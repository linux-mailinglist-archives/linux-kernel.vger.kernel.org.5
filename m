Return-Path: <linux-kernel+bounces-141143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA1C8A1AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5381F20F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D501EE28F;
	Thu, 11 Apr 2024 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1W7wHpFP"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82561EE28D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850113; cv=none; b=DUWD8xGf0eSjTUTqIhpm4wTGnw9i2k2fv6bVq79ZPoMn0/cecfLrAGCdHEaJnAJGgx/BhL5114d8kJAXSZNL0x1Aam9XBDuRD7e4+wnbbrbdhvVcKyYrS36Z7a/9BJ5WI3lY1XzP+QoP7W0ucrbHnsMIYX3OVvp+v6y53sHCA8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850113; c=relaxed/simple;
	bh=/IeMnqoAFIfNDzyMJoINUVbc0BpFENvhPn2hRx58JlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G176TRFkxwGzy/EILD28XOJJ6yg2zUIgKMREYR+SJ0Isu3HxLUrbB3jm1C/5WcFf6T9aFYhmAqC84vPEOQBwjGsEELgstN712hvCuv/LpTW97leNvHxzHGASJ3IfGZR1byFUlv0uZOoxU5kMfbeHAYNaGa0xPyDGhh3m13Way4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1W7wHpFP; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170638739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850110; x=1713454910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+B46NL6slQO6G9eUPd+J4fVyZNcCFKn3DmWcSn06so=;
        b=1W7wHpFPPSTPrfViPVVBQKCy4X2LTtPsQwBup6ZCTXaPKbeQzlkYQtn5pqOGS1TAIx
         Ylh3JZ5vTJLQ1UyuSrpuhQ/MMEe0wtpSGVIHUBDgdAD48JtQMLq/+bcRTKdpxIKSVx2+
         DhVWQvxsXoWVCeBs2NwcvaFnfy+2zsWpnFz455ht2MQC9ScnEdH/58Ebv//NVzj+0lcO
         sQnmCqOMBpQn76Q4W/zK8CfMBmbhWQsjaUDVsdErebt6sPJprKdJ/qLY7FlUC+GleSSl
         dOBqPrpl7NIPlKZzj7nuHShQrOidT0BssHeE7jvOHCv+6DSNb44BPbiXGZ913jw+8b1x
         tqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850110; x=1713454910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+B46NL6slQO6G9eUPd+J4fVyZNcCFKn3DmWcSn06so=;
        b=bESF9wrXWZl8bvTZTJW0gw08ZuH34OyTFNl6oVBsVAu9wvxaqiAQdsJ2PqpG4sRGV7
         2BOhM0vDEre3VYtyxBiGi6tRXp18wRv46FE3xHleA2DdKoobhy2VPYx6EpBr0NGciKHA
         ikhFSgLw5LlFWzUW/osjpnYGXAjAwJoENdMOmAd8Qu0fCReCtyW4s6KZVARg6TVcjLgF
         mgm06hDCZSNLyav0GOk00O8Dt+ugb9v0cyZ1jrf9bcDAkC9zkahNlyMkVmcER++TlYDX
         D42MrefTL1T/jdsouQm3TcVGfQOoQDBWkyCox+tVt3VMf4f9q4tLWPhJtB1vLlP8HPdn
         VFhQ==
X-Gm-Message-State: AOJu0YwzqxcLCS+EraETDRky1HL/7+jsFgKMKHSLbAkUAdYUl1BhP0QP
	rbLHxx3580gH7sm26deQl9NLBG5nEc/NnyPCPVCb9o/LCf4VZRiqM/HGskCLUOx42KFiHatM3v1
	P
X-Google-Smtp-Source: AGHT+IElzNKvtjTscFFzikASYFa9gNQ4da0wwnnrv18prBDPykfkz6ro7LCyNcqXhqtvk5Zii0J/QA==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr31549ioc.1.1712850110604;
        Thu, 11 Apr 2024 08:41:50 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 364/437] hwmon: max20730: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:24 -0600
Message-ID: <20240411153126.16201-365-axboe@kernel.dk>
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
 drivers/hwmon/pmbus/max20730.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
index d56ec24764fd..9b0c6084cf12 100644
--- a/drivers/hwmon/pmbus/max20730.c
+++ b/drivers/hwmon/pmbus/max20730.c
@@ -104,11 +104,10 @@ struct max20730_debugfs_data {
 			struct max20730_debugfs_data, debugfs_entries[(y)])
 
 #ifdef CONFIG_DEBUG_FS
-static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
-				     size_t count, loff_t *ppos)
+static ssize_t max20730_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int ret, len;
-	int *idxp = file->private_data;
+	int *idxp = iocb->ki_filp->private_data;
 	int idx = *idxp;
 	struct max20730_debugfs_data *psu = to_psu(idxp, idx);
 	const struct pmbus_driver_info *info;
@@ -292,13 +291,12 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
 	}
 
 	len = strlen(result);
-	return simple_read_from_buffer(buf, count, ppos, result, len);
+	return simple_copy_to_iter(result, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations max20730_fops = {
 	.llseek = noop_llseek,
-	.read = max20730_debugfs_read,
-	.write = NULL,
+	.read_iter = max20730_debugfs_read,
 	.open = simple_open,
 };
 
-- 
2.43.0


