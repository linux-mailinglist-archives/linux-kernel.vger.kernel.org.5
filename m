Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5EB79EC1C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241055AbjIMPG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbjIMPG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:06:57 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1621B9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:06:53 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E345840E01A2;
        Wed, 13 Sep 2023 15:06:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qYYmjcbtHk0r; Wed, 13 Sep 2023 15:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1694617609; bh=lw76Xn1SKDONOIBRlL8Ui7kdbzGlQ8LjfZ8Dhdktty4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dzHx2qKkj3zfvN7j8JBr8uEDepb4Z+vP8RNgJl5FNtE+/5BkuicRHi+TjntySCHJb
         wncmzTPUYV+t72jz81MmDapKLTKpRd0YnpkVPua1jbFJPIVk+6tm6E4hSHkeCa/L4P
         fAp7FT8bqJWNpx2HjfklRMJ8ZrEdCbBASvNwKvIHPQB3J58AMi3M2tFl09/tqo3xTW
         U+Tysen/SmAuzspUBVNrOMVgQG+5EOflcudj1MOO0n09ApMIiNTckTrxg26cRFg5MW
         gFFuTKguxXtruO2O2ka8hn+r+YUpgYKN6epfNCVWjU3akRshf8DMYt/vsML/qwaCY+
         02MaGTdAPv15t40yO4yPJMws+rn6RXvp2gyNOXMo4IRilh074Id3TJEWXM69OlkOKY
         /BYAgHx+Tj0DgIcxFNRGFqA8mIxJqtdFvwNU9hUMyvXhhgGXMoGR8GqVfi9+wUod/l
         1NQMGco0GKiafeAid/13ZGibQUZ0cwmoRImslq+Ib0SMoo1TFNd9R+a8/Z8UNwJKVY
         eVj7PalVBv8u4Ubk8LujG67sskIEO7s2Rxn6eM5DTH2zgaw+JEkOY7Ku9VLT+uirmx
         H01AZEKj1dayK9mNkk8Ibhu8yOUJenn/at+ZE4I5/ucrwFXCshZpadIhhnRheNCBcG
         kOPWZl+ruNzdWZDb37mmALkQ=
Received: from nazgul.tnic (unknown [93.123.97.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B12AB40E0198;
        Wed, 13 Sep 2023 15:06:40 +0000 (UTC)
Date:   Wed, 13 Sep 2023 17:06:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>, Peter Anvin <hpa@zytor.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 01/30] x86/microcode/32: Move early loading after
 paging enable
Message-ID: <20230913150649.GEZQHQCVz615l8PoSr@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065500.823314239@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912065500.823314239@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:57:44AM +0200, Thomas Gleixner wrote:
> 32-bit loads microcode before paging is enabled. The commit which
> introduced that has zero justification in the changelog. The cover letter
> has slightly more content, but it does not give any technical justification
> either:
> 
>   "The problem in current microcode loading method is that we load a
>    microcode way, way too late; ideally we should load it before turning
>    paging on.  This may only be practical on 32 bits since we can't get to
>    64-bit mode without paging on, but we should still do it as early as at
>    all possible."
> 
> Handwaving word salad with zero technical content.
>
> Someone claimed in an offlist conversation that this is required for curing
> the ATOM erratum AAE44/AAF40/AAG38/AAH41. That erratum requires an
> microcode update in order to make the usage of PSE safe. But during early
> boot PSE is completely irrelevant and it is evaluated way later.

...

> Cure this and move the microcode loading after the early paging enable and
> remove the gunk in the microcode loader which is required to handle
> physical address mode.

That same someone from the offlist conversation loves this change - 32-bit
PA loading gunk has been a major PITA ever since it got added - just
look at the code you're removing and cringe.

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Peter Anvin <hpa@zytor.com>

I guess those gents could chime in now - lemme put them in To:, perhaps
they'll look at this then.

If not, I'd say we do this. The erratum in question is for pretty much
dying hw anyway - Atom n270 of which I actually have *two* machines
even. I can "accidentally" drop them on the concrete floor while
carrying and problem solved => dying hardware.

:-P

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
