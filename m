Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D077BF9C9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjJJLdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjJJLdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:33:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72FCC9;
        Tue, 10 Oct 2023 04:33:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 62C8A211DE;
        Tue, 10 Oct 2023 11:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696937590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Rq/0B4OylI/2x7ycpj1RG14hDbwCTG8LS/MJr+5eho=;
        b=c5y4WBCIDAHdnLld/5hQDv5goKNNwRincOA4y5vWMXROZ6qXS8Bmbe+sTJz6zaztr2iYpS
        9rM2oLnVvrOzZrAj+zOGOnSh4w9ZaJcsGDOweWr95lNXE0TOl5G0uUBdG27tfxEhrXxDVv
        hUNzPZFRTlRUjJX6toshq/I4bE31nfo=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8F9332C423;
        Tue, 10 Oct 2023 11:33:09 +0000 (UTC)
Date:   Tue, 10 Oct 2023 13:33:09 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Alessandro Carminati <alessandro.carminati@gmail.com>
Cc:     Kris Van Hees <kris.van.hees@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Nick Alcock <nick.alcock@oracle.com>,
        Eugene Loh <eugene.loh@oracle.com>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Viktor Malik <vmalik@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5] scripts/link-vmlinux.sh: Add alias to duplicate
 symbols for kallsyms
Message-ID: <ZSU2dTTfLqIydSQU@alley>
References: <20230927173516.1456594-1-alessandro.carminati@gmail.com>
 <ZR7jIxh/VNT6tMVr@oracle.com>
 <CAPp5cGThN5bKsGAqiVwOV2w4tH1LgjS3eoAgucaRwty4d8JVSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPp5cGThN5bKsGAqiVwOV2w4tH1LgjS3eoAgucaRwty4d8JVSQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-10-09 15:14:28, Alessandro Carminati wrote:
> Hello Kris,
> 
> Thank you for your contribution and for having your thought shared with me.
> 
> Allow me to begin this conversation by explaining what came to mind when
> I decided to propose a patch that creates aliases.
> 
> The objective was to address a specific problem I was facing while
> minimizing any potential impact on other aspects.
> My initial consideration was the existence of numerous tools, both in the
> kernel and in userspace, that rely on the current kallsyms implementation.
> Both Nick and I shared the concern that making changes to elements upon
> which these tools depend on could have significant consequences.
> 
> To the best of my knowledge, Nick's strategy has been to duplicate kallsyms
> with something new - a new, improved kallsyms file.
> 
> However, even if Nick's patch were to be accepted, it wouldn't fully meet
> my personal requirements.
> This is because my goal was to utilize kprobe on a symbol that shares its
> name with others. Nick's work wouldn't allow me to do this, and that's why,
> I proposed an alternative.
> 
> As a result, my strategy was more modest and focused solely on creating
> aliases for duplicate symbols.
> By adding these aliases, existing tools would remain unaffected, and the
> current system state and ecosystem would be preserved.
> For instance, mechanisms like live patching could continue to use the
> symbol hit count.
> 
> On the flip side, introducing these new symbols would enable tracers to
> directly employ the new names without any modifications, and humans could
> easily identify the symbol they are dealing with just by examining the
> name.
> These are the fundamental principles behind my patch - introducing aliases.
> 
> Il giorno gio 5 ott 2023 alle ore 18:25 Kris Van Hees
> <kris.van.hees@oracle.com> ha scritto:
> >
> > On Wed, Sep 27, 2023 at 05:35:16PM +0000, Alessandro Carminati (Red Hat) wrote:
> > > It is not uncommon for drivers or modules related to similar peripherals
> > > to have symbols with the exact same name.
> > > While this is not a problem for the kernel's binary itself, it becomes an
> > > issue when attempting to trace or probe specific functions using
> > > infrastructure like ftrace or kprobe.
> > >
> > > The tracing subsystem relies on the `nm -n vmlinux` output, which provides
> > > symbol information from the kernel's ELF binary. However, when multiple
> > > symbols share the same name, the standard nm output does not differentiate
> > > between them. This can lead to confusion and difficulty when trying to
> > > probe the intended symbol.
> > >
> > >  ~ # cat /proc/kallsyms | grep " name_show"
> > >  ffffffff8c4f76d0 t name_show
> > >  ffffffff8c9cccb0 t name_show
> > >  ffffffff8cb0ac20 t name_show
> > >  ffffffff8cc728c0 t name_show
> > >  ffffffff8ce0efd0 t name_show
> > >  ffffffff8ce126c0 t name_show
> > >  ffffffff8ce1dd20 t name_show
> > >  ffffffff8ce24e70 t name_show
> > >  ffffffff8d1104c0 t name_show
> > >  ffffffff8d1fe480 t name_show
> >
> > One problem that remains as far as I can see is that this approach does not
> > take into consideration that there can be duplicate symbols in the core
> > kernel, but also between core kernel and loadable modules, and even between
> > loadable modules.  So, I think more is needed to also ensure that this
> > approach of adding alias symbols is also done for loadable modules.
> 
> To identify which symbols are duplicated, including those contained in
> modules, it requires exploring all the objects. If I were to propose a
> complementary tool to kas_alias that operates on modules, it would need to
> run on all objects to ascertain the state of the names.
> Only after this assessment could it produce its output.
> This would entail postponing the second kallsyms pass until after all
> modules have been processed.
> Additionally, modules would need to be processed twice: once to assess the
> names and a second time to generate aliases for duplicated symbols.
> I am uncertain if the community would be willing to accept such a delay in
> the build process to introduce this feature.

