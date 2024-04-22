Return-Path: <linux-kernel+bounces-154296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E82DF8ADA6A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 917E5B26A97
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B62F17B4F7;
	Mon, 22 Apr 2024 23:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHGXah8B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74D317B4E5;
	Mon, 22 Apr 2024 23:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830255; cv=none; b=ZR652IzT8O/XJKGj0p7MGROYdAwVqvt9Tttbr1HNrCJxufDUwK4sF32R17Zu9aEkQyAmu5RVvokbyleY5sjBYE0GpYNWC98e1oDotz9H//5wvKBqIBtacL+XTilbelPdN6ldqt+i+8g5M8jtUlmrik/iOGeBfai/UxF7eLZkfSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830255; c=relaxed/simple;
	bh=d2Q9GMVJ+2fK2NguGcy/bUN6cI12JDIjcFarhFhXJ0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpeFwm2rxAC1945zC37z1ZNdylBE6mkD2E9AzAN8ouiJMaOL7+bw/qPVKmBe/3Qm0qis+Axhmoe81n04wg7aTGXdjWAYsUXpM3LWIA9eD1n//B2r95dLdkqw/t/SHO36Tu0Op0XDEMFwkpDkeEVK1/LHbWd8a+AFvI1OYxhaPj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHGXah8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7605C113CC;
	Mon, 22 Apr 2024 23:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830255;
	bh=d2Q9GMVJ+2fK2NguGcy/bUN6cI12JDIjcFarhFhXJ0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fHGXah8B/s04I0qqcpSVL+XVnpTRibDIkQ6Nl8guPHZbeTrjAgX6Zc5xMFgvJYru7
	 jRzLWWBySrLoj8P3eseYRozxL1TKFEauLuYqnUIdHE4rUcdEID+bu3RooIx74eZlqA
	 qqGdpi18zX5IAkUWKAjNHxCwwrPZE+tWa3NZK/mAKWWrNxbqRcSmrsL2hddRlYbN80
	 Uh6G5cHFKNDUeMJ9u7Tig49HQuOFvm+F7I5/eO8jcK+N+25eALlTxjPki1p7l5CozB
	 dVzz5XO3LJnt9qrQwTW0J14UO5o4T8xgp2QD4XVk18qPqW5Qq/YiDn4JGc+x5bc+c/
	 sRbZqo3eEbyWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	rongtao@cestc.cn
Subject: [PATCH AUTOSEL 6.1 06/19] memblock tests: fix undefined reference to `early_pfn_to_nid'
Date: Mon, 22 Apr 2024 19:18:20 -0400
Message-ID: <20240422231845.1607921-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231845.1607921-1-sashal@kernel.org>
References: <20240422231845.1607921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.87
Content-Transfer-Encoding: 8bit

From: Wei Yang <richard.weiyang@gmail.com>

[ Upstream commit 7d8ed162e6a92268d4b2b84d364a931216102c8e ]

commit 6a9531c3a880 ("memblock: fix crash when reserved memory is not
added to memory") introduce the usage of early_pfn_to_nid, which is not
defined in memblock tests.

The original definition of early_pfn_to_nid is defined in mm.h, so let
add this in the corresponding mm.h.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Yajun Deng <yajun.deng@linux.dev>
CC: Mike Rapoport <rppt@kernel.org>
Link: https://lore.kernel.org/r/20240402132701.29744-2-richard.weiyang@gmail.com
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/mm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
index 43be27bcc897d..2f401e8c6c0bb 100644
--- a/tools/include/linux/mm.h
+++ b/tools/include/linux/mm.h
@@ -37,4 +37,9 @@ static inline void totalram_pages_add(long count)
 {
 }
 
+static inline int early_pfn_to_nid(unsigned long pfn)
+{
+	return 0;
+}
+
 #endif
-- 
2.43.0


