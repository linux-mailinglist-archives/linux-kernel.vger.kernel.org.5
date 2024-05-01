Return-Path: <linux-kernel+bounces-165842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA678B9243
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61CB91F2158C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3F5168AFB;
	Wed,  1 May 2024 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J/hoNWCl"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E14168AEE
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 23:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605798; cv=none; b=SEZpnBEPjUnHgDwPJvoPHow9q2QpMdB7X9Op/naHFV2E2ePoV9AT5wzkZyd2X0HAi93tXo0w/oaFycZ7K8gB8T0lygzTgB/v0D2bFHPQMd8vKhQGHBPD7Wp0UCUOX1jwCBM1H7g2TzUMyv+pAAb6G0kQg0fFltD6abjcxZsWpxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605798; c=relaxed/simple;
	bh=/2S35HzstemFIS0ibte+1aIjk3+p1hGYgadH69AbJ24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPsSidAW3I/Pb/jCmr8qLmes/m1XvDE+J8IEgs2ysRv9W24T7axVf8vAQX1drWB7n+ydmOKay7GXCLXzPR28bprB58rFY/QdnYy0OjQR4xFhNlJXZszmMlHOBilRL3Lne+DJ+UKPBOOCF2F2o1FFkEOugJws8c5UEbMqd3XRt1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J/hoNWCl; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 1 May 2024 16:23:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714605794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nzw2cNZaB9iCUYH814uKzdRXqDcmilZfSkUkIOiCcz4=;
	b=J/hoNWClgHwe/o6LeoXRbPcIreMprVW9+vLqQVTT0AjUdVWRvfn0FWuAsZq2A/sDj2wEmn
	kTDTiuDBbzv+4nqDGtFXgbAdTicMyv17dirzPUw1Es47BQef3jlm3lHi0/eA6BVHy5Y9Yx
	u7WVWfQ89zSqQj+LOxFbSkM6RhLDGNo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>,
	"T . J . Mercier" <tjmercier@google.com>, kernel-team@meta.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/8] memcg: warn for unexpected events and stats
Message-ID: <ZjLO3uxJgYWc4DSA@P9FQF9L96D>
References: <20240501172617.678560-1-shakeel.butt@linux.dev>
 <20240501172617.678560-8-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501172617.678560-8-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, May 01, 2024 at 10:26:16AM -0700, Shakeel Butt wrote:
> To reduce memory usage by the memcg events and stats, the kernel uses
> indirection table and only allocate stats and events which are being
> used by the memcg code. To make this more robust, let's add warnings
> where unexpected stats and events indexes are used.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

