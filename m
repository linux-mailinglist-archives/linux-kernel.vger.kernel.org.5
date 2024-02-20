Return-Path: <linux-kernel+bounces-73819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCD285CBF7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556FA1F2319E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E42154C1E;
	Tue, 20 Feb 2024 23:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iv1tVKuu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7414154C08
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471371; cv=none; b=Qy7uUE8TJpXb0O44mswMuxK0msSxUlCmArV+Hwt1oep0WMxa2SaWhz1a9LLg79QlMUNHKYySWNRRUKHxEMZbf64g/0TxSzuE2Stj7yzPNLVtB5RO9eKNLsIiX513/LNAAe181qxISV1E+9q8O1sm2zCXbIlUYnh+Ajh6cVUwgy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471371; c=relaxed/simple;
	bh=5v8IyxsitkSm3E3j6jmhK8UZ0QzoeYM3vh4aMTemJxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AE1nsZ2F1fIEXKjml/yvNq8jZne24jbrAac20yRa6Dw+jK+w/EJvWLM8K/u3oX1lbE+io49aG4RSMEuuxh0PA5DTWbecO+wz//fQyeEhbGekoGZBu478uIQ2Co0pF+ZtVljATxA2ekJu7iqWPSk1BAH/fWNcElQ2xf9LHDq/DFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iv1tVKuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED1AC433C7;
	Tue, 20 Feb 2024 23:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708471371;
	bh=5v8IyxsitkSm3E3j6jmhK8UZ0QzoeYM3vh4aMTemJxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iv1tVKuuuawAQ4p0vuYR2M1J3RtyHIFgum41/L2Nj8QM8V5PaPq16Vr8Xp65hE3I3
	 lYD9JRyweKzVeViTscez6aZeJBPFUZbwGLlNH4E/3C9Rmx0YBSwG0LzTUNvf4ol2xM
	 gReZWW3xDHZ9YuDSbU/BCCVs4vjdG9SvDdNXNYbvYSGYuJMWYp8ndIlhifp/jJkWXB
	 N4uLFbA/XMnkpx8bEvbAiTBsLXkYcgdi2L0lUqBYX5h/sS8lpGJf3n7orGlPzZ1Y4J
	 OAQ3ybQC7f4pK1Zzl2wMaXunMQAZ3wx4TSweW3tCgFhuGpfj9b6ruhf8aYwUcKszIH
	 7hiNSkeXnNJCg==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: allow to mount if cap is 100
Date: Tue, 20 Feb 2024 15:22:47 -0800
Message-ID: <20240220232247.2856-3-jaegeuk@kernel.org>
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

Don't block mounting the partition, if cap is 100%.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 160ee550cbfe..56927b097e30 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -894,6 +894,9 @@ int f2fs_disable_cp_again(struct f2fs_sb_info *sbi, block_t unusable)
 {
 	int ovp_hole_segs =
 		(overprovision_segments(sbi) - reserved_segments(sbi));
+
+	if (F2FS_OPTION(sbi).unusable_cap_perc == 100)
+		return 0;
 	if (unusable > F2FS_OPTION(sbi).unusable_cap)
 		return -EAGAIN;
 	if (is_sbi_flag_set(sbi, SBI_CP_DISABLED_QUICK) &&
-- 
2.44.0.rc0.258.g7320e95886-goog


