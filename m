Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F5A80361A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344923AbjLDOL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjLDOL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:11:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC99AA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:11:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60460C433C7;
        Mon,  4 Dec 2023 14:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701699092;
        bh=pZhSxzLDzMwLZSfKGfa6FYFeoHxIe+AuaBCdsEgSWVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qW9ttmgJAe2sgcaGpxz/Sox+kGWSziuO6ntnuQksxQfiD6B2ZimW1Rd0k2PDgfmaA
         aqtLe6wElfihVrxd0buHMlcDAZXIOZjIOSF4u8FUlPTG2boYnjV3OzCkRu2Lsyv4oZ
         6C70WhJBgwiVfcGoVEGZ2qSC3k5UV/P03pBKdmROoS4pJlKh+7EO9hPwZWe9iuFizq
         xcDh2hhhu7HUtUJqq1EW4+rt6RwGSyttvMewlFs4l/ZkAt1JS1VxU8k9QuQevrHCM9
         qLcom1jzpiFwUeTUuKx+63WL79fCUTkfQ+SJYxmRH6k2PKcHe+60Zhrx9N5+k0EThg
         Vb+sIYAO5NqgQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rA9gE-0003ez-07;
        Mon, 04 Dec 2023 15:12:14 +0100
Date:   Mon, 4 Dec 2023 15:12:14 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Ayush Singh <ayushdevel1325@gmail.com>
Cc:     greybus-dev@lists.linaro.org, elder@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        jkridner@beagleboard.org, kernel test robot <yujie.liu@intel.com>
Subject: Re: [PATCH V3] greybus: gb-beagleplay: Ensure le for values in
 transport
Message-ID: <ZW3ePt-c4Mu43DOV@hovoldconsulting.com>
References: <20231204131008.384583-1-ayushdevel1325@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204131008.384583-1-ayushdevel1325@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 06:40:06PM +0530, Ayush Singh wrote:
> Ensure that the following values are little-endian:
> - header->pad (which is used for cport_id)
> - header->size
> 
> Fixes: ec558bbfea67 ("greybus: Add BeaglePlay Linux Driver")
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Closes: https://lore.kernel.org/r/202311072329.Xogj7hGW-lkp@intel.com/
> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> ---
> V3:
> - Fix endiness while sending.
> V2: https://lists.linaro.org/archives/list/greybus-dev@lists.linaro.org/thread/L53UN5ROSG4M6OE7CU5Y3L5F44T6ZPCC/
> - Ensure endianess for header->pad
> V1: https://lists.linaro.org/archives/list/greybus-dev@lists.linaro.org/message/K7UJ6PEAWBLNDMHLT2IO6OP5LQISHRUO/
> 
>  drivers/greybus/gb-beagleplay.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
> index 43318c1993ba..8b21c3e1e612 100644
> --- a/drivers/greybus/gb-beagleplay.c
> +++ b/drivers/greybus/gb-beagleplay.c
> @@ -93,9 +93,9 @@ static void hdlc_rx_greybus_frame(struct gb_beagleplay *bg, u8 *buf, u16 len)
>  	memcpy(&cport_id, hdr->pad, sizeof(cport_id));
>  
>  	dev_dbg(&bg->sd->dev, "Greybus Operation %u type %X cport %u status %u received",
> -		hdr->operation_id, hdr->type, cport_id, hdr->result);
> +		hdr->operation_id, hdr->type, le16_to_cpu(cport_id), hdr->result);
>  
> -	greybus_data_rcvd(bg->gb_hd, cport_id, buf, len);
> +	greybus_data_rcvd(bg->gb_hd, le16_to_cpu(cport_id), buf, len);

This looks broken; a quick against mainline (and linux-next) check shows
cport_id to be u16.

I think you want get_unaligned_le16() or something instead of that
memcpy() above.

But that just begs the question: why has this driver repurposed the pad
bytes like this? The header still says that these shall be set to zero.

>  }
>  
>  static void hdlc_rx_dbg_frame(const struct gb_beagleplay *bg, const char *buf, u16 len)
> @@ -340,14 +340,15 @@ static int gb_message_send(struct gb_host_device *hd, u16 cport, struct gb_messa
>  {
>  	struct gb_beagleplay *bg = dev_get_drvdata(&hd->dev);
>  	struct hdlc_payload payloads[2];
> +	__le16 cport_id = cpu_to_le16(cport);
>  
>  	dev_dbg(&hd->dev, "Sending greybus message with Operation %u, Type: %X on Cport %u",
>  		msg->header->operation_id, msg->header->type, cport);
>  
> -	if (msg->header->size > RX_HDLC_PAYLOAD)
> +	if (le16_to_cpu(msg->header->size) > RX_HDLC_PAYLOAD)
>  		return dev_err_probe(&hd->dev, -E2BIG, "Greybus message too big");
>  
> -	memcpy(msg->header->pad, &cport, sizeof(cport));
> +	memcpy(msg->header->pad, &cport_id, sizeof(cport_id));

put_unaligned_le16(), if the driver should be messing with the pad
bytes like this at all...

>  
>  	payloads[0].buf = msg->header;
>  	payloads[0].len = sizeof(*msg->header);

Johan
