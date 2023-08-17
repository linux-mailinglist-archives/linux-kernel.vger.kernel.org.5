Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C6977EF9D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 05:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347889AbjHQDjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 23:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347886AbjHQDiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 23:38:52 -0400
Received: from out-4.mta0.migadu.com (out-4.mta0.migadu.com [91.218.175.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039592686
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 20:38:50 -0700 (PDT)
Message-ID: <2d530dec-e6c2-5e3a-ccf2-d65039a9969d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692243527; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4m46oeFWulkljhnMK2IlsZAL/z+HepLc7sY/jkFgntU=;
        b=pCB1K6WuwIyrwKQoCLmnEYzNWwQJDfkEF5N6rjtdW9GjwQlrbgeXfXXL0vmmvAAqajy/E+
        6L0oqY8uFkPq8PuPawfWoKXdJNbO1yAl8pl47tnHOl0W5OvHVS/M5rrKCHemOS13j5GYWK
        Z+kLKaPWetUQk5ZWQjCa69d84yAX7uY=
Date:   Wed, 16 Aug 2023 20:38:40 -0700
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next] bpf: Disable -Wmissing-declarations for
 globally-linked kfuncs
Content-Language: en-US
To:     David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, kernel test robot <lkp@intel.com>
References: <20230816150634.1162838-1-void@manifault.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230816150634.1162838-1-void@manifault.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/23 8:06 AM, David Vernet wrote:
> We recently got an lkp warning about missing declarations, as in e.g.
> [0]. This warning is largely redundant with -Wmissing-prototypes, which
> we already disable for kfuncs that have global linkage and are meant to
> be exported in BTF, and called from BPF programs. Let's also disable
> -Wmissing-declarations for kfuncs. For what it's worth, I wasn't able to
> reproduce the warning even on W <= 3, so I can't actually be 100% sure
> this fixes the issue.
> 
> [0]: https://lore.kernel.org/all/202308162115.Hn23vv3n-lkp@intel.com/

Okay, I just got a similar email to [0] which complains
   bpf_obj_new_impl, ..., bpf_cast_to_kern_ctx
missing declarations.

In the email, the used compiler is
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0

Unfortunately, I did not have gcc-7 to verify this.
Also, what is the minimum gcc version kernel supports? 5.1?

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308162115.Hn23vv3n-lkp@intel.com/
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>   Documentation/bpf/kfuncs.rst                          | 4 +++-
>   kernel/bpf/bpf_iter.c                                 | 2 ++
>   kernel/bpf/cpumask.c                                  | 2 ++
>   kernel/bpf/helpers.c                                  | 2 ++
>   kernel/bpf/map_iter.c                                 | 2 ++
>   kernel/cgroup/rstat.c                                 | 2 ++
>   kernel/trace/bpf_trace.c                              | 2 ++
>   net/bpf/test_run.c                                    | 2 ++
>   net/core/filter.c                                     | 4 ++++
>   net/core/xdp.c                                        | 2 ++
>   net/ipv4/fou_bpf.c                                    | 2 ++
>   net/netfilter/nf_conntrack_bpf.c                      | 2 ++
>   net/netfilter/nf_nat_bpf.c                            | 2 ++
>   net/xfrm/xfrm_interface_bpf.c                         | 2 ++
>   tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 2 ++
>   15 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 0d2647fb358d..62ce5a7b92b4 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -36,10 +36,12 @@ prototype in a header for the wrapper kfunc.
>   
>   An example is given below::
>   
> -        /* Disables missing prototype warnings */
> +        /* Disables missing prototypes and declarations warnings */
>           __diag_push();
>           __diag_ignore_all("-Wmissing-prototypes",
>                             "Global kfuncs as their definitions will be in BTF");
> +        __diag_ignore_all("-Wmissing-declarations",
> +                          "Global kfuncs as their definitions will be in BTF");
>   
>           __bpf_kfunc struct task_struct *bpf_find_get_task_by_vpid(pid_t nr)
>           {
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index 96856f130cbf..b8def6e4e5e8 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -785,6 +785,8 @@ struct bpf_iter_num_kern {
>   __diag_push();
>   __diag_ignore_all("-Wmissing-prototypes",
>   		  "Global functions as their definitions will be in vmlinux BTF");
> +__diag_ignore_all("-Wmissing-declarations",
> +		  "Global functions as their definitions will be in vmlinux BTF");
>   
>   __bpf_kfunc int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end)
>   {
[...]
