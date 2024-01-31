Return-Path: <linux-kernel+bounces-45547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB33843240
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B35C281631
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB824184F;
	Wed, 31 Jan 2024 00:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRcXaOyf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0809B376;
	Wed, 31 Jan 2024 00:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706662032; cv=none; b=C4BlXmhEXGcLr8eWO9FfS8az4efmPAy2QRZlxq08T53lhZC0gRfu9bCYZQ+c56h8XVj7KgYDk9dGicC8fyGoKr1y57U/Ujp3F38E4GSDZXmrP37IlTr2Dhbg3CnBXDRUugwxhCJz7eEorbgvR6yozIdtFP+1S1AwAzG4/W1hYEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706662032; c=relaxed/simple;
	bh=u/n42ehR8Gzk4ARZK1nf/hRQ7/fGOw0OBBHyEqZCDIE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZD/h3kF7YEUFJTmSJMAaKjsozbE+fJF0EDcs+wPSQrifgd43nDFpzFWq78T5mqfnJDA/0h0LkU5AZt9lEPSyi0/yppfJ+R3Csdktwa4fpgWw5LpW0trYkPwMag2F6ycO8tz2nF8dVotBYwfTwV6//694DxvGr03f3fAJdCOzCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRcXaOyf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91184C433C7;
	Wed, 31 Jan 2024 00:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706662031;
	bh=u/n42ehR8Gzk4ARZK1nf/hRQ7/fGOw0OBBHyEqZCDIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hRcXaOyfnnuCd7YlanR/0JUOOZrbobyeIvl5R6nJrUEm/nqQhfC1lukfYkzEmIyEq
	 lu+VZx01vyPA5nqirtdFNS/ASTedHt4IvkMWsboWCWINi/wjVQcsMzFsX95Kx/CFuS
	 V3mAuY5quid6jfiJIfCfQVtbckXWhyrd90UdNopvzdDTwW55ZNAaf29+yL4gW9mjAk
	 4C/X2bI6eiq9zXWgj09h+yqwOsttq0NjTym+BHI4jNgBh5/VjEQf9/4we8ihCMzkG4
	 hsCTuWLXy9ayaKYvajpdzRxXp7Xl3oiGVVLOZzWdzwXem8gPvKnZtc/9eY5AdP25sE
	 KYNs95NHkwmHA==
Date: Tue, 30 Jan 2024 16:47:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Mina Almasry <almasrymina@google.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Shakeel Butt
 <shakeelb@google.com>, Yunsheng Lin <linyunsheng@huawei.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v6 1/2] net: introduce abstraction for network
 memory
Message-ID: <20240130164706.6eb6a9b3@kernel.org>
In-Reply-To: <0c767128a7ceee72c3cfb4c17498ef3b6fd87a56.camel@redhat.com>
References: <20240123221749.793069-1-almasrymina@google.com>
	<20240123221749.793069-2-almasrymina@google.com>
	<0c767128a7ceee72c3cfb4c17498ef3b6fd87a56.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 10:59:53 +0100 Paolo Abeni wrote:
> > + * netmem_ref - a nonexistent type marking a reference to generic network  
> 
> Minor nit: here you need to prepend 'struct' to avoid a kdoc warning:
> 
> include/net/netmem.h:20: warning: cannot understand function prototype: 'typedef unsigned long __bitwise netmem_ref; '
> 
> Should be:
> 
> * struct netmem_ref - a nonexistent type marking a reference to generic network

s/struct/typedef/

 /**
  * typedef netmem_ref - ....
  */

Somewhat surprisingly kdoc understands the typedef keyword just fine :)

