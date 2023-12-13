Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C41E810E09
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbjLMJub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjLMJu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:50:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8B983
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 01:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702461033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1d5lTjfGL0cpfRX3W23YaewhbKiq0LrOed7Lf2Vov2M=;
        b=EDXvrrRCMzgrdfhJtO9gQUE60R9yabukJrwoxhLkHZInc8qri5EVZSeLQ1MeWuBH4R/U1M
        nnARHN4vvw+9paC4yTwTitd2cEejjOEtbvkmLho86hGhE0wm0NAi0VgREXAfs7Lpaki5Jn
        uCk5EraUlaLCjkXejJEsD3yoyIXu3Eg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-41hJxbEGNSqooWzKl0ulPQ-1; Wed, 13 Dec 2023 04:50:31 -0500
X-MC-Unique: 41hJxbEGNSqooWzKl0ulPQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40c1e05ad32so49789115e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 01:50:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702461030; x=1703065830;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1d5lTjfGL0cpfRX3W23YaewhbKiq0LrOed7Lf2Vov2M=;
        b=dAGMUQv2h9RvXrJRQi9+M/jvenYZwItZZa/7J3gcManT8ax90ujLvtCGlMWNaLyT+9
         FAQl4IPx5AjK0Zrcfb5vwIpZsrATpOwV6jL9Lw1NR7/hKCuCZPG0lTEYjcZLB1KcRTBW
         AwRQPl90SPx4iJIIWSFZnC2yUInKE23vfZ+/ge5Itpavy8AYO5XART/tUJigGWrQn6Jx
         Z2YAUZxaX4y990OCr2n3YHRFBjVDEEO8VPtUxnQJhhtZHWdb2G6UifxzA8jS+BGCDVC5
         pP7852Z0FfAT/AjtnERm4OlgwxEOFHeBltYhQ/2CFTNMCrAngHsUgVOQUoS2VobJ/jCG
         Y7ag==
X-Gm-Message-State: AOJu0Yy/b4N0JljrN9TkXVJMUwc4xy96i9oYmmOUnP2pdOMSlTwLgfaB
        9rvnTOAsp2h+oDb6NfXE5qDB6h3N6LMcZMBWftCTwnGIShNMKpJJKGyVhTDmiqovs+8ffgnEmui
        54uWIRflg36GhIwdP7xgS41qu
X-Received: by 2002:a7b:c395:0:b0:40c:3244:fec4 with SMTP id s21-20020a7bc395000000b0040c3244fec4mr3483370wmj.218.1702461030256;
        Wed, 13 Dec 2023 01:50:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgqSGM5YlkgEE4x2dZgTCXId+uIFj/eI1/Jsb2o77bKsWa4g8US0w4RLcc8W0HwMqp/ADJ5g==
X-Received: by 2002:a7b:c395:0:b0:40c:3244:fec4 with SMTP id s21-20020a7bc395000000b0040c3244fec4mr3483358wmj.218.1702461029873;
        Wed, 13 Dec 2023 01:50:29 -0800 (PST)
Received: from localhost ([84.78.248.162])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600012c400b003334041c3edsm12872969wrx.41.2023.12.13.01.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 01:50:29 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Brian Masney <bmasney@redhat.com>, hdegoede@redhat.com,
        deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, treding@nvidia.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] fbdev/simplefb: change loglevel when the power domains
 cannot be parsed
In-Reply-To: <20231212195754.232303-1-bmasney@redhat.com>
References: <20231212195754.232303-1-bmasney@redhat.com>
Date:   Wed, 13 Dec 2023 10:50:28 +0100
Message-ID: <875y12o2hn.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
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

Brian Masney <bmasney@redhat.com> writes:

Hello Brian,

> When the power domains cannot be parsed, the message is incorrectly
> logged as an info message. Let's change this to an error since an error
> is returned.
>
> Fixes: 92a511a568e4 ("fbdev/simplefb: Add support for generic power-domains")
> Signed-off-by: Brian Masney <bmasney@redhat.com>
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

Makes sense to me.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

