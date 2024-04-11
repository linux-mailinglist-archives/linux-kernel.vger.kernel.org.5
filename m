Return-Path: <linux-kernel+bounces-141148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D148A1AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6027C1F23DE2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6065E1EF537;
	Thu, 11 Apr 2024 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MamlB5PS"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723341EF521
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850120; cv=none; b=SfxtP065McQqrDHg+JlyciMPHJqwovhO1TMRwh+2ojIAurGKOLqRVJ/MQVpFdRpNXUUv8mOq8kJvuRdHNL9sxInQ9K7eXFLII9rfYVXqMEnSRmJC7XGtgScWVb6d6q7jTC5/fSGw5hi0v9fnq9lMHMdk0rO/mvtgqk2Gv7Ql9LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850120; c=relaxed/simple;
	bh=fsSAZ/j6rz8b6lfbCgyEDkxERPYjjlGbcs+nSAGXcw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdFNPYnZNFTvZFtB5uXhngGjpA0PgdGiQvDme/4wR2LS0NvTyNhuV/Ukx80snPEasAhUoAivaVzAPP84Jw07YFUeCMeKeXTIoGZkdnp3p+svhkptLmXje/KFMsHOyzk5vp0pHrjcD0EfvIyyAxcUC8UOhDsdWMnPbP65C8wqv+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MamlB5PS; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58247939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850118; x=1713454918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqR/7bLNPLxZni1GbBnllMUkQPN87O6jSpBweZ9+NFo=;
        b=MamlB5PSzbiM7rftx380vHU3akA39bx047b5gmi/rGubYMNLMy87WmQ9c4+BCjteO2
         HHpefZ9tC9Ume7tWR5TPMYxHUixxJHJxO5MSbcDr+Vx8cXhioKpLrq6vVXWfMjIbiTNf
         nvN0d0gjRY1emauZ9F+DHamiGPXOjroOXz/nspYYmtOPCKSO6u4a2fMtqN/TjGTJIaEr
         jYWTxngFLfYt7YZ2hYGJnxCo1vpdKmPyxcuY/iVD9IeZiAoC3v0rjPU5U5tvoJks5QVT
         cBZISBNSAuVy9BTkjnoNQE2mot4exnQxhtUoz9zG853hqNgZFEQN5t9igCLZBcntBfta
         MZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850118; x=1713454918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqR/7bLNPLxZni1GbBnllMUkQPN87O6jSpBweZ9+NFo=;
        b=nkE0hxgmyFDNemLZttBMgE9VmdV4LF+3imru8ttAP2ueJz+oMpGR9DB2GGkxw8nVoy
         itIB5Uh+mWFzMhky4dmSF03Y73RSARB64nZB3zEcss6D7qW5wjYDHeQf6ZUiti7jj28s
         Kyi+u4pdQCHMN5d5rrPlWkcMI4+OiN/ZE+Jf0vyJWU5Z8ncEQh/pwl5H65lnMhI3Xvcu
         PS0l2DPMNG6Xl2KRZF0+RgH8cOfN0o2yVYRK80a/rSiWTZC/poF7K5IusmlKHO8gApbq
         Li3615e+lXz4uUUf5qn7G9UZ1s6pZ2n6t5P+7jl04sxSz81RajaFADfhMhP11B4jAu6H
         +/5Q==
X-Gm-Message-State: AOJu0Yx5QJW1wVGqR/lbpL7nL5lLCuyW/VqEQW/+Ez+zkjpJzn1YE5M1
	fcOw66h7Agz5zA1x3Jnx8g64wNiFvL2qA9IPq4J1oCPozauBS3CGLMooN9oX1qR7aQhHyU0i+4A
	e
X-Google-Smtp-Source: AGHT+IGoLN+We/KSbYbic5qzT2J+MOQpxgT5CAWPHDxmTuyIn+E6lWZBnvy88sADP9HDsrotrgZaDw==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr177309ioh.1.1712850118405;
        Thu, 11 Apr 2024 08:41:58 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:55 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 367/437] hwmon: ucd9000: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:27 -0600
Message-ID: <20240411153126.16201-368-axboe@kernel.dk>
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
 drivers/hwmon/pmbus/ucd9000.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
index 8d9d422450e5..204c836fa322 100644
--- a/drivers/hwmon/pmbus/ucd9000.c
+++ b/drivers/hwmon/pmbus/ucd9000.c
@@ -471,11 +471,10 @@ static int ucd9000_debugfs_show_mfr_status_bit(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(ucd9000_debugfs_mfr_status_bit,
 			 ucd9000_debugfs_show_mfr_status_bit, NULL, "%1lld\n");
 
-static ssize_t ucd9000_debugfs_read_mfr_status(struct file *file,
-					       char __user *buf, size_t count,
-					       loff_t *ppos)
+static ssize_t ucd9000_debugfs_read_mfr_status(struct kiocb *iocb,
+					       struct iov_iter *to)
 {
-	struct i2c_client *client = file->private_data;
+	struct i2c_client *client = iocb->ki_filp->private_data;
 	u8 buffer[I2C_SMBUS_BLOCK_MAX];
 	char str[(I2C_SMBUS_BLOCK_MAX * 2) + 2];
 	char *res;
@@ -489,12 +488,12 @@ static ssize_t ucd9000_debugfs_read_mfr_status(struct file *file,
 	*res++ = '\n';
 	*res = 0;
 
-	return simple_read_from_buffer(buf, count, ppos, str, res - str);
+	return simple_copy_to_iter(str, &iocb->ki_pos, res - str, to);
 }
 
 static const struct file_operations ucd9000_debugfs_show_mfr_status_fops = {
 	.llseek = noop_llseek,
-	.read = ucd9000_debugfs_read_mfr_status,
+	.read_iter = ucd9000_debugfs_read_mfr_status,
 	.open = simple_open,
 };
 
-- 
2.43.0


