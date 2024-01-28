Return-Path: <linux-kernel+bounces-41585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AE583F4F4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 11:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7572282485
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 10:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C9B1AAAE;
	Sun, 28 Jan 2024 10:18:57 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E2CDF55;
	Sun, 28 Jan 2024 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706437137; cv=none; b=LX5Q34AZhQLjMrISZW45ouMuFH0OKajJCkmyJrGn/QPEoUoWDH9XePCTK1vZK3rhiuLOS1lDuEmbFLb0O/xWVl/oFBD8Vt0Rk1Nh6nZtKaf90ZwEmJy/9egFI3DEUgbGE+5m3WdMpGMWL+WRWkrojV+H9uRNRErKvFTsJpy3zko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706437137; c=relaxed/simple;
	bh=xY9d5ERXouy1ZaiI+F1+aXQOChBlb7NLWX7kgpBMQkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IIBJeAYZNdkxFukYxywHvKYT0U3wBSY7bZ5G9zrP/x7aAc9Cbk58Mj2aCWMVL+KZ0zjak8MmSfsMkSLkJ/1BxUG86ypWSxDFiuZ26zwVV//2blwZSTFfoa7VtoTWe/O50gmJgayhcl6RceiN8cpqC8Tgh+SCtBFiFga2qzQKhaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40ef64d8955so747715e9.3;
        Sun, 28 Jan 2024 02:18:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706437133; x=1707041933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jLClgMgKHAYy8oi26SoamRje703fIGbCXV126plVXY=;
        b=NPRFWsja7jrGluOBwcp6Sp6UcAy4MfJMtatrukG97sa8m0GB++CtBnpP3YV94guOgD
         CIhkTtJpOU6H2eYnouwRu6OEqcisDZ9oMcOSKJ36YridA3JtplbDMr0iS1Np/BA7A8gX
         mWLTpAy+tQgSJjbV2OYwC5XmxMPfWRK/Rz3TbBI37EkHyGp1hLxHIjHegLmKzaq5MHSF
         mKd+W1enDb9WEonNCTudoafkq2XokAb0SXGKZ08MA7LfNMQoTwt40d/nNeZ0BjaieWdd
         sqwtAAPmcIrViAf0wmLZvoUFC4IF7aGJW326NVIStzdR5U6xKvW80vMfxwEAhHF+NY8t
         MLyg==
X-Gm-Message-State: AOJu0Yy/dSp9vtm6adUNWuYlCKnN2z8AICLzTzooSIlKDAeoycZu9Q+H
	jLzkqtoBDBx2F54potv6LjHCtgAwZtvfqEdERgempC7gOwENRL8Z
X-Google-Smtp-Source: AGHT+IGkaMhTMf/7LomVjGIRaR8Le+S1R05a9PLNUKI7dKlEL9Quuc9mhxceiJs/myFU1LsgSsaWJA==
X-Received: by 2002:a05:600c:35d6:b0:40e:6703:af8a with SMTP id r22-20020a05600c35d600b0040e6703af8amr2667929wmq.41.1706437133059;
        Sun, 28 Jan 2024 02:18:53 -0800 (PST)
Received: from ryzen.lan (cpc147820-finc19-2-0-cust1005.4-2.cable.virginm.net. [86.16.175.238])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b0040ef2e7041esm1594505wmo.6.2024.01.28.02.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 02:18:52 -0800 (PST)
From: Lucas Tanure <tanure@linux.com>
To: Bryan Whitehead <bryan.whitehead@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lucas Tanure <tanure@linux.com>
Subject: [PATCH] ptp: lan743x: Use spin_lock instead of spin_lock_bh
Date: Sun, 28 Jan 2024 10:18:49 +0000
Message-ID: <20240128101849.107298-1-tanure@linux.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lan743x_ptp_request_tx_timestamp uses spin_lock_bh, but it is
only called from lan743x_tx_xmit_frame where all IRQs are
already disabled.

This fixes the "IRQs not enabled as expected" warning.

Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 drivers/net/ethernet/microchip/lan743x_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c b/drivers/net/ethernet/microchip/lan743x_ptp.c
index 2f04bc77a118..2801f08bf1c9 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
@@ -1712,13 +1712,13 @@ bool lan743x_ptp_request_tx_timestamp(struct lan743x_adapter *adapter)
 	struct lan743x_ptp *ptp = &adapter->ptp;
 	bool result = false;
 
-	spin_lock_bh(&ptp->tx_ts_lock);
+	spin_lock(&ptp->tx_ts_lock);
 	if (ptp->pending_tx_timestamps < LAN743X_PTP_NUMBER_OF_TX_TIMESTAMPS) {
 		/* request granted */
 		ptp->pending_tx_timestamps++;
 		result = true;
 	}
-	spin_unlock_bh(&ptp->tx_ts_lock);
+	spin_unlock(&ptp->tx_ts_lock);
 	return result;
 }
 
-- 
2.43.0


