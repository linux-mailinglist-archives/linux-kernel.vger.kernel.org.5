Return-Path: <linux-kernel+bounces-123314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F7389066C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B841F22F45
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2C83D965;
	Thu, 28 Mar 2024 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="iBeAoiSb"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716001DDCE;
	Thu, 28 Mar 2024 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645033; cv=none; b=MzDt9+sS4SOFnYshABVQlUI5q9djeUQ9iwym6dT7Nv88GoNxFYq90suWbwLJ7i4U+ES14KwohjIoxve4uPpE9DcEvtmYQhmO7ZkCA3Hjbhtrf8BiluqZ3iYHBo1NXgNyPP+iDhvlQIJEw8yIsatw51kq1J21fgaq69RxqS9ETQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645033; c=relaxed/simple;
	bh=EHJUzSEdjzJ/cmKsFNEvG7B/Q1Bo729hqrAONKDR4so=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NzMO9bdgHu8WsuTnpsxfXA2aZpstBzGW2ft5bRcFHxBtz7CQynXvyhHdofKYgQUFcpbkvccGnu+oXzuUcWalVdwMXikPljqAM/Rg0Gge6gaue+elN0fMONdho9Hi1GxoRjONUjycRsVxraaPAExrWE33KwY6kZQDwOzRhdQNmGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=iBeAoiSb; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 09146100002;
	Thu, 28 Mar 2024 19:56:51 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1711645011; bh=JCP/D9Zpg32pYmuOTl3bze6wQcVUGIRiAN7maoEjdPY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=iBeAoiSbFz0WxHExYG2lu08xrzugFz9q8AqvjJbP+ttnmnmtuwBQqQbSngvhCi/st
	 IVcqxnqBY/TaoyflxCx990IQuq0AXsaIEYl8spe0YK4V1fv4Th7kuT+jXXnJNooNej
	 q6LN6+obz6/6H8YvgwxNO1Ru8oYopXAPgDoAaax5hGx3bAt/WQGtTwijHtH3YlLBFM
	 CasuIu47gIzq6Y7g6O9eGYy6bExmB8/EGR69dVSgl67dncPyi19mXx9D7GlyeVrfwg
	 1KQHJctjOlxnJQKckWJmck4kGa8mTYkG8+WXA5ohPgviuMCBMlWQTZGQnd20jwn9CV
	 bFKhduICU5vzg==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Thu, 28 Mar 2024 19:55:33 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 28 Mar
 2024 19:55:13 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Sunil Goutham <sgoutham@marvell.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Linu Cherian
	<lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Jerin Jacob
	<jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya Sundeep
	<sbhatta@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH net v2] octeontx2-af: Add array index check
Date: Thu, 28 Mar 2024 19:55:05 +0300
Message-ID: <20240328165505.19106-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 184474 [Mar 28 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/28 16:17:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/03/28 12:50:00 #24493847
X-KSMG-AntiVirus-Status: Clean, skipped

In rvu_map_cgx_lmac_pf() the 'iter', which is used as an array index, can reach
value (up to 14) that exceed the size (MAX_LMAC_COUNT = 8) of the array.
Fix this bug by adding 'iter' value check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 91c6945ea1f9 ("octeontx2-af: cn10k: Add RPM MAC support")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
v2: Fix subject according to the networking rules

 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 72e060cf6b61..e9bf9231b018 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -160,6 +160,8 @@ static int rvu_map_cgx_lmac_pf(struct rvu *rvu)
 			continue;
 		lmac_bmap = cgx_get_lmac_bmap(rvu_cgx_pdata(cgx, rvu));
 		for_each_set_bit(iter, &lmac_bmap, rvu->hw->lmac_per_cgx) {
+			if (iter >= MAX_LMAC_COUNT)
+				continue;
 			lmac = cgx_get_lmacid(rvu_cgx_pdata(cgx, rvu),
 					      iter);
 			rvu->pf2cgxlmac_map[pf] = cgxlmac_id_to_bmap(cgx, lmac);
-- 
2.30.2


