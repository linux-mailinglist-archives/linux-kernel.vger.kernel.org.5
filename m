Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAD77DFB8C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbjKBU2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjKBU2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:28:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0475B18E;
        Thu,  2 Nov 2023 13:28:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A40C433C9;
        Thu,  2 Nov 2023 20:28:37 +0000 (UTC)
Date:   Thu, 2 Nov 2023 16:28:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: arch/sh/boot/compressed/misc.c:118:6: warning: no previous
 prototype for 'arch_ftrace_ops_list_func'
Message-ID: <20231102162835.6263ca7f@gandalf.local.home>
In-Reply-To: <8290ed7ea51c1fb6c30c9aa140dd051c39bc6e26.camel@physik.fu-berlin.de>
References: <202310310611.5RteDpO7-lkp@intel.com>
        <20231030183722.21712d18@gandalf.local.home>
        <8290ed7ea51c1fb6c30c9aa140dd051c39bc6e26.camel@physik.fu-berlin.de>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Nov 2023 21:05:29 +0100
John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:

> > > All warnings (new ones prefixed by >>):
> > > 
> > >    arch/sh/boot/compressed/misc.c:109:6: warning: no previous prototype for '__stack_chk_fail' [-Wmissing-prototypes]
> > >      109 | void __stack_chk_fail(void)
> > >          |      ^~~~~~~~~~~~~~~~
> > >    arch/sh/boot/compressed/misc.c:115:6: warning: no previous prototype for 'ftrace_stub' [-Wmissing-prototypes]
> > >      115 | void ftrace_stub(void)
> > >          |      ^~~~~~~~~~~  
> > > > > arch/sh/boot/compressed/misc.c:118:6: warning: no previous prototype for 'arch_ftrace_ops_list_func' [-Wmissing-prototypes]    
> > >      118 | void arch_ftrace_ops_list_func(void)
> > >          |      ^~~~~~~~~~~~~~~~~~~~~~~~~  
> > 
> > As the comment states, this is needed only because the linker script
> > vmlinux.lds.h references them, and it will not build without it.
> > 
> > If someone really cares, they could simply add a header to quiet these
> > warnings, but seriously, these functions are just stubs to allow the sh
> > boot portion use the vmlinux.lds.h linker script. These stubs are only for
> > satisfying linker references and are not used. I'm not going to be the one
> > to bother "fixing" it.  
> 
> I have to admit that I don't fully understand what the problem is.
> 
> Is this just a cosmetic issue? I would be willing to fix it in any case.

I'm not sure it really needs to be fixed. But I won't complain if you do.

Anyway, the issue is that arch/sh/boot/compressed/misc.c is not part of the
kernel. It's the code that decompresses the vmlinuz (or whatever sh calls
it). That is, the build will build the kernel (vmlinux) then compress it
and add a program to decompress it (vmlinuz). At least this is what is done
on x86, and I'm assuming it's the same for sh.

The vmlinuz is stored on disk, the boot loader loads it into memory and
executes it. The vmlinuz has the code to decompress the attached vmlinux
into memory and jump to that when its done.

Thus, you have two executables. The kernel and this wrapper program that
decompresses the kernel at start up (and is freed right afterward). This
wrapper code exists in arch/sh/boot (and in arch/x86/boot for x86).

As this code needs to be built just like the kernel, it uses the same
linker script as the kernel (vmlinux.lds.h), which has some references to
vmlinux code. Those include (from the warnings in this "bug"):

   arch/sh/boot/compressed/misc.c:115:6: warning: no previous prototype for 'ftrace_stub' [-Wmissing-prototypes]
     115 | void ftrace_stub(void)
         |      ^~~~~~~~~~~
>> arch/sh/boot/compressed/misc.c:118:6: warning: no previous prototype for 'arch_ftrace_ops_list_func' [-Wmissing-prototypes]
     118 | void arch_ftrace_ops_list_func(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~

Which are referenced by include/asm-generic/vmlinux.lds.h, and if you do
not include them, then linking will fail as these will be undefined
references.

Note, that bug also has:

   arch/sh/boot/compressed/misc.c:109:6: warning: no previous prototype for '__stack_chk_fail' [-Wmissing-prototypes]
     109 | void __stack_chk_fail(void)
         |      ^~~~~~~~~~~~~~~~

Which has a reference added by the compiler for stack protection options.

   arch/sh/boot/compressed/misc.c:128:6: warning: no previous prototype for 'decompress_kernel' [-Wmissing-prototypes]
     128 | void decompress_kernel(void)

Which is called by arch/sh/boot/compressed/head_*.S, which is assembly.

None of these really need prototypes, as there's nothing that would use the
prototypes. The two ftrace function stubs do not even add parameters to
match the vmlinux prototype, because they are never called. The other two
functions are either for gcc internal usage or called from assembly, both
which do not care about seeing a prototype either.

If you want to quiet gcc, you can add in arch/sh/boot/compressed, a header
file called "stubs.h" that just has:

#ifndef _STUBS_H
#define _STUBS_H

/* Quiet gcc complaining about these prototypes */

void __stack_chk_fail(void);
void decompress_kernel(void);
void ftrace_stub(void);
void arch_ftrace_ops_list_func(void);

#endif

and include that header.

-- Steve
