Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F1A7F78AD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345434AbjKXQLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjKXQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:11:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9461B19AA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700842301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=gVnyc+iJ+KiZKpFBiD0j4BpZFWXYn4m5bglNqialQuQ=;
        b=EBxgYZVKTpyflrDy2Ut6hplETi+q1z3sHsoG53cI/Gy91DUHSGuYDH2a2Cbo4pVHAk05SX
        fPaphlZ6JeJU5VmFBG8MdQkm+/VKPGuMzW+W29VQvNo+EFtWPvcn3kD8z0jOnL3bn7Cdbc
        3iIiGLk1lBxE4RrXaTNdPT/Zh5v7LIQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-4cSFkkQTMUKoGsK_CQkv1A-1; Fri, 24 Nov 2023 11:11:40 -0500
X-MC-Unique: 4cSFkkQTMUKoGsK_CQkv1A-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-77d7a92f883so109819985a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700842300; x=1701447100;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVnyc+iJ+KiZKpFBiD0j4BpZFWXYn4m5bglNqialQuQ=;
        b=TqJAPQ1R8WiT+rNgHavorvTG8WYX+4pUkUfbqfKA0ftci/d6qCLTuk23n4nN3sZV1/
         UdSaDPFNE5oKb4lZ71UnWgtJK9gYjkYBf6/EDOWrS3wdYRsC5yiCJdgX69Ce4oGgjUGb
         zs3ZkGcAm/E+H5FGm57KySvGhzaULob/M544z5PQI88Ss8ZGZQ0TmPIb92CodGoGgBEN
         a8uMZJjX9Q3eHas0gzPvIDlxyhF0Wgmh+BLiPiKp5Awvna3ItDXBLJFPCEBreI7c8inT
         fumrezd52tyEOuK+nL9ajN991GdIrVx42PxCqdPhNP6hciCQSKan7sET4Ogqb82V8lOT
         Ijkg==
X-Gm-Message-State: AOJu0YwPgtmtAEE0undptnqB3bYFzfZZe9y2Q7XuaVO8oG+ybJT4/1CQ
        rakL/LfSf996sfpYYgt19TX4uC2hScwPfGh/68Ur2+OBk4Z+vRm7eJhNRTQDMuUMRztPvUzXJUd
        TXsyZlnIGG3EqjAJzYnPfV15v
X-Received: by 2002:a05:620a:3792:b0:778:af06:640e with SMTP id pi18-20020a05620a379200b00778af06640emr3428398qkn.16.1700842300039;
        Fri, 24 Nov 2023 08:11:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4C0MFSdgRbt6SFbCLc2O4yqi2ZPuleRbYexSgR4VNJn+tjFGhceDh116YyF+ElQAT7ogDUg==
X-Received: by 2002:a05:620a:3792:b0:778:af06:640e with SMTP id pi18-20020a05620a379200b00778af06640emr3428379qkn.16.1700842299748;
        Fri, 24 Nov 2023 08:11:39 -0800 (PST)
Received: from [10.32.181.74] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id u21-20020ae9c015000000b0076efaec147csm1318135qkk.45.2023.11.24.08.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 08:11:39 -0800 (PST)
Message-ID: <a10d3a01-939c-493c-b93c-b3821735e062@redhat.com>
Date:   Fri, 24 Nov 2023 17:11:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] KVM: x86: add new nested vmexit tracepoints
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20230928103640.78453-1-mlevitsk@redhat.com>
 <20230928103640.78453-5-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20230928103640.78453-5-mlevitsk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/23 12:36, Maxim Levitsky wrote:
> Add 3 new tracepoints for nested VM exits which are intended
> to capture extra information to gain insights about the nested guest
> behavior.
> 
> The new tracepoints are:
> 
> - kvm_nested_msr
> - kvm_nested_hypercall
> 
> These tracepoints capture extra register state to be able to know
> which MSR or which hypercall was done.
> 
> - kvm_nested_page_fault
> 
> This tracepoint allows to capture extra info about which host pagefault
> error code caused the nested page fault.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

with just one question below that can be fixed when applying:

> @@ -1139,6 +1145,22 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
>   				       vmcb12->control.exit_int_info_err,
>   				       KVM_ISA_SVM);
>   
> +	/* Collect some info about nested VM exits */
> +	switch (vmcb12->control.exit_code) {
> +	case SVM_EXIT_MSR:
> +		trace_kvm_nested_msr(vmcb12->control.exit_info_1 == 1,
> +				     kvm_rcx_read(vcpu),
> +				     (vmcb12->save.rax & -1u) |
> +				     (((u64)(kvm_rdx_read(vcpu) & -1u) << 32)));

Why the second "& -1u"?  (And I also prefer 0xFFFFFFFFull

Paolo

