Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF60801147
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjLAQ6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjLAQ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:58:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B403173B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:58:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCD1C433C9;
        Fri,  1 Dec 2023 16:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701449898;
        bh=g6SxzACtr+rLXraxPSFcLrZbpvVcT8akURcyTpfXFm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sRLRGRrlLfd1e1SvG5DMc9yvLGFHvtVKvMU5JQrHnDLbNvwdwPgXUwZNPMPJJb2x+
         bVb54PNV8djtst2Ay9XgHjLNYZBrgCp/fyHQyWRjMHI3rZ3TIPtiex+YFh2jt4RD6W
         Q6QfmB/Uab76eu7KLa5G5A48cMSKmPTfG9PzDLy2ZfJkRs0CDxnSgBC4NCOaXz5D0h
         ALORRZNgrQLB+KQE/H4EXmHrioloqtkoVPXahAJU50kZKV0stbmWqsraRTWMrtgjSP
         6chtXX+gZIafMm1YbuuUBwfMs/IBGVQvhsGwy0P7vuRzajijyUZgGQx49IYeYteSrK
         T0c1e74d4sodQ==
Date:   Fri, 1 Dec 2023 09:58:16 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/Kconfig: Disable KASLR on debug builds
Message-ID: <20231201165816.GA2968051@dev-arch.thelio-3990X>
References: <20231130120552.6735-1-bp@alien8.de>
 <20231130181051.GA3357088@dev-arch.thelio-3990X>
 <20231130193428.GNZWjjxKJ38Ruh7puz@fat_crate.local>
 <20231201161610.GA2948377@dev-arch.thelio-3990X>
 <20231201162443.GBZWoIywsIqB+SNh9n@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201162443.GBZWoIywsIqB+SNh9n@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 05:24:43PM +0100, Borislav Petkov wrote:
> On Fri, Dec 01, 2023 at 09:16:10AM -0700, Nathan Chancellor wrote:
> > Right, this is the diff of Fedora's configuration before and after this
> > change:
> 
> Sorry, but what's the point of a .config which has EXPERT, DEBUG_KERNEL
> *and* KASLR enabled?

I am not really here to argue whether or not this is a "valid"
combination of configurations, I am just pointing out that your patch
will change the status quo for more people than just the x86
maintainers.

> Debugging the kernel with KASLR enabled is a futile exercise in time
> waste. You should either enable KASLR and disable DEBUG_KERNEL or the
> opposite. Both make very little sense to me.

I agree that debugging the kernel with KASLR enabled is useless but
isn't that the point of having the ability to opt out of it at runtime
so that you could debug the exact same binary that a user is running,
rather than having to manage two different builds?

> Or, if there really is a valid reason for having DEBUG_KERNEL *and*
> KASLR enabled, I can probably suggest another option under DEBUG_KERNEL
> which says "Do stable virtual addresses" and which disables KASLR. At
> least we'll have it explicit.

That does not seem unreasonable to me. Another alternative would be to
add a simple config fragment in arch/x86/configs so that it could
easily be flipped during a build like:

$ cat arch/x86/configs/nokaslr.config
# CONFIG_RANDOMIZE_BASE is not set

$ make -skj"$(nproc)" ARCH=x86_64 defconfig

$ grep CONFIG_RANDOMIZE_BASE .config
CONFIG_RANDOMIZE_BASE=y

$ make -skj"$(nproc)" ARCH=x86_64 nokaslr.config

$ grep CONFIG_RANDOMIZE_BASE .config
# CONFIG_RANDOMIZE_BASE is not set

Cheers,
Nathan
