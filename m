Return-Path: <linux-kernel+bounces-56742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E566D84CE76
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992F128A05C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E1180625;
	Wed,  7 Feb 2024 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwoswSA9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF271E4BD;
	Wed,  7 Feb 2024 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321491; cv=none; b=bImMJqG9Lqf4BZnFWqjLMEMaMcEjBGmW/alys7LKPAAL5vZ2XIRRdHI+55qQgL8K2mF5FniJCVnuIbHKjX1QxYSF5RZ3AePdh3cLSi5kWh5DDonLnM9NiMIPlAlMEvnSfq9+wPCWFbYRbX2P/EFBYi4Ssq9HH9o7ckn/Y9Hpxu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321491; c=relaxed/simple;
	bh=/+tRVDx02BW/hh+PutujEBFR9dzXkl6Wjap5CTdPXPI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CXFt83v0ck1ld6rzoan6zkxPsfMsZCKEw1TGzEL5sy4m9ekjswzInnytR5YiGbIqeexD+zjYjUtGmbF5BYM/3+/SH9TSJxNRwCr6rWuxbBVFgCdxTV6MmyZkECBWtwRmKup/LuX9ijEXH7FqBrZGoaKCKXYESnio7bNUmmgHCYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwoswSA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54E3C433F1;
	Wed,  7 Feb 2024 15:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707321489;
	bh=/+tRVDx02BW/hh+PutujEBFR9dzXkl6Wjap5CTdPXPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UwoswSA9DHdlkgDOhoW0q+dEwthdJfdOr9W5gBiE+Ljpp7m7tCG3X6hC0Uxij+Mri
	 XnkOny1SvYfw2Wvh622ZCPwwIdgcCkwdOAHnFCDbRSVi2gAZx7RxRNfrtcbwVWQmKD
	 GXLQaJovT15U7tfaEH5mKFeyQlzffZ9mLZwhQwoUNHxEtIblmHv5/fNC2IDqL77ONS
	 gjQRbXhETF1v/lHL9NvivtgC3/M64y7u8L/w6z+7QxIOYkJX6cSQ/uKRoBG6VmmCcn
	 vLG3L7BhaJLUJ5dZ6TkcIES+av/DSDyf1s1gMsTYyx138HQDmXS2Mo/K+NnhKSGWed
	 qhDM8Z5NCSaAw==
Date: Wed, 7 Feb 2024 07:58:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Ventura <david@davidv.dev>
Cc: Jonathan Corbet <corbet@lwn.net>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Xiongwei Song
 <xiongwei.song@windriver.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: Change default delay on IP autoconfig to 0ms
Message-ID: <20240207075807.5eeed93f@kernel.org>
In-Reply-To: <20240205155717.484198-1-david@davidv.dev>
References: <580001e3-17ef-4f24-8fd8-bc14110e874e@lunn.ch>
	<20240205155717.484198-1-david@davidv.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Feb 2024 16:55:43 +0100 David Ventura wrote:
> As suggested, I'm updating the default to 0ms. 
> 
> This patch depends on 1f0aa0c947eeb4edb60add141a5bc2309f2dc8dd ("
> net: make driver settling time configurable").

Please post a v2, in a new thread, and proper commit description
with a link to the discussion with Andrew.

