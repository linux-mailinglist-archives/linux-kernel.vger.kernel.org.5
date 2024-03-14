Return-Path: <linux-kernel+bounces-102690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7463087B5F4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B001F229EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711ED523C;
	Thu, 14 Mar 2024 00:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rxtsGAnj"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF9A4A0F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 00:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710377836; cv=none; b=kp0+y/HTnUUiimo7GXwcfzHlpNLlI5H4n8G7mEv9q7x476spaVZhPLk48h3TMTiQtsiFZI+WRCUy+WpfftQSNlPXq7SWEQkYWMQoDzABxgW+nnAfPsc3DKVV088XK7r54wfJBZjgTk0HzUM8jCsyaDBPioWZNIkC1Nv9lVYs4JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710377836; c=relaxed/simple;
	bh=CpoInyhXc2h5Z453QbsGAwYvcsGIOLrJqultM5kbsdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q8r7I/SCuJ9UrWlW5kTtHZ8bPd8siwD+wfTi2qKYARY+3aBOkFNMwfXovAyiQ/kghfa3I3LbVm80ecLw4CeNgHT3ESWzhFdlx5zdy7Ge5o8lEUqyV9bGTVbiOtEtK/OZUvHjcqwc4suofcCVsuH0slBOra6xuDulff9Qhd1HniI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rxtsGAnj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=LBPQUH1A+ayT+t1NyYBhKLCUNFBTXFzwBcbdjjDLePI=; b=rxtsGAnjmbV2rJ2NHM+9o+cqYj
	uh4EKUrvITTt43dBigW6dAkJRGBJB3lqkNTH0UhEUXMwW1AHJLLNW+lDP8GYLDIioc26TkIoqHXon
	uFb8fTIKqcFP37sxqANdPu5kNVzVUOZB7paMdYFliPXVoVLGYQ8qFK8cBkKjLHpHfm5z7QWCEsrWp
	I3M+bX8R+04bVcdVO7Yfa9jSQHU1N3HNdIPyz9PgzeDRT8gt28JIUcAtLOYbRwRmriKjniLoJfrie
	0bQTGhgaEkDXaHJ90ki30/HSzVkBU8kO8+PZLc2bI8CeqgDDzIPWMUiBh+D9MFmvTN0wwOWouh3NB
	iJdUOqLQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkZPE-0000000CRHg-1cy4;
	Thu, 14 Mar 2024 00:57:12 +0000
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
Subject: [RFC] mm/vmstat: add a single value debugfs fragmentation metric
Date: Wed, 13 Mar 2024 17:57:10 -0700
Message-ID: <20240314005710.2964798-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

In considering the general impact to memory fragmentation over
new features, or enhancehments I had asked what metric we could
use which is a single digit value. John Hubbard provided one [0]
however we'd need to tally up used folios per order as well, and
tallying this up would be expensive today. The value would also
only tell us how memory fragmented a system is. We can instead
just use the existing fragmentation index but generalize a single
value from it. This tells us more, when generalized to one value
it can tell us both how likely memory allocations might fail due
to external fragmention and how likely we are to fail allocations
due to low memory.

Today we expose an external fragmentation index per node and per zone,
per each supported order. This value is useful to tell us how externally
fragmented a system might be with the full scope of the CPU topology.
Obviously, the CPU topology can vary per system and per architecture,
for instance two separate x86 systems may have:

cat /sys/kernel/debug/extfrag/extfrag_index
Node 0, zone      DMA -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000
Node 0, zone    DMA32 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000
Node 0, zone   Normal -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000
Node 1, zone   Normal -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000

cat /sys/kernel/debug/extfrag/extfrag_index
Node 0, zone      DMA -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000
Node 0, zone    DMA32 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000
Node 0, zone   Normal -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000

The number of zones we have may also change over time.

This puts a bit of onus on userspace if all it wants is a general sense
of how externally fragmented a system is, overall. Provide a simple
one unit average for the fragmentation index to allow to simplify
measurements in userspace.

To make it easier for humans to grok, adjust it to be a value between
-100 (allocations failing due to lack of memory) to 100 (super fragmented).

[0] https://lore.kernel.org/all/5ac6a387-0ca7-45ca-bebc-c3bdd48452cb@nvidia.com/T/#u

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/vmstat.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 582f89b37ccf..e80983772c83 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -2262,6 +2262,54 @@ static const struct seq_operations extfrag_sops = {
 
 DEFINE_SEQ_ATTRIBUTE(extfrag);
 
+static ssize_t read_extfrag_pct(struct file *file, char __user *user_buf,
+			     size_t count, loff_t *ppos)
+{
+	char buf[32];
+	unsigned int len;
+	pg_data_t *pgdat;
+	struct zone *zone;
+	unsigned long flags;
+	unsigned int order;
+	unsigned int num_pgdats = 0;
+	int index_total = 0;
+
+	for_each_online_pgdat(pgdat) {
+		int index_pgt = 0;
+		int num_zones = 0;
+		num_pgdats++;
+		for_each_populated_zone_pgdat(zone, pgdat) {
+			num_zones++;
+			int index = 0;
+
+			spin_lock_irqsave(&zone->lock, flags);
+			for (order = 0; order < NR_PAGE_ORDERS; ++order) {
+				index += fragmentation_index(zone, order);
+			}
+			spin_unlock_irqrestore(&zone->lock, flags);
+
+			index_pgt += index / NR_PAGE_ORDERS;
+		}
+
+		BUG_ON(!num_zones);
+
+		index_total += index_pgt / num_zones;
+	}
+
+	index_total = index_total / num_pgdats;
+
+        len = sprintf(buf, "%d.%02d\n",  index_total / 10, index_total % 10);
+
+        return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static const struct file_operations extfrag_pct_fops = {
+        .read = read_extfrag_pct,
+        .open = simple_open,
+        .owner = THIS_MODULE,
+        .llseek = default_llseek,
+};
+
 static int __init extfrag_debug_init(void)
 {
 	struct dentry *extfrag_debug_root;
@@ -2274,6 +2322,9 @@ static int __init extfrag_debug_init(void)
 	debugfs_create_file("extfrag_index", 0444, extfrag_debug_root, NULL,
 			    &extfrag_fops);
 
+	debugfs_create_file("extfrag_pct", 0444, extfrag_debug_root, NULL,
+			    &extfrag_pct_fops);
+
 	return 0;
 }
 
-- 
2.43.0


