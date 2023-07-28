Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B5A766987
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbjG1J5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbjG1J5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EE72727
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690538186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U0nQmkIx0uMFTk7seYDZJ5H4WZLfPJM6Ejko8L/+g2U=;
        b=AOwnnPRxuVnAwGSLdQUdQJtrXT/PzFPgBlvBVbV0c5CYkWSHD09fixVHcS+bCs5adw1GKp
        /Dczy0IC+V9zX4u6aQIekd3TIpgS+FT6ZGnPTBrplavWza9JLIbzJiOIFa3qppSTg/Yem2
        0LQZkcDjmU4AZDuRs61AysCOFrVMcww=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-mSulyx09MVOFBLzH3ZJIkg-1; Fri, 28 Jul 2023 05:56:25 -0400
X-MC-Unique: mSulyx09MVOFBLzH3ZJIkg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b961c3af8fso19125631fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690538184; x=1691142984;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0nQmkIx0uMFTk7seYDZJ5H4WZLfPJM6Ejko8L/+g2U=;
        b=bP3mM2DBsHmfqqb3O1tX81G/tuXdA0/5MDGm8Yt7un/dXY5yZm6o/7dVRIJXu5k2vp
         8+yNqOur6Ebr7zfFCsUFrYR9ftqhnUmYp6/hRr1g1jp/X0wWGVxRzzMoYO09Jka75ke+
         /0ZTtIg6lm+qjeGr51Oni3byHV1gl8EoonuCoTonxxD6GVm9vK9RmpAUTpsv+yAxHLSD
         9+F+0DiS3ZRDnzwZ4LaZKpwETZPkuS+RGlyU+64b/9Hx4drt8Y3nWFz6QOpRMgHlPz2w
         WYgh7Kqr4926Z1Xgn0ePuBMy01tKdcPN57JkoGPHWjWSuZzNB9VABl2z4XrPUnE5E9l0
         kZ9A==
X-Gm-Message-State: ABy/qLZg3PRf4qF8x3AUUGAFgQZu8JczH1VklAi04KptylkBsaPYhSuJ
        uLI7Hg8gCjXgJ5JjSatRvA4HBhj/dTEvTl4Q9PUCFs28ypdmpmxs56uw6sotBJ/MaYmkmtBBdrd
        oQ5J832lr7xh1lsdfpkoCnktl
X-Received: by 2002:a2e:8348:0:b0:2b6:ddab:506a with SMTP id l8-20020a2e8348000000b002b6ddab506amr1383763ljh.34.1690538183854;
        Fri, 28 Jul 2023 02:56:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGwahOxbYJkEWBd03saQPCa6kZbAUxNDbMT+3FiXqFtgqQ72w3vwPLNd17NXDdmeysAzUDaWQ==
X-Received: by 2002:a2e:8348:0:b0:2b6:ddab:506a with SMTP id l8-20020a2e8348000000b002b6ddab506amr1383744ljh.34.1690538183543;
        Fri, 28 Jul 2023 02:56:23 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f14-20020a7bcd0e000000b003fba94c9e18sm3822745wmj.4.2023.07.28.02.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 02:56:23 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/panel: simple: Simplify matching using
 of_device_get_match_data()
In-Reply-To: <64ded5b7e809e4c6e915b2c4d8b82e02319cd206.1690535800.git.geert+renesas@glider.be>
References: <64ded5b7e809e4c6e915b2c4d8b82e02319cd206.1690535800.git.geert+renesas@glider.be>
Date:   Fri, 28 Jul 2023 11:56:22 +0200
Message-ID: <87jzuktl4p.fsf@minerva.mail-host-address-is-not-set>
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

> Both the patform_driver and mipi_dsi_driver structures contain pointers
> to the match table used, so the custom code to obtain match and match
> data can be replaced by calls to of_device_get_match_data().
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

