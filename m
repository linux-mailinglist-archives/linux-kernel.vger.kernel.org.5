Return-Path: <linux-kernel+bounces-141141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF7D8A1B40
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E43EB28E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9A951C42;
	Thu, 11 Apr 2024 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gbfW83uV"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228AE1ED743
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850109; cv=none; b=D0Hic0ZDUAWdlFSzo6fc7g8i1a7qC5MT1OSH739EovnH/7mCvV3tEQR3C3O3zdPn7YAE6aH6uHhFLZ54BgypBktFuJ+/wMCtucVQ8aufKZnVap1QFOGt3KFzNi9Lk+Qdi8j05HJeSdFLmtwejKsjMsXApbdVgmVeWf7GWl1Wtpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850109; c=relaxed/simple;
	bh=F3ghVNHYkYDwqG/ic0r458tZE0jAzsc5iHJB06NOZ8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOfO/3pfp+japTmuOr4FIsYwl9EpxC+ikw6aqik6LE3QMvIaxy3qZpka7DW8VHEFqFccsENfZTbHnbdopi5gqjUugaeg5nV00H6tYvhd70SP7CdcAe98BDg/a2dSogXKr7kN17cgy2vxosxtiQ7AxuCo0+4dM9NevNMwut0P3hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gbfW83uV; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58244539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850107; x=1713454907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uA8b89WlMoOLmxCUVeReNqk0nF3IewFPUR21ZUsnOJU=;
        b=gbfW83uVOSKAL5Gbv0Ske443ZkAfIoKGM4POwnqgL6gaWkM5tsj+ocrX9ko9nTF3mT
         OX5cPJdcToBRPApBPJDCZfaTHmpjrg6xmZPFmdD/qImhgLTDLBsbbP2+xqSvpT4TOH2T
         VIapH3lMOR3a9Pa4dZUWa1fY/rtm9WL/rfp2mIorD1YjzJF8LolzOdsoXs+VNrIxy2ZU
         g/w3tJocJRi5qWnLE5t1DI2OEcr4w5CHgqwBhW1nU/FbF+uayy9lIlZVbQMxeGCw9V05
         Q3A/joKAeuU7TzZwuGPpsL87EM1t4I0O4Qr6Vm55Ib+3cPS98g5F88/dd8C+KhOm4izR
         YvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850107; x=1713454907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uA8b89WlMoOLmxCUVeReNqk0nF3IewFPUR21ZUsnOJU=;
        b=wW7sWwEDpjc5cGvPJGXut83Dba/MfMBqkYCsrgl+a5co0ibzOT4Y+G/36T1BcPR0dr
         dDVXhkpxHd+QovLTWgBVcTNtGUWaIxGllFosaYGYTDlz/phnXKAPzN0geaFwbKidIsGx
         FkqyIATNggV4wMnNTger4+pvh3Rru3eF5MvznTRgRh85uIjhep+pZlMn+gR9aI3R2hl8
         9WA8fyNeBvNwZRXPnWpzIOwSyiuPr2tpKponk7xD010b3utG4PUrmhGSOO2BLSS88A87
         rf4QE3wy0nSfUvPzu4CBZ+FqtbWjUXAQgD2Rf2Xlc91wZIYD0P+Khse0qBCak8LCCLwE
         ETZw==
X-Gm-Message-State: AOJu0YwmxEe3eT191+WTxdYFrn9ZHvJfs9K2a4mOb+Q6lZwvSaCVjcqC
	/dQ+rmXO6aZ0WAEul/NSVFwZJrAQKaW30bMl2nJJ0J2UQUrSqPCWz6QnjCni92r41LoHrV86gMs
	B
X-Google-Smtp-Source: AGHT+IHPvt/AYoYLfkqFDedbhmcM+3L30/G0CY83mVPWCLvHbZ5xJpXfzUP81JxaGmI/tyevhmKYIw==
X-Received: by 2002:a6b:cd08:0:b0:7d5:fe3e:90ff with SMTP id d8-20020a6bcd08000000b007d5fe3e90ffmr212554iog.0.1712850106945;
        Thu, 11 Apr 2024 08:41:46 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 362/437] hwmon: acbel-fsg032: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:22 -0600
Message-ID: <20240411153126.16201-363-axboe@kernel.dk>
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
 drivers/hwmon/pmbus/acbel-fsg032.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pmbus/acbel-fsg032.c b/drivers/hwmon/pmbus/acbel-fsg032.c
index e0c55fd8f3a6..cc8fec9d1ea1 100644
--- a/drivers/hwmon/pmbus/acbel-fsg032.c
+++ b/drivers/hwmon/pmbus/acbel-fsg032.c
@@ -15,10 +15,9 @@
 
 #define ACBEL_MFR_FW_REVISION	0xd9
 
-static ssize_t acbel_fsg032_debugfs_read(struct file *file, char __user *buf, size_t count,
-					 loff_t *ppos)
+static ssize_t acbel_fsg032_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct i2c_client *client = file->private_data;
+	struct i2c_client *client = iocb->ki_filp->private_data;
 	u8 data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
 	char out[8];
 	int rc;
@@ -28,13 +27,12 @@ static ssize_t acbel_fsg032_debugfs_read(struct file *file, char __user *buf, si
 		return rc;
 
 	rc = snprintf(out, sizeof(out), "%*phN\n", min(rc, 3), data);
-	return simple_read_from_buffer(buf, count, ppos, out, rc);
+	return simple_copy_to_iter(out, &iocb->ki_pos, rc, to);
 }
 
 static const struct file_operations acbel_debugfs_ops = {
 	.llseek = noop_llseek,
-	.read = acbel_fsg032_debugfs_read,
-	.write = NULL,
+	.read_iter = acbel_fsg032_debugfs_read,
 	.open = simple_open,
 };
 
-- 
2.43.0


