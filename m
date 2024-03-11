Return-Path: <linux-kernel+bounces-99530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 690108789A6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E46D1F21FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0C143AAC;
	Mon, 11 Mar 2024 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6fUVGPl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AD3ECC;
	Mon, 11 Mar 2024 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189957; cv=none; b=M4qczGomWE69gfz+DXNy90w4yP1px2loa1Dx7TOJpE8oHyMZg3TOYDM+ov+XM6ks/xyIlZRi6k5yrqEDTKMG5LkiCIHwajEA2KClABI9uDu6wJpf4uRq1a9TYKP1NGcud30eAx7YAhdQ/goPIo2EWzXapvJ0c6Cz4B5dXFKywYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189957; c=relaxed/simple;
	bh=s5xI8mQzAoMjxpwEaBaKlaL9MAdSZsz/UtdcP8IG03A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VZB1ZXVK8J74vDrLSEZO9MclH3BfFh5Z+MOqf+x3t4+FpZhhHrTCWxF6LwYqrNvafme8bDyt64I49nphFQ69qvueycdFjjflTfrwqUgfg+WjX0DdGG34m9JanDF2JeKBK59nmssuPnGTOS4R8Soy4enevljVMYL8wH5b+tvyWEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6fUVGPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78E1C43390;
	Mon, 11 Mar 2024 20:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710189957;
	bh=s5xI8mQzAoMjxpwEaBaKlaL9MAdSZsz/UtdcP8IG03A=;
	h=From:To:Cc:Subject:Date:From;
	b=A6fUVGPlk5NuPRlI/mnP1O/IxeWLCbg00NHinziLuI6WiVNTXi/0/KI2drBkdkUSv
	 9RfJ1iM7LmzejKD1R5IGpER9kAzambV0NRrW1TElkuDE1uT40NuKg69gC2IYzE+BX0
	 ivzDHEL7sMthf+yv4+MZXmOvVSTytptVmO+GZ4fc622uSwwFyZ7HgTA1YC0fmTJyJv
	 MZQoP4byqHrGOMEpMOH2vP57quYbdZPjcWO2cEeaoQ6N181rs64ojbqVP4QNpHw6Cn
	 vYDGRXvFYL6ibPnaFqbU9q36RnANPS1XGkC6EqfjEoyhTZUxmRKB3iMnKqyvTaaZYO
	 GJfROvh/RhfSA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: honggyu.kim@sk.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/4] mm/damon: add a DAMOS filter type for page granularity access recheck
Date: Mon, 11 Mar 2024 13:45:41 -0700
Message-Id: <20240311204545.47097-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from RFC v1
(https://lore.kernel.org/r/20240307030013.47041-1-sj@kernel.org)
- Rename __damon_pa_young() to damon_folio_young_one()
- Mark the folio as old from the filter for the next check

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


SeongJae Park (4):
  mm/damon/paddr: implement damon_folio_young()
  mm/damon/paddr: implement damon_folio_mkold()
  mm/damon: add DAMOS filter type YOUNG
  mm/damon/paddr: support DAMOS filter type YOUNG

 include/linux/damon.h    |  2 ++
 mm/damon/paddr.c         | 64 +++++++++++++++++++++++++---------------
 mm/damon/sysfs-schemes.c |  1 +
 3 files changed, 43 insertions(+), 24 deletions(-)


base-commit: 13043cde46a19e72d37965b67b74e564623f65e7
-- 
2.39.2


