Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9794177FB01
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353261AbjHQPlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353263AbjHQPk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:40:59 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B8630C5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:40:58 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BE9D440E0196;
        Thu, 17 Aug 2023 15:40:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sEhWEHyKbp5n; Thu, 17 Aug 2023 15:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692286854; bh=A8uvLGe0iP9tNqu72ndYg/Bk+LCGJ0re4SlE/Twy5XM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EyVzw5iH52Px7pZE71dizt0iqYVRzK3+0lLyhgwUDe8EiX1kNmVx6c35DT2lCO/do
         NJ80zttCelkiHgUT+c/168MMPEvUmE9ZbZVcLmYUZm91LQV4+DgzKWCCgWuRC1t6fI
         0H1XwlEshe/ssc6HiCvvUdBjY4sg9qgmeNkjlD2nxGgyWI0hAs8bG/ih++szfAv0j7
         uxL467qln2gVc4inpod7sqHad8e3sbRByrLwODm1bFxWInIUtvMyoA7LR5LCOarSlV
         jnoqI7tiZHF2unXIJTKfuwO1YFDcNSBep+QsjVm+tBdOPTp5Sh7RwjYCgmVfNy720x
         7FoVkcMunxj+KO762fZf7AeaYUNJS8/eQNGwRnLGbK8LsqpviDShlTpomNearkC4Gj
         iJGWshyGmBxshFjvTr6s6qo7H1WET8WLz+DJZwCX3HlqF2K0d3vrm/I/SP+oPXKGMM
         cuuAm6Lm5ZHQwlaXNopswGwsSuzN3vbMKix7FYedWqXNNkT293LTU5g1jVEiNDFLad
         aoEKafTDM/UMFagltMnQimvrzEvUdz4fPKjoMe+mlz+4WrVuh4zc8m2J81rZl3M4J4
         Uv5DSrRrRwSezl1HHCj4PsfAsWqaucaBICcX4WToQykoBPM/RloDkSXRX2bMvtEr7h
         Q5Nb5t59UDW40PPd4hzk1z20=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D51F40E0140;
        Thu, 17 Aug 2023 15:40:49 +0000 (UTC)
Date:   Thu, 17 Aug 2023 17:40:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jim Mattson <jmattson@google.com>
Cc:     dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        stable@kernel.org, x86@kernel.org
Subject: Re: [PATCH 1/2] x86/microcode/AMD: Load late on both threads too
Message-ID: <20230817154044.GGZN4/fGMRuvFVtPjD@fat_crate.local>
References: <12a12721-239b-457e-1ff7-f98c02cb7abe@intel.com>
 <20230816201700.589822-1-jmattson@google.com>
 <20230816211821.GUZN09HTGo+yQ2+jd7@fat_crate.local>
 <CALMp9eR1Ub78MZwdZn178d4OXPu3Au=faBgVGe6ty6ARV+nK8g@mail.gmail.com>
 <20230816213025.GVZN0/8cjvLebNANTq@fat_crate.local>
 <CALMp9eRT4xCrK3Up_1bQuBZNd_2ZKLFqgamvP4BtA+HuC1driQ@mail.gmail.com>
 <20230816215854.GWZN1GniMWRL0GnyVh@fat_crate.local>
 <CALMp9eSbdLuUr9ZvHOA5=vvvA58S5j+cePNKxbx1RxEprRMLZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALMp9eSbdLuUr9ZvHOA5=vvvA58S5j+cePNKxbx1RxEprRMLZQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 03:37:20PM -0700, Jim Mattson wrote:
> SEV-SNP is supposed to protect the guest from a malicious host. A
> malicious host may not load the microcode update on both threads. As a
> result, it gives me some concern when I see something like this
> (https://lore.kernel.org/lkml/20230808190239.131508-1-john.allen@amd.com/):

All I can say is that if this is needed for a SEV/SNP-relevant fix, the
attestation flow will be adjusted to handle this properly.

> I had assumed that the SEV-SNP microcode revision attestation was for
> all logical processors on the host. Are you saying that it is not?

The attestation flow is fine as it takes into account the lowest
microcode revision across all cores in the system. So it doesn't matter
for SNP which core has been applied successfully or which one hasn't.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
