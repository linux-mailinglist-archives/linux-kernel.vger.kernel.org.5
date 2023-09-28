Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DBC7B1B94
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjI1MAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjI1MAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:00:40 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E5F11F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 05:00:39 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5A57E40E0198;
        Thu, 28 Sep 2023 12:00:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id onEhQxuMZo0m; Thu, 28 Sep 2023 12:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695902435; bh=kRWGuBRP82gqOqXgFdSLJU2Up4MncsBtNC6T1GU3HBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VW5gHZwGZFpet8i/IQCsAMRonaCJUKpDAXHUAJA6pwOT8VyfXHHred/9JXX7iat9f
         DOeWt/KPbqfOwdBPwrfWLBAUcbeo7gXnJHcqBLkTtpLilzcjJBKu4Vw2eWniCbhsKc
         ERE8hMeQfI1dRONi0IeI/p+0foO7TIDfTx90YUSil1U5jrloTdOsMQsdnykmcv+g8Q
         AYSRySfqRXTrBRqOM1+l+bpKsvihWFFwfeE5JuI42R6WbgI4pOW4xBl/tEUV9N8U9W
         gvPIbsM3W2Fn6pv3oxtmnniWwV+TZI7kIFZDnsPqJ1aseWZ4K1rVXlPVMxGRIk7Ia4
         bu5ol6ZuZBRSmGXIQwG/BarlzT0U/sLenFpBWy+kNDGN14tgoHGtUm96X9i2Ojt4iD
         Wi8ych34F2yfds0+hMjeKPvQ5s6VEhAY7+yEAKrTJeZ65wgZBHZnF+yhv8echlCfzN
         kyYeRqgd4gzyMUSVtmBo+RqLnmHv/D4o734TXmbTFOEiLRDJRV4UQnExI941Q550lg
         Zo308rLkKurVVNxeRiyPcU9XLGxsd16/nuk7aOYiHa3M+UcVqUFnLuBVRAhb+YYe3A
         0QBFnJf45MlCIvNngs6z7HBf2vHS557SppOiYhouP+TVZDR7Cg521hnQvecLvaVQUN
         huLL9RhrlTL10pLbG61mcSs8=
Received: from nazgul.tnic (unknown [2.247.242.78])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 10D6A40E0176;
        Thu, 28 Sep 2023 12:00:28 +0000 (UTC)
Date:   Thu, 28 Sep 2023 14:00:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 00/30] x86/microcode: Cleanup and late loading
 enhancements
Message-ID: <20230928120023.GBZRVq1wEbpCeeXssJ@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912065249.695681286@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:57:43AM +0200, Thomas Gleixner wrote:
> This is a follow up on:
> 
>   https://lore.kernel.org/lkml/20230812194003.682298127@linutronix.de

Ok, I've gone through them all. I guess you could send the new revision
so that I can start queueing them.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
