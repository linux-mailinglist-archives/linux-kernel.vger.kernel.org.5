Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D10768143
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 21:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjG2TNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 15:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjG2TNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 15:13:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C0010C0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 12:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690657955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lWSQBrU6mRCp0Fypx1PrcUwrNExP34WInNkCzbz01gk=;
        b=Pnr0vuzcad2C1rhI2EMXfsbjDKmrKsMCHsDfWc11ZkPuvbK7b5qKCnX32aU/AzBO4PbBBO
        I8RdqMvC8mzzDgCTbyTDt5oWH4B53FNn6zoQ1Lsn9xeP0j8FJBOIxvfhNn33Gr8kSi4F4a
        w1Ebml7sqdAAxlHBCCs5IOoE/0aj8JU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-DRh6olZ0NgavViY6GEZAuA-1; Sat, 29 Jul 2023 15:12:34 -0400
X-MC-Unique: DRh6olZ0NgavViY6GEZAuA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fd2d33fd93so20342215e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 12:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690657953; x=1691262753;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWSQBrU6mRCp0Fypx1PrcUwrNExP34WInNkCzbz01gk=;
        b=TzCe+Pb444QigCgVFn61YOaIdppQTNW8ZsIYdhR2bYmFhOuEuBz66PYOFaUY90DXCW
         ikW2lO7JGBmEC0eUNswBfcsUKVjpd+PfzTh/wWaZW/8ToYbfNFHZbehfSTgdMQRuga/F
         Evecb4TU5pGWjxPCMNGVOO6Gf7O5VF6hC6qYbLT0r0mrzxCJNUS/ru9sDIohsdw/9TpK
         secStQuFzHklpYmqe24RnEtP4HxUu3uJLgQVfYiXqFDGn+iCVH0qYLRnS5SztHxpFjQD
         twDFSpCDstnQ3azljqAAIUPhhE6wdFv/4A85xUswWdXvWljA65hEewOATKf0NS32pNyO
         b+AA==
X-Gm-Message-State: ABy/qLbJrDk5pxlVfT/Tjhd0oqhMpn5Pr9l60Y0ywJXf4my7Jl8a8i+p
        nlAgtkLjXa3BWEqW9ewVLoZgRX3toVVAjwDtB0ZnT2zmLtjUecXBCYQO3pG9F59iMXDhhn5USs7
        SacrUmJAQD1ucEeRK7eUhcIuY
X-Received: by 2002:a7b:c38e:0:b0:3fb:b5c0:a079 with SMTP id s14-20020a7bc38e000000b003fbb5c0a079mr4505869wmj.21.1690657953033;
        Sat, 29 Jul 2023 12:12:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF93XYAT4RY1qtSbPT2/uVvWEfThFDERd9HuH6O96rjBp2Y+gG2ACCyiQX3M81IP7BaftOdVA==
X-Received: by 2002:a7b:c38e:0:b0:3fb:b5c0:a079 with SMTP id s14-20020a7bc38e000000b003fbb5c0a079mr4505858wmj.21.1690657952725;
        Sat, 29 Jul 2023 12:12:32 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k3-20020a05600c0b4300b003fc015ae1e1sm7129506wmr.3.2023.07.29.12.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 12:12:32 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: Re: [PATCH v3] drm: Spelling s/randevouz/rendez-vous/
In-Reply-To: <084bf178dd676a4f07933eb9fcd04d3e30a779ba.1689600209.git.geert+renesas@glider.be>
References: <084bf178dd676a4f07933eb9fcd04d3e30a779ba.1689600209.git.geert+renesas@glider.be>
Date:   Sat, 29 Jul 2023 21:12:31 +0200
Message-ID: <874jlmy1k0.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> Fix a misspelling of "rendez-vous".
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
> v3:
>   - Add Reviewed-by,
>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

