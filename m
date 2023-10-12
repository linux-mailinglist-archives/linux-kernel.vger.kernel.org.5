Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F727C7563
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379619AbjJLR6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379684AbjJLR6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:58:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2052BB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697133485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FVsd25JJrPKVfuhRRuS6kpquTIw0T//+HNpizwkPWZ0=;
        b=LV60t54gnhA/1beN1Vl8qe+aOQuZu07aNUCQJOj4PsF4NGeb6Bvmdp1sUm9bDHpN2DrYqo
        +DlxW+XcFgXqccoGutKmuOpCLuKGo4GkzThSHsrymF9MBdcrwbRtJbAkU7friXoBx4NTCq
        QqANCNs1/OK0zmWvxnl1S6Fynwei2bY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-nF0KB5xuPbueV05CX2Xzxw-1; Thu, 12 Oct 2023 13:58:04 -0400
X-MC-Unique: nF0KB5xuPbueV05CX2Xzxw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a9e12a3093so138883666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133483; x=1697738283;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVsd25JJrPKVfuhRRuS6kpquTIw0T//+HNpizwkPWZ0=;
        b=qWCXdgS8f5rUlGSkWpx/10OVb5PXoePDS6/Lvqio9U5ysKSu4w7YH84iLupH4UiLNv
         kCEwoe/xT77FdUSOFQgQrR5kip4IAXdZ/PzvYcTQO4FpSJrflPZiyfkPIMYsog5DHYM1
         5nqodFZ+XJmFKb4zmqDoheQYRTE6Mn+9MjQGolNctPuSVlhv7UDLPncFZl4Nhr4p1a2J
         S0TQ0YBU+vStUS5FqPJ8QBEK5h0pHC0V9UjPvnQtdxtqN6x0tZm4/O1ywJacvRsiObfr
         e2tjccLIF3qzRWhrJ53y/mhdjBMFVfaMG0D+phZj0th2v9oLHxJHi+S+xiXurNajsV+U
         gfCw==
X-Gm-Message-State: AOJu0YybmGqwIiuxtWbIeRuZxEmGVLx8j5PeVAi4ESBXFxdVyudlUNfI
        mKKH0Fhp/1Vc4unX5XfxiVf4WF/t1zDYvwezkbgRIJI7h+KW2fSOUGdBRjVzIZWdAQSPnS6M/aB
        MY1MR/VGJX1nyYktK61MK0fgj
X-Received: by 2002:a17:907:7601:b0:9ba:b5:cba6 with SMTP id jx1-20020a170907760100b009ba00b5cba6mr16976172ejc.14.1697133483533;
        Thu, 12 Oct 2023 10:58:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9Ev4jZ1AjQIWBFFW64KwIs1qrFVUApRQO2mPNRQF9ONEf/GfLbNT6HeVYBtT/urA60vGy7A==
X-Received: by 2002:a17:907:7601:b0:9ba:b5:cba6 with SMTP id jx1-20020a170907760100b009ba00b5cba6mr16976161ejc.14.1697133483205;
        Thu, 12 Oct 2023 10:58:03 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id gz24-20020a170906f2d800b00985ed2f1584sm11393950ejb.187.2023.10.12.10.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 10:58:02 -0700 (PDT)
Message-ID: <78f3a73d-3c2a-4432-8ac5-9e4418f509cb@redhat.com>
Date:   Thu, 12 Oct 2023 19:58:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau/dispnv04: fix a possible null pointer
 dereference
Content-Language: en-US
To:     Ma Ke <make_ruc2021@163.com>
Cc:     kherbst@redhat.com, lyude@redhat.com, airlied@gmail.com,
        daniel@ffwll.ch, noralf@tronnes.org, tzimmermann@suse.de,
        mripard@kernel.org, jani.nikula@intel.com,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20231007032349.3997387-1-make_ruc2021@163.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20231007032349.3997387-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/23 05:23, Ma Ke wrote:
> In nv17_tv_get_ld_modes(), the return value of drm_mode_duplicate()
> is assigned to mode, which will lead to a NULL pointer dereference
> on failure of drm_mode_duplicate(). Add a check to avoid npd.
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>

Reviewed-by: Danilo Krummrich <dakr@redhat.com>

> ---
>   drivers/gpu/drm/nouveau/dispnv04/tvnv17.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> index 670c9739e5e1..4a08e61f3336 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> @@ -209,6 +209,8 @@ static int nv17_tv_get_ld_modes(struct drm_encoder *encoder,
>   		struct drm_display_mode *mode;
>   
>   		mode = drm_mode_duplicate(encoder->dev, tv_mode);
> +		if (!mode)
> +			continue;
>   
>   		mode->clock = tv_norm->tv_enc_mode.vrefresh *
>   			mode->htotal / 1000 *

