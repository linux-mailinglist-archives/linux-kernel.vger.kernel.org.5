Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B70C7BE720
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377751AbjJIQ54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377268AbjJIQ5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:57:54 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7359E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:57:52 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-406618d0991so44395385e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1696870671; x=1697475471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZAV/Qw52sFDXsSaIlMwU7Snqmg7zw6UPrOsGwKv28I=;
        b=Xij2wRHZ5KF7wmkX7GQJ2dIPxBy1Epr8FAvrKi2bwiEVfKZHdCcVU/T8Lt75EygD2u
         oe5rYLMJ5PoMdo9nxW3OwXWw/fbH51WHlEoJcgrE6i8t3Y7Bfnthw2A4j56PJ5/9nmKU
         vDAwZeNWLZSVBWHFs+3Cowk1wjMQP9sLR7KSvag3y8H+OkkgsafHS6+F8J7Fbq01onng
         Qd2jI3AEfaH2F0zV6KnHeGHPRNkkuL4VRbNfz5CZYkrF4CogUPEKA6mG6EK6/WTwYelK
         SatIrPdYGt+kOHtTXAsSJfK4Jd9IkEUfg5AF7lwjhZJT5w5We8WtrtxddaJRpHApGGMT
         po7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696870671; x=1697475471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZAV/Qw52sFDXsSaIlMwU7Snqmg7zw6UPrOsGwKv28I=;
        b=RlGRFHZYgCvIh15B+LVnEhbLd3g3DPj1gfrDRUTuPY+J8GRnZcYCqQIr+VHVMZiY34
         biJZvZl22ABbXR1TezAN0aNzybTSqrOFd+0TpO7046vHXKAPKYiKsC6QKy7cE7kSjxuF
         JMdRw0vBJpj8wnCS0rxRPdJ+y9zjhw4kiXSMAkBuFrCn+4d8/ZsPicuG3UIDJ9HbWe7Z
         36NC0Rcol/ZOr5s4xrSxtf7+9rgBq3+3lc2ylaN3iVuyjqM6RaQVywXyUiknULCt99aC
         RdmM6OWrNh5ijjohqhjnmP4CpMC3VowyP/qNmhwCc3QjfSOKmgSVZHhXGq+y5PZnSVhh
         mL4g==
X-Gm-Message-State: AOJu0Yz3tjLxHEZyI97buqeBfR0/DW+YhbXTuOFMBQikuwl6QRl878bl
        vQTG/hsVSwuWmgzwneP9YCS7RA==
X-Google-Smtp-Source: AGHT+IFKiN8LZgoJJqAV/SBsHALUKRZz3iXQGXq4Q/GH22ADeRnPJ9yRW8dY3+nzYECP/w1BIWaPog==
X-Received: by 2002:a7b:cb8b:0:b0:402:8c7e:3fc4 with SMTP id m11-20020a7bcb8b000000b004028c7e3fc4mr14562722wmi.30.1696870671100;
        Mon, 09 Oct 2023 09:57:51 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f49a600529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f49:a600:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id d9-20020adff2c9000000b00324887a13f7sm10199828wrp.0.2023.10.09.09.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:57:50 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] drivers/hwmon: add local variable for newly allocated attribute_group**
Date:   Mon,  9 Oct 2023 18:57:35 +0200
Message-Id: <20231009165741.746184-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009165741.746184-1-max.kellermann@ionos.com>
References: <20231009165741.746184-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the compiler to keep the pointer in a register and
prepares for making the struct field "const".

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 drivers/hwmon/hwmon.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index c7dd3f5b2bd5..e50ab229b27d 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -783,6 +783,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 	hdev = &hwdev->dev;
 
 	if (chip) {
+		const struct attribute_group **new_groups;
 		struct attribute **attrs;
 		int ngroups = 2; /* terminating NULL plus &hwdev->groups */
 
@@ -790,8 +791,8 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 			for (i = 0; groups[i]; i++)
 				ngroups++;
 
-		hwdev->groups = kcalloc(ngroups, sizeof(*groups), GFP_KERNEL);
-		if (!hwdev->groups) {
+		hwdev->groups = new_groups = kcalloc(ngroups, sizeof(*new_groups), GFP_KERNEL);
+		if (!new_groups) {
 			err = -ENOMEM;
 			goto free_hwmon;
 		}
@@ -804,14 +805,14 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 
 		hwdev->group.attrs = attrs;
 		ngroups = 0;
-		hwdev->groups[ngroups++] = &hwdev->group;
+		new_groups[ngroups++] = &hwdev->group;
 
 		if (groups) {
 			for (i = 0; groups[i]; i++)
-				hwdev->groups[ngroups++] = groups[i];
+				new_groups[ngroups++] = groups[i];
 		}
 
-		hdev->groups = hwdev->groups;
+		hdev->groups = new_groups;
 	} else {
 		hdev->groups = groups;
 	}
-- 
2.39.2

