Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1D17D433A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 01:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjJWXar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 19:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjJWXao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 19:30:44 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658E4D79
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 16:30:42 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1caaaa873efso27675405ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 16:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698103842; x=1698708642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j5fYbMEb1JvOsD0gc/Ytx1EglN9OvlUjCB+MaPjp4wM=;
        b=RMMnmn0W3ZppTZKLq1/q0ZtwsaA4YyQLnYnSMx2mf7ofI0xKATF5hoCu3sf9eIw/kc
         /NANMzwkj4msMAknT2DzobBoyKdHl6CWenjJem4sYq4OsnqL4D6C1iYLlpGi/+c6mnEI
         t6YvW8jgOs8RzzTlYnPy53MXG/u8/m8+Ce6Qt5or+7Vby5RaobexWSptQjaHyetiPWmq
         QoqV5dUETnsWvUjxGIH6mskGkMheCAubauLcafiRB+20GoamAnvgoAXezMxLtzE/Rgwj
         UDvOgPF9huXfLIlO53Px7OUMLjjlKB0ALk8u83aekHXMmMvnMyPIN0p9GXZRYIirOO9r
         N6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698103842; x=1698708642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j5fYbMEb1JvOsD0gc/Ytx1EglN9OvlUjCB+MaPjp4wM=;
        b=JU8qm00rpzPu5Y2oD+rq3bz87SdZ8LUcO7e8CCUDr8Pdb+osG4b7RGN1bsajZl0SyO
         Gmmp4DtlK2lklmyTATvo+4+/5esqs9kLQCnUz8Jl+F5pK4bpBsxhPtR+1trb60V7NCw8
         7fRsAqJ1cxtbDuy1SogfLIDS4V+IihbnSZrueKGGTIOsi3xtgM7B8tj1JHdiJb9uSeWG
         7joZ2WHo42Yu+Bil1SisMvaW9TRYoFD2I+I/GI6uhdMQUkxmr/1rGxABmQM9evwALhPK
         s86nsf1eH4A5HRflOg3IOpgxB13LX8EKRhrfoJ4/bWVnBX6KxHhceinll2/Kb4IhW9+O
         /INA==
X-Gm-Message-State: AOJu0Yzop/Kijwn1fpF7I8EZ1J6OjcYFx6bzkZKYE4Pt3Owq02C/oRbU
        XoCgm64IIAbctcSKaprfZkmx998wkAA=
X-Google-Smtp-Source: AGHT+IED9DGGHxqn6OYymLHC4FdJmMHhUaKhQoF2QicyRZM3rGefSGhnzRC82+BZ/3PYOSfYTyZtuKP0T0Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e214:b0:1c9:db23:706e with SMTP id
 u20-20020a170902e21400b001c9db23706emr176623plb.5.1698103841720; Mon, 23 Oct
 2023 16:30:41 -0700 (PDT)
Date:   Mon, 23 Oct 2023 16:30:40 -0700
In-Reply-To: <20230913124227.12574-9-binbin.wu@linux.intel.com>
Mime-Version: 1.0
References: <20230913124227.12574-1-binbin.wu@linux.intel.com> <20230913124227.12574-9-binbin.wu@linux.intel.com>
Message-ID: <ZTcCIPHMeX84auh-@google.com>
Subject: Re: [PATCH v11 08/16] KVM: x86: Introduce get_untagged_addr() in
 kvm_x86_ops and call it in emulator
From:   Sean Christopherson <seanjc@google.com>
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, chao.gao@intel.com, kai.huang@intel.com,
        David.Laight@aculab.com, robert.hu@linux.intel.com,
        guang.zeng@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023, Binbin Wu wrote:
> Introduce a new interface get_untagged_addr() to kvm_x86_ops to untag
> the metadata from linear address.  Call the interface in linearization
> of instruction emulator for 64-bit mode.
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ea48ba87dacf..e03313287816 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8308,6 +8308,15 @@ static void emulator_vm_bugged(struct x86_emulate_ctxt *ctxt)
>  		kvm_vm_bugged(kvm);
>  }
>  
> +static gva_t emulator_get_untagged_addr(struct x86_emulate_ctxt *ctxt,
> +					gva_t addr, unsigned int flags)
> +{
> +	if (!kvm_x86_ops.get_untagged_addr)
> +		return addr;
> +
> +	return static_call(kvm_x86_get_untagged_addr)(emul_to_vcpu(ctxt), addr, flags);
> +}
> +
>  static const struct x86_emulate_ops emulate_ops = {
>  	.vm_bugged           = emulator_vm_bugged,
>  	.read_gpr            = emulator_read_gpr,
> @@ -8352,6 +8361,7 @@ static const struct x86_emulate_ops emulate_ops = {
>  	.leave_smm           = emulator_leave_smm,
>  	.triple_fault        = emulator_triple_fault,
>  	.set_xcr             = emulator_set_xcr,
> +	.get_untagged_addr   = emulator_get_untagged_addr,

Oh, and for posterity because I've now thought about this on two separate occasions:

We _could_ nullify .get_untagged_addr() if LAM isn't supported, e.g. to save a
RETPOLINE when applicable, but that would require making emulate_ops non-const,
and so I think it's worth eating the indirect call.  I suppose we could gate it
on CONFIG_ADDRESS_MASKING, but then we'd have to carry a bunch of #ifdefs in the
VMX code, so I don't think that's worth doing either.
