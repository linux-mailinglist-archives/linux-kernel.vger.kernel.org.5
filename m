Return-Path: <linux-kernel+bounces-165313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45608B8B19
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79E01C21660
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3B112E1DC;
	Wed,  1 May 2024 13:22:31 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A15012E1C4
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714569750; cv=none; b=Nu40dKrLjG2tL2H7DMzns6qxXHUPYvKZCwA0D2in8wLLI5J7yDcp1xUBGWNYmcDIRJbntmqXkt3eG/HgvBE+8HDMXT93+zeJbHS9njVgv7G0hw8iss+8IkK9kSiqDyuJSnpizDAbmlNlK0K8FO/ttYe//i0llTAZAmoPTgI8HOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714569750; c=relaxed/simple;
	bh=gozmKD4gz2TfdHsspJfpOMrWaKtGaqJSlHwDFew6Dhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPCg7t5SUbfvIRyyUWuDpgZWxn+koeM4+NNVxhgCFwoqDEe9mGVCQ3NllocGyakKHJh0QLBbnIrdC/T4rafRnv8HzndGmhO9uyIFF0sU9kLCMDlUpNlxTBtN+aKM6QfGR1H3QXVoquuyHuTxcPUl3nxc4B/H8rpVJf9SLTmOi8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-raJRK7aQOAeoJjogj82kFg-1; Wed,
 01 May 2024 09:22:19 -0400
X-MC-Unique: raJRK7aQOAeoJjogj82kFg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CE7F385A18E;
	Wed,  1 May 2024 13:22:16 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 52B561121312;
	Wed,  1 May 2024 13:22:08 +0000 (UTC)
Date: Wed, 1 May 2024 15:22:08 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: j.granados@samsung.com
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Ahern <dsahern@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Remi Denis-Courmont <courmisch@gmail.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>, Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>, Martin Schiller <ms@dev.tdt.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>,
	Joerg Reuter <jreuter@yaina.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dccp@vger.kernel.org,
	linux-wpan@vger.kernel.org, mptcp@lists.linux.dev,
	linux-hams@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-afs@lists.infradead.org,
	linux-sctp@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
	linux-x25@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev,
	lvs-devel@vger.kernel.org
Subject: Re: [PATCH net-next v6 0/8] sysctl: Remove sentinel elements from
 networking
Message-ID: <ZjJCANEjFK890VCA@hog>
References: <20240501-jag-sysctl_remset_net-v6-0-370b702b6b4a@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240501-jag-sysctl_remset_net-v6-0-370b702b6b4a@samsung.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

2024-05-01, 11:29:24 +0200, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
> 
> What?
> These commits remove the sentinel element (last empty element) from the
> sysctl arrays of all the files under the "net/" directory that register
> a sysctl array. The merging of the preparation patches [4] to mainline
> allows us to just remove sentinel elements without changing behavior.
> This is safe because the sysctl registration code (register_sysctl() and
> friends) use the array size in addition to checking for a sentinel [1].
> 
> Why?
> By removing the sysctl sentinel elements we avoid kernel bloat as
> ctl_table arrays get moved out of kernel/sysctl.c into their own
> respective subsystems. This move was started long ago to avoid merge
> conflicts; the sentinel removal bit came after Mathew Wilcox suggested
> it to avoid bloating the kernel by one element as arrays moved out. This
> patchset will reduce the overall build time size of the kernel and run
> time memory bloat by about ~64 bytes per declared ctl_table array (more
> info here [5]).
> 
> When are we done?
> There are 4 patchest (25 commits [2]) that are still outstanding to
> completely remove the sentinels: files under "net/" (this patchset),
> files under "kernel/" dir, misc dirs (files under mm/ security/ and
> others) and the final set that removes the unneeded check for ->procname
> == NULL.
> 
> Testing:
> * Ran sysctl selftests (./tools/testing/selftests/sysctl/sysctl.sh)
> * Ran this through 0-day with no errors or warnings
> 
> Savings in vmlinux:
>   A total of 64 bytes per sentinel is saved after removal; I measured in
>   x86_64 to give an idea of the aggregated savings. The actual savings
>   will depend on individual kernel configuration.
>     * bloat-o-meter
>         - The "yesall" config saves 3976 bytes (bloat-o-meter output [6])
>         - A reduced config [3] saves 1263 bytes (bloat-o-meter output [7])
> 
> Savings in allocated memory:
>   None in this set but will occur when the superfluous allocations are
>   removed from proc_sysctl.c. I include it here for context. The
>   estimated savings during boot for config [3] are 6272 bytes. See [8]
>   for how to measure it.
> 
> Comments/feedback greatly appreciated
> 
> Changes in v6:
> - Rebased onto net-next/main.
> - Besides re-running my cocci scripts, I ran a new find script [9].
>   Found 0 hits in net/
> - Moved "i" variable declaraction out of for() in sysctl_core_net_init
> - Removed forgotten sentinel in mpls_table
> - Removed CONFIG_AX25_DAMA_SLAVE guard from net/ax25/ax25_ds_timer.c. It
>   is not needed because that file is compiled only when
>   CONFIG_AX25_DAMA_SLAVE is set.
> - When traversing smc_table, stop on ARRAY_SIZE instead of ARRAY_SIZE-1.
> - Link to v5: https://lore.kernel.org/r/20240426-jag-sysctl_remset_net-v5-0-e3b12f6111a6@samsung.com

I pointed out a few tiny details in the ax25 patch but either way, the
series looks good to me. Thanks!

Series:
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Note that you could have kept the ack/reviewed-by on patch 4 since it
was not modified. Jeff and Chuck, your reviews got lost in the repost.

-- 
Sabrina


