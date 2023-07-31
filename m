Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC2176A380
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjGaV51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjGaV5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:57:25 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3960139
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:57:23 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1bb98659f3cso34921295ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690840643; x=1691445443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q7XDjhCYt7FGRw55Y+SxXkLDr9VBzRKTPxUQEL1DO0A=;
        b=0r14oa0yxeLPoDTcrUFQsdRmJ1MzKa5X6LsW73dNl1PU/OSY0zRi/GXEUUtRuunzke
         BEXFYTKK9dhr/btpqKk9/KxGb46VF7nLnK8mdvlEa2Vqw6gx1jzqrm22oIwqY9XYoVAB
         o6tMTCDy9zYK4CsNQNKSC8DRFIK6HeIcOJBJcWQcv4dx4BpPRccobsOEqeM2JlWM0c+x
         tRilDqJw0H63lLGsTpxmR4Bilf75D9M09hSNVeFdNixjCrNPPDkxBE6WoQW7XXZ0GnKM
         oLzZ0TTXsq0m1tiYsjmkycSmFXfux5P5Y7E/la2Cz24A5F+xCBn6/y1+P7bnaB9/Ug+S
         oKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690840643; x=1691445443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7XDjhCYt7FGRw55Y+SxXkLDr9VBzRKTPxUQEL1DO0A=;
        b=g6UlLuB7zfSL6zWBF/HydYn07oULSukLEmGxfv+AERRkx0ai5IbPrQUcg41z/fOV+d
         r74BATMXKI/pCaYW3616LYD3AImCtW2J0i+/sP1iASjCr1+beJro7fozcl/xvqF1Copd
         0UtUfYad6iaHLMmPj11CUutvV5lIqW8qkCaI5a6ImSWLddRt6y2/kFbpRa1tNcsGXBGs
         WHY1hXInGTyH+5yqIeLlSmC+3HRRuQu1iWUcigR5szGG6AA0XXhRzHs500jjARcSXkzn
         RNwWXlJY0DElb1/RirxHxZjqBGbAIDOxSgNsBuHjsdHV2jyprdbwZD1nZTdC2Ozt53Iz
         ttSA==
X-Gm-Message-State: ABy/qLZOWd7daGQHhXDYCGB5iY+J5ySNifPA2Eng+rnFG5Dgc3/bLWYW
        niEjc17tMCh/6v+xoClBRXPTCqSJfnw=
X-Google-Smtp-Source: APBJJlEt1EFA1GYHjWvxsA4wpLnQLY4u9T6tmKWhLJwuz8A3I/H56oGiC/ODlllK4HuoyYxAZYF+nbSducE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2291:b0:1b5:2b14:5f2c with SMTP id
 b17-20020a170903229100b001b52b145f2cmr50366plh.4.1690840643199; Mon, 31 Jul
 2023 14:57:23 -0700 (PDT)
Date:   Mon, 31 Jul 2023 14:57:21 -0700
In-Reply-To: <20230722022251.3446223-1-rananta@google.com>
Mime-Version: 1.0
References: <20230722022251.3446223-1-rananta@google.com>
Message-ID: <ZMguQayWzKU3/8o5@google.com>
Subject: Re: [PATCH v7 00/12] KVM: arm64: Add support for FEAT_TLBIRANGE
From:   Sean Christopherson <seanjc@google.com>
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Jing Zhang <jingzhangos@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023, Raghavendra Rao Ananta wrote:
>  arch/arm64/include/asm/kvm_asm.h     |   3 +
>  arch/arm64/include/asm/kvm_host.h    |   6 ++
>  arch/arm64/include/asm/kvm_pgtable.h |  10 +++
>  arch/arm64/include/asm/tlbflush.h    | 109 ++++++++++++++-------------
>  arch/arm64/kvm/Kconfig               |   1 -
>  arch/arm64/kvm/arm.c                 |   6 --
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c   |  11 +++
>  arch/arm64/kvm/hyp/nvhe/tlb.c        |  30 ++++++++
>  arch/arm64/kvm/hyp/pgtable.c         |  90 +++++++++++++++++++---
>  arch/arm64/kvm/hyp/vhe/tlb.c         |  27 +++++++
>  arch/arm64/kvm/mmu.c                 |  15 +++-
>  arch/mips/include/asm/kvm_host.h     |   4 +-
>  arch/mips/kvm/mips.c                 |  12 +--
>  arch/riscv/kvm/mmu.c                 |   6 --
>  arch/x86/include/asm/kvm_host.h      |   7 +-
>  arch/x86/kvm/mmu/mmu.c               |  25 ++----
>  arch/x86/kvm/mmu/mmu_internal.h      |   3 -
>  arch/x86/kvm/x86.c                   |   2 +-
>  include/linux/kvm_host.h             |  20 +++--
>  virt/kvm/Kconfig                     |   3 -
>  virt/kvm/kvm_main.c                  |  35 +++++++--
>  21 files changed, 294 insertions(+), 131 deletions(-)

Unless I've missed something, nothing in this series conflicts with anything that's
on the horizon for x86, so feel free to take this through the ARM tree once we've
emerged from behind the bikeshed :-)
