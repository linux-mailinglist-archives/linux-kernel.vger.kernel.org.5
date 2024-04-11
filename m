Return-Path: <linux-kernel+bounces-141137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205C28A1AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBD028C7F6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594861ECE6B;
	Thu, 11 Apr 2024 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="owFm2kNH"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7616F51C21
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850103; cv=none; b=cpBZxtCYgMKp/cLkH1dNO4z0dIGMPqFBhxkMeNPuUE9/btE3GZYt6EBAqVYRRWrz8CIxCPollM79kGH8KvXy/g8Sv9N3TznNAkTS682i8hQYyo8VIZYF6j8UZj2P4R4e4Q4lkJyiPFWRQupPnU87tM5v+HeiYydCrMs8cEjNOek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850103; c=relaxed/simple;
	bh=ojbnloJYVO4ehK8CMeeqy7PmCoHDvIpXm4TvHz9u5Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byjO/j/UcPnNktdMxMVa1tFanEpAYaY0emy94hXmscILfTs5r8DHxrFCCTidsShQzd68csPDiadpo4XJPTurITAWv6BtDe9avwvLOoYyVOrRHbomg7yFkk/6+MKR08DNa0mrTgel7IiewI7N+mRyAsleBLduv7QwAE0MvV/36x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=owFm2kNH; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9917739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850100; x=1713454900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHg/3S6NbCQ02OFZAWNiLhmvhUCnFDNl1Jg+mlY3jqs=;
        b=owFm2kNHo2C3gw5H5LbunGtn21+FJrkEJpyadxXq56ElQuqe/gRGKZpr7UAdToHkl/
         oXLOB4XQGMqr5VUa5Go6PkKkmHIDrLErK+FOuTwnwND2R34+BrhW15PlvwR25fhaAtEi
         NxdrC0j91Qu4FjhKMk98+M1/F3IRZfX4tRxfBQADiDJVq7aQ/4xHII2P7skm0W/jNBtZ
         ZuOpkzZ5LdjnucYetUy55/7I0VZHR6SpkLuEgm+Up4KHlyp0Q2k9ViVohWMIz2ksYlvZ
         SjMU7JiFwgFwvBxeiMWBPaZDNlEOPgq6D8jCyLUeJs92SDXpDs5XA2daV2Fy1t+52d6i
         4u1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850100; x=1713454900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHg/3S6NbCQ02OFZAWNiLhmvhUCnFDNl1Jg+mlY3jqs=;
        b=VDAu1Tsuj+CJl5ssXQgyCPvUnuwkCigVhTYgMacIyVvf911wqax467x9/pA6dPR3FK
         4cTCUzC/JTvnT/V4TKDgxthgjyrgl/27poaihwbMPhwSwYrQGStOef+F5UYlzVUxC6qc
         TPa27DF3A2AeUrr8QtXV9+38syLzuGC6HkwtfU2mbrAhI/sXP9GkSFWJuT2Hd5i4CVGo
         HEik6jon0IWykzjCP3FdN9WZWfS3dC0+fF9vC+/1vSTjwH+BAvDHBylIYkXayAcFPmnR
         EZ/Wokne+dzOitD/OIZ/1FOzpwxhdd3p6NfYJMfGlCizECzld+dDjCKtoTyWmRYT9m57
         878Q==
X-Gm-Message-State: AOJu0YzEtj5b0PAdSVrQwP+e5164zlT1kb8emLFz1QMWxCR+a3yDUH2C
	ws0hWor4At+YdL6EAsXQHvQWP/Vms5FGyIgAaO9/UY0nieDjhR1+GaxDGH55AgwjnnjykdVoswc
	G
X-Google-Smtp-Source: AGHT+IFwlc0vOCM4GsRHaMFAKyi8dXWNVHNwCiYPdcjLedTXng5GM8K4pCdDLbZ72NKEtXeZ5VqSaw==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr234266iof.0.1712850100112;
        Thu, 11 Apr 2024 08:41:40 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 358/437] hwmon: fschmd: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:18 -0600
Message-ID: <20240411153126.16201-359-axboe@kernel.dk>
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
 drivers/hwmon/fschmd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
index b30512a705a7..896a073811a0 100644
--- a/drivers/hwmon/fschmd.c
+++ b/drivers/hwmon/fschmd.c
@@ -848,11 +848,11 @@ static int watchdog_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static ssize_t watchdog_write(struct file *filp, const char __user *buf,
-	size_t count, loff_t *offset)
+static ssize_t watchdog_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	int ret;
-	struct fschmd_data *data = filp->private_data;
+	struct fschmd_data *data = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 
 	if (count) {
 		if (!nowayout) {
@@ -863,7 +863,7 @@ static ssize_t watchdog_write(struct file *filp, const char __user *buf,
 
 			for (i = 0; i != count; i++) {
 				char c;
-				if (get_user(c, buf + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					data->watchdog_expect_close = 1;
@@ -951,7 +951,7 @@ static const struct file_operations watchdog_fops = {
 	.llseek = no_llseek,
 	.open = watchdog_open,
 	.release = watchdog_release,
-	.write = watchdog_write,
+	.write_iter = watchdog_write,
 	.unlocked_ioctl = watchdog_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
 };
-- 
2.43.0


