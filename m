Return-Path: <linux-kernel+bounces-29801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EF68313C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF0D282C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8747428DAB;
	Thu, 18 Jan 2024 07:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gleT+uLL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE398286B2;
	Thu, 18 Jan 2024 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564708; cv=none; b=YAD8X3gA9Bk6NjCVpFsp49tSIN6+ml3TknmFnuo48ODfnS8Ro2LSfrCJ9sfbXxCsJKCrC5f2QJi19Q5d5LtlPIyHm0cShpcaoPLNdYcHtQdYv7mWzpwa6WU1vorYru9+i5H7jhkapGJHeRhKq/g+QFzgsiW2Fh270szDOG7aRIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564708; c=relaxed/simple;
	bh=3Td1/Et6XB0SeL2/aGZuKKdWG7Y3VJzO4iDAmw63Qkk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=GokVi0Y+Lr/qDQnJB5HfGoAi/cPKs90cDuC7Z2RxcjIHVeU+PpnqrNLrQqScIPRFNR4PhHaPtDfMlNLUgtMZBL73e/OpnvfIUBk/WzFHRWmp19lkHJLzkxtNYQvvkv+DmQQAsxnPBI4o7eo3Z4F9VvURq6tSbd2xG9pSNlxA9v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gleT+uLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D43C433F1;
	Thu, 18 Jan 2024 07:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564708;
	bh=3Td1/Et6XB0SeL2/aGZuKKdWG7Y3VJzO4iDAmw63Qkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gleT+uLL8njaXC4xkeYX1B7ODOEnrZ2r+9l5Fm72lrvGcv3R76mLM68LsBGgrxHrS
	 900Z47O6GX44pmdRiSPqHTy4ef7pHkRvbQwlbAFbbNMHXaPVbz4Q3yNuiqG2HovzF1
	 lP1GKJIwICFUIeyqTLeCO8zc3cbS9OA2c1rt21xKNt8vtOJYXzr5BG8EN1/8oqIgKK
	 e7HsU3HheBNTM1QqEmdGNq6+HBY4DvfJag7B/Aw0hUqe5djnjnzLr+TjVFFGXK964d
	 oFGYyA9ukJP3QN3MmxtcC/T0AnAj7p3VwxhawmIE2aR9/9boND/JMRjgVvLyQZ/rG7
	 hIEukecWSZ4wA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 14/45] tty: vt: reflow csi_K()
Date: Thu, 18 Jan 2024 08:57:25 +0100
Message-ID: <20240118075756.10541-15-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118075756.10541-1-jirislaby@kernel.org>
References: <20240118075756.10541-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Push cases one level left, according to coding style.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 3e3ec9c28f26..c00c568c11a5 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1555,20 +1555,20 @@ static void csi_K(struct vc_data *vc, int vpar)
 	int offset;
 
 	switch (vpar) {
-		case CSI_K_CURSOR_TO_LINEEND:
-			offset = 0;
-			count = vc->vc_cols - vc->state.x;
-			break;
-		case CSI_K_LINESTART_TO_CURSOR:
-			offset = -vc->state.x;
-			count = vc->state.x + 1;
-			break;
-		case CSI_K_LINE:
-			offset = -vc->state.x;
-			count = vc->vc_cols;
-			break;
-		default:
-			return;
+	case CSI_K_CURSOR_TO_LINEEND:
+		offset = 0;
+		count = vc->vc_cols - vc->state.x;
+		break;
+	case CSI_K_LINESTART_TO_CURSOR:
+		offset = -vc->state.x;
+		count = vc->state.x + 1;
+		break;
+	case CSI_K_LINE:
+		offset = -vc->state.x;
+		count = vc->vc_cols;
+		break;
+	default:
+		return;
 	}
 	vc_uniscr_clear_line(vc, vc->state.x + offset, count);
 	scr_memsetw(start + offset, vc->vc_video_erase_char, 2 * count);
-- 
2.43.0


