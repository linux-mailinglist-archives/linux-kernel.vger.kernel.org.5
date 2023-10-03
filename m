Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C867B695E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjJCMsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjJCMsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:48:05 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A820B8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 05:48:01 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-774105e8c37so65301385a.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 05:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696337280; x=1696942080; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YZe9z/CDJkweGhxZy3F+7e7AP42NZQg1sBDsRc6xWLw=;
        b=PeRLYOLioqfPAPyhLsjGm3+fHcCyHikDzkDViI+Rdq+SbLRi/yze7XyjZc95a9uN77
         YN1HbMAWxHWMPoaRL/GFvagOUIEwUEnzRv4S5RQz58PqcXShypPksshtOxnOrvWvg7Hm
         CGTEyB8jpw0NY7dr73p/avmPyGHDFZUYbkEpedVaCnjjHCEDBx1eFwQ8e2sY0mdjwo7F
         79Yurn8rvgb5bJ3PKQZcoxXinziOy/LH57awDKyc+1b8frx7JawX1I+o69MF7b2wMnMq
         nGeYnpY2hu3JsSONOtmhe1lfZjsgb2r6R3LQrwLjUxC0GR1RutNB+cpWLdbYmGVE+al0
         A0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696337280; x=1696942080;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YZe9z/CDJkweGhxZy3F+7e7AP42NZQg1sBDsRc6xWLw=;
        b=LSLuAq1V5d7cyL83FR7hY7VGdBszgibrlcwb2qs+AEQM1oYsSQ7sv57cEwklxFdFQ2
         1oiFcBz7dAp2iZfgBdRvylnlY7jCOzm/t8bU94gaePQSsmNDlsKu+m9aRcmVevmMsnVF
         MmYvKbqLc0H4nd1ZC4iMW2v0JdgSZn3fosCnmQfMsoidFSDcf9XkXGFC05/l/aJ2XL+j
         OQpDraaRNJzJV/TxEobjCDOJUOy5EwIXB/sIuvdfskUw59Lzmp2MyIl+rGu38b6pOgSR
         bLcf+rOv3Ul/YFUz5LHKt86DBgvOATSjQT3ulSPBq6ZHnQ84Ov21/lHC8yhn+bkm2gxM
         QVKw==
X-Gm-Message-State: AOJu0Yx7xrwkN3lPqvGm0JkVZGzUYt3xi3IKMbibBcGiwDL4cn4CoFxt
        YC/f48o3a3fuP0+otwHnY1EMZkinCm3KDbMHaR11NQ==
X-Google-Smtp-Source: AGHT+IGdg5KfMiaxwpI9vdrZwCI62gGbA1qcJqHvAfDGqDxEQ2JSHryTMBO/72MMo9L0zK8WyPrlSIxRkNMNwCJdjzY=
X-Received: by 2002:a0c:e493:0:b0:656:347b:ea75 with SMTP id
 n19-20020a0ce493000000b00656347bea75mr13564335qvl.24.1696337280208; Tue, 03
 Oct 2023 05:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com> <20230914015531.1419405-12-seanjc@google.com>
In-Reply-To: <20230914015531.1419405-12-seanjc@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 3 Oct 2023 13:47:23 +0100
Message-ID: <CA+EHjTzSUXx8P9gWmUERg4owxH6r6yNPm1_RL-BzS_2CNPtRKw@mail.gmail.com>
Subject: Re: [RFC PATCH v12 11/33] KVM: Introduce per-page memory attributes
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index d2d913acf0df..f8642ff2eb9d 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1227,6 +1227,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE 228
>  #define KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES 229
>  #define KVM_CAP_USER_MEMORY2 230
> +#define KVM_CAP_MEMORY_ATTRIBUTES 231
>
>  #ifdef KVM_CAP_IRQ_ROUTING
>
> @@ -2293,4 +2294,17 @@ struct kvm_s390_zpci_op {
>  /* flags for kvm_s390_zpci_op->u.reg_aen.flags */
>  #define KVM_S390_ZPCIOP_REGAEN_HOST    (1 << 0)
>
> +/* Available with KVM_CAP_MEMORY_ATTRIBUTES */
> +#define KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES    _IOR(KVMIO,  0xd2, __u64)
> +#define KVM_SET_MEMORY_ATTRIBUTES              _IOW(KVMIO,  0xd3, struct kvm_memory_attributes)
> +
> +struct kvm_memory_attributes {
> +       __u64 address;
> +       __u64 size;
> +       __u64 attributes;
> +       __u64 flags;
> +};
> +
> +#define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> +

In pKVM, we don't want to allow setting (or clearing) of
PRIVATE/SHARED attributes from userspace. However, we'd like to use
the attributes xarray to track the sharing state of guest pages at the
host kernel.

Moreover, we'd rather the default guest page state be PRIVATE, and
only specify which pages are shared. All pKVM guest pages start off as
private, and the majority will remain so.

I'm not sure if this is the best way to do this: One idea would be to
move the definition of KVM_MEMORY_ATTRIBUTE_PRIVATE to
arch/*/include/asm/kvm_host.h, which is where
kvm_arch_supported_attributes() lives as well. This would allow
different architectures to specify their own attributes (i.e., instead
we'd have a KVM_MEMORY_ATTRIBUTE_SHARED for pKVM). This wouldn't help
in terms of preventing userspace from clearing attributes (i.e.,
setting a 0 attribute) though.

The other thing, which we need for pKVM anyway, is to make
kvm_vm_set_mem_attributes() global, so that it can be called from
outside of kvm_main.c (already have a local patch for this that
declares it in kvm_host.h), and not gate this function by
KVM_GENERIC_MEMORY_ATTRIBUTES. This would let pKVM select only
KVM_PRIVATE_MEM (as opposed to KVM_GENERIC_PRIVATE_MEM, which selects
KVM_GENERIC_MEMORY_ATTRIBUTES), preventing userspace from setting
these attributes, while allowing pKVM to call
kvm_vm_set_mem_attributes().

What do you think?

Thanks,
/fuad
