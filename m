Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF0A7CE4B4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjJRRfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjJRRe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:34:59 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47881B9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:31:34 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-77421a47db6so434573685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697650293; x=1698255093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9bLri2X0kCXBGV92nbDG6SwJM6GKrFdnsc241iebPNs=;
        b=e4b8bsnwDiP7Pe4vbxOAOIEc2cAZ3heTaIZKK9z55sv1NUjixG2X+zDD3zV40Cei4z
         OhE3q+V5cRAP5RU2afazYhPyY+dF9GrvVD8eQ9mJXuGfZWps6kdx5POtC7mS1Qha0mjg
         CSuMs4gZ6H7FnJ2+xsRI+gASeS9ewtO533yVilTBHtL4Xiy/6yYjk7FrIYihAzCgbFeL
         fLrkXp1dFCNwYhG2byuwW8eoXEYx7dNFluJkZsHtNzmsKTAw7bullw/S5dHX7+casfCI
         m7bLTGsDrmHhAbh5TcMWdig2pidG49vvt9xTiIIT9HJwSnPguEmI3d2PZbT3I5Ekyj5V
         RcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697650293; x=1698255093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bLri2X0kCXBGV92nbDG6SwJM6GKrFdnsc241iebPNs=;
        b=USEpW4gpeZrcLH3zwkGG1OsnU9Q8hwtuNaOT6/m+5HIW6VPYZghfregb3gZ+aZhn4f
         WhOZrUp3JlYIW03gldDbsB0q+Ej2yrx/SOXtuu8+8/HBKtuzK6k+3RRTWHOt9C8OpiRn
         REuMbdz4Na5kOTepKR/m39CavDP3Os+upLpDoNj+/orA9Gn23w8krQr1tkiSmtJ4mhna
         G2nvUdGl6RUiqmVDLiw2wgG+4RUy4Fbtctov+rQt2mE17hQoA+1QjHxNctNdaqoAtZOi
         NcwM8fH7ooCtujdfMTGyjsNf9VWAIFX75HOSwbLo8GrYUppX1/Qw/oK5QYJjvdRyT6tN
         B77g==
X-Gm-Message-State: AOJu0YyoSP3bJU+ixv7b0SNVlt9Q7gql7uyPleQCNGFrAg/YYefcxhPw
        TEB1jK9BGGFAeFJ3kmtl0X7LSw==
X-Google-Smtp-Source: AGHT+IFo+mjFtPxRpd0jIylF9fz6tknOGNAoG6F08LeZnO+TZslObXXsbTQ7uyBbn7ocgkka/c15Cw==
X-Received: by 2002:a05:620a:3994:b0:775:9c22:e901 with SMTP id ro20-20020a05620a399400b007759c22e901mr5485542qkn.15.1697650293358;
        Wed, 18 Oct 2023 10:31:33 -0700 (PDT)
Received: from ghost ([208.116.208.98])
        by smtp.gmail.com with ESMTPSA id g3-20020a05620a108300b007789a3499casm109418qkk.115.2023.10.18.10.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:31:32 -0700 (PDT)
Date:   Wed, 18 Oct 2023 10:31:29 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v4 0/2] riscv: Add remaining module relocations and tests
Message-ID: <ZTAWcX1qVhkC71BJ@ghost>
References: <20231017-module_relocations-v4-0-937f5ef316f0@rivosinc.com>
 <20231018-smite-bungee-f46b15b4ce6f@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018-smite-bungee-f46b15b4ce6f@spud>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 12:35:55PM +0100, Conor Dooley wrote:
