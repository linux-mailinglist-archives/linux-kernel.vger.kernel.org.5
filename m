Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C143F7A08D5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240713AbjINPRt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 11:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjINPRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:17:48 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE3E1FC9;
        Thu, 14 Sep 2023 08:17:44 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-d7e741729a2so1151317276.2;
        Thu, 14 Sep 2023 08:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694704661; x=1695309461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEkJKx0NjBVdd3xMHiONy8V+yf50ybZmUTpOXQj8RoE=;
        b=dH7SuCRer46KaOVn+hpGtIwakV9ev8dWyNIHp7LX43rgOautvVzKq+dP3ICYL/MVjW
         iEE1W6fiLiNRQasifDd8g7HWk+BcS7dj3azd+li8rXj2tnYV68qn43nT9ygW9eGAF1HR
         IYxbHm+ylNvv8EBrJePQsmmdYGkSul8HnSQ1e1ZBNUxlMrkkbePSuwE+aiJkhsRZFy+s
         2yX0rNQvLDfPYN3Uj+6+8KoyqUk8F9dFlgSqngnVyjrIsWUXdEy5gHlDmIirICAqSz3C
         7JHnMYun6pXs4BuASYRqSdnKUb64E986SiX+caTSEV9S3jifxHI8nTlEHfreijp1VUGt
         jlbg==
X-Gm-Message-State: AOJu0YzGwSFKRybfvDsSS7E/buzPkLMYYY3roFy6e/opQB+0lKhtVZti
        D8rMMoLCEpjl7LUMGJgqq1NjP+o1MRQP+Q==
X-Google-Smtp-Source: AGHT+IElEWg2j/G1TPDgJ6GDDWWMMTKuTjJ6ifTRLmy7lxHCixE5BxLuAvmp0gp+Gm6DBVq4jio4lA==
X-Received: by 2002:a25:2d03:0:b0:d78:3f9c:138e with SMTP id t3-20020a252d03000000b00d783f9c138emr5969314ybt.37.1694704660879;
        Thu, 14 Sep 2023 08:17:40 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id b5-20020a5b0b45000000b00d816fa23bd4sm355682ybr.26.2023.09.14.08.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 08:17:40 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d7e741729a2so1151297276.2;
        Thu, 14 Sep 2023 08:17:40 -0700 (PDT)
X-Received: by 2002:a25:760c:0:b0:d7b:9d44:76dc with SMTP id
 r12-20020a25760c000000b00d7b9d4476dcmr6035360ybc.38.1694704660368; Thu, 14
 Sep 2023 08:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <20230912045157.177966-17-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-17-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Sep 2023 17:17:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXJUsbSbKhvxwvi4oG_K2v4w+5YU3VJL9J1X2mrdCA0ag@mail.gmail.com>
Message-ID: <CAMuHMdXJUsbSbKhvxwvi4oG_K2v4w+5YU3VJL9J1X2mrdCA0ag@mail.gmail.com>
Subject: Re: [PATCH 16/37] clk: renesas: rzg2l: add struct clk_hw_data
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
> Add clk_hw_data struct that keeps the core part of a clock data. The
> sd_hw_data embeds a member of type struct clk_hw_data along with other
> members (in the next commits). This commit prepares the field for
> refactoring the SD MUX clock driver.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
