Return-Path: <linux-kernel+bounces-32823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0528D836096
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1521F220A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3A63D99E;
	Mon, 22 Jan 2024 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7OWStp/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9563D96A;
	Mon, 22 Jan 2024 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921472; cv=none; b=JTrjZF0xiRPqI+pn6mXSo8HItx6uOD+QckwdQWhcAaHCTBtn2rh43q5i+X3Ik7iIOORtR+3aFjzNtPXN3eD7XCeINgcrgwxojdO455lvwLeOIPtM8FKTvy0BHPpzzJqSL2sOkEQhCAs6byIe8hK8z4tkz71lsxa+LYLSCIO6WCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921472; c=relaxed/simple;
	bh=YR/W6sgh+vPQ/4BVGb32tslxBYk1omBuQ9MqCkWmFLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eODwaJbiEBo/QrfhloHGDrMa6hSGplPICcTOO0/pissS3IfAH2F2fyZT5rz29e2roOm8XyCVI0B2w3KzrEFCR12W/Ecah2mB1rVDgJYYNbxJBNjQmQfmOuqmDKwDSsquRLusJC6F1YnhVsSJPJjRwTITUBUsV/4WP1HyQnDTt3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7OWStp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74EFC433F1;
	Mon, 22 Jan 2024 11:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921471;
	bh=YR/W6sgh+vPQ/4BVGb32tslxBYk1omBuQ9MqCkWmFLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R7OWStp/t3Aci9CLs+4unO0StQBr+19jZoIosmEWLfpuLwiXnBH/+DWuoejojlZ7W
	 dEGRHY7jXSgIXihILPDgrJrAks0FWONPRpauxSHnEdQuDfwEJ58Z9UFtukdcyqfMhf
	 M2TtfWk0+bZKxURgJa6zqC6Ha6ZCgKJ5JybhX7wSjFm+JjnjmtzN4G2uJUAzh+boT0
	 hSbiusVH/nDE6aDbHci7WY8kciuZVHrdlXigbbIh6WbL+EdMEJkAk2RWVqoH+CpdLo
	 gPErJKK9xC63Ry6usbFgRzDSr/DCxatExZYcI0VAD+WWYU5d2wr7p99fq6G0ayJndM
	 trVz9/gyyFzOQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 14/47] don't pass vc->vc_par[0] to csi_?() handlers
Date: Mon, 22 Jan 2024 12:03:28 +0100
Message-ID: <20240122110401.7289-15-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122110401.7289-1-jirislaby@kernel.org>
References: <20240122110401.7289-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fetch the value directly in the helpers instead.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---

Notes:
    [v2] new in v2.

 drivers/tty/vt/vt.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 05baf9ca23f2..16ba3a3666ab 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1542,13 +1542,13 @@ static void csi_J(struct vc_data *vc, enum CSI_J vpar)
 	vc->vc_need_wrap = 0;
 }
 
-static void csi_K(struct vc_data *vc, int vpar)
+static void csi_K(struct vc_data *vc)
 {
 	unsigned int count;
 	unsigned short *start = (unsigned short *)vc->vc_pos;
 	int offset;
 
-	switch (vpar) {
+	switch (vc->vc_par[0]) {
 		case 0:	/* erase from cursor to end of line */
 			offset = 0;
 			count = vc->vc_cols - vc->state.x;
@@ -1571,10 +1571,10 @@ static void csi_K(struct vc_data *vc, int vpar)
 		do_update_region(vc, (unsigned long)(start + offset), count);
 }
 
-/* erase the following vpar positions */
-static void csi_X(struct vc_data *vc, unsigned int vpar)
+/* erase the following count positions */
+static void csi_X(struct vc_data *vc)
 {					  /* not vt100? */
-	unsigned int count = clamp(vpar, 1, vc->vc_cols - vc->state.x);
+	unsigned int count = clamp(vc->vc_par[0], 1, vc->vc_cols - vc->state.x);
 
 	vc_uniscr_clear_line(vc, vc->state.x, count);
 	scr_memsetw((unsigned short *)vc->vc_pos, vc->vc_video_erase_char, 2 * count);
@@ -2010,24 +2010,27 @@ static void csi_at(struct vc_data *vc, unsigned int nr)
 }
 
 /* console_lock is held */
-static void csi_L(struct vc_data *vc, unsigned int nr)
+static void csi_L(struct vc_data *vc)
 {
-	nr = clamp(nr, 1, vc->vc_rows - vc->state.y);
+	unsigned int nr = clamp(vc->vc_par[0], 1, vc->vc_rows - vc->state.y);
+
 	con_scroll(vc, vc->state.y, vc->vc_bottom, SM_DOWN, nr);
 	vc->vc_need_wrap = 0;
 }
 
 /* console_lock is held */
-static void csi_P(struct vc_data *vc, unsigned int nr)
+static void csi_P(struct vc_data *vc)
 {
-	nr = clamp(nr, 1, vc->vc_cols - vc->state.x);
+	unsigned int nr = clamp(vc->vc_par[0], 1, vc->vc_cols - vc->state.x);
+
 	delete_char(vc, nr);
 }
 
 /* console_lock is held */
-static void csi_M(struct vc_data *vc, unsigned int nr)
+static void csi_M(struct vc_data *vc)
 {
-	nr = clamp(nr, 1, vc->vc_rows - vc->state.y);
+	unsigned int nr = clamp(vc->vc_par[0], 1, vc->vc_rows - vc->state.y);
+
 	con_scroll(vc, vc->state.y, vc->vc_bottom, SM_UP, nr);
 	vc->vc_need_wrap = 0;
 }
@@ -2430,16 +2433,16 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			csi_J(vc, vc->vc_par[0]);
 			return;
 		case 'K':
-			csi_K(vc, vc->vc_par[0]);
+			csi_K(vc);
 			return;
 		case 'L':
-			csi_L(vc, vc->vc_par[0]);
+			csi_L(vc);
 			return;
 		case 'M':
-			csi_M(vc, vc->vc_par[0]);
+			csi_M(vc);
 			return;
 		case 'P':
-			csi_P(vc, vc->vc_par[0]);
+			csi_P(vc);
 			return;
 		case 'c':
 			if (!vc->vc_par[0])
@@ -2480,7 +2483,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			restore_cur(vc);
 			return;
 		case 'X':
-			csi_X(vc, vc->vc_par[0]);
+			csi_X(vc);
 			return;
 		case '@':
 			csi_at(vc, vc->vc_par[0]);
-- 
2.43.0


