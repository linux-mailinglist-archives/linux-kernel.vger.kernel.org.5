Return-Path: <linux-kernel+bounces-158310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C21E98B1E27
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A491F24536
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D8685939;
	Thu, 25 Apr 2024 09:36:17 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8539C28F7;
	Thu, 25 Apr 2024 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714037776; cv=none; b=PfqC2BF1CA0X1otmjN9yBPu4nR/vb/Mz1p0WETVhXaoFpanBQChifQ4Ir7yWJH+427/7TA7WzripVCp5dAsyDOFSdCJmh2TNJ6yxZSxX650B+V5t7fJKdhk70/vusXE8joeQt9xV6aJK6YyvAM1VaT7nD54XunPMsV3dK8qy0rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714037776; c=relaxed/simple;
	bh=Bj0ZQY1fsfYT5ptnAo2M/eBI3dM8XVsmZlPJfOdCnWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRJ2JhNCZ/T5unc2xqc+Cx/Ugjs5K8yru/mb6f1yD6LqFXm30bHIIFcdhy6lgn7IiWsT9T+JGxICQnzpKRcWFNygxN9/n64SAzXDA/BNegdXxXYsvVeCxCEiQbin36F5dcWI8gMXbaxfEzPj3gtcXzNDjoCJ+hGGhgAVcyEWz94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Date: Thu, 25 Apr 2024 11:36:11 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: linke li <lilinke99@qq.com>
Cc: xujianhao01@gmail.com, Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: mark racy access on ext->gen_id
Message-ID: <ZiokCzm41m21CxLR@calendula>
References: <tencent_284407955020261D1B2BD142194A87C9EB0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_284407955020261D1B2BD142194A87C9EB0A@qq.com>

On Tue, Apr 23, 2024 at 07:50:22PM +0800, linke li wrote:
> In __nf_ct_ext_find(), ext->gen_id can be changed by 
> nf_ct_ext_valid_post(), using WRITE_ONCE. Mark data races on ext->gen_id
> as benign using READ_ONCE. 
> 
> This patch is aimed at reducing the number of benign races reported by
> KCSAN in order to focus future debugging effort on harmful races.

There are a more uses ext->gen_id in the code, my understanding this
patch is just a stub.

