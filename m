Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9DB7F6358
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346309AbjKWPtX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Nov 2023 10:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346241AbjKWPtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:49:08 -0500
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95061739;
        Thu, 23 Nov 2023 07:48:55 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-db40849f2d5so1374713276.0;
        Thu, 23 Nov 2023 07:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700754534; x=1701359334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/SOfJqkoytaNeU5VNb3XcpwwjRQzzRj7rldaz7nZBI=;
        b=Sm7KAx0nf8tkV6NjPxwBbDPmcGVhtaRCtwpk0fXfbNqZ5P2vGngcJqHKtEZS9ofKbG
         SsMqsfwaMnlAlUIAVr4vQA02arcGel6ScVOWc9uJEdPWbKSqb5+/fQtJ8rX0FhvzJIOR
         wvpwcTnee+ryjvnERDb8/QQM/WZktP02lPFbztCMR0HPub/C5bknDJnbR3YizojWfv+k
         CPda9oZOIRTFPUBYjVmxPOlSdu3TwIeGDVp4XIwfnLAwhITg/OV7CTkWXZu/sWadh137
         vAH7wmQHSVpv9MJiUA4mHo+DroTW1ValK4AdK/TJ5lKs2QIT4n01ppfzLOTNC9DdJtiP
         FLaQ==
X-Gm-Message-State: AOJu0YzLCvtbYIFd+djoYEhPW42cT+PrM86VQVTmdp/frykGDtljAdGy
        j5SXfErDyocbmeqQHRwFR5E87gPktzcvAA==
X-Google-Smtp-Source: AGHT+IHX5/6A+/91ntECrBYe7ZkS/3dV1LmLW0vKJWZFGHyo67w7SvpLlREvYJHhXIuogovjrjZyjg==
X-Received: by 2002:a05:6902:4f4:b0:db4:2e2f:3ab4 with SMTP id w20-20020a05690204f400b00db42e2f3ab4mr2337886ybs.1.1700754534240;
        Thu, 23 Nov 2023 07:48:54 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id i143-20020a25d195000000b00da086d6921fsm374865ybg.50.2023.11.23.07.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 07:48:53 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5a877e0f0d8so16376927b3.1;
        Thu, 23 Nov 2023 07:48:52 -0800 (PST)
X-Received: by 2002:a0d:ccd0:0:b0:5a7:d8c8:aa17 with SMTP id
 o199-20020a0dccd0000000b005a7d8c8aa17mr2762297ywd.13.1700754532458; Thu, 23
 Nov 2023 07:48:52 -0800 (PST)
MIME-Version: 1.0
References: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com> <20231120070024.4079344-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231120070024.4079344-2-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Nov 2023 16:48:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWiJMDjHR72FfSQP9sWz2d-XOsPakvZ3HKRmZAakuPh1Q@mail.gmail.com>
Message-ID: <CAMuHMdWiJMDjHR72FfSQP9sWz2d-XOsPakvZ3HKRmZAakuPh1Q@mail.gmail.com>
Subject: Re: [PATCH 01/14] clk: renesas: rzg2l-cpg: Reuse code in rzg2l_cpg_reset()
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@armlinux.org.uk, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, p.zabel@pengutronix.de, arnd@arndb.de,
        m.szyprowski@samsung.com, alexandre.torgue@foss.st.com, afd@ti.com,
        broonie@kernel.org, alexander.stein@ew.tq-group.com,
        eugen.hristev@collabora.com, sergei.shtylyov@gmail.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 8:01 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Code in rzg2l_cpg_reset() is equivalent with the combined code of
> rzg2l_cpg_assert() and rzg2l_cpg_deassert(). There is no need to have
> different versions thus re-use rzg2l_cpg_assert() and rzg2l_cpg_deassert().
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.8.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
