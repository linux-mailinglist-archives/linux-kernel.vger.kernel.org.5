Return-Path: <linux-kernel+bounces-141211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C7C8A1B02
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E2E1F27DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07C32019BC;
	Thu, 11 Apr 2024 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JFUSXYks"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93441FF314
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850214; cv=none; b=AY9VP8GoY8crvRqeN2Z+tWqYlapqc1huWDfjHI9guZbhMGuFHcuZEz+4bb1wSoYRgGbtRFDaMjidIx1MLQIF5CilEWVu5wLcT2bOEAHScRc4VTYV6FTK1in4BXkItU+0jvn4jDdWCCNmERdZuDnflHMz+YT0qAPD9lmSUv5tWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850214; c=relaxed/simple;
	bh=P44fp7vc0gaZmTJDo8vBE7V6YpVr5Grh+PeAKrzTHE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgXc8l4p7acZqaK14DOQEk9zdITIsW+oct5H/QXcHWDnzYnW7m1bZM1VpQZ8bMZoLwtQf8DDUdg3cBNT/D8oU8BW2+IQ1/TgY6z2Gos4+Le/tXq0qJ4jTv3pywmWkDz5kXLUjZ8QU6D7hzNVNEV8+R7IlG5Hk8tMKd3yWsFIFrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JFUSXYks; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9117539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850211; x=1713455011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0d4z0rG2TbmIYkwYbQvTZP3vRG6ldHYDLWi2vHqW7g=;
        b=JFUSXYks8KqAKF4G1cXe6kOZntZ/xBs0/yuN/RRUPhRkDFHWTzhGMMnOOxXsRmKFRv
         AjZvyiEKF4VPbH/ZFOr0IO+/pRG5tQwS+qL/9oCjxFEf0D8FgNVDrRC6UXJZEotr+Fdj
         4r7yBh6R832/0PSRuhriVEjU3EKZ+zIWaAOZqCbYrMsY7HZdSmfmbwxi/Hy2D0bCCwGa
         05WagL8uMTD8wnbEvTWBwj7gQGm8dR9ZaKaytXeuBravVVQLlL9zQsoQznOSirZ5uA1l
         WwHpEzzZo/ImoCSvZW7jtfmULDX8lFyYrSWaBsgRPd7vxq8qZuSEGSCeIArBoXbneLKb
         GMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850211; x=1713455011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0d4z0rG2TbmIYkwYbQvTZP3vRG6ldHYDLWi2vHqW7g=;
        b=ISsnm84rKVbiDq543hU1tWD3Jd+yUvtH0NXwHkelhnT3dDn8hQdCUT4mS9UPI4VC5k
         nslePJnVFtdQxHxbJ056lO5QrGICWa/A1+TCy6nNwtDc2Q3jObis1e0xj+CfNQmJG5PW
         sMgnchS9CXkZ0vv5Uxsx2SvkZC/99U3Q9IHLkFChHje/sNiL12ffcOSINDPuROgKHFBO
         Adi53KRys463vDuWgMf+VBc4zNaWGjtOA+RM9lCC+snt/me7u6C6tUrKhPyLYFAYqgSa
         CfvV13c01m7stSoUSxEUyU2z+e0gcK++TByLxyf00UcAHlK0mG2x0fndlEj5T1zlk1Ms
         GlyA==
X-Gm-Message-State: AOJu0YweT7bAWA9GZp8XC2GXklB+AIwzDHD9pDR0gXBx0PyHaAOUB7fY
	sEKX5Hh0NaM9/OuccoNdciWVRVGZf+O6NhKqRK2ENTY63PXZKuewIJRzLbttWdIkh4W0M/Obz1S
	W
X-Google-Smtp-Source: AGHT+IGjq3rE+zn5l/ki3tM82dsmkAKJ4A5T/+zNhWElI6AC54XCy50wGg1hdzk1G49r6aKURX7Nkw==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr201129ioj.2.1712850211694;
        Thu, 11 Apr 2024 08:43:31 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 425/437] media: v4l2-dev: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:25 -0600
Message-ID: <20240411153126.16201-426-axboe@kernel.dk>
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
 drivers/media/v4l2-core/v4l2-dev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index d13954bd31fd..0ebc049fe333 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -318,6 +318,7 @@ static ssize_t v4l2_read(struct file *filp, char __user *buf,
 			video_device_node_name(vdev), sz, ret);
 	return ret;
 }
+FOPS_READ_ITER_HELPER(v4l2_read);
 
 static ssize_t v4l2_write(struct file *filp, const char __user *buf,
 		size_t sz, loff_t *off)
@@ -335,6 +336,7 @@ static ssize_t v4l2_write(struct file *filp, const char __user *buf,
 			video_device_node_name(vdev), sz, ret);
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(v4l2_write);
 
 static __poll_t v4l2_poll(struct file *filp, struct poll_table_struct *poll)
 {
@@ -472,8 +474,8 @@ static int v4l2_release(struct inode *inode, struct file *filp)
 
 static const struct file_operations v4l2_fops = {
 	.owner = THIS_MODULE,
-	.read = v4l2_read,
-	.write = v4l2_write,
+	.read_iter = v4l2_read_iter,
+	.write_iter = v4l2_write_iter,
 	.open = v4l2_open,
 	.get_unmapped_area = v4l2_get_unmapped_area,
 	.mmap = v4l2_mmap,
-- 
2.43.0


