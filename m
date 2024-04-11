Return-Path: <linux-kernel+bounces-140889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C3E8A1967
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C708E282763
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A221315990F;
	Thu, 11 Apr 2024 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HK2vJbJw"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66FB15AAA4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849715; cv=none; b=Ma23JCgpnY1ufdyvl+rIpkXuVlYvFvDnT16ZCHd1O6aMi7nzmDVapgigoOyOQ47apPKclxQM+L/PWxb143MDYea0mfHVuCG2w5KLJdj31Fm9Xs8F1KvJIEExC7rZbCLuEEuao7eCEzCHWpNcJcyt9WAYmjj7zid1giPJrIYOTe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849715; c=relaxed/simple;
	bh=b9X00iSNJYVtxC3/sqLX/o3knbJU3+NSrP5y9pStPRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovt13n3GNjrx2gbZLIh1L3cgtCo5tK34PAR3DzFVEK9zDMrXoqYFMT3/npI+ZZB2IweOA7P1+syAaFyVXLJDSl/UoaF3McS8YgM/V2CGIsJBx4+XhuLzoCrKQyu4yUZRgh56zxebwk5vGwzMpclRj2Ctw1AHZ/hvR9x4GeMERbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HK2vJbJw; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9771839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849712; x=1713454512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JN3mqvndXI1gWHhufhGdf4sQOgVkhWV1ClnaB5pVpcg=;
        b=HK2vJbJwMHfLKXXEhRpGuWFLOsp5J+2Vy43k1H5svlLmURW5PpJTRj1ADn9XX2iF17
         lKvKr3rxrmGofK5czRcAWaJl/kjwNkpFx0VOtyjcjAhvu3UcZY7BM27dMmxotyfmytQI
         PvJNB9nJogLoH1Umyg9BEp4wcaDSjRqdCCwyytEVOAIJWhkvTSrqzwqmDAXIFoCa08Or
         7daJhnb5ywMokAMZcNTjsIBMJUEn6PKVV1N7OU0THkY1XwVaD7L79jCplypyAAVpFS42
         SPNu1kIL43eJer2tCQKEGLb1EtOUxK54G/pkExXFofWDr3D276ha0K7WKMnmbXBZwyyB
         vO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849712; x=1713454512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JN3mqvndXI1gWHhufhGdf4sQOgVkhWV1ClnaB5pVpcg=;
        b=ZMP/BbzEkhh9R3GTGXcdjnEaVNNZ3QIWlphtT4FpbsSBY50T0ujhXrXGd8YD6lte0W
         jdL48H5drrfKnP8IFU62EOM3WkW5cbj0Otea5b+31yiG6OvmehBWDOyDYRq1L+MAvMBf
         MOTFV4omAlyUXAMViN6HDZmP9sIANQ80iGNwONe2h99pmLBlAeYP5f+/8W8FzoWj0aMP
         6SmdDqDjfQEYJn9KnlbdRhePOeN5b/AIOqYyd1CeL0fM9CHNF+Fi7FdF6euf2vkxcc+8
         /G7P+QhgMiAA5hIvQQ1yHJZYKgTLSEekPSWirpGY02fwvxCfHBE10sOMy6Lh/IpajywL
         7KPw==
X-Gm-Message-State: AOJu0YyK84oWBd7rZqpfMHsZkvGVzc+9otuOALpuE4GK0CD1o25WB142
	0QEU9xs+gb9Y+tDgN30GVe6imrSnoLMeQv/bBmlP7IA6b8V5mdlS8rAfzhFNcc3fczm7bUJOlyf
	5
X-Google-Smtp-Source: AGHT+IF9RaXCpaHDARHEBZNdLFUjhOhOhZnX9SjwLewk5kagZRFLwlxLCinfn5G1QQxxk7d5hQ56pQ==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr191393iop.1.1712849712438;
        Thu, 11 Apr 2024 08:35:12 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:10 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 125/437] firmware: cirrus: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:25 -0600
Message-ID: <20240411153126.16201-126-axboe@kernel.dk>
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
 drivers/firmware/cirrus/cs_dsp.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 9f3d665cfdcf..80a2cba021d1 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -398,11 +398,9 @@ static void cs_dsp_debugfs_clear(struct cs_dsp *dsp)
 	dsp->bin_file_name = NULL;
 }
 
-static ssize_t cs_dsp_debugfs_wmfw_read(struct file *file,
-					char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t cs_dsp_debugfs_wmfw_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct cs_dsp *dsp = file->private_data;
+	struct cs_dsp *dsp = iocb->ki_filp->private_data;
 	ssize_t ret;
 
 	mutex_lock(&dsp->pwr_lock);
@@ -410,19 +408,16 @@ static ssize_t cs_dsp_debugfs_wmfw_read(struct file *file,
 	if (!dsp->wmfw_file_name || !dsp->booted)
 		ret = 0;
 	else
-		ret = simple_read_from_buffer(user_buf, count, ppos,
-					      dsp->wmfw_file_name,
-					      strlen(dsp->wmfw_file_name));
+		ret = simple_copy_to_iter(dsp->wmfw_file_name, &iocb->ki_pos,
+					      strlen(dsp->wmfw_file_name), to);
 
 	mutex_unlock(&dsp->pwr_lock);
 	return ret;
 }
 
-static ssize_t cs_dsp_debugfs_bin_read(struct file *file,
-				       char __user *user_buf,
-				       size_t count, loff_t *ppos)
+static ssize_t cs_dsp_debugfs_bin_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct cs_dsp *dsp = file->private_data;
+	struct cs_dsp *dsp = iocb->ki_filp->private_data;
 	ssize_t ret;
 
 	mutex_lock(&dsp->pwr_lock);
@@ -430,9 +425,8 @@ static ssize_t cs_dsp_debugfs_bin_read(struct file *file,
 	if (!dsp->bin_file_name || !dsp->booted)
 		ret = 0;
 	else
-		ret = simple_read_from_buffer(user_buf, count, ppos,
-					      dsp->bin_file_name,
-					      strlen(dsp->bin_file_name));
+		ret = simple_copy_to_iter(dsp->bin_file_name, &iocb->ki_pos,
+					      strlen(dsp->bin_file_name), to);
 
 	mutex_unlock(&dsp->pwr_lock);
 	return ret;
@@ -446,14 +440,14 @@ static const struct {
 		.name = "wmfw_file_name",
 		.fops = {
 			.open = simple_open,
-			.read = cs_dsp_debugfs_wmfw_read,
+			.read_iter = cs_dsp_debugfs_wmfw_read,
 		},
 	},
 	{
 		.name = "bin_file_name",
 		.fops = {
 			.open = simple_open,
-			.read = cs_dsp_debugfs_bin_read,
+			.read_iter = cs_dsp_debugfs_bin_read,
 		},
 	},
 };
-- 
2.43.0


