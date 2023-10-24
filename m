Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2237D4889
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjJXH3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjJXH3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:29:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B31B110
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 00:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698132505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xssyl2cuWO4huKRCeLzBIy8S2pbYD719FEsBYqUWtcA=;
        b=ZBcPehun1R/BlII0qGaBnDAEgocXRMUNCl0S9RkCOu5dV7Aupm0R3Lnmo52r4Xa4+xHPGN
        5KnDP1ntXBhO/bK5zuhBbXm3u/Hf3V6tZgyXmMLvFMrMMkQtwQ02NCUZwGvd8tlD62spjN
        S0w2UpUT0k49j89XY1/A4nuuyenuP3E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-Xn1X-qV9P9S08jQ_91gE2g-1; Tue, 24 Oct 2023 03:28:19 -0400
X-MC-Unique: Xn1X-qV9P9S08jQ_91gE2g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40837aa4a58so22160755e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 00:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698132498; x=1698737298;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xssyl2cuWO4huKRCeLzBIy8S2pbYD719FEsBYqUWtcA=;
        b=BI75ONZAOlnu5V1LcX4OzJ4aX/q9rwnXrNZCXN0AiF5o8hN0+vyIgNZqv0BZwwiz/l
         LwigljiqMhhg5S8lnQhkH2316daiKCaIahI2BmdRZlDGeuSRGBwmGJ/ZEkzQD8XUX/pS
         ZquUxbptMiwiNsMNdGwDsZakL/bOw+FUNlJdgMNekXO19Xd5nIqBbneiATat5Nz32c4c
         8SYRxI1g7h2qaHusDaMxPf05DuqJwxqPflkL7o0rw+ORn5+5cleoGA3qzju10fXJIGqG
         w9wr5VhUYPx/sDMi4/29qFNaYnhBUD8UzA3W+VeoB/LG1A678ZFcSCYMTszCqT/YN7RI
         3qLA==
X-Gm-Message-State: AOJu0YwNbRkLswkxw9hAQJryhEGb89LxUL2y+tXadYM3/3qmr17W3Kjq
        1IR9qVaa2I+dU++M/2lS87TeF9a5ymk3J7dCS42pv/bKEYGyrqaSefnOmmhbGdK6FN7zI/nzFx3
        wfpN8W+zzG1O3LM5lI/mZeXbZ
X-Received: by 2002:a05:600c:602a:b0:407:4126:f71c with SMTP id az42-20020a05600c602a00b004074126f71cmr14169957wmb.6.1698132498088;
        Tue, 24 Oct 2023 00:28:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYDvYHh+MlKZ7YVUkxps/fFostO9uWTdFJHZIFS+9S/NQGTJDnI4KulBOWTrPTjqcmhrY/9w==
X-Received: by 2002:a05:600c:602a:b0:407:4126:f71c with SMTP id az42-20020a05600c602a00b004074126f71cmr14169939wmb.6.1698132497770;
        Tue, 24 Oct 2023 00:28:17 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v3-20020a05600c428300b003fee8793911sm11033357wmc.44.2023.10.24.00.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 00:28:17 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        Khalid Aziz <khalid@gonehiking.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vgacon: fix mips/sibyte build regression
In-Reply-To: <20231024054412.2291220-1-arnd@kernel.org>
References: <20231024054412.2291220-1-arnd@kernel.org>
Date:   Tue, 24 Oct 2023 09:28:16 +0200
Message-ID: <877cnc1nu7.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

Hello Arnd,

> From: Arnd Bergmann <arnd@arndb.de>
>
> The conversion to vgacon_register_screen() was missing an #include statement
> for the swarm board:
>
> arch/mips/sibyte/swarm/setup.c:146:9: error: implicit declaration of function 'vgacon_register_screen' [-Werror=implicit-function-declaration]
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310240429.UqeQ2Cpr-lkp@intel.com/
> Fixes: 555624c0d10b vgacon: clean up global screen_info instances
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Loos good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

