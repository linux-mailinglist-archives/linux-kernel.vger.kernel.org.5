Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F4D7CD2D5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 06:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjJREYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 00:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJREYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 00:24:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A904EF7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 21:24:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BA1C433C8;
        Wed, 18 Oct 2023 04:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697603060;
        bh=JJRO/8i4RNh8UYfA1RgCwqbN9Jg4aYe4WcOAQc90yjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LDjnw3I75ZcjA57THqhPsx8Zg9ImsXDBCahAtfC3lnTecC65xWhpj/urnKj1EEwJS
         B7UnNfelrPYuH7A2zyxauvumrNZoSuDptko2ykkNe01WH4NTlb7GS5s4eCOaqYIznp
         u/IoNiD05/7UQnzSosgfXyZ52viVca6LsSWX8MMCjR84UBlQCyZ/0T0ZQE6hpyIqrA
         nTUk0+xujIyFm0o9pbHhV6fxOrKYiucX4/nl0mk6/ngf5Qgf9Nmh3BWDNREUILV6Ta
         gGFYVqyPdjZ9Le1Yl330D74F+u6XCG2yOu5JiXQpEshL6Y3zq5AlI5h54EnlJIqdBO
         Ua45uagO6bX2Q==
Date:   Wed, 18 Oct 2023 12:24:17 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Lalith Rajendran <lalithkraj@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v1] FROMLIST: platform/chrome: cros_ec_lpc: Separate host
 command and irq disable
Message-ID: <ZS9d8R9OunZ6Xyu9@google.com>
References: <20231017124047.1.Icc99145043c8d44142bb5ca64ea4c63a417c267b@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017124047.1.Icc99145043c8d44142bb5ca64ea4c63a417c267b@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 12:40:48PM -0500, Lalith Rajendran wrote:
> Both cros host command and irq disable were moved to suspend
> prepare stage from late suspend recently. This is causing EC
> to report MKBP event timeouts during suspend stress testing.
> When the MKBP event timeouts happen during suspend, subsequent
> wakeup of AP by EC using MKBP doesn't happen properly. Although

It needs a Fixes tag.  Probably:
Fixes: 4b9abbc132b8 ("platform/chrome: cros_ec_lpc: Move host command to prepare/complete")

> there are other issues to debug here, this change move the irq
> disabling part back to late suspend stage which is a general
> suggestion from the suspend kernel documentaiton to do irq
> disable as late as possible.

s/Although there ... this change move/\nMove/.

Also, please remove "FROMLIST: " from the commit title.

> @@ -321,17 +321,8 @@ void cros_ec_unregister(struct cros_ec_device *ec_dev)
>  EXPORT_SYMBOL(cros_ec_unregister);
>  
>  #ifdef CONFIG_PM_SLEEP
> -/**
> - * cros_ec_suspend() - Handle a suspend operation for the ChromeOS EC device.
> - * @ec_dev: Device to suspend.
> - *
> - * This can be called by drivers to handle a suspend event.
> - *
> - * Return: 0 on success or negative error code.
> - */
> -int cros_ec_suspend(struct cros_ec_device *ec_dev)
> +static int cros_ec_send_suspend_event(struct cros_ec_device *ec_dev)
>  {
> -	struct device *dev = ec_dev->dev;
>  	int ret;
>  	u8 sleep_event;
>  
> @@ -343,7 +334,26 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
>  	if (ret < 0)
>  		dev_dbg(ec_dev->dev, "Error %d sending suspend event to ec\n",
>  			ret);
> +	return 0;

It was obvious in older cros_ec_suspend() but looks like a mistake in
cros_ec_send_suspend_event().

Either:
- Add a comment here for ignoring the `ret` intentionally.
- Make cros_ec_send_suspend_event() returns void.

I would prefer the latter as the newer cros_ec_suspend() also ignores the
return values.

> +static int cros_ec_disable_irq(struct cros_ec_device *ec_dev)
> +{
> +	struct device *dev = ec_dev->dev;
>  	if (device_may_wakeup(dev))
>  		ec_dev->wake_enabled = !enable_irq_wake(ec_dev->irq);
>  	else
> @@ -354,6 +364,35 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
>  
>  	return 0;

Same here, I would suggest to make it return void.

> +/**
> + * cros_ec_suspend() - Handle a suspend operation for the ChromeOS EC device.
> + * @ec_dev: Device to suspend.
> + *
> + * This can be called by drivers to handle a suspend event.
> + *
> + * Return: 0 on success or negative error code.
> + */
> +int cros_ec_suspend(struct cros_ec_device *ec_dev)
> +{
> +	cros_ec_send_suspend_event(ec_dev);
> +	cros_ec_disable_irq(ec_dev);

cros_ec_suspend() ignores all return values.

> -/**
> - * cros_ec_resume() - Handle a resume operation for the ChromeOS EC device.
> - * @ec_dev: Device to resume.
> - *
> - * This can be called by drivers to handle a resume event.
> - *
> - * Return: 0 on success or negative error code.
> - */
> -int cros_ec_resume(struct cros_ec_device *ec_dev)
> +static int cros_ec_send_resume_event(struct cros_ec_device *ec_dev)
>  {
>  	int ret;
>  	u8 sleep_event;
>  
> -	ec_dev->suspended = false;
> -	enable_irq(ec_dev->irq);
> -
>  	sleep_event = (!IS_ENABLED(CONFIG_ACPI) || pm_suspend_via_firmware()) ?
>  		      HOST_SLEEP_EVENT_S3_RESUME :
>  		      HOST_SLEEP_EVENT_S0IX_RESUME;
> @@ -394,6 +422,25 @@ int cros_ec_resume(struct cros_ec_device *ec_dev)
>  	if (ret < 0)
>  		dev_dbg(ec_dev->dev, "Error %d sending resume event to ec\n",
>  			ret);
> +	return 0;

Ditto.

> +static int cros_ec_enable_irq(struct cros_ec_device *ec_dev)
> +{
> +	ec_dev->suspended = false;
> +	enable_irq(ec_dev->irq);
>  
>  	if (ec_dev->wake_enabled)
>  		disable_irq_wake(ec_dev->irq);
> @@ -407,6 +454,35 @@ int cros_ec_resume(struct cros_ec_device *ec_dev)
>  
>  	return 0;

Ditto.

> +/**
> + * cros_ec_resume() - Handle a resume operation for the ChromeOS EC device.
> + * @ec_dev: Device to resume.
> + *
> + * This can be called by drivers to handle a resume event.
> + *
> + * Return: 0 on success or negative error code.
> + */
> +int cros_ec_resume(struct cros_ec_device *ec_dev)
> +{
> +	cros_ec_enable_irq(ec_dev);
> +	cros_ec_send_resume_event(ec_dev);

Ditto.
