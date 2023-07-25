Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1627620BA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjGYR61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjGYR6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:58:24 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC4ABB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:58:21 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9891c73e0fbso23784566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690307898; x=1690912698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b46yA1Vvz5EBZCOyU8aDfGflg6YOPM/a7952vWZXQbs=;
        b=X81Eg+KiyJkaBmeVc7EzuZxmo2VAgibDS6w9rEvwlAfI6tGsS0j7KOFV9ugSL2rwNU
         Z88MZ/QzLnnbm0huHZtZLjh2zPf+1Gqt6pgk79KKrxL9k7PkcaPEr9hREGK3AzlTnfNM
         hu4xfVfmIw/WiTeUz/2DAZVTDsmJrhk4SlXZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690307898; x=1690912698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b46yA1Vvz5EBZCOyU8aDfGflg6YOPM/a7952vWZXQbs=;
        b=Hgc57uRBieV3sL/gI9/vEiWPqCQbu/18hgLTck62+lKmnRHlYuSsgZ0fD7DtZktwTj
         USDKs9fxYYfuSSEh6cvzUk3uLGydPDXcbW3I/agXUAcxJ/gYoW43BF47bQsXmpqwrjTR
         Vr/DYP6+wNyXiErb6QXKyWmopkqfulHtjyM16AZxKgENNI7Lntug7eLc6sSwHu6XLpAW
         2D8AGwiWMtpaMGgYs9ss82XlTtX+/yR9Q6UGIL/GRbF3FazJ6pUZjik2o2vFfKL6iTjS
         q8mwCUMcyg6OXXuF69HZ3BlUhfcwzn7MJ151Rdg49qeslzUOXpo8McnQGzmTybHPHI4x
         HysA==
X-Gm-Message-State: ABy/qLYv25W1q1zA3wWe1RQvdnCdXwfY/HaBFRlSJmnuFdmtNJvYY96f
        vZlb9aNIkblatB80zFczhrxsBhXN9c3j2lDxc7SG6hPY
X-Google-Smtp-Source: APBJJlEP6jrB82m666XV98rnTqsmVCwLeF/9rjQpuxIx+FK/Qqfjn91yFN30aS4rg2gowCBvXHrt4g==
X-Received: by 2002:a17:906:3f1a:b0:998:de72:4c8c with SMTP id c26-20020a1709063f1a00b00998de724c8cmr3005627ejj.35.1690307898326;
        Tue, 25 Jul 2023 10:58:18 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id b19-20020a170906039300b0099364d9f0e2sm8528976eja.98.2023.07.25.10.58.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 10:58:17 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so1476a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:58:17 -0700 (PDT)
X-Received: by 2002:a50:d55c:0:b0:51e:16c5:2004 with SMTP id
 f28-20020a50d55c000000b0051e16c52004mr143860edj.6.1690307897245; Tue, 25 Jul
 2023 10:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <1690285689-30233-1-git-send-email-quic_vnivarth@quicinc.com> <1690285689-30233-3-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1690285689-30233-3-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Jul 2023 10:58:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wb4_q7xL_ec=_=bQodb0dy18HQzY=E855mZ1r+5G36uQ@mail.gmail.com>
Message-ID: <CAD=FV=Wb4_q7xL_ec=_=bQodb0dy18HQzY=E855mZ1r+5G36uQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] spi: spi-qcom-qspi: Use GFP_ATOMIC flag while
 allocating for descriptor
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com, dan.carpenter@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 25, 2023 at 4:48=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> While allocating for DMA descriptor, GFP_KERNEL flag is being used and
> this allocation happens within critical section with spinlock acquired.
> This generates a static checker warning.
>
> Use GFP_ATOMIC to prevent sleeping; and since this increases chances of
> allocation failure, add handling accordingly.
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/abc223e8-44af-40bb-a0bd-9865b393f435@=
moroto.mountain/
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/spi/spi-qcom-qspi.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Fixes: b5762d95607e ("spi: spi-qcom-qspi: Add DMA mode support")
Reviewed-by: Douglas Anderson <dianders@chromium.org>
