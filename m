Return-Path: <linux-kernel+bounces-140755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3A28A18EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5AD6B2C103
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFC714AB4;
	Thu, 11 Apr 2024 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Udmx4d/b"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D0E13FF6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849495; cv=none; b=Uwc5sVbGFme2GojjVC/oHRRWU8f0DKTmJyBflqN884bVBGbfGI2XsXGx2Ko5eISVSY97L1X8Qqc5j6g6uyGAJ+qCCFKwmgvWshucVWVxXz9XmUl33WF2lAAu6vPZM7R6TRWn8JVlCADnvK7CqTRNVJvRK/i+SwmgcXya8mhfrdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849495; c=relaxed/simple;
	bh=x+u/nQhNU1iu7Dza7OxlrgPFrNgRW9j3PCiLFVmM26Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZm3uu5hmRozbsM/9qbiQukr5D9Td1X5IKazidUzYbhNTc7e7KGwPH3IZyW84rFbrYyja2iVO08/5UAXNAio0+4UJHgB1GEnf3Y/5zHFg1y/My3yfCwydK6wzD3x7ur9tPHAN1L9svmDDVa609qf8QZ6VCaGja4B3KvZOb1MghE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Udmx4d/b; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8836739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849490; x=1713454290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7iZENkO3MAymxhOjZv2YM3OJXd/PaTjjUhgyV5xd68=;
        b=Udmx4d/brKQ33YDX9n4saq7ia2J4rST2Qr+KcRXKzzcMeHTFkV1UvcaW1Z5QDLwGkW
         hAGsMyNkBl5L0HwM7GxkQSMKDQZXTPiOoNgUiBUP93J/z0Pirly+zyp692sJKMHsH07g
         yfNykkzfSShEDRUJOvr16l8J1RZ7h7RN9F7XmEeL9GO8Ldj04amOcDHBnwxI/l2Cc31g
         Uz517WL/GePvKV2KXYG972C2uXndn9jR/a7B/jrpebuz8oLkQCxkZ9dn7PuhT7nb2vk1
         DKEEEPlmpUt4kvxXipXDv9nb/CA/3dq7R2GvGpZplw5mKOp0WDa/TcsSfoLEzkbFS8Iq
         EURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849490; x=1713454290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7iZENkO3MAymxhOjZv2YM3OJXd/PaTjjUhgyV5xd68=;
        b=bimteybEUJ4cJdnUl7mD/NPH0Gf/kkjFXQwDFdJMNCWXtCG3zAvpTdO0Kren4jNLkG
         Qf5vAP5IPOokIVrOBo+/qu1WGlKGWiI4YL8tbCK0nmpoTVBoOem5FKEhcAIK3J+uNQ2F
         llTpH5Ovi58CnKGW1OIVJOh6QEIRXzxv1EYrvbJ0Bv7hgFc+6MHTRHq8P46vdih/fVb0
         07sVz5oXjb817ZotMJhmI2UsToScVwGhr75ooGV6vPhWvBy9uFKko3UG9DHqPjkQWGtz
         dfK+B5HfErdU9NRJ+N/JXCI0jnhZTfKbjzv97x9UjdlTDqFh0LQHdGVxlSmredd1xEg6
         tuZQ==
X-Gm-Message-State: AOJu0YzGdEkAfxHCqjAQx87UmKvTmx1wE8ZknCuU8cljY5UUvUBXTH3h
	5Nn5lqD8MVxgQFoDQqQECfnJ44VCNUEp3akGc3JcdaGVsmYpHvpRNS1hmsr6MOLRYITeiIXNuf0
	4
X-Google-Smtp-Source: AGHT+IErTnU8QFnrp/rGRKRLn8HhGGI5TaJA2GcbiawgKU7lxIE6UiShgCAX+0tq4ehuocGabe9SeQ==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr167498ioj.2.1712849489814;
        Thu, 11 Apr 2024 08:31:29 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:31:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 001/437] fs: split do_loop_readv_writev() into separate read/write side helpers
Date: Thu, 11 Apr 2024 09:12:21 -0600
Message-ID: <20240411153126.16201-2-axboe@kernel.dk>
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

No functional changes, just in preparation for using these separately.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/read_write.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index d4c036e82b6c..82ec75937b08 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -746,8 +746,10 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
 }
 
 /* Do it by hand, with file-ops */
-static ssize_t do_loop_readv_writev(struct file *filp, struct iov_iter *iter,
-		loff_t *ppos, int type, rwf_t flags)
+static ssize_t do_loop_readv(struct file *file, struct iov_iter *iter,
+			     loff_t *ppos, rwf_t flags,
+			     ssize_t (*read)(struct file *, char __user *,
+					     size_t, loff_t *))
 {
 	ssize_t ret = 0;
 
@@ -757,14 +759,35 @@ static ssize_t do_loop_readv_writev(struct file *filp, struct iov_iter *iter,
 	while (iov_iter_count(iter)) {
 		ssize_t nr;
 
-		if (type == READ) {
-			nr = filp->f_op->read(filp, iter_iov_addr(iter),
-						iter_iov_len(iter), ppos);
-		} else {
-			nr = filp->f_op->write(filp, iter_iov_addr(iter),
-						iter_iov_len(iter), ppos);
+		nr = read(file, iter_iov_addr(iter), iter_iov_len(iter), ppos);
+		if (nr < 0) {
+			if (!ret)
+				ret = nr;
+			break;
 		}
+		ret += nr;
+		if (nr != iter_iov_len(iter))
+			break;
+		iov_iter_advance(iter, nr);
+	}
+
+	return ret;
+}
+
+static ssize_t do_loop_writev(struct file *file, struct iov_iter *iter,
+			      loff_t *ppos, rwf_t flags,
+			      ssize_t (*write)(struct file *, const char __user *,
+					       size_t, loff_t *))
+{
+	ssize_t ret = 0;
+
+	if (flags & ~RWF_HIPRI)
+		return -EOPNOTSUPP;
+
+	while (iov_iter_count(iter)) {
+		ssize_t nr;
 
+		nr = write(file, iter_iov_addr(iter), iter_iov_len(iter), ppos);
 		if (nr < 0) {
 			if (!ret)
 				ret = nr;
@@ -931,7 +954,7 @@ static ssize_t vfs_readv(struct file *file, const struct iovec __user *vec,
 	if (file->f_op->read_iter)
 		ret = do_iter_readv_writev(file, &iter, pos, READ, flags);
 	else
-		ret = do_loop_readv_writev(file, &iter, pos, READ, flags);
+		ret = do_loop_readv(file, &iter, pos, flags, file->f_op->read);
 out:
 	if (ret >= 0)
 		fsnotify_access(file);
@@ -970,7 +993,7 @@ static ssize_t vfs_writev(struct file *file, const struct iovec __user *vec,
 	if (file->f_op->write_iter)
 		ret = do_iter_readv_writev(file, &iter, pos, WRITE, flags);
 	else
-		ret = do_loop_readv_writev(file, &iter, pos, WRITE, flags);
+		ret = do_loop_writev(file, &iter, pos, flags, file->f_op->write);
 	if (ret > 0)
 		fsnotify_modify(file);
 	file_end_write(file);
-- 
2.43.0


