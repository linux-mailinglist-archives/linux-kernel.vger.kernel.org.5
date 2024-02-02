Return-Path: <linux-kernel+bounces-49334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA06E8468C6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43928B25C00
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECC5482FC;
	Fri,  2 Feb 2024 06:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7ZxXwSn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90452482F1;
	Fri,  2 Feb 2024 06:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856999; cv=none; b=CGBZ9vZTznceiWvlFmtsEVy0/523lTTPGWZ03L7+Dg7YySkGqmeiDby7DQdbISRD2zn5b5GHMt8zHBFEi1xmDCqyvfdP1Knjw8C06WvOFXmWV1ceNu0mtX7enjeBm6cMgk70N/l4Mulo+6tjFqKDoBEyU77BWMFUKVK1obn5OW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856999; c=relaxed/simple;
	bh=f1BOAc650vN/wZSXPoFGQMv1ubutbNRxF0vqxh4BsrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwIvAXxzvUKfL+GCv3Jbo5UdllMYHlUb+S5qTaZ0zUV+74RIshmL/05BTMuKJf5XBKlK3vO2r9ry1/o6oIrWTpO4Bimumk45OVKvudU82fMI6aCOwFZUQPHW2j4E5Ptk1Vc3U67F4MhrCAVGNdBOQw3jqBsjgCc++xCqDsxmZEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7ZxXwSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8FEC433F1;
	Fri,  2 Feb 2024 06:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706856999;
	bh=f1BOAc650vN/wZSXPoFGQMv1ubutbNRxF0vqxh4BsrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M7ZxXwSn6t/o6IcTt2O/lgEkqG7p8eTQGR3uTgShc3uXD8hdci7keg1scFmervl94
	 YIou5trwftdSLC09lwe7zetKNMl88kCLhSq+P0LHcNlk2UVvo6ijc9FjV5600gGeN+
	 yPtt0deFW8xHdOnW0rdjRdtNQTx5nAoiaL6hbOAZa0f2cadjhoHyN25dDFOVo2fwRV
	 5aCb8X+3cQLKm2wBbxcc5nAge1//xdMkWpLCVMN2cL5hQI7J5+b/kdriNV0p9a8NWH
	 pXu/NadI9jdJu2TYFuDRZBx5ARaGqVfU4c2saN1PlO54SLZjvgWGb8hQuEH7pEjtEN
	 A8gtvYRMubGnw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 18/22] tty: vt: add new helper for reseting vc parameters
Date: Fri,  2 Feb 2024 07:56:04 +0100
Message-ID: <20240202065608.14019-19-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202065608.14019-1-jirislaby@kernel.org>
References: <20240202065608.14019-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code to reset the vc parameter parsing is repeated on two locations.
Create a helper vc_reset_params() and use it on both of them.

And instead of a 'for' loop to clear the array of parameters, use
simpler memset().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 4d020a9967a2..b0f691d79bf2 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2548,6 +2548,12 @@ static void csi_ECMA(struct tty_struct *tty, struct vc_data *vc, u8 c)
 
 }
 
+static void vc_reset_params(struct vc_data *vc)
+{
+	memset(vc->vc_par, 0, sizeof(vc->vc_par));
+	vc->vc_npar = 0;
+}
+
 /* console_lock is held */
 static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 {
@@ -2568,9 +2574,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 		return;
 	case ESnonstd:	/* ESC ] aka OSC */
 		if (c=='P') {   /* palette escape sequence */
-			for (vc->vc_npar = 0; vc->vc_npar < NPAR; vc->vc_npar++)
-				vc->vc_par[vc->vc_npar] = 0;
-			vc->vc_npar = 0;
+			vc_reset_params(vc);
 			vc->vc_state = ESpalette;
 			return;
 		} else if (c=='R') {   /* reset palette */
@@ -2599,9 +2603,8 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 			vc->vc_state = ESnormal;
 		return;
 	case ESsquare:	/* ESC [ aka CSI, parameters or modifiers expected */
-		for (vc->vc_npar = 0; vc->vc_npar < NPAR; vc->vc_npar++)
-			vc->vc_par[vc->vc_npar] = 0;
-		vc->vc_npar = 0;
+		vc_reset_params(vc);
+
 		vc->vc_state = ESgetpars;
 		switch (c) {
 		case '[': /* Function key */
-- 
2.43.0


