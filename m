Return-Path: <linux-kernel+bounces-62688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CAE852466
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A179BB22DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A652233A;
	Tue, 13 Feb 2024 00:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4K8ZiCo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D170C76919;
	Tue, 13 Feb 2024 00:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783762; cv=none; b=oL6Ggoyorl7ZlRTovbOM8xJdusEipOlVSbpvXF8JHX2spVVWjKzQb/RbuiJBhNCDw6Ghxeqtltip99QCu5LVdoFVNrT+7lgSkB7CasA6TmfLD/2eOeCDCcNZQYberDgCLsxXZeiSUymhHJQzaKh34jSq9WN+xFeUn48MDu52Fjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783762; c=relaxed/simple;
	bh=5jdQ8ka1cAjXD4ykRdjthiJU48SgqrsTzGpdqupGmCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeuNQ1YA8kIv7LgJNPnKjdQSBdPzBzfCLVVI2WE4M5lPqlq9FQaRgEszltGMXzvN1mGSSnCHeftdGVLYaUzJX6igjyFI9tii2gwm0tk8CZaFIu35kBvfbC1Z8WqLN344JpJZQca1Zgs+LsUwKDA4EQdPi92C0fFIYKLPRruHCh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4K8ZiCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09F5C433A6;
	Tue, 13 Feb 2024 00:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783762;
	bh=5jdQ8ka1cAjXD4ykRdjthiJU48SgqrsTzGpdqupGmCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R4K8ZiCo0moueCSIM9cwP++zzn+p9Nsck3DDuB1HZXiS/JIFIKR1lPi3jv1eLgb1k
	 ZFkAYKbYb3bCNbS3dFD2ddF3ZnXSbhJup7edjPH4Sd0OGy28NMEMlyi/hhGtKKtJDH
	 FK1Xc2JbJZOmhxnqy8jauxnxbjcIBdEzI9PJ2MomO2LuQbCm6h0vCEUnvrJ14z8Fi2
	 X7QvDblrUQ9fFq17nn9eqvpt+5rQIPL2cn/nGOI4p4SfqOVgTpGAeP9EbQ7sLJyjTK
	 1/o52prQlXGLwFq7SVYH/glERQlGLRW6c87VEgqwfP7NDYEKaZU4cjki9I2INNcX+3
	 vg0MPM6SBfS1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 05/28] fs/ntfs3: Fix detected field-spanning write (size 8) of single field "le->name"
Date: Mon, 12 Feb 2024 19:22:03 -0500
Message-ID: <20240213002235.671934-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002235.671934-1-sashal@kernel.org>
References: <20240213002235.671934-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit d155617006ebc172a80d3eb013c4b867f9a8ada4 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/ntfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 0f38d558169a..8b580515b1d6 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -517,7 +517,7 @@ struct ATTR_LIST_ENTRY {
 	__le64 vcn;		// 0x08: Starting VCN of this attribute.
 	struct MFT_REF ref;	// 0x10: MFT record number with attribute.
 	__le16 id;		// 0x18: struct ATTRIB ID.
-	__le16 name[3];		// 0x1A: Just to align. To get real name can use bNameOffset.
+	__le16 name[];		// 0x1A: Just to align. To get real name can use name_off.
 
 }; // sizeof(0x20)
 
-- 
2.43.0


