Return-Path: <linux-kernel+bounces-141222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874928A1C91
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74068B27054
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102C220404B;
	Thu, 11 Apr 2024 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jlUaS+ys"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFDB2049F8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850231; cv=none; b=SLEBHY5Ycpu0p2Fy6G5mbNR21VYN0kWXwvOoR3aIxyn/tiAbylwCFgXb+79Mw+GqWAgCwu0hyzYZ/KDFtW7Y+cDxEvikWVlVXjL0lAp4EpmN24kTZi3uE552hPSSMstfxHRq+hq9ofQuv0d+hl0g9wqiiZULGJ4mw4AMolWh+9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850231; c=relaxed/simple;
	bh=javgIbxkE1+7A6rhREq95g8HCMcpsCkLIkqCYQtKuUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tP4gOAI9Geupn26mWPq72/2VtdCYln56cZYgYgyoJCZ8c/QJbWCTY8f6lHbAeATTnNu8hCBp4jqXGAG4G06dMNeiGrQOUNDwB3HLz3mm7o0aSdckZ0+7wcBTTm0J3PWaywyW+MMKeKq6yw5233n/vnmUnoXEoOE88GD4c4mM2UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jlUaS+ys; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36a34b68277so125625ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850229; x=1713455029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0Ldb0OWw+BFeSwp6J+TFEGOy1nUuoCa5jXwSLo8ftE=;
        b=jlUaS+ysKpGyGbjPnX1KzAVsrQoq7ruz0hsgvJu6eSgczJRg3kwhDTIpOQAmjz/4uV
         Q9beO9h3Y9n5apuWyGxBi/+XTjG4viX2KnrkmjHUFpMRzoAgDgK7Q64dE/jf4knvV2oi
         lA8dXwcX/78D1sV3skIrZgC1E5U13lDQmx/OKZMO/fO2YcmHgrBQGDaiyOiVUWoH3sK9
         AuXW7aokg8l0h+c2lWSAnoDmZ2IyxAejzGp8qvTkIKMVJN8k7xXcyFip73dLRGxkjtru
         R7IFfgLa6Ce0c1SM1A22PnCdQRp8sV0sWPnrJXpds8u2BfqqvOVPMf3xfkiKsdq8NSKF
         peHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850229; x=1713455029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0Ldb0OWw+BFeSwp6J+TFEGOy1nUuoCa5jXwSLo8ftE=;
        b=f/ioS8ZHU+YVCiTbvopJYfI4il/fqagyZLYrr1zJtubNoyBHELuWgzyzKENVKtT1ub
         +P+LeweQew3YnI7X+7bd8n2WEu7TPER139bgH4ddQnaNsDlTnDrITTK0M52qVNCNX/uT
         q8q/2p/qlTa/JUVRx1kvoZaufsaL7/UgklovULUS4EMW2AokPgviLZ/Yq5+LOIMYQWRd
         ofwKiwH6LkVB7C5jD5Jp4wGcbIlLnxOfCRp8xqNBFLCbWuy0O0WfB399sLyAJg4z+qa7
         TLJZM7Y1+/wJ5YIxas1zRAWoPmx/U9stl1CBDiqJhnND4GaG2VJwl5UkOQ8vyXdKme5s
         jOVQ==
X-Gm-Message-State: AOJu0YxwXIklL/GkCZp68r9tTNjtAzSa/fQPClvZWhRRfpT7we18W4+a
	N424XpWuICEVabhoaYDbyATkMi9B6aqLm4+WlKkejUoXM9Buy9tzCNtxHeXyLYxLvfDSGYBt6xn
	c
X-Google-Smtp-Source: AGHT+IFpFHSz7Hea4rg3qKqsQ1AOKmrfuLzFkj77vfljNyXFRiMumTJa70jT/Ytbn9tM/hLjQxdNqA==
X-Received: by 2002:a6b:6605:0:b0:7d4:1dae:da1a with SMTP id a5-20020a6b6605000000b007d41daeda1amr166987ioc.2.1712850228798;
        Thu, 11 Apr 2024 08:43:48 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:47 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 435/437] fs: kill off non-iter variants of simple_attr_{read,write}*
Date: Thu, 11 Apr 2024 09:19:35 -0600
Message-ID: <20240411153126.16201-436-axboe@kernel.dk>
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

