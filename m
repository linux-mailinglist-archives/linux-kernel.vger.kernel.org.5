Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52887FB348
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343928AbjK1HxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbjK1HxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:53:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EE010C1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701157993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jjvXCqaDg/PDFR1CIU19n539Mqy9U46sCLk0Pho1wkM=;
        b=TPfT+/II64ViUH2Bx8u7nNqBcdy9UPQLqjsYDeBW8m1Z8Rt1QNmuEQhECb3WNfLPdtvQWP
        93NO2kOz1jtQNlBrqOqBwVj41sAq/DE8Et0ij/uqE+xkPGP2VdSKrezzDU03ngsOzefyww
        snlbVO4Pqe45y7BMpt8Gql0CwRd3qdA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-ogQQCVT9NbG-4SIB5_HnkQ-1; Tue, 28 Nov 2023 02:53:11 -0500
X-MC-Unique: ogQQCVT9NbG-4SIB5_HnkQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40b40234b64so17087045e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:53:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701157990; x=1701762790;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jjvXCqaDg/PDFR1CIU19n539Mqy9U46sCLk0Pho1wkM=;
        b=h8aIZBdJtDNygTKdpuo9TuyKlwCXwZra2y/cUDjSmRHXRtLPKeuxHppo70PQ2AeY0j
         SdtEdawpRhu+zij6GK8Q65xs3nV0Nu9MVkeyzUgz2sqn5X9psxLdyEQZ/uv9321MIWkT
         h1HR22OSDqeKDN9EzwVDJHC8nCil6zqAtiGFOiTez/U6wYiGMJGl09bEUUBKRXg/rWWu
         WxNibd1Httx/noTkil85pAegBp6nXP31tjTxwA7TNa/FqOY/1ikZp7tvrEjM1G5YA9ka
         kQa6miQn8Jw9IMLlwh5MBd6ZalMeB6qp2uYsxvJ857B2VrEUEB0ry0C+pKNIMXjCDdLj
         arnA==
X-Gm-Message-State: AOJu0Yx5iglgEA0+vAX3NqSCLpjsx490kEXQzUjkMPVYf77ETwU1p7li
        4W9c96egqILf3iON+YUkHdIERR15GvwbsfAygNiPqyYIE2AsYHJfCmxqFMBby5d+ew0gHx9gTAD
        gz43h+XohVxt2SUPr3aC8t2dY
X-Received: by 2002:a05:600c:4312:b0:40a:5b3c:403 with SMTP id p18-20020a05600c431200b0040a5b3c0403mr9591478wme.14.1701157990535;
        Mon, 27 Nov 2023 23:53:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkKv1KOQdshB9/dvB9axHpdpJTKux/xN+DaSsnqos22H4Ya2ymZa3yFlYzeR7EMvJI63X0EA==
X-Received: by 2002:a05:600c:4312:b0:40a:5b3c:403 with SMTP id p18-20020a05600c431200b0040a5b3c0403mr9591465wme.14.1701157990169;
        Mon, 27 Nov 2023 23:53:10 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id c37-20020a05600c4a2500b003fee6e170f9sm16206179wmp.45.2023.11.27.23.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:53:09 -0800 (PST)
Message-ID: <4eda2ec5444cc151279d5b571a158a60a5406e1f.camel@redhat.com>
Subject: Re: [RFC 28/33] x86/hyper-v: Introduce memory intercept message
 structure
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        anelkz@amazon.com, graf@amazon.com, dwmw@amazon.co.uk,
        jgowans@amazon.com, corbert@lwn.net, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, x86@kernel.org,
        linux-doc@vger.kernel.org
Date:   Tue, 28 Nov 2023 09:53:07 +0200
In-Reply-To: <20231108111806.92604-29-nsaenz@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
         <20231108111806.92604-29-nsaenz@amazon.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-08 at 11:18 +0000, Nicolas Saenz Julienne wrote:
