Return-Path: <linux-kernel+bounces-96932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 920D187634E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6CF1F2197D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBFC55E62;
	Fri,  8 Mar 2024 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AQU+K6Xo"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2105.outbound.protection.outlook.com [40.92.75.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBED55E57;
	Fri,  8 Mar 2024 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.75.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897209; cv=fail; b=dzT3QGbaUWWN39nRKhfwIHhoVzqvEIXMaTgPSFfsig9RtzYyXdOOnAPqcsmqlR0hscZziX4wCBpnDfJaNU4skn3Lhk7O9PEXwvqXM9ZFY40O9WSPN1cl6zDVCLTu12Rkgz1u98o+36h+Uet46Jc0E0yBdugN0hJHgK+kfhONROI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897209; c=relaxed/simple;
	bh=qC6cBhZ4WeO0B41SMD3bU4lFXl8euGv9dCxN1OrsRZc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LMqKUv/9bviA3onm6x/5+YjP0NNdXcYS3ZHr/D8bYVcCzY2ELsLNIenoSsZC8yUXbz4gtgwO4ybKotTwbrwidjr37Y1nKMumB6+XWI1FzaaXhJ8+a319Zg7uWzK0KXx4v1j9UYXW2UgpZ+uJ7F+rv7IW8p2moWyYGtyzfa7lVcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AQU+K6Xo; arc=fail smtp.client-ip=40.92.75.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8UL1T3QE9ArH+ZCip3p9ONGnZmkercG3Z6DcvQgDQdQCIPTNk1QN+EmlwN/BzHwciUs6rvcXbkakWWEcVCXr8ei1PjoPjFyoKEUQclRtm2wAOdWd/tD5ZasRt7Msl7Qgf8wfRJTy2CrLW5EIiGNObFNZvtKD9KzB4QCpkatcSuKHSM3fPypXewgJ1XB1hFzmiL3ivWwTki/3DMctZlIy3CGpMiGqzHIjc+bYpMXrpwq9hsMaM8rPjVgUJbA4AtAuVIthNjB3kBaCHqFv9o1Ykhau9+p3WKEZz9KLM09k6FBn3NG4jEUSdgxORrRcWyH9YFWArUT0ENPIcptZNEbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8/0ntTErBjeWs4Yi3udrt3+cvfB12DnFxeDyZXmT1A=;
 b=aUdCHCk3yJfQFwjyyGtuXm5BKWoxXTN7H/K5N0K2pZGOA9534o9bPDSAXMrTqHV+ckdqAjVeKGrnSUsHv/1/BpXPkFsw3w1mWpIRxLIl0gBoS8FJUBYAcgjHoGfSGRS+QvPEjv+Yg3Xdgy3jdQVJGonaQ8s5SJQpDNhJFTwdZxEAtlc1IEl+otXzvNLqRpEuL86rJyzCE3wEnR2PgXagAKwxq56xDlME6wAXZ3NhbnABUj1dqeKlChUAflgkUjnrCoI+E4OmdkNONbqhrbJ5sBvzcm/Dx7Gygz1/eDT8YL4MF3PfHUXHbJs0Y6gKSyex/1rV2yXAFlJc0Btcvqt76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8/0ntTErBjeWs4Yi3udrt3+cvfB12DnFxeDyZXmT1A=;
 b=AQU+K6XofQBBcqwu4As+obWkIgjwlwc/7aCnpEgjmAgiO8aJ/UwExauJBRqulbpB8fmbQIreLcRVzEBQbaB6wOSNyNzJh7CnSo2yKpMGL5wwQ+V2QTvwRe1laHX0K0Q1nOTi+yXEiqYZrW9pK3dzmoShtYpx2INyWIWt+RDE2zQsDu+Xz4JbqnAt1HCcRFQJ5qS61n4LGgSUWIby+2i1B1zP4YfVH8BzmCHU9z4psUVpms7T6DN7AmypoNIavJk0r3CHy3ZCUhv4mz1QwobwKU1SVlyNP+Fbt9ZaOddcH8FWdEPSgMXhVLgVCzKO46Ce1hjflBxQb2Bon+Mdx84ajA==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by DU5PR03MB10392.eurprd03.prod.outlook.com (2603:10a6:10:527::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 11:26:44 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18%7]) with mapi id 15.20.7362.028; Fri, 8 Mar 2024
 11:26:44 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net/packet: Add getsockopt support for PACKET_COPY_THRESH
Date: Fri,  8 Mar 2024 11:23:29 +0000
Message-ID:
 <AM6PR03MB5848595A20BB5D958C2D9DE299272@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [XSmGukAVwFwjaBjnpYPhmT/xB5qZDWuc]
