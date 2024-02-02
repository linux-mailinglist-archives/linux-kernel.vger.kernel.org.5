Return-Path: <linux-kernel+bounces-49329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E6F8468B9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9698C1F26D6C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BE441A86;
	Fri,  2 Feb 2024 06:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urSwzHRf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183463FE4C;
	Fri,  2 Feb 2024 06:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856992; cv=none; b=oAWns+lroTc0Mgws4sTBkCMFGamD3b3V2lQymG4eeTG/LNWifpD2yjC0WoPGdr6pFOJFCDH+0Ww8leO1R59fynrDHZYUOxc/+L1ENxpvZ9naEHWHHFCp1I3hourIDcL6t5npbJtLElo/gwFbBFDXH4zTJhIQq2iN/WsD7KyuWTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856992; c=relaxed/simple;
	bh=br4CsOaJKFLkacvMt7qXjCHOiPEn6HigxjiQN83xsF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enG7D1Nv64ycobO+lbn5a+IIijzxkmKJylyVoByWtHOaHi0OVW0YtDfih5fXdZDXlDy6fUN/dk5hw0WNMaIkG5LMxHLFPelIcjYM5EQJV2+zFLTVs6PQ5dTue5LJe35MrbbRQanXNOTlh8bZpCRT05YPsJjVTINNtoRkXApbPpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urSwzHRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BE4C43390;
	Fri,  2 Feb 2024 06:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706856991;
	bh=br4CsOaJKFLkacvMt7qXjCHOiPEn6HigxjiQN83xsF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=urSwzHRfIEtM0XBZoW/QWahm6rK6Hn3ao+LZHlj/vRBL/U7Q9LB7VwdhqSb67MFKP
	 JlpWZOotYTnkksw5N7Ljn8jtD3NZEPas4l70p1Ez6ws3BzEFgrR72Y2kiyqB57yaRy
	 4yC8wl2lq22i1QHYWK0u3D5GOJf/k417q+Llsyf4k9gvk4iQnsjB8G22LHjPqSJvM9
	 nNk29F74unFLIIcBZQd8WYAuComGFr0btphRO2T5lxH7hTY4GLFbZddfPNemT202US
	 2Y5qOI9poA9ur8Aa10r+JzaQlnwLiz8F0llwfF+lAUekc8XFtb8kTMc9SrFE3Sw7L5
	 fNNoMabJQ9ofA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 13/22] tty: vt: move CSI DEC handling to a separate function
Date: Fri,  2 Feb 2024 07:55:59 +0100
Message-ID: <20240202065608.14019-14-jirislaby@kernel.org>
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

The handling of "CSI ? ..." (i.e. vc_priv == EPdec) can be easily moved
out of do_con_trol() into a separate function. This again increases
readability of do_con_trol().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 75 ++++++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 3dddb7128234..7cdd0eb1e423 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2338,6 +2338,43 @@ static void handle_esc(struct tty_struct *tty, struct vc_data *vc, u8 c)
 	}
 }
 
+/*
+ * Handle special DEC control sequences ("ESC [ ? parameters char"). Parameters
+ * are in @vc->vc_par and the char is in @c here.
+ */
+static void csi_DEC(struct tty_struct *tty, struct vc_data *vc, u8 c)
+{
+	switch (c) {
+	case 'h':
+		csi_DEC_hl(vc, true);
+		break;
+	case 'l':
+		csi_DEC_hl(vc, false);
+		break;
+	case 'c':
+		if (vc->vc_par[0])
+			vc->vc_cursor_type = CUR_MAKE(vc->vc_par[0],
+						      vc->vc_par[1],
+						      vc->vc_par[2]);
+		else
+			vc->vc_cursor_type = cur_default;
+		break;
+	case 'm':
+		clear_selection();
+		if (vc->vc_par[0])
+			vc->vc_complement_mask = vc->vc_par[0] << 8 | vc->vc_par[1];
+		else
+			vc->vc_complement_mask = vc->vc_s_complement_mask;
+		break;
+	case 'n':
+		if (vc->vc_par[0] == 5)
+			status_report(tty);
+		else if (vc->vc_par[0] == 6)
+			cursor_report(vc, tty);
+		break;
+	}
+}
+
 /* console_lock is held */
 static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 {
@@ -2427,40 +2464,16 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 			return;
 		}
 		vc->vc_state = ESnormal;
-		switch(c) {
-		case 'h':
-			if (vc->vc_priv == EPdec)
-				csi_DEC_hl(vc, true);
-			return;
-		case 'l':
-			if (vc->vc_priv == EPdec)
-				csi_DEC_hl(vc, false);
+
+		switch (vc->vc_priv) {
+		case EPdec:
+			csi_DEC(tty, vc, c);
 			return;
-		case 'c':
-			if (vc->vc_priv == EPdec) {
-				if (vc->vc_par[0])
-					vc->vc_cursor_type =
-						CUR_MAKE(vc->vc_par[0],
-							 vc->vc_par[1],
-							 vc->vc_par[2]);
-				else
-					vc->vc_cursor_type = cur_default;
-				return;
-			}
+		case EPecma:
 			break;
-		case 'm':
-			if (vc->vc_priv == EPdec) {
-				clear_selection();
-				if (vc->vc_par[0])
-					vc->vc_complement_mask = vc->vc_par[0] << 8 | vc->vc_par[1];
-				else
-					vc->vc_complement_mask = vc->vc_s_complement_mask;
-				return;
-			}
-			break;
-		}
-		if (vc->vc_priv != EPecma)
+		default:
 			return;
+		}
 
 		switch(c) {
 		case 'G':
-- 
2.43.0


