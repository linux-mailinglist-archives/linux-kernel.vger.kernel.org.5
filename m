Return-Path: <linux-kernel+bounces-165531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B348B8DAA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE1D9B22F2B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1707130A6F;
	Wed,  1 May 2024 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="reOO3hls"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2071.outbound.protection.outlook.com [40.92.45.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E88130A4C;
	Wed,  1 May 2024 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579438; cv=fail; b=n0OMpDfjTMrMoCfKRiKAREMUz1nByQyP7Zia3x1b271Vu0XD58UFq5CHt8qebkzm+wPc9jBydRaknxgBt/zeHHg2l/J1AQs/DR2yU3WvQz4ttKTmz4GuZEghNr/dQLlLl31BipoJpHObNYv/GHS2Lvyqa3+W9khpiAWBfA9HxLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579438; c=relaxed/simple;
	bh=cHB5Bd3AQvD4qN37/en3h/15oj4vABf1xasMvTLVjTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q6DTMEgCcIPVA61OoWHTMIm31ATNPWyepQcIw5r9LMl+yt47QTegzLxAuku9l1v44lSg4PrYSVUyyyyxtJ9+Wudq9WyV6iMfRXA2fe5Q0huD49pZKrVQZgEUDeGbQ25xFj4uU0GIi3iFeRPxLDdX2pSuybd7NK4K+cqKb+3uESc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=reOO3hls; arc=fail smtp.client-ip=40.92.45.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asWbY3KQX10hbcutcae00rBCGyar1dooniy80tFvw/QDjtR4YQSYHRuYEr0KErDn7ggBxIN/0HndBoXqKBf3lGCM+GzNZ3RxcraWAK5ZMBkvc6KFvj2e9U7IZGDeC6AAL2ekmy83pMJA8UNgUjZ6Ju4JD9W6tZLrEDZKwiykwO9l4CMf1Rr0kYpUtuBOYXLIfDxhOJTwaxp3P5N62RB3QqKHKqX9dDPjpFHHZlnN00cpwDbtfpzwkppXqXLrYqaaL7QxtJxE4zXnnq+SR++dFqGhOBLBfnUa2TW2zRAu+fzsuGIo8Ul1FLcd0i5oV6yxohIA/uz6SW5wanGCWhfZkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTWLBrb4fL4nzNjk3Tbhv6WCgSXloJeYw3KGYpXWzDY=;
 b=hGvWCB2Q/o/EmVa65x59elBemrLODlDVRUjbmwBsnygwelUYH3GVRCAcEaW6QjKpx+l5U4AwYwzRwLiZdmezikqgKwqKLpydkMrYEQQptoyHgc7JN8CfVpdpRWFDzJWFECzXlXYQn5sRVcVe7sP+EQka6SRycsw3r8Epj7SiFHxCD2OYJfEMygBbcwEICqlmiz6QagOMahJzlpliNqzbXfmUfPM+OD442ag7CLmMQb7hyM20OI56aMW2P2DEOacjGggys+3Aic3mcAQAfY48xoPkvXk+1YEFDuRDcLd/L1pFLtnPxfFj5Sr1aidHqqwitzYjERXbMMmgJCKS8T4+nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTWLBrb4fL4nzNjk3Tbhv6WCgSXloJeYw3KGYpXWzDY=;
 b=reOO3hlsQ27+FYip0u31CvLLrJ1tIhL8f/SWyeI3CG6sKUiSfElN7vIydj+yaRwMuC98ihu/Fpqk5e5OYLQGarmAxQZFyeFYlfTa0JPAXbyOPf4Mac6WbG8i4kLK6W2ERtnzz+71uxm8q6vqxNHietIQOogT7aqGG/MwW4GGfbNZlSj2tVD4uW15yOaKaGr2h+o8kjJE3RYznyvOxRgnVdYUuvHK9c/9zM5t9SzETegmDZBTt130kgIsV26cBfNtcpORmwfrx/Dx4aL/t8riiZuUHZvPS6ZO7x9mGl6UZBRix+JTg0AJjoQ9/2CZ7In6NMkexrS3E28QGa1rCuNZhQ==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by EA2P220MB1331.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:257::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 16:03:50 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7d42:dbbf:4d41:6999]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7d42:dbbf:4d41:6999%4]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 16:03:50 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 3/5] ptp: clockmatrix: dco input-to-output delay is 20 FOD cycles + 8ns
Date: Wed,  1 May 2024 12:03:22 -0400
Message-ID:
 <LV3P220MB12024CB984967E4AC05A1E13A0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240501160324.27514-1-lnimi@hotmail.com>
References: <20240501160324.27514-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [1jK8wd5RFbc0dRQpAkXM8A1yyoTZz9px]
X-ClientProxiedBy: MN2PR18CA0016.namprd18.prod.outlook.com
 (2603:10b6:208:23c::21) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240501160324.27514-4-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|EA2P220MB1331:EE_
