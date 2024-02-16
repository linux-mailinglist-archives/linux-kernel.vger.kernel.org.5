Return-Path: <linux-kernel+bounces-69250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A017858641
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF20284FFD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A75137C5C;
	Fri, 16 Feb 2024 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVej5bwl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584EF1369AA;
	Fri, 16 Feb 2024 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112430; cv=none; b=U0LmtdFajfK9PdzidLNgj9pEkqannRyjwkcVhuJ5gWJT0eVklCZGwPMIa30IrV2sfYGou1vGMSK2JX54PY06GfRpA+/wEn1RQThxp1kccIPy1oou3Me34Nu8u5w3bP8FvmFWbJyIdKjYu5DQ5zkoiL13r+pDVN+NixT8VI1YL1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112430; c=relaxed/simple;
	bh=KIYFFZlklNJB3GcWj6tjjHQ4i09E6AICjsErgAI/kHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s4B7Ii9QDjlWy5e/iYak7iOkOpFmC2Q46oP6ziA9cuKnqTSyYJo2PuHV8/WbbgCfknMrGlIfgX5sliXcJ7caIYTtE3DTV21yIX30kEqzy7kR7P0vVZasiaA1tzcyp8NfhGCIvqORQwb+Kqz9qRAGU5mjM7xfqNSALBV87SFH0eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVej5bwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562A6C433F1;
	Fri, 16 Feb 2024 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708112429;
	bh=KIYFFZlklNJB3GcWj6tjjHQ4i09E6AICjsErgAI/kHs=;
	h=From:To:Cc:Subject:Date:From;
	b=kVej5bwlwvTjKN8bv1jBXdDFINYZYqRwCXuvFIIAMP9Erd/haiqJJyIoNvCOJv7/W
	 G3smFU0REZuYhPxBKlVcGHGGutjXzBiN0GqrrZk3JzDr8GqRhJrY8FPnDQKsjllrgd
	 vp/Yjm9jlZ6g7Q9iC+2YTC6ZS7V2BIOTo4zVxYEKtEw4zy01/RHB7QZ/nNUhbyAOwB
	 lffB1AdUG8NSK1vsC+1CLD2y4UUnhx9FdKdtallDZOOf8qZCMvIog+BmFGMLPGPhfO
	 ZEVqxjqPl/Zd1CzpYtj0PCYKUYfRDXMWh0YAT9LAmqqLlKGBIQ7m8Mn1vM+CWqWeuk
	 YMJ2FTeqh+pxA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mm/damon: fix quota status loss due to online tunings
Date: Fri, 16 Feb 2024 11:40:23 -0800
Message-Id: <20240216194025.9207-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_RECLAIM and DAMON_LRU_SORT is not preserving internal quota status
when applying new user parameters, and hence could cause temporal quota
accuracy degradation.  Fix it by preserving the status.

SeongJae Park (2):
  mm/damon/reclaim: fix quota stauts loss due to online tunings
  mm/damon/lru_sort: fix quota status loss due to online tunings

 mm/damon/lru_sort.c | 43 ++++++++++++++++++++++++++++++++++++-------
 mm/damon/reclaim.c  | 18 +++++++++++++++++-
 2 files changed, 53 insertions(+), 8 deletions(-)


base-commit: 0f8cac70960349ba21deb424bd41bc4f4362c113
-- 
2.39.2


