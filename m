Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2149C806E1F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377705AbjLFLgt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 06:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377704AbjLFLgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:36:48 -0500
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DD31A5;
        Wed,  6 Dec 2023 03:36:54 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5d74186170fso42084847b3.3;
        Wed, 06 Dec 2023 03:36:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701862613; x=1702467413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7uKADVFo67bwK9oLvgec0xCPe6KYQSC4PqeYTk7K8M=;
        b=wCd7RJ4chb2r3uf8Qosbe1Fmf4ZKLgAjxaa6mPUk+L8lXAy5heN3NmUZpeGpJ1vjIe
         shTz7A944KGjzQ0zkahp//hmyRir6iRYz/+4PV9wSAxxfXgwY66AT39BLT9t1cE1593S
         1Y3ZLzd9UnYhfhX2hGpmGYnuJnbRZwKgd5tclPlr+vKlFe0CkplMNcJ0qn07RMz8pcZg
         B8hRk3GA3nCv+U2/u/Z6ya/WxJHXFiumY5bIECHvLFiZunvjl14Lc6ii2/Vk2U4HaZjV
         y1ALkTFpkfAbKbiVBr5NRESLn3uHDOYc//opzffrbRDKoTUh4xTzBwX7NSHRVt+PR/XS
         WRIw==
X-Gm-Message-State: AOJu0YzwbN5hcFk+p7+0QOgMJ+o3VcQqP/y2TxlpLFhZTJcbD8GP+jpK
        Wkm3Hwz3SUMs0IGNW0x0LzSXIdEz7nMq5A==
X-Google-Smtp-Source: AGHT+IFcRlZyOhU4rv85Tz0KaWEXBAmvUQaQyMJXzGN7o+d/zc8yq6Lrq6M8ZxDlN/A44bkK37MglA==
X-Received: by 2002:a81:af61:0:b0:5d8:96c:690d with SMTP id x33-20020a81af61000000b005d8096c690dmr575820ywj.7.1701862613612;
        Wed, 06 Dec 2023 03:36:53 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id r20-20020a0de814000000b005d39c874019sm4620372ywe.66.2023.12.06.03.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 03:36:51 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5d96efd26f8so24131207b3.2;
        Wed, 06 Dec 2023 03:36:49 -0800 (PST)
X-Received: by 2002:a81:a103:0:b0:5d1:430e:4c2f with SMTP id
 y3-20020a81a103000000b005d1430e4c2fmr594560ywg.42.1701862609581; Wed, 06 Dec
 2023 03:36:49 -0800 (PST)
MIME-Version: 1.0
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com> <20231120084606.4083194-11-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231120084606.4083194-11-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Dec 2023 12:36:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUe4xNMOqMkRhnD0Ciq19uWoFRVbg0YPzB6-Y2gh6m-1g@mail.gmail.com>
Message-ID: <CAMuHMdUe4xNMOqMkRhnD0Ciq19uWoFRVbg0YPzB6-Y2gh6m-1g@mail.gmail.com>
Subject: Re: [PATCH 10/13] net: ravb: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS()
 and pm_ptr()
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, p.zabel@pengutronix.de,
        yoshihiro.shimoda.uh@renesas.com, wsa+renesas@sang-engineering.com,
        biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        sergei.shtylyov@cogentembedded.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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

On Thu, Nov 23, 2023 at 7:15 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() are deprecated now
> and require __maybe_unused protection against unused function warnings.
> The usage of pm_ptr() and SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() allows
> the compiler to see the functions, thus suppressing the warning. Thus
> drop the __maybe_unused markings.
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
