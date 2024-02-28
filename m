Return-Path: <linux-kernel+bounces-84596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 247A986A8CC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75D79B2288F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D7924A05;
	Wed, 28 Feb 2024 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq4dQWNV"
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADF821101;
	Wed, 28 Feb 2024 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709104843; cv=none; b=DrHpmcwFEM9TIkNYZ9QngNwW8lId1wIY7YdA9Um+CFZuU8zRxt2BJ8fX6Ehey9fAQFg8wUCwaSBhjz7RffrmxVhYmLTLfruXJ41432WcFo8CMYsSUG/GIYqu9Lu6sUSJOb2U8snhhHJNO/TCBK/cVd8uu2RzWiuPQgN0hPEYWcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709104843; c=relaxed/simple;
	bh=KnCLIruDxEpjkUu0iXN6aDRoox5VEzg/DiTLHq/fZDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VgGNhz3S1jVW+Fh8d6TS/Ez6GaCJ1HkHp6kVKRLXk0OXAtohWe0Zl814nfyn7kieL2K15HKXXZvHuleVlAZkj2wQM+y0YAesmA7Elmc+FbhOjwAcZPW3DwM8vqDldp5DZKtI8AgRmtHv04uM5BqFzLC68F5YY4h9lA1v07885Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aq4dQWNV; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-29a6dcfdd30so3660881a91.0;
        Tue, 27 Feb 2024 23:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709104841; x=1709709641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wlOULTxMbvpLMCDfp4Qmeh52Tzs4NQhllgCjZFw527c=;
        b=aq4dQWNVd+ClV/swVk0pBJeCb+ukyZv5RKwPrhWJISiGpnY/agOWl67pfNTfh8qkLy
         +hzjZRl1DHU0c67Eg37k4cvpJmJUxnl89N0GsQn2p6zjKsrZm1YqtjAodhMXK2RQK98S
         LTrHW8UajCpJEwdZDy9bOWwH1w4vjIGVPUmz+atP8IpTw5vkRG9GEqS2SotlwnTJtYo2
         PgLDuT4DGzG9wHVUiFy/UMCo3buiFZ6d/z/gbB3Ejw2tz1YHjd4i097wvMdk2bkwDUAx
         0xBEo8dzgBdJDatwH690gr7GrggNZRHMzbPcLVy6dUXPSnJoEBX9lVtp47MROmBMHHJ0
         PyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709104841; x=1709709641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wlOULTxMbvpLMCDfp4Qmeh52Tzs4NQhllgCjZFw527c=;
        b=EEyfwJHx1aLCpV25VD/zbIKCMGsmkuYB11C/W7625ylEQy6IJ92EUW1rhtMgU34XO1
         IGPoNUnkqYoxrRZNQcTjmilC2EywgNuhUvXjtH8/1zxnmh+mxzqTy6DatYYBoD7aevdK
         pNw2jcbmrNBgJejPspdOUP+t/QJRWCw9VmyHUE20J3o4xVQkAPUVnVhHOMsT6bbxVNYQ
         7sWvgc8vxGdHc9+OceHFFk3+3iQZKH0SO2BUVHmkFh9HgOkutnuEvRhrKAgrnJsRMjPr
         HYzpLKYHX5bNR7ifzy9PzRE7JStrWKt2op2D39mrQ9+MVCBGA+lRbN8jyWZbMHiIxZ32
         qoAg==
X-Forwarded-Encrypted: i=1; AJvYcCVz96PL16DF2arfjjFuWk8oyHf+afNWm5bDpNsStjWZKxTMU0NJt45SYmaWvGApUGLxrqgQFWYd3rKfFcP7cBBQ5BdaA9aYBYVff5pv
X-Gm-Message-State: AOJu0YwXnm5ygqg+945Ga8obrqAbwMINkoaMtL3nEAB/y7J9+iG5ST12
	NFNIj3Z8mJveulw7fPqH+uhs/xDIc9i/xQ0vbsqWoo/lRDHAyV6dfliiuyVLu0w=
X-Google-Smtp-Source: AGHT+IGrMIlgQk6knPFAPHdqNl3j57NnQs89JhWyZugjGOssKaqBgvYiudwHM+ilo/CyzdezvoXf7w==
X-Received: by 2002:a17:90b:484:b0:29a:638c:620c with SMTP id bh4-20020a17090b048400b0029a638c620cmr10984328pjb.43.1709104839299;
        Tue, 27 Feb 2024 23:20:39 -0800 (PST)
Received: from ubuntu.localdomain ([103.235.17.227])
        by smtp.gmail.com with ESMTPSA id bh6-20020a17090b048600b0029951d04dc4sm799088pjb.54.2024.02.27.23.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 23:20:38 -0800 (PST)
From: buckzhangwh@gmail.com
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	weihui zhang <buckzhangwh@gmail.com>
Subject: [PATCH V2] drivers:usb:disable usb hub&port async suspend
Date: Tue, 27 Feb 2024 23:20:30 -0800
Message-Id: <20240228072030.2470-1-buckzhangwh@gmail.com>
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


