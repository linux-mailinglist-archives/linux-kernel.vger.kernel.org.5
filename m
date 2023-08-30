Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E4C78E034
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245425AbjH3TWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242097AbjH3HQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:16:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38131AE;
        Wed, 30 Aug 2023 00:16:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38B7E60C7F;
        Wed, 30 Aug 2023 07:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F01DC433C8;
        Wed, 30 Aug 2023 07:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693379763;
        bh=IVZbMJYXQZ3+ZHPo8VVoVt+cIGLauZ5T+93TRFqZtlE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jpF+7IIVKgUeRqTN9CccH9OL3A4iK7CYbvOCc5WVvbGRx9LC1JqpDFXltqd5nwg1p
         cOvSKVEaVArFbG6/JbwzohTEWey+jxinQ23Zox9sXGrryvOPje4o2mMfibOotawBEK
         wvzOS8ih5bb+0+oXmP1vHSO0lDqyKctnYMAzLtoonbe9pnPjYxui4cUY2WpdYkuPpS
         wwzWqe+Mf03cx/QPXxKYerm4EMmkrtTDCRGKphQfle7XFgiXkg1dIWWJZdM1RW9Tib
         LwceGDr4S+KRObOZ8qZRPAbhRjmyb2XwxaS6t1Yk02K8XC4QC2yFR3pzsWPtbkvArM
         ZxCK6iyIx3KtQ==
Date:   Wed, 30 Aug 2023 16:16:00 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: [PATCH v1 1/1] bitops: Share BYTES_TO_BITS() for everyone
Message-Id: <20230830161600.be8ff8544ee417c0048b716b@kernel.org>
In-Reply-To: <a5574786-0a49-454d-67e3-571983e6a6e8@intel.com>
References: <20230824123728.2761663-1-andriy.shevchenko@linux.intel.com>
        <a5574786-0a49-454d-67e3-571983e6a6e8@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 16:49:07 +0200
Alexander Lobakin <aleksander.lobakin@intel.com> wrote:

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date: Thu, 24 Aug 2023 15:37:28 +0300
> 
> > It may be new callers for the same macro, share it.
> > 
> > Note, it's unknown why it's represented in the current form instead of
> > simple multiplication and commit 1ff511e35ed8 ("tracing/kprobes: Add
> > bitfield type") doesn't explain that neither. Let leave it as is and
> > we may improve it in the future.
> 
> Maybe symmetrical change in tools/ like I did[0] an aeon ago?

Hm, it looks the same. The reason why I used the macro was I didn't
know the BITS_PER_TYPE() at that point. Now it is OK to replace it
with 'bytes * BITS_PER_TYPE(char)'.

Thank you,

> 
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  include/linux/bitops.h     | 2 ++
> >  kernel/trace/trace_probe.c | 3 +--
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> > index 2ba557e067fe..66dc091e0c28 100644
> > --- a/include/linux/bitops.h
> > +++ b/include/linux/bitops.h
> > @@ -21,6 +21,8 @@
> >  #define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
> >  #define BITS_TO_BYTES(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
> >  
> > +#define BYTES_TO_BITS(nb)	((BITS_PER_LONG * (nb)) / sizeof(long))
> > +
> >  extern unsigned int __sw_hweight8(unsigned int w);
> >  extern unsigned int __sw_hweight16(unsigned int w);
> >  extern unsigned int __sw_hweight32(unsigned int w);
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index c68a72707852..da6297d24d61 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -11,6 +11,7 @@
> >   */
> >  #define pr_fmt(fmt)	"trace_probe: " fmt
> >  
> > +#include <linux/bitops.h>
> >  #include <linux/bpf.h>
> >  
> >  #include "trace_probe.h"
> > @@ -830,8 +831,6 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
> >  	return ret;
> >  }
> >  
> > -#define BYTES_TO_BITS(nb)	((BITS_PER_LONG * (nb)) / sizeof(long))
> > -
> >  /* Bitfield type needs to be parsed into a fetch function */
> >  static int __parse_bitfield_probe_arg(const char *bf,
> >  				      const struct fetch_type *t,
> 
> [0]
> https://github.com/alobakin/linux/commit/fd308001fe6d38837fe820427209a6a99e4850a8
> 
> Thanks,
> Olek


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
