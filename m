Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4D87B43A7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 22:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjI3Ulm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Sep 2023 16:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjI3Ull (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 16:41:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8791DCA;
        Sat, 30 Sep 2023 13:41:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E3EC433C7;
        Sat, 30 Sep 2023 20:41:38 +0000 (UTC)
Date:   Sat, 30 Sep 2023 16:41:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: Re: [for-linus][PATCH 3/4] tracing/user_events: Align set_bit()
 address for all archs
Message-ID: <20230930164136.7517caab@rorschach.local.home>
In-Reply-To: <20230930203821.843544914@goodmis.org>
References: <20230930203213.826737400@goodmis.org>
        <20230930203821.843544914@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ Replying to show this patch that got dropped from the mailing list ]

On Sat, 30 Sep 2023 16:32:16 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Beau Belgrave <beaub@linux.microsoft.com>
> 
> All architectures should use a long aligned address passed to set_bit().
> User processes can pass either a 32-bit or 64-bit sized value to be
> updated when tracing is enabled when on a 64-bit kernel. Both cases are
> ensured to be naturally aligned, however, that is not enough. The
> address must be long aligned without affecting checks on the value
> within the user process which require different adjustments for the bit
> for little and big endian CPUs.
> 
> Add a compat flag to user_event_enabler that indicates when a 32-bit
> value is being used on a 64-bit kernel. Long align addresses and correct
> the bit to be used by set_bit() to account for this alignment. Ensure
> compat flags are copied during forks and used during deletion clears.
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20230925230829.341-2-beaub@linux.microsoft.com
> Link: https://lore.kernel.org/linux-trace-kernel/20230914131102.179100-1-cleger@rivosinc.com/
> 
> Cc: stable@vger.kernel.org
> Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
> Reported-by: Clément Léger <cleger@rivosinc.com>
> Suggested-by: Clément Léger <cleger@rivosinc.com>
> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_user.c | 58 ++++++++++++++++++++++++++++----
>  1 file changed, 51 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 6f046650e527..b87f41187c6a 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -127,8 +127,13 @@ struct user_event_enabler {
>  /* Bit 7 is for freeing status of enablement */
>  #define ENABLE_VAL_FREEING_BIT 7
>  
> -/* Only duplicate the bit value */
> -#define ENABLE_VAL_DUP_MASK ENABLE_VAL_BIT_MASK
> +/* Bit 8 is for marking 32-bit on 64-bit */
> +#define ENABLE_VAL_32_ON_64_BIT 8
> +
> +#define ENABLE_VAL_COMPAT_MASK (1 << ENABLE_VAL_32_ON_64_BIT)
> +
> +/* Only duplicate the bit and compat values */
> +#define ENABLE_VAL_DUP_MASK (ENABLE_VAL_BIT_MASK | ENABLE_VAL_COMPAT_MASK)
>  
>  #define ENABLE_BITOPS(e) (&(e)->values)
>  
> @@ -174,6 +179,30 @@ struct user_event_validator {
>  	int			flags;
>  };
>  
> +static inline void align_addr_bit(unsigned long *addr, int *bit,
> +				  unsigned long *flags)
> +{
> +	if (IS_ALIGNED(*addr, sizeof(long))) {
> +#ifdef __BIG_ENDIAN
> +		/* 32 bit on BE 64 bit requires a 32 bit offset when aligned. */
> +		if (test_bit(ENABLE_VAL_32_ON_64_BIT, flags))
> +			*bit += 32;
> +#endif
> +		return;
> +	}
> +
> +	*addr = ALIGN_DOWN(*addr, sizeof(long));
> +
> +	/*
> +	 * We only support 32 and 64 bit values. The only time we need
> +	 * to align is a 32 bit value on a 64 bit kernel, which on LE
> +	 * is always 32 bits, and on BE requires no change when unaligned.
> +	 */
> +#ifdef __LITTLE_ENDIAN
> +	*bit += 32;
> +#endif
> +}
> +
>  typedef void (*user_event_func_t) (struct user_event *user, struct iov_iter *i,
>  				   void *tpdata, bool *faulted);
>  
> @@ -482,6 +511,7 @@ static int user_event_enabler_write(struct user_event_mm *mm,
>  	unsigned long *ptr;
>  	struct page *page;
>  	void *kaddr;
> +	int bit = ENABLE_BIT(enabler);
>  	int ret;
>  
>  	lockdep_assert_held(&event_mutex);
> @@ -497,6 +527,8 @@ static int user_event_enabler_write(struct user_event_mm *mm,
>  		     test_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler))))
>  		return -EBUSY;
>  
> +	align_addr_bit(&uaddr, &bit, ENABLE_BITOPS(enabler));
> +
>  	ret = pin_user_pages_remote(mm->mm, uaddr, 1, FOLL_WRITE | FOLL_NOFAULT,
>  				    &page, NULL);
>  
> @@ -515,9 +547,9 @@ static int user_event_enabler_write(struct user_event_mm *mm,
>  
>  	/* Update bit atomically, user tracers must be atomic as well */
>  	if (enabler->event && enabler->event->status)
> -		set_bit(ENABLE_BIT(enabler), ptr);
> +		set_bit(bit, ptr);
>  	else
> -		clear_bit(ENABLE_BIT(enabler), ptr);
> +		clear_bit(bit, ptr);
>  
>  	kunmap_local(kaddr);
>  	unpin_user_pages_dirty_lock(&page, 1, true);
> @@ -849,6 +881,12 @@ static struct user_event_enabler
>  	enabler->event = user;
>  	enabler->addr = uaddr;
>  	enabler->values = reg->enable_bit;
> +
> +#if BITS_PER_LONG >= 64
> +	if (reg->enable_size == 4)
> +		set_bit(ENABLE_VAL_32_ON_64_BIT, ENABLE_BITOPS(enabler));
> +#endif
> +
>  retry:
>  	/* Prevents state changes from racing with new enablers */
>  	mutex_lock(&event_mutex);
> @@ -2377,7 +2415,8 @@ static long user_unreg_get(struct user_unreg __user *ureg,
>  }
>  
>  static int user_event_mm_clear_bit(struct user_event_mm *user_mm,
> -				   unsigned long uaddr, unsigned char bit)
> +				   unsigned long uaddr, unsigned char bit,
> +				   unsigned long flags)
>  {
>  	struct user_event_enabler enabler;
>  	int result;
> @@ -2385,7 +2424,7 @@ static int user_event_mm_clear_bit(struct user_event_mm *user_mm,
>  
>  	memset(&enabler, 0, sizeof(enabler));
>  	enabler.addr = uaddr;
> -	enabler.values = bit;
> +	enabler.values = bit | flags;
>  retry:
>  	/* Prevents state changes from racing with new enablers */
>  	mutex_lock(&event_mutex);
> @@ -2415,6 +2454,7 @@ static long user_events_ioctl_unreg(unsigned long uarg)
>  	struct user_event_mm *mm = current->user_event_mm;
>  	struct user_event_enabler *enabler, *next;
>  	struct user_unreg reg;
> +	unsigned long flags;
>  	long ret;
>  
>  	ret = user_unreg_get(ureg, &reg);
> @@ -2425,6 +2465,7 @@ static long user_events_ioctl_unreg(unsigned long uarg)
>  	if (!mm)
>  		return -ENOENT;
>  
> +	flags = 0;
>  	ret = -ENOENT;
>  
>  	/*
> @@ -2441,6 +2482,9 @@ static long user_events_ioctl_unreg(unsigned long uarg)
>  		    ENABLE_BIT(enabler) == reg.disable_bit) {
>  			set_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler));
>  
> +			/* We must keep compat flags for the clear */
> +			flags |= enabler->values & ENABLE_VAL_COMPAT_MASK;
> +
>  			if (!test_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler)))
>  				user_event_enabler_destroy(enabler, true);
>  
> @@ -2454,7 +2498,7 @@ static long user_events_ioctl_unreg(unsigned long uarg)
>  	/* Ensure bit is now cleared for user, regardless of event status */
>  	if (!ret)
>  		ret = user_event_mm_clear_bit(mm, reg.disable_addr,
> -					      reg.disable_bit);
> +					      reg.disable_bit, flags);
>  
>  	return ret;
>  }

