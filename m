Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1877B2857
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 00:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjI1WXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 18:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjI1WXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 18:23:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8958B1A7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 15:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695939695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=29G1BYuCds6xnt+aRDjOqp1d8b71T59JlT2+VGIavIo=;
        b=VtHY83YRmhVYJfigUO/Yw+X1+yesbEsa0dwl24ZDIXq1DsTC1r+YwG55pkVg3DMidjRfmz
        D5Sp9w8xrnvNE5k3e4weDjb1IBMuLqDW8NUcD7xioX9yZZbqG6eHTbUuf1idEUG/OucnV9
        xedNY8w3vacX6rbuLmvbSenXH2hfCkQ=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-K98TteVbNe2gfRXtkj9Zig-1; Thu, 28 Sep 2023 18:21:34 -0400
X-MC-Unique: K98TteVbNe2gfRXtkj9Zig-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-79f9edb0086so1530956439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 15:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695939693; x=1696544493;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=29G1BYuCds6xnt+aRDjOqp1d8b71T59JlT2+VGIavIo=;
        b=m2VbRJ+c7m5zzOqRXLAMBPZb/DeN5JNx+Sdo0o8k7Ym+LKcPakaFEVoBAFOveB7KDC
         Spe6IdKuZ4ZUCzjdNEDczc8F5t2dSFXZe6uGyme0JPR6ZFZ9WxYzTtev/c0HvUiG+Fn0
         +ET54caEcswLM6Mu4Q1x/VN79TnoPfJJPDbMdWjLSqgNRDergrlI5orekkwz7hFckl4r
         wv9ijvNoAsoyc/cwJ0WoXT/ZKOwk22ySxsh7X24qdcloJ0yBGFd17HiJBRBptpCZupQV
         vuZghF8Nodw8NXfxXnAe5vWuzPBGtRKtXtXnKREgHboLEo8OBvSZRz/VguX/fhxebbia
         M8dw==
X-Gm-Message-State: AOJu0YwMuPD45wGT1iHhGc+1ugFCYEkgh7QSYGvgM8gNHcWOUROOxOmh
        EaVgcSFTVIZTxZk5gVshNWPe9HiGDpViRS0VZYlREtMRJsKNVxvXcOc/0rcONgSxig3/l1V/7/c
        q0nkJsO8URA4+W1t6o6yvBp7i
X-Received: by 2002:a5e:a907:0:b0:790:ab53:ed16 with SMTP id c7-20020a5ea907000000b00790ab53ed16mr2491914iod.21.1695939693566;
        Thu, 28 Sep 2023 15:21:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM9rzDoRunyOXP5133v1Lo+cjXO3E6zwL+8+g1e4+R6wKyGcuEKXEoPgEET4hcDTu/MP0tQg==
X-Received: by 2002:a5e:a907:0:b0:790:ab53:ed16 with SMTP id c7-20020a5ea907000000b00790ab53ed16mr2491880iod.21.1695939693228;
        Thu, 28 Sep 2023 15:21:33 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id t23-20020a02c497000000b0042b10d42c90sm4610172jam.113.2023.09.28.15.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 15:21:31 -0700 (PDT)
Date:   Thu, 28 Sep 2023 16:21:11 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Anish Ghulati <aghulati@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>,
        Andrew Thornton <andrewth@google.com>
Subject: Re: [PATCH 06/26] KVM: Drop CONFIG_KVM_VFIO and just look at
 KVM+VFIO
Message-ID: <20230928162111.09820688.alex.williamson@redhat.com>
In-Reply-To: <20230916003118.2540661-7-seanjc@google.com>
References: <20230916003118.2540661-1-seanjc@google.com>
        <20230916003118.2540661-7-seanjc@google.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023 17:30:58 -0700
Sean Christopherson <seanjc@google.com> wrote:

