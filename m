Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24467E4222
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbjKGOxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjKGOxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:53:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF7C101
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 06:53:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD27C433C7;
        Tue,  7 Nov 2023 14:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699368826;
        bh=fOlaiY+Lug3W3hWE5Iha2poFtpHLl/oEcKB+nLp/pwE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TmchANtoaaPiRKN2OVuXoB2x79MMbJ7272ifdkW3t+92fq6U6CbxC5kzht3cXPb/7
         J4YodH/BXoKU0iQW1fxWBeltkc37FnJLmxr78LvB3cSO/+ziGO0jbU4WeR4c5DYmUZ
         lyl8PKDM2Xt16Z3YWWdbkMeLnIlJZ00L0MsBXm/VcQLdPHTfrlbiSt/roXfYVfSMYG
         M3NKJqJwluRWHFHezS5ERBDZQ9jTqssjxNrcEtS/2+o4G1GEhDh85tCf0ZmouyzEzF
         bqDn5mFiWa9VBvQ6VyD/TUOJ+hXbPJPTrMHNeyvJb9mVylKdDmOc3yMISK7BPkL6Ub
         0E/C0IAWoPkWg==
Message-ID: <fbba559c-59e2-94f1-52d6-94960a13f682@kernel.org>
Date:   Tue, 7 Nov 2023 22:53:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] f2fs: fix thread name cannot be fully displayed
Content-Language: en-US
To:     Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com
References: <1698888042-17199-1-git-send-email-zhiguo.niu@unisoc.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <1698888042-17199-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/2 9:20, Zhiguo Niu wrote:
> Because the length of task'name in task_struct can not exceed
> 16 characters, f2fs some thread'name cannot be fully displayed,
> including important device number information.
> If there are more than one partition using the f2fs file system,
> it is very inconvenient to match partitions and their threads.
> 
> The following examples show that 4 partitions all use f2fs file system
> PID: 400    TASK: ffffff80f120c9c0  CPU: 2   COMMAND: "f2fs_discard-25"
> PID: 392    TASK: ffffff80f6b75880  CPU: 3   COMMAND: "f2fs_discard-25"
> PID: 400    TASK: ffffff80f120c9c0  CPU: 2   COMMAND: "f2fs_discard-25"
> PID: 392    TASK: ffffff80f6b75880  CPU: 3   COMMAND: "f2fs_discard-25"
> PID: 510    TASK: ffffff80dd62c9c0  CPU: 0   COMMAND: "f2fs_ckpt-254:4"
> PID: 255    TASK: ffffff80f2268000  CPU: 3   COMMAND: "f2fs_ckpt-259:4"
> PID: 398    TASK: ffffff80f120ac40  CPU: 2   COMMAND: "f2fs_ckpt-259:4"
> PID: 390    TASK: ffffff80f6b76740  CPU: 3   COMMAND: "f2fs_ckpt-259:4"
> PID: 511    TASK: ffffff80dd629d80  CPU: 3   COMMAND: "f2fs_flush-254:"
> PID: 399    TASK: ffffff80f120bb00  CPU: 2   COMMAND: "f2fs_flush-259:"
> PID: 391    TASK: ffffff80f6b70000  CPU: 3   COMMAND: "f2fs_flush-259:"
> PID: 256    TASK: ffffff80f226d880  CPU: 6   COMMAND: "f2fs_flush-259:"
> 
> We can use the name format such as f2fs_gc-xxx, as saw in device:
> PID: 260    TASK: ffffff80f8c2e740  CPU: 3   COMMAND: "f2fs_gc-259:44"
> PID: 420    TASK: ffffff80f6505880  CPU: 2   COMMAND: "f2fs_gc-259:41"
> PID: 393    TASK: ffffff80f6b72c40  CPU: 1   COMMAND: "f2fs_gc-259:40
> PID: 513    TASK: ffffff80dd62e740  CPU: 1   COMMAND: "f2fs_gc-254:40"

Can you please check comments in below link?

https://lore.kernel.org/linux-f2fs-devel/8eaad9d0-1d59-3ecb-bab4-904ed22385f4@kernel.org/

Thanks,

> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>   fs/f2fs/checkpoint.c | 2 +-
>   fs/f2fs/segment.c    | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index b0597a5..f6a5424 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1893,7 +1893,7 @@ int f2fs_start_ckpt_thread(struct f2fs_sb_info *sbi)
>   		return 0;
>   
>   	cprc->f2fs_issue_ckpt = kthread_run(issue_checkpoint_thread, sbi,
> -			"f2fs_ckpt-%u:%u", MAJOR(dev), MINOR(dev));
> +			"f2fs_cp-%u:%u", MAJOR(dev), MINOR(dev));
>   	if (IS_ERR(cprc->f2fs_issue_ckpt)) {
>   		int err = PTR_ERR(cprc->f2fs_issue_ckpt);
>   
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index d05b416..b290713 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -677,7 +677,7 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
>   
>   init_thread:
>   	fcc->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
> -				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
> +				"f2fs_fh-%u:%u", MAJOR(dev), MINOR(dev));
>   	if (IS_ERR(fcc->f2fs_issue_flush)) {
>   		int err = PTR_ERR(fcc->f2fs_issue_flush);
>   
> @@ -2248,7 +2248,7 @@ int f2fs_start_discard_thread(struct f2fs_sb_info *sbi)
>   		return 0;
>   
>   	dcc->f2fs_issue_discard = kthread_run(issue_discard_thread, sbi,
> -				"f2fs_discard-%u:%u", MAJOR(dev), MINOR(dev));
> +				"f2fs_dc-%u:%u", MAJOR(dev), MINOR(dev));
>   	if (IS_ERR(dcc->f2fs_issue_discard)) {
>   		err = PTR_ERR(dcc->f2fs_issue_discard);
>   		dcc->f2fs_issue_discard = NULL;
