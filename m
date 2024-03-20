Return-Path: <linux-kernel+bounces-108549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 214D6880C21
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4AC281FC7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D422C69C;
	Wed, 20 Mar 2024 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3Gqg2/8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37422C683
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920257; cv=none; b=oKHM4mF7/y8l7+gF5z+U14Qt0kJOQjyDOJ18g2sTiW7I5xWEh0J0PiyxyWb+vXGB0dM85QIarazDnvIqLId3nExqrCejCx2zzW3/AMzKce64ZEP+cyB3joiiHR/og3oScDQKU3G24sh3egYDZ0mUkvEwgzK5ta9OhBD1RUNOaow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920257; c=relaxed/simple;
	bh=YTMRU0Nf5P5SYGoJuo+TisiaAmlJOWa0iSN0mNp+DiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J9rTK4REwrFnTCIDGLbKPKQt2aeqZCzrZXmn0RQv96epSTMNzRw1ejQ68jFpgWaRfAIfQNVx6CNxS1k/nfI/qy1Dc6IA2ji7m69n0zVu7RAqryaBDXs3m0JXMr4F97eTLoRXTlZUQ23LRBIQAat+w/4LlWKapHA+89z7yUcQWSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3Gqg2/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FEDC433C7;
	Wed, 20 Mar 2024 07:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710920257;
	bh=YTMRU0Nf5P5SYGoJuo+TisiaAmlJOWa0iSN0mNp+DiU=;
	h=From:To:Cc:Subject:Date:From;
	b=r3Gqg2/8wmLMN5FOuFo7g0GoXHvDzxZy05MxXkftJCg2VDtHDzYUM09zB1nAly1y7
	 4QQ16V3lFv9MghoR261GCjN3fMWbUwbIauf5mw2yIJRbwtGCXm2YB8QJ8oGFnfeBeC
	 FeT+nwz3aLfydQy8rc0c/QolFkFlaL0f6S3uES1INjEQvKMU3hW8a9xaZ5ZKf8AQTM
	 LUSvMhO1YxdyHiJh2yKylPDgWjDGwLImnW9GP66bc9X99MshxR76ecDnb5O1CXPSF3
	 AiXtYL9Uj4BNDXmcOLPxrXeyQi4DCDtBE/leqHR7eOxzoGMiGQCiSdt7BbpkAi2X1x
	 zwzFNLEDmF7WQ==
From: alexs@kernel.org
To: Izik Eidus <izik.eidus@ravellosystems.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Chris Wright <chrisw@sous-sol.org>,
	kasong@tencent.com
Cc: linux-kernel@vger.kernel.org,
	"Alex Shi (tencent)" <alexs@kernel.org>
Subject: [PATCH 00/11] transfer page to folio in KSM 
Date: Wed, 20 Mar 2024 15:40:36 +0800
Message-ID: <20240320074049.4130552-1-alexs@kernel.org>
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
This patchset could reduce ksm.o size to 2487136 from 2547952 bytes on
latest akpm/mm-stable branch with CONFIG_DEBUG_VM enabled.


Alex Shi (tencent) (11):
  mm/ksm: Convert get_ksm_page to return a folio
  mm/ksm: use a folio in remove_rmap_item_from_tree
  mm/ksm: use a folio in remove_stable_node
  mm/ksm: use folio in stable_node_dup
  mm/ksm: use a folio in scan_get_next_rmap_item func
  mm/ksm: use folio in write_protect_page
  mm/ksm: Convert chain series funcs to use folio
  mm/ksm: Convert stable_tree_insert to use folio
  mm/ksm: Convert stable_tree_search to use folio
  mm/ksm: rename get_ksm_page to get_ksm_folio and return type
  mm/ksm: return folio for chain series funcs

 mm/ksm.c | 244 +++++++++++++++++++++++++++----------------------------
 1 file changed, 122 insertions(+), 122 deletions(-)

-- 
2.43.0


