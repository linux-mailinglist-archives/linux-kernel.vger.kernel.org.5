Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7287599A0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjGSPZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjGSPZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:25:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D22526A5;
        Wed, 19 Jul 2023 08:24:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3894061761;
        Wed, 19 Jul 2023 15:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60941C433C9;
        Wed, 19 Jul 2023 15:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689780291;
        bh=TglNMz0f8swaTJc60t0XLOJgKWaOgNbTdxFSiSOa6vk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EafWMN+ZTzB0x2RXgz4HsKnHdsY4ZZaPnxO9UHo4VO4g5mR2IlDnJsOd7JEJBrdep
         SKAH+7igFyYhb5j+h38+SsqT1Wi9I7LCC4FB5JKY7akFflRIm2PXIyDY5wW1NKCsoO
         yw7f5/FrkBbGWXtPnZL2UuJGdcZuK84WySmgB8Z6txleL4rTgNk7GPMiIOnQXrXCVo
         ri9ht9RuAO7YwL4Id1hyW7bSyC23SIprzTCHSm+KdlegGDXDb02m5YMuGMrhYD1oPb
         tWj5o8RBd/eNvx0T2EXwfbJLxOM2QOVlCQ/T2opKjSx+ZXIzLvrD4BSQCrNyH6hf1D
         xcfWbNr3dJX/A==
Date:   Thu, 20 Jul 2023 00:24:46 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v2 2/9] bpf/btf: tracing: Move finding func-proto API
 and getting func-param API to BTF
Message-Id: <20230720002446.83aa066ea37af9482751ee8d@kernel.org>
In-Reply-To: <13926373-1beb-16f4-180e-f529a8c9b0a7@oracle.com>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
        <168960741686.34107.6330273416064011062.stgit@devnote2>
        <13926373-1beb-16f4-180e-f529a8c9b0a7@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 13:36:48 +0100
Alan Maguire <alan.maguire@oracle.com> wrote:

