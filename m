Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65F27DF80B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376966AbjKBQ45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKBQ4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:56:55 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39B5181
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 09:56:49 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9d8d3b65a67so173299366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 09:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698944207; x=1699549007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6E1PmPxdJrRCrp3jKHhIR/orep6iCxyvOLSiJH5wr4=;
        b=j9Zrd8fMusNCAlvpC/v4x5JvRjoBw4K5BnMLlJfAPOdfam8mmbUSMf7+ItLphWPNWT
         Y7s4sgKI13buNaoqXB5l/wORlBBW2eOJBosUebYxHQtZTtZx2dw4PaKDs8HDi9fHo2tp
         nJdSiCaVA15Wz8s0OiffyEm5N8QAY/clCXawo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698944207; x=1699549007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6E1PmPxdJrRCrp3jKHhIR/orep6iCxyvOLSiJH5wr4=;
        b=gmb/dUWyNIm5oxtsXN/jFkbPuPGzSYL3B5Q6oX/W0HdaXwHDHZwrCxkwlYNdnJIzEx
         4eJbqxhoTh5pXlUGJ2mYespNCyxfuscp/vEB/eDoAOmjb5cYDPWczUjqhlA+ZgN1OyKq
         W3ikTEzZk4QYP/otOh8awmmfZqb0Pxmxv1gSshpV+jB40qEr0fkikTRjsgxfPkDIxs8U
         2+AooXO8eAsMR77k3tAuY+oYKwhGI68uOJpv6Nqi7KnKjhTqeeuJr4rrHHMS6YdYpTjw
         EycUvc7D8ORycpWX0zGfubzVeePq6LRVjACtncgKDX4oRRGVgUxqMKmTSA5/SLB+Dgxd
         Kolg==
X-Gm-Message-State: AOJu0YxtrjGks+eIju1SR9wyauKxfBKwd6JZsrDhs9MUQptl8Ft00MEY
        B5NUhfMtnDrFUidv1YoyUGMHbAhqk2w6Nz0qZeTf4Saz
X-Google-Smtp-Source: AGHT+IH3OuFlrv0sQkTUVELgpwnBB/qMiampv4axm7N3XvbvI8ctoPsGlALOW8j7Dis/u81svUn4Tg==
X-Received: by 2002:a17:907:5c1:b0:9bf:b8f7:1fc4 with SMTP id wg1-20020a17090705c100b009bfb8f71fc4mr4976425ejb.43.1698944206819;
        Thu, 02 Nov 2023 09:56:46 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id h3-20020a1709063b4300b009d2819cce87sm1352161ejf.177.2023.11.02.09.56.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 09:56:46 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-54357417e81so319a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 09:56:46 -0700 (PDT)
X-Received: by 2002:a50:cd8d:0:b0:540:e4c3:430 with SMTP id
 p13-20020a50cd8d000000b00540e4c30430mr108765edi.6.1698944205867; Thu, 02 Nov
 2023 09:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231101212604.1636517-1-hsinyi@chromium.org> <20231101212604.1636517-3-hsinyi@chromium.org>
In-Reply-To: <20231101212604.1636517-3-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 2 Nov 2023 09:56:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XH9gz3c7F0kKX4TnOa0_9-Ji-x-Vqt1AsnXLwsiWMH_w@mail.gmail.com>
Message-ID: <CAD=FV=XH9gz3c7F0kKX4TnOa0_9-Ji-x-Vqt1AsnXLwsiWMH_w@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/panel-edp: Add override_edid_mode quirk for
 generic edp
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 1, 2023 at 2:26=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> w=
rote:
>
> Generic edp gets mode from edid. However, some panels report incorrect
> mode in this way, resulting in glitches on panel. Introduce a new quirk
> additional_mode to the generic edid to pick a correct hardcoded mode.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 68 ++++++++++++++++++++++++++++---
>  1 file changed, 63 insertions(+), 5 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
