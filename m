Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A21777031C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjHDOa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjHDOa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20CA46B1;
        Fri,  4 Aug 2023 07:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67FCA62045;
        Fri,  4 Aug 2023 14:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B06EC433C7;
        Fri,  4 Aug 2023 14:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691159425;
        bh=QmdFUI/tW49KHWL5QDdmtPcbFX2wKIYC4pTkYlhDZ5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q7XjllZz6/aPkZXSqdJMt6Xkbq7Dy8u2taIJY4qraKsBnozAtJuzQvEJr4L4qSnJc
         YIDcZSEecJWxYtGXFTwzJJTesjURawtSVcdYH+zPuKK6F0KakujvXlEtzyhqrX4Kpg
         wh9SuP5w4qh/ii7PS3QKlAbck2Qjt6ZvL1Y3rwW+U1sYcaQW6SRpmAw6IFcdJZ768V
         BN6+51InOgPiii1LmvKrd2iR26mitiNkGdG4FEuDvLLLs+6yGunP694TOKiSS08nrs
         x1jQ817LM56x1t26wEyHikY2u/ScywldVWTbVQzl8K9dDtpFPIJbZSivxAjlaWNFna
         ea1KhXL0r13Nw==
Date:   Fri, 4 Aug 2023 15:30:20 +0100
From:   Will Deacon <will@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v3 3/4] scripts/faddr2line: Constrain readelf output to
 symbols from System.map
Message-ID: <20230804143019.GA30486@willie-the-truck>
References: <20230728113415.21067-1-will@kernel.org>
 <20230728113415.21067-4-will@kernel.org>
 <CAK7LNARnOUbySnnqOpP-3KBQTT-WvUHfnjV_sVTKe+faB8=86g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNARnOUbySnnqOpP-3KBQTT-WvUHfnjV_sVTKe+faB8=86g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 04:54:37AM +0900, Masahiro Yamada wrote:
> On Fri, Jul 28, 2023 at 8:34 PM Will Deacon <will@kernel.org> wrote:
> >
> > Some symbols emitted in the readelf output but filtered from System.map
> > can confuse the 'faddr2line' symbol size calculation, resulting in the
> > erroneous rejection of valid offsets. This is especially prevalent when
> > building an arm64 kernel with CONFIG_CFI_CLANG=y, where most functions
> > are prefixed with a 32-bit data value in a '$d.n' section. For example:
> >
> > 447538: ffff800080014b80   548 FUNC    GLOBAL DEFAULT    2 do_one_initcall
> >    104: ffff800080014c74     0 NOTYPE  LOCAL  DEFAULT    2 $x.73
> >    106: ffff800080014d30     0 NOTYPE  LOCAL  DEFAULT    2 $x.75
> >    111: ffff800080014da4     0 NOTYPE  LOCAL  DEFAULT    2 $d.78
> >    112: ffff800080014da8     0 NOTYPE  LOCAL  DEFAULT    2 $x.79
> >     36: ffff800080014de0   200 FUNC    LOCAL  DEFAULT    2 run_init_process
> >
> > Adding a warning to do_one_initcall() results in:
> >
> >   | WARNING: CPU: 0 PID: 1 at init/main.c:1236 do_one_initcall+0xf4/0x260
> >
> > Which 'faddr2line' refuses to accept:
> >
> > $ ./scripts/faddr2line vmlinux do_one_initcall+0xf4/0x260
> > skipping do_one_initcall address at 0xffff800080014c74 due to size mismatch (0x260 != 0x224)
> > no match for do_one_initcall+0xf4/0x260
> >
> > Filter out entries from readelf using the 'sysmap-ignored-syms.sed'
> > script used to construct System.map, so that the size of a symbol is
> > calculated as a delta to the next symbol present in ksymtab.
> 
> 
> I do not think this patch set is the right approach.
> 
> I assume faddr2line is meant to work with both vmlinux
> and modules.

Huh, it seems to be busted for modules :/ I get:

 | error: unknown argument '--section=.text'

with llvm and:

 | addr2line: DWARF error: invalid or unhandled FORM value: 0x25

with binutils.

I'll look into this, as I don't think it's related to symbol filtering.

> A problem is that we have different filtering policies wrt kallsyms.
> 
> scripts/mksysmap filters symbols in vmlinux,
> while kernel/module/kallsyms.c filters ones in modules.

I don't understand why we need two different ways of filtering out
symbols, but it appears that the module case only filters out local
labels and mapping symbols, both of which are filtered out of vmlinux
as well. Is that right?

> This patch tries to get aligned with the stacktrace of vmlinux,
> but that does not seem optimal to the stacktrace of modules.
> 
> 
> I have not checked the details, but I guess
> the module kallsyms filters less symbols.
> 
> https://github.com/torvalds/linux/blob/v6.5-rc4/kernel/module/kallsyms.c#L288
> 
> I prefer filtering symbols in the intersection of vmlinux and modules.

I think mksysmap filters out a superset of the symbols which are filtered
for modules, so why is the intersection the right thing to do? That will
mean that faddr2line considers a whole bunch of symbols that aren't in
the ksymtab of vmlinux.

> is_mapping_symbol() filters symbols you are addressing.

That's a C function and faddr2line is a shell script. What exactly do
you want me to do? My first hack just matched on symbols starting with
'$' but I ended up with this after other review feedback.

Josh -- how do you want to proceed here?

Will
