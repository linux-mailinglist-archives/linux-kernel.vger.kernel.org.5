Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46F07DCDF2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344590AbjJaNfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344583AbjJaNfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:35:17 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A50DE;
        Tue, 31 Oct 2023 06:35:13 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9A7D540E0199;
        Tue, 31 Oct 2023 13:35:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5K4SqGA76OhW; Tue, 31 Oct 2023 13:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698759309; bh=dxj8fhRzPwH8/JFJjxqLFgA5VsrRSPOlPjjVeAxOH84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TiUmT2IqFvFQsrHFfFebr3RX8IY65pAta2roA7X2QYyP+qMXF1/9KQRYygqUsbLg7
         fr3aDvJyezudutupPghVQiRBEdxG/HmbqB9T9PbtOAJ2N5/ic+v78Wnt8J3NHFxK56
         ucb3W4HPImWYTOkDN2yfAWJR9VKAmcH77cWRstrA9Eh2JMvVUA+YOaMTJkfDygREjB
         YLnw90DJODFmcgQ2Ggm3V97DUi6+U/jvhNnrzFs5LE5qmEMzb0e8u8McbYsN+rAR+R
         eXwxkdWDsFh/1YnyoKYMnMh2lrOtLFCkBQarlGOEzmw9GX5xCpC8+jCm4BHcuYksEe
         OuIz8Bu4ZPmFiarwSC0jfKLBThfhM5rTnZ5XdLQgtQ5op7eLTEujcVoaNk28s29gxX
         9eBp1KMIoXzN/Q0tuinCXqU9W5qkWhVMaTS6hp0ELKttzcPQ3ZGWx2rlt9AbYuYxRw
         LAYKjaBi7DS1nPmf+cbq3c3AxunIAfoq1POu6tk0+1EMB26qY8GPuok61oGJvagB/J
         hGHRomfWYtRPcZwmJEILRiO7eWP8DyWDNcSHdQ8ctxDhaExjaegRnTfRfKA8x9uoT5
         m1er16Q53gWCgwjvdGdiYUjRpicmBnNNpz6XAQ0aj+/mNA/xRFY6MgiYBGvFEpBlDP
         LakxItjMf3+p7jylivDzvfdI=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3840E40E0173;
        Tue, 31 Oct 2023 13:34:53 +0000 (UTC)
Date:   Tue, 31 Oct 2023 14:34:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] x86: Let AS_WRUSS depend on X86_64
Message-ID: <20231031133447.GBZUECd12o2sw7E4Re@fat_crate.local>
References: <20231031102111.32142-1-jirislaby@kernel.org>
 <20231031112558.GAZUDkRrkEStZqDnz4@fat_crate.local>
 <CAK7LNAS+Ej9q7Tw7Op8J27KUeFUEg6VvytWm6SXd1qB-ocUJ8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNAS+Ej9q7Tw7Op8J27KUeFUEg6VvytWm6SXd1qB-ocUJ8A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 09:20:33PM +0900, Masahiro Yamada wrote:
> Please note "depends on X86_64" cannot prevent gcc
> from running here.
> 
> $(as-instr,wrussq %rax$(comma)(%rbx)) is replaced with 'y'
> while parsing the Kconfig files.
>
Then what is this fixing?

Jiri, what openSUSE kernel build issues were you referring to on IRC?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
