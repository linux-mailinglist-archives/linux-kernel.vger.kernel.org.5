Return-Path: <linux-kernel+bounces-90514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F530870077
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 012D6B218E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C695A39AD0;
	Mon,  4 Mar 2024 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="c5l7Lqdt"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01olkn2089.outbound.protection.outlook.com [40.92.66.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C2B38DF5;
	Mon,  4 Mar 2024 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.66.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709552032; cv=fail; b=uifFooWcuWLtJ5uCeIN7/jHLYANi4gtsolNJmBIIJypcSPgFml3kpnbLCYNFzkPbk17pqv+SSZTpWBpaQBLtWJww3C59ozVC3Dvv/mHVyjOJF4qB1J2/wEAIdZqbYa79wf+Ac1YYTZoBil3dloS3jFuBcH5/bRiAMNrnl2160wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709552032; c=relaxed/simple;
	bh=+It/hXI6eVCvvWeLqENSF6crpP/sWxmBiUIYWQbNfEc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UI+cv59rhXPT6F5yiHShtraA8Sc5CyPDvXMtCOwgzY8xZLx6OSyGtWzDF2NL7cWmjVpgPeM/Nb0wJwwpI3pqQWcyNyjiymGqgF/da6RNh6hocZ9qC5vztDWAXvu6KBBd6UiI6/fOeTE/MwYI/QunDqcWNAsArvf2NzbdQZcl67c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=c5l7Lqdt; arc=fail smtp.client-ip=40.92.66.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9qmwsrqIXwneBvHhHCO6jeZXsW/AUyGRedT8jwMDFHkyR+uvPDHAan7sj1FCv1FiyrWAq/AjVJ98HnCXYkOqZGqZaUNTd/vo38vmDHePB6lNpL0H4cAPrd8kQV+qjwwe9YvtsuIiT74/Gmlo3G+r3V6HGHmnbFWS9CQ+O9CxFiKTVv7QEF+EPpGKpd7KDMYukjMtIvZ0QamtBqoXgq359zV5/GJCgtsmD3vpeQfP6HdarEWs1lKvInZFDauvRW6CjK3RZGebwLSiWnh8jaFJtsCYQPGb6/7wWcl+mhTy3hh3HbvSQH3+9Kn5IEzve3GVo9TY0cYMEajkM5RcOEcOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIx8m254gb0gnPms+182+fGXVvxCQymsyDXC9FaNnDk=;
 b=YpVxapzf6a0orUDt5jV1JjSh9nkzHDVs7PFLihhTB/Nk/OBEcEXSAUBAuoR06BRHA+7dA/N8MucGKG4hBUY6wBF9SpS86Gr+gg1blXQbuQQQMQlQwUinfcR5xzLQmsVxEao5avKd9ViBmhJIoFw+tFyMnCz8RpLcpSgSyfzUjdN+WxPdi/m322Ngp6vPtgrjBzBmQH2+QjDbnMt0wEEqsja129d0A4nhcwHUfVIEiVfRKHgca3bG66jgG93XOFrEOS0Lx2G8yEn1J5sdbhc7+23LssH2uZZTaC35ktQNsKeKJJxu7m5sMkTTEWKpVYkWTEXCuCN6BOovCGznT1xbXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIx8m254gb0gnPms+182+fGXVvxCQymsyDXC9FaNnDk=;
 b=c5l7LqdtlE5YonZNsVXWcJdO7yHTOGE7Y/VEPT54uTb3HB0YfatjWzutyLw1x59wr7e4snTRB2YHE4OtDTAf5yaDWHkFr1YPS3UtfsLJiK9vNRlM32OgEWQ9b2Yhhx+X+ZxgVFd5PHQ1vROSOUXVFeVsqd41tn3L2BpqxZDa3sF/7foRoSwusKZTAL/aXARxzD7t8zBsBeqd14LtMBEbGn/KUpEHHLTQ0+eNnE7htpqXnxzq1h0ySdH5epFK3DWxl4Ksr4I4sbrTTVRORYVFsxF232Mej/Q+kJHGTYlacAceXxxpduUR6f5hRQBJURWuf/FzbsbVr800wkQzGNQ3Aw==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by GVXPR03MB10334.eurprd03.prod.outlook.com (2603:10a6:150:158::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Mon, 4 Mar
 2024 11:33:47 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18%7]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 11:33:47 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] inet: Add getsockopt support for IP_ROUTER_ALERT and IPV6_ROUTER_ALERT
Date: Mon,  4 Mar 2024 11:32:08 +0000
Message-ID:
 <AM6PR03MB5848BD89913195FF68DC625599232@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [X1tM+OX0hTGFrCWK0mF/AugkuqlPIK1H]
