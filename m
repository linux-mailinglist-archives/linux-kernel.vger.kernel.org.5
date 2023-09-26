Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05857AE45B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjIZEBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjIZEBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:01:01 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2D6BF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:00:54 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50337b43ee6so13053331e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695700852; x=1696305652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYClnlSGRE/VVPHFCk//gM0X3MtjPFgRACsIZo27ba8=;
        b=U1sgDXtUz13BzFct2TvayisYMgaYWBJbvfMFAtX7Y7s9vid9/TdGy/B7dznKR0Hiqj
         WUQACYEPWXK8RlWXap2I9khybQUwSO14jFW6jr/pySY1KUvOIMkvuLPvAeS7kL7krx1p
         kqvNPQMMaSllhx2KmEutSS1GZsEMqRJWVECqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695700852; x=1696305652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYClnlSGRE/VVPHFCk//gM0X3MtjPFgRACsIZo27ba8=;
        b=JA2D7lneJ/NFAY/Oj5WPA4Pi9uvHNSj3U6Qsp4D14cZs30KjHFGcmBk/Xs55VSly00
         B6SOJJxHkXJEKT9Oj7IGWZJ2dcFg9ZliuktrOMsSsKM22Ye0mGQ6xatyLKs0+yLdNyOn
         G9q1Jc/f7/mxoI9GsLK7Gk4mlo6RoIASR+kw6xFygvDJpiz68rB13i3VvEd/J1ObhZOu
         z46dbwft3OdFym2UjGegItMVOv1CHJ+lgbKWqv0PXbRTuY6dzFu+trtiRKvMDAh+Mskv
         /DQycpJwxwB48dcVS5Rw8ckFJmxFYv8rGCb9KHLYjWZRROGq6w5jRyfty5/6BVR9ST7a
         19vA==
X-Gm-Message-State: AOJu0YwXscgBLitbxdZhDzDsbL0XAxDurTdXQwbOCwTqPdRg1AFrBWdW
        M51K0GyG/qzt2l0lBKPayNScbkpTTPL6yRsg7Cbplw==
X-Google-Smtp-Source: AGHT+IEtkTctsf5HbOONUd8gTf3/GdExf1zf0JDg4leCj0a9OJM+OM1FoXuuppkPECKOTlmyKr+PorFc6IG0rss5xr4=
X-Received: by 2002:a05:6512:3995:b0:502:ff3b:7670 with SMTP id
 j21-20020a056512399500b00502ff3b7670mr8220870lfu.4.1695700851585; Mon, 25 Sep
 2023 21:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230921091057.3812-1-duminjie@vivo.com>
In-Reply-To: <20230921091057.3812-1-duminjie@vivo.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 26 Sep 2023 12:00:40 +0800
Message-ID: <CAGXv+5HFsLxVqoUsa4BAC8waq=hXoh=4sdXxSmFP1vB1FhnsZQ@mail.gmail.com>
Subject: Re: [PATCH v1] thermal/drivers/mediatek/lvts_thermal: fix error check
 in lvts_debugfs_init()
To:     Minjie Du <duminjie@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Balsam CHIHI <bchihi@baylibre.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 5:11=E2=80=AFPM Minjie Du <duminjie@vivo.com> wrote=
:
>
> debugfs_create_dir() function returns an error value embedded in
> the pointer (PTR_ERR). Evaluate the return value using IS_ERR
> rather than checking for NULL.
>
> Signed-off-by: Minjie Du <duminjie@vivo.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
