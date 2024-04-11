Return-Path: <linux-kernel+bounces-139823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ADA8A0830
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834F7281803
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DD013CAA2;
	Thu, 11 Apr 2024 06:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVzRFEao"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDA413CABC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816054; cv=none; b=U5S1pHBXbvky/7S/4gPX4v6qJowlSM0TQnRgzDttctm6uS1ZNys7cW/jpYHiRvPYCae2Z+7R6yNhm1ci4fiTygc772xKNN5HgjEkN2trzTDi4oO9UdT36Xe5/lpEMtkzPdWs7mIUtU5ZZXq2TRE4TLkSPmj1ckpZ00WwBLTaQ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816054; c=relaxed/simple;
	bh=+FjVUrA5fdJ/d6cNIYDRyBigkWREtGjUPt3tLRh4HVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ssZNQUlsiDdaxqtnRw6xr4PCgC2Tqr8BwG4bDuKFMbuHoicgnvxlPk053POl59Z6/XWh7RjB/hElT10ogkPCLnvHJukrGLsh9AEb76G/vQ9hyNkpFx3WtgsogU0KlwRj/0cc9C9tvlr6blZ24Q6uv4dyPPbFBaHN82RLv5J2AAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVzRFEao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34306C43394;
	Thu, 11 Apr 2024 06:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712816054;
	bh=+FjVUrA5fdJ/d6cNIYDRyBigkWREtGjUPt3tLRh4HVU=;
	h=From:To:Cc:Subject:Date:From;
	b=OVzRFEaoSt0A4KVfm5E7VwlmSq2+5A5/TgVy0mvWq75wHhDkSONuQu6HrN9TFeQeK
	 t+gtz2xqgdoxRur0Dgp6NJlpbat/i81CJwJA2L/jynBh8Q1upFfC1DBiDNGaIcOlmM
	 P1pyg7O2zKYgHNz6RrhZ7HUSE9mFjU9JzuKkPGpB8HUvGZRv1AP/lUPVFFqF5UkdOm
	 0WAQM8PhfJCvDYNTEA+WeoccqM2cJP7Ka8+7ifacsnQ6SsCAIG/yqVZimoeMdacmac
	 H6A06vD7xZwdYhLipEmoJjLG0vNfuTLRdBjMaxXEzqb25mjVaYCZ15N9uTL7vmKhQl
	 kttN088xOQMAA==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zik.eidus@ravellosystems.com,
	willy@infradead.org,
	aarcange@redhat.com,
	hughd@google.com,
	chrisw@sous-sol.org,
	david@redhat.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>
Subject: [PATCH v5 0/10] transfer page to folio in KSM 
Date: Thu, 11 Apr 2024 14:17:01 +0800
Message-ID: <20240411061713.1847574-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

This is the first part of page to folio transfer on KSM. Since only
single page could be stored in KSM, we could safely transfer stable tree
pages to folios. 
This patchset could reduce ksm.o 57kbytes from 2541776 bytes on latest
akpm/mm-stable branch with CONFIG_DEBUG_VM enabled. It pass the KSM testing
in LTP and kernel selftest.

Thanks for Matthew Wilcox and David Hildenbrand's suggestions and comments!

Alex Shi (tencent) (9):
  mm/ksm: add ksm_get_folio
  mm/ksm: use folio in remove_rmap_item_from_tree
  mm/ksm: add folio_set_stable_node
  mm/ksm: use folio in remove_stable_node
  mm/ksm: use folio in stable_node_dup
  mm/ksm: use ksm_get_folio in scan_get_next_rmap_item
  mm/ksm: use folio in write_protect_page
  mm/ksm: Convert chain series funcs and replace get_ksm_page
  mm/ksm: replace set_page_stable_node by folio_set_stable_node

David Hildenbrand (1):
  mm/ksm: rename get_ksm_page_flags() to ksm_get_folio_flags

 mm/ksm.c     | 273 ++++++++++++++++++++++++++-------------------------
 mm/migrate.c |   2 +-
 2 files changed, 139 insertions(+), 136 deletions(-)

-- 
2.43.0


