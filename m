Return-Path: <linux-kernel+bounces-141149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAD78A1AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B901C20F17
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBC21F01B6;
	Thu, 11 Apr 2024 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1VdAh08G"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0EF1EF53C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850123; cv=none; b=fQDTjOi4qQTbNAHD3to+vaDzLzqz04+dAZlALfZpE+zA56BmaX1sm+pX57KiO6Q6WE9lUs0cRSBAtosjInIhakTSddwgOL3mxS17s+h8hcOn12Et4d8Kq6F/FEHhl8rVHC4BV/K0r7yLj+vtRpqBYaEX1gM0Be1vU3aVIf/FWHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850123; c=relaxed/simple;
	bh=iRh49+5OkxCbqpZ3XI8G42DxgL1Hmu+w12M8sdxKXlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODnZpD1oFbs7QZa7v5bcc5heWY1TSk5kISCRCdfFwdEbpLcsXZXbnLBdTqShRSQUgVJrgjYysMcdWYCPPIdLG81Y5HWPGR/4fwwDY2EYS+5veJyvPrLiHswBvl2Nqy55LchIGoyAR3rm5/u8nKk+JjFcYma6ctZzKUfVesW/7I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1VdAh08G; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9086639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850120; x=1713454920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFfR7rnk37eY+kj40RhuQFhYiRlfBiirVwlFZTavQ+w=;
        b=1VdAh08Gn5IoeaFgRBpBaHGinv6l0YgH7oSquQr5YE/3Gl7XKtCqkV/sv+qgO6ENM1
         MyKLS4rx8kU3Kt3kSrND5sIT6T2UKx+kvC5Cs1B4tyiALF3jxUsgnXfVXwO3781z8OeW
         r3kUplr92pGXcyWGA4RUowqtD4Z6EgcTaevdwNFQ9RajCqck8727SYElasZetCDrgakl
         uGRUWqTfm/xpCLYqbVy0jmyUsULohizcmdIPD4V1cFcL8gUhtnGASNF8nE1iZRR0nR7k
         zB7Y05/4LRLIg0mmEJvykecooVjJ0ljDfkx1Lvu/28APcZ19Q5BtnYC8nm5P24FoVdde
         IzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850120; x=1713454920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFfR7rnk37eY+kj40RhuQFhYiRlfBiirVwlFZTavQ+w=;
        b=pqFTrCWenEzlE0YnLLFsLlBNAkCMC03CSdL6bHsm+NywHObqbauTfcHdYWjEs8Vip4
         yofkGhbcjw/XJEaSEPqO5hQRPGXetonbQ/wKBkkkuGpLIcFqVMIZ+w56Z414BhA3Kddj
         nGcDC0LiBUNnIZNREBack5Kss6uY0yFK+REauLUYa5BoOxQ7WWTTWE8cw+3uxiPeJ4Jm
         S9vhOBR53zBAwGOCLE6RKxWniBhq80UL13QMNln3j0SsdbvxW5HH90RHkXMMqANG4Yvf
         0Yu1PsvSr6M2fA1o9rt5xO1npmnH4nkDS4jgn+HtYkRbGDvEb32MKPdKFF2Cvnsemp9/
         nlUQ==
X-Gm-Message-State: AOJu0YweMB3wAFrfMU6oYFCvj7SMzUaeYCL03k059nO7hkhe+JDOddF/
	Q9Q1dYqUbIfQeAulbqB16OXC6sDE4UJHk36QKPkxCGRCI/4uMkvz6DMiVnfiZmKAHxYAc++bN33
	6
X-Google-Smtp-Source: AGHT+IEKusgxFsZviB42sX7w8qMc/9bpnqRiAigAZhLfBu54VqsupGZGe7VZFd8i52j6/721s9KOsg==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr196484ioj.2.1712850119657;
        Thu, 11 Apr 2024 08:41:59 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 368/437] hwmon: pt5161l: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:28 -0600
