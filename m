Return-Path: <linux-kernel+bounces-140814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7358A1911
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84DC4280EDA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41FC79945;
	Thu, 11 Apr 2024 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ywOLjbPT"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D1676C61
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849595; cv=none; b=ENbUZy9Dp0VKMeml8bcf0Rgt6TCArf0QEgYmfc3o8MjjiBT2/aP0n7dR8C4nU3J57ckh51E6ai2BHCerINOU+VwTEf7B5oUc6Aak4lhxTutuyLt7844DFCqLILWzT+q+D/UMd23Tkm5FeMUJAwjTNisVBHzYJ6zNyuQriCnG8XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849595; c=relaxed/simple;
	bh=EytEfueZdmHeZjMKVtERN8jT8/dREiZxCWtZspGZpjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAWH8ZZuwuCP0JU+1PNbYqOq00/EED5atAPlczhguci0UGZeUPV0oNV518mFnRaqFSGKrAmdf2wyxgPs8+e2xDAu5pR3pHe80jUwBlsgoRO1sFbvH15ulYiDvV7MF88OQ8QBg2cL+fD9GXbnR4aRsEuJBViwLykC+19LMDv6cYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ywOLjbPT; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9725139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849593; x=1713454393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttGc03mslHrJppIMBAAwcoGoLF7eUDlInI7/mEOC2ro=;
        b=ywOLjbPTlR77bw7gyvAudd6Le4jWE0Jx67miifsH9g/KP6NEQ0FaUuRF6my0ZLAiPS
         gh7LuyNt/Z3J94MJ0A92FRcoS5BO78hwvf6I0u9h4gWfzQdl6hG1VSpLI9ANZN2mdnOa
         yuCl+TmjiBAWolzSf5NC5OzUmFFGz4ul04LZcTJ2d7RGiPdT3DEEkJ0wrmsscli3zKSM
         t8BKDYT1B7rVSZQz2qk086uRiQiFjn5bZnF6bA4Q9yjBBj5Fkzl6iQWmNdW+DN4DglxV
         5r0ap6zF/eAaF4TRiVzKxtRF+XKAQShkV915+wa97zsuYHsuxJpdzjVAonouhzSyTBOh
         L1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849593; x=1713454393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttGc03mslHrJppIMBAAwcoGoLF7eUDlInI7/mEOC2ro=;
        b=o+jImyvh704AAlBJmzVPfUf85fg+4o35IOulzTzr+nc1ZmGR0CtnlPEmwO6p6qjOVC
         X9W//yopRFQ4l90xqVnJHr2F+IvmTfl8Kznsmc7h5kDYKpzLYRS3eyoe3c8nXenI/3xZ
         4QfigcX/t5dNXNoOzJASjGIGcf/UH+EgRvxzOAt2UL3eXNKgPn9vI4xvFptviV3CUVmw
         dI0SgOfGts8g0iU4Hc+De5FWHQU3XRMyOGhjzF9Kmow8xmS7KLgcQ9dxC9s6nZoumfSv
         /ztuDQFSWntAxxmN7wEhWQwu9qBKyrQ34hKCH+prl4Pj18w7g3vqEOVGPqROM2uDkXtk
         /p2A==
X-Gm-Message-State: AOJu0YynNmntlV4ZDwf6H5GwTEtQZoZpXbKX6ru1I8IAJV0+v50LM6g8
	TOPjlOTzBWD7J49ZdgSeHd0Ywe9yFW4wbEHc9QIeDBxRxygpSUkX62qmXfcGnrvvgbJGztCBQib
	g
X-Google-Smtp-Source: AGHT+IE4ZaUQLplCisu3bQYyi2+xumFquATwSGoMfA34ws/KXcHy4IYRj9o7157hhzrfT2YuZT9s/Q==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr206732iof.0.1712849593194;
        Thu, 11 Apr 2024 08:33:13 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 054/437] net: sunrpc: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:14 -0600
Message-ID: <20240411153126.16201-55-axboe@kernel.dk>
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
 net/sunrpc/cache.c    | 14 +++++++++-----
 net/sunrpc/debugfs.c  |  4 ++--
 net/sunrpc/rpc_pipe.c |  8 +++++---
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 95ff74706104..451b93494585 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1774,6 +1774,7 @@ static ssize_t cache_read_pipefs(struct file *filp, char __user *buf,
 
 	return cache_read(filp, buf, count, ppos, cd);
 }
+FOPS_READ_ITER_HELPER(cache_read_pipefs);
 
 static ssize_t cache_write_pipefs(struct file *filp, const char __user *buf,
 				  size_t count, loff_t *ppos)
