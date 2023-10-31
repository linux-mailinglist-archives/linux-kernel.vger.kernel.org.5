Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DAC7DCF2B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbjJaOPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbjJaOPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44602DE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698761689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t0Rzur0DPYsSsAxdt1Pi/bDYKklT+E5fkG1AqmAajEo=;
        b=OnxDyVyvgiMYG47XACejsKhdAqdhU/WmXnJme5mdzyx/7hq8YxdMfZPdabVmn5tc/SSsbH
        RoM3Nm+j0yngG4J+fWvX1nddGA/IrhOydQ5Djo6kOmrJDAzOpPdpEGeS8jYlFIkQilPYbA
        NdD8qboG0lINtkU2hICr7H9YaCYTKHE=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-mOmeb7syO7W6WlA8j27iPA-1; Tue, 31 Oct 2023 10:14:47 -0400
X-MC-Unique: mOmeb7syO7W6WlA8j27iPA-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-457c02bfb64so1859787137.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698761686; x=1699366486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0Rzur0DPYsSsAxdt1Pi/bDYKklT+E5fkG1AqmAajEo=;
        b=pC9VxS9Sa5jrKsJCJJFJdoeLLxTT+5GkzOJ9oCQYYaouEtngStarODHais+XlBo5z6
         x9fmCeXb7V6AVko6l4jdbigCzm1FzxyIKVleAc/SkvDqn5aLtAWQSrT9mb/vCSZL0aYh
         n+VU2n8RuDKaoubMiOUDQVFFn12Cp1oIAx3cQH84n/bbqZgidJx44YlE2wF27V0YPbYk
         7WVPKwcAkEXDCW8MKMLIYWAhqCODDuyXDNcn45TFayAAL0gZSz3fWlWGK0iotfIkJmil
         1YABY8AC4GjzFWXca3LrefofkhX5ebxgVJuqEEmsN3Dp+ep7nJiki2VbUpYMQLVx4Koy
         Nunw==
X-Gm-Message-State: AOJu0YwfZCNp14U1F3o1bMMOQV1LBf8Mgml/SaiA3qDK7HZa4HCx0Jgm
        L9KiYGQFCfANhi0CM5SweBF1djFqraL08psHQvf7z3U8Uix1kEtUY0+pDM1TsYN/TArPUaijXun
        Ifb02hHSlM0l3QICANcLxWW+3jp3IGth3Hpges7m2BP7ndsm2
X-Received: by 2002:a05:6102:3d8c:b0:457:a915:5e85 with SMTP id h12-20020a0561023d8c00b00457a9155e85mr12840824vsv.28.1698761686242;
        Tue, 31 Oct 2023 07:14:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2aILnhqixBNcNVNeBm0z/LBexH2dJ9/e2srt+6eIErcEXLvOaCG43iBBOkp/KJnhIZQ53Q3DZhvKlvsGLv0M=
X-Received: by 2002:a05:6102:3d8c:b0:457:a915:5e85 with SMTP id
 h12-20020a0561023d8c00b00457a9155e85mr12840811vsv.28.1698761685982; Tue, 31
 Oct 2023 07:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231027204933.3651381-1-seanjc@google.com> <20231027204933.3651381-3-seanjc@google.com>
In-Reply-To: <20231027204933.3651381-3-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 31 Oct 2023 15:14:34 +0100
Message-ID: <CABgObfY8Mr29fQwWfLE4fhDUnUnYw8_wQ1UGcBq9i86PncSE=g@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Documentation updates for 6.7
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 10:49=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> Doc updates for 6.7.  The bulk is a cleanup of the kvm_mmu_page docs, whi=
ch are
> sadly already stale because I neglected to update the docs when removing =
the
> TDP MMU's async root zapping :-(
>
> The following changes since commit 5804c19b80bf625c6a9925317f845e497434d6=
d3:
>
>   Merge tag 'kvm-riscv-fixes-6.6-1' of https://github.com/kvm-riscv/linux=
 into HEAD (2023-09-23 05:35:55 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-docs-6.7

Pulled, thanks.

Paolo

> for you to fetch changes up to b35babd3abea081de0611ce0d5b85281c18c52c7:
>
>   KVM: x86/pmu: Add documentation for fixed ctr on PMU filter (2023-09-27=
 14:23:51 -0700)
>
> ----------------------------------------------------------------
> KVM x86 Documentation updates for 6.7:
>
>  - Fix various typos, notably a confusing reference to the non-existent
>    "struct kvm_vcpu_event" (the actual structure is kvm_vcpu_events, plur=
al).
>
>  - Update x86's kvm_mmu_page documentation to bring it closer to the code
>    (this raced with the removal of async zapping and so the documentation=
 is
>    already stale; my bad).
>
>  - Document the behavior of x86 PMU filters on fixed counters.
>
> ----------------------------------------------------------------
> Jinrong Liang (1):
>       KVM: x86/pmu: Add documentation for fixed ctr on PMU filter
>
> Michal Luczaj (1):
>       KVM: Correct kvm_vcpu_event(s) typo in KVM API documentation
>
> Mingwei Zhang (6):
>       KVM: Documentation: Add the missing description for guest_mode in k=
vm_mmu_page_role
>       KVM: Documentation: Update the field name gfns and its description =
in kvm_mmu_page
>       KVM: Documentation: Add the missing description for ptep in kvm_mmu=
_page
>       KVM: Documentation: Add the missing description for tdp_mmu_root_co=
unt into kvm_mmu_page
>       KVM: Documentation: Add the missing description for mmu_valid_gen i=
nto kvm_mmu_page
>       KVM: Documentation: Add the missing description for tdp_mmu_page in=
to kvm_mmu_page
>
>  Documentation/virt/kvm/api.rst     | 36 +++++++++++++++++++++++--------
>  Documentation/virt/kvm/x86/mmu.rst | 43 ++++++++++++++++++++++++++++++--=
------
>  2 files changed, 61 insertions(+), 18 deletions(-)
>