X-ClientProxiedBy: LO4P123CA0626.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::11) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240304113208.7183-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|GVXPR03MB10334:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3ebc95-b674-4182-03d0-08dc3c3ef4ec
X-MS-Exchange-SLBlob-MailProps:
	ZILSnhm0P3mQ8fCRM+tO9EsyYupD3QvmOYaWEI0ctpypiaxkCq9TC6si5pMnGK1KBwnnbJ2MQ99YYhAESM4FQsN+ZOHz9OkYkZf7VSz9YmN+FzjyWTY12+C3V30n5RzRvk9rYlNM9meN1uh0+sRBqv8ZJffkeRSmJ5yCt7hyfJbxaC1w7lOsv+aKqiABZgsmlAfBxDyxM7VzwU2kmz0e0QGBKgV1DEa1OnnYXQucUDToRVJQQbG/cLvCGLcsKeJvwntCtIj31h9njOHjsDUJHp4DgbVNdl2eZ5kGfKpoubY4O6hYfFj7z5zkgnQD3LtI38GhRdAGE6AlZlvjvBiaT7rg9He+GdaW4LACM/O5Dx7zW25IjEZ2BarJ/KVLy/57LaSlrefixIdZZfxwjZOtyuKm9fJXQJ7/y/lTQ7RfKOYd8F+gvD0frXTRBR+u5E2KlvUFqxwRaBAZNZBugr3RBVItXQHWaSZ14hrloEK67r6RCa5+RaG/T6el5tFtAhL2JeHewWHBG07CZWhsJd5bTG5TUCsInY61FP5cKYnb9ePSb2NigCAckk4MS0DLQEjh7ZhE+6FJl7OBTisFNOLYaDXyfkY0EMlv4YajuM/C9r4n+qeK6ZwoXLAOKp9Bl+kkooxxwzq5h8D+Rw2Gq1CCKtYMaekVHcvHFpwxaNMpKyle2FQWdVvgRUph9YbmoQyqZZ0CRC0KgVnwIJjloCC6WuowvszVrcQTzsS1Cv6jbziOpJ+NzSqlUGpk0a++FAnEEwuvCCfB8gcIPdV+fstzgfc9RVtiGE9x
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5xdP5+KhdUb2PTCvUJMhx3KP/+YpGNsOwA4R20H+qkT0bzJGfBiRiWiKEHWvYHuTfE5f7aHkegwaVZ7DS4AAkyGt55ng+9gu7GIk5atuIQXEZrfgXZ27NMRSKZMouZoIMq6W/hcUqxIh3BoOYq/8joxMXdaP9ZVNXvp+kqPjx5CL19YB3p82O1YaYc2ArbbgkVsQ7x0+YiWWnsObhZkfmZsbpbqCygpslgtsAcEM5R9CXD9ImTLkbzCY1vvwqQ+KCSPEEsYf2+BsWvc8aj3Ys0xclbQUwLm/KXoOHDKFVCFSGHbjc77STLb6ZdGEaB1tVu55YIv+HYqXk5olTlmHh94ZFq564JkjuZveZwgdfZLs/RInPQ1zZ8FktmJDkFi9rCsbvUu65yCTLF6iM2kct08qvxpaUY+uZT2EB6A69FxbN9g9VekiUp+/JppUPB6dg8VyKFDf5QP+FamYF+n8xF40mg8CBZ6fyapeecdv4KIvWnPQRA/jdQAPht8yVHD/H4fjw4j1Sjy94TKIqfge23KFVL5SRvNMWRM9be+Kvf5AQM5QLeKTzov5SLmbf9pX
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s1HXWuY2v6VFfHVN8aSKkj0/nPqzMGBkSVWOp5ipsmkgl60wDf3/aqPAsBU3?=
 =?us-ascii?Q?k+9R0/k0ShrBUBzuBbCLb+I6ycwA7FounPJcFXgMlDARX0lGFuBeqkzZFBXe?=
 =?us-ascii?Q?dqrfXkcNtn9e15TjqLN6CMvI3xyxzieUg9jvHputc2S6N2YQ8FKWKShedYig?=
 =?us-ascii?Q?oGFkyrP/2bTooeAIc2NEmSzU2sdntMRqoevdeyeeYMnJzwzPCOWbQwFKoPP9?=
 =?us-ascii?Q?20p3MffMGx6dXTHlLg1hP9b4KkjAzuJqRSDPD3b8tjrbvj19pA7i4Q9TdOiJ?=
 =?us-ascii?Q?FjR44yzwU0NwvEY0vx8efCqyeX8JxDRRcYh5aiKnFeLv6CNQ8SgK0kVl/CIZ?=
 =?us-ascii?Q?td1VNly0RJEqn8DYfaMASYyEL+rUih7nP780VqtAI1copsSJRD9WscO8y/RX?=
 =?us-ascii?Q?/+ijtauoq/dNdTAUBuSR7s6gG7gAJAjbbeKTolYTO+Lb96GELc84PUv9LW6k?=
 =?us-ascii?Q?anUKniVkh84P0j4efmLvPTSbUeV2y2Zcd0GJIRUsIQXJOhTaRjXaTN008KOt?=
 =?us-ascii?Q?KJY1uWfgMl8EAyV9te9kkGtVLNjo5mF3inscajTxu4YRI6ZtJ08k4hrNMxUV?=
 =?us-ascii?Q?hBPg/lVStTF7JnjeAzvykr9gXLi3tH2nASZ+Uphfc/fzSttg983JwK6z5iGI?=
 =?us-ascii?Q?PhsV1IMGN6/sQ3BHfcwztqJvCdjdnTICdu6eZpiYHyOGTwDi0oWFE0Qtdf2I?=
 =?us-ascii?Q?Fljv7xJc2IzQdLFY5nr2BcWDCloq5JuzZtTxMos0r+X1MB1y3NA+r6I2nDYl?=
 =?us-ascii?Q?IZtvBGzFO0Pc/5QdkUGExXBKuxjvf8UC2P2pg6XNgWmvJ+LmoyIk2QaYDyWR?=
 =?us-ascii?Q?R4TeJnacosZf44ENeLjQa/rdnTr2qN2pEBH+W3jlOWTPgWyhtL5xRu8PDJsI?=
 =?us-ascii?Q?EUn7lF1uLbhczq0yaf3V69VNMBnpJGi88G+x1Gq2X6jv0Pk5Muu7LJC55vks?=
 =?us-ascii?Q?cDcFrBcFIk0Zunfdp7FGFj81opdWxr9q47RrTnzlbX965OIpSdx9dVeM0fmu?=
 =?us-ascii?Q?4tm59XsgL0onxBBuhAWLkDzFaAs9YakePphXq0y6RGZom5hup2+un4xuYu0U?=
 =?us-ascii?Q?BbzFi9kEBY/ZrJdUI2MyZDlIuD2SBKhxAZWV6ZZ/BHllBav4HQEDz1ELJ08n?=
 =?us-ascii?Q?Y8kol1ikd5oNfy8P+xoqMhsT6Pe4UX1cYqsIHIJZ+G6cV9R/XwmCk9t2Ttz2?=
 =?us-ascii?Q?zn5KWzmCbZorlQgmkGCK+8h8/ZkIwXtDiTx0GuqgBen/U6yPSRFQmMFbRaPO?=
 =?us-ascii?Q?JA1wj3Ml1/DSKI5xrzHV?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3ebc95-b674-4182-03d0-08dc3c3ef4ec
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 11:33:47.8359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB10334

