Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5CE7BDA5B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346363AbjJILyo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 07:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346341AbjJILym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:54:42 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A486A6;
        Mon,  9 Oct 2023 04:54:40 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5a2379a8b69so53619037b3.2;
        Mon, 09 Oct 2023 04:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696852479; x=1697457279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKftZbIuUuwHrrNDRHp67wk5T+SshNeupCiJ+fTYlnU=;
        b=Y92UVjIjkthEVVNt7GAvfT/kHstbOjMvYMcjvSajFgqqkWWAJffcqYlddgudDU527D
         QjakuLFbtpDDzUVOL2uAjyIKP26S+wOHmRJ03WtwjxubK2sbP0ssz2MhuQqxR0TmLWcQ
         FNAnlSZ5Rs9Jg6frbO8u4lNikNAJr79IViMZ6hfLMNMx00ISHoWNTHl40VFImUj6Rgvy
         x2d2XeSJu17l0LJzxp9K0KM5FykeMOZE+zVHSRbc1eekmYBM6Ll4XPqhfNgqSvy7YjcE
         IJVCb2PLXv094qtz+eeW/VFa3nefuzX9Mv6vwnoGG7O6yywlTSAJBiThN3X1r8RpoJpd
         qwNA==
X-Gm-Message-State: AOJu0YxD93Pa9CXQc2OM03DDA0QtsUsfDiItDx+7JtnW6PPCniI06cvL
        xIIVpczHv/zIztdxR7mn9P5cAm/C4FEH1A==
X-Google-Smtp-Source: AGHT+IHdhxdkJjTEtKZ3Vn3xtAJXCe9uaQUwvTiyG4MzG44zukomqtZWeY5s748HwgQfE32FgI+qKw==
X-Received: by 2002:a81:62d7:0:b0:576:fc3a:3ef5 with SMTP id w206-20020a8162d7000000b00576fc3a3ef5mr16417248ywb.47.1696852479286;
        Mon, 09 Oct 2023 04:54:39 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id x184-20020a814ac1000000b005869ca8da8esm3615750ywa.146.2023.10.09.04.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 04:54:38 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d8195078f69so4643845276.3;
        Mon, 09 Oct 2023 04:54:38 -0700 (PDT)
X-Received: by 2002:a25:add4:0:b0:d9a:3bbb:8602 with SMTP id
 d20-20020a25add4000000b00d9a3bbb8602mr297864ybe.64.1696852478659; Mon, 09 Oct
 2023 04:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231006103959.197485-1-claudiu.beznea.uj@bp.renesas.com> <20231006103959.197485-5-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231006103959.197485-5-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Oct 2023 13:54:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW9YaL3OBnWYqTCH63DBw1-Q_pVp0ZhEnYL6iuQpQeLCQ@mail.gmail.com>
Message-ID: <CAMuHMdW9YaL3OBnWYqTCH63DBw1-Q_pVp0ZhEnYL6iuQpQeLCQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] clk: renesas: add minimal boot support for RZ/G3S SoC
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, magnus.damm@gmail.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 12:40 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add minimal clock and reset support for RZ/G3S SoC to be able to boot
> Linux from SD Card/eMMC. This includes necessary core clocks for booting
> and GIC, SCIF, GPIO, SD0 mod clocks and resets.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v3:
> - collected Rb tag
> - passed max rate to DEF_G3S_DIV()

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
