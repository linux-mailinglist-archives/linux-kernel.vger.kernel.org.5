Return-Path: <linux-kernel+bounces-120576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DF088D99D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528E91F2D34B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470D14644F;
	Wed, 27 Mar 2024 08:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpEcppkS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B4B3EA86
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529635; cv=none; b=tQw5qgROOtZkOana7ehoiGK0uxwrmOJsyMXXaCBEG9oDo3T6SXDuaQ4ksZm063bcCfaw65qvfenBf7J2wlmSHViZxqCRw9zUBlA1ATTGvRmqPUDJKRVR0KEzqy0jRiv8fAaT9x6mCCJjOCWAIRkv3LyiXm/WrPwfwZ6eITaK/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529635; c=relaxed/simple;
	bh=G+lQKyO8XYPtuMapTR34hMDUALueaAFeQ9enFHtzrQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ke3b13gelYeXPxMbQeK36RUGYemmP7fryVNQ4dWd0mEJ5f5knW/E3Yz6jl8n6J0ExbTPXVW2XZe8cC6fyqj9B8AAiK7hdOgP6MSZd7CWY4RO3Ra1aATucH8nH0qDO3uUQzKOv5oq9zWZF8n6rwkXbxt32yoeg9Scd+xy5ir78rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GpEcppkS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711529632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQayDiLeMZdAEU12a7XUqQdU0MXKYllLESqhbcKtdFY=;
	b=GpEcppkSbyJfy7XRPxQOAfsdM/W4YH/DIfVDFrJ4CW1YyvLGQa0lFt71CE9kWedjMcPnJB
	47qK7MgAYvQVKxynr49wotxwbrmKl+yScTzJRCrHe0DxHzgkW3qxSVtZ93I073Vj/ZNSxZ
	O9+qQhUG1KQMwM05pkgqNL9rxVgb4SQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Lpk-1W4GMAe_Ie7AhY_Wbw-1; Wed, 27 Mar 2024 04:53:49 -0400
X-MC-Unique: Lpk-1W4GMAe_Ie7AhY_Wbw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e435a606aso35053985e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 01:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711529627; x=1712134427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQayDiLeMZdAEU12a7XUqQdU0MXKYllLESqhbcKtdFY=;
        b=ophglYL56UInTj0xhTJpXBDabNTgwVrPCNXEGuPCeHN9OXdz74vFVnjfOMj1HF/Hn/
         T0UFjWIMBkCa4oxrjq7wiSdbYzBYeKjnxOmPE2EG2XN9g+dNvZnF1FzYk8kg4SonlEj1
         g5NwNl1pt2OXvyZQkdcytH5HWGfu3jUAIAqnDJnK8xN9aNOcrPaypWAwiZv0lCmQEDh3
         efIQVsPCPUQbHG5ZXt3ZRl9/QtMSXcmUJpcBD0/t+oTkJtYd8MDq/hbvpEHUHh+QppnL
         HED84+5WlLciA+aL2V9iNn3P8fXjhFO/Wmiun48KOM6obP07fD8gSEenhAU9dKWWhHZK
         KXxA==
X-Forwarded-Encrypted: i=1; AJvYcCXEruen4sZlF3YfK9OWTLyiGjMa72DreBouO8HwknqM3FtwCF9Mih6sh0TX8e6pWT2591SYY+4gtLATfr9XXWm0CE8nHYXNMex/5ksO
X-Gm-Message-State: AOJu0YymfvfD5wPSGV9JHNonOSD+5ZZ27WATifFNCFKi8MfKChI90GM5
	RjklNlDiQSVswNrsidV6sCj+tTB7vFrvDk8O/zbJX7tA/4oYHfwV4IxwPW40R7OHgN8VcjTz9HJ
	V5p9XhcuDFDgWK1vVODsogQhPYu/zyQhVwcgGBqhql47L1QuHT3PqLQToF5aEsQ==
X-Received: by 2002:adf:f451:0:b0:33e:48f9:169d with SMTP id f17-20020adff451000000b0033e48f9169dmr501991wrp.31.1711529627013;
        Wed, 27 Mar 2024 01:53:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyYZsP9X3qxXI8cZXakmL7rjWFiYhk/YTocnXK2U91YBDzGTzDlmcuOk2/rHJDPaHGdtJnTA==
X-Received: by 2002:adf:f451:0:b0:33e:48f9:169d with SMTP id f17-20020adff451000000b0033e48f9169dmr501974wrp.31.1711529626671;
        Wed, 27 Mar 2024 01:53:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id bt17-20020a056000081100b00341b5cf0527sm4147245wrb.11.2024.03.27.01.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 01:53:46 -0700 (PDT)
Message-ID: <c04ebd16-f0b0-45be-a831-fae8b50b7011@redhat.com>
Date: Wed, 27 Mar 2024 09:53:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ast: Fix soft lockup
Content-Language: en-US, fr
To: Jammy Huang <orbit.huang@gmail.com>, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@redhat.com,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jammy Huang <jammy_huang@aspeedtech.com>, stable@vger.kernel.org
References: <20240325033515.814-1-jammy_huang@aspeedtech.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20240325033515.814-1-jammy_huang@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Thanks for your patch.
I'm wondering how you can trigger this infinite loop ?

Also this looks like a simple fix, that can be easily backported, so I'm 
adding stable in Cc.

If Thomas has no objections, I can push it to drm-misc-fixes.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

-- 

Jocelyn

On 25/03/2024 04:35, Jammy Huang wrote:
> Avoid infinite-loop in ast_dp_set_on_off().
> 
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>   drivers/gpu/drm/ast/ast_dp.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
> index ebb6d8ebd44e..1e9259416980 100644
> --- a/drivers/gpu/drm/ast/ast_dp.c
> +++ b/drivers/gpu/drm/ast/ast_dp.c
> @@ -180,6 +180,7 @@ void ast_dp_set_on_off(struct drm_device *dev, bool on)
>   {
>   	struct ast_device *ast = to_ast_device(dev);
>   	u8 video_on_off = on;
> +	u32 i = 0;
>   
>   	// Video On/Off
>   	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xE3, (u8) ~AST_DP_VIDEO_ENABLE, on);
> @@ -192,6 +193,8 @@ void ast_dp_set_on_off(struct drm_device *dev, bool on)
>   						ASTDP_MIRROR_VIDEO_ENABLE) != video_on_off) {
>   			// wait 1 ms
>   			mdelay(1);
> +			if (++i > 200)
> +				break;
>   		}
>   	}
>   }
> 
> base-commit: b0546776ad3f332e215cebc0b063ba4351971cca


