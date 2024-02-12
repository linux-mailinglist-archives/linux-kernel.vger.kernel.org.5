Return-Path: <linux-kernel+bounces-62554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A891E8522B4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2261C23142
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBBD50254;
	Mon, 12 Feb 2024 23:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c10xvUXd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB794F897;
	Mon, 12 Feb 2024 23:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781340; cv=none; b=BKTtRSOOKV5ul6QVYEmvuCiSutVMnQOGPZzWMone4XWBSHN0T0LGPXsADXL+OjafSIQPSP8PZ7+oQ/iy+UIdh2uR44lvPVJw6PFoTuzKoPwpK/QMliLPo+8EdaOJX0c/tg0Nd9WwUnb3PYGazOrBrtdGKFlU/+apI6ePyv2/Bfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781340; c=relaxed/simple;
	bh=7OgQNDmpILmfx9Ap+vxY4LxyWvfTI/aAmMdFZWULYpc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=reyToar/+XHGPynDdBpPXJpYLYGx+7qcdz6cRoBLTV5jvo/GmqiH6QyDaewqefzECndsNSSDe8YtYJmTPdtU3p1o/3eDV/d+gHpYYCKv+NEFjtHMSVLWZKVa7JTtJ4qiOv8y3AZaE0zRaG4yGyqjTBzn8qcAnTOAl/VpPOueLMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c10xvUXd; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707781339; x=1739317339;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=7OgQNDmpILmfx9Ap+vxY4LxyWvfTI/aAmMdFZWULYpc=;
  b=c10xvUXdS9FcxHbvysrzrIxv5P4LA5kPF19PlMjhjnUsObfiE3/h/QQW
   6wqeixKkQaWDkmD7NlgREg4qCaosVrcYn9ZptMNmIvqdkF807hU04/6pe
   cPJh/MPdaWtQo7QIOEXvz/ROH9BlMO7s4bQwKI7k1so/TxzfhB9YO0HzS
   +BLZfEl/IJXNGZ6CvwdSUlvR+D6Bg1/wbVAw8M9aCOoDKnKC3JKz3G+ja
   ora0LSWjyAS55a+2ntG69L8l6xkeRW+d+K23yLM2Jyr2Td7/QGHk6BiOH
   sXM345ClOYlAruUujA7bSqKafOrCk123IHibLJoCW3v2FGoJ/EXzOKWfL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="13162158"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="13162158"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 15:42:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="7375030"
Received: from sparrish-mobl1.amr.corp.intel.com (HELO [10.209.29.247]) ([10.209.29.247])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 15:42:18 -0800
Message-ID: <65e9189f920b03d0a8741c1cd19e55997b6ca9d2.camel@linux.intel.com>
Subject: Re: [PATCH] tracing: Fix wasted memory in saved_cmdlines logic
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,  Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort
 <vdonnefort@google.com>,  Sven Schnelle <svens@linux.ibm.com>, Mete Durlu
 <meted@linux.ibm.com>, stable <stable@vger.kernel.org>
Date: Mon, 12 Feb 2024 15:42:16 -0800
In-Reply-To: <20240208105328.7e73f71d@rorschach.local.home>
References: <20240208105328.7e73f71d@rorschach.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-08 at 10:53 -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>=20
> While looking at improving the saved_cmdlines cache I found a huge amount
> of wasted memory that should be used for the cmdlines.
>=20
> The tracing data saves pids during the trace. At sched switch, if a trace
> occurred, it will save the comm of the task that did the trace. This is
> saved in a "cache" that maps pids to comms and exposed to user space via
> the /sys/kernel/tracing/saved_cmdlines file. Currently it only caches by
> default 128 comms.
>=20
> The structure that uses this creates an array to store the pids using
> PID_MAX_DEFAULT (which is usually set to 32768). This causes the structur=
e
> to be of the size of 131104 bytes on 64 bit machines.
>=20
> In hex: 131104 =3D 0x20020, and since the kernel allocates generic memory=
 in
> powers of two, the kernel would allocate 0x40000 or 262144 bytes to store
> this structure. That leaves 131040 bytes of wasted space.
>=20
> Worse, the structure points to an allocated array to store the comm names=
,
> which is 16 bytes times the amount of names to save (currently 128), whic=
h
> is 2048 bytes. Instead of allocating a separate array, make the structure
> end with a variable length string and use the extra space for that.
>=20
> This is similar to a recommendation that Linus had made about eventfs_ino=
de names:
>=20
>   https://lore.kernel.org/all/20240130190355.11486-5-torvalds@linux-found=
ation.org/
>=20
> Instead of allocating a separate string array to hold the saved comms,
> have the structure end with: char saved_cmdlines[]; and round up to the
> next power of two over sizeof(struct saved_cmdline_buffers) + num_cmdline=
s * TASK_COMM_LEN
> It will use this extra space for the saved_cmdline portion.
>=20
> Now, instead of saving only 128 comms by default, by using this wasted
> space at the end of the structure it can save over 8000 comms and even
> saves space by removing the need for allocating the other array.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 939c7a4f04fcd ("tracing: Introduce saved_cmdlines_size file")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>

