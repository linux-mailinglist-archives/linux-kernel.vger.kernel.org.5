Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63959751802
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbjGMFWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbjGMFWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:22:40 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AFF127
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 22:22:38 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-66c729f5618so360691b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 22:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689225757; x=1691817757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXkqor9Pj1M925UJ+WZIwXJFUm4FisVGEdFy8WXsojI=;
        b=j8k6Q14byW5JjV/sfjFd4uGLMjuj8iRdgH6g3n6siLv7deQY2HQwHXhjx/QjKK7yfB
         DorLX40CwV+wcqDrMqndTl2/0ptE00PIfVl/pslyzO6lcjmOANqhhBMO5hl+yVZAo62L
         Hqh3mieIp+KzYzu8DAykAl1wyj+466CI0BS64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689225757; x=1691817757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXkqor9Pj1M925UJ+WZIwXJFUm4FisVGEdFy8WXsojI=;
        b=HASoVBsEl9TsjM9t4clqlCXW5CXUfEvXsvIBb7MGJkzxOgTpfJHxgNbtHl4d/NiCzi
         oJnJxJmtHnsHpqtVL+dO6+PDjnm9SRAcDA1Di56hE4E4eegh9lXhklfDND6zPkWMiow6
         Ym0yO2FodQhQoQw+gYh8SaGff5wgGMk9Uf44eh5qnz2zfLmdr7Q2Y0Zlb1Rh/oVqrmbj
         4MgRNbqenIDfZsTvDxoQHwcrp+cS+2lCfc/6WTNUknGwFCglYm3x0Vtt3zqF9AkB6RNr
         aT3g08BG6T+wuKM5cGomqYdqIYL4F+ncl2ULEtdElFlnxubHFd/1dyOmrGuBWfak7mKJ
         DW8A==
X-Gm-Message-State: ABy/qLZqcNNX3qhzoEYengXjg3A2ASG5xmkdyzR5X01VFs/L25TmqlNU
        4DxQU/N5IfCpd/9KQdAys/y2fA==
X-Google-Smtp-Source: APBJJlHplYhOqSZW6ahZfnyEya/TDhnDEgnXh2VWL3LotXdHTEHPrKtPps+qfXQ93yZwO0iIoJkFTA==
X-Received: by 2002:a05:6a20:32aa:b0:12e:32e2:2645 with SMTP id g42-20020a056a2032aa00b0012e32e22645mr432420pzd.15.1689225757577;
        Wed, 12 Jul 2023 22:22:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k22-20020aa792d6000000b00682868714fdsm4626428pfa.95.2023.07.12.22.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 22:22:36 -0700 (PDT)
Date:   Wed, 12 Jul 2023 22:22:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] tracing: Stop FORTIFY_SOURCE complaining about stack
 trace caller
Message-ID: <202307122118.F4DD6200@keescook>
References: <20230712105235.5fc441aa@gandalf.local.home>
 <202307121618.17C50DA9A@keescook>
 <20230712204358.756d0018@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712204358.756d0018@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 08:43:58PM -0400, Steven Rostedt wrote:
> On Wed, 12 Jul 2023 16:36:30 -0700
> Kees Cook <keescook@chromium.org> wrote:
> > [...]
> > +union stack_entry_dynamic {
> > +	struct stack_entry entry;
> > +	struct {
> > +		int size;
> > +		unsigned long caller[] __counted_by(size);
> > +	};
> > +};
> 
> This actually makes it more likely to cause a bug in the future (and the
> present!). Now we need to know that if stack_entry were to ever change, we
> have to change this too. And it can change (although highly unlikely).

Yeah, I should have included a bit more, like:
BUILD_BUG_ON(offsetof(struct stack_entry, caller) == offsetof(struct stack_entry_dynamic, caller))

But anyway, I think we can still do better. :)

> [...]
> Now, this event is unique, as it's the only event that has a dynamic array
> that is not done by the way other dynamic arrays are done. Which is to
> insert a field that has an offset and length to it. That is, other events
> would look like this:
> 
> struct stack_entry {
> 	int		size;
> 	short		offset; length;
> 	[ more fields ]
> 	int		dynamic[];
> }

Yeah, it won't be a "true" trace dynamic array. stack_entry is the
sockaddr of trace. :) (i.e. we want to change the size of the trailing
array without actually changing the struct, but this way leads to
madness.)

> Where offset would be the ((void *)(struct stack_entry *)data) + offset. As
> all the dynamic size portions of an event are at the end of the event, with
> these offset/length tuples to tell user space and the kernel where to look
> in the event binary data for those fields.
> 
> But to keep backward compatibility, as this event had code specific for
> parsing it in libtraceevent that doesn't expect that offset/length tuple,
> and instead just looked at the "caller[8]" portion to see that it had 8
> fields (this is static for all events). New code uses the size to know, and
> ignores the [8]. The event meta data gives the actual size of the stored
> data so the parser knows not to go beyond that.

Right -- so, it would have been much nicer to use a new struct when
caller[8] wasn't enough. :) But that ship has sailed. Now we're in
a state where some tools expect caller[8] and some expect "caller[]
__counted_by(size)". In other places where we've had a "minimum sized
flexible array" requirements, we would've used a union, effectively like:

	int size;
	union {
		some_type legacy_padding[8];
		some_type caller[] __counted_by(size);
	};

Old code ends up with the same sized struct, and new code gets a proper
flexible array with the original struct member name. (And with
__counted_by, we'll have the capacity to do run-time bounds checking on
the flexible array.)

> 
> Note, this event existed before normal trace events that had the dynamic
> arrays, which is why it didn't do the same.
> 
> The only thing this code is doing is filling in the ring buffer. The entry
> structure is just a helper to know where to place the data in the ring
> buffer.
> 
> So my question to you is, what's the purpose of hardening? To prevent
> future bugs, right? By making a shadow struct, we are now burdened to
> remember to modify the shadow stack if we ever modify this current
> structure.

Right, I'd rather avoid a shadow struct -- it's especially weird here
given the special way trace creates its structures. :P The hardening
efforts are mainly holistic protections, in the sense that much of the
kernel isn't doing this kind of careful length management, etc. But that
means we can't abuse fixed-sized arrays anymore -- the compiler needs
to believe what it's told about sizes. ;)

> [...]
> This is why I much rather prefer the simple:
> 
>  	ptr += offsetof(typeof(*entry), caller);
>  	memcpy(ptr, fstack->calls, size);
> 
> Which doesn't need to care about synchronizing with the macro magic of the
> structure, which may change in the future, and this will lead to one more
> location that would need to be updated, but likely forgotten.

I am just thinking this will kick the can down the road. The compiler
may get smart enough to see through this or who know what next.

> C is fun, let's go shopping!

Yup. I'm just trying to take away all the foot-guns. :) Let me try
another way to solve this that is less of a bypass. For now, sure, let's
take the work-around, but I think it'll need to be fixed up soon.

-Kees

-- 
Kees Cook
