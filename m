Return-Path: <linux-kernel+bounces-54817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B402E84B40B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95461C223C6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E425B686;
	Tue,  6 Feb 2024 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FX+id5uB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4485912FB06
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219624; cv=none; b=LNuBMJSZGgAVoqSNUhatZzh3TFp/yLhiEFsW9GpEgx+HghH+CgoN9TpOgWtna9xO+Rd1xoDQa7kqVc4VaMYmHE3VkbnKsvrAMzoajg7m9uWbsSW0AYh0+unAOPVHbSQl40V1A7E4AyNA6bhrR2yMQeqFgB9kUSRDrJ1eLWqV7mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219624; c=relaxed/simple;
	bh=TnPOfCBj497/caMhCQlDdIcWVZkUg4ndPkIx7MzT1pk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ih/Uf6u6X7TxImqw2ERDl7kYYAFm3EA6Cysnm4mB8i6kGBlUGAmNKppsheSyNK4VOPnsvCWyi/VzTdwgvSjR8ZJwLJTTKYe1Z1JbkNO5+USeigKvkB5/qld2jXghzrVNozyLStdzPBaSLAvTt+2b317cxcZFemkFlRls9vokfJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FX+id5uB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707219621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TPELn2sdkgF0FjAabyDqjzot0ROUv2uYxpIr8s6iS+8=;
	b=FX+id5uBCQLa49aQESe7f60GSc11q63LLzaM/nfySPQ2PCrF8uyDsFuwAcl4rE5QP4V4Iq
	iIi2Ddf7AE37B/hQcX6/+Emz0BHR1Jl7DSsBa9Ao6d91rvMWItT4PjJ3N/PcvdVy9M59pc
	ztFVSH2bDNduNfgAC7l85WKtpMZoppI=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-GkDVM4FKM4icEUC2vjRTfg-1; Tue, 06 Feb 2024 06:40:19 -0500
X-MC-Unique: GkDVM4FKM4icEUC2vjRTfg-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3be33c7f1c7so2336011b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 03:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707219619; x=1707824419;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPELn2sdkgF0FjAabyDqjzot0ROUv2uYxpIr8s6iS+8=;
        b=YEPzv5f38le5aBG5Zy23BXiKu54vqBjvLElrY9l7EW3/3Wk8Nmp5gZuZnEZKrmgAkj
         wnmhWPQ8Qkrr9kk96JKJfBsWEXfCCw7ze393WGQfdIl8mopz+3RtfPEeCX1mtfZa+0KY
         fNF4Z5Elyc+KPSRWqZfhaFDc0+CfJf0czeY5DtwbWN9JUVM2lu2LU+WhHsVI4ubScAnx
         k2WIjzmGiI/XN971O3EahU6RIFl6Rpvy/MH3A1NUteRCXxBBaoa5EjySw7lsJFQg0IVC
         oIqNKYghmwTy/QFEkysHbUaWKynU0xUFWc1GQ4VuAxPIeT607obCwgPh43A0hUPFirBo
         B/9g==
X-Gm-Message-State: AOJu0YzZWuCr+D4jAZaG7QLSIInvWPH0Z1a08R1nmcTfmPKRr4ViTwhb
	YSJu1yhmwqx/pTThAnXZJC9xfWCoh53m52l7oKAyE8yEeTvzFnFahE3/CdcbshllZw9bwjumpMP
	PD1Akb+FdhjcdylhXF95tsNCmoNipU9JTSeSvYEv7bS6Ec2GWdlqEnXRk9Kbk5Q==
X-Received: by 2002:a05:6808:190f:b0:3bf:bc5c:c452 with SMTP id bf15-20020a056808190f00b003bfbc5cc452mr3064115oib.3.1707219618760;
        Tue, 06 Feb 2024 03:40:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6ZmeylEOxILfsDwOB8t205YVtnvISVVTonMkLuzePqzv9q2EyhH2b2Jk23HHMNB6iJU5asQ==
