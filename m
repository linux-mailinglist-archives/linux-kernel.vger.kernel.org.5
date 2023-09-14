Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C027A11F8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 01:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjINXn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 19:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjINXn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 19:43:27 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15CD1FE8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:43:22 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b962c226ceso24387741fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694735000; x=1695339800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ffsw5m1PXl5CYPaF5hVOzi1zPkWams0dilWKJC5stN8=;
        b=V2D5cQXyXxSS+SaKUAz9z1hsYWoIRU/iVYToDReF26+ELj+4rBZyGbJBB1Pp9WH529
         HE+w1WHvQAH9akn7RjM7cB1KI037qB8mZ3jTz0wiIPFAX2I+EyqEk8eiz4PhzUb96Z8f
         yYW5HfSKlki3bSvHYqPQ9zRpVCe7i6x+UVwsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694735000; x=1695339800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ffsw5m1PXl5CYPaF5hVOzi1zPkWams0dilWKJC5stN8=;
        b=VQk/4yDDimp99azRyf1eAMUcyo5Zfpt7WfPLtxDxh1V7mc5aSabx2fpl//o0bIr/rg
         qOFRp72ykjuwEreMgWD/FoEfRKQl33XyQyigTvRWxuCSlX4J2l8zMMp7AhN5e7eV+eMc
         Laqls1c+A+ldY0ftlqCAi3UHbxIOaoCID7hC4P3589iZIWBr5tqXfMi3P7fLQgDSJXYB
         VTSPHKNaPUDv/DcpL77b0GyU6BBYvAmFLx0Vgkx1ldxMBU4wy2AugagPjRL4PVB4EvcV
         RG01lv6adez7mnTStkIi7LOAL8v9Ax6Kaj0rtqHfJVgL39agrIo7Rwy/9Uo9NU9iZFUo
         lH0Q==
X-Gm-Message-State: AOJu0Yyyh49w17RiNO7wgKKtoicRSygChOXyXLQU9G9rEKhzvNbUF/+K
        DFY2sOlqeoTEuxb1AMqKAgkmppPj44B5lOrkIRtgiQli
X-Google-Smtp-Source: AGHT+IGY1BGXqAdciw7qZtf5hniIqPr6KwEyYU2MdJE/cmQivHxd7dF0/ZHB40Oh+hu7WEnV3oScEQ==
X-Received: by 2002:a2e:b002:0:b0:2bc:f78a:e5e0 with SMTP id y2-20020a2eb002000000b002bcf78ae5e0mr177341ljk.43.1694735000766;
        Thu, 14 Sep 2023 16:43:20 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id x6-20020a170906710600b00992e14af9c3sm1651286ejj.143.2023.09.14.16.43.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 16:43:20 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so6625a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:43:20 -0700 (PDT)
X-Received: by 2002:a05:600c:1daa:b0:3fe:f32f:c57f with SMTP id
 p42-20020a05600c1daa00b003fef32fc57fmr70422wms.0.1694734979632; Thu, 14 Sep
 2023 16:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230727171750.633410-1-dianders@chromium.org> <20230727101636.v4.11.Ia06c340e3482563e6bfd3106ecd0d3139f173ca4@changeid>
In-Reply-To: <20230727101636.v4.11.Ia06c340e3482563e6bfd3106ecd0d3139f173ca4@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 14 Sep 2023 16:42:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ued9suf95ub1-rftO2Ffx_Rwv7XvAf7yX-s7djO889+Q@mail.gmail.com>
Message-ID: <CAD=FV=Ued9suf95ub1-rftO2Ffx_Rwv7XvAf7yX-s7djO889+Q@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] arm64: dts: qcom: sc7180: Link trogdor
 touchscreens to the panels
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-arm-msm@vger.kernel.org,
        yangcong5@huaqin.corp-partner.google.com,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        hsinyi@google.com, Chris Morgan <macroalpha82@gmail.com>,
        linux-input@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 27, 2023 at 10:19=E2=80=AFAM Douglas Anderson <dianders@chromiu=
m.org> wrote:
>
> Let's provide the proper link from the touchscreen to the panel on
> trogdor devices where the touchscreen support it. This allows the OS
> to power sequence the touchscreen more properly.
>
> For the most part, this is just expected to marginally improve power
> consumption while the screen is off. However, in at least one trogdor
> model (wormdingler) it's suspected that this will fix some behavorial
> corner cases when the panel power cycles (like for a modeset) without
> the touchscreen power cycling.
>
> NOTE: some trogdor variants use touchscreens that don't (yet) support
> linking the touchscreen and the panel. Those variants are left alone.
>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> (no changes since v1)
>
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi        | 1 +
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi      | 1 +
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi         | 1 +
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi        | 1 +
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi | 1 +
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi   | 1 +
>  6 files changed, 6 insertions(+)

FWIW, this old patch could land any time. All the earlier patches in
the series have landed.

-Doug
