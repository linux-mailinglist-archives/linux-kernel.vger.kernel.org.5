Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350577FCC96
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 03:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjK2CJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK2CJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:09:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018EC1735
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 18:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701223753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yaVTVjwPsRLQvhHQX/AWNDhOssIGmmbDVerq5y+xWjc=;
        b=dsNFDOqtd5alsOcWCw4QrKAC4LNN62AZxVhKUCMenysNzqkGCkz8AXbqV0iyaexW+DMiiY
        HkOcbtmhPn5iX3quHwZ819Kr4nGKn2K8LS2M/M1ZtjkTwivYtZg/q0pU6X4dSADytxAY5s
        tZYIzjGnrScwXKapuzmUCf+DBGgIJDQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-FO9fiMhMPo6RHoba12kjLQ-1; Tue, 28 Nov 2023 21:09:12 -0500
X-MC-Unique: FO9fiMhMPo6RHoba12kjLQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-54af6c23f5aso3414170a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 18:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701223751; x=1701828551;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yaVTVjwPsRLQvhHQX/AWNDhOssIGmmbDVerq5y+xWjc=;
        b=R/X2JewYm7OsWY5HLINSq5tUUWUyEUTkN6muNGNUHitmfOm6TQn3YPm2GWTp0utnXV
         vhPvIMkTuE79rujFp2NtfQPt/EcYdGf5Ry+h0hRq+luqrgN3fh+qnBdLyRtqcPjzYt/J
         YHnkXWsu//4hyaTUiWnPiv0MP30+nXUYM0Jwvxmu/S3dMSt1zP9cWkh28p/UJjln8ydn
         DV/0hcgZ6T0QYRB0HE+0eskbbq/O93PHvVUnA0q9rkwrjoDT/g086UdqI0ciOkDtXxe+
         fCfsc6saZELqSLw519soVcJaVxdIEmaIFdM/wQPtsLZ06fqgtxltLqUNrJlkmMybkpfl
         73Cg==
X-Gm-Message-State: AOJu0YxTyQGB4Z2OLTPl34gqQRbNo6boFFMLdfdT4yCxBU3tP6cbl+9E
        YUe+DtZnR/DfGGEbZLlqOsOMB5+6gxM+0i/1c64evpf3v3/x2kfwi+p4WYCJXJyHqYCS0nXqmie
        5L6kpq/vT1joh+Y615Moi64oc
X-Received: by 2002:a50:c014:0:b0:548:5629:81d0 with SMTP id r20-20020a50c014000000b00548562981d0mr10471182edb.42.1701223751273;
        Tue, 28 Nov 2023 18:09:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTXj86sNva9Z5Ps9fdWD2v7xHrgnGPL6vZZMQ7VdHN3+53HEGJpmfV2bjKoyYKGVn9NipKGA==
X-Received: by 2002:a50:c014:0:b0:548:5629:81d0 with SMTP id r20-20020a50c014000000b00548562981d0mr10471168edb.42.1701223751013;
        Tue, 28 Nov 2023 18:09:11 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id eg36-20020a05640228a400b0054bc5624616sm540233edb.53.2023.11.28.18.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 18:09:10 -0800 (PST)
Message-ID: <0dd7741c-b2f0-4593-b286-de918ffe8955@redhat.com>
Date:   Wed, 29 Nov 2023 03:09:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nouveau/gsp/r535: remove a stray unlock in
 r535_gsp_rpc_send()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Karol Herbst <kherbst@redhat.com>
References: <a0293812-c05d-45f0-a535-3f24fe582c02@moroto.mountain>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <a0293812-c05d-45f0-a535-3f24fe582c02@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 11/27/23 13:56, Dan Carpenter wrote:
> This unlock doesn't belong here and it leads to a double unlock in
> the caller, r535_gsp_rpc_push().
> 
> Fixes: 176fdcbddfd2 ("drm/nouveau/gsp/r535: add support for booting GSP-RM")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Good catch - applied to drm-misc-fixes.

- Danilo

> ---
>   drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
> index dc44f5c7833f..818e5c73b7a6 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
> @@ -365,10 +365,8 @@ r535_gsp_rpc_send(struct nvkm_gsp *gsp, void *argv, bool wait, u32 repc)
>   	}
>   
>   	ret = r535_gsp_cmdq_push(gsp, rpc);
> -	if (ret) {
> -		mutex_unlock(&gsp->cmdq.mutex);
> +	if (ret)
>   		return ERR_PTR(ret);
> -	}
>   
>   	if (wait) {
>   		msg = r535_gsp_msg_recv(gsp, fn, repc);

