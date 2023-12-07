Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DC48086C1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjLGLad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjLGLa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:30:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D23122
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 03:30:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55ECC433C9;
        Thu,  7 Dec 2023 11:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701948632;
        bh=yW7tXWdDtIWMp7veY4GKrj377HGeMh3azpE291fF+DE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZasI4foS+lpsk6sVVze2+Fxi1d3UOk8JkVu4yEUNu7HZKZJ6ZI7/P9/8FxZZ01BfG
         u6uPDMIRwOHssp6eiDTxRXH4GDyKQCQpAzenKZyoI8iZMgz+uAj75WPNlDZ55o1LEy
         aA2K4GryPbPqpuWtCmR7qL52wgo8CMaDVwTf/g6w=
Date:   Thu, 7 Dec 2023 12:30:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ayush Singh <ayushdevel1325@gmail.com>
Cc:     greybus-dev@lists.linaro.org, johan@kernel.org, elder@kernel.org,
        linux-kernel@vger.kernel.org, jkridner@beagleboard.org, nm@ti.com,
        yujie.liu@intel.com
Subject: Re: [PATCH 1/1] greybus: gb-beagleplay: Remove use of pad bytes
Message-ID: <2023120758-coleslaw-unstopped-530c@gregkh>
References: <20231206150602.176574-1-ayushdevel1325@gmail.com>
 <20231206150602.176574-2-ayushdevel1325@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206150602.176574-2-ayushdevel1325@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 08:36:00PM +0530, Ayush Singh wrote:
> Make gb-beagleplay greybus spec compliant by using a wrapper around HDLC
> payload to include cport information.

"wrapper"?  You just changed the data you send on your "wire", right?

> Fixes: ec558bbfea67 ("greybus: Add BeaglePlay Linux Driver")
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Closes: https://lore.kernel.org/r/202311072329.Xogj7hGW-lkp@intel.com/
> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> ---
>  drivers/greybus/gb-beagleplay.c | 44 +++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
> index 1e70ff7e3da4..fb40ade9364f 100644
> --- a/drivers/greybus/gb-beagleplay.c
> +++ b/drivers/greybus/gb-beagleplay.c
> @@ -85,17 +85,35 @@ struct hdlc_payload {
>  	void *buf;
>  };
>  
> +/**
> + * struct hdlc_greybus_frame - Structure to represent greybus HDLC frame

Represent it where?  And where is this documented?

> + *
> + * @cport: cport id
> + * @hdr: greybus operation header
> + * @payload: greybus message payload
> + */
> +struct hdlc_greybus_frame {
> +	__le16 cport;
> +	struct gb_operation_msg_hdr hdr;
> +	u8 payload[];
> +} __packed;
> +
>  static void hdlc_rx_greybus_frame(struct gb_beagleplay *bg, u8 *buf, u16 len)
>  {
> -	u16 cport_id;
> -	struct gb_operation_msg_hdr *hdr = (struct gb_operation_msg_hdr *)buf;
> +	struct hdlc_greybus_frame *gb_frame = (struct hdlc_greybus_frame *)buf;
> +	u16 cport_id = le16_to_cpu(gb_frame->cport);
>  
> -	memcpy(&cport_id, hdr->pad, sizeof(cport_id));
> +	/* Ensure that the greybus message is valid */
> +	if (le16_to_cpu(gb_frame->hdr.size) > len - sizeof(cport_id)) {
> +		dev_warn_ratelimited(&bg->sd->dev, "Invalid/Incomplete greybus message");

Don't spam the kernel log for corrupted data on the line, that would be
a mess.  Use a tracepoint?

> +		return;
> +	}
>  
>  	dev_dbg(&bg->sd->dev, "Greybus Operation %u type %X cport %u status %u received",
> -		hdr->operation_id, hdr->type, le16_to_cpu(cport_id), hdr->result);
> +		gb_frame->hdr.operation_id, gb_frame->hdr.type, cport_id, gb_frame->hdr.result);

Better yet, put the error in the debug message?

>  
> -	greybus_data_rcvd(bg->gb_hd, le16_to_cpu(cport_id), buf, len);
> +	greybus_data_rcvd(bg->gb_hd, cport_id, &buf[sizeof(cport_id)],

Fun with pointer math.  This feels really fragile, why not just point to
the field instead?

> +			  le16_to_cpu(gb_frame->hdr.size));

You convert the size twice, might as well do it once up above, right?

Also, it's best to use the same value you checked as the value you pass
in here, odds are you can't change the data underneath you (like you
could if this came from userspace), but it's best to not get in the
habit of coding like this.


>  }
>  
>  static void hdlc_rx_dbg_frame(const struct gb_beagleplay *bg, const char *buf, u16 len)
> @@ -339,7 +357,7 @@ static struct serdev_device_ops gb_beagleplay_ops = {
>  static int gb_message_send(struct gb_host_device *hd, u16 cport, struct gb_message *msg, gfp_t mask)
>  {
>  	struct gb_beagleplay *bg = dev_get_drvdata(&hd->dev);
> -	struct hdlc_payload payloads[2];
> +	struct hdlc_payload payloads[3];

why 3?

It's ok to put this on the stack?

>  	__le16 cport_id = le16_to_cpu(cport);
>  
>  	dev_dbg(&hd->dev, "Sending greybus message with Operation %u, Type: %X on Cport %u",
> @@ -348,14 +366,14 @@ static int gb_message_send(struct gb_host_device *hd, u16 cport, struct gb_messa
>  	if (le16_to_cpu(msg->header->size) > RX_HDLC_PAYLOAD)
>  		return dev_err_probe(&hd->dev, -E2BIG, "Greybus message too big");
>  
> -	memcpy(msg->header->pad, &cport_id, sizeof(cport_id));
> -
> -	payloads[0].buf = msg->header;
> -	payloads[0].len = sizeof(*msg->header);
> -	payloads[1].buf = msg->payload;
> -	payloads[1].len = msg->payload_size;
> +	payloads[0].buf = &cport_id;
> +	payloads[0].len = sizeof(cport_id);
> +	payloads[1].buf = msg->header;
> +	payloads[1].len = sizeof(*msg->header);
> +	payloads[2].buf = msg->payload;
> +	payloads[2].len = msg->payload_size;

So you send the cport number as the first message?  Don't you need to
document this somewhere?

thanks,

greg k-h
