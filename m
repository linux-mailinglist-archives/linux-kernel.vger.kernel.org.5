Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FD67ABA52
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 22:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjIVUAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 16:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIVUAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 16:00:53 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8867C19B;
        Fri, 22 Sep 2023 13:00:47 -0700 (PDT)
Received: from DESKTOP-4OLSCEK. (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id CB69F212C5CD;
        Fri, 22 Sep 2023 13:00:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB69F212C5CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1695412846;
        bh=pa2lqK8tLRFSFgOMzplmgHoF6LUPfwgF2UX/Kyn0MmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RaykwJUMG3etwttwdEEJpDTgXvbyop+iEVPs7w6rEMn6QcB6o9n2C0uFeU7OjAcSa
         7BW2/CCVIeFhoYAahg+P5h9mZGPGfauaMJe/mZnIct0MTWMge9cB743lnAA0Pphv9y
         wc6ML3YUYP+oBYL1K/58sUZz9UPXAilh1Jvw3/ng=
Date:   Fri, 22 Sep 2023 13:00:42 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/user_events: align uaddr on unsigned long
 alignment
Message-ID: <20230922200042.GA1981-beaub@linux.microsoft.com>
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

Actually, I take back some of what I said [1]. If a 32-bit on a 64-bit
kernel comes in on BE, and is aligned, we do need to offset the bits as
well (just verified on my ppc64 BE VM).

You should be able to use that patch as a base though and add a flag to
struct user_event_enabler when this case occurs. Then in the
align_addr_bit() adjust the bits as well upon aligned cases.

Thanks,
-Beau

1. https://lore.kernel.org/linux-trace-kernel/20230922192231.GA1828-beaub@linux.microsoft.com/

> Clément
