Return-Path: <linux-kernel+bounces-108155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763FD8806C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17DBDB218E2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFF240851;
	Tue, 19 Mar 2024 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9ueXtCv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A1440844;
	Tue, 19 Mar 2024 21:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710883939; cv=none; b=R+KWUXIiM+/1xVoc897tFNlziBKU1g+23ejfNSdKziy8q9gaYRZAdt5JHwibM6fVd2K/jps5sJwiu89iqH/6H5u+GrZjUwNiF69ME4dlkhO95fNv0mZ3/59E6YufdOes06pcBRQCNtHehEb2oZKQ2RfRCHRFXDgP4gzpBwiowdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710883939; c=relaxed/simple;
	bh=wHi1QgX7LbP6dkCBxVzG1neumr3N6oxJ810Rng9EFVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bG2GnGAM/GP6M4yisk1AqOI/sy+TLnTB3TUiCALKL+VvodvoZc4q+QBwXoUpeKRPfu73EC9n80FXaUXUibeJnLE3O359Ermtaoo4lQHW1euik17ko0GX069Kyk3sEzE3mEgl+jwH0/GqcfYznd44ktYMnS0N1YsJ2sOkWU/nBxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9ueXtCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9D5C433C7;
	Tue, 19 Mar 2024 21:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710883939;
	bh=wHi1QgX7LbP6dkCBxVzG1neumr3N6oxJ810Rng9EFVM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=f9ueXtCv+oeQzrfUVrvcMV6FTHy+HXrdV7p/VhHpfole0YRA+M8SmwkhlUunVr9Te
	 M2O3ks/cUjqfWYu2MCU+5U/Rh1P7RHHD1p7LYxutcJ+kht55pEYVucbHDBzzSYRbxg
	 YBpeQPOmEUc7OrWnY9LcS9Ju0ABHaWNp5SlRaCoqrlmafklmH7PRCC9L9KxIBTbFlD
	 t1apSMCBjotewL4t0lKjSBgf+RDsfbL530BFxMoe+5AQ54/ukr6VBXhXyfaLBy5NYo
	 YK1bbMm/IJnlJuWFCeHvqId23ij6qzbGRYK3+4scK07y6hIPBwtQ+y6kVXZkSiekwa
	 tr7xafevR970A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 30369CE16D7; Tue, 19 Mar 2024 14:32:16 -0700 (PDT)
Date: Tue, 19 Mar 2024 14:32:16 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v5 net 2/3] net: report RCU QS on threaded NAPI repolling
Message-ID: <417655d4-ba74-4f21-89f4-4cf41c6645ae@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cover.1710877680.git.yan@cloudflare.com>
 <4c3b0d3f32d3b18949d75b18e5e1d9f13a24f025.1710877680.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c3b0d3f32d3b18949d75b18e5e1d9f13a24f025.1710877680.git.yan@cloudflare.com>

On Tue, Mar 19, 2024 at 01:44:37PM -0700, Yan Zhai wrote:
> NAPI threads can keep polling packets under load. Currently it is only
> calling cond_resched() before repolling, but it is not sufficient to
> clear out the holdout of RCU tasks, which prevent BPF tracing programs
> from detaching for long period. This can be reproduced easily with
> following set up:
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
>     ip netns exec test2 iptables -I INPUT -s 3.3.$i.$j -p udp --dport 5201
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
> ip netns exec test1 iperf3 -c 2.2.2.2 -B 1.1.1.1 -u -l 1500 -b 3g -t 100 >/dev/null&
> bpftrace -e 'kfunc:__napi_poll{@=count();} interval:s:1{exit();}'
> 
> Report RCU quiescent states periodically will resolve the issue.
> 
> Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop support")
> Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> v2->v3: abstracted the work into a RCU helper
> v1->v2: moved rcu_softirq_qs out from bh critical section, and only
> raise it after a second of repolling. Added some brief perf test result.
> 
> v2: https://lore.kernel.org/bpf/ZeFPz4D121TgvCje@debian.debian/
> v1: https://lore.kernel.org/lkml/Zd4DXTyCf17lcTfq@debian.debian/#t
> ---
>  net/core/dev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 303a6ff46e4e..9a67003e49db 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6743,6 +6743,8 @@ static int napi_threaded_poll(void *data)
>  	void *have;
>  
>  	while (!napi_thread_wait(napi)) {
> +		unsigned long last_qs = jiffies;
> +
>  		for (;;) {
>  			bool repoll = false;
>  
> @@ -6767,6 +6769,7 @@ static int napi_threaded_poll(void *data)
>  			if (!repoll)
>  				break;
>  
> +			rcu_softirq_qs_periodic(last_qs);
>  			cond_resched();
>  		}
>  	}
> -- 
> 2.30.2
> 
> 

