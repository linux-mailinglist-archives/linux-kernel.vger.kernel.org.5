Return-Path: <linux-kernel+bounces-140973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 659F38A19DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203591F25C4A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E3778C77;
	Thu, 11 Apr 2024 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LQ76ahtj"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB59939AF1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849844; cv=none; b=LxnDUVPb0DEkZN9fLHXEmN4kt6Qy0HKRzf+G2YGR6ZqzsVjDc9PeKySHvecPzgvWS0hIuD9xhauHiabtbmhM0HklRp0m07Xoc66uFSOFpwbIRarnB52a9xeeMQPkHp/a9q8rtGTeHXNvr12Ta0rjcS+/azP5Ipah7N9mDTQDHVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849844; c=relaxed/simple;
	bh=aajrNqD/Rckw7jOidvZZUN6fQKDlQgxbvTZgO+e9Gq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAiNA6sX0BtzRwM7xQHmWAEraNSwXDYJ+E04pkAA/DnHBJ0tTM1E82O1h9f2oyiSryaKeTinvU+xjxfsANTeVRVn+yh51fk2rWYCd/GRiWjUdn6aEbgxwJJxZmDbRYNms3+Ys8Iy0GG1F6St0TThQOX0OyKpuBAnnCeVK4kDDOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LQ76ahtj; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170540739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849842; x=1713454642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pe/uXO9WUbo/+TRHqVLJ2sBbazJNxXNSSYXndo+pK7U=;
        b=LQ76ahtjA3DCyZxr6OzWXDBxYNnEhoO+eWy7LJh7BRW/tC8Peye88jccRnyBT7x0ZX
         g5bsgO5HulhMorOR8ebE0j+mqEC60I+k5X1iZKmJQFrtrD7xqWj8Tq/KW2Z+7coiBn2O
         AQ/P4TEMyE0z5A0f/itlTKHyPexYvljmqtW06IxmN6QDourlkfJJ/4Y+cjNTZiO65xUv
         X0+3zddDiV/BtLqRoef9EeCvUWW1NhOeZiJGymOlyQNOv7FbtJ/9UPQg7rOqy8c7lTgQ
         ZV/tNYtLKs/SEvxa79xW31dcInsjC7+T4ByQ/vA5sMRjpnEC4Fjk6FztqSBn09zDIkJY
         XT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849842; x=1713454642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pe/uXO9WUbo/+TRHqVLJ2sBbazJNxXNSSYXndo+pK7U=;
        b=SBD379sc51vfpICsnnW33E8allgmu0aNuB6FYElZ0rsADFHSpoGWts62Mh3VvXGrfI
         QNREaonmbCzPg3hS9yDc+Mdsp1fCbW54JoP8DrDCB2HFN8Wlc/TO0/xGjhzoFo9y9H0x
         obR8CVES4bJRhmxkzRESAekM37GvPAA2nfSq4jRehGDomPB0ZMMcI46npOaviUkKlZ2s
         mWirGungWJMei56xdkNzyc8bq5PueU8JOM/Z2uXbHql32STlSDv3gm4DMUrDgch13Y25
         MAW3TBPbBNcI4g44VRZ/+3eKPkU5iX7csw3qREjyhrS1OJccsW55g2/cncwSjQe4y2Ey
         WUIQ==
X-Gm-Message-State: AOJu0YzpM6TKWDYps+VHl3gDecx2MR6L2I0nYS6GBvBPB+HCA+vpn/nT
	J+0XRPaTcTdLVPm4NTrqzBmjppaua29INjr1SXjlBeNATkVQ/1vglK/+m227dkxcnsgRUT0sWUX
	4
X-Google-Smtp-Source: AGHT+IEOccgd7r+7kiKfP8/FuXJKQogbWfXF+ILwn8ZGkIRuH1eumh5NUUo92oaSIoQ79NCw1qMGOQ==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr19532ioc.1.1712849841782;
        Thu, 11 Apr 2024 08:37:21 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 204/437] staging: vc04_services: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:44 -0600
Message-ID: <20240411153126.16201-205-axboe@kernel.dk>
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
 .../interface/vchiq_arm/vchiq_debugfs.c          | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
index d833e4e2973a..0e18e2020654 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
@@ -52,15 +52,14 @@ static int debugfs_trace_open(struct inode *inode, struct file *file)
 	return single_open(file, debugfs_trace_show, inode->i_private);
 }
 
-static ssize_t debugfs_trace_write(struct file *file,
-	const char __user *buffer,
-	size_t count, loff_t *ppos)
+static ssize_t debugfs_trace_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *f = (struct seq_file *)file->private_data;
+	struct seq_file *f = iocb->ki_filp->private_data;
 	struct vchiq_instance *instance = f->private;
+	size_t count = iov_iter_count(from);
 	char firstchar;
 
-	if (copy_from_user(&firstchar, buffer, 1))
+	if (!copy_from_iter_full(&firstchar, 1, from))
 		return -EFAULT;
 
 	switch (firstchar) {
@@ -78,16 +77,15 @@ static ssize_t debugfs_trace_write(struct file *file,
 		break;
 	}
 
-	*ppos += count;
-
+	iocb->ki_pos += count;
 	return count;
 }
 
 static const struct file_operations debugfs_trace_fops = {
 	.owner		= THIS_MODULE,
 	.open		= debugfs_trace_open,
-	.write		= debugfs_trace_write,
-	.read		= seq_read,
+	.write_iter	= debugfs_trace_write,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
-- 
2.43.0