X-Received: by 2002:a05:6808:190f:b0:3bf:bc5c:c452 with SMTP id bf15-20020a056808190f00b003bfbc5cc452mr3064098oib.3.1707219618357;
        Tue, 06 Feb 2024 03:40:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUJnhmQkSPCfSV4Wcdm8uHXiBJgR24AtZKafe87Sq4EsX9PXjU1u1KSMLKbDPHwFZEGkdLWk5UoZYxbdadgwn2iQitkvsFBx5Hykb1wK1UhHB+EAq9kRvoIxQB92PHlUAcO73RCBKSpvh3gq8hOQhgbCfRhHegJDclNaF9iw2Ew9M5RB9xwT7fpKc0HvpfaRnDk5l2g/jLunUI6O7Y+DilVtC8gkGT/oOvy7YHXU/mnbC+zKBYep8VM0gDlrqTYSECJPSdd+r1mVC/XM1VzJLxK+OjXLLPK5iRwesmlX7raC7ZJZ66HHGqxkGDNlt6m1ktVWeiHpTEMlBqPIO755Ol7VMFJFOQR9gQ2azAnrg+q0TOICO8tXI8QZjgZjK2l/BaGMqIm0FTclCwi7oyli21fYCzhxk86ut8lLaYlAeLp2JW7dBhKH5NmTG+XUy1HM5UXPOJOD0Gm8TsgG+X1qXVXgZBExd2z2iOvF2YRKj6muMGRK1oecIKpor8jiiUS6iGA6EnkTwdy+NvM4RHWWvEYQ+oWCqnKueFaTt4tHjJrruN2D2pn
Received: from gerbillo.redhat.com (146-241-224-127.dyn.eolo.it. [146.241.224.127])
        by smtp.gmail.com with ESMTPSA id u21-20020a05620a121500b00783fb468e7bsm837276qkj.44.2024.02.06.03.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 03:40:17 -0800 (PST)
Message-ID: <dc049b1e556ef7b398fb78c01b6e2e693c185273.camel@redhat.com>
Subject: Re: [PATCH net-next v3] net: dqs: add NIC stall detector based on
 BQL
From: Paolo Abeni <pabeni@redhat.com>
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net, 
 edumazet@google.com, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: weiwan@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
  horms@kernel.org, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap
 <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, Johannes Berg
 <johannes.berg@intel.com>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
 <linux@weissschuh.net>, "open list:TRACING"
 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 06 Feb 2024 12:40:13 +0100
In-Reply-To: <20240202165315.2506384-1-leitao@debian.org>
References: <20240202165315.2506384-1-leitao@debian.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-02 at 08:53 -0800, Breno Leitao wrote:
> From: Jakub Kicinski <kuba@kernel.org>
>=20
> softnet_data->time_squeeze is sometimes used as a proxy for
> host overload or indication of scheduling problems. In practice
> this statistic is very noisy and has hard to grasp units -
> e.g. is 10 squeezes a second to be expected, or high?
>=20
> Delaying network (NAPI) processing leads to drops on NIC queues
> but also RTT bloat, impacting pacing and CA decisions.
> Stalls are a little hard to detect on the Rx side, because
> there may simply have not been any packets received in given
> period of time. Packet timestamps help a little bit, but
> again we don't know if packets are stale because we're
> not keeping up or because someone (*cough* cgroups)
> disabled IRQs for a long time.
>=20
> We can, however, use Tx as a proxy for Rx stalls. Most drivers
> use combined Rx+Tx NAPIs so if Tx gets starved so will Rx.
> On the Tx side we know exactly when packets get queued,
> and completed, so there is no uncertainty.
>=20
> This patch adds stall checks to BQL. Why BQL? Because
> it's a convenient place to add such checks, already
> called by most drivers, and it has copious free space
> in its structures (this patch adds no extra cache
> references or dirtying to the fast path).
>=20
> The algorithm takes one parameter - max delay AKA stall
> threshold and increments a counter whenever NAPI got delayed
> for at least that amount of time. It also records the length
> of the longest stall.
>=20
> To be precise every time NAPI has not polled for at least
> stall thrs we check if there were any Tx packets queued
> between last NAPI run and now - stall_thrs/2.
>=20
> Unlike the classic Tx watchdog this mechanism does not
> ignore stalls caused by Tx being disabled, or loss of link.
> I don't think the check is worth the complexity, and
> stall is a stall, whether due to host overload, flow
> control, link down... doesn't matter much to the application.
>=20
> We have been running this detector in production at Meta
> for 2 years, with the threshold of 8ms. It's the lowest
> value where false positives become rare. There's still
> a constant stream of reported stalls (especially without
> the ksoftirqd deferral patches reverted), those who like
> their stall metrics to be 0 may prefer higher value.
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changelog:
>=20
> v1:
>   * https://lore.kernel.org/netdev/202306172057.jx7YhLiu-lkp@intel.com/T/
>=20
> v2:
>   * Fix the documentation file in patch 0001, since patch 0002 will
>     touch it later.
>   * Fix the kernel test robot issues, marking functions as statics.
>   * Use #include <linux/bitops.h> instead of <asm/bitops.h>.
>   * Added some new comments around, mainly around barriers.
>   * Format struct `netdev_queue_attribute` assignments to make
>     checkpatch happy.
>   * Updated and fixed the path in sysfs-class-net-queues
>     documentation.
>=20
> v3:
>   * Sending patch 0002 against net-next.
> 	- The first patch was accepted against 'net'
>=20
> ---
>  .../ABI/testing/sysfs-class-net-queues        | 23 +++++++
>  include/linux/dynamic_queue_limits.h          | 35 +++++++++++
>  include/trace/events/napi.h                   | 33 ++++++++++
>  lib/dynamic_queue_limits.c                    | 58 +++++++++++++++++
>  net/core/net-sysfs.c                          | 62 +++++++++++++++++++
>  5 files changed, 211 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-net-queues b/Documenta=
tion/ABI/testing/sysfs-class-net-queues
> index 5bff64d256c2..45bab9b6e3ae 100644
> --- a/Documentation/ABI/testing/sysfs-class-net-queues
> +++ b/Documentation/ABI/testing/sysfs-class-net-queues
> @@ -96,3 +96,26 @@ Description:
>  		Indicates the absolute minimum limit of bytes allowed to be
>  		queued on this network device transmit queue. Default value is
>  		0.
> +
> +What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/stall_=
thrs
> +Date:		Jan 2024
> +KernelVersion:	6.9
> +Contact:	netdev@vger.kernel.org
> +Description:
> +		Tx completion stall detection threshold.=C2=A0

