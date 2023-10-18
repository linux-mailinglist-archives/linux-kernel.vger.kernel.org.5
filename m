Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EE27CE0E5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345340AbjJRPNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345355AbjJRPNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:13:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F6B130
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:13:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E5CC433C8;
        Wed, 18 Oct 2023 15:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697641989;
        bh=gf1en1MFTQj6YIJHsRedci2J/yLMelSJ1cxQHEVixBA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M0QdATYk2ED50MAUiZZHQPGpZl6D5AjwJDSwNTxhENMbNDzpvyX5QPH5Lv05hrVxX
         uN2oBcvkh9eyda1QNf5J2/NeJKqQq8BOzqtprSBqRE5z0eRG+415TYv00HYMwH8K2W
         re+fMBRljLDEtvMo/DZ3jno8Dh/Mlihem7KeO15opsRt6ApcbFlW06kh8w7vD08U9c
         OGa9ubWM8NjndwQT4kQV1RLDkQVHqS6XHOyTN2AaYKGYuKOVQ0t2xky+ktuBHkEv47
         Qstpq5pMlzlQDVB2INsjCu/kfINN8YqAwZum2Ngt3AQHiSv66FTNY1fl/I/4wvx46B
         SGaTtML3IAvwA==
Date:   Thu, 19 Oct 2023 00:13:03 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc:     linux-trace-kernel@vger.kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com
Subject: Re: [PATCH v11 0/5] lib,kprobes: kretprobe scalability improvement
Message-Id: <20231019001303.befd514dd103d334527e1754@kernel.org>
In-Reply-To: <20231017135654.82270-1-wuqiang.matt@bytedance.com>
References: <20231017135654.82270-1-wuqiang.matt@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 17 Oct 2023 21:56:49 +0800
"wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:

> This patch series introduces a scalable and lockless ring-array based
> object pool to improve scalability of kretprobed routines.
> 
> v11:
>   *) patchset rebased to branch probes/core of linux-trace.git
>   *) objpool: objpool_fini optimized for better code readability
>   *) test_objpool: asynchronous releasing of objpool now covered
> 
> wuqiang.matt (5):
>   lib: objpool added: ring-array based lockless MPMC
>   lib: objpool test module added
>   kprobes: kretprobe scalability improvement with objpool
>   kprobes: freelist.h removed
>   MAINTAINERS: objpool added

OK, this version looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

I'll pick this series on for-next branch.

Thank you,

> 
>  MAINTAINERS              |   7 +
>  include/linux/freelist.h | 129 --------
>  include/linux/kprobes.h  |  11 +-
>  include/linux/objpool.h  | 176 ++++++++++
>  include/linux/rethook.h  |  16 +-
>  kernel/kprobes.c         |  93 +++---
>  kernel/trace/fprobe.c    |  32 +-
>  kernel/trace/rethook.c   |  90 +++--
>  lib/Kconfig.debug        |  11 +
>  lib/Makefile             |   4 +-
>  lib/objpool.c            | 286 ++++++++++++++++
>  lib/test_objpool.c       | 689 +++++++++++++++++++++++++++++++++++++++
>  12 files changed, 1270 insertions(+), 274 deletions(-)
>  delete mode 100644 include/linux/freelist.h
>  create mode 100644 include/linux/objpool.h
>  create mode 100644 lib/objpool.c
>  create mode 100644 lib/test_objpool.c
> 
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
