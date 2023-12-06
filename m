Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236AE80790D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442813AbjLFT61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379434AbjLFT6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:58:25 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7DF122
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 11:58:31 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E73F340E00C5;
        Wed,  6 Dec 2023 19:58:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TIdXIvgqTTTI; Wed,  6 Dec 2023 19:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701892707; bh=EeWH7AGmmWL6UxBj78A0h6bJDsIwrO2t+84+U03t9BY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A9g6uihSKPN0VNOvpqB22kwuZrQ+Dl6lrBOe96kGXVfKSWaG/Wwx86opLNQ1uhSyS
         /ZWK/hRlatcbkm/VBy69m34MKGXxboio+Nsnn2eTrjq94olT1PhZqYQqETQ+dg4lYO
         pdWIUw2abtK8yGp3LqCpYgBvmigw58qig42tCVxWuDhPfuFTTP8ant4AvMMoasItoS
         R3UkDKYfRQY5zuREXeiW5zNMwuQf91Q2xTIKpsTDi1JQfskSzxGQV/2SaO0QJFWgt0
         z9arZI39kQbJRdbMay4h649IpVJGKeFo4vNYr7SGsh3E2JqcwXdHQn6g8qrIb9dHc+
         rfeRk7nP8l7agPne9dZROXoaqDwpm6GdCNUfUkX8fA7TtiShhcB2RwY3n8b69ThSg9
         fOsTS1ujD+reRRrTAwaiv5QC9uyyme6ZT95JHoGzMpVhc1lFjpGd11EN3wCvnUpKh8
         K4XETtV+IUol+PQtI79+OOU8YkYAtm+mHHY7J5GKTPT+u9LzeCNRJoZ2eNtGIR314J
         BxUVHXWHhcVIP+FTH+b2FJNEoAsCc5vNaqI1j9NZLaz1abDADboTY37nWIDE8Vq42J
         Y6YrduMC1XzYX1YeBMqG6XMxvJ/cscXpPK7BPbLSjhETBfRoMHSqLeUsetbhBiLNhs
         amnXSa2vlWb1LZceMInSORdM=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DBF5940E00A9;
        Wed,  6 Dec 2023 19:58:19 +0000 (UTC)
Date:   Wed, 6 Dec 2023 20:58:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: Be more verbose, especially about loading
 errors
Message-ID: <20231206195814.GDZXDSVgtCWspEJx8Q@fat_crate.local>
References: <20231206172844.1756871-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231206172844.1756871-1-jannh@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 06:28:44PM +0100, Jann Horn wrote:
> The AMD ucode loader contains several checks for corrupted ucode blobs that
> only log with pr_debug(); make them pr_err(), corrupted ucode blobs are
> bad.
> 
> Also make both microcode loaders a bit more verbose about whether they
> found ucode blobs at all and whether they found ucode for the specific CPU.

So far, so good.

The only thing I'm missing here is the *why*.

There's merit in not complaining about corrupted microcode blobs because
they won't be loaded anyway: no harm, no foul.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
