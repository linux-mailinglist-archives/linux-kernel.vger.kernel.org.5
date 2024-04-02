Return-Path: <linux-kernel+bounces-127836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4DB89518F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2B41C22168
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF714757FB;
	Tue,  2 Apr 2024 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAT5AWe2"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687D36996A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056473; cv=none; b=YFaS+wRVZyUCzpd0Km1O5gmySoL8zHySQp47p35Dm6y4y9h8+EAC0wqOwTs34QQIzKx6TsvcyVI3s1LQrvFsQ/Qbjhq6tn3WRUfsg59VV+smTJeW3y8feiMFADAUSbNAo/UvE29uI+xu2VpRwmS5vHz3wBTDYNzmbmSn9nmud+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056473; c=relaxed/simple;
	bh=HjRvMGXjDbwDSvM16WAhK4wPegt0yyIWO/1j4Z95mjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NjhgJ98W0bqr3+XQuRzvT9eBaDu2QnJELoZpZF2efFjibKezvSkIYKTz6JiXhwvdADnoLMRMkl7G70TlEyFPqFAJ3UxFFs647Apq+JQ38ne/1fMCxF+8fjcsBgBajnHveHfzKysWWvHE4XM5cmI8KW2BAD3QeiKHaiBmZLdpYxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAT5AWe2; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6991b50e2b3so2403636d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 04:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712056471; x=1712661271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJrpsii5KxAd/+yN0rzfHDl19GAcoZcZzgV5GRtFABE=;
        b=JAT5AWe2nZxSvKyyo2YpAfq5ke30uGTWqXnQUMxXleDP0ZjJlLkP2f5gnuzZVng9ie
         Zm2CM6mSS7LX0R1cFKJ/3hbHGyOkbkml0qvObdt/Lbqf56DvuV8CsruV6Cm7CV5ptqo8
         RkSIHjqIoJ841q8qOKPrqe9C0kJevzfTFdV7Q9z5u7gSeTozfyx9EF9ouLKY+N6150oa
         D2hwIv4s1m3CtvOTv0ThP2gxYJPbbu576hRs4TuIQ1lkl/yc1tAv3iWnwYraOQS5NrUl
         7/u5WhHvrm9QsnwS1h2hBG2M9oTtg15jzKHGarrkkr9cS7LgSD0sVPgdFCJqgwJm+HGe
         3Dxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712056471; x=1712661271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJrpsii5KxAd/+yN0rzfHDl19GAcoZcZzgV5GRtFABE=;
        b=jS8sj9XCc1j5O1y0A4+mepT+rh+3oR+C7sFx1YEbRbbOAAqkhUvmmul2G2WaaEZ/in
         R7YPr50XctP7L8mGEfEIEWCKZ8tXdl65an6VA+IsTF7x88zuDWOTZ1RtaVAasa4OqFAx
         Rqnrdw6IiQdasPPMhJaQEMPTRG4ZawDpzegiQz/rrMKq3xfkDuS8gloIlyBcjsKAoFLp
         tPg7thH/tbgp66CpePJxuQqv2bySVxBnS+mxhQUrnYyscDhbr/D5erd1mXeV614Se+9A
         J55ZgMikzJAKKEWwBBaMw9Iz3I+0/vzt1PMLuCqp/XFaAw21+NaKsFgcWMB0gmWbs+dw
         wcjw==
X-Forwarded-Encrypted: i=1; AJvYcCXhvpCHqdwFsxfSVfFATjX6AFobMX2Ncm+A4lBM+G3CrrOSQSVK4xNZsfGC9PyikXAVQzNSjqlTWAjedps51+QM9DOWiTQwZADqF68n
X-Gm-Message-State: AOJu0YyLbcYoDMc7GvxLY3Ks2r8tEkUkGqikqj/M9kQOFxyUwNIjYOuo
	3OKSvvZ1klI/fO0K9ryVMjETnmLhfaReHmGgnCTm+aTQl468Qv0n
