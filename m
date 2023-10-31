Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A112E7DCF16
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344012AbjJaOVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjJaOVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B75BF3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698762056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QXthgqjY+SpDv3y6xxTLIrI9RIFKk1NjsAtr8h5OfqY=;
        b=gAOaaoph+JLwcYNHFMxRL4Sp03pLW0MOKQW7CaISuWi4lNZy1XrafQO+QJUZFT51lQrZT7
        O6i2SAEv8FX/+lAy5x0s8XeqoIuyRDPy8Ca7zlodGmrl7QXa/tKyHlVdipziQhUg3KNiPy
        AuMi8u/Edf8/vQY/TgLeSA7AoA3po/k=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-U93QScwJP3igyTWFXAr3qw-1; Tue, 31 Oct 2023 10:20:54 -0400
X-MC-Unique: U93QScwJP3igyTWFXAr3qw-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-7ba45ffb1e0so786049241.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698762053; x=1699366853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXthgqjY+SpDv3y6xxTLIrI9RIFKk1NjsAtr8h5OfqY=;
        b=YRPvLN+NRqcIuc6kB1gYVH8CsupRrRSq6HbC9PCwHcny8dA5kzz6+LZC1cMtoTIbA1
         1LvQsb/ef9WEaeR+v3XPJPrdS2BgTV9m0h41gOIDeHesgpxq/tYMibEDcc1s9wyVP2tY
         52GMpt1Ohsr93AE44MJezm9I4SkqNGxTjUIcEC9NHwyBhoiBaj5FoEm8t5de+PfCwNZU
         p6IM4c+sQSUT/lf6SCWlZ3M+lfHEwsJTMlFBIgsda62roORUCjfqnRY1jGuPcA8xaSM/
         MHCXDzUF5uL6ij0coJNVEzuZ14slLD8krwOvEKLo6UqAPlC+831vvGkRwYrPJluqeF9t
         hTmA==
X-Gm-Message-State: AOJu0YzuYOfnDq4g5XVxNjXp2yXCra+5rMs5dKCVuqy0Wtv7SKRTwRsm
        7GXlEd5XKOa3JqOAPyWapc6oWj/LVsr8YqNttQS4mFjnHXnjE4qfzJqcT6f+qbFCSuiPznzGlUM
        EgYwbQKGDoXOWElk+lKhKJoAYXodss2e3Scof241w
X-Received: by 2002:a67:c89d:0:b0:457:bc5f:b497 with SMTP id v29-20020a67c89d000000b00457bc5fb497mr11554247vsk.27.1698762053572;
        Tue, 31 Oct 2023 07:20:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZTNWIrtxgjAmfW2uP5CgYHQb74iSe9pyTPKxSUoeAiL/+ELfGW3MKgEGC5lWgJVeaIXdJwYHIgvWDZhYMIJs=
X-Received: by 2002:a67:c89d:0:b0:457:bc5f:b497 with SMTP id
 v29-20020a67c89d000000b00457bc5fb497mr11554223vsk.27.1698762053277; Tue, 31
 Oct 2023 07:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231027204933.3651381-1-seanjc@google.com> <20231027204933.3651381-5-seanjc@google.com>
In-Reply-To: <20231027204933.3651381-5-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 31 Oct 2023 15:20:41 +0100
Message-ID: <CABgObfb55_B0SC41j9iiqBuccoSiZK+x488Pqpyq=R32eObtwQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: MMU changes for 6.7
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 10:49=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> This is mostly the first half of a series by Yan to optimize KVM's handli=
ng of
> guest MTRR changes for VMs with non-coherent DMA.  Yan had to put more co=
mplex
> changes that actually realize the optimizations on hold, but the patches =
here
> are all nice cleanups on their own.
>
> The following changes since commit 5804c19b80bf625c6a9925317f845e497434d6=
d3:
>
>   Merge tag 'kvm-riscv-fixes-6.6-1' of https://github.com/kvm-riscv/linux=
 into HEAD (2023-09-23 05:35:55 -0400)

Pulled, thanks.

Paolo


> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-mmu-6.7
>
> for you to fetch changes up to 1de9992f9de0a92b6e11133aba0e2be833c11084:
>
>   KVM: x86/mmu: Remove unnecessary =E2=80=98NULL=E2=80=99 values from spt=
ep (2023-10-18 14:34:28 -0700)
>
> ----------------------------------------------------------------
> KVM x86 MMU changes for 6.7:
>
>  - Clean up code that deals with honoring guest MTRRs when the VM has
>    non-coherent DMA and host MTRRs are ignored, i.e. EPT is enabled.
>
>  - Zap EPT entries when non-coherent DMA assignment stops/start to preven=
t
>    using stale entries with the wrong memtype.
>
>  - Don't ignore guest PAT for CR0.CD=3D1 && KVM_X86_QUIRK_CD_NW_CLEARED=
=3Dy, as
>    there's zero reason to ignore guest PAT if the effective MTRR memtype =
is WB.
>    This will also allow for future optimizations of handling guest MTRR u=
pdates
>    for VMs with non-coherent DMA and the quirk enabled.
>
>  - Harden the fast page fault path to guard against encountering an inval=
id
>    root when walking SPTEs.
>
> ----------------------------------------------------------------
> Li zeming (1):
>       KVM: x86/mmu: Remove unnecessary =E2=80=98NULL=E2=80=99 values from=
 sptep
>
> Yan Zhao (5):
>       KVM: x86/mmu: Add helpers to return if KVM honors guest MTRRs
>       KVM: x86/mmu: Zap SPTEs when CR0.CD is toggled iff guest MTRRs are =
honored
>       KVM: x86/mmu: Zap SPTEs on MTRR update iff guest MTRRs are honored
>       KVM: x86/mmu: Zap KVM TDP when noncoherent DMA assignment starts/st=
ops
>       KVM: VMX: drop IPAT in memtype when CD=3D1 for KVM_X86_QUIRK_CD_NW_=
CLEARED
>
>  arch/x86/kvm/mmu.h     |  7 +++++++
>  arch/x86/kvm/mmu/mmu.c | 37 ++++++++++++++++++++++++++-----------
>  arch/x86/kvm/mtrr.c    |  2 +-
>  arch/x86/kvm/vmx/vmx.c |  9 +++------
>  arch/x86/kvm/x86.c     | 21 ++++++++++++++++++---
>  5 files changed, 55 insertions(+), 21 deletions(-)
>

