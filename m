Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BEC782D58
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbjHUPeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbjHUPeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:34:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3648F4;
        Mon, 21 Aug 2023 08:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692632047; x=1724168047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kXlM/pwJGzRIMSIfVIy6urX8rZiLt3tsyIjFnb54JgE=;
  b=eeaQm6UKHkUmLXMgg8LlP46HXzoa81mYCM3RqD/bvtR2jGjRQn+/XyNr
   Xx1uQB0RJCT2eK3cyBs2pGViKyn0E2KYdW4HPPmv4I7dWRUK8K3tuqzNP
   CHx5hU0/prAPoKgu2pU6271Jhd4bBnNUnbnCwjbT/QVhp1jiE/3M9Ymdh
   tSiCHIWgJ+r5FKrpp2oznDNoxJwhKC7ryCFWzt1oKY5hv49ZSDVNOCP5K
   EyKHx4SemodrgwNamyIWLTDcyTdyZ+JO0YxQaun8IPQ02kNEx8oaPsoWJ
   qWMkWEZzHVfw2PKRx2j4ILo3xTVgKEb+ZeST4ubltA4odcpj6zzQaAVBf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="372520836"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="372520836"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 08:34:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="982518254"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="982518254"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 21 Aug 2023 08:33:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY6uj-002ZBE-04;
        Mon, 21 Aug 2023 18:33:57 +0300
Date:   Mon, 21 Aug 2023 18:33:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: provide and use gpiod_line_state_notify()
Message-ID: <ZOOD5BrhsX3O6TQG@smile.fi.intel.com>
References: <20230821141827.18061-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821141827.18061-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 04:18:27PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Wrap the calls to blocking_notifier_call_chain() for the line state
> notifier with a helper that allows us to use fewer lines of code and
> simpler syntax.

This change I like, no questions asked.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpiolib-cdev.c | 17 +++++------------
>  drivers/gpio/gpiolib.c      | 12 ++++++++----
>  drivers/gpio/gpiolib.h      |  1 +
>  3 files changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 35dcaf78aed6..e39d344feb28 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -230,9 +230,7 @@ static long linehandle_set_config(struct linehandle_state *lh,
>  				return ret;
>  		}
>  
> -		blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
> -					     GPIO_V2_LINE_CHANGED_CONFIG,
> -					     desc);
> +		gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
>  	}
>  	return 0;
>  }
> @@ -414,8 +412,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
>  				goto out_free_lh;
>  		}
>  
> -		blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
> -					     GPIO_V2_LINE_CHANGED_REQUESTED, desc);
> +		gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_REQUESTED);
>  
>  		dev_dbg(&gdev->dev, "registered chardev handle for line %d\n",
>  			offset);
> @@ -1420,9 +1417,7 @@ static long linereq_set_config_unlocked(struct linereq *lr,
>  
>  		WRITE_ONCE(line->edflags, edflags);
>  
> -		blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
> -					     GPIO_V2_LINE_CHANGED_CONFIG,
> -					     desc);
> +		gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
>  	}
>  	return 0;
>  }
> @@ -1737,8 +1732,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
>  
>  		lr->lines[i].edflags = edflags;
>  
> -		blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
> -					     GPIO_V2_LINE_CHANGED_REQUESTED, desc);
> +		gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_REQUESTED);
>  
>  		dev_dbg(&gdev->dev, "registered chardev handle for line %d\n",
>  			offset);
> @@ -2156,8 +2150,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
>  	if (ret)
>  		goto out_free_le;
>  
> -	blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
> -				     GPIO_V2_LINE_CHANGED_REQUESTED, desc);
> +	gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_REQUESTED);
>  
>  	irq = gpiod_to_irq(desc);
>  	if (irq <= 0) {
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 0737952882cd..43162fd71d92 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2160,8 +2160,7 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
>  	}
>  
>  	spin_unlock_irqrestore(&gpio_lock, flags);
> -	blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
> -				     GPIOLINE_CHANGED_RELEASED, desc);
> +	gpiod_line_state_notify(desc, GPIOLINE_CHANGED_RELEASED);
>  
>  	return ret;
>  }
> @@ -3729,6 +3728,12 @@ int gpiod_set_array_value_cansleep(unsigned int array_size,
>  }
>  EXPORT_SYMBOL_GPL(gpiod_set_array_value_cansleep);
>  
> +void gpiod_line_state_notify(struct gpio_desc *desc, unsigned long action)
> +{
> +	blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
> +				     action, desc);

action can be on previous line, but this is the logical split, so fine as is.

> +}
> +
>  /**
>   * gpiod_add_lookup_table() - register GPIO device consumers
>   * @table: table of consumers to register
> @@ -3996,8 +4001,7 @@ static struct gpio_desc *gpiod_find_and_request(struct device *consumer,
>  		return ERR_PTR(ret);
>  	}
>  
> -	blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
> -				     GPIOLINE_CHANGED_REQUESTED, desc);
> +	gpiod_line_state_notify(desc, GPIOLINE_CHANGED_REQUESTED);
>  
>  	return desc;
>  }
> diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> index 54012605b4a4..0d81ac3bbb40 100644
> --- a/drivers/gpio/gpiolib.h
> +++ b/drivers/gpio/gpiolib.h
> @@ -146,6 +146,7 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
>  extern spinlock_t gpio_lock;
>  extern struct list_head gpio_devices;
>  
> +void gpiod_line_state_notify(struct gpio_desc *desc, unsigned long action);
>  
>  /**
>   * struct gpio_desc - Opaque descriptor for a GPIO
> -- 
> 2.39.2
> 

-- 
With Best Regards,
Andy Shevchenko


