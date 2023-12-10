Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449C880BC8A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 19:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjLJSYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 13:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJSYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 13:24:07 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B11DA
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 10:24:14 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4258423e133so29280241cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 10:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702232653; x=1702837453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:references:cc:to:from:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFC+Ld7HDeMUs4re+B6x4b2YLJQHbLSKDEyx71KqL3A=;
        b=L1azIyFdZJh7gg+ObkdncYcgXTPyoYkWLpXUsXaUOZILUamhbsbxXhCNE+rQlZj/ST
         k54tOwvUndLh7itFxOwpMTDI59dnOxaMdNajum6A1uhCH6N4KhewfFQTT36GbnYUHAb0
         J90p4awRoElXHpv6kigyolqtrc6YdRYsvVgdCx7Re9vQPdg17jpD4bFEqXq0KEDNtvRZ
         2DbQwZ2gQzcWN1fOaS7OB3+eEJNhBHplRV661Z+W6O5SG7QG4Jd2UqGVsRGme4BMnIiI
         KbP9fSHvVsgutHzx9JpVIw1OuSN6QxVNn8n9a20vbHNW55NkGNZ02digk6uCM63I84K5
         +fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702232653; x=1702837453;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:references:cc:to:from:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VFC+Ld7HDeMUs4re+B6x4b2YLJQHbLSKDEyx71KqL3A=;
        b=bywlAhBGEymqwHCOuYoxAMarusdK269BbdU7nYOCWRgPDyNww5z5fhQQa1V+Fqt6rz
         UU20rol/TxkBkGT5yLKzEAHbd4mXEgGwAwJv6bNx0Wd3/qvRx1/CJtGt3gKRvKGU2duA
         BW6EJB7f+2+wSteAbYuxv58yr3sQ7z7YDmAsJ3MaeHW3dTA1KKlucdfGn4f/I+65WniZ
         tp17HuXcZuxysLQikfcnp+FShLrmgEaEOU6bP8A+34FARAmQZAb1RTdvVm5Q9OQ2g64s
         zCa0dhPA7Yp7/CLn+QQlqXSNc7ZiHeDNaKVoeE/YgzKUHgTYTUMm3mZ2M6nmgvsXTrUb
         K+Ng==
X-Gm-Message-State: AOJu0YyMSeW7Bv/fi6n3ONWF0v+QG5cPrYO4mUTtCcbUkdyE7HGZveVy
        jnLtInedg0qpnT0x7WxxnQ==
X-Google-Smtp-Source: AGHT+IGiwVuS82uMmowPDIIs+WOardV+vbpfdEESKrFXKPIXGeQUK50jQvQcMakDsJIXeyWrqcn+LA==
X-Received: by 2002:ac8:5795:0:b0:418:1a5c:dcc2 with SMTP id v21-20020ac85795000000b004181a5cdcc2mr5288319qta.19.1702232653469;
        Sun, 10 Dec 2023 10:24:13 -0800 (PST)
Received: from [120.7.1.23] (198-84-239-141.cpe.teksavvy.com. [198.84.239.141])
        by smtp.gmail.com with ESMTPSA id g6-20020ac84806000000b004255638e8b9sm2534715qtq.79.2023.12.10.10.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Dec 2023 10:24:13 -0800 (PST)
Subject: Re: [PATCH] drm/radeon: Prevent multiple error lines on suspend
From:   Woody Suwalski <terraluna977@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        terraluna977@gmail.com
References: <78cc3067-b458-5cf2-d9f4-908aa5a4c5d5@gmail.com>
Message-ID: <6beb3bab-b559-9333-320f-f0c03eb24326@gmail.com>
Date:   Sun, 10 Dec 2023 13:24:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.18
MIME-Version: 1.0
In-Reply-To: <78cc3067-b458-5cf2-d9f4-908aa5a4c5d5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, it has been now over 2 weeks and I have not seen any response to 
this patch.
Has it been lost in the cracks of the wide internet ? :-(

Thanks, Woody


Woody Suwalski wrote:
> # Fix to avoid multiple error lines printed on every suspend by Radeon 
> driver's debugfs.
> #
> # radeon_debugfs_init() calls debugfs_create_file() for every ring.
> #
> # This results in printing multiple error lines to the screen and 
> dmesg similar to this:
> # debugfs: File 'radeon_ring_vce2' in directory '0000:00:01.0' already 
> present!
> #
> # The fix is to run lookup for the file before trying to (re)create 
> that debug file.
>
> # Signed-off-by: Woody Suwalski <terraluna977@gmail.com>
>
> diff --git a/drivers/gpu/drm/radeon/radeon_ring.c 
> b/drivers/gpu/drm/radeon/radeon_ring.c
> index e6534fa9f1fb..72b1d2d31295 100644
> --- a/drivers/gpu/drm/radeon/radeon_ring.c
> +++ b/drivers/gpu/drm/radeon/radeon_ring.c
> @@ -549,10 +549,15 @@ static void radeon_debugfs_ring_init(struct 
> radeon_device *rdev, struct radeon_r
>  #if defined(CONFIG_DEBUG_FS)
>      const char *ring_name = radeon_debugfs_ring_idx_to_name(ring->idx);
>      struct dentry *root = rdev->ddev->primary->debugfs_root;
> -
> -    if (ring_name)
> -        debugfs_create_file(ring_name, 0444, root, ring,
> -                    &radeon_debugfs_ring_info_fops);
> +    struct dentry *lookup;
> +
> +    if (ring_name) {
> +        if ((lookup = debugfs_lookup(ring_name, root)) == NULL)
> +            debugfs_create_file(ring_name, 0444, root, ring,
> +                        &radeon_debugfs_ring_info_fops);
> +        else
> +            dput(lookup);
> +    }
>
>  #endif
>  }
>

