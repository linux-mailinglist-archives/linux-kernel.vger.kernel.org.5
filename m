Return-Path: <linux-kernel+bounces-89518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D0086F171
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8675128322C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42D7381BF;
	Sat,  2 Mar 2024 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="Rn6zPuYd"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5A8374F6;
	Sat,  2 Mar 2024 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709398063; cv=none; b=P8IYB7LdYrYqT9KTrFaOh0flmEzkKN442WTepzyCFNNLpfVbmQrqZW6OR2Y3z6NBBrSC6hIXDf8PyYsz5vcgYw8FJJxsR+c4rjuIAyNiu78KWkOg+hqCtTiFcDZVeuzXfZo9CTi+0+4ylWGegIyEuFT6CxZvb6hHns6Gq8qjXIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709398063; c=relaxed/simple;
	bh=OFw+SoUq0xk7W6nH4RuzhazAI/0hRJvdMx9LIMtpX3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FSmslWHMh7lpvmghlJyJik7ruu8ox6zOXGPwNCoaKvLrWF/B97c+gqB1q3o57E/Tcj88PBCKZ2sIXKr7bn23TtbFZEv8SdB/yDJyFkQFFqg/sZLh2IOnAyTnPUV5ftHqBMP36OFlP47FPy4/h20Xm4rcoKM2jueOk73ch33cNVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=Rn6zPuYd; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c7b8fb8ba6so193743839f.2;
        Sat, 02 Mar 2024 08:47:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709398061; x=1710002861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=io+X3piu28ZGp7fEkiX94HlMuyoRpBle34GT2h5igCM=;
        b=dEhkRZ5Em3Owp4e95X5tGprH44ZEQS7JlT5LIuXZK/+Gw1AMY6eoW1H82kpnjA3Sq2
         /Oildon2Txs5oBxj7gTSw8y3IyQ5dX13DHTb9TDVSr38llrQEowHZDWAlmm/tMYMRJA7
         +E2F5f6f1vwiaXfm2VrfhBSPwwm/ekuEC2VSpoWWyjrDRhz1GNsUbuok1d9DchAtu87k
         0SGp9f3PRxyYo95m7sPDDq8//HtKsFAGxtXJClDVOFHc64DurGygnsoJUUrrSV/+xUhP
         J7MNgmeYvsixapVYw6wcIHL+VvQkcdernFSh9DC1I7Ye5F3mHhqCrgV3pd04zK9jDCJt
         QoRA==
X-Forwarded-Encrypted: i=1; AJvYcCVRVv1m0AWjdfGHeJePdr14xipDHniJ1DaHieKqqFHikuYZzUatvsuFfNjp+LVMgh7MLe5yjV+0nkMFexqiCFpS/zw1TLj0lJ8Vb5zs
X-Gm-Message-State: AOJu0YzxgvZlaZGI6Ay05QQydxAlAij++pjUMtKJ1oFdNgrNPGjkyr2e
	ZThcF+dg/iVJubKhRXBTJVnzJs9bDujiVGTEHFlGoyPrkzAwCEOC
X-Google-Smtp-Source: AGHT+IGwhI7z0oc0j3g/9SiNMz0DnhCN3lRVafp+YkKuc9V5wkG/aMG1CZgmqdEIgAuWQ8gbVmg/6w==
X-Received: by 2002:a05:6e02:2141:b0:365:b56f:ff8 with SMTP id d1-20020a056e02214100b00365b56f0ff8mr6001241ilv.15.1709398060828;
        Sat, 02 Mar 2024 08:47:40 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id k6-20020a92c9c6000000b0036577f79570sm1542618ilq.54.2024.03.02.08.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 08:47:40 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709398059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=io+X3piu28ZGp7fEkiX94HlMuyoRpBle34GT2h5igCM=;
	b=Rn6zPuYdvHA1i4lJ2avKHDE5h2+mTSUlwl2b3iNINkvtj+zB3OqJP9ot2hWU3TNkj0IN+/
	8r/i7EnAF0626UmHUqxnE0Cg6mcE11F0a1nAXUHczfT4RSdk5eRy1mqGXy4SMayZsQCDQ2
	6nQV4gy0o66iZgFAHqF/nqsOgJBjPyZCZAe4SUJt0hiLSAB5FjQskxvdLEIe8fQ3//VZro
	NQQ/yHuk5EwUDn4/xruCnLgIEPa8OGk1JHap6iA0iHbIte7c87O+1zFsOemH5/PryLs5Uh
	wMji25k273VZSUME111nT+xc4uwN2rku6pcTaivcOAnpVZ7cCTGr28vmAPwDsg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 02 Mar 2024 13:47:25 -0300