Possibly worth mentioning it's in milliseconds

> Kernel will guarantee
> +		to detect all stalls longer than this threshold but may also
> +		detect stalls longer than half of the threshold.
> +
> +What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/stall_=
cnt
> +Date:		Jan 2024
> +KernelVersion:	6.9
> +Contact:	netdev@vger.kernel.org
> +Description:
> +		Number of detected Tx completion stalls.
> +
> +What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/stall_=
max
> +Date:		Jan 2024
> +KernelVersion:	6.9
> +Contact:	netdev@vger.kernel.org
> +Description:
> +		Longest detected Tx completion stall. Write 0 to clear.
> diff --git a/include/linux/dynamic_queue_limits.h b/include/linux/dynamic=
_queue_limits.h
> index 407c2f281b64..288e98fe85f0 100644
> --- a/include/linux/dynamic_queue_limits.h
> +++ b/include/linux/dynamic_queue_limits.h
> @@ -38,14 +38,21 @@
> =20
>  #ifdef __KERNEL__
> =20
> +#include <linux/bitops.h>
>  #include <asm/bug.h>
> =20
> +#define DQL_HIST_LEN		4
> +#define DQL_HIST_ENT(dql, idx)	((dql)->history[(idx) % DQL_HIST_LEN])
> +
>  struct dql {
>  	/* Fields accessed in enqueue path (dql_queued) */
>  	unsigned int	num_queued;		/* Total ever queued */
>  	unsigned int	adj_limit;		/* limit + num_completed */
>  	unsigned int	last_obj_cnt;		/* Count at last queuing */
> =20
> +	unsigned long	history_head;
> +	unsigned long	history[DQL_HIST_LEN];
> +
>  	/* Fields accessed only by completion path (dql_completed) */
> =20
>  	unsigned int	limit ____cacheline_aligned_in_smp; /* Current limit */
> @@ -62,6 +69,11 @@ struct dql {
>  	unsigned int	max_limit;		/* Max limit */
>  	unsigned int	min_limit;		/* Minimum limit */
>  	unsigned int	slack_hold_time;	/* Time to measure slack */
> +
> +	unsigned char	stall_thrs;
> +	unsigned char	stall_max;

Why don't 'unsigned short'?=20


> +	unsigned long	last_reap;
> +	unsigned long	stall_cnt;
>  };
> =20
>  /* Set some static maximums */
> @@ -74,6 +86,8 @@ struct dql {
>   */
>  static inline void dql_queued(struct dql *dql, unsigned int count)
>  {
> +	unsigned long map, now, now_hi, i;
> +
>  	BUG_ON(count > DQL_MAX_OBJECT);
> =20
>  	dql->last_obj_cnt =3D count;
> @@ -86,6 +100,27 @@ static inline void dql_queued(struct dql *dql, unsign=
ed int count)
>  	barrier();
> =20
>  	dql->num_queued +=3D count;
> +
> +	now =3D jiffies;
> +	now_hi =3D now / BITS_PER_LONG;
> +	if (unlikely(now_hi !=3D dql->history_head)) {
> +		/* About to reuse slots, clear them */
> +		for (i =3D 0; i < DQL_HIST_LEN; i++) {
> +			/* Multiplication masks high bits */
> +			if (now_hi * BITS_PER_LONG =3D=3D
> +			    (dql->history_head + i) * BITS_PER_LONG)
> +				break;
> +			DQL_HIST_ENT(dql, dql->history_head + i + 1) =3D 0;
> +		}
> +		/* pairs with smp_rmb() in dql_check_stall() */
> +		smp_wmb();
> +		WRITE_ONCE(dql->history_head, now_hi);
> +	}
> +
> +	/* __set_bit() does not guarantee WRITE_ONCE() semantics */
> +	map =3D DQL_HIST_ENT(dql, now_hi);
> +	if (!(map & BIT_MASK(now)))
> +		WRITE_ONCE(DQL_HIST_ENT(dql, now_hi), map | BIT_MASK(now));

Do you have measure of performance impact, if any? e.g. for udp
flood/pktgen/xdp tput tests with extreme pkt rate?

What about making all the above conditional to a non zero stall_thrs,
alike the check part?

>  }
> =20
>  /* Returns how many objects can be queued, < 0 indicates over limit. */
> diff --git a/include/trace/events/napi.h b/include/trace/events/napi.h
> index 6678cf8b235b..272112ddaaa8 100644
> --- a/include/trace/events/napi.h
> +++ b/include/trace/events/napi.h
> @@ -36,6 +36,39 @@ TRACE_EVENT(napi_poll,
>  		  __entry->work, __entry->budget)
>  );
> =20
> +TRACE_EVENT(dql_stall_detected,
> +
> +	TP_PROTO(unsigned int thrs, unsigned int len,
> +		 unsigned long last_reap, unsigned long hist_head,
> +		 unsigned long now, unsigned long *hist),
> +
> +	TP_ARGS(thrs, len, last_reap, hist_head, now, hist),
> +
> +	TP_STRUCT__entry(
> +		__field(	unsigned int,		thrs)
> +		__field(	unsigned int,		len)
> +		__field(	unsigned long,		last_reap)
> +		__field(	unsigned long,		hist_head)
> +		__field(	unsigned long,		now)
> +		__array(	unsigned long,		hist, 4)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->thrs =3D thrs;
> +		__entry->len =3D len;
> +		__entry->last_reap =3D last_reap;
> +		__entry->hist_head =3D hist_head * BITS_PER_LONG;
> +		__entry->now =3D now;
> +		memcpy(__entry->hist, hist, sizeof(entry->hist));
> +	),
> +
> +	TP_printk("thrs %u  len %u  last_reap %lu  hist_head %lu  now %lu  hist=
 %016lx %016lx %016lx %016lx",
> +		  __entry->thrs, __entry->len,
> +		  __entry->last_reap, __entry->hist_head, __entry->now,
> +		  __entry->hist[0], __entry->hist[1],
> +		  __entry->hist[2], __entry->hist[3])
> +);
> +
>  #undef NO_DEV
> =20
>  #endif /* _TRACE_NAPI_H */
> diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
> index fde0aa244148..162d30ae542c 100644
> --- a/lib/dynamic_queue_limits.c
> +++ b/lib/dynamic_queue_limits.c
> @@ -10,10 +10,61 @@
>  #include <linux/dynamic_queue_limits.h>
>  #include <linux/compiler.h>
>  #include <linux/export.h>
> +#include <trace/events/napi.h>
> =20
>  #define POSDIFF(A, B) ((int)((A) - (B)) > 0 ? (A) - (B) : 0)
>  #define AFTER_EQ(A, B) ((int)((A) - (B)) >=3D 0)
> =20
> +static void dql_check_stall(struct dql *dql)
> +{
> +	unsigned long stall_thrs, now;
> +
> +	/* If we detect a stall see if anything was queued */
> +	stall_thrs =3D READ_ONCE(dql->stall_thrs);
> +	if (!stall_thrs)
> +		return;
> +
> +	now =3D jiffies;
> +	if (time_after_eq(now, dql->last_reap + stall_thrs)) {
> +		unsigned long hist_head, t, start, end;
> +
> +		/* We are trying to detect a period of at least @stall_thrs
> +		 * jiffies without any Tx completions, but during first half
> +		 * of which some Tx was posted.
> +		 */
> +dqs_again:
> +		hist_head =3D READ_ONCE(dql->history_head);
> +		/* pairs with smp_wmb() in dql_queued() */
> +		smp_rmb();
> +		/* oldest sample since last reap */
> +		start =3D (hist_head - DQL_HIST_LEN + 1) * BITS_PER_LONG;
> +		if (time_before(start, dql->last_reap + 1))
> +			start =3D dql->last_reap + 1;
> +		/* newest sample we should have already seen a completion for */
> +		end =3D hist_head * BITS_PER_LONG + (BITS_PER_LONG - 1);
> +		if (time_before(now, end + stall_thrs / 2))
> +			end =3D now - stall_thrs / 2;
> +
> +		for (t =3D start; time_before_eq(t, end); t++)
> +			if (test_bit(t % (DQL_HIST_LEN * BITS_PER_LONG),
> +				     dql->history))
> +				break;
> +		if (!time_before_eq(t, end))
> +			goto no_stall;
> +		if (hist_head !=3D READ_ONCE(dql->history_head))
> +			goto dqs_again;
> +
> +		dql->stall_cnt++;
> +		dql->stall_max =3D max_t(unsigned int, dql->stall_max, now - t);
> +
> +		trace_dql_stall_detected(dql->stall_thrs, now - t,
> +					 dql->last_reap, dql->history_head,
> +					 now, dql->history);
> +	}
> +no_stall:
> +	dql->last_reap =3D now;
> +}
> +
>  /* Records completed count and recalculates the queue limit */
>  void dql_completed(struct dql *dql, unsigned int count)
>  {
> @@ -110,6 +161,8 @@ void dql_completed(struct dql *dql, unsigned int coun=
t)
>  	dql->prev_last_obj_cnt =3D dql->last_obj_cnt;
>  	dql->num_completed =3D completed;
>  	dql->prev_num_queued =3D num_queued;
> +
> +	dql_check_stall(dql);
>  }
>  EXPORT_SYMBOL(dql_completed);
> =20
> @@ -125,6 +178,10 @@ void dql_reset(struct dql *dql)
>  	dql->prev_ovlimit =3D 0;
>  	dql->lowest_slack =3D UINT_MAX;
>  	dql->slack_start_time =3D jiffies;
> +
> +	dql->last_reap =3D jiffies;
> +	dql->history_head =3D jiffies / BITS_PER_LONG;
> +	memset(dql->history, 0, sizeof(dql->history));
>  }
>  EXPORT_SYMBOL(dql_reset);
> =20
> @@ -133,6 +190,7 @@ void dql_init(struct dql *dql, unsigned int hold_time=
)
>  	dql->max_limit =3D DQL_MAX_LIMIT;
>  	dql->min_limit =3D 0;
>  	dql->slack_hold_time =3D hold_time;
> +	dql->stall_thrs =3D 0;
>  	dql_reset(dql);
>  }
>  EXPORT_SYMBOL(dql_init);
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index a09d507c5b03..94a622b0bb55 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -1409,6 +1409,65 @@ static struct netdev_queue_attribute bql_hold_time=
_attribute __ro_after_init
>  	=3D __ATTR(hold_time, 0644,
>  		 bql_show_hold_time, bql_set_hold_time);
> =20
> +static ssize_t bql_show_stall_thrs(struct netdev_queue *queue, char *buf=
)
> +{
> +	struct dql *dql =3D &queue->dql;
> +
> +	return sprintf(buf, "%u\n", jiffies_to_msecs(dql->stall_thrs));
> +}
> +
> +static ssize_t bql_set_stall_thrs(struct netdev_queue *queue,
> +				  const char *buf, size_t len)
> +{
> +	struct dql *dql =3D &queue->dql;
> +	unsigned int value;
> +	int err;
> +
> +	err =3D kstrtouint(buf, 10, &value);
> +	if (err < 0)
> +		return err;
> +
> +	value =3D msecs_to_jiffies(value);
> +	if (value && (value < 4 || value > 4 / 2 * BITS_PER_LONG))

I admit I'm more than a bit lost with constant usage.. why 4/2 here?
Perhaps some more comments describing the implement logic would be
helpful.

Thanks!

Paolo


