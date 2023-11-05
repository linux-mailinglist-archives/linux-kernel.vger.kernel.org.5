Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206697E12B4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 10:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjKEJHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 04:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKEJHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 04:07:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86EDAF;
        Sun,  5 Nov 2023 01:07:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B99C433C8;
        Sun,  5 Nov 2023 09:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699175258;
        bh=P6acD7fe6sUvxQpsIbl2pBAajV8Y/96IVULs2XzB798=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pWcDNKSIJm+Jp/3CiV3ydk1cbdd37eY9fdUsN5Q8/QpEULbtdbqPHCXy9Ndme+Zvy
         e6bNMkqaX5jDbeN8amUNQWGBGK5qfu84YymrFHMVFyebouZUlBOZTKWwUCJpfrfEPd
         dy316GXqm+3EmE6XBanDsRFbW227fUXnirrQiuWR6MmXR+IXUlXmnvc8hnaW0N0nVN
         ZZnZyZFaWJuG6zECHRZ6NHg3MC9d/w/5YSwE6F3sKiyaB2DF70jAEma7jmOfEHhrme
         /7gDpPB2AeAtdBP2JFSFS8FIMaWeA4R9NbFrugDQ4UBRl4OToMI9NdudpAvhUJnI0+
         LRo4GFN0FlIKw==
Date:   Sun, 5 Nov 2023 18:07:32 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH 08/48] perf dwarf-aux: Factor out __die_get_typename()
Message-Id: <20231105180732.f3483276b09360267e6d6fbb@kernel.org>
In-Reply-To: <20231012035111.676789-9-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
        <20231012035111.676789-9-namhyung@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 20:50:31 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> The __die_get_typename() is to get the name of the given DIE in C-style
> type name.  The difference from the die_get_typename() is that it does
> not retrieve the DW_AT_type and use the given DIE directly.  This will
> be used when users know the type DIE already.

Hmm, I would rather like to have another name for this function.
What about 'die_get_typename_from_type()' ?

> 
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/dwarf-aux.c | 38 ++++++++++++++++++++++++++-----------
>  tools/perf/util/dwarf-aux.h |  3 +++
>  2 files changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 652e6e7368a2..5bb05c84d249 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1051,32 +1051,28 @@ Dwarf_Die *die_find_member(Dwarf_Die *st_die, const char *name,
>  }
>  
>  /**
> - * die_get_typename - Get the name of given variable DIE
> - * @vr_die: a variable DIE
> + * __die_get_typename - Get the name of given type DIE
> + * @type: a type DIE
>   * @buf: a strbuf for result type name
>   *
> - * Get the name of @vr_die and stores it to @buf. Return 0 if succeeded.
> + * Get the name of @type_die and stores it to @buf. Return 0 if succeeded.
>   * and Return -ENOENT if failed to find type name.
>   * Note that the result will stores typedef name if possible, and stores
>   * "*(function_type)" if the type is a function pointer.
>   */
> -int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
> +int __die_get_typename(Dwarf_Die *type, struct strbuf *buf)

Could you use 'type_die' instead of 'type' if it is exposed?

Thank you,

>  {
> -	Dwarf_Die type;
>  	int tag, ret;
>  	const char *tmp = "";
>  
> -	if (__die_get_real_type(vr_die, &type) == NULL)
> -		return -ENOENT;
> -
> -	tag = dwarf_tag(&type);
> +	tag = dwarf_tag(type);
>  	if (tag == DW_TAG_array_type || tag == DW_TAG_pointer_type)
>  		tmp = "*";
>  	else if (tag == DW_TAG_subroutine_type) {
>  		/* Function pointer */
>  		return strbuf_add(buf, "(function_type)", 15);
>  	} else {
> -		const char *name = dwarf_diename(&type);
> +		const char *name = dwarf_diename(type);
>  
>  		if (tag == DW_TAG_union_type)
>  			tmp = "union ";
> @@ -1089,7 +1085,7 @@ int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
>  		/* Write a base name */
>  		return strbuf_addf(buf, "%s%s", tmp, name ?: "");
>  	}
> -	ret = die_get_typename(&type, buf);
> +	ret = die_get_typename(type, buf);
>  	if (ret < 0) {
>  		/* void pointer has no type attribute */
>  		if (tag == DW_TAG_pointer_type && ret == -ENOENT)
> @@ -1100,6 +1096,26 @@ int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
>  	return strbuf_addstr(buf, tmp);
>  }
>  
> +/**
> + * die_get_typename - Get the name of given variable DIE
> + * @vr_die: a variable DIE
> + * @buf: a strbuf for result type name
> + *
> + * Get the name of @vr_die and stores it to @buf. Return 0 if succeeded.
> + * and Return -ENOENT if failed to find type name.
> + * Note that the result will stores typedef name if possible, and stores
> + * "*(function_type)" if the type is a function pointer.
> + */
> +int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
> +{
> +	Dwarf_Die type;
> +
> +	if (__die_get_real_type(vr_die, &type) == NULL)
> +		return -ENOENT;
> +
> +	return __die_get_typename(&type, buf);
> +}
> +
>  /**
>   * die_get_varname - Get the name and type of given variable DIE
>   * @vr_die: a variable DIE
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index b6f430730bd1..574405c57d3b 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -116,6 +116,9 @@ Dwarf_Die *die_find_variable_at(Dwarf_Die *sp_die, const char *name,
>  Dwarf_Die *die_find_member(Dwarf_Die *st_die, const char *name,
>  			   Dwarf_Die *die_mem);
>  
> +/* Get the name of given type DIE */
> +int __die_get_typename(Dwarf_Die *type, struct strbuf *buf);
> +
>  /* Get the name of given variable DIE */
>  int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf);
>  
> -- 
> 2.42.0.655.g421f12c284-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
