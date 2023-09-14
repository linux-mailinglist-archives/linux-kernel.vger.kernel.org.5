Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1D87A056C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbjINNTq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 09:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239125AbjINNTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:19:32 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E94D2118;
        Thu, 14 Sep 2023 06:19:26 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-59be6bcf408so10975147b3.2;
        Thu, 14 Sep 2023 06:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694697565; x=1695302365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uZJSTJpkTY7WDoLQQFFp+wNWgzUgYBYIubQOSDA1p4=;
        b=d+GDl4HmOQuJucCMgKLXtlTYAaHozUBNEUHJfhAcLc9IA5olrnIdUAg18YKSUzPnTL
         FtKp7FTb2lXFSUl1NTI0Msa0kzCpWzYdSveGz/I4KDoVqv6+Z7wXz2Oqnd0QSKGGasHc
         spB1vnPynvMGzp9FePbu67aLbCZ4fT1GRE6hFn5POUMuvEnYoJHybHdKb197k87v5FxO
         43C4sb7wxnrLbzaeIbxd9YGSfRSuKsaumkKxjzlNovdlFsTCSbFkJJ8fp44n+z9/EYu1
         BdGcKfNZE1YnsDrHJANHtwwq8u+uaaC/28RVCyKOzn2cYi7cm5q2o3EkU3TI8VEcPmPj
         bKvQ==
X-Gm-Message-State: AOJu0YxSOtJ91M/+m8Eh/MFmaG109gAXcDnqrWU8O23ei7i3T4h7+5oP
        6Sdok6pH53rBLA2YNPB+61RcivhJz1cKpg==
X-Google-Smtp-Source: AGHT+IGeOj+7TvsOg0sYCahslHPaDV6RS/lHn+S2/o3KDQ6yeDkCQErAC2LuLGLdyhY61hcyAAcypA==
X-Received: by 2002:a0d:c087:0:b0:599:da80:e1e6 with SMTP id b129-20020a0dc087000000b00599da80e1e6mr5484264ywd.34.1694697565168;
        Thu, 14 Sep 2023 06:19:25 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id f4-20020a0ddc04000000b005869ca8da8esm307222ywe.146.2023.09.14.06.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 06:19:24 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d7ecdb99b7aso974501276.3;
        Thu, 14 Sep 2023 06:19:24 -0700 (PDT)
X-Received: by 2002:a5b:cca:0:b0:d7f:9215:6869 with SMTP id
 e10-20020a5b0cca000000b00d7f92156869mr5228632ybr.55.1694697564530; Thu, 14
 Sep 2023 06:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <20230912045157.177966-14-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-14-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Sep 2023 15:19:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWkOOPrwUX4iJCA5SqDGB+0WgU5yx_XzuoexKYu0Y=zkw@mail.gmail.com>
Message-ID: <CAMuHMdWkOOPrwUX4iJCA5SqDGB+0WgU5yx_XzuoexKYu0Y=zkw@mail.gmail.com>
Subject: Re: [PATCH 13/37] clk: renesas: rzg2l: use FIELD_GET() for PLL
 register fields
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 6:52 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Use FIELD_GET() for PLL register fields. This is its purpose.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
