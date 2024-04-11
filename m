Return-Path: <linux-kernel+bounces-141144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FFE8A1AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922F728D425
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC031EECA2;
	Thu, 11 Apr 2024 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="R4yRdgqR"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B731EE2AB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850114; cv=none; b=oHPSOus/ZVNT1+11lGeMJNJNm5z+t6wH/Ziv2lxWF78NlEGRPDXwKsBlm0zJT0qHiz1lehIBUhCHKL4P4vJJvB5Mon/Bg7BZyDinn0hWhNIQ/LpjUQX+cIfKxkLj1TjF5AAG4tfpaRKVMIK6oADv406Ftkh6b0SigqkdbNtRB3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850114; c=relaxed/simple;
	bh=Y/iSvpIjGlIRFVx4u2nZZL2wUzPPNJ4zB+MKklb6/ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+EqMFyWBcUHFcrl3Uw646PL57YqEZYO/69QOwZF6O4s7xTnTgy+8lW0s1MK7qU63uc6AQxVDvNPQbOY/ftsbUK5Zn9WCwxYJ1X2YaNCSODT2jfJImGkUnBHRtdZIb9TVMP7oxuUpqz2mMQU2vuVADDXEJn2EE0o2t76a/elYZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=R4yRdgqR; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36a34b68277so121415ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850112; x=1713454912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bg2rFEF/+oIdUQ14ghwtCcWSCSUbBNSWYK4tXZxz9dU=;
        b=R4yRdgqROj2OP2ypNihEScjRcJq0VupodHLKEJvZ0Pt2p0Nad5NLVV1BpPZBH04RkE
         m/hhmIL5j1r+Q9x/hu2V291JJ3FWS99GyjbBWt9GV6AisOJShjU02H993G/CaOsFVgNs
         fm6pex0AzFr/jPyDGEMYtQN6COTuo6/xW+nuzmIwGxr9W2v0tZauxKtNrdp9CD4BVJO+
         FMjLmyFj3pDfGsGX0uB9BplGN32ZeetpVcXRJS+9kb+6UuPIV4PZP0OaLtY7kXQm3M+j
         6bbaPjmOqIt0eOig9pU+jmPiocoqvBB5VQ/0HEVFZw7pQYMNzKI2k7uo/S4rgiUDCgJI
         I/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850112; x=1713454912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bg2rFEF/+oIdUQ14ghwtCcWSCSUbBNSWYK4tXZxz9dU=;
        b=VR2HpvI4S0s/olMvK3qOiV05NFkc1Av8CpY1Nm1F1igiC1NfzxOv1mVWxuj8BVQQuK
         T1WH/6QQGzABioFf+TAqB+FRnIxnZyzC4qdfDWJKc1ix76KcstKxRzOYaSnzpHcYke9z
         YO+M/oUxpGefp3VIIDyDaXhNssQo/2qn+59A+Hw1qCbGYnCDaPDk8ePw4NU5vTJUacRD
         zRbL2W0yViZgD1WWP051Up8xVKzOzGBO3D95L5cQVHiVS9WK43wg5FG621S3qIN0GvQk
         E9ifXXAR4w2S4eCU9lFPL7zMRjvyKfzNLKShoaPT72KORXyaWYAbYJWKa1AjlvDM/0b2
         EXeQ==
X-Gm-Message-State: AOJu0YyJONA7KpP57L79BAJMLzWqdfulmi84nM4trYe+LuAtSWGz0VRm
	baj47uGPoEk2ymqdVbdtMDwzNA46F6kGVXM7Q71VeePew+cSz7Mu72bsZjdOOeLS67OyKep7d9V
	Z
X-Google-Smtp-Source: AGHT+IEHU4dZHhwHkQD4H7YG9tJchvLQ2aCeiuD3KjckGsACToq/lu35Ca+PKnLM4MMA3SXcdVIkUw==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr202685iob.1.1712850112472;
        Thu, 11 Apr 2024 08:41:52 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:50 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 365/437] hwmon: pmbus: core: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:25 -0600
Message-ID: <20240411153126.16201-366-axboe@kernel.dk>
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
 drivers/hwmon/pmbus/pmbus_core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index cb4c65a7f288..39b340024c28 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -3303,11 +3303,10 @@ static int pmbus_debugfs_get_status(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(pmbus_debugfs_ops_status, pmbus_debugfs_get_status,
 			 NULL, "0x%04llx\n");
 
-static ssize_t pmbus_debugfs_mfr_read(struct file *file, char __user *buf,
-				       size_t count, loff_t *ppos)
+static ssize_t pmbus_debugfs_mfr_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int rc;
-	struct pmbus_debugfs_entry *entry = file->private_data;
+	struct pmbus_debugfs_entry *entry = iocb->ki_filp->private_data;
 	struct pmbus_data *pdata = i2c_get_clientdata(entry->client);
 	char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
 
@@ -3326,13 +3325,12 @@ static ssize_t pmbus_debugfs_mfr_read(struct file *file, char __user *buf,
 	/* Include newline into the length */
 	rc += 1;
 
-	return simple_read_from_buffer(buf, count, ppos, data, rc);
+	return simple_copy_to_iter(data, &iocb->ki_pos, rc, to);
 }
 
 static const struct file_operations pmbus_debugfs_ops_mfr = {
 	.llseek = noop_llseek,
-	.read = pmbus_debugfs_mfr_read,
-	.write = NULL,
+	.read_iter = pmbus_debugfs_mfr_read,
 	.open = simple_open,
 };
 
-- 
2.43.0


