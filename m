Return-Path: <linux-kernel+bounces-113401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AED3A888408
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F4EDB2031D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9D2139CF9;
	Sun, 24 Mar 2024 22:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9iS4LRa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B906F506;
	Sun, 24 Mar 2024 22:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320203; cv=none; b=hdh7vBe1QaB5cir8iqM0xFhIng6KM8VchDStU5LwRJpRmo2QDCcfF+9KX7KBTUIs/jQO/7e7/u8cZxhVP2/aDnd5/CQzB8FqGwOI+z+jjZjigLKBTs0nTR9fUcJ34vdGwOSuxEft+5J4qUtq4IBFl0zketOwjK1WYrUmP/CB4cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320203; c=relaxed/simple;
	bh=Wjn6ahfpV7yn/8rD5L4qV2HHdeT2hQ8Tt+KFgMreko0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtGxnoCkR5bo0YdRCavb2WYndpJdn5Y06zpUxDm1EkJllSGTGLglh3Ssl6ctMKH38heO/AQXCGormUFToFUzFMMLhjaWoVyoctFFhu+af+R5UTL4zoX4E/+H6nhN3LTLxb2GFT9i+Q7iHQXn95xyB9WO9SpsejQBJWNLWr6KeCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9iS4LRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADB0C433F1;
	Sun, 24 Mar 2024 22:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320202;
	bh=Wjn6ahfpV7yn/8rD5L4qV2HHdeT2hQ8Tt+KFgMreko0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K9iS4LRabGNK0US0cmkL2cUoB5a81RpY68X6yzZHhbGdmrz/Dm4FQbdnDfXzOn5m+
	 M4b14USdIXTzBv7IVvSpy+NQEE+bZhxcQ5+vsaDvU2dEH73TY5CyC42xeDh1Yc03y7
	 dyRmn09QgEWInhdJXsjniynYuwJZagzskQEqYnS2c5rJ18BSTliIZTnWoFaxRe1pf7
	 RfFLH3EQP1LARAHjDK5AnoEbmg4KFvP5pZa8EgBlGuX6orfDB87zpz0gMLUo7Dg27i
	 LNXYVUb5UfG25IxlExD5rxtak0fNHUB6EEUlWuleiHpGAfyl36T0YbZDfwNcHezR6/
	 LqNUVLhScjcvw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Mika Kuoppala <mika.kuoppala@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 510/715] drm/xe: Fix ref counting leak on page fault
Date: Sun, 24 Mar 2024 18:31:29 -0400
Message-ID: <20240324223455.1342824-511-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

[ Upstream commit f7da398935f7ddabf1a098714593e032c875cd74 ]

If a page fault occurs on VM not in fault a ref can be leaked. Fix this.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240301041036.238471-1-matthew.brost@intel.com
(cherry picked from commit 27b5a3f237fe66dbf2288c2b50973aee8a427e41)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt_pagefault.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_pagefault.c b/drivers/gpu/drm/xe/xe_gt_pagefault.c
index 73f08f1924df2..e2cf1759527c6 100644
--- a/drivers/gpu/drm/xe/xe_gt_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_gt_pagefault.c
@@ -146,10 +146,12 @@ static int handle_pagefault(struct xe_gt *gt, struct pagefault *pf)
 	/* ASID to VM */
 	mutex_lock(&xe->usm.lock);
 	vm = xa_load(&xe->usm.asid_to_vm, pf->asid);
-	if (vm)
+	if (vm && xe_vm_in_fault_mode(vm))
 		xe_vm_get(vm);
+	else
+		vm = NULL;
 	mutex_unlock(&xe->usm.lock);
-	if (!vm || !xe_vm_in_fault_mode(vm))
+	if (!vm)
 		return -EINVAL;
 
 retry_userptr:
-- 
2.43.0


