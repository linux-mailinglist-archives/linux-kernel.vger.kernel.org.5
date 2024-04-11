Return-Path: <linux-kernel+bounces-140848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D89D8A1931
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9F82821B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6065713664A;
	Thu, 11 Apr 2024 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="x+4m/oFZ"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9E31332B0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849649; cv=none; b=URXmK7/mSES+KLU5OBqGV2aLoce7kn/cK/iyeyHJHxrcD2M9R0X1f3VKC76YQkpuzK0RlQo9EBQY88gs0j2TGoL2+ECj+o9XWlQcTHyL6LdrJApiCNa/Cf/KETcABr12fw/kh/QihsDunYi1X5UQKT+SAsCr6DrOGI19ErcOBFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849649; c=relaxed/simple;
	bh=XLySHR0YIO1LxjGPhiC1KU5h/wP3tvj1z/3UEePY214=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGZtXwEdFE62HbJx9+LpLbsB5HFCU0TEDMvDKg1KeRc4vPgj6eEdwek/I0Vj15fnRvMlDhWK0fEaIMTzrKCaeoB/WD1t4nZ4nSfOtvvR0Pc1Q/nWL/JxSC0NPVf5g5isKGkfkpRXeNG4ai4Lkrvzgg8O3cjkfheASsnydjWwt/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=x+4m/oFZ; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16133939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849647; x=1713454447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsMZ1D54PALBtcGxDrQ52r7sdp3B1+XzVHP1czxtxdo=;
        b=x+4m/oFZc0doGN4BTJLtHixC+osiC4gt0QuY8DOBKHLJGvsdPd+ufvh5i5X6wh6ieE
         Nh9pChbw3koVgN8KUI+QQSI2kKu/1Rtr4JfDJs41r0hGYVDa9kv9XEA4BqiO9FbLBop/
         GaJP6Go6l4OSeN6C4Uj7fgpfxiNEsDPXEO8Ox06gjFcz41SHWSQeEOU9AW6zxR0PpoNO
         QLgb3QCNLTzf5OvpxNAvzBJShZDh/Fdwb9of1lsVFMiykVQLQodyUaMBC32um4zAFv6b
         ZHFlKUJKhcgXpBVlrY4bVTmPGQwmZK1l2Mi6jQq6dTcLgaTFPcL+8gwKUiXPif1Ef5G7
         GiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849647; x=1713454447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsMZ1D54PALBtcGxDrQ52r7sdp3B1+XzVHP1czxtxdo=;
        b=pZpXrNiqkgWZ/j6pG9uRjINMVc404YdzbQay8fdznrYTekYTBcWrlxMA2Yki8GPjOv
         +zc2DLZYnxQJ8W+PkQ431Q6wsRkXQpVimZCI94ixQ1fPm7HHgxwhPBMEzmfmrYROBT3/
         VgcOUVqgIod0CY1Yv5VNq3W1o+sdUiLB7zbvgfbXoZA38OzNnLRe6MVMsSvU8S3dSTAU
         WV2nkZb1XRs2bfW0NBRSYu/OE0EI8R1iWXfp8miE0x2nVEPSaBARmcba/DUd1XYVV6/v
         Rs4LPWs1J9Ysfs9prx/+w3HEUiff3za6vr4L8N34wSNErGUXKpzWwhzMGuuri2mGE9Dc
         xU6Q==
X-Gm-Message-State: AOJu0Ywwqkec0+kxXj0G3ZOY7iJcx3VKWO0pO8PBj7JBbFUzUW8zdNzh
	4rw9910gnVNS7expxeDQc+bdAHzVHH2G//TDXwmFPvgfjrtdn7QhPk3iuXtxVD6agjXS8FPfYHD
	g
X-Google-Smtp-Source: AGHT+IGNtxu+nO20y/bUirS7yrDe+if+4KobIglJP0JH5xPtqlsJDwp5/7YDU5oA1qCCkLXeDqGo7w==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr177343iov.2.1712849647382;
        Thu, 11 Apr 2024 08:34:07 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 086/437] fs: add iterator based version of simple_transaction_read()
Date: Thu, 11 Apr 2024 09:13:46 -0600
Message-ID: <20240411153126.16201-87-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411153126.16201-1-axboe@kernel.dk>
References: <20240411153126.16201-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/libfs.c         | 10 ++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 3280d02fc385..56b404ad4cfb 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1277,6 +1277,16 @@ ssize_t simple_transaction_read(struct file *file, char __user *buf, size_t size
 }
 EXPORT_SYMBOL(simple_transaction_read);
 
+ssize_t simple_transaction_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct simple_transaction_argresp *ar = iocb->ki_filp->private_data;
+
+	if (!ar)
+		return 0;
+	return simple_copy_to_iter(ar->data, &iocb->ki_pos, ar->size, to);
+}
+EXPORT_SYMBOL(simple_transaction_read_iter);
+
 int simple_transaction_release(struct inode *inode, struct file *file)
 {
 	free_page((unsigned long)file->private_data);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 69e4dfac2853..85db7dde4778 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3500,6 +3500,7 @@ char *simple_transaction_get(struct file *file, const char __user *buf,
 				size_t size);
 ssize_t simple_transaction_read(struct file *file, char __user *buf,
 				size_t size, loff_t *pos);
+ssize_t simple_transaction_read_iter(struct kiocb *iocb, struct iov_iter *to);
 int simple_transaction_release(struct inode *inode, struct file *file);
 
 void simple_transaction_set(struct file *file, size_t n);
-- 
2.43.0


