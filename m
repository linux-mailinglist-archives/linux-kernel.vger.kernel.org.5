Return-Path: <linux-kernel+bounces-121392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D138A88E917
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE446B30643
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C64A140394;
	Wed, 27 Mar 2024 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxYzWUVK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBDF12DD9A;
	Wed, 27 Mar 2024 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711547546; cv=none; b=UR5gZykShg7OMaEak3Lk1NpwwGrIcWKxBFeQRylqypm8Vwyz+8DShu4OmqLY4dbGyYzCp2UJCthcNz7omdVLU5SXDyEiNEziiGeaCzB3gUrntDi9rH5SRaWt4oGdd0oGTFWQ2rbnZWN6fmAqKtllC/Nmdhr3ivB2Tttq1pL9saY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711547546; c=relaxed/simple;
	bh=jg9FTT393fzAorP20OTFEHk2bAT7VNUxgdh7vcxybxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcbbPwOZ1HNgNjJ50rJ5psYWoWbnUL4mKBLsdoHlxzbhR4hN1DpTNf1Z6Jj0Cuv6AXJznCAqgnyTAD4Om6rH1o2APiW/zlByVJQ0uDYnZS84V3WoXOzCLXcavdioZN+k/IqE5jo5mpA/jHnboQryica1/mS5QAczBLn4NxCZv2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxYzWUVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C12FC433C7;
	Wed, 27 Mar 2024 13:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711547546;
	bh=jg9FTT393fzAorP20OTFEHk2bAT7VNUxgdh7vcxybxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SxYzWUVKxN3HfmJqWxnCgfbNgZ4su3KNRtLDhEnrX8GQQg7fgFHlC5zoNPpiSR12l
	 sP63xQXkwN/qTlnII6IUVEGjX4GBQqH3+bJW4HplRajrLLuqN96gra49LlTey09tZP
	 8ESn5Sp7uQpFZQ/SdOaM642XFGMzSSwcGTHuuj2yf8jwfK8BLMNhpeFpPbh/FH0di4
	 ZOzSrXQwnz6JZ3rWxYBqtyjjiZR9JqsjN28lX7auj1NWhAcRR6zXfYE7HIoBiGXk35
	 5ZxQFOQUmfwJs8Ybd3gaw8jhgQ9s4VdGLLPFP/2FRQpt8cZHzd5smr7kZarenBAMP2
	 po2pvvejb9Ctg==
Date: Wed, 27 Mar 2024 13:52:21 +0000
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vlad Buslov <vladbu@nvidia.com>,
	Marcelo Ricardo Leitner <mleitner@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	llu@fiberby.dk
Subject: Re: [PATCH net-next v4 3/3] net: sched: make skip_sw actually skip
 software
Message-ID: <20240327135221.GG403975@kernel.org>
References: <20240325204740.1393349-1-ast@fiberby.net>
 <20240325204740.1393349-4-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240325204740.1393349-4-ast@fiberby.net>

