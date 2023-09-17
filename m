Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5F37A3521
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 12:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjIQKSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 06:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjIQKRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 06:17:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C3D11C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 03:17:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E188C433C7;
        Sun, 17 Sep 2023 10:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694945847;
        bh=E18AkEQod1yCcIHs6KsYIjCqBZKEf0RRYz+ytGA5u+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iEhUouuZCUei1U38fYN0Jjt1wy1T1hEMWRfMwvOaOhpJFFibCaADW7hV0I9lURlXF
         XRIG7xUiYsQXjzI7OswVGEMy84lFY/PuCQmNQa68fYjSPhvgmOgL+nVeFFE2KAZ9Tr
         xdP1t/sRfhpUJ517HQuigX8EyAoaQIxAuMID8VSw=
Date:   Sun, 17 Sep 2023 12:17:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Akash Kumar <quic_akakum@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jing Leng <jleng@ambarella.com>,
        Felipe Balbi <balbi@kernel.org>,
        Pratham =?iso-8859-1?Q?Pratap=A0?= <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH v3] usb: gadget: f_uac2: uevent changes for uac2
Message-ID: <2023091702-unbutton-handoff-558d@gregkh>
References: <20230829092132.1940-1-quic_akakum@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829092132.1940-1-quic_akakum@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 02:51:32PM +0530, Akash Kumar wrote:
> Adding uevent from usb audio gadget driver for uac2 playback/capture
> events, which userspace reads and later reads sysfs entry to know if
> playback or capture has stopped or started by host application.
> 
> /config/usb_gadget/g1/functions/uac2.0 # cat c_status
> 1  --> capture started
> 0  --> capture stopped
> /config/usb_gadget/g1/functions/uac2.0 # cat p_status
> 1 --> playback started
> 0 --> playback stopped
> 
> Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
> ---
>  Documentation/usb/gadget-testing.rst |  6 ++++
>  drivers/usb/gadget/function/f_uac2.c | 47 ++++++++++++++++++++++++++++
>  drivers/usb/gadget/function/u_uac2.h |  5 +++
>  3 files changed, 58 insertions(+)
> 
> diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
> index 2eeb3e9299e4..b2fded232ced 100644
> --- a/Documentation/usb/gadget-testing.rst
> +++ b/Documentation/usb/gadget-testing.rst
> @@ -733,6 +733,12 @@ The uac2 function provides these attributes in its function directory:
>  	p_ssize		playback sample size (bytes)
>  	req_number	the number of pre-allocated request for both capture
>  			and playback
> +        c_status        audio capture state
> +                        (0: capture stopped, 1: capture started)
> +        p_status        audio playback state
> +                        (0: playback stopped, 1: playback started)
> +        c_status        audio capture state
> +        p_status        audio playback state

spaces not tabs?

And shouldn't this also be documented in Documentation/ABI/ as well with
the other attributes?

>  	=============== ====================================================
>  
>  The attributes have sane default values.
> diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
> index db2d4980cb35..f1f7631e9380 100644
> --- a/drivers/usb/gadget/function/f_uac2.c
> +++ b/drivers/usb/gadget/function/f_uac2.c
> @@ -739,6 +739,8 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
>  	struct usb_gadget *gadget = cdev->gadget;
>  	struct device *dev = &gadget->dev;
>  	int ret = 0;
> +	struct f_uac2_opts *audio_opts =
> +		container_of(fn->fi, struct f_uac2_opts, func_inst);

Why assign it here and not below?


