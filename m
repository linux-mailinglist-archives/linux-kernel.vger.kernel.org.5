Return-Path: <linux-kernel+bounces-29509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6271830F71
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7662E1F267E0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C4B288D7;
	Wed, 17 Jan 2024 22:41:15 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB424288CF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 22:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531275; cv=none; b=JkkrOCVWXwoB3HxrDNdFyIqZLYRewxN8c7G6sTYnzPplHUypFI2me0pJXJlKyKmtnhEbpWOz/Te6PWvrD5JIUj4TjhRjzYDsVS9YCvlr6D7mM6WdXhtOufxR4wY8exfWddK8qliDkl9pzGK5E9to9CzUyVzmWtS0vghTpt+ZspY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531275; c=relaxed/simple;
	bh=tLO73DrRLHxpNwP+tcdGTJ/LqLrt/oVJwNsNMB12t7s=;
	h=Received:Received:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type; b=YomvWGdPjW7LOjB9KbnnqIpsqN+K5jn+CdGkngR+JDrk+RFDyrQWN1adX4UXRFCpsfHd3qU6c2a+VXa03Hn1/xzx4U/d2LdlK/oe5h1znaSdVzkCWwny0cZ8qosDI1jfax5v/Mlnk4Q/jwyiiOv9aeNe7HW83ik/TnZ48wmWTyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Received: by gentwo.org (Postfix, from userid 1003)
	id 2BE3740A8B; Wed, 17 Jan 2024 14:41:13 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 2A50E40A85;
	Wed, 17 Jan 2024 14:41:13 -0800 (PST)
Date: Wed, 17 Jan 2024 14:41:13 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Vlastimil Babka <vbabka@suse.cz>, Pekka Enberg <penberg@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    David Rientjes <rientjes@google.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/slub: directly load freelist from cpu partial
 slab in the likely case
In-Reply-To: <20240117-slab-misc-v1-1-fd1c49ccbe70@bytedance.com>
Message-ID: <76641777-1918-2b29-b6aa-bda9b5467aa3@gentwo.org>
References: <20240117-slab-misc-v1-0-fd1c49ccbe70@bytedance.com> <20240117-slab-misc-v1-1-fd1c49ccbe70@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 17 Jan 2024, Chengming Zhou wrote:

> The likely case is that we get a usable slab from the cpu partial list,
> we can directly load freelist from it and return back, instead of going
> the other way that need more work, like reenable interrupt and recheck.

Ok I see that it could be useful to avoid the unlock_irq/lock_irq sequence 
in the partial cpu handling.

> But we need to remove the "VM_BUG_ON(!new.frozen)" in get_freelist()
> for reusing it, since cpu partial slab is not frozen. It seems
> acceptable since it's only for debug purpose.

This is test for verification that the newly acquired slab is actually in 
frozen status. If that test is no longer necessary then this is a bug that 
may need to be fixed independently. Maybe this test is now required to be 
different depending on where the partial slab originated from? Check only 
necessary when taken from the per node partials?

> There is some small performance improvement too, which shows by:
> perf bench sched messaging -g 5 -t -l 100000
>
>            mm-stable   slub-optimize
> Total time      7.473    7.209

Hmm... Good avoiding the lock/relock sequence helps.

