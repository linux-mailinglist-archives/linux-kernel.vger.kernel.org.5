Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646BD7CDBE9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjJRMg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjJRMgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:36:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AF2112
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697632562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DvkIUJlsPsk9rKKrIiotFgIDw4k3ZXO6WEuCH5meJOE=;
        b=IEVK83eysqRiFCabDFTRnoXcBSf9w6v7Vp8ztTH1KcCrrtXRBmHiixKgg+GHBVEphwJfkC
        FPqJ/K4KQ58Ed2E5u/FWe+raTYQBz2ROeaPWxX7fNjChWKC2DTqUqQx9K0sUcU0nbsEszK
        nIY9CN8nVu0vsWSysyKI3FRTOV/ExgA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-XkurThGENXSEeI2-AX2Kbg-1; Wed, 18 Oct 2023 08:36:01 -0400
X-MC-Unique: XkurThGENXSEeI2-AX2Kbg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32172e3679bso4184656f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632559; x=1698237359;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DvkIUJlsPsk9rKKrIiotFgIDw4k3ZXO6WEuCH5meJOE=;
        b=OeYm9I0IC+ZdgE6dQSGyR4U6W8y7qWMwolbx3HE1frlEL/uoE+hRFxAVk+bx2OWHMR
         WuPD/UagFCm6CMs08gy9BPy5FWl8WcX0/Dr1ERHD0s9TqSatZHnUxyEK1vJ87GOJm0pB
         VcaXYyQxpegvyLRKA/yJK5oLtI3uYcYlq7ecgVjv+pqYZBMQ0+L6kmSB3xF+3OsQG/rr
         CpGjMWsSmGAeEoKPxIha/gGytce7syoDHsrCJB6ByHt/Raq/BARj4ZermLYlhVa6BO2d
         04VgOEL9WLKMmisVKW76vJ/gMDd/xxc4w9KKMDLkuUdWdpVv8SF+OwLKEEg+bxonW6iA
         Mgng==
X-Gm-Message-State: AOJu0YwmA5UFvRgLHGF/IomSJr86lx0HDxLVRKOodnfGVApCJ9KqdiRr
        gQGhzth614EvOYxiFTciRo2kccVjT/xY3CJncNpu6aROCknfincSg2a81M2YCZ6dSwQP3KSHl7w
        jbJ3tOne/ftEfMsCnilRbUUR97qug8YQR5SAAeql51R/6aCXMeMCbmMv9ibRuyFiq2bhX0lbMHH
        euikQMZmNR
X-Received: by 2002:adf:f7c3:0:b0:32d:89b5:7fd9 with SMTP id a3-20020adff7c3000000b0032d89b57fd9mr4190455wrq.56.1697632559752;
        Wed, 18 Oct 2023 05:35:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRw2wtzC78mi1fzASa956lKjGhi0QeXQyM0+7DBplHT/RMgj9Axr/3Zwe8PoI7WZzPEHj2EA==
X-Received: by 2002:adf:f7c3:0:b0:32d:89b5:7fd9 with SMTP id a3-20020adff7c3000000b0032d89b57fd9mr4190430wrq.56.1697632559317;
        Wed, 18 Oct 2023 05:35:59 -0700 (PDT)
Received: from localhost (210.red-80-36-22.staticip.rima-tde.net. [80.36.22.210])
        by smtp.gmail.com with ESMTPSA id n13-20020adffe0d000000b0032d9382e6e0sm2029069wrr.45.2023.10.18.05.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:35:59 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 0/6] drm/solomon: Add support for the SSD132x
 controller family
In-Reply-To: <20231014071520.1342189-1-javierm@redhat.com>
References: <20231014071520.1342189-1-javierm@redhat.com>
Date:   Wed, 18 Oct 2023 14:35:58 +0200
Message-ID: <874jioqf9t.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Javier Martinez Canillas <javierm@redhat.com> writes:

> Hello,
>
> This patch-set adds support for the family of SSD132x Solomon controllers,
> such as the SSD1322, SSD1325 and SSD1327 chips. These are used for 16 Gray
> Scale Dot Matrix OLED panels.
>
> This is a v4 that just rebases on top of commit a48e2cc92835 ("drm/ssd130x:
> Fix atomic_check for disabled planes"), that landed in drm-misc tree and
> conflicts with this series.
>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

