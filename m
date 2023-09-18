Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CD07A49DD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbjIRMjL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 08:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241413AbjIRMip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:38:45 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A91FE7;
        Mon, 18 Sep 2023 05:38:39 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-59c0281d72dso35118157b3.0;
        Mon, 18 Sep 2023 05:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695040718; x=1695645518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9ZCzxi6Aw1yRdjYwesxAoKZKahcsiLzQsVUb2WRDfM=;
        b=uNGk8uRU3ocY40g5K6LMGMt7gugTfWPyNzZ3sq2CwIfxF2evDkArzrYdAXdwTTC2hS
         jIdbSPbNKeboDYmpJsoHugwSYlWXgnSTNSTsA8vWdftYnWUjdx3G+jFsHrt45r/s6FfB
         DzbJ5ObZEP5Q10qpOnf1kTw1Hba1fEONAwcbXW3U5J2MW0BuAf/U/Z1kvekV9u0BoJEm
         QLoOjkzhpoZTLCydxF0hdW5sR66fKGLZ4gDQ5tPR1grKVouqLX2p4jvUB1PIPFWRqRy4
         eS+64hg21WQjqCgyf6PY35//DBQbiyH/Jri/IH5QxGZfL8+6HTNNXmZ65XUk15qUFyiv
         RNRQ==
X-Gm-Message-State: AOJu0YzAiTT33qgR/s2Ok5SR4mkIp5/7S7e7ucN0Lv7rXzC1mKcKbXlY
        UsnEi1svSEIPniv11DIxYG18lchB9o98Mw==
X-Google-Smtp-Source: AGHT+IEVUrBGVdv+pYwPkzSf7fvxMFrTSYSEEdxxm3I4QTmrMoahwa6Xw0uyd819hA7jtPOrZ6ABWQ==
X-Received: by 2002:a0d:c981:0:b0:59b:14ca:4316 with SMTP id l123-20020a0dc981000000b0059b14ca4316mr9153893ywd.43.1695040718203;
        Mon, 18 Sep 2023 05:38:38 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id y18-20020a81a112000000b0058451c12076sm2557882ywg.14.2023.09.18.05.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 05:38:37 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-59c0281d72dso35117997b3.0;
        Mon, 18 Sep 2023 05:38:37 -0700 (PDT)
X-Received: by 2002:a0d:eb0a:0:b0:59b:85c:404a with SMTP id
 u10-20020a0deb0a000000b0059b085c404amr9500169ywe.6.1695040717617; Mon, 18 Sep
 2023 05:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230918122411.237635-1-biju.das.jz@bp.renesas.com> <20230918122411.237635-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230918122411.237635-2-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2023 14:38:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWX0Owu5B3+UbydGmHu_wE6acpgto=Q=xUcSC54-goqeg@mail.gmail.com>
Message-ID: <CAMuHMdWX0Owu5B3+UbydGmHu_wE6acpgto=Q=xUcSC54-goqeg@mail.gmail.com>
Subject: Re: [PATCH 1/3] irqchip: renesas-rzg2l: Fix logic to clear TINT
 interrupt source
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.au@gmail.com>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
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

On Mon, Sep 18, 2023 at 2:24 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> The logic to clear the TINT interrupt source in rzg2l_irqc_irq_disable()
> is wrong as the mask is correct only for LSB on the TSSR register.
> This issue is found when testing with two TINT interrupt sources. So fix
> the logic for all TINTs by using the macro TSSEL_SHIFT() to multiply
> tssr_offset with 8.
>
> Fixes: 3fed09559cd8 ("irqchip: Add RZ/G2L IA55 Interrupt Controller driver")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
