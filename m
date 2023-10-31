Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF55D7DD588
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376348AbjJaRxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347035AbjJaRxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:53:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EA7DA
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698774770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BygMSyQj/wRvGQhztLyD1nlXgXiXFczqxRGZR5KZln0=;
        b=YpAkJL10eAyBkVeTM77WPUUNL74m6UVI51Kbbgd9JalsJY3cBAWhREwURbrJt3Zvkg2qM4
        xjxt6MdQlMTtnTH3Zh6+TQ1gEA4J25zk10a2/zitxfRBMBNKWGb+FMjayWoDS2PNg/W7xE
        WBW1jDzgax9zPjp1WGoif4BiVNzyBfo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-dG892lSvPSu_JARPbaXfew-1; Tue, 31 Oct 2023 13:52:48 -0400
X-MC-Unique: dG892lSvPSu_JARPbaXfew-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507ceeff451so7214412e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774767; x=1699379567;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BygMSyQj/wRvGQhztLyD1nlXgXiXFczqxRGZR5KZln0=;
        b=J6kZlUFiuRzLPFT6uHSBR+oaQ2EXVG/gi/9ffXvLUDbT9y7gaMoTTEHIi+8wsl3iYZ
         /+ZiSI8IP+Jmh1r5p1JUxPg4B08Zw6KwIaXzpEqX8c/Kp5OukWNBKY0c5KXnmcGoRCTR
         0WMO1TKny80GpOcCCH7J04WqbtEbB66bENy0iWDwLnFuerjU4BUCBnVVp9PmZi2y7oI7
         vHTAeps8Noi3D/uHTNEwegooUooJ2fmvCDj4c/zNhElrPVfkEtbmaUdhTB2HOuT0yxn5
         jfSqIRJJfjD+sYbrqXcft4BnUe0PEy9xApDFeA+oBdnWOd5CsAohgHRez3s123OFJlRW
         95VQ==
X-Gm-Message-State: AOJu0Yx/vypq8wuoGB0Y4YTtRelxM55+zQm4F7j8din52FTNMe3sSPmx
        6IjTznvyfJ8lw4LhR8BnFttD6LQGLDl38pCWs41GZwtJH054ZM59pGQObTuBkbSP90zkzT2ytCT
        TRgpJYAhgBh3dD8JkE3MxLh3B
X-Received: by 2002:a19:914a:0:b0:507:9701:2700 with SMTP id y10-20020a19914a000000b0050797012700mr10583784lfj.20.1698774766904;
        Tue, 31 Oct 2023 10:52:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM8J0ccfxV3wa4kU3C0GSAiAn99kWpNAC7kIbXlwn8xqr6/7BtO3g+5ERh+7Lh3PNkkTI61Q==
X-Received: by 2002:a19:914a:0:b0:507:9701:2700 with SMTP id y10-20020a19914a000000b0050797012700mr10583767lfj.20.1698774766571;
        Tue, 31 Oct 2023 10:52:46 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id k19-20020a05600c0b5300b0040773c69fc0sm2331006wmr.11.2023.10.31.10.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:52:46 -0700 (PDT)
