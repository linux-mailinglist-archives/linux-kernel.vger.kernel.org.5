Return-Path: <linux-kernel+bounces-160839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 820858B436C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 03:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18E4283BD0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97E82E62C;
	Sat, 27 Apr 2024 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rCbwiDGH"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CD72C6BB
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 01:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714180600; cv=none; b=m06YExCZzZuNB0NTYoFBs7y3RC7pc4KJKulxl8W8nMXh9Z9SRP6IdkVVyoplkRzDazr+iia7zW5ow3K6ng9/+6XCTMJS5YCFIPqs2JhRFI7eqPaexUxevTNHdwM11ZADSJ/vPML1tGeqZjA/tSSHkLzUSoUnuwEpjyFYYdO0wSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714180600; c=relaxed/simple;
	bh=35LKY7Ge563urcdAjPWNirdL2Ze4zZ9nGJan4ILzT3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkODs6Y/tcTZh+LMSvj7ocmKpPgd9roCQjeYC0tVv+mI1WL3+yWL5L+rIY1t3ioPwnJEiMIzNpWm7oSppSkq/TWAO1xVPHXPznspzML2MztPzbGnwDJTIZ1WL+xl+yVT2Cx3u9C+BuzKYS6fmpeI856WXa2aLasmpKaDxcdZO4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rCbwiDGH; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 26 Apr 2024 18:16:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714180596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dw9CXe+SmxN1TDy435qbdzl8HGL75SSMRvyUbyXE2xA=;
	b=rCbwiDGHCO+X1lYKKamtp1knSDpnUWhysMFPCiO7cUuKr6CeRmkM+Kb8LwAowZ19Qec1AP
	wxht7p6bqUg4mqYsCjAigIMyrG4uFGDlnfXj7D+3K6MfnatGerx8IDbLro6iDAbtrea/6f
	j8mHp2qf0hC7Rpg58h0nLMqmYHG3UlQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] memcg: reduce memory for the lruvec and memcg
 stats
Message-ID: <uewheydidpkiqywtc4m6dcmvlfj7raocpngtbqocksxvf4nyz4@srxnazpqxvzy>
References: <20240427003733.3898961-1-shakeel.butt@linux.dev>
 <20240427003733.3898961-4-shakeel.butt@linux.dev>
 <CAJD7tkY2EwtOHh3w=e0+OC3gOPb9xCC7C36BhM0RHYPv184U+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkY2EwtOHh3w=e0+OC3gOPb9xCC7C36BhM0RHYPv184U+Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 26, 2024 at 05:51:23PM -0700, Yosry Ahmed wrote:
> On Fri, Apr 26, 2024 at 5:37 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > At the moment, the amount of memory allocated for stats related structs
> > in the mem_cgroup corresponds to the size of enum node_stat_item.
> > However not all fields in enum node_stat_item has corresponding memcg
> > stats. So, let's use indirection mechanism similar to the one used for
> > memcg vmstats management.
> 
> Just curious, does the indirection table cause any noticeable
> performance impact? My guess is no, but the update paths are usually
> very performance sensitive.
> 
> I guess lkp will shout at us if there are any noticeable regressions.

Yeah and that is the reason I made the indirection table smaller (i.e.
int8_t) to keep more entries in a single cacheline.

