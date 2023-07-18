Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B412757FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjGROpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjGROpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:45:41 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59402EC;
        Tue, 18 Jul 2023 07:45:36 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 69EBA899;
        Tue, 18 Jul 2023 16:44:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689691481;
        bh=669G/reeV5KFCerQAHZbVYzVd6yogImIgY+avsAUZgA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lw2ofPbweF/ExKF68LdNOerYwFT3RXdUenU1XGFHJUibAciq+0suXIiKfxSVyRjBn
         CUIOeB4Xv9VMAcxvBZNDIqREKEby/wKcV1x2tl4GMG3XvNGJqvrHUKpfD9wy83bsnD
         JMna4WSZcluc/y94xFkhtO8//xF+4qGcYdw55sOc=
Message-ID: <0f37556d-629b-93bd-6c6d-60126d714a65@ideasonboard.com>
Date:   Tue, 18 Jul 2023 17:45:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 next] media: i2c: fix error handling in
 ub960_rxport_add_serializer()
Content-Language: en-US
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20230718140659.4009167-1-harshit.m.mogalapalli@oracle.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230718140659.4009167-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 17:06, Harshit Mogalapalli wrote:
> Smatch warns:
>   drivers/media/i2c/ds90ub960.c:1671 ub960_rxport_add_serializer():
>   err: 'rxport->ser.client' dereferencing possible ERR_PTR()
> 
> i2c_new_client_device() returns error pointers on failure and in
> dev_dbg statement we are dereferencing error pointer which is a bug.
> 
> Fix this by using IS_ERR() which checks for error pointers.
> 
> Fixes: afe267f2d368 ("media: i2c: add DS90UB960 driver")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is based on static analysis and only compile tested.
> 
> V1->V2: Suggestion from Tomi Valkeinen: Propogate the error code with
> PTR_ERR() instead of -EIO.
> ---
>   drivers/media/i2c/ds90ub960.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/ds90ub960.c b/drivers/media/i2c/ds90ub960.c
> index e101bcf2356a..92aa004a3674 100644
> --- a/drivers/media/i2c/ds90ub960.c
> +++ b/drivers/media/i2c/ds90ub960.c
> @@ -1662,10 +1662,10 @@ static int ub960_rxport_add_serializer(struct ub960_data *priv, u8 nport)
>   	ser_info.addr = rxport->ser.alias;
>   	rxport->ser.client =
>   		i2c_new_client_device(priv->client->adapter, &ser_info);
> -	if (!rxport->ser.client) {
> +	if (IS_ERR(rxport->ser.client)) {
>   		dev_err(dev, "rx%u: cannot add %s i2c device", nport,
>   			ser_info.type);
> -		return -EIO;
> +		return PTR_ERR(rxport->ser.client);
>   	}
>   
>   	dev_dbg(dev, "rx%u: remote serializer at alias 0x%02x (%u-%04x)\n",

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

