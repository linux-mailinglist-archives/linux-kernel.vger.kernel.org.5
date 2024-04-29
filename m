Return-Path: <linux-kernel+bounces-162654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 304D78B5E99
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10791F2533E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07E883CB0;
	Mon, 29 Apr 2024 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wdFn3l11"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D031874400
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406856; cv=none; b=ZKd38tB07MwlX677qY0V0wTKlx0RZqEW0tJuE1SXeNP9L/4U+nhU9gbsmu1vEvVm15++ltOPK8BlyF5wHzlw9Wcqx+8rJHd43bk3aJGqZyD91pKt1kzhmxFxxe4y2AO+fflDE5X07lFW0N3dFr9AstjboGP3yXmIh179sMZPCto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406856; c=relaxed/simple;
	bh=Yv7MpG6Lph1Nkm5Wxn81Qp2iEq25Jsr8Xz6iEsJIkuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDE85kbewQUdmtSN7XLPbnsKQF9t4azF0026BMXMkG1fdO3EhQiH6yat5D0kH4KkyqDa3z8uuuB2SY9T/PfrEckg+0DOvrHS7vi5u+Jv5iUcC3RDdx31eZo7DS2OfP0v6FLhhDBJikvIeLYGm/8wWV/51gqr2PM1zJWkeHgySeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wdFn3l11; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 29 Apr 2024 09:07:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714406853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Af9swwyjE9aq+gFvEtFlpYxD5VA7L7/5Bjt51dmOc2o=;
	b=wdFn3l11noD7XAoZXISsQIPIsCwIB2M7qo6z6QbjiXguS62xBh6HdWbm1VfskBBqCTmIhU
	1dCrIuubR2sk51yxM0Li7Xr5qQViHM4k6T6B2li22vaFv/ROpR7Cjk75phHvpt/mbGXxsK
	ymlfX2+PyYzolqAdigTR9muYX81fyN4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] mm: cleanup WORKINGSET_NODES in workingset
Message-ID: <Zi_Fwcx_wWiAoA8K@P9FQF9L96D>
References: <20240427003733.3898961-1-shakeel.butt@linux.dev>
 <20240427003733.3898961-8-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427003733.3898961-8-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 26, 2024 at 05:37:33PM -0700, Shakeel Butt wrote:
> WORKINGSET_NODES is not exposed in the memcg stats and thus there is no
> need to use the memcg specific stat update functions for it. In future
> if we decide to expose WORKINGSET_NODES in the memcg stats, we can
> revert this patch.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks for the series, Shakeel!

