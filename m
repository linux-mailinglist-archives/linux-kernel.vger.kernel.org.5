Return-Path: <linux-kernel+bounces-62639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DE48523E8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DC4A283EF0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCB05FB9D;
	Tue, 13 Feb 2024 00:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqFM4bAM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5257A5FB85;
	Tue, 13 Feb 2024 00:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783662; cv=none; b=dD4iai1h0jUO5FqWDFChSb5ybl8pW5BlmW5dxXGm7TJEQnfEgC8DI+xqHT14WhcH8lNmCPPqh9bj2n6ecOdix7S0i2/kWuOmUUahZnYhKMQzxunB+3Te1HgYDWw0l0QhNZGHe88o5VTQmJuG6Jrc4314R1r5BAkoLZVg6ZWurvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783662; c=relaxed/simple;
	bh=+zQnrBocJsKRSmbpAD2SeDkbeGR/xV1SBSQUiSQVRGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwuyKJbMV3n1CTHRSgUSWhfz+QrVibC6shq6LJV+UhDb4AwMUqJ24fT0nNiRA/JtKVgtiPNlMGHqfMASgK2TbixyfrOyfJ7g4cerFm4hhY+HakYW2WidE5Wbo/4QfDNBcJeGHzv6OlHv29fvT0yz1Ta2efYGO7WZ63yL999QUYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqFM4bAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1E3C433C7;
	Tue, 13 Feb 2024 00:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783662;
	bh=+zQnrBocJsKRSmbpAD2SeDkbeGR/xV1SBSQUiSQVRGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MqFM4bAMpP8k4HA/T8wEggWu0awRmz9FiNLMfifLqfftIIXP3pU+/A4DhfWjkRr0c
	 JIKaLcs8jjSKeUj2tEGBSDqnXMGCyaHayFVB0HJjyZ2B3aXn+91RAWecBYrAItTP2Z
	 64X8uGe7mkNpY8kKJZ+eg4SPWEZiL8TLMqPtqCENO26aET4U6jXh4bx5nVGae0NwsS
	 Idqey1M4eK3SoXyg7nQF7aq8bHy04onVR7z8rnyx9G12BVokE3kYOVVtON+yyvAyz8
	 +37Ce98pIv+cwzwCw4NG4wzi2fL7MDLqDQ5uKq4t0N6WttaBv4aYpOvbRUNHe9Ycup
	 Yp4qmxhlQQ3ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 08/51] fs/ntfs3: Fix detected field-spanning write (size 8) of single field "le->name"
Date: Mon, 12 Feb 2024 19:19:45 -0500
Message-ID: <20240213002052.670571-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
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