X-ClientProxiedBy: LO4P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::23) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240308112329.10826-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|DU5PR03MB10392:EE_
X-MS-Office365-Filtering-Correlation-Id: e321d628-6c94-4a00-b5a9-08dc3f62a211
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c1B3w5QIAR4xaDegrPDc+kFKSzt61VKVd4LhVmTi/SlEOKmbF9nNMyH9NjUCFHzEwB2R+E2hMJQkzTBc/oCm8II3qSfnXfB/fcAYcmNUzvXBuAyyluyvxa2u+N/Q7SaYgiV51AAlouKiqDSuIJT6ywzdLjwfdNctKgVwrWcvv0Iidr/JIjCl1qCtrG0Lbw6QO505f81MyS18GTTdmpEcosJLvBNcEJxmQbXAgUoX+EG47SSckdYTOrJH18x826Ml4Z5s4udwIUrWUjScuL/bcsKpP1H5j5k4N79lwuoav7bQdNuhWVlB9Z0x+C3eawlZXWUx8EfYP1+bRmI3Wnxg9yQpzx0UA8pWxBME1sAAVEztLgoFIH1w/IvLYSAVPkAh/JeNnzfTanWxEOPKjzf/RGqTIbP+Wxs6qcVQW7oo7wmBDvj9gGpiHW3VGRWYi4r5NJ0j15GeOdZNSCN78oNGp812I3LNPjkrj78nO1XfsBSgAduBPuQWCCmY/vmHFb4p/puVjRPlOu1pUiZ0IiqBC2VaYns8icIfh3XGgI1eUxS3oEFnKoLEg0Go4CpU2WWb
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fq3syZybfEhf3vPHg3a4ueILsDPVbPPnEZMID24OyESEBJHaBBnKdU1vl9DH?=
 =?us-ascii?Q?kFxcVX2v51sdq6OaDQtmXkZj1OJj6YDQKQIMVrWIxLZwPpqJLxn7gtiLd/Cg?=
 =?us-ascii?Q?xMf+1vTJxpwJqGO+fCK8v62e3CKT3FtxOp8fsBnkHAOtd1TBCTYLThIKfplZ?=
 =?us-ascii?Q?4F3exyuXYwloKvnpEZj8E3cIWYZOdpGMWmnTdfmXha5ZXmQp0bbxc2DfwSd8?=
 =?us-ascii?Q?E2GYrNVN0kGTu+foSK8O4SYuPgFDGdKUG3NV5yZaTHbX04OLvU4mUZKtAXB1?=
 =?us-ascii?Q?l5V8DOdQr6h4kMyjfsYmm3Ho4Y10VYbyC4t0xr79mZoydcenMwm84yxIlHVo?=
 =?us-ascii?Q?p0HEMRZV9P94RNIC7KK46Q15c2uvoXjfkQlUWUHMZ+dej1RkIlFwwkq0tGKV?=
 =?us-ascii?Q?gS1oqD0C8PJ7bGVaQuqsF0iH6o9XUZflSjg0kua9vesUoKihMLwYpiW3Eisn?=
 =?us-ascii?Q?gOuYEQzILZo/uJ4JDTsaliVMGEVDMCD2Ti78g6wlC+1SL2O+wnm5ydYg3esk?=
 =?us-ascii?Q?vxAwJ4DPlMsHDQNvgb+GzC2kmubl507umIU4RI1R/FQdMnfMdR5UCpYJsdd9?=
 =?us-ascii?Q?B7rMaRFFTsaiDvjYyoOrgQxhECS747zJQAFHB1r0AStfP9AktACGhTs3Od4z?=
 =?us-ascii?Q?ID7M6nzvKzNNUrKG7g3QH6hANpxf1yNdbovdbhGPY1q33tZuqUHXQ2C6h3IW?=
 =?us-ascii?Q?Y3mmOa9VHKzoa6oBY2Nf5+iwLoBweaVh8d9pvu/5oyXi2h6VLUeBxa+eZ4W0?=
 =?us-ascii?Q?OkpfaiAptPegh3hFtuVy5+EjQmkVCuJfNSweekRhHtEhQgN41yvx0Ns35H+J?=
 =?us-ascii?Q?bBJGz8oftb7yzqqnDLeWcdHWeKdyJmvUXNf16E3OeCWgexVt2uWvwghEnZzl?=
 =?us-ascii?Q?BiDV0shAHnh0eXfFKipfTlM66SFO6Ik8Q/hAIHU6fQDi9/QDUc0OA9133pbt?=
 =?us-ascii?Q?q1KB9cL6JsFul7eBgeoVJgtRUPwDcmFRUaqxmGR8MxDEbPlel9Egl1p9cux2?=
 =?us-ascii?Q?PuK8pDqoaybO//m+2VXfRm732ahaBcLOOzDAt9AI5VfG01a412qInMMA9udX?=
 =?us-ascii?Q?iHPvA0pPYCD3k+FUsYnoEVGMH3BeUmoetRtscFBtpHUJ1GBVGO+ow0DSyutw?=
 =?us-ascii?Q?KSosH3d9U+C7d6gtRLRmrOodrpqeC/r2ciR+zUjnMYaZ/qxUAKCfxkYn4Nfb?=
 =?us-ascii?Q?0K6wuuucj1ZlJPeIcfw5QZOw7NS0+fNdnMuqOo5AdP9s0mfqQTYSoSZGtU9I?=
 =?us-ascii?Q?xeBTMJN4cjksXVLMtljC?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e321d628-6c94-4a00-b5a9-08dc3f62a211
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 11:26:44.1325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR03MB10392

Currently getsockopt does not support PACKET_COPY_THRESH,
and we are unable to get the value of PACKET_COPY_THRESH
socket option through getsockopt.

This patch adds getsockopt support for PACKET_COPY_THRESH.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 net/packet/af_packet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 0db31ca4982d..65042edd1a97 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4090,6 +4090,9 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
 	case PACKET_VNET_HDR_SZ:
 		val = READ_ONCE(po->vnet_hdr_sz);
 		break;
+	case PACKET_COPY_THRESH:
+		val = pkt_sk(sk)->copy_thresh;
+		break;
 	case PACKET_VERSION:
 		val = po->tp_version;
 		break;
-- 
2.39.2


