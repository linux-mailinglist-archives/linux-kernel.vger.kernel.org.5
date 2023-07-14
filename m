Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E92753458
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbjGNHym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbjGNHyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:54:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FFC3C16
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689321144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WC74EEKhJlhJoUZcemPJUMicIDs5RJVsAsHWl0ODu1o=;
        b=B1FVXscX/vAUXM3fualnOl4msSqjyk4iqJCrmjLi9L0iIUQmW4sLmVC5D4iUtP3n9w8Oo7
        ciRg/n8dV50CT2aCh3y22mhAac3KbrZGaaavy5dHvolrLimJMdWzpXncvD4DNe500wIJXH
        7EiNy9o0+VSNPKRK9IzA5IzNjW0/Mz4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-BqRCDpe7PJWuJQlLvrSH-g-1; Fri, 14 Jul 2023 03:52:22 -0400
X-MC-Unique: BqRCDpe7PJWuJQlLvrSH-g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fa9a282fffso8876095e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689321141; x=1691913141;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WC74EEKhJlhJoUZcemPJUMicIDs5RJVsAsHWl0ODu1o=;
        b=e04syFlVWRZuwNvD8S2XvwbYAYIkl9JXcK9WxB20G69+/+KGWZtPrZrAZsMLKRAZ1c
         CCnR6nhGkSCs+wX4Xjwrc78zjKSZfGKeKD+weqXMtyfpSHWhPPf7pxBNRJKjys0PMjes
         o5MN8xWZ/+ufoqMbyPxu+dHSGWNJlmrp7Xzr0glDSB/CX9ISPC1bgMR76qLTU0//EH+D
         AQ6SqyqqDzJqQ2vuz8KcHoeHeNOWrUqD43EjZ3OhgFre/svUT6752zhFWx+HtzfvroVt
         Bn+ludvapp+yXr4EcdfZvLbY3ix7y8nM+FeV0e/qbnvw0ECCOmIsYrJUPbn03rKOXF9f
         j6JQ==
X-Gm-Message-State: ABy/qLaQXVoEO0sM63sklM0UZbwUYB8MXmDZ+fT6bGgY3UyfzRhgBl/D
        4x3W+9TKDMOQnLotBJzJ/QZQ8Rd2mkpfzYuqaQQYE0tdP2sLm5yY49G5r89fAM9WL5nU2qrhYpd
        hs14TQAVCwf9qyes+rxho4x+h
X-Received: by 2002:a7b:c04b:0:b0:3fa:97ad:2ba5 with SMTP id u11-20020a7bc04b000000b003fa97ad2ba5mr3249063wmc.31.1689321141245;
        Fri, 14 Jul 2023 00:52:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEC1xgj6rDpPbnDj033RgOCZB0seoIVN0Wc0wMxtKEDxY5P9kWVI1zu27Jcd8L02JWvRUJPHA==
X-Received: by 2002:a7b:c04b:0:b0:3fa:97ad:2ba5 with SMTP id u11-20020a7bc04b000000b003fa97ad2ba5mr3249050wmc.31.1689321140927;
        Fri, 14 Jul 2023 00:52:20 -0700 (PDT)
Received: from localhost ([90.167.94.6])
        by smtp.gmail.com with ESMTPSA id c7-20020a5d4147000000b003141a3c4353sm10130634wrq.30.2023.07.14.00.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 00:52:20 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Aradhya Bhatia <a-bhatia1@ti.com>, Sam Ravnborg <sam@ravnborg.org>
Cc:     Tomi Valkeinen <tomba@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Francesco Dolcini <francesco@dolcini.it>,
        Nishanth Menon <nm@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v7 5/8] drm/bridge: sii902x: Support format negotiation
 hooks
In-Reply-To: <5bf5e4d1-546f-19fc-1647-7ece567d52f1@ti.com>
References: <20230606082142.23760-1-a-bhatia1@ti.com>
 <20230606082142.23760-6-a-bhatia1@ti.com>
 <20230710150822.GA5237@ravnborg.org>
 <5bf5e4d1-546f-19fc-1647-7ece567d52f1@ti.com>
Date:   Fri, 14 Jul 2023 09:52:19 +0200
Message-ID: <87wmz3szf0.fsf@minerva.mail-host-address-is-not-set>
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

Aradhya Bhatia <a-bhatia1@ti.com> writes:

Hello Aradhya,

> Hi Sam,
>

[...]

>> 
>> It would be even better to walk through other implementations of
>> get_input_bus_fmts and update them accordingly.
>> 
>> Again, sorry for being late here. Feel free to ignore if you already
>> moved on with something else.
>> 
>
> I am working on adding OLDI support for tidss, but if we can resolve the
> above concern, and Javier agrees, I will be happy to add an incremental
> fix for this! =)
>
>

Yes, an incremental patch on top of what has already been merged in
drm-misc-next works. Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

