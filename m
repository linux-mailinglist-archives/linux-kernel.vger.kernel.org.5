Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6940E75CB31
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjGUPO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjGUPOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:14:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7EC30DF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689952377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KuECWgmrt4c8ZTlDSWFvVOJXkvdaI59iER7noO41RWI=;
        b=EvkoIsl1Ald/n0VtWGIJbPb/A4z3GOpRj0Fhdz3yIaJA9+IuTR5LFPxCvPVCsM/PPQhaFn
        qzg5hwNlD9wRgSbxTD2TWcJDQZR8wW/OAEghdUsxebgITTS5FZ+r49v9XHkPvQUSvVRIbm
        nP7MgLrNUnZr075+tH0CO8K6Rm76QwU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-FO_L-YZ3O0iUTUSR0_F3FA-1; Fri, 21 Jul 2023 11:12:55 -0400
X-MC-Unique: FO_L-YZ3O0iUTUSR0_F3FA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fb76659cacso2086760e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689952374; x=1690557174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KuECWgmrt4c8ZTlDSWFvVOJXkvdaI59iER7noO41RWI=;
        b=bHupUrJ0yK58G0sn5rnvuteVm9g7AWlUbuZ4yAvyg2aOUqGx1c7i0HuCKaQCjg+Y3U
         gbdm6JNMvYUifXlLwZuxNijPGDpZSCu44UsEWfKY5uCpS9kDUtijbqZuPwfNvNL8yPMY
         KWRaWkw/Nq6H6itQ6NUCZIzLZSkWwDygwmfULLrVD6mzyFSxEs801edeHLdVeqWi4u15
         NRMDpggwKq1r3tGTG/kCNolwyiVGJRYGK1mhycorxoFfR9Rj50qkNC6Wa91E/7SwLoWZ
         9VLmDN+9GH0XHgXGH4B+4lu0KbWd6smnSbIFh7/ZLJfwSGK5AtjNhimqxBlrIzf0bV6G
         NaEA==
X-Gm-Message-State: ABy/qLY50u0CnTNTDDV/thV3MjmcuOxclQzDjUSZ6bM+GcZQv3yi8vmg
        Pm718LG8nUP3tOLEdbu7EX5sEUthUQOY0lmEeF3CUZqDtiohn0S5ha9tX2vzaV8PqUC9IUrhV8P
        TOps1heRYbDRx60F6d17XjSy+
X-Received: by 2002:a19:e05b:0:b0:4fb:caed:95c3 with SMTP id g27-20020a19e05b000000b004fbcaed95c3mr1377435lfj.53.1689952374304;
        Fri, 21 Jul 2023 08:12:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG7b5XRxViP22WEsYjZVx9eEuQn7vFDvQWd5jPtrRlHnUDSnFTiFx5UF3BQ2XwQWfw7l/MGag==
X-Received: by 2002:a19:e05b:0:b0:4fb:caed:95c3 with SMTP id g27-20020a19e05b000000b004fbcaed95c3mr1377407lfj.53.1689952373968;
        Fri, 21 Jul 2023 08:12:53 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id n1-20020a05640204c100b0051e0f21c43fsm2214094edw.31.2023.07.21.08.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 08:12:53 -0700 (PDT)
Message-ID: <6519e3f4-7cea-01a6-724e-a0bce10c3c19@redhat.com>
Date:   Fri, 21 Jul 2023 17:12:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v11 16/29] KVM: Allow arch code to track number of
 memslot address spaces per VM
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
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
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20230718234512.1690985-1-seanjc@google.com>
 <20230718234512.1690985-17-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230718234512.1690985-17-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 01:44, Sean Christopherson wrote:
> @@ -4725,9 +4725,9 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>   	case KVM_CAP_IRQ_ROUTING:
>   		return KVM_MAX_IRQ_ROUTES;
>   #endif
> -#if KVM_ADDRESS_SPACE_NUM > 1
> +#if KVM_MAX_NR_ADDRESS_SPACES > 1
>   	case KVM_CAP_MULTI_ADDRESS_SPACE:
> -		return KVM_ADDRESS_SPACE_NUM;
> +		return KVM_MAX_NR_ADDRESS_SPACES;
>   #endif

Since this is a VM ioctl, it should return 
kvm_arch_nr_memslot_as_ids(kvm) if kvm != NULL.

Paolo

