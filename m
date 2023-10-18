Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5657CE1DC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjJRP4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbjJRP4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:56:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC2A12C;
        Wed, 18 Oct 2023 08:56:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E6FC433C9;
        Wed, 18 Oct 2023 15:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697644569;
        bh=xZk3yByiO+3u209tA6RY3MKQENY0UHz3PBRs0HuKHWQ=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=oMTOwNPk76VLuQFZ6X+aCfPcWKXsfrVvdCes+/kxEjg8oc78gPKDahVnXY2w8iMX2
         AXxEqQPZ72rs6LXxS1oeZpgo60I9XDbCksccWWJA7ZZrqheOgrVMcN0YP28c/zJQv5
         nmBLNe+Zs9QcpsyiMstWL9mnVcQnmZ5wKPRsdk6CDQfA/IqAn0J5H6zhSW88+2t+aB
         im40c3KpzJp4hDgJvrr2US+BzASTpFZoaho/3gdT+igrVuQb5dKhXikvtQaASimg42
         jzGi5fDZWNZuf1pKuJ2ajrDe6DR3FhBH/3kkHUt7LKkASBKvH1srDfQjkrXQoUgPkG
         kJYcSW8bxNxww==
Message-ID: <8e90af8f-8abc-4a0b-bdd2-c6352a985f59@kernel.org>
Date:   Thu, 19 Oct 2023 00:56:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] PM / devfreq: introduce multiple devfreq devices per
 parent device
Content-Language: en-US
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
        digetx@gmail.com, viresh.kumar@linaro.org
References: <20231017211944.192978-1-rodrigo.vivi@intel.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20231017211944.192978-1-rodrigo.vivi@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodrigo,

I'm always welcoming to extend the devfreq subsystem
in order to support the new hardware architecture.
Thanks for your suggestion.

On 23. 10. 18. 06:19, Rodrigo Vivi wrote:
> Devfreq provides a very good standard for frequency management of
> a device. However it is limited to a single frequency control and
> governor per device with a hardcoded 1-1 match since devfreq device
> name inherits dev_name of the parent device.
> 
> Although it suits well most of PCI devices out there, it currently
> limits its adoption on devices with multiple domain frequencies
> that could be seen as sub-devices.
> 
> This patch introduces the optional string argument 'name'.
> 
> When a name is given, the device itself is named with a generic
> 'df<n>' where 'n' is the global devfreq's device counter.
> The given name is only visible at /sys/class/devfreq/df<n>/name.
> 
> So, when a name is given, multiple devfreq devices can be created
> for a single parent device that is willing to address multiple
> frequencies domains or subdevices withing a PCI device for instance.
> 
> When no name is given both the device name and the name file uses
> the the parent's device dev_name() and it is limited to a
> single devfreq device per parent-device, in order to respect the
> legacy usage and not break any backwards compatibility.
> 
> Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> ---
> 
> This is mostly a RFC where the main answer that I'm looking for
> is to know if this would be acceptable by devfreq subsystem.
> 
> For Intel GPUs we have a concept of a multi-tile and multi-gt.
> Each tile can be seen as a duplication of an entire gpu and
> contain a GT inside each and each GT has its own independent
> frequency management.
> 
> Also, some newer platforms, even with single tile, has an exclusive
> GT for media, also with independent frequency management.
> 
> Currently our sysfs provides a full representation of the hardware
> and we could even have something like:
> /sys/class/drm/card0/device/tile0/gt0/freq/
> /sys/class/drm/card0/device/tile0/gt1/freq/
> /sys/class/drm/card0/device/tile1/gt0/freq/
> /sys/class/drm/card0/device/tile1/gt1/freq/
> 
> We are implementing a new driver for the future platforms, so we
> are looking for standardize our interfaces with other drivers
> and devfreq seemed to have a bright future.
> 
> Unfortunately just this patch by itself wouldn't allow us to use
> devfreq directly, because we have underlaying firmware governors.
> Other local experiments that seemed to work for me was to convert
> the current Tegra's exclusive governor to a generic governor_active.c
> 
> On top of that we would need some extra stuff like throttle_reasons,
> and some custom arguments, however before taking any further step
> toward this direction I'd like to get back to my original question
> 
> is this multiple device/domain acceptable here?
> 
> Thoughts?

It is possible to create the multiple devfreq device from one device.
Instead, I think that better to use the following style node name
in order to make the group of same parent device.
- /sys/class/devfreq/devfreq<id>-<id of sub-device>/name.

For example,
/sys/class/devfreq/devfreq0-0/
/sys/class/devfreq/devfreq0-1/
/sys/class/devfreq/devfreq0-2/

/sys/class/devfreq/devfreq1-0/
/sys/class/devfreq/devfreq1-1/
/sys/class/devfreq/devfreq1-2/
/sys/class/devfreq/devfreq1-3/
/sys/class/devfreq/devfreq1-4/

...


