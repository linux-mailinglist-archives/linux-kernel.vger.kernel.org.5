Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E81D7D81C7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344748AbjJZL3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZL3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:29:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0981A6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:29:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22E9C433C8;
        Thu, 26 Oct 2023 11:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698319759;
        bh=zSnBPFL1FyHMB9Lt8OdwtoUZBHJnYsTes7TD3DNgyUg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RBUTFYSgh8Um39OgbjSsykD9QdZ+mMEd/mFEqF22zpd8TqHADvOlNHlOSKH8xXajT
         F97/IMqlBrSUNRvjGCF13HTvG5zeJyP834METlDGqVseVG3zr6tf7PyQc78gwq/igX
         WcLwabCZgeDXIJ3XfrlKCwbZId6ojP9D1SFSInGSvkLsmNYeldLFkUiYuMJTsevirA
         PhqRrZfcbLwfopaIXHqv7KRZQcRr0mZcbuKANgMYiDdLglR6kMO3F0tJjzBQNu4Aj7
         DwX0PpzQQQ+jW4Q+umvbX6mNdjF/Mskp1vYTX71jG/Z0ioNF0G6BA6yO7J3rKjgsUf
         kVdvhKZsjJ/sg==
Date:   Thu, 26 Oct 2023 20:29:13 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] eventfs: Fix WARN_ON() in create_file_dentry()
Message-Id: <20231026202913.be6afa452f9839a826c4b8ed@kernel.org>
In-Reply-To: <20231024123628.62b88755@gandalf.local.home>
References: <20231024123628.62b88755@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 12:36:28 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> As the comment right above a WARN_ON() in create_file_dentry() states:
> 
>   * Note, with the mutex held, the e_dentry cannot have content
>   * and the ei->is_freed be true at the same time.
> 
> But the WARN_ON() only has:
> 
>   WARN_ON_ONCE(ei->is_free);
> 
> Where to match the comment (and what it should actually do) is:
> 
>   dentry = *e_dentry;
>   WARN_ON_ONCE(dentry && ei->is_free)
> 
> Also in that case, set dentry to NULL (although it should never happen).

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> 
> Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  fs/tracefs/event_inode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 09ab93357957..4d2da7480e5f 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -264,8 +264,9 @@ create_file_dentry(struct eventfs_inode *ei, struct dentry **e_dentry,
>  		 * Note, with the mutex held, the e_dentry cannot have content
>  		 * and the ei->is_freed be true at the same time.
>  		 */
> -		WARN_ON_ONCE(ei->is_freed);
>  		dentry = *e_dentry;
> +		if (WARN_ON_ONCE(dentry && ei->is_freed))
> +			dentry = NULL;
>  		/* The lookup does not need to up the dentry refcount */
>  		if (dentry && !lookup)
>  			dget(dentry);
> -- 
> 2.42.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
