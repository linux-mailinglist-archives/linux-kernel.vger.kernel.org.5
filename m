Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FB57A156B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjIOF2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjIOF2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:28:44 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C4E2D55
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:28:17 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bce552508fso26259711fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694755696; x=1695360496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xn9oFhHLAknaWRf3uArqHTLA9prBJhnE4LW7Dd164uA=;
        b=dK+HDjyZaIzzWjOpKGliaqyaq/IuzoIhWNmB8yFOe3y4+beIdkyiw3y4C+DO86gi5Z
         AQEBqzuRuIB+l5fp3AsZavt6Lz/jrs3lfLVPhX4ZEpJm1WJvceXX/P831J+WFK8f1/it
         eIQBvIggVMaXhLBOOAxyvA/w4SoUn970h/sCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694755696; x=1695360496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xn9oFhHLAknaWRf3uArqHTLA9prBJhnE4LW7Dd164uA=;
        b=BL0aOJmj8uu05dmCOXVMmqz2krRCUeKgm4CLhiKNEUd2kS6myh4y6bkA2BBUWu6s9F
         zINuGOl3roNBzeLB8fFy6MeQd50guBXQRj0r8nFEfFvFUnL5dVCO+8F321pbxkiiECLB
         AheCUxxgk8WTERTD2xK3oCISgTcP1uAnPFs3T3j2oekbThpKDt48R4KmlQenP7RZPnDT
         3qWoeVJjXydGCNJ8AhcY4JM9wlrI3oZcAZGuEf4oYq4OM0yM8GZZW1KArB+e9Z0ByZTm
         GQC1kxr9TRLsjvtr4RMGmDJhfe66dLrXWuIeHG5QyIuhIKu4+YStMEp/MjKMx5wu9qLB
         p4Lw==
X-Gm-Message-State: AOJu0YziBZ2ZU8p7jwiQ6jimIQEHrSrbSV0v4+NV53+7k9tO2tRjuDHp
        gFNeoG4b8fdROIjsaZhuDmm8lxYyQ6jbQkhJpXJQ+A==
X-Google-Smtp-Source: AGHT+IHBF/LZiSOCHbF9PK/ZZsZw9DLkRfLiviBg8ZInp/Df/pEH0sQClGR3SSNslHwvIhnE/oLD3Fo+uCtKqC7O+9w=
X-Received: by 2002:a05:6512:48c9:b0:502:d639:22ed with SMTP id
 er9-20020a05651248c900b00502d63922edmr518597lfb.48.1694755696091; Thu, 14 Sep
 2023 22:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230914131058.2472260-1-jani.nikula@intel.com> <20230914155317.2511876-1-jani.nikula@intel.com>
In-Reply-To: <20230914155317.2511876-1-jani.nikula@intel.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 15 Sep 2023 13:28:04 +0800
Message-ID: <CAGXv+5GJxEobJKKWuc_UN+Gf_z8g6eb6KWTz-L+RqtyLYKK3Jg@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek/dp: fix memory leak on ->get_edid callback
 audio detection
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     dri-devel@lists.freedesktop.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Guillaume Ranquet <granquet@baylibre.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 11:53=E2=80=AFPM Jani Nikula <jani.nikula@intel.com=
> wrote:
>
> The sads returned by drm_edid_to_sad() needs to be freed.
>
> Fixes: e71a8ebbe086 ("drm/mediatek: dp: Audio support for MT8195")
> Cc: Guillaume Ranquet <granquet@baylibre.com>
> Cc: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: <stable@vger.kernel.org> # v6.1+
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Looks correct to me.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
