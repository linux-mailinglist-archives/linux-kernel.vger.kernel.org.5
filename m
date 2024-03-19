Return-Path: <linux-kernel+bounces-107612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D7187FF22
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564AC1F22804
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD94E81732;
	Tue, 19 Mar 2024 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWPNg9A4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D817C2E400;
	Tue, 19 Mar 2024 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710856507; cv=none; b=MeiqPEv1fL+Rrg1cHBxyhkGZ1lXXcpT2E72mfpfp5Tnrd8xXqB8B+6o0V4Sd3Dc2P0ay47oLMoOI/YvBPD9tC8uPeX3YinA9bXgaavfrg7Ef3zWzA4hpA5RZ0g5fNMMrBtDEzs0ZRm2vxjY6ZM7OhR8Eq6png805fLfnIFqacaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710856507; c=relaxed/simple;
	bh=qziAJaseZHHgfgm21J4PRkLv2UKbDlCmE6GZg/0BK1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUAg5awQq1rmG+UKpgrUdmq6gvfSB9Z84mdjMFY4Dh79WiY5+bTonGOKcwyyGVDEt/XTXpPk+jYC6LyxIDs39BkSkb19eAIyLPq+8sfHhoiP4O3q6gIltNaOaGu2mofGsSLg9l1DXxnA0/QbcV+2BTbh8r7rvJl2M3T3PmAuWFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWPNg9A4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7C8C433F1;
	Tue, 19 Mar 2024 13:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710856506;
	bh=qziAJaseZHHgfgm21J4PRkLv2UKbDlCmE6GZg/0BK1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tWPNg9A4HBB2oCD+wGaOqNo/cah8AyDCWs7/bizzcEvjo7Svh5mbHNPlwSPDi80QA
	 plo8ZeKf8IneRTw5cYArX/uf+Uxg4oHz+Q/dGx14ExBKx9KdIb0GD+DNPx1HHuoqx7
	 2uyFMbgPk0E0a4KU1mZ39f2gBH+/r1ZdtTRm/N7LcEg7YCocUI9sLKAPWt0iKkMK0P
	 coms6jRpXWdfFc6c2D8rdeRsaBi67abiytuKECq7vj7I/2V3SgBKKTPW/HPWv+Ojew
	 +OLFC4Juar6rwkJmO0jlGRep6V4Tyyeda3X3L+dhHJoYs/qW7Ce1OH8yDMRAiBhRky
	 X3KOkrho0+mNQ==
Date: Tue, 19 Mar 2024 10:55:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH 03/23] perf dwarf-aux: Handle type transfer for memory
 access
Message-ID: <ZfmZNp1DaKYZCwyf@x1>
References: <20240319055115.4063940-1-namhyung@kernel.org>
 <20240319055115.4063940-4-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319055115.4063940-4-namhyung@kernel.org>

On Mon, Mar 18, 2024 at 10:50:55PM -0700, Namhyung Kim wrote:
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
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/dwarf-aux.c | 110 ++++++++++++++++++++++++++++++++++++
>  tools/perf/util/dwarf-aux.h |   6 ++
>  2 files changed, 116 insertions(+)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 785aa7a3d725..cd9364d296b6 100644
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

Don't we have to check that the type_die was initialized? From what I
can see there is the possibility it isn't:

  Dwarf_Die type_die;
  die_get_real_type(die_mem, &type_die);
        do {
                vr_die = __die_get_real_type(vr_die, die_mem);
        } while (vr_die && dwarf_tag(vr_die) == DW_TAG_typedef);
        
        return vr_die;

    static Dwarf_Die *__die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)

        do {
                vr_die = die_get_type(vr_die, die_mem);
                if (!vr_die)
                        break;

   Dwarf_Die *die_get_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)

        Dwarf_Attribute attr;

        if (dwarf_attr_integrate(vr_die, DW_AT_type, &attr) &&
            dwarf_formref_die(&attr, die_mem))
                return die_mem;
        else
                return NULL;
  } 

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
> index cd171b06fd4c..16c916311bc0 100644
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
> 2.44.0.291.gc1ea87d7ee-goog

