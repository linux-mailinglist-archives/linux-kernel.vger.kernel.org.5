Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F747FE512
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 01:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343796AbjK3AmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 19:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjK3AmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 19:42:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391FD1B3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 16:42:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9A2C433C8;
        Thu, 30 Nov 2023 00:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701304946;
        bh=8nzlEGlTs23WnuWO60c1e2cluA21UQcXiLq8MdrlUq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Alcgnt/BtUoUp4InDQMZgs/IX+8gQPxIZcPXGUc0udT5b6Tq/haKiZm04X93M1BzD
         Cg2H1jkgvc5R6esOS+bKTc/iFFT9zDGZs+aQqPHL5H6aNrRhLBIV6v3ckvPghTNTiw
         ZKEes9qGssNEGFZXCGEqr1E0pfLLZ0qlTxIvKO1wxGHBL/kg0agO2xr80k+T196MZY
         IasBxgkod+kYtMMOaFuZg7Mv2JV5d2Ji2lJMMPNjpFO7MITDIg8DovvYNYpkFwdNcl
         NDOJAyyQw273ZvY0UoQUICBsc6cWBZQ6iz0LH4Kcv7JjIf502bEGHIiPPd18e74MH2
         ErMz8UgWXsP/A==
Date:   Wed, 29 Nov 2023 17:42:24 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        llvm@lists.linux.dev, arnd@arndb.de
Subject: Re: [PATCH 3/3] drm/amd/display: Support DRM_AMD_DC_FP on RISC-V
Message-ID: <20231130004224.GE2513828@dev-arch.thelio-3990X>
References: <20231122030621.3759313-1-samuel.holland@sifive.com>
 <20231122030621.3759313-4-samuel.holland@sifive.com>
 <20231123-headdress-mold-0dd7a74477f7@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123-headdress-mold-0dd7a74477f7@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 02:23:01PM +0000, Conor Dooley wrote:
> On Tue, Nov 21, 2023 at 07:05:15PM -0800, Samuel Holland wrote:
> > RISC-V uses kernel_fpu_begin()/kernel_fpu_end() like several other
> > architectures. Enabling hardware FP requires overriding the ISA string
> > for the relevant compilation units.
> 
> Ah yes, bringing the joy of frame-larger-than warnings to RISC-V:
> ../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:58:13: warning: stack frame size (2416) exceeds limit (2048) in 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Wframe-larger-than]

:(

> Nathan, have you given up on these being sorted out?

Does your configuration have KASAN (I don't think RISC-V supports
KCSAN)? It is possible that dml/dcn32 needs something similar to commit
6740ec97bcdb ("drm/amd/display: Increase frame warning limit with KASAN
or KCSAN in dml2")?

I am not really interested in playing whack-a-mole with these warnings
like I have done in the past for the reasons I outlined here:

https://lore.kernel.org/20231019205117.GA839902@dev-arch.thelio-3990X/

> Also, what on earth is that function name, it exceeds 80 characters
> before even considering anything else? Actually, I don't think I want
> to know.

Welcome to "gcc-parsable HW gospel, coming straight from HW engineers" :)

Cheers,
Nathan
