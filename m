Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AAC7763B1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjHIPab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjHIPa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0EF1FD4;
        Wed,  9 Aug 2023 08:30:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5FBD639F5;
        Wed,  9 Aug 2023 15:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753E4C433C8;
        Wed,  9 Aug 2023 15:30:23 +0000 (UTC)
Date:   Wed, 9 Aug 2023 11:30:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Marco Elver <elver@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
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
Message-ID: <20230809113021.63e5ef66@gandalf.local.home>
In-Reply-To: <ZNNi/4L1mD8XPNix@elver.google.com>
References: <20230808102049.465864-1-elver@google.com>
        <20230808102049.465864-3-elver@google.com>
        <202308081424.1DC7AA4AE3@keescook>
        <CANpmjNM3rc8ih7wvFc2GLuMDLpWcdA8uWfut-5tOajqtVG952A@mail.gmail.com>
        <ZNNi/4L1mD8XPNix@elver.google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 11:57:19 +0200
Marco Elver <elver@google.com> wrote:

>  static __always_inline bool __list_add_valid(struct list_head *new,
>  					     struct list_head *prev,
>  					     struct list_head *next)
>  {
> -	return __list_add_valid_or_report(new, prev, next);
> +	bool ret = true;
> +
> +	if (IS_ENABLED(CONFIG_HARDEN_LIST)) {
> +		/*
> +		 * With the hardening version, elide checking if next and prev
> +		 * are NULL, since the immediate dereference of them below would
> +		 * result in a fault if NULL.
> +		 *
> +		 * With the reduced set of checks, we can afford to inline the
> +		 * checks, which also gives the compiler a chance to elide some
> +		 * of them completely if they can be proven at compile-time. If
> +		 * one of the pre-conditions does not hold, the slow-path will
> +		 * show a report which pre-condition failed.
> +		 */
> +		if (likely(next->prev == prev && prev->next == next && new != prev && new != next))
> +			return true;
> +		ret = false;
> +	}
> +
> +	ret &= __list_add_valid_or_report(new, prev, next);
> +	return ret;
>  }

I would actually prefer DEBUG_LIST to select HARDEN_LIST and not the other
way around. It logically doesn't make sense that HARDEN_LIST would select
DEBUG_LIST. That is, I could by default want HARDEN_LIST always on, but not
DEBUG_LIST (because who knows, it may add other features I don't want). But
then, I may have stumbled over something and want more info, and enable
DEBUG_LIST (while still having HARDEN_LIST) enabled.

I think you are looking at this from an implementation perspective and not
the normal developer one.

This would mean the above function should get enabled by CONFIG_HARDEN_LIST
(and CONFIG_DEBUG would select CONFIG_HARDEN) and would look more like:

static __always_inline bool __list_add_valid(struct list_head *new,
					     struct list_head *prev,
					     struct list_head *next)
{
	bool ret = true;

	if (!IS_ENABLED(CONFIG_DEBUG_LIST)) {
		/*
		 * With the hardening version, elide checking if next and prev
		 * are NULL, since the immediate dereference of them below would
		 * result in a fault if NULL.
		 *
		 * With the reduced set of checks, we can afford to inline the
		 * checks, which also gives the compiler a chance to elide some
		 * of them completely if they can be proven at compile-time. If
		 * one of the pre-conditions does not hold, the slow-path will
		 * show a report which pre-condition failed.
		 */
		if (likely(next->prev == prev && prev->next == next && new != prev && new != next))
			return true;
		ret = false;
	}

	ret &= __list_add_valid_or_report(new, prev, next);
	return ret;
}

That is, if DEBUG_LIST is enabled, we always call the
__list_add_valid_or_report(), but if only HARDEN_LIST is enabled, then we
do the shortcut.

-- Steve
