Return-Path: <linux-kernel+bounces-140880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E1C8A1968
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55C52B2FBD0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C23153BC4;
	Thu, 11 Apr 2024 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3PkB2dYF"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8304915380A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849699; cv=none; b=JmwFifNB+WZ2n7miPO7QyQ/lG5gaySreQkvemqM5rxTMXKjZ0z6NjlTtfBdG0tWSziKzm4X0nTZWFZMp0qcI1db25+p4ZmDwzsczK08rUvjT0VvnvX3YN4GcPYdrQWMZW2cgW6//fhpUAZtF7MWtQPr++ZkGUumTCqx9uwqcZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849699; c=relaxed/simple;
	bh=1GLmpfIFqA5S0RQqXLieN4KD9l3gdVC3UtaGZNcIIhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0Il5Ow1UFmnpPbXNcqAi3mMge8KdOiWSCvficFktP5o0Ak5xGOjvK60hpGC0i7Coe44xErwyfcb0tlkF9MTLecLN5znmWIv3FaghnNJRRH71RggcRzfp2ML88aNO4Qek+Jhm22GxmVv5wocXwW0/7GO2CEyq4VYP8a7y9paRbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3PkB2dYF; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69543439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849697; x=1713454497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLnb1KrtQmeOhT6FF+w9hR8jXQ2bjsSrQAHPvcNxMrA=;
        b=3PkB2dYFK95dn2C3UZ9JXq5zjb94c7PEsUQxOFkHpdlwQllixLAO3seXLn3rKlVyaO
         xijwoYg/w6h2lMQSHb9r9S8Y3G3pqQYoADFkD0HM8L5rwgGYGg3P3tt2Syc/o1XweLta
         nvmRQ0Pggtm4e2i0VVBmXG3uN+zke36l9AbmXAjGUkuPK/OgoygU1t6Ov/46HroYfez0
         OkN16P2TLQoZA4Mjbr4vkeTuLXvy8Wjuio70TPBsVQzwl2WlbxFHeATZhRJh5bSfliYA
         vIKBiCtmgdtG6oaRSHezevwVw+1GvB4IBTHB4jyPP7slJW9d7Kinlu6xpJhKGCCXfMHX
         9D7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849697; x=1713454497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLnb1KrtQmeOhT6FF+w9hR8jXQ2bjsSrQAHPvcNxMrA=;
        b=V9zkpBNbx7PIDPzFr0N9R9pZYnxghfyTDJC+TITbIpB4IV8KltqQZjnnqAhyt8H0T2
         GuaQK3QutcUzvAvqe/uJoFy2Ry8Hdk6/DL2XWLNsHSgNtW6D3GbuD3EjdzTRdkwtyOM8
         29964x3DWDpAM0faBz1NX/rUPY7tJ9Tzk8SWrlCA0poYvwnW+KQ+BL9Didg517/VL2pm
         jCLPi81iiM9eglvj4zpQ4VfhDLoHEbkDyXPwuEQ0MnvuCES7RZhAwpr0w5OkNQ/Mg+vD
         MeQ3LJMeAnbg/mICZznfWWnSAgXk/vb7l4xQ5SBY21xRRKzlCpIRZsIQnfjkchRT30A7
         oirw==
X-Gm-Message-State: AOJu0YzzHzJBx6H6OZFbxJO4/AF68vTDpE8yEXS1YZpxOef5MZvi4LIn
	hOrojXu+KUrJodTeQ51OJEz4+c6BY9XxwNA/k2UJBlexuLmDjd/pZB3SdR/E6qKeqnwbWseKJZs
	t
X-Google-Smtp-Source: AGHT+IEZNAUK0YwIXcMKGCIZ3RgU+Nz28oCZMyP0wW8lWFDd9u+rUTZkMHOqRLNlxWrFP6T+U81ybw==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr38301iob.2.1712849697423;
        Thu, 11 Apr 2024 08:34:57 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:56 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 116/437] drivers/counter: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:16 -0600
Message-ID: <20240411153126.16201-117-axboe@kernel.dk>
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
 drivers/counter/counter-chrdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
index afc94d0062b1..f2d513248120 100644
--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -99,6 +99,7 @@ static ssize_t counter_chrdev_read(struct file *filp, char __user *buf,
 
 	return copied;
 }
+FOPS_READ_ITER_HELPER(counter_chrdev_read);
 
 static __poll_t counter_chrdev_poll(struct file *filp,
 				    struct poll_table_struct *pollt)
@@ -455,7 +456,7 @@ static int counter_chrdev_release(struct inode *inode, struct file *filp)
 static const struct file_operations counter_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
-	.read = counter_chrdev_read,
+	.read_iter = counter_chrdev_read_iter,
 	.poll = counter_chrdev_poll,
 	.unlocked_ioctl = counter_chrdev_ioctl,
 	.open = counter_chrdev_open,
-- 
2.43.0


