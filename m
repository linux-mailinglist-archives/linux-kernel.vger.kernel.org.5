Return-Path: <linux-kernel+bounces-121406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C17288E78F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D7C1F3263C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A26312EBEB;
	Wed, 27 Mar 2024 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NPSaRHKg"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50293134AA;
	Wed, 27 Mar 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711548683; cv=none; b=heslQVou71MMI4qQoQ4LN+rV9tyRm1v5XxIoV10j1CnMgHMdU3FE3WoHJFnWKGrt49vgWsx/EpxBMIZL2yenP27jKh5E88MrPZf+tBZSqNlhNe1l/amlUzzy/zxYd6MvhmjJt7F7iP9iykySCuMTMleEP0+gMNqd6eyXk5N3cYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711548683; c=relaxed/simple;
	bh=G8rt3lGkdxJ6g0fchM346JUO/RC/GCAHONQIjdQ2OOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jn1qV9sXmbSDEoL7AAEGePB/O/uNVpdjdGvbx6XWWxZg10BDR2nOGtLaQd3CSiXB1FIrEGytJGBzPWzKW0gf82nsnChMWn/rb3BMAN9qGDGjBeHiYVeLQfHa+D7UQi2MsfIHgjD95AfYjbBRd9C/jTbeMh7fF8OGYs6onAUmIWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NPSaRHKg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G8rt3lGkdxJ6g0fchM346JUO/RC/GCAHONQIjdQ2OOQ=; b=NPSaRHKg7cdRjaZfQs+5twodpe
	oW01QnWxbztkS4yrZoW1935p66SOj7mPjte4TTbRiiZ5Zxbd/U/ri8R4fBbqBP4vjLDnHZq0wrLwG
	nIEGmKi+iD/SS0VZ1gxUicY5gVE+y1T56ON9Ew9yM1319kg+p3xV3ytemDlzPMUynis90tf+/Xq4o
	5DO7PQtXWUjtkQc5X6QH7k8x+gCM4TsPt3jHqgglGHsTxynO1FOwFpd83ZJL6d3lx0l+DO0OHFZnt
	Z9FDdAE8jBR20vJB9vVFnqdtJn2qtM6eW/KbDeMUZ77yAyK7KrmNhMaaMrRUR9lCCUIcmhjbK9YJp
	aXE5rNMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpTzs-000000041LW-3Lj4;
	Wed, 27 Mar 2024 14:11:20 +0000
Date: Wed, 27 Mar 2024 14:11:20 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Rik van Riel <riel@surriel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: FAILED: Patch "bounds: support non-power-of-two CONFIG_NR_CPUS"
 failed to apply to 4.19-stable tree
Message-ID: <ZgQpCEif65doAG_3@casper.infradead.org>
References: <20240327122521.2840152-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327122521.2840152-1-sashal@kernel.org>

On Wed, Mar 27, 2024 at 08:25:20AM -0400, Sasha Levin wrote:
> The patch below does not apply to the 4.19-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

The 5.4 patch I just sent also applies cleanly to 4.19.

