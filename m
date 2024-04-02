Return-Path: <linux-kernel+bounces-127838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA213895191
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E468288EB7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F8678B4E;
	Tue,  2 Apr 2024 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjQXOnc/"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847FD76C76
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056478; cv=none; b=Tzx14Fry/faKOSMhbSy16AY/JzAP1qnkoJDYaQ8xIgkvOh7ryDXrmIPLFtDUWTuHjtlczpYoRwDGSqxeHm2MTu6HK880J9FhjiM6rgf9lZ2gKLYyeC/G/kSo3GclKnN0qsYI3fjbSFH0f8lG57Kx0dAWCJpeNSWZ71G8ng9L+iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056478; c=relaxed/simple;
	bh=fcVbgCCXoK3w9FQOBuxNovy1ixOVJR9WHZpVbqKlyWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MD5vAX6gopgWdDPX12oclwlNm1cUtlvFD3W0SF+7+kHBTL/ftQMrxGulJHSpD1D3hFt8wfTFzKMayglRVFkDAErlgHcSERt5/Aj1qOwoGq4/IwSPJ2uIck6uSt6xvRqCRFcybLHNfug92+puCLf84PBTcmvr0iiqJgu/ugXKDh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjQXOnc/; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-69107859bedso28281626d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 04:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712056475; x=1712661275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FG+XcPSEX9Mh6tQPFknGS3juRQhjzxHPLPnw/bWfBs8=;
        b=MjQXOnc/POBhqVNmqo8AfKGi4GGG6SXc9gE+5YHWPXfIJj05Qbl0x1DD7U4uTwccUe
         8eHdgt8tDOz91fAndlh/RpmujfZhTsDkKGITEoamHzaISyUJNoBSmjgZw5GOqkgowNrR
         WfW3Uxlt8XY38waJoOrAlvy5nD6eLiS9RUCNWmvC814REC1dfKZJ4Ig/Aj0cvLl8LIUw
         fP9FIwPN+ADhtzS7A/yc3bEsBe+gDYlI9fPwRsZme7XhCtd7V0cCjOhu9YeBHmGvXw/M
         oBMlL/HVhXoD3MvAxDEmIBL7laR1YFAYIKavV3Nl8Y1CwkiUxFN2pl/Lz9yczhSRJu9u
         QSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712056475; x=1712661275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FG+XcPSEX9Mh6tQPFknGS3juRQhjzxHPLPnw/bWfBs8=;
        b=KFWTl5SDCwVFDHVUZIov6+EqzFNLQjOr3vD3QTfpmDAYmrnVzdAFX6xYkLwClXOB1j
         yEhd737JqlNWe8Aa0S/okygEpAEcF5n8vk/JY3OuR0Tpd2KsOHWH9U8WzS13B4qDO923
         JKU0lHDc5wD/EsxeIHeSpuBTEUnM+cJpQbM8JB+lO59p4GuQLhXZUC3w23QWIPcq6oxx
         GKmZe0vYKF1VT4oP6wby432RhhVA/4hibESqDV3b/gbEiaT1Mb4f7Oue0sLMPGN0d1Oa
         aGY5kBI3DrT97y8NIORxfimrhAckkPhDBaUxSDPA6hFwoT9CIDPkVxCqS6D1KmdS47d8
         /rxw==
X-Forwarded-Encrypted: i=1; AJvYcCWWgC8NQhDpskMQxR3vaj6WGGZH+BE39uGGzlNAxl6PbUppdgTQWtKN+sYSqVV0vjThn+N257XibzdOEPIcHe38kOEUuVj6h0CcuJHj
X-Gm-Message-State: AOJu0YzltVM4Ok/gXIE1oou/rpkNi/GAkrcVgabAIG78FFvl3LEIwujw
	k3imxC6zVcZcbxpwKduThVk4XnxnfooRrasXT6S5ZfKb+EfSuKzh
X-Google-Smtp-Source: AGHT+IF0PGkbBIJ7k97WVMkLHs2MM/H3Ee4F+sOqhIzOuyRuvbbet/78Nva9DA9ERL1udXnY8UjthQ==
X-Received: by 2002:ad4:5d4b:0:b0:699:11a4:1aab with SMTP id jk11-20020ad45d4b000000b0069911a41aabmr3881782qvb.54.1712056475577;
        Tue, 02 Apr 2024 04:14:35 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:737b:ef00:2c6f:6cdc:f641:6ecf])
        by smtp.gmail.com with ESMTPSA id 11-20020a05621420cb00b006968a6fb010sm5428855qve.91.2024.04.02.04.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 04:14:35 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	felixkimbu1@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] staging: pi433: Rename return value from "status" to "ret".
Date: Tue,  2 Apr 2024 14:14:14 +0300
Message-Id: <20240402111414.871089-7-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402111414.871089-1-ikobh7@gmail.com>
References: <20240402111414.871089-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers init functions usually use either "ret" or "rc" naming their
return variable.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 47e0c51ffe2e..b0407d5c6be8 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1384,7 +1384,7 @@ static struct spi_driver pi433_spi_driver = {
 
 static int __init pi433_init(void)
 {
-	int status;
+	int ret;
 
 	/*
 	 * If MAX_MSG_SIZE is smaller then FIFO_SIZE, the driver won't
@@ -1398,21 +1398,21 @@ static int __init pi433_init(void)
 	 * that will key udev/mdev to add/remove /dev nodes.
 	 * Last, register the driver which manages those device numbers.
 	 */
-	status = alloc_chrdev_region(&pi433_devt, 0, N_PI433_MINORS, "pi433");
-	if (status)
-		return status;
+	ret = alloc_chrdev_region(&pi433_devt, 0, N_PI433_MINORS, "pi433");
+	if (ret)
+		return ret;
 
-	status = class_register(&pi433_class);
-	if (status)
+	ret = class_register(&pi433_class);
+	if (ret)
 		goto unreg_chrdev;
 
-	status = spi_register_driver(&pi433_spi_driver);
-	if (status)
+	ret = spi_register_driver(&pi433_spi_driver);
+	if (ret)
 		goto unreg_class;
 
 	root_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 	if (IS_ERR(root_dir)) {
-		status = PTR_ERR(root_dir);
+		ret = PTR_ERR(root_dir);
 		goto unreg_spi_drv;
 	}
 
@@ -1425,7 +1425,7 @@ static int __init pi433_init(void)
 unreg_chrdev:
 	unregister_chrdev(MAJOR(pi433_devt), pi433_spi_driver.driver.name);
 
-	return status;
+	return ret;
 }
 
 module_init(pi433_init);
-- 
2.34.1


