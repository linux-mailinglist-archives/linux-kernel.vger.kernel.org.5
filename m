Return-Path: <linux-kernel+bounces-117032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5C088A656
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B91A1C3C32D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B745E12B77;
	Mon, 25 Mar 2024 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1AJXD1u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0941D46B9B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370745; cv=none; b=PWX32rRlDX9qyMp+uJEj0z4Xfxp70XMWPDxlOLQT4DYbIKcPtqDSHKEhynHipL+xuksO/I9Orhw3yT2g4r9d6XzPCzMnJph7cXNgGyo2ycfh8lPCMEu+jtKXXpp+GjjB37mcQiTNRyRfOdnkZIed3xPIxAm9NynDZPZLkRAeioQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370745; c=relaxed/simple;
	bh=6S1jpM8cRjal0ma04kQFc9hgNF7SQSqnoGDvQZoxzUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N5wvCrt30RDjm8ARgGUTx6FIBQ9VzYVn9eKxldhq9atvbcWNn+TDxcGw6QO5f8xVn95cOyrnPbblWwib0kQb+3mACm55etNXKa2G8iJ4O2kKNWosEnjalbkvvZ+01xyMKa8yHiG7gQx6hmwIHD5G9lK0uCjUuqqeD2ZuV1bmQew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1AJXD1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C154BC43399;
	Mon, 25 Mar 2024 12:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711370744;
	bh=6S1jpM8cRjal0ma04kQFc9hgNF7SQSqnoGDvQZoxzUA=;
	h=From:To:Cc:Subject:Date:From;
	b=c1AJXD1uJxo0/HCChDVUYuM+YaNpjXA5bpAV6DV/h2IDgJpbREmcfv4+oXFnOrFIy
	 d1We1AV3bqL+RhTjJCiDHTH4YfzHWpxd31KIvvGMbVidqh1obvpEPLymxNPIVomFDs
	 Y52v/+fm2dy7E1LHyjNEAnAOLSZkLB1Bj9uNUEVczkKWvEPzKrH4IZJ7wCYvK6MQ3H
	 XeTfFJJk8WKOzOIzaqvFowEJ71Azh6RUdOr7N++V2mYRJGuW4NmvQQ3iRf5M+UwG47
	 1btU0QcIJjwT0uonQst7dpUcB7I/en2EFPGSIjebAPxJiUtSOc0Yz+vnKEtrGmdwls
	 UFl04zznNZ6CQ==
From: alexs@kernel.org
To: Matthew Wilcox <willy@infradead.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Izik Eidus <izik.eidus@ravellosystems.com>,
	david@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ryncsn@gmail.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>
Subject: [PATCH v2 00/14] transfer page to folio in KSM 
Date: Mon, 25 Mar 2024 20:48:47 +0800
Message-ID: <20240325124904.398913-1-alexs@kernel.org>
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
akpm/mm-stable branch with CONFIG_DEBUG_VM enabled. It pass the KSM testing
in LTP and kernel selftest.

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


