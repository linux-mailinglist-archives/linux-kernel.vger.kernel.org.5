Return-Path: <linux-kernel+bounces-96940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A885876369
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8071F21EAD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872145644E;
	Fri,  8 Mar 2024 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Vv2UMVph"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2067.outbound.protection.outlook.com [40.92.91.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93015578A;
	Fri,  8 Mar 2024 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897847; cv=fail; b=H6Sz7dHEf5046NIMdM7y3T8BJJGXeVPtVCpDX4UNMgideYcqIR2DtA7N8X6Y6WKT/82t8/pQAlrotuFOd8SpANIP59VTymIdxKBQzvWCWLNsmr44I3GXp8OkIX3Fq7JU8QkuRRc5b/2JASOBfGBrxS6mWtWKTjXBnDXzT6EWqhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897847; c=relaxed/simple;
	bh=5W8OQsTkb8zlsQtLe8dbiSIO5acTornZARWuIWrGn08=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ddi6pTeCHmTzYbvWGA4Mgl4B5Ef5PLksszA20nSBaGY6f5fImlBXGD5J4lCTAmlbjFAVjNeemv+ObK805GGeqqk0si0M2uESH4/tVF2zz2IEOk5M8TuqJButTdOCR+DXCbnRYHTAvjNsi6JemyT2gdbyP2Kgc86duKvJ/WMz7Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Vv2UMVph; arc=fail smtp.client-ip=40.92.91.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiSX6wHNlh/tEJEIztC7Tsan90A6Vg6W/wtAeF2ZoKKmLa37UgGm19Q4kD2S9cTAQd8npYoXwW+lahl9jm8boBUxh8v6wuPeiTl659P5hSztsgnIBWwNemYiYgJ9brWSTL+zt/JgrmDsaNsocxKvL0QOzymrK04ktro5bXMXscM2ngMmSvaVWI9aTlvnhwuzi0ZUNajtDPXTtSr0e44Yr25AlnB4MgTTPGAnOusGIEF4X+BpM6ZRF4YAzIeVltNFQQ+qlN+TZEj4LUF6kVrW+eJqiHR2XPqMjxe5TimGt1ii3Q9eS5QZUlYoJx6SXND1kjdM/nqAcgvIByJAGccl+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZPjAIqUphboDKkP5eYqFo5/dKb7IepaomOF1h29P14=;
 b=AVcTwUpUOKCje3fR9Qh/pDCO/nY7JaBlnZOJQZJTlXasGd9vPES4S0sd0ij45UcGFj0pF9ynXmyYn9EZL3F2RfSqlv0dwTwufeTMTN8+rn3nDA8YJa43aIS5tJhtC2zN1IMrlhEjWb7KH6FWxRAsg9NqGOYnv4NUmxO8Ha5qxLLmHxl5blcx+CM5d2WFjmbHgog683eMqsHD1PpSj+ZuRX3cT8/YJdlhgAyHpCRkCf+u9gBlRQ62X+TmX8kTCVjCMw61A0lA2hESxSa6rbI8d3a9FSu6v4NuvKmyjOhereeEOmBfIBOk9UzNDD+qRRPOTzp2ABUqn1mCNbyDxfxS7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZPjAIqUphboDKkP5eYqFo5/dKb7IepaomOF1h29P14=;
 b=Vv2UMVphRPmn/zyUN0aSRdc9NQfqZzaf++W8b6fKCN7QEDQPkxQ59Xib8qnTARizdUiwFrQrAWl9iwv9TVE+A7SCiVNMfcrg3l/aGvHanx+7jJrT234xsPhjdL828LpSHRl51oYHrfW/Lms+6T1Cx3TCglUCuoMBoHFGqHiOcD5KBMNXl4WQP6TkptkPAIzRZfwp4o8N5pBZuAiSI0Bq6yWkI+kFkG+3ShH/OL3+C4wV7go0yoz0rmcLi3LSaoBpswUIyQrtq4+GXYLFhO5pJNHI5Lx44uM1b2B2Tqtwou1MsBYX1xVRJcUTDV4JyjzR4lYQUokHCAQ1gD/H3G+8AQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AM7PR03MB6309.eurprd03.prod.outlook.com (2603:10a6:20b:131::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 11:37:23 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18%7]) with mapi id 15.20.7362.028; Fri, 8 Mar 2024
 11:37:23 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Liam.Howlett@oracle.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net/netlink: Add getsockopt support for NETLINK_LISTEN_ALL_NSID
Date: Fri,  8 Mar 2024 11:33:04 +0000
Message-ID:
 <AM6PR03MB58482322B7B335308DA56FE599272@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [JA9sT5KNrvqKZHaox87B830FOKZqk6E/]
