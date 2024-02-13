Return-Path: <linux-kernel+bounces-63652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876BF8532CC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861A91C26A29
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDC157889;
	Tue, 13 Feb 2024 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nm8+bCWW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D6656767
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833784; cv=none; b=S2p8v2yxufN2zmXerz4CG59FvhcDIlFTQlNnQjNmSr0IL8csUkWSw1vl5TwzKuF6QdiVzrkc8nT4WZXYyxhC5SKeh23xONSswSl4nLhStYk7hn2LZDXCcXSaBH/gcD27xbIwYxggVJbgjGXJx6Uz+qWXpENksnXd5UxqcYg2uGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833784; c=relaxed/simple;
	bh=mR9jE69DxA0qjgdPZMgyZugnq7WaKrvj0wxkNxXUAwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhMdT/S6YdgUxGjA2KqxerWNWwazTiwAmPwvfaKjlj8bH+k81wauLYmen1xt4wNoRj5p3ovqSDObf7XS7YFHquPm7NGbSjhrQNoShVa5qZOvHdiyjDQW4ZkPp18DlVQ8h7T522YR20pbVW8Rpd9R2nD9Xm5Q+wypkUBWQFCDl4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nm8+bCWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAE7C433F1;
	Tue, 13 Feb 2024 14:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707833783;
	bh=mR9jE69DxA0qjgdPZMgyZugnq7WaKrvj0wxkNxXUAwY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Nm8+bCWWU3tNlaGS4FhfNlZhZC1QxWkWM49FpdudJtGWG1b/cTUBu9D2TojeKkmgq
	 d11GbN5trwePODA3An27JrSRfOMRwvWMLZXBLyFLxC/PgRZKVzqsTpLx66xrO9Ksxk
	 kAZgL51bBzP1+SagOZI8FUDyUcboo1VvXMcCxwXxtSNwtI2WQTTOt74aP27JNAszqK
	 BUgzrsR05dfhO672qW57JOCNNJ8MnvvWsfph7MuRHnD+784v98Lwhy7RCuFTnmH3f5
	 KVqfu8rAWoaxk4zt3TEWESs7E1VINIpqYIrDrmW3wL992LwlzFzuw5z9tSbyx1uTZP
	 aP0Y7uBd2pZKQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EEC92CE1C11; Tue, 13 Feb 2024 06:16:22 -0800 (PST)
Date: Tue, 13 Feb 2024 06:16:22 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Gang Li <gang.li@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Jane Chu <jane.chu@oracle.com>, Muchun Song <muchun.song@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	Gang Li <ligang.bdlg@bytedance.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v1 0/2] hugetlb: two small improvements of hugetlb init
 parallelization
Message-ID: <25c09dd0-48af-4a6b-a009-95539cef7785@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240213111347.3189206-1-gang.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213111347.3189206-1-gang.li@linux.dev>

On Tue, Feb 13, 2024 at 07:13:45PM +0800, Gang Li wrote:
> This series includes two improvements: fixing the PADATA Kconfig warning
> and a potential bug in gather_bootmem_prealloc_parallel. Please refer to
> the specific commit message for details.
> 
> For Andrew:
> If you want me to include these two fixes into the previous series[1], I
> would be happy to send v6. Otherwise, you can directly apply these two
> patches.
> 
> [1]. https://lore.kernel.org/lkml/20240126152411.1238072-1-gang.li@linux.dev/

Thank you!

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> Gang Li (2):
>   padata: downgrade padata_do_multithreaded to serial execution for
>     non-SMP
>   hugetlb: process multiple lists in gather_bootmem_prealloc_parallel
> 
>  fs/Kconfig             |  2 +-
>  include/linux/padata.h | 13 +++++++++----
>  mm/hugetlb.c           | 15 +++++++++++----
>  3 files changed, 21 insertions(+), 9 deletions(-)
> 
> -- 
> 2.20.1
> 

