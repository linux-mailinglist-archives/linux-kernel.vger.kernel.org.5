Return-Path: <linux-kernel+bounces-107339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BFB87FB39
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C585A1F226C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1EB7F7C3;
	Tue, 19 Mar 2024 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSETVizk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D28F7D098;
	Tue, 19 Mar 2024 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842021; cv=none; b=auMPhynXmOCG75oOjffgLRsyNzK5cTVQgoaGaagbuzZaDu4K8vrf5SY+A0FBRwaclVahAFMgbSZs8yiJhoQaB+fmPeDRDP95Tnc1UAEXJLWjmV8468TqQZFHKde6AjQFf5RgjVJmria84Q9c0/tAn3wCOLBrbs3eU2BuxbDpqNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842021; c=relaxed/simple;
	bh=cWZjeTgOZCFr/5XpumqncS6R514+WzkceRCXWiA0OoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcot3DBJzz8072PPaO7THXe7CIogKR3vwTwYZNWcSlDYwqHzPJgQhgsu4SKNOO0AiV8gkZh85Yh+rbJQ+3DZeS2Pl7CM0TW5RCyKV9kifY6Imzl7JjCPnablbk9lubPRBteuITZDnurcExftaF5p6+Or946itcA+U43kI8P2kks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSETVizk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBD7C433F1;
	Tue, 19 Mar 2024 09:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710842020;
	bh=cWZjeTgOZCFr/5XpumqncS6R514+WzkceRCXWiA0OoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bSETVizk+rVn1apNUog2bK9+0yOGPGPp+0yHbPNtKZgCpp77UOAdFetdlOHghgbn7
	 hiUOE1zV99R6k99AnMUbuDewlOltkcDsZzsBnyEHDuI2CDxWbrAY/oVHtJEmN8MQP8
	 xIXdbdCiozlLuoYPkryEgiRFbrTFDByc1BjBUStGv6tvDyrIgtit2ovDycxxvlA703
	 mWY9/t+wEO9KuND3+Gl+ijUd+xHRy9nvpE+Qb3kTfm4IEzBzS+5NWiC0XCyLV72vmu
	 vVfjgEh7pJYaT7pghL+tNx/OHkUdDiitx6ryqsJps/H+ixWzQtC9b1fGuBEYsA/Zh7
	 0htebaF2ld8vQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [RFT 06/15] kfifo: pass offset to setup_sgl_buf() instead of a pointer
Date: Tue, 19 Mar 2024 10:53:06 +0100
Message-ID: <20240319095315.27624-8-jirislaby@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319095315.27624-1-jirislaby@kernel.org>
References: <20240319095315.27624-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As a preparatory for dma addresses filling, we need the data offset
instead of virtual pointer in setup_sgl_buf(). So pass the former
instead the latter.

And pointer to fifo is needed in setup_sgl_buf() now too.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Stefani Seibold <stefani@seibold.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/kfifo.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/kfifo.c b/lib/kfifo.c
index 61e35550aea5..3a249ce4f281 100644
--- a/lib/kfifo.c
+++ b/lib/kfifo.c
@@ -305,9 +305,12 @@ int __kfifo_to_user(struct __kfifo *fifo, void __user *to,
 }
 EXPORT_SYMBOL(__kfifo_to_user);
 
-static unsigned int setup_sgl_buf(struct scatterlist *sgl, void *buf,
-				  int nents, unsigned int len)
+static unsigned int setup_sgl_buf(struct __kfifo *fifo, struct scatterlist *sgl,
+				  unsigned int data_offset, int nents,
+				  unsigned int len)
 {
+	const void *buf = fifo->data + data_offset;
+
 	if (!nents || !len)
 		return 0;
 
@@ -332,8 +335,8 @@ static unsigned int setup_sgl(struct __kfifo *fifo, struct scatterlist *sgl,
 	}
 	len_to_end = min(len, size - off);
 
-	n = setup_sgl_buf(sgl, fifo->data + off, nents, len_to_end);
-	n += setup_sgl_buf(sgl + n, fifo->data, nents - n, len - len_to_end);
+	n = setup_sgl_buf(fifo, sgl, off, nents, len_to_end);
+	n += setup_sgl_buf(fifo, sgl + n, 0, nents - n, len - len_to_end);
 
 	return n;
 }
-- 
2.44.0


