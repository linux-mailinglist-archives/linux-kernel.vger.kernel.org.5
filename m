Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C827774BA0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjHHUvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbjHHUuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:50:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8DF10E9EF;
        Tue,  8 Aug 2023 09:46:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F423562440;
        Tue,  8 Aug 2023 08:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B03C433C8;
        Tue,  8 Aug 2023 08:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691483390;
        bh=FiNrcT5Dlrnd8YbrKQdjS/NZ+m/l50JiT60Nd4pIS58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PfrXdrBsHppC85W5vyjvDMZ+T3KCSq1OYjw9KWardf/6t5trHjyzT0beno+v2tHgM
         6yYhlDf9JUwlVDrdbGX4NJRYNvHDqY8/1qCVfxdT7CDT4YTfJ8YG+eJKr6kfpYTUWF
         nCZnJuLZnDkl3VELamwskHxOhstOHbC1t25eF7fE=
Date:   Tue, 8 Aug 2023 10:29:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Akash Kumar <quic_akakum@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jing Leng <jleng@ambarella.com>,
        Felipe Balbi <balbi@kernel.org>,
        Pratham =?iso-8859-1?Q?Pratap=A0?= <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_uac2: uevent changes for uac2
Message-ID: <2023080837-droplet-mace-dfbb@gregkh>
References: <20230723190538.27750-1-quic_akakum@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723190538.27750-1-quic_akakum@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 12:35:38AM +0530, Akash Kumar wrote:
> Adding uevent from usb audio gadget driver for uac2 playback/capture
> events, which userspace reads and later reads sysfs entry to know if
> playback or capture has stopped or started by host application.

How do you keep the events in sync then?  If you get a uevent, and then
wait a while before reading sysfs, how do you know that a different
uevent didn't happen inbetween?

> /config/usb_gadget/g1/functions/uac2.0 # cat c_status
> 1  --> capture started
> 0  --> capture stopped
> /config/usb_gadget/g1/functions/uac2.0 # cat p_status
> 1 --> playback started
> 0 --> playback stopped
> 
> Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
> ---
>  .../ABI/testing/configfs-usb-gadget-uac2      |  4 ++
>  drivers/usb/gadget/function/f_uac2.c          | 47 +++++++++++++++++++
>  drivers/usb/gadget/function/u_uac2.h          |  5 ++
>  3 files changed, 56 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uac2 b/Documentation/ABI/testing/configfs-usb-gadget-uac2
> index 2bfdd4efa9bd..196c6921a163 100644
> --- a/Documentation/ABI/testing/configfs-usb-gadget-uac2
> +++ b/Documentation/ABI/testing/configfs-usb-gadget-uac2
> @@ -10,3 +10,7 @@ Description:
>  		p_chmask - playback channel mask
>  		p_srate - playback sampling rate
>  		p_ssize - playback sample size (bytes)
> +		c_status - usb uac2 audio capture state
> +			   (0: capture stopped, 1: capture started)
> +		p_status - usb uac2 audio playback state
> +			   (0: playback stopped, 1: playback started)
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
>  
>  	/* No i/f has more than 2 alt settings */
>  	if (alt > 1) {
> @@ -762,6 +764,8 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
>  			ret = u_audio_start_capture(&uac2->g_audio);
>  		else
>  			u_audio_stop_capture(&uac2->g_audio);
> +		audio_opts->c_status = alt;
> +		schedule_work(&audio_opts->work);
>  	} else if (intf == uac2->as_in_intf) {
>  		uac2->as_in_alt = alt;
>  
> @@ -769,6 +773,8 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
>  			ret = u_audio_start_playback(&uac2->g_audio);
>  		else
>  			u_audio_stop_playback(&uac2->g_audio);
> +		audio_opts->p_status = alt;
> +		schedule_work(&audio_opts->work);
>  	} else {
>  		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
>  		return -EINVAL;
> @@ -801,11 +807,16 @@ static void
>  afunc_disable(struct usb_function *fn)
>  {
>  	struct f_uac2 *uac2 = func_to_uac2(fn);
> +	struct f_uac2_opts *audio_opts =
> +		container_of(fn->fi, struct f_uac2_opts, func_inst);
>  
>  	uac2->as_in_alt = 0;
>  	uac2->as_out_alt = 0;
> +	audio_opts->p_status = 0;//alt;
> +	audio_opts->c_status = 0; //alt;
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

You didn't document these new attributes either in Documentation/ABI/

Also, what userspace tool is going to use these?

thanks,

greg k-h
