Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72495807964
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379515AbjLFUcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjLFUcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:32:08 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CE712F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 12:32:14 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F1EE340E00C7;
        Wed,  6 Dec 2023 20:32:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aHJQXq1KwOzP; Wed,  6 Dec 2023 20:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701894731; bh=UyueyU7MPaTQvDgK5wlvJcgDd3FO2Ojq10R0R2BYr8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JLxAmP3STXVtCqrnOC9GhMnd7+K1s1K++2no+yM9Jlwwx1o5j4/K4Yu2lobULump+
         mdILmapFJi/eMMe5/c9zYytvZzQ+xD56TPahPTzQDfdeqS6kumX7SNOIsnnkVFCJxK
         MG69+oQ3tyfP9ZT6VGYQyvvhmMEJPzbj//76vEv2Ti8piikePT5nuz0nXHzIe4Tr+x
         wZUTbA1EvyKOE4g+UCnM360rtPm9kKL7oN+AICDl39Xlltsx6kl0ZtIVZN4jQnA1r/
         TlVPIDCGFOxBRePgDaQy5rRhTl5npyvwEkV+gQ+U2skSY4FSj7EFXy8u0BpQwhAAkh
         prF3pjXFuyU+P+1Wqq3Xyrc96iwoDBfTZ1j1iAqquC9l7DqyR/wLcildZ98MxGXqhr
         DSGNzVHvG4TVOXo2cEJGYsDzsEHHZcn9umlbJCeTknvvViDBlCNb+qFXz71VtuQYOe
         BwPtPJs05VpBMYv4S6HA6ed2waRRbXtsC7j+XA7PAB2Nu8qyT78rIfyOyz8zKqaGWR
         kx5cLrF3Uij4dKzlm2ArHFRNj6W1JF+H7bcOKlP3wRn3sKdwL0cyYG8d29ivSTxVCC
         8ca9D1s6wOUBhY7v1hRQcQ9OLMQFDSu72L37O80Js5VqrU8EUYFHd6eYkUjPSmhyNu
         hdwiHaeyFYLIB12nuhWN33tQ=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 038C740E00C5;
        Wed,  6 Dec 2023 20:32:03 +0000 (UTC)
Date:   Wed, 6 Dec 2023 21:31:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: Be more verbose, especially about loading
 errors
Message-ID: <20231206203158.GEZXDaPslvxtOS/gze@fat_crate.local>
References: <20231206172844.1756871-1-jannh@google.com>
 <20231206195814.GDZXDSVgtCWspEJx8Q@fat_crate.local>
 <CAG48ez3weAU-Uti0QyBSDNRv8xYqCJ5UbgJvssEWAWpvyon0DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez3weAU-Uti0QyBSDNRv8xYqCJ5UbgJvssEWAWpvyon0DA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 09:23:48PM +0100, Jann Horn wrote:
> Well, yes, except that if no microcode blob is loaded, you're not
> gonna have the errata fixes and/or security mitigations that you might
> expect to have.

We say that too:

microcode: Current revision: 0x000000f0
microcode: Updated early from: 0x000000be

That second line would be missing.

And updated microcode != microcode version for all the mitigations is
even available.

Therefore, the mitigation fixes all report that too. Look for
"[Mm]icrocode" in the mitigation strings in arch/x86/kernel/cpu/bugs.c.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
