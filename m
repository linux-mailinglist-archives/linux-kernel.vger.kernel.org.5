Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B498781D56
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 12:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjHTKMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 06:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjHTKMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 06:12:48 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6972BD944
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 12:03:06 -0700 (PDT)
Received: (qmail 67274 invoked by uid 1000); 19 Aug 2023 15:03:05 -0400
Date:   Sat, 19 Aug 2023 15:03:05 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Dingyan Li <18500469033@163.com>
Cc:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        xiaofanc@gmail.com, oneukum@suse.com, lists.tormod@gmail.com,
        sebastian.reichel@collabora.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: Support 20Gbps speed for ioctl USBDEVFS_GET_SPEED
Message-ID: <07c821ae-2391-474c-aec9-65f47d3fecf2@rowland.harvard.edu>
References: <79f3ec25.fa3.18a0c111fa9.Coremail.18500469033@163.com>
 <20230819054655.5495-1-18500469033@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819054655.5495-1-18500469033@163.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 01:46:55PM +0800, Dingyan Li wrote:
> Currently ioctl USBDEVFS_GET_SPEED can only return
> USB_SPEED_SUPER_PLUS at most. However, there are also
> ssp rates to indicate different connection speeds, which
> we can not tell further via USBDEVFS_GET_SPEED.
> 
> To fix it, this patch still uses USB_SPEED_SUPER_PLUS
> to indicate USB_SSP_GEN_UNKNOWN, USB_SSP_GEN_2x1, and
> USB_SSP_GEN_1x2. But need to #define a new value for
> USB_SSP_GEN_2x2. Besides, move the definition of enum
> usb_ssp_rate from include/linux/usb/ch9.h to
> include/uapi/linux/usb/ch9.h, which is a better place
> to hold it.
> 
> Signed-off-by: Dingyan Li <18500469033@163.com>

I'm not going to ACK this.  It's clumsy -- having two separate 
enumerations for USB device speeds just looks ridiculous.

We should fix the whole situation once and for all, recognizing that any 
code which depends on the speed needs to be upward compatible because 
new speeds and bus technologies may be added at any time.

> --- a/include/uapi/linux/usb/ch9.h
> +++ b/include/uapi/linux/usb/ch9.h
> @@ -1185,6 +1185,14 @@ enum usb_device_speed {
>  	USB_SPEED_SUPER_PLUS,			/* usb 3.1 */
>  };
>  
> +/* USB 3.2 SuperSpeed Plus phy signaling rate generation and lane count */
> +
> +enum usb_ssp_rate {
> +	USB_SSP_GEN_UNKNOWN = 0,
> +	USB_SSP_GEN_2x1,
> +	USB_SSP_GEN_1x2,
> +	USB_SSP_GEN_2x2,
> +};

This would make more sense if you kept very clear the distinction 
between the overall speed and the physical communication mechanism.  In 
other words, 10000 bps is 10000 bps, no matter whether the underlying 
technology uses one lane carrying 10000 bits per second or two lanes 
each carrying 5000 bits per second.

I'm not sure if anything in the kernel or userspace really cares about 
the number of lanes, as opposed to the total speed.  If it turns out 
that nothing does, the usb_ssp_rate enumeration could be removed.  
Besides, it should named something else, like usb_ssp_gen or 
usb_sp_generation, since it isn't just a rate designation.  (Whereas as 
enum usb_device_speed _is_ just a rate designation.)

Regardless of what happens to usb_ssp_rate, usb_device_speed should be 
enlarged to encompass all possible existing speeds.  That would 
immediately fix the ioctl problem.  Doing this in an upward-compatible 
way might end up being a little awkward but it ought to be possible.

Alan Stern
