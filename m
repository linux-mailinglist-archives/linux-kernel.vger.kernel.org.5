Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D9979C056
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376811AbjIKWUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238139AbjIKNmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:42:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1E1CD7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:42:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E395C433C8;
        Mon, 11 Sep 2023 13:42:41 +0000 (UTC)
Message-ID: <0424526e-e9fd-7a3f-71ed-c43855ab1290@linux-m68k.org>
Date:   Mon, 11 Sep 2023 23:42:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 06/52] m68k: kernel: Add and use "process.h"
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-kernel@vger.kernel.org
References: <cover.1694093327.git.geert@linux-m68k.org>
 <6894409da1a0d8667bf74b9100067485ce3c37ac.1694093327.git.geert@linux-m68k.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <6894409da1a0d8667bf74b9100067485ce3c37ac.1694093327.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Nice cleanups. My plan is to clean up the ColdFire/68000 warnings as well.


On 7/9/23 23:41, Geert Uytterhoeven wrote:
> When building with W=1:
> 
>      arch/m68k/kernel/process.c:115:16: warning: no previous prototype for ‘m68k_clone’ [-Wmissing-prototypes]
>        115 | asmlinkage int m68k_clone(struct pt_regs *regs)
> 	  |                ^~~~~~~~~~
>      arch/m68k/kernel/process.c:136:16: warning: no previous prototype for ‘m68k_clone3’ [-Wmissing-prototypes]
>        136 | asmlinkage int m68k_clone3(struct pt_regs *regs)
> 	  |                ^~~~~~~~~~~
> 
> Fix this by introducing a new header file "process.h" for holding the
> prototypes of functions implemented in arch/m68k/kernel/process.c.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>   arch/m68k/kernel/process.c | 1 +
>   arch/m68k/kernel/process.h | 8 ++++++++
>   2 files changed, 9 insertions(+)
>   create mode 100644 arch/m68k/kernel/process.h
> 
> diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
> index e06ce147c0b7fcf2..d2d6a57356502e5b 100644
> --- a/arch/m68k/kernel/process.c
> +++ b/arch/m68k/kernel/process.c
> @@ -38,6 +38,7 @@
>   #include <asm/machdep.h>
>   #include <asm/setup.h>
>   
> +#include <process.h>

I applied all 52 patches to linux-6.6-rc1 and see this:

     $ ARCH=m68k CROSS_COMPILE=m68k-linux- make amiga_defconfig
     $ ARCH=m68k CROSS_COMPILE=m68k-linux- make W=1
     ...
       CC      arch/m68k/kernel/process.o
     arch/m68k/kernel/process.c:41:10: fatal error: process.h: No such file or directory
      #include <process.h>
               ^~~~~~~~~~~

Of course trivially fixed by doing this:

diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index d2d6a5735650..2584e94e2134 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -38,7 +38,7 @@
  #include <asm/machdep.h>
  #include <asm/setup.h>
  
-#include <process.h>
+#include "process.h"
  
  asmlinkage void ret_from_fork(void);
  asmlinkage void ret_from_kernel_thread(void);


Regards
Greg


>   asmlinkage void ret_from_fork(void);
>   asmlinkage void ret_from_kernel_thread(void);
> diff --git a/arch/m68k/kernel/process.h b/arch/m68k/kernel/process.h
> new file mode 100644
> index 0000000000000000..d31745f2e64bebab
> --- /dev/null
> +++ b/arch/m68k/kernel/process.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/linkage.h>
> +
> +struct pt_regs;
> +
> +asmlinkage int m68k_clone(struct pt_regs *regs);
> +asmlinkage int m68k_clone3(struct pt_regs *regs);