@@ -1782,6 +1783,7 @@ static ssize_t cache_write_pipefs(struct file *filp, const char __user *buf,
 
 	return cache_write(filp, buf, count, ppos, cd);
 }
+FOPS_WRITE_ITER_HELPER(cache_write_pipefs);
 
 static __poll_t cache_poll_pipefs(struct file *filp, poll_table *wait)
 {
@@ -1816,8 +1818,8 @@ static int cache_release_pipefs(struct inode *inode, struct file *filp)
 const struct file_operations cache_file_operations_pipefs = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.read		= cache_read_pipefs,
-	.write		= cache_write_pipefs,
+	.read_iter	= cache_read_pipefs_iter,
+	.write_iter	= cache_write_pipefs_iter,
 	.poll		= cache_poll_pipefs,
 	.unlocked_ioctl	= cache_ioctl_pipefs, /* for FIONREAD */
 	.open		= cache_open_pipefs,
@@ -1840,7 +1842,7 @@ static int content_release_pipefs(struct inode *inode, struct file *filp)
 
 const struct file_operations content_file_operations_pipefs = {
 	.open		= content_open_pipefs,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= content_release_pipefs,
 };
@@ -1866,6 +1868,7 @@ static ssize_t read_flush_pipefs(struct file *filp, char __user *buf,
 
 	return read_flush(filp, buf, count, ppos, cd);
 }
+FOPS_READ_ITER_HELPER(read_flush_pipefs);
 
 static ssize_t write_flush_pipefs(struct file *filp,
 				  const char __user *buf,
@@ -1875,11 +1878,12 @@ static ssize_t write_flush_pipefs(struct file *filp,
 
 	return write_flush(filp, buf, count, ppos, cd);
 }
+FOPS_WRITE_ITER_HELPER(write_flush_pipefs);
 
 const struct file_operations cache_flush_operations_pipefs = {
 	.open		= open_flush_pipefs,
-	.read		= read_flush_pipefs,
-	.write		= write_flush_pipefs,
+	.read_iter	= read_flush_pipefs_iter,
+	.write_iter	= write_flush_pipefs_iter,
 	.release	= release_flush_pipefs,
 	.llseek		= no_llseek,
 };
diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
index a176d5a0b0ee..8fb085c614ef 100644
--- a/net/sunrpc/debugfs.c
+++ b/net/sunrpc/debugfs.c
@@ -112,7 +112,7 @@ tasks_release(struct inode *inode, struct file *filp)
 static const struct file_operations tasks_fops = {
 	.owner		= THIS_MODULE,
 	.open		= tasks_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= tasks_release,
 };
@@ -211,7 +211,7 @@ xprt_info_release(struct inode *inode, struct file *filp)
 static const struct file_operations xprt_info_fops = {
 	.owner		= THIS_MODULE,
 	.open		= xprt_info_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= xprt_info_release,
 };
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 910a5d850d04..73189ac4d9f7 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -320,6 +320,7 @@ rpc_pipe_read(struct file *filp, char __user *buf, size_t len, loff_t *offset)
 	inode_unlock(inode);
 	return res;
 }
+FOPS_READ_ITER_HELPER(rpc_pipe_read);
 
 static ssize_t
 rpc_pipe_write(struct file *filp, const char __user *buf, size_t len, loff_t *offset)
@@ -334,6 +335,7 @@ rpc_pipe_write(struct file *filp, const char __user *buf, size_t len, loff_t *of
 	inode_unlock(inode);
 	return res;
 }
+FOPS_WRITE_ITER_HELPER(rpc_pipe_write);
 
 static __poll_t
 rpc_pipe_poll(struct file *filp, struct poll_table_struct *wait)
@@ -386,8 +388,8 @@ rpc_pipe_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 static const struct file_operations rpc_pipe_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.read		= rpc_pipe_read,
-	.write		= rpc_pipe_write,
+	.read_iter	= rpc_pipe_read_iter,
+	.write_iter	= rpc_pipe_write_iter,
 	.poll		= rpc_pipe_poll,
 	.unlocked_ioctl	= rpc_pipe_ioctl,
 	.open		= rpc_pipe_open,
@@ -449,7 +451,7 @@ rpc_info_release(struct inode *inode, struct file *file)
 static const struct file_operations rpc_info_operations = {
 	.owner		= THIS_MODULE,
 	.open		= rpc_info_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= rpc_info_release,
 };
-- 
2.43.0


