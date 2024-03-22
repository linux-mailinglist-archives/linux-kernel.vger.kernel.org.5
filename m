Return-Path: <linux-kernel+bounces-111999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB528873F7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99791F2369D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6340F7AE50;
	Fri, 22 Mar 2024 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="JjKgd0LD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FgVjeW9o"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EA37AE44
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711136000; cv=none; b=U9e+pvwxAaMJ4n9p9JESpCbmbqSe0/1EnaHiV1abNU1Y4PWHyvB4OcNEsImnTB5ZKWJQga9tAiEFKcvrGWS0dgpSFnHYWs21JQpxj6+YRfTlK52Yo5NmiOSVkDvNhsYvw6fgwhi4XejBe5d9cEIzNv7Wo63q2pCpNVRF7YQ9Fig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711136000; c=relaxed/simple;
	bh=6aXe99vy9NwkLcaUAxwc/CBOxXdrV4VqdlEFRv/Uuoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HlMLYmVcEpONmEN5YlKP+HOoKJGG8uEcilP1/wT4LH6YA+3gBaBihLz6ac7Y0cQc/lVNTVmDH91aKYtwhOrgl6KiKvfgOOoqUEFZLo7LepA3gLWwrLW9YhlGLHcUTfsTiO0b5O/w2fsbaybFairYFtvgJQwgYRlfcQip+OOaMHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=JjKgd0LD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FgVjeW9o; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id D261C13800C8;
	Fri, 22 Mar 2024 15:33:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 22 Mar 2024 15:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm2; t=1711135996; x=
	1711222396; bh=Z4qwXiUVtIySYeeeDHMpOYt0KW6NAQHnh4gQJgkXoJ4=; b=J
	jKgd0LDJusRF0knrNa/Y3vIZsqA0w4UKM57xw1itDNsuPwP6aPkIFBrl7zrN7il4
	bNqLYIutwLOFKI8x7Z2EVdRDCXvqszrdQXGpUVWZ6Iv8YlGoPUzT1sKnrXJ9KaCj
	P7xoO+4KFQRE8QfWfptIi+uFGoXs6HCqYO+iL5kBZoThkCK+JYlI/3a4V70zYoyl
	PNIfqjrGonZNaaSulKPstQXQ0kqlKk9qUV7ao8E/1qHHKdFooQbyobSKo2d2RGwT
	YlhMGPd6YGLCvLGgvCnU/XzaaKALJLmjjDnu6YSX2E4bxiPJNIDQ9y0ohhU5yKgr
	ZTl9Nobi4OpJZPh8lBk2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1711135996; x=1711222396; bh=Z
	4qwXiUVtIySYeeeDHMpOYt0KW6NAQHnh4gQJgkXoJ4=; b=FgVjeW9osSLt3u5fV
	U6dMfnZUjQK+MnEXnWIY45U5l8YS29AcPodXP4MYaLWP8CVZLqDuteQoGN/+MbIA
	MkQy5yj7FDEKPB/ZXjekF4JOSLp/b6BRbaHY954hleESgi8exrQdLUvTDBrlLp9F
	RFixnQTy3RkYjUMz5WIev1vLCMHtvAUyKuzayP44l5r3zvEtQ2tfY8xhFBSItMkV
	fsnu3VCOV7c1ZZYqLMiTBfGM3ilqXSWaVvvFOV6wm40REDF2Nr18VHvd8VeR+ihA
	ZulIXqjVdExBpdXcVrA50n49XB9EaBl/fqmHAnznBINyaSP3xKdv2uuDsk9H3+O/
	PA3wA==
X-ME-Sender: <xms:_Nz9Zb7gI-wrn-B8CYOQBTG9cDPbbGeeKVogYTeyB7AJ37S79kRx0w>
    <xme:_Nz9ZQ6BTwJLk9v1nGr8zL06EbSHr9oQ3m8wLbZl88d3Sl2mLMeqpYSO3CWi7vHdi
    XQQqwnNcx6fhJUfTw>
