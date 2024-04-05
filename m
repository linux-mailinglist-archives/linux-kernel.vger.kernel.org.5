Return-Path: <linux-kernel+bounces-133538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44AF89A53B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B385A1C21867
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3343C17335B;
	Fri,  5 Apr 2024 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFZ6BxS6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF6417167F;
	Fri,  5 Apr 2024 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346681; cv=none; b=MFFuCyY16ykeUKT7xnHm7cGig4lJLn9VlYDlySiLteV/Oppi50Ows6tkFcrl+F/c+XAkFMOMITzkIYy/bFXtN1m8Bzs5/h4LaK9i4TbakaZ9lIwgvU/zzN/y423NwvHj0V6NIjhbFF2BuYlKhiI6rB1F75IPpTlPBBX/CKS9bJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346681; c=relaxed/simple;
	bh=f/CMxni7jFnpuDFclRQ1sPJPHz81GAHsls7RUeZIdCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DP9avejGEJDGOKtgugqG2TTHzemCeXlKa74efNSNmdhCDpSf8Pjcfr4AXqxLQUqjJyWgLMkmjWXheVUwkz95cdpWebTyLvYYzJ9AnBM7Xciwhmm0STvzj2J1YX5iRNzwbHaeH8YH8IWWmAFfqEQCbhZb6bB//wbAOAzAM+MZdYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFZ6BxS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753DCC433C7;
	Fri,  5 Apr 2024 19:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712346681;
	bh=f/CMxni7jFnpuDFclRQ1sPJPHz81GAHsls7RUeZIdCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pFZ6BxS6BGeI5OmF9rs1tRD2Hp2W9N7XTVe5pVrAF7rvPFaOibY/fpmVZ77dK4bZU
	 noTNHTNfxSHvFI/0c+n17Iae2j+0W9yaOVfBx78hiU2/XenxVQuMWhOUcKkWXh/TNM
	 camqvKOLDRLcXNuarSCk2hmBGYczjWSaeMr6YhupVqTTqEw5efmoDy6HFY6BpBfJqg
	 ml06ZbuI7lS1204c90vdfBpuLAHgCaObxPLt2TOen9bauIKLgNgCValaYzlat1Kcuw
	 O3NzhV+3p3z6GSlCC1yz2JO0DTfuROqOWmYRV5lXO9vGx7T9ye7uLYThf96k2WCJXR
	 RsZJ01ZdoIUyg==
Date: Fri, 5 Apr 2024 20:51:17 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Tesarik <petr@tesarici.cz>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	open list <netdev@vger.kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Subject: Re: [PATCH net] u64_stats: fix u64_stats_init() for lockdep when
 used repeatedly in one file
Message-ID: <20240405195117.GV26556@kernel.org>
References: <20240404075740.30682-1-petr@tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404075740.30682-1-petr@tesarici.cz>

On Thu, Apr 04, 2024 at 09:57:40AM +0200, Petr Tesarik wrote:
> Fix bogus lockdep warnings if multiple u64_stats_sync variables are
> initialized in the same file.
> 
> With CONFIG_LOCKDEP, seqcount_init() is a macro which declares:
> 
> 	static struct lock_class_key __key;
> 
> Since u64_stats_init() is a function (albeit an inline one), all calls
> within the same file end up using the same instance, effectively treating
> them all as a single lock-class.
> 
> Fixes: 9464ca650008 ("net: make u64_stats_init() a function")
> Closes: https://lore.kernel.org/netdev/ea1567d9-ce66-45e6-8168-ac40a47d1821@roeck-us.net/
> Signed-off-by: Petr Tesarik <petr@tesarici.cz>

Reviewed-by: Simon Horman <horms@kernel.org>

Interesting bug. I'm wondering if you also looked over other users of
u64_stats_init() to see if any of them can result in unexpected aliasing of
lock keys too.

..

