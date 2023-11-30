Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E963B7FFAF1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376303AbjK3TNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbjK3TNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:13:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7DC10F1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701371635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EkCMhFpiP/sdJl9nslDpr6bpl6B4gQB+ldegoyD9sYM=;
        b=YY3Vo4J9zX1jfXB4z3nzvPYWLDOdCrdWEhlAEoi//o3HDM3H87UyeJPBH7U2zW3q3HGDBa
        pNIs0W+SpTODWLOb6GswmJjCcB7wvJWNFtd45X6+K0NTcAgqVKFDOpgqg1VXrUEdlMlXB+
        rDGcTwo7qacBCSh3KJmv9rtbrHgi3Kw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-OkgcqvxhPr6E-D3pu9pebQ-1; Thu, 30 Nov 2023 14:13:54 -0500
X-MC-Unique: OkgcqvxhPr6E-D3pu9pebQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-333120f8976so1053544f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:13:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701371632; x=1701976432;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EkCMhFpiP/sdJl9nslDpr6bpl6B4gQB+ldegoyD9sYM=;
        b=E+omENF2Ww3x6Fw0gRJTMNDc1cLJUO0/6Krcnazt0HCabn6z6gN2ckw4i2dys7WgMe
         bbB4X7wKJUsWfmoz8JJ2rLL64GkLjeAM5Q6NRY8yuz4kQoFTHNQZDCZVSgB05Nnw1BcI
         ts5TkPHixyhLLg6UX6l0XjnOy9KQhOSAUtEAm0fi0rXMRBZ4LAfgHuW8mdoDh5y7IfTr
         pbdey9ZzgaJHJJfiDktXc2CBFzVRVMMsACFjW+DDwUSWrwkcU2qxgOkTOsd7zpJXnwY3
         +jxcltDW+2A0kB5LUtANh0abz2BHYkj29xDjw50PbvI7TQpVtrGqh9UsW7kROvcw4nGx
         Z1KA==
X-Gm-Message-State: AOJu0YxcR+7OIRH2eUrM4glnmrpSRrU0D5YcBFYhpcNOwc2zlhNvh75c
        vXQN3pch8wJ7AsvB38SlH8fEw9eKu5itsXYhcBWq7Rktnx8+N5LqJ3BZnCb8SG9gMJMVXWg6JM3
        dCezg5rikuz6Ivi0wTEgGfzxKM+DIvJ7t
X-Received: by 2002:adf:f00a:0:b0:333:2fd2:3c04 with SMTP id j10-20020adff00a000000b003332fd23c04mr1021wro.189.1701371632089;
        Thu, 30 Nov 2023 11:13:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFza7U9/12615LfgTxmIGc5pXDaVHNaln+IrotDbqNHf6KkGfPK0Mfevm8RZ3Mrmt9N20hCeA==
X-Received: by 2002:ac2:5397:0:b0:50a:40b6:2d37 with SMTP id g23-20020ac25397000000b0050a40b62d37mr2940lfh.40.1701365203737;
        Thu, 30 Nov 2023 09:26:43 -0800 (PST)
Received: from starship ([5.28.147.32])
        by smtp.gmail.com with ESMTPSA id v10-20020a19740a000000b00507977e9a38sm209487lfe.35.2023.11.30.09.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:26:43 -0800 (PST)
Message-ID: <c22d17ab04bf5f27409518e3e79477d579b55071.camel@redhat.com>
Subject: Re: [PATCH v7 02/26] x86/fpu/xstate: Refine CET user xstate bit
 enabling
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, dave.hansen@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Thu, 30 Nov 2023 19:26:40 +0200
In-Reply-To: <20231124055330.138870-3-weijiang.yang@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-3-weijiang.yang@intel.com>
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
> Remove XFEATURE_CET_USER entry from dependency array as the entry doesn't
> reflect true dependency between CET features and the user xstate bit.
> Enable the bit in fpu_kernel_cfg.max_features when either SHSTK or IBT is
> available.
> 
> Both user mode shadow stack and indirect branch tracking features depend
> on XFEATURE_CET_USER bit in XSS to automatically save/restore user mode
> xstate registers, i.e., IA32_U_CET and IA32_PL3_SSP whenever necessary.
> 
> Note, the issue, i.e., CPUID only enumerates IBT but no SHSTK is resulted
> from CET KVM series which synthesizes guest CPUIDs based on userspace
> settings,in real world the case is rare. In other words, the exitings
> dependency check is correct when only user mode SHSTK is available.
> 
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/kernel/fpu/xstate.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 73f6bc00d178..6e50a4251e2b 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -73,7 +73,6 @@ static unsigned short xsave_cpuid_features[] __initdata = {
>  	[XFEATURE_PT_UNIMPLEMENTED_SO_FAR]	= X86_FEATURE_INTEL_PT,
>  	[XFEATURE_PKRU]				= X86_FEATURE_OSPKE,
>  	[XFEATURE_PASID]			= X86_FEATURE_ENQCMD,
> -	[XFEATURE_CET_USER]			= X86_FEATURE_SHSTK,
>  	[XFEATURE_XTILE_CFG]			= X86_FEATURE_AMX_TILE,
>  	[XFEATURE_XTILE_DATA]			= X86_FEATURE_AMX_TILE,
>  };
> @@ -798,6 +797,14 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
>  			fpu_kernel_cfg.max_features &= ~BIT_ULL(i);
>  	}
>  
> +	/*
> +	 * CET user mode xstate bit has been cleared by above sanity check.
> +	 * Now pick it up if either SHSTK or IBT is available. Either feature
> +	 * depends on the xstate bit to save/restore user mode states.
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_SHSTK) || boot_cpu_has(X86_FEATURE_IBT))
> +		fpu_kernel_cfg.max_features |= BIT_ULL(XFEATURE_CET_USER);
> +
>  	if (!cpu_feature_enabled(X86_FEATURE_XFD))
>  		fpu_kernel_cfg.max_features &= ~XFEATURE_MASK_USER_DYNAMIC;
>  

I am curious:

Any reason why my review feedback was not applied even though you did agree
that it is reasonable?


https://lore.kernel.org/lkml/c72dfaac-1622-94cf-a81d-9d7ed81b2f55@intel.com/

Best regards,
	Maxim Levitsky

