Return-Path: <linux-kernel+bounces-94895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 924D3874671
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C141F2427D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C32CA78;
	Thu,  7 Mar 2024 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNWVZ5Ua"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0912963C7;
	Thu,  7 Mar 2024 03:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709780419; cv=none; b=iXrovgOTo2IpF8bEjfqQYdMS8/6QKuy1YSoj7y7YuHu3Gbav6rkKEHfwA/knSoeIYPkstMMNCoSB7MpskVBnOal02LtYbQcko4vSx0dCTMPb7PbVqc4XMX5ynDGJdMq48chU7uGnohBd+BfzyDG8KcZ+iDE4p3Mv8Tuw8wq+/gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709780419; c=relaxed/simple;
	bh=SKDskSd9+RHTYzohWkfkmurFwjgubMDTQl6vfvCQs5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mwIqYeQO46KFpF5JC40IkN25AnHWXoWqQlKXZqDDsHsDypiVJXCpGNJr2q9Wp9t8/6Rnm2pr8eEgkoqPg5062QZv7rZ/PmlbRUd9pcR7exUtDA21gVAnSk8UDWNvgOr9JhiXdHkW7Jh+MFYV9ukzRpIFFdOeeNxJN7ZeQ45rX5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNWVZ5Ua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F5FC433C7;
	Thu,  7 Mar 2024 03:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709780418;
	bh=SKDskSd9+RHTYzohWkfkmurFwjgubMDTQl6vfvCQs5Y=;
	h=From:To:Cc:Subject:Date:From;
	b=MNWVZ5UaOouUV0GmS9soRfvZz7uEDLs0c9qjfpsMFIyYID5x1KTMaegxXZoOlRuZN
	 trL7xfGG4vS3gFvPPGpX5x0J1DPYqJD1dwSLAG1fwqMiLpQ3RwG07ErEiT1rAm7aLj
	 bVuuPMrbUwmZ2QMMBPt4yCvO6f+KrvKCqGLKMQ2aSxSsgh1LNw8qTIrSnnmXcRPY7C
	 kepNZ50op2NzFicOAZOu2amTBgA3aOaqfsrKnLv590qXwZi/N8EL2CGVEnyNeVKhBs
	 WwzOzZ0rou2lMvnV6+lOjnBAMlp6GvtIatIj7xYnydboCnleokcqV1SjqS3vbiaArH
	 Gt22LHfxmGU4Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	honggyu.kim@sk.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] mm/damon: add a DAMOS filter type for page granularity access recheck
Date: Wed,  6 Mar 2024 19:00:10 -0800
Message-Id: <20240307030013.47041-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON allows users to specify desired ranges of overhead and accuracy of
the monitoring, and do its best effort to make most lightweight and
accurate results.  A recent discussion for tiered memory management
support from DAMON[1] revealed that the best effort accuracy may not
suffice in some use cases, while increasing the minimum accuracy can
incur too high overhead.  The discussion further concluded finding
memory regions of specific access pattern via DAMON first, and then
double checking the access of the region again in finer granularity
could help increasing the accuracy while keeping the low overhead.

Add a new type of DAMOS filter, namely YOUNG for such a case.  Like anon
and memcg, the type of filter is applied to each page of the memory
region of DAMOS target memory region, and check if the page is accessed
since the last check.  Because this is a filter type that applied in
page granularity, the support depends on DAMON operations set.  Because
there are expected usages of this filter for physical address space
based DAMOS usage[1], implement the support for only DAMON operations
set for the physical address space, paddr.

[1] https://lore.kernel.org/r/20240227235121.153277-1-sj@kernel.org

SeongJae Park (3):
  mm/damon: add DAMOS filter type YOUNG
  mm/damon/paddr: implement damon_folio_young()
  mm/damon/paddr: support DAMOS filter type YOUNG

 include/linux/damon.h    |  2 ++
 mm/damon/paddr.c         | 29 +++++++++++++++++++----------
 mm/damon/sysfs-schemes.c |  1 +
 3 files changed, 22 insertions(+), 10 deletions(-)


base-commit: 78a854de1f605e99ccc20df1775f237120cca47c
-- 
2.39.2


