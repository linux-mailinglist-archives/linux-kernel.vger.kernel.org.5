Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C577B285E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 00:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjI1WXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 18:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjI1WXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 18:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8D71B6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 15:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695939698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rT9am+jLmHorOzbZRxZ3QKMwJmosafd47BiiQuOc1Lw=;
        b=hgUc8sqzTnH/mSPVzvy2P9DhDFskybZw1lsg/2CppeFl09UTTaihCUCRxhbXbblrHvT39s
        TQhsGaKcBU8HIMWzo62Pl/jeDqE2z7BVP2UU20AdFmc/C+aPuDJ49OhQ1W4/JY3ArTAWd3
        dhXsKeZ61tTjhbZ/DUQX0TWmwY3U4QI=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-RZTRWL0TOjCVpsuhY4fdHg-1; Thu, 28 Sep 2023 18:21:37 -0400
X-MC-Unique: RZTRWL0TOjCVpsuhY4fdHg-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7a25e4045c2so83766139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 15:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695939696; x=1696544496;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rT9am+jLmHorOzbZRxZ3QKMwJmosafd47BiiQuOc1Lw=;
        b=G4X+/PjrnAvSnTlGIzyqkqY/U5dHuVlOgMpOTywYckKzo9Paj/156HpOLDqG/V7YkB
         nzsOxdjVuUMigejPxGnAsfS/HWLg7t6LMPRXYStNeaIAILuudi/PVCqKu73cnFs4nMRM
         MlMIyq500YNDoG4aGXKiQHZEaEvU2ksAm0/37ESYeEPt840A5gV1oPh/AeN6B8ZhvRyv
         UFR6aWtbMg1Cyem/7Zzb8wLzyyyFrMBLImZ4GOu35vc21xosi3R9qK7Siz0YgdfLBfYs
         cehDYWlwULi16TiEgrJmda5n4APQAfJDrOBIKsNM9CoxrVSriZlTkyho3oVABgkwHHra
         cELw==
X-Gm-Message-State: AOJu0Yyo9jnt/5F5lKrkMs2U3QSXWbap4KHwgRKzd5wUBUNTOiY8DduG
        w+6Ne7ucj+yPYi1QaQXImbnpEqF0NOZzHirzXJXTgZiMBJRKS1IC0Le+6dVOF7+JvCPkbu6Ind9
        K2+DSo7ZEGqy/Uy2M3H20390x
X-Received: by 2002:a6b:a12:0:b0:792:792e:6619 with SMTP id z18-20020a6b0a12000000b00792792e6619mr2823006ioi.2.1695939696197;
        Thu, 28 Sep 2023 15:21:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvHyy/Hemz69W4ceT0BNd5Cdmv5i7C45WBCarFFElXolFsYoe8vV4yGo1CGx8WsH3XpWDdNw==
X-Received: by 2002:a6b:a12:0:b0:792:792e:6619 with SMTP id z18-20020a6b0a12000000b00792792e6619mr2822961ioi.2.1695939695939;
        Thu, 28 Sep 2023 15:21:35 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id t23-20020a02c497000000b0042b10d42c90sm4610172jam.113.2023.09.28.15.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 15:21:34 -0700 (PDT)
Date:   Thu, 28 Sep 2023 16:21:03 -0600
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
Subject: Re: [PATCH 01/26] vfio: Wrap KVM helpers with CONFIG_KVM instead of
 CONFIG_HAVE_KVM
Message-ID: <20230928162103.433f03db.alex.williamson@redhat.com>
In-Reply-To: <20230916003118.2540661-2-seanjc@google.com>
References: <20230916003118.2540661-1-seanjc@google.com>
        <20230916003118.2540661-2-seanjc@google.com>
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

On Fri, 15 Sep 2023 17:30:53 -0700
Sean Christopherson <seanjc@google.com> wrote:

> Wrap the helpers for getting references to KVM instances with a check on
> CONFIG_KVM being enabled, not on CONFIG_HAVE_KVM being defined.  PPC does
> NOT select HAVE_KVM, despite obviously supporting KVM, and guarding code
> to get references to KVM based on whether or not the architecture supports
> KVM is nonsensical.
> 
> Drop the guard around linux/kvm_host.h entirely, conditionally including a
> generic headers is completely unnecessary.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  drivers/vfio/vfio.h      | 2 +-
>  drivers/vfio/vfio_main.c | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)


Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 307e3f29b527..c26d1ad68105 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -434,7 +434,7 @@ static inline void vfio_virqfd_exit(void)
>  }
>  #endif
>  
> -#ifdef CONFIG_HAVE_KVM
> +#if IS_ENABLED(CONFIG_KVM)
>  void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm);
>  void vfio_device_put_kvm(struct vfio_device *device);
>  #else
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 40732e8ed4c6..80e39f7a6d8f 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -16,9 +16,7 @@
>  #include <linux/fs.h>
>  #include <linux/idr.h>
>  #include <linux/iommu.h>
> -#ifdef CONFIG_HAVE_KVM
>  #include <linux/kvm_host.h>
> -#endif
>  #include <linux/list.h>
>  #include <linux/miscdevice.h>
>  #include <linux/module.h>
> @@ -383,7 +381,7 @@ void vfio_unregister_group_dev(struct vfio_device *device)
>  }
>  EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
>  
> -#ifdef CONFIG_HAVE_KVM
> +#if IS_ENABLED(CONFIG_KVM)
>  void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm)
>  {
>  	void (*pfn)(struct kvm *kvm);

