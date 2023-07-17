Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53760755F3A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjGQJ3j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 05:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQJ3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:29:35 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74527A9;
        Mon, 17 Jul 2023 02:29:34 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-579ed2829a8so38353747b3.1;
        Mon, 17 Jul 2023 02:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689586173; x=1692178173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXUbfRC50rKT4fSUI17PwiwLo3gj1n7rjx0sQOz4AH0=;
        b=E2SDzFbd3r+4+8mC/L7unwQlVJkSpoM147Sv2f1SbbA4LsBgY9ml4qtf+vLlIXuVFH
         A64H+r1UmLupRjpQgxq9wUPd0jKMdpTqkoj1U8KWnTH1ciGdxdIXg5W+jgIGGoc/6Meb
         LlIVAkP1y+va3+9cP6oF6arpZK36ordBFPzBXa+eHZiXE7pDBWzjv/+wflKT3idfz/kh
         oj7IVL5LE2V/vVDe1S0eTkWNOvamWntHpjerksF5PmcVt5dXWtvuWs7/uwUIsdFulehc
         Y0hH929+QcL97NzgAQHhfRNGHNbcH1qq/kzueIp/Naol5uihCtXKId5lM9im7ORM0D+u
         DitA==
X-Gm-Message-State: ABy/qLaycvxwbFsxns4hab/jiK1k86aBdMFdTxQUDY7SbiFrwKRqy7Ub
        wfWLgmRR9KgHnHQ2XiGynnea3u+suVRrtA==
X-Google-Smtp-Source: APBJJlFKdqVy30TG2OkGE62sP/jh3o3lkQvmMDK18p4k71U6LEaIvgOaGFRZzFIAX7u/YEbx2lqE6Q==
X-Received: by 2002:a81:4757:0:b0:54f:9cd0:990 with SMTP id u84-20020a814757000000b0054f9cd00990mr10331426ywa.18.1689586173208;
        Mon, 17 Jul 2023 02:29:33 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id f65-20020a0dc344000000b00565271801b6sm3744542ywd.59.2023.07.17.02.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 02:29:32 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-ca4a6e11f55so2899589276.1;
        Mon, 17 Jul 2023 02:29:32 -0700 (PDT)
X-Received: by 2002:a25:7348:0:b0:caf:99ac:d39f with SMTP id
 o69-20020a257348000000b00caf99acd39fmr10105835ybc.1.1689586172440; Mon, 17
 Jul 2023 02:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com> <20230715010407.1751715-5-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230715010407.1751715-5-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Jul 2023 11:29:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWxEQxJ+F4z3umVjRMmGyi8rfkQ+9hO-y=RZ5bN+ctLEA@mail.gmail.com>
Message-ID: <CAMuHMdWxEQxJ+F4z3umVjRMmGyi8rfkQ+9hO-y=RZ5bN+ctLEA@mail.gmail.com>
Subject: Re: [PATCH 04/10] spi: rzv2m-csi: Leave readl_poll_timeout calls for last
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
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

On Sat, Jul 15, 2023 at 3:04 AM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> Both rzv2m_csi_sw_reset and rzv2m_csi_start_stop_operation
> call into readl_poll_timeout upon a certain condition, and
> return 0 otherwise.
> Flip the logic to improve readability.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
