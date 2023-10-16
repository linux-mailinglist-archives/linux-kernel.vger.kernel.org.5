Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF6B7CA57C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjJPKds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPKdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:33:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A7483;
        Mon, 16 Oct 2023 03:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697452426; x=1728988426;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XYtfn268wDdb2xRd7dtN0hGq1egPK3I+Lq+i14Uyjos=;
  b=SSRQRLScXZPJFYwofc0oEmn8gtyfOpPeAVBO0EKl0R/fhm0JrLzoOrEF
   ppBxq5wbziNnjD+l+FL+EdILx70+emb4GW3Y7EVNjhF0QynVFV8aDgl74
   WYaTLBPQRpnne9u+2KbuExsbH7JOkCYaZEI4Vd9CVOhj/sXOV6PYs/9Tu
   y4+Wa0D65yp4BGRZUFF5P3I9oynfMUzmV9WIbGoc2rnC9leKy7OMOOA/p
   PWCi3KQ1o7r4d+XnK3IR/b7EJTqK9TN/zdSKq4B/a4maAZ/Ux353ULN52
   IyEiaHLF+bfKVwbsKmy3pnA/nARbBRMfy35mhWXW9bzukuaYEQ6gKjyLU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="4106426"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="4106426"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 03:33:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="899446234"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="899446234"
Received: from rhaeussl-mobl.ger.corp.intel.com ([10.252.59.103])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 03:31:45 -0700
Date:   Mon, 16 Oct 2023 13:33:41 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Vamshi Gajjela <vamshigajjela@google.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, manugautam@google.com,
        Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>
Subject: Re: [PATCH 1/3] serial: core: Potential overflow of frame_time
In-Reply-To: <20231014104942.856152-2-vamshigajjela@google.com>
Message-ID: <6f25e6fb-bebc-3f9b-9876-5e14d2582f6@linux.intel.com>
References: <20231014104942.856152-1-vamshigajjela@google.com> <20231014104942.856152-2-vamshigajjela@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1847621484-1697452425=:1986"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1847621484-1697452425=:1986
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sat, 14 Oct 2023, Vamshi Gajjela wrote:

> From: VAMSHI GAJJELA <vamshigajjela@google.com>
> 
> uart_update_timeout() sets a u64 value to an unsigned int frame_time.

Yes it does, because uart_update_timeout() does math that requires u64 but 
the result is always smaller than what requires u64. If you insist on 
doing something add the cast there.

> While it can be cast to u32 before assignment, there's a specific case
> where frame_time is cast to u64.

Because it gets multipled with something that results in a big number
The cast is all correct too because the developer actually thought of 
possiblity of an overflow on multiply (something every developer should 
be conscious of), so there's nothing to see there either. 

> Since frame_time consistently
> participates in u64 arithmetic, its data type is converted to u64 to
> eliminate the need for explicit casting.

You need a way more convincing argument that that since you're not even 
converting it to u64 like you falsely stated so the sizes still won't 
match on all architectures.

I see you've realized u32 is more than enough to store frame time for the 
speeds UART operates with? So why exactly is this patch needed? Should all 
the other cases where 64-bit arithmetic needs to be used in the kernel be 
similarly upconverted to 64 bits?

Also, did you happen to realize frame_time also participates in 32-bit 
arithmetic which you just make much worse with this change? (Yes, there 
are 32-bit divides done for it.)

So NACK from me to this "fix" of a non-problem by causing much worse 
problems you seem to be entirely unaware.

NACKED-by:  Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

> Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
> ---
>  include/linux/serial_core.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index bb6f073bc159..b128513b009a 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -558,7 +558,7 @@ struct uart_port {
>  
>  	bool			hw_stopped;		/* sw-assisted CTS flow state */
>  	unsigned int		mctrl;			/* current modem ctrl settings */
> -	unsigned int		frame_time;		/* frame timing in ns */
> +	unsigned long		frame_time;		/* frame timing in ns */
>  	unsigned int		type;			/* port type */
>  	const struct uart_ops	*ops;
>  	unsigned int		custom_divisor;
> @@ -764,7 +764,7 @@ unsigned int uart_get_divisor(struct uart_port *port, unsigned int baud);
>   */
>  static inline unsigned long uart_fifo_timeout(struct uart_port *port)
>  {
> -	u64 fifo_timeout = (u64)READ_ONCE(port->frame_time) * port->fifosize;
> +	u64 fifo_timeout = READ_ONCE(port->frame_time) * port->fifosize;
>  
>  	/* Add .02 seconds of slop */
>  	fifo_timeout += 20 * NSEC_PER_MSEC;
> 
--8323329-1847621484-1697452425=:1986--
