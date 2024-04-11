Return-Path: <linux-kernel+bounces-140912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 760558A1992
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22271C240BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A237B1802D8;
	Thu, 11 Apr 2024 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PWSx51rH"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8016B176FBD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849749; cv=none; b=IX7RfIymi53Y5UkGfLiz/GbB1DxDOJ3mSQPsjg2VWQdEx/fe8rRBGaP1lHDmrMkpcjqCasNPWiwG/GQeqLRB5+gkw/8UoEoG1jnVfB78c2ReLjPJ/bm9bHmQwtVRn3qmhEbfvujR42PvKjnYX1fa5bPEzMYvci5mEwUiQWxo+Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849749; c=relaxed/simple;
	bh=MAdYJg7vC80sayVUc6VUMFMQPxg4PDOoBSuAV4FtkDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S24CXo9vQPCvLRDZ5CLMT8FL3mSNRDSm+nKI2TDI63xhgHtVvUEVF+wel3aHSfC8y8JAfZG4TxsEhgZYU6LgbcLCRDVypPivDeC5Y3puLbjV1BsnAECmjkY5xMy0zBHZA9r2ZCWzHACsbU9nb8Jv37DGVEtSz010EfBmdXntAy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PWSx51rH; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170508039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849747; x=1713454547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpJzi3ktCie7A8Der17tbeDtmCXTCdjPxKaVEBIvR+w=;
        b=PWSx51rHnUYDRkVm5ToTvhqz1p18QzRfpGuA9doQjR05QDtOJumt3a18AKEkTUDXdU
         Ams51ylY6TpjHBz7OdqIDMnbzBYd0vmNW/mnc4c2TlYOqUf8VEnbuz0wh4F5qNl1opR2
         1kQbdqe1NcMs1xq82QwYM2Yil+9UDATl6FJ2EBd4aCCzsVY7ulPC5aiZ05TvRqCizo9D
         9fTbyn3+LLGnEo3qT+gnowfgdngY/JiOvXdbqteosjt4Mi5OuMSa0Pq5leuJmQxbRhAq
         wpLs2b3HpfaMkLwoh1pavYvAcuHjNTA6AheyCT8ZEb0nK/lOGk47qU0qZgzTEaDlA9b9
         xv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849747; x=1713454547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpJzi3ktCie7A8Der17tbeDtmCXTCdjPxKaVEBIvR+w=;
        b=iYh6LjbaFTFw161MeBG4EEpEbfNAyaxgKs2iWxXpNxCw8G3+1c56SEnEEW6DXt3bS/
         G7wwsge/fdI2bG+9musMpk7Hd801rBcL49qI+PfUbqnGbvLn+5QmDipIaxtlBNEMWPRa
         q3anM5O1AVJ7zTtzDb2wcpxjCJ73ve4hLsSrEIKdoiI9w1FJsYmM89iN8D1fU1cDs0Uc
         L5jAbzl47XSXUL6BBdoBy9b8ZfO7hwkJ3RiJtT6PH0gHajlMrTNO8amG0GJCa7a+f0E9
         SFU/1mfbG5RvYMxL5RftVLnaJjTl6qZjbeVd6OoLMfoVLqqFN+8VvoK0YesHFI0v6Y6W
         NncQ==
X-Gm-Message-State: AOJu0YxK89L7BGfXYrzuQksnszdvro8zYUJVJLYkRAHyXVTlAXI3WNAO
	/hg3iUZu0mupPZOXmnYGp/HL/nCfko55E5rNMxZBs92Z5GX0x7lQS3i9XxMd/UlE5lUCkTYmS3O
	q
X-Google-Smtp-Source: AGHT+IFLdertjjG+IB6jv3VjjUJfSpBzxjcraSi0D3fqPJYZGO0vzNYxiHAUUkn+dOCGdMFX1bVIhg==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr180282ioj.2.1712849747403;
        Thu, 11 Apr 2024 08:35:47 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 147/437] drm/radeon/radeon_ttm: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:47 -0600
Message-ID: <20240411153126.16201-148-axboe@kernel.dk>
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
 drivers/gpu/drm/radeon/radeon_ttm.c | 40 ++++++++++++++---------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 2078b0000e22..2570babc690c 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -786,37 +786,36 @@ static int radeon_ttm_vram_open(struct inode *inode, struct file *filep)
 	return 0;
 }
 