Subject: [PATCH 4/5] scsi: ch: make ch_sysfs_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240302-class_cleanup-scsi-v1-4-b9096b990e27@marliere.net>
References: <20240302-class_cleanup-scsi-v1-0-b9096b990e27@marliere.net>
In-Reply-To: <20240302-class_cleanup-scsi-v1-0-b9096b990e27@marliere.net>
To: Doug Gilbert <dgilbert@interlog.com>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 "Manoj N. Kumar" <manoj@linux.ibm.com>, 
 "Matthew R. Ochs" <mrochs@linux.ibm.com>, 
 Uma Krishnan <ukrishn@linux.ibm.com>, 
 =?utf-8?q?Kai_M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2964; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=OFw+SoUq0xk7W6nH4RuzhazAI/0hRJvdMx9LIMtpX3E=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl41gdug7CFvW2hatyKdoEGu0YCP9JqtLPIRH4X
 A+So7602CSJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZeNYHQAKCRDJC4p8Y4ZY
 puZfD/9fEO0jnMv3Bq1JgyMfUPJQT8aSKLEJMf7Pbcb9RI5jFHpKC6fTxzB50/Nxhqlnx75nslI
 ro1ssoH+LIWkdtLtX8Kw2FUBbsR7dCaeTUYu8bljk/ab4mLFRXbTvj8rbre08eBILS6i264z5Kf
 HhyJgYRzcnD7B0pxoBnWmAvoFrSUhzPEzss0sF5YjvkM2QSP4cvvHfV0Ve1TdcCnfOPP2CW3aXB
 9K/JptuL+lvWbnyOmofkzKMqXwuwbOzJn9Os4igSvAg38h+tr/4nsj8qCFaUCwvZIpgWJSYR/Zi
 7xtCBoDroJAABSXkHlWKxJ+/uQ+VcQlk1yEZ2HzO8G5O6FDruL/W+lquJmZvVTJNasZw1IBWrEn
 pxjNNH/wp4GR/IjbZBLEyoPmEPTHfPQgOT5DDhL5SmvNTMIEp9+4geGlfQ6g0ysO4CSFp/jlw2h
 CaPCxkn8sIQIz2kyRHo0zNOpxAt/iBpYvZ8hKfqFDY2ZZBoaY/nkn6sr2HY98OBtrr5UuDk9up0
 n3KIKrhW53SnZ36qK5E4oHZlndvQb0zW2tyzeQ5/9vdXZxLKMvUtyjry5Xo2RUKZh3mDbnznmQG
 TeTiP/66M5xIRGEtAjKAXwfN4jODl4jNTMrFkeN039qgdP7cGdumloTOVEfmn4cd7Un/onVJU1G
 D6NOAVOCk+WWDBQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the ch_sysfs_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/scsi/ch.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
index 1befcd5b2a0f..fa07a6f54003 100644
--- a/drivers/scsi/ch.c
+++ b/drivers/scsi/ch.c
@@ -102,7 +102,9 @@ do {									\
 
 #define MAX_RETRIES   1
 
-static struct class * ch_sysfs_class;
+static const struct class ch_sysfs_class = {
+	.name = "scsi_changer",
+};
 
 typedef struct {
 	struct kref         ref;
@@ -930,7 +932,7 @@ static int ch_probe(struct device *dev)
 	mutex_init(&ch->lock);
 	kref_init(&ch->ref);
 	ch->device = sd;
-	class_dev = device_create(ch_sysfs_class, dev,
+	class_dev = device_create(&ch_sysfs_class, dev,
 				  MKDEV(SCSI_CHANGER_MAJOR, ch->minor), ch,
 				  "s%s", ch->name);
 	if (IS_ERR(class_dev)) {
@@ -955,7 +957,7 @@ static int ch_probe(struct device *dev)
 
 	return 0;
 destroy_dev:
-	device_destroy(ch_sysfs_class, MKDEV(SCSI_CHANGER_MAJOR, ch->minor));
+	device_destroy(&ch_sysfs_class, MKDEV(SCSI_CHANGER_MAJOR, ch->minor));
 put_device:
 	scsi_device_put(sd);
 remove_idr:
@@ -974,7 +976,7 @@ static int ch_remove(struct device *dev)
 	dev_set_drvdata(dev, NULL);
 	spin_unlock(&ch_index_lock);
 
-	device_destroy(ch_sysfs_class, MKDEV(SCSI_CHANGER_MAJOR,ch->minor));
+	device_destroy(&ch_sysfs_class, MKDEV(SCSI_CHANGER_MAJOR, ch->minor));
 	scsi_device_put(ch->device);
 	kref_put(&ch->ref, ch_destroy);
 	return 0;
@@ -1003,11 +1005,9 @@ static int __init init_ch_module(void)
 	int rc;
 
 	printk(KERN_INFO "SCSI Media Changer driver v" VERSION " \n");
-        ch_sysfs_class = class_create("scsi_changer");
-        if (IS_ERR(ch_sysfs_class)) {
-		rc = PTR_ERR(ch_sysfs_class);
+	rc = class_register(&ch_sysfs_class);
+	if (rc)
 		return rc;
-        }
 	rc = register_chrdev(SCSI_CHANGER_MAJOR,"ch",&changer_fops);
 	if (rc < 0) {
 		printk("Unable to get major %d for SCSI-Changer\n",
@@ -1022,7 +1022,7 @@ static int __init init_ch_module(void)
  fail2:
 	unregister_chrdev(SCSI_CHANGER_MAJOR, "ch");
  fail1:
-	class_destroy(ch_sysfs_class);
+	class_unregister(&ch_sysfs_class);
 	return rc;
 }
 
@@ -1030,7 +1030,7 @@ static void __exit exit_ch_module(void)
 {
 	scsi_unregister_driver(&ch_template.gendrv);
 	unregister_chrdev(SCSI_CHANGER_MAJOR, "ch");
-	class_destroy(ch_sysfs_class);
+	class_unregister(&ch_sysfs_class);
 	idr_destroy(&ch_index_idr);
 }
 

-- 
2.43.0


