Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5758112F6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379238AbjLMNcE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 08:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379232AbjLMNby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:31:54 -0500
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC817107;
        Wed, 13 Dec 2023 05:31:57 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-db538b07865so7148265276.2;
        Wed, 13 Dec 2023 05:31:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474316; x=1703079116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ByD+WhHBWOGKiqiMHh0fO3Oon6EHmqlUadQiQzx7t8=;
        b=KNjX9y7hM9XHp0ODBk7facblQo1ZXMIZ1MjvxE9g8UWTrk+LBjk7OFoXWrs3biuvRZ
         NeeT1+Ba5NkGpxhwmTlUzn9tiVS4hF0zc+zxsWC604/PrNcxaFMmuS9ymTms1RM9slbL
         CGw6vjT1FmTgzfYO+Mctys2WzUMIWkTJ4AqZ/bZjagRzTxqViCRmayopEA+Dxgz6/5Qv
         8OSzd+S6ALzcFqhOx+I62K8NyAjwIk3hS3VMb+Zp7wSADQDydKbkjNtX2lOeTkClBqwn
         H0m5BOANHux9o2kWHuomgpZxCTxAIRo6JpVRzbkjHkEifq8wAmTvplq4NRRJdsnYDePM
         1K0Q==
X-Gm-Message-State: AOJu0YxdEFK32NEc0+HLn8/0ApED/QlCQn9LfC6TbShXTv1bAHUhM73D
        P+E/yh5OpWv5aXqPhi7KhhsdG/Eb8Kkvmw==
X-Google-Smtp-Source: AGHT+IH5Wy8HCpG0Da2bbQB8VMzjHdvSLWPqfUL2GBw1r6l1/12fv9QkqbAt56i7cc313+R5GoVVbw==
X-Received: by 2002:a05:6902:150:b0:db7:dacf:ed8b with SMTP id p16-20020a056902015000b00db7dacfed8bmr5694588ybh.108.1702474316690;
        Wed, 13 Dec 2023 05:31:56 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id q3-20020a258203000000b00dbcd92f26d4sm174366ybk.20.2023.12.13.05.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:31:56 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbcd28d5004so516019276.1;
        Wed, 13 Dec 2023 05:31:56 -0800 (PST)
X-Received: by 2002:a25:bf85:0:b0:db7:dacf:ed6f with SMTP id
 l5-20020a25bf85000000b00db7dacfed6fmr4540307ybk.80.1702474315827; Wed, 13 Dec
 2023 05:31:55 -0800 (PST)
MIME-Version: 1.0
References: <20231207070700.4156557-1-claudiu.beznea.uj@bp.renesas.com> <20231207070700.4156557-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231207070700.4156557-4-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Dec 2023 14:31:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVFsFbn94JdTFBaraUxLOQf5yJH0CUoJteOmYAb1WkCSA@mail.gmail.com>
Message-ID: <CAMuHMdVFsFbn94JdTFBaraUxLOQf5yJH0CUoJteOmYAb1WkCSA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] pinctrl: renesas: rzg2l: Move arg and index in
 the main function block
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
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

On Thu, Dec 7, 2023 at 8:08 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Move arg and index in the main block of the function as they are used by
> more than one case block of switch-case (3 out of 4 for arg, 2 out of 4
> for index). In this way some lines of code are removed.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - adapted for index variable and updated patch title and description
>   accordingly

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl-for-v6.8.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
