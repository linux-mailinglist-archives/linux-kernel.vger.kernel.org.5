Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE877E04F7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjKCOsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjKCOsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:48:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3743AD56
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 07:48:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9c5b313b3ffso320909866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 07:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699022920; x=1699627720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfjHfwWNRKQtLWE4mF8zOuQXPhouIuA80xLEWdz457U=;
        b=bNUMumbdY6wGzVw2bEGrojJQ/4Iy2aBf0c22RXV6fISGXPZ7Y1/UkTEHflM4HcoZKO
         SG3L/0FEdZWOtVjD4dinX+pyaGQCWZB6aKjyP7I1a1TQ22JCojJtghOrcI5UTL+SsUOM
         BHgx94ErrVGeUboJcgTmC3lGH21uHkuOfJrXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699022920; x=1699627720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfjHfwWNRKQtLWE4mF8zOuQXPhouIuA80xLEWdz457U=;
        b=CNzkhxgWM/a1NxMgdBpNXS0awc/+J8JQEanYGaFcGnt2Xs3Qlc/Am8xeU7+oZiz1B4
         E8XTXpmDrRw3lkwSMEw3SODXliugRPR8+mZzq1ddKPXunHoLKLJM8dKkOnFIvQxh3pRc
         ihMQfq5MMjUGPPjWeV0ffim7Mhlp9BK2jI1y6N73gebDz1Pga6A4cQyi/NVt8kuXLoa/
         Wfv+oTiOr2BkHrOzyaQJOExwW/WnAedEGHTDm+ShxUBLR3UAWONjNGa3se3Sucf9eW4m
         HeM8ZDIftnXN1nwHRNff7krtIAifwl6jxQaUvxM8X3NU+/6Npjq8Qnaqk3o0/tfoQ5kv
         xSAg==
X-Gm-Message-State: AOJu0YxqdI/CNh78PevshFGcikZz16ZGHcGDWdnWdvxbOZempqI7tLUz
        oiT7UTa8kvDRk2uchcWzulEL7dxxoqGdedc2OpHktU13
X-Google-Smtp-Source: AGHT+IGty2dVAp/RsMz2JnrK3+vYowgf2xj5UoDO6YLKDLyXGDH5OhFl9mpwi3ibfBdqDved7UBXOg==
X-Received: by 2002:a17:907:a45:b0:9a2:86b:bb18 with SMTP id be5-20020a1709070a4500b009a2086bbb18mr7984650ejc.26.1699022920372;
        Fri, 03 Nov 2023 07:48:40 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id v4-20020a170906180400b009a1c05bd672sm978268eje.127.2023.11.03.07.48.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 07:48:39 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4078fe6a063so64935e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 07:48:39 -0700 (PDT)
X-Received: by 2002:a05:600c:1c26:b0:404:74f8:f47c with SMTP id
 j38-20020a05600c1c2600b0040474f8f47cmr171937wms.5.1699022919108; Fri, 03 Nov
 2023 07:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231103105712.1159213-1-quic_adhudase@quicinc.com>
In-Reply-To: <20231103105712.1159213-1-quic_adhudase@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 3 Nov 2023 07:48:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Un2GnOC64AXgKa31FNZ+FM2dMbHVT8UuZXNbMUDBD=8w@mail.gmail.com>
Message-ID: <CAD=FV=Un2GnOC64AXgKa31FNZ+FM2dMbHVT8UuZXNbMUDBD=8w@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc configuration
To:     Atul Dhudase <quic_adhudase@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        swboyd@chromium.org, isaacm@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 3, 2023 at 3:57=E2=80=AFAM Atul Dhudase <quic_adhudase@quicinc.=
com> wrote:
>
> While programming dis_cap_alloc and retain_on_pc, set a bit
> corresponding to a specific SCID without disturbing the
> previously configured bits.
>
> Fixes: c14e64b46944 ("soc: qcom: llcc: Support chipsets that can write to=
 llcc")
> Signed-off-by: Atul Dhudase <quic_adhudase@quicinc.com>
> ---
>  drivers/soc/qcom/llcc-qcom.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 674abd0d6700..509d972c1bd9 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -941,15 +941,15 @@ static int _qcom_llcc_cfg_program(const struct llcc=
_slice_config *config,
>                 u32 disable_cap_alloc, retain_pc;
>
>                 disable_cap_alloc =3D config->dis_cap_alloc << config->sl=
ice_id;
> -               ret =3D regmap_write(drv_data->bcast_regmap,
> -                               LLCC_TRP_SCID_DIS_CAP_ALLOC, disable_cap_=
alloc);
> +               ret =3D regmap_update_bits(drv_data->bcast_regmap, LLCC_T=
RP_SCID_DIS_CAP_ALLOC,
> +                               BIT(config->slice_id), disable_cap_alloc)=
;
>                 if (ret)
>                         return ret;
>
>                 if (drv_data->version < LLCC_VERSION_4_1_0_0) {
>                         retain_pc =3D config->retain_on_pc << config->sli=
ce_id;
> -                       ret =3D regmap_write(drv_data->bcast_regmap,
> -                                       LLCC_TRP_PCB_ACT, retain_pc);
> +                       ret =3D regmap_update_bits(drv_data->bcast_regmap=
, LLCC_TRP_PCB_ACT,
> +                                       BIT(config->slice_id), retain_pc)=
;

Wow, that seems pretty serious. As far as I can tell this looks correct.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
