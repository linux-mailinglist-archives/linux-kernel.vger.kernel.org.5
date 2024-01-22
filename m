Return-Path: <linux-kernel+bounces-32822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA15836094
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533BA1F220A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BDF3D579;
	Mon, 22 Jan 2024 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGdjdLKm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46873D56E;
	Mon, 22 Jan 2024 11:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921470; cv=none; b=Mdmf4jSQ1LmfBtEvilZqapU1IB4gEhpHwa+o+jmNk/uDzKHK94zBWm0mR5/rFXJpo2VYquWn6gx1r8eBNwXhpUJ7kJ0yH2TwtY0/k+GXWLO/RagrcQLYYyQC6rNKUyIqYCWcSq8brOB3LpGEjUgFxkzG9V9eAcnXVSJaLIs1tuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921470; c=relaxed/simple;
	bh=+6RmAVgvPeAhp0Iodnu3W0aQRPApBErXx5nAi3YhGf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKBOHY/Bwciu9I8DEv9CCsVk8G1+qKHrzmXSG9ronMXu8pbra1A1vEKCNiAgnAwShMxNfAupL1Yd2Y0UxwtS4cJJ70hIUx4Qa6u9t1TB9mEFqIEH1H0IxJHNw34mH3Y5RfLwHAtE+XJ29JWgsu6pIuBFgAn2CXh6TaSSP9VcDIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGdjdLKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A220C43390;
	Mon, 22 Jan 2024 11:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921470;
	bh=+6RmAVgvPeAhp0Iodnu3W0aQRPApBErXx5nAi3YhGf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hGdjdLKmtAYq9HUIIMGa6dTxYYyP1h7ILZfCA6eUyt3K2nPEQY/vfVm0MdXyVxCVR
	 xtmEjCaa5q3Pdf5kXKwlB0KcNSiHDDWFRgNKvd9vxxNTXL1aSpoIYsuwuN4Z+XppOS
	 fwJyHkDKBWuBYX8zkyvCHenTv0WFYfGOvNz5QZRfpIO2OpNWX7vSkX8c4zQyZZ9ca+
	 CfbHdixclUqTFLzF0iwf8Hw5cJvnbpn47d26s2WIhPbqzwItNU3iUB0M85WBkNFp77
	 IzyaBpqKS9Y1IXR0yc95/u0YbvsYReNjfry8lJ/2XOG7dRFx3PqKY7nkZiRQmDeZqs
	 KIaz0BLkPVGSw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 13/47] use clamp() for counts in csi_?() handlers
Date: Mon, 22 Jan 2024 12:03:27 +0100
Message-ID: <20240122110401.7289-14-jirislaby@kernel.org>
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

The count to process is supposed to be between 1 and vc->vc_cols -
vc->state.x (or rows and .y). clamp() can be used exactly for this,
instead of ifs and min().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---

Notes:
    [v2] new in v2.

 drivers/tty/vt/vt.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index bf77d962eeb4..05baf9ca23f2 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1574,12 +1574,7 @@ static void csi_K(struct vc_data *vc, int vpar)
 /* erase the following vpar positions */
 static void csi_X(struct vc_data *vc, unsigned int vpar)
 {					  /* not vt100? */
-	unsigned int count;
-
-	if (!vpar)
-		vpar++;
-
-	count = min(vpar, vc->vc_cols - vc->state.x);
+	unsigned int count = clamp(vpar, 1, vc->vc_cols - vc->state.x);
 
 	vc_uniscr_clear_line(vc, vc->state.x, count);
 	scr_memsetw((unsigned short *)vc->vc_pos, vc->vc_video_erase_char, 2 * count);
@@ -2010,20 +2005,14 @@ static void setterm_command(struct vc_data *vc)
 /* console_lock is held */
 static void csi_at(struct vc_data *vc, unsigned int nr)
 {
-	if (nr > vc->vc_cols - vc->state.x)
-		nr = vc->vc_cols - vc->state.x;
-	else if (!nr)
-		nr = 1;
+	nr = clamp(nr, 1, vc->vc_cols - vc->state.x);
 	insert_char(vc, nr);
 }
 
 /* console_lock is held */
 static void csi_L(struct vc_data *vc, unsigned int nr)
 {
-	if (nr > vc->vc_rows - vc->state.y)
-		nr = vc->vc_rows - vc->state.y;
-	else if (!nr)
-		nr = 1;
+	nr = clamp(nr, 1, vc->vc_rows - vc->state.y);
 	con_scroll(vc, vc->state.y, vc->vc_bottom, SM_DOWN, nr);
 	vc->vc_need_wrap = 0;
 }
@@ -2031,20 +2020,14 @@ static void csi_L(struct vc_data *vc, unsigned int nr)
 /* console_lock is held */
 static void csi_P(struct vc_data *vc, unsigned int nr)
 {
-	if (nr > vc->vc_cols - vc->state.x)
-		nr = vc->vc_cols - vc->state.x;
-	else if (!nr)
-		nr = 1;
+	nr = clamp(nr, 1, vc->vc_cols - vc->state.x);
 	delete_char(vc, nr);
 }
 
 /* console_lock is held */
 static void csi_M(struct vc_data *vc, unsigned int nr)
 {
-	if (nr > vc->vc_rows - vc->state.y)
-		nr = vc->vc_rows - vc->state.y;
-	else if (!nr)
-		nr=1;
+	nr = clamp(nr, 1, vc->vc_rows - vc->state.y);
 	con_scroll(vc, vc->state.y, vc->vc_bottom, SM_UP, nr);
 	vc->vc_need_wrap = 0;
 }
-- 
2.43.0


