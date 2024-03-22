Return-Path: <linux-kernel+bounces-112011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BAC887420
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E21283F29
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124517F7C0;
	Fri, 22 Mar 2024 20:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="NB3wWpxT"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D767F483;
	Fri, 22 Mar 2024 20:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711138557; cv=none; b=Mb1NA2Ov9pcuj5NVGpnx08pVdWojQVcG64Ad4D7WZQfZNvBxtEg2g0GooSwK5ZGBfOlI3CnQtJ5C/YALOAVHpISMjPNm6HLoCsqnaR8RvqLTdW2FTGTNeCrHwyGc9urXqA21an87RWp3C40Dksu8ZwJ32XcT9HOh7XrDz6a8mdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711138557; c=relaxed/simple;
	bh=HwkJQSGxRgGjbePLX2h1Rv1MHm0zl/nPYHxGd9cCXrc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ijaWBwuPjc6uQX8ioSjDmvkCVSmnjttrjRDAwi90Q6qWzPLgPpFXK2EzdWEyUIKjLeLM35kShuyNu6zqew1jMD6jm9jgGMaAW1ac9jO9rxPmaiFArb27nRgLtJ8XgvngYI6E29y6w32gYC6GrGF41h3y1HYKzrntARDJPl8TPyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=NB3wWpxT; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id EA364100002;
	Fri, 22 Mar 2024 23:00:21 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1711137622; bh=UW+aPfVPIjEjrOCStLiM6dlN4mJg5sptGWy0tcnbKZI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=NB3wWpxTF4d/KUpLvkSFY/s+u8EQ1saR6XBeCuueL05MLbMbMofRcl03RoZdkQfDo
	 2wbdV72wLQWY3+BPB7RqbcjDqCHu+aitHSx6xM91tMMzK4z7JKNWa4zxOmwUFTyISe
	 6dI2ArylH/q39So2MBd2RP6XKxv403HGXdjp0CKabNXnvPlLTo2pl3Qj66uGHMo/YZ
	 eJ/35zpecSY9y0RADecC98W5mFHvLEHAssCMtTh8rXIX5Vdehv6bGqRw77cneFgv6B
	 j/BV4bOHiZ8AWAQmZQ3TYNBjRlf7pyh31e2w6m5N3nHl5gfaIpRELjf8R2iZwoEQUL
	 ffEwBpSSL/dBA==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Fri, 22 Mar 2024 22:59:05 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 22 Mar
 2024 22:58:44 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: "David S. Miller" <davem@davemloft.net>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kees Cook
	<keescook@chromium.org>, Justin Stitt <justinstitt@google.com>, Felix
 Manlunas <felix.manlunas@cavium.com>, Satanand Burla
	<satananda.burla@cavium.com>, Raghu Vatsavayi <raghu.vatsavayi@cavium.com>,
	Vijaya Mohan Guvva <vijaya.guvva@cavium.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH net v2] liquidio: Fix potential null pointer dereference
Date: Fri, 22 Mar 2024 22:57:44 +0300
Message-ID: <20240322195744.9050-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 184367 [Mar 22 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 11 0.3.11 5ecf9895443a5066245fcb91e8430edf92b1b594, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/22 19:47:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/03/22 14:30:00 #24353062
X-KSMG-AntiVirus-Status: Clean, skipped

In lio_vf_rep_copy_packet() pg_info->page is compared to a NULL value,
but then it is unconditionally passed to skb_add_rx_frag() which could
lead to null pointer dereference.
Fix this bug by moving skb_add_rx_frag() into conditional scope.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1f233f327913 ("liquidio: switchdev support for LiquidIO NIC")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
v2: Fix incorrect 'Fixes' tag format

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