From the livepatching POV:

  + It needs a way to distinguish duplicate symbols within a module.

  + It does _not_ need to distinguish symbols which have the same name
    in two modules or in a module and vmlinux.

Background: The livepatch contains a structure where the livepatched
symbols are already split per-livepatched objects: vmlinux or modules.
I has to know whether a later loaded or removed module is livepatched
or not and what functions need some tweaking.

> > I'd be happy to work on something like this as a contribution to your work.
> > I would envision the alias entry not needing to have the typical [module] added
> > to it because that will already be annotated on the actual symbol entry.  So,
> > the alias could be extended to be something like:
> >
> > ffffffffc0533720 t floppy_open  [floppy]
> > ffffffffc0533720 t floppy_open@floppy:drivers_block_floppy_c_3988
> >
> > (absence of a name: prefix to the path would indicate the symbol is not
> >  associated with any module)
> >
> > Doing this is more realistic now as a result of the clean-up patches that
> > Nick introduced, e.g.
> >
> > https://lore.kernel.org/lkml/20230302211759.30135-1-nick.alcock@oracle.com/
> >
> 
> Personally, I don't perceive any specific benefit in including the module name
> as part of the decoration. Please don't get me wrong; I do recognize that it
> enhances clarity in Nick's work.
> In that context, a human can easily discern that a duplicated name originates
> from a module, aiding in understanding which symbol they require as it is
> already for duplicates coming from modules.
> 
> However, when it comes to my current implementation, I don't see a compelling
> reason to include module name into the decoration I append to names aliases.
> Please accept my apologies if I may not be taking into account any obvious use
> cases, but as it stands, I don't find a strong rationale for incorporating
> module names into the symbol decoration.
>
> In any case, as you've pointed out, duplicates can arise from names in code
> that is not intended to be a module.
> Therefore, relying solely on the module name would not fully address the
> problem you initially aimed to solve.

From my POV:

The source path and the line number is enough to distinguish duplicate
symbols even in modules.

The added module name would just add extra complexity into the kernel
and tools parsing and using the alias. The tracing tools would need to
handle the source path and line number anyway for symbols duplicated
within same module/vmlinux.

Adding module name for builtin modules might be misleading. It won't
be clear which symbols are in vmlinux binary and which are in
real modules.

Best Regards,
Petr
