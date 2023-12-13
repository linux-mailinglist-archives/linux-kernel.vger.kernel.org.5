Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E950811273
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379134AbjLMNEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379206AbjLMNEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:04:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAC9121
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:54:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C24C433C7;
        Wed, 13 Dec 2023 12:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702472094;
        bh=gBG7q7d6yeZOd/c1kwWuK1qPKa2vW1p2OK1rECWWvTI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TPj3sNYbXok2E+B31zh2s3H/L6aacMNCDhzhZ71Mv0L0tL9xoHx0BF8RiDWrUDX03
         hlY8FULjAeL+T2oGzyMKlDT4jev8KnS9u6o7reCF2OrDJ43yCpPhC7AafRLQPKDCyD
         6MV6gOMSt+rrcsaLqALumG+QCDlD5QzvmVpCPS4yXxSfg9PAdCwq/HPtjgrUHO24ya
         NQ48QfEcUntf7KUcpAlpQauJ8OSmkD0AjD8iv8RR6jw9DQV6sXgIfIXVOhSEQuHkTr
         exSG4xLITkcmc3yddRyStj0rvF/Z2uD+l957iveD/Y1P9leZv0ZKvmfUHGtiP/8SV9
         flZoF06HLS96A==
Date:   Wed, 13 Dec 2023 21:54:50 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Naveen N Rao <naveen@kernel.org>
Cc:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] selftests/ftrace: Add test to exercize function
 tracer across cpu hotplug
Message-Id: <20231213215450.792f5e6f21eb3e709f4ea05c@kernel.org>
In-Reply-To: <20231213113802.1278600-1-naveen@kernel.org>
References: <20231213113802.1278600-1-naveen@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 17:08:02 +0530
Naveen N Rao <naveen@kernel.org> wrote:

> Add a test to exercize cpu hotplug with the function tracer active to
> ensure that sensitive functions in idle path are excluded from being
> traced. This helps catch issues such as the one fixed by commit
> 4b3338aaa74d ("powerpc/ftrace: Fix stack teardown in ftrace_no_trace").
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Naveen N Rao <naveen@kernel.org>
> ---
> v2: Add a check for next available online cpu, as suggested by Masami.
> 
>  .../ftrace/test.d/ftrace/func_hotplug.tc      | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
> new file mode 100644
> index 000000000000..ccfbfde3d942
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
> @@ -0,0 +1,42 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
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
> +  echo "We cannot test cpu hotplug in UP environment"
> +  exit_unresolved
> +fi
> +
> +# Find online cpu
> +for i in /sys/devices/system/cpu/cpu[1-9]*; do
> +	if [ -f $i/online ] && [ "$(cat $i/online)" = "1" ]; then
> +		cpu=$i
> +		break
> +	fi
> +done
> +
> +if [ -z "$cpu" ]; then
> +	echo "We cannot test cpu hotplug with a single cpu online"
> +	exit_unresolved
> +fi
> +
> +echo 0 > tracing_on
> +echo > trace
> +
> +: "Set $(basename $cpu) offline/online with function tracer enabled"
> +echo function > current_tracer
> +echo 1 > tracing_on
> +(echo 0 > $cpu/online)
> +(echo "forked"; sleep 1)
> +(echo 1 > $cpu/online)
> +echo 0 > tracing_on
> +echo nop > current_tracer
> 
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
