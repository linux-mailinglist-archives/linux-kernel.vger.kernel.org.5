Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F787E549C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344389AbjKHK5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344527AbjKHK5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:57:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E3119B3;
        Wed,  8 Nov 2023 02:57:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94986C433C8;
        Wed,  8 Nov 2023 10:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699441039;
        bh=bBfDtun/yig5gpao6MlDL0MdQfODZaj79tb/Ng2zcrY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NLbDPV0Ky8LzRtPakVUO7Cv8Wi3j9VnFF84uCAxizTtfl1XUeAPVVoFvr7IicLrNR
         rtvDMubsOP1PjsGIu/vTFJWqe+Xcy4f1v935tdqsL0mcfEU0MUXI6wlTzYWtYyaETp
         bVx/O8jSRYBVdk96z2Xa8ScXpsnlOIAi/76W3l78d8DIj9HD9d3nZQwDdAqQNn5duI
         Fnl8Ks+cimy5jNHY1vz6SHUpTkIuiQnLP437vad9w1nilUXlV6kFTj9M77+rc3tyqg
         yM4hLgRl0j6fI1dPNyIALHiNf0yFG6sKASltx+jY8fwnPcRn8IvpTifJ4MK09sj/W0
         wnymegX3uuc1g==
Date:   Wed, 8 Nov 2023 19:57:12 +0900
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
Subject: Re: [PATCH 35/48] perf dwarf-aux: Handle type transfer for memory
 access
Message-Id: <20231108195712.efc2b701bdec85de386e1e55@kernel.org>
In-Reply-To: <20231012035111.676789-36-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
        <20231012035111.676789-36-namhyung@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 20:50:58 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> We want to track type states as instructions are executed.  Each
> instruction can access compound types like struct or union and load/
> store its members to a different location.
> 
> The die_deref_ptr_type() is to find a type of memory access with a
> pointer variable.  If it points to a compound type like struct, the
> target memory is a member in the struct.  The access will happen
> with an offset indicating which member it refers.  Let's follow the
> DWARF info to figure out the type of the pointer target.
> 
> For example, say we have the following code.
> 
>   struct foo {
>     int a;
>     int b;
>   };
> 
>   struct foo *p = malloc(sizeof(*p));
>   p->b = 0;
> 
> The last pointer access should produce x86 asm like below:
> 
>   mov  0x0, 4(%rbx)
> 
> And we know %rbx register has a pointer to struct foo.  Then offset 4
> should return the debug info of member 'b'.
> 
> Also variables of compound types can be accessed directly without a
> pointer.  The die_get_member_type() is to handle a such case.

Looks good to me. perf probe search the member by name, but these
APIs searches it by offset.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/dwarf-aux.c | 110 ++++++++++++++++++++++++++++++++++++
>  tools/perf/util/dwarf-aux.h |   6 ++
>  2 files changed, 116 insertions(+)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 16e63d8caf83..5ec895e0a069 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1838,3 +1838,113 @@ int die_get_scopes(Dwarf_Die *cu_die, Dwarf_Addr pc, Dwarf_Die **scopes)
>  	*scopes = data.scopes;
>  	return data.nr;
>  }
> +
> +static int __die_find_member_offset_cb(Dwarf_Die *die_mem, void *arg)
> +{
> +	Dwarf_Die type_die;
> +	Dwarf_Word size, loc;
> +	Dwarf_Word offset = (long)arg;
> +	int tag = dwarf_tag(die_mem);
> +
> +	if (tag != DW_TAG_member)
> +		return DIE_FIND_CB_SIBLING;
> +
> +	/* Unions might not have location */
> +	if (die_get_data_member_location(die_mem, &loc) < 0)
> +		loc = 0;
> +
> +	if (offset == loc)
> +		return DIE_FIND_CB_END;
> +
> +	die_get_real_type(die_mem, &type_die);
> +
> +	if (dwarf_aggregate_size(&type_die, &size) < 0)
> +		size = 0;
> +
> +	if (loc < offset && offset < (loc + size))
> +		return DIE_FIND_CB_END;
> +
> +	return DIE_FIND_CB_SIBLING;
> +}
> +
> +/**
> + * die_get_member_type - Return type info of struct member
> + * @type_die: a type DIE
> + * @offset: offset in the type
> + * @die_mem: a buffer to save the resulting DIE
> + *
> + * This function returns a type of a member in @type_die where it's located at
> + * @offset if it's a struct.  For now, it just returns the first matching
> + * member in a union.  For other types, it'd return the given type directly
> + * if it's within the size of the type or NULL otherwise.
> + */
> +Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
> +			       Dwarf_Die *die_mem)
> +{
> +	Dwarf_Die *member;
> +	Dwarf_Die mb_type;
> +	int tag;
> +
> +	tag = dwarf_tag(type_die);
> +	/* If it's not a compound type, return the type directly */
> +	if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type) {
> +		Dwarf_Word size;
> +
> +		if (dwarf_aggregate_size(type_die, &size) < 0)
> +			size = 0;
> +
> +		if ((unsigned)offset >= size)
> +			return NULL;
> +
> +		*die_mem = *type_die;
> +		return die_mem;
> +	}
> +
> +	mb_type = *type_die;
> +	/* TODO: Handle union types better? */
> +	while (tag == DW_TAG_structure_type || tag == DW_TAG_union_type) {
> +		member = die_find_child(&mb_type, __die_find_member_offset_cb,
> +					(void *)(long)offset, die_mem);
> +		if (member == NULL)
> +			return NULL;
> +
> +		if (die_get_real_type(member, &mb_type) == NULL)
> +			return NULL;
> +
> +		tag = dwarf_tag(&mb_type);
> +
> +		if (tag == DW_TAG_structure_type || tag == DW_TAG_union_type) {
> +			Dwarf_Word loc;
> +
> +			/* Update offset for the start of the member struct */
> +			if (die_get_data_member_location(member, &loc) == 0)
> +				offset -= loc;
> +		}
> +	}
> +	*die_mem = mb_type;
> +	return die_mem;
> +}
> +
> +/**
> + * die_deref_ptr_type - Return type info for pointer access
> + * @ptr_die: a pointer type DIE
> + * @offset: access offset for the pointer
> + * @die_mem: a buffer to save the resulting DIE
> + *
> + * This function follows the pointer in @ptr_die with given @offset
> + * and saves the resulting type in @die_mem.  If the pointer points
> + * a struct type, actual member at the offset would be returned.
> + */
> +Dwarf_Die *die_deref_ptr_type(Dwarf_Die *ptr_die, int offset,
> +			      Dwarf_Die *die_mem)
> +{
> +	Dwarf_Die type_die;
> +
> +	if (dwarf_tag(ptr_die) != DW_TAG_pointer_type)
> +		return NULL;
> +
> +	if (die_get_real_type(ptr_die, &type_die) == NULL)
> +		return NULL;
> +
> +	return die_get_member_type(&type_die, offset, die_mem);
> +}
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index d0ef41738abd..df846bd30134 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -144,6 +144,12 @@ struct die_var_type {
>  	int offset;
>  };
>  
> +/* Return type info of a member at offset */
> +Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset, Dwarf_Die *die_mem);
> +
> +/* Return type info where the pointer and offset point to */
> +Dwarf_Die *die_deref_ptr_type(Dwarf_Die *ptr_die, int offset, Dwarf_Die *die_mem);
> +
>  #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
>  
>  /* Get byte offset range of given variable DIE */
> -- 
> 2.42.0.655.g421f12c284-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
