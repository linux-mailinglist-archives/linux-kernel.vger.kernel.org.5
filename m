Return-Path: <linux-kernel+bounces-54771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C36884B37C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8CE1C21265
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DA712FF9B;
	Tue,  6 Feb 2024 11:29:58 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6997112B152;
	Tue,  6 Feb 2024 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218997; cv=none; b=pOYv0m4VHFi65DAM7AYR/wiBrFK1bsqmBGdr/lRudnhXABcumRD0wLbGZTj3A7v3ph1OYrxx71Rziy2ZaLto95SbE8Pdnay032cqAFrzINOZYHmL3IfLFf4PqO8ysgsrk3vubzj36xAqOGDG9z2SZp5wSPz4T9aUAn3/wY4oebs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218997; c=relaxed/simple;
	bh=d8j5bVacOldPx0qHulCU26piuVSsiWVjLgm8BB62cJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyh/648J0nYbkQhQicgcoPkrrYzgwiZ2uozGcx8ef2MtBshLWDWgmgzB2Sz8LchDTlXvhU0eMCpV8yBQ2+rSSYMGAeGtcr6KfaawODTXQdZV0sHQ0u4zpdJLtoyVvO34VH4gpPIdSU+ZGB9cisC4+tAPCZshbUGTs4Sb8LplahA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rXJM8-0001Ub-Do; Tue, 06 Feb 2024 12:11:12 +0100
Date: Tue, 6 Feb 2024 12:11:12 +0100
From: Florian Westphal <fw@strlen.de>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, andrea.mattiazzo@suse.com
Subject: Re: [PATCH net] netfilter: nf_tables: fix pointer math issue in
 nft_byteorder_eval()
Message-ID: <20240206111112.GD17626@breakpoint.cc>
References: <15fdceb5-2de5-4453-98b3-cfa9d486e8da@moroto.mountain>
 <20240206104336.ctigqpkunom2ufmn@lion.mk-sys.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206104336.ctigqpkunom2ufmn@lion.mk-sys.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)

Michal Kubecek <mkubecek@suse.cz> wrote:
> I stumbled upon this when the issue got a CVE id (sigh) and I share
> Andrea's (Cc-ed) concern that the fix is incomplete. While the fix,
> commit c301f0981fdd ("netfilter: nf_tables: fix pointer math issue in
> nft_byteorder_eval()") now, fixes the destination side, src is still
> a pointer to u32, i.e. we are reading 64-bit values with relative
> offsets which are multiples of 32 bits.
> 
> Shouldn't we fix this as well, e.g. like indicated below?

No, please remove multi-elem support instead, nothing uses this feature.

