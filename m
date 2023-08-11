Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09BA7797CF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbjHKTeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjHKTeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:34:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3940B1FE3;
        Fri, 11 Aug 2023 12:34:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB3966794B;
        Fri, 11 Aug 2023 19:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBFCC433C8;
        Fri, 11 Aug 2023 19:33:59 +0000 (UTC)
Date:   Fri, 11 Aug 2023 15:33:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v3 3/3] list_debug: Introduce CONFIG_DEBUG_LIST_MINIMAL
Message-ID: <20230811153357.3cdfdbeb@gandalf.local.home>
In-Reply-To: <202308101259.D2C4C72F8@keescook>
References: <20230808102049.465864-1-elver@google.com>
        <20230808102049.465864-3-elver@google.com>
        <202308081424.1DC7AA4AE3@keescook>
        <CANpmjNM3rc8ih7wvFc2GLuMDLpWcdA8uWfut-5tOajqtVG952A@mail.gmail.com>
        <ZNNi/4L1mD8XPNix@elver.google.com>
        <20230809113021.63e5ef66@gandalf.local.home>
        <ZNO/pf/pH5jJAZI0@elver.google.com>
        <202308101259.D2C4C72F8@keescook>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 13:11:58 -0700
Kees Cook <keescook@chromium.org> wrote:

> > [...]
> > +		/*
> > +		 * With the hardening version, elide checking if next and prev
> > +		 * are NULL, LIST_POISON1 or LIST_POISON2, since the immediate
> > +		 * dereference of them below would result in a fault.
> > +		 */
> > +		if (likely(prev->next == entry && next->prev == entry))
> > +			return true;  
> 
> I'm not super excited about skipping those checks, since they are
> values that can be reached through kernel list management confusion. If
> an attacker is using a system where the zero-page has been mapped
> and is accessible (i.e. lacking SMAP etc), then attacks could still
> be constructed. However, I do recognize this chain of exploitation
> prerequisites is getting rather long, so probably this is a reasonable
> trade off on modern systems.

A totally hardened machine is one that doesn't run ;-)

Yes, hopefully that when the kernel is configured with HARDENED it will
eliminate steps to a prerequisite attack. I'm sure enabling lockdep would
also help harden the system too. But there is a balance between security
and performance. The more that adding security harms performance, the less
people will use that security.

-- Steve
