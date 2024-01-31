Return-Path: <linux-kernel+bounces-45702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EFD84345F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C61E1C24572
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE421B268;
	Wed, 31 Jan 2024 03:12:17 +0000 (UTC)
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBACC1862D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 03:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.87.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706670737; cv=none; b=bG5VqQ8YzGRc5mKe6oq+Lq//fWL21VjvNpMnVv7dAjCSToBaMEqVHsV0xBp3xUHqWz0oqqGROhdldH4qcrnDStakqmolHqyP5GrqFjFg6tubgHgNAEwyV9V9r/Hg+ASo0A4wLql/X/m0hMNSS2t1QICIH9FX5LdpoBUgc6QGfD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706670737; c=relaxed/simple;
	bh=3vH+tDOzI1Onrb5XmrwRY3DlzQhSj0fHeVpIM7vywME=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZZm8xIWgHJQP1WQ2v0QUtx0KBGueWorCGBWjIvaB1MEcIWPKK7U9eSJ/vIKfEreXyyR64muZtMN9BlABUXI8IDPxzbKgOuLVAaozzlC1JwQpw/2gRZGEUSBunhHj6nLAhi8uBh4Vyk72et711jg7v/oooG82VhlGeeKdqLNpVwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.87.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4TPmpJ1GZjzB2lnX;
	Wed, 31 Jan 2024 10:54:16 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 31 Jan
 2024 10:54:42 +0800
Date: Wed, 31 Jan 2024 10:54:41 +0800
From: Wang Jinchao <wangjinchao@xfusion.com>
To: <brauner@kernel.org>, <viro@zeniv.linux.org.uk>,
	<linux-kernel@vger.kernel.org>
CC: <stone.xulei@xfusion.com>, <wangjinchao@xfusion.com>
Subject: [PATCH] fork: Using clone_flags for legacy clone check
Message-ID: <202401311054+0800-wangjinchao@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: wuxshcsitd00602.xfusion.com (10.32.132.250) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)

In the current implementation of clone(), there is a line that
initializes `u64 clone_flags = args->flags` at the top.
This means that there is no longer a need to use args->flags
for the legacy clone check.

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
---
 kernel/fork.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 0d944e92a43f..a6c5383288c9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2876,8 +2876,8 @@ pid_t kernel_clone(struct kernel_clone_args *args)
 	 * here has the advantage that we don't need to have a separate helper
 	 * to check for legacy clone().
 	 */
-	if ((args->flags & CLONE_PIDFD) &&
-	    (args->flags & CLONE_PARENT_SETTID) &&
+	if ((clone_flags & CLONE_PIDFD) &&
+	    (clone_flags & CLONE_PARENT_SETTID) &&
 	    (args->pidfd == args->parent_tid))
 		return -EINVAL;
 
-- 
2.40.0