X-ClientProxiedBy: LO4P123CA0111.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::8) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240308113304.12061-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AM7PR03MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 264ea03d-b2f2-4bc8-6a50-08dc3f641f1b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nhzAW36gHmOkEbNg2oKhDSFeQZ/i/bXWKLdToFjxkxuyoWI32soe9Lm03dBBFzwpgNjwddG7Gq/LsXTsJr6OOwUl0qufcEDS4cAKM2kZNfqgdOP54agrXrGea7YSo2hv4dv28IF4FK35pi5d56h2pdlyBaiE0OEP4GbKsFnXqxZvFJgPl72dnqEZxMPFIKPjcBM+a+dALOfuQrCngkbs2Yx/MBPUE+u5oeMPIDfDqXyRN8eVlv47utw8nRgZD3fn2ja2rlgYKFn+kpN3EcAW8XAu+716AFkmRZN//oO8/SPveXKM+KIh9yj/jBhfXsi2iH7tGeDbh1PmVbXQVNHzjlr0JZTXklVJS5789yTaHpIdtt04bcnrA6AzbTJZ3tjU7mjtqvKd3DUUybQBoOC3lSfka7J5Y9aQnfu0d2uXdLkU16LgapVEaVgZAZz6STRtNSpTZx6h2K8f29xF1vGWYo0SptwHZyjDr5t02jsW1gVb/hWXSsHCTenLVWgamXALkNLDEQgPo7sve+EWYLijD0V8U6G0GbsifNdELw/ji4U132bMYQxJvw9BkCrDi0SY
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?912d1s8w57kiceH+niu2NFreFRPUKtBnfThF111yNW4cSbVubR9khLC5hNWf?=
 =?us-ascii?Q?mWiquniLovu1apxzIvGGAJ2S/bcCbchw0SNl6eTRMmfdRvsfSI7oBmHWvF/+?=
 =?us-ascii?Q?k/A0OwIXd9t+rZakai9AA33oDXidBlZpvwpEpwuDgHPz6lNKWX7xU/8xhBsh?=
 =?us-ascii?Q?WormD6ch+kk/Fs+WT5ajiTohNufRfN7Xk05EC19ol6o21rXy4RjSonNe3fm0?=
 =?us-ascii?Q?Ddis78Tn+gJcPJD5MCksl4MlM8/ccs20z4Y+d3XtA/2bnqqS2OEia/Q7Mx/M?=
 =?us-ascii?Q?oZXjsUyFvs9S8KSLRuEQHfXsjLAybA63wnvWWPeCubIkE4Cn6NA4A7DQiRWs?=
 =?us-ascii?Q?1wG4ipGWXlPkodHfgzMEPEe/edNU55GtmroYtf8hP5Qf7MDAZOA6RPS/QIoF?=
 =?us-ascii?Q?fzh7uji3Elxhk2A/d3HUfETihKZ9TB0JNQqMomgr/QYzob+MOspvwi8ihyoJ?=
 =?us-ascii?Q?dTAJqLm0Ap6uHKHadL+Vnp5MlRV6EzvuQn6dGkfEIlurad1CMV1B0LTvzJ5o?=
 =?us-ascii?Q?7kww2DSwaS2gILYiu8SF7svrs2CV40gC+hQkklcVjkrZLvfSYuJKWLBTcOtW?=
 =?us-ascii?Q?HR6rT6JrlEWkJ0cA2p5kahlRw/58yHhD64RIz6ac1s+wdvi09vVvHVsjiM2q?=
 =?us-ascii?Q?KhApkJ7A7kbYbZ+hEas+hyv+H8NEiwT9ZtelvlmJalWfgbqKu0LIZ2A6d0Ss?=
 =?us-ascii?Q?wIP1QKuVu1HrgZf+dRp0UO6DfelVjVJVxR3Ec9t7J7ABQ7/RH+RbAJ8p0ZAL?=
 =?us-ascii?Q?cCf+IlOoRnsHkjVGNgwa55WQaoaYk5YwUPvap5xsZo6VhZa/5pvqp8fyXNpK?=
 =?us-ascii?Q?KdBQaOZdV9nf13jtheVhKFjPKar/ZofR8k4lVxlwi+Eqbg/1m3SzvGpyJ5D6?=
 =?us-ascii?Q?cYClokB+VR8r1toL1iRia2QphwINZQv/cjEX7IkjKqrqem7UCUKu/KCH6Cdr?=
 =?us-ascii?Q?uC8gVsqTLpyYYZ4EIWkl4RfjWMEHpxb7D4UJEfMmuhvbCC0y4ZRLmSaB+vW9?=
 =?us-ascii?Q?hQaPGhPDTPk39i+7x0ZOiwTDwNwXb+J4Y7GZueWsrGE33/5oa/eH++Uj/euJ?=
 =?us-ascii?Q?/IhOcb7v2cmfnrBpor5O3SGCYZv9uWo35OW31BTH/iKI9HdGuC2ujEcIALnM?=
 =?us-ascii?Q?BgV5M+lcclmeKwC371p/eMOM5rtZPZNczkGdXV/ul4iXU/ZIVs7dKBvoEZmL?=
 =?us-ascii?Q?l+VDrIKxDrsHq4n7U0fJ7Rx11VMM8cibnyETMEJT4jaJ7+iUhZNeUvVOGe1Z?=
 =?us-ascii?Q?C1YaNNKfZgwKrVMLBDJ2?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 264ea03d-b2f2-4bc8-6a50-08dc3f641f1b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 11:37:23.3006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6309

Currently getsockopt does not support NETLINK_LISTEN_ALL_NSID,
and we are unable to get the value of NETLINK_LISTEN_ALL_NSID
socket option through getsockopt.

This patch adds getsockopt support for NETLINK_LISTEN_ALL_NSID.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 net/netlink/af_netlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index da846212fb9b..7554803218a2 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1773,6 +1773,9 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
 		netlink_unlock_table();
 		return err;
 	}
+	case NETLINK_LISTEN_ALL_NSID:
+		flag = NETLINK_F_LISTEN_ALL_NSID;
+		break;
 	case NETLINK_CAP_ACK:
 		flag = NETLINK_F_CAP_ACK;
 		break;
-- 
2.39.2


