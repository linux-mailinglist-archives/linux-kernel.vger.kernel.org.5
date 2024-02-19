Return-Path: <linux-kernel+bounces-71885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9397D85AC33
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F27D282903
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0FD53E3B;
	Mon, 19 Feb 2024 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGNlhels"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47A9535C6;
	Mon, 19 Feb 2024 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371881; cv=none; b=a9wkcj47iDjzWYQQkh8A5UUn016D67Xs0WsglzyIOoi++vVtubzmpoKS8qyr00egyKje8gQWP29mgdb+lSZpnNGXjSdsVG7k8NLMiW+PF1aoGxZUYafRg0fKa9e1dvUAgWlj7QvgrDj10j1jmc+bUb6vQwmVQRWIfrv1SzC+Izs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371881; c=relaxed/simple;
	bh=zs+kw6wIVyudOx0IbIQ/KacaL4dSPBoyKxbciIuGSqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zn6gwoksWSMJmKe/r+I1NZOmce4Ya1myqU/iGMCUV/1cjWW8Lg45a2jZHfcF0ink60C+1cxYT5M9cD4fBHc54C66sNmp2QYtoZ87+oqjykP+091oCzptZiqgbuq4+2PZFwQqYNKig8pY/oeb+3hqwsU/++r3fG6UeGajk0tEgS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGNlhels; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D968FC43601;
	Mon, 19 Feb 2024 19:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371881;
	bh=zs+kw6wIVyudOx0IbIQ/KacaL4dSPBoyKxbciIuGSqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bGNlhelsuaOaVxbpRiKvqbRC14Uit74+279k9YL6Eqrf/mCSZmQo5fNZC2Zn6ZDKj
	 fOuHIHYPsbeH88zPeYuccArNi0m1YJ0i/565Ne57yKMD7zC9YblLyXJDvea9GrJE9O
	 zarsCYLN1OJhuIAnD3y1Wdk3AH+hplMwdJZdNHr6z1HoCozoX1hXubFTIulZFy8K67
	 WoP3gxY4HmUpWAuqB7ShV6n116XZy2e+77MmGhGjyuu8r6sBQi6zh3VQ855a9VHTe6
	 L9fLcKFksI1kXy2qX+E6FftgAS1BP3hRJ8lpic3LqDJCpyKQz4yUpfjsvf6A3u7g6a
	 NggL4U2/GvAuw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/20] Docs/ABI/damon: document effective_bytes sysfs file
Date: Mon, 19 Feb 2024 11:44:15 -0800
Message-Id: <20240219194431.159606-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240219194431.159606-1-sj@kernel.org>
References: <20240219194431.159606-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the DAMON ABI doc for the effective_bytes sysfs file and the
kdamond state file input command for updating the content of the file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index bfa5b8288d8d..a1e4fdb04f95 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -34,7 +34,9 @@ Description:	Writing 'on' or 'off' to this file makes the kdamond starts or
 		kdamond.  Writing 'update_schemes_tried_bytes' to the file
 		updates only '.../tried_regions/total_bytes' files of this
 		kdamond.  Writing 'clear_schemes_tried_regions' to the file
-		removes contents of the 'tried_regions' directory.
+		removes contents of the 'tried_regions' directory.  Writing
+		'update_schemes_effective_quotas' to the file updates
+		'.../quotas/effective_bytes' files of this kdamond.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/pid
 Date:		Mar 2022
@@ -208,6 +210,12 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the size
 		quota of the scheme in bytes.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/effective_bytes
+Date:		Feb 2024
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading from this file gets the effective size quota of the
+		scheme in bytes, which adjusted for the time quota and goals.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/reset_interval_ms
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.39.2


