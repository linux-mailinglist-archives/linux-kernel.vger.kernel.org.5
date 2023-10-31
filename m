Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B717DCEBA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbjJaOFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbjJaOFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:05:33 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80192F1;
        Tue, 31 Oct 2023 07:05:31 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 51AED40E0199;
        Tue, 31 Oct 2023 14:05:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tuqewIV_ganz; Tue, 31 Oct 2023 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698761126; bh=fFVuYYWadDmi8VgiNlTQK09zIwoB4UQfVZxwG2NDq3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jz4CzFkSYOAkxl8XgnPADK/qaBHrCbwTMd0IoPGCU1ffqiJC1uAIktt5pCgg0jhI8
         1EPvSkU+9omXeNo8lx/4/zFzV8JnHzW4Jmeh6n6ctyMkRnjs90iuhvWbbAOQPNVoTJ
         +P7w5FiZum898gYirXHWulmAqNejusDeJwyCuwlP+LZiNA3rKSFQmLEPyaBrtOJexf
         xxNTAVQ/HLonbhExZ2RaAEJVtCNdd5t8X+xWtDgc5j7HNJKgk+XbhegwVJw3YSMsFP
         oggC1RKVZmocbG7moCR7AjOhW9M1S5eMQ8vnXZT1SaAPcIsaDcZ96mxEiga2ALrC+L
         /0dTDef/g6hSS6UrzxWQZV2VzMzoWne1yf6dik/dOaik/2XQDDcOd7ibtFoO2rY2Nt
         7igkVsJ63ZIgpO6nNW6F0+lNitOvaBqyqGzif+R78xqmA0fyI6JpezIxovpiH7xaDY
         6b/c2F1h5vv6llsqHRnR/7n0KHTU4nqcwpKQcf8lnffTnZjnkgONm7mhg4bvB7ytLx
         yItCrbL8LDWXuZRsSVy+GMk/bhQo/RyQGZkahUPv+Q470l4LGe/0eSBOrQ3Rq2SAU4
         3GoIhFjGEsDiXQBUOa61AbWEgw4nhLEdX97FaR/FeYKG5fa33hd2dQwRLLl+OyEUk6
         M0era9vYfjz3bn6Z0JHcRfOE=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 43F3940E0171;
        Tue, 31 Oct 2023 14:05:10 +0000 (UTC)
Date:   Tue, 31 Oct 2023 15:05:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, peterz@infradead.org,
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
Message-ID: <20231031140504.GCZUEJkMPXSrEDh3MA@fat_crate.local>
References: <20231031102111.32142-1-jirislaby@kernel.org>
 <20231031112558.GAZUDkRrkEStZqDnz4@fat_crate.local>
 <CAK7LNAS+Ej9q7Tw7Op8J27KUeFUEg6VvytWm6SXd1qB-ocUJ8A@mail.gmail.com>
 <20231031133447.GBZUECd12o2sw7E4Re@fat_crate.local>
 <80496187-8392-4c9e-ba05-89edea53e6e0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80496187-8392-4c9e-ba05-89edea53e6e0@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 02:59:39PM +0100, Jiri Slaby wrote:
> As I wrote, we have a config which maintainers feed through oldconfig when
> updating the kernel. This time we got WRUSS=y. It was stored in git and
> later passed to build the kernel. And we received a different config from
> the build (WRUSS=n).
> 
> We diff the two and error out if the built kernel differs from the passed
> configuration. Which is the case here.

I sure hope that diffing script can ignore Kconfig items. Because this
doesn't sound like a reason to "fix" the upstream kernel and as Masahiro
says, it doesn't change anything anyway.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
