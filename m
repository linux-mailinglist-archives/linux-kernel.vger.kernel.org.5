Return-Path: <linux-kernel+bounces-162982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB4B8B6305
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 273F3B20E0F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC06813F439;
	Mon, 29 Apr 2024 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="upUBjJS8"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E06613C3D3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420817; cv=none; b=cpz0dEiQDg2yPGUakyK42720AoTLPu2LKFbUnA0hGPmzz/DxSn6eH75cZTRPcZC7ndDkHtK3j0QG9vtdpIPWcqOPBSBpm9YQKgGfSbmwdbcSknaczVhMZzmyqpWHCEdGJfmaWOPVWGwnzGskT6XAH5mh6UA3QBORC+Kp2UizqBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420817; c=relaxed/simple;
	bh=c4mB7o8/yzEVcwo2o6r+iqRTnzaM2sN+BU+6NpT2eFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zpv4frtDDqWWaGgi7aZNMkZXOE8dhkYTIjJT//o94SgU0S+1wgRmn72fri7CJ1J4ZO1ZOQK6rg3ErRvjWlz7SLq7t5L+7tz1JA0ofGcszW1iQtcdbw+Dub3eW5a2ZzpY8EKX9pLggmL1ABHwrfzKnAq7s/c0clwkrQC69icbmqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=upUBjJS8; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 29 Apr 2024 13:00:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714420813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QQ5FcjaYCyg1Mr1CGy79zC22GmrlSZ/10SszbgWtzIY=;
	b=upUBjJS8WJNxYCju+dzj7JEkoZILGvcJRS/jL9TRfeDHDAhNO80uHktKWufdqJaVXvz37c
	Na3/fPiwWSmrWlcX32RkGMqkuq3gWdF+v0x5XCozLMfbCGz5N/0wHNuhF7VwnIWSygCI0f
	ECuVybXOUfs0o4AsVHmfPlkt7GUCASU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] memcg: reduce memory for the lruvec and memcg
 stats
Message-ID: <sskkbmc36fljo5xj3mn4fufctu3lvk3ubkxzy5mif4wsxe2zou@4oyulvmduhbk>
References: <20240427003733.3898961-1-shakeel.butt@linux.dev>
 <20240427003733.3898961-4-shakeel.butt@linux.dev>
 <Zi_EEOUS_iCh2Nfh@P9FQF9L96D>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi_EEOUS_iCh2Nfh@P9FQF9L96D>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 29, 2024 at 09:00:16AM -0700, Roman Gushchin wrote:
> On Fri, Apr 26, 2024 at 05:37:29PM -0700, Shakeel Butt wrote:
[...]
> 
> Hm, I'm slightly worried about the performance penalty due to the increased cache
> footprint. Can't we have some formula to translate idx to memcg_idx instead of
> a translation table?
> If it requires a re-arrangement of items we can add a translation table on the
> read side to save the visible order in procfs/sysfs.
> Or I'm overthinking and the real difference is negligible?
> 

No, you are not overthinking and the update side is very performance
sensitive. On my simple testing I do not see any regression but I am
hoping that the Intel's performance bot will tell us if this is really
worth exploring.

> Thanks!

