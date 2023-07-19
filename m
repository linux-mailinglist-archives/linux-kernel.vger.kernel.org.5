Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7CF758F19
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjGSHeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGSHeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:34:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC598E43;
        Wed, 19 Jul 2023 00:34:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78751612F3;
        Wed, 19 Jul 2023 07:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3D7C433C8;
        Wed, 19 Jul 2023 07:34:11 +0000 (UTC)
Message-ID: <81c898ca-cf43-d6b8-8686-a274c7adf3be@xs4all.nl>
Date:   Wed, 19 Jul 2023 09:34:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Initialization of read buffer for dib3000_read_reg
Content-Language: en-US
To:     Kernel-Development <kdev@benbenng.net>,
        "mchehab@kernel.org" <mchehab@kernel.org>
Cc:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "syzbot+c88fc0ebe0d5935c70da@syzkaller.appspotmail.com" 
        <syzbot+c88fc0ebe0d5935c70da@syzkaller.appspotmail.com>
References: <20230413091841.22000-1-kdev@benbenng.net>
 <0100018779eb40dc-cee9e39d-5d87-4733-83db-eca5218fcc8f-000000@email.amazonses.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <0100018779eb40dc-cee9e39d-5d87-4733-83db-eca5218fcc8f-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some comments on this patch:

On 13/04/2023 11:21, Kernel-Development wrote:
> This is a patch that fixes a bug:
> KMSAN: uninit-value in dib3000mb_attach (2)
> 
> Local variable u8 rb[2] is not initialized as it is used as read buffer
> for i2c_transfer(). It is expected that i2c_transfer() should fill in
> the buffer before the target function returns rb's content. However
> error handling of i2c_transfer is not done, and on occasions where the
> read fails, uninitialized rb value will be returned.
> 
> The usage of this function, defined as macro rd() in
> drivers/media/dvb-frontends/dib3000mb_priv,h, does not expect any error
> to occur. Adding error handling here might involve significant code
> changes.
> 
> Thus 0-initialization is done on rb. This might affect some logic on
> error case as the use of the return value is used as boolean and flags.
> 
> Reported-by: syzbot+c88fc0ebe0d5935c70da@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=2f4d19de8c9e9f0b9794e53ca54d68e0ffe9f068
> Signed-off-by: (Ben) HokChun Ng <kdev@benbenng.net>
> ---
>  drivers/media/dvb-frontends/dib3000mb.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/dvb-frontends/dib3000mb.c b/drivers/media/dvb-frontends/dib3000mb.c
> index a6c2fc4586eb..0dd96656aaf4 100644
> --- a/drivers/media/dvb-frontends/dib3000mb.c
> +++ b/drivers/media/dvb-frontends/dib3000mb.c
> @@ -50,15 +50,19 @@ MODULE_PARM_DESC(debug, "set debugging level (1=info,2=xfer,4=setfe,8=getfe (|-a
>  
>  static int dib3000_read_reg(struct dib3000_state *state, u16 reg)
>  {
> +	int errno;
>  	u8 wb[] = { ((reg >> 8) | 0x80) & 0xff, reg & 0xff };
> -	u8 rb[2];
> +	u8 rb[2] = { 0, 0 };

Really all you need to do here is zero this array, which can be even
shorter by writing: u8 rb[2] = {};

It is enough to just show the "i2c read error" message, nothing else
is needed here.

BTW, checkpatch.pl also complains about your email address ('Kernel-Development <kdev@benbenng.net>'
being different from your SoB line: (Ben) HokChun Ng <kdev@benbenng.net>.

It's a good idea to ensure the two are the same. I would stick to
(Ben) HokChun Ng <kdev@benbenng.net> since that has your actual name.

Regards,

	Hans

>  	struct i2c_msg msg[] = {
>  		{ .addr = state->config.demod_address, .flags = 0,        .buf = wb, .len = 2 },
>  		{ .addr = state->config.demod_address, .flags = I2C_M_RD, .buf = rb, .len = 2 },
>  	};
>  
> -	if (i2c_transfer(state->i2c, msg, 2) != 2)
> -		deb_i2c("i2c read error\n");
> +	errno = i2c_transfer(state->i2c, msg, 2);
> +	if (errno != 2) {
> +		deb_i2c("i2c read error (errno: %d)\n", -errno);
> +		return 0;
> +	}
>  
>  	deb_i2c("reading i2c bus (reg: %5d 0x%04x, val: %5d 0x%04x)\n",reg,reg,
>  			(rb[0] << 8) | rb[1],(rb[0] << 8) | rb[1]);

