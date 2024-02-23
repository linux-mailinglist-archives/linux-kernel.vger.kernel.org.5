Return-Path: <linux-kernel+bounces-79150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE0A861E3B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA47E1C237D0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663AC14CAAC;
	Fri, 23 Feb 2024 20:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmh02COf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3841DDC3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708721740; cv=none; b=ks7f7+Bd60gLyADcdFd5rjB6t9ZQgqvEEKQq7vt6JI/Wdo+m8WcIdGDexCo0MwReJpWWm7Kyp4eEajdTb0HipuwHvISCZe+fj3FySeGmW87IMp/Nj9eX8Tuiv0HpUQLY6qIboquKmkmApth0rW7Y0W00FJ0HEMu4Qm6fIHXyBoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708721740; c=relaxed/simple;
	bh=Dks7ZYdpho4cTIrGeKroPJwikwZpUsV1Ym/LDVuEhMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWeebP0C4O0Coc465eSPgr5yZvered3QWVyiIAuAVZrS46XVwPVdL+XsjUynnAhiNXxsur7il3auPsEQebCbuoMqlj+Z9M2rhNCp974DsE7V/nFabpvW2kvKMflKtLsYn0WUjYYatd3fYvSaVGDOcPiQ0aSs9uxk5C7LLAP7pto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmh02COf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351D1C43390;
	Fri, 23 Feb 2024 20:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708721740;
	bh=Dks7ZYdpho4cTIrGeKroPJwikwZpUsV1Ym/LDVuEhMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hmh02COfYfzXOAY/wQfnzDRk4Ol3gGYIn1gDcG02Bf2LrYPE/K1cx7LX/SVL2WF9Y
	 WqtEQE8K4EUTV2MyulSisJi14ElRtimAP1qCg6blP4+VPLcEwhbntU9XTDIWE/O1uo
	 5lUk4hBsmPYcD6+EtNZWUM12c0f53Af/Wqjv6SyFL+PV0rqTv30oxOySWjpKKJJFlb
	 rKjLFIb9CQXbR8X0t/AlGQCS5xV28QufjgyMHagNp6LWXie1aXQR5TuaDqINBkqCrR
	 ToQ3A0XaoLjbIBW1jxCWMyUBzQW/LHF72Vvv1eMGAY5df4w/yuz5kj/kgyGhoyltk3
	 j410fPAfilfUA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/5] f2fs: allow to mount if cap is 100
Date: Fri, 23 Feb 2024 12:55:35 -0800
Message-ID: <20240223205535.307307-5-jaegeuk@kernel.org>
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

Don't block mounting the partition, if cap is 100%.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6d586ae8b55f..f11361152d2a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -904,6 +904,9 @@ int f2fs_disable_cp_again(struct f2fs_sb_info *sbi, block_t unusable)
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


