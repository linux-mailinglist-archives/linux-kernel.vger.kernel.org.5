Return-Path: <linux-kernel+bounces-144651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7967B8A48CD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3479F284514
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C19D225D4;
	Mon, 15 Apr 2024 07:16:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5C520DC4;
	Mon, 15 Apr 2024 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165362; cv=none; b=X3NYpW33POma4c1SWQgPJfnSULSRsXt66rtzm/jOMTAC5iR0/VvrKu3uVDqcMNHTKYw5Ay6l9oSF+rnbxZl+0kJY+8EtDf5EfjMjBvMf91TZpUfdJYY8lvijIlscx0wPJpjzW8ZjAJkusCFaGzWFR4UPQBrdPcuQVp8D+bnFsso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165362; c=relaxed/simple;
	bh=QMcq1DhjSKdHb6qqoxA+QfgDkKOTwt2YbMawmdiDzV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dN8DNdFhY4nYYeUIeA7TP+4yaWDCO+BuNXcGCdA0LHG1q05eK/X3t6LqD20SFWyc3dt/Olm4NalqhsbjD+ol8fpX1IRZqVZuJjbQsd5Xq3U0Ke2KKtzNa+no1ns/sdWWmJZy8bKyfLSAGhFxoGtGmyulnNuFWTBbxbCn1VtPx/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC0EC113CC;
	Mon, 15 Apr 2024 07:16:00 +0000 (UTC)
Date: Mon, 15 Apr 2024 03:15:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dongliang Cui <dongliang.cui@unisoc.com>
Cc: <axboe@kernel.dk>, <mhiramat@kernel.org>,
 <mathieu.desnoyers@efficios.com>, <ebiggers@kernel.org>,
 <ke.wang@unisoc.com>, <hongyu.jin.cn@gmail.com>, <niuzhiguo84@gmail.com>,
 <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <cuidongliang390@gmail.com>
Subject: Re: [PATCH RESEND] block: Add ioprio to block_rq tracepoint
Message-ID: <20240415031556.5788238e@rorschach.local.home>
In-Reply-To: <20240415060710.1199009-1-dongliang.cui@unisoc.com>
References: <20240415060710.1199009-1-dongliang.cui@unisoc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Apr 2024 14:07:10 +0800
Dongliang Cui <dongliang.cui@unisoc.com> wrote:

> Sometimes we need to track the processing order of requests with
> ioprio set. So the ioprio of request can be useful information.
>=20
> Example=EF=BC=9A
>=20
> block_rq_insert: 8,0 WS 4096 () 16573296 + 8 rt,4 [highpool[1]]
> block_rq_issue: 8,0 WS 4096 () 16573296 + 8 rt,4 [kworker/7:0H]
> block_rq_complete: 8,0 WS () 16573296 + 8 rt,4 [0]

Note, it's up to the subsystem to take trace event patches.

