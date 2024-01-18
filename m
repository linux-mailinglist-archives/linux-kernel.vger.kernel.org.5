Return-Path: <linux-kernel+bounces-30597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 538B1832173
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077A71F22759
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75323328B5;
	Thu, 18 Jan 2024 22:14:27 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CF1328AB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 22:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705616067; cv=none; b=D+6Lbeiz6RETVE2syZycE7/5WlQ4okB42jK2xXJV9tOABTH69TG97xP9OU7UvV6Jo/j79hQELdSsMDED0+5uMCUs1S+qe/ocQADnv4H7PvvpSZnnt4LBMHsDItNayTrx51KJhc8GKncYyZKgOO/34h7lcvCPrmAtRGcvlZeHjk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705616067; c=relaxed/simple;
	bh=KNzMXxvj1PRO1JNAxJ39l4/YUa8pBQvllxzTgn89BZU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KgAxkqZzFYM9YkEGIFlRRLLAdg48rdX0w8GUu3jQL7vpuUSvDdiQkXuegupvurqSYlJh/mqgSHrHyni3suhMF9ET51LgiX5tN9uw5ntMK08lcY8PbbpeDlSnuL1dGMeoV08H5wcWT3/oHIaPvCfsSXIR4J7HIExX36PV+58tdu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id C879C40AAD; Thu, 18 Jan 2024 14:14:17 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id C67AA40A82;
	Thu, 18 Jan 2024 14:14:17 -0800 (PST)
Date: Thu, 18 Jan 2024 14:14:17 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Chengming Zhou <zhouchengming@bytedance.com>
cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Vlastimil Babka <vbabka@suse.cz>, Pekka Enberg <penberg@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    David Rientjes <rientjes@google.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/slub: directly load freelist from cpu partial
 slab in the likely case
In-Reply-To: <412b8618-0941-4d9d-85df-ee480695e7f7@bytedance.com>
Message-ID: <a2132c63-99a5-7fa2-9f2a-cccf6b40fe9e@linux.com>
References: <20240117-slab-misc-v1-0-fd1c49ccbe70@bytedance.com> <20240117-slab-misc-v1-1-fd1c49ccbe70@bytedance.com> <76641777-1918-2b29-b6aa-bda9b5467aa3@gentwo.org> <412b8618-0941-4d9d-85df-ee480695e7f7@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 18 Jan 2024, Chengming Zhou wrote:

> So get_freelist() has two cases to handle: cpu slab and cpu partial list slab.
> The latter is NOT frozen, so need to remove "VM_BUG_ON(!new.frozen)" from it.

Right so keep the check if it is the former?


