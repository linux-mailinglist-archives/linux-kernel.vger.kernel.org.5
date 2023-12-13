Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3772A8106CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377899AbjLMAkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377870AbjLMAkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:40:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28EEAC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:40:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4A1C433C7;
        Wed, 13 Dec 2023 00:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702428042;
        bh=yaOwyRdIE6NOk7geX4K1Pt2wgBpMW9U+4MntbxQURCg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yj1K/lmw3/ETwXTyAQSKFVJX2kJMUqhNhBGdxKl6cdMPT2LkbWQBAFima855XXjIU
         F8XcRe+llUb+ob2bgnSv/EQps95hU5ddAvcJSL+XdKJDtbutXD3utC80d6xkVGn77m
         xFgIv49utMavdx0BC6nvK7KyrtpqPP7Q78/ifBWh0e9Xh5kG62w0WGYsjHMTXIKtSL
         UQAiYUJdUPaGlXDDgtVLCU1GxBJn1x5rAZvQq54PBUxnN4xOy2XUDxQmUA5FAQrKuy
         XoHoJ8gd+zYnbEi9RIQ71imytOLyKR/hKF1n4E/l+8S6sKzdMaKto4bPUN4IrSsxQf
         n4YuThzp87x1Q==
Date:   Wed, 13 Dec 2023 09:40:38 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Naveen N Rao <naveen@kernel.org>
Cc:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] selftests/ftrace: Add test to exercize function tracer
 across cpu hotplug
Message-Id: <20231213094038.6c9518a2042b84c8388ec6ae@kernel.org>
In-Reply-To: <20231212085607.1213210-1-naveen@kernel.org>
References: <20231212085607.1213210-1-naveen@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naveen,

On Tue, 12 Dec 2023 14:26:07 +0530
Naveen N Rao <naveen@kernel.org> wrote:

> Add a test to exercize cpu hotplug with the function tracer active to
> ensure that sensitive functions in idle path are excluded from being
> traced. This helps catch issues such as the one fixed by commit
> 4b3338aaa74d ("powerpc/ftrace: Fix stack teardown in ftrace_no_trace").
> 
> Signed-off-by: Naveen N Rao <naveen@kernel.org>
> ---
>  .../ftrace/test.d/ftrace/func_hotplug.tc      | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
> new file mode 100644
> index 000000000000..49731a2b5c23
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: ftrace - function trace across cpu hotplug
> +# requires: function:tracer
> +
> +if ! which nproc ; then
> +  nproc() {
> +    ls -d /sys/devices/system/cpu/cpu[0-9]* | wc -l
> +  }
> +fi
> +
> +NP=`nproc`
> +
> +if [ $NP -eq 1 ] ;then
> +  echo "We can not test cpu hotplug in UP environment"
> +  exit_unresolved
> +fi

This looks good, but can you find the 2nd online CPU before
this test?
I mean, there is a case that cpu1 is already offlined and others
like cpu2 is onlined. So we need to use the 2nd online cpu.

Thank you,

> +
> +echo 0 > tracing_on
> +echo > trace
> +: "Set CPU1 offline/online with function tracer enabled"
> +echo function > current_tracer
> +echo 1 > tracing_on
> +(echo 0 > /sys/devices/system/cpu/cpu1/online)
> +(echo "forked"; sleep 1)
> +(echo 1 > /sys/devices/system/cpu/cpu1/online)
> +echo 0 > tracing_on
> +
> +: "Check CPU1 events are recorded"
> +grep -q -e "\[001\]" trace
> 
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
