Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E649C7A04FB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbjINNGy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 09:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238525AbjINNGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:06:52 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F891FD8;
        Thu, 14 Sep 2023 06:06:48 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5925e580e87so10731947b3.1;
        Thu, 14 Sep 2023 06:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694696807; x=1695301607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHc0DpORXlGUIyJemXMGFwVrMRXG1k2BQKoTOugDHHg=;
        b=nSnCrULD0xRPONVeIXpOGcYOD3VK7CYTIGIhbcix6oBrlHUv1znEG5FCdGtClrXkuH
         eAVRZVcEYehQhDj8Di+eFJAr+5wyiAwioQ4PH/Jf8v5+YdT71M4qZdkQcSJCWe1o0E8z
         YMKmZvFkr7GOD9Pk+C6+NYGayO1Tg+H564Ii10+w5G5cBQOyIN7qpFVQ9xY09wD80IGV
         RsSsVHtMwqnfdBZfdsdIvClelZaUyz1+hpfV/68b0JgUGjZa3F407UMd4yuce1fNcGY+
         OBr86ahmFxX0KT8+cH0iEY3Szg7Rqiyc6lvrNWEDLH09E8bL8CxvZckkGukU/1qoKBu8
         XOiA==
X-Gm-Message-State: AOJu0YwPB2KFNZ9xiPCFBcACgwLnzi6EydrFMEi3Qz3S4ck/OAGqqxRY
        HOLcKBsDdTiKz1gfEezc8TE8AV8BJQr/4g==
X-Google-Smtp-Source: AGHT+IFS9HoJ0Qyx9QUiGoaPAoioe4tpc9Q2XDgr11jN6FtP32a4AMfhhful3BVJwzCxVQ576y4bQA==
X-Received: by 2002:a05:690c:250d:b0:59b:ec40:a121 with SMTP id dt13-20020a05690c250d00b0059bec40a121mr1597344ywb.3.1694696807118;
        Thu, 14 Sep 2023 06:06:47 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id t125-20020a0dd183000000b00597e912e67esm304748ywd.131.2023.09.14.06.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 06:06:46 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d7e741729a2so989118276.2;
        Thu, 14 Sep 2023 06:06:46 -0700 (PDT)
X-Received: by 2002:a5b:bc6:0:b0:d80:1a0a:e7a7 with SMTP id
 c6-20020a5b0bc6000000b00d801a0ae7a7mr5064343ybr.53.1694696806097; Thu, 14 Sep
 2023 06:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <20230912045157.177966-12-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-12-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Sep 2023 15:06:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWDa0pmCR3Ma3KWhRTyXk13qXt0wsu50M9CRhNn5SSJ0A@mail.gmail.com>
Message-ID: <CAMuHMdWDa0pmCR3Ma3KWhRTyXk13qXt0wsu50M9CRhNn5SSJ0A@mail.gmail.com>
Subject: Re: [PATCH 11/37] clk: renesas: rzg2l: simplify a bit the logic in rzg2l_mod_clock_endisable()
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
> The bitmask << 16 is anyway set on both branches of if thus move it
> before the if and set the lower bits of registers only in case clock is
> enabled.
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
