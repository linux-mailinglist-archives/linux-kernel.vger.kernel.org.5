Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCC17751DA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 06:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjHIERS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 00:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjHIERQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 00:17:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCCD19A1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 21:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691554589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jc2RrwZUDP/ZLfqGAQFdphKEXcWYocBgrdrh4msM7SQ=;
        b=K9eNG+CYTd5SuigFYgwGKVHV8Uwl061ui1TGhszVDnfmDlOqDK+BOII1662i4UA7LfakG8
        C/sPoW6ud7PzyDhEcvwjKwrHBo+nc8/VbvnsDWuGmBCnPoDcrJ5urZJwEBB+eIiAkkQtjp
        HGa7tG5W+4dUoUbIdpd5OTDGR0f+nKI=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-4nHNnDFjPaSDQ8aHdl16Ww-1; Wed, 09 Aug 2023 00:16:27 -0400
X-MC-Unique: 4nHNnDFjPaSDQ8aHdl16Ww-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5635233876bso4530351a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 21:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691554283; x=1692159083;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jc2RrwZUDP/ZLfqGAQFdphKEXcWYocBgrdrh4msM7SQ=;
        b=QWw9/21XxDAWuY0zxGsawcn0vV48sPhUlVO85zjCYgZgToCrhC7Oj1TB25b45MA7Ap
         xvtLM+LlMM8HDhwSpktIo6F/RHfupF6G8+t+VWFWs356xsDezeNLrk33x8NjkNxTorLt
         Kz9CckOfFHF7/8jd8p+vVbjxnhHMeBEztu5MdBd62BEdBQAKDix/jqTlbQKH3QepBa93
         f4Wqfa73cBVgbZxbd/1zwCKRV+IcbtWQcewPjBCKtWgrFFVLuK1bA7VN+GPF/MNL4g0c
         2k/rc7KiPSq6gNFUOp9vQjbfrIbz8OglKLEmYEFwziBB2qMc8INhCNgp89fy9irYFJ8i
         aTaw==
X-Gm-Message-State: AOJu0YxYg4xhUn8kJ5T9GUTiJ4z/5rYdx8wZ7fXTJ1CzygueTUVcfpQ1
        3nNWwcqKkW+vl6dCYJKQMlGsfLKVf7mfyffOElNVGFyG2tCyCf3Bzc7j473Q+Z+zPTJKqgSfVp5
        9VOdDkEr26l82Viiw0poMnPbt
X-Received: by 2002:a05:6a21:328b:b0:121:ca90:df01 with SMTP id yt11-20020a056a21328b00b00121ca90df01mr1394030pzb.40.1691554282928;
        Tue, 08 Aug 2023 21:11:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuTcKraAGNvme4rsh9nauIBvvaQvIf9BEXJr92oZnpUAljzMU4HrA4zieEd0juLoJJfRohRg==
X-Received: by 2002:a05:6a21:328b:b0:121:ca90:df01 with SMTP id yt11-20020a056a21328b00b00121ca90df01mr1394005pzb.40.1691554282647;
        Tue, 08 Aug 2023 21:11:22 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090322c900b001b2069072ccsm9850474plg.18.2023.08.08.21.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 21:11:22 -0700 (PDT)
Message-ID: <79b8548e-715a-85ee-aad6-cb0b97753df6@redhat.com>
Date:   Wed, 9 Aug 2023 14:11:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v8 04/14] KVM: Remove CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL
Content-Language: en-US
To:     Raghavendra Rao Ananta <rananta@google.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Jing Zhang <jingzhangos@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Fuad Tabba <tabba@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Shaoqin Huang <shahuang@redhat.com>
References: <20230808231330.3855936-1-rananta@google.com>
 <20230808231330.3855936-5-rananta@google.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230808231330.3855936-5-rananta@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/9/23 09:13, Raghavendra Rao Ananta wrote:
> kvm_arch_flush_remote_tlbs() or CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL
> are two mechanisms to solve the same problem, allowing
> architecture-specific code to provide a non-IPI implementation of
> remote TLB flushing.
> 
> Dropping CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL allows KVM to standardize
> all architectures on kvm_arch_flush_remote_tlbs() instead of
> maintaining two mechanisms.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>   virt/kvm/Kconfig    | 3 ---
>   virt/kvm/kvm_main.c | 2 --
>   2 files changed, 5 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index b74916de5183a..484d0873061ca 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -62,9 +62,6 @@ config HAVE_KVM_CPU_RELAX_INTERCEPT
>   config KVM_VFIO
>          bool
>   
> -config HAVE_KVM_ARCH_TLB_FLUSH_ALL
> -       bool
> -
>   config HAVE_KVM_INVALID_WAKEUPS
>          bool
>   
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 70e5479797ac3..d6b0507861550 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -345,7 +345,6 @@ bool kvm_make_all_cpus_request(struct kvm *kvm, unsigned int req)
>   }
>   EXPORT_SYMBOL_GPL(kvm_make_all_cpus_request);
>   
> -#ifndef CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL
>   void kvm_flush_remote_tlbs(struct kvm *kvm)
>   {
>   	++kvm->stat.generic.remote_tlb_flush_requests;
> @@ -366,7 +365,6 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
>   		++kvm->stat.generic.remote_tlb_flush;
>   }
>   EXPORT_SYMBOL_GPL(kvm_flush_remote_tlbs);
> -#endif
>   
>   static void kvm_flush_shadow_all(struct kvm *kvm)
>   {

