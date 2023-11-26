Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067307F9558
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 21:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjKZUjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 15:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZUjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 15:39:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B630891
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 12:39:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135D3C433C7;
        Sun, 26 Nov 2023 20:39:08 +0000 (UTC)
Date:   Sun, 26 Nov 2023 21:39:06 +0100
From:   Helge Deller <deller@gmx.de>
To:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 4.14 00/53] 4.14.331-rc2 review
Message-ID: <ZWOs6uwZoCoxYSSs@p100>
References: <20231125163059.878143365@linuxfoundation.org>
 <09f33739-9bf6-4ff8-895d-92d3567c3cb9@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09f33739-9bf6-4ff8-895d-92d3567c3cb9@roeck-us.net>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net>:
> On 11/25/23 08:32, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.331 release.
> > There are 53 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Mon, 27 Nov 2023 16:30:48 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Building parisc64:generic-64bit_defconfig ... failed
> --------------
> Error log:
> hppa64-linux-ld: arch/parisc/kernel/head.o: in function `$iodc_panic':
> (.head.text+0x64): undefined reference to `init_stack'
> hppa64-linux-ld: (.head.text+0x68): undefined reference to `init_stack'
> make[1]: *** [Makefile:1049: vmlinux] Error 1
> make: *** [Makefile:153: sub-make] Error 2

Indeed.
Thanks for testing, Guenter!

Greg, could you please replace the patch in queue/4.14 with
the one below? It simply uses another stack start, which is ok since the
machine will stop anyway.

No changes needed for your other stable-queues. I tested 4.19 and
it's ok as-is.

Thanks!
Helge


From 29e10df694b70b4283e2d6f6852afc0ea7823e5b Mon Sep 17 00:00:00 2001
From: Helge Deller <deller@gmx.de>
Date: Fri, 10 Nov 2023 16:13:15 +0100
Subject: [PATCH] parisc: Prevent booting 64-bit kernels on PA1.x machines

commit a406b8b424fa01f244c1aab02ba186258448c36b upstream.

Bail out early with error message when trying to boot a 64-bit kernel on
32-bit machines. This fixes the previous commit to include the check for
true 64-bit kernels as well.

Patch modified for 4.14 to use __bss_stop for stack. This is OK, since
the machine will halt after printing the warning.

Signed-off-by: Helge Deller <deller@gmx.de>
Fixes: 591d2108f3abc ("parisc: Add runtime check to prevent PA2.0 kernels on PA1.x machines")
Cc:  <stable@vger.kernel.org> # v6.0+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/arch/parisc/kernel/head.S b/arch/parisc/kernel/head.S
index 2f570a520586..2f552ff3a75f 100644
--- a/arch/parisc/kernel/head.S
+++ b/arch/parisc/kernel/head.S
@@ -69,9 +69,8 @@ $bss_loop:
 	stw,ma          %arg2,4(%r1)
 	stw,ma          %arg3,4(%r1)
 
-#if !defined(CONFIG_64BIT) && defined(CONFIG_PA20)
-	/* This 32-bit kernel was compiled for PA2.0 CPUs. Check current CPU
-	 * and halt kernel if we detect a PA1.x CPU. */
+#if defined(CONFIG_PA20)
+	/* check for 64-bit capable CPU as required by current kernel */
 	ldi		32,%r10
 	mtctl		%r10,%cr11
 	.level 2.0
@@ -84,7 +83,7 @@ $bss_loop:
 $iodc_panic:
 	copy		%arg0, %r10
 	copy		%arg1, %r11
-	load32		PA(init_stack),%sp
+	load32		PA(__bss_stop),%sp
 #define MEM_CONS 0x3A0
 	ldw		MEM_CONS+32(%r0),%arg0	// HPA
 	ldi		ENTRY_IO_COUT,%arg1

