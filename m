Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CD47DA7F2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 18:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjJ1QEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 12:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1QEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 12:04:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A39E1;
        Sat, 28 Oct 2023 09:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=eSKhnAArEdJ0K2lY6fWY7BVlQz2sRRzxT30U8f6o7W4=; b=YjV4h4/kQ81uUu8OE7ZkPEDJq+
        6ooH46Hz62+KmbbnRO78qSEL/ogehoEiyM8mf/tFt5TDe/sdYSM6qjn7FdIFgK9gRz96uGyCKnebv
        vUiqIL2EEgDcWXGpx2FnOXnl3iqYNHWNoltpD0YNMVzKyrBI7YQtB3Ry2GmU+62XuB6p4KIYwqCxJ
        OBtnPk9v2fDlEYYGqIn8RPRSqB11G1l3tui8ing4gcZidvogpUt9N++e3mtpkafFcHW0Woa2+K2S8
        wPyKAvWTrvCF8gUce3YIle4dKFtzxJAriKL/+J5xAD6AqFLTP1/2vN0piZ2CKathWO/5noAtISVa1
        uRmh1pvg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qwln8-000dFK-2i;
        Sat, 28 Oct 2023 16:04:03 +0000
Message-ID: <36e87cdb-9341-4e86-a1ad-dc2d1d105fa8@infradead.org>
Date:   Sat, 28 Oct 2023 09:04:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: core: Add option to prevent disabling unused
 regulators
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org
References: <20231028102423.179400-1-javierm@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231028102423.179400-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/28/23 03:24, Javier Martinez Canillas wrote:
> This may be useful for debugging and develompent purposes, when there are
> drivers that depend on regulators to be enabled but do not request them.
> 
> It is inspired from the clk_ignore_unused and pd_ignore_unused parameters,
> that are used to keep firmware-enabled clocks and power domains on even if
> these are not used by drivers.
> 
> The parameter is not expected to be used in normal cases and should not be
> needed on a platform with proper driver support.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>  Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
>  drivers/regulator/core.c                        | 17 +++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0a1731a0f0ef..91b58d767c2c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5461,6 +5461,13 @@
>  			print every Nth verbose statement, where N is the value
>  			specified.
>  
> +	regulator_ignore_unused
> +			[REGULATOR]
> +			Prevents the regulator framework to disable regulators

			                                 from disabling regulators

> +			that are unused due not driver claiming them. This may

			                    no driver claiming them.

> +			be useful for debug and development, but should not be
> +			needed on a platform with proper driver support.
> +
>  	relax_domain_level=
>  			[KNL, SMP] Set scheduler's default relax_domain_level.
>  			See Documentation/admin-guide/cgroup-v1/cpusets.rst.
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 3137e40fcd3e..220034ff0273 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -6234,6 +6234,14 @@ static int regulator_late_cleanup(struct device *dev, void *data)
>  	return 0;
>  }
>  
> +static bool regulator_ignore_unused;
> +static int __init regulator_ignore_unused_setup(char *__unused)
> +{
> +	regulator_ignore_unused = true;
> +	return 1;
> +}
> +__setup("regulator_ignore_unused", regulator_ignore_unused_setup);
> +
>  static void regulator_init_complete_work_function(struct work_struct *work)
>  {
>  	/*
> @@ -6246,6 +6254,15 @@ static void regulator_init_complete_work_function(struct work_struct *work)
>  	class_for_each_device(&regulator_class, NULL, NULL,
>  			      regulator_register_resolve_supply);
>  
> +	/*
> +	 * For debugging purposes, it may be useful to prevent unused
> +	 * regulators to be disabled.

	              from being disabled.

> +	 */
> +	if (regulator_ignore_unused) {
> +		pr_warn("regulator: Not disabling unused regulators\n");
> +		return;
> +	}
> +
>  	/* If we have a full configuration then disable any regulators
>  	 * we have permission to change the status for and which are
>  	 * not in use or always_on.  This is effectively the default

HTH.
-- 
~Randy
