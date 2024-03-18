Return-Path: <linux-kernel+bounces-106458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFB787EEE1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16021F21FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D7B5786E;
	Mon, 18 Mar 2024 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="W0zRPFJa"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2042.outbound.protection.outlook.com [40.92.43.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27C956463;
	Mon, 18 Mar 2024 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783165; cv=fail; b=sOKJoAXVoLxP/y44K+dXhC+J/8KLzAUrg5IMZlr6P+Y91wStFCfi/gcLLuL4Xz0Cgwf3K47S/KK/ou0LneykeKnQvF6ncCYWLuJ5oIXlo50+r1muQPsPzt3YPhBrePnKGTSEirQgh4b1KcKN3+z/amTwCAjnQO/1YP5qHb1Veyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783165; c=relaxed/simple;
	bh=cHB5Bd3AQvD4qN37/en3h/15oj4vABf1xasMvTLVjTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m8bu21BNXGojNSm14oE+13Uikjr6H+3SIYAedwuK7eGw0cCCY33hXGdUgln2pfpS0keKsN6HCFraaBvnIbSL4XGLS0PHcWt/C14yYS+8KmsZT3hKMLJWe7q0bbPn3QS1aWq+IkuKhRIUvYcf+R1RrfpQXKh0sy4/nusZbntpReI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=W0zRPFJa; arc=fail smtp.client-ip=40.92.43.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALHt2h1dMYU6MX38/tkrZ8WlBEW3UgEzqcpbfCGHN3KG8j4HV2+k9yOKvL1efPeLjLJmmHOV+wJYrFxHblLvb4yYj18kSbX0LGDz3G72G2o17y1jdtrVv5z8JCr5xc3g6igLq+NSWC6h1pNs56qHL8BoK/sUn5z6fYRV54yrLhGK1quN458UVivZgdYcjs5QlnLe/mnsEnImT6EfLX9U1u13yIrOFuKGKOce8pp+oqSOhQjV+LNe4t0PcN/+SUORS3V6I5l/iDLcRjiMlsY0sL9NRAcxGfy8CBo7fOsAWu+8N/iQQpwK+nLESzJnLgX3LWLQ4dBbqzN1Cloy4ZTVLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTWLBrb4fL4nzNjk3Tbhv6WCgSXloJeYw3KGYpXWzDY=;
 b=YuxHED4rWCvB41V5OhA0cIQYZZvoaKiC5iJJslYAYBd92XM6fCznO+ogjUlJAJXODSgvoh1xa69FCrIEM7sYlzAHyT196rQSoDwvJEK1fSN6SzbYEzknE2KjuH1n/1S6BGIy9YmE1tRzJAHINkGZIWEJDB/PmHaBAOi0eKkJFoxsmkHlt1vpnKk/90DZOv197z6pAyC4/84DOKob8cgwrJyp/ckVsHEwYfW7nNzSR1ARIHHJAoI1c22+8DiABBXlfa2gxfxT/sZ1v2vdvZdCy/3CFDfA7lDozgf5zWo1lfXCaByIhuJFAyU/+IlEGn9nao9W7FbBgh0kJ+mg3wiE9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTWLBrb4fL4nzNjk3Tbhv6WCgSXloJeYw3KGYpXWzDY=;
 b=W0zRPFJaz4ziJvg4IE6CSg/bPLXSbK7AehHdF4nvKUmS4mECn5tA+rWGWrdsEwck3dzWGbNVoT+m4MYJpXEDf8VX+NuDNJxJa2HWFqWZQKPfE2my3zWHbO6Jw2RDLCWm838jIrhCs3PX7zKnZ+Hk7BNN8vl2dwnp6wMJqRwFASNy2v3tHjGuTiKNd6VIXXzltFFM/z8e1JYVoLwW/YfwBiz6KUF2gmC7kBlyDO5svVSlKLCfU/TQ6v2Kkw8rAwtNmA5Vqd8wZ5+BNQgY2UQgoPzrfzx8lOwwCO3EEgBFkloN68T1yFW7711uZ45ygLdwMFru9YfGpgymzjyOBJilwA==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by SJ0P220MB0785.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:408::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 17:32:41 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 17:32:41 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 3/5] ptp: clockmatrix: dco input-to-output delay is 20 FOD cycles + 8ns
