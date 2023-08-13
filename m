Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FA077A494
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 03:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjHMBZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 21:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHMBZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 21:25:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF671713
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 18:25:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF67C61FC5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 01:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14271C433CA
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 01:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691889924;
        bh=qBn7ZrOy+UcTVdFjclASJJKKcop5exO2hn21hxT/xuI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m9/13huMbVmD3gCR1x395p1wAOBRceMwvCKXF+sqwbAHShDAXYFf/wmzY/1Z6eq0s
         +P5FYqVzSj7ZzWxldsXvjQml4ymH6jpRxY6PuKN7Hhir6IL+x0iksXbFQhePb/nBaK
         Ofxc+eqr3HbNjk66iYo/R3lHewmMbuR3daMmWitSA0uE+tFnzhFNxr2/RmHKicLGya
         ryUc1QodjBEK8YfPpryglqhem2rebThdtk7DGPZR42O6XAV0Oap4PsuUgKghtlMmDm
         sqyg3YbTjwONcTI7eic+fHgiI+rItnQNiAU/VglkWI7m6QF9r3vs1iOtw/4A+aUPRq
         UmedHIL6v4K0w==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-99c93638322so661037366b.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 18:25:23 -0700 (PDT)
X-Gm-Message-State: AOJu0YxvtjdZN7QbIE2BN3MKj1suqe8Ee+8acehU5jHLTx15aLij2SYM
        3aLE7fNPKtx07ND1uYp0hCvRYQf0Kb9rfL3tl2Y=
X-Google-Smtp-Source: AGHT+IFBUqH08lheIJkH/oMHGgazBLLf/1+HP+LYHvJfgYOnuhTd5XaEtVlAr7EpvNwEjhzFG3y+luogwo0/YJC71vs=
X-Received: by 2002:a17:907:c16:b0:988:d841:7f90 with SMTP id
 ga22-20020a1709070c1600b00988d8417f90mr10036574ejc.27.1691889922298; Sat, 12
 Aug 2023 18:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230811233556.97161-8-samitolvanen@google.com> <202308122238.XLMMmeL0-lkp@intel.com>
In-Reply-To: <202308122238.XLMMmeL0-lkp@intel.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 13 Aug 2023 09:25:10 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQmezqnJo68CuV8e+=RwCAioKbk0UqTS_fq5--HjUTLDw@mail.gmail.com>
Message-ID: <CAJF2gTQmezqnJo68CuV8e+=RwCAioKbk0UqTS_fq5--HjUTLDw@mail.gmail.com>
Subject: Re: [PATCH 1/5] riscv: VMAP_STACK overflow detection thread-safe
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>, llvm@lists.linux.dev,
        kernel test robot <lkp@intel.com>,
        oe-kbuild-all@lists.linux.dev, Deepak Gupta <debug@rivosinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jisheng Zhang <jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 10:36=E2=80=AFPM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Sami,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on 52a93d39b17dc7eb98b6aa3edb93943248e03b2f]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Sami-Tolvanen/risc=
v-VMAP_STACK-overflow-detection-thread-safe/20230812-073751
> base:   52a93d39b17dc7eb98b6aa3edb93943248e03b2f
> patch link:    https://lore.kernel.org/r/20230811233556.97161-8-samitolva=
nen%40google.com
> patch subject: [PATCH 1/5] riscv: VMAP_STACK overflow detection thread-sa=
fe
> config: riscv-randconfig-r042-20230812 (https://download.01.org/0day-ci/a=
rchive/20230812/202308122238.XLMMmeL0-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git =
4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce: (https://download.01.org/0day-ci/archive/20230812/202308122238=
.XLMMmeL0-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308122238.XLMMmeL0-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> ld.lld: error: undefined symbol: __per_cpu_offset
>    >>> referenced by arch/riscv/kernel/entry.o:(handle_kernel_stack_overf=
low) in archive vmlinux.a
!CONFIG_SMP missed

>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki



--=20
Best Regards
 Guo Ren
