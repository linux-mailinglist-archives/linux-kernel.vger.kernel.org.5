Return-Path: <linux-kernel+bounces-49335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3F78468C8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF971292CF4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC07817BC4;
	Fri,  2 Feb 2024 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVOV5o6e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B46648786;
	Fri,  2 Feb 2024 06:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706857001; cv=none; b=h3/t6YrOXdTmKsh0gfeSFo0QSGIUuDCu4crCwE7PhPktZzpaZ5M4HZT7QUIfENS3GT1T5XkcYaRbxleIbN6toh/oX+bJ2HqxX2kcWW+z2T3rZzrcYS3RMBcr3uTxCAlmI/dGfqsjTLUjRbskmz289pr1fw2834iI4qcM4sYshpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706857001; c=relaxed/simple;
	bh=mf+XMWdb5Ui9tDRVo2+XaapMqsHlRKk1tHRmQX2ocSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQB4POLZ9RW7FcHmDCT62bl6SKU2eSKg4O0WjZD19OSMw16o0fQdbSepNEH9UkyCFB7Kya6hCaGB5Kl1lW7KxgbB75xDhI0F7p1i8DV6pFXGeDw46yEHzpIMXiMpAhP9aft0QHIjixn01W1LeNHsR6Broypzf9YqMw06HoU07I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVOV5o6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8527FC43394;
	Fri,  2 Feb 2024 06:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706857000;
	bh=mf+XMWdb5Ui9tDRVo2+XaapMqsHlRKk1tHRmQX2ocSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TVOV5o6eQDLO0488ndhuhsueCU9dSmu6C5xnRf6KoiZ/8LUZliej2Fs40OdDw6D5p
	 sFELmt9JluCw7J80k9UFEMrXceGL5hiT+oYe9CXM+DcwoqUU1UQP/Rls4NFFuYiuEO
	 gh+S+jW5cCV1omOp3nh6CCoiufeLkpy5kUteiaiZ3T4Wqnx/aLcFVupFscE1vF4CUN
	 OkT+9Z6li+wPXrr1RMr/7HZNfaDZdVLOwqHb99hLNgknZ1edOCrp82Wd6rjMuhDPyY
	 dId9iToeILBXPe1UhXgrB5ed3v1ypzMOdjq2Jns1GFtzDIyrhkB1pqXLAU2k+cPY4/
	 MaNvlbXxXZksA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 19/22] tty: vt: use switch+case in the ESnonstd case
Date: Fri,  2 Feb 2024 07:56:05 +0100
Message-ID: <20240202065608.14019-20-jirislaby@kernel.org>
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

To be uniform in the 'c' handling, use switch-case (with ranges) even in
the ESnonstd case in do_con_trol().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index b0f691d79bf2..b5fc3b896e26 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2573,17 +2573,19 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 		handle_esc(tty, vc, c);
 		return;
 	case ESnonstd:	/* ESC ] aka OSC */
-		if (c=='P') {   /* palette escape sequence */
+		switch (c) {
+		case 'P': /* palette escape sequence */
 			vc_reset_params(vc);
 			vc->vc_state = ESpalette;
 			return;
-		} else if (c=='R') {   /* reset palette */
+		case 'R': /* reset palette */
 			reset_palette(vc);
-			vc->vc_state = ESnormal;
-		} else if (c>='0' && c<='9')
+			break;
+		case '0' ... '9':
 			vc->vc_state = ESosc;
-		else
-			vc->vc_state = ESnormal;
+			return;
+		}
+		vc->vc_state = ESnormal;
 		return;
 	case ESpalette:	/* ESC ] P aka OSC P */
 		if (isxdigit(c)) {
-- 
2.43.0


