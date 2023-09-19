Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A919A7A5945
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 07:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjISFTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 01:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjISFTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 01:19:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6B9FC;
        Mon, 18 Sep 2023 22:19:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDA4C433C8;
        Tue, 19 Sep 2023 05:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695100749;
        bh=b0mnAPtySR6jZ3NDA8RYGRddFtYNQZ0xvMRTcjIL/x8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QWdbjsk/12RUMkBwU5i21Amo060j/pmAEnP3P3V2hqJi4laTnXXGvid1+xL7PxOZp
         f+3SIONUh/tXxgcHrYCYEkcn/aURAmqHj2IXyDyRJT2sCtQUlBR+GOichZMz1CZoGv
         LB5sHYsCi8ZD07VMzHhJNiIwA0MNr0/6JmE1uAxJDZYDbwv/Utigl5i4SOI93I9SZN
         pVaA1Hkxny3dS+IdfLGKH/fybdt9H3Moi7Qv3AGRGoKSLEF06/T1ps0GKr4X9Kakwz
         BgUqvyyuppVwDx0UJumn1jFqjWSNns4Rn6x1FIU+ZdyLJEPiaFpnqKv9bMeU3Wtl51
         K9YBAeWUA9N3A==
Date:   Tue, 19 Sep 2023 14:19:04 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Li zeming <zeming@nfschina.com>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Remove unnecessary initial values of variables
Message-Id: <20230919141904.ef53e6663e4c5400ae913622@kernel.org>
In-Reply-To: <20230919012823.7815-1-zeming@nfschina.com>
References: <20230919012823.7815-1-zeming@nfschina.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023 09:28:23 +0800
Li zeming <zeming@nfschina.com> wrote:

> ri and sym is assigned first, so it does not need to initialize the
> assignment.
> 

Yes, thanks for fixing!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  kernel/kprobes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index ca385b61d546..82b2a366d496 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1990,7 +1990,7 @@ NOKPROBE_SYMBOL(__kretprobe_find_ret_addr);
>  unsigned long kretprobe_find_ret_addr(struct task_struct *tsk, void *fp,
>  				      struct llist_node **cur)
>  {
> -	struct kretprobe_instance *ri = NULL;
> +	struct kretprobe_instance *ri;
>  	kprobe_opcode_t *ret;
>  
>  	if (WARN_ON_ONCE(!cur))
> @@ -2817,7 +2817,7 @@ static int show_kprobe_addr(struct seq_file *pi, void *v)
>  {
>  	struct hlist_head *head;
>  	struct kprobe *p, *kp;
> -	const char *sym = NULL;
> +	const char *sym;
>  	unsigned int i = *(loff_t *) v;
>  	unsigned long offset = 0;
>  	char *modname, namebuf[KSYM_NAME_LEN];
> -- 
> 2.18.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