> ---
>  kernel/trace/trace.c | 73 +++++++++++++++++++++-----------------------
>  1 file changed, 34 insertions(+), 39 deletions(-)
>=20
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 2a7c6fd934e9..0b3e60b827f7 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2320,7 +2320,7 @@ struct saved_cmdlines_buffer {
>  	unsigned *map_cmdline_to_pid;
>  	unsigned cmdline_num;
>  	int cmdline_idx;
> -	char *saved_cmdlines;
> +	char saved_cmdlines[];
>  };
>  static struct saved_cmdlines_buffer *savedcmd;
> =20
> @@ -2334,47 +2334,54 @@ static inline void set_cmdline(int idx, const cha=
r *cmdline)
>  	strncpy(get_saved_cmdlines(idx), cmdline, TASK_COMM_LEN);
>  }
> =20
> -static int allocate_cmdlines_buffer(unsigned int val,
> -				    struct saved_cmdlines_buffer *s)
> +static void free_saved_cmdlines_buffer(struct saved_cmdlines_buffer *s)
> +{
> +	int order =3D get_order(sizeof(*s) + s->cmdline_num * TASK_COMM_LEN);
> +
> +	kfree(s->map_cmdline_to_pid);
> +	free_pages((unsigned long)s, order);
> +}
> +
> +static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned i=
nt val)
>  {
> +	struct saved_cmdlines_buffer *s;
> +	struct page *page;
> +	int orig_size, size;
> +	int order;
> +
> +	/* Figure out how much is needed to hold the given number of cmdlines *=
/
> +	orig_size =3D sizeof(*s) + val * TASK_COMM_LEN;
> +	order =3D get_order(orig_size);
> +	size =3D 1 << (order + PAGE_SHIFT);
> +	page =3D alloc_pages(GFP_KERNEL, order);
> +	if (!page)
> +		return NULL;
> +
> +	s =3D page_address(page);
> +	memset(s, 0, sizeof(*s));
> +
> +	/* Round up to actual allocation */
> +	val =3D (size - sizeof(*s)) / TASK_COMM_LEN;
> +	s->cmdline_num =3D val;
> +
>  	s->map_cmdline_to_pid =3D kmalloc_array(val,
>  					      sizeof(*s->map_cmdline_to_pid),
>  					      GFP_KERNEL);
> -	if (!s->map_cmdline_to_pid)
> -		return -ENOMEM;
> -
> -	s->saved_cmdlines =3D kmalloc_array(TASK_COMM_LEN, val, GFP_KERNEL);
> -	if (!s->saved_cmdlines) {
> -		kfree(s->map_cmdline_to_pid);
> -		return -ENOMEM;
> -	}
> =20
>  	s->cmdline_idx =3D 0;
> -	s->cmdline_num =3D val;
>  	memset(&s->map_pid_to_cmdline, NO_CMDLINE_MAP,
>  	       sizeof(s->map_pid_to_cmdline));
>  	memset(s->map_cmdline_to_pid, NO_CMDLINE_MAP,
>  	       val * sizeof(*s->map_cmdline_to_pid));
> =20
> -	return 0;
> +	return s;
>  }
> =20
>  static int trace_create_savedcmd(void)
>  {
> -	int ret;
> -
> -	savedcmd =3D kmalloc(sizeof(*savedcmd), GFP_KERNEL);
> -	if (!savedcmd)
> -		return -ENOMEM;
> -
> -	ret =3D allocate_cmdlines_buffer(SAVED_CMDLINES_DEFAULT, savedcmd);
> -	if (ret < 0) {
> -		kfree(savedcmd);
> -		savedcmd =3D NULL;
> -		return -ENOMEM;
> -	}
> +	savedcmd =3D allocate_cmdlines_buffer(SAVED_CMDLINES_DEFAULT);
> =20
> -	return 0;
> +	return savedcmd ? 0 : -ENOMEM;
>  }
> =20
>  int is_tracing_stopped(void)
> @@ -6056,26 +6063,14 @@ tracing_saved_cmdlines_size_read(struct file *fil=
p, char __user *ubuf,
>  	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
>  }
> =20
> -static void free_saved_cmdlines_buffer(struct saved_cmdlines_buffer *s)
> -{
> -	kfree(s->saved_cmdlines);
> -	kfree(s->map_cmdline_to_pid);
> -	kfree(s);
> -}
> -
>  static int tracing_resize_saved_cmdlines(unsigned int val)
>  {
>  	struct saved_cmdlines_buffer *s, *savedcmd_temp;
> =20
> -	s =3D kmalloc(sizeof(*s), GFP_KERNEL);
> +	s =3D allocate_cmdlines_buffer(val);
>  	if (!s)
>  		return -ENOMEM;
> =20
> -	if (allocate_cmdlines_buffer(val, s) < 0) {
> -		kfree(s);
> -		return -ENOMEM;
> -	}
> -
>  	preempt_disable();
>  	arch_spin_lock(&trace_cmdline_lock);
>  	savedcmd_temp =3D savedcmd;


