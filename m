Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DC67DEA95
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348250AbjKBCOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348224AbjKBCOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:14:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02228BD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 19:14:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7A0C433C8;
        Thu,  2 Nov 2023 02:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698891270;
        bh=CJMrtyfuHl+r7KeAJXfcnHc6hF/5D0/sWKNgaLrPbP8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r0p6VTcKuIV1vgCZCk8pSw3J6KhLx27uHXZ/WwFbauiM3l2pgfo+yxUp+gNnYbrus
         qaK/zijM8d7Upy0dhFnDUjU52LLkq8mrNJS6wEwXSiu5s5L9745JfmmzoEHMIX/Ndg
         dc0MQ/wLuls9kMEa2yYNnyNdXNJtv3OI8Vsc+dlWnLVqPIxQRDo3w2ZuFTACe0qXoK
         LWJiq+vnwOATmRfLrJi5ruLxtNuWtcVQhsPbx9E6GU4H+ljBcz6x3pMAIfnDKVWhbR
         d01j1lSrJBm21FtZH2NxIQxEw+GoRMcNOLoEQFUQLoAoidRZnxyZkvNRPAk0e+KSRC
         De1VBceZtVDNA==
Date:   Thu, 2 Nov 2023 11:14:26 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH v6 7/8] eventfs: Remove special processing of dput() of
 events directory
Message-Id: <20231102111426.5ca004d4f8fce591b536708c@kernel.org>
In-Reply-To: <20231101172650.340876747@goodmis.org>
References: <20231101172541.971928390@goodmis.org>
        <20231101172650.340876747@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2023 13:25:48 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The top level events directory is no longer special with regards to how it
> should be delete. Remove the extra processing for it in
> eventfs_set_ei_status_free().
> 
Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Cc: Ajay Kaher <akaher@vmware.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v5: https://lkml.kernel.org/r/20231031223421.185413077@goodmis.org
> 
> - Resynced to this patch series
> 
>  fs/tracefs/event_inode.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 0a04ae0ca8c8..0087a3f455f1 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -274,28 +274,11 @@ static void free_ei(struct eventfs_inode *ei)
>   */
>  void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
>  {
> -	struct tracefs_inode *ti_parent;
>  	struct eventfs_inode *ei;
>  	int i;
>  
> -	/* The top level events directory may be freed by this */
> -	if (unlikely(ti->flags & TRACEFS_EVENT_TOP_INODE)) {
> -		mutex_lock(&eventfs_mutex);
> -		ei = ti->private;
> -		/* Nothing should access this, but just in case! */
> -		ti->private = NULL;
> -		mutex_unlock(&eventfs_mutex);
> -
> -		free_ei(ei);
> -		return;
> -	}
> -
>  	mutex_lock(&eventfs_mutex);
>  
> -	ti_parent = get_tracefs(dentry->d_parent->d_inode);
> -	if (!ti_parent || !(ti_parent->flags & TRACEFS_EVENT_INODE))
> -		goto out;
> -
>  	ei = dentry->d_fsdata;
>  	if (!ei)
>  		goto out;
> @@ -920,6 +903,8 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
>  	inode->i_op = &eventfs_root_dir_inode_operations;
>  	inode->i_fop = &eventfs_file_operations;
>  
> +	dentry->d_fsdata = ei;
> +
>  	/* directory inodes start off with i_nlink == 2 (for "." entry) */
>  	inc_nlink(inode);
>  	d_instantiate(dentry, inode);
> -- 
> 2.42.0


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
