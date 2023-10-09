Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950537BE3EC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376370AbjJIPIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346567AbjJIPIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:08:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6571B9E;
        Mon,  9 Oct 2023 08:08:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55F6C433C7;
        Mon,  9 Oct 2023 15:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696864114;
        bh=r36vFBcTVq6uDwqhbi9cOT6hngO8r2QtiwqiCrlmXNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CHwUOMlGn4ZsfhhY017MjAYjRfs3e+y5m24/Jb/6p+qQ2Atb4GrKwEIhAcDi5mu/5
         rFFCn0L34LW8V3B+gRZmtjA7L13IlSLN6OEDOKBiv0aMtl4UxGB/G3myMcfcqJMsu+
         VTMbZOuEIuBa+fWi1RqAbA53ZxcEMtHsiK21xTio=
Date:   Mon, 9 Oct 2023 17:08:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        onathan Corbet <corbet@lwn.net>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com
Subject: Re: [PATCH 2/2] usb: gadget: ncm: Add support to update
 wMaxSegmentSize via configfs
Message-ID: <2023100931-reward-justice-ed1c@gregkh>
References: <20231009142005.21338-1-quic_kriskura@quicinc.com>
 <20231009142005.21338-2-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009142005.21338-2-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 07:50:05PM +0530, Krishna Kurapati wrote:
> Currently the NCM driver restricts wMaxSegmentSize that indicates
> the datagram size coming from network layer to 1514.

I don't see that restriction in the existing driver, where does that
happen?

> However the spec doesn't have any limitation.

What spec?

> For P2P connections over NCM, increasing MTU helps increasing
> throughput.

While increasing latency, right?

> Add support to configure this value before configfs symlink is
> created. Also since the NTB Out/In buffer sizes are fixed at 16384
> bytes, limit the segment size to an upper cap of 15014. Set the
> default MTU size for the ncm interface during function bind before
> network interface is registered allowing MTU to be set in parity
> with wMaxSegmentSize.

Where does 15014 come from?

> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/gadget/function/f_ncm.c | 51 +++++++++++++++++++++++++++++
>  drivers/usb/gadget/function/u_ncm.h |  2 ++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
> index feccf4c8cc4f..eab297b22200 100644
> --- a/drivers/usb/gadget/function/f_ncm.c
> +++ b/drivers/usb/gadget/function/f_ncm.c
> @@ -103,6 +103,8 @@ static inline struct f_ncm *func_to_ncm(struct usb_function *f)
>  /* Delay for the transmit to wait before sending an unfilled NTB frame. */
>  #define TX_TIMEOUT_NSECS	300000
>  
> +#define MAX_DATAGRAM_SIZE	15014

Where does this magic value come from?  Please document it really really
well.

> +
>  #define FORMATS_SUPPORTED	(USB_CDC_NCM_NTB16_SUPPORTED |	\
>  				 USB_CDC_NCM_NTB32_SUPPORTED)
>  
> @@ -1408,6 +1410,7 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
>  	ncm_opts = container_of(f->fi, struct f_ncm_opts, func_inst);
>  
>  	if (cdev->use_os_string) {
> +		ncm_opts->net->mtu = (ncm_opts->max_segment_size - ETH_HLEN);
>  		f->os_desc_table = kzalloc(sizeof(*f->os_desc_table),
>  					   GFP_KERNEL);
>  		if (!f->os_desc_table)
> @@ -1469,6 +1472,8 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
>  
>  	status = -ENODEV;
>  
> +	ecm_desc.wMaxSegmentSize = ncm_opts->max_segment_size;
> +
>  	/* allocate instance-specific endpoints */
>  	ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_in_desc);
>  	if (!ep)
> @@ -1569,11 +1574,56 @@ USB_ETHERNET_CONFIGFS_ITEM_ATTR_QMULT(ncm);
>  /* f_ncm_opts_ifname */
>  USB_ETHERNET_CONFIGFS_ITEM_ATTR_IFNAME(ncm);
>  
> +static ssize_t ncm_opts_max_segment_size_show(struct config_item *item,
> +					      char *page)
> +{
> +	struct f_ncm_opts *opts = to_f_ncm_opts(item);
> +	u32 segment_size;
> +
> +	mutex_lock(&opts->lock);
> +	segment_size = opts->max_segment_size;
> +	mutex_unlock(&opts->lock);
> +
> +	return sprintf(page, "%u\n", segment_size);

sysfs_emit()?

thanks,

greg k-h
