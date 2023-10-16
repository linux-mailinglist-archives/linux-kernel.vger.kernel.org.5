Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86057CA8B2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjJPM6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjJPM6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:58:33 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C67AB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:58:29 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a8628e54d4so10947217b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697461109; x=1698065909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqpzVrhZyZozpiYjtHgOesuqQhqMKFkX4Btaax5HP/A=;
        b=XZy1TEMOgiOKqf77F/+NH3h4HVrGztdOQzgj4uhq1ZT1WZiWdMaqPUh4BmcbS1CyFi
         tp5k4yUKIU5t/ODSMoZM2xFvUw7j8d8E6ZW58Ykj1BO9zQuA7t0YtGUZX7tmj559m7PC
         NWmPbuiEtgCxsI5xZi3CNyAoDkYJn06OVYdJJLN1vR2m89QvrjzkZQjCTEdcfg1UTaAr
         AyMBXF1rOhmnaHgON2ipbm8GV8eD7+x74BQIg+0shmgqNdYBiwKBArEzs98QzlKd2K4m
         nue419CScKyxPZO5L7Nv2vSVvrhhCJhDxwl6F3Uj94Nrf2E8s+fUbBcKh8QVg3oNQzJ9
         nWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697461109; x=1698065909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqpzVrhZyZozpiYjtHgOesuqQhqMKFkX4Btaax5HP/A=;
        b=XwZmYhxREboBVqKGTu7V5Sv7FiItZcdTU5xirnaiOlgdgRUuK4lkiq8+4Nfay2UKYG
         bX9yOnR8IrGSUAxgOteyQDep+u/Z40yZ18oieLF944u7qpwNfAdq0S3fyjsdk839+qeb
         2LL7BB8QwuA78e16g5IIjftCrPAyJltrbHYn1zgMWdvVw5EzGARvdTjik11wkyHTfn3J
         wmlLoPKA0TU5uca0gGyRuW7KlfwE6N1sHMK3rnFQH+Fn/G9e6KKrSdek0BadYp+ZQcbk
         qvT9ianmS/eUIIxXINa+GsCYVuC0xVEBkpXUXQlsEN0B4GiqSly0iwyDmlDTu3R5n8FQ
         xc+A==
X-Gm-Message-State: AOJu0Yy42/5NsaNeom2AIZG2T1LJr6lRhKRjS3h39CONyRlwHsl//mE+
        mLTMPFodJ1PGXu7xHvHyQ28LTjLV0P8SE+/CHImUFA==
X-Google-Smtp-Source: AGHT+IEY9xc9MLbOxQayOC2CIwTNUCGEN0BwcVh5yvAKFOrPVCkbItp5sV/n6OwMrpQoOqRvEmz2F1crhgfhpP7vLqw=
X-Received: by 2002:a81:5281:0:b0:59b:cd92:779f with SMTP id
 g123-20020a815281000000b0059bcd92779fmr3973966ywb.6.1697461108826; Mon, 16
 Oct 2023 05:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231013145705.219954-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231013145705.219954-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Oct 2023 14:58:17 +0200
Message-ID: <CACRpkdaybnYEmkgv7VG4fh5sXQ7uwHm2wH2Khja-P1b6idYr8w@mail.gmail.com>
Subject: Re: [RESEND PATCH] pinctrl: qcom: lpass-lpi: fix concurrent register updates
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 4:57=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:


> The Qualcomm LPASS LPI pin controller driver uses one lock for guarding
> Read-Modify-Write code for slew rate registers.  However the pin
> configuration and muxing registers have exactly the same RMW code but
> are not protected.
>
> Pin controller framework does not provide locking here, thus it is
> possible to trigger simultaneous change of pin configuration registers
> resulting in non-atomic changes.
>
> Protect from concurrent access by re-using the same lock used to cover
> the slew rate register.  Using the same lock instead of adding second
> one will make more sense, once we add support for newer Qualcomm SoC,
> where slew rate is configured in the same register as pin
> configuration/muxing.
>
> Fixes: 6e261d1090d6 ("pinctrl: qcom: Add sm8250 lpass lpi pinctrl driver"=
)
> Cc: stable@vger.kernel.org
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Added Linus' review. Resending because no one picked up this patch.

What a mess, I applied the patch for fixes so I try to cram in a last
pull request before the merge window.

Yours,
Linus Walleij