They are no longer used, kill them with fire.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/libfs.c         | 89 ----------------------------------------------
 include/linux/fs.h |  6 ----
 2 files changed, 95 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 56b404ad4cfb..74159f63334e 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1337,44 +1337,6 @@ int simple_attr_release(struct inode *inode, struct file *file)
 }
 EXPORT_SYMBOL_GPL(simple_attr_release);	/* GPL-only?  This?  Really? */
 
-/* read from the buffer that is filled with the get function */
-ssize_t simple_attr_read(struct file *file, char __user *buf,
-			 size_t len, loff_t *ppos)
-{
-	struct simple_attr *attr;
-	size_t size;
-	ssize_t ret;
-
-	attr = file->private_data;
-
-	if (!attr->get)
-		return -EACCES;
-
-	ret = mutex_lock_interruptible(&attr->mutex);
-	if (ret)
-		return ret;
-
-	if (*ppos && attr->get_buf[0]) {
-		/* continued read */
-		size = strlen(attr->get_buf);
-	} else {
-		/* first read */
-		u64 val;
-		ret = attr->get(attr->data, &val);
-		if (ret)
-			goto out;
-
-		size = scnprintf(attr->get_buf, sizeof(attr->get_buf),
-				 attr->fmt, (unsigned long long)val);
-	}
-
-	ret = simple_read_from_buffer(buf, len, ppos, attr->get_buf, size);
-out:
-	mutex_unlock(&attr->mutex);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(simple_attr_read);
-
 /* read from the buffer that is filled with the get function */
 ssize_t simple_attr_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
@@ -1462,57 +1424,6 @@ ssize_t simple_attr_write_iter_signed(struct kiocb *iocb, struct iov_iter *from)
 }
 EXPORT_SYMBOL_GPL(simple_attr_write_iter_signed);
 
-/* interpret the buffer as a number to call the set function with */
-static ssize_t simple_attr_write_xsigned(struct file *file, const char __user *buf,
-			  size_t len, loff_t *ppos, bool is_signed)
-{
-	struct simple_attr *attr;
-	unsigned long long val;
-	size_t size;
-	ssize_t ret;
-
-	attr = file->private_data;
-	if (!attr->set)
-		return -EACCES;
-
-	ret = mutex_lock_interruptible(&attr->mutex);
-	if (ret)
-		return ret;
-
-	ret = -EFAULT;
-	size = min(sizeof(attr->set_buf) - 1, len);
-	if (copy_from_user(attr->set_buf, buf, size))
-		goto out;
-
-	attr->set_buf[size] = '\0';
-	if (is_signed)
-		ret = kstrtoll(attr->set_buf, 0, &val);
-	else
-		ret = kstrtoull(attr->set_buf, 0, &val);
-	if (ret)
-		goto out;
-	ret = attr->set(attr->data, val);
-	if (ret == 0)
-		ret = len; /* on success, claim we got the whole input */
-out:
-	mutex_unlock(&attr->mutex);
-	return ret;
-}
-
-ssize_t simple_attr_write(struct file *file, const char __user *buf,
-			  size_t len, loff_t *ppos)
-{
-	return simple_attr_write_xsigned(file, buf, len, ppos, false);
-}
-EXPORT_SYMBOL_GPL(simple_attr_write);
-
-ssize_t simple_attr_write_signed(struct file *file, const char __user *buf,
-			  size_t len, loff_t *ppos)
-{
-	return simple_attr_write_xsigned(file, buf, len, ppos, true);
-}
-EXPORT_SYMBOL_GPL(simple_attr_write_signed);
-
 /**
  * generic_encode_ino32_fh - generic export_operations->encode_fh function
  * @inode:   the object to encode
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 85db7dde4778..55fc02b99cf6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3552,12 +3552,6 @@ int simple_attr_open(struct inode *inode, struct file *file,
 		     int (*get)(void *, u64 *), int (*set)(void *, u64),
 		     const char *fmt);
 int simple_attr_release(struct inode *inode, struct file *file);
-ssize_t simple_attr_read(struct file *file, char __user *buf,
-			 size_t len, loff_t *ppos);
-ssize_t simple_attr_write(struct file *file, const char __user *buf,
-			  size_t len, loff_t *ppos);
-ssize_t simple_attr_write_signed(struct file *file, const char __user *buf,
-				 size_t len, loff_t *ppos);
 ssize_t simple_attr_read_iter(struct kiocb *iocb, struct iov_iter *to);
 ssize_t simple_attr_write_iter(struct kiocb *iocb, struct iov_iter *from);
 ssize_t simple_attr_write_iter_signed(struct kiocb *iocb, struct iov_iter *from);
-- 
2.43.0


