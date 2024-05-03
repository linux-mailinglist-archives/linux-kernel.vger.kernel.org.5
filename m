Return-Path: <linux-kernel+bounces-167996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF148BB208
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42651F2276A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5201586CF;
	Fri,  3 May 2024 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c71lokwp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE99158219;
	Fri,  3 May 2024 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759403; cv=none; b=eRN6GhBoE+vSo7MCSghJPaVW9ptfGq6gb4jwpNpO5yVu2COzSr47Vey1yudZPM5peQEf0OyUZSOZlPg8MxNnjDvwxBLNBPlFj7ug2OO3sW0KCF1lRZaAfoOKX3qraF3OAypD02Cpz3ac2hGgGlZZXeT/VzoDvcW65zFQ7O3grCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759403; c=relaxed/simple;
	bh=zSTAIYDsysAOFhSKZc274DZ8idV6c4WJQL8j1/BLSlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T9Y3YRLUMezD2UsEppCCij/G8QmI12ZNxXctzEQ7Eqn9xoQInXWVNUzdGuNTM7gA1YL/YnhgJN8t74/cTsZbv01f8OnmiygZSfK0NSP3rfFSXOb1W8s0PpcpC7njXop1BozqVkN+J9I0z2ethFdt63sZWZxIXwwgZZ3GUHvsQh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c71lokwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DEFC4AF1A;
	Fri,  3 May 2024 18:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714759402;
	bh=zSTAIYDsysAOFhSKZc274DZ8idV6c4WJQL8j1/BLSlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c71lokwplM4u6LWwWT9mEgvfvFZezL/myTEwABYNAPeXhXSK7pe5V2OOUbsCJblvJ
	 mWEN3cCe5wg4UwB5LxnXWWrbiSkv7fFox/yfAUF3vp3J9oeSTb+oQmGRMzXdPyKX/e
	 MlbYAfhdOK5DClrKc6TbgdoJMmn+08aYUS5exWq/5uWmcOD3aYGDPKjmZN/RQcgmJd
	 Pcp/I3auQn0krCRzZ16b4PZMgXMARPIuN7gk1scj5aF1f47SteyRr5MMRRRItlQ8/I
	 QHo7GGPcAMTWkReXmaBfoSobz12v5bsgxsDS3/Y+dxrR/MeGunw01ia48IkfLV/Vvr
	 ec8AGXSHMGx/A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] mm/damon/core: initialize ->esz_bp from damos_quota_init_priv()
Date: Fri,  3 May 2024 11:03:09 -0700
Message-Id: <20240503180318.72798-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503180318.72798-1-sj@kernel.org>
References: <20240503180318.72798-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_quota_init_priv() function should initialize all private fields of
struct damos_quota.  However, it is not initializing ->esz_bp field.
This could result in use of uninitialized variable from
damon_feed_loop_next_input() function.  There is no such issue at the
moment because every caller of the function is passing damos_quota
object that already having the field zero value.  But we cannot
guarantee the future, and the function is not doing what it is
promising.  A bug is a bug.  This fix is for preventing possible future
issues.

Fixes: 9294a037c015 ("mm/damon/core: implement goal-oriented feedback-driven quota auto-tuning")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 172095e68c5d..6392f1cc97a3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -346,6 +346,7 @@ static struct damos_quota *damos_quota_init(struct damos_quota *quota)
 	quota->charged_from = 0;
 	quota->charge_target_from = NULL;
 	quota->charge_addr_from = 0;
+	quota->esz_bp = 0;
 	return quota;
 }
 
-- 
2.39.2


