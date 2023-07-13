Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C43F751DED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjGMJ4r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jul 2023 05:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjGMJ4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:56:45 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A81E75
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:56:43 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-cb19b1b9a36so473856276.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689242203; x=1691834203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ky38aRztiJlAI5tJIApUzXIrtiO5iJsH9sjAfnvxdr8=;
        b=bm2/O70CDbhKTTU2wEjgAIfpbWJNIsVprya9h0NRwmroBjJnC1fwg12yt2Flo31NfX
         vNnHdTh+h2t3d50ZqDrOEYBxbpsd8WHLC+Mx8ubBIcOC+GE+OEt/mm+voqDkgcjV0HF8
         lm15rlsw6RvEduD5yw+zjGlp/CCicQa27caECd518jHg5+NOcelHw8Y07QtlSRb97z5+
         ZVR5WnWnqW5IbWPLq4hQz1+fFToroe/v4dWUAiinoz5lXZBdM0TSTRF589Jt7MRZrzRA
         5UIdBZyQI7l389TCTV4tgkIO7K4Y7cLpJFwG0BHP8mTAGr+w8OPx5sMZAqWU6aHBAKvS
         QN4w==
X-Gm-Message-State: ABy/qLbUNQ3MSbDBeni90/ohJN1jg4sImoWUCjMxQip+e0iwWZ02sDEE
        /rE4TTVtvEFRNbqH30lkvRpiKAoi5v3WP3uu
X-Google-Smtp-Source: APBJJlGyemvosa3q/vk99UnYYuB73ahA0C5jyPoxkXPHYmyur2oYomZNeto0NpZOwqtGP9Ndl8Ia9w==
X-Received: by 2002:a0d:cac8:0:b0:56d:28b:8042 with SMTP id m191-20020a0dcac8000000b0056d028b8042mr1291248ywd.40.1689242202946;
        Thu, 13 Jul 2023 02:56:42 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id a63-20020a0df142000000b00569eb609458sm1678336ywf.81.2023.07.13.02.56.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 02:56:42 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-cb19b1b9a36so473837276.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:56:42 -0700 (PDT)
X-Received: by 2002:a0d:eb14:0:b0:56c:f8f1:eed5 with SMTP id
 u20-20020a0deb14000000b0056cf8f1eed5mr1235965ywe.6.1689242202613; Thu, 13 Jul
 2023 02:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230713085859.907127-1-javierm@redhat.com>
In-Reply-To: <20230713085859.907127-1-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Jul 2023 11:56:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXWfeX9EESbiSnJ-G-TuyFKt7ZnMKi2Y85HRG2695siTg@mail.gmail.com>
Message-ID: <CAMuHMdXWfeX9EESbiSnJ-G-TuyFKt7ZnMKi2Y85HRG2695siTg@mail.gmail.com>
Subject: Re: [PATCH] drm/ssd130x: Change pixel format used to compute the
 buffer size
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 10:59 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> The commit e254b584dbc0 ("drm/ssd130x: Remove hardcoded bits-per-pixel in
> ssd130x_buf_alloc()") used a pixel format info instead of a hardcoded bpp
> to calculate the size of the buffer allocated to store the native pixels.
>
> But that wrongly used the DRM_FORMAT_C1 fourcc pixel format, which is for
> color-indexed frame buffer formats. While the ssd103x controllers don't
> support different single-channel colors nor a Color Lookup Table (CLUT).
>
> Both formats use eight pixels/byte, so in practice there is no functional
> changes in this patch. But still the correct pixel format should be used.
>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