> Introduce struct hv_memory_intercept_message, which is used when issuing
> memory intercepts to a Hyper-V VSM guest.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 76 ++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index af594aa65307..d3d74fde6da1 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -799,6 +799,82 @@ struct hv_get_vp_from_apic_id_in {
>  	u32 apic_ids[];
>  } __packed;
>  
> +
> +/* struct hv_intercept_header::access_type_mask */
> +#define HV_INTERCEPT_ACCESS_MASK_NONE    0
> +#define HV_INTERCEPT_ACCESS_MASK_READ    1
> +#define HV_INTERCEPT_ACCESS_MASK_WRITE   2
> +#define HV_INTERCEPT_ACCESS_MASK_EXECUTE 4
> +
> +/* struct hv_intercept_exception::cache_type */
> +#define HV_X64_CACHE_TYPE_UNCACHED       0
> +#define HV_X64_CACHE_TYPE_WRITECOMBINING 1
> +#define HV_X64_CACHE_TYPE_WRITETHROUGH   4
> +#define HV_X64_CACHE_TYPE_WRITEPROTECTED 5
> +#define HV_X64_CACHE_TYPE_WRITEBACK      6
> +
> +/* Intecept message header */
> +struct hv_intercept_header {
> +	__u32 vp_index;
> +	__u8 instruction_length;
> +#define HV_INTERCEPT_ACCESS_READ    0
> +#define HV_INTERCEPT_ACCESS_WRITE   1
> +#define HV_INTERCEPT_ACCESS_EXECUTE 2
> +	__u8 access_type_mask;
> +	union {
> +		__u16 as_u16;
> +		struct {
> +			__u16 cpl:2;
> +			__u16 cr0_pe:1;
> +			__u16 cr0_am:1;
> +			__u16 efer_lma:1;
> +			__u16 debug_active:1;
> +			__u16 interruption_pending:1;
> +			__u16 reserved:9;
> +		};
> +	} exec_state;
> +	struct hv_x64_segment_register cs;
> +	__u64 rip;
> +	__u64 rflags;
> +} __packed;


Although the struct/field names in the TLFS spec are terrible for obvious reasons,
we should still try to stick to them as much as possible to make one's life
less miserable when trying to find them in the spec.

It is also a good idea to mention from which part of the spec these fields
come (hint, it's not from VSM part).

Copying here the structs that I found in the spec:

typedef struct
{
	HV_VP_INDEX VpIndex;
	UINT8 InstructionLength;
	HV_INTERCEPT_ACCESS_TYPE_MASK InterceptAccessType;
	HV_X64_VP_EXECUTION_STATE ExecutionState;
	HV_X64_SEGMENT_REGISTER CsSegment;
	UINT64 Rip;
	UINT64 Rflags;
} HV_X64_INTERCEPT_MESSAGE_HEADER;


typedef struct
{
	UINT16 Cpl:2;
	UINT16 Cr0Pe:1;
	UINT16 Cr0Am:1;
	UINT16 EferLma:1;
	UINT16 DebugActive:1;
	UINT16 InterruptionPending:1;
	UINT16 Reserved:4;
	UINT16 Reserved:5;
} HV_X64_VP_EXECUTION_STATE;


For example 'access_type_mask' should be called intercept_access_type,
and so on.



> +
> +union hv_x64_memory_access_info {
> +	__u8 as_u8;
> +	struct {
> +		__u8 gva_valid:1;
> +		__u8 _reserved:7;
> +	};
> +};

typedef struct
{
	UINT8 GvaValid:1;
	UINT8 Reserved:7;

} HV_X64_MEMORY_ACCESS_INFO;

> +
> +struct hv_memory_intercept_message {
> +	struct hv_intercept_header header;
> +	__u32 cache_type;
> +	__u8 instruction_byte_count;

If I understand correctly this is the size of the following
'instruction_bytes' field?


> +	union hv_x64_memory_access_info memory_access_info;
> +	__u16 _reserved;
> +	__u64 gva;
> +	__u64 gpa;
> +	__u8 instruction_bytes[16];
> +	struct hv_x64_segment_register ds;
> +	struct hv_x64_segment_register ss;
> +	__u64 rax;
> +	__u64 rcx;
> +	__u64 rdx;
> +	__u64 rbx;
> +	__u64 rsp;
> +	__u64 rbp;
> +	__u64 rsi;
> +	__u64 rdi;
> +	__u64 r8;
> +	__u64 r9;
> +	__u64 r10;
> +	__u64 r11;
> +	__u64 r12;
> +	__u64 r13;
> +	__u64 r14;
> +	__u64 r15;
> +} __packed;

I can't seem to find this struct at all in the spec. If it was reverse-engineered,
then we must document everything that we know to help future readers of this code.


Best regards,
	Maxim Levitsky

> +
>  #include <asm-generic/hyperv-tlfs.h>
>  
>  #endif