X-ME-Received: <xmr:_Nz9ZSffFH4OqvrAYxjo09eX1y7zGBs_EeKZv15mqjLez0XEghxdHOCOBQzTHv-behz5AwRLfWgPzIstaOHWNIw26Qz0aEtfLIWF27eAaLXO7xsm0y4Tfa1x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtvddgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrgggtgfesthekredtredtjeenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepteduve
    ehteehheeiteeihfejveejledtgfdvieeuiedutefftdevtdfhteevtdffnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:_Nz9ZcJ5Nz7TrN_op3klkyGuQi7iFX_vpQjudJagb4i_srXeFkLPeA>
    <xmx:_Nz9ZfLnHgwLAGU5NfJuq6MWSzC6o53mfhv3Cj0hI3XObwYYDhixbg>
    <xmx:_Nz9ZVzKih2CVpMUeP5F10z4O5--guwyoNIBzNbscBlqy7GgHK4bwA>
    <xmx:_Nz9ZbJiVA2y8BI7AKxlULd4fUd6_B5KCzFEEExl9g4zXlVtPbf2xg>
    <xmx:_Nz9ZeYPNLpdW7MQ4RMi38ae07y6up8UAJRtrXjXA51ZpDn0dxaGWQ>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Mar 2024 15:33:15 -0400 (EDT)
From: Zi Yan <zi.yan@sent.com>
To: linux-mm@kvack.org
Cc: Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Yang Shi <shy828301@gmail.com>,
	Huang Ying <ying.huang@intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Yin, Fengwei" <fengwei.yin@intel.com>,
	SeongJae Park <sj@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] mm/migrate: split source folio if it is on deferred split list
Date: Fri, 22 Mar 2024 15:33:04 -0400
Message-ID: <20240322193304.522496-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
Reply-To: Zi Yan <ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

If the source folio is on deferred split list, it is likely some subpages
are not used. Split it before migration to avoid migrating unused subpages.

Commit 616b8371539a6 ("mm: thp: enable thp migration in generic path")
did not check if a THP is on deferred split list before migration, thus,
the destination THP is never put on deferred split list even if the source
THP might be. The opportunity of reclaiming free pages in a partially
mapped THP during deferred list scanning is lost, but no other harmful
consequence is present[1].

From v4:
1. Simplify _deferred_list check without locking and do not count as
   migration failures. (per Matthew Wilcox)

From v3:
1. Guarded deferred list code behind CONFIG_TRANSPARENT_HUGEPAGE to avoid
   compilation error (per SeongJae Park).

From v2:
1. Split the source folio instead of migrating it (per Matthew Wilcox)[2].

From v1:
1. Used dst to get correct deferred split list after migration
   (per Ryan Roberts).

[1]: https://lore.kernel.org/linux-mm/03CE3A00-917C-48CC-8E1C-6A98713C817C@nvidia.com/
[2]: https://lore.kernel.org/linux-mm/Ze_P6xagdTbcu1Kz@casper.infradead.org/

Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/migrate.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index ab9856f5931b..6bd9319624a3 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1652,6 +1652,29 @@ static int migrate_pages_batch(struct list_head *from,
 
 			cond_resched();
 
+			/*
+			 * The rare folio on the deferred split list should
+			 * be split now. It should not count as a failure.
+			 * Only check it without removing it from the list.
+			 * Since the folio can be on deferred_split_scan()
+			 * local list and removing it can cause the local list
+			 * corruption. Folio split process below can handle it
+			 * with the help of folio_ref_freeze().
+			 *
+			 * nr_pages > 2 is needed to avoid checking order-1
+			 * page cache folios. They exist, in contrast to
+			 * non-existent order-1 anonymous folios, and do not
+			 * use _deferred_list.
+			 */
+			if (nr_pages > 2 &&
+			   !list_empty(&folio->_deferred_list)) {
+				if (try_split_folio(folio, from) == 0) {
+					stats->nr_thp_split += is_thp;
+					stats->nr_split++;
+					continue;
+				}
+			}
+
 			/*
 			 * Large folio migration might be unsupported or
 			 * the allocation might be failed so we should retry

base-commit: 08a487ab26d541a3bd0adaee144f684b724d233b
-- 
2.43.0


