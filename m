Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7657DDC2B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 06:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347593AbjKAE5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 00:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347588AbjKAE5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 00:57:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B3710F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 21:57:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D96C433C7;
        Wed,  1 Nov 2023 04:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698814629;
        bh=WZ7SUIOWohN5AEnVEnPROIft0gHOpjrwRA4R5V62NE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IZGqMAS8v8/526lxoxoktvLI3XNOUSOSE75EPfqiMj1gam1kF/FoZg5cXgRgXMBlA
         MGm2y+ovkUifXYrOYOeMT6MnYgkUjKL7sZztMV8pGCqWHJ2pAtZipPVEYPYoZD7TXB
         WxYPiB7FlXGiRp9X6JSTnsCdezN4aV8cifhL/kTpRK9Nr9Db2Ze8ySe0zgCmehimff
         sE4QGX0dV1u4eevQVpiYOlHI6QYaCxINZe8AUBFqBOIv1aXkgyyRoL5JYqIEG8qkSt
         zYPLpRRGeB32udiGcjmox2pS7vbmM/CiHKd+/hpwgOFY5G5LAasEsO2IH8QvdaBciM
         9T8xxYXISK48A==
Date:   Wed, 1 Nov 2023 10:26:52 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] regulator: core: Add option to prevent disabling unused
 regulators
Message-ID: <20231101045652.GA2897@thinkpad>
References: <20231028102423.179400-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231028102423.179400-1-javierm@redhat.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2023 at 12:24:03PM +0200, Javier Martinez Canillas wrote:
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

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks for looking into this. This patch is very handy to debug display related
issues on platforms without serial console.

On the other note, I'm wondering if we could use sync_state() for handling the
regulator_init_complete() work. This would ensure that the regulators are only
disabled when all the consumers are probed.

- Mani

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
> +			that are unused due not driver claiming them. This may
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
> +	 */
> +	if (regulator_ignore_unused) {
> +		pr_warn("regulator: Not disabling unused regulators\n");
> +		return;
> +	}
> +
>  	/* If we have a full configuration then disable any regulators
>  	 * we have permission to change the status for and which are
>  	 * not in use or always_on.  This is effectively the default
> -- 
> 2.41.0
> 

-- 
மணிவண்ணன் சதாசிவம்
