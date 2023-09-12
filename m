Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C96779DCA4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 01:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbjILXaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 19:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjILXav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 19:30:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4FF10C7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 16:30:47 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52a3ff5f0abso7987751a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 16:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694561445; x=1695166245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiT6xmXSdGoBaHZvckfZjy18MoIhmr9QJ20ZYjr0eBk=;
        b=jwxjtWtnNgZGQxDzXYAC6JaARkuWiqA+k1hrJNVsQWvd8C7G/ZWIzu7BkAm6/r60Ss
         JHFzXYmNd/+UkcyZQ8xqQ1nOxjxyB+kpBbda63ChSNTmBmlwOpzfn1k6JJhsc14CWJtU
         43PuDrmhDY9XddaLWfiy+CXavUyR3/ClsBhWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694561445; x=1695166245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiT6xmXSdGoBaHZvckfZjy18MoIhmr9QJ20ZYjr0eBk=;
        b=c3UvIo668vnObyVjelSY1ae3PR4qe9GzD4KOWTozRdasvOkAjzPVvuko98HBMcQptC
         6Ogt/aOeWZoG5u51sFjAx5nDZvrkJ23GvDZBr6TAc8foKpdvPUihlFkRSXjFAlf6YBeX
         MqABCFCDu7/S0mXrTp7mkit9qepYmXHaNLm7IRurplceyryPVsAPrv0sGXL+QvWJZ0GM
         C4QRCZhPeaVg5PbvAhp4loao+oldhXVyajCSWYVpx5qgLgUZwQ/6BTSv4+qcilZYQ5kq
         +KK0fIs0kuNIUvv74XkDw8iuIrGMUU1qE1XVvhvKDU6abso4G7eZKZM8iibrg4s9d+ec
         brUg==
X-Gm-Message-State: AOJu0YwtFY0WX76Rjww3n2dkmx/VU06+JUHQ0L0Xa+kZZzi7p+vzkwag
        l046MK+9nqLg6I2rFWB2fjNWiMXZhjOytIoClVfgHw==
X-Google-Smtp-Source: AGHT+IEncmdYC1dSJlMD/QGNm7/UFTjPboRoiw3m5q6s+76h6YogJLeWSUZhVNAyC0A40XbJDw44Mg==
X-Received: by 2002:a50:ee04:0:b0:523:387d:f5f1 with SMTP id g4-20020a50ee04000000b00523387df5f1mr924457eds.24.1694561444733;
        Tue, 12 Sep 2023 16:30:44 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id h6-20020a0564020e8600b0052fa02d8efdsm1468375eda.39.2023.09.12.16.30.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 16:30:43 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-402c80b71ecso33675e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 16:30:43 -0700 (PDT)
X-Received: by 2002:a05:600c:5123:b0:403:9d52:195f with SMTP id
 o35-20020a05600c512300b004039d52195fmr57028wms.6.1694561443510; Tue, 12 Sep
 2023 16:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230912071205.11502-1-david@ixit.cz> <20230912071205.11502-2-david@ixit.cz>
In-Reply-To: <20230912071205.11502-2-david@ixit.cz>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 12 Sep 2023 16:30:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XYdvcF2mo9=-EBb4Ann1UAM1VFW61MH3yOWjyLqCJRiw@mail.gmail.com>
Message-ID: <CAD=FV=XYdvcF2mo9=-EBb4Ann1UAM1VFW61MH3yOWjyLqCJRiw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sdm845: cheza doesn't support
 LMh node
To:     David Heidelberg <david@ixit.cz>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 12, 2023 at 12:14=E2=80=AFAM David Heidelberg <david@ixit.cz> w=
rote:
>
> Cheza firmware doesn't allow controlling LMh from the operating system.
>
> Fixes: 36c6581214c4 ("arm64: dts: qcom: sdm845: Add support for LMh node"=
)
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2:
>  - moved power-domains removal from this patch to previous one, since
>    it's not related to LMh support
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

I haven't used a cheza in years, but this seems reasonable to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
