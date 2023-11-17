Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D30A7EEEC3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjKQJdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjKQJde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:33:34 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6AFC4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:33:30 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5afa5dbc378so19306187b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700213610; x=1700818410; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v760LgpcfQOP0YeuG/30ZJ0hYcCt31Y4fxVmQiAp9qA=;
        b=AbJpxXIKhs5PE+dfsniMzY02N9ojS6WFDP3EZX41VNtFg/xjoVu0PD67zZia3ZLcgx
         dUdQgkDKlXxdzp/orUKj/A7hzP1Sz4AXiYH+tdHciedS8XsNyQ8FUm7EJ9NsF8TG7ybp
         1Niy3XIf3/spEW6v2jT5W0OyftXYghhu0/BXfqdcjd8bA8YMRD8ZahLpPdqiCLoO5gjk
         sIsLWZ7GLxUsmf38dMs6LsynWQEHn8kCXZCx6be1p0YmFfl0i48qGNVhEDdEPfWgehq3
         Ztr8EgW6//kIQKHokvgwjqPhwUQDUeiu6bi0i7ZEGN5b5foiuYZQn6fSVg6rbFzvKcjO
         TIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700213610; x=1700818410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v760LgpcfQOP0YeuG/30ZJ0hYcCt31Y4fxVmQiAp9qA=;
        b=WVSkYxj7rGty3Bq7SjJiYezL/zeuXflo+KhKbNawooK2Ze1prUGVGQdHpC5PrRKEC5
         NJmjnxaYqB72ZiTwlnHNuJEJvIIzKcyBjqibQgchF5LmtkZNh9R5gx17U4EMR9R7KJLr
         M1f/RhsBKhhf0a9YTlyph/7c02voaLsJctlq5haM+PCnClv2msT2jLm/csF8Q6oJFl/O
         Y2fYDIdUy8B5W7Po7XXxgssVE0O8//k+Cj/aPjiDw5YFmcDN6ieDQO7vMBVHpjcX3pYq
         sPt4/idd7/XzRbGWaHa0uDkR7m9i96rIJ1Ug4MIJ+Ky9k7QiyPIBB7RlgtpvvUjYzFXO
         TSzA==
X-Gm-Message-State: AOJu0YxziL+OvVfCSqaWgojUYqWU5KhwcqT73XbNwaqIuOiqyv/5Fube
        3dNvP8HX20uJI+PswKbb7Bu/xEJXzvhTOY4mN8O9V3Uf3g3F6Jij
X-Google-Smtp-Source: AGHT+IFK3e0M4t/vG0KKQGcetbavVwPTP98E38NRyc8wthbNVKwBEsAsuMN/W/rfY75Lu6AiZ0ieKM7si7+AeZXz+wU=
X-Received: by 2002:a81:9c52:0:b0:5c6:9488:4c99 with SMTP id
 n18-20020a819c52000000b005c694884c99mr1803791ywa.18.1700213610008; Fri, 17
 Nov 2023 01:33:30 -0800 (PST)
MIME-Version: 1.0
References: <20231103184655.23555-1-quic_kbajaj@quicinc.com>
 <20231103184655.23555-3-quic_kbajaj@quicinc.com> <CAA8EJprNyu0r_mV9hbKA1fSvoEvTHuk5umxU8H64Voj_cnZcFQ@mail.gmail.com>
 <4d8c094f-07b0-2b38-4680-145eb2d7c4f5@quicinc.com>
In-Reply-To: <4d8c094f-07b0-2b38-4680-145eb2d7c4f5@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 17 Nov 2023 11:33:18 +0200
Message-ID: <CAA8EJpr_PwD0kD0RdgcwLCGaCdau+3EUPAQd32hxccNbtoKaKg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] arm64: dts: qcom: qcm6490: Add qcm6490 idp and
 rb3 board
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_nainmeht@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 at 08:53, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:

No HTML mail on kernel mailing lists, please. Some developers can have
'MIME => junk' mail filters.
And replying to the HTML mail messes up quotation level.

> On 11/4/2023 3:52 AM, Dmitry Baryshkov wrote:
>
> On Fri, 3 Nov 2023 at 20:49, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
> Add qcm6490 devicetree file for QCM6490 IDP and QCM6490 RB3
> platform. QCM6490 is derived from SC7280 meant for various
> form factor including IoT.
>
> Supported features are, as of now:
> * Debug UART
> * eMMC (only in IDP)
> * USB
>
> Co-developed-by: Naina Mehta <quic_nainmeht@quicinc.com>
> Signed-off-by: Naina Mehta <quic_nainmeht@quicinc.com>
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   2 +
>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts      |  33 ++
>  .../boot/dts/qcom/qcm6490-iot-common.dtsi     | 291 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/qcm6490-rb3.dts      |  26 ++
>  4 files changed, 352 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/qcm6490-iot-common.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/qcm6490-rb3.dts
>
>
> [...]
>
>
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-rb3.dts b/arch/arm64/boot/dts/qcom/qcm6490-rb3.dts
> new file mode 100644
> index 000000000000..5b4c2826ac5c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-rb3.dts
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +/* PM7250B is configured to use SID8/9 */
> +#define PM7250B_SID 8
> +#define PM7250B_SID1 9
> +
> +#include "qcm6490-iot-common.dtsi"
> +#include "pm7250b.dtsi"
> +
> +/ {
> +       model = "Qualcomm Technologies, Inc. QCM6490 RB3";
>
> Is this a marketing name of the platform?
>
>
> Sorry for the confusion, QCS6490 RB3gen2 is the correct marketing name for this board.
> Will correct this in the next patchset.

Then it is probably "Qualcomm Technologies, Inc. Robotics RB3gen2"?

> +       compatible = "qcom,qcm6490-rb3", "qcom,qcm6490";
>
> chassis-type = ?
>
>
> No, this won't be needed as it is an evaluation board and will be used for multiple use cases.
> So, we don't want to mark it to any specific type.

Then it is "embedded". We should probably update existing
dragonboards/RB boards to have this type too.

-- 
With best wishes
Dmitry
