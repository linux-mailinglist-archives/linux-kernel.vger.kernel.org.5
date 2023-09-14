Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D8E7A0B5F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbjINRQr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 13:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238630AbjINRQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:16:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37B01FE8;
        Thu, 14 Sep 2023 10:16:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC882C433C7;
        Thu, 14 Sep 2023 17:16:40 +0000 (UTC)
Date:   Thu, 14 Sep 2023 13:17:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: Re: [PATCH] tracing/user_events: align uaddr on unsigned long
 alignment
Message-ID: <20230914131700.0ba3ee80@gandalf.local.home>
In-Reply-To: <20230914131102.179100-1-cleger@rivosinc.com>
References: <20230914131102.179100-1-cleger@rivosinc.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023 15:11:02 +0200
Clément Léger <cleger@rivosinc.com> wrote:

> @@ -511,13 +511,19 @@ static int user_event_enabler_write(struct user_event_mm *mm,
>  	}
>  
>  	kaddr = kmap_local_page(page);
> +
> +	bit_offset = uaddr & (sizeof(unsigned long) - 1);
> +	if (bit_offset) {
> +		bit_offset *= 8;
> +		uaddr &= ~(sizeof(unsigned long) - 1);
> +	}
>  	ptr = kaddr + (uaddr & ~PAGE_MASK);
>  
>  	/* Update bit atomically, user tracers must be atomic as well */
>  	if (enabler->event && enabler->event->status)
> -		set_bit(ENABLE_BIT(enabler), ptr);
> +		set_bit(ENABLE_BIT(enabler) + bit_offset, ptr);
>  	else
> -		clear_bit(ENABLE_BIT(enabler), ptr);
> +		clear_bit(ENABLE_BIT(enabler) + bit_offset, ptr);
>  
>  	kunmap_local(kaddr);
>  	unpin_user_pages_dirty_lock(&page, 1, true);

Does this work for big endian machines too?

Little endian layout:

 uaddr = 0xbeef0004
 enabler = 1;

 memory at 0xbeef0000:  00 00 00 00 02 00 00 00
                                    ^
                                    addr: 0xbeef0004

				(enabler is set )

	bitoffset = uaddr & (sizeof(unsigned long) - 1); bitoffset = 4
	bit_offset *= 8;				 bitoffset = 32
	uaddr &= ~(sizeof(unsigned long) - 1);		 uaddr = 0xbeef0000

	ptr = kaddr + (uaddr & ~PAGE_MASK);

	clear_bit(1 + 32, ptr);

 memory at 0xbeef0000:  00 00 00 00 02 00 00 00
                                     ^
				bit 33 of 0xbeef0000

Now lets look at big endian layout:

 uaddr = 0xbeef0004
 enabler = 1;

 memory at 0xbeef0000:  00 00 00 00 00 00 00 02
                                    ^
                                    addr: 0xbeef0004

				(enabler is set )

	bitoffset = uaddr & (sizeof(unsigned long) - 1); bitoffset = 4
	bit_offset *= 8;				 bitoffset = 32
	uaddr &= ~(sizeof(unsigned long) - 1);		 uaddr = 0xbeef0000

	ptr = kaddr + (uaddr & ~PAGE_MASK);

	clear_bit(1 + 32, ptr);

 memory at 0xbeef0000:  00 00 00 00 00 00 00 02
                                  ^
				bit 33 of 0xbeef0000

I don't think that's what you expected!

-- Steve
