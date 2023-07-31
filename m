Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7715A768968
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 02:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjGaAtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 20:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGaAtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 20:49:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F280E78;
        Sun, 30 Jul 2023 17:49:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3124760DF9;
        Mon, 31 Jul 2023 00:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9299CC43397;
        Mon, 31 Jul 2023 00:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690764570;
        bh=HSe9skEoxlUTuOZvdtNJpMW/Hkn8jkbcfx3F/K4PLVY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p+D7khP4AiP7n5c2GyfpNG+VVGVttTyGWAQRc+NtLtBozyiyHmuvJg4wLhYTRPoU3
         O9cBmMMFPhdKcNDf02eZ/qCyEXOQjoZH9sC1zubZ+OvUqczlj8iMOoR0ScKqGqPZfi
         /0GdSLc0GJj/ZdFSCR38HMGD1p2QSJoLhuRoaFnoe3zvSkoa/hOECqnC1pED6etxQL
         aAOrXh8KdMZOjVBCN7o49+4wVhsaZQL4Zt9iVou7PcJs2jzmzXV1+Lbq68FSLQU/sM
         UxduwZh/q3IBFeozIKt3xDmJ2r/x3wP2vzNIeAhaXc8QAvW3lwN3Br3OIZKpTpL6As
         tvqnrlzZf/H/w==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so6267536e87.0;
        Sun, 30 Jul 2023 17:49:30 -0700 (PDT)
X-Gm-Message-State: ABy/qLZLCSqmX2Ds8EuQp9mJ8zu852jZc7fCThFSz0Z4VzJlnPyKMUIi
        6mgisCRIi/8TQWIF0nVQ61UQygvcyN/0+b8kbV0=
X-Google-Smtp-Source: APBJJlF7/ie/dP5ysn5qcMXEX8GaXG49PtXGNJVueUhetg/GlqbiKWs42dguiSGoTIKK9SRUFsaY3KxIgB75UtwPxKU=
X-Received: by 2002:ac2:5047:0:b0:4fb:92df:a27b with SMTP id
 a7-20020ac25047000000b004fb92dfa27bmr4330470lfm.39.1690764568411; Sun, 30 Jul
 2023 17:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230702203429.237615-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230702203429.237615-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZMZ6XB6gX2kFd/Nt@xhacker> <CAJM55Z8vF8_xq0QyByLUGM2W-8m6R-_6SdOFdLETV7J-yo5DMQ@mail.gmail.com>
 <92c00ddb-e956-4861-af80-5f5558c9a8f5@app.fastmail.com>
In-Reply-To: <92c00ddb-e956-4861-af80-5f5558c9a8f5@app.fastmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 31 Jul 2023 08:49:17 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTRHzT+CEtb1LVYdfCorVUdLvCh_eMxrmC=xjdQ_JS6Sg@mail.gmail.com>
Message-ID: <CAJF2gTTRHzT+CEtb1LVYdfCorVUdLvCh_eMxrmC=xjdQ_JS6Sg@mail.gmail.com>
Subject: Re: [PATCH v10 3/6] riscv: mm: dma-noncoherent: nonstandard cache
 operations support
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 4:36=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Sun, Jul 30, 2023, at 17:42, Emil Renner Berthing wrote:
> > On Sun, 30 Jul 2023 at 17:11, Jisheng Zhang <jszhang@kernel.org> wrote:
>
> >> > +
> >> >  static inline void arch_dma_cache_wback(phys_addr_t paddr, size_t s=
ize)
> >> >  {
> >> >       void *vaddr =3D phys_to_virt(paddr);
> >> >
> >> > +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> >> > +     if (unlikely(noncoherent_cache_ops.wback)) {
> >>
> >> I'm worried about the performance impact here.
> >> For unified kernel Image reason, RISCV_NONSTANDARD_CACHE_OPS will be
> >> enabled by default, so standard CMO and T-HEAD's CMO platform's
> >> performance will be impacted, because even an unlikely is put
> >> here, the check action still needs to be done.
> >
> > On IRC I asked why not use a static key so the overhead is just a
> > single nop when the standard CMO ops are available, but the consensus
> > seemed to be that the flushing would completely dominate this branch.
> > And on platforms with the standard CMO ops the branch be correctly
> > predicted anyway.
>
> Not just the flushing, but also loading back the invalidated
> cache lines afterwards is just very expensive. I don't think
> you would be able to measure a difference between the static
> key and a correctly predicted branch on any relevant usecase here.
Maybe we should move CMO & THEAD ops to the noncoherent_cache_ops, and
only keep one of them.

I prefer noncoherent_cache_ops, it's more maintance than ALTERNATIVE.

Heiko, How do you think about this?

>
>      Arnd



--=20
Best Regards
 Guo Ren
