Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CF4769B79
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjGaPzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjGaPzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:55:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4687E199E;
        Mon, 31 Jul 2023 08:55:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ED3B611E4;
        Mon, 31 Jul 2023 15:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5CDC433C7;
        Mon, 31 Jul 2023 15:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690818931;
        bh=NpBtSIJSQAMZgop0+UrbZFjO72hykmWioT0INVInNzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xsiktcq6yFo8bOa1grhEAGYy7DsiCxGQ61akQuSRbSwgdbkw9u2hCxXeagc3bSYfW
         UxwX+nPP9ioKXtvf/dOVtbUtbW2QUKfnDjPwdLPZ9Yj03LIV2NnploqVk+yNOSQKo3
         lIn23gUH61k3GeZ5aAm5B6WjRfJtwyxQcnJQUrOwTKIbGN3u24EsVzIOF4eQBSnCt9
         LeW53R+OyWgIL3cnlrgbfVVFuoeW1fiusxzu2NwTtIEErbXofC/yCejdXWSm/BHL3P
         Ynnp4jVgwfx1aj7I1kiGCuh2tIXDsSltWmnH+32lJC8m8QqxE3Vavb8Hx4QTLfD1n4
         zSSrN7Jy0bO2Q==
Date:   Mon, 31 Jul 2023 23:43:52 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     guoren <guoren@kernel.org>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
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
Subject: Re: [PATCH v10 3/6] riscv: mm: dma-noncoherent: nonstandard cache
 operations support
Message-ID: <ZMfWuHPdcHuIeUHQ@xhacker>
References: <20230702203429.237615-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230702203429.237615-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZMZ6XB6gX2kFd/Nt@xhacker>
 <CAJM55Z8vF8_xq0QyByLUGM2W-8m6R-_6SdOFdLETV7J-yo5DMQ@mail.gmail.com>
 <92c00ddb-e956-4861-af80-5f5558c9a8f5@app.fastmail.com>
 <CAJF2gTTRHzT+CEtb1LVYdfCorVUdLvCh_eMxrmC=xjdQ_JS6Sg@mail.gmail.com>
 <8b3466e4-a295-4249-bd05-2edbf7b3f6e3@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b3466e4-a295-4249-bd05-2edbf7b3f6e3@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 07:39:30AM +0200, Arnd Bergmann wrote:
> On Mon, Jul 31, 2023, at 02:49, Guo Ren wrote:
> > On Mon, Jul 31, 2023 at 4:36 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >>
> >> On Sun, Jul 30, 2023, at 17:42, Emil Renner Berthing wrote:
> >> > On Sun, 30 Jul 2023 at 17:11, Jisheng Zhang <jszhang@kernel.org> wrote:
> >>
> >> >> > +
> >> >> >  static inline void arch_dma_cache_wback(phys_addr_t paddr, size_t size)
> >> >> >  {
> >> >> >       void *vaddr = phys_to_virt(paddr);
> >> >> >
> >> >> > +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> >> >> > +     if (unlikely(noncoherent_cache_ops.wback)) {
> >> >>
> >> >> I'm worried about the performance impact here.
> >> >> For unified kernel Image reason, RISCV_NONSTANDARD_CACHE_OPS will be
> >> >> enabled by default, so standard CMO and T-HEAD's CMO platform's
> >> >> performance will be impacted, because even an unlikely is put
> >> >> here, the check action still needs to be done.
> >> >
> >> > On IRC I asked why not use a static key so the overhead is just a
> >> > single nop when the standard CMO ops are available, but the consensus
> >> > seemed to be that the flushing would completely dominate this branch.
> >> > And on platforms with the standard CMO ops the branch be correctly
> >> > predicted anyway.
> >>
> >> Not just the flushing, but also loading back the invalidated
> >> cache lines afterwards is just very expensive. I don't think
> >> you would be able to measure a difference between the static

I read this as: the cache clean/inv is so expensive that the static
key saving percentage is trivial, is this understanding right?

this could be measured by writing a small benchmark kernel module
which just calls cache clean/inv a buf(for example 1500Bytes)in a loop. 

> >> key and a correctly predicted branch on any relevant usecase here.
> > Maybe we should move CMO & THEAD ops to the noncoherent_cache_ops, and
> > only keep one of them.
> >
> > I prefer noncoherent_cache_ops, it's more maintance than ALTERNATIVE.
> 
> I think moving the THEAD ops at the same level as all nonstandard
> operations makes sense, but I'd still leave CMO as an explicit
> fast path that avoids the indirect branch. This seems like the right
> thing to do both for readability and for platforms on which the
> indirect branch has a noticeable overhead.
> 
>     Arnd
