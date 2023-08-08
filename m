Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CF0774230
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjHHRg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjHHRfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:35:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8861B4207
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:15:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67A2462490
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AADC433C7;
        Tue,  8 Aug 2023 10:14:25 +0000 (UTC)
Date:   Tue, 8 Aug 2023 06:14:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>
Subject: Re: BUG: KASAN: slab-out-of-bounds in print_synth_event+0xa68/0xa78
Message-ID: <20230808061423.0a12980f@gandalf.local.home>
In-Reply-To: <yt9da5v1rhqd.fsf@linux.ibm.com>
References: <yt9dsf8zfhw8.fsf@linux.ibm.com>
        <20230807215310.068fce2f@gandalf.local.home>
        <yt9da5v1rhqd.fsf@linux.ibm.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Aug 2023 11:44:26 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> Steven Rostedt <rostedt@goodmis.org> writes:
> 
> > On Fri, 04 Aug 2023 08:20:23 +0200
> > Sven Schnelle <svens@linux.ibm.com> wrote:
> >  
> >> Hi Steven,
> >> 
> >> i noticed the following KASAN splat in CI (on s390):  
> >
> > Could this actually be a bug in KASAN?
> >
> > The reason I ask, is because of the report.  
> 
> I think the problem is that the code assigns data_offset with:
> 
> *(u32 *)&entry->fields[*n_u64] = data_offset;
> 
> but reads it with:
> 
> offset = (u32)entry->fields[n_u64];
> 
> which works on LE, but not BE.

