Return-Path: <linux-kernel+bounces-87882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0741686DA5D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E6A1C20D11
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E819447F6A;
	Fri,  1 Mar 2024 03:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RyNVqiCB"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242C22F5B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 03:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709265011; cv=none; b=P3bOT8Hi/TZ/FI/DCc4zXJZJ+p4xYQtKBGd5yofq3U5O1HVA4gcbc/X6J7THSt4qimVxiBznXs661+cyWDUDQVGtMvkRtH8OW9Xd577QUqRf9C1oX1c7g0DdW94V8az0kvrvq6PzBIyM0X4GmjxXVecydu2LvfXvh7bJGKmEfUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709265011; c=relaxed/simple;
	bh=uPw6Ok9OigX8h+kBZiUmWmz7PVWG2C6QTzBSqowPZ8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLQoPOixMBnk4+ylnhMfzPc+OjGeGu1e5uwFrhRU5yvv7C1O3+W5ZHu0sTTokPXiGXhkwlIfDjeazsFgUczwUDq0ikduvxH5HaSHpNBH5bZ4yJQxJPsTqSE20/aVDWRVtI/yjSUj4V2R9jv1McUi1xEr/IcXP6ZCde3R0i8gQpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RyNVqiCB; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so289015566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 19:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1709265007; x=1709869807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+3NRDVXjjhqZT6WozelkxjPXqAsZxeRxj+ykKPb3iw=;
        b=RyNVqiCBcdz0u88nJ9QJW+dqo4i/gvmOpnYbCO/TgupF1wfzMRiLIBhnPuGRItm/ls
         Tms3LPPaZ4WQ17pHtVrCBhRC1jK0dvg6b16T8J13dHei/7qrrJ0yrTvKeuF9cYhWz0za
         zzgWtlXGWY9iNZP9BYFCsc/BFH2AfSUR05z7vVb5ZDl1J8ssuMTIsf6DEi+dH6pJpNjc
         LA4zNd2/0K77U+sWwuMzE0TfSRtrg+vNhjlWoa7qMnJFPT8lovF2BMdcL2BZEdh2T+0z
         gHvyiMzqFXOtds/402FGA8fDk3ikW3XrXG1bgTgnkLaQN0osJInIfjrsECVjWyIrbTGC
         KXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709265007; x=1709869807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+3NRDVXjjhqZT6WozelkxjPXqAsZxeRxj+ykKPb3iw=;
        b=epDJJ0SHaNwewKwFQMr0YCGoQ40//3d0mFXQWvOpEI2aIhLz8kGv9BsUTa/uMAPTjZ
         +UgS68Kw/0eqOI7VJ0Wsust+6D6/Jx5Z2A8o3cWsJqeYV1SZaFWwabojaHif0zgVyK+D
         8XBLFTPeQ8G71Pr2fz9tmGVPjHDJX/J9MXL+EU35kiXj4157FrF9xijT4WwGQoiOxpml
         5ZmRd4cSfZ0Ni919YNyyX/cvZuGAm69BHc/ciwD9ifu4jxGJ7BOHAOOViex04BeT1j4c
         W3qT876TcGRxf6rzFHUqqQJCRoT7kNo8yZMy/ZiDeB+UEXhGkUMXGpSJfHY/RGD/Ao4e
         1zQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvBehQQDwSfAaT8YupGis1qkO3iMpWGcwbPtGkFgB+p5hp69uiiApty+KmpGFzZIdHo8n0M3OLiUqhDZCVu9mkQM2AcrvFmzwLd/cS
X-Gm-Message-State: AOJu0Yyn/m5Q9WQyIgmJNJZqxseehXWIl+Y/99AA0DtDM0Um5jiuOYva
	E9+17Zhfnsqm5bcbZIPfWJH4yMgiyuuZw3Vtv83Ehg80aLY4GK1CAExZFa1xfzGcnJCbuU5udDy
	nSxo7LrKD+B4OY1WRq9E9hpZSzK8Sq3fA5qazdA==
