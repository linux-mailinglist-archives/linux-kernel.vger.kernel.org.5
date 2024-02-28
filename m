Return-Path: <linux-kernel+bounces-84710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA8386AA89
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B8E286F98
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682EA2D61B;
	Wed, 28 Feb 2024 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgAsXEG8"
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497172D05E;
	Wed, 28 Feb 2024 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110577; cv=none; b=TEXTBlskHwnqVlym4IsEgAqkJwecPZKRQGKtxA6j0kg/oy8a+YcD+hG8l6wOLs7UWklcrkJRgYHUOwYhkG59TT1hbbg5meteJLNkTcbrTf8/LmhPmnm2Uwyv5WPz/X0Ck7eNnvWvcvyAn7PVmPqgfJ+U5ruU+cTNwhBDXq0g5ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110577; c=relaxed/simple;
	bh=KnCLIruDxEpjkUu0iXN6aDRoox5VEzg/DiTLHq/fZDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hWd6I0eyL2PWhHJ2uDVJnTxuQN8RYqC5nOjACN0OwzXrGSijaD0tO2jtG2et4z5ubMQufDGbrQoRIS2/1SxQd6g0+QrwFaaUZY0ox3lYPJWd1U808b9Z1bWQpJA5EIKsJuVeOIcqbU4W2hRN+p2J7FsDwqMmR6R7bufWI/6y2oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgAsXEG8; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-29ae4c7da02so1143423a91.2;
        Wed, 28 Feb 2024 00:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709110575; x=1709715375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wlOULTxMbvpLMCDfp4Qmeh52Tzs4NQhllgCjZFw527c=;
        b=jgAsXEG83idPqOlm+U7SpMbMFvhTzNfRK4e6kdvOUgGvmQbnnHB5ZBISuFG41vNf2S
         zm0kBnJctRqHonG6a0ewtzVTOngg7QB29vXSLls/yLSlPqRK1AlJx924QJ0dM1b4oTp5
         m1eQXJOySoWYTBB4Rep1beapX/Sy1SqwIbFkbAB8iEuKr3fe3j2AxpjSpiV2cXlBE/N2
         xBsTaq+ahhMhzqkjNPYEF4NtWXhQMPu0tccEl4sMOOHIZ/yQfcbqYmxXUfGFePUvhV0l
         gZBe0ZeJR+m8Oajjjk7gaS0RmPHmgE0IFum0HXEij+8PWjgK/77YCSDdn3n7p0kGDyJP
         +xRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709110575; x=1709715375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wlOULTxMbvpLMCDfp4Qmeh52Tzs4NQhllgCjZFw527c=;
        b=Ka/obh99plyuyb9vXKxAzzl3IWsGuBScoemhyfxrW5ujcrubo/qhGZQ8UfQGYqPMLN
         RRBcTIdMlsvzplFdYWN20dVOJzafzC5f7BI5D5+nWAIIT1lSLjBNkK64tYYjyY06kFAa
         2BWE2pX1RK2JMnY7UtVq26O6bX8sZB5+/qzzO7aE2QvjxOa7aXBLNq2fFnk5l0mA2Vvk
         ZPlXRNqoKOKRaRJdXyJGfIchTi3kz2SQm8pra/lS/5MMxKsK+R33q8881jCBN2IbptbU
         n2KPMd2pwLhv6vYxrnYs+ybVBKgFqwlcTIRRcthdFQAfGt9SNQapx19bQYrRbGH7Zrt6
         QUUA==
X-Forwarded-Encrypted: i=1; AJvYcCV0fS7Yvt6E6njAW1QeCZqBhu5GCaZV+4jUpyPG0vpQCZo+O8HjwRuPSQ4PDMpGS8M/creDopE7PRf6Qhdq5RD8qoZk3TvbOz07diye
X-Gm-Message-State: AOJu0YyFUQexxJPhNApFCXy4xvu6d+W2gqd+JlYww7hxM6cEdLF/shJ/
	glGnl0Wdk4QDGZjaNraw/ClJ4dCBVKNJV6xcX8mTYN7QrW2D4WkNGorX794PysZU5Q==
