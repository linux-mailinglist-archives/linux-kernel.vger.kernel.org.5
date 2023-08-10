Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBF6777411
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbjHJJQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjHJJPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:15:34 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659092D51
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:15:34 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ACD2240E01A3;
        Thu, 10 Aug 2023 09:15:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NrSqTNoI79cw; Thu, 10 Aug 2023 09:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691658930; bh=LM+G2WXY8aKY4yJnSkZJ2W6l9N8Kh9eaLkrFwmoW/DU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a21f34DQaoMhPz6+5FAClOLyjfhs/gx4tWn14fH4x99VrNtmg4lx+IpRFVZ45tvR0
         Er5hYbDlntJAAHIdAB2hxIwQe/9mocIsnhhtmvuxh9smIkcorWblzP0gI+UfBqKlXW
         /QgQM/Fj0n6i94iDN0e19EeitaNK7iScietDCl/tpAkUsBGzI4UsiCoJKSHnd51IOF
         Qjo/ap4iG0iW2h/1LtpZSsi1pCkqkgJNdXYeRdryD1ZtBpRFOETShXUjY2DdyysM5R
         /i1dmwG7ZrCi7+79HoAkrKyXcS9fCaLJoprZVA789u2QpeRTCknJKyCiNJkDYEegBo
         dZLGlAx0yfaQCJEekh/gP638TdKwkZZsAfXkTsRdeyNGdtCtAiT7dRg5bPt4ivpaCn
         53UG4LjGkTleZaAVB208h+gEFXLbnY8VicT90S9ZjukvMzN7+XgZA6/TGQZEn3SKoG
         HA8ef0eN8nxAvv5PmORDI0WtzT2j5HRhTP1usZ9cwvqJ6vr5Ye4E8GM4dL+dAPHOr7
         M9llIBrBY2G48hBzSPWs/YFt5VIHT/WCSrGwb2eCNin6noT1FqeAaUX3E00FhPy6h2
         ZsHv3x0NQCdqkD/SBRZdwXpfV3S8VHR/0d9keOwmakAR+Ntmsea/21bjObCD3nqEXm
         iME5eRQWEx7MFgJSk6F+Sk+k=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C43940E01A0;
        Thu, 10 Aug 2023 09:15:26 +0000 (UTC)
Date:   Thu, 10 Aug 2023 11:15:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: Hang when booting guest kernels compiled with clang after SRSO
 mitigations
Message-ID: <20230810091525.GCZNSqrRVmKC0xJ3JL@fat_crate.local>
References: <20230810013334.GA5354@dev-arch.thelio-3990X>
 <20230810081038.GAZNSbftb6DOgg/U7e@fat_crate.local>
 <20230810090835.GBZNSpE6tCw+Ci+9yh@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230810090835.GBZNSpE6tCw+Ci+9yh@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:08:35AM +0200, Borislav Petkov wrote:
> On Thu, Aug 10, 2023 at 10:10:38AM +0200, Borislav Petkov wrote:
> > I can repro this here with Debian clang version 14.0.6-2 even with -smp
> > 2.
> > 
> > Lemme poke at this a bit.
> 
> Err, this stops booting even on plain -rc5 which doesn't have the SRSO
> patches.
> 
> If so, then you'd need to bisect.

-rc4 doesn't boot either here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
