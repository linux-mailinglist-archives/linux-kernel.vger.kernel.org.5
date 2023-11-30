Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0572A7FF9B8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjK3SnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjK3SnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:43:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0FC94
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701369792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=utEKCvi3Mxs8/wKWs/wFnw+4sKW1Lht1FkWRA71th2s=;
        b=akVQGVqKQ7cnMF75XTYcXtgs8SPYQzxB9PxfDjBPSL1PxaAkQ92J7QVgdH/HecV7gPsOd3
        Yl7DwnLNnYqdOPUgfCih+Zok216+PaMYB0I2Va+iCFA8cK5lQEqkBQialOhJuaLbQ7EH6y
        K3cChEVBRHApc2CnYRpNHQEQ4RYaOtQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-VNCYOUGTOd2swZqGcmdw_Q-1; Thu, 30 Nov 2023 13:43:09 -0500
X-MC-Unique: VNCYOUGTOd2swZqGcmdw_Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a19494e36bbso35396466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:43:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701369788; x=1701974588;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=utEKCvi3Mxs8/wKWs/wFnw+4sKW1Lht1FkWRA71th2s=;
        b=qZPFk6Yg6rz0tnUo4nRQg5gj5ESpQ83uB3bgG2Tf2pehS/YpHDj6Cq8VdHRyy7Hzi5
         ELr5rwgJe4XCplYgSLVRt8cB5L8+H0nuA+YfZVackfZNJqKAPcVCuKy8Dehb1aRK+c+0
         wdMLPCUzc3E0pZ3nQwaIOSs9sMuZ+IRUIw6nfGJVXFCxxDDtxnDLZ3+l77YDP1Xm9H4S
         g0rSQHw5l/9J3MXAJsA7vXPwHBIqsZ76IzfraVR1F2Z/lyTYDTP4OTlfahjEbZqoVOBn
         pldkOl70j7ahhfrxoif3TBFu6FJIlO8R2IUnbGkrzUUrpqKO1xmmlhfS+iqpDyq2snVM
         gzpg==
X-Gm-Message-State: AOJu0YzzDKTeXR9oOa6/V9B9GpIavxcIo83GOZes7u1uf8jhfOK8+/IK
        YCGumFt9rQWSLa0IixXvubIIJAVlqaChHRcDOXwZ2do/vmSfApphIUwkp3pii9odfe8Sn9ru6eL
        5cjMa0ZbjfP3icgx9WGyTttLyIIM7xz/4
X-Received: by 2002:a05:600c:151:b0:40b:4c66:874e with SMTP id w17-20020a05600c015100b0040b4c66874emr15957wmm.2.1701366163018;
        Thu, 30 Nov 2023 09:42:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpy3Gr5M3fCLKDTAd83unfhlFE0DziiM+WQGw754XRPWR2jJ3oNb5aPpzgpNBXdcE2CgCWYg==
X-Received: by 2002:a05:6512:3b1f:b0:509:8fbf:7af0 with SMTP id f31-20020a0565123b1f00b005098fbf7af0mr42056lfv.69.1701365231787;
        Thu, 30 Nov 2023 09:27:11 -0800 (PST)
Received: from starship ([5.28.147.32])
        by smtp.gmail.com with ESMTPSA id h4-20020a056512350400b0050aa8c0dfc3sm210133lfs.31.2023.11.30.09.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:27:11 -0800 (PST)
