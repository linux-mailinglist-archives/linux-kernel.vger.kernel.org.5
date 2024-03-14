Return-Path: <linux-kernel+bounces-102688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B1187B5F2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD8D3B22A92
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6A5C2D6;
	Thu, 14 Mar 2024 00:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WprG9LXx"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4EC8F62
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 00:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710377683; cv=none; b=TzjVNpw0QacqJsk99hfo6RolNY9rXtrEg80g1Nk7QqPxHcK8juObpOnPBamrFcYpHSvpbPjvDEmHJMTUWGSvR+dq/7nhOlr0Y0J+k4neIerwiQ+OdFh7a6mrPiqCTeiy4q/yKhJ9ihmraxwxfAYxFNj57ccPA7DYMEn8jZHeCS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710377683; c=relaxed/simple;
	bh=fERwqyDgx9PvBlsJI0XpErqvohPCsQlGNvyKE6D5xE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diJFmpRvCtndsJJhPD/joMLVvmBJec6lHvbnrMaUSy8cX98R2xXOQFmumoGlX90O7ThznFAZkyIMbiB+Ag1YDPYCPsCfmYlu/OdvwCfR5z4+9yR6ghdLjBj6qdgyrG0vIdcPEIaU3Vb7oYLEHpqzqd72fHDxT6LvCD000g8CSQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WprG9LXx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=IlrnMbOqpJ2/S6gj5kQQ6CnmyYoOw3Yg8bRGX3sCghg=; b=WprG9LXxkpkrd2J/PoJcJt1Zi/
	AXp+bYR1AcF0qAtAKEWut8ddrHSpIg3sP5Gnh5Yq3548iivB+Kp3j+ccbsjktXIuOxHHVvdsk//dD
	LxqHD7UmSi8A7EIthtU7CxqOu5Yw0d1tRuuqrneTbeqayayJVS4GNqL7LfGgsLQHP3sbeVGOv+4/4
	O3vLr1RrHBG+6ZJ54ftmdIUUlHRfuav8JasAp0ootpUZOlLrmmFM3LqV76FoZ4IPfRZdtklj9C0Nw
	5S6w/VDtaLYk1h+yj7bfW1pJnrpji0jVAnvUPoVqRLeN13XZkX6AkYuggSSXLu1HCkiLmzcyLWHCS
	7ZK9ckdw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkZMj-0000000CQo5-0pYM;
	Thu, 14 Mar 2024 00:54:37 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: akpm@linux-foundation.org,
	jhubbard@nvidia.com,
	vbabka@suse.cz,
	mgorman@suse.de,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	dave@stgolabs.net,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH 2/3] mm/compaction: add and use for_each_populated_zone_pgdat() helper
Date: Wed, 13 Mar 2024 17:54:34 -0700
Message-ID: <20240314005436.2962962-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240314005436.2962962-1-mcgrof@kernel.org>
References: <20240314005436.2962962-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

We can just wrap most of the work done on fragmentation_score_node()
into a pgdat helper for populated zones. Add the helper and use it.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/mmzone.h | 8 ++++++++
 mm/compaction.c        | 9 ++-------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a497f189d988..1fd74c7100ec 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1597,6 +1597,14 @@ extern struct zone *next_zone(struct zone *zone);
 			; /* do nothing */		\
 		else
 
+#define for_each_populated_zone_pgdat(zone, pgdat)	\
+	for (zone = pgdat->node_zones;			\
+	     zone;					\
+	     zone = next_zone(zone))			\
+		if (!populated_zone(zone))		\
+			; /* do nothing */		\
+		else
+
 static inline struct zone *zonelist_zone(struct zoneref *zoneref)
 {
 	return zoneref->zone;
diff --git a/mm/compaction.c b/mm/compaction.c
index b961db601df4..023a09d0786d 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2151,16 +2151,11 @@ static unsigned int fragmentation_score_zone_weighted(struct zone *zone)
 static unsigned int fragmentation_score_node(pg_data_t *pgdat)
 {
 	unsigned int score = 0;
+	struct zone *zone;
 	int zoneid;
 
-	for (zoneid = 0; zoneid < MAX_NR_ZONES; zoneid++) {
-		struct zone *zone;
-
-		zone = &pgdat->node_zones[zoneid];
-		if (!populated_zone(zone))
-			continue;
+	for_each_populated_zone_pgdat(zone, pgdat)
 		score += fragmentation_score_zone_weighted(zone);
-	}
 
 	return score;
 }
-- 
2.43.0


