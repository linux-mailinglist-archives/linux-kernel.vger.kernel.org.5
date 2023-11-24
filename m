Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B897F6DAA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344829AbjKXIIA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Nov 2023 03:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjKXIH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:07:57 -0500
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64568D6E;
        Fri, 24 Nov 2023 00:08:03 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-da37522a363so1541594276.0;
        Fri, 24 Nov 2023 00:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700813282; x=1701418082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdqMHP0CicQk6etm9k8xzNIMQhbVBnmQltX+GSQmRjU=;
        b=odnRkzT0kwk6gwYuF75BSAvOKwaJmy8up8jV0JhPcncOiha2tw9cGsquNnK3S7qwY/
         SDkBlF+HOTSskmDKOWNjqa9JmXaabwM8YgQZBhhzEhplcN7uuTGQeSHoY9hUZDXceBQA
         /xS9WBIC3n1z1GfJoNBTHNOaxmtwxIn95Jpwmj9OAb2tr2AKvaKOlSA5vU33gDuOexTy
         zlskcziXaneTSzknTxKWFlD+uBChqWtK3HZqOUFHWDBI6zCLDuanAaE3FTAmmtI+qxTY
         SEJBquG7w1huDUwV0DIsCJ8DBBm6Hd69/+y0G5qsSqlXbg6wFDkXEyzfi0UTDwwRDw6O
         0Zvg==
X-Gm-Message-State: AOJu0YwZX14jJPicPQ4LpshYF3dIxwOUmWaEK/EgPhJkPHw1F4K75wNi
        iMoq4weEKVqTW8H+01n4i0r8Se+sxil0PA==
X-Google-Smtp-Source: AGHT+IGx2il7Ohv+rTrqbdNMIxfqH0O1Q/RAa6QA9BPuR8yYsytmIIJuU3dc9qnS16rQ+a/4LXNWvA==
X-Received: by 2002:a5b:201:0:b0:d9a:3bee:2eeb with SMTP id z1-20020a5b0201000000b00d9a3bee2eebmr1540118ybl.60.1700813282405;
        Fri, 24 Nov 2023 00:08:02 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id o21-20020a254115000000b00d7e96c6eaf5sm758671yba.46.2023.11.24.00.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 00:08:01 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5cd2f1a198cso13885957b3.0;
        Fri, 24 Nov 2023 00:08:01 -0800 (PST)
X-Received: by 2002:a0d:d54b:0:b0:5c9:d870:cb18 with SMTP id
 x72-20020a0dd54b000000b005c9d870cb18mr1741216ywd.21.1700813280818; Fri, 24
 Nov 2023 00:08:00 -0800 (PST)
MIME-Version: 1.0
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com> <20231120084606.4083194-10-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231120084606.4083194-10-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 24 Nov 2023 09:07:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUu1NTrsk9=zBHeDYK0=1gaaO6FodFBwQaZCAwNW4DhuQ@mail.gmail.com>
Message-ID: <CAMuHMdUu1NTrsk9=zBHeDYK0=1gaaO6FodFBwQaZCAwNW4DhuQ@mail.gmail.com>
Subject: Re: [PATCH 09/13] net: ravb: Make reset controller support mandatory
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, p.zabel@pengutronix.de,
        yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be,
        wsa+renesas@sang-engineering.com, biju.das.jz@bp.renesas.com,
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

On Fri, Nov 24, 2023 at 7:20 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> On RZ/G3S SoC the reset controller is mandatory for the IP to work.
> The device tree binding documentation for ravb driver specifies that the
> resets are mandatory. Based on this make the resets mandatory also in
> driver for all ravb devices.
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
