Return-Path: <linux-kernel+bounces-40472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C624C83E10D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B622867F8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C0F20B30;
	Fri, 26 Jan 2024 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhsCRM7j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190A320B22
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706292580; cv=none; b=CoCsx1lpeb6z0nv94RwLEmwxcL+7dL9xkIGJkCsSk2girNBdMWNWbpJWpUPesvzb65W+jMldW6+cJbRpUCyTQpOTxmk24plKJcqYfjkSiKdRVr+HBMDsZk4VQihqGIr30ORsQdVqXR8MjgQjZboyPx1VBdIsxP6wA0kNEvyxSxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706292580; c=relaxed/simple;
	bh=PG4/aZR5ehNoaIXSCVLkh7AD4cNnfxBqq7Vn9VNuNN8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=q6idbL6+AaI+NawV/1j5im4wDEd2Ffn3dJBP7NX03n0+1B4+OOfvWSq6+hSQhbOlPpptnpRaIRyJWeKAdNxF2gai+ZrTLcgZBWE0ZEcXGWNHG+Mc89mh1aetekYj1kxbygr4+fCEsqcXJAvBXkp5uRc2i2Kjx7i3wrz4oUWt6Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QhsCRM7j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706292577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wO/GDAatG6A2816f5tEylmQBmDB7G8kJQQtaCJdUFO4=;
	b=QhsCRM7jSr0l9dDhkjrH6TCKRx6JnedUgQrzqSsDCP76ya/cwPin4oJyEhqkP14yeBR+2p
	okZyXvUkqOLlbdiWTVDXk1R0HCyivAbh6CWeMK8HngQIUxEljOw9o62NpLEWVzA1cHs3IE
	izkLc+hVABhZgKHbpf2bO1IFukwab3c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-hFFMn07mPBuMNb_mMsj6uA-1; Fri, 26 Jan 2024 13:09:34 -0500
X-MC-Unique: hFFMn07mPBuMNb_mMsj6uA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EA0A1013661;
	Fri, 26 Jan 2024 18:09:33 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 003CA492BFA;
	Fri, 26 Jan 2024 18:09:31 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id DFEC030BFEFE; Fri, 26 Jan 2024 18:09:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id DB7CD3FB50;
	Fri, 26 Jan 2024 19:09:31 +0100 (CET)
Date: Fri, 26 Jan 2024 19:09:31 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Hannes Reinecke <hare@suse.de>
cc: Damien Le Moal <dlemoal@kernel.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, Tejun Heo <tj@kernel.org>, 
    Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
    dm-devel@lists.linux.dev, Mike Snitzer <msnitzer@redhat.com>, 
    Ignat Korchagin <ignat@cloudflare.com>, 
    Damien Le Moal <damien.lemoal@wdc.com>, Hou Tao <houtao1@huawei.com>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] softirq: fix memory corruption when freeing
 tasklet_struct
In-Reply-To: <d390d7ee-f142-44d3-822a-87949e14608b@suse.de>
Message-ID: <d01a8554-10dd-1968-c9b0-f9ff16e6ac4@redhat.com>
References: <82b964f0-c2c8-a2c6-5b1f-f3145dc2c8e5@redhat.com> <CAHk-=wjDW53w4-YcSmgKC5RruiRLHmJ1sXeYdp_ZgVoBw=5byA@mail.gmail.com> <586ca4dd-f191-9ada-1bc3-e5672f17f7c@redhat.com> <5e2b5f23-94f0-4bf0-80a6-48380c7dc730@kernel.org>
 <d390d7ee-f142-44d3-822a-87949e14608b@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10



On Fri, 26 Jan 2024, Hannes Reinecke wrote:

> Oh, it's this time of the year again?
> (This topic regularly comes up ...)
> 
> The reason is not that it will disable dm-multipath (Mike Snitzer put in
> bio-based multipathing as an additional code path); the reason is that
> dm-multipath performance will suffer when you remove request-based DM.

Is there some benchmark that says how much will it suffer?

> DM-multipath schedules based on request (if you use the request-based
> interface) or bios (if you use the bio-based interface).
> Any merge decision is typically done by the block layer when combining bios
> into requests; and you can only merge bios if the bvecs are adjacent.
> So if you use bio-based multipathing you will spread sequential bios
> across all paths, leaving the block layer unable to merge requests.

The same problem exists in raid1 and there's a function read_balance that 
solves it. If the starting sector of a new bio matches the ending sector 
of a previous bio, then submit it for the same device.

> For request based multipathing the requests are already fully-formed,
> and scheduling across paths does not change them.
> Things are slightly better with multi-page bvecs nowadays, but the
> overall picture still stands.
> 
> Another thing is timeouts; bios don't do timeouts, so a bio can run
> for an arbitrary time with no chance of interrupting it.
> Requests do have a timeout, and will be aborted from the driver when
> the timeout is hit.
> Seeing that 99% of all I/O issues I've seen _are_ timeouts it becomes
> a crucial feature if you want dm-multipath to control failover time.

You can set timeout of the underlying physical devices.

> Cheers,
> 
> Hannes

Mikulas