> Hey Charlie,
> 
> On Tue, Oct 17, 2023 at 10:34:15PM -0700, Charlie Jenkins wrote:
> > A handful of module relocations were missing, this patch includes the
> > remaining ones. I also wrote some test cases to ensure that module
> > loading works properly. Some relocations cannot be supported in the
> > kernel, these include the ones that rely on thread local storage and
> > dynamic linking.
> > 
> > ULEB128 handling is a bit special because SET and SUB relocations must
> > happen together, and SET must happen before SUB. A psABI proposal [1]
> > mandates that the first SET_ULEB128 that appears before a SUB_ULEB128
> > is the associated SET_ULEB128.
> > 
> > This can be tested by enabling KUNIT, RUNTIME_KERNEL_TESTING_MENU, and
> > RISCV_MODULE_LINKING_KUNIT.
> > 
> > [1] https://github.com/riscv-non-isa/riscv-elf-psabi-doc/pull/403
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> > Changes in v4:
> > - Complete removal of R_RISCV_RVC_LUI
> > - Fix bug in R_RISCV_SUB6 linking
> > - Only build ULEB128 tests if supported by toolchain
> > - Link to v3: https://lore.kernel.org/r/20231016-module_relocations-v3-0-a667fd6071e9@rivosinc.com
> 
> On patch 2/2:
> 
> ../arch/riscv/kernel/tests/module_test/test_uleb128.S:18:17: error: unknown relocation name
> ../arch/riscv/kernel/tests/module_test/test_uleb128.S:19:17: error: unknown relocation name
> 
> Same toolchain configuration in the patchwork automation as before.
> 
> Cheers,
> Conor.

Where do you see this error? On Patchwork I see a success [1].

[1] https://patchwork.kernel.org/project/linux-riscv/patch/20231017-module_relocations-v4-2-937f5ef316f0@rivosinc.com/

> 
> > 
> > Changes in v3:
> > - Add prototypes to test_module_linking_main as recommended by intel
> >   zero day bot
> > - Improve efficiency of ULEB128 pair matching
> > - Link to v2: https://lore.kernel.org/r/20231006-module_relocations-v2-0-47566453fedc@rivosinc.com
> > 
> > Changes in v2:
> > - Added ULEB128 relocations
> > - Link to v1: https://lore.kernel.org/r/20230913-module_relocations-v1-0-bb3d8467e793@rivosinc.com
> > 
> > ---
> > Charlie Jenkins (2):
> >       riscv: Add remaining module relocations
> >       riscv: Add tests for riscv module loading
> > 
> >  arch/riscv/Kconfig.debug                           |   1 +
> >  arch/riscv/include/uapi/asm/elf.h                  |   5 +-
> >  arch/riscv/kernel/Makefile                         |   1 +
> >  arch/riscv/kernel/module.c                         | 207 ++++++++++++++++++---
> >  arch/riscv/kernel/tests/Kconfig.debug              |  35 ++++
> >  arch/riscv/kernel/tests/Makefile                   |   1 +
> >  arch/riscv/kernel/tests/module_test/Makefile       |  15 ++
> >  .../tests/module_test/test_module_linking_main.c   |  85 +++++++++
> >  arch/riscv/kernel/tests/module_test/test_set16.S   |  23 +++
> >  arch/riscv/kernel/tests/module_test/test_set32.S   |  20 ++
> >  arch/riscv/kernel/tests/module_test/test_set6.S    |  23 +++
> >  arch/riscv/kernel/tests/module_test/test_set8.S    |  23 +++
> >  arch/riscv/kernel/tests/module_test/test_sub16.S   |  22 +++
> >  arch/riscv/kernel/tests/module_test/test_sub32.S   |  22 +++
> >  arch/riscv/kernel/tests/module_test/test_sub6.S    |  22 +++
> >  arch/riscv/kernel/tests/module_test/test_sub64.S   |  27 +++
> >  arch/riscv/kernel/tests/module_test/test_sub8.S    |  22 +++
> >  arch/riscv/kernel/tests/module_test/test_uleb128.S |  20 ++
> >  18 files changed, 548 insertions(+), 26 deletions(-)
> > ---
> > base-commit: 4d320c2d9a2b22f53523a1b012cda17a50220965
> > change-id: 20230908-module_relocations-f63ced651bd7
> > -- 
> > - Charlie
> > 