X-Google-Smtp-Source: AGHT+IFDOb0z2VP0FGReVj1kh0Mm/cm6JzaXWyns0ZBLDO76FBn53/tdxCSbIEXB3eY7OUGQ8/ZdK7v5e2XQ54WX7tY=
X-Received: by 2002:a17:906:cd03:b0:a3d:ce2c:b06a with SMTP id
 oz3-20020a170906cd0300b00a3dce2cb06amr329158ejb.22.1709265007335; Thu, 29 Feb
 2024 19:50:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZeFPz4D121TgvCje@debian.debian>
In-Reply-To: <ZeFPz4D121TgvCje@debian.debian>
From: Yan Zhai <yan@cloudflare.com>
Date: Thu, 29 Feb 2024 21:49:56 -0600
Message-ID: <CAO3-PboqKqjqrAScqzu6aB8d+fOq97_Wuz8b7d5uoMKT-+-WvQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: raise RCU qs after each threaded NAPI poll
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com, Joel Fernandes <joel@joelfernandes.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 9:47=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> We noticed task RCUs being blocked when threaded NAPIs are very busy at
> workloads: detaching any BPF tracing programs, i.e. removing a ftrace
> trampoline, will simply block for very long in rcu_tasks_wait_gp. This
> ranges from hundreds of seconds to even an hour, severely harming any
> observability tools that rely on BPF tracing programs. It can be
> easily reproduced locally with following setup:
>
> ip netns add test1
> ip netns add test2
>
> ip -n test1 link add veth1 type veth peer name veth2 netns test2
>
> ip -n test1 link set veth1 up
> ip -n test1 link set lo up
> ip -n test2 link set veth2 up
> ip -n test2 link set lo up
>
> ip -n test1 addr add 192.168.1.2/31 dev veth1
> ip -n test1 addr add 1.1.1.1/32 dev lo
> ip -n test2 addr add 192.168.1.3/31 dev veth2
> ip -n test2 addr add 2.2.2.2/31 dev lo
>
> ip -n test1 route add default via 192.168.1.3
> ip -n test2 route add default via 192.168.1.2
>
> for i in `seq 10 210`; do
>  for j in `seq 10 210`; do
>     ip netns exec test2 iptables -I INPUT -s 3.3.$i.$j -p udp --dport 520=
1
>  done
> done
>
> ip netns exec test2 ethtool -K veth2 gro on
> ip netns exec test2 bash -c 'echo 1 > /sys/class/net/veth2/threaded'
> ip netns exec test1 ethtool -K veth1 tso off
>
> Then run an iperf3 client/server and a bpftrace script can trigger it:
>
> ip netns exec test2 iperf3 -s -B 2.2.2.2 >/dev/null&
> ip netns exec test1 iperf3 -c 2.2.2.2 -B 1.1.1.1 -u -l 1500 -b 3g -t 100 =
>/dev/null&
> bpftrace -e 'kfunc:__napi_poll{@=3Dcount();} interval:s:1{exit();}'
>
> Above reproduce for net-next kernel with following RCU and preempt
> configuraitons:
>
> # RCU Subsystem
> CONFIG_TREE_RCU=3Dy
> CONFIG_PREEMPT_RCU=3Dy
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=3Dy
> CONFIG_TREE_SRCU=3Dy
> CONFIG_TASKS_RCU_GENERIC=3Dy
> CONFIG_TASKS_RCU=3Dy
> CONFIG_TASKS_RUDE_RCU=3Dy
> CONFIG_TASKS_TRACE_RCU=3Dy
> CONFIG_RCU_STALL_COMMON=3Dy
> CONFIG_RCU_NEED_SEGCBLIST=3Dy
> # end of RCU Subsystem
> # RCU Debugging
> # CONFIG_RCU_SCALE_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_RCU_REF_SCALE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=3D21
> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=3D0
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
> # end of RCU Debugging
>
> CONFIG_PREEMPT_BUILD=3Dy
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=3Dy
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_COUNT=3Dy
> CONFIG_PREEMPTION=3Dy
> CONFIG_PREEMPT_DYNAMIC=3Dy
> CONFIG_PREEMPT_RCU=3Dy
> CONFIG_HAVE_PREEMPT_DYNAMIC=3Dy
> CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=3Dy
> CONFIG_PREEMPT_NOTIFIERS=3Dy
> # CONFIG_DEBUG_PREEMPT is not set
> # CONFIG_PREEMPT_TRACER is not set
> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
>
> An interesting observation is that, while tasks RCUs are blocked,
> related NAPI thread is still being scheduled (even across cores)
> regularly. Looking at the gp conditions, I am inclining to cond_resched
> after each __napi_poll being the problem: cond_resched enters the
> scheduler with PREEMPT bit, which does not account as a gp for tasks
> RCUs. Meanwhile, since the thread has been frequently resched, the
> normal scheduling point (no PREEMPT bit, accounted as a task RCU gp)
> seems to have very little chance to kick in. Given the nature of "busy
> polling" program, such NAPI thread won't have task->nvcsw or task->on_rq
> updated (other gp conditions), the result is that such NAPI thread is
> put on RCU holdouts list for indefinitely long time.
>
> This is simply fixed by adapting similar behavior of ksoftirqd: after
> the thread repolls for a while, raise a RCU QS to help expedite the
> tasks RCU grace period. No more blocking afterwards.
>
> Some brief iperf3 throughput testing in my VM with net-next kernel shows =
no
> noteable perf difference with 1500 byte MTU for 10 repeat runs each:
>
> Before:
> UDP:  3.073Gbps (+-0.070Gbps)
> TCP: 37.850Gbps (+-1.947Gbps)
>
> After:
> UDP:  3.077Gbps (+-0.121 Gbps)
> TCP: 38.120Gbps (+-2.272 Gbps)
>
> Note I didn't enable GRO for UDP so its throughput is lower than TCP.
>
> Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop support=
")
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
> v1->v2: moved rcu_softirq_qs out from bh critical section, and only
> raise it after a second of repolling. Added some brief perf test result.
>
Link to v1: https://lore.kernel.org/netdev/Zd4DXTyCf17lcTfq@debian.debian/T=
/#u
And I apparently forgot to rename the subject since it's not raising
after every poll (let me know if it is prefered to send a V3 to fix
it)

