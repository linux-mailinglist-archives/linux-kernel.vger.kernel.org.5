Return-Path: <linux-kernel+bounces-95224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC262874AE4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECAED1C21298
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5336883A1A;
	Thu,  7 Mar 2024 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="o7ya2Bbk"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820C4839EF;
	Thu,  7 Mar 2024 09:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803905; cv=none; b=ADLKPmJGiFMI7KqS3ZgjT+xf1EwAzWeaMgFeISfmH6fRVDvHVmXt0zLkYBk+rIBX4/cuPH7fpcSoZcD+mi7mh2TMujAOE511leggg1x2Kau92McMl+GHFcNAEqBoUEzXzreBAguIMNwc/RPMTAgVkf/rpUQ+EBteNPsltysvuqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803905; c=relaxed/simple;
	bh=pax4kMUXsJGJnoUzX9FvaDRqurWPA4Z3ms9k7p/CSr4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FT3hAMe+u2ibzrVESvcAf8aLxo5r8lmge0ykLeGTQqg/l6q8D8URIyLy4PrnKEjsJ0FzUzEHn2071vyyn+l8cGOlGIEAf5MMWJPZMO4qUdv5b6SRDgExnnIaDNQfJpRK/amc9YEBSucADQFck4MAKmPg/9wlghVRAmtrt+kauYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=o7ya2Bbk; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 60CA6100003;
	Thu,  7 Mar 2024 12:31:21 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1709803881; bh=2TtaUxTCDa70M6gykgWVJXWVoctQT59eKYoSiehXjoc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=o7ya2Bbk8Yf/SiTancm3WfYE5GRDOgJrggAe6E1ksUo3YFH42baTHQLsSCZOTwlWA
	 jwG9fAnPGra/pMNC4xwqQ5oNsqPIm3UqfiLjdt/7Edoe68LqCpBzUaaFMzA2/lDwKT
	 nqajLGYCHgUan1a/I8Nn63z24d+EIgOl09cENR1r1wLXE9y12HANGO9edzrTtWs0Fp
	 jwZi6AhdP8cTJCYu+sMzaXyUCujFKVlu0gQZVt5OrD/36F/j+v4bGsqjAGHpAWHNVe
	 RCV8T2fLKHvYIYdkBotbGY1hns78AIdlJ80Og5t/AfXOP9PeEL7kIN9PDUg3XV8syf
	 ZoB+b+np6iPEA==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Thu,  7 Mar 2024 12:30:02 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Mar 2024
 12:29:41 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: "David S. Miller" <davem@davemloft.net>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kees Cook
	<keescook@chromium.org>, Justin Stitt <justinstitt@google.com>, Felix
 Manlunas <felix.manlunas@cavium.com>, Satanand Burla
	<satananda.burla@cavium.com>, Raghu Vatsavayi <raghu.vatsavayi@cavium.com>,
	Vijaya Mohan Guvva <vijaya.guvva@cavium.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] liquidio: Fix potential null pointer dereference
Date: Thu, 7 Mar 2024 12:29:32 +0300
Message-ID: <20240307092932.18419-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184023 [Mar 07 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 9 0.3.9 e923e63e431b6489f12901471775b2d1b59df0ba, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/07 08:43:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/03/07 06:26:00 #24026065
X-KSMG-AntiVirus-Status: Clean, skipped

In lio_vf_rep_copy_packet() pg_info->page is compared to a NULL value,
but then it is unconditionally passed to skb_add_rx_frag() which could
lead to null pointer dereference.
Fix this bug by moving skb_add_rx_frag() into conditional scope.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1f233f327913 (liquidio: switchdev support for LiquidIO NIC)
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
index aa6c0dfb6f1c..e26b4ed33dc8 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
@@ -272,13 +272,12 @@ lio_vf_rep_copy_packet(struct octeon_device *oct,
 				pg_info->page_offset;
 			memcpy(skb->data, va, MIN_SKB_SIZE);
 			skb_put(skb, MIN_SKB_SIZE);
+			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+					pg_info->page,
+					pg_info->page_offset + MIN_SKB_SIZE,
+					len - MIN_SKB_SIZE,
+					LIO_RXBUFFER_SZ);
 		}
-
-		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-				pg_info->page,
-				pg_info->page_offset + MIN_SKB_SIZE,
-				len - MIN_SKB_SIZE,
-				LIO_RXBUFFER_SZ);
 	} else {
 		struct octeon_skb_page_info *pg_info =
 			((struct octeon_skb_page_info *)(skb->cb));
-- 
2.30.2


