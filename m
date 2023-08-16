Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B38977ECAF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 00:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346658AbjHPWAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 18:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346731AbjHPV7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:59:33 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDC5273B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:59:10 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3751740E0196;
        Wed, 16 Aug 2023 21:59:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id a_D12V2y8vn3; Wed, 16 Aug 2023 21:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692223146; bh=GhV8skxV+ZlV8WuCqPSMhGjJ4Q8tYVm2/02sN87iMMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d2Ve5XAnju859+SwuP0qsfxDpQODpOnuS800BWGrBieXZYkRaRdiEVZMrRmOFHky9
         ACB+v2u5jwtJKTAJ6WiWld3wBxYMpwwtOIFC/2kkIgJKCzqGrbDx1GPXZDGcIEtIJ0
         iHG63OTIqlTZCD9Lj/YEuZFvCDTGIEn4hCzzaEkGyW+ktVOpqhF6o5ffSYRAdD7p/t
         YyX17xxuUhXBedM/K1O9OfkEPrxEb6HH96SmIjsDDO2uUxc0e1b7LF8U9yZHtpXloj
         wUNXT3wj2KP12ZtmHSSW4curdZ6xM52KgVkFGHVfTpIx2fk3iwR2egF2neXYru27wM
         j7wLmWG6XlDAbZJRtze09ftGtR1m8bPpebLIOjLx7ltl4xJdzPp6j/C9oXZ5L8l/S/
         wPzuxNEjR4+A2M5kyfQcf7yaeHnY86iW7u5k65MKtVwcBZoWr8KjmbMJI6r+yH8O+A
         bHp7S8lE/VU++YeYAaOf/wBoHWAHT6aYkwFGxM0EJlKih2Vm9j43EvmFILtR2qcMRH
         iv2EfiWPn9CcJ0qAgC5LsCZvTfzhxK5uZxyJ/E5v6/rbZCUMGT+4G7Ter4sR+5PYAS
         T4VAS+XbNEHoxghBd4GhwV0JmDqc2GwzXwx0RzQyHVR3T9AY8beGVXLx4jSVWvyzTX
         o5XRI/7Eymh7Z9fxMyvRErOM=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9905940E0140;
        Wed, 16 Aug 2023 21:59:01 +0000 (UTC)
Date:   Wed, 16 Aug 2023 23:58:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jim Mattson <jmattson@google.com>
Cc:     dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        stable@kernel.org, x86@kernel.org
Subject: Re: [PATCH 1/2] x86/microcode/AMD: Load late on both threads too
Message-ID: <20230816215854.GWZN1GniMWRL0GnyVh@fat_crate.local>
References: <12a12721-239b-457e-1ff7-f98c02cb7abe@intel.com>
 <20230816201700.589822-1-jmattson@google.com>
 <20230816211821.GUZN09HTGo+yQ2+jd7@fat_crate.local>
 <CALMp9eR1Ub78MZwdZn178d4OXPu3Au=faBgVGe6ty6ARV+nK8g@mail.gmail.com>
 <20230816213025.GVZN0/8cjvLebNANTq@fat_crate.local>
 <CALMp9eRT4xCrK3Up_1bQuBZNd_2ZKLFqgamvP4BtA+HuC1driQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALMp9eRT4xCrK3Up_1bQuBZNd_2ZKLFqgamvP4BtA+HuC1driQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 02:36:57PM -0700, Jim Mattson wrote:
> Doesn't this render that attestation misleading, since the microcode
> patch may not have been loaded on all logical processors?

For that it doesn't matter because the microcode engine is shared
between the two threads. The updated microcode revision is shown on any
of the two threads so you can load on one only. And we did this for
years.

Only recently we started loading on both and we will be doing that from
now on.

What could be problematic is if it simply fails loading on some cores
- regardless of SMT - but that would be problematic not only to SEV-SNP
attestation but to the general system health. tglx has some patches
which verify what has been successfully loaded where so hopefully we'll
be verifying more in that area.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
