Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7E17DCF2A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbjJaOQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbjJaOQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2467B11B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698761715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zUGnQiCF/6Ik0AtOZ0SWI2X75euizpW/yno5GZDuOec=;
        b=C+7yUcfB6cSz4rk0M8dclTAJrC/w8y+oPYbVFlJ24574hQgILn0ZEEXsIcRLVTwsJ3O5LO
        ysGP5Sp/eth3xtEjJwKt/2M22+qe7OtXNib8DR7YBNhIdAcrwnVvhEUYOOG7Kpeh422cHd
        JAc28/bQJ/hw69Oom3GwKVLWWnTUJEE=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-jbpqL53rNBaN8VkSKcn27Q-1; Tue, 31 Oct 2023 10:15:13 -0400
X-MC-Unique: jbpqL53rNBaN8VkSKcn27Q-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-457c4ea7f18so2340676137.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698761712; x=1699366512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUGnQiCF/6Ik0AtOZ0SWI2X75euizpW/yno5GZDuOec=;
        b=GRhg39cv+VEmy+8mCldgPwGYyY/ma/csHNj06yfoV62Q9tNCMj4k4EPGtlgISDbeHQ
         ZY06tPk1vQKx4glVR9OBYRq/bpIsWeAzriP2o3TrC37nDG/M4okDHC/3MyQGJ9sb++ys
         yudOH2tFK+ZRO/2bpF/ldyRQBNyWSY1VDEivN2dtQovmhlGKFOY2jnSw9GizfzgUp6HF
         c103baQ4BeFBp3t8TnN4K9wMCpytx9Nhauh6xcclJo1EHKr2p3L2ngt0nU86f4GGGLCU
         Fmsvp7w60tr6hHuDm0v2crOw9hAERyabe3aHx/AgYUuuZWsqq6EoMWOaodPGvUilnO4v
         Hw9w==
X-Gm-Message-State: AOJu0YyoziDQTqdZTQIWHm1W8MoCFjCRARASK73CYeO9hrYlwI7oQ59V
        curxbwAtHb6lV4t3lFF4jHb7bOnTj4u6Ff88ow85eVtop1ODI4XkHX8jR6OJOCG162D2PqZeU7f
        LMg4iBb+kkN/jx9xZpToMamz5By36HISslyQaZ3Ts
X-Received: by 2002:a67:c89e:0:b0:458:19fc:e1e5 with SMTP id v30-20020a67c89e000000b0045819fce1e5mr12735501vsk.6.1698761711825;
        Tue, 31 Oct 2023 07:15:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzfspbtQPT/PwHpMJ6AmRbIK+Xv0rm0SMcOh4AZ98GXC/seDM6hbA1/X8AnPzKjQfoUtt/DHdK26LXWPMwctU=
X-Received: by 2002:a67:c89e:0:b0:458:19fc:e1e5 with SMTP id
 v30-20020a67c89e000000b0045819fce1e5mr12735480vsk.6.1698761711580; Tue, 31
 Oct 2023 07:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231027204933.3651381-1-seanjc@google.com> <20231027204933.3651381-2-seanjc@google.com>
In-Reply-To: <20231027204933.3651381-2-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 31 Oct 2023 15:15:00 +0100
Message-ID: <CABgObfZEXKOnLaU9pcH8n3VSGgFRYWy00VP4n5szjdK-pBMhqw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: APIC changes for 6.7
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
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
> Two small APIC changes for 6.7, both specific to Intel's APICv.
>
> The following changes since commit 5804c19b80bf625c6a9925317f845e497434d6=
d3:
>
>   Merge tag 'kvm-riscv-fixes-6.6-1' of https://github.com/kvm-riscv/linux=
 into HEAD (2023-09-23 05:35:55 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-apic-6.7
>
> for you to fetch changes up to 629d3698f6958ee6f8131ea324af794f973b12ac:
>
>   KVM: x86: Clear bit12 of ICR after APIC-write VM-exit (2023-09-28 10:42=
:16 -0700)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM x86 APIC changes for 6.7:
>
>  - Purge VMX's posted interrupt descriptor *before* loading APIC state wh=
en
>    handling KVM_SET_LAPIC.  Purging the PID after loading APIC state resu=
lts in
>    lost APIC timer IRQs as the APIC timer can be armed as part of loading=
 APIC
>    state, i.e. can immediately pend an IRQ if the expiry is in the past.
>
>  - Clear the ICR.BUSY bit when handling trap-like x2APIC writes to suppre=
ss a
>    WARN due to KVM expecting the BUSY bit to be cleared when sending IPIs=
.
>
> ----------------------------------------------------------------
> Haitao Shan (1):
>       KVM: x86: Fix lapic timer interrupt lost after loading a snapshot.
>
> Tao Su (1):
>       KVM: x86: Clear bit12 of ICR after APIC-write VM-exit
>
>  arch/x86/include/asm/kvm-x86-ops.h |  1 +
>  arch/x86/include/asm/kvm_host.h    |  1 +
>  arch/x86/kvm/lapic.c               | 30 +++++++++++++++++-------------
>  arch/x86/kvm/vmx/vmx.c             |  4 ++--
>  4 files changed, 21 insertions(+), 15 deletions(-)
>