Message-ID: <ca9133b12babbf51359683d8ff13fb3def2a2abd.camel@redhat.com>
Subject: Re: [PATCH v6 17/25] KVM: VMX: Introduce CET VMCS fields and
 control bits
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Date:   Tue, 31 Oct 2023 19:52:44 +0200
In-Reply-To: <20230914063325.85503-18-weijiang.yang@intel.com>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-18-weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> Control-flow Enforcement Technology (CET) is a kind of CPU feature used
> to prevent Return/CALL/Jump-Oriented Programming (ROP/COP/JOP) attacks.
> It provides two sub-features(SHSTK,IBT) to defend against ROP/COP/JOP
> style control-flow subversion attacks.
> 
> Shadow Stack (SHSTK):
>   A shadow stack is a second stack used exclusively for control transfer
>   operations. The shadow stack is separate from the data/normal stack and
>   can be enabled individually in user and kernel mode. When shadow stack
>   is enabled, CALL pushes the return address on both the data and shadow
>   stack. RET pops the return address from both stacks and compares them.
>   If the return addresses from the two stacks do not match, the processor
>   generates a #CP.
> 
> Indirect Branch Tracking (IBT):
>   IBT introduces instruction(ENDBRANCH)to mark valid target addresses of
>   indirect branches (CALL, JMP etc...). If an indirect branch is executed
>   and the next instruction is _not_ an ENDBRANCH, the processor generates
>   a #CP. These instruction behaves as a NOP on platforms that have no CET.
> 
> Several new CET MSRs are defined to support CET:
>   MSR_IA32_{U,S}_CET: CET settings for {user,supervisor} CET respectively.
> 
>   MSR_IA32_PL{0,1,2,3}_SSP: SHSTK pointer linear address for CPL{0,1,2,3}.
> 
>   MSR_IA32_INT_SSP_TAB: Linear address of SHSTK pointer table, whose entry
> 			is indexed by IST of interrupt gate desc.
> 
> Two XSAVES state bits are introduced for CET:
>   IA32_XSS:[bit 11]: Control saving/restoring user mode CET states
>   IA32_XSS:[bit 12]: Control saving/restoring supervisor mode CET states.
> 
> Six VMCS fields are introduced for CET:
>   {HOST,GUEST}_S_CET: Stores CET settings for kernel mode.
>   {HOST,GUEST}_SSP: Stores current active SSP.
>   {HOST,GUEST}_INTR_SSP_TABLE: Stores current active MSR_IA32_INT_SSP_TAB.
> 
> On Intel platforms, two additional bits are defined in VM_EXIT and VM_ENTRY
> control fields:
> If VM_EXIT_LOAD_CET_STATE = 1, host CET states are loaded from following
> VMCS fields at VM-Exit:
>   HOST_S_CET
>   HOST_SSP
>   HOST_INTR_SSP_TABLE
> 
> If VM_ENTRY_LOAD_CET_STATE = 1, guest CET states are loaded from following
> VMCS fields at VM-Entry:
>   GUEST_S_CET
>   GUEST_SSP
>   GUEST_INTR_SSP_TABLE
> 
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> Co-developed-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/include/asm/vmx.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index 0e73616b82f3..451fd4f4fedc 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -104,6 +104,7 @@
>  #define VM_EXIT_CLEAR_BNDCFGS                   0x00800000
>  #define VM_EXIT_PT_CONCEAL_PIP			0x01000000
>  #define VM_EXIT_CLEAR_IA32_RTIT_CTL		0x02000000
> +#define VM_EXIT_LOAD_CET_STATE                  0x10000000
Bit 28, matches PRM.
>  
>  #define VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR	0x00036dff
>  
> @@ -117,6 +118,7 @@
>  #define VM_ENTRY_LOAD_BNDCFGS                   0x00010000
>  #define VM_ENTRY_PT_CONCEAL_PIP			0x00020000
>  #define VM_ENTRY_LOAD_IA32_RTIT_CTL		0x00040000
> +#define VM_ENTRY_LOAD_CET_STATE                 0x00100000
Bit 20, matches PRM.


I wish we redefine these masks with BIT_ULL(n) macros for the sake of
having less chance of a mistake. Patches to refactor this are welcome!

>  
>  #define VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR	0x000011ff
>  
> @@ -345,6 +347,9 @@ enum vmcs_field {
>  	GUEST_PENDING_DBG_EXCEPTIONS    = 0x00006822,
>  	GUEST_SYSENTER_ESP              = 0x00006824,
>  	GUEST_SYSENTER_EIP              = 0x00006826,
> +	GUEST_S_CET                     = 0x00006828,
> +	GUEST_SSP                       = 0x0000682a,
> +	GUEST_INTR_SSP_TABLE            = 0x0000682c,
Matches the PRM.

>  	HOST_CR0                        = 0x00006c00,
>  	HOST_CR3                        = 0x00006c02,
>  	HOST_CR4                        = 0x00006c04,
> @@ -357,6 +362,9 @@ enum vmcs_field {
>  	HOST_IA32_SYSENTER_EIP          = 0x00006c12,
>  	HOST_RSP                        = 0x00006c14,
>  	HOST_RIP                        = 0x00006c16,

> +	HOST_S_CET                      = 0x00006c18,
> +	HOST_SSP                        = 0x00006c1a,
> +	HOST_INTR_SSP_TABLE             = 0x00006c1c
Matches the PRM as well.


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



>  };
>  
>  /*





