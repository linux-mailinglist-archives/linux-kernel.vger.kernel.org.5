Return-Path: <linux-kernel+bounces-78387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC878612CD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD78F1C21B77
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5EF7F46F;
	Fri, 23 Feb 2024 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="R8WydVYV"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2028.outbound.protection.outlook.com [40.92.99.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE9D7AE78;
	Fri, 23 Feb 2024 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695408; cv=fail; b=bbE2CwNx2VxpEYvzfoyPJnl6xgLWbX16I2z2dfFoh9NuryxmbdppA43acbzqvlfYRVcsAtNvD1rogY5zrgTi+i7RSEp6v+2fdIo4zvfSW8x9JVW020T4MkoCjQo+8ODLqUtJNP2wO6xcc1ygFtlRxF+wdewxQfVqc4ssLC16Vd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695408; c=relaxed/simple;
	bh=7ojPixXZE5J9hkTNdeeDDMUaUZBW5I47qRWHMl9a5GU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F7fFtl762SnCkeEKUSOKbg0KYXnw9a1TSUyXl8f5P/3a/va2SFNTvBp30TJFF7nC2Klpstgo6s8PgVyRYpxv24R8buhoVkd+iKEvdyYC9AoLDEaAHsRsmk8KjteOSouidbQHQVaA/4H/4Zz8xiZZ8HZ25onhJ0euhLB35lNMxhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=R8WydVYV; arc=fail smtp.client-ip=40.92.99.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNKscIAzJhqC7d+B8pOU2hvvJm36NIosymgcx943Q2YxvlLvBIiFstLAMwLATfsNzEpx0XgK75iA/h+MSe/RQSW/FpFYJjwmdfTnDLUBYLLJDPVR/IHrWJ0xNpiqnwaVnutxcj1tRcRnDlIXDcjDvX35eEjVaY1H+FrhYScGJ7F/pSpxe4/1R6ppqMtnhqzJ0WESmWd8h/dxB55s1lsyIakaKXOhOM+Nxtks/itByASEhuF1zZxDNTuO12MjvZtXt0TTqgolfmRCEmQFdVppz1Pue9GCxS1a/Q4QfM6lgLsVMuw7JmrgqiUCglVBd4fi2yHnfVJIggO4adAvYnGong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oj3TNpSsWO+FLW0UrdijuaIsFCx6SOHY9wjf1DrxMNc=;
 b=Z/5SwFX3UqhmR5RpROmbeYTx9IpuCtJjBE60Qw76H/4kp+fdYseHNBUnJjeDqr8d9Ih3uMuag7/3is6+da3Xcvqz9DzWQb9xPsUT4X667DTOzKGgqEd7fjudUddk50jbqU/r+x76VXmu79aan/fl/A8t2fNCQYLI/puFINWpHu0wM3N13n48EQLDuFel5N+czxLAtO4KWFxIjQ1ZNypRnJPgiaFHnoeQm3aIOxC8HkqcJPo8z7Wh/wpkOeiTijRS1q1s+LjKCfFo/+Lx/nApmnC+hWheYQ7SvX3FdeeA9nUJKZipC3nYUzpugVXJw8Zy7/GwGgiK3+9vZwdSS1G4fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oj3TNpSsWO+FLW0UrdijuaIsFCx6SOHY9wjf1DrxMNc=;
 b=R8WydVYVshWnMyKnG1jJD3uLgyG2Ef/35f+eJLeSCh/s8PNaE4qGuMgNFc7WzArShxXPU4irDit5Y6Y7H72e0/gazt9aAEU+v3dEFknFNBqkcfuCFGjVqB91RMlKWQJD2fUBVlDUEVufjs6ZxBqtN44NRdz9Ik/7b1M9LRzjxni60RcHd2N+zbpXeOYBbmy5BlVEfMQuBqZWuo+FJJ5Wr5AXVMLyOUpyMH8KEEWTY+wjamE11+ZpzDr5vGZxGBaQqKN4CGQdeeZk8ds47lkJga+TughHZp9kjBSSBvdtVNVhh3M+MPXFe+m8XrXxIpD1TDA84QEinGNswKeRSpkq+w==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYTP286MB3527.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 13:36:44 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ee92:6ce6:9de0:d8e5]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ee92:6ce6:9de0:d8e5%4]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 13:36:44 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-kernel@vger.kernel.org,
	Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] wifi: rtl8xxxu: fix mixed declarations in rtl8xxxu_set_aifs()
Date: Fri, 23 Feb 2024 21:34:32 +0800
Message-ID:
 <TYAP286MB03157A408E0D69F2F6FBD88ABC552@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [JJ6ohtCLTKF55XCxJuoHrUI52SN/l+1MTq6gPg49uyQ=]
