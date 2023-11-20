Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1037F124C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjKTLl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjKTLl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:41:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B9C9C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700480483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XroWRvXs+Y4iSNm22W3/JdNTVL8TEZs8UV4UrMaRAU8=;
        b=Px9sVBaeOWtyjcrVkc7AopIeuck2+tKg1uegBSQA5mFztYi4SXiAz6bHDBjY3nFs2CjQ96
        VU+Ht/N8O0su+LQb0ucixq+z6GIAK8DBtkzoxNMJc19zklpGCvV4aMMOOlyJB8+RZMsxwK
        kN7ST3RB9tHH+fpOqHy26t4GyS8Fcqo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-OwlrFnZWM9GjNlRZSgA4sA-1; Mon, 20 Nov 2023 06:41:17 -0500
X-MC-Unique: OwlrFnZWM9GjNlRZSgA4sA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32f8371247fso2338760f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:41:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700480476; x=1701085276;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XroWRvXs+Y4iSNm22W3/JdNTVL8TEZs8UV4UrMaRAU8=;
        b=UMSPTCPvxfbCCKQf9P+y7xl+M4BmHdnruz6/vRu/guYo0/uE3m/c7bwuPw2h1B/WQq
         5t9otCMM89Vhc8yIPSTgY9B8O1weqCC1B/P84F94g1YmWcNL/2X+eAEmK8nyKg2Z+C41
         uldfMUjxWIBMT2IskE8ZSHJNyjnelb8Jo9iJwrSSLg0ntzdBWWZiiJm6DFpnVGnFnRVg
         qh5Ywek2d3uwxJQh4+pYYREIAdla5vZvGrbiqcH3qbO0+ZvPZ8N036NhMW86wm5myHbi
         849YFcpaEBtM+wXRCGIndjteyKIF6rQrsk1+neJHsegVowdl0Dg5ac1exwIB/i+P6P14
         G+aA==
X-Gm-Message-State: AOJu0YwJWtc6rIFn1emyHdeAkUT/ljlbml3ySTbJMnYYbqDAtKy3+2FB
        6iq87hqdUMzUvQlDRBaVhL/zoJfxZn9ckxzpxRx5206syhMmRzp7ZCgwFt1xBlZtA2y3lW9w00N
        zi2jOEglInwaavdcdneebSqPd
X-Received: by 2002:adf:8b5e:0:b0:331:6945:9d11 with SMTP id v30-20020adf8b5e000000b0033169459d11mr4491910wra.71.1700480475873;
        Mon, 20 Nov 2023 03:41:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQeYavQxEh9X/79Cw3cos/8euUJrt0jtYgzKPT2aR6UAKDUJgVcLEnoC7Ho8gMeRLd6M44Tw==
X-Received: by 2002:adf:8b5e:0:b0:331:6945:9d11 with SMTP id v30-20020adf8b5e000000b0033169459d11mr4491896wra.71.1700480475496;
        Mon, 20 Nov 2023 03:41:15 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d5909000000b0032f9688ea48sm10955278wrd.10.2023.11.20.03.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 03:41:15 -0800 (PST)
Message-ID: <8018a697eae37a5e749afcb19368ac7c32b91d57.camel@redhat.com>
Subject: Re: [PATCH 1/2] Revert "nSVM: Check for reserved encodings of
 TLB_CONTROL in nested VMCB"
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Sterz <s.sterz@proxmox.com>
Date:   Mon, 20 Nov 2023 13:41:13 +0200
In-Reply-To: <20231018194104.1896415-2-seanjc@google.com>
References: <20231018194104.1896415-1-seanjc@google.com>
         <20231018194104.1896415-2-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-18 at 12:41 -0700, Sean Christopherson wrote:
> Revert KVM's made-up consistency check on SVM's TLB control.  The APM says
> that unsupported encodings are reserved, but the APM doesn't state that
> VMRUN checks for a supported encoding.  Unless something is called out
> in "Canonicalization and Consistency Checks" or listed as MBZ (Must Be
> Zero), AMD behavior is typically to let software shoot itself in the foot.
> 
> This reverts commit 174a921b6975ef959dd82ee9e8844067a62e3ec1.
> 
> Fixes: 174a921b6975 ("nSVM: Check for reserved encodings of TLB_CONTROL in nested VMCB")
> Reported-by: Stefan Sterz <s.sterz@proxmox.com>
> Closes: https://lkml.kernel.org/r/b9915c9c-4cf6-051a-2d91-44cc6380f455%40proxmox.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/nested.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 3fea8c47679e..60891b9ce25f 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -247,18 +247,6 @@ static bool nested_svm_check_bitmap_pa(struct kvm_vcpu *vcpu, u64 pa, u32 size)
>  	    kvm_vcpu_is_legal_gpa(vcpu, addr + size - 1);
>  }
>  
> -static bool nested_svm_check_tlb_ctl(struct kvm_vcpu *vcpu, u8 tlb_ctl)
> -{
> -	/* Nested FLUSHBYASID is not supported yet.  */
> -	switch(tlb_ctl) {
> -		case TLB_CONTROL_DO_NOTHING:
> -		case TLB_CONTROL_FLUSH_ALL_ASID:
> -			return true;
> -		default:
> -			return false;
> -	}
> -}
> -
>  static bool __nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
>  					 struct vmcb_ctrl_area_cached *control)
>  {
> @@ -278,9 +266,6 @@ static bool __nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
>  					   IOPM_SIZE)))
>  		return false;
>  
> -	if (CC(!nested_svm_check_tlb_ctl(vcpu, control->tlb_ctl)))
> -		return false;
> -
>  	if (CC((control->int_ctl & V_NMI_ENABLE_MASK) &&
>  	       !vmcb12_is_intercept(control, INTERCEPT_NMI))) {
>  		return false;


Yes, after checking Jim's comment (*) on this I still agree that revert is OK.
KVM never passes through the tlb_ctl field (but does copy it to the cache),
thus there is no need to sanitize it.

https://www.spinics.net/lists/kvm/msg316072.html


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

