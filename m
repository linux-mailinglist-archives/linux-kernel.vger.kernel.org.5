Return-Path: <linux-kernel+bounces-26751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB5B82E5D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCFD1C226B3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5D735F1B;
	Tue, 16 Jan 2024 00:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwACQQZm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E535F1A;
	Tue, 16 Jan 2024 00:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DCBC433C7;
	Tue, 16 Jan 2024 00:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364741;
	bh=cgcRAiYk9vNMeMeB7RPaExiqCoReMDxjFFMz4hwr2P0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lwACQQZmBBoKMD8Rui4ANcqMyTbhzGJK4XK6WHXOacaVbkqvPD3o8uV8a6p2RFgyh
	 bl26BuozpjJsR0UFhfM9RhSPdnm6i4FBk0VRglJXDvoKuz0gR4J8KWyR9lH6PCZg53
	 UmopZN+BdLiBCnKl7UkdaeWPYLbGhIX1UFY1d5M6pIx3dpIXxmEFpyfcABx+Mi1Oq3
	 G8YHL22FAIzKiRG0tXza9uuYQuU9RVN98b8TSwcMA1nsanw26SU/zriVm4QhKYL0k4
	 ZWnnuj/3RkmgbWT5aA/QMVknfoXW2EhxZMBjRoWXw2O1CqNw7wMmrB/NhK+6kQD6/r
	 yaqBBbje6TJLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Bourgoin <thomas.bourgoin@foss.st.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	u.kleine-koenig@pengutronix.de,
	ebiggers@google.com,
	linux-crypto@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 10/14] crypto: stm32/crc32 - fix parsing list of devices
Date: Mon, 15 Jan 2024 19:24:52 -0500
Message-ID: <20240116002512.215607-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002512.215607-1-sashal@kernel.org>
References: <20240116002512.215607-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Thomas Bourgoin <thomas.bourgoin@foss.st.com>

[ Upstream commit 0eaef675b94c746900dcea7f6c41b9a103ed5d53 ]

smatch warnings:
drivers/crypto/stm32/stm32-crc32.c:108 stm32_crc_get_next_crc() warn:
can 'crc' even be NULL?

Use list_first_entry_or_null instead of list_first_entry to retrieve
the first device registered.
The function list_first_entry always return a non NULL pointer even if
the list is empty. Hence checking if the pointer returned is NULL does
not tell if the list is empty or not.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202311281111.ou2oUL2i-lkp@intel.com/
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202311281111.ou2oUL2i-lkp@intel.com/
Signed-off-by: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/stm32/stm32-crc32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/stm32/stm32-crc32.c b/drivers/crypto/stm32/stm32-crc32.c
index 90a920e7f664..c439be1650c8 100644
--- a/drivers/crypto/stm32/stm32-crc32.c
+++ b/drivers/crypto/stm32/stm32-crc32.c
@@ -104,7 +104,7 @@ static struct stm32_crc *stm32_crc_get_next_crc(void)
 	struct stm32_crc *crc;
 
 	spin_lock_bh(&crc_list.lock);
-	crc = list_first_entry(&crc_list.dev_list, struct stm32_crc, list);
+	crc = list_first_entry_or_null(&crc_list.dev_list, struct stm32_crc, list);
 	if (crc)
 		list_move_tail(&crc->list, &crc_list.dev_list);
 	spin_unlock_bh(&crc_list.lock);
-- 
2.43.0


