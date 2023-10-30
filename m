Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4627DC0CF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjJ3ToP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJ3ToO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:44:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69206C0;
        Mon, 30 Oct 2023 12:44:12 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SK3bX1n0Lz6K98J;
        Tue, 31 Oct 2023 03:43:20 +0800 (CST)
Received: from localhost (10.48.147.130) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 30 Oct
 2023 19:43:51 +0000
Date:   Mon, 30 Oct 2023 19:43:50 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andy Shevchenko" <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 01/17] pinctrl: intel: Provide Intel pin control wide
 PM ops structure
Message-ID: <20231030194350.0000581f@Huawei.com>
In-Reply-To: <20231030194112.00001917@Huawei.com>
References: <20231030120734.2831419-1-andriy.shevchenko@linux.intel.com>
        <20231030120734.2831419-2-andriy.shevchenko@linux.intel.com>
        <20231030194112.00001917@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.147.130]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 19:41:12 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 30 Oct 2023 14:07:18 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > With the help of EXPORT_NS_GPL_DEV_PM_OPS() and
> > NOIRQ_SYSTEM_SLEEP_PM_OPS() we may convert PM ops functions to become
> > static. This also takes into account the PM configuration options such
> > as CONFIG_PM and CONFIG_PM_SLEEP. Hence the first step is to provide
> > a generic PM ops structure that can be used by drivers directly.  
> 
> It's a good thing to do, but if rolling a v3, should mention that the export
> moves into the namespace.
> 
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> Other than that,
> LGTM
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
Actually looking at usecase, why isn't the absence of an EXPORT in
the !CONFIG_PM_SLEEP path not a problem for bisection of this series given
you haven't yet protected the users?

Jonathan

> > ---
> >  drivers/pinctrl/intel/pinctrl-intel.c | 8 +++++---
> >  drivers/pinctrl/intel/pinctrl-intel.h | 4 ++--
> >  2 files changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
> > index b19527a8728e..9fbdc7bfa65c 100644
> > --- a/drivers/pinctrl/intel/pinctrl-intel.c
> > +++ b/drivers/pinctrl/intel/pinctrl-intel.c
> > @@ -899,7 +899,7 @@ static int intel_gpio_to_pin(struct intel_pinctrl *pctrl, unsigned int offset,
> >   *
> >   * Return: a GPIO offset, or negative error code if translation can't be done.
> >   */
> > -static __maybe_unused int intel_pin_to_gpio(struct intel_pinctrl *pctrl, int pin)
> > +static int intel_pin_to_gpio(struct intel_pinctrl *pctrl, int pin)
> >  {
> >  	const struct intel_community *community;
> >  	const struct intel_padgroup *padgrp;
> > @@ -1682,7 +1682,6 @@ const struct intel_pinctrl_soc_data *intel_pinctrl_get_soc_data(struct platform_
> >  }
> >  EXPORT_SYMBOL_NS_GPL(intel_pinctrl_get_soc_data, PINCTRL_INTEL);
> >  
> > -#ifdef CONFIG_PM_SLEEP
> >  static bool __intel_gpio_is_direct_irq(u32 value)
> >  {
> >  	return (value & PADCFG0_GPIROUTIOXAPIC) && (value & PADCFG0_GPIOTXDIS) &&
> > @@ -1883,7 +1882,10 @@ int intel_pinctrl_resume_noirq(struct device *dev)
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(intel_pinctrl_resume_noirq);
> > -#endif
> > +
> > +EXPORT_NS_GPL_DEV_PM_OPS(intel_pinctrl_pm_ops, PINCTRL_INTEL) = {
> > +	NOIRQ_SYSTEM_SLEEP_PM_OPS(intel_pinctrl_suspend_noirq, intel_pinctrl_resume_noirq)
> > +};
> >  
> >  MODULE_AUTHOR("Mathias Nyman <mathias.nyman@linux.intel.com>");
> >  MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
> > diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
> > index 2bb553598e8b..d3f511f97ed9 100644
> > --- a/drivers/pinctrl/intel/pinctrl-intel.h
> > +++ b/drivers/pinctrl/intel/pinctrl-intel.h
> > @@ -255,10 +255,8 @@ struct intel_pinctrl {
> >  int intel_pinctrl_probe_by_hid(struct platform_device *pdev);
> >  int intel_pinctrl_probe_by_uid(struct platform_device *pdev);
> >  
> > -#ifdef CONFIG_PM_SLEEP
> >  int intel_pinctrl_suspend_noirq(struct device *dev);
> >  int intel_pinctrl_resume_noirq(struct device *dev);
> > -#endif
> >  
> >  #define INTEL_PINCTRL_PM_OPS(_name)					\
> >  const struct dev_pm_ops _name = {					\
> > @@ -266,6 +264,8 @@ const struct dev_pm_ops _name = {					\
> >  				      intel_pinctrl_resume_noirq)	\
> >  }
> >  
> > +extern const struct dev_pm_ops intel_pinctrl_pm_ops;
> > +
> >  struct intel_community *intel_get_community(struct intel_pinctrl *pctrl, unsigned int pin);
> >  
> >  int intel_get_groups_count(struct pinctrl_dev *pctldev);  
> 

