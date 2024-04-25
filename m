Return-Path: <linux-kernel+bounces-158352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1430E8B1EBA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7891C21E41
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B708627A;
	Thu, 25 Apr 2024 10:04:34 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82245D477;
	Thu, 25 Apr 2024 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039474; cv=none; b=cTRWSAMg1jh4JCiGiGttdQdWCbTGvdro+1tWmKe6zC/uQaeGYQIzZmL0u257rLXRyU6bhUShE8tDCD5l8YFfwMvBiiKpzGmMIMhcHZpA42expoG++wJUcKFOSmmRknXVSVQce42eCjXTMHPN8BWo+MOG6gyrdpJl96PFrCBvMKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039474; c=relaxed/simple;
	bh=T4/SvwSb/RpceslN4TdWuVNb2RScrhueN/tYDCHMa3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0/cB7oOrUoUPYctDxiF0ENQ9y4M0W3vC4McmQ1mb3zdkGUOwyWPX5/f3DZIGAwcGkfoBif5F+kU23Z6o70GcUn1jHJBSP87qOq3+uX8mF19UK1+kCGa66cUNUCntkxR3JBMXqSXI93oYZXoh3V8OtQa7Pi6kjkZJZxox7ElZVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rzvxa-000733-M9; Thu, 25 Apr 2024 12:04:10 +0200
Date: Thu, 25 Apr 2024 12:04:10 +0200
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, linke li <lilinke99@qq.com>,
	xujianhao01@gmail.com, Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: mark racy access on ext->gen_id
Message-ID: <20240425100410.GB29182@breakpoint.cc>
References: <tencent_284407955020261D1B2BD142194A87C9EB0A@qq.com>
 <ZiokCzm41m21CxLR@calendula>
 <CANn89iLxRgYSsFokDo327B4CwwwN9B1Q8e+OHvQenn0a5SfxDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iLxRgYSsFokDo327B4CwwwN9B1Q8e+OHvQenn0a5SfxDQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Eric Dumazet <edumazet@google.com> wrote:
> > There are a more uses ext->gen_id in the code, my understanding this
> > patch is just a stub.
> 
> Anyway, ext->gen_id was already read and stored in @this_id
> 
> I would probably avoid reading it a second time.
 
> diff --git a/net/netfilter/nf_conntrack_extend.c
> b/net/netfilter/nf_conntrack_extend.c
> index dd62cc12e7750734fec9be8a90fd0defcbc815e0..747797b20bc7417a2b7270d84f62d24991a4b982
> 100644
> --- a/net/netfilter/nf_conntrack_extend.c
> +++ b/net/netfilter/nf_conntrack_extend.c
> @@ -141,7 +141,7 @@ void *__nf_ct_ext_find(const struct nf_ct_ext *ext, u8 id)
>         if (!__nf_ct_ext_exist(ext, id))
>                 return NULL;
> 
> -       if (this_id == 0 || ext->gen_id == gen_id)
> +       if (this_id == 0 || this_id == gen_id)
>                 return (void *)ext + ext->offset[id];
> 
>         return NULL;
> 

Right, that should work, unconfirmed entries are not exposed to other
cpus and confirmed entries get their id set to 0.

