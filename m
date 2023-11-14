Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3636C7EB50F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjKNQmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjKNQml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:42:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0CA11D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699980157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S0c77MRIfmEGYCNMMqVyI2qPOnHUBgvpZCQHCynNgK8=;
        b=GERmnqXCS6btgTnkvNuXwSapr4qSlrZNXnedtzpItu6Alli8MhEmNFIZ1B2bfAhuVLH6FH
        PmjrjMpyRn5mvrsWxxQWmmHGvzkG3XCeJiUGL4YCkefKnwA52PQVDGTIV3pfQMzyHU1A/h
        xx01W3rsJ3vqk7XbDym1ycEAvVshJSM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-pJQdRnwDOaaDQvfPVvjtQg-1; Tue, 14 Nov 2023 11:42:36 -0500
X-MC-Unique: pJQdRnwDOaaDQvfPVvjtQg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9e31708ad72so401917966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:42:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699980155; x=1700584955;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0c77MRIfmEGYCNMMqVyI2qPOnHUBgvpZCQHCynNgK8=;
        b=kFxVwgsFkd7YEwNzhJchjAmorIHocGHed3i9c9J9LyzYkFOyp2Em47sImU2Yo99CfS
         9xtJhL0d9FYpJDXcOEfuEtsWL9wUW2quZbnoYziunbuQfdmSMceMXFz7k4eae5UpqkKM
         TxYY+IIlV2lcrjTHWCdWHae7dDe0hFeO9TjdcHPxDmuxnBoFVc3mjuiV9uEdzZTjTeOX
         7ZfCzjkZse/BL0ujF7AjGJL2GlBahXc+Ynae7N6n1IMoFBkZOg4ntqotV0ZqhtCwmlvu
         viGYyzJXMTX5wSnGyQ1eui2Ad7j3Es1z8fanpoQXmMcWoZGrE5NzESyakmTOW8IQV9Op
         YrSA==
X-Gm-Message-State: AOJu0YxlJDgiV66N7K98ou7NB1BFIWnG3M/bjr1rB1ATpMnmD+4h5Vb6
        pXcSenA81CwkvC1VLPVhWns4kFDqyIX4tgfhUb1xBy/JMkRr/cgXC2wM/kwxHs4yS5eLIYRFm4B
        sl+E5Q4+N2dXIzKl9ym2dpdG0
X-Received: by 2002:a17:906:4f13:b0:9df:bc50:2513 with SMTP id t19-20020a1709064f1300b009dfbc502513mr7274333eju.65.1699980154874;
        Tue, 14 Nov 2023 08:42:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfn4c24R5W4bd+EVwrMNaRwBMuNVIsC9zYOUo2FKiKsCdAOBsvD6dioe9WjEOnxb9D3QGFVw==
X-Received: by 2002:a17:906:4f13:b0:9df:bc50:2513 with SMTP id t19-20020a1709064f1300b009dfbc502513mr7274298eju.65.1699980154501;
        Tue, 14 Nov 2023 08:42:34 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id y19-20020a170906525300b009a13fdc139fsm5766753ejm.183.2023.11.14.08.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 08:42:34 -0800 (PST)
Message-ID: <e517d560-3a1f-4e79-9bec-acdc77784bcd@redhat.com>
Date:   Tue, 14 Nov 2023 17:42:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/20] drm/gpuvm: Helper to get range of unmap from a
 remap op.
Content-Language: en-US
To:     Sarah Walker <sarah.walker@imgtec.com>,
        dri-devel@lists.freedesktop.org
Cc:     frank.binns@imgtec.com, donald.robson@imgtec.com,
        boris.brezillon@collabora.com, faith.ekstrand@collabora.com,
        airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, afd@ti.com, hns@goldelico.com,
        matthew.brost@intel.com, christian.koenig@amd.com,
        luben.tuikov@amd.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
References: <20231031151257.90350-1-sarah.walker@imgtec.com>
 <20231031151257.90350-3-sarah.walker@imgtec.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20231031151257.90350-3-sarah.walker@imgtec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 16:12, Sarah Walker wrote:
> From: Donald Robson <donald.robson@imgtec.com>
> 
> Determining the start and range of the unmap stage of a remap op is a
> common piece of code currently implemented by multiple drivers. Add a
> helper for this.
> 
> Changes since v7:
> - Renamed helper to drm_gpuva_op_remap_to_unmap_range()
> - Improved documentation
> 
> Changes since v6:
> - Remove use of __always_inline
> 
> Signed-off-by: Donald Robson <donald.robson@imgtec.com>
> Signed-off-by: Sarah Walker <sarah.walker@imgtec.com>

Reviewed-by: Danilo Krummrich <dakr@redhat.com>

Want me to apply the patch?

> ---
>   include/drm/drm_gpuvm.h | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
> index c7ed6bf441d4..c64585dc4e8e 100644
> --- a/include/drm/drm_gpuvm.h
> +++ b/include/drm/drm_gpuvm.h
> @@ -702,4 +702,32 @@ void drm_gpuva_remap(struct drm_gpuva *prev,
>   
>   void drm_gpuva_unmap(struct drm_gpuva_op_unmap *op);
>   
> +/**
> + * drm_gpuva_op_remap_to_unmap_range() - Helper to get the start and range of
> + * the unmap stage of a remap op.
> + * @op: Remap op.
> + * @start_addr: Output pointer for the start of the required unmap.
> + * @range: Output pointer for the length of the required unmap.
> + *
> + * The given start address and range will be set such that they represent the
> + * range of the address space that was previously covered by the mapping being
> + * re-mapped, but is now empty.
> + */
> +static inline void
> +drm_gpuva_op_remap_to_unmap_range(const struct drm_gpuva_op_remap *op,
> +				  u64 *start_addr, u64 *range)
> +{
> +	const u64 va_start = op->prev ?
> +			     op->prev->va.addr + op->prev->va.range :
> +			     op->unmap->va->va.addr;
> +	const u64 va_end = op->next ?
> +			   op->next->va.addr :
> +			   op->unmap->va->va.addr + op->unmap->va->va.range;
> +
> +	if (start_addr)
> +		*start_addr = va_start;
> +	if (range)
> +		*range = va_end - va_start;
> +}
> +
>   #endif /* __DRM_GPUVM_H__ */

