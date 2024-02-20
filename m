Return-Path: <linux-kernel+bounces-73818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E9D85CBF6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78971F231FE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903EB154C04;
	Tue, 20 Feb 2024 23:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PddiNl/Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D653D154459
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471370; cv=none; b=jYWsW2cPbdb7F4Ce+W3wJOtTPoPRkYRBbOPJXdl01j6FTPtv7aQ4P7rOZUXZa6iwXLCbwN992MEAj2TPAjB8x7/GshOGRJmQQt3nqIbNAQDYdr8rAObWJ2IB1iTajJgeJrt9mrDBaYOGIyBqSZRGOick0J1ayKux1YI2hDi9o5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471370; c=relaxed/simple;
	bh=0ms7KVh+AOl9a1lPdIN8NKPVq4XoHxB9aa6kRs4XqG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTV/Ah+exrSVAIbPTVxp5jMFJ0GBLgrKapRFhpx2Q3lx7V2eHEft7JuoB9ORILqVU3ANZhFLrm/xORIBgNbz9gTuj1+/Pv5F6N4iZtCGAe905qiqiB/QMnK2QF0tij+8r5+p4FaAkHpisvGB0ndX0JAmw7/OCjDjL3n4uMJ+yHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PddiNl/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E07C43394;
	Tue, 20 Feb 2024 23:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708471370;
	bh=0ms7KVh+AOl9a1lPdIN8NKPVq4XoHxB9aa6kRs4XqG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PddiNl/YazsPYFCCCjB+VXg4HrEqsF7rDKgVkEQBMXqz3QOyKp7+JcTchUDPadrVJ
	 sBPHoSAazM9M5b42J1PYokXzdRadn/GAY+o2pM5zQ2U6t28Ia+EXANZiED5Tc4IRGU
	 SqazlN0wiIcQ03GmdNbMLCY8xG6xwH6rsmG07nEbAc6Re2iwFjaEQ3j82NdR3RPucs
	 Bu01oyqgONjUN9qpLJa8iTidhvtlHaKNBKxWX1Qu1UufjtIP5qg6nY62bUeVPqsXUD
	 LsUea/GcH2yUOs9FoSpsU8+qNp/F3SNhPe2i4GZK8F2UneJzyiVdU6wsL7y5cLIM3Y
	 tuavq7QtWfgfQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: prevent an f2fs_gc loop during disable_checkpoint
Date: Tue, 20 Feb 2024 15:22:46 -0800
Message-ID: <20240220232247.2856-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240220232247.2856-1-jaegeuk@kernel.org>
References: <20240220232247.2856-1-jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't get stuck in the f2fs_gc loop while disabling checkpoint. Instead, we have
a time-based management.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ad80cd38f3a4..9de467a28fd3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2190,6 +2190,7 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 			.init_gc_type = FG_GC,
 			.should_migrate_blocks = false,
 			.err_gc_skipped = true,
+			.no_bg_gc = true,
 			.nr_free_secs = 1 };
 
 		f2fs_down_write(&sbi->gc_lock);
-- 
2.44.0.rc0.258.g7320e95886-goog


