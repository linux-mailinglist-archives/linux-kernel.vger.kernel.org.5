Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930C57A8A69
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjITRRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjITRRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:17:17 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186CCA9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 10:17:12 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c1e3a4a06fso22175ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 10:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695230231; x=1695835031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QOS+5EG5HCh/KtSWQpSt4vXKPupbqZZS9Bbcm1Xg6BE=;
        b=Mc5qD3YSA+Hfs+CNVesH+r0DuUIxOSIx7DN3/kpHVlpBO1w6RnVBsIlhKrLkVM00X5
         DUxY5WlBaOlnl8aTDCKp1uDhOZ+QiVERMU7EWVySlr4qAXmJu2RyISJVqoirlejS7acN
         xJgGW8nJpIWS9499MNauANQ3B15gdVYKHR6QVsXyP/T53vzvYN5MD0Wnp3w/w/682nDE
         vr+MBOFgK/xh9proh1fy9ABQBk3HzF3b8ROcCf9KVQHWkOoH4i0Ss+0i2q7/Wooxj/e7
         7gowoaGoi8AEfkDs5NS04tVIhMNezB20CmUkixM1z4U2QRg3qYaKXVfgH3GVf0VZrDMl
         aCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695230231; x=1695835031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOS+5EG5HCh/KtSWQpSt4vXKPupbqZZS9Bbcm1Xg6BE=;
        b=rtBd2zMtL4kEr/RZ3aIJVHWfhIHuFhjVRBWeEU5RyUzi8P0yK8Dl4A6SDXyNDMk9T4
         VWg3vlVzcdEc09f5NnW7D/V0PqVzswowK3kY4oPoOHmZHcjz3gQrZo9NcFI+DWlrgH5S
         8ZSdg87lEIJTYbIH3a3Kd7shrSsCszkLZ+zF1RyyVcLtURwemh8T713z0OkerNKeR7mk
         3Kgm+wllkZqzr/ai15w+Wi0MqYzG52fRa1LaHeePNFox3PWcgRlKc2mkimqdoh8ZY3vI
         IFt0TsaPbP7Gd5h4p4gWeQ6ilMaj0709ftq01NkWFPd/z82pJQdAhRDmapmG5axx5/pV
         b5AQ==
X-Gm-Message-State: AOJu0YxuOVL4BC9BGGVkhapxsE0PouXCE8zGvK+AOQQ/M8MhQ7D8x3wY
        kWAH/S//bgPSzF6O2gFsvGA=
X-Google-Smtp-Source: AGHT+IEY8HDNNtZhYZANek9UW67AyxssTPWX0iiVpwERwVkPdu6/+HqVJOdZ8JTdn/GuVPGdLkAN0g==
X-Received: by 2002:a17:902:b708:b0:1bc:e6a:205f with SMTP id d8-20020a170902b70800b001bc0e6a205fmr2506031pls.20.1695230231447;
        Wed, 20 Sep 2023 10:17:11 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id u7-20020a170903124700b001bb0eebd90asm12071760plh.245.2023.09.20.10.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 10:17:10 -0700 (PDT)
Date:   Wed, 20 Sep 2023 10:14:56 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 1/4] bitmap: define a cleanup function for bitmaps
Message-ID: <ZQsokMJmD548DZrm@yury-ThinkPad>
References: <20230920075500.96260-1-brgl@bgdev.pl>
 <20230920075500.96260-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920075500.96260-2-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 09:54:57AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add support for autopointers for bitmaps allocated with bitmap_alloc()
> et al.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  include/linux/bitmap.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 03644237e1ef..6709807ebb59 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -6,6 +6,7 @@
>  
>  #include <linux/align.h>
>  #include <linux/bitops.h>
> +#include <linux/cleanup.h>
>  #include <linux/find.h>
>  #include <linux/limits.h>
>  #include <linux/string.h>
> @@ -125,6 +126,8 @@ unsigned long *bitmap_alloc_node(unsigned int nbits, gfp_t flags, int node);
>  unsigned long *bitmap_zalloc_node(unsigned int nbits, gfp_t flags, int node);
>  void bitmap_free(const unsigned long *bitmap);
>  
> +DEFINE_FREE(bitmap, unsigned long *, if (_T) bitmap_free(_T))
> +
>  /* Managed variants of the above. */
>  unsigned long *devm_bitmap_alloc(struct device *dev,
>  				 unsigned int nbits, gfp_t flags);

Acked-by: Yury Norov <yury.norov@gmail.com>
