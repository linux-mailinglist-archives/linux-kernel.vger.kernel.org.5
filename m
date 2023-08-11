Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFA4779387
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbjHKPwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjHKPw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:52:28 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 904392123;
        Fri, 11 Aug 2023 08:52:27 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id EEFB420FD0DE;
        Fri, 11 Aug 2023 08:52:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EEFB420FD0DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691769147;
        bh=7lg6MAc3Fzg+9ht1AuqtVa7Ty+/W/6SyS65Q52iCnxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dmEAtNJDyslyhDo/Ai1fEsLMsB6TD+gjwLXFlW6bJHEQiLG2N6aCbGCnBhDbXZ7Q7
         98r8Cx66Hyz1paqN0rDp435Sob6fLfqXxt24dYicsswDsLw+vyRvTKasWnhA80NH5y
         MwtKknTVFMtmy99o50qF+8IAhnQ57aJIWs97RDJs=
Date:   Fri, 11 Aug 2023 08:52:19 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Eric Vaughn <ervaughn@linux.microsoft.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/user_events: Optimize safe list traversals
Message-ID: <20230811155219.GA1220@W11-BEAU-MD.localdomain>
References: <20230810194337.695983-1-ervaughn@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810194337.695983-1-ervaughn@linux.microsoft.com>
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:43:37PM -0700, Eric Vaughn wrote:
> Several of the list traversals in the user_events facility use safe list
> traversals where they could be using the unsafe versions instead.
> 
> Replace these safe traversals with their unsafe counterparts in the
> interest of optimization.
> 
> Suggested-by: Beau Belgrave <beaub@linux.microsoft.com>
> Signed-off-by: Eric Vaughn <ervaughn@linux.microsoft.com>
> ---

Thanks for doing this, it looks good to me.

Acked-by: Beau Belgrave <beaub@linux.microsoft.com>

Thanks,
-Beau

>  kernel/trace/trace_events_user.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 33cb6af31f39..6f046650e527 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1328,14 +1328,14 @@ static int user_field_set_string(struct ftrace_event_field *field,
>  
>  static int user_event_set_print_fmt(struct user_event *user, char *buf, int len)
>  {
> -	struct ftrace_event_field *field, *next;
> +	struct ftrace_event_field *field;
>  	struct list_head *head = &user->fields;
>  	int pos = 0, depth = 0;
>  	const char *str_func;
>  
>  	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
>  
> -	list_for_each_entry_safe_reverse(field, next, head, link) {
> +	list_for_each_entry_reverse(field, head, link) {
>  		if (depth != 0)
>  			pos += snprintf(buf + pos, LEN_OR_ZERO, " ");
>  
> @@ -1347,7 +1347,7 @@ static int user_event_set_print_fmt(struct user_event *user, char *buf, int len)
>  
>  	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
>  
> -	list_for_each_entry_safe_reverse(field, next, head, link) {
> +	list_for_each_entry_reverse(field, head, link) {
>  		if (user_field_is_dyn_string(field->type, &str_func))
>  			pos += snprintf(buf + pos, LEN_OR_ZERO,
>  					", %s(%s)", str_func, field->name);
> @@ -1732,7 +1732,7 @@ static int user_event_create(const char *raw_command)
>  static int user_event_show(struct seq_file *m, struct dyn_event *ev)
>  {
>  	struct user_event *user = container_of(ev, struct user_event, devent);
> -	struct ftrace_event_field *field, *next;
> +	struct ftrace_event_field *field;
>  	struct list_head *head;
>  	int depth = 0;
>  
> @@ -1740,7 +1740,7 @@ static int user_event_show(struct seq_file *m, struct dyn_event *ev)
>  
>  	head = trace_get_fields(&user->call);
>  
> -	list_for_each_entry_safe_reverse(field, next, head, link) {
> +	list_for_each_entry_reverse(field, head, link) {
>  		if (depth == 0)
>  			seq_puts(m, " ");
>  		else
> @@ -1816,13 +1816,14 @@ static bool user_field_match(struct ftrace_event_field *field, int argc,
>  static bool user_fields_match(struct user_event *user, int argc,
>  			      const char **argv)
>  {
> -	struct ftrace_event_field *field, *next;
> +	struct ftrace_event_field *field;
>  	struct list_head *head = &user->fields;
>  	int i = 0;
>  
> -	list_for_each_entry_safe_reverse(field, next, head, link)
> +	list_for_each_entry_reverse(field, head, link) {
>  		if (!user_field_match(field, argc, argv, &i))
>  			return false;
> +	}
>  
>  	if (i != argc)
>  		return false;
> -- 
> 2.34.1
