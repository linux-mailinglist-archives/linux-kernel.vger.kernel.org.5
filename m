Return-Path: <linux-kernel+bounces-160633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 963038B4079
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE501B22D12
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480B02032A;
	Fri, 26 Apr 2024 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVVGWpEo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883A1BE4A;
	Fri, 26 Apr 2024 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161180; cv=none; b=fvRfvWaBlEdDwiY5xXC5MeuoBqcfaV0mKZXKyd+Cu/gbgDdbQNeCaDTQh664jYLGngT9XNOQvwXdwgTAQhFv3/l9+gE99zShdPn6q2pVljbdoCakTCWPOPUhSmwFOy5CkJeskUPNXnx5bWjKI2ZFYEfvmw45bziH6iv9lJjhvPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161180; c=relaxed/simple;
	bh=KDQABXFXICsHnj+v3YhXIoEGy+Tp7EqKpAZ8dhNvvfY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LZHIra1oLEoZc1QKFY1zrrdYAEBGtZbHBtIljPRDVrcpnn/TAe4nxa45rKFMIpkD7+2qHdzhiB83Eec6HwgsaRZS/4ZBOBbcxN21hjuQconFNNvmQye/sg/9rxeexKIlHXAsb0Yh482oZ/C2By/l7YR2+ssccjF1sKNbDc1rCEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVVGWpEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F525C113CD;
	Fri, 26 Apr 2024 19:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714161180;
	bh=KDQABXFXICsHnj+v3YhXIoEGy+Tp7EqKpAZ8dhNvvfY=;
	h=From:To:Cc:Subject:Date:From;
	b=BVVGWpEoAs/HVIHW1jVbh/MGwqLjrbJJESwz32Kkj9LuwJ2IL5OXifVSlfWAbA5Ce
	 eECBaZlWlXZF+bSDyrZlFkjGOW4iDt41a/tmJEaGcI/iDhioMwYsXYr/Owm3d0OTyR
	 y+m4GRFg5UXOJKz58ElhqUoqEDxSmOFWLDTtSHiPi2pHWM+VTGbmMk6bU19VkD74m3
	 snsA/YQyeJQLeZIknVZcuxpLWlGx/U6PNcEM4UqVF/jmIGZAJQIOv6US7qQs3TRcDh
	 xlBqfihJ81nPUHd5Tl8XMItzJDDpmZzyxY27WnknsG1uuK7ipjIezKg9PR6aT9T8Xi
	 O8hDAE9+BMYzg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] mm/damon: add a DAMOS filter type for page granularity access recheck
Date: Fri, 26 Apr 2024 12:52:39 -0700
Message-Id: <20240426195247.100306-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from RFC v2
(https://lore.kernel.org/r/20240311204545.47097-1-sj@kernel.org)
- Add documentation
- Add Tested-by: Honggyu Kim <honggyu.kim@sk.com>
- Wordsmith commit messages

Changes from RFC v1
(https://lore.kernel.org/r/20240307030013.47041-1-sj@kernel.org)
- Mark the folio as old if it was young
- Rename __damon_pa_young() to damon_folio_young_one()

DAMON provides its best-effort accuracy-overhead tradeoff under the
user-defined ranges of acceptable level of the monitoring accuracy and
overhead.  A recent discussion for tiered memory management support from
DAMON[1] concluded that finding memory regions of specific access
pattern with low overhead despite of low accuracy via DAMON first, and
then double checking the access of the region again in a finer (e.g.,
page) granularity could be a useful strategy for some DAMOS schemes.

Add a new type of DAMOS filter, namely 'young' for such a case.  It
checks each page of DAMOS target region is accessed since the last
check, and filters it out or in if 'matching' parameter is 'true' or
'false', respectively.

Because this is a filter type that applied in page granularity, the
support depends on DAMON operations set, similar to 'anon' and 'memcg'
DAMOS filter types.  Implement the support on the DAMON operations set
for the physical address space, 'paddr', since one of the expected
usages[1] is based on the physical address space.

[1] https://lore.kernel.org/r/20240227235121.153277-1-sj@kernel.org

SeongJae Park (7):
  mm/damon/paddr: implement damon_folio_young()
  mm/damon/paddr: implement damon_folio_mkold()
  mm/damon: add DAMOS filter type YOUNG
  mm/damon/paddr: implement DAMOS filter type YOUNG
  Docs/mm/damon/design: document 'young page' type DAMOS filter
  Docs/admin-guide/mm/damon/usage: update for young page type DAMOS
    filter
  Docs/ABI/damon: update for 'youg page' type DAMOS filter

 .../ABI/testing/sysfs-kernel-mm-damon         |  6 +-
 Documentation/admin-guide/mm/damon/usage.rst  | 26 ++++----
 Documentation/mm/damon/design.rst             | 20 +++---
 include/linux/damon.h                         |  2 +
 mm/damon/paddr.c                              | 64 ++++++++++++-------
 mm/damon/sysfs-schemes.c                      |  1 +
 6 files changed, 70 insertions(+), 49 deletions(-)


base-commit: 4b4dd809460911d6c406bb45d2c627a9e5734468
-- 
2.39.2


