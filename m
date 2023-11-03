Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DE37E0994
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377703AbjKCTme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjKCTmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:42:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3B0D50;
        Fri,  3 Nov 2023 12:42:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E87C433C8;
        Fri,  3 Nov 2023 19:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699040548;
        bh=S85mameRPRRNGRNjFJvCP+oPALlyzRxrT6MFpHRCEe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GzCaKem2q+eRgkJPHAs1kSEEwbZyja+YMIXwdLgxn3tacI/VlZw5Arffaqr4qS6gS
         MDU9oU1CdkUYttX6hutisSUoEbI+hhqy8eHya+wGV1+o5LpkvAZaNh8A6ms9YhsXub
         sB/d2h7QO7CJnkNp+LU5MdU8ns0MQ2q7J0CgYBxeDLCyaPxNZUHiQAOsStCoC1+U0L
         kdDhxsfSUAXfQkzyHPq2LtPz1J99V4ZokwLnptzBMbps4rJU7emN6abn+xEyMGMcoD
         UNeiqpppc13fg1ljvPTz/sqnDS0ByfGT9RJVNthohdgwSdZx5/nsA9RgOEC7hk9B0K
         Ym84V8O7uqRhw==
Date:   Fri, 3 Nov 2023 12:46:33 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH RESEND v3 1/5] PM: domains: Allow devices attached to
 genpd to be managed by HW
Message-ID: <f2tufov2amxapubo4r3wqnzuf3qgm2bt2hc6g5zszj4r5w47xf@vmw3on4axns4>
References: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org>
 <20231101-gdsc-hwctrl-v3-1-0740ae6b2b04@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101-gdsc-hwctrl-v3-1-0740ae6b2b04@linaro.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 11:04:07AM +0200, Abel Vesa wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Some power-domains may be capable of relying on the HW to control the power
> for a device that's hooked up to it. Typically, for these kinds of
> configurations the device doesn't really need to be attached to a PM domain
> (genpd), from Linux point of view.

Per patch 5, this description isn't correct.

Linux enables the power-domain, which in turn enables parent domains
etc. Once the firmware is booted the hardware-control mechanism is
engaged, but until then, and in order to keep the supplies to the domain
voted for, Linux needs a proper genpd.

Regards,
Bjorn

> However, in some cases the behaviour of
> the power-domain and its device can be changed in runtime.
> 
> To allow a consumer driver to change the behaviour of the PM domain for its
> device, let's provide a new function, dev_pm_genpd_set_hwmode(). Moreover,
> let's add a corresponding optional genpd callback, ->set_hwmode_dev(),
> which the genpd provider should implement if it can support switching
> between HW controlled mode and SW controlled mode. Similarly, add the
> dev_pm_genpd_get_hwmode() to allow consumers to read the current mode and
> its corresponding optional genpd callback, ->get_hwmode_dev(), which the
> genpd provider can also implement for reading back the mode from the
> hardware.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/base/power/domain.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   | 17 +++++++++++
>  2 files changed, 86 insertions(+)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index da1777e39eaa..3fb1a234c7f2 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -550,6 +550,75 @@ void dev_pm_genpd_synced_poweroff(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_genpd_synced_poweroff);
>  
> +/**
> + * dev_pm_genpd_set_hwmode - Set the HW mode for the device and its PM domain.
> + *
> + * @dev: Device for which the HW-mode should be changed.
> + * @enable: Value to set or unset the HW-mode.
> + *
> + * Some PM domains can rely on HW signals to control the power for a device. To
> + * allow a consumer driver to switch the behaviour for its device in runtime,
> + * which may be beneficial from a latency or energy point of view, this function
> + * may be called.
> + *
> + * It is assumed that the users guarantee that the genpd wouldn't be detached
> + * while this routine is getting called.
> + *
> + * Returns 0 on success and negative error values on failures.
> + */
> +int dev_pm_genpd_set_hwmode(struct device *dev, bool enable)
> +{
> +	struct generic_pm_domain *genpd;
> +	int ret = 0;
> +
> +	genpd = dev_to_genpd_safe(dev);
> +	if (!genpd)
> +		return -ENODEV;
> +
> +	if (!genpd->set_hwmode_dev)
> +		return -EOPNOTSUPP;
> +
> +	genpd_lock(genpd);
> +
> +	if (dev_gpd_data(dev)->hw_mode == enable)
> +		goto out;
> +
> +	ret = genpd->set_hwmode_dev(genpd, dev, enable);
> +	if (!ret)
> +		dev_gpd_data(dev)->hw_mode = enable;
> +
> +out:
> +	genpd_unlock(genpd);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_genpd_set_hwmode);
> +
> +/**
> + * dev_pm_genpd_get_hwmode - Get the HW mode setting for the device.
> + *
> + * @dev: Device for which the current HW-mode setting should be fetched.
> + *
> + * This helper function allows consumer drivers to fetch the current HW mode
> + * setting of its the device.
> + *
> + * It is assumed that the users guarantee that the genpd wouldn't be detached
> + * while this routine is getting called.
> + */
> +bool dev_pm_genpd_get_hwmode(struct device *dev)
> +{
> +	struct generic_pm_domain *genpd;
> +
> +	genpd = dev_to_genpd_safe(dev);
> +	if (!genpd)
> +		return false;
> +
> +	if (genpd->get_hwmode_dev)
> +		return genpd->get_hwmode_dev(genpd, dev);
> +
> +	return dev_gpd_data(dev)->hw_mode;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_genpd_get_hwmode);
> +
>  static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>  {
>  	unsigned int state_idx = genpd->state_idx;
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 34663d0d5c55..0e7d177fdc3e 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -151,6 +151,10 @@ struct generic_pm_domain {
>  	int (*set_performance_state)(struct generic_pm_domain *genpd,
>  				     unsigned int state);
>  	struct gpd_dev_ops dev_ops;
> +	int (*set_hwmode_dev)(struct generic_pm_domain *domain,
> +			      struct device *dev, bool enable);
> +	bool (*get_hwmode_dev)(struct generic_pm_domain *domain,
> +			      struct device *dev);
>  	int (*attach_dev)(struct generic_pm_domain *domain,
>  			  struct device *dev);
>  	void (*detach_dev)(struct generic_pm_domain *domain,
> @@ -213,6 +217,7 @@ struct generic_pm_domain_data {
>  	unsigned int performance_state;
>  	unsigned int default_pstate;
>  	unsigned int rpm_pstate;
> +	bool hw_mode;
>  	void *data;
>  };
>  
> @@ -242,6 +247,8 @@ int dev_pm_genpd_remove_notifier(struct device *dev);
>  void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next);
>  ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev);
>  void dev_pm_genpd_synced_poweroff(struct device *dev);
> +int dev_pm_genpd_set_hwmode(struct device *dev, bool enable);
> +bool dev_pm_genpd_get_hwmode(struct device *dev);
>  
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> @@ -310,6 +317,16 @@ static inline ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev)
>  static inline void dev_pm_genpd_synced_poweroff(struct device *dev)
>  { }
>  
> +static inline int dev_pm_genpd_set_hwmode(struct device *dev, bool enable)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline bool dev_pm_genpd_get_hwmode(struct device *dev)
> +{
> +	return false;
> +}
> +
>  #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
>  #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
>  #endif
> 
> -- 
> 2.34.1
> 
