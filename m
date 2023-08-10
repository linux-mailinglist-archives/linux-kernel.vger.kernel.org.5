Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AC6777B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbjHJOn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbjHJOn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:43:57 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C40226A0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:43:57 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7D6AB40E01A1;
        Thu, 10 Aug 2023 14:43:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aLHMl40-ushH; Thu, 10 Aug 2023 14:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691678633; bh=ArANne49dbxlITExbmt0RFdovHJvV5KiGYWWtf+AXvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HJ84YJBdNJOsIe+5ijOAb2er/oeG0LLswEeXg7BiXbyBFGIU3dYNzjJJVVNd6qmy8
         aKfpj44MXC79QZogRJod9zDQQeH3QYWcp2WEqnMNI19kQrYE3Bn8zZ9u1i4/6Yjxvu
         zW3Vt/KFKe+uZ9oqJmkLU2KfQh7RvCsX4rop99vc4zJeELFm9LBy4UrpKN7OA8nHWU
         F6B+Ep45EowlGuGeba4JQnDwJbdpdKaMfosJymfQOGfvJj2C4SFa3VsFhXhaubS488
         HbZ5alq7EQ4+b03+xR9RZXmXG1ERz8h+SQSOCkci6gHM+NhvlAC5vbjkHopElCcA/F
         kYftPd48jrFc096fOOuIJyGHAVY0lHB6JocE7tCK2AvqMYgTh/XKnUfs25yaX7CBXK
         hzCnY9zLJkHxnSS7bnO/Umq93+0Y+ZquKWYo7QHTwIixPK0CRrpageMTOZmN/hph50
         cSQGLoU7KEAf51oFWi6m41gDA5r9m4YevG56ZC6zJ7NofVRGpRw0KiaTNaxEFIIYxN
         ClK6hiTiwiKTkj7b766OJERD/tu1ckw/mA3FZK4YfiVQhB2Vu6pqguGCqmFRoVQ6At
         +iMc7E9gQLyEqEtaNHuXrz2Ce+I8tAd78vrMBmfx9AN5OL7SryIJke9vaMh7l7umV2
         Rr81vziKIOSCsrIEyhtrU/7w=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1C0F040E0140;
        Thu, 10 Aug 2023 14:43:49 +0000 (UTC)
Date:   Thu, 10 Aug 2023 16:43:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: Hang when booting guest kernels compiled with clang after SRSO
 mitigations
Message-ID: <20230810144344.GLZNT3oM6MLVdzGlyd@fat_crate.local>
References: <20230810013334.GA5354@dev-arch.thelio-3990X>
 <20230810081038.GAZNSbftb6DOgg/U7e@fat_crate.local>
 <20230810090835.GBZNSpE6tCw+Ci+9yh@fat_crate.local>
 <20230810101649.GA1795474@dev-arch.thelio-3990X>
 <20230810125122.GIZNTdSuFvA3Cjfexq@fat_crate.local>
 <20230810132706.GA3805855@dev-arch.thelio-3990X>
 <20230810133216.GKZNTm4KpohRR4gVsT@fat_crate.local>
 <20230810134056.GA130730@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230810134056.GA130730@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 06:40:56AM -0700, Nathan Chancellor wrote:
>   6.5.0-rc5-00039-g138bcddb86d8 (nathan@dev-arch.thelio-3990X) (x86_64-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.41) #1 SMP PREEMPT_DYNAMIC Wed Aug  9 17:34:43 MST 2023

Mine:

Linux version 6.5.0-rc5+ (root@vh) (gcc (Debian 10.2.1-3) 10.2.1 20201224, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Thu Aug 10 16:13:54 CEST 2023

...

[    0.083541] Speculative Return Stack Overflow: Mitigation: safe RET

> Guest kernel string:
> 
>   6.5.0-rc5 (nathan@dev-arch.thelio-3990X) (ClangBuiltLinux clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6), GNU ld (GNU Binutils) 2.41.50.20230809) #1 SMP PREEMPT_DYNAMIC Wed Aug  9 16:54:33 MST 2023
> 

Mine:

[    0.000000] Linux version 6.5.0-rc5 (root@vh) (Debian clang version 14.0.6, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Thu Aug 10 13:22:30 CEST 2023

Guest and host are up and running.

There's something else missing.

Your host gcc is 13, maybe I should update...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
