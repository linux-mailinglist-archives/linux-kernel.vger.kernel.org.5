Return-Path: <linux-kernel+bounces-160764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2288B4281
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7CA1C21447
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF093B782;
	Fri, 26 Apr 2024 23:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSP+Ao3T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB0863A9;
	Fri, 26 Apr 2024 23:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714172833; cv=none; b=ko8vPqrpU5h3Sv2Wv30tcH0kZoTVxKWQTs6Y7K0+4f2xWIXr3xwlOlEDJOQNyLuGnCKQs3KqJ2jPR7R4JoxmzL0niojpYayp3gvGITu/9iqLnXHN0F3wDFXELZJvK4ErwABL3vfyOnITF0ZuNy0QQg83UqN63hT0D1/owVqXG04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714172833; c=relaxed/simple;
	bh=KoojGFy+JrtPKQmbUwRNQIrM8CnY7+bm7FaKHPZkLic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCaOlGg8XEZUuBZ8gK3+tQ4L4Jp57TJE3r3WslY9HDA9o3ykZOx/le6XP8GH7qUTYwL5uJg7CrARMrXHO7c9pKyJ2dEn8KpV+DssvHGyBRrFwTMB2Tan/xBI5Et2Bx5FL3mUOrSFiXTONaSMseY/9BEqFYixlxkG/iQNqS9cc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSP+Ao3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C36CC113CD;
	Fri, 26 Apr 2024 23:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714172832;
	bh=KoojGFy+JrtPKQmbUwRNQIrM8CnY7+bm7FaKHPZkLic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HSP+Ao3TUzFiOIcogruEQEp1VoHwB1B1oSeW2CSPQRZux5Pf6zBOrMWyEtJbGoNVr
	 0pG264mwOAt5cqY2ssYYwIB1pB9rpCw4Li/wTXceKapR/ErebKFxhiVsYFfiWmRGr+
	 5J1iC/o6aqYk8TuDo4H/1co6wXwGRJTvfkpkJut9owS9YXST6DqjHZxcmCj1hHGZio
	 1J5n2hdxFXY8VLjlBrxDDfXY1g5Aw4XyoZAea6VvvT7870O5olKHAqYXXZz9m5WmxM
	 PHcdJWUSn0wsoPwWMS625/qmidcxVvLschMAE64oNey5173I9GUJ+WPSKeisEvGniZ
	 AdY0uvWxo75JQ==
Date: Fri, 26 Apr 2024 16:07:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "jacob.e.keller@intel.com"
 <jacob.e.keller@intel.com>, "edumazet@google.com" <edumazet@google.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "ilias.apalodimas@linaro.org"
 <ilias.apalodimas@linaro.org>, Jianbo Liu <jianbol@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] net: Fix one page_pool page leak from
 skb_frag_unref
Message-ID: <20240426160711.4fd99586@kernel.org>
In-Reply-To: <CAHS8izMbAJHatnM6SvsZVLPY+N7LgGJg03pSdNfSRFCufGh9Zg@mail.gmail.com>
References: <20240424165646.1625690-2-dtatulea@nvidia.com>
	<4ba023709249e11d97c78a98ac7db3b37f419960.camel@nvidia.com>
	<CAHS8izMbAJHatnM6SvsZVLPY+N7LgGJg03pSdNfSRFCufGh9Zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2024 15:08:42 -0700 Mina Almasry wrote:
> I'm unable to repro this issue. Do you need to do anything special? Or
> is 1 flow that hits skb_segment() good enough?

At some point we may want to start writing unit tests to make sure 
we don't regress the 5 corner cases we found previously.. ;)
Should be easy to operate on skbs under kunit.

