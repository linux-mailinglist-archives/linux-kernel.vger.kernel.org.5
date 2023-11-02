Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52B27DF7CD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377040AbjKBQf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347656AbjKBQfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:35:54 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715DD134;
        Thu,  2 Nov 2023 09:35:48 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E71E54B7;
        Thu,  2 Nov 2023 16:35:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E71E54B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1698942948; bh=7waQtWBq6v9SleipOhTZie0WA8WJXzE+cSqQL2QSnDE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MgJT4k+z6aIjsE3/eyAALjy8FigCW5E8U8EzL0R5xNFfeOblm2ZUZVm9FD126S+NL
         /nSoiY0k+X0fN7FBtq9u6T8YEFrhJ9EoDXtilcZ+5mHDVfR0LHKvfOK6gg/qzYb/eJ
         9qx/pLo4aZOLSBs0WcW3ewZBOwxx7W4MrB6UTiDR/7Fd8OOfeQ93d1u/kQX5KoYM9F
         xpe6cEQQyUpc4XCK3bCMVoCmVEI2RhUqKCfZ6DTk++s+bzm7T684NCA+aMj692Audn
         xIbW2xSQ36IQs2/wGV0RF2bdCH6gcViuDYHXXq7wiOXIdTvvVKYTUke01qqzYwdmNG
         jfc8hULbGSzUg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        David Vernet <void@manifault.com>,
        Miguel Ojeda <ojeda@kernel.org>, James Seo <james@equiv.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH RFC RESEND 0/4] Documentation: Web fonts for kernel
 documentation
In-Reply-To: <20231102123225.32768-1-bagasdotme@gmail.com>
References: <20231102123225.32768-1-bagasdotme@gmail.com>
Date:   Thu, 02 Nov 2023 10:35:47 -0600
Message-ID: <874ji48658.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> The problem
> ===========
>
> Currently, the kernel docs uses system-default serif fonts, as in
> Documentation/conf.py:
>
> ```
> ...
> if  html_theme == 'alabaster':
>     html_theme_options = {
>         'description': get_cline_version(),
>         'page_width': '65em',
>         'sidebar_width': '15em',
>         'fixed_sidebar': 'true',
>         'font_size': 'inherit',
>         'font_family': 'serif',
>     }
> ...
> ```
>
> The problem is depending on the serif font selected by system, the docs
> text (especially long passages) can be hard and uncomfortable to read.
> For developers reading the docs on multiple devices, the apparence may
> look inconsistent.
>
> The solution
> ============
>
> Uniform the font choices by leveraging web fonts. Most of people reading
> the kernel docs should already have modern browser that supports this
> feature (e.g. Chrome/Chromium and Firefox). The fonts are downloaded
> automatically when loading the page, but only if the reader don't
> already have ones installed locally. Subsequent docs page loading will
> use the browser cache to retrieve the fonts. If for some reasons the
> fonts fail to load, the browser will fall back to fallback fonts
> commonly seen on other sites.

So my immediate response to this is pretty uniformly negative.

- If you don't like serif, tweaking conf.py is easy enough without
  pushing it on everybody else.

- I'm not thrilled about adding a bunch of binary font data to the
  kernel, and suspect a lot of people would not feel that the bloat is
  worth it.

- The licensing of the fonts is not fully free.

There's so much we can do to improve our documentation and access to it;
messing around with web fonts seems - to me, at least - pretty low on
the list.

I suppose I can ask people at the kernel summit session in a couple
weeks to see if others feel differently.

Thanks,

jon
