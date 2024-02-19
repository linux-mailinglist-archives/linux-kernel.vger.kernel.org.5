Return-Path: <linux-kernel+bounces-71899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6967F85AC48
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25DC6281270
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474DE5B5CD;
	Mon, 19 Feb 2024 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCReNk/o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7849C5A106;
	Mon, 19 Feb 2024 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371889; cv=none; b=SBc/VUfo+TpOzBqA2wEWUrR5goA3zAniHdSAyB0SRnFlN7JzOY9c3T7WYn+sg7cKhgqaepnM6woWLZrtgJmWhJyoEWMX8FVQD719eWfyq2a+uSdYq2n0ffaq5eqR1nDAMy0zL0mXfv9hif/05tkKPIVF6OWaqkaGI9hwd+YOihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371889; c=relaxed/simple;
	bh=on8Lep3AS4Mtk6AjiPZh/C8TU3CHqMgnp8c3zsc3Iao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjy0UQgQmtoVM7DKUBmpL9eG8R9i6Ef2u7/v14yIPoy7/7DAiJ+jhaDTpLYBv/R045hPI+WcfgQqlgzvjhCoTlfEPuEi9niwRH2HojtGQRmtLth0uMet5PFcUXF3oMNyNsLE4FNZuBDghqsIWBaUM7EslSPmGYOOOr6GPxcc/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCReNk/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A6DC433C7;
	Mon, 19 Feb 2024 19:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371889;
	bh=on8Lep3AS4Mtk6AjiPZh/C8TU3CHqMgnp8c3zsc3Iao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aCReNk/oosprUvxML+loGz5WEl3Ex0wq8loimKpYSK8vC0StgTzc6hzZtHhrVpWd+
	 me+a2u1A2eOPZrePsH9WPL1k2OS8p8XMl2saSj+BmYT3t6QBHa+T0pb7ZfAlzCvrk7
	 gA6aUzkKjMNrH76IFAPd0BaiuojxtgycMnw8vDjd8Vyj4MbrA1ejTXY7slYrRDLE8c
	 MgPkImBcgWOtQ49mT8xulLK8eeMQ6OytjD582dPstYkeDyokYl/YmwJ0jIILgvYZwL
	 DlFu3pE/pVPe/hLKevn9ubaCmAWtyDdVO+9RXbtJrdpoVlzCFwt9KG9NjcHwEW/F3b
	 PuXS69mZlmmzg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/20] Docs/admin-guide/mm/damon/usage: document quota goal metric file
Date: Mon, 19 Feb 2024 11:44:28 -0800
Message-Id: <20240219194431.159606-18-sj@kernel.org>
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

Update DAMON usage document for the quota goal target_metric file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 220ebbde7324..b33eecfd0e90 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -86,7 +86,7 @@ comma (",").
     │ │ │ │ │ │ │ :ref:`quotas <sysfs_quotas>`/ms,bytes,reset_interval_ms,effective_bytes
     │ │ │ │ │ │ │ │ weights/sz_permil,nr_accesses_permil,age_permil
     │ │ │ │ │ │ │ │ :ref:`goals <sysfs_schemes_quota_goals>`/nr_goals
-    │ │ │ │ │ │ │ │ │ 0/target_value,current_value
+    │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value
     │ │ │ │ │ │ │ :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
     │ │ │ │ │ │ │ :ref:`filters <sysfs_filters>`/nr_filters
     │ │ │ │ │ │ │ │ 0/type,matching,memcg_id
@@ -366,11 +366,11 @@ number (``N``) to the file creates the number of child directories named ``0``
 to ``N-1``.  Each directory represents each goal and current achievement.
 Among the multiple feedback, the best one is used.
 
-Each goal directory contains two files, namely ``target_value`` and
-``current_value``.  Users can set and get any number to those files to set the
-feedback.  User space main workload's latency or throughput, system metrics
-like free memory ratio or memory pressure stall time (PSI) could be example
-metrics for the values.  Note that users should write
+Each goal directory contains three files, namely ``target_metric``,
+``target_value`` and ``current_value``.  Users can set and get the three
+parameters for the quota auto-tuning goals that specified on the :ref:`design
+doc <damon_design_damos_quota_auto_tuning>` by writing to and reading from each
+of the files.  Note that users should further write
 ``commit_schemes_quota_goals`` to the ``state`` file of the :ref:`kdamond
 directory <sysfs_kdamond>` to pass the feedback to DAMON.
 
-- 
2.39.2


