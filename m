Return-Path: <linux-kernel+bounces-110052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83402885964
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EDE71F221F9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B48383CCB;
	Thu, 21 Mar 2024 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5Y2dcmM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB067605D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711025385; cv=none; b=KpOEZKxjFfWnFsB8n1FDtabtnnguvQciQPePAvLA1oiGTo9iw5bQGIoxZ+A+DUqItO8aI3KK+yP0hx4HYxJSvZAUDGhF58V8cS9Fim6D+6R8sTT9oIOcNB99YmRvyELot6tKsJ8EHhbA/NW3gjXzxNqqEH3kOBjw9e9NcC22MVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711025385; c=relaxed/simple;
	bh=2rlwk50YfNwtwsgOGYdotf1jy1yE1uw/N1ZSBKvN0uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnhszvuSlk8N+5/XmEAXo6fnq/+qjRc7mLARVxYefuQiG7F7sSiXcdvSxgzni2l+yMQbW6yqlnUYRCPb4PoKp2UwCH4z1ZNY5pLYDMorZCkO/IVBdNN5bBe/VaRglecBSQfH2h29csV7M1I0Uo9f69bjWmNMg1Ze4YcgCHXBqFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c5Y2dcmM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711025382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cdflo9wEQNniRXgP4FQTpqM0V2zD1bJdjhyO4rCdRw0=;
	b=c5Y2dcmMcQC5E34U+IG5FHFCZZ3hSqIvielUfDZmTYyMBTv8DCWV1fYjPSdpg2hx4YxThw
	M9llP+yEOTN3m8fTitwH3X0fNRSWDQVLmWCr/lPm1+taDsyy5uU4fV2SPkbQSwoHXja+hn
	bdTp5SoaFRHBBMJRXYGdCF3Xt1TCJwI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-dS4gnDpgOHSvUgra6cHzoQ-1; Thu, 21 Mar 2024 08:49:38 -0400
X-MC-Unique: dS4gnDpgOHSvUgra6cHzoQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 140A888B7A1;
	Thu, 21 Mar 2024 12:49:38 +0000 (UTC)
Received: from fedora (unknown [10.72.116.10])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 03AF38173;
	Thu, 21 Mar 2024 12:49:31 +0000 (UTC)
Date: Thu, 21 Mar 2024 20:49:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Andrew Theurer <atheurer@redhat.com>, Joe Mario <jmario@redhat.com>,
	Sebastian Jug <sejug@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>,
	ming.lei@redhat.com
Subject: Re: [PATCH V4] blk-mq: don't schedule block kworker on isolated CPUs
Message-ID: <Zfws04M0p3QUPmPJ@fedora>
References: <20240320023446.882006-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320023446.882006-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Wed, Mar 20, 2024 at 10:34:46AM +0800, Ming Lei wrote:
> Kernel parameter of `isolcpus=` or 'nohz_full=' are used to isolate CPUs
> for specific task, and it isn't expected to let block IO disturb these CPUs.
> blk-mq kworker shouldn't be scheduled on isolated CPUs. Also if isolated
> CPUs is run for blk-mq kworker, long block IO latency can be caused.
> 
> Kernel workqueue only respects CPU isolation for WQ_UNBOUND, for bound
> WQ, the responsibility is on user because CPU is specified as WQ API
> parameter, such as mod_delayed_work_on(cpu), queue_delayed_work_on(cpu)
> and queue_work_on(cpu).
> 
> So not run blk-mq kworker on isolated CPUs by removing isolated CPUs
> from hctx->cpumask. Meantime use queue map to check if all CPUs in this
> hw queue are offline instead of hctx->cpumask, this way can avoid any
> cost in fast IO code path, and is safe since hctx->cpumask are only
> used in the two cases.
> 
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Andrew Theurer <atheurer@redhat.com>
> Cc: Joe Mario <jmario@redhat.com>
> Cc: Sebastian Jug <sejug@redhat.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Tejun Heo <tj@kernel.org>
> Tested-by: Joe Mario <jmario@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V4:
> 	- improve comment & commit log as suggested by Tim

Hello Jens, Tejun and Guys,

This patch fixes one issue in OpenShift low latency environment, I appreciate
you may take a look at the patch and merge it if you are fine.


Thanks,
Ming