> On 17/07/2023 16:23, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Move generic function-proto find API and getting function parameter API
> > to BTF library code from trace_probe.c. This will avoid redundant efforts
> > on different feature.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  include/linux/btf.h        |    4 ++++
> >  kernel/bpf/btf.c           |   45 ++++++++++++++++++++++++++++++++++++++++
> >  kernel/trace/trace_probe.c |   50 +++++++++++++-------------------------------
> >  3 files changed, 64 insertions(+), 35 deletions(-)
> > 
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index cac9f304e27a..98fbbcdd72ec 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -221,6 +221,10 @@ const struct btf_type *
> >  btf_resolve_size(const struct btf *btf, const struct btf_type *type,
> >  		 u32 *type_size);
> >  const char *btf_type_str(const struct btf_type *t);
> > +const struct btf_type *btf_find_func_proto(struct btf *btf,
> > +					   const char *func_name);
> > +const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
> > +					   s32 *nr);
> >  
> >  #define for_each_member(i, struct_type, member)			\
> >  	for (i = 0, member = btf_type_member(struct_type);	\
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 817204d53372..e015b52956cb 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -1947,6 +1947,51 @@ btf_resolve_size(const struct btf *btf, const struct btf_type *type,
> >  	return __btf_resolve_size(btf, type, type_size, NULL, NULL, NULL, NULL);
> >  }
> >  
> > +/*
> > + * Find a functio proto type by name, and return it.
> > + * Return NULL if not found, or return -EINVAL if parameter is invalid.
> > + */
> > +const struct btf_type *btf_find_func_proto(struct btf *btf, const char *func_name)
> > +{
> > +	const struct btf_type *t;
> > +	s32 id;
> > +
> > +	if (!btf || !func_name)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	id = btf_find_by_name_kind(btf, func_name, BTF_KIND_FUNC);
> 
> as mentioned in my other mail, there are cases where the function name
> may have a .isra.0 suffix, but the BTF representation will not. I looked
> at this and it seems like symbol names are validated via
> traceprobe_parse_event_name() - will this validation allow a "."-suffix
> name? I tried the following (with pahole v1.25 that emits BTF for
> schedule_work.isra.0):
> 
> [45454] FUNC 'schedule_work' type_id=45453 linkage=static

That's a good point! I'm checking fprobe, but kprobes actually
uses those suffixed names.

> 
> $ echo 'f schedule_work.isra.0 $arg*' >> dynamic_events
> bash: echo: write error: No such file or directory

So maybe fprobe doesn't accept that.

> So presuming that such "."-suffixed names are allowed, would it make
> sense to fall back to search BTF for the prefix ("schedule_work")
> instead of the full name ("schedule_work.isra.0"), as the former is what
> makes it into the BTF representation? Thanks!

OK, that's not a problem. My concern is that some "constprop" functions
will replace a part of parameter with constant value (so it can skip
passing some arguments). BTF argument may not work in such case.
Let me check it.

Thank you,

> 
> Alan
> 
> > +	if (id <= 0)
> > +		return NULL;
> > +
> > +	/* Get BTF_KIND_FUNC type */
> > +	t = btf_type_by_id(btf, id);
> > +	if (!t || !btf_type_is_func(t))
> > +		return NULL;
> > +
> > +	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
> > +	t = btf_type_by_id(btf, t->type);
> > +	if (!t || !btf_type_is_func_proto(t))
> > +		return NULL;
> > +
> > +	return t;
> > +}
> > +
> > +/*
> > + * Get function parameter with the number of parameters.
> > + * This can return NULL if the function has no parameters.
> > + */
> > +const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s32 *nr)
> > +{
> > +	if (!func_proto || !nr)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	*nr = btf_type_vlen(func_proto);
> > +	if (*nr > 0)
> > +		return (const struct btf_param *)(func_proto + 1);
> > +	else
> > +		return NULL;
> > +}
> > +
> >  static u32 btf_resolved_type_id(const struct btf *btf, u32 type_id)
> >  {
> >  	while (type_id < btf->start_id)
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index c68a72707852..cd89fc1ebb42 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -371,47 +371,23 @@ static const char *type_from_btf_id(struct btf *btf, s32 id)
> >  	return NULL;
> >  }
> >  
> > -static const struct btf_type *find_btf_func_proto(const char *funcname)
> > -{
> > -	struct btf *btf = traceprobe_get_btf();
> > -	const struct btf_type *t;
> > -	s32 id;
> > -
> > -	if (!btf || !funcname)
> > -		return ERR_PTR(-EINVAL);
> > -
> > -	id = btf_find_by_name_kind(btf, funcname, BTF_KIND_FUNC);
> > -	if (id <= 0)
> > -		return ERR_PTR(-ENOENT);
> > -
> > -	/* Get BTF_KIND_FUNC type */
> > -	t = btf_type_by_id(btf, id);
> > -	if (!t || !btf_type_is_func(t))
> > -		return ERR_PTR(-ENOENT);
> > -
> > -	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
> > -	t = btf_type_by_id(btf, t->type);
> > -	if (!t || !btf_type_is_func_proto(t))
> > -		return ERR_PTR(-ENOENT);
> > -
> > -	return t;
> > -}
> > -
> >  static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
> >  						   bool tracepoint)
> >  {
> > +	struct btf *btf = traceprobe_get_btf();
> >  	const struct btf_param *param;
> >  	const struct btf_type *t;
> >  
> > -	if (!funcname || !nr)
> > +	if (!funcname || !nr || !btf)
> >  		return ERR_PTR(-EINVAL);
> >  
> > -	t = find_btf_func_proto(funcname);
> > -	if (IS_ERR(t))
> > +	t = btf_find_func_proto(btf, funcname);
> > +	if (IS_ERR_OR_NULL(t))
> >  		return (const struct btf_param *)t;
> >  
> > -	*nr = btf_type_vlen(t);
> > -	param = (const struct btf_param *)(t + 1);
> > +	param = btf_get_func_param(t, nr);
> > +	if (IS_ERR_OR_NULL(param))
> > +		return param;
> >  
> >  	/* Hide the first 'data' argument of tracepoint */
> >  	if (tracepoint) {
> > @@ -490,8 +466,8 @@ static const struct fetch_type *parse_btf_retval_type(
> >  	const struct btf_type *t;
> >  
> >  	if (btf && ctx->funcname) {
> > -		t = find_btf_func_proto(ctx->funcname);
> > -		if (!IS_ERR(t))
> > +		t = btf_find_func_proto(btf, ctx->funcname);
> > +		if (!IS_ERR_OR_NULL(t))
> >  			typestr = type_from_btf_id(btf, t->type);
> >  	}
> >  
> > @@ -500,10 +476,14 @@ static const struct fetch_type *parse_btf_retval_type(
> >  
> >  static bool is_btf_retval_void(const char *funcname)
> >  {
> > +	struct btf *btf = traceprobe_get_btf();
> >  	const struct btf_type *t;
> >  
> > -	t = find_btf_func_proto(funcname);
> > -	if (IS_ERR(t))
> > +	if (!btf)
> > +		return false;
> > +
> > +	t = btf_find_func_proto(btf, funcname);
> > +	if (IS_ERR_OR_NULL(t))
> >  		return false;
> >  
> >  	return t->type == 0;
> > 
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
