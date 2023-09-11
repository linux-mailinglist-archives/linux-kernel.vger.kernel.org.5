Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0884C79AE30
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239865AbjIKVGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbjIKI5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:57:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2311BE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LyggSFNgiy14BwIsDV/0K7QQu/1ltroH4K6t5ZXh5Ko=; b=KynaWtg4Ji1mqWYGq5dur9t/Y+
        E+1k3GfenBxgLToV59RYvKzPzAvJkUEL1pWHhlI/xwgf6Ri0egTBJih9teF65YcC9rgFu2/n3qve/
        6slJk/uLntE79CQfZryu3e0oewX/IFH4q1zToOqquqrivvO3CD6Atk0rD7V4bt1JbAyaAg/DMc+a8
        Ew5iQPhcCoPl4PQx3/ynBhRDx8Baiq3TqdO36SFBAceY6tixLmIulmF8ysuW1muiWLz2utEM049D4
        GxzeqrdK1EDoaDQJPJFN+Z3crp6dfW4vLUFMhiWMAV2slUDPwFMgY6w5z/m/1nm2vLPDONedlsOmg
        Gml0+ZZw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qfcii-004rWA-1F;
        Mon, 11 Sep 2023 08:56:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B134300321; Mon, 11 Sep 2023 10:56:37 +0200 (CEST)
Date:   Mon, 11 Sep 2023 10:56:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel@axis.com
Subject: Re: [PATCH] x86: Fix build of UML with KASAN
Message-ID: <20230911085637.GA9098@noisy.programming.kicks-ass.net>
References: <20230609-uml-kasan-v1-1-5fac8d409d4f@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609-uml-kasan-v1-1-5fac8d409d4f@axis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 01:18:54PM +0200, Vincent Whitchurch wrote:
> Building UML with KASAN fails since commit 69d4c0d32186 ("entry, kasan,
> x86: Disallow overriding mem*() functions") with the following errors:
> 
>  $ tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=y
>  ...
>  ld: mm/kasan/shadow.o: in function `memset':
>  shadow.c:(.text+0x40): multiple definition of `memset';
>  arch/x86/lib/memset_64.o:(.noinstr.text+0x0): first defined here
>  ld: mm/kasan/shadow.o: in function `memmove':
>  shadow.c:(.text+0x90): multiple definition of `memmove';
>  arch/x86/lib/memmove_64.o:(.noinstr.text+0x0): first defined here
>  ld: mm/kasan/shadow.o: in function `memcpy':
>  shadow.c:(.text+0x110): multiple definition of `memcpy';
>  arch/x86/lib/memcpy_64.o:(.noinstr.text+0x0): first defined here
> 
> If I'm reading that commit right, the !GENERIC_ENTRY case is still
> supposed to be allowed to override the mem*() functions, so use weak
> aliases in that case.
> 
> Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  arch/x86/lib/memcpy_64.S  | 4 ++++
>  arch/x86/lib/memmove_64.S | 4 ++++
>  arch/x86/lib/memset_64.S  | 4 ++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
> index 8f95fb267caa7..5dc265b36ef0b 100644
> --- a/arch/x86/lib/memcpy_64.S
> +++ b/arch/x86/lib/memcpy_64.S
> @@ -40,7 +40,11 @@ SYM_TYPED_FUNC_START(__memcpy)
>  SYM_FUNC_END(__memcpy)
>  EXPORT_SYMBOL(__memcpy)
>  
> +#ifdef CONFIG_GENERIC_ENTRY
>  SYM_FUNC_ALIAS(memcpy, __memcpy)
> +#else
> +SYM_FUNC_ALIAS_WEAK(memcpy, __memcpy)
> +#endif
>  EXPORT_SYMBOL(memcpy)
>  
>  SYM_FUNC_START_LOCAL(memcpy_orig)

Urgh... 

Can we use CONFIG_UML here to clarify things? It's a bit of a bother UML
is diverging to much, but oh well.
