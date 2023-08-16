Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C41C77E7BB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344296AbjHPRgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345277AbjHPRfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:35:47 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318302710
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:35:46 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6329240E0197;
        Wed, 16 Aug 2023 17:35:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id n0JSCixq2TF6; Wed, 16 Aug 2023 17:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692207341; bh=Q+St8D4yU2DPSg0YS5UDkFey7X71OU/AUWstEQDJWbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JnUtLAXw/uYokKp0RI2kH6e5RMchQ8e/9Xyuit15ZSJcu5fRaDjw+nhOpipZ4viIc
         gDGMJ7yhMKY+Zwm/YXK+8msnce8cRRlOHnL2y7JqdyCyjt7xjD44V4+ROJOKIOxdtz
         87c8ohqfyhkOo1NFgoY8aePZfAg7a8O1uqUBdtnM4hlIlzz6mID5CCHGTSi28gUTH5
         htR/wdXzSnGkfd/S5sISWCueCyovNn6uufnyrvVVz3qovYlTUmPWI4Vm48QL3eBZw8
         NxkfWGcnptx+pypp1vpOoMBKq0Kds2LBwtTnEN3ZUOTDJ6Gjvld5cKC5n7AU003oZu
         psqCQh1D7X+qhvOJyh1Zaq0U8OWnjPP1F+JubKPw1+KDfLYN8xlXbfo1Tp8w7MBS+7
         32rNdmFSlt97wFA7exMdQ8AMu6sDRuk5bJAFZGwUtEzpR037dvPV9V/n0bdmyrtfUl
         IzaE772VJNVQA68xFalMDkiAXTGUidI8jnjfsyCTwteTr3Extd7MRmZ/9olVEFH7AC
         cfLWY3WQ3eUYpozTso7Ym8Y7zIeqnSQqAj9qcfxHHSoINMZ1T4x6zkkZB36QU29i+r
         XidqrUVAzDVNYAv8Jxde87FKIz3eeWI6eCevnXJ7u/nHEvKp/+VT/kMOrhkXsxvA/v
         Xx2JbxqEgVNNUB4zbwmLpcuc=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 169CF40E0193;
        Wed, 16 Aug 2023 17:35:36 +0000 (UTC)
Date:   Wed, 16 Aug 2023 19:35:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Nikolay Borisov <nik.borisov@suse.com>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/srso: Correct the mitigation status when SMT is
 disabled
Message-ID: <20230816173531.GMZN0I40DEFE38Zxuz@fat_crate.local>
References: <20230814200813.p5czl47zssuej7nv@treble>
 <20230814202545.GKZNqNybUnKv+xyrtP@fat_crate.local>
 <20230814205300.krikym7jeckehqik@treble>
 <20230814211727.GLZNqZ5+flxtyaDjMQ@fat_crate.local>
 <20230815095724.GBZNtMBPUJSEegviJN@fat_crate.local>
 <20230815195831.2opbgrznnpszaa32@treble>
 <20230815201753.GGZNvdcbPHXtEXn4As@fat_crate.local>
 <20230815212751.xhsyn7iwj2gwpuk5@treble>
 <20230816083057.GCZNyJQVARsxD3rNAm@fat_crate.local>
 <20230816160757.oegndrcnf2fvt7l3@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816160757.oegndrcnf2fvt7l3@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 09:07:57AM -0700, Josh Poimboeuf wrote:
> In this case srso_show_state() is never called, so the following code
> can't run:
> 
> +	if (boot_cpu_has(X86_FEATURE_SRSO_NO)) {
> +		if (sched_smt_active())
> +			return sysfs_emit(buf, "Not affected\n");

Ofc it can. If something has set X86_FEATURE_SRSO_NO early, before the
bug bits detection happens, then you get:

$ cat /sys/devices/system/cpu/vulnerabilities/spec_rstack_overflow
Not affected

> In this case SMT is disabled, so the following code still can't run:
> 
> +	if (boot_cpu_has(X86_FEATURE_SRSO_NO)) {
> +		if (sched_smt_active())
> +			return sysfs_emit(buf, "Not affected\n");

Yes, it runs in the above case where on some future hw which might have
SRSO fixed, we'll set SRSO_NO.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
