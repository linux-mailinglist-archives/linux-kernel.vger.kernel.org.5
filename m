Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3976377E9D8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345854AbjHPTm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345852AbjHPTmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:42:49 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAA8270D;
        Wed, 16 Aug 2023 12:42:48 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E9E6F40E0196;
        Wed, 16 Aug 2023 19:42:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mmH0LmXUSdjZ; Wed, 16 Aug 2023 19:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692214964; bh=qnMCLg1wInvq3YwvBaf+ydFL3JZncUBUVLSHI11P8E8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GRZL5rvZY7X/74CLPbH46RMSO2ixIkI8c6b/f/8ZfDXfz8eHSLmE63ezpssTCecIY
         Miau02EcvlGZqLc8XerAVZTvWybFa7rlsMYsKfyEd7Wb62DPh2lCn4gaOkZvlTGThp
         3x+7HYUvp9wMiSgHSRgD7WoBEcpOXwiAKS+OhpSi7SBxmttpRKbrh0BhWlgWKpMzOV
         00icImGfsjabkSZRPwLWnaQNGuGi/mh6Gq1jwKhNo8PAdqWSlPX7yPruQuBl20tBEo
         AjiKwiRBNkd37v2f+C3LXfuDMzV+ExD8r31vse7Dt0p39IYoQ/lgSqAQ5lKw8iQXt/
         LPv3ABwn0kF4NEDztnPxGhHaI5kBzCCVlo4dgMqE1II2ii2deGqqlpi5YYeoLzh4FO
         AHmtzbM38dLsPUzorl42dJhqJJSQur0PbT7Z6wajUlQ1qzwGTerjyTeslVdOqPczS3
         k82c7G/7h7ZIEbIIbRX/ifXAM4dw3M6KXFWr7E8hS8SmfUeYYm2S5oHmqMb6CKfUWl
         zwc5/gXfmRDl6osLyFFnFzWTbdVGzlqT/YKtGHhJiYoinwoB/dF7j0Rgwjljbw9srU
         MsywyR+//ZGFuuSPwHvvAyUmXWWau2HvIEa2cv4TVNnKK+ITds2Lva9uz1r42FgHCm
         WyomGNW0lzQKFo/rE3ZGuepI=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 70FFC40E00F4;
        Wed, 16 Aug 2023 19:42:39 +0000 (UTC)
Date:   Wed, 16 Aug 2023 21:42:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-tip-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/cpu: Clean up SRSO return thunk mess
Message-ID: <20230816194238.GRZN0mrvQ5Xg3qgsuY@fat_crate.local>
References: <20230814121148.842775684@infradead.org>
 <169217251663.27769.14430226618442726061.tip-bot2@tip-bot2>
 <20230816185839.GA3843691@dev-arch.thelio-3990X>
 <20230816192413.GPZN0iXRRpOGKVMm47@fat_crate.local>
 <20230816193011.GA855169@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816193011.GA855169@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 12:30:11PM -0700, Nathan Chancellor wrote:
> Heh, fixups are always hard to get right across multiple patches, been
> there, done that...

Oh yeah.

> Just ARCH=i386 allmodconfig. CONFIG_CPU_SRSO depends on X86_64 so I
> guess that is how it got triggered. I did not build between every patch,
> just this one (since it should fix the runtime warning folks have been
> noticing) and the final one (as I reported earlier).

I see.

> No problem, hopefully most of the hard work around SRSO is behind us :)

Yeah, I'm pretty sure Murphy will visit us. He always does.

But we'll see. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
