Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D712A7DECB5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 07:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjKBGAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 02:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKBGA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 02:00:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A0A13D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 23:00:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2ACC3C433AD;
        Thu,  2 Nov 2023 06:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698904825;
        bh=5Qas+HFTiqzVDkX8McUzv1By9wmnnhxEMbccqZ++u+U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aQhccwjFXbgFDng+kpQMi+bxm1bBNmU6eWx5dsev1b7WRp+TczXxtetoZTKweQfTW
         JCk/05d8qC2TzJHdcS68LvtI6OuWo/TQBSU66jbLhX1fS+dptakFzeCbezRVxJM6aB
         R862WZfIeNVGbtieparl3YFAjuchiiQ9T3nAr9LwUTrvHXUPOBC5uWWQfqxn/ZJtz2
         GTFuEaWcqmjUp9c8AQd0cnZLMiwOlOTNSNijBIJAPrsC9CPQSaEifMDeR5ImE4lNpI
         SNmLi7JSFOtnKq82rsOrDdn+Ae1GHDhXKWPMOtUWHq1A8aIAtSGNnKcg33ppKCaPjV
         BSosLcIapxaxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E216E00094;
        Thu,  2 Nov 2023 06:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 bpf-next] bpf: fix compilation error without CGROUPS
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169890482505.9002.10852784674164703819.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Nov 2023 06:00:25 +0000
References: <20231101181601.1493271-1-jolsa@kernel.org>
In-Reply-To: <20231101181601.1493271-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        lkp@intel.com, bpf@vger.kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        laoar.shao@gmail.com, tj@kernel.org, linux-kernel@vger.kernel.org,
        mptcp@lists.linux.dev
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  1 Nov 2023 19:16:01 +0100 you wrote:
> From: Matthieu Baerts <matttbe@kernel.org>
> 
> Our MPTCP CI complained [1] -- and KBuild too -- that it was no longer
> possible to build the kernel without CONFIG_CGROUPS:
> 
>   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
>   kernel/bpf/task_iter.c:919:14: error: 'CSS_TASK_ITER_PROCS' undeclared (first use in this function)
>     919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
>         |              ^~~~~~~~~~~~~~~~~~~
>   kernel/bpf/task_iter.c:919:14: note: each undeclared identifier is reported only once for each function it appears in
>   kernel/bpf/task_iter.c:919:36: error: 'CSS_TASK_ITER_THREADED' undeclared (first use in this function)
>     919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
>         |                                    ^~~~~~~~~~~~~~~~~~~~~~
>   kernel/bpf/task_iter.c:927:60: error: invalid application of 'sizeof' to incomplete type 'struct css_task_iter'
>     927 |         kit->css_it = bpf_mem_alloc(&bpf_global_ma, sizeof(struct css_task_iter));
>         |                                                            ^~~~~~
>   kernel/bpf/task_iter.c:930:9: error: implicit declaration of function 'css_task_iter_start'; did you mean 'task_seq_start'? [-Werror=implicit-function-declaration]
>     930 |         css_task_iter_start(css, flags, kit->css_it);
>         |         ^~~~~~~~~~~~~~~~~~~
>         |         task_seq_start
>   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_next':
>   kernel/bpf/task_iter.c:940:16: error: implicit declaration of function 'css_task_iter_next'; did you mean 'class_dev_iter_next'? [-Werror=implicit-function-declaration]
>     940 |         return css_task_iter_next(kit->css_it);
>         |                ^~~~~~~~~~~~~~~~~~
>         |                class_dev_iter_next
>   kernel/bpf/task_iter.c:940:16: error: returning 'int' from a function with return type 'struct task_struct *' makes pointer from integer without a cast [-Werror=int-conversion]
>     940 |         return css_task_iter_next(kit->css_it);
>         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_destroy':
>   kernel/bpf/task_iter.c:949:9: error: implicit declaration of function 'css_task_iter_end' [-Werror=implicit-function-declaration]
>     949 |         css_task_iter_end(kit->css_it);
>         |         ^~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [PATCHv2,bpf-next] bpf: fix compilation error without CGROUPS
    https://git.kernel.org/bpf/bpf/c/05670f81d128

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


