Return-Path: <linux-kernel+bounces-140895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2E18A1972
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F512887EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6AB15B99A;
	Thu, 11 Apr 2024 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cNorlwSi"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D015115B578
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849724; cv=none; b=hIvgHDC//Vart566EDDKM7uCAUDt6pY03eFKoscaCnEVb20JeOY2SXlNJP9G2ivSZVuFuRI5LV1GDYefnowkHSqStpf6praqXDYWUMmZThrS6VAaV4kN23eeUC7fhv+Mbtwx42nnZSqNuMTTw6BsTVxa6QZrpflIzCq57EbhVv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849724; c=relaxed/simple;
	bh=qDW73nLCAbthEU1m3Wg56pQPy3RqiqdOL715SPwIqGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulDkdkO2usjPk6ufe5gvj+mQ88TPma21El1VNTARRlxMy+4roma+6wEAVrlfZwXAZxGBziFR6OCC91vP/qwv8PFC8PHZK9z+/Zylu6ahpPB8f3AqE39tnoNiB5gzYa8pZ6ZtyLKWjs3avImcpPXq4SBb5NPivbh3cyOSiTARmY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cNorlwSi; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36a224d7414so181175ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849721; x=1713454521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLjJmJHxmSDaxASdqWWWd85ZwrkHxHPKLKhPKVXwGoQ=;
        b=cNorlwSiLD7H0nldjbDukU9Hyq649frf3KfwCqYXSA9/VRyWryeacP4WVtjVIcl/ZV
         jt6omdMN9EzviIW+4dJXPGo/DtNqQS7293Z+c6RsTWfcpqRY2tlv17cV63YKfiKkFIum
         qKuYH1/6Y4WVaonsjniFC0EdQSBG8tR8juseoWikNTx3ucCOmVhDBkdkkbNOICma+J15
         5uny/iy7bajPvxCtaxw1imlkt2jbm9AwenUrkPE08N6HVYp0IW8DxYXc7aokim1SB36h
         v97q2DmCX3Y0rd6D4Gg4m/24gSnBGTAl1HqLcDUmj8RgPVjHUnYWle+NEsjfEc7PvCUW
         rVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849721; x=1713454521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLjJmJHxmSDaxASdqWWWd85ZwrkHxHPKLKhPKVXwGoQ=;
        b=kEoAG9JRei4RimTJiwqco2xchESVbHstI/NVGCQal6wZDf03fPeyqRNq3s+agzpAro
         97nD3R5aOCxHgaqZaFjFXbXpjZms0VC8U1cSkmoZAn4um6+WK+dAry/aSVaPcPczI2Ph
         0r3fqG+uSx+LKOKaQTOGswYRYlhc0AVlXL8+JwNTbUHxzvKySj3vJ5bYdaWqpN8EZO3F
         sIEJh0VxUWUdqSVw7m6Kl+6jy+Aqw9BSEtUhOM6P2sBWR4lEOjmSiQUTXY2rWj6PiOih
         Zx08OSGvJcZksGyG93qNBRzYagG8mUWkL85jHwiQe1ZRRmOvAWNilWBfzqHH+ozqppf6
         +yEA==
X-Gm-Message-State: AOJu0Ywo8QombLo4rw/UJ4FexAZXN3ArgkwRAhahQi+eB4EEpa0/udc+
	xKkAwxmk7MKAHSxXeEV2doYHNetxSvrYOhR7ZjMhCkEy5oba4LoDZmpndCxPWg/OLsgeW+w9/UW
	L
X-Google-Smtp-Source: AGHT+IFLMHFadikXh/jxWbpQ/Uc7LBZl7P0+r03WFsqVk6YVAvma8YacJD41+IO0WAlx64uARiUkvA==
X-Received: by 2002:a92:c56f:0:b0:369:e37d:541f with SMTP id b15-20020a92c56f000000b00369e37d541fmr6986163ilj.1.1712849721608;
        Thu, 11 Apr 2024 08:35:21 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 131/437] drivers/opp: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:31 -0600
Message-ID: <20240411153126.16201-132-axboe@kernel.dk>
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
 drivers/opp/debugfs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 105de7c3274a..a755dacb2c61 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -33,10 +33,9 @@ void opp_debug_remove_one(struct dev_pm_opp *opp)
 	debugfs_remove_recursive(opp->dentry);
 }
 
-static ssize_t bw_name_read(struct file *fp, char __user *userbuf,
-			    size_t count, loff_t *ppos)
+static ssize_t bw_name_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct icc_path *path = fp->private_data;
+	struct icc_path *path = iocb->ki_filp->private_data;
 	const char *name = icc_get_name(path);
 	char buf[64];
 	int i = 0;
@@ -44,12 +43,12 @@ static ssize_t bw_name_read(struct file *fp, char __user *userbuf,
 	if (name)
 		i = scnprintf(buf, sizeof(buf), "%.62s\n", name);
 
-	return simple_read_from_buffer(userbuf, count, ppos, buf, i);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, i, to);
 }
 
 static const struct file_operations bw_name_fops = {
 	.open = simple_open,
-	.read = bw_name_read,
+	.read_iter = bw_name_read,
 	.llseek = default_llseek,
 };
 
-- 
2.43.0


