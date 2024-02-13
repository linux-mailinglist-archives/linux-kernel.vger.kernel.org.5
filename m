Return-Path: <linux-kernel+bounces-62577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D04A0852331
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8A21B242D8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D33BA56;
	Tue, 13 Feb 2024 00:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aD1q3Wm3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72966AD53;
	Tue, 13 Feb 2024 00:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783528; cv=none; b=HWDEvmmzvxA3MP1CNlle9h3bEKgpkTQAX82W6WnUjvy2eL0C5ixJ5KnAwtO8qnf81XLbgtNvF6wUU7LAxr4gT5qk0VuW1yG5LW7+UNKGKJfnLAH1cb176eriqihvSPJHjMcbZBGA31MmOW3Tn+gRt/ObeyWAUx8s7mkGtu1L124=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783528; c=relaxed/simple;
	bh=+zQnrBocJsKRSmbpAD2SeDkbeGR/xV1SBSQUiSQVRGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezhZvV+CyaRdf5MiWo+zz+/90/cBtgyk3+CYlHu1Y4OYFI5excNnZ0JpnK1s59TCRQ6xtLb4hUihIw+19ioSEv7wxiFCSdTQH59VW69JOpcqqSt1rZZ3zmVI8SQ3hC8jDKOpmZy2x2EbVnIrtQtgSwCI40ytPwARHqb1B31dsnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aD1q3Wm3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A321C43394;
	Tue, 13 Feb 2024 00:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783528;
	bh=+zQnrBocJsKRSmbpAD2SeDkbeGR/xV1SBSQUiSQVRGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aD1q3Wm3oGALH9nLVwj/yA/rqF7NpKa43ZV3pcDCtfsL38Io1KRZ4vjC9+E3ZaJJB
	 Q077QQcG1RV80ICM8x2gkcwjMsRNgZngbb3iIuuVlp8FGMliLkgIYDKIAYWAslA3Kt
	 wT5Y1yUW/hxFr54uL81HBMaq0VYfmW3JPbYrwEmt/3tSQH/i2XZ16U7PDO+NOSzF4s
	 7UmDPWgGrnXzAOBtt1ZBws3FyASvm8aNC6zhQfsVlCtF6M1hd7ecbviO5PinmSccZx
	 fpR3VC3JB6sD77MM0F/x4UCF0wsr+XgnMNMsytPpv7HNYtd0dWPiTHKBul/GdfbZnJ
	 Up3nAlthw/tDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 08/58] fs/ntfs3: Fix detected field-spanning write (size 8) of single field "le->name"
Date: Mon, 12 Feb 2024 19:17:14 -0500
Message-ID: <20240213001837.668862-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit d155617006ebc172a80d3eb013c4b867f9a8ada4 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/ntfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 86aecbb01a92..13e96fc63dae 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -523,7 +523,7 @@ struct ATTR_LIST_ENTRY {
 	__le64 vcn;		// 0x08: Starting VCN of this attribute.
 	struct MFT_REF ref;	// 0x10: MFT record number with attribute.
 	__le16 id;		// 0x18: struct ATTRIB ID.
-	__le16 name[3];		// 0x1A: Just to align. To get real name can use bNameOffset.
+	__le16 name[];		// 0x1A: Just to align. To get real name can use name_off.
 
 }; // sizeof(0x20)
 
-- 
2.43.0


