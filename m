Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0317AB9F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjIVTWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjIVTWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:22:42 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 382F9A3;
        Fri, 22 Sep 2023 12:22:36 -0700 (PDT)
Received: from DESKTOP-4OLSCEK. (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id A5489212C5CE;
        Fri, 22 Sep 2023 12:22:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A5489212C5CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1695410555;
        bh=o0eOhrQ2qy/nejECaGDjff9cSGUav4nkz0bEC/QwN/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bYsShCofRHECCOLxVQ4NAkSR32P54vF1Lbs3/cYhfluj2GvZsrh6UWEw/XSZDTsE/
         x7jfUpAvWXxxA8xo5rAnKoDsjgINWd9p9572g8ytzNjmRVlXHSyfDJtUG8aO1hkHj8
         T8+TLif1OhkK8zolRoR1XraRvI6T5sHU9SBrb4s8=
Date:   Fri, 22 Sep 2023 12:22:31 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/user_events: align uaddr on unsigned long
 alignment
Message-ID: <20230922192231.GA1828-beaub@linux.microsoft.com>
References: <20230914131102.179100-1-cleger@rivosinc.com>
 <20230914131700.0ba3ee80@gandalf.local.home>
 <20230914132956.569dad45@gandalf.local.home>
 <a736f219-9a38-4f95-a874-93e1561906d5@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a736f219-9a38-4f95-a874-93e1561906d5@rivosinc.com>
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 02:59:12PM +0200, Clément Léger wrote:
> 
> 
> On 14/09/2023 19:29, Steven Rostedt wrote:
> > On Thu, 14 Sep 2023 13:17:00 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> >> Now lets look at big endian layout:
> >>
> >>  uaddr = 0xbeef0004
> >>  enabler = 1;
> >>
> >>  memory at 0xbeef0000:  00 00 00 00 00 00 00 02
> >>                                     ^
> >>                                     addr: 0xbeef0004
> >>
> >> 				(enabler is set )
> >>
> >> 	bitoffset = uaddr & (sizeof(unsigned long) - 1); bitoffset = 4
> >> 	bit_offset *= 8;				 bitoffset = 32
> >> 	uaddr &= ~(sizeof(unsigned long) - 1);		 uaddr = 0xbeef0000
> >>
> >> 	ptr = kaddr + (uaddr & ~PAGE_MASK);
> >>
> >> 	clear_bit(1 + 32, ptr);
> >>
> >>  memory at 0xbeef0000:  00 00 00 00 00 00 00 02
> >>                                   ^
> >> 				bit 33 of 0xbeef0000
> >>
> >> I don't think that's what you expected!
> > 
> > I believe the above can be fixed with:
> > 
> > 	bit_offset = uaddr & (sizeof(unsigned long) - 1);
> > 	if (bit_offset) {
> > #ifdef CONFIG_CPU_BIG_ENDIAN
> > 		bit_offest = 0;
> > #else
> > 		bit_offset *= BITS_PER_BYTE;
> > #endif
> > 		uaddr &= ~(sizeof(unsigned long) - 1);
> > 	}
> > 
> > -- Steve
> 
> 
> Actually, after looking more in depth at that, it seems like there are
> actually 2 problems that can happen.
> 
> First one is atomic access misalignment due to enable_size == 4 and
> uaddr not being aligned on a (long) boundary on 64 bits architecture.
> This can generate misaligned exceptions on various architectures. This
> can be fixed in a more general way according to Masami snippet.
> 
> Second one that I can see is on 64 bits, big endian architectures with
> enable_size == 4. In that case, the bit provided by the userspace won't
> be correctly set since this code kind of assume that the atomic are done
> on 32bits value. Since the kernel assume long sized atomic operation, on
> big endian 64 bits architecture, the updated bit will actually be in the
> next 32 bits word.
> 
> Can someone confirm my understanding ?
> 

I have a ppc 64bit BE VM I've been validating this on. If we do the
shifting within user_events (vs a generic set_bit_aligned approach)
64bit BE does not need additional bit manipulation. However, if we were
to blindly pass the address and bit as is to set_bit_aligned() it
assumes the bit number is for a long, not a 32 bit word. So for that
approach we would need to offset the bit in the unaligned case.

Here's a patch I have that I've validated on ppc64 BE, aarch64 LE, and
x86_64 LE. I personally feel more comfortable with this approach than
the generic set_bit_aligned() one.

Thanks,
-Beau

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index e3f2b8d72e01..ae854374d0b7 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -162,6 +162,23 @@ struct user_event_validator {
 	int			flags;
 };
 
+static inline void align_addr_bit(unsigned long *addr, int *bit)
+{
+	if (IS_ALIGNED(*addr, sizeof(long)))
+		return;
+
+	*addr = ALIGN_DOWN(*addr, sizeof(long));
+
+	/*
+	 * We only support 32 and 64 bit values. The only time we need
+	 * to align is a 32 bit value on a 64 bit kernel, which on LE
+	 * is always 32 bits, and on BE requires no change.
+	 */
+#ifdef __LITTLE_ENDIAN
+	*bit += 32;
+#endif
+}
+
 typedef void (*user_event_func_t) (struct user_event *user, struct iov_iter *i,
 				   void *tpdata, bool *faulted);
 
@@ -481,6 +498,7 @@ static int user_event_enabler_write(struct user_event_mm *mm,
 	unsigned long *ptr;
 	struct page *page;
 	void *kaddr;
+	int bit = ENABLE_BIT(enabler);
 	int ret;
 
 	lockdep_assert_held(&event_mutex);
@@ -496,6 +514,8 @@ static int user_event_enabler_write(struct user_event_mm *mm,
 		     test_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler))))
 		return -EBUSY;
 
+	align_addr_bit(&uaddr, &bit);
+
 	ret = pin_user_pages_remote(mm->mm, uaddr, 1, FOLL_WRITE | FOLL_NOFAULT,
 				    &page, NULL);
 
@@ -514,9 +534,9 @@ static int user_event_enabler_write(struct user_event_mm *mm,
 
 	/* Update bit atomically, user tracers must be atomic as well */
 	if (enabler->event && enabler->event->status)
-		set_bit(ENABLE_BIT(enabler), ptr);
+		set_bit(bit, ptr);
 	else
-		clear_bit(ENABLE_BIT(enabler), ptr);
+		clear_bit(bit, ptr);
 
 	kunmap_local(kaddr);
 	unpin_user_pages_dirty_lock(&page, 1, true);
