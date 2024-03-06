Return-Path: <linux-kernel+bounces-93719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 009098733BA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D411C215D2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C122A5FDB5;
	Wed,  6 Mar 2024 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aVH/oJsK"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041235D750
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720023; cv=none; b=MusrVvZHrbsTnpUyZOXZwmnSBXRRF9Zbs7ObEcklZlHCHZvlMlgy8KTG0+KbQsH8yX95NfCTzQrvuaR4l2Hc6SeRJy0jOjs8FEAaMxiJEg2q+czdHm/nzLQnNzhuN1sFa7Sb+PLwrkwvrHrV4Yx4IyqVpw1SUIbvm8Wr8bRWyIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720023; c=relaxed/simple;
	bh=MzCC0AE/rUvpEAo4tb5cVZ7cGsewHKgZszzxyYlWgms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=foAprtJ0H+fGcIz4XPbPNRAhY935n/+B6B8RZibPe80XKR0g/n0TKrliKrklrxgYo03xj/EGaw6ob3JSkkmDAEWpmI/+qo07/D10xj++eNB4S7TIkVZI8tDMjNmfSwlWp2xIDi/68x8qdKaHFyuyG+tz/pg6QItpn7+L7BrbJEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aVH/oJsK; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709720018; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jQS6ixAjVk0AC8cKYwTBDAm2HkLKEDsUdifzfOmBcs0=;
	b=aVH/oJsKmuK6AiXGW+Yhae9St6wsrA+7CYmVTQyL6WXrMA45Ym8q7cE4mc3QAGNjSve/8uzcXVWPvHkxX9Lo1UKlrEko+TNsrrsRzfrKXLFO6PYLgwM5NjXyyZfAuimM0UZnYzeqp8abGal/E6v5Vx+OfdCGAPr9JhSCGrzwp24=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W1xC4Y-_1709720017;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W1xC4Y-_1709720017)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 18:13:38 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com,
	linmiaohe@huawei.com,
	naoya.horiguchi@nec.com,
	mhocko@kernel.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] docs: hugetlbpage.rst: add hugetlb migration description
Date: Wed,  6 Mar 2024 18:13:28 +0800
Message-Id: <63fb16e7a4ebc5cb69ce655af86e29b2d8e9ba34.1709719720.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1709719720.git.baolin.wang@linux.alibaba.com>
References: <cover.1709719720.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some description of the hugetlb migration strategy.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 Documentation/admin-guide/mm/hugetlbpage.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index e4d4b4a8dc97..f34a0d798d5b 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -376,6 +376,13 @@ Note that the number of overcommit and reserve pages remain global quantities,
 as we don't know until fault time, when the faulting task's mempolicy is
 applied, from which node the huge page allocation will be attempted.
 
+The hugetlb may be migrated between the per-node hugepages pool in the following
+scenarios: memory offline, memory failure, longterm pinning, syscalls(mbind,
+migrate_pages and move_pages), alloc_contig_range() and alloc_contig_pages().
+Now only memory offline, memory failure and syscalls allow fallbacking to allocate
+a new hugetlb on a different node if the current node is unable to allocate during
+hugetlb migration, that means these 3 cases can break the per-node hugepages pool.
+
 .. _using_huge_pages:
 
 Using Huge Pages
-- 
2.39.3