>  
>  	/* No i/f has more than 2 alt settings */
>  	if (alt > 1) {
> @@ -762,6 +764,8 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
>  			ret = u_audio_start_capture(&uac2->g_audio);
>  		else
>  			u_audio_stop_capture(&uac2->g_audio);
> +		audio_opts->c_status = alt;
> +		schedule_work(&audio_opts->work);

You are changing functionality here, not just adding statistics, why is
work needed here?

>  	} else if (intf == uac2->as_in_intf) {
>  		uac2->as_in_alt = alt;
>  
> @@ -769,6 +773,8 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
>  			ret = u_audio_start_playback(&uac2->g_audio);
>  		else
>  			u_audio_stop_playback(&uac2->g_audio);
> +		audio_opts->p_status = alt;
> +		schedule_work(&audio_opts->work);

Same here?

>  	} else {
>  		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
>  		return -EINVAL;
> @@ -801,11 +807,16 @@ static void
>  afunc_disable(struct usb_function *fn)
>  {
>  	struct f_uac2 *uac2 = func_to_uac2(fn);
> +	struct f_uac2_opts *audio_opts =
> +		container_of(fn->fi, struct f_uac2_opts, func_inst);

Normally the bigger line goes at top.

>  
>  	uac2->as_in_alt = 0;
>  	uac2->as_out_alt = 0;
> +	audio_opts->p_status = 0;//alt;
> +	audio_opts->c_status = 0; //alt;

You didn't actually mean to do this, right?

Please get review from someone else in your group before sending this
out for us to find obvious problems.

>  	u_audio_stop_capture(&uac2->g_audio);
>  	u_audio_stop_playback(&uac2->g_audio);
> +	schedule_work(&audio_opts->work);
>  }
>  
>  static int
> @@ -1036,6 +1047,25 @@ UAC2_ATTRIBUTE(c_srate);
>  UAC2_ATTRIBUTE(c_ssize);
>  UAC2_ATTRIBUTE(req_number);
>  
> +#define UAC2_ATTRIBUTE_RO(name)                                         \
> +	static ssize_t f_uac2_opts_##name##_show(                       \
> +			struct config_item *item,                       \
> +			char *page)                                     \
> +{                                                                       \
> +	struct f_uac2_opts *opts = to_f_uac2_opts(item);                \
> +	int result;                                                     \
> +									\
> +	mutex_lock(&opts->lock);                                        \
> +	result = scnprintf(page, PAGE_SIZE, "%u\n", opts->name);        \
> +	mutex_unlock(&opts->lock);                                      \
> +									\
> +	return result;                                                  \
> +}                                                                       \
> +CONFIGFS_ATTR_RO(f_uac2_opts_, name)
> +
> +UAC2_ATTRIBUTE_RO(c_status);
> +UAC2_ATTRIBUTE_RO(p_status);
> +
>  static struct configfs_attribute *f_uac2_attrs[] = {
>  	&f_uac2_opts_attr_p_chmask,
>  	&f_uac2_opts_attr_p_srate,
> @@ -1044,6 +1074,8 @@ static struct configfs_attribute *f_uac2_attrs[] = {
>  	&f_uac2_opts_attr_c_srate,
>  	&f_uac2_opts_attr_c_ssize,
>  	&f_uac2_opts_attr_req_number,
> +	&f_uac2_opts_attr_c_status,
> +	&f_uac2_opts_attr_p_status,
>  	NULL,
>  };
>  
> @@ -1053,11 +1085,23 @@ static const struct config_item_type f_uac2_func_type = {
>  	.ct_owner	= THIS_MODULE,
>  };
>  
> +static void f_uac2_audio_status_change_work(struct work_struct *data)
> +{
> +	struct f_uac2_opts *audio_opts =
> +		container_of(data, struct f_uac2_opts, work);
> +	char *envp[2] = { "UAC2_STATE=Changed", NULL };
> +
> +	kobject_uevent_env(&audio_opts->device->kobj,
> +			KOBJ_CHANGE, envp);
> +}
> +
>  static void afunc_free_inst(struct usb_function_instance *f)
>  {
>  	struct f_uac2_opts *opts;
>  
>  	opts = container_of(f, struct f_uac2_opts, func_inst);
> +	device_destroy(opts->device->class, opts->device->devt);

Wait, why?

> +	cancel_work_sync(&opts->work);
>  	kfree(opts);
>  }
>  
> @@ -1082,6 +1126,9 @@ static struct usb_function_instance *afunc_alloc_inst(void)
>  	opts->c_srate = UAC2_DEF_CSRATE;
>  	opts->c_ssize = UAC2_DEF_CSSIZE;
>  	opts->req_number = UAC2_DEF_REQ_NUM;
> +	INIT_WORK(&opts->work, f_uac2_audio_status_change_work);
> +	opts->device = create_function_device("f_uac2");

A whole new device?  Why?  There should already be a device for this, if
not, you now need to document your new device as this is a whole new
thing for sysfs to show, right?

> +
>  	return &opts->func_inst;
>  }
>  
> diff --git a/drivers/usb/gadget/function/u_uac2.h b/drivers/usb/gadget/function/u_uac2.h
> index b5035711172d..3ccf2eb002f1 100644
> --- a/drivers/usb/gadget/function/u_uac2.h
> +++ b/drivers/usb/gadget/function/u_uac2.h
> @@ -36,6 +36,11 @@ struct f_uac2_opts {
>  
>  	struct mutex			lock;
>  	int				refcnt;
> +	int				c_status;
> +	int				p_status;
> +	struct device			*device;
> +	struct work_struct		work;

Some documentation please for what these new fields are for.

thanks,

greg k-h
