Return-Path: <linux-kernel+bounces-140756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90608A18C2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61021287A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCCE1758D;
	Thu, 11 Apr 2024 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="C+Xipf6l"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842061400B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849495; cv=none; b=GZSNnQv0fWipwj9H982IKiaYQztxj6ehIvQ8WKFW+Yq/J4/f/0hd1gp/PuJmRQVH0QM1VgvhCEZc/xg4mRa/7s3udb9s5zLY2rtyoDtXGiD8JI9vmCMNMLd4cWW9aiFgsaSXq16JPlO/qZ/v2/KHw3iUXjlXITd5tZXIdoEz/yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849495; c=relaxed/simple;
	bh=KNF16j1wWRHp7QL9dlpe230fqxnk/ID08XGeyGDW3Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqMtZU/CCNQhDvPQUHpDQp1WbZ6I7Puw6ct4XA0HA6WxAOORaG7JFDFuIsHpBdDqZH6Yd9FetUcs9Uy6PCAV7NQZWOi1bnFHLbU/V6nnbO2iwA8M84m0AAWt3TvJKKZAd5GZGQaB0k1X7jgabc3zc7HHsutIQ04fYPM/ZID+xFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=C+Xipf6l; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69471839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849490; x=1713454290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siJ0q22m4N60RaUsv3MSDvS2FSwhfuD2Ji6r6b8RrnE=;
        b=C+Xipf6lHz7Ht2uIiPAWtFD5zabTOd7SnayD5GXrxEzLUDXMuG9FlUBk7O9tBq0Xvl
         EiCfnZqBvpRc6QvKWpO5CPEB6ZaHh8gcfvHskdSWEFGIfPKJoMizLmw/5ICAC0xH4HRY
         kMz5I+BzGebLU6mEaiwOG4eMQF4TZAZdPNlVZCujnGIjkPLS82CGVtZvjMBkH5MkmGJn
         WYVGiMBd3Uu5lIOAEewIVkWmlY63C0b5zTefQlRK8pENWzzii5uspJnFyLqxTdZCcm15
         I5AP2+VLi9BrToiSprdfmAKuJBWGsKM3W9QvJqnBMHHD8bpe2k7KYrNKAomYMdXSxL9D
         /Ncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849490; x=1713454290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siJ0q22m4N60RaUsv3MSDvS2FSwhfuD2Ji6r6b8RrnE=;
        b=Gq3Qg2tnvElKJemBTUcRno3rzGKjpqm9vivEqOo9OKoT1iu18xPrnVmYjZ6IO6oows
         TmRY5slpsVwCWcwIfoNJYaoGZ8sQnWp3n8TFE7AilrhNY29X56LY/LqUeARoTL1iPmpz
         vGobaic9EtS/Zuo7CGvqVr29b0opY9z6cnLzhQRZmUbQt7VjxAK3/m7cVU8sRKWI4Cvi
         5UMVZAxnTcnqtzANv3ilECN/oekI742YSpHWFm/xIC4VZvHrZAhM8oCITG1MEa3loOIz
         QqUskG9V5BBrh3+lcb66nxDG8t6Ypw5MK1QPMnwLnv06lg++hUYaRZ90vHPux9OMW8tN
         1Y+Q==
X-Gm-Message-State: AOJu0YyVBpbLQCQt+2kZ+rP8lpPWe8nI9gFHffFh70RoT0F8Q16iVxSs
	YfbrAfrH1XS/38v+UbU7DIGUno8Z5Ajm0qTGQSpHohaCOMcAlbUCUcgvwvg3SH3JJ3FxphNq9an
	k
X-Google-Smtp-Source: AGHT+IHSEwWPNkGz6RFsJUyvtJz5TmYfwSwjzDjeEl/S+aKbzVoEIcp0vxQZ95ip9xvY33n9KK7dxg==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr29422iob.2.1712849490498;
        Thu, 11 Apr 2024 08:31:30 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:31:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 002/437] fs: add generic read/write iterator helpers
Date: Thu, 11 Apr 2024 09:12:22 -0600
Message-ID: <20240411153126.16201-3-axboe@kernel.dk>
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

We already do this internally for vfs_readv() and vfs_writev(), which
need to check what method to use. Add generic helpers for this so that
drivers can do this themselves, if they haven't converted to using the
read/write iterator file_operations hooks just yet.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/read_write.c    | 18 ++++++++++++++++++
 include/linux/fs.h |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index 82ec75937b08..1d035293607b 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -802,6 +802,24 @@ static ssize_t do_loop_writev(struct file *file, struct iov_iter *iter,
 	return ret;
 }
 
+/* generic read side helper for drivers converting to ->read_iter() */
+ssize_t vfs_read_iter(struct kiocb *iocb, struct iov_iter *to,
+		      ssize_t (*read)(struct file *, char __user *,
+				     size_t, loff_t *))
+{
+	return do_loop_readv(iocb->ki_filp, to, &iocb->ki_pos, 0, read);
+}
+EXPORT_SYMBOL(vfs_read_iter);
+
+/* generic write side helper for drivers converting to ->write_iter() */
+ssize_t vfs_write_iter(struct kiocb *iocb, struct iov_iter *from,
+		       ssize_t (*write)(struct file *, const char __user *,
+				       size_t, loff_t *))
+{
+	return do_loop_writev(iocb->ki_filp, from, &iocb->ki_pos, 0, write);
+}
+EXPORT_SYMBOL(vfs_write_iter);
+
 ssize_t vfs_iocb_iter_read(struct file *file, struct kiocb *iocb,
 			   struct iov_iter *iter)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8dfd53b52744..fd862985a309 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2119,6 +2119,12 @@ extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
 				   loff_t, size_t, unsigned int);
+ssize_t vfs_write_iter(struct kiocb *iocb, struct iov_iter *from,
+		       ssize_t (*write)(struct file *, const char __user *,
+				        size_t, loff_t *));
+ssize_t vfs_read_iter(struct kiocb *iocb, struct iov_iter *to,
+		      ssize_t (*read)(struct file *, char __user *,
+				      size_t, loff_t *));
 int __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 				    struct file *file_out, loff_t pos_out,
 				    loff_t *len, unsigned int remap_flags,
-- 
2.43.0


