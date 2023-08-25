Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5272D78915E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjHYWA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjHYWAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:00:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819C7C7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:00:43 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4ff8cf11b90so2146854e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693000839; x=1693605639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhpqi3RsiTeSycikChKIyWBlkmV4boq70Ok6Dhkoa6w=;
        b=Hcex+n20KpYmrze4S7I3IT7jXAZjpWWeLKxyACv4IOBOi3lveq7d31L65l5xF4Gb/1
         cyStIYnapfrMQNuTe8mDrQE3kJP5YrrpWIkNMX6pET89RctAttmhBx2caM3WE6dUz0ru
         F+PiYnAkPQe4BNGjdpHLRuMmiE4ItC8i4LF9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693000839; x=1693605639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhpqi3RsiTeSycikChKIyWBlkmV4boq70Ok6Dhkoa6w=;
        b=QpseKq367mcjoqCiAP0guX9DEu0+WRILgaHUK9niwK/l8RU2fGHo7dcIrDm2oKOvaH
         3TEHXh/ThtSEnu2+Zi5v42ufynjueVH709uE+4DetYh6rHkddmXS1WveiabkOEK18UwB
         cFdJui24BYrGgrp2yYPNNKgv1ZaNIMEYX2vDRR5+Ge/xHSiJN/4ZfwGH1yiIvIt6XhIU
         e9cDSPn45vidIwctC9ZCgLfPzrh6f4/OSY6CXTJPtisnF9yXY9sThr3P13ZndyWyd8/3
         CE/qEi/Umh3bK83uXyht/DiJszqX+L9han4FiqFHNOHb4xltkfQM04NiJHS7lH3xTkCj
         pp3Q==
X-Gm-Message-State: AOJu0YyM7p/xNXFhGhSQU/7W7xf9+oLzXA4pznmP5G22k/WnIXV9oQ9n
        yXg+dcIyMbWD4JEA8MOwvZFw0EQyEwKJ8y0GBtMq9A==
X-Google-Smtp-Source: AGHT+IFxdXZ7R7noz80kMhrT9yxfzGcXb1qk+6HUuEUaucs64RhfTAixuCTCKeNb3T5lXrwqvIJZSQ==
X-Received: by 2002:a19:520b:0:b0:4f8:71cc:2b6e with SMTP id m11-20020a19520b000000b004f871cc2b6emr13111401lfb.33.1693000839471;
        Fri, 25 Aug 2023 15:00:39 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id d2-20020a056402078200b005232ea6a330sm1409937edy.2.2023.08.25.15.00.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 15:00:39 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4005f0a6c2bso11515e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:00:38 -0700 (PDT)
X-Received: by 2002:a05:600c:1c86:b0:3fe:e9ea:9653 with SMTP id
 k6-20020a05600c1c8600b003fee9ea9653mr85660wms.4.1693000838168; Fri, 25 Aug
 2023 15:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230811-topic-7280_lmhirq-v1-1-c262b6a25c8f@linaro.org>
 <CAD=FV=XKeE7_ciuvfAic+24kyOF0yaFT7iCJWgN9NaW-zG+vKA@mail.gmail.com> <d413843f-5187-41ee-89aa-1f4dc0bc729d@linaro.org>
In-Reply-To: <d413843f-5187-41ee-89aa-1f4dc0bc729d@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 25 Aug 2023 15:00:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wh1xSz8MOt-GY7w_ha3shNpAnGOwXdrqJE17oJB+cG4Q@mail.gmail.com>
Message-ID: <CAD=FV=Wh1xSz8MOt-GY7w_ha3shNpAnGOwXdrqJE17oJB+cG4Q@mail.gmail.com>
Subject: Re: [PATCH RFT] arm64: dts: qcom: sc7280: Add missing LMH interrupts
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 25, 2023 at 2:07=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
> > I put the same kernel on a trogdor device and that did normal Linux
> > throttling OK. So something is definitely wonky with sc7280... I dug
> > enough to find that if I used "step_wise" instead of "power_allocator"
> > that it works OK, so I guess something is wonky about the config of
> > power_allocator on sc7280. In any case, it's not affected by your
> > patch and I've already probably spent too much time on it. :-P
> Hm, perhaps it would be worth to try this patch on a non-chrome 7280
> device.. Would you guys have standard android-y or windows-y firmware
> that you could flash on these to try out, or should I try poking
> somebody else?

I don't have hardware that runs anything other than the standard
ChromeOS bootloader, sorry!

-Doug
