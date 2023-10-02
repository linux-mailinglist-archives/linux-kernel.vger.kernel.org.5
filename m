Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36D67B56A7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238102AbjJBP0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbjJBP0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:26:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB27899;
        Mon,  2 Oct 2023 08:26:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87B3C433C7;
        Mon,  2 Oct 2023 15:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696260410;
        bh=8IILTKrGQU/hoxa4/QqemlhG1ml9gdsLhVJNcvhGTc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P+s/tFcBRWOWCefwZM/YJXvU2QkWHBHx7Uv4ZlXCMglTa9+DhzkDs8c4izlq2FTq6
         X2GQJzod5e+/oTemAFeQPspp4zxeM+TZ+9MIRkHkz4BFqcNjxgHFx1aXl5AZgDRe2Y
         O3JYwqat004rqzOilvO5ZUUllH/d77+fj4vv1gIqwqtiPpzRVk2LBWRjuZjg+PHhr/
         DlvljSVs8AseaMUKuDD1sqy/7qOYWIBiENeTo3+opcrqA/u+nZdHfdXD7kZScsHWnL
         fxFXgOQLeoH3YZKkuQKx3jybs30UXJSJvvnVv32RJyxV7p1nCDtNo4jXi0b88u4dza
         4gwzBjXX3hrQg==
Date:   Mon, 2 Oct 2023 16:26:45 +0100
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v4 3/3] scripts/faddr2line: Skip over mapping symbols in
 output from readelf
Message-ID: <20231002152644.GA1519@willie-the-truck>
References: <20230914131225.13415-1-will@kernel.org>
 <20230914131225.13415-4-will@kernel.org>
 <CAKwvOd=gDX4ebkyHyqr276nrZVuRaoJG9Ptofpq8WjejD3s5AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd=gDX4ebkyHyqr276nrZVuRaoJG9Ptofpq8WjejD3s5AA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 08:46:22AM -0700, Nick Desaulniers wrote:
> On Thu, Sep 14, 2023 at 6:12 AM Will Deacon <will@kernel.org> wrote:
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
> 
> Thanks for the patch!
> 
> I'm curious about the `|$` in the final part of the regex.  IIUC that
> will match something like
> $a
> Do we have any such symbols without `.<n>` suffixes?

tbh, I just blindly followed the implementation of is_mapping_symbol()
at the time, but Masahiro has since pointed out that it's been
significantly simplified so this regex should get much more manageable
in the next version.

Will