On Mon, Mar 25, 2024 at 08:47:36PM +0000, Asbjørn Sloth Tønnesen wrote:
> TC filters come in 3 variants:
> - no flag (try to process in hardware, but fallback to software))
> - skip_hw (do not process filter by hardware)
> - skip_sw (do not process filter by software)
> 
> However skip_sw is implemented so that the skip_sw
> flag can first be checked, after it has been matched.
> 
> IMHO it's common when using skip_sw, to use it on all rules.
> 
> So if all filters in a block is skip_sw filters, then
> we can bail early, we can thus avoid having to match
> the filters, just to check for the skip_sw flag.
> 
> This patch adds a bypass, for when only TC skip_sw rules
> are used. The bypass is guarded by a static key, to avoid
> harming other workloads.
> 
> There are 3 ways that a packet from a skip_sw ruleset, can
> end up in the kernel path. Although the send packets to a
> non-existent chain way is only improved a few percents, then
> I believe it's worth optimizing the trap and fall-though
> use-cases.
> 
>  +----------------------------+--------+--------+--------+
>  | Test description           | Pre-   | Post-  | Rel.   |
>  |                            | kpps   | kpps   | chg.   |
>  +----------------------------+--------+--------+--------+
>  | basic forwarding + notrack | 3589.3 | 3587.9 |  1.00x |
>  | switch to eswitch mode     | 3081.8 | 3094.7 |  1.00x |
>  | add ingress qdisc          | 3042.9 | 3063.6 |  1.01x |
>  | tc forward in hw / skip_sw |37024.7 |37028.4 |  1.00x |
>  | tc forward in sw / skip_hw | 3245.0 | 3245.3 |  1.00x |
>  +----------------------------+--------+--------+--------+
>  | tests with only skip_sw rules below:                  |
>  +----------------------------+--------+--------+--------+
>  | 1 non-matching rule        | 2694.7 | 3058.7 |  1.14x |
>  | 1 n-m rule, match trap     | 2611.2 | 3323.1 |  1.27x |
>  | 1 n-m rule, goto non-chain | 2886.8 | 2945.9 |  1.02x |
>  | 5 non-matching rules       | 1958.2 | 3061.3 |  1.56x |
>  | 5 n-m rules, match trap    | 1911.9 | 3327.0 |  1.74x |
>  | 5 n-m rules, goto non-chain| 2883.1 | 2947.5 |  1.02x |
>  | 10 non-matching rules      | 1466.3 | 3062.8 |  2.09x |
>  | 10 n-m rules, match trap   | 1444.3 | 3317.9 |  2.30x |
>  | 10 n-m rules,goto non-chain| 2883.1 | 2939.5 |  1.02x |
>  | 25 non-matching rules      |  838.5 | 3058.9 |  3.65x |
>  | 25 n-m rules, match trap   |  824.5 | 3323.0 |  4.03x |
>  | 25 n-m rules,goto non-chain| 2875.8 | 2944.7 |  1.02x |
>  | 50 non-matching rules      |  488.1 | 3054.7 |  6.26x |
>  | 50 n-m rules, match trap   |  484.9 | 3318.5 |  6.84x |
>  | 50 n-m rules,goto non-chain| 2884.1 | 2939.7 |  1.02x |
>  +----------------------------+--------+--------+--------+
> 
> perf top (25 n-m skip_sw rules - pre patch):
>   20.39%  [kernel]  [k] __skb_flow_dissect
>   16.43%  [kernel]  [k] rhashtable_jhash2
>   10.58%  [kernel]  [k] fl_classify
>   10.23%  [kernel]  [k] fl_mask_lookup
>    4.79%  [kernel]  [k] memset_orig
>    2.58%  [kernel]  [k] tcf_classify
>    1.47%  [kernel]  [k] __x86_indirect_thunk_rax
>    1.42%  [kernel]  [k] __dev_queue_xmit
>    1.36%  [kernel]  [k] nft_do_chain
>    1.21%  [kernel]  [k] __rcu_read_lock
> 
> perf top (25 n-m skip_sw rules - post patch):
>    5.12%  [kernel]  [k] __dev_queue_xmit
>    4.77%  [kernel]  [k] nft_do_chain
>    3.65%  [kernel]  [k] dev_gro_receive
>    3.41%  [kernel]  [k] check_preemption_disabled
>    3.14%  [kernel]  [k] mlx5e_skb_from_cqe_mpwrq_nonlinear
>    2.88%  [kernel]  [k] __netif_receive_skb_core.constprop.0
>    2.49%  [kernel]  [k] mlx5e_xmit
>    2.15%  [kernel]  [k] ip_forward
>    1.95%  [kernel]  [k] mlx5e_tc_restore_tunnel
>    1.92%  [kernel]  [k] vlan_gro_receive
> 
> Test setup:
>  DUT: Intel Xeon D-1518 (2.20GHz) w/ Nvidia/Mellanox ConnectX-6 Dx 2x100G
>  Data rate measured on switch (Extreme X690), and DUT connected as
>  a router on a stick, with pktgen and pktsink as VLANs.
>  Pktgen-dpdk was in range 36.6-37.7 Mpps 64B packets across all tests.
>  Full test data at https://files.fiberby.net/ast/2024/tc_skip_sw/v2_tests/
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


