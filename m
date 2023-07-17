Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B6D756F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 23:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjGQVka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 17:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjGQVk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:40:27 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79FB137
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:40:26 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-992acf67388so620955366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689630024; x=1692222024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYk2j/SRza18eE5VYpPrRQIWdMxdJwDfSSkNCndN4e8=;
        b=KZTJ/HI9bKZHL50kXVw4IhnThEpCHDcqOIIKImOtHS5Gb0L+p1HIQWd8/s/Sqr960G
         q2u8bYaNzIxxxoX2R7ZRSIPwhxt7YUl7wNGUC6u4PczCOmo9GF5N2V96C1tlToKt+BVM
         nmZzTKhzPgsiePpBZgu92yfmFLJALv/Q87WWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689630024; x=1692222024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYk2j/SRza18eE5VYpPrRQIWdMxdJwDfSSkNCndN4e8=;
        b=a1XBKne42dJ6VMGX0LABHJQ6kY5NXmSAQcODVCxz9SWKNr4npGbp7K/HaepqjTVW2a
         qeRCN9y+yHThGIPTzB0BEuQTrqud5gPhTGQujr/2Z0hWoTZZFpiISV8bjS1xoliw9faB
         PVSNWjGeFpvlzbzZ/ofZR8cOMLA/JBKvtZANvJOFo0Jbicv/6z8hyd0nDkESkstaR6Qx
         LYwaJNYx99hGcmxvhnG5hTY8NR+/HwfpmwyPry6ae5MK0/oCA3IPJV8PHgW4QEHmJvu+
         Qz7dp/0HTTAV34pDKHHyeCOoqb6YpBBi8AZj0uiCSyvZgXQ85L36gIzqHlHlmvMSphkt
         5wWA==
X-Gm-Message-State: ABy/qLaBcVdHm4mUzOFHGsmTJ6DTdeGdIbhBdne8wZteBlQeMS1Rfuit
        Lxpl/KS59PHWGNq2/vX7yoYNG/o/LpTMpfqtQWhdVkvY
X-Google-Smtp-Source: APBJJlEAO9v5jVm5JJITW3bdIxeXIp6X3vr6xuGykdVba2plJlnPOZ3RZ1MEHfNq8VGhmmo/lY6yzA==
X-Received: by 2002:a17:906:73d0:b0:991:ed4e:1c84 with SMTP id n16-20020a17090673d000b00991ed4e1c84mr11352032ejl.25.1689630024463;
        Mon, 17 Jul 2023 14:40:24 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id lg14-20020a170906f88e00b00992e265495csm158205ejb.212.2023.07.17.14.40.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 14:40:24 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3fbb07e7155so30705e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:40:23 -0700 (PDT)
X-Received: by 2002:a05:600c:5129:b0:3f1:9a3d:4f7f with SMTP id
 o41-20020a05600c512900b003f19a3d4f7fmr10147wms.1.1689630023411; Mon, 17 Jul
 2023 14:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230711091155.2216848-1-wenst@chromium.org>
In-Reply-To: <20230711091155.2216848-1-wenst@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 17 Jul 2023 14:40:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UW=VrrCB8Ko7ysWTia--hG6t+4BmRwodY=nkL=DyP6CQ@mail.gmail.com>
Message-ID: <CAD=FV=UW=VrrCB8Ko7ysWTia--hG6t+4BmRwodY=nkL=DyP6CQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add AUO B116XAB01.4 (HW:0A) panel entry
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hi,

On Tue, Jul 11, 2023 at 2:12=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> This panel is found at least on the MT8183-based Juniper Chromebook,
> also known as the Acer Chromebook Spin 311. It matches the common
> delay_200_500_e50 set of delay timings.
>
> Add an entry for it.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index fbd114b4f0be..df7e3cff004c 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1866,6 +1866,7 @@ static const struct panel_delay delay_200_500_e200 =
=3D {
>   */
>  static const struct edp_panel_entry edp_panels[] =3D {
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x1062, &delay_200_500_e50, "B120X=
AN01.0"),
> +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x145c, &delay_200_500_e50, "B116X=
AB01.4"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x1e9b, &delay_200_500_e50, "B133U=
AN02.1"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e50, "B116X=
AK01.6"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B11=
6XAK01"),

You're about 1 month too late. ;-) This landed in drm-misc-next as
commit 1ebc9f0365ef ("drm/panel-edp: Add AUO B116XAB01.4 edp panel
entry").

You can find it on drm-misc-next: https://cgit.freedesktop.org/drm/drm-misc=
/log/

Specifically see:
https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3D1ebc9f0365ef

-Doug
