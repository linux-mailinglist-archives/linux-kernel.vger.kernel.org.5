Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256997D289C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjJWChL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 22:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjJWChK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:37:10 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A42819E;
        Sun, 22 Oct 2023 19:37:08 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 07A55490;
        Mon, 23 Oct 2023 02:37:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 07A55490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1698028628; bh=R5LH3wrNSoDjy8rlap0GjBlZjbGMIoHVxyeW8u44+PA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=q4QzJ/mhX9lwVAK1yEC310AolAe+0f9Lk0E2nzvSO+juDXdxnctSahg72XzJquaOE
         IUHlbDMey8NOzUOh7LOGWSwpHahF1GR5o1FZ/YIpoq98uv2+nd8HtQc8SIXJsaGGYb
         SVvk/z/W0URYN57eWJry9T8ncklwZvTvhiJIzMx0ViZ649dBpSGGkuyOas+X8cTkHh
         cSBLi0gxA6ZHBWZ6EeBkmYeSnZ5N61sAy/M8uGlD9EUaFGG6ZFoZ99mQ7GriaZUJNt
         dEGzyiaT6m7WM28C7ztt7UwLRvMMKEyg/6p/Z15jjphLMdqyn5nHiwcpPKzXDChFsM
         HqLWTQv54uPpg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Yujie Liu <yujie.liu@intel.com>, linux-doc@vger.kernel.org
Cc:     Yujie Liu <yujie.liu@intel.com>, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] scripts/kernel-doc: match -Werror flag strictly
In-Reply-To: <20231019095637.2471840-1-yujie.liu@intel.com>
References: <20231019095637.2471840-1-yujie.liu@intel.com>
Date:   Sun, 22 Oct 2023 20:37:07 -0600
Message-ID: <87r0lmjc8c.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yujie Liu <yujie.liu@intel.com> writes:

> In our CI testing, we use some commands as below to only turn a specific
> type of warnings into errors, but we notice that kernel-doc warnings
> are also turned into errors unexpectedly.
>
> $ make KCFLAGS="-Werror=return-type" W=1 kernel/fork.o
>
> kernel/fork.c:1406: warning: Function parameter or member 'mm' not described in 'set_mm_exe_file'
> kernel/fork.c:1406: warning: Function parameter or member 'new_exe_file' not described in 'set_mm_exe_file'
> kernel/fork.c:1441: warning: Function parameter or member 'mm' not described in 'replace_mm_exe_file'
> kernel/fork.c:1441: warning: Function parameter or member 'new_exe_file' not described in 'replace_mm_exe_file'
> kernel/fork.c:1491: warning: Function parameter or member 'mm' not described in 'get_mm_exe_file'
> kernel/fork.c:1510: warning: Function parameter or member 'task' not described in 'get_task_exe_file'
> kernel/fork.c:1534: warning: Function parameter or member 'task' not described in 'get_task_mm'
> kernel/fork.c:2109: warning: bad line:
> kernel/fork.c:2130: warning: Function parameter or member 'ret' not described in '__pidfd_prepare'
> kernel/fork.c:2130: warning: Excess function parameter 'pidfd' description in '__pidfd_prepare'
> kernel/fork.c:2179: warning: Function parameter or member 'ret' not described in 'pidfd_prepare'
> kernel/fork.c:2179: warning: Excess function parameter 'pidfd' description in 'pidfd_prepare'
> kernel/fork.c:3195: warning: expecting prototype for clone3(). Prototype was for sys_clone3() instead
> 13 warnings as Errors
> make[3]: *** [scripts/Makefile.build:243: kernel/fork.o] Error 13
> make[3]: *** Deleting file 'kernel/fork.o'
> make[2]: *** [scripts/Makefile.build:480: kernel] Error 2
> make[1]: *** [/root/linux/Makefile:1913: .] Error 2
> make: *** [Makefile:234: __sub-make] Error 2
>
> From the git history, commit 2c12c8103d8f ("scripts/kernel-doc:
> optionally treat warnings as errors") introduces a new command-line
> option to make kernel-doc warnings into errors. It can also read the
> KCFLAGS environment variable to decide whether to turn this option on,
> but the regex used for matching may not be accurate enough. It can match
> both "-Werror" and "-Werror=<diagnostic-type>", so the option is turned
> on by mistake in the latter case.
>
> Fix this by strictly matching the flag "-Werror": there must be a space
> or start of string in the front, and a space or end of string at the
> end. This can handle all the following cases correctly:
>
> KCFLAGS="-Werror" make W=1 [MATCH]
> KCFLAGS="-Werror=return-type" make W=1 [NO MATCH]
> KCFLAGS="-Wcomment -Werror -Wundef" make W=1 [MATCH]
> KCFLAGS="-Wcomment -Werror=return-type -Wundef" make W=1 [NO MATCH]
>
> Fixes: 2c12c8103d8f ("scripts/kernel-doc: optionally treat warnings as errors")
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> ---
>  scripts/kernel-doc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks,

jon
