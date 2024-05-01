Return-Path: <linux-kernel+bounces-165844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D878B9246
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C051F212C1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1620168B05;
	Wed,  1 May 2024 23:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CwIR318X"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE1117C6B
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 23:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605841; cv=none; b=upwjjDxMPNlnTzzZD6otCHWjaTOL3mKtd8rV1/E4KYFnW3TvdjU/1a43TTydYPMQ8Js3FYTcYzwGTzayHwhQyaB5gMclHzI/Vx7f++3qEzBSeWRnzIu/4GnEIcRsa89CjmiItL+M7pBUrmOVHI3mMl8Jg5nEvVP+3MUugSZyTXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605841; c=relaxed/simple;
	bh=B43LLTsmKyCt/5EeFU/pHFuKghGgXnF1UaumPgLWfsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klsXNTZ6gv70fPNcDmU9LZ7ky+P//iPrZzCfHfcxF8piarjcYQGxL1zajYTW8QkLzDwdZ8ESu1QCMI+VEeuzJW+dgxENEgBk0STRQ/5gSW/UOSaiaWu0KFOXAePLdwKmsHVeSWLzBZdeLIrVcbH2GnOxvGewF1lO53n87+H8pPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CwIR318X; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 1 May 2024 16:23:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714605837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XIw6/PKldmSG9/LrfELSqhhgzz+8Bg2Si7fn/vvmJOk=;
	b=CwIR318XR52sEpnTL4RO3i1X+4dQ+U3QZKExq/aC9oWFt9polR9so4pmRHJFZJZ50Vf5UB
	tfTKq0bzqy0lZvrVF217hew6F1IKVh51rJP97F2hLd3RY1DkkgW+i3zICMe3beohIz1fEm
	I37ZzTGz90rVD6Zqqan5+n9ALvD8QiE=
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
Subject: Re: [PATCH v4 8/8] memcg: use proper type for mod_memcg_state
Message-ID: <ZjLPCE1F5oH91sHU@P9FQF9L96D>
References: <20240501172617.678560-1-shakeel.butt@linux.dev>
 <20240501172617.678560-9-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501172617.678560-9-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, May 01, 2024 at 10:26:17AM -0700, Shakeel Butt wrote:
> The memcg stats update functions can take arbitrary integer but the
> only input which make sense is enum memcg_stat_item and we don't
> want these functions to be called with arbitrary integer, so replace
> the parameter type with enum memcg_stat_item and compiler will be able
> to warn if memcg stat update functions are called with incorrect index
> value.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: T.J. Mercier <tjmercier@google.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

