Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFABC8014B6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjLAUl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAUly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:41:54 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB662FF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:42:00 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0DC8D40E025A;
        Fri,  1 Dec 2023 20:41:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dtF9r-Yr94qi; Fri,  1 Dec 2023 20:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701463316; bh=Byd7KdvcncbN7gGuEC25NvwTc2Eqb0K83JwmPnTaOeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M+yL/PueUuR2N7pMxdTKChMM0zp47nG29XS7CLUxj0TlhLKWDIiGiOgUrJ6PIT+JT
         ka/FN4hnyHw6OXt+rVs43Lj9V0nYyVGXDL8hlYMjJFdThUlwDEj+U49XI2FvZYNjdU
         utzck5W/i0BIlBn2rLWdG6uZWZ8uR8w/0c6oD+6h94AdJEM+fQ3wSxwaNZ7/yn3exA
         /tVT3X8Y2yKZ2DCghO0vPpAFpysYVxyEXiYwl6U9aSFfOeULuYcUFX5z5ovjSe7cbt
         GFKk4JQMsODTv+pJwX1MifQbNXPhNhxB3xjcN+dpLfZvXKczqO9/S4qbpYEvaNbJtu
         bBLfzFqBAsWQ1rV0RCly17e3js1knA5k5RuyCttjhdasCtExDPIEhu5ZdTR11F0dOb
         TGwYkP2zK+NfHCsr3/S1yCM1/Fy9yy7saUoPU9QYsGO8s6PXA/u7m1uJL1dBvCcjHB
         5aO0linwtiTfADE/e/w548MnM/bsbnyqj3sith921E2Y0wmGTN12KFzqHkDPT4Toxq
         OwU8pVVJBYoDSdctVadegDY3O3hvLGNMB6wYPPm/rJF4Sr/rNIrXFFQvqMeG0GB67x
         BcBTvGMcsShugoYOfnhowBETD0aMm2ppRqNDqdU/OBas7o/a62/SKdUDuHJa94hTbY
         G4PwJv7jAnlJJJRVlOQLn1eE=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 141CE40E0239;
        Fri,  1 Dec 2023 20:41:52 +0000 (UTC)
Date:   Fri, 1 Dec 2023 21:41:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] x86/microcode: Rework early revisions reporting
Message-ID: <20231201204146.GGZWpFCqodLUPS27tJ@fat_crate.local>
References: <20231115210212.9981-1-bp@alien8.de>
 <20231115210212.9981-3-bp@alien8.de>
 <ZWjVt5dNRjbcvlzR@a4bf019067fa.jf.intel.com>
 <20231201163928.GCZWoMQNAAQSA9U12D@fat_crate.local>
 <ZWpDHgNjhQKLodF6@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWpDHgNjhQKLodF6@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 12:33:34PM -0800, Ashok Raj wrote:
> I'll get a dmesg shortly once i get my test system back.

Thanks.

> What I meant was 

I know what you meant. Did you see the diff I sent you?

It has the fix already:

@@ -410,13 +421,19 @@ void __init load_ucode_intel_bsp(struct early_load_data *ed)
 {
        struct ucode_cpu_info uci;

-       ed->old_rev = intel_get_microcode_revision();
-
        uci.mc = get_microcode_blob(&uci, false);
-       if (uci.mc && apply_microcode_early(&uci) == UCODE_UPDATED)
+       ed->old_rev = uci.cpu_sig.rev;
+
+       uc_dbg("old_rev: 0x%x", ed->old_rev);
+
+       if (uci.mc && apply_microcode_early(&uci) == UCODE_UPDATED) {
                ucode_patch_va = UCODE_BSP_LOADED;
+               ed->new_rev = uci.cpu_sig.rev;
+
+               uc_dbg("updated, new_rev: 0x%x", ed->new_rev);
+       }
^^^^^^^^^^^^^

The assignment is now inside the UCODE_UPDATED conditional.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
