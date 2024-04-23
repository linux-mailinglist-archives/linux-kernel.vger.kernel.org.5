Return-Path: <linux-kernel+bounces-155123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AB78AE58C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43B8289C96
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277A213665C;
	Tue, 23 Apr 2024 12:03:28 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949176EB70;
	Tue, 23 Apr 2024 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873807; cv=none; b=Cqe8/tJ1m+gRyerwm9mkAOIgNZlZ8e6/fPG4YusEVWelAxmWyHwm8mY9kUgSPlQdiAQqY62j78XIcTWnXdpyl6mYU+cmAgz+nUuBbz/EMIZxB6HNbuLsmgZaDjJedeNBpqYtMS7UFwujGFxoRaf5Dik1sOOcP7PvAEaSuieWQoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873807; c=relaxed/simple;
	bh=96I0kNJ+O/vKVFMzIcptJmjvlnHCw6mQHNnzLfM8sjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGvWPSaIkzFomFThNa8UDRjLEZI5yguhZj9jqyP95fxLmlCLgQOCdtelcP8vflcBL5M2bLV+QbW2UX5CUOSgeKP79hxtfqA6heIVYikk3LpbMwrDtdVZHEJA9XHfiPp6AXtotNtiG80hfAmAIW/2S5uG/aZ46HkrGtOz1j5IpNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rzErd-0007SS-Gu; Tue, 23 Apr 2024 14:03:09 +0200
Date: Tue, 23 Apr 2024 14:03:09 +0200
From: Florian Westphal <fw@strlen.de>
To: linke li <lilinke99@qq.com>
Cc: xujianhao01@gmail.com, Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: mark racy access on ext->gen_id
Message-ID: <20240423120309.GA18954@breakpoint.cc>
References: <tencent_284407955020261D1B2BD142194A87C9EB0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_284407955020261D1B2BD142194A87C9EB0A@qq.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

linke li <lilinke99@qq.com> wrote:
> In __nf_ct_ext_find(), ext->gen_id can be changed by 
> nf_ct_ext_valid_post(), using WRITE_ONCE. Mark data races on ext->gen_id
> as benign using READ_ONCE. 
> 
> This patch is aimed at reducing the number of benign races reported by
> KCSAN in order to focus future debugging effort on harmful races.

Acked-by: Florian Westphal <fw@strlen.de>

Should proably go to nf tree.

