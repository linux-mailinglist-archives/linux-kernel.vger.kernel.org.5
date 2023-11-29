Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DDD7FDD6D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjK2QlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjK2QlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:41:17 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D4284;
        Wed, 29 Nov 2023 08:41:23 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0FBCF40E014B;
        Wed, 29 Nov 2023 16:41:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id thJhzFysIltR; Wed, 29 Nov 2023 16:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701276079; bh=36Py6F37KaOYd/LEkELg9D/cNoZfYEAHek0ZM2QfIEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ho/FPQWgt1pQU6PAIbYvr3PY0xrbh0aW/vVdG4Pe3XOWSRBOax+ygJXn/C/mYfwAi
         J5tuEaFq+8E8VIMo36JePDFhj/l14HZnzIeGxdFREOlczs0mDquU1bXAw1TG0uclhQ
         gMpNmqTdE0L8Gxk/WeZ9TTc+E9Q5tQ5aTJg0zApjBvX4lKF4HKBqRccYXv2WstvmqB
         nuOIbTjFjgdG2te5KUIJ69p3pTnPhrX+7oFKPKAYfMpEvcNou3b8a2A9j0CQJpKdqO
         c/Lo1RD7zAYDg2si59Nm3sjKdtyvtO+/X7V+xuqqm1xwc4hSLVmTuEiBQKGHNPu9Hm
         IttgZDCk/l+5vLWuYO+ncvLpPQydnMu5aZKJuoNQs3OD4poTlP+5lGB47nSja/vgI5
         a4FRCdoRUzMEMDbmWVBCT4gQvTtCFUFdQbckuiUe5vQoaOTCvvAzb0uHmFJ1MwA4vE
         KiLUAuF6Eo/tmKkf6PiokVpdvIsQMt3gH9kmsPqstwaercWT8JzM8DeTGIBzu3+MOt
         flbAa5rxMd8hwoeHa9e/87ooHllNIxVo719DL7V6EjZG+OnRSLHWMxHNAVIATgiEAD
         lPDhpR5pZy2dmIryiyEGSNYw8FVTb3Gr/HbDDv8LQ9vviXRM4UTT1qsjn0LApStoDb
         fLltdi0ivnpWcjBZFo7sGWsA=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF02940E0031;
        Wed, 29 Nov 2023 16:40:55 +0000 (UTC)
Date:   Wed, 29 Nov 2023 17:40:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, stefan.bader@canonical.com,
        tim.gardner@canonical.com, roxana.nicolescu@canonical.com,
        cascardo@canonical.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, sashal@kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Kelley <mhkelley58@gmail.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Message-ID: <20231129164049.GVZWdpkVlc8nUvl/jx@fat_crate.local>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <0799b692-4b26-4e00-9cec-fdc4c929ea58@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0799b692-4b26-4e00-9cec-fdc4c929ea58@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 06:19:20PM +0100, Jeremi Piotrowski wrote:
> Which approach do you prefer?

I'm trying to figure out from the whole thread, what this guest is.

* A HyperV second-level guest

* of type TDX

* Needs to defer cc_mask and page visibility bla...

* needs to disable TDX module calls

* stub out tdx_accept_memory

Anything else?

And my worry is that this is going to become a mess and your patches
already show that it is going in that direction because you need to run
the TDX side but still have *some* things done differently. Which is
needed because this is a different type of guest, even if it is a TDX
one.

Which reminds me, we have amd_cc_platform_vtom() which is a similar type
of thing.

And the TDX side could do something similar and at least *try* to
abstract away all that stuff.

Would it be nice? Of course not!

How can one model a virt zoo of at least a dozen guest types but still
keep code sane... :-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
