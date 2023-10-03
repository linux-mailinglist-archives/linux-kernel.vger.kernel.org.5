Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E6C7B6CCC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjJCPPL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 11:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjJCPPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:15:10 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5409AC9;
        Tue,  3 Oct 2023 08:15:07 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d89ba259964so1083560276.2;
        Tue, 03 Oct 2023 08:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696346106; x=1696950906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNhSWAJYWgEDGwtiwjiH8QlfR14j4fmvgyQzNmxJTSU=;
        b=hTTSn+f/bb+WTxFkvDp05w1vE/lXlwsWqeqPT4+qH/40lO/BCZJctOJGZYFqmWQ9tM
         /s+xSAGesrsVct28+zPj5ZVDwZl6Z7QotY+zEusjU4/H0Wi02H8eampKA//fh82nBTwl
         PRUbFloArUCcI2w9oE0VjOz3/R1qh8lk7hxmd7xLo8XL6Lv0Tq2lxkst1covBvYTSbs8
         k5EXDJabrOFHiVASeWKGbZE0241i4l7DC9d/4h4OgpcfO9TCkBvo7KYhE3sOVj5CliXR
         g9v9QoEV7neziIzvzx8xtH2OeC3lLDmrWo/FzhGkHNAebd+MtCzMis+Tuvi4RnKwKQqV
         qpfg==
X-Gm-Message-State: AOJu0YwM3wBS5ogjM6gVmTRIwzvk2yYQZGck5crEgDviBwdVqCJwngS8
        ErDWM80uVMgWIWnUPxGeRif1okY9SFBn2w==
X-Google-Smtp-Source: AGHT+IExJlaND/bKWaUuUpX2KdLNm1zvoB5Wk69ljUOGH9ijRnq7wIvdjSmpFe3169JwdwbYzwC47A==
X-Received: by 2002:a25:941:0:b0:d89:4343:a0a5 with SMTP id u1-20020a250941000000b00d894343a0a5mr13217297ybm.42.1696346106075;
        Tue, 03 Oct 2023 08:15:06 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id a9-20020a259389000000b00d8128f9a46bsm449515ybm.37.2023.10.03.08.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 08:15:04 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d8181087dc9so1082657276.3;
        Tue, 03 Oct 2023 08:15:04 -0700 (PDT)
X-Received: by 2002:a25:c791:0:b0:d81:6e88:7cb3 with SMTP id
 w139-20020a25c791000000b00d816e887cb3mr14108080ybe.47.1696346103886; Tue, 03
 Oct 2023 08:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com> <20230929053915.1530607-3-claudiu.beznea@bp.renesas.com>
In-Reply-To: <20230929053915.1530607-3-claudiu.beznea@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Oct 2023 17:14:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXsECEfYmqiGSdkkeyCvD87mAp_LGHdXy+Q_hDAPNRiFg@mail.gmail.com>
Message-ID: <CAMuHMdXsECEfYmqiGSdkkeyCvD87mAp_LGHdXy+Q_hDAPNRiFg@mail.gmail.com>
Subject: Re: [PATCH v2 02/28] clk: renesas: rzg2l: wait for status bit of SD
 mux before continuing
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, konrad.dybcio@linaro.org, arnd@arndb.de,
        neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 7:39 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Hardware user manual of RZ/G2L (r01uh0914ej0130-rzg2l-rzg2lc.pdf,
> chapter 7.4.7 Procedure for Switching Clocks by the Dynamic Switching
> Frequency Selectors) specifies that we need to check CPG_PL2SDHI_DSEL for
> SD clock switching status.
>
> Fixes: eaff33646f4cb ("clk: renesas: rzg2l: Add SDHI clk mux support")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - initialized msk

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
