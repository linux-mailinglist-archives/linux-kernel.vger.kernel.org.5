Return-Path: <linux-kernel+bounces-161805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D978B5179
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E921F2203F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5040134DE;
	Mon, 29 Apr 2024 06:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HWMA8rUq"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C168711C85;
	Mon, 29 Apr 2024 06:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372295; cv=fail; b=MQyFuUEHPsrNnfwySEEjPV2sIj8zYLi+GzI6vQ3W53qJvVNuTyT+gPd3QkoHtPs4dl2GNzI3VPPG5wXh39C+JE3teWMOB9M+urbfBK2kJ0itstwx3scBkdJUdpRZYDMyPa8KzPJMhRcRFsVeceH9BZ+Wi3NtX42Ee9eYsFrw0LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372295; c=relaxed/simple;
	bh=1SNdOcDtAyJ7YLSmVD5NXfBQnBCWbA8J/3E5xdbjgYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lhi+kIp40dsWSa0w7IIhWEnRZgJFbUliwgmEB/BmZwffntTUt8q6UW0dlGfaEYdXI/e+jhIjscSh81J8LadK/IJlXG34pBE/b3FZxlj1nrYPCjnQtKOxVDLlUIN6qyBRiWrSnNvBrRuBAjWqmTYO3G2rMZELjaGh8UDTKo0MWkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HWMA8rUq; arc=fail smtp.client-ip=40.107.7.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iX3J+3RQuoxtc5WrGtuzWkuXY5kSkQfCn7B1XFhQggPVsAmAQ2pBjO0ApRbSO58syddwDGk394pVFtXL8q+JFbmu7suSCzOlutwkWIgJOQ/0ZjNhCGPkCUTsDVIVimATHsIl95q1D7SobjLuH/8RhfdalXhOe9hK41iGvfyjP191tjvHo/CGuVG1GBplmfzXqR/PluN5+0PVZXuiM8J/iWSPQlcFCfzFUt4tjSQL/osmLh0XFwvG9ttVHLhbjlmF+NazdxW8CUSltYFC2Iq41TSpVQFo013Z9jA2mFMMd/9W76RuGZi4z9vhwGgfe/YK1v9qMANjE+K/UTPsZoXWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilba0+wjvJEz+gOwt6MA86RvZdp3T1VrWIo2DzN9fvA=;
 b=fWHa82r9asQ31nCOadij9macDiQL4wnFs3GqNz9/UnkdsO7o2fB8dpLVYXmovlCk2Cg7I5TlOCiefcJGa01mLQGOuZUFRLJeofqTfnyRqbUo4aYuibC8k67DGIzm96MdxndYE8ZJ5ADcLwBsnmY866bHodfRykhGyH7E7A/mhaAeft9V2/1fyLe2Fa3JrMO7e+tQ0W+HDNsOn0JujkKr/FK25aRNEzLsPNTg59cERdginjebqvLWuZThhAfRqtoAa88frrKiyPEJR1yAo01ThV1Ycx/WaDgvjT2KlRfvVC5/VkoeZ9atFUwDt2LgBKRN1tjCZvXWme4wdSv6v9VB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilba0+wjvJEz+gOwt6MA86RvZdp3T1VrWIo2DzN9fvA=;
 b=HWMA8rUqb7+PWiBzKSX/1TG3y/xGwE2qOWFQ6DiQ7Hhi6MVHAXshhsuh8hrNqlXzT4DBx01t/hlqdOyS727l3D84qHt4qsKuFpRarThGT/upGbsxXqZjMXpNp0cJREVy1Sw4liHe3bje+Ehixx8x6ejn1Vax9RSO9S5f91j4Im8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB8PR04MB6859.eurprd04.prod.outlook.com (2603:10a6:10:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 06:31:30 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4%2]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 06:31:30 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: gaurav.jain@nxp.com,
	horia.geanta@nxp.com,
	V.Sethi@nxp.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	iuliana.prodan@nxp.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v4 0/2] caam: init-clk based on caam-page0-access
