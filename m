Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAE180F4CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376830AbjLLRmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjLLRmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:42:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34F383
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:42:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912EFC433C7;
        Tue, 12 Dec 2023 17:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702402975;
        bh=+h9Hy/o6qPUoywDyWEUPYa0LHvbEAwTr1e24Paq/tos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lDcLxHelMIzPI8uabqZaj/J1ptw8Bbp3/fmYDq0ra7rMT0PeFkQ90OOZCAPFaUb6A
         Pf1xrFjFQDntjBJ4litDwDD96rI7P1hbXkHlQbxzfymZPaWqFcP3fJIKPQdbiwgy5V
         BZJhfu7qQSK2nEpGdAWBr/1DJIdxCNhkDvpMPJNKnZReAND+JosLQhQEoKLVyhjNHY
         7QQIjUTZ9p13DxnOVCRkam5wdQ9+3tPoCM9vtVV5SAZCsuMYJISitUvT7/vXsbJMJc
         Qmgwwdb2RgC0munn2yFEdl9n2A/m1gqB5rjiOmGfk/xWixe+wxrvaEF4X8ZUEXoRmv
         Bu4BZ7fKxNpRQ==
Date:   Tue, 12 Dec 2023 09:42:52 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] drm/amd/display: Support DRM_AMD_DC_FP on RISC-V
Message-ID: <20231212174252.ycztjhgyhtcrffur@treble>
References: <20231122030621.3759313-1-samuel.holland@sifive.com>
 <20231122030621.3759313-4-samuel.holland@sifive.com>
 <ZV2+f/yu3C6xTVqn@infradead.org>
 <6d4cecd5-9083-4d68-a7e2-266dae9e3952@sifive.com>
 <ZXgH6un2uLdjQ48X@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXgH6un2uLdjQ48X@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 11:12:42PM -0800, Christoph Hellwig wrote:
> On Thu, Dec 07, 2023 at 10:49:53PM -0600, Samuel Holland wrote:
> > Actually tracking all possibly-FPU-tainted functions and their call sites is
> > probably possible, but a much larger task.
> 
> I think objtool should be able to do that reasonably easily, it already
> does it for checking section where userspace address access is enabled
> or not, which is very similar.

Yeah, that might be doable.  I can look into it.

-- 
Josh
