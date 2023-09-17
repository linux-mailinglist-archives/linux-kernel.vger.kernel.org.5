Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B238E7A343E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 10:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjIQIFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 04:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjIQIEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 04:04:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEB3127;
        Sun, 17 Sep 2023 01:04:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B4AC433C7;
        Sun, 17 Sep 2023 08:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694937887;
        bh=1h5LcJ03IUO48wVxTPxjCPe7OlWV58gb87QmcYg6uuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LubuApJ/ahdQUlJAbFGW/avEpTKbuPb8jGK4Wmih51twXHgNZZk1kPJrrv6amXOlH
         3vDGAz1HYb2NwvCM6Z7H1vthBFQ625vewD2Zz9PUWde4UWw1/RmyK9DdXLFqRfZbTo
         LK+FHdpQZBoQfzlfaKrj2G1Gv0vo5YuEGfFPisS4=
Date:   Sun, 17 Sep 2023 10:04:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Linyu Yuan <quic_linyyuan@quicinc.com>,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: ncm: Handle decoding of multiple NTB's
 in unwrap call
Message-ID: <2023091743-tightly-drivable-4360@gregkh>
References: <20230915061001.18884-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230915061001.18884-1-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 11:39:48AM +0530, Krishna Kurapati wrote:
> When NCM is used with hosts like Windows PC, it is observed that there are
> multiple NTB's contained in one usb request giveback. Since the driver
> unwraps the obtained request data assuming only one NTB is present, we loose
> the subsequent NTB's present resulting in data loss.
> 
> Fix this by checking the parsed block length with the obtained data length
> in usb request and continue parsing after the last byte of current NTB.
> 
> Cc: stable@vger.kernel.org

What commit id does this fix?

> Reviewed-by: Maciej Żenczykowski <maze@google.com>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/gadget/function/f_ncm.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
> index feccf4c8cc4f..f00f051438ec 100644
> --- a/drivers/usb/gadget/function/f_ncm.c
> +++ b/drivers/usb/gadget/function/f_ncm.c
> @@ -1156,7 +1156,8 @@ static int ncm_unwrap_ntb(struct gether *port,
>  			  struct sk_buff_head *list)
>  {
>  	struct f_ncm	*ncm = func_to_ncm(&port->func);
> -	__le16		*tmp = (void *) skb->data;
> +	unsigned char	*ntb_ptr = (void *) skb->data;

Why persist with the extra ' ', didn't checkpatch complain about this?

And why the cast at all?

> +	__le16		*tmp;
>  	unsigned	index, index2;
>  	int		ndp_index;
>  	unsigned	dg_len, dg_len2;
> @@ -1169,6 +1170,10 @@ static int ncm_unwrap_ntb(struct gether *port,
>  	const struct ndp_parser_opts *opts = ncm->parser_opts;
>  	unsigned	crc_len = ncm->is_crc ? sizeof(uint32_t) : 0;
>  	int		dgram_counter;
> +	int		to_process = skb->len;
> +
> +parse_ntb:
> +	tmp = (void *) ntb_ptr;

Again, no blank space please.

And why the cast?

thanks,

greg k-h
