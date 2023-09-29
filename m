Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2167B34A4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjI2OPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjI2OPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:15:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A37510C7;
        Fri, 29 Sep 2023 07:15:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAF3C433C7;
        Fri, 29 Sep 2023 14:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695996914;
        bh=PrGEd+n3I9phoCJZQNjyU2lIksSp10nLF/ZgSuI2swc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RYzFpFqpLu2iW64GmDGSknW1Yg8vM6E1OvMKcmto2zqTCOxpw5jTs1TganR82f5Kp
         Vi5dYEPzkDVoK8NHCpQ6YvJEwkwH41OXv3md4Q4WQ/QmD6jFqJnR6KD+N2Ski/WqKN
         eCjgxUK2ipKQQRheaBEbKO2NI97YP/y8vT35HUCae4Vka+IrLmgCxPY7PrmA0CSiBw
         hjbVFAkkrm9iC91ag8Ea5ezqf44U+dCkJg/Zyx/LYWsuc2yUZcCJyYwZ7geDMhNyOr
         L3hLrkRibsCAw/IidOxaaUe5xQTO2i56gVvKUc1t5R6XyDGw6+wo2GsLrAoeLyYbxK
         SRugZ0OekOFoA==
Date:   Fri, 29 Sep 2023 15:15:09 +0100
From:   Will Deacon <will@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v4 3/3] scripts/faddr2line: Skip over mapping symbols in
 output from readelf
Message-ID: <20230929141508.GA30367@willie-the-truck>
References: <20230914131225.13415-1-will@kernel.org>
 <20230914131225.13415-4-will@kernel.org>
 <CAK7LNAQimVFOofEN5dNtPMWZ1m0Jh_3KawNU04kpmnSaUn3MKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQimVFOofEN5dNtPMWZ1m0Jh_3KawNU04kpmnSaUn3MKQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 01:50:20AM +0900, Masahiro Yamada wrote:
> On Thu, Sep 14, 2023 at 10:12 PM Will Deacon <will@kernel.org> wrote:
> >
> > Mapping symbols emitted in the readelf output can confuse the
> > 'faddr2line' symbol size calculation, resulting in the erroneous
> > rejection of valid offsets. This is especially prevalent when building
> > an arm64 kernel with CONFIG_CFI_CLANG=y, where most functions are
> > prefixed with a 32-bit data value in a '$d.n' section. For example:
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
> > Filter out these entries from readelf using a shell reimplementation of
> > is_mapping_symbol(), so that the size of a symbol is calculated as a
> > delta to the next symbol present in ksymtab.
> >
> > Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> > Cc: John Stultz <jstultz@google.com>
> > Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  scripts/faddr2line | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/scripts/faddr2line b/scripts/faddr2line
> > index 6b8206802157..20d9b3d37843 100755
> > --- a/scripts/faddr2line
> > +++ b/scripts/faddr2line
> > @@ -179,6 +179,11 @@ __faddr2line() {
> >                         local cur_sym_elf_size=${fields[2]}
> >                         local cur_sym_name=${fields[7]:-}
> >
> > +                       # is_mapping_symbol(cur_sym_name)
> > +                       if [[ ${cur_sym_name} =~ ^((\.L)|(L0)|(\$[adtx](\.|$))) ]]; then
> > +                               continue
> > +                       fi
> > +
> 
> 
> Too many parentheses.

Ha, well _that_ is subjective! I really think they help when it comes to
regex syntax. However...

> The latest include/linux/module_symbol.h looks like this.
> 
> static inline int is_mapping_symbol(const char *str)
> {
>         if (str[0] == '.' && str[1] == 'L')
>                 return true;
>         if (str[0] == 'L' && str[1] == '0')
>                 return true;
>         return str[0] == '$';
> }

...oh, nice, that got simplified a whole lot by ff09f6fd2972 ("modpost,
kallsyms: Treat add '$'-prefixed symbols as mapping symbols") in the
recent merge window, so I can definitely simplify the regex.

> Does this work?
> 
> if [[ ${cur_sym_name} =~ ^(\.L|L0|\$) ]]; then
>         continue
> fi

Looks about right.

Will