Date: Mon, 18 Mar 2024 13:32:11 -0400
Message-ID:
 <LV3P220MB1202EDC87417EA6C3F55836EA02D2@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240318173213.28475-1-lnimi@hotmail.com>
References: <20240318173213.28475-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [KocnEvyWJOemvqv5bJMN2mpSHO0rOPIy]
X-ClientProxiedBy: YQBPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::47) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240318173213.28475-4-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|SJ0P220MB0785:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc57f6d-78ce-4187-bcb2-08dc47716a04
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnr9wYTvfIwcniUcOEk7m2BTvc7sUbL42pz9myjLRdNG1hponPip/9dg7NYmjd1i/NP2Pz2qLPnmUwCUtqcK4uFWSOW9AAcy3zq3nigqMZQOKIBudJPXF07Hm6uWVfuCzZZCbCzDO9lPwgZbFxHoF21lty68Y3H1pdQq7UEfAo+JAQDjcAtVHrcBj18mqDMHqVPrcacCj3aQQJyXbVIGAxnWJYzac88Oby1mqnkgEDAUb609dvzLHbYvLG4AtsBGssoli9CG3n43Jy6rMrpyoCf6eOqvVFNoE7OabxaUu3/53JevUyhmeMeePm2eebUWORsLdYOnPEPZRmz9sUutmGBjyG5icrzRZuJ50IlCaCkzT7TgRdNCuwjZLzRaRTdCcvMrczGh7+iLt5ul6Wyqtu4gyAaGH546o0JrbmKlA8VyMbKu9tjV+/q+/asK3yh1nmGOZv61fkAN5c0o871226lVH6ewDtixAkKWc6G2ExJGGdKCFpdI25O1jLfYKlHZa4iYj0ko4ChdKgPwOHth/zblXK5rQnM06AZv80i4O7XU0E3hR6fXwljMkyGmgqAAvWYvt7n/eJp/gh0qPiZYsrRbsLwzjuvQqb0PjbdjQTFzzzwBiWNCsaXucCz5VbFCaZxeQg77DPN/ODbz+jDOdDcQ/PqnAnr7aodp7xIgTTl3wxdbouCMqQsFx9zoC+J4NtzIWl1WWVsoVSOWMbgM8TyRK+/yg30r2Zye6m832T+vFJXfHLrt4ovIu6k/G6D4V4c=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Su5mRazYK6skJiOH+PounIddnNVhoDQqWE9dbKO5vOFEOwRQ1pPp292XfqxY5AMt4pM8hazJjo3U3ZC/yGhkGOHx8+2m02TKLPM5EjRwlzNnoEGxty2uTHuf5VGBeDtI7MlMwEocD/KQq80XQWnwJDCb3ngLCRhrywEOCGHVjaCzWHHRCER3k76L3/peDbX80pN/o4GFQ8vvnN/jKJMBhOsJ3E8pt2qfApV+LGm+eqQx25F9SVF/MJHmHXtNL+SoT6Ku6pmx2QHv54UGYcgJcpGatcoBBlF9wywPwjHkB2DtX2vqHilnNWbfEuKkblHjpKjyUHnGsJa+bs3Hu41hzCN/Yk4Q3WFLR1zDQCoKKP0Pit8fVs8KATKlLayGotgATibZoOqi2NWSexBqRCDvwBF3QX6vYD5GdZlCSqgar1T0nBTmqVWlzi/AgVoTNvq9O1Q+hWHi7grEozVXgnI0hb6cQD64kSt/7dXURauGdxWYchen3dAYVUaF2Fqdg9Iba4T6aFi5F3NnSL8sAJ9e5RYqHQRVpFKQl3g4MbLzG5XJ882/3lxQ/QxyNEWx6wJt
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vqsb/RlaQNJYMaOlnlNGDfurwvM52EnmyySRtGe/rsJEn0OwNPEnxXhXiN84?=
 =?us-ascii?Q?pS7hv7WuhcEBaRQnJDP/qYB6Rl/do3JqGgPE2lJXXzEAawco6vVk2ZtgfX4S?=
 =?us-ascii?Q?pmZkBxY+lz3mtBmKTEr7/dzxHQDal2WAfR9IyrMQhQeJc/UTmr3cdJaF/Ad7?=
 =?us-ascii?Q?i1JLweiu1VVACJMCy/C3Jl7oSHIamFNHyYxCILmoTUGGPcZKEMXOifhTfM4/?=
 =?us-ascii?Q?JRooCyVgCOLRWWAusk0Im+OHjBDzyNEV2/z57nTfifUR+RpclrcPOjDpJ/qU?=
 =?us-ascii?Q?ajiybzFPcvjvgY4Diec7IYysRVirKJQcxPr+9Vn7KafU4Bjqmi9anvc20wVt?=
 =?us-ascii?Q?Y8oSkmNIfRjk+LEE0B7NyOM6aF/qR59/XGCQyIc0U2+SBbnF/UMKANK1z7R+?=
 =?us-ascii?Q?sXM03u00OmlTICalNBsTVnsl7lF5Oxp9lpj/LXZYabHRJA0IXEP/XNpOvYr5?=
 =?us-ascii?Q?9JEzqGr/zHskqYWQsn/NYpAkWaQYi9mNSUehozwd4loCgzaWsJdwrki6TDmw?=
 =?us-ascii?Q?JjNr/s8IcviNBNxbtyHZ3a9pJUJE0feb/kv2AimXbSh4h5WvtRrCSoT9k3dO?=
 =?us-ascii?Q?NWrrpDGu04grh97kV9vNRHlfFva5euaOAVpzMKhfSdYQaHjbCj/MHB7+gHuI?=
 =?us-ascii?Q?tsxjpoB1gtDtOm2nI+wwcDOQQ3KRduH/eWO9r/e5FoLqNnS7fp9u4bSRD0ba?=
 =?us-ascii?Q?yX0wOgLBgYYgjgrRgMUw1qsQvEClGBq0WV2z/VoxE9KGqywsS8b8KGD3vEAW?=
 =?us-ascii?Q?MMxdlBUu/PjZiRvhzcu5cSCd0Bg255HpGH7pXjjyk8gGmYXP530kecD7vV82?=
 =?us-ascii?Q?+pfhtLkzNrBjKWl7bQnjrdrEV6pJO7Ptk+q71uEIF3ShCUsAfAcYU4Txfke/?=
 =?us-ascii?Q?j99dEU3lo5RZhXogr6DQ6xbf9IGV0fa1pIATWEWbGFMEPmleP65z59NLwBQR?=
 =?us-ascii?Q?n+Ctvi/cFhJgEayFFS37D8enlERB61+BQgLiiHGaH2xvJhxEFjSGvuCIpJiH?=
 =?us-ascii?Q?4ef1WMtddFe9I7I+DSgD3wPbgK9fUKWMf4w/DKM1+ri/Tbvh+W43Om6xl+KK?=
 =?us-ascii?Q?AaGqbG7XvH3tis0Gk4W/eCMK2QsAoKkmLbVuD/OYmNmD298TRrYrJxuHhXj8?=
 =?us-ascii?Q?E6ADCKSCgHxpNhdauQryXK/pEqcqq0pbr0tTLA5cUKBtFbVNN0c9upIj/mh+?=
 =?us-ascii?Q?vgo9qYgyY06sK6vfz+BFennDFgYkqFA+xTNK/5q0k8rHJwaofVNaCl4Y6Zc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc57f6d-78ce-4187-bcb2-08dc47716a04
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 17:32:41.8169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0P220MB0785

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


