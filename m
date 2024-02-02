Return-Path: <linux-kernel+bounces-49317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0A084689C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37E51F233C4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D59517BDC;
	Fri,  2 Feb 2024 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAi+ARWj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D97617BC2;
	Fri,  2 Feb 2024 06:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856975; cv=none; b=rQz3W/DLH1cEQ6MM1TSL5ZdLf+z6mMtxkkmzeeGUtf7n1fyMJHc86K+aKFbgIEsADIkyzbdVhngRZhm+kI2mft9eNXQB94iGsmy5/YOFtsO331ENt8ZPUGRCbgmM75yazSrEcj64UNEGNgfXyz1hjyG3q6GAwdL4saYMpG/e/zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856975; c=relaxed/simple;
	bh=kxVDTHfZGYZb1zilvgP1SsL8GjUUvmxkdEFoPyB4ugg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVOkGG9xoq2T2AniGVc2EBvrZngB13JzYhJX0NGE8wh/8m9gBrbtluYj3c/lqVvrlRJbICOGuGKyTT/Jhqt21DAlvP8VYRj7BH0nLdsAI+1iwSepgiEiKJxCc5pU4PNKmfFbZtNkziDCD5dB4vZynqccRI3zTS3g2Yguauu6ZH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAi+ARWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED070C43390;
	Fri,  2 Feb 2024 06:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706856975;
	bh=kxVDTHfZGYZb1zilvgP1SsL8GjUUvmxkdEFoPyB4ugg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aAi+ARWjnWruG7yFiXNTUS1zzRsHbEUEzLZLEhgham7+Hk/8XBDZus9sRBcDUjVso
	 UtTW5nuy1N/hxCu8RVPkH4vp2uMVLoWMgE7gxYv09d1nWI/1l3dPs1ahIETRG/IY5R
	 uQx70vnQ4+Ocz5OgYV8F/D+nnz7tEpB6pAyjFLFYzFj4toEEEB6zcpQZ7ZCs/6zWYI
	 ur5cRCAHt0tPvym0Rl0OLtCffzB54KtIa3No1nnl9oUUQ4ZwwfpUVOHFqQYs8p6ZaK
	 poU87oHLdFuxSte1dHCRUIpj/NbzTRnWMxPO7kr7iETqNGPeqNyHUMXsdEq4hj4hEp
	 rb5mT/DnV3zCg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 02/22] tty: vt: define enums for CSI+h/l codes
Date: Fri,  2 Feb 2024 07:55:48 +0100
Message-ID: <20240202065608.14019-3-jirislaby@kernel.org>
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

Decrypt the constant values by proper enum names. This time in
set_mode().

Define two of them as DEC ('CSI ?') is about to be split away in the
next patches.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 7d42f148559a..7b55d87248f8 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1862,6 +1862,24 @@ int mouse_reporting(void)
 	return vc_cons[fg_console].d->vc_report_mouse;
 }
 
+enum {
+	CSI_DEC_hl_CURSOR_KEYS	= 1,	/* CKM: cursor keys send ^[Ox/^[[x */
+	CSI_DEC_hl_132_COLUMNS	= 3,	/* COLM: 80/132 mode switch */
+	CSI_DEC_hl_REVERSE_VIDEO = 5,	/* SCNM */
+	CSI_DEC_hl_ORIGIN_MODE	= 6,	/* OM: origin relative/absolute */
+	CSI_DEC_hl_AUTOWRAP	= 7,	/* AWM */
+	CSI_DEC_hl_AUTOREPEAT	= 8,	/* ARM */
+	CSI_DEC_hl_MOUSE_X10	= 9,
+	CSI_DEC_hl_SHOW_CURSOR	= 25,	/* TCEM */
+	CSI_DEC_hl_MOUSE_VT200	= 1000,
+};
+
+enum {
+	CSI_hl_DISPLAY_CTRL	= 3,	/* handle ansi control chars */
+	CSI_hl_INSERT		= 4,	/* IRM: insert/replace */
+	CSI_hl_AUTO_NL		= 20,	/* LNM: Enter == CrLf/Lf */
+};
+
 /* console_lock is held */
 static void set_mode(struct vc_data *vc, int on_off)
 {
@@ -1870,20 +1888,20 @@ static void set_mode(struct vc_data *vc, int on_off)
 	for (i = 0; i <= vc->vc_npar; i++)
 		if (vc->vc_priv == EPdec) {
 			switch(vc->vc_par[i]) {	/* DEC private modes set/reset */
-			case 1:			/* Cursor keys send ^[Ox/^[[x */
+			case CSI_DEC_hl_CURSOR_KEYS:
 				if (on_off)
 					set_kbd(vc, decckm);
 				else
 					clr_kbd(vc, decckm);
 				break;
-			case 3:	/* 80/132 mode switch unimplemented */
+			case CSI_DEC_hl_132_COLUMNS:	/* unimplemented */
 #if 0
 				vc_resize(deccolm ? 132 : 80, vc->vc_rows);
 				/* this alone does not suffice; some user mode
 				   utility has to change the hardware regs */
 #endif
 				break;
-			case 5:			/* Inverted screen on/off */
+			case CSI_DEC_hl_REVERSE_VIDEO:
 				if (vc->vc_decscnm != on_off) {
 					vc->vc_decscnm = on_off;
 					invert_screen(vc, 0,
@@ -1892,38 +1910,38 @@ static void set_mode(struct vc_data *vc, int on_off)
 					update_attr(vc);
 				}
 				break;
-			case 6:			/* Origin relative/absolute */
+			case CSI_DEC_hl_ORIGIN_MODE:
 				vc->vc_decom = on_off;
 				gotoxay(vc, 0, 0);
 				break;
-			case 7:			/* Autowrap on/off */
+			case CSI_DEC_hl_AUTOWRAP:
 				vc->vc_decawm = on_off;
 				break;
-			case 8:			/* Autorepeat on/off */
+			case CSI_DEC_hl_AUTOREPEAT:
 				if (on_off)
 					set_kbd(vc, decarm);
 				else
 					clr_kbd(vc, decarm);
 				break;
-			case 9:
+			case CSI_DEC_hl_MOUSE_X10:
 				vc->vc_report_mouse = on_off ? 1 : 0;
 				break;
-			case 25:		/* Cursor on/off */
+			case CSI_DEC_hl_SHOW_CURSOR:
 				vc->vc_deccm = on_off;
 				break;
-			case 1000:
+			case CSI_DEC_hl_MOUSE_VT200:
 				vc->vc_report_mouse = on_off ? 2 : 0;
 				break;
 			}
 		} else {
 			switch(vc->vc_par[i]) {	/* ANSI modes set/reset */
-			case 3:			/* Monitor (display ctrls) */
+			case CSI_hl_DISPLAY_CTRL:
 				vc->vc_disp_ctrl = on_off;
 				break;
-			case 4:			/* Insert Mode on/off */
+			case CSI_hl_INSERT:
 				vc->vc_decim = on_off;
 				break;
-			case 20:		/* Lf, Enter == CrLf/Lf */
+			case CSI_hl_AUTO_NL:
 				if (on_off)
 					set_kbd(vc, lnm);
 				else
-- 
2.43.0


