Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1427A7EB10D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjKNNnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjKNNnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:43:20 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF93132
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:43:17 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5c08c47c055so43557107b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699969396; x=1700574196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9I1+HuMjUOXRka8oYccWC1sMj8od0MqtKuun6lk2Gk=;
        b=uGfl/YPkEfMjZMYLIB1JYHwyMWDbX+7Moj6UkcY5WctHf4vK6jBsJlRC/P8B0wXK6P
         +n3GEnKShGHX4sHXuSvEVnV1oZtQ/QMNJHdci++o34sFJZfvzhP4NP75CKYpDpaDp8DT
         KrJMynCOsZQ/WsJMeXK4WLzO8UW04s+l9q9hXvDBtJr648Ts9Hy3AZEq+zJT7EjzbKmL
         P6brX/D8EoNnJyDnyxN5gcr4RuHNO/x/Xt0OwgF3xWGj7kLmw5y0xqsJtXViBxfn4V04
         Zyntpo77Vppx/zgE/l9JAdueaugid0jSnRJnHx/VT3wYlPkAz8d2sWQ009xpvsRFVU1o
         +Gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699969396; x=1700574196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9I1+HuMjUOXRka8oYccWC1sMj8od0MqtKuun6lk2Gk=;
        b=XCbrzyHeRrpRGqdP6DDDPcMSgxPVrqGf1b01btqjcf5h42tBR66ALJ348BtyS6M4ts
         RiiapOZKIdSL3g3S5FxK7N7lSPtJKo9UdqHfvL14mBqTaVUHJYfs7mNQHbY9dNjZiaYC
         341Zg0FlFQMGooWe9D2dmX1hyndv8nTLHW8LEO4at1wkYKfkHHtbLq8SwgqCJIi0iKfB
         Ru7Rz1AgZKfLAOt79fsZS1Ze3NTy5hgD/2N1ZednHc5mRZccIZe+LEswNv4mktXg4wh+
         G8QOqoz+p+7i4znbKMIfZzxwnvGnMoSIYXgY5DSa1HWZqK/S6cKIbISB+4OrWOYZMsaa
         FNnQ==
X-Gm-Message-State: AOJu0YzYzJ1UwQEI8G0Qyh8mkvMEjEY69d6WC4elyxxfeNnwMLB4oqfu
        OOh9rdR2S7zl4G2l7QpphNgo4Z9ebBr3YxnDdY0Plw==
X-Google-Smtp-Source: AGHT+IETVNVRx+UHRWTMbFT8MvR2FR1FnRXu1s74l+weM1l/KrAH5OgSnaA8wp+8GfGDd6aNNN115dmrpYwW1pLZt5o=
X-Received: by 2002:a81:8357:0:b0:5ad:cd52:d6f0 with SMTP id
 t84-20020a818357000000b005adcd52d6f0mr10580139ywf.45.1699969396564; Tue, 14
 Nov 2023 05:43:16 -0800 (PST)
MIME-Version: 1.0
References: <20231107110520.4449-1-antonio.borneo@foss.st.com>
In-Reply-To: <20231107110520.4449-1-antonio.borneo@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Nov 2023 14:43:05 +0100
Message-ID: <CACRpkdZziT+3E30-u_PV8Q=eR=8r8N-s7QomCbmdLi2BtD4WXg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stm32: fix array read out of bound
To:     Antonio Borneo <antonio.borneo@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        linux-gpio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 12:06=E2=80=AFPM Antonio Borneo
<antonio.borneo@foss.st.com> wrote:

> The existing code does not verify if the "tentative" index exceeds
> the size of the array, causing out of bound read.
> Issue identified with kasan.
>
> Check the index before using it.
>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> Fixes: 32c170ff15b0 ("pinctrl: stm32: set default gpio line names using p=
in names")

Patch applied for fixes.

And now I feel better about that I spent so much time porting Kasan to ARM3=
2.

Yours,
Linus Walleij
