Return-Path: <linux-kernel+bounces-60553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5621F8506A1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB8ACB220C0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AFF5FEF9;
	Sat, 10 Feb 2024 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwgLb6wL"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0871E604C6;
	Sat, 10 Feb 2024 21:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707602001; cv=none; b=el5cACoWlvvStaLxZtno73YPr7Pw8E6japp8d1wMbJ0CnveV8xQsGfCIhVsE4BEdy9CmPU6ihscnCmV0WUIrvRGVd2+Pvbcxtu8woInuMyZitanLOO8ZYaH1xCKpQM+xmEVkou0mAI0VYMjSo/nZIl5s0pkKznDNyegB2UQ2TTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707602001; c=relaxed/simple;
	bh=QeLwyWmd7NPkYXcDqCuEyzt6u/pRusg8+Tyv90sqj9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rK1aMV46caM386ykDvZ7MDricHYmrDf1Tj+eedTqMUGAeGUv9mBQDy9zi6zOlL4s71v3M+qfOiVk4GuoI7QOg+RJcxOAT/LUfMWzYnxBJWNAjN3yOzrhN/QjAamVLxvVgPo2O6GSCPNwbaL0bavzZIunfWnNPpKohtG5ZJl650Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwgLb6wL; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51167e470f7so2601295e87.2;
        Sat, 10 Feb 2024 13:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707601998; x=1708206798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMdjM6y7kF9azHHy8v2BrI6Kc/oC+WGprWIMEkx9WQo=;
        b=FwgLb6wLlvmf4AbLRG2XQnG3fZaTplWO7W4OQfyDYcYY3k5Zt0xdD7IoqbNaFj0D7t
         V/abVZiBk19xt5q+K4l88sbN8809wf7shnol/aH2WDUMY7+K2++jFm8iMNQ4tck79Y7y
         XeYoqKpudej7Kubb0+dVhYksRfPELqu33odHaWSlk5xazBYykoAXCDpGfQ6sh90j+mhh
         1atXVaLsg09zgxuUapKv2jT8zHKWrKKjrgh/MRDSrNtaeWOh7p12DaD9AqYnSobiTRpW
         UkmqWOOYMfOldLGZRKSJO/LoBlTcFnxaGeD4KtMyo/8kUSbljTB6Q4JL2xlKzCjfDqrn
         0I0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707601998; x=1708206798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMdjM6y7kF9azHHy8v2BrI6Kc/oC+WGprWIMEkx9WQo=;
        b=SZFdCjyXDtZenMOpTsvyalmwJMX9hlyWuB1ZKhPplVD4HRBR2gq6GmanLpkhN7NMWK
         JToVigakLSs6dRolgHk++qb6Pu/Mnolu/rrz/FfjLc47lAUJEm+Zyc+HIFDLJYKo2eSU
         5hb/Pyc+FyjvoMD9nHPea37QAGN0ewiYnMz+nSJBpm8CFUSKK7sWuJpXxheava6GvP2U
         eeMfomJ9CsI5X5jlsQnc/GtzTL5hHYV0G0ddeFUH5yozsGi8i1o36pAVPrdel9uyRbl/
         3A9kjGbgYtY/Kta760WXBMFUn6V8lxOicNQZ15fUbBjbAA7+W0wJfI4ND2XPQhyKdQPy
         NqzQ==
X-Gm-Message-State: AOJu0YyRrHZ8VLoksVkE/tfqeqwDAZjqsH1+LQaTNJnGLDGjcCdriXJB
	0rYrLHmSEcytaZzBsyFKOcWEVgAaa+WVrbP0739RRxoP/I+Ox/Oa
X-Google-Smtp-Source: AGHT+IFBl89sLOcwTVbtEV5d6hlD62y9BvFRoAZgG0bWrj4BGKt0p7O63PX1FsOqis+J/DKKUFw/oA==
X-Received: by 2002:a19:f805:0:b0:511:5361:20df with SMTP id a5-20020a19f805000000b00511536120dfmr1790854lff.13.1707601998077;
        Sat, 10 Feb 2024 13:53:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW9FrSZtrtzkAYHkZCEv3npM/qj+QrBYwEKI8UB4dCsHfGDISwwAfwY2sPB+uLw5CLe4fZiEDQnsE+n3cstkOHzNmPMACy5+6qxflVGGXjrTQ5k5qlyyRafvbqxCyOWOAx3xlMd0WBH/mV+VPkm2GvC75yjeG0LsKAKxaM4rj/2PIzrSckFQZpVZuJTM93uKYxGjhqL+y16/SZR4yfJixuvZ3xnOPr5NRNG5yzuY7q9chpOceV/2WJN42SIcGZtQTo8mcZ5FBACT9kDQc4Q8RS4lK2mxhU1wkdyZ9vYAO3ypnPgDgmRf69zFCjydoU13lbwq1Qi5kAs2uXJ3C2efK4SswCQOSRnauw4bWji7MRIAK1vcWAAFA==
Received: from m2.. (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.googlemail.com with ESMTPSA id a7-20020a19ca07000000b0051189b53f93sm24005lfg.302.2024.02.10.13.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 13:53:17 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: chrysh@christina-quast.de,
	daniel.beer@igorinstitute.com,
	jikos@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	johan@kernel.org,
	gregkh@linuxfoundation.org,
	equinox@diac24.net,
	michael.zaidman@gmail.com
Subject: [PATCH v1 06/19] hid-ft260: uart: enable wakeup workaround
Date: Sat, 10 Feb 2024 23:51:34 +0200
Message-Id: <20240210215147.77629-7-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240210215147.77629-1-michael.zaidman@gmail.com>
References: <20240210215147.77629-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FT260 has a "power saving mode" that causes the device to switch
to a 30 kHz oscillator if there's no activity for 5 seconds.
Unfortunately, this mode can only be disabled by reprogramming
internal fuses, or external eeprom if exists.

One effect of this mode is to cause data loss on an Rx line at baud
rates higher than 4800 after being idle for longer than 5 seconds.

We work around this by sending a dummy report at least once per 4.8
seconds if the UART is in use. But it is not acctivated in the
"[PATCH v4 RESEND] hid-ft260: Add serial driver"
https://lore.kernel.org/all/20231218093153.192268-1-contact@christina-quast.de/

It causes data loss on the Rx line at the driver's default 9600 baud rate.

Enable periodic dummy report to prevent data loss on Rx line upon exiting
from power saving mode.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 3d6beac0b8b6..19599e64c6be 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1575,7 +1575,7 @@ static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device *dev)
 	INIT_WORK(&dev->wakeup_work, ft260_uart_do_wakeup);
 	// FIXME: Do I need that if I have cancel_work_sync?
 	// FIXME: are all kfifo access secured by lock? with irq or not?
-	dev->reschedule_work = false;
+	dev->reschedule_work = true;
 	/* Work not started at this point */
 	timer_setup(&dev->wakeup_timer, ft260_uart_start_wakeup, 0);
 
-- 
2.40.1


