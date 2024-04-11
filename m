Return-Path: <linux-kernel+bounces-141034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C118A1A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35479B2CC03
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34281CCF02;
	Thu, 11 Apr 2024 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="M15IK9YL"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5371CAE8E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849936; cv=none; b=l3pCgGpUwXHhiUQ1vrKyUx1he7LabMSnhXf3xndKi1Bp+dOxH4ZZtnc7LUz9fCGcgLWj8m4+QcI4gGbkFatJe8uglyVT05Xh1jt+rqS2r9T3fHEO99twxiFJHZgnjvbRmIdOG7itM07ZRDCg3ozBgBltaMA0GyilD53L3g57EYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849936; c=relaxed/simple;
	bh=D1i61hy/OGU/BxDFd2yZetRX2a3LrZr04fgGEwdIAKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFsMQNNJdpBtvtt0QJOvpQ0w9QtH9hoBawgMEaRr+0jwxE9LYMfqHDSMrQfm0y1AH9vFZaTjkPwb1QDwtPKgruhuarkhV0aBetANsOTS9GFi1qfow5V8oHwxJAaZA+ZCkoJnUxUdYbI8Xe0xjO+BHWk1tu02dDb++19ZwxhjvCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=M15IK9YL; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36a34b68277so114915ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849934; x=1713454734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82ju2a3lzjB0FXBKzrCXQHn/nfbrPYZeNscDq2Myhhs=;
        b=M15IK9YLVmZx03KmTRz+xlghs8Zkl4HiDUbxVotfWnOtI1Iwy7bVrtRnfFl5aCA2y+
         0yaWW5+10at1Q5HKKKhjkJEPDn+FT+8Mly1fBEwcE2kItFOEI8vxfeWPz+N6jrDWegcg
         odAqc9Cd2jOG7UbdhCOM+5PT8hruc2okxIE4OtJYJm571hX6e44IrcXUZTH1I2+Vbo1I
         uvleAyw2VfZ0i8rMH4Peq3W+MPAe9NoQJ0DcxAYyP3O4W8ECyIftZ6H/VjfuLBT+e1Mm
         DTmm7u+A0N+yAjHI/Ue4inZDVtSq7eQJffufSSWEfG+WGg7bF1QFLKrObOxm3WaP2pg/
         e+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849934; x=1713454734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82ju2a3lzjB0FXBKzrCXQHn/nfbrPYZeNscDq2Myhhs=;
        b=ICRp3qHV5GKNdd7o04NWPtXNKUsN8Ld8iQhi1JxLmA0cmcc3HbhdXikjybt3XsG3Yd
         TRERlgGtdd3K/cLFXezCLRaySuOwsB1/rBgnClcm7nn7gqNS9UVWsCuLwvzjWCz5TkA4
         Mg7Nh8tM6NTFnAaWUJHbQ5QDPXAjQQmkCBICbtCSVokyu46BSyOk2R+VYgkG0YZOznc3
         S/94R3QXLL9IPHHfAM3760nw7upTHeTJra4PAgbyW417+Ujv4YAuo4OzKMsAN3aXN+OS
         x/DiPc2+mTivUQMGBCnj5A1zerEHTWQIcOYu5zCX5xfKAIwgTq6Bx94x5uYibgKzIaCf
         CDbw==
X-Gm-Message-State: AOJu0Yz1lDxt1mLf+NiKPV6rB6QWP1fDsydocj/+7fZVxHK8hx+g/zT8
	kC1pj+npDSVAg+a2PDnHENVP+ZmoYFxoeuaaI6iiEnYPyl3VHjOqsC+4g6t5SHyQjY9B02mMf26
	4
X-Google-Smtp-Source: AGHT+IEiFHbMRIsw76oJgyHlTtQXP12zhA8SJ3cGwX31ogb/WkTO9K48efPQt/2SnzGra+rAecxXiQ==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr195274iob.1.1712849933788;
        Thu, 11 Apr 2024 08:38:53 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 260/437] watchdog: w83977f_wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:40 -0600
Message-ID: <20240411153126.16201-261-axboe@kernel.dk>
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
 drivers/watchdog/w83977f_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/w83977f_wdt.c b/drivers/watchdog/w83977f_wdt.c
index 31bf21ceaf48..2b9a8920ac2c 100644
--- a/drivers/watchdog/w83977f_wdt.c
+++ b/drivers/watchdog/w83977f_wdt.c
@@ -324,9 +324,9 @@ static int wdt_release(struct inode *inode, struct file *file)
  *      write of data will do, as we don't define content meaning.
  */
 
-static ssize_t wdt_write(struct file *file, const char __user *buf,
-			    size_t count, loff_t *ppos)
+static ssize_t wdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	/* See if we got the magic character 'V' and reload the timer */
 	if (count) {
 		if (!nowayout) {
@@ -340,7 +340,7 @@ static ssize_t wdt_write(struct file *file, const char __user *buf,
 			   magic character */
 			for (ofs = 0; ofs != count; ofs++) {
 				char c;
-				if (get_user(c, buf + ofs))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					expect_close = 42;
@@ -444,7 +444,7 @@ static int wdt_notify_sys(struct notifier_block *this, unsigned long code,
 static const struct file_operations wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= wdt_write,
+	.write_iter	= wdt_write,
 	.unlocked_ioctl	= wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= wdt_open,
-- 
2.43.0


