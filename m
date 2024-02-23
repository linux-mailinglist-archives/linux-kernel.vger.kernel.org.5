Return-Path: <linux-kernel+bounces-79149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFD5861E3A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B85C1F23A41
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC01C14A4F4;
	Fri, 23 Feb 2024 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SB3mQtoL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040E91493A5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708721740; cv=none; b=aQFyQrUfWanjbrWBWexrfaL8swIWBuok9+pxqvbXxp2AAIUe6unGi2IguTHOMxW6zuT7IxSX4HJ8GmyG4d2zEVZ7YOz9QCATuxJxJ2GXUtp0HTn3URXcWqFflmhxUwmXTDsPmlNg4eW7BNkmrxbER8eTf29o1/QGlJp4hCNZFac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708721740; c=relaxed/simple;
	bh=jcqHB3mOguQlmJS0WZkHNVvEJ+LlBmJIQaxT0/mGi48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ec05xRK3rHK0TZndzZhr4ZhB2Wnr2EPXs8i4sPiIzPjO7fkJcI2A2+oiVQ3hXjssX9YkVM7l5eBPe93yUDih9XfYEBX0O+B3jPaUQ8EtdNfbzqw81999R5BSEMj6nDuVc4/JQlypaqQblt8H5jvfKtlQrHTa55Ybpu5cCTwq15w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SB3mQtoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6DAC433F1;
	Fri, 23 Feb 2024 20:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708721739;
	bh=jcqHB3mOguQlmJS0WZkHNVvEJ+LlBmJIQaxT0/mGi48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SB3mQtoLjZc3slFBxMQrc1O4HtbEMqzWJ/jBNTuPg46FWdAFrTsuEr3EkozkldcV0
	 qAaO6BTlVNGrYTROIXCN2Amj4mabG7qG2YHN1PAAzYoipn5o5eQUStaR1qZA7rAGeQ
	 jOBs1vmnQXSZ11t341fROSPlKCIb0rk8Xnpu02UC8vzTHnNXzye9LrSr5wuSrq/dVE
	 m3D7HdmqSzsJiRwuLbNCeGxKvCAB6R4c1m878ohP4rQso5/gjLA8hX/Gc84Jdm639T
	 uaZ/L0JUYTkQvgMfOw4hhZ9ZyTy/QHhGl2/oTZ/FCRK/J/cqy/0cBhrUq3Dm8cdQLn
	 0Kdk/h96tmGbQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/5] f2fs: prevent an f2fs_gc loop during disable_checkpoint
Date: Fri, 23 Feb 2024 12:55:34 -0800
Message-ID: <20240223205535.307307-4-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240223205535.307307-1-jaegeuk@kernel.org>
References: <20240223205535.307307-1-jaegeuk@kernel.org>
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
index fc7f1a9fbbda..7d9b92978709 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2191,6 +2191,7 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 			.init_gc_type = FG_GC,
 			.should_migrate_blocks = false,
 			.err_gc_skipped = true,
+			.no_bg_gc = true,
 			.nr_free_secs = 1 };
 
 		f2fs_down_write(&sbi->gc_lock);
-- 
2.44.0.rc0.258.g7320e95886-goog


