Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB6D75A4D3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 05:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjGTDkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 23:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjGTDkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:40:15 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3BC2107
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 20:40:13 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-481389cd087so120198e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 20:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689824413; x=1690429213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSjRK2q1L9TAgulU0uKFfXHGPLF469L5iIGjDG8jzbg=;
        b=FmeTyNoriwl9eaAi4UWOvHlnCraMY6GehOzN23WwXZRmcok3v6POEoNGHEu94dxVB8
         XV4VcCfpZYkmClWeuwO/dz2ibDjqJ8d55lxTA46EwDPzcxh4fhnBC7Tdws3NBkdTIflj
         r1NHovSBoV0qsV6wHj6W6XPQiDFsT3TG4VhK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689824413; x=1690429213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSjRK2q1L9TAgulU0uKFfXHGPLF469L5iIGjDG8jzbg=;
        b=Obfemm+Kh9nzj0qu6LNKfw4kkpRazMn4+ePN6WTb9xtDUL5leYilSRezIlRHf5in9N
         Womo9h8cJNLc97l2P3b/Qr2+eoufBS/a6yrletCRtazARmSjjepEXrpoF3Qg3a1NlVW7
         xY5Otg7BbRHW3Zep/hnZAP1vUqyaPG5WszB6j/owzS4wmnNf3YNCS78eWCW/GW7eS7HN
         9BpqE3tpoweNUH1fqDLjg70JKK2CllwaVw1paroEYW144yLsoZb4zstpj+zhwASkwp/6
         LctOqXiSycZ+Gf5ZGTfWOw4CFybog8UQ7DVOg6p7cuKJ30rGVwr/MpcbIld3U28sqbv1
         LPnw==
X-Gm-Message-State: ABy/qLaO/K3U3nVKH/T7065RFEN1Eq6hshNHmrlI5Q6Mw0rWqP0lN1fZ
        mWCoRIWQlo0otN8GVja22TVUw10lpoHI1BTlYTMyBg==
X-Google-Smtp-Source: APBJJlFNX7ga31HK628CC6mrALekyrNpX5VHsIamGWWzU5anyG2qAUaYHqYQELEJ8vJVk/lcPOgf7qx4IpcShRxdv2Q=
X-Received: by 2002:a05:6102:387:b0:443:516b:782 with SMTP id
 m7-20020a056102038700b00443516b0782mr1896634vsq.33.1689824412895; Wed, 19 Jul
 2023 20:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230707092414.866760-1-zyytlz.wz@163.com>
In-Reply-To: <20230707092414.866760-1-zyytlz.wz@163.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 20 Jul 2023 11:40:01 +0800
Message-ID: <CAGXv+5HjLdZO7mCJyBYk_Kj9SFUJrL3Z4VbxSsPb2qK-mbwkaQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     Kyrie.Wu@mediatek.com, bin.liu@mediatek.com, mchehab@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Irui.Wang@mediatek.com,
        security@kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 7, 2023 at 5:25=E2=80=AFPM Zheng Wang <zyytlz.wz@163.com> wrote=
:
>
> In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
> mtk_jpeg_job_timeout_work. Then mtk_jpeg_dec_device_run
> and mtk_jpeg_enc_device_run may be called to start the
> work.
> If we remove the module which will call mtk_jpeg_remove
> to make cleanup, there may be a unfinished work. The
> possible sequence is as follows, which will cause a
> typical UAF bug.
>
> Fix it by canceling the work before cleanup in the mtk_jpeg_remove
>
> CPU0                  CPU1
>
>                     |mtk_jpeg_job_timeout_work
> mtk_jpeg_remove     |
>   v4l2_m2m_release  |
>     kfree(m2m_dev); |
>                     |
>                     | v4l2_m2m_get_curr_priv
>                     |   m2m_dev->curr_ctx //use
> Fixes: b2f0d2724ba4 ("[media] vcodec: mediatek: Add Mediatek JPEG Decoder=
 Driver")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
