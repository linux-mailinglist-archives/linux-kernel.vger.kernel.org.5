Return-Path: <linux-kernel+bounces-71886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 915CB85AC34
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A1AB282502
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2735A54650;
	Mon, 19 Feb 2024 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3JlR1TM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE2153812;
	Mon, 19 Feb 2024 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371882; cv=none; b=NrsgyozpI2TaRqjFRLxxjJVbO+NdnAayliLZ1U/NhI1CmcYz4Td4wwuJcBhqtowF/6isEnJIL4LSjBtJMmj4RnKJYAlqdbHvKU/zsyjdNNCo0o0eIUFK5VwURH+/SGWlr2NHlISn80b40wgmwoZRKxO1AvC1dEiAXsLJpr8wcqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371882; c=relaxed/simple;
	bh=Kc80eiLjIjFfjUUzf1ec4uqhs3PwKD70+PMFGRlYm9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtM0fisApGOZqxpID6NWTfxehVIF3d1C0ICJYNYxqxyAwaAchrCtbFrxtRpBIJFOeeGkx8JQduFVtAMcNGwqf/OhhzOrd0J76vb8k/c1V2NSA5W60Bw4r+1om1780lPg2Ely4EJGO3XteVAjfCL8I0QX3upudhbUGiixeZqxvxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3JlR1TM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E787C43390;
	Mon, 19 Feb 2024 19:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371881;
	bh=Kc80eiLjIjFfjUUzf1ec4uqhs3PwKD70+PMFGRlYm9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3JlR1TMBd4SZipJkxguG3s3i9iwsqiUwe8NWYu9g5VarCQPcboEKYUol/8Ltw02/
	 7lVy4f/dwVLcQIzZq2RwxsBGYZPGlnDwh/ncGthYhY+xGOxovBI2rk5qA8CmR4V3P3
	 rOgyHFgBbl7gBF7thKUeezEPey8JCAxfIjN1twH61U5pqFdIxT4PvAa4FHXrrhIGiu
	 SUCph24Jhh8qdoNRJzRpTQnRUE1/Y3Xx91lMc263hFrZIgsAzmpfyQ+84r5OHWFwKQ
	 cJ7bWU4XUwCN1ukCpTJBEgtQk1D5I6a6/1+YdOXyMFDGXpSrXK3/fhvNVVsDoZ+ZTV
	 f7hbn9PJKUiPg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/20] Docs/admin-guide/mm/damon/usage: document effective_bytes file
Date: Mon, 19 Feb 2024 11:44:16 -0800
Message-Id: <20240219194431.159606-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240219194431.159606-1-sj@kernel.org>
References: <20240219194431.159606-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the effective quota file of the DAMON
sysfs interface.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index db6620b5bc0a..220ebbde7324 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -83,7 +83,7 @@ comma (",").
     │ │ │ │ │ │ │ │ sz/min,max
     │ │ │ │ │ │ │ │ nr_accesses/min,max
     │ │ │ │ │ │ │ │ age/min,max
-    │ │ │ │ │ │ │ :ref:`quotas <sysfs_quotas>`/ms,bytes,reset_interval_ms
+    │ │ │ │ │ │ │ :ref:`quotas <sysfs_quotas>`/ms,bytes,reset_interval_ms,effective_bytes
     │ │ │ │ │ │ │ │ weights/sz_permil,nr_accesses_permil,age_permil
     │ │ │ │ │ │ │ │ :ref:`goals <sysfs_schemes_quota_goals>`/nr_goals
     │ │ │ │ │ │ │ │ │ 0/target_value,current_value
@@ -153,6 +153,9 @@ Users can write below commands for the kdamond to the ``state`` file.
 - ``clear_schemes_tried_regions``: Clear the DAMON-based operating scheme
   action tried regions directory for each DAMON-based operation scheme of the
   kdamond.
+- ``update_schemes_effective_bytes``: Update the contents of
+  ``effective_bytes`` files for each DAMON-based operation scheme of the
+  kdamond.  For more details, refer to :ref:`quotas directory <sysfs_quotas>`.
 
 If the state is ``on``, reading ``pid`` shows the pid of the kdamond thread.
 
@@ -320,8 +323,9 @@ schemes/<N>/quotas/
 The directory for the :ref:`quotas <damon_design_damos_quotas>` of the given
 DAMON-based operation scheme.
 
-Under ``quotas`` directory, three files (``ms``, ``bytes``,
-``reset_interval_ms``) and two directores (``weights`` and ``goals``) exist.
+Under ``quotas`` directory, four files (``ms``, ``bytes``,
+``reset_interval_ms``, ``effective_bytes``) and two directores (``weights`` and
+``goals``) exist.
 
 You can set the ``time quota`` in milliseconds, ``size quota`` in bytes, and
 ``reset interval`` in milliseconds by writing the values to the three files,
@@ -332,6 +336,15 @@ apply the action to only up to ``bytes`` bytes of memory regions within the
 quota limits unless at least one :ref:`goal <sysfs_schemes_quota_goals>` is
 set.
 
+The time quota is internally transformed to a size quota.  Between the
+transformed size quota and user-specified size quota, smaller one is applied.
+Based on the user-specified :ref:`goal <sysfs_schemes_quota_goals>`, the
+effective size quota is further adjusted.  Reading ``effective_bytes`` returns
+the current effective size quota.  The file is not updated in real time, so
+users should ask DAMON sysfs interface to update the content of the file for
+the stats by writing a special keyword, ``update_schemes_effective_bytes`` to
+the relevant ``kdamonds/<N>/state`` file.
+
 Under ``weights`` directory, three files (``sz_permil``,
 ``nr_accesses_permil``, and ``age_permil``) exist.
 You can set the :ref:`prioritization weights
-- 
2.39.2


