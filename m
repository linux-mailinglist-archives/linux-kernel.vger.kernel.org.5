Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD1B7B4181
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 17:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbjI3PNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 11:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbjI3PNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 11:13:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AA2E1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 08:12:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31785C433C7;
        Sat, 30 Sep 2023 15:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696086777;
        bh=PivOh9Oi3ti4R3r3d2NJsId/JfcsfaTfCvijj5nVn6E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BBmI5PC6F5HIGQ+X3xf6XHDSQAXgcxHHV2ZU+8g8bx6ml8/GIqzWLAg0eTKVxsTx6
         bjgJ7n3UtsSjyBMottdbY/q0kgiJIePqe/XuJgGZCMdZmbAK+CGbMesV+BOvyTJ27M
         jOkkUVb/I0kHivbk55fM6jLYFFlfeeFBJUtrpxWCjC95/Iu+XfyyQ+pVrKQVbdzX8g
         N0CG/mNXWRuD79HkQUPvs3l8eedpx1caKjY6LiaJgHMTIaguTfu+EUrvtYSSCWpgsl
         moGF2W7MW/9BnEN5ZEzczoewhLc30GVyKNuWdEjOJu3y7rr0LMGtEM6hPib4XqvjVT
         hPADVzbRxAdiA==
Date:   Sun, 1 Oct 2023 00:12:53 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] eventfs: Test for dentries array allocated in
 eventfs_release()
Message-Id: <20231001001253.19971f4357e85d372ef34fc2@kernel.org>
In-Reply-To: <20230930090106.1c3164e9@rorschach.local.home>
References: <20230930090106.1c3164e9@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2023 09:01:06 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The dcache_dir_open_wrapper() could be called when a dynamic event is
> being deleted leaving a dentry with no children. In this case the
> dlist->dentries array will never be allocated. This needs to be checked
> for in eventfs_release(), otherwise it will trigger a NULL pointer
> dereference.

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Fixes: ef36b4f92868 ("eventfs: Remember what dentries were created on dir open")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  fs/tracefs/event_inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 5f1714089884..8c8d64e76103 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -421,7 +421,7 @@ static int eventfs_release(struct inode *inode, struct file *file)
>  	if (WARN_ON_ONCE(!dlist))
>  		return -EINVAL;
>  
> -	for (i = 0; dlist->dentries[i]; i++) {
> +	for (i = 0; dlist->dentries && dlist->dentries[i]; i++) {
>  		dput(dlist->dentries[i]);
>  	}
>  
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
