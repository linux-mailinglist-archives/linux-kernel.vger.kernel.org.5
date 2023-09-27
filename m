Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A918D7AFF91
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjI0JNL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Sep 2023 05:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjI0JNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:13:09 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5BA92;
        Wed, 27 Sep 2023 02:13:04 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-59bf1dde73fso136832087b3.3;
        Wed, 27 Sep 2023 02:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695805983; x=1696410783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHnJwbTT+NL76Y01vj09nEUgjneKsn8IwMUSAB7otyI=;
        b=rxkPTSF5eP4CIFDvLwTlm8zn0RcmQwGkSgiiW5v9nHcHerUabTSXbALzkU+iWaIxSS
         btmUs41U3s4nuKqXITlYjpKmZ2XZDrh5ULGoEuC1KluHyzjd9wrx/DFGCEG4zBjmT/z3
         vCAmESUlpCDwgkE4ghgp2eiJZ6pTkTBMYcoR1Vzw8/PPw0UbgQpmZVsqhcOnhp1lpPhf
         0qSzDwE410wuype6wWbtCYI5xzNE1K6vB/xBvynzwUq0FPcHeakGK1Aeg6tBWDT0R2b8
         S59rzrEj0LUT4D0BObyegDjuTxQ5T2rmH7D7V/f/5GW7SW6ProUkyl6umspocEJe/cS7
         DY+Q==
X-Gm-Message-State: AOJu0YwkW9DFjsQKgFzjRwUfoDfUPbIamk/0xPGlYGYkePkoocLRJGGL
        MwihwoLvucmFzdh9h0dyf26Kj75dCVFAow==
X-Google-Smtp-Source: AGHT+IFWaBM5hhOMeaReF11+CfnaHAilFR07R//vprByMeGRA+e62DC+eFfiFGXTB5T8Snn+On8Epg==
X-Received: by 2002:a81:df0e:0:b0:598:5bb5:1801 with SMTP id c14-20020a81df0e000000b005985bb51801mr1576463ywn.50.1695805983326;
        Wed, 27 Sep 2023 02:13:03 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id g203-20020a0dddd4000000b00592548b2c47sm3598015ywe.80.2023.09.27.02.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 02:13:02 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-59f6763767dso86956037b3.2;
        Wed, 27 Sep 2023 02:13:02 -0700 (PDT)
X-Received: by 2002:a0d:cbd6:0:b0:599:da80:e1eb with SMTP id
 n205-20020a0dcbd6000000b00599da80e1ebmr1944408ywd.24.1695805982143; Wed, 27
 Sep 2023 02:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230926210818.197356-1-fabrizio.castro.jz@renesas.com>
 <20230926210818.197356-3-fabrizio.castro.jz@renesas.com> <ZRPvikYWgbeDdz4X@finisterre.sirena.org.uk>
In-Reply-To: <ZRPvikYWgbeDdz4X@finisterre.sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Sep 2023 11:12:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUroPd17ynUtXpEpUfp_g352ukG-Fc+ySrrsVTJhMgONw@mail.gmail.com>
Message-ID: <CAMuHMdUroPd17ynUtXpEpUfp_g352ukG-Fc+ySrrsVTJhMgONw@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: rzv2m-csi: Add Slave mode support
To:     Mark Brown <broonie@kernel.org>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wed, Sep 27, 2023 at 11:02 AM Mark Brown <broonie@kernel.org> wrote:
> On Tue, Sep 26, 2023 at 10:08:18PM +0100, Fabrizio Castro wrote:
>
> > The CSI IP found inside the Renesas RZ/V2M SoC supports
> > both SPI Master and SPI Slave roles.
>
> Prefer controller and device.

You mean host and target?
(oops, got the latter wrong in my previous email, too ;-)

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
