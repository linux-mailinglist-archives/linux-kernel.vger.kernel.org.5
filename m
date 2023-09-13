Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84BB79F54A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 01:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjIMXCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 19:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjIMXCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 19:02:37 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963DE1BCB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694646151;
        bh=9nwKgi53Nw3aMPL4gvYJ3xe4olH9cOVWHjkvB/aIJa8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ei0JJks17AdpLhLQiE88kxIh56GBLFTWb4JsFbgm6YICyQPFfLT7TD4a4897X+CZz
         CSOsImUJVhSjrQC5qdb+S9g/a4YrNE0U7tybLo+TigOT4msWLVrK5I93DXDBKlkTpg
         7Q98fH5wLEgXLsjZqzzQ4zdM1e175kcUvrvLqrHU=
Date:   Thu, 14 Sep 2023 01:02:30 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Sebastian Ott <sebott@redhat.com>
Cc:     Mark Brown <broonie@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: aarch64 binaries using nolibc segfault before reaching the entry
 point
Message-ID: <1d0342f3-0474-482b-b6db-81ca7820a462@t-8ch.de>
References: <5d49767a-fbdc-fbe7-5fb2-d99ece3168cb@redhat.com>
 <2da5ce29-e0de-4715-aa77-453ff3cc48aa@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2da5ce29-e0de-4715-aa77-453ff3cc48aa@t-8ch.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-13 22:19:00+0200, Thomas Weißschuh wrote:
> On 2023-09-13 20:44:59+0200, Sebastian Ott wrote:
> > the tpidr2 selftest on an arm box segfaults before reaching the entry point.
> > I have no clue what is to blame for this or how to debug it but for a
> > statically linked binary there shouldn't be much stuff going on besides the
> > elf loader?

> [..]

> 
> I reduced it to the following reproducer:
> 
>     $ cat test.c
>     int foo;  /* It works when deleting this variable */
>     
>     void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) _start(void)
>     {
>     	__asm__ volatile (
>     		"mov x8, 93\n"       /* NR_exit == 93 */
>     		"svc #0\n"
>     	);
>     	__builtin_unreachable();
>     }
>     
>     $ aarch64-linux-gnu-gcc -Os -static -fno-stack-protector -Wall -nostdlib test.c
>     $ ./a.out
>     Segmentation fault
> 
> Also when running under gdb the error message is:
> 
>     During startup program terminated with signal SIGSEGV, Segmentation fault.
> 
> So it seems the error already happens during loading.
> 
> Could be a compiler or kernel bug?

Callchain for the failure:

load_elf_binary()
  -> if (likely(elf_bss != elf_brk) && unlikely(padzero(elf_bess)))
    -> padzero()
      -> clear_user()
        -> __arch_clear_user()
	  -> failure in arch/arm64/lib/clear_user.S

Resulting in a EFAULT which gets translated to SIGSEGV somewhere.


The following patch, which seems sensible to me, fixes it for me.
But as this is really old, heavily used code I'm a bit hesitant.

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 7b3d2d491407..13f71733ba63 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -112,7 +112,7 @@ static struct linux_binfmt elf_format = {
 
 static int set_brk(unsigned long start, unsigned long end, int prot)
 {
-	start = ELF_PAGEALIGN(start);
+	start = ELF_PAGESTART(start);
 	end = ELF_PAGEALIGN(end);
 	if (end > start) {
 		/*
