Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C397757476
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjGRGj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjGRGjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:39:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14916136
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689662347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uGWZGJs7iJ0bHkmNYO8V4KcHUQKd/vxJD2N3uDsccto=;
        b=ZuJAJ03Aj/fuw3xOsSNe3JNbS8PgII33FmcISQ6GJZgsycnnrj4+xED3sqi9+7yKHPxSvd
        JbzObVey2c0DY67oEu8RL8D449xd+Y1YerzVGae5xn1aC/QpSWYbzYN0W+Sr4HVVeesaKx
        eXRZbLhv6juivM2lkZCpSTk8jaJxgLc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-GsR9qr1RM32b71Hcv2kA8g-1; Tue, 18 Jul 2023 02:39:05 -0400
X-MC-Unique: GsR9qr1RM32b71Hcv2kA8g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30e6153f0eeso2936042f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689662344; x=1692254344;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGWZGJs7iJ0bHkmNYO8V4KcHUQKd/vxJD2N3uDsccto=;
        b=U03PPQ0bhi6ldyVB4/QL3csZ6ABr4jtLjQ22TLNV2QkuGbHKPhXCM12fSIOX0Vgg2G
         33paXpoHPD0m4A1mIQonO2UDJ226QBYIytbnEtyziGFvn8WFXApQT8MCwQGG1cGo2I2a
         9f2/dZk1ob6J+TdoKAyvwPvZKau/Q8DqsT+3MrbhnZ9in3KbempNT2cfkdssdcjgyEgQ
         UpSnhmW/9BYCVlZo/kc1NyGsh3bWkkcJmxkKX6tg8vOSZBdSIXf/KooQM5FqwpUdzL6w
         T32kdaZ4nzHcM5au9jN6z5TKB6in495gKe02EDBvfNJMCOjY2T/y5xKvWt5t3WJkDBtg
         Vxaw==
X-Gm-Message-State: ABy/qLa0S3tahT6m3tS8B3Aat1qnFG2GRB0H8PDyCPdh6eTersO9ev/F
        ixyRID9+zhy/vWSu+iNxOIAO9Q264o/b97z+D0I/5xoH/RT1vUN+6xwkOcoU+Iq04pe7qj6f81S
        T9TOYawq3405pf25RZJ2awsAOOXZioiT7
X-Received: by 2002:adf:d4c7:0:b0:314:268b:21f1 with SMTP id w7-20020adfd4c7000000b00314268b21f1mr11320611wrk.18.1689662344258;
        Mon, 17 Jul 2023 23:39:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHv18uaI93wFrqmmHeM+/M9p05Ssvf+TiET1HDtjWoK2EEJHqu10sNXHiTb6Zw0EgXCaxftWA==
X-Received: by 2002:adf:d4c7:0:b0:314:268b:21f1 with SMTP id w7-20020adfd4c7000000b00314268b21f1mr11320599wrk.18.1689662343997;
        Mon, 17 Jul 2023 23:39:03 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c7-20020adfe747000000b003143c9beeaesm1393087wrn.44.2023.07.17.23.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 23:39:03 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Luc Ma <onion0709@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        onion0709@gmail.com
Subject: Re: [PATCH] dma-buf: remove unintended hyphen in the sysfs path
In-Reply-To: <64b5dc93.170a0220.243d5.1d63@mx.google.com>
References: <64b5dc93.170a0220.243d5.1d63@mx.google.com>
Date:   Tue, 18 Jul 2023 08:39:03 +0200
Message-ID: <87zg3tiv08.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
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

Luc Ma <onion0709@gmail.com> writes:

> From: Luc Ma <luc@sietium.com>
>
> Signed-off-by: Luc Ma <luc@sietium.com>
> ---

Even when is a trivial change I would add something as commit message, i.e:

"The kernel-doc mentions /sys/kernel/dma-buf/buffers but the correct path
is /sys/kernel/dmabuf/buffers instead. Fix the typo in the documentation".

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

