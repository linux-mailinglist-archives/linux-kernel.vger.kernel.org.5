Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2CB7E4CA1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbjKGXUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjKGXUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:20:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9065410C3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:20:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFDDC433C8;
        Tue,  7 Nov 2023 23:20:27 +0000 (UTC)
Date:   Tue, 7 Nov 2023 18:20:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@ACULAB.COM,
        richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 14/86] Revert "preempt/dynamic: Fix
 setup_preempt_mode() return value"
Message-ID: <20231107182030.0dfc4e78@gandalf.local.home>
In-Reply-To: <20231107215742.363031-15-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231107215742.363031-15-ankur.a.arora@oracle.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Nov 2023 13:57:00 -0800
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> This reverts commit 9ed20bafc85806ca6c97c9128cec46c3ef80ae86.

Note, it's better to just do a big revert of related code than to have to
revert every individual commit.

You can do one big commit that states:

This reverts commits:

  ....

And list the commits.

That is, for commits that affect a single file, do not cherry-pick commits
to remove, just remove them all in one go.

-- Steve


> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  kernel/sched/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f8bbddd729db..50e1133cacc9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7062,11 +7062,11 @@ static int __init setup_preempt_mode(char *str)
>  	int mode = sched_dynamic_mode(str);
>  	if (mode < 0) {
>  		pr_warn("Dynamic Preempt: unsupported mode: %s\n", str);
> -		return 0;
> +		return 1;
>  	}
>  
>  	sched_dynamic_update(mode);
> -	return 1;
> +	return 0;
>  }
>  __setup("preempt=", setup_preempt_mode);
>  

