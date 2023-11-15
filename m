Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B127EC422
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjKONyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjKONyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:54:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B231EAF;
        Wed, 15 Nov 2023 05:54:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12847DA7;
        Wed, 15 Nov 2023 05:54:48 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBC473F641;
        Wed, 15 Nov 2023 05:54:00 -0800 (PST)
Message-ID: <92d6a66d-3270-3378-2ab9-9214c004d5c7@arm.com>
Date:   Wed, 15 Nov 2023 13:53:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/7] coresight: tpiu: Move ACPI support from AMBA driver
 to platform driver
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20231027072943.3418997-1-anshuman.khandual@arm.com>
 <20231027072943.3418997-5-anshuman.khandual@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20231027072943.3418997-5-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/10/2023 08:29, Anshuman Khandual wrote:
> Add support for the tpiu device in the platform driver, which can then be
> used on ACPI based platforms. This change would now allow runtime power
> management for ACPI based systems. The driver would try to enable the APB
> clock if available.
> 
[...]
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id tpiu_acpi_ids[] = {
> +	{"ARMHC979", 0}, /* ARM CoreSight TPIU */
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, tpiu_acpi_ids);
> +#endif
> +
> +static struct platform_driver tpiu_platform_driver = {
> +	.probe	= tpiu_platform_probe,
> +	.remove	= tpiu_platform_remove,
> +	.driver = {
> +		.name			= "coresight-tpiu-platform",
> +		.acpi_match_table	= ACPI_PTR(tpiu_acpi_ids),
> +		.suppress_bind_attrs	= true,
> +		.pm			= &tpiu_dev_pm_ops,
> +	},
> +};
> +module_platform_driver(tpiu_platform_driver);
> +

Is there a special build config where this works? I get an error here
because module_platform_driver() redefines things that are in
module_amba_driver() which is defined above:

  module_amba_driver(tpiu_driver);

This isn't a W=1 build or anything, just a normal one. And it applies to
most of the patches in this set.