Date: Mon, 29 Apr 2024 11:58:51 +0530
Message-Id: <20240429062855.923595-2-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429062855.923595-1-pankaj.gupta@nxp.com>
References: <20240429062855.923595-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DB8PR04MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: 05512f44-4093-4f1d-7486-08dc68160126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0IG0YW42WKdgTyF81de7956DhwO3cqB5v7wBi9a8WxcO4wVyCr6rZAvc4kV0?=
 =?us-ascii?Q?gJv4SaLAV9nuNa7FQ/fxXAxnd76yLJWJOn/3tEgZ8U25vc5Jh6w1gQd6rImz?=
 =?us-ascii?Q?WWFu5DBFI56u0/Kc75gUbj0rEmUnipSrU/gD6txACJu9FE8vSzxVCnqXcnXA?=
 =?us-ascii?Q?IUhcSDFoT1qMGO8S9tmRtm4xr0EhrKAspn0oShFcpuSCxueX+2nn+L2UjVsC?=
 =?us-ascii?Q?uVx7YKhYQjCwA6q124NS70HVzEJLs8/yWofGgEaC4uX3KN0+vhKGcqxffjXm?=
 =?us-ascii?Q?bOS3iWgyvjvcmJx85aYz5VVnyArNPIIKnwBzVCiikPxhD5OH8ESJDjHEMkav?=
 =?us-ascii?Q?lznAgVVtanyNJGDKuPAIogRf3OPhscdvvGIGkmPEEfuPHwCZDvxZkGnFfVZB?=
 =?us-ascii?Q?GyjIbgjceQlzMfH0Ig81B4UceOYbxU/UpyUgWaGpZURWSrG6QJ7HJWuvFnvS?=
 =?us-ascii?Q?HwDjnLLY5i9mh9E3gp/m6Wcgi+ntlLyPa7icclrX6TOX6WFz+PrXkjjYeMUq?=
 =?us-ascii?Q?2oQCR7xNm92g2Wcl4yK2fbhqFiV19ZBWBB6C4IiY6z+TEPkrwcDr/bTuErKq?=
 =?us-ascii?Q?mvrZL3okOyUuw9p7MKdppmmaF7rS2LOiRYLXUq36EJpNJr9+DZYS72BnSBpz?=
 =?us-ascii?Q?Kt+1HZLfVNzMyh68Mr+7ohiGksjvISl+LaoMQQ1JP9IEEqeGtFbFZIPIdcy7?=
 =?us-ascii?Q?gzJtdqQYWD/aeWJ6yhAjSdXicPNbp/S1iO7AiMnIDXRKx6n6fgXWXB5p3Jb/?=
 =?us-ascii?Q?XUPc73Mtvsb0KGqdtbTgq+2XC+0KPvsCQoi3xsV2WdykWE5G2S4xrlyqVwO4?=
 =?us-ascii?Q?t7QHongFXbLGkMqN0GRnbubYSyrzvP6u1QvvRJdf6TmB7zF/2O08nZQpjRX0?=
 =?us-ascii?Q?TcYxuSxAQbHGfGREWwmn6/+buF6ydlw+Ody5fBb5DAUewYpAnCweP1U/od+E?=
 =?us-ascii?Q?UXf+bipQY/mi+QoVLVGhRHn8BsNYbEX4YczWCNA01k3J30n2lSwxjxc8oliR?=
 =?us-ascii?Q?PKEcV3s+flZvI01Bc1o0oklxpGF1wV8nkEd8CovCNO9Gy6aSD8UdFAWLJxj6?=
 =?us-ascii?Q?4WOAwBlmcJ86ojV0rCHTsSt5iWWaksN1G9yzq90J3tY/5iyBExzyKOVYyII8?=
 =?us-ascii?Q?8hybbaSmU/xXHNvSQpUvetOlBRuvhAUBCdGbdpDCLufnmY/l644K3II3/Zba?=
 =?us-ascii?Q?9JueXTYeA+JdoCzN1UpXanxnL5fjNj+GLvoi/CXQULB4y7Bzkqs4TWsvKh0T?=
 =?us-ascii?Q?7bDleFSEvXhy//1N5ehskepYOYlv/goF2gDV3fcQyWM8s5/y1Bq+MmwemAMa?=
 =?us-ascii?Q?J2KzT/Z9uuzWULe3F3oLQcTCP0Fpz/NSmMsgtC+cqhWuCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BYTUXXWDbhOjWa8llFZI+Fp97rtziGxQmc3YXPPJwRezwDdZH9OhOYxw8u4a?=
 =?us-ascii?Q?hT+pRrCPolJlbbUt61/mjOrlzUPDN/22Eyymihsy/ePUabgihnzYruzmc+PW?=
 =?us-ascii?Q?iCafldRJC7y0iYXXjA49T7e0ENVXJ531AWLPRqSJppy9Eh0+nzejWoQ1Mecu?=
 =?us-ascii?Q?MpaJp62ssPeMqJsaYD6QcVknanCnusUE3Kif917VNBNS3cXVZqPPo0QyDNEv?=
 =?us-ascii?Q?+O66I1wraIxN8eBZDm3LZKCUzwxyGr854++o0qe1tEp/ck9H714MZvV8Q0LC?=
 =?us-ascii?Q?ARdtrKqhPSp+ph2uUxWJfunTmjr2APiSmHtFPkKPmfpdkPN8Kh1bdfJp1WPm?=
 =?us-ascii?Q?Aq4jRasQD/KhAG028z2qQOSI7XgkG+RWAOwOUvl852tzR9gLielAy+II2dmy?=
 =?us-ascii?Q?ljzEJROwXPRHOOIoGMbOkqEnZzoefJIitcfv1kTGaLMcXQLImGqqmNS164t4?=
 =?us-ascii?Q?mPvUMhOlXFwke4W9mk3AAyNH9LHwIR/97to7VncWvP17neX4/LymiQm8q14Q?=
 =?us-ascii?Q?P90RryqIX8kCEK2fUoV4vkICG6g3uXj2R5RfwIrGB/4243Hx8d7GYqoLBB8s?=
 =?us-ascii?Q?bzywp1RVsMFYdwFaw08w6QCPACFdlHJEjAF7lalr1m+mRd57omNFaDCLnqMM?=
 =?us-ascii?Q?Ij5Qv94B9BvDgM9dPbHwYyos3xTWOYbi7Ul8MzMSOjqDn0PcjeFwF6+R5lCu?=
 =?us-ascii?Q?04DgkWs2be59098b8gXBGWp9ANWu8OoCE4P+puilmNAsWpBf0gsZNe4MbVLW?=
 =?us-ascii?Q?Et/CDt8G5+SwB9mO59hTZ31hze5FMYLktDuHBwLOeowG4t3XDsIee0g3aOpm?=
 =?us-ascii?Q?ZWO+yUYp/dhmT2ALMYbkh8i8ljXxql/RgIC1ecafNjHmo1+mNZNuk6O+jM5I?=
 =?us-ascii?Q?4q5bw5tcLSbgd0o2hkO6660TSXWGp5x1PjelYiX8POGJabjJga/+g0DcTQWy?=
 =?us-ascii?Q?8aSfZ8zAaWazPqQbazw7U9ZwL3iruHWZFQLwtq0Ujb48CQYyjAu1p04DxH5K?=
 =?us-ascii?Q?F6NciFkw4bcj//OP4lGjK01O9crc1mXLshXiOCKZUp4qQ0yQOGqtYqPWpQFB?=
 =?us-ascii?Q?pkFEzyAZhmXExcd28gfKSEQeZ4a6E5lI/CyQKjLiNtrIM3iimKwD8X4Hrq7G?=
 =?us-ascii?Q?QHTJatnsUHKDjF2FeEIkdmNjtEpI/mxV/qJgNxajsgLTR29PQPokQYckdwGl?=
 =?us-ascii?Q?wHjnOaE2v6PqI5j6miLk9MyoPWSD3p5s5w6YTTwUJY4r0xN3+ty5Kjvj7B0S?=
 =?us-ascii?Q?TBKuNTEN4hRMkyXtSUfCS0sc7OPEBso3x9QOtJuHitrLnvTi17tI99iL1w7G?=
 =?us-ascii?Q?fytxaAqyJiST9e73eG8ccqqsFc1VnaKpQ46Zf7mMMkofNLgKYDqxHjV2WFm6?=
 =?us-ascii?Q?tsQaAygLWAp514+gOIZupizsU4RWE2jZ5ySngHT2qz446NCQ0Y3ePr+NTVoQ?=
 =?us-ascii?Q?/6Tj9QPuutmXrm+g8OXSdCDfU0Dq43S2eiG+7nwYC8mvcEtgD1YDPSGq7PU5?=
 =?us-ascii?Q?wCr6vhvH6VMBJ7q6h1mjeA56rE6QAR/lzVGAXbyqin3vD58y0UYwZCFHOnKj?=
 =?us-ascii?Q?u/WOSvHQrV0ZanyDpkTWf2fQzZDYugYSjvN2SFvS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05512f44-4093-4f1d-7486-08dc68160126
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 06:31:30.2660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erE0Lbs0B0xnWOfoL9hiGGCZ2esusPkTfYqT3n5S+a/7DpWpotfaLLODkS70Qn5ASFART+NdaL51YXFG6YjtnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6859

v4:
 - Correct the null pointer checking

v3:
 - Splitting the patch into two.
 - Disposed-off comments received on v2.

v2:
 - Considering the OPTEE enablement check too, for setting the
   variable 'reg_access'.

Pankaj Gupta (2):
  caam: init-clk based on caam-page0-access
  drivers: crypto: caam: i.MX8ULP donot have CAAM page0 access

 drivers/crypto/caam/ctrl.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

-- 
2.34.1


