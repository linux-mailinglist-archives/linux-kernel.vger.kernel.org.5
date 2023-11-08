Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323547E535C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344199AbjKHKaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjKHKaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:30:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEB51BD7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:30:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510AEC433C7;
        Wed,  8 Nov 2023 10:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699439403;
        bh=6ZoI2ba6vIpYYpfl0ANvHJHV0XAA/rAOGYtXoD2uuRg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HrDtYH6eKjPaP8v6C+1BefyGqlLRNHZLg4zWFl2q2QUVcr7vOhiJnEOU1P7PzPRGW
         rr9xwIo7hc0KEJzD3Xu48pmTcEY4ol+81jw17pVnZ3UrZPLc83DkYE37aed4UQsOpO
         Z83ayotG0vUMkFyVhsUk46QARRmFh+OJCGHIMWqn/m18j7pOHgU1OUrI+IKGkZ9keL
         HPl/fKRfcRaS5wdaiXx8JRMH4VGF5DHPc2ye1hCRD6ybC5iTR5hn+uSJ4ZvCJtTxS1
         b08UMZRk0sMZFU2ordnozCblbqfjycozFB+qW7YNPDrynRFmFjUVg/IpmaQkHVQGMr
         XQm6NwocnGgNQ==
Date:   Wed, 8 Nov 2023 19:29:49 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     <j.granados@samsung.com>
Cc:     Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
        josh@joshtriplett.org, Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 03/10] ftrace: Remove the now superfluous sentinel
 elements from ctl_table array
Message-Id: <20231108192949.f19832c76d1cf18c5d614e72@kernel.org>
In-Reply-To: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-3-e4ce1388dfa0@samsung.com>
References: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-0-e4ce1388dfa0@samsung.com>
        <20231107-jag-sysctl_remove_empty_elem_kernel-v1-3-e4ce1388dfa0@samsung.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2023 14:45:03 +0100
Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org> wrote:

> From: Joel Granados <j.granados@samsung.com>
> 
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> 
> Remove sentinel elements from ftrace_sysctls and user_event_sysctls
> 

Both looks good to me. (since register_sysctl_init() uses ARRAY_SIZE()
macro to get the array size.)

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  kernel/trace/ftrace.c            | 1 -
>  kernel/trace/trace_events_user.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 8de8bec5f366..fd40d02a23c7 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -8264,7 +8264,6 @@ static struct ctl_table ftrace_sysctls[] = {
>  		.mode           = 0644,
>  		.proc_handler   = ftrace_enable_sysctl,
>  	},
> -	{}
>  };
>  
>  static int __init ftrace_sysctl_init(void)
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 6f046650e527..bef1bdc62acf 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -2694,7 +2694,6 @@ static struct ctl_table user_event_sysctls[] = {
>  		.mode		= 0644,
>  		.proc_handler	= set_max_user_events_sysctl,
>  	},
> -	{}
>  };
>  
>  static int __init trace_events_user_init(void)
> 
> -- 
> 2.30.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
