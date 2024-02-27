Return-Path: <linux-kernel+bounces-82944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DA5868C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625BD1F22CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B65813664B;
	Tue, 27 Feb 2024 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FZ9fUI1F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E4A15D0;
	Tue, 27 Feb 2024 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025585; cv=none; b=K1/LZxav9TyWweSU0X3VON56Y5R7cLXxbl3kHLRVQ2KL58ap9qENaPpe6usODzIb80g/LG5g9pY51x9no94TXFbIHGQg5B2Fl3LtrjEk0lV41sSAfCnkPkN5fja4mdL5D6Mg90JMahBIxYcezGyr1yngjHifysJKz6IZey/vuTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025585; c=relaxed/simple;
	bh=mWuQqMS4uz9qq4fM6oWFzkCwnWqLgdXy4FqN58EEn4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N29ntVRvZCgXblh6WKAAZznnbhsSA+cpTJXAysAkxdCe1+eZ2naCFd80cMu1NqEmQ6PbAkJ5WXdkX8Q04IasOOASVD+v/tcA1Yy8r4kLVouednvGM8GSE7JTCNlLlaNCacph5fBHOlPd9nx1z87GfVpvVLO0YMYVrIV8762ASmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FZ9fUI1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2D7C433F1;
	Tue, 27 Feb 2024 09:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709025584;
	bh=mWuQqMS4uz9qq4fM6oWFzkCwnWqLgdXy4FqN58EEn4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZ9fUI1FOL0OHcqIyA1oNWr2JN4APMm470UwK4REcPHycyrp7PaHwnZsss+fZcKTm
	 lrQGaD6NgMzQ9yDMzvqFPwsarXiQshHptPGTnPOvse+em35/zAQrgi1D2t96j00G/S
	 NYQUFFjozZswRZAfsvZC8/hZibXJH7PqT0ewI2H0=
Date: Tue, 27 Feb 2024 10:19:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: stable@vger.kernel.org, damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/damon/reclaim: fix quota stauts loss due to
 online tunings
Message-ID: <2024022731-varying-underpaid-c855@gregkh>
References: <2024022643-scorn-filtrate-8677@gregkh>
 <20240227051335.168121-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227051335.168121-1-sj@kernel.org>

On Mon, Feb 26, 2024 at 09:13:35PM -0800, SeongJae Park wrote:
> Patch series "mm/damon: fix quota status loss due to online tunings".
> 
> DAMON_RECLAIM and DAMON_LRU_SORT is not preserving internal quota status
> when applying new user parameters, and hence could cause temporal quota
> accuracy degradation.  Fix it by preserving the status.
> 
> This patch (of 2):
> 
> For online parameters change, DAMON_RECLAIM creates new scheme based on
> latest values of the parameters and replaces the old scheme with the new
> one.  When creating it, the internal status of the quota of the old
> scheme is not preserved.  As a result, charging of the quota starts from
> zero after the online tuning.  The data that collected to estimate the
> throughput of the scheme's action is also reset, and therefore the
> estimation should start from the scratch again.  Because the throughput
> estimation is being used to convert the time quota to the effective size
> quota, this could result in temporal time quota inaccuracy.  It would be
> recovered over time, though.  In short, the quota accuracy could be
> temporarily degraded after online parameters update.
> 
> Fix the problem by checking the case and copying the internal fields for
> the status.
> 
> Link: https://lkml.kernel.org/r/20240216194025.9207-1-sj@kernel.org
> Link: https://lkml.kernel.org/r/20240216194025.9207-2-sj@kernel.org
> Fixes: e035c280f6df ("mm/damon/reclaim: support online inputs update")
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Cc: <stable@vger.kernel.org>	[5.19+]
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 1b0ca4e4ff10a2c8402e2cf70132c683e1c772e4)
> ---
>  mm/damon/reclaim.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 

Now queued up, thanks.

greg k-h

