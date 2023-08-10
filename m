Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F748777A15
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjHJOEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjHJOEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E14310C7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691676210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nlAONK5WQTaqTvjs/IJt1TfwjeXJy9baGm//on5NsDU=;
        b=gYpdPEi8IyRtHI4zf50oCfUApR9xHuNHErV/+IvaPVrV7GG10TI17INDsKjc57SERw82yR
        P8yHQhcgyiC0EYbcUUcFn3dcvMKfkkWBW1M9Dfuf9uZ/0Yq2kbyiZ2USymUbBB94cvF7+L
        iE8QYteWWsj6XOzKWm9guCR3v1IZUHQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-4qwtULL9MkelmkmfpqBtXQ-1; Thu, 10 Aug 2023 10:03:29 -0400
X-MC-Unique: 4qwtULL9MkelmkmfpqBtXQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe517ca810so5611555e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691676201; x=1692281001;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlAONK5WQTaqTvjs/IJt1TfwjeXJy9baGm//on5NsDU=;
        b=M2R6B9JpemTKo9kEI9OVe7zvDsXByopPcAvtwbO74VxJwfwILpgKYMhgbD+JU4t2Cj
         pQQSSxCWzbsJCzJG2V7Wmtcez1us07qoga0yZfdMR2vzrBVyqQ7B/vn2dwl+zFjt0wNh
         n05TlOOr+/DfLySNz6z9lzUHDXm3qVWhS5T+1oDkMS5nkiv+/yAnI1h54l7EGRxigzJt
         ndRP7AyV/FXaNuzGFNyk3TAG5kXGDghSyuuYzdH7p4IASqNxYn2f1TNeKIfWes9AwmRR
         hp1qif7KMEo3QINpJrZyPMtq5FGqUkg3nYwlG6Gv+lrpxgi/kEsBNc+gmUI2jYSDXgnH
         ia/A==
X-Gm-Message-State: AOJu0Yza+N62jauSXR+HV5xgNqtzof3GiVeO5iuDOXnMJDJICiZ8ynFW
        W7IosvQ59k8CMAQxGOj0P6JezO1qVt2sg254xBFLdwfSQojxTpST82Qx+YR4iGr6gK0HQVCoEJc
        9DFI/v82fspLZc0I0a8i136ry
X-Received: by 2002:a05:600c:4685:b0:3fe:b78:f4b1 with SMTP id p5-20020a05600c468500b003fe0b78f4b1mr1898374wmo.2.1691676201678;
        Thu, 10 Aug 2023 07:03:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwH4c+ibBCE7JaCGWrshMbWFduUcHCjQpgp+Gizgr2r1PQ5mWl8LEmTu1VHsDdW6O4HOwjdg==
X-Received: by 2002:a05:600c:4685:b0:3fe:b78:f4b1 with SMTP id p5-20020a05600c468500b003fe0b78f4b1mr1898337wmo.2.1691676201343;
        Thu, 10 Aug 2023 07:03:21 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id v1-20020adff681000000b00313e2abfb8dsm2279337wrp.92.2023.08.10.07.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 07:03:20 -0700 (PDT)
Message-ID: <d6858d5c-7db6-6e4c-7f07-92ff3340e02b@redhat.com>
Date:   Thu, 10 Aug 2023 16:03:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Ackerley Tng <ackerleytng@google.com>, seanjc@google.com,
        tglx@linutronix.de, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, andrew.jones@linux.dev,
        ricarkol@google.com, chao.p.peng@linux.intel.com, tabba@google.com,
        jarkko@kernel.org, yu.c.zhang@linux.intel.com,
        vannapurve@google.com, erdemaktas@google.com,
        mail@maciej.szmigiero.name, vbabka@suse.cz, david@redhat.com,
        qperret@google.com, michael.roth@amd.com, wei.w.wang@intel.com,
        liam.merwick@oracle.com, isaku.yamahata@gmail.com,
        kirill.shutemov@linux.intel.com
References: <cover.1691446946.git.ackerleytng@google.com>
 <196a2130f155cbc0201cce06579f122352c8b236.1691446946.git.ackerleytng@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 08/11] KVM: x86: Let moving encryption context be
 configurable
In-Reply-To: <196a2130f155cbc0201cce06579f122352c8b236.1691446946.git.ackerleytng@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/23 01:01, Ackerley Tng wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 75d48379d94d..a1a28dd77b94 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6351,7 +6351,14 @@ static int kvm_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
>   	if (r)
>   		goto out_mark_migration_done;
>   
> -	r = static_call(kvm_x86_vm_move_enc_context_from)(kvm, source_kvm);
> +	/*
> +	 * Different types of VMs will allow userspace to define if moving
> +	 * encryption context should be supported.
> +	 */
> +	if (kvm->arch.vm_move_enc_ctxt_supported &&
> +	    kvm_x86_ops.vm_move_enc_context_from) {
> +		r = static_call(kvm_x86_vm_move_enc_context_from)(kvm, source_kvm);
> +	}

Rather than "supported" this is more "required".  So  perhaps 
kvm->arch.use_vm_enc_ctxt_op?

Paolo

