Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0667FE48E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 01:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343729AbjK3AI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 19:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjK3AI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 19:08:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD5F10C9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 16:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701302942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dCyXRa/HRcuMhxSELQ2U4bOOtsV2/Jacvl5LozlvP7c=;
        b=hWBPTYYztYJyXFmv0B/6XcRVmRkwJlpon/d/OIxtamqlm3Sw9vqKWf2N/Fe8k9trMgsXrm
        NrmjTIzEkC7kYqGYywBmvVbgEejayV/51iGAm2gSm/+Wjhss5lEB2zCWB4iNeKBE4A+Xnb
        hlaEK/FNkKgnLGApye/14cno5xYpQ24=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-Lun819n0Mz-kP4vWHreRTA-1; Wed, 29 Nov 2023 19:09:00 -0500
X-MC-Unique: Lun819n0Mz-kP4vWHreRTA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a00dd93a5fcso33309766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 16:09:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701302939; x=1701907739;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCyXRa/HRcuMhxSELQ2U4bOOtsV2/Jacvl5LozlvP7c=;
        b=uQdNsTXUcO3jxlUVCpvKMCS8xG2yYZnqru21+DFScWvR446/MoUGLLIMuLecaPlq9o
         y9iFN4FlpQGtZgNKklnzRqeqyLxdk+V/AkwKR/Ned3zN4YHxkWNApT2dr0QadCvwaOEl
         x6VDul9vTlFlEro+sv3CylsX0aRcFbUInb9ceZ6CwOed1jjsjOtQH4B0AhLSi3inG8F6
         2DBFtUJF2PQ+1/fQSfI3u3nVC+WKq1uRwseJHy/cg2rXJyArhrlGz0knDc9P00TijH+O
         wFEHnw7UmmGTd5UJIqibezCXgcG3W8ZyR4KclzgLog2HMoZIffu08idzxy8gsdGHc+7z
         XrDg==
X-Gm-Message-State: AOJu0YwWYbpr5qAEBdYLxu6eIXReXBRh3YFYSxo32MOHOSSvix1Zuz2V
        /EBzaeshVNzVQAs3j8OTJAuh0C/gFfekF9Q93yit/XJxSgr5pvpIWwES1lYNgCf2nPBabypQar5
        YMzgfRzenvZOKXL1Rh+63Jfr9WN1OYBHk
X-Received: by 2002:a17:906:a8d:b0:9fe:1681:22c7 with SMTP id y13-20020a1709060a8d00b009fe168122c7mr13130035ejf.26.1701302939155;
        Wed, 29 Nov 2023 16:08:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtKQWiKVVfzSK2WurxuaaT+/mGIK3WRsRM0Q64/jn5Kal8vzUIheow6+DDV7rwbMg1GSX59w==
X-Received: by 2002:a17:906:a8d:b0:9fe:1681:22c7 with SMTP id y13-20020a1709060a8d00b009fe168122c7mr13130025ejf.26.1701302938899;
        Wed, 29 Nov 2023 16:08:58 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ay19-20020a170906d29300b00a0c3b122a1esm26634ejb.63.2023.11.29.16.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 16:08:58 -0800 (PST)
Message-ID: <feefd689-780c-4314-a020-00826e09472a@redhat.com>
Date:   Thu, 30 Nov 2023 01:08:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau: Removes unnecessary args check in
 nouveau_uvmm_sm_prepare
Content-Language: en-US
To:     Yuran Pereira <yuran.pereira@hotmail.com>
Cc:     kherbst@redhat.com, lyude@redhat.com, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        nouveau@lists.freedesktop.org
References: <GV1PR10MB65637F4BAABFE2D8E261E1DCE8B0A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <GV1PR10MB65637F4BAABFE2D8E261E1DCE8B0A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/23 21:52, Yuran Pereira wrote:
> Checking `args` after calling `op_map_prepare` is unnecessary since
> if `op_map_prepare` was to be called with  NULL args, it would lead
> to a NULL pointer dereference, thus never hitting that check.
> 
> Hence this check can be removed, and a note added to remind users of
> this function to ensure that args != NULL when calling this function
> for a map operation as it was suggested  by Danilo [1]
> 
> [1] https://lore.kernel.org/lkml/6a1ebcef-bade-45a0-9bd9-c05f0226eb88@redhat.com
> 
> Suggested-by: Danilo Krummrich <dakr@redhat.com>
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>

Applied to drm-misc-next.

> ---
>   drivers/gpu/drm/nouveau/nouveau_uvmm.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> index 5cf892c50f43..c8c3f1b1b604 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -604,6 +604,10 @@ op_unmap_prepare(struct drm_gpuva_op_unmap *u)
>   	drm_gpuva_unmap(u);
>   }
>   
> +/*
> + * Note: @args should not be NULL when calling for
> + * a map operation.
> + */
>   static int
>   nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
>   			struct nouveau_uvma_prealloc *new,
> @@ -624,7 +628,7 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
>   			if (ret)
>   				goto unwind;
>   
> -			if (args && vmm_get_range) {
> +			if (vmm_get_range) {
>   				ret = nouveau_uvmm_vmm_get(uvmm, vmm_get_start,
>   							   vmm_get_range);
>   				if (ret) {

