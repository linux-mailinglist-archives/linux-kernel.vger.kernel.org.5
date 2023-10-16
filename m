Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B335B7C9EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjJPFfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjJPFfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:35:14 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16AE120;
        Sun, 15 Oct 2023 22:35:05 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-405497850dbso41234255e9.0;
        Sun, 15 Oct 2023 22:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697434504; x=1698039304;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOvvTQQy+JfGRbCEkEtFd8cZk3x1MPjZLKQ8b9QGiKU=;
        b=d8pASWNRWlheRT/OCvXdBIC3LJQoEiBKaaRv8pURKL3lQg2g4GKjLQkQg4dbzfQTnL
         j7EoHln3Er1wOQwbvjVEKRWpYp3YJJDo9Rv3E7v05QZqbSahRlRkiagy3tBvobbwNCRU
         7a+4X2FHN3g6dgzDULM58roEbv66kQkq7xR579YfFzoZvWMQIhNMVkEThWHoOJMl9N2y
         CayQWpBlsKHyw5NpPW//MiY8B9SEnoj7Mha4WRxSfXmTrttFmfr/rQZ5lsZqQdYlQI8I
         PmKozCOMSMBLFiHo2FXK39B96ryy0aGdvggEoHx6s5HezOuP5aGK0RsEh9Z8FskKuEqK
         UT2w==
X-Gm-Message-State: AOJu0YxYMfmoHf/957hE2kww/LsvsxT2/Pp6QDUB1UINGeygHLu5ofM8
        cLZzhbgXkuDa1DsPR4Al4chhXsnJEqk=
X-Google-Smtp-Source: AGHT+IFPZe+piZQPNHSWAA8zt7wf5lSfRigoQiafEWSLJwRkAESEX8SvLMO4dQgrZTTnxw5TiwCvnA==
X-Received: by 2002:a05:600c:2197:b0:405:514d:eb0e with SMTP id e23-20020a05600c219700b00405514deb0emr28704305wme.19.1697434503719;
        Sun, 15 Oct 2023 22:35:03 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b00405c7591b09sm6161011wmq.35.2023.10.15.22.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 22:35:03 -0700 (PDT)
Message-ID: <0d5f9af2-22ac-4753-8c5a-76c4d44dcc9c@kernel.org>
Date:   Mon, 16 Oct 2023 07:35:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] serial: core: Potential overflow of frame_time
Content-Language: en-US
To:     Vamshi Gajjela <vamshigajjela@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>
References: <20231014181333.2579530-1-vamshigajjela@google.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20231014181333.2579530-1-vamshigajjela@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14. 10. 23, 20:13, Vamshi Gajjela wrote:
> From: VAMSHI GAJJELA <vamshigajjela@google.com>
> 
> uart_update_timeout() sets a u64 value to an unsigned int frame_time.
> While it can be cast to u32 before assignment, there's a specific case
> where frame_time is cast to u64. Since frame_time consistently
> participates in u64 arithmetic, its data type is converted to u64 to
> eliminate the need for explicit casting.

And make the divisions by the order of magnutude slower for no good 
reason? (Hint: have you looked what DIV64_U64_ROUND_UP() looks like on 
32bit yet?)

Unless you provide a reason it can overflow in real (in fact you spell 
the opposite in the text above):
NACKED-by: Jiri Slaby <jirislaby@kernel.org>

> Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
> ---
> v2:
> - use DIV64_U64_ROUND_UP with frame_time
> 
>   drivers/tty/serial/8250/8250_port.c | 2 +-
>   include/linux/serial_core.h         | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 141627370aab..d1bf794498c4 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1510,7 +1510,7 @@ static inline void __stop_tx(struct uart_8250_port *p)
>   			 * rather than after it is fully sent.
>   			 * Roughly estimate 1 extra bit here with / 7.
>   			 */
> -			stop_delay = p->port.frame_time + DIV_ROUND_UP(p->port.frame_time, 7);
> +			stop_delay = p->port.frame_time + DIV64_U64_ROUND_UP(p->port.frame_time, 7);
>   		}
>   
>   		__stop_tx_rs485(p, stop_delay);
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index bb6f073bc159..b128513b009a 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -558,7 +558,7 @@ struct uart_port {
>   
>   	bool			hw_stopped;		/* sw-assisted CTS flow state */
>   	unsigned int		mctrl;			/* current modem ctrl settings */
> -	unsigned int		frame_time;		/* frame timing in ns */
> +	unsigned long		frame_time;		/* frame timing in ns */
>   	unsigned int		type;			/* port type */
>   	const struct uart_ops	*ops;
>   	unsigned int		custom_divisor;
> @@ -764,7 +764,7 @@ unsigned int uart_get_divisor(struct uart_port *port, unsigned int baud);
>    */
>   static inline unsigned long uart_fifo_timeout(struct uart_port *port)
>   {
> -	u64 fifo_timeout = (u64)READ_ONCE(port->frame_time) * port->fifosize;
> +	u64 fifo_timeout = READ_ONCE(port->frame_time) * port->fifosize;
>   
>   	/* Add .02 seconds of slop */
>   	fifo_timeout += 20 * NSEC_PER_MSEC;

-- 
js
suse labs

