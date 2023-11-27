Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6888C7FA596
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbjK0QED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbjK0QEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:04:00 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB23EEA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:04:06 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9beb865a40so3916236276.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701101046; x=1701705846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7kfcTFnc1EIcTrfufgAiSWZaBI8ZkU3ldDxmrr3WA8=;
        b=SysesZokp5xWO/Fl8lCVgEy4lqfbu0NZ+qRRLJz0pnmy8n3ZM57d0McKSVo1ATYsKm
         si1rvtagc74oDGvjO3pj90jlH0tvynj1d5K9qyHb+wQDYLtFhlKN0ZhjCjkluSl3Ki+B
         RYleH2fpS7CUf0SPHcv6y2qzXTlktyeveBrxo9rNo/BM4v66fPEPgaWk1/U8RQR9Gm/r
         aZgF205XF3qOZw3QqyjcL6XF5qZDH2yoQp4EwPj3mVxFEtgQY9OUb4HQ/GZPzKZvydIm
         ZiYnuS8ZANwUxaw8yJApwHzHjU+PpvmlQcHCVzf8+d1tej059Spj/e/t7Z6ddgYLMbkO
         mFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701101046; x=1701705846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7kfcTFnc1EIcTrfufgAiSWZaBI8ZkU3ldDxmrr3WA8=;
        b=AroE23CmrkgI/pW4ZngO6pJIOkHWBgB/asPyFaZz90ZhVQhh9ZKsnhdIGOPl6eGsIL
         hLmvNPylm0/tQi4YOb5ustTwulz05WBNpPmLwF2fX+EcYeactwiWGoSjYTqrVIUsLrMK
         YlPGmDmd7R0Gv/i+5M0m1F0xqsZR343XEzQZoCpgij0C4GHosoTkxdUrMq5G01w93hNC
         ICKTYvr3txWXPlWpWeRoH786E3DTAwic+BhNK2Smq8l2/xli6ql+drK3w7bl+UIGAe1W
         5PpMv7JCTgC26RffXcm/15eIBr8BsF5UuFoKUzqlFVC+c06UT10RJ1Z/+L4osD52zihU
         Dn2Q==
X-Gm-Message-State: AOJu0Yx3iPurrNZ4oKMQ7v9kmYB3chqnixF770fkDF6lcTtxR6PP1uXW
        ibyGNxesLJnsAMjs4oeLvlVFrgtcNqxvSztEFBTY/w==
X-Google-Smtp-Source: AGHT+IH34yJLIkZJKXuCRnBcCqV+kUWFq5pvwWNuBFGfgw8Ppgvz1en2RopG7eerUDrKPKL790hzAPbQaxQoDiQvtbQ=
X-Received: by 2002:a25:ea45:0:b0:db3:9994:119b with SMTP id
 o5-20020a25ea45000000b00db39994119bmr10785589ybe.50.1701101046011; Mon, 27
 Nov 2023 08:04:06 -0800 (PST)
MIME-Version: 1.0
References: <20231127051414.3783108-1-victor.liu@nxp.com>
In-Reply-To: <20231127051414.3783108-1-victor.liu@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 Nov 2023 17:03:53 +0100
Message-ID: <CACRpkdZAtxh5muhbPKvmUQGtQogs3UhGxNZqnSGWoWQNUL7=9g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/bridge: panel: Check device dependency before
 managing device link
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        angelogioacchino.delregno@collabora.com, ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 6:10=E2=80=AFAM Liu Ying <victor.liu@nxp.com> wrote=
:

> This series aims to check panel device dependency upon DRM device before
> managing device link between them.  It fixes eariler patches in v6.7-rc1
> which tried to manage the link.  Without this series, the link fails to
> be added for dependent panel devices and hence relevant panel bridges
> fail to be attached.  A real broken panel is "novatek,nt35510" defined
> in arch/arm/boot/dts/st/ste-ux500-samsung-skomer.dts as reported by
> Linus Walleij.
>
> Patch 1 exports device_is_dependent() to modules as needed by patch 2.
> Patch 2 checks device dependency before managing the device link.
>
> Note that patch 2 is already in drm-misc/drm-misc-fixes and
> drm-misc/for-linux-next-fixes.  Patch 1 needs to be reviewed and picked u=
p.
>
> v2:
> * Introduce patch 1 to export device_is_dependent() to modules as needed =
by
>   patch 2.
>
> Liu Ying (2):
>   driver core: Export device_is_dependent() to modules
>   drm/bridge: panel: Check device dependency before managing device link

I just applied patch 1 directly to the drm-misc-fixes so we don't have to
revert and then re-apply patches, because that is a bigger evil. (We can't
rebase these branches...)

Yours,
Linus Walleij