X-ClientProxiedBy: PS2PR02CA0082.apcprd02.prod.outlook.com
 (2603:1096:300:5c::22) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID:
 <20240223133432.4502-1-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYTP286MB3527:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe693d2-576f-43a3-dae4-08dc347478f9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EKA9hMSvhak+UZUAduJrzp85heDhjNfwO86au7JtccNndoIf4mZnOSEmhCnHIPvbYmEOefPNOkng6evvgVK6w82hfgqidxgB/3Xt1ZeYfWbQyTAsCIgMQd1kQ27ffmK/0+h9sYdiwpyKDciHVr0LHrmaRzLQ0NEF24lLfcBZdvy0aOXaFVQZ62q5Je0bKV4cEH4Lnr4tDUTL7EYyVgKk0D/MqopvIpGIbjKCKrYWbmHHlrKD8sNaHAOrkGr+QnGW5GSKaB9IaHrjs6s+uE1omV3fz54AYE22SzqcNwhMUYIXEoG5iXbWI3GSDglgn/gLhq1hWqwP+tK+55C8OCyx9HN9R9doe0OJ3H4xymK8sEAS1Z0MWNkhy6aXuNykFJZviJIkRkT5YHQJrmbm2SquRkKYhReb7/ljXtu3JbUw6j2M6qT3QO9TjEj0izvG0XR19WhwHDsHhb7PLZ3HCEwdaNsi4Po0xpaWsSmQk/swDqY/fbzA7uXzhZrBtIXV722IxzOunXbLH2hkm/1Z1DcdppcLwF7l1WzCtTNRxa7HDW1VX0FxzbVJeJcD8LbXY2/Y51m1azX/yZ1nmd73akE5SblRXjNLAcec87N/ZbfZSKqRSAd3DVoCRwG/jDxgJryW
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b3WkjUR9X1dorvYXgijaPkmOINGzYXhACiqUhTkkoyqmxOMUhDMOHCksN/KL?=
 =?us-ascii?Q?PITXbkS+83fCr06g9Wz2WM4mpAdykjHilvfUgimOrV7blYztgzL17FFuyfmc?=
 =?us-ascii?Q?ezwDhpK4fWNrVWHsdtj4pMrTDUPqNAij/jqlmUTc1dKSWKyKP2np2x4UMmvi?=
 =?us-ascii?Q?VCUBlJ0YM4UEJ69U3QXU1rzFHX+4cV54c9iEANYJ3Pvx3Gn/Vr7nQMVZjn40?=
 =?us-ascii?Q?zO5UOTPDQwCKYuBnYGBmxe65x6Pa9BA+rgf4d2yesykcUEvJFz4sEthuo4lI?=
 =?us-ascii?Q?l6rMUvH2luEvTX4nqluqaNK+kdaOudhBAUrjeDda1rinBbrd79kk/YdEWCt4?=
 =?us-ascii?Q?qth2nP4lvCCe192dlWVr4xaX2fBDucOtFAWYy5vbyC+PPgv4vHuD2NhojoAr?=
 =?us-ascii?Q?CFd8/4iql/D/aroK1d+i6mQzJar6NMfx670IHaSfMw5SboE2nxGRiipY115h?=
 =?us-ascii?Q?plFNOCJeYOCbyE5+6UrYkw0Hm5YGaIBoOrzIg7rLgTNlZyjI6IOVDBnCy+6P?=
 =?us-ascii?Q?KVbmwtfTwhMXPzwERyyNHQ6qls9m5BzKszdwRE4EZykcgWgqCuaIRjGMhTQo?=
 =?us-ascii?Q?AUDq1lEzzJ+XHzM2mGX2X/VyKN6sAzfw287RIrA96aAZdCfKpifdt0apfGV/?=
 =?us-ascii?Q?sj7mWdhWP28hB9HGMdOaOOtXNy2pRGdrY8P7iTrjF4qz/R63x3/m2D/youH+?=
 =?us-ascii?Q?kDQ1sj4ZB+Wqcbi6DQL4vmpFci4TWdAOpy1csJUXw+/56VtX8Al1fYeLDdqE?=
 =?us-ascii?Q?Swn7SCF9F/uZLP+fD6NM9jYpcEAN99zSVcmkRu+dFM0Pmey764hNHCXhYyhm?=
 =?us-ascii?Q?lC0K/nIe/LBacwRzkPz7XB4uaXqBcCX+Tp1oeVjJOGVW+mied0+1ucwdyRAs?=
 =?us-ascii?Q?XHvVld3mQGjilp9obW0rhbGVBl34l+Df/AyTHBSp/a08K+0VIaT7Occz2k9Y?=
 =?us-ascii?Q?oBuXp9EwCgDEYAIWjsi3HpKBjU9/ArAZ1qDpuBokpc5fUyWFwRF+MdtIbYTb?=
 =?us-ascii?Q?xtbDHpvAZjMQmbfeoOqRXpX6XJ78hPXZ1I0DbHWgKqbJr1ayDh8JFkPLgMpI?=
 =?us-ascii?Q?orAmfdkqhhe6wWGmDCKLwg6LSPcWxRy/3UvDrbvjrzIO11987Gdo+kbemYsc?=
 =?us-ascii?Q?GcTUzy93QNXSissu2p+oBqX22ewt/uc93faPtJ7ebctfJiHPpQuooTEJj6wL?=
 =?us-ascii?Q?C70mmjET7IVCZZZGUkqVMUYwHXmr1Gfodvwq5rJaF6udRZb9xXH8HPy3slxb?=
 =?us-ascii?Q?k6oR8gCKDR2WbCFVT+lM?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe693d2-576f-43a3-dae4-08dc347478f9
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 13:36:44.4228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB3527

Moving struct ieee80211_sta *sta variable definition to the front
of the code to fix the ISO C90 forbids mixed declarations and code
warning.

Fixes: 43532c050f8e ("wifi: rtl8xxxu: support multiple interfaces in set_aifs()")
Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 6dfa060..6c03433 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4919,11 +4919,11 @@ static void rtl8xxxu_set_aifs(struct rtl8xxxu_priv *priv, u8 slot_time)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(priv->vifs); i++) {
+		struct ieee80211_sta *sta;
+
 		if (!priv->vifs[i])
 			continue;
 
-		struct ieee80211_sta *sta;
-
 		rcu_read_lock();
 		sta = ieee80211_find_sta(priv->vifs[i], priv->vifs[i]->bss_conf.bssid);
 		if (sta)
-- 
2.39.2