> Drop KVM's KVM_VFIO Kconfig, and instead compile in VFIO support if
> and only if VFIO itself is enabled.  Similar to the recent change to have
> VFIO stop looking at HAVE_KVM, compiling in support for talking to VFIO
> just because the architecture supports VFIO is nonsensical.
> 
> This fixes a bug where RISC-V doesn't select KVM_VFIO, i.e. would silently
> fail to do connect KVM and VFIO, even though RISC-V supports VFIO.  The
> bug is benign as the only driver in all of Linux that actually uses the
> KVM reference provided by VFIO is KVM-GT, which is x86/Intel specific.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/arm64/kvm/Kconfig   | 1 -
>  arch/powerpc/kvm/Kconfig | 1 -
>  arch/s390/kvm/Kconfig    | 1 -
>  arch/x86/kvm/Kconfig     | 1 -
>  virt/kvm/Kconfig         | 3 ---
>  virt/kvm/Makefile.kvm    | 4 +++-
>  virt/kvm/vfio.h          | 2 +-
>  7 files changed, 4 insertions(+), 9 deletions(-)


Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index 83c1e09be42e..2b5c332f157d 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -28,7 +28,6 @@ menuconfig KVM
>  	select KVM_MMIO
>  	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
>  	select KVM_XFER_TO_GUEST_WORK
> -	select KVM_VFIO
>  	select HAVE_KVM_EVENTFD
>  	select HAVE_KVM_IRQFD
>  	select HAVE_KVM_DIRTY_RING_ACQ_REL
> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> index 902611954200..c4beb49c0eb2 100644
> --- a/arch/powerpc/kvm/Kconfig
> +++ b/arch/powerpc/kvm/Kconfig
> @@ -22,7 +22,6 @@ config KVM
>  	select PREEMPT_NOTIFIERS
>  	select HAVE_KVM_EVENTFD
>  	select HAVE_KVM_VCPU_ASYNC_IOCTL
> -	select KVM_VFIO
>  	select IRQ_BYPASS_MANAGER
>  	select HAVE_KVM_IRQ_BYPASS
>  	select INTERVAL_TREE
> diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
> index 45fdf2a9b2e3..459d536116a6 100644
> --- a/arch/s390/kvm/Kconfig
> +++ b/arch/s390/kvm/Kconfig
> @@ -31,7 +31,6 @@ config KVM
>  	select HAVE_KVM_IRQ_ROUTING
>  	select HAVE_KVM_INVALID_WAKEUPS
>  	select HAVE_KVM_NO_POLL
> -	select KVM_VFIO
>  	select INTERVAL_TREE
>  	select MMU_NOTIFIER
>  	help
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index ed90f148140d..0f01e5600b5f 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -45,7 +45,6 @@ config KVM
>  	select HAVE_KVM_NO_POLL
>  	select KVM_XFER_TO_GUEST_WORK
>  	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
> -	select KVM_VFIO
>  	select INTERVAL_TREE
>  	select HAVE_KVM_PM_NOTIFIER if PM
>  	select KVM_GENERIC_HARDWARE_ENABLING
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 484d0873061c..f0be3b55cea6 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -59,9 +59,6 @@ config HAVE_KVM_MSI
>  config HAVE_KVM_CPU_RELAX_INTERCEPT
>         bool
>  
> -config KVM_VFIO
> -       bool
> -
>  config HAVE_KVM_INVALID_WAKEUPS
>         bool
>  
> diff --git a/virt/kvm/Makefile.kvm b/virt/kvm/Makefile.kvm
> index 2c27d5d0c367..29373b59d89a 100644
> --- a/virt/kvm/Makefile.kvm
> +++ b/virt/kvm/Makefile.kvm
> @@ -6,7 +6,9 @@
>  KVM ?= ../../../virt/kvm
>  
>  kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
> -kvm-$(CONFIG_KVM_VFIO) += $(KVM)/vfio.o
> +ifdef CONFIG_VFIO
> +kvm-y += $(KVM)/vfio.o
> +endif
>  kvm-$(CONFIG_KVM_MMIO) += $(KVM)/coalesced_mmio.o
>  kvm-$(CONFIG_KVM_ASYNC_PF) += $(KVM)/async_pf.o
>  kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
> diff --git a/virt/kvm/vfio.h b/virt/kvm/vfio.h
> index e130a4a03530..af475a323965 100644
> --- a/virt/kvm/vfio.h
> +++ b/virt/kvm/vfio.h
> @@ -2,7 +2,7 @@
>  #ifndef __KVM_VFIO_H
>  #define __KVM_VFIO_H
>  
> -#ifdef CONFIG_KVM_VFIO
> +#if IS_ENABLED(CONFIG_KVM) && IS_ENABLED(CONFIG_VFIO)
>  int kvm_vfio_ops_init(void);
>  void kvm_vfio_ops_exit(void);
>  #else

