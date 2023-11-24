Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436847F8713
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 00:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjKXXsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 18:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKXXsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 18:48:39 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8BF1A5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:48:45 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5ce4b3f12e5so7587417b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700869725; x=1701474525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/830YKnDcxSt/CJDe7WkW9RteXiYPTW2q0xMnOOWww8=;
        b=n+buqhthWrOoAl3h/zVsyjVXyLMVf1smtCWoYJo0PCoRqtOfk4YrwooSszYbcM1o3C
         G58M7/O3yZxdIyzO3q/9CW++aV3RsZx7tGefzduzxZ9NPuK35ii97b+rL82sSLNc/7Fd
         WO5ZlVn5qKaikahWxDoxUhFtML8/TX7jyzsUHxxLBohGu3F35xQchsgYOcGRpweA6MyF
         NbXE8vBsvXPgJDUeguORA0UzY0yEAFiStyGlFdSaGyAqXU5EUCbY+3Sxv5AwfWslgI0q
         LE/MZRU4UPMCfdnrgSN1PHI6O6vVT2bTQ+o6x9Ck98jdieu8NlYBEFkJwi5djmDyqHkK
         ELmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700869725; x=1701474525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/830YKnDcxSt/CJDe7WkW9RteXiYPTW2q0xMnOOWww8=;
        b=MeGH85gAKLY2abhMaNFYO7QUcNijdr8LtBH1UWwtbbeoFw2ox9/0igSiwqVUWs8DrB
         p03QzOls4k3v2sJ9G9d7fKRn/OSX4F2+UAPh4WPU3nWE/JBn/jbCJUKj7OPonsACeEAI
         PQGhWmEoMIXhFVh4bWo1nHeYx3igpP3mi2uxhOQRc3PqHzWtaowoEA9a2KZ/ByMmPX93
         gAmE7ip5n/VzT/LxpzYCAKuh0G3hRaLqLbokULrxYRCRu/V+67PsHrwPnHQu9FcjkWYI
         zYVNkovOe6ov2dOSIlgUsWmy6J9aAExukmGMG2EtQH7LPf4f9dHjbJV8KmvzDuYTs4jd
         x1Vg==
X-Gm-Message-State: AOJu0YxcafdRwpp31v3eFzZkdP5FhraG2HzAmsIYecUZ1cEe0J04z+f6
        uDjQ5W5kRAsimhB/GFQA6ib78xw9nTiUoyJh1Sw/jw==
X-Google-Smtp-Source: AGHT+IGQeg1xyWfs+38KV7TLHDR+ADT+EAresNrQwsRA+n70yeLTadHSkV2mxHH0FpPr27asVE6qoh7iQZPNnjqXt4U=
X-Received: by 2002:a05:690c:3485:b0:5ce:cd8:ee1 with SMTP id
 fo5-20020a05690c348500b005ce0cd80ee1mr3528023ywb.7.1700869725147; Fri, 24 Nov
 2023 15:48:45 -0800 (PST)
MIME-Version: 1.0
References: <20231123032615.3760488-1-victor.liu@nxp.com>
In-Reply-To: <20231123032615.3760488-1-victor.liu@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 25 Nov 2023 00:48:34 +0100
Message-ID: <CACRpkdZsqR0MUoLdmdk1-XW0zQDTf0g+-dp1hsSzQ2vXosKoXA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: panel: Check device dependency before
 managing device link
To:     Liu Ying <victor.liu@nxp.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 4:22=E2=80=AFAM Liu Ying <victor.liu@nxp.com> wrote=
:

> Some panel devices already depend on DRM device, like the panel in
> arch/arm/boot/dts/st/ste-ux500-samsung-skomer.dts, because DRM device is
> the ancestor of those panel devices.  device_link_add() would fail by
> returning a NULL pointer for those panel devices because of the existing
> dependency.  So, check the dependency by calling device_is_dependent()
> before adding or deleting device link between panel device and DRM device
> so that the link is managed only for independent panel devices.
>
> Fixes: 887878014534 ("drm/bridge: panel: Fix device link for DRM_BRIDGE_A=
TTACH_NO_CONNECTOR")
> Fixes: 199cf07ebd2b ("drm/bridge: panel: Add a device link between drm de=
vice and panel device")
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Closes: https://lore.kernel.org/lkml/CACRpkdaGzXD6HbiX7mVUNJAJtMEPG00Pp6+=
nJ1P0JrfJ-ArMvQ@mail.gmail.com/T/
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Patch applied to drm-misc-fixes.

Yours,
Linus Walleij
