Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0737D0439
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346618AbjJSVvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346606AbjJSVvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:51:07 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AD711F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:51:05 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c503dbe50dso2311731fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697752262; x=1698357062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XF9t5trmYV2tU8uP1V1uGs3giS+nQ6cAeAndNsOA6c=;
        b=XKecxZw+9atQoxLFNJghavdtLoqts/seGMjs7GX8Rp7rkZsrcfjdOyhEAZlUpwqxLU
         deghHUr0FsyExxgrh0eCsMZiyWxu3mWrCG64udsMkLRFNp0SZARLPLbt0KOX7Z2jzpcm
         1YxOK595hbZ7HGAJOqlG0aaExxx1oQLGlgnBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697752262; x=1698357062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XF9t5trmYV2tU8uP1V1uGs3giS+nQ6cAeAndNsOA6c=;
        b=cpLnUd+hWmoqZ7u+EA8iuSRrObi+3YIzgf3+Gscj6RIbFY/+CcCsElskmjv/fc8F7e
         wh/CMIW0bTifMEB4oI9RPQPYu1XcnVLkcBjYxL5quFUZi1wwaOFDPmPByZpC+0/ptiyV
         WFpIs75E6lP3kgHi3BBiPgHkP8OYEabsCTgR8STh6qAZf6hgwfQaNt+wz3TNx5t1bE8V
         kYCgexTabNA2AdfTnhS3sA70u9G8rAi+FJiCVTSdv6T85hEfs1dyjNfJ309BOY9i+Ebv
         mv+DrFqy9QZWki+v2NUQ2+XbLNyPzmvvFU4vqtT5Oanvq7uRiQHPFr4A3TlIWSWDLJCw
         3kTQ==
X-Gm-Message-State: AOJu0YyYD2iXXfP1IcxX7DosXU9L5gyyk2fR6kIJeSMpxZEPdNKHrQHk
        blpUog45MSTwXMwqqDSzNqraM6iV2tFfBqqkVFy8tRQI
X-Google-Smtp-Source: AGHT+IFyM5s+gDOMGaURr06T6snD6KJ/Qn/s0W0NRPqc4LiSeXlqKWUxm8FTzOeiH8IlVj/mNG2UgQ==
X-Received: by 2002:ac2:4309:0:b0:500:daec:2817 with SMTP id l9-20020ac24309000000b00500daec2817mr2554704lfh.54.1697752262382;
        Thu, 19 Oct 2023 14:51:02 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id o2-20020a509b02000000b0053db0df6970sm276520edi.54.2023.10.19.14.51.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 14:51:02 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so1631a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:51:01 -0700 (PDT)
X-Received: by 2002:a50:8d59:0:b0:53e:7ad7:6d47 with SMTP id
 t25-20020a508d59000000b0053e7ad76d47mr25591edt.5.1697752261284; Thu, 19 Oct
 2023 14:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231013091844.804310-1-yangcong5@huaqin.corp-partner.google.com> <20231013091844.804310-4-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20231013091844.804310-4-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 19 Oct 2023 14:50:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U8fDO7q3k8DmXHPnX0XrryzY1-zcuU6N1ZmDo=O3anLw@mail.gmail.com>
Message-ID: <CAD=FV=U8fDO7q3k8DmXHPnX0XrryzY1-zcuU6N1ZmDo=O3anLw@mail.gmail.com>
Subject: Re: [v4 3/3] arm64: defconfig: Enable ILITEK_ILI9882T panel
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        hsinyi@google.com, linus.walleij@linaro.org, swboyd@chromium.org,
        airlied@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Fri, Oct 13, 2023 at 2:19=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> DRM_PANEL_ILITEK_ILI9882T is being split out from
> DRM_PANEL_BOE_TV101WUM_NL6. Since the arm64 defconfig had the BOE
> panel driver enabled, let's also enable the Ilitek driver.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)

Pushed to drm-misc-next:

c2635c0ec8b4 arm64: defconfig: Enable ILITEK_ILI9882T panel
