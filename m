Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32F97DD586
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376539AbjJaRxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376359AbjJaRxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544AC91
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698774733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hBI/XfTeVx6UUkeIftDiyCARDs2jjPZzB3PYsBCrIyo=;
        b=J3b9pXAl54eASFoCM15y66e1Ev0NTs6ukRl2+SOttGyOyOxuUK/3c8L8oizzjBnI+64dYc
        WwL1uRL8/eQDwxJZ0vAyn7aHpVi8AWtdp+5DtJRpfsiCDaTxTExtGkrfGi3yJzOMDvnwMC
        Ln9yZIL2++E7zYmO5RM/PeruXPlAIC0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-oQpxGtSyNYearIDGfvLWkA-1; Tue, 31 Oct 2023 13:52:02 -0400
X-MC-Unique: oQpxGtSyNYearIDGfvLWkA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5082705f6dfso5142376e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774720; x=1699379520;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hBI/XfTeVx6UUkeIftDiyCARDs2jjPZzB3PYsBCrIyo=;
        b=i4ccCdG9+PFUyUEOv/qpVagEN/kFKP5MfhiPKrfaxMWS+aDNi1PZoupXLsTMbhRXgM
         aYguOdfBfnhuhLNR2g5lhj9WSt+qF1pu/FtHgPHISe2kTp1aNa9hb+m2Kcs8ql4cH/Sa
         9FSeGYxxbxHl4HAZ1QIxtlkIT9KL5hqOPRDMKb/DzECve6a3I0/nIGTSoMKPWxBsi8wf
         qDAlx0Qm25a8v9Vs0CtVeauMITIMzKKGlGya9NFyRawpxpAF6jsRLHm5pXE6A5zQL11X
         /rEz1wdMyYwlRxXhVoIAFyRE/PIabwQlikhk5Ik3EzzJDkVTpLvNwHuVa7h95G15y7aS
         pQpw==
X-Gm-Message-State: AOJu0YyD3CiH0bJUYt7/BfLhW+oB3drN7HbpV8vqw4qqWMf6OF1bhASZ
        IbNkRN8G68oesxC3F+Ke1EDy2MchK1Z6h1THPFa7i8gl7SVDvQMdVNWeNx7m0TpP6+kYTn/G/eA
        axB7/D3C62qv4/PBMtAVbf21Y
X-Received: by 2002:ac2:5297:0:b0:502:afea:dfdd with SMTP id q23-20020ac25297000000b00502afeadfddmr9995697lfm.13.1698774720742;
        Tue, 31 Oct 2023 10:52:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcFnla1lIfA/d2qFFhpzSBLsRjsScH33jS94JueL3Lmqbnb6cxPakrUEg+PZYcw2vVziy/ug==
X-Received: by 2002:ac2:5297:0:b0:502:afea:dfdd with SMTP id q23-20020ac25297000000b00502afeadfddmr9995679lfm.13.1698774720515;
        Tue, 31 Oct 2023 10:52:00 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id r13-20020a056000014d00b0032d8354fb43sm1994817wrx.76.2023.10.31.10.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:51:59 -0700 (PDT)
Message-ID: <fcc76a837a5f5eb4ed57b298a455694106d5c9c7.camel@redhat.com>
Subject: Re: [PATCH v6 15/25] KVM: x86: Add fault checks for guest CR4.CET
 setting
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Tue, 31 Oct 2023 19:51:57 +0200
In-Reply-To: <20230914063325.85503-16-weijiang.yang@intel.com>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-16-weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> Check potential faults for CR4.CET setting per Intel SDM requirements.
> CET can be enabled if and only if CR0.WP == 1, i.e. setting CR4.CET ==
> 1 faults if CR0.WP == 0 and setting CR0.WP == 0 fails if CR4.CET == 1.
> 
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/x86.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a091764bf1d2..dda9c7141ea1 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1006,6 +1006,9 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
>  	    (is_64_bit_mode(vcpu) || kvm_is_cr4_bit_set(vcpu, X86_CR4_PCIDE)))
>  		return 1;
>  
> +	if (!(cr0 & X86_CR0_WP) && kvm_is_cr4_bit_set(vcpu, X86_CR4_CET))
> +		return 1;
> +
>  	static_call(kvm_x86_set_cr0)(vcpu, cr0);
>  
>  	kvm_post_set_cr0(vcpu, old_cr0, cr0);
> @@ -1217,6 +1220,9 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
>  			return 1;
>  	}
>  
> +	if ((cr4 & X86_CR4_CET) && !kvm_is_cr0_bit_set(vcpu, X86_CR0_WP))
> +		return 1;
> +
>  	static_call(kvm_x86_set_cr4)(vcpu, cr4);
>  
>  	kvm_post_set_cr4(vcpu, old_cr4, cr4);

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky




