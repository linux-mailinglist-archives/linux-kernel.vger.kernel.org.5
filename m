Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DB77CD8C2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjJRKAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjJRKAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:00:39 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E27A109
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:00:37 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B105D40E0196;
        Wed, 18 Oct 2023 10:00:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id k4JyC3DMyeue; Wed, 18 Oct 2023 10:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697623233; bh=UWu64KdaBnReM2G1t6rB9kmANqjin4/4AXYGHUxgQpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RAC9BnFaxdaWSYwy9jsGcLFZrbYfyIsY/d2qRREb1IWQqD7BC3MCdn47UMTMAQmiP
         1kSxaH4ClTLUOR0BJioN1Bpw1Vb7mqfhUE8msQ+fE/yz7+ZaC3mJhR+4G/uNDnf0jL
         V5Rta+gGmBOsNROLMtahVKnaec5VGBj9Pk8emJlMvtgVFRNu6+lx07/GCaCBfzY/fi
         m8ELeydF/4owoRR6u1kNW+YnLNqhxsWA8swE1HRkh84ZiUvHi1JOZoRIEIgWaTImGN
         BHjbFx28mr1yCABKbZMyDa0LiobrGZa9w2eAVeCcT4rondVNRT1jHNW3HRP/OcZo/R
         cxVZrRkDml2otYPnsG5Hyah9EpKMhjl3q5CuyAGtPv8khpBea8wYKWdolllWtnqc92
         Ckqi3f4TqijgYhsZ0asZNvkw2YDX0hjRRSizxK86Qk+0Rjyim7QKV9HwQ9PfMITn3g
         NGYtXP4Ue3JCd0SADYTbQa9z6nDK+7F9KwWhsinMtUVoHr8jspB85d4V+Ffg7bXpOc
         L3EhFVhz6r4mW0MbVR861X3RFkEmMaZRSPuPNdWkTe4oKfeJUOWO4+gXdrcyoGnYFD
         a33E/U29ylzECuhEwBnTH94bB74T0QpLGWwpklyBaZM0JSZKm+r+7vVHrCa0eSuaQa
         Pnz698exjFTwX7T98wQLTjmg=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 106FB40E0193;
        Wed, 18 Oct 2023 10:00:30 +0000 (UTC)
Date:   Wed, 18 Oct 2023 12:00:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: [patch V5 03/39] x86/boot/32: De-uglify the 2/3 level paging
 difference in mk_early_pgtbl_32()
Message-ID: <20231018100023.GAZS+st5ePdAQjnO4z@fat_crate.local>
References: <20231017200758.877560658@linutronix.de>
 <20231017211722.111059491@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231017211722.111059491@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 11:23:26PM +0200, Thomas Gleixner wrote:
> Move the ifdeffery out of the function and use proper typedefs to make it
> work for both 2 and 3 level paging.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V5: New patch
> ---
>  arch/x86/kernel/head32.c |   38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 
> --- a/arch/x86/kernel/head32.c
> +++ b/arch/x86/kernel/head32.c
> @@ -71,39 +71,43 @@ asmlinkage __visible void __init __noret
>   */
>  void __init mk_early_pgtbl_32(void);

Lemme zap that forward declaration too - it looks redundant.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
