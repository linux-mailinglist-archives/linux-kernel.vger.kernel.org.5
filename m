Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2998813913
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjLNRsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLNRsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:48:40 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB1A99
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:48:46 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54cd2281ccbso10871679a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702576123; x=1703180923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjzqvPNodJ+AYwzDBCkKXGHQ6gaMigpuT4ZV+tVtwn0=;
        b=QMX77YNkSHZTpggSQrIC5N4wr+OHe1IQP5U81JUUZFQJ1OpjhW7nASj9ckutE2M99X
         bSnHg95vFOJLS95EY+AuIcJi5GBrASccia9+X1lRDSTvpoPPnSej5yGQsrXFTZVVZ2V5
         CKXzHiCHaSKlNrDEGT2S7vhue8x5iIwVWALVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702576123; x=1703180923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjzqvPNodJ+AYwzDBCkKXGHQ6gaMigpuT4ZV+tVtwn0=;
        b=Q34ioTokdBl9hfA9O1cUelj0t+7kiUZVPJrYeyCs0ld6Y8MvewzMEwtXPW4XZABVAv
         5sOiFGq6pawmvb4kR6CLVMEFKncRj+S0pB1hkn4qAxfcTHHxgWLfMJckkcPCsU4YHhss
         xGXzKWhvPcKeMM7MUtK9ID1yDnD1oXcmYgIJl6xAV6j0qahqW/yLpC99JXSpl/0fYBKz
         WId51vwtnHuTLjbeBBkv9UQLxnjUdgfF2IHiw+YOJ8IF7GEmoF+Pcc8cYcu2VxLOzhGZ
         Th7Wsj0eP2lEv6Bp4hxWKv70F3wlo2jJwO29KP0qIGaiGsY/yEJS50ntMlZrsiN8gmFw
         2ARw==
X-Gm-Message-State: AOJu0YxyXB9Ir9ghbW65Lh6SZgAd6jUO7n+LCHqEjC0EnaqEVQVuli0a
        JqpZKl1VBXCjUjuTvyRna9VTit1GLfhsRejCvAr9yP33
X-Google-Smtp-Source: AGHT+IF2GN1Z5zbHAadbAr3xwUzYcn/KCix1WzlSYf1Us6Ab9UslPAg+GXZfdZiV+5UN0psZF4LOFg==
X-Received: by 2002:a17:906:73d3:b0:a1f:99e3:b53a with SMTP id n19-20020a17090673d300b00a1f99e3b53amr3532328ejl.5.1702576122907;
        Thu, 14 Dec 2023 09:48:42 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id se13-20020a170907a38d00b00a1f78048f08sm8929500ejc.146.2023.12.14.09.48.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 09:48:42 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40c3963f9fcso215e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:48:42 -0800 (PST)
X-Received: by 2002:a05:600c:600a:b0:40a:483f:f828 with SMTP id
 az10-20020a05600c600a00b0040a483ff828mr554730wmb.4.1702576121615; Thu, 14 Dec
 2023 09:48:41 -0800 (PST)
MIME-Version: 1.0
References: <20231214-topic-undo_ddr_stats-v1-1-1fe32c258e56@linaro.org>
In-Reply-To: <20231214-topic-undo_ddr_stats-v1-1-1fe32c258e56@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 14 Dec 2023 09:48:24 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W5V7XO-h7DXxQgqEYcN0R2oHTJ_3G06bY8tKGtjKySRg@mail.gmail.com>
Message-ID: <CAD=FV=W5V7XO-h7DXxQgqEYcN0R2oHTJ_3G06bY8tKGtjKySRg@mail.gmail.com>
Subject: Re: [PATCH] Revert "soc: qcom: stats: Add DDR sleep stats"
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

On Thu, Dec 14, 2023 at 4:25=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
> After recent reports ([1], [2]) of older platforms (particularly 8150 and
> 7180) breaking after DDR sleep stats introduction, revert the following:
>
> Commit 73380e2573c3 ("soc: qcom: stats: fix 64-bit division")
> Commit e84e61bdb97c ("soc: qcom: stats: Add DDR sleep stats")
>
> The feature itself is rather useful for debugging DRAM power management,
> however it looks like the shared RPMh stats data structures differ on
> previous SoCs.
>
> Revert its addition for now to un-break booting on these earlier SoCs,
> while I try to come up with a better way to enable it conditionally.
>
> [1] https://lore.kernel.org/linux-arm-msm/20231209215601.3543895-2-dmitry=
.baryshkov@linaro.org/
> [2] https://lore.kernel.org/linux-arm-msm/CAD=3DFV=3DXX4wLg1NNVL15RK4D4tL=
vuSzZyUv=3Dk_tS4bSb3=3D7QJzQ@mail.gmail.com/
>
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reported-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/soc/qcom/qcom_stats.c | 187 +-----------------------------------=
------
>  1 file changed, 1 insertion(+), 186 deletions(-)

Tested-by: Douglas Anderson <dianders@chromium.org>
