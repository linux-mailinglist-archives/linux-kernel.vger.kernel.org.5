Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE357C9735
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 01:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjJNXOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 19:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJNXOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 19:14:07 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BC7B7;
        Sat, 14 Oct 2023 16:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=1c3txNHZeejcpxtcDKwHKiD/0cQWQlYfIFYfb+CR5c0=; b=ZAxCfK9YH4kE7qE5ymfUlbYT9Y
        3wWKRNe6KK0qcNC7TmB0H+Ua/Gg8hnKN9etap2sxNj3pRUtE1iOTqGbJUwyXF571vhq8CctsJY8Jf
        a7tjrl/PMru9oATm60T3rz5C5DeA0CKPirtb9Z2wv7z/HuAqofvCk1lQ0MDfFh6a7l/0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:38996 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qrnpT-00016Z-RV; Sat, 14 Oct 2023 19:13:56 -0400
Date:   Sat, 14 Oct 2023 19:13:55 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Vamshi Gajjela <vamshigajjela@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        ilpo.jarvinen@linux.intel.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>
Message-Id: <20231014191355.7f44aac3537a8d260225fa0c@hugovil.com>
In-Reply-To: <20231014181333.2579530-1-vamshigajjela@google.com>
References: <20231014181333.2579530-1-vamshigajjela@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 1/3] serial: core: Potential overflow of frame_time
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Oct 2023 23:43:33 +0530
Vamshi Gajjela <vamshigajjela@google.com> wrote:

> From: VAMSHI GAJJELA <vamshigajjela@google.com>

Hi,
your commit title doesn't really explain what this patch is doing.

Please see: https://cbea.ms/git-commit/#imperative


> uart_update_timeout() sets a u64 value to an unsigned int frame_time.
> While it can be cast to u32 before assignment, there's a specific case
> where frame_time is cast to u64. Since frame_time consistently
> participates in u64 arithmetic, its data type is converted to u64 to
> eliminate the need for explicit casting.

Again, refering to your title commit message, I would expect that you
would describe precisely how a potential overflow can happen here, and
I am not seeing it.

And based on your log message, it seems that your commit is simply some
kind of optimization, not a fix?

Hugo.



> Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
> ---
> v2:
> - use DIV64_U64_ROUND_UP with frame_time
> 
>  drivers/tty/serial/8250/8250_port.c | 2 +-
>  include/linux/serial_core.h         | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 141627370aab..d1bf794498c4 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1510,7 +1510,7 @@ static inline void __stop_tx(struct uart_8250_port *p)
>  			 * rather than after it is fully sent.
>  			 * Roughly estimate 1 extra bit here with / 7.
>  			 */
> -			stop_delay = p->port.frame_time + DIV_ROUND_UP(p->port.frame_time, 7);
> +			stop_delay = p->port.frame_time + DIV64_U64_ROUND_UP(p->port.frame_time, 7);
>  		}
>  
>  		__stop_tx_rs485(p, stop_delay);
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
> -- 
> 2.42.0.655.g421f12c284-goog
> 
