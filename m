Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8442B7DC28C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 23:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjJ3Whb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 18:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjJ3Wh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 18:37:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458A2126;
        Mon, 30 Oct 2023 15:37:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2948DC433C7;
        Mon, 30 Oct 2023 22:37:24 +0000 (UTC)
Date:   Mon, 30 Oct 2023 18:37:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org
Subject: Re: arch/sh/boot/compressed/misc.c:118:6: warning: no previous
 prototype for 'arch_ftrace_ops_list_func'
Message-ID: <20231030183722.21712d18@gandalf.local.home>
In-Reply-To: <202310310611.5RteDpO7-lkp@intel.com>
References: <202310310611.5RteDpO7-lkp@intel.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023 06:15:04 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Steven,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   14ab6d425e80674b6a0145f05719b11e82e64824
> commit: 17b251a290ba84a0c2c5c82df9596cb2e7207ca6 ftrace/sh: Add arch_ftrace_ops_list_func stub to have compressed image still link
> date:   2 years ago
> config: sh-allnoconfig (https://download.01.org/0day-ci/archive/20231031/202310310611.5RteDpO7-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231031/202310310611.5RteDpO7-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310310611.5RteDpO7-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    arch/sh/boot/compressed/misc.c:109:6: warning: no previous prototype for '__stack_chk_fail' [-Wmissing-prototypes]
>      109 | void __stack_chk_fail(void)
>          |      ^~~~~~~~~~~~~~~~
>    arch/sh/boot/compressed/misc.c:115:6: warning: no previous prototype for 'ftrace_stub' [-Wmissing-prototypes]
>      115 | void ftrace_stub(void)
>          |      ^~~~~~~~~~~
> >> arch/sh/boot/compressed/misc.c:118:6: warning: no previous prototype for 'arch_ftrace_ops_list_func' [-Wmissing-prototypes]  
>      118 | void arch_ftrace_ops_list_func(void)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~

As the comment states, this is needed only because the linker script
vmlinux.lds.h references them, and it will not build without it.

If someone really cares, they could simply add a header to quiet these
warnings, but seriously, these functions are just stubs to allow the sh
boot portion use the vmlinux.lds.h linker script. These stubs are only for
satisfying linker references and are not used. I'm not going to be the one
to bother "fixing" it.

-- Steve


>    arch/sh/boot/compressed/misc.c:128:6: warning: no previous prototype for 'decompress_kernel' [-Wmissing-prototypes]
>      128 | void decompress_kernel(void)
>          |      ^~~~~~~~~~~~~~~~~
> 
> 
> vim +/arch_ftrace_ops_list_func +118 arch/sh/boot/compressed/misc.c
> 
>    113	
>    114	/* Needed because vmlinux.lds.h references this */
>    115	void ftrace_stub(void)
>    116	{
>    117	}
>  > 118	void arch_ftrace_ops_list_func(void)  
>    119	{
>    120	}
>    121	
> 

