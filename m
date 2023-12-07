Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCAC808FDB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443711AbjLGSXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443686AbjLGSXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:23:33 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFEA10E3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:23:39 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54bf9a54fe3so1819997a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 10:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701973416; x=1702578216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18Xj7GvDH6vU8O7BJr6AsjtH8lVK3Aid34DvmXifJHM=;
        b=FLQrPp82ZxoFUAOELtyxwE30HqRsZzio/ZSv48fB+PyEj26C0N4+QEzAkKE5fHtd6b
         Zr1FVmSkODrxLajK76o0TlisSckJUbBwCQVWJDkCoppsy5hYCK6wk2KseuzNUFCMbgY5
         qWANEDBu4EoYLN0dqZ4KwRn6VWjgNYRNSLDBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701973416; x=1702578216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18Xj7GvDH6vU8O7BJr6AsjtH8lVK3Aid34DvmXifJHM=;
        b=sDJ/aKF54EI3P65PgUWVY6FIregF4oAbdDB0+fhVRxTkZCw8aC6NJ50alXtwwz/kqN
         4C7DJp642yspnHzwL1QMR22l/JYqIk7f8Pi0zTJl/LpjpD82BNeOK9sfbhjbDIyr9/cX
         3uFOTpTthFvWbfR4/z1WSLmVtatPbWEm6rJCxGPnZ+A9074b+MmA3+70eyZlVYNewHjr
         JEGcY3+Tc3LRqofudBrtvH3q9G3cNOpweimxGdv68jS5DkE/JK3uyFLbXli/ySbcTv6Z
         nAG900ZUTdNUFYL58a3ihm8GASX+2NhJXt5YFr3T2JZ8QBMeokfLjJOD3qTz6o036n1W
         ISaw==
X-Gm-Message-State: AOJu0YzK80uJvsWrRDZyvsWvrZwlpLkrnTjGFiC6LeXOBChEB43OMeDZ
        hBYeP+JuLamrpn7X8gEViLSbv50ic1l/zXah6/AYlnj8
X-Google-Smtp-Source: AGHT+IFyT0GFuweuOYW/7w7U8kThzWMNxwRYS5HH3DiguQIoJyzc8JhsiuJIZdh3L/eiQ3hrhooRAQ==
X-Received: by 2002:a17:906:20c8:b0:a1c:f745:e0b8 with SMTP id c8-20020a17090620c800b00a1cf745e0b8mr1856048ejc.92.1701973416048;
        Thu, 07 Dec 2023 10:23:36 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id th8-20020a1709078e0800b00a1df93ed441sm50902ejc.135.2023.12.07.10.23.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 10:23:35 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so3555e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 10:23:35 -0800 (PST)
X-Received: by 2002:a05:600c:231a:b0:405:320a:44f9 with SMTP id
 26-20020a05600c231a00b00405320a44f9mr220896wmo.5.1701973414710; Thu, 07 Dec
 2023 10:23:34 -0800 (PST)
MIME-Version: 1.0
References: <20231207081801.4049075-1-treapking@chromium.org> <20231207081801.4049075-2-treapking@chromium.org>
In-Reply-To: <20231207081801.4049075-2-treapking@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 Dec 2023 10:23:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xbmo4BYjy3si4D8NJ5hThmjQky3oK4VFQz8fwKj87Rtw@mail.gmail.com>
Message-ID: <CAD=FV=Xbmo4BYjy3si4D8NJ5hThmjQky3oK4VFQz8fwKj87Rtw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/edp-panel: Move the KDC panel to a separate group
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        dri-devel@lists.freedesktop.org
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

On Thu, Dec 7, 2023 at 12:18=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> Move the KDC panel entry to make the list sorted by the vendor string.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
> (no changes since v1)
>
>  drivers/gpu/drm/panel/panel-edp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

67a5f0ff3429 drm/edp-panel: Move the KDC panel to a separate group
