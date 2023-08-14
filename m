Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795A977C176
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjHNU0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjHNU0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:26:00 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7F4E5B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:25:59 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 73F9240E0196;
        Mon, 14 Aug 2023 20:25:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WppYfPc9ZAGl; Mon, 14 Aug 2023 20:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692044755; bh=5u4W93jZGbRqyrHSI7VAPgBEpwZ9Naizc5KkK/gnZ2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iui+iwLGNpQSE/Tv+Whu1F1D9HwYfdX/1kDMNTPg+cYX9gIZrUT+7UDmHhhp9moc0
         uWNC/xUJ+wVeQ1WWJuf4STGCJVjDXDtr5BS7MtpZbx2dwPTgeULRJc2NPRglB7alIg
         vA9SoGqMbd+PyEGmmRtoZIQWglT8ztnAGOx5PzVDGarS6WGd33XgZluqvid3SQ3Nwa
         mB1xiEu8fnUbZXq8qmXmK1QEVZEbAEgjWasNu5STm5td5P8+/PgrTMxxBIvgGvHAeS
         QSasOBvr/rodBq5w9Zl+cZUhnT0Mqz79fkHM///qB09TT5Cx+4677X5W6llGV4EpRs
         79omV8CUk/hMg6+v1gjzHfS71nBaH2lZ42SADTEZsi8zlY6EA9ouZJ2JPHHLO9BBq8
         rc+sj4wM1uhv6GyMZnHPWEdBRB7TsZADjIjKWhFpyHUKZl7r8Kvx9IUUG2FVQfDAlM
         Y9a7I/vQyUSU4Wj9j4D9bf+FkuIfKe0tyxPIDkHYD9bWaEZm0G19RTiI2CfZ/RPqPV
         YSHg95laUuyQ+wxp2mnJU2CcfQkkrDWs5LkYdUtuWpb5y9e4s2FBffBB8Py86wM0Ab
         lZtjhHDsf5ALvEfjuaYkyhGR4JGP0wrybTH8mZgPpwyC1jkdxE99DqqxbkZn0upEKX
         NKf3qPx54AiyvrLM/1n4cAAM=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7E97A40E0195;
        Mon, 14 Aug 2023 20:25:50 +0000 (UTC)
Date:   Mon, 14 Aug 2023 22:25:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Nikolay Borisov <nik.borisov@suse.com>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/srso: Disable the mitigation on unaffected
 configurations
Message-ID: <20230814202545.GKZNqNybUnKv+xyrtP@fat_crate.local>
References: <20230813104517.3346-1-bp@alien8.de>
 <1588ed00-be11-ff9d-e4c2-12db78cca06f@suse.com>
 <20230814200813.p5czl47zssuej7nv@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230814200813.p5czl47zssuej7nv@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 01:08:13PM -0700, Josh Poimboeuf wrote:
> Tangentially, the 'cpu_smt_control == CPU_SMT_DISABLED' check is wrong,
> as SMT could still get enabled at runtime and SRSO would be exposed.

Well, even if it gets exposed, I don't think we can safely enable the
mitigation at runtime as alternatives have run already.

I guess I could use CPU_SMT_FORCE_DISABLED here.

> Also is there a reason to re-use the hardware SRSO_NO bit

Not a hardware bit - this is set by software - it is only allocated in
the CPUID leaf for easier interaction with guests.

> rather than clear the bug bit? 

We don't clear the X86_BUGs. Ever. The logic is that if the CPU matches
an affected CPU, that flag remains to show that it is potentially
affected.

/sys/devices/system/cpu/vulnerabilities/ tells you what the actual state
is.

> That seems cleaner, then you wouldn't need this hack:

Not a hack. This is just like the other "not affected" feature flags.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
