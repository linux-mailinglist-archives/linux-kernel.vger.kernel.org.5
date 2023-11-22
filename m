Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE7B7F4569
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344011AbjKVMK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343932AbjKVMK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:10:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90D6F1BB;
        Wed, 22 Nov 2023 04:10:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D6391595;
        Wed, 22 Nov 2023 04:11:11 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC93E3F7A6;
        Wed, 22 Nov 2023 04:10:22 -0800 (PST)
Date:   Wed, 22 Nov 2023 12:10:20 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 4/7] coresight: tpiu: Move ACPI support from AMBA driver
 to platform driver
Message-ID: <ZV3vrE6tCBWupwJM@bogus>
References: <20231027072943.3418997-1-anshuman.khandual@arm.com>
 <20231027072943.3418997-5-anshuman.khandual@arm.com>
 <92d6a66d-3270-3378-2ab9-9214c004d5c7@arm.com>
 <268e1605-fe3f-4aa0-92e3-36ddfc8aacb3@arm.com>
 <ZV3kVhZYBHwSaPr9@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV3kVhZYBHwSaPr9@bogus>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:21:58AM +0000, Sudeep Holla wrote:
> On Wed, Nov 22, 2023 at 12:32:33PM +0530, Anshuman Khandual wrote:
[..]

> > Although, AFAICT, have not seen these before - even on the defconfig.
> > Just to work around this problem, there can be a common module_init()
> > /module_exit() to register/unregister both AMBA and platform drivers,
> > similar to etm4x_init()/etm4x_exit() setup in coresight-etm4x-core.c.
> 
> Could this be the reason why I am seeing the below error why booting with
> ACPI ? I wanted to check the tables before I comment but this discussion
> made me think it could be the reason, hence posting this before I got time
> to analyse it.
> 
>   |  coresight-tmc-platform ARMHC97C:00: can't request region for resource [mem 0x20010000-0x20010fff]
>   |  coresight-tmc-platform: probe of ARMHC97C:00 failed with error -16
>   |  coresight-tmc-platform ARMHC501:00: can't request region for resource [mem 0x20070000-0x20070fff]
>   |  coresight-tmc-platform: probe of ARMHC501:00 failed with error -16
> 

Scratch that, it didn't help. This error I am seeing is not related to
the issue reported here. I tried a hack below, it didn't help.
 
Regards,
Sudeep

-->8
diff --git i/drivers/hwtracing/coresight/coresight-tpiu.c w/drivers/hwtracing/coresight/coresight-tpiu.c
index ea8827d289ca..f6ba350b3777 100644
--- i/drivers/hwtracing/coresight/coresight-tpiu.c
+++ w/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -254,8 +254,6 @@ static struct amba_driver tpiu_driver = {
        .id_table       = tpiu_ids,
 };

-module_amba_driver(tpiu_driver);
-
 static int tpiu_platform_probe(struct platform_device *pdev)
 {
        struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -297,7 +295,21 @@ static struct platform_driver tpiu_platform_driver = {
                .pm                     = &tpiu_dev_pm_ops,
        },
 };
-module_platform_driver(tpiu_platform_driver);
+
+static int __init tpiu_init(void)
+{
+       amba_driver_register(&tpiu_driver);
+       platform_driver_register(&tpiu_platform_driver);
+       return 0;
+}
+
+static void __exit tpiu_exit(void)
+{
+       amba_driver_unregister(&tpiu_driver);
+       platform_driver_unregister(&tpiu_platform_driver);
+}
+module_init(tpiu_init);
+module_exit(tpiu_exit);

 MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
 MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");