Currently getsockopt does not support IP_ROUTER_ALERT and
IPV6_ROUTER_ALERT, and we are unable to get the values of these two
socket options through getsockopt.

This patch adds getsockopt support for IP_ROUTER_ALERT and
IPV6_ROUTER_ALERT.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 include/net/inet_sock.h  |  1 +
 net/ipv4/ip_sockglue.c   | 13 ++++++++++---
 net/ipv6/ipv6_sockglue.c |  6 ++++++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index d94c242eb3ed..f9ddd47dc4f8 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -274,6 +274,7 @@ enum {
 	INET_FLAGS_REPFLOW	= 27,
 	INET_FLAGS_RTALERT_ISOLATE = 28,
 	INET_FLAGS_SNDFLOW	= 29,
+	INET_FLAGS_RTALERT	= 30,
 };
 
 /* cmsg flags for inet */
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 21d2ffa919e9..cf377377b52d 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -894,7 +894,7 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 {
 	struct inet_sock *inet = inet_sk(sk);
 	struct net *net = sock_net(sk);
-	int val = 0, err;
+	int val = 0, err, retv;
 	bool needs_rtnl = setsockopt_needs_rtnl(optname);
 
 	switch (optname) {
@@ -938,8 +938,12 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 
 	/* If optlen==0, it is equivalent to val == 0 */
 
-	if (optname == IP_ROUTER_ALERT)
-		return ip_ra_control(sk, val ? 1 : 0, NULL);
+	if (optname == IP_ROUTER_ALERT) {
+		retv = ip_ra_control(sk, val ? 1 : 0, NULL);
+		if (retv == 0)
+			inet_assign_bit(RTALERT, sk, val);
+		return retv;
+	}
 	if (ip_mroute_opt(optname))
 		return ip_mroute_setsockopt(sk, optname, optval, optlen);
 
@@ -1575,6 +1579,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_BIND_ADDRESS_NO_PORT:
 		val = inet_test_bit(BIND_ADDRESS_NO_PORT, sk);
 		goto copyval;
+	case IP_ROUTER_ALERT:
+		val = inet_test_bit(RTALERT, sk);
+		goto copyval;
 	case IP_TTL:
 		val = READ_ONCE(inet->uc_ttl);
 		if (val < 0)
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 56c3c467f9de..9f15664fa607 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -948,6 +948,8 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		if (optlen < sizeof(int))
 			goto e_inval;
 		retv = ip6_ra_control(sk, val);
+		if (retv == 0)
+			inet6_assign_bit(RTALERT, sk, valbool);
 		break;
 	case IPV6_FLOWLABEL_MGR:
 		retv = ipv6_flowlabel_opt(sk, optval, optlen);
@@ -1445,6 +1447,10 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		val = np->rxopt.bits.recvfragsize;
 		break;
 
+	case IPV6_ROUTER_ALERT:
+		val = inet6_test_bit(RTALERT, sk);
+		break;
+
 	case IPV6_ROUTER_ALERT_ISOLATE:
 		val = inet6_test_bit(RTALERT_ISOLATE, sk);
 		break;
-- 
2.39.2


