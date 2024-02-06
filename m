Return-Path: <linux-kernel+bounces-55587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846F884BE8C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420CE287496
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9291CAB3;
	Tue,  6 Feb 2024 20:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uprbPkH6"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E22B1BC27
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707250757; cv=none; b=iZygL5v1aPreG0F0a/hiNjLXCAYO4hi20umbhacoz5cVITsqP5hcMtTj/AMtUuI2qCUbwSm/FzghH1jzlsdVYkiym3CatWdYY/2GKJPtk9rJjYZSGqCHZf1hQKvU3EFUkGqNuZ8IAd3DoCNXa/KCpb/OrJBC3DwtuF76HUXKniM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707250757; c=relaxed/simple;
	bh=IagyAptpbVbCJIu7tGslMZS09sjpEcntZ7cc/Wf4Lo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5AxySGdbqr4EQy2gvSRpHER47O7XUYHi28/vzri3QMtZpIU2noX5X+BApfyPI/sCSiuNObxSeLjIK+Wdd4kttNy+8u7YbLPcQl0y4iqot6wWr5anUZIEMh9k9cwtWX8hEtpfWF6alrOWiL1pBcJMj/Z1QYvgdOMliL2omN7TeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uprbPkH6; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707250754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2YXrtm+1+cRzzafgmSF6M7/9FRb0PSFDCes3wLXLLXk=;
	b=uprbPkH6CHnUWKye0Byqav98Oq/yCStE6lfL0ElOIC4gcxaaHvA80rGm1JIpl+gfF6aYSU
	H/2BhtQ5tWOrIbwGFABiVF1kllQoAIlp6yRZ0vjPdFLK+HfBsk9AIF9P0Rbb/4ecbuUvaX
	OZD/5Tu4GHOLeZdfSEfizG72iYAZsDU=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v2 6/7] xfs: add support for FS_IOC_GETSYSFSNAME
Date: Tue,  6 Feb 2024 15:18:54 -0500
Message-ID: <20240206201858.952303-7-kent.overstreet@linux.dev>
In-Reply-To: <20240206201858.952303-1-kent.overstreet@linux.dev>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/xfs/xfs_mount.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 4a46bc44088f..d87d14d8f699 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -711,6 +711,8 @@ xfs_mountfs(
 	if (error)
 		goto out;
 
+	strscpy(mp->m_super->s_sysfs_name, mp->m_super->s_id, sizeof(mp->m_super->m_sysfs_name));
+
 	error = xfs_sysfs_init(&mp->m_stats.xs_kobj, &xfs_stats_ktype,
 			       &mp->m_kobj, "stats");
 	if (error)
-- 
2.43.0


