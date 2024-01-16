Return-Path: <linux-kernel+bounces-27558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A5B82F21C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23FE1C23603
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0B11CA88;
	Tue, 16 Jan 2024 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clg/3LK8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBA11CD05;
	Tue, 16 Jan 2024 16:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5383C433F1;
	Tue, 16 Jan 2024 16:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705421015;
	bh=bHzyF8LGYsF06hfUsvNFRxL+Xu1Z5AeKaWGruhCzQhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=clg/3LK86toiisIJI8OXUvyzpZk5vrEkPjyHd19PwvuGKwe5KUZxipo9cvRq9ayXw
	 j21BDeja9CGey3UR4r2hGGMwS7sICpdxn1MwLKORq0EHdpmb8Gr3r+gFMeXlw9FLEA
	 p522/2VNSbBCFW5A+XTpwtl9IoVnnH+jP6Zx7V2w+VeIyj565UppFza2Uz47TY92/l
	 82L1Ju9QzX4Z4vYj8QdBYGdW0TD/jJlVxnawkaml4daCZfQ1yQiJrPleCUQL5EzGP1
	 OandjRepUw6aG52NaXZISoMeOmjUm+IJkYicg0dTN/e2SQLfkO543sdlBGvleYgcRh
	 eP2qzAn01YGPw==
Date: Tue, 16 Jan 2024 16:03:29 +0000
From: Simon Horman <horms@kernel.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Julian Anastasov <ja@ssi.bg>, Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dwip Banerjee <dwip@linux.vnet.ibm.com>, netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net] net: ipvs: avoid stat macros calls from preemptible
 context
Message-ID: <20240116160329.GB588419@kernel.org>
References: <20240115143923.31243-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115143923.31243-1-pchelkin@ispras.ru>

On Mon, Jan 15, 2024 at 05:39:22PM +0300, Fedor Pchelkin wrote:
> Inside decrement_ttl() upon discovering that the packet ttl has exceeded,
> __IP_INC_STATS and __IP6_INC_STATS macros can be called from preemptible
> context having the following backtrace:
> 
> check_preemption_disabled: 48 callbacks suppressed
> BUG: using __this_cpu_add() in preemptible [00000000] code: curl/1177
> caller is decrement_ttl+0x217/0x830
> CPU: 5 PID: 1177 Comm: curl Not tainted 6.7.0+ #34
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xbd/0xe0
>  check_preemption_disabled+0xd1/0xe0
>  decrement_ttl+0x217/0x830
>  __ip_vs_get_out_rt+0x4e0/0x1ef0
>  ip_vs_nat_xmit+0x205/0xcd0
>  ip_vs_in_hook+0x9b1/0x26a0
>  nf_hook_slow+0xc2/0x210
>  nf_hook+0x1fb/0x770
>  __ip_local_out+0x33b/0x640
>  ip_local_out+0x2a/0x490
>  __ip_queue_xmit+0x990/0x1d10
>  __tcp_transmit_skb+0x288b/0x3d10
>  tcp_connect+0x3466/0x5180
>  tcp_v4_connect+0x1535/0x1bb0
>  __inet_stream_connect+0x40d/0x1040
>  inet_stream_connect+0x57/0xa0
>  __sys_connect_file+0x162/0x1a0
>  __sys_connect+0x137/0x160
>  __x64_sys_connect+0x72/0xb0
>  do_syscall_64+0x6f/0x140
>  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> RIP: 0033:0x7fe6dbbc34e0
> 
> Use the corresponding preemption-aware variants: IP_INC_STATS and
> IP6_INC_STATS.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 8d8e20e2d7bb ("ipvs: Decrement ttl")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Acked-by: Simon Horman <horms@kernel.org>


