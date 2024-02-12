Return-Path: <linux-kernel+bounces-62551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5208522AB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB14B237F5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1995351C21;
	Mon, 12 Feb 2024 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gaCKnN3a"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F4350268;
	Mon, 12 Feb 2024 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781147; cv=none; b=HFSKSA/Mp6jVGt2iWBm66pZjnLfteBfTgFhrk2ubh8FAkBuclgxHBw9SY4o3BxKVKIJJ93tdIkKSaLFah4cdvTCwVSS87t9sMSBNKwIPQ601aO6pRS3UPhv6OC6nexH+uQWxCxmzjw3F36xDYkcWRaDEeDhugQ5xKzQlVxXENW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781147; c=relaxed/simple;
	bh=QPAWSIbAkGzPHg0gCvchvrpX63qIMyVQwVrLpDY0n+c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fk9zfJ7QYmqacUYHjgUV7yFgq0fmWVYcY9zJvUL9bZzacnqzStDoe+SbLhCkGO7GPaVwRLG3yEjJDmYUIJHZn9IahwnssxTJmuzNpg2PNQgnFrTgXwQ+zRcWNdB+ZW+/gVc0pWxQz3ECK96dBp0xIph1E2SmPTjj4alZVSAH+0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gaCKnN3a; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707781146; x=1739317146;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=QPAWSIbAkGzPHg0gCvchvrpX63qIMyVQwVrLpDY0n+c=;
  b=gaCKnN3aIXi8iyK5YygR7BBoJNHbLA2Eti0Y1xg+mxJKXifJLKdKt+ih
   cmVITmm9D41H3uuKe2NZHUolus6pRvu1kJMLW/4KglSPrDOOV2AeZQGZ0
   fDGcFRCoPlswSwgkZkfXM+yp3B5X5X1vPVtcKmXWwbQ51U8n5RRp4amIG
   GVWSyxwT49QhJNNRmcli6HKF6gxSDgGB/ZIYoYGBryhhit73Y75TEHO0y
   A8dNNFj5h+Uktd1YkIdxlZ52W2YyTmyOo4TCRrjvuC2SOtotznYZSgTQz
   IADCzDilj3qmNbydXdV5UmJjONSemYxecMlOPnfshwDHXdWS4yUvrXdel
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="12332444"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="12332444"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 15:39:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="2682509"
Received: from sparrish-mobl1.amr.corp.intel.com (HELO [10.209.29.247]) ([10.209.29.247])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 15:39:04 -0800
Message-ID: <ef94259e139e4579ee27db99975dc4cf397e2a06.camel@linux.intel.com>
Subject: Re: [PATCH] tracing: Have saved_cmdlines arrays all in one
 allocation
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,  Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, 
 Vincent Donnefort <vdonnefort@google.com>, Sven Schnelle
 <svens@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>
Date: Mon, 12 Feb 2024 15:39:03 -0800
In-Reply-To: <20240212180941.379c419b@gandalf.local.home>
References: <20240212180941.379c419b@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-12 at 18:09 -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>=20
> The saved_cmdlines have three arrays for mapping PIDs to COMMs:
>=20
>  - map_pid_to_cmdline[]
>  - map_cmdline_to_pid[]
>  - saved_cmdlines
>=20
> The map_pid_to_cmdline[] is PID_MAX_DEFAULT in size and holds the index
> into the other arrays. The map_cmdline_to_pid[] is a mapping back to the
> full pid as it can be larger than PID_MAX_DEFAULT. And the
> saved_cmdlines[] just holds the COMMs associated to the pids.
>=20
> Currently the map_pid_to_cmdline[] and saved_cmdlines[] are allocated
> together (in reality the saved_cmdlines is just in the memory of the
> rounding of the allocation of the structure as it is always allocated in
> powers of two). The map_cmdline_to_pid[] array is allocated separately.
>=20
> Since the rounding to a power of two is rather large (it allows for 8000
> elements in saved_cmdlines), also include the map_cmdline_to_pid[] array.
> (This drops it to 6000 by default, which is still plenty for most use
> cases). This saves even more memory as the map_cmdline_to_pid[] array
> doesn't need to be allocated.


This patch does make better use of the extra space and make the
previous change better.

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
=20
>=20
> Link: https://lore.kernel.org/linux-trace-kernel/20240212174011.068211d9@=
gandalf.local.home/
>=20
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_sched_switch.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>=20
> diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched=
_switch.c
> index e4fbcc3bede5..210c74dcd016 100644
> --- a/kernel/trace/trace_sched_switch.c
> +++ b/kernel/trace/trace_sched_switch.c
> @@ -201,7 +201,7 @@ static struct saved_cmdlines_buffer *allocate_cmdline=
s_buffer(unsigned int val)
>  	int order;
> =20
>  	/* Figure out how much is needed to hold the given number of cmdlines *=
/
> -	orig_size =3D sizeof(*s) + val * TASK_COMM_LEN;
> +	orig_size =3D sizeof(*s) + val * (TASK_COMM_LEN + sizeof(int));

Strictly speaking, *map_cmdline_to_pid is unsigned int so it is more consis=
tent
to use sizeof(unsigned) in line above.  But I'm nitpicking and I'm fine to
leave it as is.

>  	order =3D get_order(orig_size);
>  	size =3D 1 << (order + PAGE_SHIFT);
>  	page =3D alloc_pages(GFP_KERNEL, order);
> @@ -212,16 +212,11 @@ static struct saved_cmdlines_buffer *allocate_cmdli=
nes_buffer(unsigned int val)
>  	memset(s, 0, sizeof(*s));
> =20
>  	/* Round up to actual allocation */
> -	val =3D (size - sizeof(*s)) / TASK_COMM_LEN;
> +	val =3D (size - sizeof(*s)) / (TASK_COMM_LEN + sizeof(int));
>  	s->cmdline_num =3D val;
> =20
> -	s->map_cmdline_to_pid =3D kmalloc_array(val,
> -					      sizeof(*s->map_cmdline_to_pid),
> -					      GFP_KERNEL);
> -	if (!s->map_cmdline_to_pid) {
> -		free_saved_cmdlines_buffer(s);
> -		return NULL;
> -	}
> +	/* Place map_cmdline_to_pid array right after saved_cmdlines */
> +	s->map_cmdline_to_pid =3D (unsigned *)&s->saved_cmdlines[val * TASK_COM=
M_LEN];
> =20
>  	s->cmdline_idx =3D 0;
>  	memset(&s->map_pid_to_cmdline, NO_CMDLINE_MAP,


