Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550D27DE153
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343713AbjKAMuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 08:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjKAMuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 08:50:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110D0DC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 05:50:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6162C433C8;
        Wed,  1 Nov 2023 12:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698843010;
        bh=KhyivPo3cZxjT4zLT/eDsI1KcZ5W1n5vn+8zmeHVfWI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J70F5BAgpv4f+Y9mU2Qo0SkBSdikAQ2GHS8SeGh5npe9gWlISdT2A/VW0beP9uJqC
         3prlSq68ZOLFc+b4QXdkbqKghZdBS5rAFjV+lghnb9/oc3hfimetySiAqq5fiVSTwR
         WVQtnmIvgAJIWAEwu/+qY9TzGXkABk9TwPvvfq/fq2BJ5zkAGuRpZQLCFcnvBpmcVS
         3Ij4HoTz8C0C2UDuD2ZClZPoAqUxsiSWluwJaXsIW0lqlmvXoDGMnmTR7U4cchJ/sY
         nTNqmml0lWXIPWEmv7a+2rjUyxdk91pjqiKj08YhZGDQRokLCywABWNP2NCH79Jgll
         RB+ZX0v68K43Q==
Date:   Wed, 1 Nov 2023 21:50:05 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 2/7] eventfs: Have a free_ei() that just frees the
 eventfs_inode
Message-Id: <20231101215005.9f38dc62e03d164501c6095c@kernel.org>
In-Reply-To: <20231031223420.141626438@goodmis.org>
References: <20231031223326.794680978@goodmis.org>
        <20231031223420.141626438@goodmis.org>
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

On Tue, 31 Oct 2023 18:33:28 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> As the eventfs_inode is freed in two different locations, make a helper
> function free_ei() to make sure all the allocated fields of the
> eventfs_inode is freed.
> 
> This requires renaming the existing free_ei() which is called by the srcu
> handler to free_rcu_ei() and have free_ei() just do the freeing, where
> free_rcu_ei() will call it.

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changse since v4: https://lore.kernel.org/all/20231031193428.133533311@goodmis.org/T/#u
> 
> - Rebased to this patch series
> 
>  fs/tracefs/event_inode.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 2c2c75b2ad73..0331d9bd568b 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -129,6 +129,13 @@ static struct dentry *create_dir(const char *name, struct dentry *parent)
>  	return eventfs_end_creating(dentry);
>  }
>  
> +static void free_ei(struct eventfs_inode *ei)
> +{
> +	kfree_const(ei->name);
> +	kfree(ei->d_children);
> +	kfree(ei);
> +}
> +
>  /**
>   * eventfs_set_ei_status_free - remove the dentry reference from an eventfs_inode
>   * @ti: the tracefs_inode of the dentry
> @@ -168,9 +175,7 @@ void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
>  			eventfs_remove_dir(ei_child);
>  		}
>  
> -		kfree_const(ei->name);
> -		kfree(ei->d_children);
> -		kfree(ei);
> +		free_ei(ei);
>  		return;
>  	}
>  
> @@ -784,13 +789,11 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
>  	return ERR_PTR(-ENOMEM);
>  }
>  
> -static void free_ei(struct rcu_head *head)
> +static void free_rcu_ei(struct rcu_head *head)
>  {
>  	struct eventfs_inode *ei = container_of(head, struct eventfs_inode, rcu);
>  
> -	kfree_const(ei->name);
> -	kfree(ei->d_children);
> -	kfree(ei);
> +	free_ei(ei);
>  }
>  
>  /**
> @@ -883,7 +886,7 @@ void eventfs_remove_dir(struct eventfs_inode *ei)
>  		for (i = 0; i < ei->nr_entries; i++)
>  			unhook_dentry(&ei->d_children[i], &dentry_list);
>  		unhook_dentry(&ei->dentry, &dentry_list);
> -		call_srcu(&eventfs_srcu, &ei->rcu, free_ei);
> +		call_srcu(&eventfs_srcu, &ei->rcu, free_rcu_ei);
>  	}
>  	mutex_unlock(&eventfs_mutex);
>  
> -- 
> 2.42.0


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
