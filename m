Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC637BF598
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442792AbjJJIU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442776AbjJJIUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:20:33 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8641DD6C;
        Tue, 10 Oct 2023 01:20:05 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 08C6C40E01AE;
        Tue, 10 Oct 2023 08:20:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Rlcgad57B5RT; Tue, 10 Oct 2023 08:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696925995; bh=E9CMcde7JhHmBwITrfwM1TdYK1kSavxuW5gL57dtmNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YO31Bh3hiUYXieWDsQmicGvc7EezBWsDoF2wNwa9LwQ4AmMkUhkQrwJUPVkV0SM76
         z/ij/VKF3VaJB8Klvx23jyXwNE0zPSR/+DT5Cz40pg9Dlx2bUKN5OeLJKMHQDGY87g
         s9LAhd7E8RXdxpSVYTrPiASh73s8nCG37mzj26UUmFhQzJZGtrc++9aEzzYEjbIkVw
         9DnrbBwK8T7e0SaTmsWAo1NYc2mrKN5PIkAPC061aFKeaiP45BwOqLxBi7VTaGActF
         UIruJsMjeckwsc9wkhymlrfSLh3eVaTNczfEfpjwJRfzNzHqz1dEVHlW6EJnMmVQRo
         /lGlVWFVGM+17KFA1GHHGwtfgo9WZib0Hs/oZ0BR2icCvQbrVAE6PhEoOdguPUvhsR
         O5nl5Xv78BtpZ0dMA16XVTNeaAqTt+jZJUhG2voVsVSIF3j/ddxsONZoFy4XQOBi4a
         aiSjuTkok718T6KM9HvwMEh+plK+EO8vfjCT30dAT90VdBpm5+8TTDr4ibalSdZoWr
         euUxcQKeYhAepXGhTGg1Y2mlb7wMTCNFS3m11Gb1jjGYsRbrPdJun0QW/xfR/s0Imn
         fXXgFUlAEGLPAVk4rISIrH/iFlbETdE9qqtv0FxxEKTnUzW6aSYuHcWakQHZRC8HxX
         c+nmBefGdzh9bO1QiGbDnk0U=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C73140E0187;
        Tue, 10 Oct 2023 08:19:39 +0000 (UTC)
Date:   Tue, 10 Oct 2023 10:19:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Fei Yang <fei.yang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/alternatives: Disable KASAN on text_poke_early() in
 apply_alternatives()
Message-ID: <20231010081938.GBZSUJGlSvEkFIDnES@fat_crate.local>
References: <20231010053716.2481-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231010053716.2481-1-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 08:37:16AM +0300, Kirill A. Shutemov wrote:
> On machines with 5-level paging, cpu_feature_enabled(X86_FEATURE_LA57)
> got patched. It includes KASAN code, where KASAN_SHADOW_START depends on
> __VIRTUAL_MASK_SHIFT, which is defined with the cpu_feature_enabled().

So use boot_cpu_has(X86_FEATURE_LA57).

> It seems that KASAN gets confused when apply_alternatives() patches the

It seems?

> KASAN_SHADOW_START users. A test patch that makes KASAN_SHADOW_START
> static, by replacing __VIRTUAL_MASK_SHIFT with 56, fixes the issue.
> 
> During text_poke_early() in apply_alternatives(), KASAN should be
> disabled. KASAN is already disabled in non-_early() text_poke().
> 
> It is unclear why the issue was not reported earlier. Bisecting does not
> help. Older kernels trigger the issue less frequently, but it still
> occurs. In the absence of any other clear offenders, the initial dynamic
> 5-level paging support is to blame.

This whole thing sounds like it is still not really clear what is
actually happening...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
