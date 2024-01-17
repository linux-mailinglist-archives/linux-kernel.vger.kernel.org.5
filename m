Return-Path: <linux-kernel+bounces-28977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054948305CF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE6E6B229FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D26C1EA77;
	Wed, 17 Jan 2024 12:44:28 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6BE637;
	Wed, 17 Jan 2024 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495467; cv=none; b=IV1tg02pN3ipAL6wHmPthXvUDYxKd3wuIUQb92VRn8ikdhBt4HhUaXTTQfIDVk92N7oTrfi3MsY2wdYdecElqbRbseSA8nkYm89HupfaUw8LGQ/Ou12oaAFY/nX9KdBLiuGGqmaz3KW9Y4C59uvzZsAhPU5z5tIouTuqSIvygM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495467; c=relaxed/simple;
	bh=KoXalv3CDMgZHjdkgvPU6xGKSYFCIOANzZIRheAObrg=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spam-Score; b=HX73OBww9I13jMvEnUf/t1T6wKe8wVAzQzGXQCJbm570rB9yHNA6Tinxz6/owf8/iT+Q0kCT9F1BDp76qoVmawHdd4FU/rJZRwxZDw7Y8eRNWJTyArwmEQkFvXtonZV3k4wUmhtesOxKv3JQwSQXWtAnwTZryMhcMtYpEoidxE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.41.52] (port=34296 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rQ5HH-00DsEM-LJ; Wed, 17 Jan 2024 13:44:21 +0100
Date: Wed, 17 Jan 2024 13:44:18 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>,
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
Message-ID: <ZafLoqDyHxuah5Hi@calendula>
References: <20240115143923.31243-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240115143923.31243-1-pchelkin@ispras.ru>
X-Spam-Score: -1.9 (-)

On Mon, Jan 15, 2024 at 05:39:22PM +0300, Fedor Pchelkin wrote:
> Inside decrement_ttl() upon discovering that the packet ttl has exceeded,
> __IP_INC_STATS and __IP6_INC_STATS macros can be called from preemptible
> context having the following backtrace:
> 
> check_preemption_disabled: 48 callbacks suppressed
> BUG: using __this_cpu_add() in preemptible [00000000] code: curl/1177
> caller is decrement_ttl+0x217/0x830

Applied to nf.git, thanks

