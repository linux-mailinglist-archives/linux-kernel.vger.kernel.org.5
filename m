Return-Path: <linux-kernel+bounces-129956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E114C89727F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3F31C26408
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2FA149DE9;
	Wed,  3 Apr 2024 14:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIJTsiIz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A51149C6D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154269; cv=none; b=WFugazbDgycqHmJqPlrY2+YcjCAYw9q4IqnIsm+f904CSyRS93fbe0CsrJz5CKvbmtLEVKIQhQTAu0g/5ZUY+KDFQykBv4r0D+L7mLDI8Hn/wGBD3sULN1CwhXM7o1hgjO5Qijsr++eSRyQKPYjl6/Ln7fmKTA0opPJa8Ge93Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154269; c=relaxed/simple;
	bh=ptc7NY5ggY3TRPp0+wwY3rbiFNHckWsv1H/R/8taUtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m/PM9o1uQJZYy/cKeP3waU7Fr9G4bD3bDNbXW4GgFh81W5o6SyJc12V2HBibv63QtdmdPHgfMWs68TcbA9eB2UYnyc50wLEJF//HvdAbpYz8hipfKEUqjtWgWGPcheAyiT4nSgDstjR2f44W1BqoDfeK6PKpFf6kRRGFlQBzwZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIJTsiIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CD0C43394;
	Wed,  3 Apr 2024 14:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712154269;
	bh=ptc7NY5ggY3TRPp0+wwY3rbiFNHckWsv1H/R/8taUtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QIJTsiIzCdJdwWYGjp/u10rqGF6STRdrYu5daHJrNF0Ilj8MwByFD1robyv8kB4Rw
	 ncGg5D8fGbH1Fg6XreO6hduB7R0vlIqXQB+ikUHsLpNNMaw5tdMZ+JBCipa4oOppvp
	 PwHRPkt5tYRTLsZRAtDOnGmpC2uhS6scXaofJOeLjo1Wrf/agWc63O+F7ttg7PnNTV
	 viU2x4znYXfmNnfUZymJM/Y0JLuzjLayo563dot94WwAMAqlwZTsUMC43TNFi1+tm0
	 n8/Y1IX2t3GaJ/7jWKl18Fn8oF/c8/XpmbkUbPALrMr3na+GjIFi+9bE2/5xWzHVVe
	 69ayxwHis7jxA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: fix to check pinfile flag in f2fs_move_file_range()
Date: Wed,  3 Apr 2024 22:24:20 +0800
Message-Id: <20240403142420.2042498-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240403142420.2042498-1-chao@kernel.org>
References: <20240403142420.2042498-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ioctl(F2FS_IOC_MOVE_RANGE) can truncate or punch hole on pinned file,
fix to disallow it.

Fixes: 5fed0be8583f ("f2fs: do not allow partial truncation on pinned file")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 83a807e25e31..0d1bcdf61a09 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2858,7 +2858,8 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 			goto out;
 	}
 
-	if (f2fs_compressed_file(src) || f2fs_compressed_file(dst)) {
+	if (f2fs_compressed_file(src) || f2fs_compressed_file(dst) ||
+		f2fs_is_pinned_file(src) || f2fs_is_pinned_file(dst)) {
 		ret = -EOPNOTSUPP;
 		goto out_unlock;
 	}
-- 
2.40.1


