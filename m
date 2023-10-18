Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239497CD8C7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjJRKCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjJRKB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:01:56 -0400
X-Greylist: delayed 570 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Oct 2023 03:01:53 PDT
Received: from mail.insite.cz (smtp.ivitera.com [88.101.85.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AFDB0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:01:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.insite.cz (Postfix) with ESMTP id 102ED14CFE4;
        Wed, 18 Oct 2023 11:52:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
        t=1697622741; bh=cRVI+9/XTH2Bjki5R3jdddnaAgNLzSshDZnaoPkt5fs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GlUhsJCs3z7Ev1/A/dm+UrfygTu401iIBhi28CSgpDHH4hnty8Z+u9+DMZDaiTPt4
         kKQHBn3i06gWSqGsAfDHAfFZxajLhEg9+4L0Jj7iBsH/BonfSrbD+SkDtUUwlrl0ZB
         XYkrv1n/hmSDiVPQMnDglapdFQY3kzB/Xu/ASkpk=
Received: from mail.insite.cz ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8zr1hqqDBjHR; Wed, 18 Oct 2023 11:52:20 +0200 (CEST)
Received: from [192.168.105.22] (unknown [192.168.100.40])
        (Authenticated sender: pavel)
        by mail.insite.cz (Postfix) with ESMTPSA id B0EE014C7F1;
        Wed, 18 Oct 2023 11:52:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
        t=1697622740; bh=cRVI+9/XTH2Bjki5R3jdddnaAgNLzSshDZnaoPkt5fs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sCIw79GDl4l9WLJZKrsmzMhu3PK/+aEyRb0QISjyd4TKIs//qs345z42EYJTWkqxX
         RnEINymUXRSQj5sjEppLE8rPUr68ZHLl8vNB1BR/eQcd8o/EDJriBr45eM1ucDcj4M
         sG1JMpGEYDNoR3DskQG1iwVswIkECi9dMeqFJLl4=
Message-ID: <ff75dd5a-7c32-577b-9ac0-b2aecab3d02c@ivitera.com>
Date:   Wed, 18 Oct 2023 11:52:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2] usb: gadget: f_uac1: add adaptive sync support for
 capture
Content-Language: en-US
To:     Charles Yi <be286@163.com>, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231018074739.1234394-1-be286@163.com>
From:   Pavel Hofman <pavel.hofman@ivitera.com>
In-Reply-To: <20231018074739.1234394-1-be286@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URI_DOTEDU autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dne 18. 10. 23 v 9:47 Charles Yi napsal(a):
> UAC1 has it's own freerunning clock and can update Host about
> real clock frequency through feedback endpoint so Host can align
> number of samples sent to the UAC1 to prevent overruns/underruns.
> 
> Change UAC1 driver to make it configurable through additional
> 'c_sync' configfs file.
> 
> Default remains 'asynchronous' with possibility to switch it
> to 'adaptive'.


Hi Charles,

Please can you clarify more the adaptive EP IN scenario? I am aware that 
the f_uac2.c also allows defining c_sync type (that's what your patch is 
based on).

IIUC the data production rate of adaptive source endpoint (i.e. EP IN) 
is controlled by feed forward messages from the host
Quoting http://sdpha2.ucsd.edu/Lab_Equip_Manuals/usb_20.pdf page 73:

"Adaptive source endpoints produce data at a rate that is controlled by 
the data sink. The sink provides feedback (refer to Section 5.12.4.2) to 
the source, which allows the source to know the desired data rate of the 
sink."

While the current f_uac2 implementation generates feedback for EP OUT 
async (unlike f_uac1), I cannot find any support for incoming 
feed-forward messages from the host for EP IN adaptive case. Neither in 
f_uac1, of course.

I am not sure if linux supports IN EP adaptive, but the MS UAC2 driver 
does not 
https://learn.microsoft.com/en-us/windows-hardware/drivers/audio/usb-2-0-audio-drivers#audio-streaming:

"For the Adaptive IN case the driver doesn't support a feed forward 
endpoint. If such an endpoint is present in the alternate setting, it 
will be ignored. The driver handles the Adaptive IN stream in the same 
way as an Asynchronous IN stream."

IIUC (and I may be wrong) all the c_sync param does in f_uac2 (and 
f_uac1 in your patch) is just changing the EP IN configuration flag, but 
the actual support for truly adaptive EP IN is not implemented. IMO 
there is no code which would accept the feed-forward message from the 
host and adjust the rate at which samples are consumed from the alsa 
buffer to EP IN packets (method u_audio_iso_complete 
https://elixir.bootlin.com/linux/latest/source/drivers/usb/gadget/function/u_audio.c#L193 
)

That pertains a bit to the first sentence of your patch - IMO it 
describes EP OUT async, but not EP IN adaptive.

Thanks a lot for a bit of clarification.

Pavel.


> 
> Changes in V2:
> - Updated the indentation of commit message.
> 
> Signed-off-by: Charles Yi <be286@163.com>
> ---
>   drivers/usb/gadget/function/f_uac1.c | 30 ++++++++++++++++++++++++++++
>   drivers/usb/gadget/function/u_uac1.h |  2 ++
>   2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
> index 6f0e1d803dc2..7a6fcb40bb46 100644
> --- a/drivers/usb/gadget/function/f_uac1.c
> +++ b/drivers/usb/gadget/function/f_uac1.c
> @@ -33,6 +33,8 @@
>   #define FUOUT_EN(_opts) ((_opts)->c_mute_present \
>   			|| (_opts)->c_volume_present)
>   
> +#define EPOUT_FBACK_IN_EN(_opts) ((_opts)->c_sync == USB_ENDPOINT_SYNC_ASYNC)
> +
>   struct f_uac1 {
>   	struct g_audio g_audio;
>   	u8 ac_intf, as_in_intf, as_out_intf;
> @@ -227,6 +229,16 @@ static struct uac_iso_endpoint_descriptor as_iso_out_desc = {
>   	.wLockDelay =		cpu_to_le16(1),
>   };
>   
> +static struct usb_endpoint_descriptor as_fback_ep_desc = {
> +	.bLength = USB_DT_ENDPOINT_SIZE,
> +	.bDescriptorType = USB_DT_ENDPOINT,
> +
> +	.bEndpointAddress = USB_DIR_IN,
> +	.bmAttributes = USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_USAGE_FEEDBACK,
> +	.wMaxPacketSize = cpu_to_le16(3),
> +	.bInterval = 1,
> +};
> +
>   static struct uac_format_type_i_discrete_descriptor as_in_type_i_desc = {
>   	.bLength =		0, /* filled on rate setup */
>   	.bDescriptorType =	USB_DT_CS_INTERFACE,
> @@ -280,6 +292,7 @@ static struct usb_descriptor_header *f_audio_desc[] = {
>   
>   	(struct usb_descriptor_header *)&as_out_ep_desc,
>   	(struct usb_descriptor_header *)&as_iso_out_desc,
> +	(struct usb_descriptor_header *)&as_fback_ep_desc,
>   
>   	(struct usb_descriptor_header *)&as_in_interface_alt_0_desc,
>   	(struct usb_descriptor_header *)&as_in_interface_alt_1_desc,
> @@ -1107,6 +1120,9 @@ static void setup_descriptor(struct f_uac1_opts *opts)
>   		f_audio_desc[i++] = USBDHDR(&as_out_type_i_desc);
>   		f_audio_desc[i++] = USBDHDR(&as_out_ep_desc);
>   		f_audio_desc[i++] = USBDHDR(&as_iso_out_desc);
> +		if (EPOUT_FBACK_IN_EN(opts)) {
> +			f_audio_desc[i++] = USBDHDR(&as_fback_ep_desc);
> +		}
>   	}
>   	if (EPIN_EN(opts)) {
>   		f_audio_desc[i++] = USBDHDR(&as_in_interface_alt_0_desc);
> @@ -1317,6 +1333,12 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
>   		ac_header_desc->baInterfaceNr[ba_iface_id++] = status;
>   		uac1->as_out_intf = status;
>   		uac1->as_out_alt = 0;
> +
> +		if (EPOUT_FBACK_IN_EN(audio_opts)) {
> +			as_out_ep_desc.bmAttributes =
> +			USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ASYNC;
> +			as_out_interface_alt_1_desc.bNumEndpoints++;
> +		}
>   	}
>   
>   	if (EPIN_EN(audio_opts)) {
> @@ -1354,6 +1376,12 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
>   			goto err_free_fu;
>   		audio->out_ep = ep;
>   		audio->out_ep->desc = &as_out_ep_desc;
> +		if (EPOUT_FBACK_IN_EN(audio_opts)) {
> +			audio->in_ep_fback = usb_ep_autoconfig(gadget, &as_fback_ep_desc);
> +			if (!audio->in_ep_fback) {
> +				goto err_free_fu;
> +			}
> +		}
>   	}
>   
>   	if (EPIN_EN(audio_opts)) {
> @@ -1685,6 +1713,8 @@ static struct usb_function_instance *f_audio_alloc_inst(void)
>   
>   	opts->req_number = UAC1_DEF_REQ_NUM;
>   
> +	opts->c_sync = UAC1_DEF_CSYNC;
> +
>   	snprintf(opts->function_name, sizeof(opts->function_name), "AC Interface");
>   
>   	return &opts->func_inst;
> diff --git a/drivers/usb/gadget/function/u_uac1.h b/drivers/usb/gadget/function/u_uac1.h
> index f7a616760e31..c6e2271e8cdd 100644
> --- a/drivers/usb/gadget/function/u_uac1.h
> +++ b/drivers/usb/gadget/function/u_uac1.h
> @@ -27,6 +27,7 @@
>   #define UAC1_DEF_MAX_DB		0		/* 0 dB */
>   #define UAC1_DEF_RES_DB		(1*256)	/* 1 dB */
>   
> +#define UAC1_DEF_CSYNC		USB_ENDPOINT_SYNC_ASYNC
>   
>   struct f_uac1_opts {
>   	struct usb_function_instance	func_inst;
> @@ -56,6 +57,7 @@ struct f_uac1_opts {
>   
>   	struct mutex			lock;
>   	int				refcnt;
> +	int				c_sync;
>   };
>   
>   #endif /* __U_UAC1_H */

