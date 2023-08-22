Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80A4784B38
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjHVUPe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Aug 2023 16:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjHVUPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:15:33 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8790CE8;
        Tue, 22 Aug 2023 13:15:31 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-569612f9d89so306767a12.0;
        Tue, 22 Aug 2023 13:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692735331; x=1693340131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1F/YuUxdcKJr7smXX2ZZ2vuPoNRmrhMlAHFUit9bp0=;
        b=PtlEtHBf1yxTsO7Rr4SSf8/WDIfspVTLvux3Zv8lwDdapvziiiakfaJlvDVu4UuDYC
         xSLLDtboaVE+ZOrOE90nAx6aXL1koZ4KGSjwtYxEXZJeMUB2VCPlnx8wKjLiy7QbNEcL
         hRzfweuo4HClq0Fa3nmdPLRN6smjTb+qNmDy5XNidDXenpGV+Zzz6dooN2EqPaM2CtpQ
         FYjDM1SYGc188foKDoJ73Y7i0UVdIPEHDbxnffFlTb43fr9xZ5zbWUcY4ie1rfpXinKm
         7MckevB41gYhGQE5U+/KSN9Tj9lDLvPMR4GoX3REhYIiYVmJv8vwAoJA8hrl+bGEpcjj
         jr1A==
X-Gm-Message-State: AOJu0YyoSswL1U59Ea++V4+lX1oMU5gJnqwzy4oG3qdBgPSslrfG/cee
        uiuZA/+A+so+JU9MOE/sJh5YLPsQ70kGBjMfaVU=
X-Google-Smtp-Source: AGHT+IFmBDkLRRJmA2VZ8BjkFl4TGw+aAVWGGca1M5OjSqJ2HlQnrpKtMtsmEIwSvaYIqleolv5msCH0uoO+D3s9G8A=
X-Received: by 2002:a17:90a:680e:b0:26d:2635:5a7c with SMTP id
 p14-20020a17090a680e00b0026d26355a7cmr9661643pjj.2.1692735331184; Tue, 22 Aug
 2023 13:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230816145741.1472721-1-abel.vesa@linaro.org>
In-Reply-To: <20230816145741.1472721-1-abel.vesa@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Aug 2023 22:15:19 +0200
Message-ID: <CAJZ5v0iCap-HgejaXPi4h_CROWJXBSRDQZ57Z7Tgi67FeDXnAw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] PM: domains: Add control for switching back and
 forth to HW control
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 4:57 PM Abel Vesa <abel.vesa@linaro.org> wrote:
>
> The v1 (and the back story) can be found here:
> https://lore.kernel.org/all/20230628105652.1670316-1-abel.vesa@linaro.org/
>
> Changes since v1:
>  * patch for printing domain HW-managed mode in the summary
>  * patch that adds one consumer (venus)
>  * patch for gdsc with new (different) flag
>  * patch for videocc GDSC provider to update flags
>
> Abel Vesa (1):
>   PM: domains: Add the domain HW-managed mode to the summary
>
> Jagadeesh Kona (4):
>   clk: qcom: gdsc: Add set and get hwmode callbacks to switch GDSC mode
>   clk: qcom: Use HW_CTRL_TRIGGER flag to switch video GDSC to HW mode
>   clk: qcom: videocc-sm8550: Use HW_CTRL_TRIGGER instead of HW_CTRL for
>     GDSC
>   venus: pm_helpers: Use dev_pm_genpd_set_hwmode to switch GDSC mode
>
> Ulf Hansson (1):
>   PM: domains: Allow devices attached to genpd to be managed by HW
>
>  drivers/base/power/domain.c                   | 84 ++++++++++++++++++-
>  drivers/clk/qcom/gdsc.c                       | 32 +++++++
>  drivers/clk/qcom/gdsc.h                       |  1 +
>  drivers/clk/qcom/videocc-sc7180.c             |  2 +-
>  drivers/clk/qcom/videocc-sc7280.c             |  2 +-
>  drivers/clk/qcom/videocc-sdm845.c             |  4 +-
>  drivers/clk/qcom/videocc-sm8250.c             |  4 +-
>  drivers/clk/qcom/videocc-sm8550.c             |  4 +-
>  drivers/media/platform/qcom/venus/core.c      |  4 +
>  drivers/media/platform/qcom/venus/core.h      |  1 +
>  .../media/platform/qcom/venus/pm_helpers.c    | 47 +++++------
>  include/linux/pm_domain.h                     | 17 ++++
>  12 files changed, 165 insertions(+), 37 deletions(-)
>
> --

The second patch requires an ACK from Ulf anyway and with his ACK the
whole series can be routed via arm-soc as far as I'm concerned.

I have nothing to add here.

Thanks!
