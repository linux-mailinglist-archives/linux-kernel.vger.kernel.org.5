Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02287AAF9A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbjIVKhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjIVKhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:37:23 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF7F99;
        Fri, 22 Sep 2023 03:37:16 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7A48C40E01A1;
        Fri, 22 Sep 2023 10:37:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hhcnoopnkRlS; Fri, 22 Sep 2023 10:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695379029; bh=WpeoT8PnLL6SFV8kCiTwvistzGDQLcoEMqAKzHK7MK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZNms5fH/n47cbkjX3Yfe/XS6JV3yljLikSpZ4rtlK8A455lhRYblRAdTkcsv4lUAi
         Sqk4i6AtD8tsdSunDUkMH7/UuToLcNADjc2RU6rolSRli9SiILcdFAbH05nKJEYZ01
         kVIFE1GHJy8IjePM0jhJi5EWK/APbJd4kTdqwJ7XEb4iDLLbF2tSRT+uzf+aiISwsn
         zM9KVtFpQwPVWEhhluA4ZC1BwU2C8V2+hlCeIhwnM11V+1ljQKlBat+j0BZfx1UsCJ
         NAUn71A+ggJtWpRLOHMtePeHC9MH6q88bDr2tS05XUQwuer+KGdziqK3qfYuYU52dk
         xGr4HFFwJW4gm6nfg6zTHcUAyT9H/jD1useDSyXlneSDA/GFnXSmZRRxIA0wFOyX/c
         QATWPRlr4/nnhle61/o96X2/znL174SLX+33zP1Y7YKM09h8g/LykCgv9RQZTIR9ED
         2aK+DjUh/LJr7S+8AaOABnEz4KM5AWI/3QJRAEqrrukwIIdLp7b84JwmAVHCZbr/hH
         4gTq1zeOemaTKcAY284W/lUmXgYWQVoXoGROaylsKwTnzLKpVm00+ExUdby25xoI8w
         pY+b2iPn99wyrb9szXGE1tDl/kouC6wufaOtRFw057CQCbDVhDVJAusiYUgo4vHGHb
         4IZMh8MCtoTXqOCSdNZLwM+0=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B5B940E014B;
        Fri, 22 Sep 2023 10:37:04 +0000 (UTC)
Date:   Fri, 22 Sep 2023 12:36:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org
Subject: Re: [tip: x86/cpu] x86/cpu: Clear SVM feature if disabled by BIOS
Message-ID: <20230922103659.GCZQ1uS2VOlG82DVAs@fat_crate.local>
References: <20230921114940.957141-1-pbonzini@redhat.com>
 <169537583818.27769.18320521458994415527.tip-bot2@tip-bot2>
 <ZQ1rwSJsO7A4HR8O@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZQ1rwSJsO7A4HR8O@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 12:26:09PM +0200, Ingo Molnar wrote:
> It's a bit sad that we are duplicating identical code.
> 
> 2)
> 
> We are doing it in other cases as well: for example nearby_node() is 
> duplicated between arch/x86/kernel/cpu/amd.c and 
> arch/x86/kernel/cpu/hygon.c too.

We could do a unification pass at some point. At the moment is not worth
the effort, IMO, for only a handful of small functions.

> BTW., while look at this code I noticed that the 'Author' copyright
> tag in arch/x86/kernel/cpu/hygon.c seems to be inaccurate:
> 
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Hygon Processor Support for Linux
>   *
>   * Copyright (C) 2018 Chengdu Haiguang IC Design Co., Ltd.
>   *
>   * Author: Pu Wen <puwen@hygon.cn>
>   */     
> 
> ... as for example the nearby_node() was clearly copied & derived from 
> arch/x86/kernel/cpu/amd.c, which does not appear to be accurately reflected 
> in this copyright notice?

Perhaps it should say "copied from amd.c and adjusted" or so. That whole
file has pretty-much copied parts of amd.c AFAICT.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
