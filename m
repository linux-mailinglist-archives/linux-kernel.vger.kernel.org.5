Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE6376F08B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbjHCRYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjHCRYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:24:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E686430C2;
        Thu,  3 Aug 2023 10:24:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83BD261E4A;
        Thu,  3 Aug 2023 17:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2680EC433C8;
        Thu,  3 Aug 2023 17:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1691083487;
        bh=oIo8w6drezvDhvrXgj4j0LpRAgS/qxGC1oMH8Yk1tvw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eMUBImiK3nx9CnEb8dGmTePWdUsS7g5uZigscN46OZefvAG3cHSY2c1TSsAcLKC40
         zPxEuHVQWiL5/mNhVTLbA8ihaNKKMYztp8m3nTQYBzC0NmOSQDQIdWjQg3Y7lhAX8W
         XkhnUZWaEsgnvMagICmJ859HiRc9GHDBYBWe6kXc=
Date:   Thu, 3 Aug 2023 10:24:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v4 1/1] drm/i915: Move abs_diff() to math.h
Message-Id: <20230803102446.8edf94acc77e81ab2e09cee3@linux-foundation.org>
In-Reply-To: <20230803131918.53727-1-andriy.shevchenko@linux.intel.com>
References: <20230803131918.53727-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Aug 2023 16:19:18 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> abs_diff() belongs to math.h. Move it there.
> This will allow others to use it.
> 
> ...
>
> --- a/include/linux/math.h
> +++ b/include/linux/math.h
> @@ -155,6 +155,13 @@ __STRUCT_FRACT(u32)
>  	__builtin_types_compatible_p(typeof(x), unsigned type),		\
>  	({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
>  
> +#define abs_diff(a, b) ({			\
> +	typeof(a) __a = (a);			\
> +	typeof(b) __b = (b);			\
> +	(void)(&__a == &__b);			\
> +	__a > __b ? (__a - __b) : (__b - __a);	\
> +})

Can we document it please?

Also, the open-coded type comparison could be replaced with __typecheck()?

And why the heck isn't __typecheck() in typecheck.h, to be included by
minmax.h.

etcetera.  Sigh.  I'll grab it, but please at least send along some
kerneldoc?


