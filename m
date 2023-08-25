Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F7D788FB4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 22:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjHYUSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 16:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjHYUR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:17:56 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92AB171A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 13:17:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52a4737a08fso1802475a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 13:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692994672; x=1693599472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4MG4Y7KTbIUQEo4oi1409RKv9+4SxTW98bg1s1cKPw=;
        b=GrWpKq5qCWAOl/qCljbumGTWm18CTyDkFE4buGF28JEPf0EZ0jJYaMAXKEiLEAfBOC
         RA/iWnBdbzq5isvY3WVl02D6l8eqg0C3mh3jA9PJju5HZIa0Hi/raZoviuzkE44aDI02
         YLbwz1qATI+NWtedTySF44E9AijpItQHAMWy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692994672; x=1693599472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4MG4Y7KTbIUQEo4oi1409RKv9+4SxTW98bg1s1cKPw=;
        b=lFT1nIfXa5LAv+FZ/rvKVzi5KEOdF2qVB9c2H8wekemL+NUnDg5MFMerssRqJ1W/Zb
         ZVCG/r736uu8m/ncTDuy/g7CzMl+AjO0gJMUFJEtbXBFfAIxjoGhbA0b7b/iPRe0HPo5
         1X7PWmIaQlODPoAKoctTA9GnAQ/dlRaHzf3osVf08olqml9F1KU8NAhGOc65jCu9xvKd
         +5+7+o3qxxBT58t6zJowtCGGVqYHHzRotpr59gZ8UZfjxg4XJLXzbEdo8iMYYdF2kdno
         CWZanWTBynAGNlcc0W+XbWS3tXoLQ53uZth2r9T/ITL32UI/fGUhU+/qx3bqIGBfHmVR
         KYOQ==
X-Gm-Message-State: AOJu0YxZAsJEzg5lFTpk0jK7P2S5T1BVqd62uVq2QmzvAExBS7FNC7ZB
        it/+8NXeNo+KdbIrinOCECCa0CvRCH20cN2UyxPfx2DE
X-Google-Smtp-Source: AGHT+IFf8wGCjjeiMxP2mgg8snBktWoKJZmLLCzRtU8yObtkMEG1jsXrL0iA8ocpMei5oyvd01dMLg==
X-Received: by 2002:a05:6402:3447:b0:522:30cc:a1f4 with SMTP id l7-20020a056402344700b0052230cca1f4mr17573858edc.0.1692994672262;
        Fri, 25 Aug 2023 13:17:52 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id l17-20020a056402029100b00523b1335618sm1323760edv.97.2023.08.25.13.17.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 13:17:51 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fef2fafee2so20085e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 13:17:51 -0700 (PDT)
X-Received: by 2002:a05:600c:3b8f:b0:400:46db:1bf2 with SMTP id
 n15-20020a05600c3b8f00b0040046db1bf2mr67016wms.2.1692994670872; Fri, 25 Aug
 2023 13:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230811-topic-7280_lmhirq-v1-1-c262b6a25c8f@linaro.org>
In-Reply-To: <20230811-topic-7280_lmhirq-v1-1-c262b6a25c8f@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 25 Aug 2023 13:17:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XKeE7_ciuvfAic+24kyOF0yaFT7iCJWgN9NaW-zG+vKA@mail.gmail.com>
Message-ID: <CAD=FV=XKeE7_ciuvfAic+24kyOF0yaFT7iCJWgN9NaW-zG+vKA@mail.gmail.com>
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

On Fri, Aug 11, 2023 at 1:58=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
> Hook up the interrupts that signal the Limits Management Hardware has
> started some sort of throttling action.
>
> Fixes: 7dbd121a2c58 ("arm64: dts: qcom: sc7280: Add cpufreq hw node")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> test case:
>
> - hammer the CPUs (like compile the Linux kernel)
> - watch -n1 "cat /proc/interrupts | grep dcvsh"
> - the numbers go up up up up -> good

I'm not doing much on sc7280 these days, but I did try putting your
patch on a sc7280-hoglin (AKA a CRD). I tried to stress the system out
a bunch (ran 8 instances of "while true; do true; done" and opened
something to activate the GPU). I didn't see any LMH interrupts fire.
Of course, with ChromeOS firmware LMH is _supposed_ to be mostly
disabled, so maybe that's right? Our policy was always to have Linux
do as much of the throttling as possible and only use LMH as a last
resort.

I assume I don't need any specific config option turned on?

I know that on other Qualcomm boards I see LMH nodes in the device
tree, which we don't have in sc7280. Like "qcom,sdm845-lmh". Is that
important? I haven't been following what's been going on with LMH in
Linux since we try not to use it.

For giggles, I also tried putting the patch on a sc7280-villager
device to see if it had different thermals. I even put my jacket over
it to try to keep it warm. I saw the sensors go up to 109C on the
medium cores and still no LMH interrupts. Oh, and then the device shut
itself down. I guess something about thermal throttling in Linux must
be disabled but then it still handles the critical state? :( That's
concerning...

I put the same kernel on a trogdor device and that did normal Linux
throttling OK. So something is definitely wonky with sc7280... I dug
enough to find that if I used "step_wise" instead of "power_allocator"
that it works OK, so I guess something is wonky about the config of
power_allocator on sc7280. In any case, it's not affected by your
patch and I've already probably spent too much time on it. :-P

-Doug
