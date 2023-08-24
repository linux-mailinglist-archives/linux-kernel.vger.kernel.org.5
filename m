Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1ED37877C3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242992AbjHXSZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243062AbjHXSZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:25:27 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D406E1BF2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:25:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-986d8332f50so9312766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692901522; x=1693506322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/dmEEbj7+i/B+fm5A2Uaw5rpUCMdPhpq0R3TswGQcw=;
        b=R2eMJxiXeuLEd+V7um/DUPtNQDItKfs9VqHmea3P7OhicvkxcrN0T3O/WhQOjtSqJA
         ELzA/1CmHxsyekuXm+SKsK2zRGKZlRRGOih2u7HjrVnUI7ld1nQ5MRnRZVBJ/T17ru38
         LQiPp818Lti5vwQwDVUK2yj4IGBVeF5SmfCbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901522; x=1693506322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/dmEEbj7+i/B+fm5A2Uaw5rpUCMdPhpq0R3TswGQcw=;
        b=S240f8qOCVf7EQ2ZYu4BLHIa8z3OW+4ioOmzqGn+26vthKkZFEPoNRIxGFsDNSh3iE
         aiGPZ1ch6BiiijvUZXfUxzbHt2+PtRFZ4ujOF3W1wyxqouoLdu6Yxd0EuSXMm93VfpCK
         KNj3ycOI2ChJJDtXm/lhNDrBZwHafJjqxiAG/Vmdcbro/ad6uhgnOGzdVhvkddvgPsFa
         SKEE0yzebk8NVwFX3Ha3DQhVswthRItVECEU0/zuBuTZLwDuEkQklNKqxcvpzJZ9UBPX
         K9L0gLM1xW+5aDQ4jo8VhdTqUniQRTBF/RzL4EAvYif5kF/ac8azqKVRFDoCvA87sBib
         EPGw==
X-Gm-Message-State: AOJu0Yx+mKsM9uCN8oFNHYLA7MMH6qfu++z0saaxnmjin/cKTi+wDLan
        hYXugnUbwXpXg/9Mk+vWhWRhvXPBfgoB4DYdP00XZFiM
X-Google-Smtp-Source: AGHT+IFOPJX5gdCHVmYX/0T26D6mYHk34VrdDdH36wnGwN3GTO2nAUVM/ULi4H1v3REVNN6DIWXxvw==
X-Received: by 2002:a17:906:51d3:b0:9a1:e941:6f47 with SMTP id v19-20020a17090651d300b009a1e9416f47mr4239991ejk.42.1692901521990;
        Thu, 24 Aug 2023 11:25:21 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id l1-20020a1709060e0100b0099b6becb107sm11415463eji.95.2023.08.24.11.25.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 11:25:21 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so13065e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:25:21 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba5:b0:3fe:dd72:13ae with SMTP id
 n37-20020a05600c3ba500b003fedd7213aemr24711wms.0.1692901521167; Thu, 24 Aug
 2023 11:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230823222741.89584-1-david@ixit.cz>
In-Reply-To: <20230823222741.89584-1-david@ixit.cz>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 24 Aug 2023 11:25:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VqzpL1n16eBrV7N_i8Zx3-eJRUBY+NgZxjBqaZQCYkdA@mail.gmail.com>
Message-ID: <CAD=FV=VqzpL1n16eBrV7N_i8Zx3-eJRUBY+NgZxjBqaZQCYkdA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sdm845: Fix PSCI power domain names
To:     David Heidelberg <david@ixit.cz>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 23, 2023 at 3:28=E2=80=AFPM David Heidelberg <david@ixit.cz> wr=
ote:
>
> The original commit hasn't been updated according to
> refactoring done in sdm845.dtsi.
>
> Fixes: a1ade6cac5a2 ("arm64: dts: qcom: sdm845: Switch PSCI cpu idle stat=
es from PC to OSI")
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
