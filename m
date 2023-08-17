Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6F377F333
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349544AbjHQJZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349561AbjHQJZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:25:36 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666432724
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:25:34 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so69486895e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1692264333; x=1692869133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RbSvzpoYud8FXP7GYgLwCUqHVr8YxqyCeoFfLHTQpA=;
        b=EBKIaD6uHatu3ECpuenVk+PU5q41V6meiTHO+mgqbRsrnABNvtfGilKX888J7xu1Yr
         a0XBGgyMSJMfTTOhTqKMc/omc46wfDEVjJNi/YHpikEj98gkqAw8VVcFGVaYZbLYYR9U
         3GjH38q8/CRv2/sTerTCY7d8ljejaMbTrGxh1MemSSRnQSURQg049ZtXX9VeKaKghhlR
         GQZcn2NMFkjONuuFGJLnN4yQq5IaKPaX8+v4cbm3d2sytFNDOWsydXY+kM3l2B9GJrjV
         33rwXNyEwyT01R2kxiu2n29dKsiwIcX2ixRKj1lPNE3N9QbvWHBAlDId6eIG+MqOJL8Y
         x7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692264333; x=1692869133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RbSvzpoYud8FXP7GYgLwCUqHVr8YxqyCeoFfLHTQpA=;
        b=WyOtxTWHXnJG2eCI1qObzFF2ZwtyAXmtYSaNOcq+L6mwmY4gSCjtDuv078uJAJybio
         fMRsu7P6qnHgiMDQp8B9Nf7CltH7GMlSAw0hyShp/xoDKLXff7FVmth6R1YsJdFi23bg
         eUw/Sj3elerRpjxEMGwAK7npcUVXOqDo6G2UEPokzh3/FDCZEYBo3nomgN1FEZ5vT+bD
         n3cmPKxB7o7EEFuhXty6TqRb2YwTUQ1VvGH/kYBEDmtVDWQvt1IVwXU3j2cKZg5PyauG
         lgnc3XOP+Q1YhJDqWWt3jqvXGumYb5cNXQ2GwvzR/x9rjhbwPvR8H7vdbBZP6MN0FfoS
         cUPQ==
X-Gm-Message-State: AOJu0YyEvGeUvMhMacGJ9v1xZ11lF09V54mQ9e8gmcrgStKHeW/rdhRu
        yKh8u2fP0AmeMdFAIK7T7XnGHQ==
X-Google-Smtp-Source: AGHT+IGhyCxgx8JdXYe6FXcaqCt52k8fm6b5/iHkfpRZILf7HomCeA965oYnuSpKRjYR0eCUpoMv1Q==
X-Received: by 2002:a1c:6a14:0:b0:3fc:27:7e46 with SMTP id f20-20020a1c6a14000000b003fc00277e46mr4682206wmc.3.1692264333007;
        Thu, 17 Aug 2023 02:25:33 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id x10-20020a05600c2a4a00b003fc00892c13sm2227934wme.35.2023.08.17.02.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 02:25:32 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hwmon: pmbus: Drop unnecessary clear fault page
Date:   Thu, 17 Aug 2023 11:25:25 +0200
Message-ID: <20230817092527.808631-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817092527.808631-1-Naresh.Solanki@9elements.com>
References: <20230817092527.808631-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

The pmbus_check_byte_register function already calls clear
fault page, so there's no need to do it again in
pmbus_identify_common.

TEST: Verified using an I2C bus analyser to confirm that only
      one clear fault page is being send instead of two in a row.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index cbfabdd69056..1363d9f89181 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2541,7 +2541,6 @@ static int pmbus_identify_common(struct i2c_client *client,
 		}
 	}
 
-	pmbus_clear_fault_page(client, page);
 	return 0;
 }
 
-- 
2.41.0

