Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71137EF3D0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjKQNsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQNsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:48:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7D9120
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 05:48:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A0EC433C7;
        Fri, 17 Nov 2023 13:47:59 +0000 (UTC)
Date:   Fri, 17 Nov 2023 08:47:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        cgroups@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/3] kernfs: Convert kernfs_path_from_node_locked() from
 strlcpy() to strscpy()
Message-ID: <20231117084757.150724ed@rorschach.local.home>
In-Reply-To: <20231116192127.1558276-3-keescook@chromium.org>
References: <20231116191718.work.246-kees@kernel.org>
        <20231116192127.1558276-3-keescook@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 11:21:25 -0800
Kees Cook <keescook@chromium.org> wrote:

> One of the last remaining users of strlcpy() in the kernel is
> kernfs_path_from_node_locked(), which passes back the problematic "length
> we _would_ have copied" return value to indicate truncation.  Convert the
> chain of all callers to use the negative return value (some of which
> already doing this explicitly). All callers were already also checking
> for negative return values, so the risk to missed checks looks very low.
> 
> In this analysis, it was found that cgroup1_release_agent() actually
> didn't handle the "too large" condition, so this is technically also a
> bug fix. :)
> 
> Here's the chain of callers, and resolution identifying each one as now
> handling the correct return value:
> 
> kernfs_path_from_node_locked()
>         kernfs_path_from_node()
>                 pr_cont_kernfs_path()
>                         returns void
>                 kernfs_path()
>                         sysfs_warn_dup()
>                                 return value ignored
>                         cgroup_path()
>                                 blkg_path()
>                                         bfq_bic_update_cgroup()
>                                                 return value ignored
>                                 TRACE_IOCG_PATH()
>                                         return value ignored
>                                 TRACE_CGROUP_PATH()
>                                         return value ignored
>                                 perf_event_cgroup()
>                                         return value ignored
>                                 task_group_path()
>                                         return value ignored
>                                 damon_sysfs_memcg_path_eq()
>                                         return value ignored
>                                 get_mm_memcg_path()
>                                         return value ignored
>                                 lru_gen_seq_show()
>                                         return value ignored
>                         cgroup_path_from_kernfs_id()
>                                 return value ignored
>                 cgroup_show_path()
>                         already converted "too large" error to negative value
>                 cgroup_path_ns_locked()
>                         cgroup_path_ns()
>                                 bpf_iter_cgroup_show_fdinfo()
>                                         return value ignored
>                                 cgroup1_release_agent()
>                                         wasn't checking "too large" error
>                         proc_cgroup_show()
>                                 already converted "too large" to negative value
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: cgroups@vger.kernel.org
> Cc: linux-trace-kernel@vger.kernel.org
> Co-developed-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/kernfs/dir.c             | 37 ++++++++++++++++++++-----------------
>  kernel/cgroup/cgroup-v1.c   |  2 +-
>  kernel/cgroup/cgroup.c      |  4 ++--
>  kernel/cgroup/cpuset.c      |  2 +-
>  kernel/trace/trace_uprobe.c |  2 +-

trace_uprobe.c seems out of scope for this patch.

-- Steve
