Return-Path: <linux-kernel+bounces-62651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79983852400
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC16F1C235C5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A21A60B86;
	Tue, 13 Feb 2024 00:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsJNL4ZR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D808160894;
	Tue, 13 Feb 2024 00:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783676; cv=none; b=XY7MSCkk6zMAlSxQ9bCymfvHzjmhYgtN8/URhbzVYXTP9gc2kvIdNCDn7NObs+yipDAhRqYbczy38AQj0lDCMlyMNk5FX0iCWvigGUy1Vwcyq6iSu+NsGJMqqWoZsp7TTinigKqaz29IyOCafAzofv3n7uJYr3DvjOPTfIN7jhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783676; c=relaxed/simple;
	bh=32NY0xmryJ2uwxO8tHhJx32hyvGfMO+SblgEUkmuYPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dfceol+lmtUFMByEpaX4uiwGXm2jyxjW0F+wHNG0qcR36QplLkRk7lmJvV5Af52ESbbCeqX+emEOGCkOXN9XOUfGC8CzvqpBQLAF5DJD4LRgXlLiOMiGWWAeGKop3e+j844Us1JN27lQiPCeg1U4QivbEyHo4n569vv3Xo+by9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsJNL4ZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC30AC43399;
	Tue, 13 Feb 2024 00:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783676;
	bh=32NY0xmryJ2uwxO8tHhJx32hyvGfMO+SblgEUkmuYPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hsJNL4ZRUpVE7ikxku3q8aAn8tOSSpRG4w3gElf3Wd+HixGArTddFHQy/c4nqifmP
	 36gGSl6xL2ajbBcXq3UAB+/EAnJ01zvStMneNvw0pZ3SynGy54TdhCUJmLJpWAusob
	 xq+AOH7nH90GqA37ppDD4bMda9xE6oWQUnnVyjBeHnuTmCFhQX7eM8GHyv8uf+EQ4R
	 2YBPbv+WzFVW4zSAddGG/v0Pd4agwueGZUFRoDLDkXbriGfsPAPCcyQpEKKsSuiKME
	 DCwifRChvqlGrUgjYLupYbrihhiAz8STNEYHzDw7O500+zNQjqszOLYInjd3MdSvxI
	 eeJVqq3ADGI+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Robert Morris <rtm@csail.mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 20/51] fs/ntfs3: Fixed overflow check in mi_enum_attr()
Date: Mon, 12 Feb 2024 19:19:57 -0500
Message-ID: <20240213002052.670571-20-sashal@kernel.org>
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