X-Google-Smtp-Source: AGHT+IFTJFoftwAp3pG6GasgEPLGKVzetJoo+P2a7Zg5f2r103TFdttVGWQPlmOkrXJ50FLw0oCLZQ==
X-Received: by 2002:a17:90b:4f84:b0:29a:f9ad:a096 with SMTP id qe4-20020a17090b4f8400b0029af9ada096mr263672pjb.35.1709110575452;
        Wed, 28 Feb 2024 00:56:15 -0800 (PST)
Received: from ubuntu.localdomain ([156.245.137.3])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090ac88b00b002994f848bc9sm993985pjt.43.2024.02.28.00.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 00:56:15 -0800 (PST)
From: buckzhangwh@gmail.com
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	weihui zhang <buckzhangwh@gmail.com>
Subject: [PATCH] drivers:usb:disable usb hub&port async suspend
Date: Wed, 28 Feb 2024 00:56:07 -0800
Message-Id: <20240228085607.3275-1-buckzhangwh@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: weihui zhang <buckzhangwh@gmail.com>

we prepare 30 mobile phones only for usb plugg in and out.
testers plug USB in and out very frequently after phone in deep.
Repeat the test again and again,some phones are crashed.
our analysis：
We analyze ten kernel-dumps,we found something common kernel is blocked.
pasre in crash,all the dump are directed to usb(device port/hub).
here is a kdump,task 446 &365&4511 are UN.
446:
... ->|kobj_attr_store
          |state_store
            |pm_suspend
              |enter_state
                |suspend_devices_and_enter
                 |dpm_resume_end
                   |dpm_resume
                    |dpm_resume
                     |async_synchronize_full
                      |async_synchronize_cookie_domain
                       |schedule
446 is waiting for 365&4511,no doubtful usb thread.
here is some warning log:
[83.958310] musb device disconnect detected from VBUS GPIO.
.........
[84.908017] musb device connection detected from VBUS GPIO.
[84.911946] typec port1-partner: parent port1 should not be sleeping
task 365 & 4511:
.. ->worker_thread
       |process_one_work
        |async_run_entry_fn
          |async_resume
            |device_resume
              |dpm_wait_for_superior
                |wait_for_completion
                  |wait_for_common
                     |schedule_timeout
I guess usb async resume/suspend are disordered,So I try to disable.
After that,we tested the case for a month,the bug never happened again.
the fn device_enable_async_suspend set the dev->power.async_suspend= 1.
dev->power.async_suspend=1&pm_async_enabled=1,fork task like 365
   ---> dpm_resume
           |dpm_async_fn
             |async_resume  
dev->power.async_suspend=0,disable async
     --->dpm_resume
            |device_resume
              |call device resume fn.
here is a demo:
Only few devices such as scsi/pci/usb call device_enable_async_suspend.
but scsi call device_disable_async_suspend at drivers/scsi/hosts.c

Signed-off-by: weihui zhang <buckzhangwh@gmail.com>
---
 drivers/usb/core/hub.c  | 2 +-
 drivers/usb/core/port.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index e38a4124f..de74f70e5 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2602,7 +2602,7 @@ int usb_new_device(struct usb_device *udev)
 		add_device_randomness(udev->manufacturer,
 				      strlen(udev->manufacturer));
 
-	device_enable_async_suspend(&udev->dev);
+	device_disable_async_suspend(&udev->dev);
 
 	/* check whether the hub or firmware marks this port as non-removable */
 	set_usb_port_removable(udev);
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index c628c1abc..97696c415 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -760,7 +760,7 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 	pm_runtime_set_active(&port_dev->dev);
 	pm_runtime_get_noresume(&port_dev->dev);
 	pm_runtime_enable(&port_dev->dev);
-	device_enable_async_suspend(&port_dev->dev);
+	device_disable_async_suspend(&port_dev->dev);
 
 	/*
 	 * Keep hidden the ability to enable port-poweroff if the hub
-- 
2.17.1