Ah, that makes sense. I didn't realize (or forgot) that s390 was BE. My
PowerPC box that was BE died years ago, and I have stopped testing BE ever
since :-(

> 
> I'm currently preparing the patch below, which also makes the code a bit
> easier to read. I'm still seeing no stack traces, but at least the
> random memory reads are gone and no KASAN warning anymore. I'll
> continue fixing and sent a full patch as soon as everything is fixed.
> 
> >From 82fc673f0d3b6031b760b4217bebdb1047119041 Mon Sep 17 00:00:00 2001  
> From: Sven Schnelle <svens@linux.ibm.com>
> Date: Tue, 8 Aug 2023 11:35:12 +0200
> Subject: [PATCH] tracing/synthetic: use union instead of casts
> 
> The current code uses a lot of casts to access the fields
> member in struct synth_trace_events with different sizes.
> This makes the code hard to read, and had already introduced
> an endianess bug. Use a union and struct instead.
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  kernel/trace/trace_events_synth.c | 100 +++++++++++++++---------------
>  1 file changed, 50 insertions(+), 50 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index d6a70aff2410..1f8fe7f2b5b2 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -125,9 +125,22 @@ static bool synth_event_match(const char *system, const char *event,
>  		(!system || strcmp(system, SYNTH_SYSTEM) == 0);
>  }
>  
> +struct synth_trace_data {
> +	u16 len;
> +	u16 offset;
> +};

This is actually common throughout the tracing code (as all dynamic fields
have this). We should probably make this more generic than just for
synthetic events. Although, that would probably break BE user space. Hmm,
we could have it be:

struct trace_dynamic {
#ifdef CONFIG_CPU_BIG_ENDIAN
	u16	offset;
	u16	len;
#else
	u16	len;
	u16	offset
#endif
};

So that we don't break user space (which still does the:

	offset = value & 0xffff;
	len = value >> 16;


The rest seems good to me for just synthetic event.

Thanks!

-- Steve

> +
> +union synth_trace_field {
> +	u8 as8;
> +	u16 as16;
> +	u32 as32;
> +	u64 as64;
> +	struct synth_trace_data as_data;
> +};
> +
>  struct synth_trace_event {
>  	struct trace_entry	ent;
> -	u64			fields[];
> +	union synth_trace_field fields[];
>  };
>  
>  static int synth_event_define_fields(struct trace_event_call *call)
> @@ -321,19 +334,19 @@ static const char *synth_field_fmt(char *type)
>  
>  static void print_synth_event_num_val(struct trace_seq *s,
>  				      char *print_fmt, char *name,
> -				      int size, u64 val, char *space)
> +				      int size, union synth_trace_field *val, char *space)
>  {
>  	switch (size) {
>  	case 1:
> -		trace_seq_printf(s, print_fmt, name, (u8)val, space);
> +		trace_seq_printf(s, print_fmt, name, val->as8, space);
>  		break;
>  
>  	case 2:
> -		trace_seq_printf(s, print_fmt, name, (u16)val, space);
> +		trace_seq_printf(s, print_fmt, name, val->as16, space);
>  		break;
>  
>  	case 4:
> -		trace_seq_printf(s, print_fmt, name, (u32)val, space);
> +		trace_seq_printf(s, print_fmt, name, val->as32, space);
>  		break;
>  
>  	default:
> @@ -374,36 +387,26 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
>  		/* parameter values */
>  		if (se->fields[i]->is_string) {
>  			if (se->fields[i]->is_dynamic) {
> -				u32 offset, data_offset;
> -				char *str_field;
> -
> -				offset = (u32)entry->fields[n_u64];
> -				data_offset = offset & 0xffff;
> -
> -				str_field = (char *)entry + data_offset;
> +				struct synth_trace_data *data = &entry->fields[n_u64].as_data;
>  
>  				trace_seq_printf(s, print_fmt, se->fields[i]->name,
>  						 STR_VAR_LEN_MAX,
> -						 str_field,
> +						 (char *)entry + data->offset,
>  						 i == se->n_fields - 1 ? "" : " ");
>  				n_u64++;
>  			} else {
>  				trace_seq_printf(s, print_fmt, se->fields[i]->name,
>  						 STR_VAR_LEN_MAX,
> -						 (char *)&entry->fields[n_u64],
> +						 (char *)&entry->fields[n_u64].as64,
>  						 i == se->n_fields - 1 ? "" : " ");
>  				n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
>  			}
>  		} else if (se->fields[i]->is_stack) {
> -			u32 offset, data_offset, len;
>  			unsigned long *p, *end;
> +			struct synth_trace_data *data = &entry->fields[n_u64].as_data;
>  
> -			offset = (u32)entry->fields[n_u64];
> -			data_offset = offset & 0xffff;
> -			len = offset >> 16;
> -
> -			p = (void *)entry + data_offset;
> -			end = (void *)p + len - (sizeof(long) - 1);
> +			p = (void *)entry + data->offset;
> +			end = (void *)p + data->len - (sizeof(long) - 1);
>  
>  			trace_seq_printf(s, "%s=STACK:\n", se->fields[i]->name);
>  
> @@ -419,13 +422,13 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
>  			print_synth_event_num_val(s, print_fmt,
>  						  se->fields[i]->name,
>  						  se->fields[i]->size,
> -						  entry->fields[n_u64],
> +						  &entry->fields[n_u64],
>  						  space);
>  
>  			if (strcmp(se->fields[i]->type, "gfp_t") == 0) {
>  				trace_seq_puts(s, " (");
>  				trace_print_flags_seq(s, "|",
> -						      entry->fields[n_u64],
> +						      entry->fields[n_u64].as64,
>  						      __flags);
>  				trace_seq_putc(s, ')');
>  			}
> @@ -454,21 +457,16 @@ static unsigned int trace_string(struct synth_trace_event *entry,
>  	int ret;
>  
>  	if (is_dynamic) {
> -		u32 data_offset;
> +		struct synth_trace_data *data = &entry->fields[*n_u64].as_data;
>  
> -		data_offset = struct_size(entry, fields, event->n_u64);
> -		data_offset += data_size;
> -
> -		len = fetch_store_strlen((unsigned long)str_val);
> -
> -		data_offset |= len << 16;
> -		*(u32 *)&entry->fields[*n_u64] = data_offset;
> +		data->offset = struct_size(entry, fields, event->n_u64) + data_size;
> +		data->len = fetch_store_strlen((unsigned long)str_val);
>  
>  		ret = fetch_store_string((unsigned long)str_val, &entry->fields[*n_u64], entry);
>  
>  		(*n_u64)++;
>  	} else {
> -		str_field = (char *)&entry->fields[*n_u64];
> +		str_field = (char *)&entry->fields[*n_u64].as64;
>  
>  #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>  		if ((unsigned long)str_val < TASK_SIZE)
> @@ -492,6 +490,7 @@ static unsigned int trace_stack(struct synth_trace_event *entry,
>  				 unsigned int data_size,
>  				 unsigned int *n_u64)
>  {
> +	struct synth_trace_data *data = &entry->fields[*n_u64].as_data;
>  	unsigned int len;
>  	u32 data_offset;
>  	void *data_loc;
> @@ -515,8 +514,9 @@ static unsigned int trace_stack(struct synth_trace_event *entry,
>  	memcpy(data_loc, stack, len);
>  
>  	/* Fill in the field that holds the offset/len combo */
> -	data_offset |= len << 16;
> -	*(u32 *)&entry->fields[*n_u64] = data_offset;
> +
> +	data->offset = data_offset;
> +	data->len = len;
>  
>  	(*n_u64)++;
>  
> @@ -592,19 +592,19 @@ static notrace void trace_event_raw_event_synth(void *__data,
>  
>  			switch (field->size) {
>  			case 1:
> -				*(u8 *)&entry->fields[n_u64] = (u8)val;
> +				entry->fields[n_u64].as8 = (u8)val;
>  				break;
>  
>  			case 2:
> -				*(u16 *)&entry->fields[n_u64] = (u16)val;
> +				entry->fields[n_u64].as16 = (u16)val;
>  				break;
>  
>  			case 4:
> -				*(u32 *)&entry->fields[n_u64] = (u32)val;
> +				entry->fields[n_u64].as32 = (u32)val;
>  				break;
>  
>  			default:
> -				entry->fields[n_u64] = val;
> +				entry->fields[n_u64].as64 = val;
>  				break;
>  			}
>  			n_u64++;
> @@ -1790,19 +1790,19 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
>  
>  			switch (field->size) {
>  			case 1:
> -				*(u8 *)&state.entry->fields[n_u64] = (u8)val;
> +				state.entry->fields[n_u64].as8 = (u8)val;
>  				break;
>  
>  			case 2:
> -				*(u16 *)&state.entry->fields[n_u64] = (u16)val;
> +				state.entry->fields[n_u64].as16 = (u16)val;
>  				break;
>  
>  			case 4:
> -				*(u32 *)&state.entry->fields[n_u64] = (u32)val;
> +				state.entry->fields[n_u64].as32 = (u32)val;
>  				break;
>  
>  			default:
> -				state.entry->fields[n_u64] = val;
> +				state.entry->fields[n_u64].as64 = val;
>  				break;
>  			}
>  			n_u64++;
> @@ -1883,19 +1883,19 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
>  
>  			switch (field->size) {
>  			case 1:
> -				*(u8 *)&state.entry->fields[n_u64] = (u8)val;
> +				state.entry->fields[n_u64].as8 = (u8)val;
>  				break;
>  
>  			case 2:
> -				*(u16 *)&state.entry->fields[n_u64] = (u16)val;
> +				state.entry->fields[n_u64].as16 = (u16)val;
>  				break;
>  
>  			case 4:
> -				*(u32 *)&state.entry->fields[n_u64] = (u32)val;
> +				state.entry->fields[n_u64].as32 = (u32)val;
>  				break;
>  
>  			default:
> -				state.entry->fields[n_u64] = val;
> +				state.entry->fields[n_u64].as64 = val;
>  				break;
>  			}
>  			n_u64++;
> @@ -2030,19 +2030,19 @@ static int __synth_event_add_val(const char *field_name, u64 val,
>  	} else {
>  		switch (field->size) {
>  		case 1:
> -			*(u8 *)&trace_state->entry->fields[field->offset] = (u8)val;
> +			trace_state->entry->fields[field->offset].as8 = (u8)val;
>  			break;
>  
>  		case 2:
> -			*(u16 *)&trace_state->entry->fields[field->offset] = (u16)val;
> +			trace_state->entry->fields[field->offset].as16 = (u16)val;
>  			break;
>  
>  		case 4:
> -			*(u32 *)&trace_state->entry->fields[field->offset] = (u32)val;
> +			trace_state->entry->fields[field->offset].as32 = (u32)val;
>  			break;
>  
>  		default:
> -			trace_state->entry->fields[field->offset] = val;
> +			trace_state->entry->fields[field->offset].as64 = val;
>  			break;
>  		}
>  	}

