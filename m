Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3794A7BF194
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442021AbjJJDgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378482AbjJJDgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:36:39 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0534C92;
        Mon,  9 Oct 2023 20:36:37 -0700 (PDT)
Received: from [IPV6:2405:201:2033:3002:3848:5d20:59c9:c87c] (unknown [IPv6:2405:201:2033:3002:3848:5d20:59c9:c87c])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CFD363D6;
        Tue, 10 Oct 2023 05:36:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1696908994;
        bh=HN7mDg7VsRlOfml4LOazT/vu//u9sVi/DeEg8aI9kx0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Vzz8N3HYNAaoX6t+b+qpI6/WYFDa6z5TFAP3P/En7CocheAYqcWv2FSuPF8ggTgSz
         h/XzBYdem7qn0KwrtcTdE9kPFGAuellAG0lhN9fNm8ej3eHzgGgFSfQE1Ws6TkqjEH
         HO3vEJeX1Xdi2JZcxI3EUxqQgZZdLl/yV1pTUxks=
Message-ID: <9de11f54-6f25-6945-b42c-bc3632563a56@ideasonboard.com>
Date:   Tue, 10 Oct 2023 09:06:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5/5] media: i2c: imx335: Improve configuration error
 reporting
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231010005126.3425444-1-kieran.bingham@ideasonboard.com>
 <20231010005126.3425444-6-kieran.bingham@ideasonboard.com>
Content-Language: en-US
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20231010005126.3425444-6-kieran.bingham@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On 10/10/23 6:21 AM, Kieran Bingham wrote:
> The existing imx335_parse_hw_config function has two paths
> that can be taken without reporting to the user the reason
> for failing to accept the hardware configuration.
>
> Extend the error reporting paths to identify failures when
> probing the device.
>
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> ---
>   drivers/media/i2c/imx335.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index 1a34b2a43718..753e5c39e0fa 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -864,8 +864,10 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
>   	}
>   
>   	ep = fwnode_graph_get_next_endpoint(fwnode, NULL);
> -	if (!ep)
> +	if (!ep) {
> +		dev_err(imx335->dev, "Failed to get next endpoint");

missing '\n' at the end.
>   		return -ENXIO;
> +	}
>   
>   	ret = v4l2_fwnode_endpoint_alloc_parse(ep, &bus_cfg);
>   	fwnode_handle_put(ep);
> @@ -890,6 +892,8 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
>   		if (bus_cfg.link_frequencies[i] == IMX335_LINK_FREQ)
>   			goto done_endpoint_free;
>   
> +	dev_err(imx335->dev, "no compatible link frequencies found");

Ditto.

Other than that,

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>

> +
>   	ret = -EINVAL;
>   
>   done_endpoint_free:

