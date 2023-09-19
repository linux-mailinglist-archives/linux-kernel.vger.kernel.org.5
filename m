Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69927A6649
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjISOPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjISOP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:15:29 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E46811A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:15:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-532addba879so2294843a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695132921; x=1695737721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/FEvYyM2EeHOdSQPD/GJAyv/Ms6P3+0S37WW9XjZPo=;
        b=O+3Ad4fa08zRS54wwdex6+WfmwQAINFDJnWMNtpJJu2ryPGomfFcClbOVNyZGKFk6Y
         JvzlhpL3FocsTEBudBIYl7nbSNA0DNmB5Ig6IkqlFh5gh8WWGOFR58facN3IgJ8q9IOS
         XwmdmtweUitk3E2e8rAVdxDDb357JIDkQvbyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695132921; x=1695737721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/FEvYyM2EeHOdSQPD/GJAyv/Ms6P3+0S37WW9XjZPo=;
        b=X1Z76tQ0JBL328PmAPM5u+jlev0BEh+qbF6+hYGW+1AOIvTl+8g9OAd2G18J12FbVG
         mvfIAX7dFjqJK/QNOzceakDuDev1yN7uHhqnPvrdO5CG5dssS1Rajb/16FeksIGaxo9M
         h2zwqWUC32BE92jwh8sIJ5h1v5BODcFJf1tzdcZkIHDpNfW1YaSDqnFt9pSMTobrxmO3
         Pp5G1GCjjQvGYEcAn0K2qViXb4W1B83Mx69beQhrXuXC6GuJjtKE5QEtfuVwLWMU6Xsx
         7GQ9u/feeDMxUNqEuU4Dp878Uklos3CpbRJko0Q3CbJl7UfUASDVRgrf9boOMqfl4oiC
         rYYw==
X-Gm-Message-State: AOJu0YxahYknMyBA2ROtAibiwX5p9Fk3vigav4eEXuOcCaiLAmwLtY+Q
        iN6vtV3jQD3ig02tn9iidRVA64tkwaUo6sr6ZStKOnF5
X-Google-Smtp-Source: AGHT+IGhSyEeOqaZlWk9uZi3O9ndr6R3ZP0PrYmsKCY7qvD8Dq21Vep10hw+ZgYIas3K0aorTs41yA==
X-Received: by 2002:a05:6402:348e:b0:529:d147:e9f3 with SMTP id v14-20020a056402348e00b00529d147e9f3mr4221395edc.5.1695132921337;
        Tue, 19 Sep 2023 07:15:21 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id t13-20020aa7d70d000000b0052328d4268asm7312926edq.81.2023.09.19.07.15.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 07:15:20 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso68775e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:15:20 -0700 (PDT)
X-Received: by 2002:a05:600c:3d0b:b0:3fe:f32f:c57f with SMTP id
 bh11-20020a05600c3d0b00b003fef32fc57fmr110023wmb.0.1695132919977; Tue, 19 Sep
 2023 07:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230919-fp5-initial-v2-0-14bb7cedadf5@fairphone.com> <20230919-fp5-initial-v2-2-14bb7cedadf5@fairphone.com>
In-Reply-To: <20230919-fp5-initial-v2-2-14bb7cedadf5@fairphone.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 19 Sep 2023 07:15:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UmW8QwcT=YN8VSffuds2ib5zYPr6O2oQ=kUJkKa=5Bmw@mail.gmail.com>
Message-ID: <CAD=FV=UmW8QwcT=YN8VSffuds2ib5zYPr6O2oQ=kUJkKa=5Bmw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] nvmem: qfprom: Mark core clk as optional
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org
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

Hi,

On Tue, Sep 19, 2023 at 5:46=E2=80=AFAM Luca Weiss <luca.weiss@fairphone.co=
m> wrote:
>
> On some platforms like sc7280 on non-ChromeOS devices the core clock
> cannot be touched by Linux so we cannot provide it. Mark it as optional
> as accessing qfprom for reading works without it but we still prohibit
> writing if we cannot provide the clock.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/nvmem/qfprom.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
