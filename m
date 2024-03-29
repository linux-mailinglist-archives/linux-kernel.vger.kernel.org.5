Return-Path: <linux-kernel+bounces-125194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35B78921FB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F95285993
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022FD131BA7;
	Fri, 29 Mar 2024 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cghGEWlR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B981F4D110;
	Fri, 29 Mar 2024 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711731365; cv=none; b=M1rocGSlddX2FsHTCiqwZjoUq1DjOdwE8dHY9Mdx1byAkKsaKzOD+syKxjISzhI4eOYrYUKoVDOgz4/NgOg0DPZugvEve80OPKwogViPfO0E5WlYlpggi6X12PWQp9gV6aHif19VKn1ihLMV2bmZTZySeQwyneMGw3cl9ybzyzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711731365; c=relaxed/simple;
	bh=VxARxmxYM3GO7DLsPsyLQsRNQnRnEuKjwENsIJuOWpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fovNP9SLOl9OkXgiAl8Yox6+/tVnLp9hX/NoYa21d7XCJWXlD7mm/qLhUtx4VqT57wZ6bpUbYWFy+a6zvWMpdzYp3QOJSWR/psH4vQWbnTnlnGrk6QD5qonJnjfoj9SPEK/7K8oR69izZuq9hTdf6YZbj6nAiN/Cc4jggo5pAGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cghGEWlR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711731363; x=1743267363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VxARxmxYM3GO7DLsPsyLQsRNQnRnEuKjwENsIJuOWpU=;
  b=cghGEWlRQEypXobcRDQHQotx8FyupUqaYmD2+neAB9zbBDmSAVklsJZT
   mGMzeLco2qDCvsj9P7iNcz3xQEPBP4Cqjz6+b+3Wedamd8ctCyf5kpXb2
   VDj3cx738JHnjZN27XFeIWy6Mh12MsSzgLC6FUCD6/d4gw148xLCanTW8
   00LyxzFQR2E6IfnzWA9DKT8IkaKsfmRj8/rK0yjOxYDi1V4z82u4l3UD6
   wRDtcYWDLq9kjx4GlSYhtfgafsnWuWqrEnufFUjAyDJU0PmaHu7WFHB0U
   5jsY/EeY622OdunAxq7c3J7YSv+NgqzhLSae9BYLaU+xYOahWCpFoFPYS
   A==;
X-CSE-ConnectionGUID: UYi93YssSbOi7bEB55ufVw==
X-CSE-MsgGUID: vgVxRWh1QMSgQFeTW9IXWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="18072481"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="18072481"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 09:55:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="17100401"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa008.fm.intel.com with ESMTP; 29 Mar 2024 09:55:58 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] page_pool: try direct bulk recycling
Date: Fri, 29 Mar 2024 17:55:07 +0100
Message-ID: <20240329165507.3240110-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329165507.3240110-1-aleksander.lobakin@intel.com>
References: <20240329165507.3240110-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the checks for direct recycling possibility live inside the
Page Pool core, reuse them when performing bulk recycling.
page_pool_put_page_bulk() can be called from process context as well,
page_pool_napi_local() takes care of this at the very beginning.
Under high .ndo_xdp_xmit() traffic load, the win is 2-3% Pps assuming
the sending driver uses xdp_return_frame_bulk() on Tx completion.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 net/core/page_pool.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 9d56257e444b..4c175091fc0a 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -772,8 +772,11 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 			     int count)
 {
 	int i, bulk_len = 0;
+	bool allow_direct;
 	bool in_softirq;
 
+	allow_direct = page_pool_napi_local(pool);
+
 	for (i = 0; i < count; i++) {
 		struct page *page = virt_to_head_page(data[i]);
 
@@ -781,13 +784,13 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 		if (!page_pool_is_last_ref(page))
 			continue;
 
-		page = __page_pool_put_page(pool, page, -1, false);
+		page = __page_pool_put_page(pool, page, -1, allow_direct);
 		/* Approved for bulk recycling in ptr_ring cache */
 		if (page)
 			data[bulk_len++] = page;
 	}
 
-	if (unlikely(!bulk_len))
+	if (!bulk_len)
 		return;
 
 	/* Bulk producer into ptr_ring page_pool cache */
-- 
2.44.0