>=20
> Signed-off-by: Dongliang Cui <dongliang.cui@unisoc.com>
> ---
>  include/linux/blktrace_api.h |  2 ++
>  include/trace/events/block.h | 63 ++++++++++++++++++++++--------------
>  kernel/trace/blktrace.c      | 11 +++++++
>  3 files changed, 51 insertions(+), 25 deletions(-)
>=20
> diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
> index 122c62e561fc..adb0333efbdb 100644
> --- a/include/linux/blktrace_api.h
> +++ b/include/linux/blktrace_api.h
> @@ -112,6 +112,8 @@ struct compat_blk_user_trace_setup {
> =20
>  void blk_fill_rwbs(char *rwbs, blk_opf_t opf);
> =20
> +void blk_fill_ioprio(u32 ioprio, char *ioprio_class, u32 *ioprio_value);
> +
>  static inline sector_t blk_rq_trace_sector(struct request *rq)
>  {
>  	/*
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> index 0e128ad51460..1d41fade160a 100644
> --- a/include/trace/events/block.h
> +++ b/include/trace/events/block.h
> @@ -10,7 +10,8 @@
>  #include <linux/buffer_head.h>
>  #include <linux/tracepoint.h>
> =20
> -#define RWBS_LEN	8
> +#define RWBS_LEN		8
> +#define IOPRIO_CLASS_LEN	8
> =20
>  #ifdef CONFIG_BUFFER_HEAD
>  DECLARE_EVENT_CLASS(block_buffer,
> @@ -79,11 +80,13 @@ TRACE_EVENT(block_rq_requeue,
>  	TP_ARGS(rq),
> =20
>  	TP_STRUCT__entry(
> -		__field(  dev_t,	dev			)
> -		__field(  sector_t,	sector			)
> -		__field(  unsigned int,	nr_sector		)
> -		__array(  char,		rwbs,	RWBS_LEN	)
> -		__dynamic_array( char,	cmd,	1		)
> +		__field(  dev_t,	dev				)
> +		__field(  sector_t,	sector				)
> +		__field(  unsigned int,	nr_sector			)
> +		__array(  char,		rwbs,	RWBS_LEN		)
> +		__array(  char,		ioprio_class, IOPRIO_CLASS_LEN	)
> +		__field(  unsigned int, ioprio_value			)
> +		__dynamic_array( char,	cmd,	1			)
>  	),
> =20
>  	TP_fast_assign(
> @@ -92,14 +95,16 @@ TRACE_EVENT(block_rq_requeue,
>  		__entry->nr_sector =3D blk_rq_trace_nr_sectors(rq);
> =20
>  		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
> +		blk_fill_ioprio(rq->ioprio, __entry->ioprio_class, &__entry->ioprio_va=
lue);
>  		__get_str(cmd)[0] =3D '\0';
>  	),
> =20
> -	TP_printk("%d,%d %s (%s) %llu + %u [%d]",
> +	TP_printk("%d,%d %s (%s) %llu + %u %s,%u [%d]",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  __entry->rwbs, __get_str(cmd),
>  		  (unsigned long long)__entry->sector,
> -		  __entry->nr_sector, 0)
> +		  __entry->nr_sector, __entry->ioprio_class,
> +		  __entry->ioprio_value, 0)
>  );


> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index d5d94510afd3..e55aa49f94db 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -19,6 +19,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/list.h>
>  #include <linux/blk-cgroup.h>
> +#include <linux/ioprio.h>
> =20
>  #include "../../block/blk.h"
> =20
> @@ -26,6 +27,9 @@
> =20
>  #include "trace_output.h"
> =20
> +/* Type of ioprio */
> +static char *classes[] =3D {"none", "rt", "be", "idle"};
> +
>  #ifdef CONFIG_BLK_DEV_IO_TRACE
> =20
>  static unsigned int blktrace_seq __read_mostly =3D 1;
> @@ -1914,5 +1918,12 @@ void blk_fill_rwbs(char *rwbs, blk_opf_t opf)
>  }
>  EXPORT_SYMBOL_GPL(blk_fill_rwbs);
> =20
> +void blk_fill_ioprio(u32 ioprio, char *ioprio_class, u32 *ioprio_value)
> +{
> +	memcpy(ioprio_class, classes[(ioprio >> IOPRIO_CLASS_SHIFT) & 0x3], IOP=
RIO_CLASS_LEN);
> +	*ioprio_value =3D ioprio & 0xff;
> +}
> +EXPORT_SYMBOL_GPL(blk_fill_ioprio);
> +
>  #endif /* CONFIG_EVENT_TRACING */
> =20

Instead of doing:

		blk_fill_ioprio(rq->ioprio, __entry->ioprio_class, &__entry->ioprio_value=
);


Why not do:

	__field(	int,	ioprio_class	)

[..]

	__entry->ioprio_class =3D rq->ioprio >> IOPRIO_CLASS_SHIFT & 0x3;

[..]

	TP_printk("%d,%d %s (%s) %llu + %u %s,%u [%d]",
		  MAJOR(__entry->dev), MINOR(__entry->dev),
		  __entry->rwbs, __get_str(cmd),
		  (unsigned long long)__entry->sector,
		  __entry->nr_sector,
		  __print_symbolic(ioclass,
			{ 0, "none" }, { 1, "rt" }, { 2, "bt" }, { 3, "idle" }),
		  __entry->ioprio_value, 0)
);

 ?

Then you don't need to save a string into the buffer, and just print
the mapping on reading of the buffer.

-- Steve