thanks
Yan

> ---
>  net/core/dev.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 275fd5259a4a..76cff3849e1f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6751,9 +6751,12 @@ static int napi_threaded_poll(void *data)
>  {
>         struct napi_struct *napi =3D data;
>         struct softnet_data *sd;
> +       unsigned long next_qs;
>         void *have;
>
>         while (!napi_thread_wait(napi)) {
> +               next_qs =3D jiffies + HZ;
> +
>                 for (;;) {
>                         bool repoll =3D false;
>
> @@ -6778,6 +6781,21 @@ static int napi_threaded_poll(void *data)
>                         if (!repoll)
>                                 break;
>
> +                       /* cond_resched cannot unblock tasks RCU writers,=
 so it
> +                        * is necessary to relax periodically and raise a=
 QS to
> +                        * avoid starving writers under frequent repoll, =
e.g.
> +                        * ftrace trampoline clean up work. When not repo=
ll,
> +                        * napi_thread_wait will enter sleep and have the=
 same
> +                        * QS effect.
> +                        */
> +                       if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> +                           time_after(jiffies, next_qs)) {
> +                               preempt_disable();
> +                               rcu_softirq_qs();
> +                               preempt_enable();
> +                               next_qs =3D jiffies + HZ;
> +                       }
> +
>                         cond_resched();
>                 }
>         }
> --
> 2.30.2
>

