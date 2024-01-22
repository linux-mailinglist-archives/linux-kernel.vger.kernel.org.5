Return-Path: <linux-kernel+bounces-32821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56704836092
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E55A1F21AEA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A74C3D556;
	Mon, 22 Jan 2024 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmoKgcGb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F073D548;
	Mon, 22 Jan 2024 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921468; cv=none; b=jrOXuBcStoWq9keiVQkwU6O48o4Yu7oHQ1azgBSras0/WJnLo4XAYNUtbIiC4DinFGl0nPGKVtDEFPadSbks0PFrOefbn0PyX2WSsL+SOuv3cx56Win7jn65ipRKNPwoRMbLoNLpjpXeILFy8t+kywWuGDEvOlhKnpJhCbICOFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921468; c=relaxed/simple;
	bh=AXiRX8dRFFCRyZh6z4CAVlWbUqnScmiBQUZ2UxbtulE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NigOrSHVUh/aVqB2oixQO2H2Nf7+HgfDgssXaDiCFZ0cfxgFPcMm2B3hyYIcL2S6pJah716X2Uf/z70EXT7onl90+zwIlmDUvLA953caei4I5H8cZDK1XGtw5xOTQGTru/JlIEQX/bU9/rNRQ4bsUajwzKPAV+GmIfX9Z7j7hBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmoKgcGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F36C433F1;
	Mon, 22 Jan 2024 11:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921468;
	bh=AXiRX8dRFFCRyZh6z4CAVlWbUqnScmiBQUZ2UxbtulE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FmoKgcGbf6TyPm8w1G7cv7iJTCN4nL1ux4EgH3nIEqwHTuYPDFn5aejw6mG7S/u05
	 5YsPpgQkk0prPrSVTnKMcFJkBvzSzCTob/lzQlVdfS/KKusjf3nRjJYPs5YmLiXkgF
	 sMjq/IP9JqCN+rBHvNf+fy4sPyna9xhdfKFrDYs0wyGaCXl7LFcgiClusZCSXvls6E
	 oVCcHX5/3LPrucSA2x+5TEmnr7M0kTRkEUPmIvkwZ1Le33mr8GAPEc3axMIGzKvk4Q
	 AuDMLTrgl93GW653h/XX8UAm4yzA26M1wqtJT5DMfpQ5W7D/1oVkiFI8z55IfIJNF2
	 PnOrhUFeT8dwg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 12/47] tty: vt: reflow csi_J()
Date: Mon, 22 Jan 2024 12:03:26 +0100
Message-ID: <20240122110401.7289-13-jirislaby@kernel.org>
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

Push cases one level left, according to coding style. And reorder local
variables.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 50 ++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 85e89fb9b207..bf77d962eeb4 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1507,34 +1507,34 @@ enum CSI_J {
 
 static void csi_J(struct vc_data *vc, enum CSI_J vpar)
 {
+	unsigned short *start;
 	unsigned int count;
-	unsigned short * start;
 
 	switch (vpar) {
-		case CSI_J_CURSOR_TO_END:
-			vc_uniscr_clear_line(vc, vc->state.x,
-					     vc->vc_cols - vc->state.x);
-			vc_uniscr_clear_lines(vc, vc->state.y + 1,
-					      vc->vc_rows - vc->state.y - 1);
-			count = (vc->vc_scr_end - vc->vc_pos) >> 1;
-			start = (unsigned short *)vc->vc_pos;
-			break;
-		case CSI_J_START_TO_CURSOR:
-			vc_uniscr_clear_line(vc, 0, vc->state.x + 1);
-			vc_uniscr_clear_lines(vc, 0, vc->state.y);
-			count = ((vc->vc_pos - vc->vc_origin) >> 1) + 1;
-			start = (unsigned short *)vc->vc_origin;
-			break;
-		case CSI_J_FULL:
-			flush_scrollback(vc);
-			fallthrough;
-		case CSI_J_VISIBLE:
-			vc_uniscr_clear_lines(vc, 0, vc->vc_rows);
-			count = vc->vc_cols * vc->vc_rows;
-			start = (unsigned short *)vc->vc_origin;
-			break;
-		default:
-			return;
+	case CSI_J_CURSOR_TO_END:
+		vc_uniscr_clear_line(vc, vc->state.x,
+				     vc->vc_cols - vc->state.x);
+		vc_uniscr_clear_lines(vc, vc->state.y + 1,
+				      vc->vc_rows - vc->state.y - 1);
+		count = (vc->vc_scr_end - vc->vc_pos) >> 1;
+		start = (unsigned short *)vc->vc_pos;
+		break;
+	case CSI_J_START_TO_CURSOR:
+		vc_uniscr_clear_line(vc, 0, vc->state.x + 1);
+		vc_uniscr_clear_lines(vc, 0, vc->state.y);
+		count = ((vc->vc_pos - vc->vc_origin) >> 1) + 1;
+		start = (unsigned short *)vc->vc_origin;
+		break;
+	case CSI_J_FULL:
+		flush_scrollback(vc);
+		fallthrough;
+	case CSI_J_VISIBLE:
+		vc_uniscr_clear_lines(vc, 0, vc->vc_rows);
+		count = vc->vc_cols * vc->vc_rows;
+		start = (unsigned short *)vc->vc_origin;
+		break;
+	default:
+		return;
 	}
 	scr_memsetw(start, vc->vc_video_erase_char, 2 * count);
 	if (con_should_update(vc))
-- 
2.43.0


