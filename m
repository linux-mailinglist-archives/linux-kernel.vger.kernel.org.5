Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF746758246
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjGRQkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjGRQj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:39:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6795210D2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:39:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E916161662
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 16:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E21CC433C8;
        Tue, 18 Jul 2023 16:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689698396;
        bh=eWaZcHsWI81n6SkQbS3KA6jeCLJ0Qmcg3VQycKfRq14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=irVoVVtkRxdHhOFSKnVqtgvZ3OYBf/wX7sWiliHa85pGShBit+Mf6fuVvJjNhvpzJ
         NKq7zG53XEXYkMAOnXwMJzAOc5bYfz0VwhLdJORlF+eHibjZ9XVxwXRv/A7398a/cf
         P8wSN7Lfx1Blu7po8WM1dV067ahejkuV3ySjdHVZJ85pudBuayaYLHhcL1gfgwkhgs
         nK/3QXNeN5feJoTzN5ZP0McIx/Fk6FxTYxBhZLDrPRMdb3G0JAXAhqK+nC4kdIcBVJ
         3RoKHDpPxComNB/XK2HaazBV9lBxmi8j2vwAHBiBG4tXj3JGGYJsKpJsYcRcNSPyxE
         Oe3QBcQurZjZw==
Date:   Tue, 18 Jul 2023 09:39:53 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, Tom Rix <trix@redhat.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] drm/amd/display: Allow building DC with clang on RISC-V
Message-ID: <20230718163953.GA1279879@dev-arch.thelio-3990X>
References: <20230717222923.3026018-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717222923.3026018-1-samuel.holland@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 03:29:23PM -0700, Samuel Holland wrote:
> clang on RISC-V appears to be unaffected by the bug causing excessive
> stack usage in calculate_bandwidth(). clang 16 with -fstack-usage
> reports a 304 byte stack frame size with CONFIG_ARCH_RV32I, and 512
> bytes with CONFIG_ARCH_RV64I.
> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

I built ARCH=riscv allmodconfig drivers/gpu/drm/amd/amdgpu/ (confirming
that CONFIG_DRM_AMD_DC gets enabled) with LLVM 11 through 17 with and
without CONFIG_KASAN=y and I never saw the -Wframe-larger-than instance
that this was disabled for, so I agree.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

> 
>  drivers/gpu/drm/amd/display/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index bf0a655d009e..901d1961b739 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -5,7 +5,7 @@ menu "Display Engine Configuration"
>  config DRM_AMD_DC
>  	bool "AMD DC - Enable new display engine"
>  	default y
> -	depends on BROKEN || !CC_IS_CLANG || X86_64 || SPARC64 || ARM64
> +	depends on BROKEN || !CC_IS_CLANG || ARM64 || RISCV || SPARC64 || X86_64
>  	select SND_HDA_COMPONENT if SND_HDA_CORE
>  	# !CC_IS_CLANG: https://github.com/ClangBuiltLinux/linux/issues/1752
>  	select DRM_AMD_DC_FP if (X86 || LOONGARCH || (PPC64 && ALTIVEC) || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))
> -- 
> 2.40.1
> 
