Return-Path: <linux-kernel+bounces-140963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C18E78A19D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0D61C20C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF7D1B835F;
	Thu, 11 Apr 2024 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="k3j01mFG"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF8A1B8339
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849826; cv=none; b=nQG17EnwLyvHjjMRyItHZMDjTpRfSEdhyC7Qr+Wr7Z9RmGGL5F5wTB+ji+FxjlLVwMcWDeDNN5vO0m6/Ah5qPsyE6F6wOV570ez5Vx8jur/D5/b8IJnai92IAjLp4vcvTGZKEMm6MpBDH5voJ5Hcv28JLVLVwSlad6PHB8ll47s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849826; c=relaxed/simple;
	bh=wAyhkeiT98OgDYnfb1/0TlRUPJy9U3NtVZbm/6cnRGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQWAXU0gCb27/OEU43qiUeNQe/vYMadU8qBuZMVbL9Q2/akr6lazHUggNuskJoMWwZsgmboja+/dwkMqRk2ZM4mOtoHpN7mY+xAOps4ZDoSAH/8VfYwJSSSsUSnX2uQYFojNwJfmfSbIVWl3iS3OkwVGObpLQNBCnOVLf5fO2VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=k3j01mFG; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9809239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849824; x=1713454624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWDh0fHrNKhYTff7Upo8ZcOWFWy4jGjf0GUm5p1uDg8=;
        b=k3j01mFGH+Umvif35nE/BlrnWm2l6kMOMzkmwpTT11bGx+o0laCkSucFSfLlZr0LHG
         gxjS74WzCfigIcpyM91hpOMXMcfJ/nMVzLddCRU+6xQhRnvIngRJ7qIFT6T4AdcOdDZj
         CnZCXvgZqpzx6RS4q31e5M5MQuS8044bzfpow6Eiqzq+pzyjTzHzrPjKL6W8Ap8UE8xl
         vXb1Hu9M/rXZUCs4mkx+cchoRCQkdvGXmAgd+0sJojNxwviH7xugWctU+wpBb9F9izgg
         YMlx2hWDHFH9B4hg0KENMopLETHfNzJELWvQEP6j8PpZvBaG4PujTgWZqEgpEaVZCa6n
         Uwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849824; x=1713454624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWDh0fHrNKhYTff7Upo8ZcOWFWy4jGjf0GUm5p1uDg8=;
        b=CuKF/VZQibJ1ssuY/pvMyVqeChqqWUhX/LhTSaNkWS3n/8HpOQCgEImMlucQ9i6FGB
         Vp7LX6MKQBwv3/zFzWXKAirqUHmb41mhzbtzpBp75SaZiw8PaVtuUGxe1fESiVpAqTt5
         q3zAN14cnIaTtTnccJmQBWU2slHgZYjRr5lHwZmZj2RMv7eJmMyPdi0FxBMuFFYIY0Dr
         rjiIjK17JWYE9Er+TMqRTFRQtSfN8TTL63S0RTqYQfZtHeS2S5+jwxeKemQ1I4P3x4Qa
         czaf504MVdPn6eyOcwEi/5mH/ZwiAH2o1NKLC1bohkfeEAwxxSqLBDedVjFxWni5V0dS
         EgwQ==
X-Gm-Message-State: AOJu0YwzpPN+CYY8m7RDjOATw2Yf2Y9VuFtda+CBdkAv8oAmTqokVw13
	StFf8kLXh9f94I45BOpZEYB9BOHRwOLskyD9YyhGLpe2SP1MhIXVxU8sEeXgTCnGfqQo6qJ7Glh
	Y
X-Google-Smtp-Source: AGHT+IFMmGT6wfG7g0UVy3gvANf4vcwvYUQl+xWwkiJqTn4Drnl4Hg570k2iW5liDFh82653CNK+Eg==
X-Received: by 2002:a92:de01:0:b0:36a:cf8:3fe6 with SMTP id x1-20020a92de01000000b0036a0cf83fe6mr5774650ilm.1.1712849824297;
        Thu, 11 Apr 2024 08:37:04 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 194/437] scsi: qla2xxx: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:34 -0600
Message-ID: <20240411153126.16201-195-axboe@kernel.dk>
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
 drivers/scsi/qla2xxx/qla_dfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_dfs.c b/drivers/scsi/qla2xxx/qla_dfs.c
index 55ff3d7482b3..6aacdb5c65aa 100644
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@ -490,7 +490,7 @@ qla2x00_dfs_fce_release(struct inode *inode, struct file *file)
 
 static const struct file_operations dfs_fce_ops = {
 	.open		= qla2x00_dfs_fce_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= qla2x00_dfs_fce_release,
 };
@@ -569,13 +569,13 @@ qla_dfs_naqp_show(struct seq_file *s, void *unused)
 		}							\
 	} while (0)
 
-static ssize_t
-qla_dfs_naqp_write(struct file *file, const char __user *buffer,
-    size_t count, loff_t *pos)
+static ssize_t qla_dfs_naqp_write_iter(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
-	struct seq_file *s = file->private_data;
+	struct seq_file *s = iocb->ki_filp->private_data;
 	struct scsi_qla_host *vha = s->private;
 	struct qla_hw_data *ha = vha->hw;
+	size_t count = iov_iter_count(from);
 	char *buf;
 	int rc = 0;
 	unsigned long num_act_qp;
@@ -591,7 +591,7 @@ qla_dfs_naqp_write(struct file *file, const char __user *buffer,
 		    vha->host_no);
 		return -EINVAL;
 	}
-	buf = memdup_user_nul(buffer, count);
+	buf = iterdup_nul(from, count);
 	if (IS_ERR(buf)) {
 		pr_err("host%ld: fail to copy user buffer.",
 		    vha->host_no);
-- 
2.43.0


