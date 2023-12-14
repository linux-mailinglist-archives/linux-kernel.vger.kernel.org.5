Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B92812C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443540AbjLNJsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443523AbjLNJso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:48:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF8610C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702547330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Aac/fS+HABTTdTt9Tjp0/ej5UaiGQ4YUyORo11HpcO0=;
        b=F4xp4/2I9DPL5e0cnrcWGagZNB3xkuv8HqlAFnoECAO2Wk/Ma2nklUVXuigh6C0+uv17kq
        vMbEFzszGtF5Ai721kT+AeQPEP+Om63JS+X8OuhadQB165Voghs/lptiGAYd8UAn1v4rjo
        IaWytgFVNSiIvw3vqFm7TKZeE3DYfKI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-QsLy1bi7PsGcS6wBMVElAg-1; Thu, 14 Dec 2023 04:48:49 -0500
X-MC-Unique: QsLy1bi7PsGcS6wBMVElAg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-54c5f4a05f8so4844935a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:48:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702547328; x=1703152128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aac/fS+HABTTdTt9Tjp0/ej5UaiGQ4YUyORo11HpcO0=;
        b=KhoVcXnvyG0vIshGoGNNufm6vGUImyjryfH7wlynGkUJaXmeDz4WS4JzBhsjrgKtRD
         E9nh+PCcKNe9DN4ndJm84V3Ai+31uLqwGKLc16GzuOU+wgehZ/A02GJ9LgpEynQ03eno
         xAu1qf8HBBC43xf2BGiJ45ryzCuAFptTUykWyJq1cR9v1EPOicMYfbxDaEVR45xSwIat
         yUziH34nsjsjABT+KyljLmSQ6kU3WzUQ85yAdJoqUzphVdECvdAkBs+N1cGSDGXQbRxJ
         bO2sLCrisht2rmv5fAEEXXTdXAkdFU99BZfwR5qkLThbEsgb/KC2ADOMRngcaW6Vw6FB
         eadQ==
X-Gm-Message-State: AOJu0YxqODyZmz89qL94o7Yz9/LC93vqpORriQLfVFhmaMZTd5m/vO9G
        v4GOFQvOEDGrJyGmisvvcUA/DjHWmx7NbqapdjZ5T3cjZxlfon48QVA4nhb8atCJZc9EVzygBVN
        /gFSnaiISb0E9Aq7WLSE9eI+zCtkZCotH
X-Received: by 2002:a50:d692:0:b0:551:e5ea:cd32 with SMTP id r18-20020a50d692000000b00551e5eacd32mr1623887edi.23.1702547327867;
        Thu, 14 Dec 2023 01:48:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfAPTl0ZBTHUgp9clExLMwVaQJM4BXpD6DoX/3U7sXNMttZ5MP+uupqGj8TWjV6I+QQzg05Q==
X-Received: by 2002:a50:d692:0:b0:551:e5ea:cd32 with SMTP id r18-20020a50d692000000b00551e5eacd32mr1623879edi.23.1702547327612;
        Thu, 14 Dec 2023 01:48:47 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id k13-20020a50cb8d000000b0054cc7a4dc4csm6427998edi.13.2023.12.14.01.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 01:48:46 -0800 (PST)
Message-ID: <a65ca848-20cc-4794-9731-c84eaa295fbc@redhat.com>
Date:   Thu, 14 Dec 2023 10:48:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev/simplefb: change loglevel when the power domains
 cannot be parsed
Content-Language: en-US, nl
To:     Brian Masney <bmasney@redhat.com>, deller@gmx.de
Cc:     treding@nvidia.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20231212195754.232303-1-bmasney@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231212195754.232303-1-bmasney@redhat.com>
Content-Type: text/plain; charset=UTF-8
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

Hi,

On 12/12/23 20:57, Brian Masney wrote:
> When the power domains cannot be parsed, the message is incorrectly
> logged as an info message. Let's change this to an error since an error
> is returned.
> 
> Fixes: 92a511a568e4 ("fbdev/simplefb: Add support for generic power-domains")
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Thank you for your patch. I have pushed this to drm-misc-next now.

Regards,

Hans



> ---
>  drivers/video/fbdev/simplefb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index 6f58ee276ad1..028a56525047 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -470,7 +470,7 @@ static int simplefb_attach_genpds(struct simplefb_par *par,
>  		if (err == -ENOENT)
>  			return 0;
>  
> -		dev_info(dev, "failed to parse power-domains: %d\n", err);
> +		dev_err(dev, "failed to parse power-domains: %d\n", err);
>  		return err;
>  	}
>  

