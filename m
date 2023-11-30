Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9817FFCBC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346785AbjK3UiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjK3UiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:38:11 -0500
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BCB10DC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:38:16 -0800 (PST)
Received: from [192.168.1.18] ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id 8nnYrCuP2RmBy8nnYrb7ak; Thu, 30 Nov 2023 21:38:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1701376694;
        bh=PxjlyLqGg3ejqMJeqvlJH8ecba7J9j55JY/fAcFBxOY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=mpx5N8JZgAr8OKYmGqydFOQXanBTNLnUTxMCMkjffdOBjH3960VuM68iMmcV3ckiF
         uZZikEUKK7/Z2RqDMSL4xubHHbnSnhbP2QGKopG1AU4B06AbisV7xYZo7YmFI05aJb
         zRQzecFqyZenFSuTG9zd5b+axWXJsTJXJNUTx+a5/03lGS1j9KXuqKjnhbY6jP+2GV
         lbnIS1UWBPgzKwbU2WulaGV7hOAhzdV6CMeiyFDsN+uBVq3QVWHKACgKdZXr6c2SI3
         Ykxq1s2rK4IJYcnWGSdD4W+Gvoc0WbIPW3riWIJbGtyoglWFiz85SqJV63vvuzsxF/
         3R84QqIrZzbPQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 30 Nov 2023 21:38:14 +0100
X-ME-IP: 92.140.202.140
Message-ID: <40b65db9-1b37-45b6-8afe-7be2df11cfa9@wanadoo.fr>
Date:   Thu, 30 Nov 2023 21:38:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] kernfs: Convert kernfs_path_from_node_locked()
 from strlcpy() to strscpy()
Content-Language: fr
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20231130200937.it.424-kees@kernel.org>
 <20231130201222.3613535-3-keescook@chromium.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231130201222.3613535-3-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 30/11/2023 à 21:12, Kees Cook a écrit :
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
>          kernfs_path_from_node()
>                  pr_cont_kernfs_path()
>                          returns void
>                  kernfs_path()
>                          sysfs_warn_dup()
>                                  return value ignored
>                          cgroup_path()
>                                  blkg_path()
>                                          bfq_bic_update_cgroup()
>                                                  return value ignored
>                                  TRACE_IOCG_PATH()
>                                          return value ignored
>                                  TRACE_CGROUP_PATH()
>                                          return value ignored
>                                  perf_event_cgroup()
>                                          return value ignored
>                                  task_group_path()
>                                          return value ignored
>                                  damon_sysfs_memcg_path_eq()
>                                          return value ignored
>                                  get_mm_memcg_path()
>                                          return value ignored
>                                  lru_gen_seq_show()
>                                          return value ignored
>                          cgroup_path_from_kernfs_id()
>                                  return value ignored
>                  cgroup_show_path()
>                          already converted "too large" error to negative value
>                  cgroup_path_ns_locked()
>                          cgroup_path_ns()
>                                  bpf_iter_cgroup_show_fdinfo()
>                                          return value ignored
>                                  cgroup1_release_agent()
>                                          wasn't checking "too large" error
>                          proc_cgroup_show()
>                                  already converted "too large" to negative value
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: cgroups@vger.kernel.org
> Co-developed-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> Link: https://lore.kernel.org/r/20231116192127.1558276-3-keescook@chromium.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   fs/kernfs/dir.c           | 37 ++++++++++++++++++++-----------------
>   kernel/cgroup/cgroup-v1.c |  2 +-
>   kernel/cgroup/cgroup.c    |  4 ++--
>   kernel/cgroup/cpuset.c    |  2 +-
>   4 files changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 8c0e5442597e..183f353b3852 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -127,7 +127,7 @@ static struct kernfs_node *kernfs_common_ancestor(struct kernfs_node *a,
>    *
>    * [3] when @kn_to is %NULL result will be "(null)"
>    *
> - * Return: the length of the full path.  If the full length is equal to or
> + * Return: the length of the constructed path.  If the path would have been
>    * greater than @buflen, @buf contains the truncated path with the trailing
>    * '\0'.  On error, -errno is returned.
>    */
> @@ -138,16 +138,17 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
>   	struct kernfs_node *kn, *common;
>   	const char parent_str[] = "/..";
>   	size_t depth_from, depth_to, len = 0;
> +	ssize_t copied;
>   	int i, j;
>   
>   	if (!kn_to)
> -		return strlcpy(buf, "(null)", buflen);
> +		return strscpy(buf, "(null)", buflen);
>   
>   	if (!kn_from)
>   		kn_from = kernfs_root(kn_to)->kn;
>   
>   	if (kn_from == kn_to)
> -		return strlcpy(buf, "/", buflen);
> +		return strscpy(buf, "/", buflen);
>   
>   	common = kernfs_common_ancestor(kn_from, kn_to);
>   	if (WARN_ON(!common))
> @@ -158,18 +159,22 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
>   
>   	buf[0] = '\0';
>   
> -	for (i = 0; i < depth_from; i++)
> -		len += strlcpy(buf + len, parent_str,
> -			       len < buflen ? buflen - len : 0);
> +	for (i = 0; i < depth_from; i++) {
> +		copied = strscpy(buf + len, parent_str, buflen - len);
> +		if (copied < 0)
> +			return copied;
> +		len += copied;
> +	}
>   
>   	/* Calculate how many bytes we need for the rest */
>   	for (i = depth_to - 1; i >= 0; i--) {
>   		for (kn = kn_to, j = 0; j < i; j++)
>   			kn = kn->parent;
> -		len += strlcpy(buf + len, "/",
> -			       len < buflen ? buflen - len : 0);
> -		len += strlcpy(buf + len, kn->name,
> -			       len < buflen ? buflen - len : 0);
> +
> +		copied = scnprintf(buf + len, buflen - len, "/%s", kn->name);
> +		if (copied < 0)

Can scnprintf() return <0 ?

> +			return copied;
> +		len += copied;
>   	}

...