X-MS-Office365-Filtering-Correlation-Id: 93718da5-a9ce-4be3-a297-08dc69f849e7
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	1p7b40z+gaHCVZ9SeEYVvrgFpTby4r+pryK/HppKgJMIRUhAHVHLvTSCSCaKIZjyfUAf9MKLqW10014DMABYcYwWMw2M2sDqgPa64uwkB3Rxqk8rJVnnBzbM3/Ap3lddjMnjssdeJ27HKsm4kd3WX0PVc/RwFHJ0j6jWf5brmyqIG9Xa8pW/0NO+2l1fchU01ip6z7+kmtuzN6nn2kdgtzCNsC9AePmrqrgDFUTPMiD5LZQMwGkvWtqAWOlW18mx2brzryfosMiccbAj0wIab8tTAhwuRrIQd1KSsyFU/8E3JcdjT+ndJNxnQS84/86dwXzIEr/eNa5v/ciDExUufEdW0fI3mXmaaZSo2nNQuev1Fl9OrzCEq0FGQi9cJviz2qpXEZtZaREOnTNAuEdfdilIXSkqSSXb6yiOoTvbmMHsD5lGVIsgsv/SIFhzDGeJBnLVdhbYBNOM77taS71aZU1Sravceie3fhfnxDup4Esc5HYccYhRiPHX548vq5QAsGK1dhd+gCo2UbUG3nX1bHBhmgNBIP17COzX2MQ9bBINJQ6YYDd/b71QiKSq+O4t
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nnEQ9ZjwTI44+P7D7f6esR/zrJKyWbIaVyfuADmw4X52bByF9Wh0VvQf6Rp2?=
 =?us-ascii?Q?+ch3mLLBW/b9Ryk2Cx6KYkACtm8eNLXUX5Cpbm5Bzncp4YnVUBHRr45mh3Ca?=
 =?us-ascii?Q?uKyHw4p535ZNHfPgrbdnm16p5MtRxjQHKc9s57g20DHHkPY2/LnZsxMxeQso?=
 =?us-ascii?Q?z8Jd1vFqx6tQfs/FYi17Nz70n1v2RM2bgF0CrRnTN0sFvZ4d/dc6GLkRgs3O?=
 =?us-ascii?Q?7XRCMzcqgQSDDYy/bbXdizG+CbSfg8rIXeYUJ1ZlYjRXDXvkEGGWLF3deLXw?=
 =?us-ascii?Q?sMzD419wqBTlszIC/kqbldR4CoIbgQAiz/qkTVg5GErfxE/oYJITlVRrs52g?=
 =?us-ascii?Q?mwbqu7FdAc7kbIr0dA6gfm3pSVRafBVrvYZQwkYYYHiDeeawfbwGXbCNmlZW?=
 =?us-ascii?Q?UciC8rwBqWGwyTZ6qpmce8z9l7W3UIngEBimirYsdnDCEt+ptt/qCNEMF8W2?=
 =?us-ascii?Q?EXDFczsF8OoaXOrfvmZGsGXH8AFyp47mkar29i/7590shgJYp+i+M6fyI7Ii?=
 =?us-ascii?Q?HznFPP769p2eQ4HTPNPdgRvdOzgv3pqcSk3GSgyUYj4+WHayxEqcCRr8EIEi?=
 =?us-ascii?Q?6Z/w6HJMdRTsKm8UmwtDxM1n59IjEtqdEZmpE2AkirP5X4u0CHKSgb2BnHQA?=
 =?us-ascii?Q?WQ+AMkPSrpWRNqbZqwJyFldyAYEKbbWAhCXOG/Ro2SpAeUfxkp+d0jqbFFpj?=
 =?us-ascii?Q?Ndrl0YSxAEbx0Vx/FsaDqc25UQN18j+BEmb2yGVDPbsXQ4T3RkYBa/wRbw/7?=
 =?us-ascii?Q?OQ7JYAN7JFIcwdCYN6v/XSGfuHcWrFsCPO2YJmEQKuSYGHweKDsMNGp2t7yF?=
 =?us-ascii?Q?GXlkWj3wGab7aVCBM1TrdNlLWxGX+56NuMmAqtDVkEJZ7MpQ+9qKsuhWlHqi?=
 =?us-ascii?Q?aCLa7il/5yxA1XO13qQo8hmaFl37xL3K+OiXzxYrjXqFFv130gXJAkXnL2Z3?=
 =?us-ascii?Q?l5GcnYtYQ+u6PoCSwSiVX9zWELlxqrObAmhcom1aopGmuBS+F+Uo5J2qRKmT?=
 =?us-ascii?Q?ndyGN6dn/LqfT5YGu/+vcqPajXldp1rD50BSME+tgdOAJg9zesRmwpJ3u9Vt?=
 =?us-ascii?Q?yYf5gMCENnHfl7ukxvzyBK5Xn5+F0it6n42h7z4l+G/7U4azu+gTeU4wureS?=
 =?us-ascii?Q?rI1YArUxI01Yj2KJ8nrNqmkWW8TKFLZEW4qsUmYYJAWL7yB/Zt/fg474evgR?=
 =?us-ascii?Q?898/XYX2CDh4NMIvsGtD9bYiWST1UUOX9RZj/WXpaZDidzYGYXKvT/a/pzk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 93718da5-a9ce-4be3-a297-08dc69f849e7
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 16:03:49.5378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2P220MB1331

From: Min Li <min.li.xe@renesas.com>

Set dco input-to-output delay is 20 FOD cycles + 8ns

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 drivers/ptp/ptp_clockmatrix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
index d069b6e451ef..21f3a2c179f5 100644
--- a/drivers/ptp/ptp_clockmatrix.c
+++ b/drivers/ptp/ptp_clockmatrix.c
@@ -2165,7 +2165,7 @@ static int configure_channel_pll(struct idtcm_channel *channel)
 
 /*
  * Compensate for the PTP DCO input-to-output delay.
- * This delay is 18 FOD cycles.
+ * This delay is 20 FOD cycles + 8ns.
  */
 static u32 idtcm_get_dco_delay(struct idtcm_channel *channel)
 {
@@ -2196,7 +2196,7 @@ static u32 idtcm_get_dco_delay(struct idtcm_channel *channel)
 	fodFreq = (u32)div_u64(m, n);
 
 	if (fodFreq >= 500000000)
-		return (u32)div_u64(18 * (u64)NSEC_PER_SEC, fodFreq);
+		return (u32)div_u64(20 * (u64)NSEC_PER_SEC, fodFreq) + 8;
 
 	return 0;
 }
-- 
2.39.2


