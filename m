Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA11D758FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjGSHxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjGSHx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:53:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E8A2702;
        Wed, 19 Jul 2023 00:53:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A98C5612F0;
        Wed, 19 Jul 2023 07:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09501C433C7;
        Wed, 19 Jul 2023 07:53:08 +0000 (UTC)
Message-ID: <b176e4ae-7000-45af-64ba-2a5bd948f1e3@xs4all.nl>
Date:   Wed, 19 Jul 2023 09:53:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/1] media: drxk: Use %*ph for printing hexdump of a
 small buffer
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230612212038.3876-1-andriy.shevchenko@linux.intel.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230612212038.3876-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 12/06/2023 23:20, Andy Shevchenko wrote:
> The kernel already has a helper to print a hexdump of a small
> buffer via pointer extension. Use that instead of open coded
> variant.
> 
> In long term it helps to kill pr_cont() or at least narrow down
> its use.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/media/dvb-frontends/drxk_hard.c | 28 ++++++-------------------
>  1 file changed, 6 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/media/dvb-frontends/drxk_hard.c b/drivers/media/dvb-frontends/drxk_hard.c
> index 3301ef75d441..14035deeb6d8 100644
> --- a/drivers/media/dvb-frontends/drxk_hard.c
> +++ b/drivers/media/dvb-frontends/drxk_hard.c
> @@ -229,13 +229,8 @@ static int i2c_write(struct drxk_state *state, u8 adr, u8 *data, int len)
>  	struct i2c_msg msg = {
>  	    .addr = adr, .flags = 0, .buf = data, .len = len };
>  
> -	dprintk(3, ":");
> -	if (debug > 2) {
> -		int i;
> -		for (i = 0; i < len; i++)
> -			pr_cont(" %02x", data[i]);
> -		pr_cont("\n");
> -	}
> +	dprintk(3, ": %*ph\n", len, data);
> +
>  	status = drxk_i2c_transfer(state, &msg, 1);
>  	if (status >= 0 && status != 1)
>  		status = -EIO;
> @@ -268,14 +263,8 @@ static int i2c_read(struct drxk_state *state,
>  		return status;
>  	}
>  	if (debug > 2) {
> -		int i;
> -		dprintk(2, ": read from");
> -		for (i = 0; i < len; i++)
> -			pr_cont(" %02x", msg[i]);
> -		pr_cont(", value = ");
> -		for (i = 0; i < alen; i++)
> -			pr_cont(" %02x", answ[i]);
> -		pr_cont("\n");
> +		dprintk(2, ": read from %*ph, value = %*ph\n", len, msg,
> +			alen, answ);

The patch looks good, except here the dprintk debug level should be 3, not 2.
With that change the 'if (debug > 2)' can be dropped as well.

Regards,

	Hans

>  	}
>  	return 0;
>  }
> @@ -441,13 +430,8 @@ static int write_block(struct drxk_state *state, u32 address,
>  		}
>  		memcpy(&state->chunk[adr_length], p_block, chunk);
>  		dprintk(2, "(0x%08x, 0x%02x)\n", address, flags);
> -		if (debug > 1) {
> -			int i;
> -			if (p_block)
> -				for (i = 0; i < chunk; i++)
> -					pr_cont(" %02x", p_block[i]);
> -			pr_cont("\n");
> -		}
> +		if (p_block)
> +			dprintk(2, "%*ph\n", chunk, p_block);
>  		status = i2c_write(state, state->demod_address,
>  				   &state->chunk[0], chunk + adr_length);
>  		if (status < 0) {

