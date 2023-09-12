Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F28779D630
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbjILQX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjILQXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:23:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A2410EA;
        Tue, 12 Sep 2023 09:23:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC37C433C7;
        Tue, 12 Sep 2023 16:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1694535830;
        bh=cM9usqpqAjvNAVl4RACKoLLLMEuBld91IwmymEvqjW4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mWaTNNuVKpdDr3c1+zVME8cRWR0WIwZwcKSZtVf4Ow7eG3TiyoJpfXllu0c2auzbX
         IBadXeYFOy8PBUEHRLQ/9aBbg1F5ArAFwd2nmcDVuajIoRetRj37U2Ar5MUIfbdI66
         uEWrjLDz6hOsDQPaL28fnLBGF7+BRE67SUvy2Lxs=
Date:   Tue, 12 Sep 2023 09:23:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        chinwen.chang@mediatek.com, qun-wei.lin@mediatek.com,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        casper.li@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/8] scripts/gdb/symbols: add specific ko module load
 command
Message-Id: <20230912092349.2ec5bf4e20bed10d27410076@linux-foundation.org>
In-Reply-To: <c44b748307a074d0c250002cdcfe209b8cce93c9.camel@sipsolutions.net>
References: <20230808083020.22254-1-Kuan-Ying.Lee@mediatek.com>
        <20230808083020.22254-2-Kuan-Ying.Lee@mediatek.com>
        <c44b748307a074d0c250002cdcfe209b8cce93c9.camel@sipsolutions.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2023 11:41:29 +0200 Johannes Berg <johannes@sipsolutions.net> wrote:

> On Tue, 2023-08-08 at 16:30 +0800, Kuan-Ying Lee wrote:
> > Add lx-symbols <ko_path> command to support add specific
> > ko module.
> 
> I'm not sure how this was supposed to work? It should have updated the
> documentation, but more importantly, it shouldn't have broken the
> documented usage of this command:
> 
>       The kernel (vmlinux) is taken from the current working directly. Modules (.ko)
>       are scanned recursively, starting in the same directory. Optionally, the module
>       search path can be extended by a space separated list of paths passed to the
>       lx-symbols command.
> 
> Note how that talks about a "space separated list of paths" for which
> clearly a single path seems like it should be accepted?
> 
> > @@ -138,6 +139,19 @@ lx-symbols command."""

Thanks, I queued a revert.

From: Andrew Morton <akpm@linux-foundation.org>
Subject: revert "scripts/gdb/symbols: add specific ko module load command"
Date: Tue Sep 12 09:19:10 AM PDT 2023

Revert 11f956538c07 ("scripts/gdb/symbols: add specific ko module load
command") due to breakage identified by Johannes Berg in [1].

Fixes: 11f956538c07 ("scripts/gdb/symbols: add specific ko module load command")
Reported-by: Johannes Berg <johannes@sipsolutions.net>
Closes: https://lkml.kernel.org/r/c44b748307a074d0c250002cdcfe209b8cce93c9.camel@sipsolutions.net [1]
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chinwen Chang <chinwen.chang@mediatek.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Kieran Bingham <kbingham@kernel.org>
Cc: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Qun-Wei Lin <qun-wei.lin@mediatek.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 scripts/gdb/linux/symbols.py |   23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

--- a/scripts/gdb/linux/symbols.py~revert-scripts-gdb-symbols-add-specific-ko-module-load-command
+++ a/scripts/gdb/linux/symbols.py
@@ -111,12 +111,11 @@ lx-symbols command."""
         return "{textaddr} {sections}".format(
             textaddr=textaddr, sections="".join(args))
 
-    def load_module_symbols(self, module, module_file=None):
+    def load_module_symbols(self, module):
         module_name = module['name'].string()
         module_addr = str(module['mem'][constants.LX_MOD_TEXT]['base']).split()[0]
 
-        if not module_file:
-            module_file = self._get_module_file(module_name)
+        module_file = self._get_module_file(module_name)
         if not module_file and not self.module_files_updated:
             self._update_module_files()
             module_file = self._get_module_file(module_name)
@@ -139,19 +138,6 @@ lx-symbols command."""
         else:
             gdb.write("no module object found for '{0}'\n".format(module_name))
 
-    def load_ko_symbols(self, mod_path):
-        self.loaded_modules = []
-        module_list = modules.module_list()
-
-        for module in module_list:
-            module_name = module['name'].string()
-            module_pattern = ".*/{0}\.ko(?:.debug)?$".format(
-                module_name.replace("_", r"[_\-]"))
-            if re.match(module_pattern, mod_path) and os.path.exists(mod_path):
-                self.load_module_symbols(module, mod_path)
-                return
-        raise gdb.GdbError("%s is not a valid .ko\n" % mod_path)
-
     def load_all_symbols(self):
         gdb.write("loading vmlinux\n")
 
@@ -190,11 +176,6 @@ lx-symbols command."""
         self.module_files = []
         self.module_files_updated = False
 
-        argv = gdb.string_to_argv(arg)
-        if len(argv) == 1:
-            self.load_ko_symbols(argv[0])
-            return
-
         self.load_all_symbols()
 
         if hasattr(gdb, 'Breakpoint'):
_

