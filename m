Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D5178A693
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjH1He7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjH1Hev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:34:51 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B96E10A;
        Mon, 28 Aug 2023 00:34:48 -0700 (PDT)
Received: from ideasonboard.com (mob-5-91-19-240.net.vodafone.it [5.91.19.240])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1E95C6B5;
        Mon, 28 Aug 2023 09:33:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693208005;
        bh=1rsSXCqvZ4/X2DpUqa0xnHt/RsZuL51FvPDwOwl1IEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JxOrOdrW4hcUebkgh5EsYFtGsTv0CsmBEkc7ORijPg/6TVCtQkQ3lwNGedZHpagcp
         txIeGE7FWB3u9GjdZ/+ZYvuqJpzeIxS3eyX0aKiKHWZHy2r49S21ClleGmErP8TDnA
         O9S8vWEy9FtjHLbuullKPnTp6xTzzT8eqtjEA3ag=
Date:   Mon, 28 Aug 2023 09:34:40 +0200
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: i2c: max9286: Fix some redundant of_node_put()
 calls
Message-ID: <rveb47frebdzhpcxdt4jnyasiztrhfnee3pzgl5ndafh2jbrsf@za4o23cw3lch>
References: <084fdd562690c08f1ee72bc08e63e8ee576dc86a.1693001599.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <084fdd562690c08f1ee72bc08e63e8ee576dc86a.1693001599.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe

On Sat, Aug 26, 2023 at 12:13:40AM +0200, Christophe JAILLET wrote:
> This is odd to have a of_node_put() just after a for_each_child_of_node()
> or a for_each_endpoint_of_node() loop. It should already be called
> during the last iteration.

Let's unwrap the calls:

#define for_each_child_of_node(parent, child) \
     for (child = of_get_next_child(parent, NULL); child != NULL; \
          child = of_get_next_child(parent, child))

static struct device_node *__of_get_next_child(const struct device_node *node,
						struct device_node *prev)
{
	struct device_node *next;

	if (!node)
		return NULL;

	next = prev ? prev->sibling : node->child;
	of_node_get(next);
	of_node_put(prev);
	return next;
}

Let's express the C for loop semantic as a while to help following the
code:

        child = of_get_next_child(parent, NULL);
        while (child != NULL)
                child = of_get_next_child(parent, child);

I concur that the last loop iteration the call to
__of_get_next_child() will expand to

        next = NULL;
        of_node_get(NULL);
        of_node_put(prev)

So it seems to me it is not necessary to put the node after
for_each_child_of_node() ?

In facts none of the other usages of for_each_child_of_node() in the
kernel (the ones i checked at least) have a put() after the loop.

>
> Remove these calls.
>
> Fixes: 66d8c9d2422d ("media: i2c: Add MAX9286 driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

Thanks
  j

> ---
> /!\  This patch is speculative, review with case  /!\
> ---
>  drivers/media/i2c/max9286.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
> index 20e7c7cf5eeb..f27a69b1b727 100644
> --- a/drivers/media/i2c/max9286.c
> +++ b/drivers/media/i2c/max9286.c
> @@ -1450,7 +1450,6 @@ static int max9286_parse_dt(struct max9286_priv *priv)
>
>  		i2c_mux_mask |= BIT(id);
>  	}
> -	of_node_put(node);
>  	of_node_put(i2c_mux);
>
>  	/* Parse the endpoints */
> @@ -1514,7 +1513,6 @@ static int max9286_parse_dt(struct max9286_priv *priv)
>  		priv->source_mask |= BIT(ep.port);
>  		priv->nsources++;
>  	}
> -	of_node_put(node);
>
>  	of_property_read_u32(dev->of_node, "maxim,bus-width", &priv->bus_width);
>  	switch (priv->bus_width) {
> --
> 2.34.1
>
