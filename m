Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59F97EB6EB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 20:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjKNTes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 14:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKNTer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 14:34:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE74E102
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 11:34:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C113C433C7;
        Tue, 14 Nov 2023 19:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699990483;
        bh=EAHDqUEEKtXeWe5W9DXxOytpOiD9zxXvd26YHTDARZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SNRCsM6BWahAGQ4iw/ouMLweTkrArRy3nv5NL64fQFrU7TRyJMBX6oPqu4yopRH83
         +LEjrBnNFBW2VgUqRF4M4YQcOHvhdPNmxOHYPqUrRiSEf8pgDf7NiA2AyudxUQ1lcb
         yNKZG6b8XtozsybWJbbpDJfPScp1nuo2x9HYgtcCfReoTGaTWN9YT5KalAVA2NwH+Y
         iZ97MXkR98kPcEcHimti30QSmvHAeSw2xEreWv+gcXXdt9OFQUerKDZsa3LEsgphjP
         HXkB48ED8OuWgzK4KHx9jJ2EjqJJZUq8ny6/y+CcgxUdKcASafzpLdTrnxVrfw6uNH
         L6x2Yub73LbkA==
Date:   Tue, 14 Nov 2023 19:34:39 +0000
From:   Simon Horman <horms@kernel.org>
To:     Min Li <lnimi@hotmail.com>
Cc:     richardcochran@gmail.com, lee@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v3 1/1] ptp: clockmatrix: support 32-bit address
 space
Message-ID: <20231114193439.GF74656@kernel.org>
References: <MW5PR03MB69324AE8F4C54FE03BD93A55A0B3A@MW5PR03MB6932.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR03MB69324AE8F4C54FE03BD93A55A0B3A@MW5PR03MB6932.namprd03.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 10:50:46AM -0500, Min Li wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> We used to assume 0x2010xxxx address. Now that
> we need to access 0x2011xxxx address, we need
> to support read/write the whole 32-bit address space.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
> - Drop MAX_ABS_WRITE_PHASE_PICOSECONDS advised by Rahul
> - Apply SCSR_ADDR to scrach register in idtcm_load_firmware advised by Simon

Hi Min Li,

thanks for addressing my earlier feedback.
I have done a more thorough review of this version,
I hope that it is useful.

>  drivers/ptp/ptp_clockmatrix.c    |  59 ++--
>  drivers/ptp/ptp_clockmatrix.h    |  32 +-
>  include/linux/mfd/idt8a340_reg.h | 542 ++++++++++++++++---------------
>  3 files changed, 325 insertions(+), 308 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
> index f6f9d4adce04..4d7898dc39d5 100644
> --- a/drivers/ptp/ptp_clockmatrix.c
> +++ b/drivers/ptp/ptp_clockmatrix.c
> @@ -41,7 +41,7 @@ module_param(firmware, charp, 0);
>  static int _idtcm_adjfine(struct idtcm_channel *channel, long scaled_ppm);
>  
>  static inline int idtcm_read(struct idtcm *idtcm,
> -			     u16 module,
> +			     u32 module,
>  			     u16 regaddr,
>  			     u8 *buf,
>  			     u16 count)
> @@ -50,7 +50,7 @@ static inline int idtcm_read(struct idtcm *idtcm,
>  }
>  
>  static inline int idtcm_write(struct idtcm *idtcm,
> -			      u16 module,
> +			      u32 module,
>  			      u16 regaddr,
>  			      u8 *buf,
>  			      u16 count)

I see that this patch expands the width of the module parameter of
idtcm_read() and idtcm_write(). And that with this change the module
parameter's leading 16bits are 0x2010. And that this is done to allow the
leading bits to be a different value, which I assume will be utilised in a
follow-up patch. But I am unclear on how the code handles that the
underlying read/write is now to an address 0x2010000 bytes greater than
before, or alternatively, how 0x2010000 was previously taken into account.

Also:

1. idtcm_output_enable() still seems to pass a 16-bit value as the module
   parameter to idtcm_read() and idtcm_write(), which seems inconsistent
   with this patch.

2. Related to 1., get_output_base_addr() returns an int which either
   encodes a negative error value (good) or a 32bit address (maybe not so
   good).

3. Some more of the idtcm_write() calls in _sync_pll_output() seem
   to need updating by inverting the 2nd and 3rd parameters
   so that the 2nd parameter is 32bits. I'm referring to the use
   of sync_ctrl0 and sync_ctrl1 as arguments to idtcm_write().

...

> @@ -1705,7 +1720,7 @@ static s32 idtcm_getmaxphase(struct ptp_clock_info *ptp __always_unused)
>  }
>  
>  /*
> - * Internal function for implementing support for write phase offset
> + * Maximum absolute value for write phase offset in picoseconds
>   *
>   * @channel:  channel
>   * @delta_ns: delta in nanoseconds
> @@ -1717,6 +1732,7 @@ static int _idtcm_adjphase(struct idtcm_channel *channel, s32 delta_ns)
>  	u8 i;
>  	u8 buf[4] = {0};
>  	s32 phase_50ps;
> +	s64 offset_ps;
>  
>  	if (channel->mode != PTP_PLL_MODE_WRITE_PHASE) {
>  		err = channel->configure_write_phase(channel);
> @@ -1724,7 +1740,8 @@ static int _idtcm_adjphase(struct idtcm_channel *channel, s32 delta_ns)
>  			return err;
>  	}
>  
> -	phase_50ps = div_s64((s64)delta_ns * 1000, 50);
> +	offset_ps = (s64)delta_ns * 1000;
> +	phase_50ps = div_s64(offset_ps, 50);
>  
>  	for (i = 0; i < 4; i++) {
>  		buf[i] = phase_50ps & 0xff;

It is unclear to me how the _idtcm_adjphase changes in the above 3 hunks
relate to the patch description. I wonder if this should be a separate patch?

> diff --git a/drivers/ptp/ptp_clockmatrix.h b/drivers/ptp/ptp_clockmatrix.h
> index 7c17c4f7f573..ad39dc6decdf 100644
> --- a/drivers/ptp/ptp_clockmatrix.h
> +++ b/drivers/ptp/ptp_clockmatrix.h
> @@ -54,21 +54,9 @@
>  #define LOCK_TIMEOUT_MS			(2000)
>  #define LOCK_POLL_INTERVAL_MS		(10)
>  
> -#define IDTCM_MAX_WRITE_COUNT		(512)
> -

Removing IDTCM_MAX_WRITE_COUNT seems nice, if it is unused.
But this doesn't seem related to the rest of this patch,
so perhaps it should be a separate patch.

...

> diff --git a/include/linux/mfd/idt8a340_reg.h b/include/linux/mfd/idt8a340_reg.h
> index 0c706085c205..b680a0eb5f68 100644
> --- a/include/linux/mfd/idt8a340_reg.h
> +++ b/include/linux/mfd/idt8a340_reg.h
> @@ -7,20 +7,20 @@
>  #ifndef HAVE_IDT8A340_REG
>  #define HAVE_IDT8A340_REG
>  
> -#define PAGE_ADDR_BASE                    0x0000
> -#define PAGE_ADDR                         0x00fc

Likewise, cleaning up PAGE_ADDR_BASE and PAGE_ADDR doesn't
seem strictly related to this patch. Though perhaps I am missing
something obvious.

...