Message-ID: <13aaf1272737737c29ab1de22438695637944d24.camel@redhat.com>
Subject: Re: [PATCH v7 03/26] x86/fpu/xstate: Add CET supervisor mode state
 support
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, dave.hansen@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Thu, 30 Nov 2023 19:27:09 +0200
In-Reply-To: <20231124055330.138870-4-weijiang.yang@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-4-weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-24 at 00:53 -0500, Yang Weijiang wrote:
> Add supervisor mode state support within FPU xstate management framework.
> Although supervisor shadow stack is not enabled/used today in kernel,KVM
> requires the support because when KVM advertises shadow stack feature to
> guest, architecturally it claims the support for both user and supervisor
> modes for guest OSes(Linux or non-Linux).
> 
> CET supervisor states not only includes PL{0,1,2}_SSP but also IA32_S_CET
> MSR, but the latter is not xsave-managed. In virtualization world, guest
> IA32_S_CET is saved/stored into/from VM control structure. With supervisor
> xstate support, guest supervisor mode shadow stack state can be properly
> saved/restored when 1) guest/host FPU context is swapped 2) vCPU
> thread is sched out/in.
> 
> The alternative is to enable it in KVM domain, but KVM maintainers NAKed
> the solution. The external discussion can be found at [*], it ended up
> with adding the support in kernel instead of KVM domain.
> 
> Note, in KVM case, guest CET supervisor state i.e., IA32_PL{0,1,2}_MSRs,
> are preserved after VM-Exit until host/guest fpstates are swapped, but
> since host supervisor shadow stack is disabled, the preserved MSRs won't
> hurt host.
> 
> [*]: https://lore.kernel.org/all/806e26c2-8d21-9cc9-a0b7-7787dd231729@intel.com/
> 
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/include/asm/fpu/types.h  | 14 ++++++++++++--
>  arch/x86/include/asm/fpu/xstate.h |  6 +++---
>  arch/x86/kernel/fpu/xstate.c      |  6 +++++-
>  3 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
> index eb810074f1e7..c6fd13a17205 100644
> --- a/arch/x86/include/asm/fpu/types.h
> +++ b/arch/x86/include/asm/fpu/types.h
> @@ -116,7 +116,7 @@ enum xfeature {
>  	XFEATURE_PKRU,
>  	XFEATURE_PASID,
>  	XFEATURE_CET_USER,
> -	XFEATURE_CET_KERNEL_UNUSED,
> +	XFEATURE_CET_KERNEL,
>  	XFEATURE_RSRVD_COMP_13,
>  	XFEATURE_RSRVD_COMP_14,
>  	XFEATURE_LBR,
> @@ -139,7 +139,7 @@ enum xfeature {
>  #define XFEATURE_MASK_PKRU		(1 << XFEATURE_PKRU)
>  #define XFEATURE_MASK_PASID		(1 << XFEATURE_PASID)
>  #define XFEATURE_MASK_CET_USER		(1 << XFEATURE_CET_USER)
> -#define XFEATURE_MASK_CET_KERNEL	(1 << XFEATURE_CET_KERNEL_UNUSED)
> +#define XFEATURE_MASK_CET_KERNEL	(1 << XFEATURE_CET_KERNEL)
>  #define XFEATURE_MASK_LBR		(1 << XFEATURE_LBR)
>  #define XFEATURE_MASK_XTILE_CFG		(1 << XFEATURE_XTILE_CFG)
>  #define XFEATURE_MASK_XTILE_DATA	(1 << XFEATURE_XTILE_DATA)
> @@ -264,6 +264,16 @@ struct cet_user_state {
>  	u64 user_ssp;
>  };
>  
> +/*
> + * State component 12 is Control-flow Enforcement supervisor states
> + */
> +struct cet_supervisor_state {
> +	/* supervisor ssp pointers  */
> +	u64 pl0_ssp;
> +	u64 pl1_ssp;
> +	u64 pl2_ssp;
> +};
> +
>  /*
>   * State component 15: Architectural LBR configuration state.
>   * The size of Arch LBR state depends on the number of LBRs (lbr_depth).
> diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
> index d4427b88ee12..3b4a038d3c57 100644
> --- a/arch/x86/include/asm/fpu/xstate.h
> +++ b/arch/x86/include/asm/fpu/xstate.h
> @@ -51,7 +51,8 @@
>  
>  /* All currently supported supervisor features */
>  #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID | \
> -					    XFEATURE_MASK_CET_USER)
> +					    XFEATURE_MASK_CET_USER | \
> +					    XFEATURE_MASK_CET_KERNEL)
>  
>  /*
>   * A supervisor state component may not always contain valuable information,
> @@ -78,8 +79,7 @@
>   * Unsupported supervisor features. When a supervisor feature in this mask is
>   * supported in the future, move it to the supported supervisor feature mask.
>   */
> -#define XFEATURE_MASK_SUPERVISOR_UNSUPPORTED (XFEATURE_MASK_PT | \
> -					      XFEATURE_MASK_CET_KERNEL)
> +#define XFEATURE_MASK_SUPERVISOR_UNSUPPORTED (XFEATURE_MASK_PT)
>  
>  /* All supervisor states including supported and unsupported states. */
>  #define XFEATURE_MASK_SUPERVISOR_ALL (XFEATURE_MASK_SUPERVISOR_SUPPORTED | \
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 6e50a4251e2b..b57d909facca 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -51,7 +51,7 @@ static const char *xfeature_names[] =
>  	"Protection Keys User registers",
>  	"PASID state",
>  	"Control-flow User registers",
> -	"Control-flow Kernel registers (unused)",
> +	"Control-flow Kernel registers",
>  	"unknown xstate feature",
>  	"unknown xstate feature",
>  	"unknown xstate feature",
> @@ -73,6 +73,7 @@ static unsigned short xsave_cpuid_features[] __initdata = {
>  	[XFEATURE_PT_UNIMPLEMENTED_SO_FAR]	= X86_FEATURE_INTEL_PT,
>  	[XFEATURE_PKRU]				= X86_FEATURE_OSPKE,
>  	[XFEATURE_PASID]			= X86_FEATURE_ENQCMD,
> +	[XFEATURE_CET_KERNEL]			= X86_FEATURE_SHSTK,
>  	[XFEATURE_XTILE_CFG]			= X86_FEATURE_AMX_TILE,
>  	[XFEATURE_XTILE_DATA]			= X86_FEATURE_AMX_TILE,
>  };
> @@ -277,6 +278,7 @@ static void __init print_xstate_features(void)
>  	print_xstate_feature(XFEATURE_MASK_PKRU);
>  	print_xstate_feature(XFEATURE_MASK_PASID);
>  	print_xstate_feature(XFEATURE_MASK_CET_USER);
> +	print_xstate_feature(XFEATURE_MASK_CET_KERNEL);
>  	print_xstate_feature(XFEATURE_MASK_XTILE_CFG);
>  	print_xstate_feature(XFEATURE_MASK_XTILE_DATA);
>  }
> @@ -346,6 +348,7 @@ static __init void os_xrstor_booting(struct xregs_state *xstate)
>  	 XFEATURE_MASK_BNDCSR |			\
>  	 XFEATURE_MASK_PASID |			\
>  	 XFEATURE_MASK_CET_USER |		\
> +	 XFEATURE_MASK_CET_KERNEL |		\
>  	 XFEATURE_MASK_XTILE)
>  
>  /*
> @@ -546,6 +549,7 @@ static bool __init check_xstate_against_struct(int nr)
>  	case XFEATURE_PASID:	  return XCHECK_SZ(sz, nr, struct ia32_pasid_state);
>  	case XFEATURE_XTILE_CFG:  return XCHECK_SZ(sz, nr, struct xtile_cfg);
>  	case XFEATURE_CET_USER:	  return XCHECK_SZ(sz, nr, struct cet_user_state);
> +	case XFEATURE_CET_KERNEL: return XCHECK_SZ(sz, nr, struct cet_supervisor_state);
>  	case XFEATURE_XTILE_DATA: check_xtile_data_against_struct(sz); return true;
>  	default:
>  		XSTATE_WARN_ON(1, "No structure for xstate: %d\n", nr);

Any reason why my reviewed-by was not added to this patch?

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


