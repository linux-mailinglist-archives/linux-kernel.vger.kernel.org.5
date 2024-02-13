Return-Path: <linux-kernel+bounces-62592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE8C852364
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5541C233D6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6872A2A1B0;
	Tue, 13 Feb 2024 00:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0hLKgwj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A855D29415;
	Tue, 13 Feb 2024 00:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783546; cv=none; b=gPHi9dNazyDmmRlOun5jSzo9qi7Lnv/kabmA1wgU1H+RBligx6befNeYP8vu1slLyXsQDHacqTwCQhooEyF7kLxGeaIo86n0cNMwN3LSmBIMzjtFWlMgXZJKaZK+TlwtWX5Up3wYYy5GAc3pn01T5WBm/YJRH1aExBB7t9RYqcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783546; c=relaxed/simple;
	bh=32NY0xmryJ2uwxO8tHhJx32hyvGfMO+SblgEUkmuYPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEDYUFqjTqiE6LaE0bwWNSyV2itmJeAGrhsM419L7k80V3QzHPsQVZI//1SwobPB/QRCdpC3F0XnK1ok16IBLZ/wyH9+rsRdvZECeJsGXsr33T8ri6rWjk0z6Jb9u64XKG7/SM2eI3TskDY9V2PSxRGqrMPWXXmLvIxc/dyj2Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0hLKgwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C69C43390;
	Tue, 13 Feb 2024 00:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783546;
	bh=32NY0xmryJ2uwxO8tHhJx32hyvGfMO+SblgEUkmuYPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E0hLKgwjhdKPCPy/e1x7hNnCd37Z5PIKLCLRU01esbvxAeMC7csN8xFUGBUjOyiYl
	 FDDUWjcRSwNTvtK0kqeHED5byWjxnSdYp9Ua9RMIkxECSWtSTmTuz1jG4QOPcRJm/z
	 FfoKFn9KEkn4rWTv2dE8Gd2djIvXNfDQWnRc8rf/kRNTxn6yzmCGCtUE/TdVRFycqP
	 BeHxuFI0lhraBDKLZ30bT6OP0YoOtJUkg1RjXk2JyDtx01hGJy1L7PbhrRd+0pDCVT
	 WqkKd8bnOq6NfUq5lGp2UNsmxXhZV7edvrC8zun8q0QQEWG9KKWmk1WE8XVnIHIUeQ
	 i581FK7/+JEQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Robert Morris <rtm@csail.mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 23/58] fs/ntfs3: Fixed overflow check in mi_enum_attr()
Date: Mon, 12 Feb 2024 19:17:29 -0500
Message-ID: <20240213001837.668862-23-sashal@kernel.org>
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

[ Upstream commit 652cfeb43d6b9aba5c7c4902bed7a7340df131fb ]

Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 7b6423584eae..6aa3a9d44df1 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -279,7 +279,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		if (t16 > asize)
 			return NULL;
 
-		if (t16 + le32_to_cpu(attr->res.data_size) > asize)
+		if (le32_to_cpu(attr->res.data_size) > asize - t16)
 			return NULL;
 
 		t32 = sizeof(short) * attr->name_len;
-- 
2.43.0