> 
> Thanks in advance,
> Rodrigo.
> 
>  drivers/devfreq/devfreq.c | 31 ++++++++++++++++++++++++++-----
>  include/linux/devfreq.h   |  8 ++++++++
>  2 files changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 474d81831ad3..7b4355229d0f 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -15,6 +15,7 @@
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
> +#include <linux/idr.h>
>  #include <linux/export.h>
>  #include <linux/slab.h>
>  #include <linux/stat.h>
> @@ -57,6 +58,8 @@ static const char timer_name[][DEVFREQ_NAME_LEN] = {
>  	[DEVFREQ_TIMER_DELAYED] = { "delayed" },
>  };
>  
> +static DEFINE_IDA(devfreq_ida);
> +
>  /**
>   * find_device_devfreq() - find devfreq struct using device pointer
>   * @dev:	device pointer used to lookup device devfreq.
> @@ -727,12 +730,15 @@ static int qos_max_notifier_call(struct notifier_block *nb,
>  static void devfreq_dev_release(struct device *dev)
>  {
>  	struct devfreq *devfreq = to_devfreq(dev);
> -	int err;
> +	int id, err;
>  
>  	mutex_lock(&devfreq_list_lock);
>  	list_del(&devfreq->node);
>  	mutex_unlock(&devfreq_list_lock);
>  
> +	if (sscanf(dev_name(dev), "df%d", &id))
> +		ida_free(&devfreq_ida, id);
> +
>  	err = dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_max,
>  					 DEV_PM_QOS_MAX_FREQUENCY);
>  	if (err && err != -ENOENT)
> @@ -788,17 +794,26 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	struct devfreq *devfreq;
>  	struct devfreq_governor *governor;
>  	unsigned long min_freq, max_freq;
> -	int err = 0;
> +	int id, err = 0;
>  
>  	if (!dev || !profile || !governor_name) {
>  		dev_err(dev, "%s: Invalid parameters.\n", __func__);
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> +	id = ida_alloc(&devfreq_ida, GFP_KERNEL);
> +	if (id < 0) {
> +	        err = -ENOMEM;
> +		goto err_ida;
> +	}
> +
>  	mutex_lock(&devfreq_list_lock);
>  	devfreq = find_device_devfreq(dev);
>  	mutex_unlock(&devfreq_list_lock);
> -	if (!IS_ERR(devfreq)) {
> +	if (!IS_ERR(devfreq) &&
> +	    (!profile->name ||
> +	     (profile->name && devfreq->profile->name &&
> +	      !strcmp(profile->name, devfreq->profile->name)))) {
>  		dev_err(dev, "%s: devfreq device already exists!\n",
>  			__func__);
>  		err = -EINVAL;
> @@ -864,7 +879,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  
>  	atomic_set(&devfreq->suspend_count, 0);
>  
> -	dev_set_name(&devfreq->dev, "%s", dev_name(dev));
> +	if (profile->name)
> +		dev_set_name(&devfreq->dev, "df%d", id);
> +	else
> +		dev_set_name(&devfreq->dev, "%s", dev_name(dev));
>  	err = device_register(&devfreq->dev);
>  	if (err) {
>  		mutex_unlock(&devfreq->lock);
> @@ -955,6 +973,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  
>  	return devfreq;
>  
> +err_ida:
> +	ida_free(&devfreq_ida, id);
>  err_init:
>  	mutex_unlock(&devfreq_list_lock);
>  err_devfreq:
> @@ -1394,7 +1414,8 @@ static ssize_t name_show(struct device *dev,
>  			struct device_attribute *attr, char *buf)
>  {
>  	struct devfreq *df = to_devfreq(dev);
> -	return sprintf(buf, "%s\n", dev_name(df->dev.parent));
> +	return sprintf(buf, "%s\n", df->profile->name ? :
> +		       dev_name(df->dev.parent));
>  }
>  static DEVICE_ATTR_RO(name);
>  
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index d312ffbac4dd..0ec43eac647d 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -100,6 +100,13 @@ struct devfreq_dev_status {
>   * @freq_table:		Optional list of frequencies to support statistics
>   *			and freq_table must be generated in ascending order.
>   * @max_state:		The size of freq_table.
> + * @name:		Optional name string. When a name is given, the device
> + *			itself is named with a generic 'df<n>' where 'n' is the
> + *			global devfreq's device counter. The given name is only
> + *			visible at /sys/class/devfreq/df<n>/name. When no name
> + *			is given both the device name and the name file uses the
> + *			the parent's device dev_name() and it is limited to a
> + *			single devfreq device per parent-device.
>   *
>   * @is_cooling_device: A self-explanatory boolean giving the device a
>   *                     cooling effect property.
> @@ -117,6 +124,7 @@ struct devfreq_dev_profile {
>  
>  	unsigned long *freq_table;
>  	unsigned int max_state;
> +	char *name;
>  
>  	bool is_cooling_device;
>  };

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

