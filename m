Return-Path: <linux-kernel+bounces-122315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C29888F506
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5661C29B14
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364762374E;
	Thu, 28 Mar 2024 02:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMHsrQEE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A8323773
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711591214; cv=none; b=c8SOOrPMzRQe8LNYXAKUifAAX/l/1pgkdZjXGFW2DXR2G5wuYWb60L4jk5cvzuIf90rqJvuNuA10O5ee/hFlPTTDeavJFFLVZVrrb2A4jotcGhrCadJ/CQpjv1fzUIq0Wfb8CKxIsaJtT0w/HHxlgkEQIYAop1jOzlgYTe61oDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711591214; c=relaxed/simple;
	bh=WO6HUfry9BHwXmmmaocg9kjEOnGz8Oiuy+GYJJcQtWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xq9f6R4YMiasOzWHFgh/vLFsor7wysreIxJtkMrNQzhErsqMVXj9JAJswfl31ikpWbKMQj9nl6bEEj4HMSfgF+mBKs2ea+fHyM83fsMIX1bGBHAX8Pg6FyP+Eg96EDsWi2rZnpXROv+X0cp2njXQ2MUIDt8TrN6nqKuksY14COQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMHsrQEE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711591211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p5nqKfv3v+biAgyqBmGEVEdrEDuJ1P9xCB6+AquGT5s=;
	b=NMHsrQEE0fWperfC1HUByBgDhE04bwxrTe/Ci06QG1ijt3FHh6Vs1L7htbajOdqMzhM/y7
	+LEtuWWVazHiSiQ2FCDmuB5t3qhVGGoP5l1eO3bLPbfWaUZuvdbeL/QeHwiA6FTLAX14qy
	3DD5ddeLsqpRu7TlBWIHbplo88+Md3g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-daDXQqzoMI2v4zX4q8y23g-1; Wed, 27 Mar 2024 22:00:01 -0400
X-MC-Unique: daDXQqzoMI2v4zX4q8y23g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FCE3879849;
	Thu, 28 Mar 2024 02:00:00 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C08F9492BD0;
	Thu, 28 Mar 2024 01:59:59 +0000 (UTC)
Date: Thu, 28 Mar 2024 09:59:52 +0800
From: Baoquan He <bhe@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm tree
Message-ID: <ZgTPGJamrN+nJsfr@MiWiFi-R3L-srv>
References: <20240328091337.03421187@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328091337.03421187@canb.auug.org.au>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 03/28/24 at 09:13am, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> mm/page_alloc.c: In function 'build_zonelists':
> mm/page_alloc.c:5324:13: warning: unused variable 'node' [-Wunused-variable]
>  5324 |         int node, local_node;
>       |             ^~~~
> 
> Introduced by commit
> 
>   95d0185255a3 ("mm/page_alloc.c: remove unneeded codes in !NUMA version of build_zonelists()")
> 
> from the mm-unstable branch of the mm tree.

Thanks. Below code change has been queued on mm-unstable branch to fix it.

From 6bb5aa700a6221248df150cba3d9c54cd95bed97 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Wed, 27 Mar 2024 20:06:45 +0800
Subject: [PATCH] 
 mm-page_allocc-remove-unneeded-codes-in-numa-version-of-build_zonelists-v2
Content-type: text/plain

remove unused locals

Link: https://lkml.kernel.org/r/ZgQL1WOf9K88nLpQ@MiWiFi-R3L-srv
Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/page_alloc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a4f6b5f308ea..9c591413ca04 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5285,12 +5285,9 @@ static void setup_min_slab_ratio(void);
 
 static void build_zonelists(pg_data_t *pgdat)
 {
-	int node, local_node;
 	struct zoneref *zonerefs;
 	int nr_zones;
 
-	local_node = pgdat->node_id;
-
 	zonerefs = pgdat->node_zonelists[ZONELIST_FALLBACK]._zonerefs;
 	nr_zones = build_zonerefs_node(pgdat, zonerefs);
 	zonerefs += nr_zones;
-- 
2.41.0


