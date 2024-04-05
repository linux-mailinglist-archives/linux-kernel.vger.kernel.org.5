Return-Path: <linux-kernel+bounces-132442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 754C38994F9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16E92B25750
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE1F2E64F;
	Fri,  5 Apr 2024 06:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVN9rsRC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801692D61A;
	Fri,  5 Apr 2024 06:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297330; cv=none; b=SC6lZ4GdVdrnkzBDmQVHAMyi2G40b66VENibXrisijP0yeWHG7eSGCdhlTNnNUasoEvjZtLc+6JBFeWOkwHhUd5C/MIRgWouPrG2gFDFqZDJQXsNsvG/0ehFVCVs2mpUgkmuj9EHgKr31RzedrPGgWCS4QIijgJTZlJyL0TGdEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297330; c=relaxed/simple;
	bh=cWZjeTgOZCFr/5XpumqncS6R514+WzkceRCXWiA0OoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKsK8SHttElAVITUDvCysM4r9VPz+qr9QWNyn2MjyAOgJ4CQ/jfFUofTbLM+XG08C4RcPUyE4Ln/Hq8gDnsDRVWXXxrcDVNshyB2ka5VY16xsFGVFuqozz0mZXuo18yqTAGhQHF5zHbm0fMfNMhlU5N4WIl/0DBAM5+g6f6iUeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVN9rsRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D83C433F1;
	Fri,  5 Apr 2024 06:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712297330;
	bh=cWZjeTgOZCFr/5XpumqncS6R514+WzkceRCXWiA0OoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVN9rsRCJEZ7kH/NLiRLBCYA25kGTEfdgzg7rP8fFBtzPeF+ncV5nHrTFs8vdOR/t
	 KSU+7jM62DPqRKyLqmM0FklHsUUGv/AEOrUa97U0+u8DS4ZDkrHf1uNZcQv/AOzQtw
	 T+O9ualZCKYebmSwYm1X+2jq0kIRTHa0+adceE+jlVMgnjYkvuobFqiIpPq/G6UN3F
	 eTq3aVW0XAD4Pb/JvfL1wQV7WJsslLeUCi3qiHxcyKAG3EItkskiyGHeLtiR8TUAoT
	 lNbOtAjY6UV02yQefOe88YtxLoxQ5ggh6ZJFGAq/w9qk7MyB/9zX0XOH4Dagv/KFfl
	 p22ZbEIjnvRoQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 06/15] kfifo: pass offset to setup_sgl_buf() instead of a pointer
Date: Fri,  5 Apr 2024 08:08:17 +0200
Message-ID: <20240405060826.2521-7-jirislaby@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405060826.2521-1-jirislaby@kernel.org>
References: <20240405060826.2521-1-jirislaby@kernel.org>
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


