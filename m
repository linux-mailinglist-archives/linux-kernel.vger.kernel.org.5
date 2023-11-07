Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A969A7E4A36
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343759AbjKGVAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjKGVAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:00:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648851724;
        Tue,  7 Nov 2023 13:00:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903CDC433C7;
        Tue,  7 Nov 2023 21:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699390808;
        bh=LarIf6JBeHjPIH1r2xen7IJx+ARqZUkJ5J7Gxn4B/lE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rBxQ5bABLQTCBix7Ka06a2C5R6TyRqXRoUflQKl6rVneKCp4SDSkfyOYI5OqrTHr5
         VGko1ipUJyLSbvzJ2xZLmtt33f6+HS+VTb40L685erl32vfuz2ZEp9b6B/lTholrsf
         hFUNSHnJ8ZD9KjPIROrLdC8aeibxhFylqaKpFkbZi2tB4I186XorlaOjj9VUj/iAo/
         TlkaZTWYWAFVpZozkYeZunhIR0D3oG69+r1PKYwTREx2mW9QFg71k0BginE2jEQO5d
         HVMX50Ev+r5kP1YhmVca3XNMEa/O5zMB8Uk/oauxTKGdMqAyHw7k0k0WQK8Bc7Eskj
         qwM4bOWIyB3NA==
Date:   Tue, 7 Nov 2023 14:00:04 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Yoann Congal <yoann.congal@smile.fr>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Brandon Maier <brandon.maier@collins.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5] kconfig: avoid an infinite loop in
 oldconfig/syncconfig
Message-ID: <20231107210004.GA2065849@dev-arch.thelio-3990X>
References: <20231104222715.3967791-1-yoann.congal@smile.fr>
 <CAK7LNAS6J5Nh8nOUHbaf123yd1Z-1q--FvB1ok8GQcoNorAROw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAS6J5Nh8nOUHbaf123yd1Z-1q--FvB1ok8GQcoNorAROw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2023 at 04:55:57PM +0900, Masahiro Yamada wrote:
> On Sun, Nov 5, 2023 at 7:27 AM Yoann Congal <yoann.congal@smile.fr> wrote:
> >
> > Exit on error when asking for value and reading stdin returns an error
> > (mainly if it has reached EOF or is closed).
> >
> > This infinite loop happens in particular for hex/int configs without an
> > explicit default value.
> >
> > Previously, this case would loop:
> > * oldconfig prompts for the value but stdin has reached EOF
> > * It gets the global default value : an empty string
> > * This is not a valid hex/int value so it prompts again, hence the
> >   infinite loop.
> >
> > This case happens with a configuration like this (a hex config without a
> > valid default value):
> >   config TEST_KCONFIG
> >        hex "Test KConfig"
> >        # default 0x0
> >
> > And using:
> >   make oldconfig < /dev/null
> >
> > This was discovered when working on Yocto bug[0] on a downstream
> > kconfig user (U-boot)
> >
> > [0]: https://bugzilla.yoctoproject.org/show_bug.cgi?id=14136
> >
> > CC: Brandon Maier <brandon.maier@collins.com>
> > Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> 
> Applied to linux-kbuild.
> Thanks.

For what it's worth, this change breaks our continuous integration [1]
because tuxmake explicitly uses /dev/null as stdin to make for
non-interactive commands (I think it does this as basically the
equivalent of "yes '' | make" in Python), so the error will always
occur.

Before:

$ curl -LSso .config https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/raw/main/config

# Same as 'make < /dev/null' but still
$ python3 -c "import subprocess; subprocess.run(['make', '-j128'], stdin=subprocess.DEVNULL)"
  SYNC    include/config/auto.conf
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/expr.o
  LEX     scripts/kconfig/lexer.lex.c
  YACC    scripts/kconfig/parser.tab.[ch]
  HOSTCC  scripts/kconfig/menu.o
  HOSTCC  scripts/kconfig/preprocess.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTCC  scripts/kconfig/util.o
  HOSTCC  scripts/kconfig/lexer.lex.o
  HOSTCC  scripts/kconfig/parser.tab.o
  HOSTLD  scripts/kconfig/conf
*
* Restart config...
*
...
Error in reading or end of file.

  GEN     arch/x86/include/generated/asm/orc_hash.h
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/errno.h
...

After:

$ curl -LSso .config https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/raw/main/config

$ python3 -c "import subprocess; subprocess.run(['make', '-j128'], stdin=subprocess.DEVNULL)"
  SYNC    include/config/auto.conf
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/expr.o
  LEX     scripts/kconfig/lexer.lex.c
  YACC    scripts/kconfig/parser.tab.[ch]
  HOSTCC  scripts/kconfig/menu.o
  HOSTCC  scripts/kconfig/preprocess.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTCC  scripts/kconfig/util.o
  HOSTCC  scripts/kconfig/lexer.lex.o
  HOSTCC  scripts/kconfig/parser.tab.o
  HOSTLD  scripts/kconfig/conf
*
* Restart config...
*
...
Error in reading or end of file.
make[3]: *** [scripts/kconfig/Makefile:77: syncconfig] Error 1
...

We have been doing this for some time and never run across an infinite
loop in syncconfig. Can this be improved?

[1]: https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/6784349581

Cheers,
Nathan

> > ---
> > v4->v5:
> >  * Switched to Masahiro Yamada's suggested code.
> > v3->v4:
> >  * Added Brandon Maier's "Tested-by". Thanks!
> > v2->v3:
> >  * Simplify the patch by fusing comments of :
> >    * Masahiro Yamada : Exit as soon as reading stdin hits an error
> >    * Randy Dunlap : Display the name of the currently read symbol
> > v1->v2:
> >  * Improve coding style
> >  * Put more info in the commit message
> > ---
> >  scripts/kconfig/conf.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
> > index 33d19e419908..62de1fbaff97 100644
> > --- a/scripts/kconfig/conf.c
> > +++ b/scripts/kconfig/conf.c
> > @@ -76,8 +76,10 @@ static void strip(char *str)
> >  /* Helper function to facilitate fgets() by Jean Sacren. */
> >  static void xfgets(char *str, int size, FILE *in)
> >  {
> > -       if (!fgets(str, size, in))
> > +       if (!fgets(str, size, in)) {
> >                 fprintf(stderr, "\nError in reading or end of file.\n");
> > +               exit(1);
> > +       }
> >
> >         if (!tty_stdio)
> >                 printf("%s", str);
> > --
> > 2.30.2
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
