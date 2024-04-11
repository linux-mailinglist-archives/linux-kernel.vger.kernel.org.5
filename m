Return-Path: <linux-kernel+bounces-140764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803238A18D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3720F281B35
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB583716F;
	Thu, 11 Apr 2024 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="g/tCYKRS"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26A42556E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849504; cv=none; b=f1mMsiBTNPdcFUBor+uEY4ifQkD/mnep5GIME1ss08jClEexuPa/aX0frvsXN+tz+GB6sIktd0/Zq8f3qEm9/0OvGJOCG56Sjk/qeuItnQB1xB1xtzS1JMqKdVLDKuwwWnyxQv5vS6Mmkm+TajVC3yUqLYYdfln5YCP6AQPSY4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849504; c=relaxed/simple;
	bh=TZBv3QxQEHQifRazqOUvpuU1rG3ph2R3aVTk3X9Gap0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FC3ja+bOI/8MrL0JWdXuo7U104SDrTlJFt+M4sISxIvkz81Xss2Qs06js7k8BrFecdDBY3B8Rvwy2d7hqV1j3O1xXvOOZZT4ES9E7r4v86s2z0ZPvAVM0EU7MaXw1Q4/4g/uKjZ+CtLJj2B/95eiddZXwDk3AOMEHAbNUozGp+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=g/tCYKRS; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso180583239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849500; x=1713454300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnTaAM7cR5Yq5Ow6bam+JWxgxFhkDbGidFejqzVzbL8=;
        b=g/tCYKRS4Gmfowos5Xy4WF98hwrGj8aGi010fS5yC/rsdTDOylQ27kAm8iIJbLmSgT
         97NFfrnsiLt8MEnEv06QwYmaYxMn63YmHeXmTcSOjyD1AOCxwaBgjwt/1bgCoGF2fkoB
         m8l+PC6DyjdMEYFtWiU7f/GqZpn7pE5hu3rdgpzV8hDbSDrKL+Yy/Q7L8tfskMKu1MK9
         h7G8URRWolNkqw/UdZw+eV0Dbpb1BEDfrK98uHBpaem5fEEgMHrPNiyGUjlp53amjzE+
         +5DeFIdg+2IKw0N/yH0EUoi1kXe8CNUAj5BE2W4tRKOChduX9+qfoaO5MHaOrA3+9AcD
         kFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849500; x=1713454300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnTaAM7cR5Yq5Ow6bam+JWxgxFhkDbGidFejqzVzbL8=;
        b=drHNVq6J5byvSpiUdO6saZuZ/1VYRBY5RZl8dcZJfuFaAwtnjE8VkJnhDNnVj7pAs/
         W64ECY3YGrvTojHFHaRRylX98fayzZCEu8MHItAUlgFzFwi9JvstUH+v5XvFJG8zOA3J
         I91ucJitz7J34z5mINo4K65cqbshfui/6uzasH3+fdMtwZFPaRPFAjaCyim4MYxfJaDw
         xQHrVhjjpVbi9YuUKoEcMbTJwATxRzyjht9SzV403T+8e7wTpZhetLiVusSqtYRpkyHM
         s/VI3CNoRyeGdHzc7/51uDxCs4tkU6fCNAs7f5yA/VDDxouoKK8o3vHMoeZSIpPeB4NG
         7hlg==
X-Gm-Message-State: AOJu0YwaGN9GiE08NM20IX6bhNVXfAsXSWwT//SoXsDs4huco//EcdBr
	OGJyn8zUlj3nuz4Lr/xEioNOy9q4tZHheLfV32cR3sWvWQtPy5Uzz8YVNA4ktrh41eDpJe/+ayI
	G
X-Google-Smtp-Source: AGHT+IHCYhbVjeiN6ZbVGZ5FXT6s+PbBwUNcZSjkCcgCxerd5TEJ92G6njbB511lBWV6yPsPhU9+ZQ==
X-Received: by 2002:a92:c56f:0:b0:369:e37d:541f with SMTP id b15-20020a92c56f000000b00369e37d541fmr6975632ilj.1.1712849500395;
        Thu, 11 Apr 2024 08:31:40 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:31:38 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 007/437] mm/util: add iterdup_nul() and iterdup() helpers
Date: Thu, 11 Apr 2024 09:12:27 -0600
Message-ID: <20240411153126.16201-8-axboe@kernel.dk>
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

This is identical to the memdup variants, except it operates on a struct
iov_iter rather than a direct user pointer.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/string.h |  4 +++
 mm/util.c              | 57 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 9ba8b4597009..1983d2bf8840 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -18,6 +18,10 @@ extern void *memdup_user(const void __user *, size_t);
 extern void *vmemdup_user(const void __user *, size_t);
 extern void *memdup_user_nul(const void __user *, size_t);
 
+struct iov_iter;
+void *iterdup_nul(struct iov_iter *, size_t);
+void *iterdup(struct iov_iter *, size_t);
+
 /**
  * memdup_array_user - duplicate array from user space
  * @src: source address in user space
diff --git a/mm/util.c b/mm/util.c
index 669397235787..5d701cf693b0 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -224,6 +224,32 @@ void *memdup_user(const void __user *src, size_t len)
 }
 EXPORT_SYMBOL(memdup_user);
 
+/**
+ * iterdup - duplicate memory region
+ *
+ * @src: source iov_iter
+ * @len: number of bytes to copy
+ *
+ * Return: an ERR_PTR() on failure.  Result is physically
+ * contiguous, to be freed by kfree().
+ */
+void *iterdup(struct iov_iter *src, size_t len)
+{
+	void *p;
+
+	p = kmalloc_track_caller(len, GFP_USER | __GFP_NOWARN);
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+
+	if (!copy_from_iter_full(p, len, src)) {
+		kfree(p);
+		return ERR_PTR(-EFAULT);
+	}
+
+	return p;
+}
+EXPORT_SYMBOL(iterdup);
+
 /**
  * vmemdup_user - duplicate memory region from user space
  *
@@ -312,6 +338,37 @@ void *memdup_user_nul(const void __user *src, size_t len)
 }
 EXPORT_SYMBOL(memdup_user_nul);
 
+/**
+ * iterdup_nul - duplicate memory region from iov_iter and NUL-terminate
+ *
+ * @src: source address to copy from
+ * @len: number of bytes to copy
+ *
+ * Return: an ERR_PTR() on failure.
+ */
+void *iterdup_nul(struct iov_iter *src, size_t len)
+{
+	char *p;
+
+	/*
+	 * Always use GFP_KERNEL, since copy_from_iter_full() can sleep and
+	 * cause pagefault, which makes it pointless to use GFP_NOFS
+	 * or GFP_ATOMIC.
+	 */
+	p = kmalloc_track_caller(len + 1, GFP_KERNEL);
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+
+	if (!copy_from_iter_full(p, len, src)) {
+		kfree(p);
+		return ERR_PTR(-EFAULT);
+	}
+	p[len] = '\0';
+
+	return p;
+}
+EXPORT_SYMBOL(iterdup_nul);
+
 /* Check if the vma is being used as a stack by this task */
 int vma_is_stack_for_current(struct vm_area_struct *vma)
 {
-- 
2.43.0


