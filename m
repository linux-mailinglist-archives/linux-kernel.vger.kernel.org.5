Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F897EED11
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjKQIEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQIEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:04:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37AFB7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700208235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SSjGLJu7XF01eP3l5L5+n+lDfOwEOlxpIkXKZr/vgis=;
        b=AMPzoTTFJWM+vhe7yacMlTYJwYh5aR2DvTIv1eWwheL4CM8PM2GfeTlrRG0OylHv5KpLx+
        bZjB5QVfWk6A1mcV2WaiGnbsi/puEGs0dVeuBW4Ry/2HXlXT6XVYhmxEuJyd8dlzZwx2p0
        1A5Gn6XT+6b7wP3J19qNbFv59ihZnu0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-cJkDvTZHM0urABhfSd5P_g-1; Fri, 17 Nov 2023 03:03:54 -0500
X-MC-Unique: cJkDvTZHM0urABhfSd5P_g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4091c9bdb8eso13615265e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700208233; x=1700813033;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSjGLJu7XF01eP3l5L5+n+lDfOwEOlxpIkXKZr/vgis=;
        b=w1dNPSlsVSABKRpL3XPQKsLHv6su0CHbydrSaIBIktEadk6wFl8tt5o/R1rdkbqnb1
         p85/vhMJkV2L4lmzUGkC+Jpfp5GV7eYbv8OSeVfpsMwZdU/0U0p/bLl3HBg7Ue63Z4Ji
         Oi7JfxwK6llz3OjyJG0S+w/F0HeivvnRHvSw+kgeS6J4K5iUc+YnKsWOThMhXruYLR2F
         iYrXHydMzuH3oSpjYZPa5li5228p5GbsxQBcCt/LRWlHIODi2EPcJsJYo3VzZ6Alegl/
         2K3yfc6o8iIiHtJiNyeQ8yPAw5tsmXqZa3OizEUqTJCM/HYpe3Q1AQqnxHpz/O7pw4mY
         gfcw==
X-Gm-Message-State: AOJu0Yy9HsgkanUu830bEDo/1mJTmBHqYMPsMl/raaCqwRsj46K+8G2n
        hGmeRr9Nn4iX2+tifuBB/ph5jIeyM0NCWtZPsd+yaQQS31La52qB9no0lGkVZUDfX0pnQtceZXL
        5kqfS2CyUG3s1lLgUxVmxTIqO
X-Received: by 2002:a5d:47c2:0:b0:32f:c188:38ec with SMTP id o2-20020a5d47c2000000b0032fc18838ecmr4365810wrc.16.1700208233052;
        Fri, 17 Nov 2023 00:03:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZ3B8sBxZjOwVSuhhG1BKCYOiHR+59JD/uoZSEiTZfAGQV+12ksFl2dbvoDPKTF+TX0GP6HQ==
X-Received: by 2002:a5d:47c2:0:b0:32f:c188:38ec with SMTP id o2-20020a5d47c2000000b0032fc18838ecmr4365785wrc.16.1700208232750;
        Fri, 17 Nov 2023 00:03:52 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r7-20020a056000014700b0032fab28e9c9sm1525182wrx.73.2023.11.17.00.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 00:03:52 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Mostafa Weshahy <mweshahy@yahoo.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        noralf@tronnes.org, mweshahy@yahoo.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        daniel@zonque.org
Subject: Re: [PATCH] drm/ili9163: Add "1.8-128160EF" to spi_device_id table
In-Reply-To: <20231116185124.13887-1-mweshahy@yahoo.com>
References: <20231116185124.13887-1-mweshahy.ref@yahoo.com>
 <20231116185124.13887-1-mweshahy@yahoo.com>
Date:   Fri, 17 Nov 2023 09:03:51 +0100
Message-ID: <87fs1424d4.fsf@minerva.mail-host-address-is-not-set>
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

Mostafa Weshahy <mweshahy@yahoo.com> writes:

Hello Mostafa,

> drm/ili9163: Add "1.8-128160EF" to spi_device_id table
>
> Currently enabling CONFIG_TINYDRM_ILI9163 driver - regardless of the device
> tree - results in the below confusing log line:
> SPI driver ili9163 has no spi_device_id for newhaven,1.8-128160EF
>
> This commit fixes this false alarm by adding "1.8-128160EF" to
> spi_device_id table of ili9163 driver.
>

It's not actually a false alarm, this is needed if you want the driver
module to be automatically loaded. Because the SPI core always reports
a MODALIAS of the form "spi:1.8-128160EF" even if the device has been
registered by OF.

So this is an actual fix since this driver can be built as a module.

> Signed-off-by: Mostafa Weshahy <mweshahy@yahoo.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

