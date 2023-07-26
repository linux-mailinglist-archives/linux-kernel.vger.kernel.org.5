Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA03763F09
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjGZSxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjGZSxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:53:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC922685
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:53:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E506961C9C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 18:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBDCC433C7;
        Wed, 26 Jul 2023 18:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690397594;
        bh=/OsjSXaYXBnGicGGKXYdVkxU7x46d6xO1z/t20cknDc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tw/lFetk7tT64WXIH8oO4Tm+Ta31kDLkDi8TmF69reiVnVGfyLK52zYnAXZyEVK1W
         zWNn64YdOX968oGHCIcNNcpkCKctwY7b2uDmG2UMlHPogUT1OQLncwxdsgc8KZTowO
         8PWlBloBOvawX5xTocwjGAiRUbDkmUXs7Q/omxV7QfbqKfTz5uexrYiU47AtJxMr8h
         9kIQyzc3T4g4PERhxcYDgRGAoyhTP45FYaeNg2JUPr/pobf4h6/ypNyDXTATb9QqT8
         CGtuLDOS4CZ4ANudHToxq6ySQmMwjwbeksf7SB47tobcSslQXnRNj0KH3EZ+4uR/Uj
         NeiX7hGH6l3ZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D0C64CE092A; Wed, 26 Jul 2023 11:53:13 -0700 (PDT)
Date:   Wed, 26 Jul 2023 11:53:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] init: keep boot_command_line after init
Message-ID: <0df94114-71e2-41e0-a0b8-1c46bbb4e430@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230726143348.724611-1-arnd@kernel.org>
 <CAKwvOdnk+e_QmE+QpcqzntNVgf8mL+NOPtUggj4F__iTf_XD+A@mail.gmail.com>
 <034f0b5e-3c61-4392-8360-ebd57749d53e@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <034f0b5e-3c61-4392-8360-ebd57749d53e@app.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 07:02:55PM +0200, Arnd Bergmann wrote:
> On Wed, Jul 26, 2023, at 18:25, Nick Desaulniers wrote:
> > On Wed, Jul 26, 2023 at 7:33 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >>
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> The boot command line is not available after the init section gets discarded,
> >> so adding a permanent reference to it causes a link time warning:
> >>
> >> WARNING: modpost: vmlinux: section mismatch in reference: cmdline_load_proc_show+0x2 (section: .text) -> boot_command_line (section: .init.data)
> >
> > cmdline_load_proc_show is probably inlined, but should it also be
> > marked __init?  It's lone call site seems to be __init AFAICT.
> >
> 
> No, that's not what it does: cmdline_load_proc_show() is called
> when someone reads /proc/cmdline_load from userspace. It's only
> the function that creates this procfs file that is __init, but the
> call happens later.

Thank you all!  I have declared a tie between Stephen Rothwell and Arnd
Bergmann for this fix.  Please let me know if you are uncomfortable
with these changes being squashed into the original with your guys'
Co-developed-by.  I also added Nick's Reviewed-by, please see below.

							Thanx, Paul

------------------------------------------------------------------------

commit de2f542cfbec295ac0f9b6a832d7b3ba20df391f
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri Jul 21 16:05:38 2023 -0700

    fs/proc: Add /proc/cmdline_load for boot loader arguments
    
    In kernels built with CONFIG_BOOT_CONFIG_FORCE=y, /proc/cmdline will
    show all kernel boot parameters, both those supplied by the boot loader
    and those embedded in the kernel image.  This works well for those who
    just want to see all of the kernel boot parameters, but is not helpful to
    those who need to see only those parameters supplied by the boot loader.
    This is especially important when these parameters are presented to the
    boot loader by automation that might gather them from diverse sources.
    
    Therefore, provide a /proc/cmdline_load file that shows only those kernel
    boot parameters supplied by the boot loader.
    
    Why put this in /proc?  Because it is quite similar to /proc/cmdline, so
    it makes sense to put it in the same place that /proc/cmdline is located.
    
    Co-developed-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Co-developed-by: Arnd Bergmann <arnd@kernel.org>
    Signed-off-by: Arnd Bergmann <arnd@kernel.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: Alexey Dobriyan <adobriyan@gmail.com>
    Cc: Masami Hiramatsu <mhiramat@kernel.org>
    Cc: <linux-fsdevel@vger.kernel.org>

diff --git a/fs/proc/cmdline.c b/fs/proc/cmdline.c
index a6f76121955f..1d0ef9d2949d 100644
--- a/fs/proc/cmdline.c
+++ b/fs/proc/cmdline.c
@@ -3,6 +3,7 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <asm/setup.h>
 #include "internal.h"
 
 static int cmdline_proc_show(struct seq_file *m, void *v)
@@ -12,6 +13,13 @@ static int cmdline_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int cmdline_load_proc_show(struct seq_file *m, void *v)
+{
+	seq_puts(m, boot_command_line);
+	seq_putc(m, '\n');
+	return 0;
+}
+
 static int __init proc_cmdline_init(void)
 {
 	struct proc_dir_entry *pde;
@@ -19,6 +27,11 @@ static int __init proc_cmdline_init(void)
 	pde = proc_create_single("cmdline", 0, NULL, cmdline_proc_show);
 	pde_make_permanent(pde);
 	pde->size = saved_command_line_len + 1;
+	if (IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE)) {
+		pde = proc_create_single("cmdline_load", 0, NULL, cmdline_load_proc_show);
+		pde_make_permanent(pde);
+		pde->size = strnlen(boot_command_line, COMMAND_LINE_SIZE) + 1;
+	}
 	return 0;
 }
 fs_initcall(proc_cmdline_init);
diff --git a/include/linux/init.h b/include/linux/init.h
index 266c3e1640d4..c42a277db2da 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -112,6 +112,9 @@
 #define __REFCONST       .section       ".ref.rodata", "a"
 
 #ifndef __ASSEMBLY__
+
+#include <linux/cache.h>
+
 /*
  * Used for initialization calls..
  */
@@ -143,7 +146,7 @@ struct file_system_type;
 
 /* Defined in init/main.c */
 extern int do_one_initcall(initcall_t fn);
-extern char __initdata boot_command_line[];
+extern char boot_command_line[] __ro_after_init;
 extern char *saved_command_line;
 extern unsigned int saved_command_line_len;
 extern unsigned int reset_devices;
diff --git a/init/main.c b/init/main.c
index ad920fac325c..2121685c479a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -135,7 +135,7 @@ EXPORT_SYMBOL(system_state);
 void (*__initdata late_time_init)(void);
 
 /* Untouched command line saved by arch-specific code. */
-char __initdata boot_command_line[COMMAND_LINE_SIZE];
+char boot_command_line[COMMAND_LINE_SIZE] __ro_after_init;
 /* Untouched saved command line (eg. for /proc) */
 char *saved_command_line __ro_after_init;
 unsigned int saved_command_line_len __ro_after_init;
