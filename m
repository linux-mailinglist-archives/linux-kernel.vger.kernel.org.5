Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1014E7DCF01
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344085AbjJaOXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjJaOXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:23:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047D3BD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698762145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xTQ9peqnSDJoBFuGuy2zfzNkYJ1d26aC7/ftaOk3pZs=;
        b=YSaCKtM1W4teK2AXT16AcJ0/tXumWTVfPHZTLrhhxsC75h2XqEP4+Xzy79EWSW0nWdoW+H
        nswl9DWXZzQ+M52eE9GYFAq5hygwenOXkXQtoPfqacSN2jBHwJHqS1WQTavBBLP3UHLYBW
        c9bCx2xpATi7DfbgF901eDW/pLA8Hec=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-W1F7JidbMIOrSpXk7Kafmw-1; Tue, 31 Oct 2023 10:22:12 -0400
X-MC-Unique: W1F7JidbMIOrSpXk7Kafmw-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-457cd8cf484so2156988137.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698762132; x=1699366932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTQ9peqnSDJoBFuGuy2zfzNkYJ1d26aC7/ftaOk3pZs=;
        b=gHi1nKGpN1bJPe6qbf7hIS7FRG57d8/I1IJrHxSPhZYwCWkcD/hOgbDnzNRExpHlDi
         ranwukRx6TaGdOEGPk4D1tlWphUhYe4Si+r5T1JbI4l6ZZCt9go4or0Rrh0pKMxCo0Um
         Osq67Z3WqSJBi6irRQCQQmZwF94hQ3JBswf2KeT52Kj5Ik32kjjzHjT+CoNyeehvTgXi
         FDW2egMEi1K7KRyGgWCcLo5fV0/pTLRlGAYRXShx2Dc2wtXelLDziVMlEUylIxsdQczN
         l11fCYCTMx3qYgm84lHKP36BLpfcgopGvWVeHt3cLso1S7k2/DiNqxhytK9VCtnzradY
         LAVQ==
X-Gm-Message-State: AOJu0YxsD0u9o9fB6OYhmxJynkjcSSxXyIL5tRs1IdM3QSYIsuKsr3Dv
        WS0yvPelJVuLOOjoyjVw7tIvBQEVBBDWOilHACjnpMDpNe4FkWGYmurAFzH+I5p9/Wv5zl/79On
        BTyemImocT87nSM2cpds2RPklIAjho7O962dsEvpD
X-Received: by 2002:a67:e08b:0:b0:457:bbd5:23fd with SMTP id f11-20020a67e08b000000b00457bbd523fdmr11490500vsl.9.1698762132335;
        Tue, 31 Oct 2023 07:22:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX1VOGY6Vv0/6Cc+cQHaz240fhBPnWaKTAJjlxBn/ZofHFAxyJMKJ0y2qNcZbeqg1kqPA40cyHEWFvomJiS5Q=
X-Received: by 2002:a67:e08b:0:b0:457:bbd5:23fd with SMTP id
 f11-20020a67e08b000000b00457bbd523fdmr11490495vsl.9.1698762132102; Tue, 31
 Oct 2023 07:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231027204933.3651381-1-seanjc@google.com> <20231027204933.3651381-8-seanjc@google.com>
In-Reply-To: <20231027204933.3651381-8-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 31 Oct 2023 15:22:00 +0100
Message-ID: <CABgObfYewNZd-X4KWeRiFw5M+dj_-b4WPG+Gs-2GRpAsTHnA9w@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Xen changes for 6.7
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
> Read the tag, I couldn't figure out how to summarize this one without sim=
ply
> regurgitating the tag :-)
>
> The following changes since commit 5804c19b80bf625c6a9925317f845e497434d6=
d3:
>
>   Merge tag 'kvm-riscv-fixes-6.6-1' of https://github.com/kvm-riscv/linux=
 into HEAD (2023-09-23 05:35:55 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-xen-6.7
>
> for you to fetch changes up to 409f2e92a27a210fc768c5569851b4a419e6a232:
>
>   KVM: x86/xen: ignore the VCPU_SSHOTTMR_future flag (2023-10-04 15:22:58=
 -0700)

Pulled, thanks.

Paolo

>
> ----------------------------------------------------------------
> KVM x86 Xen changes for 6.7:
>
>  - Omit "struct kvm_vcpu_xen" entirely when CONFIG_KVM_XEN=3Dn.
>
>  - Use the fast path directly from the timer callback when delivering Xen=
 timer
>    events.  Avoid the problematic races with using the fast path by ensur=
ing
>    the hrtimer isn't running when (re)starting the timer or saving the ti=
mer
>    information (for userspace).
>
>  - Follow the lead of upstream Xen and ignore the VCPU_SSHOTTMR_future fl=
ag.
>
> ----------------------------------------------------------------
> David Woodhouse (1):
>       KVM: x86/xen: Use fast path for Xen timer delivery
>
> Paul Durrant (1):
>       KVM: x86/xen: ignore the VCPU_SSHOTTMR_future flag
>
> Peng Hao (1):
>       KVM: X86: Reduce size of kvm_vcpu_arch structure when CONFIG_KVM_XE=
N=3Dn
>
>  arch/x86/include/asm/kvm_host.h |  5 +++-
>  arch/x86/kvm/cpuid.c            |  2 ++
>  arch/x86/kvm/x86.c              |  2 ++
>  arch/x86/kvm/xen.c              | 55 +++++++++++++++++++++++++++++++++++=
++----
>  4 files changed, 58 insertions(+), 6 deletions(-)
>

