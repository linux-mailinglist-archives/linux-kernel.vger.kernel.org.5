Return-Path: <linux-kernel+bounces-165369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0230E8B8BD2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914B71F2235A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D33912F389;
	Wed,  1 May 2024 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfrn5fwv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C813F12F369;
	Wed,  1 May 2024 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714573476; cv=none; b=gorPcIp6WM+kxx4eGpPvokp7CqQ42fIbgtyLMzaFm2cLeUWMjUWFGkK82n6pmore/vedgA8GiJI6Ka3pWzVPQ/53EYqtG1I+upAIZp1bqJWlLKq1IAwN4MxjdZPIX/H+yU6lyRM8OQ7i91cwPJSVLTiVkF16Hz6M9dJXzLP6TAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714573476; c=relaxed/simple;
	bh=5SMHChzXslPomkTdsmjySqWEgGtys1hP+1JViTdT/Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=noNwYKKZ948iuSDeiVqFJnnnBG3IexMhpJ9LfgnjhGJN6J9OglFGjE0oAdDCyzrdSBoQoESSz/ELmyjjrX8ftlqs+w9uu1JleqCsQqTTqHe0oeBTkkfBfqm7jgHO0YHj635cDvhxOKTnNHT9/kqNxFdZgNzavmPzJmbvPSoXm8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfrn5fwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40B4C072AA;
	Wed,  1 May 2024 14:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714573476;
	bh=5SMHChzXslPomkTdsmjySqWEgGtys1hP+1JViTdT/Tw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pfrn5fwvvguoy5iBs6q3RWzQjvxCYThiAH1qBgxpjGW0XmbWcT1ON+jSE99g+1jVD
	 GjOhTFTQcBuk+/t/9u7Z8RUzCw8oY2s/z0IwAHNKIuPtqJUOWNLh+DcO8ZEiIibUtv
	 cLD2JpTuoAjuQ/xu+mAsy9gTsCUR6RGAnBwiq3jlWk81zSjFVXzEwTFX2YDuib5Q2W
	 T301KBrX3FRrbBEKHDV8DBYGnfmys/e2cVmC9T90HKk2ar2skRkfF/y096BRiKaTpQ
	 Eo9gMXekxMBjvwPIkwFTKdZGp2Qxhc8y0o1caJxFmp6pcTcOA7vuvhjmpqndfsB08p
	 +Yw4CyqJ6Zg4g==
Date: Wed, 1 May 2024 07:24:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "ilias.apalodimas@linaro.org"
 <ilias.apalodimas@linaro.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "jacob.e.keller@intel.com"
 <jacob.e.keller@intel.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Jianbo
 Liu <jianbol@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>
Subject: Re: [RFC PATCH] net: Fix one page_pool page leak from
 skb_frag_unref
Message-ID: <20240501072434.5720fd42@kernel.org>
In-Reply-To: <CAHS8izOsFqiSiS4Z-E-jfD70aogNp5Bcyt7Rk8xFoR2TcDjz=g@mail.gmail.com>
References: <20240424165646.1625690-2-dtatulea@nvidia.com>
	<4ba023709249e11d97c78a98ac7db3b37f419960.camel@nvidia.com>
	<CAHS8izMbAJHatnM6SvsZVLPY+N7LgGJg03pSdNfSRFCufGh9Zg@mail.gmail.com>
	<4c20b500c2ed615aba424c0f3c7a79f5f5a04171.camel@nvidia.com>
	<20240426160557.51de91f9@kernel.org>
	<c307a3086d255d1dfed22284f500aa9fb70f11a3.camel@nvidia.com>
	<7a5a1d74040052afc8cc6cc5c2700fdf2e836b0c.camel@nvidia.com>
	<CAHS8izOsFqiSiS4Z-E-jfD70aogNp5Bcyt7Rk8xFoR2TcDjz=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 May 2024 00:48:43 -0700 Mina Almasry wrote:
> > 1) Revert commit 2cc3aeb5eccc
> > ("skbuff: Fix a potential race while recycling page_pool packets"). I tested
> > this btw and it works (for this specific scenario).
> >
> > 2) Revert Mina's commit a580ea994fd3 ("net: mirror skb frag ref/unref helpers")
> > for now.
> 
> I vote for #1, and IIUC Jakub's feedback, he seems to prefer this as
> well.

I vote #2, actually :( Or #3 make page pool ref safe to acquire
concurrently, but that plus fixing all the places where we do crazy
things may be tricky.

Even taking the ref is not as simple as using atomic_long_inc_not_zero()
sadly, partly because we try to keep the refcount at one, in an apparent
attempt to avoid dirtying the cache line twice.

So maybe partial revert to stop be bleeding and retry after more testing
is the way to go?

I had a quick look at the code and there is also a bunch of functions
which "shift" frags from one skb to another, without checking whether
the pp_recycle state matches.

