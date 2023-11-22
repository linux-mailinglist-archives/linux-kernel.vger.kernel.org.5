Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E953D7F52A4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbjKVVdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 16:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjKVVdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:33:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22527A4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:33:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216ECC433C7;
        Wed, 22 Nov 2023 21:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700688829;
        bh=CCGiBp6ijIbiQN49IM0yNAMFM6x8RmE/GApUZ80sKhk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a9T8JgpHz5rCww2lmiWFAgJiYQz4lQnKLd+N/wJREBIzFj2s77dIv23vFbVfIT9GL
         dYS5ISI7BaGwajylptbeE4CbFzWkGsDed74VdXV5ZAH6c7ZfBstkSddhZsFb82ORIs
         +7sOq27xvaEWQzLNx0SteALC+cjD+zL6q9xcPca4=
Date:   Wed, 22 Nov 2023 13:33:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, tglx@linutronix.de, luto@kernel.org,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, mhocko@kernel.org, tj@kernel.org,
        ying.huang@intel.com, Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 00/11] mm/mempolicy: Make task->mempolicy externally
 modifiable via syscall and procfs
Message-Id: <20231122133348.d27c09a90bce755dc1c0f251@linux-foundation.org>
In-Reply-To: <20231122211200.31620-1-gregory.price@memverge.com>
References: <20231122211200.31620-1-gregory.price@memverge.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 16:11:49 -0500 Gregory Price <gourry.memverge@gmail.com> wrote:

> The patch set changes task->mempolicy to be modifiable by tasks other
> than just current.
> 
> The ultimate goal is to make mempolicy more flexible and extensible,
> such as adding interleave weights (which may need to change at runtime
> due to hotplug events).  Making mempolicy externally modifiable allows
> for userland daemons to make runtime performance adjustments to running
> tasks without that software needing to be made numa-aware.

Please add to this [0/N] a full description of the security aspect: who
can modify whose mempolicy, along with a full description of the
reasoning behind this decision.

> 3. Add external interfaces which allow for a task mempolicy to be
>    modified by another task.  This is implemented in 4 syscalls
>    and a procfs interface:
>         sys_set_task_mempolicy
>         sys_get_task_mempolicy
>         sys_set_task_mempolicy_home_node
>         sys_task_mbind
>         /proc/[pid]/mempolicy

Why is the procfs interface needed?  Doesn't it simply duplicate the
syscall interface?  Please update [0/N] with a description of this
decision.

> The new syscalls are the same as their current-task counterparts,
> except that they take a pid as an argument.  The exception is
> task_mbind, which required a new struct due to the number of args.
> 
> The /proc/pid/mempolicy re-uses the interface mpol_parse_str format
> to enable get/set of mempolicy via procsfs.
> 
> mpol_parse_str format:
>             <mode>[=<flags>][:<nodelist>]
> 
> Example usage:
> 
> echo "default" > /proc/pid/mempolicy
> echo "prefer=relative:0" > /proc/pid/mempolicy
> echo "interleave:0-3" > /proc/pid/mempolicy

What do we get when we read from this?  Please add to changelog.

> Changing the mempolicy does not induce memory migrations via the
> procfs interface (which is the exact same behavior as set_mempolicy).
> 

