Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628D475383E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbjGNKcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbjGNKcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:32:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE288211C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689330727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bswM7v1JuTkyCrRrLUO+88+ZhMY73z5COH1v+XdpEac=;
        b=L5J9+TQu4MTvO7pcBJZlNVpH3RCE66/oMja3yftXSQigfqi66MhVntmQMQX8Q/XXoyCMxJ
        KsAPZJi1JuWVaDdCQOfoDaLlbZiOIQTrwFG9vN6JzJzYiKrHJutqudqJ/PKh/JY45r+y9r
        wFMheWNFKXOzEXdvNW1lhSZiQCcU7fo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-_eDNriJ4MNW9czX4QCJs_g-1; Fri, 14 Jul 2023 06:32:03 -0400
X-MC-Unique: _eDNriJ4MNW9czX4QCJs_g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-314394a798dso741882f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689330722; x=1691922722;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bswM7v1JuTkyCrRrLUO+88+ZhMY73z5COH1v+XdpEac=;
        b=PYcJP2+htTHZT08AiWmEqgj8VSkn9Nq9oAIveC9Kf1zmHOFC1aaiGz6e+PPI/qC1Vl
         cpjixU2G/9vsi0w2SeRi81bYjvZQnBnWzQRb5EmQ6cJ1crIJ74gIdbxk87OaDNBmhSCo
         fLgb1eyvw+aJRDgMFOpfzn0BBic5YoGhorkGQoxk/0Ci7pugt7ssaWvUT42oJ3Vfe7/G
         +Wc3k5/b4hpn9NU5hPly6BXMx9jtMvPRm6oL4OBaBPk59RUI2KhyaOvPDxB1l+yM6LVd
         /4SucxNlwhItY1xCSQLJhSLakjh14o9TOCvEVNrjC9jlPj3dD9RwQf3WkQnskmEvgDHb
         zCeQ==
X-Gm-Message-State: ABy/qLb3OHaXd7X+2TSOAiqM9qrbjfdEOZK9aL7ycnAQ7hm02/KA+9X3
        DH086/6/jfi9Ik/57Tg4wIBm1XjMeie3EulAHQpWt7HRT749ohljlSIqeIpIN9aKHJeAZblWEIE
        zjOGNshGlK+mqmBR3h+HCiZ7G
X-Received: by 2002:adf:f5ca:0:b0:315:acbc:cab6 with SMTP id k10-20020adff5ca000000b00315acbccab6mr1973689wrp.16.1689330722372;
        Fri, 14 Jul 2023 03:32:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGLjBHCh4GeTwl+UYr12Fntv21WCEoSsC6SdOQUnI/JIxRF/C7Cx2SlNpcAwswe6YuPwABAbA==
X-Received: by 2002:adf:f5ca:0:b0:315:acbc:cab6 with SMTP id k10-20020adff5ca000000b00315acbccab6mr1973674wrp.16.1689330722072;
        Fri, 14 Jul 2023 03:32:02 -0700 (PDT)
Received: from localhost ([91.126.32.244])
        by smtp.gmail.com with ESMTPSA id s15-20020adff80f000000b00313f9a0c521sm10529733wrp.107.2023.07.14.03.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 03:32:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 8/8] drm/ssd130x: Switch preferred_bpp/depth to 1
In-Reply-To: <6b97ca629131a8c1c047947a21b2c558ece9ce87.1689252746.git.geert@linux-m68k.org>
References: <cover.1689252746.git.geert@linux-m68k.org>
 <6b97ca629131a8c1c047947a21b2c558ece9ce87.1689252746.git.geert@linux-m68k.org>
Date:   Fri, 14 Jul 2023 12:32:00 +0200
Message-ID: <877cr2u6lb.fsf@minerva.mail-host-address-is-not-set>
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

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> The native display format is R1.  Hence change the preferred_depth and
> preferred_bpp to 1, to avoid the overhead of using XR24 and the
> associated conversions when using fbdev emulation and its text console.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks again for the series!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

