Return-Path: <linux-kernel+bounces-111129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A35886841
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF3F1F22D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E1218B15;
	Fri, 22 Mar 2024 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYcGa9mX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB65E18057
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096471; cv=none; b=T99+LDTtBlgFlTX4y8lzDwM1GdFfuuvk+YqRn79qIpi8t2hqwASleHKde5BYIkCW7LilpIEO/29eNXWTgNsMhK0V6o97WRGrJa4Y68PdLIjcb37KulRb9CJwuw94sADhggfQPEyesuOkpviXZ4yDUP2J72e05wH87ZfXN5Cg0bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096471; c=relaxed/simple;
	bh=BZayepR+CEi8yM6DRRgla9ll3e+zD9FmiqFSA2KVg2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kU2+dJFRBBmiRZnwnAzQDfcmPik9psn3dz+fsxUu6R3qvMEYlHUxyyAFBICuHz9yFFu0XZRSQOD7AEMy14pIrHfSTE81QyR9Q6U7SULjJDWYLDBI19VCjQjSR5HbNjQvXqqUojPFzOWcd7JFP4eMx0CL9Xc12CsMuXlAaQ2GCh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYcGa9mX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7149FC433C7;
	Fri, 22 Mar 2024 08:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711096471;
	bh=BZayepR+CEi8yM6DRRgla9ll3e+zD9FmiqFSA2KVg2o=;
	h=From:To:Cc:Subject:Date:From;
	b=rYcGa9mX0yTT/evSVfcg2Z33lFIs/T8RcTG+wJT277HuOklkjHAVjCt7clvy1ZPRa
	 3JbgDAIiJw8wxtBaxTfcAvy0TCk08LiBSwczpBPGyaJgUI47cMgbDgkEW8gCpaRHIA
	 cxD+4fnrZGgYx+fGrC39afObm9Xwm00bpziVLi7BLZVrygda9zQTMGyf9ZnT8P2xhU
	 cFE28HYo+TH29j2F/bZqkEsZbTzQGtbCH0bg0zp1y9hVkQVqUMONN0+XvC8b8E88CN
	 mO8DMf8LxVjDgU8+4eQvWtxg0sZC9l3QkYf6/7d9P1Xjxnsq5ll3HtrD7Zwlr+1Tnh
	 AmjinawuKgB1w==
From: alexs@kernel.org
To: Matthew Wilcox <willy@infradead.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Izik Eidus <izik.eidus@ravellosystems.com>,
	david@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: "Alex Shi (tencent)" <alexs@kernel.org>
Subject: [PATCH v2 00/14] transfer page to folio in KSM 
Date: Fri, 22 Mar 2024 16:36:47 +0800
Message-ID: <20240322083703.232364-1-alexs@kernel.org>
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
This patchset could reduce ksm.o 81kbytes from 2570760 bytes on latest
akpm/mm-stable branch with CONFIG_DEBUG_VM enabled.

Alex Shi (tencent) (14):
  mm/ksm: add ksm_get_folio
  mm/ksm: use folio in remove_rmap_item_from_tree
  mm/ksm: add folio_set_stable_node
  mm/ksm: use folio in remove_stable_node
  mm/ksm: use folio in stable_node_dup
  mm/ksm: use ksm_get_folio in scan_get_next_rmap_item
  mm/ksm: use folio in write_protect_page
  mm/ksm: Convert chain series funcs to use folio
  mm/ksm: Convert stable_tree_insert to use folio
  mm/ksm: Convert stable_tree_search to use folio
  mm/ksm: return folio for chain series funcs
  mm/ksm: remove get_ksm_page and related info
  mm/ksm: use folio_set_stable_node in try_to_merge_one_page
  mm/ksm: remove set_page_stable_node

 mm/ksm.c     | 259 ++++++++++++++++++++++++++-------------------------
 mm/migrate.c |   2 +-
 2 files changed, 131 insertions(+), 130 deletions(-)

-- 
2.43.0


