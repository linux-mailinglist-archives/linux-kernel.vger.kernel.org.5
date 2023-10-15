Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9C27C98EF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 14:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjJOMYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 08:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjJOMYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 08:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61527AB
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 05:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697372614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MJ81Q5/B7q8cI3s0s8gDvVOoyclQrSAhpuPqTSeggew=;
        b=RvHnsKsI8bH6Dm+Kz/rszsBR4iAw0AC1eoyZpYsza+GcevVgOQisbgevP1iU1Elv+CxdI+
        aBxnXFEo2RbvA8eOFsQ1msTQflhiwzpfjvMdEsLjOjIYBWicmm2SxEyK3aRIFukMCrlrfa
        cygIvMt6rgChUVPQtnIQ4XkEHBTO7G4=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-AVAMyzsEMS-Bnqnljrc2Nw-1; Sun, 15 Oct 2023 08:23:23 -0400
X-MC-Unique: AVAMyzsEMS-Bnqnljrc2Nw-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-4a4156b0b5cso1143808e0c.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 05:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697372597; x=1697977397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJ81Q5/B7q8cI3s0s8gDvVOoyclQrSAhpuPqTSeggew=;
        b=fJuOjjuce4M3jsozijJAPybeGUr0ZcnKFo2YReyw630ndrwzUeKrnjBq9q9wUY9fNg
         +gB5258+Ix9MRSFNqyidczYJQJqkN2C/DGSZHRk3STh1wdDGhViniyji2UfGYPV9vMxT
         zpugtZ3nAy7mwZxZUffGK9E4Ue6TiOf73bvsclEvRWUhRz4UnCx6e59ufpnulT3FJJRs
         2UmepYv1vcG4BGBGgyRaX6OfxBDVe7gXsn3YP+YLveLRDNUlR6eJtAjk4TRK/I+inexG
         9yKFCW6VJRWVs0Ag99rhx31w0ISM74Ner6MqtvwYU9/nKxAYWAyDi7ND9xz4YUJ9Tt/z
         VfTA==
X-Gm-Message-State: AOJu0YyLXiPGyDEL98k571MxglDH1IJfQ+wq7ZOoBx64YcUXjbSqbMyF
        ujs/qSDY+yH5vxcHd99QIEhm0d62aKC7BkL30DeEgv6xqfugSATrD1lVr5CE8+1WYO7XNNsaIwf
        oLF0LtQ+mIY2Mwn7dNzCITkj9Rhg22YGq2GpMHYQj2kd0Jhey
X-Received: by 2002:a67:e1c4:0:b0:457:bdbf:8a34 with SMTP id p4-20020a67e1c4000000b00457bdbf8a34mr5510907vsl.29.1697372597594;
        Sun, 15 Oct 2023 05:23:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLssNye3K6hgQQYMw1WXAnaq+73MFpiDByXlBI9bAJiL9b103Flr6+4ZBOkqE2VWibhn55BXabT71I1Q4Czc4=
X-Received: by 2002:a67:e1c4:0:b0:457:bdbf:8a34 with SMTP id
 p4-20020a67e1c4000000b00457bdbf8a34mr5510883vsl.29.1697372596972; Sun, 15 Oct
 2023 05:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231013213053.3947696-1-maz@kernel.org>
In-Reply-To: <20231013213053.3947696-1-maz@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Sun, 15 Oct 2023 14:23:05 +0200
Message-ID: <CABgObfYQoepvvB6j7k2gei0DdV+noO-qSfEzqFcmrKLM_URG_Q@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 fixes for 6.6, take #2
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        James Morse <james.morse@arm.com>,
        Joey Gouly <joey.gouly@arm.com>, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 11:31=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrot=
e:
>
>  Paolo,
>
> Here's a set of additional fixes for 6.6. The most important part is
> the fix for a breakage of the Permission Indirection feature, which is
> a regression. The other (less important) part is a fix for the physical
> timer offset.
>
> Please pull,
>
>         M.
>
> The following changes since commit 373beef00f7d781a000b12c31fb17a5a9c2596=
9c:
>
>   KVM: arm64: nvhe: Ignore SVE hint in SMCCC function ID (2023-09-12 13:0=
7:37 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kv=
marm-fixes-6.6-2
>
> for you to fetch changes up to 9404673293b065cbb16b8915530147cac7e80b4d:
>
>   KVM: arm64: timers: Correctly handle TGE flip with CNTPOFF_EL2 (2023-10=
-12 16:55:21 +0100)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM/arm64 fixes for 6.6, take #2
>
> - Fix the handling of the phycal timer offset when FEAT_ECV
>   and CNTPOFF_EL2 are implemented.
>
> - Restore the functionnality of Permission Indirection that
>   was broken by the Fine Grained Trapping rework
>
> - Cleanup some PMU event sharing code
>
> ----------------------------------------------------------------
> Anshuman Khandual (1):
>       KVM: arm64: pmu: Drop redundant check for non-NULL kvm_pmu_events
>
> Joey Gouly (2):
>       KVM: arm64: Add nPIR{E0}_EL1 to HFG traps
>       KVM: arm64: POR{E0}_EL1 do not need trap handlers
>
> Marc Zyngier (1):
>       KVM: arm64: timers: Correctly handle TGE flip with CNTPOFF_EL2
>
>  arch/arm64/include/asm/kvm_arm.h |  4 ++--
>  arch/arm64/kvm/arch_timer.c      | 13 +++---------
>  arch/arm64/kvm/emulate-nested.c  |  2 ++
>  arch/arm64/kvm/hyp/vhe/switch.c  | 44 ++++++++++++++++++++++++++++++++++=
++++++
>  arch/arm64/kvm/pmu.c             |  4 ++--
>  arch/arm64/kvm/sys_regs.c        |  4 ++--
>  include/kvm/arm_arch_timer.h     |  7 +++++++
>  7 files changed, 62 insertions(+), 16 deletions(-)
>