-static ssize_t radeon_ttm_vram_read(struct file *f, char __user *buf,
-				    size_t size, loff_t *pos)
+static ssize_t radeon_ttm_vram_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct radeon_device *rdev = f->private_data;
+	struct radeon_device *rdev = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(to);
 	ssize_t result = 0;
 	int r;
 
-	if (size & 0x3 || *pos & 0x3)
+	if (size & 0x3 || iocb->ki_pos & 0x3)
 		return -EINVAL;
 
 	while (size) {
 		unsigned long flags;
 		uint32_t value;
 
-		if (*pos >= rdev->mc.mc_vram_size)
+		if (iocb->ki_pos >= rdev->mc.mc_vram_size)
 			return result;
 
 		spin_lock_irqsave(&rdev->mmio_idx_lock, flags);
-		WREG32(RADEON_MM_INDEX, ((uint32_t)*pos) | 0x80000000);
+		WREG32(RADEON_MM_INDEX, ((uint32_t)iocb->ki_pos) | 0x80000000);
 		if (rdev->family >= CHIP_CEDAR)
-			WREG32(EVERGREEN_MM_INDEX_HI, *pos >> 31);
+			WREG32(EVERGREEN_MM_INDEX_HI, iocb->ki_pos >> 31);
 		value = RREG32(RADEON_MM_DATA);
 		spin_unlock_irqrestore(&rdev->mmio_idx_lock, flags);
 
-		r = put_user(value, (uint32_t __user *)buf);
+		r = put_iter(value, to);
 		if (r)
 			return r;
 
 		result += 4;
-		buf += 4;
-		*pos += 4;
+		iocb->ki_pos += 4;
 		size -= 4;
 	}
 
@@ -826,7 +825,7 @@ static ssize_t radeon_ttm_vram_read(struct file *f, char __user *buf,
 static const struct file_operations radeon_ttm_vram_fops = {
 	.owner = THIS_MODULE,
 	.open = radeon_ttm_vram_open,
-	.read = radeon_ttm_vram_read,
+	.read_iter = radeon_ttm_vram_read,
 	.llseek = default_llseek
 };
 
@@ -838,16 +837,16 @@ static int radeon_ttm_gtt_open(struct inode *inode, struct file *filep)
 	return 0;
 }
 
-static ssize_t radeon_ttm_gtt_read(struct file *f, char __user *buf,
-				   size_t size, loff_t *pos)
+static ssize_t radeon_ttm_gtt_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct radeon_device *rdev = f->private_data;
+	struct radeon_device *rdev = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(to);
 	ssize_t result = 0;
 	int r;
 
 	while (size) {
-		loff_t p = *pos / PAGE_SIZE;
-		unsigned off = *pos & ~PAGE_MASK;
+		loff_t p = iocb->ki_pos / PAGE_SIZE;
+		unsigned off = iocb->ki_pos & ~PAGE_MASK;
 		size_t cur_size = min_t(size_t, size, PAGE_SIZE - off);
 		struct page *page;
 		void *ptr;
@@ -860,17 +859,16 @@ static ssize_t radeon_ttm_gtt_read(struct file *f, char __user *buf,
 			ptr = kmap_local_page(page);
 			ptr += off;
 
-			r = copy_to_user(buf, ptr, cur_size);
+			r = !copy_to_iter_full(ptr, cur_size, to);
 			kunmap_local(ptr);
 		} else
-			r = clear_user(buf, cur_size);
+			r = iov_iter_zero(cur_size, to) != cur_size;
 
 		if (r)
 			return -EFAULT;
 
 		result += cur_size;
-		buf += cur_size;
-		*pos += cur_size;
+		iocb->ki_pos += cur_size;
 		size -= cur_size;
 	}
 
@@ -880,7 +878,7 @@ static ssize_t radeon_ttm_gtt_read(struct file *f, char __user *buf,
 static const struct file_operations radeon_ttm_gtt_fops = {
 	.owner = THIS_MODULE,
 	.open = radeon_ttm_gtt_open,
-	.read = radeon_ttm_gtt_read,
+	.read_iter = radeon_ttm_gtt_read,
 	.llseek = default_llseek
 };
 
-- 
2.43.0