Message-ID: <20240411153126.16201-369-axboe@kernel.dk>
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
 drivers/hwmon/pt5161l.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/pt5161l.c b/drivers/hwmon/pt5161l.c
index 60361e39c474..90cb27822ac0 100644
--- a/drivers/hwmon/pt5161l.c
+++ b/drivers/hwmon/pt5161l.c
@@ -493,10 +493,10 @@ static const struct hwmon_chip_info pt5161l_chip_info = {
 	.info = pt5161l_info,
 };
 
-static ssize_t pt5161l_debugfs_read_fw_ver(struct file *file, char __user *buf,
-					   size_t count, loff_t *ppos)
+static ssize_t pt5161l_debugfs_read_fw_ver(struct kiocb *iocb,
+					   struct iov_iter *to)
 {
-	struct pt5161l_data *data = file->private_data;
+	struct pt5161l_data *data = iocb->ki_filp->private_data;
 	int ret;
 	char ver[32];
 
@@ -509,19 +509,18 @@ static ssize_t pt5161l_debugfs_read_fw_ver(struct file *file, char __user *buf,
 	ret = snprintf(ver, sizeof(ver), "%u.%u.%u\n", data->fw_ver.major,
 		       data->fw_ver.minor, data->fw_ver.build);
 
-	return simple_read_from_buffer(buf, count, ppos, ver, ret);
+	return simple_copy_to_iter(ver, &iocb->ki_pos, ret, to);
 }
 
 static const struct file_operations pt5161l_debugfs_ops_fw_ver = {
-	.read = pt5161l_debugfs_read_fw_ver,
+	.read_iter = pt5161l_debugfs_read_fw_ver,
 	.open = simple_open,
 };
 
-static ssize_t pt5161l_debugfs_read_fw_load_sts(struct file *file,
-						char __user *buf, size_t count,
-						loff_t *ppos)
+static ssize_t pt5161l_debugfs_read_fw_load_sts(struct kiocb *iocb,
+						struct iov_iter *to)
 {
-	struct pt5161l_data *data = file->private_data;
+	struct pt5161l_data *data = iocb->ki_filp->private_data;
 	int ret;
 	bool status = false;
 	char health[16];
@@ -535,18 +534,18 @@ static ssize_t pt5161l_debugfs_read_fw_load_sts(struct file *file,
 	ret = snprintf(health, sizeof(health), "%s\n",
 		       status ? "normal" : "abnormal");
 
-	return simple_read_from_buffer(buf, count, ppos, health, ret);
+	return simple_copy_to_iter(health, &iocb->ki_pos, ret, to);
 }
 
 static const struct file_operations pt5161l_debugfs_ops_fw_load_sts = {
-	.read = pt5161l_debugfs_read_fw_load_sts,
+	.read_iter = pt5161l_debugfs_read_fw_load_sts,
 	.open = simple_open,
 };
 
-static ssize_t pt5161l_debugfs_read_hb_sts(struct file *file, char __user *buf,
-					   size_t count, loff_t *ppos)
+static ssize_t pt5161l_debugfs_read_hb_sts(struct kiocb *iocb,
+					   struct iov_iter *to)
 {
-	struct pt5161l_data *data = file->private_data;
+	struct pt5161l_data *data = iocb->ki_filp->private_data;
 	int ret;
 	bool status = false;
 	char health[16];
@@ -560,11 +559,11 @@ static ssize_t pt5161l_debugfs_read_hb_sts(struct file *file, char __user *buf,
 	ret = snprintf(health, sizeof(health), "%s\n",
 		       status ? "normal" : "abnormal");
 
-	return simple_read_from_buffer(buf, count, ppos, health, ret);
+	return simple_copy_to_iter(health, &iocb->ki_pos, ret, to);
 }
 
 static const struct file_operations pt5161l_debugfs_ops_hb_sts = {
-	.read = pt5161l_debugfs_read_hb_sts,
+	.read_iter = pt5161l_debugfs_read_hb_sts,
 	.open = simple_open,
 };
 
-- 
2.43.0


