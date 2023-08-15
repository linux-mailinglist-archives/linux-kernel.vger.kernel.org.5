Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620AC77D4F9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbjHOVNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240235AbjHOVNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:13:19 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A31810EC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:13:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bccc9ec02so820222666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692133991; x=1692738791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQL376aYCM3mORsHenByKOm9UE97TQIxr1RFcgdCPKQ=;
        b=HAK8GG9O0/3jtFiiUynpPDzV212pGhmNxm8edooqqx/pAVg29LxGMQ4IN1wOJVDRDH
         J4iF2vhWI6iDRdiI1VrzmxURR3gKR42BFFKZlEXX+U2ZvqulAXJhlpztmEeox+MIU8+0
         x1z8/m5LOWL2MKyscFagcCs0p8Hp0o4RQEHBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692133991; x=1692738791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQL376aYCM3mORsHenByKOm9UE97TQIxr1RFcgdCPKQ=;
        b=CkI7MY9X9t9pz1Ye4aTmIfrYpNN1jCGAWgwB00BuMaR79XX75e/eKmCXV75Z4+Vqjv
         cOret7qhZXQ86t96Zrck+Vu0ixibadthWIlzpP3gK/Qhv7UFbLdUqOOTGDGZ5DjNYYFk
         OTHtIJRvs5dvC7Adsn/3314RI8gXyjkxRknFx03xGQ28qFiD4pBxh3SXkhtcIlf91yIL
         UclCklhm4CN6akdB+52hG04+kfcQwkrOieTDW0guSbsaprTQ5gmgdwXKW0c4thjrdQmi
         YKnLG7tk8LX/GhXoAOgMQlLmfyi2o5hLHKvzfuCBILv0L5JdZe9+UKxHkb4QQV5qQcVk
         H/Sw==
X-Gm-Message-State: AOJu0YwOC8o2t/ZplqMpMUv48MlhkiSMYgMm6zStWCUmSx31sydJpi5Q
        odNjjPM8YVM354wc+b5ZDl5srJ+RHPzJd9XjK+HCR8+e
X-Google-Smtp-Source: AGHT+IFW3rOoHJuHJHpWDSQ/6FgnOxoDAP4ymHiELjkL6MuMlfxJER3ZcNS1QrPnyPMatLlM+p8TpA==
X-Received: by 2002:a17:907:a075:b0:99c:1ed1:65b2 with SMTP id ia21-20020a170907a07500b0099c1ed165b2mr10343459ejc.33.1692133991680;
        Tue, 15 Aug 2023 14:13:11 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id gw4-20020a170906f14400b00993b381f808sm7491477ejb.38.2023.08.15.14.13.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 14:13:10 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3fe2a116565so8925e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:13:09 -0700 (PDT)
X-Received: by 2002:a05:600c:5126:b0:3fc:75d:8f85 with SMTP id
 o38-20020a05600c512600b003fc075d8f85mr36477wms.6.1692133989440; Tue, 15 Aug
 2023 14:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230809064908.193739-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20230809144516.v3.3.Ie77732a87ab53d21bac47db309b75a796fa19337@changeid>
 <cd15df3a-eadc-13d6-7088-3ad785ea733e@linaro.org> <4e05a1fb-f6f2-3219-b41d-67351c70a7ff@linaro.org>
 <1dfaf72b-1e2a-e771-39f9-c3a5cf1c8463@linaro.org> <20230814094802.9127-1-sheng-liang.pan@quanta.corp-partner.google.com>
In-Reply-To: <20230814094802.9127-1-sheng-liang.pan@quanta.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 15 Aug 2023 14:12:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U1_yxPT1=ncYBdd33HSuoqSiQ8Uzt2+ETkS-Doj06azA@mail.gmail.com>
Message-ID: <CAD=FV=U1_yxPT1=ncYBdd33HSuoqSiQ8Uzt2+ETkS-Doj06azA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sc7180: Add board id for lazor/limozeen
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Cc:     krzysztof.kozlowski@linaro.org, agross@kernel.org,
        andersson@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 14, 2023 at 2:49=E2=80=AFAM Sheng-Liang Pan
<sheng-liang.pan@quanta.corp-partner.google.com> wrote:
>
> >> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> On 10/08/2023 11:30, Sheng-Liang Pan wrote:
> >>>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>>
> >>>>> Isn't this duplicated with r9? Probably other places as well... or.=
...
> >>>>> separate r10 add rt5682s node which different with r9.
> >>>> we separate r10 add rt5682s which differentwith r9
> >>>>
> >>>>
> >>>>>> -        model =3D "Google Lazor Limozeen without Touchscreen (rev=
9+)";
> >>>>>> -        compatible =3D "google,lazor-sku6", "google,lazor-sku18",=
 "qcom,sc7180";
> >>>>>> +        model =3D "Google Lazor Limozeen without Touchscreen (rev=
9)";
> >>>>>> +        compatible =3D "google,lazor-rev9-sku6", "google,lazor-re=
v9-sku18", "qcom,sc7180";
> >>>>
> >>>>> Your patch 2 does not make any sense. Didn't you touch it in patch =
2?
> >>>>> Really, what is happening here?
> >>>> patch 2 explain why we added new sku for no-eSIM.
> >>>
> >>> So which commit explain why you touch the same line twice? Sorry, thi=
s
> >>> does not make sense.
> >>>
> >>> Best regards,
> >>> Krzysztof
> >>
> >> We sort patch by change order,
> >> fist request for non-eSIM, patch2 add new sku 10, 15 for non-eSIM, and=
 18, but keep the newset reversion is r9,
> >> after add non-eSIM SKU, a sencond request for ALC5682i-VS,
> >> so continue patch2 we upreversion r10 which include rt5682s node.
> >
> > I barely can parse it, but anyway does not look right. You explained
> > what you are doing but it does not explain why touching the same line
> > twice. There is no point in making one board new SKU, but then
> > immediately change it to something else. The previous commit is just no=
-op.
> >
> > Best regards,
> > Krzysztof
>
> Thanks Krzysztof.
>
> Hi Douglas,
> May I consult with you if you can accept we merge patch2 and patch3 toget=
her?

I have no objection to merging patch #2 and patch #3 into one patch if
that makes it better for Krzysztof.

-Doug
