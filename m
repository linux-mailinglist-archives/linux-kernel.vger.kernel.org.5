Return-Path: <linux-kernel+bounces-104068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A2487C889
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 06:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704B5282AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736EFFC0E;
	Fri, 15 Mar 2024 05:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WhzCZ5A9"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E9EDF51
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 05:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710481125; cv=none; b=m7JgrdcwoScUmLz8nlEvukzm9Tv2UnaZJaGJR29IX+Eq8X15sx3MWhaDjpfAsSDZKKYXngOXETe5ctMRIohM8dmjIUJNEarJDmpFMM0nPdTWLFCOSUD3w2IxvA/+I5EL0axyNPqQmXBVzhcc8KTTjXvgdGumxMDpNnhb3Eh/1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710481125; c=relaxed/simple;
	bh=Rk4C0yASpUi0yoJQP/c/JotB7EeTAcs9P0Lf5YmncxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avdMTP7HeQsw5fz1Dn+HvF5YMrifjrzoR6CRQaGKaWT6m6r70+1WpuRcU8CW/U64dsU5BZVNXchMNeZ+UuLdbOM9TMLcu0ivk7iVZ1SZAKvKDoYqxm162Unj/+dw+5C8JzJFPFNWBxFiJn7/SWnW0F5xVw6+6rDIlLs3SC9K7cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WhzCZ5A9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Vgui9xa+Yta3BpdkqR3h17bfR59JfFjIZqVGIGYKUUw=; b=WhzCZ5A9iWy3cuBbJxFhmCtmCe
	My656L9mMcEqZU3Nlk+GH8BHWpjfOFhdj73vXpCAUwsSo5nxyc72+iogwwelJ/fC/AOI4V4xY/fWD
	9wrZjj1nLYgNCzrYNdiykEKGirz8h+b4BhAMJaPR90fC7QSUSU4ArXqTK3ylOOnMeddjxkdGJg3hF
	wjjgD7CB8ymvbUEpZIamsz3jMzU/qcxqrcb3ejgdc68RQCFAZKSkOEx+BEB03E2LMWCoM0QOigh0O
	tPowqFEL7g2fEn9vexxfKZwGGKvpYEdFkce6hCVjtoJY9lGCDK3Ko2aSRVpI8N3tpU0cqVGO04cbz
	3XXDChqw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rl0H6-0000000GkFX-076Q;
	Fri, 15 Mar 2024 05:38:36 +0000
Date: Thu, 14 Mar 2024 22:38:35 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, jhubbard@nvidia.com, vbabka@suse.cz,
	mgorman@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	dave@stgolabs.net, p.raghav@samsung.com, da.gomez@samsung.com
Subject: Re: [PATCH 2/3] mm/compaction: add and use
 for_each_populated_zone_pgdat() helper
Message-ID: <ZfPe22p9U8PiRB0W@bombadil.infradead.org>
References: <20240314005436.2962962-1-mcgrof@kernel.org>
 <20240314005436.2962962-3-mcgrof@kernel.org>
 <ea5d5bb6-32a5-4161-95cd-3dc916576bf7@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea5d5bb6-32a5-4161-95cd-3dc916576bf7@linux.alibaba.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Mar 14, 2024 at 03:19:45PM +0800, Baolin Wang wrote:
> 
> 
> On 2024/3/14 08:54, Luis Chamberlain wrote:
> > We can just wrap most of the work done on fragmentation_score_node()
> > into a pgdat helper for populated zones. Add the helper and use it.
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >   include/linux/mmzone.h | 8 ++++++++
> >   mm/compaction.c        | 9 ++-------
> >   2 files changed, 10 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index a497f189d988..1fd74c7100ec 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -1597,6 +1597,14 @@ extern struct zone *next_zone(struct zone *zone);
> >   			; /* do nothing */		\
> >   		else
> > +#define for_each_populated_zone_pgdat(zone, pgdat)	\
> > +	for (zone = pgdat->node_zones;			\
> > +	     zone;					\
> > +	     zone = next_zone(zone))			\
> > +		if (!populated_zone(zone))		\
> > +			; /* do nothing */		\
> > +		else
> 
> I think this will break the original logics, since the next_zone() will
> iterate over all memory zones, instead of only the memory zones of the
> specified node.

Definitely, thanks, so we'd need something like this in addition:

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 34b729fc751b..bd11d33ea14d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1568,6 +1568,7 @@ static inline struct pglist_data *NODE_DATA(int nid)
 extern struct pglist_data *first_online_pgdat(void);
 extern struct pglist_data *next_online_pgdat(struct pglist_data *pgdat);
 extern struct zone *next_zone(struct zone *zone);
+extern struct zone *next_zone_pgdat(struct zone *zone, struct pglist_data *pgdat);
 
 /**
  * for_each_online_pgdat - helper macro to iterate over all online nodes
@@ -1600,7 +1601,7 @@ extern struct zone *next_zone(struct zone *zone);
 #define for_each_populated_zone_pgdat(zone, pgdat)	\
 	for (zone = pgdat->node_zones;			\
 	     zone;					\
-	     zone = next_zone(zone))			\
+	     zone = next_zone_pgdat(zone, pgdat))	\
 		if (!populated_zone(zone))		\
 			; /* do nothing */		\
 		else
diff --git a/mm/compaction.c b/mm/compaction.c
index 015126803017..96434f6fc1ad 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2152,7 +2152,6 @@ static unsigned int fragmentation_score_node(pg_data_t *pgdat)
 {
 	unsigned int score = 0;
 	struct zone *zone;
-	int zoneid;
 
 	for_each_populated_zone_pgdat(zone, pgdat)
 		score += fragmentation_score_zone_weighted(zone);
diff --git a/mm/mmzone.c b/mm/mmzone.c
index c01896eca736..043a6dc16c05 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -43,6 +43,18 @@ struct zone *next_zone(struct zone *zone)
 	return zone;
 }
 
+/*
+ * next_zone_pgdat - helper magic for for_each_zone() per node
+ */
+struct zone *next_zone_pgdat(struct zone *zone, struct pglist_data *pgdat)
+{
+	if (!zone || !pgdat)
+		return NULL;
+	if (zone < pgdat->node_zones + MAX_NR_ZONES - 1)
+		return ++zone;
+	return NULL;
+}
+
 static inline int zref_in_nodemask(struct zoneref *zref, nodemask_t *nodes)
 {
 #ifdef CONFIG_NUMA

