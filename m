Return-Path: <linux-kernel+bounces-49324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C60B8468AC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295982911CC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0E9199A2;
	Fri,  2 Feb 2024 06:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuJMc8b5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354EE18E17;
	Fri,  2 Feb 2024 06:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856984; cv=none; b=kl1b5gsuaeHqtwnu4x0AO2W7t8tdZvIypDyfr34j0zKnbw+MRP1H8ojEOHF1s8+oIRZ9mRvMr+va9qsDG9A4cRhbhfEr2waw6JAxCgjsDLcQWSelCL/fCIS8nrhaa6o2hkKDoVYra7N9OMb0tCEC2EOqIfobyjSU3SbLUmBdNW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856984; c=relaxed/simple;
	bh=A/DGpXBJR9ZPWHNz7cYQLXBrUjxv88QCU8EKOJUwuLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxJG+2rMqj6nJ/oXF8qeF99caOxhe0F8c4y3MeaDzntWxj+b8g5QuGnQ+9wOyr40/oqOcDO1mwl5xsmN+WjEG5ijffavavF2CbzYmmciqIaOgmysRwerg941zNsbWMJfmIkIFONvPWY5Kvrq0wZAZVTvnl+DEZM5po3qA8wkcSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuJMc8b5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B1CC43394;
	Fri,  2 Feb 2024 06:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706856984;
	bh=A/DGpXBJR9ZPWHNz7cYQLXBrUjxv88QCU8EKOJUwuLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kuJMc8b5oWti2uqzIM81eI6MSTQ4nWHHsfkub7U72acPXXmqg5CnmC+rzysD0LEnk
	 MQpYZOJdKlIZVbNMXW1Wu5Ft/L+/JJ2oHFTV31rSKhM1iUDqBWrUgKs6Llyl3oxq4X
	 Ri+I4cmSPZHKbQ2EmCOlXtiv4nxos0J1U+C+5Wfd6+23NixG2qzc24rmK4gCLH2L8Z
	 CIW4AOOp5vSB6lMcR/NdG5xzj/JVHyHqKrozjNeFGZiISNBSCDdvgcXOV/WvYcbrrR
	 PzM0V3OlOSoCIglvksdSrG89Ewz7+2XgIh0AHC9pH3xDzQkRDumTnQemEu61/zdsDk
	 C42a/jjizuwQQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 08/22] tty: vt: rename setterm_command() to csi_RSB()
Date: Fri,  2 Feb 2024 07:55:54 +0100
Message-ID: <20240202065608.14019-9-jirislaby@kernel.org>
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

It follows naming of other similar functions. RSB stands here for Right
Square Bracket as (obviously) ']' cannot be in the function name.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 9db545f305dc..c072007807e1 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1969,8 +1969,14 @@ enum CSI_right_square_bracket {
 	CSI_RSB_CURSOR_BLINK_INTERVAL		= 16,
 };
 
-/* console_lock is held */
-static void setterm_command(struct vc_data *vc)
+/*
+ * csi_RSB - csi+] (Right Square Bracket) handler
+ *
+ * These are linux console private sequences.
+ *
+ * console_lock is held
+ */
+static void csi_RSB(struct vc_data *vc)
 {
 	switch (vc->vc_par[0]) {
 	case CSI_RSB_COLOR_FOR_UNDERLINE:
@@ -2549,8 +2555,8 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		case '@':
 			csi_at(vc, vc->vc_par[0]);
 			return;
-		case ']': /* setterm functions */
-			setterm_command(vc);
+		case ']':
+			csi_RSB(vc);
 			return;
 		}
 		return;
-- 
2.43.0


