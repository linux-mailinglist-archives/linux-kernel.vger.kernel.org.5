Return-Path: <linux-kernel+bounces-136552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0877989D57B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17671F235EB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CA27FBB3;
	Tue,  9 Apr 2024 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJek0EN9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3CB7F7F8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654714; cv=none; b=Eq421KnDMcArita+MSftV1S2cM+YBvpxadpTLdbnZOxsJL71D6V0tkH3NnLkUXnZ+W64NV+qsiP1IOmKW4xGPokv+5Z7UvRP/djgVbTKrNqT8oNbGegQM6fzNV+ghvabirnDjXEWl1nFpwgj18GK2qZ2gKCIXpDmJwXIJKFF9wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654714; c=relaxed/simple;
	bh=2xDuSu2bZaFbHQfV9u0Wk7X0lwP1q8Cg/dxX29fvekw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWx324BsHeSP9WWnHSdM1jTP16xbDixOVv4fgs5leVa/BbWyRYORR+BtFVm02r/8vNsv/h9a2PJ3dz5LlheCG7OA5nzlG82/SFpDSEu0ZYGEmehxR667zryGPVMZeoKdPM1FAAv8ajEUZugjdWHbaMjQvCsouifoXY+YedI7w4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJek0EN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCB9C433F1;
	Tue,  9 Apr 2024 09:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712654714;
	bh=2xDuSu2bZaFbHQfV9u0Wk7X0lwP1q8Cg/dxX29fvekw=;
	h=From:To:Cc:Subject:Date:From;
	b=MJek0EN91l7r5UXMfQ2gaY/SfZ++QWsTWhwAKvlwbJlC/yB8r1Hk0jR4i4ftKjb7y
	 1wl3UPPxcyEJzXhTBG8UJozzZRuc84XFgfyIReAUrbGJzalyfVnNHhaDzV7mFGUfOF
	 xDXwokd9YPgfIHdcG0w3HqqB2jik7zjpPNuegaG5j6s69HAfT3GKi6R3/aFl4F8t8x
	 3fc55kQl78et94d09S9b+R3Diq9SuxKnAIGYZ08V+B/mDpBcqakjI0ud5CbzZcmumy
	 GJsrvntx1L51oi+/d64vt9MsloCI2wxe7CMD2U2ZwObAEqJQldYu7gdbTsevzuxCdn
	 A5cS4lJg476ow==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: "Alex Shi (tencent)" <alexs@kernel.org>
Subject: [PATCH v4 0/9] transfer page to folio in KSM 
Date: Tue,  9 Apr 2024 17:28:15 +0800
Message-ID: <20240409092826.1733637-1-alexs@kernel.org>
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
  mm/ksm: Convert chain series funcs to use and return folios
  mm/ksm: replace set_page_stable_node by folio_set_stable_node

 mm/ksm.c     | 263 ++++++++++++++++++++++++++-------------------------
 mm/migrate.c |   2 +-
 2 files changed, 134 insertions(+), 131 deletions(-)

-- 
2.43.0


