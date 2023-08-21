Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37DF782DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbjHUQHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjHUQHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:07:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17896F3;
        Mon, 21 Aug 2023 09:07:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A08AF62567;
        Mon, 21 Aug 2023 16:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58136C433C7;
        Mon, 21 Aug 2023 16:07:15 +0000 (UTC)
Date:   Mon, 21 Aug 2023 12:07:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/user_events: Fix an erroneous usage of
 struct_size()
Message-ID: <20230821120728.7b34266c@gandalf.local.home>
In-Reply-To: <7a20160628fa586a74936c9212102dbf896e7332.1692543738.git.christophe.jaillet@wanadoo.fr>
References: <7a20160628fa586a74936c9212102dbf896e7332.1692543738.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Aug 2023 17:02:42 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> If struct_size() returns a value that does not fit in a 'int', the size
> passed to kzalloc() is wrong.
> 
> Remove the intermediate 'size' variable and use struct_size() directly.
> 
> Fixes: 7f5a08c79df3 ("user_events: Add minimal support for trace_event into ftrace")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> I don't know if 'size' can get bigger than a int in the real world, but the
> change looks safe in any cases.
> 
> On x86_64, looking at the .s files, the previous code had an extra:
>     movslq	%r13d, %r13
> which really looks wrong to me.

If size is bigger than int, then we have much bigger problems than this allocation.

That means count is over 2 billion, and the kzalloc() will fail regardless.

This is an unneeded change.

-- Steve


> ---
>  kernel/trace/trace_events_user.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 33cb6af31f39..67cc71a872b0 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -2153,7 +2153,7 @@ static int user_events_ref_add(struct user_event_file_info *info,
>  {
>  	struct user_event_group *group = info->group;
>  	struct user_event_refs *refs, *new_refs;
> -	int i, size, count = 0;
> +	int i, count = 0;
>  
>  	refs = rcu_dereference_protected(info->refs,
>  					 lockdep_is_held(&group->reg_mutex));
> @@ -2166,10 +2166,8 @@ static int user_events_ref_add(struct user_event_file_info *info,
>  				return i;
>  	}
>  
> -	size = struct_size(refs, events, count + 1);
> -
> -	new_refs = kzalloc(size, GFP_KERNEL_ACCOUNT);
> -
> +	new_refs = kzalloc(struct_size(refs, events, count + 1),
> +			   GFP_KERNEL_ACCOUNT);
>  	if (!new_refs)
>  		return -ENOMEM;
>  

