Return-Path: <linux-kernel+bounces-161808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1E88B517F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E151F22049
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855FE1171A;
	Mon, 29 Apr 2024 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eaeTOZdl"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2070.outbound.protection.outlook.com [40.107.14.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8F71758C;
	Mon, 29 Apr 2024 06:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372307; cv=fail; b=Tg0dOa7/tBJaSKVFHtQnk791twQAb5h/d4ZnEyWvD+VT1lX5r7ZrW1ZSvJrxZUPVrPATdvxVgnojJQyvDGGNFUYMSG/Cljeetb/s/fqT9u7P9CslBVaf2FXKp3yGqKaHReYp2zO0hP0s9/bGe+NrL1oyMMTCyGdT+vIT+WZmJ14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372307; c=relaxed/simple;
	bh=ILCWX4RI5bLypu+q7jOillTXLN9PM6fM5Bjf9Hqihzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CrmbEBlJGaCgyx/9uIIjKW8uxcHNTKbvd65BWXUQLeQQ1LGiUBu2AylwnPdKTstvQJT1+EDMUWnQkJBczEvwevzjuRRLjRvs/agistgJ0gPmoTmb6kJ57T8yybwEHB/dFxQ8RFcXpQO8+zgPP8fnaSMmtarkFsSyW87y/kt4Mao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eaeTOZdl; arc=fail smtp.client-ip=40.107.14.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZS2FlQmmGv3C7x6n0jUk/lfaM5T2VgqFe+ZyYbiaCfr3rYuqQmsJG77kk2raAKr3RhW6NTNUMkiGi0+UMgkfSQvpD6iQ4mbALHNOGysanWoFTlEjoJlX4g8qCryd7n350upTbVwWtHuTAGWv9Ef/j/PuXGcq3xRzHRVYkrRzRXXSpMw6iSH2rbl42PZvBecQ9s8VpzMWNT3eBdKuM5wWsA7U/zsSTMHFULjFBvZkCHDMoNKSIrIYcWr8DRfja/I2+TDtbv1QU+TmvYCsMJTIF3E7+tR+cKGDY5JXMvGxDyHkf/rz11PRyl33N69q3ef/oVTDF7sxurn7uMv6uL6IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWHZk3m8zovg7GLehv8w9ehZe3UBbtoFImeKn+T3wcE=;
 b=HxIHsDRBWnpo7+015IIgbQ6xTNuXTHMcX4yNlVG4sawpHTdRQvHwYk3gj2Gqmp74TAEp2XQswxDjgdWWn66mUeSL3yT6d0zJdTh/JEh6se9ekURp8usebZwWK0FeR7SZOcp87PUF3v/p0XVE8fUMEC90lucZoaHiTwt4YdaejHuLUyMnN0jMbYGBeMfhMNu8OYvnqG0i7fnDGF487KsD4Jpvb0IVbQNNG/MTDU+9T+xi+N6FmikJ8+KLgKnbgr7rllz1OYEoxbH9vRxLsqpCez5B/kz6vNtEI46qJQhlG2cB2iuL7UixK22VDodV+nrtbQPjYUdl5pWRBvNfBqwY4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWHZk3m8zovg7GLehv8w9ehZe3UBbtoFImeKn+T3wcE=;
 b=eaeTOZdlDN056p4LDNJtVGWxGlcmKDF3dbb55mSd4RnA4MSZKIz1rqABAQsI0l12JuMKbXCcCVr8XBuD9CGCW3cGJ6yQYqopGKtcNMaa0BooLDmCRl9h+cyW8xKt6dVRvaEXmoUJrJM8mGg1UgDuJNpakEhcGnu2oP2wiobsd60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DUZPR04MB9919.eurprd04.prod.outlook.com (2603:10a6:10:4d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 06:31:42 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4%2]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 06:31:42 +0000
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
Subject: [PATCH v4 2/2] drivers: crypto: caam: i.MX8ULP donot have CAAM page0 access
Date: Mon, 29 Apr 2024 11:58:54 +0530
Message-Id: <20240429062855.923595-5-pankaj.gupta@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DUZPR04MB9919:EE_
X-MS-Office365-Filtering-Correlation-Id: 4677a5ce-f89f-4bc1-afad-08dc6816089d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vw5t76QsUehL0grWk8848Q5Ag6iGt9WtOPcubuiVlWt/tLzoNyivV5+JG9dA?=
 =?us-ascii?Q?ypmbBgSYq4Bfbq4FNBGaIGGjkaU5iufXlLgMh+h/76gw2qeH04MbLInAbydC?=
 =?us-ascii?Q?nZ5cQBUfZR3F3k3KRVhAzvtGzZGrwq77OR4RVaDuJ7lxOAde0sN8G22sEZ7R?=
 =?us-ascii?Q?410q8NDDeBznsxk/gTrUKurCDtpU5yHNO7eJumUIsAhhriEcgrs+S/Pu71F8?=
 =?us-ascii?Q?7oEDXX7nSp6tkfxeahZKd8WJOhfsX+XJX+scJVICbeQFx5HkvocMTCaSRHjf?=
 =?us-ascii?Q?zrar9yG6wHkVCxVzDweRtg1WBpXTtQ30GIHWYmMLLJGQd05gupjLTPCQ0+aE?=
 =?us-ascii?Q?noDOhCpqB+C2RFbuMze+wwmihmZlZ120s916C2X4npsFXNbUvhMho6+OIMC6?=
 =?us-ascii?Q?Jk/s370iNq3gQYJ1qZxbTNK43C67ROH6gTnGHjIGiFEExZjj+/tl/rOLNCTs?=
 =?us-ascii?Q?2arYSm7DSJHcOhaG1FggkPh6exujb3JJ9PQkepC+fxurqzypZYzwAZJp2ebE?=
 =?us-ascii?Q?XYb2DISE0nH9rrvGjWItJkrOIHUnVpVjep3tYlaLv44PUP0dayz2FLKsuLZW?=
 =?us-ascii?Q?PAq3FZWieBmXO3dJVPT2L1klKZ0QNQhkyBdANE6BDKgOlmeiZxP5PvJFvw+m?=
 =?us-ascii?Q?JFoYzUN7Z7EEG3nYMpalWlpFYlONAMkQ3KFUOYO8LwOV/AEpFhwGXXvqHFsQ?=
 =?us-ascii?Q?XOUbSu2sRPP65sHsCPJ9q/2HaG7SLsdqU8PLnycCFNKGzv2uXDXb5pBHRtHz?=
 =?us-ascii?Q?4hPkDs5H8D+XkP6XA3/6gBLn6srmJGYRmR5ss4xXWkCLg4ELcZLphyuGM5E9?=
 =?us-ascii?Q?fsQJPpj9xrRi57QDaNaNcCFjG8poP2CTm1Li5EdUC0KzBLMdI36fv7LiM4gk?=
 =?us-ascii?Q?DjcQepVkU+F/v3P8R55btA+ZM3oEKNrC2sw3LvTFNrToj9j0yBnVI3E4MKAd?=
 =?us-ascii?Q?S/pI6PbhpQ8URwSuglzJ1EdwjoMFLzUqP7qLg8+dfs5swBwY36yX2A/loh6n?=
 =?us-ascii?Q?J+a+19Mb9J3opyBShO32MzZAEIE9qXwIWQ5dWtfi7kpDiTS9u8R6H9trN07/?=
 =?us-ascii?Q?F+jsYFUsX9WyFlqKc1cOc+fWMUeuugEIWc785E5RfIgWnygcAaujqipu6dxB?=
 =?us-ascii?Q?kBFDiI9nH8f8M2Jl4rp96phnXXLqrgyiFeMN/Ukb8CJ63BDD1fSnei62kFdD?=
 =?us-ascii?Q?V95qi1vwnxr73+EotTwom4ZLWfoXcTDK0E/rHDgCzJWZLv7jnTl1sGdU7J36?=
 =?us-ascii?Q?eI5uMN7mvYAp2WG4WXccRLqKdp6UlFyZ6F9hEloV2sfQdUAQwXr9IWFlODZY?=
 =?us-ascii?Q?+9buLggQfsXZZTnaRGxge9jM14KszEEYlNCgT5qtSRNPhg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?clYDG54REMKOlUghuSJJFzde2k2bdiiDd0sc84DYDCnw3a5NTKmwP9dfVTiG?=
 =?us-ascii?Q?o6aqErCDH6U9OMHOma9VTHltp3ka62V3B4Lhpapt7+PpxT9f9XhK3xQbko4t?=
 =?us-ascii?Q?8T68kUBvNrz58wR57oTQgW1Q+udIwXxbDeVUz2VQh2x8ER8AFt05xQ/KyBqY?=
 =?us-ascii?Q?EuvR/n0rStHux3BmYhG+cgfQdKCIwFNSbhMU9kd2f2rFqXTNhpqq7lP6kv26?=
 =?us-ascii?Q?e3Je2LBuR6ZuQ0M6AqEJdr28O0k/roYQ/cMTZ51KIgoM6xNBMNWEGPv21KM3?=
 =?us-ascii?Q?xhppJPGFWM6vQWTDjHN6dWEOr7vvS68Jlj7fxryW/mb+yIzKWcrsg/Lpan9v?=
 =?us-ascii?Q?frzPdJSrWLgZxQJF9SbGsyhcYhnbS+hFpKPnTx8VgC/Uoiz+NI8ZV3FP7dim?=
 =?us-ascii?Q?xCT5uJs9BthwfWXvyuZPH6/JDiSXb8zpBhvfhQWbLHMJFgNwlYnN9/+l53cQ?=
 =?us-ascii?Q?xa+Ja6nrTCk6bTmhdFClVcNLZqA5Pylm08E1av6WhtM5fu3lHFZ+NOXdZjvH?=
 =?us-ascii?Q?aL1v9EExXV0G3LJkt0IA/nG0l5G9kpaZwVqViuJw0sRt+LyylyuAvMJZVooL?=
 =?us-ascii?Q?XkXWlAM5HC25jge78u8L3n4I9iWo6ZUIqdKItcmx1Tzkbo23qC9RdqF289e8?=
 =?us-ascii?Q?u42Kk39I1pJZBCuvlbU+tx3wUXkq13nal1H+jbOmwLOxeksrOy7WwiqiGZB2?=
 =?us-ascii?Q?ySzsJn1yP1Z8nPVMdQED9luhlat/cz1L9/Ggnb/vXy4UPPC2UMNJMG1rEjV+?=
 =?us-ascii?Q?FX2i3YlViu/+wBHiPPFs8CEeY95qz87+DbMtd71ABJOMD9qMEWWMme3qBUlG?=
 =?us-ascii?Q?6vFI5ogndDUqOuFnfn6WtqR9OYcd+rpufvC9/cRSEeC+q7nuFhaLPOqN9bCG?=
 =?us-ascii?Q?A1oid4JhOfq0sYX0v6faqxz1/81zx58dLVye6VcejBhynI84qxBYGal9yMoQ?=
 =?us-ascii?Q?3uX43mEt6d2yl/BvCaILUM33x9TIEqn9jS3bW6q/CE5VBakeVgD7lz7ahNX5?=
 =?us-ascii?Q?/wZsnNmFeQHqEPwM4kOmaM3mB/t91MpOROeYhInD8PUbWIOjNcx+NFKte0HQ?=
 =?us-ascii?Q?sS4wsfrhWgwDT6U7qFAle3lCiDPUTQ3sFOggd87VZKkGVAlHbCd4FO92XMkH?=
 =?us-ascii?Q?TQYpUYiWwsS5pV7d1z1uVIkuDSCrJ+WPFplJsToAJ668WAZVcrBeGO+xVff2?=
 =?us-ascii?Q?mHZPUSrH5TvvIYKcvuC7NlF4R1EXTIvpZOlI6lKVYzDCT8CfnA/Ha9MTxTfz?=
 =?us-ascii?Q?7bSlKsLqCeedRtA+pL+kytbjuY9SbVUqLbzE/tXMmKzjlpDJbg9ArFpsuvUF?=
 =?us-ascii?Q?jzN7f9X9Mm+UFVmLFe8RfMPFR6LflFH78XCbtB7DZKQFpnawrKTFAuldkvvX?=
 =?us-ascii?Q?N61hiRzVkMEbpNjWvgZHmyN5YSUu+7nMKGe1k1iFvHAQHg3Eb7wd1P5pZjjD?=
 =?us-ascii?Q?eNZkyjMHKZ/ggEIzO04m8On9vFOnN522LkVoEEss5+2gcTrD91VG6Iv60rkO?=
 =?us-ascii?Q?Y83Oq3F8yZ/dM0gidAibFYwSDUSnoNuS97CTYg0Jor/KIqKefObOFMDB8n3N?=
 =?us-ascii?Q?+qvhqMF6oNjSo0x3xZhHp41m4stwy5/XVDyI9kGv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4677a5ce-f89f-4bc1-afad-08dc6816089d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 06:31:42.4576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LQVceg/6jNIgztsw1eubob0IVMhIdArmzx/0B8/3G+bJEkEJWBR54BmOyRgeXBzZTcEojkTCrrhxYi769KrmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9919

