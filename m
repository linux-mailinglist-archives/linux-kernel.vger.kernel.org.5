Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B35D7F0B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 05:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjKTE5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 23:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTE5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 23:57:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4FAD3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 20:57:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05502C433C7;
        Mon, 20 Nov 2023 04:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700456266;
        bh=D8GkFkadiMvyfeHxVlRTuBngO0W+nbZFP1V6zF4gWgY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ap4gfEVJl+R+eIh1mutUrAjpACp5P0jiwpxn/rx78T/sultv9oQKN/7Da6gpCcusv
         037av/hc14u38aufL6LrpScArXelj8mceylftyLmIlYfBu9bD1y9OHR6TnG320DooP
         dFOZrgzVGRmYh6/j4UCu2mgfyElARiKd9UvsnL8bP/rWoiogK5tSngLLZ8hg8iiQ1t
         V+ygjmbszOjGa+qvtEEgtT0yec1c5TNAYr6H9jF0lSBj+UpheeqtLEKMTsxnEO41jG
         9Cj6UpuJVeoFqa5HQpp8kyr0G7GOEDKMUa2EFhwkEYto150rFFDFSgFqWbxAjKOg8n
         SuxGIQYEf86FA==
Date:   Mon, 20 Nov 2023 13:57:42 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Yuran Pereira <yuran.pereira@hotmail.com>
Cc:     linux-trace-kernel@vger.kernel.org, mark.rutland@arm.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] ftrace: Replaces simple_strtoul in ftrace
Message-Id: <20231120135742.0abfc6bb7ccdd985990c68a4@kernel.org>
In-Reply-To: <GV1PR10MB656333529A8D7B8AFB28D238E8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
References: <GV1PR10MB656333529A8D7B8AFB28D238E8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 05:46:13 +0530
Yuran Pereira <yuran.pereira@hotmail.com> wrote:

> The function simple_strtoul performs no error checking in scenarios
> where the input value overflows the intended output variable.
> This results in this function successfully returning, even when the
> output does not match the input string (aka the function returns
> successfully even when the result is wrong).
> 
> Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
> simple_strtoul(), and simple_strtoull() functions explicitly ignore
> overflows, which may lead to unexpected results in callers."
> Hence, the use of those functions is discouraged.
> 
> This patch replaces all uses of the simple_strtoul with the safer
> alternatives kstrtoul and kstruint.
> 
> Callers affected:
> - add_rec_by_index
> - set_graph_max_depth_function
> 
> Side effects of this patch:
> - Since `fgraph_max_depth` is an `unsigned int`, this patch uses
>   kstrtouint instead of kstrtoul to avoid any compiler warnings
>   that could originate from calling the latter.
> - This patch ensures that the callers of kstrtou* return accordingly
>   when kstrtoul and kstruint fail for some reason.
>   In this case, both callers this patch is addressing return 0 on error.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull
> 

This looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> ---
>  kernel/trace/ftrace.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 8de8bec5f366..70217ee97322 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -4233,12 +4233,12 @@ static int
>  add_rec_by_index(struct ftrace_hash *hash, struct ftrace_glob *func_g,
>  		 int clear_filter)
>  {
> -	long index = simple_strtoul(func_g->search, NULL, 0);
> +	long index;
>  	struct ftrace_page *pg;
>  	struct dyn_ftrace *rec;
>  
>  	/* The index starts at 1 */
> -	if (--index < 0)
> +	if (kstrtoul(func_g->search, 0, &index) || --index < 0)
>  		return 0;
>  
>  	do_for_each_ftrace_rec(pg, rec) {
> @@ -5810,9 +5810,8 @@ __setup("ftrace_graph_notrace=", set_graph_notrace_function);
>  
>  static int __init set_graph_max_depth_function(char *str)
>  {
> -	if (!str)
> +	if (!str || kstrtouint(str, 0, &fgraph_max_depth))
>  		return 0;
> -	fgraph_max_depth = simple_strtoul(str, NULL, 0);
>  	return 1;
>  }
>  __setup("ftrace_graph_max_depth=", set_graph_max_depth_function);
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
