Return-Path: <linux-kernel+bounces-63309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7662E852D80
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94CF1C211DC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92DD225A6;
	Tue, 13 Feb 2024 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avMTiGFZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062CB224E6;
	Tue, 13 Feb 2024 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818958; cv=none; b=qWZHefZhXDXhtdnlJ9jxGYvwzYmKPBT5iZLxq7gcnXHKHeS0Oetixd4VR6+8xJbL+GlE8eas4Xum9sdk2AA+vtnnu9fGER40BxRZuTQ1jhgjVfKt4ZjP11WY5MqUj3cHcvpGqlkjANCyB0KgXGbKh/Mju2wSKddMsYpbDg+duS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818958; c=relaxed/simple;
	bh=HiQZbdRmzgTCB8ES0rsIWJhMeBxKcVI2EgJVFYK5Yf8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vwpa1e2JML2XyuHmQIxCCMpvZRU+Uc76JZ3sZ8xD1B3LX/GISXW3hkz49LiqCoRvcxxvOQq+dui0yNEBE3D8N0Cv76KgB3bjH4Tf8sUP/j0vtkuEX73egngTXERSdS8Gy8qG56kINlClBtZ0rQBPdQ3h3hXiT34lGGPFontS/Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avMTiGFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C174C433C7;
	Tue, 13 Feb 2024 10:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707818957;
	bh=HiQZbdRmzgTCB8ES0rsIWJhMeBxKcVI2EgJVFYK5Yf8=;
	h=From:To:Cc:Subject:Date:From;
	b=avMTiGFZmj1wjnBPK3XnQaqWfS/7+BbASpyxX5lpSUDuWS63seveFw96r/Qvfst+f
	 bnU4gUmidsQcnjDMw1d/JdNBasC3KdDdQkfFd4wibVtwyOJAeaPoCWA3YFays2zQeZ
	 ZVIYqXZ5XbjcI1Y2tHw+SPOB8C5PfQpLG89+i/DaGw4bx6XjZyXhIZlfhe5nAWXUrm
	 iDnYF24eCvShjvczrifMxhg+rgAeQa0IMkbyX9DQs5EUPGZW6xabDNig4x3Ee6YVba
	 doJeEel5bUec3/Q4lQctn51QyUSmvnYDOuquxep9qnEP5IQpyN7jAnby6eoaFfZCLO
	 MyLifuYmoDJdw==
From: Arnd Bergmann <arnd@kernel.org>
To: Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	Wen Gong <quic_wgong@quicinc.com>,
	Muna Sinada <quic_msinada@quicinc.com>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ath12k: sanitize ath12k_mac_allocate() return code
Date: Tue, 13 Feb 2024 11:09:06 +0100
Message-Id: <20240213100912.459018-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The return code has no initializer:

drivers/net/wireless/ath/ath12k/mac.c:8006:9: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]

Make it return -ENOMEM for allocation failures and remove the unused
variable instead.

Fixes: 6db6e70a17f6 ("wifi: ath12k: Introduce the container for mac80211 hw")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/ath/ath12k/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index f2f7b2a60261..e93475ae8d07 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7965,7 +7965,7 @@ int ath12k_mac_allocate(struct ath12k_base *ab)
 {
 	struct ath12k_hw *ah;
 	struct ath12k_pdev_map pdev_map[MAX_RADIOS];
-	int ret, i, j;
+	int i, j;
 	u8 radio_per_hw;
 
 	if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags))
@@ -8003,5 +8003,5 @@ int ath12k_mac_allocate(struct ath12k_base *ab)
 		ab->ah[i] = NULL;
 	}
 
-	return ret;
+	return -ENOMEM;
 }
-- 
2.39.2