X-Google-Smtp-Source: AGHT+IF+fzJLuXaGOfACwLIziHCh2KfismoKuF2DlR8MVTa2dSbqg37YPm3Lu8RyXS7XIz2TLdqRwA==
X-Received: by 2002:a0c:ecc4:0:b0:699:21a9:8ecd with SMTP id o4-20020a0cecc4000000b0069921a98ecdmr196674qvq.5.1712056471307;
        Tue, 02 Apr 2024 04:14:31 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:737b:ef00:2c6f:6cdc:f641:6ecf])
        by smtp.gmail.com with ESMTPSA id 11-20020a05621420cb00b006968a6fb010sm5428855qve.91.2024.04.02.04.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 04:14:30 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	felixkimbu1@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] staging: pi433: Rename "pi433_dev" of type "dev_t" to "pi433_devt"
Date: Tue,  2 Apr 2024 14:14:12 +0300
Message-Id: <20240402111414.871089-5-ikobh7@gmail.com>
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

Distinguish struct device type instances from dev_t instances
to enhance readability.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 208c0c6d3649..62ce75b07bf0 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -53,7 +53,7 @@
 #define FIFO_THRESHOLD	15		/* bytes */
 #define NUM_DIO			2
 
-static dev_t pi433_dev;
+static dev_t pi433_devt;
 static DEFINE_IDR(pi433_idr);
 static DEFINE_MUTEX(minor_lock); /* Protect idr accesses */
 static struct dentry *root_dir;	/* debugfs root directory for the driver */
@@ -1262,7 +1262,7 @@ static int pi433_probe(struct spi_device *spi)
 	}
 
 	/* create device */
-	pi433->devt = MKDEV(MAJOR(pi433_dev), pi433->minor);
+	pi433->devt = MKDEV(MAJOR(pi433_devt), pi433->minor);
 	pi433->dev = device_create(&pi433_class,
 				   &spi->dev,
 				   pi433->devt,
@@ -1276,7 +1276,7 @@ static int pi433_probe(struct spi_device *spi)
 	} else {
 		dev_dbg(pi433->dev,
 			"created device for major %d, minor %d\n",
-			MAJOR(pi433_dev),
+			MAJOR(pi433_devt),
 			pi433->minor);
 	}
 
@@ -1398,13 +1398,13 @@ static int __init pi433_init(void)
 	 * that will key udev/mdev to add/remove /dev nodes.
 	 * Last, register the driver which manages those device numbers.
 	 */
-	status = alloc_chrdev_region(&pi433_dev, 0, N_PI433_MINORS, "pi433");
+	status = alloc_chrdev_region(&pi433_devt, 0, N_PI433_MINORS, "pi433");
 	if (status < 0)
 		return status;
 
 	status = class_register(&pi433_class);
 	if (status) {
-		unregister_chrdev(MAJOR(pi433_dev),
+		unregister_chrdev(MAJOR(pi433_devt),
 				  pi433_spi_driver.driver.name);
 		return status;
 	}
@@ -1414,7 +1414,7 @@ static int __init pi433_init(void)
 	status = spi_register_driver(&pi433_spi_driver);
 	if (status < 0) {
 		class_unregister(&pi433_class);
-		unregister_chrdev(MAJOR(pi433_dev),
+		unregister_chrdev(MAJOR(pi433_devt),
 				  pi433_spi_driver.driver.name);
 	}
 
@@ -1427,7 +1427,7 @@ static void __exit pi433_exit(void)
 {
 	spi_unregister_driver(&pi433_spi_driver);
 	class_unregister(&pi433_class);
-	unregister_chrdev(MAJOR(pi433_dev), pi433_spi_driver.driver.name);
+	unregister_chrdev(MAJOR(pi433_devt), pi433_spi_driver.driver.name);
 	debugfs_remove(root_dir);
 }
 module_exit(pi433_exit);
-- 
2.34.1


