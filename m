Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B657B273D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjI1VMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1VMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:12:51 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4974CF3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:12:50 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9b281a2aa94so1166407966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695935569; x=1696540369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPv1pC+VCKhvZ3GzFtn0QfxJiJssysFSOtklYYl2yJw=;
        b=VRKfA6rWkZ+yeen8f8R8Kb0PC+c6XpLGvY5ipyAOpBgnQXLP2CvccDEUsLQPOaiU2Z
         KNOA4r317C6D/Qxm+v5iADNmdjtUeUIGke8NzgTCcUBkhdAiA0JJUWxmToAbFHEy4jx8
         PjohKRbaoyMVxRjAuHZsQ44YNAJfnq6VH4EkHkvQp9+roHbBwyM4lciuqDG17KlYubW8
         gc3DYRB75BUhyI9xoejZp3oG474Js7SN4KhQBs7uo/3RRRhahzgapaSUaMaV07IEOVXQ
         TMpFfSf5so2AwXlArgVcf0MG4cB6mRBI3Q0FQyx3b/TQ9a166hKtxawC9+wPDsNffJQ8
         nByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695935569; x=1696540369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPv1pC+VCKhvZ3GzFtn0QfxJiJssysFSOtklYYl2yJw=;
        b=UTSsfxacgev9/uxkabjvzbiQatO6a5IEl6mRnRlSztpajyZcFv7paYxZNhvbHhjzGj
         +g5jl/s6Cadi8xvmnHABweqZMyNnYwLPQTWzKajpFcRojXjAwAaFvaFw/lA+WZGiYDU/
         EkGzLR3MBTw/qAY8LNCoXGUJN4x4PiNvg2HwAucg3i/Q6d0W2cyyhaFH4qohKw5cyZ7v
         Ew86K96jdZPTYEvON51dUeDoDmYB8qrik7FmRog+TNIu/3REo2P39MDtlfmWeXNCWfT3
         6PAgiVgqBNSBct/fEKSjwyOWqwSGJ4lgSrtQmYkZJb/8fBUFfceemrTza0R5j/gq/lGU
         dGQw==
X-Gm-Message-State: AOJu0YyYFWt2bQyfmhwDhWx+OnewzQz1h79Qa1gNt6xGs0dszzceUNvo
        fVtcU34wAkNsYgIJLxarBtY=
X-Google-Smtp-Source: AGHT+IEmvw6hPGZYTNNC3NPfpIJu5J8U3nGXJCqgO7G37nKTfW9VAX5RLgdhpbFF6N+MgMW61GiEoA==
X-Received: by 2002:a17:907:2cea:b0:98e:26ae:9b07 with SMTP id hz10-20020a1709072cea00b0098e26ae9b07mr2185247ejc.35.1695935568532;
        Thu, 28 Sep 2023 14:12:48 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
        by smtp.gmail.com with ESMTPSA id sd6-20020a170906ce2600b0098e34446464sm11429796ejb.25.2023.09.28.14.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 14:12:47 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 28 Sep 2023 23:12:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] irqchip fixes for 6.6, take #1
Message-ID: <ZRXsTcNpxHbHN3Yz@gmail.com>
References: <20230924094105.2361754-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230924094105.2361754-1-maz@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Marc Zyngier <maz@kernel.org> wrote:

> Neil Armstrong (1):
>       irqchip/qcom-pdc: Add support for v3.2 HW

This commit has a broken SOB chain:

  From: Neil Armstrong <neil.armstrong@linaro.org>
  Date: Tue, 5 Sep 2023 15:19:25 +0200
  Subject: [PATCH] irqchip/qcom-pdc: Add support for v3.2 HW

  ...

  Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
  Reviewed-by: Maulik Shah <quic_mkshah@quicinc.com>
  Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
  Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
  Signed-off-by: Marc Zyngier <maz@kernel.org>

The first SOB (Dmitry Baryshkov) is not the author (Neil Armstrong).

Also, please group SOBs together, as is the usual core kernel style.

Thanks,

	Ingo
