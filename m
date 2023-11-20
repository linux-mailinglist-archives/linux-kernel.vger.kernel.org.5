Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7195C7F1251
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjKTLme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjKTLmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:42:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499A9B3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700480548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ywZqg0MRB/SOqibE44rsexi3e6ZvTzo2NLgsXDnSvV0=;
        b=e5n7PDxSoKt2cE6RJ190fA1pUbRMotQAoyfbGkGWde6kS0Q179zArird9JPjdj1vEgFdPy
        3idJ/h3V7NL1ZnH0HwJxkWANPpTSmesO3H+peDIHaNxexpZww4aRyysVEbo/U8lzO1hd+J
        lmfvdXnp25TLUq8AOOFAi9096bFS/bw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-Cqd8r2EqNLmOFgXhz8pwnQ-1; Mon, 20 Nov 2023 06:42:27 -0500
X-MC-Unique: Cqd8r2EqNLmOFgXhz8pwnQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c83269c4ccso40058691fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:42:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700480545; x=1701085345;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywZqg0MRB/SOqibE44rsexi3e6ZvTzo2NLgsXDnSvV0=;
        b=gQ/yOH42JzEFck+4Ow/q8j7iwG9ffSkbvpMjVozIQY5oFw1uZjfMOkIUGBF8kzsXRo
         BhXsSzKQd8LGEr4dbPTxbp73jn73VN2tQvwOiSs/bIIiiNe7Ql5Rw5Jxh4jzkne/9JIk
         5B4x41HIaVO9KlmKr8NLrEpeX20F7QULowgNejYYH48fs6yeEBBccr7HXNTPcxYpPlqi
         Mt9xmcEq1/a8xx4J0zN7/1qIHDCHSMuZnsr7t5/5YRC9jXBY21sJFScZ3Cu13tJDLi0G
         nEG1jxgjaY4nBWeUa/l+Zv4vQ/j6HfLfmaBa0ThSaiOlGsyf2srvqOMd1mGjtHlIpTtq
         zXYA==
X-Gm-Message-State: AOJu0YxmV8lhOL7x/SCTLdRYeL6FncYXI+OsHCZVq9zI1xW5Aqa1PYs0
        tmEvXoQHQsLhYQIwETstMPZ7EMQgN29dlzk0mgZd50Iq3g9Fk5RMM4QHi4b32hYEW8w8ZmeSH9j
        BbDW2aNpYbLMfSOmX3SEMQbyg
X-Received: by 2002:a05:651c:a10:b0:2bf:eccb:548 with SMTP id k16-20020a05651c0a1000b002bfeccb0548mr6186505ljq.0.1700480545632;
        Mon, 20 Nov 2023 03:42:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjKQM/vOpMY9WYFl3GfILi46upwBqkgOLSeVIAoWAtIypyoBzfkhZr7UG5lapd2y3yGW6eDg==
X-Received: by 2002:a05:651c:a10:b0:2bf:eccb:548 with SMTP id k16-20020a05651c0a1000b002bfeccb0548mr6186489ljq.0.1700480545312;
        Mon, 20 Nov 2023 03:42:25 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id k42-20020a05600c1caa00b003feae747ff2sm17922471wms.35.2023.11.20.03.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 03:42:25 -0800 (PST)
Message-ID: <4eaec4f20dd463ae46418ebf460de43b15789950.camel@redhat.com>
Subject: Re: [PATCH 2/2] KVM: nSVM: Advertise support for flush-by-ASID
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Sterz <s.sterz@proxmox.com>
Date:   Mon, 20 Nov 2023 13:42:23 +0200
In-Reply-To: <20231018194104.1896415-3-seanjc@google.com>
References: <20231018194104.1896415-1-seanjc@google.com>
         <20231018194104.1896415-3-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-18 at 12:41 -0700, Sean Christopherson wrote:
> Advertise support for FLUSHBYASID when nested SVM is enabled, as KVM can
> always emulate flushing TLB entries for a vmcb12 ASID, e.g. by running L2
> with a new, fresh ASID in vmcb02.  Some modern hypervisors, e.g. VMWare
> Workstation 17, require FLUSHBYASID support and will refuse to run if it's
> not present.
> 
> Punt on proper support, as "Honor L1's request to flush an ASID on nested
> VMRUN" is one of the TODO items in the (incomplete) list of issues that
> need to be addressed in order for KVM to NOT do a full TLB flush on every
> nested SVM transition (see nested_svm_transition_tlb_flush()).
> 
> Reported-by: Stefan Sterz <s.sterz@proxmox.com>
> Closes: https://lkml.kernel.org/r/b9915c9c-4cf6-051a-2d91-44cc6380f455%40proxmox.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/svm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 1785de7dc98b..9cf7eef161ff 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5083,6 +5083,7 @@ static __init void svm_set_cpu_caps(void)
>  	if (nested) {
>  		kvm_cpu_cap_set(X86_FEATURE_SVM);
>  		kvm_cpu_cap_set(X86_FEATURE_VMCBCLEAN);
> +		kvm_cpu_cap_set(X86_FEATURE_FLUSHBYASID);
>  
>  		if (nrips)
>  			kvm_cpu_cap_set(X86_FEATURE_NRIPS);

Nitpick: if you think that this is worth it,
maybe we can add a comment here on why we can 'support' the flushbyasid feature?
in addition to the commit message.

Other than that:

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