iMX8ULP have a secure-enclave hardware IP called EdgeLock Enclave(ELE),
that control access to caam controller's register page, i.e., page0.

At all, if the ELE release access to CAAM controller's register page,
it will release to secure-world only.

Clocks are turned on automatically for iMX8ULP. There exists the caam
clock gating bit, but it is not advised to gate the clock at linux, as
optee-os or any other entity might be using it.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Reviewed-by: Gaurav Jain <gaurav.jain@nxp.com>
Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
---
 drivers/crypto/caam/ctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 02363c467cf3..bd418dea586d 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -563,11 +563,14 @@ static const struct caam_imx_data caam_vf610_data = {
 	.num_clks = ARRAY_SIZE(caam_vf610_clks),
 };
 
+static const struct caam_imx_data caam_imx8ulp_data;
+
 static const struct soc_device_attribute caam_imx_soc_table[] = {
 	{ .soc_id = "i.MX6UL", .data = &caam_imx6ul_data },
 	{ .soc_id = "i.MX6*",  .data = &caam_imx6_data },
 	{ .soc_id = "i.MX7*",  .data = &caam_imx7_data },
 	{ .soc_id = "i.MX8M*", .data = &caam_imx7_data },
+	{ .soc_id = "i.MX8ULP", .data = &caam_imx8ulp_data },
 	{ .soc_id = "VF*",     .data = &caam_vf610_data },
 	{ .family = "Freescale i.MX" },
 	{ /* sentinel */ }
-- 
2.34.1


