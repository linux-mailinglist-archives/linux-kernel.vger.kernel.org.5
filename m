Return-Path: <linux-kernel+bounces-161818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA25D8B519F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D460B21562
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEED111BB;
	Mon, 29 Apr 2024 06:42:17 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2106.outbound.protection.partner.outlook.cn [139.219.146.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8913B1FC8;
	Mon, 29 Apr 2024 06:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372936; cv=fail; b=WdgeupGKuggB3FW3awDLPKsdzKtNcVF1ixeiMyGqpFqyckpXdp7nCf/8RKl/FoJGMToGJlyPFMu6uSlmB/5+D2fjU79t5b6bPtnRcYQ8RzNnbgT3ZixPZPT+SXHk+i1uW4ZfRKAXnoj76ff0WNmLdepqlmLOtBsaHJ8h4t+KOxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372936; c=relaxed/simple;
	bh=PB3GBoEXep2ry6qG6V2WzZWfQx64M6+A4aHWNXAhhQg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pHzdnCkWiUNcPeQEXNKJYwnH/NkUSNgaqbVKZp+EJohY1nYDJ3vUabmmYVXN7YfTv0nFfrSaCtQne/Kz9O60XxDOl1REEv/XOki6xsqqB/sAAUjk/azuF6CPoZmsAhGvuk9SHS76sMRyt9thjVpgbp2ynkdcfXuLLHJyB7XExr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZRA0d1jNbdrQ1iI1Oe88HCyQ9CiCcA2ngQRer2R/Ne0VaV4CuNLGVIMQw0geNbmnwOSLg6Kno8oslrZNVwN8RXu7hKglH1a49W2tcym/51kpW5+HgtyuHbJSFMkxPK7b56Sj6vpnkbDx1K3lWnnLF0mGrUyeccgmZ3G8vCYdjft0GFUcQm2n6GSQTz24OY5TlPj3JFwSJC+N+zxcp55WTr3w7F090pxonOPVxARxw6ubyO0rqtiNh1fZ9/V7+9VIsJlF+9w20Kf68QgniCGXeBefKzUmx08Nz0rBsJAArYuPQEGCRWGtM0+NuUBUY0sfm/3Psqdhzeq/VV13a0vjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0PbBRkJufUOUggY+g7ZpyqJ6ozeAyZSGDjJisY1OCI=;
 b=P8tkG2rvj7kUPrXUi0Icwqt5LKKR+C1u7eLxlCiuVOzQBEtxABP1f3H+nSxJk+xytbPdW3L+1kVxY3eFixIL4X0qFzzJ59MbviHRzX/qh1N3bsPkdGZuMfnJBqXNugtDTVeY/ely5jvl1yXWNB493BlpCCk/jGfTqK7gIWrGntv7gJgomRgsQQj8Y72TsnHUHl3O+HtMAHA8nMsSzkJs6LNGv4MpCKD8yF0L5+TYhKKGUiCQwPv/SKx3d3FeNgA3XFHYKcFSyp/T2EfkrewN8h7yGTMc2rntzfZWGt4VaRR4Qn1tYez4Sh/AtUUtWOGbGnmAsDcSQliiA4Cx3Dw22w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::10) by NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 29 Apr
 2024 06:07:58 +0000
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 ([fe80::3dc9:e0c9:9a09:3bb7]) by
 NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn ([fe80::3dc9:e0c9:9a09:3bb7%4])
 with mapi id 15.20.7472.044; Mon, 29 Apr 2024 06:07:58 +0000
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH -next 3/4] crypto: starfive: Do not free stack buffer
Date: Mon, 29 Apr 2024 14:06:39 +0800
Message-Id: <20240429060640.2451685-4-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240429060640.2451685-1-jiajie.ho@starfivetech.com>
References: <20240429060640.2451685-1-jiajie.ho@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0034.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::12) To NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1182:EE_|NT0PR01MB1278:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4862c3-3634-45d3-26dd-08dc6812b7d2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wYER8FGZbU4rQVuxQRcEuTDfAdtWfXKAzW5+sLBpk9SxALfrcqUiuMMp+P7iwJzWm8o++jlQVdmsyTb2Gj0ahXZ/xYCQ2VsbotiYbib7E00ht7lJpWsrWKfGyWw1Fgw8ggoaPkE3rlt8mO6/UnO07VtU82jDxPqFonMyPrNeGAB2XixCl0gOLVSFGqiwXmnAqRqgLmUvqzzAWpeTOZFT2wvX7RCkHhsd9I6cj9H6pcTDrnwg4glVzQ2FSLvfM6Rn+1Lh4e5453Zs3Rr67hA/qguyNPrVINQ3hiiFmW1izmzfTj4KQCCkkkO17Boivz0SpUuO4CZzBMp+t/VlWgWDQAw0bx7q+cWqkZnn1GRY3maGpdaekY+dgul0voBlIbc+nhzdBNHQmZYIdi5zrCSWKo/+6EKcnHmyKU2ZkUS/xHY6NAtvxzaaiPsI222MGuh5MXZOdwsZyhDJeSdcgQxwUS/szcWb+i+4jHhOcYlk0wxPGo0qx9iepF4hzrz3kp4UHHXbyTQuA7Uq09pWSRzkSwm7GD8MeqwlVHDyBnuWMzx6ZdGL4Dh2K3Q6teWOVj6hjUKL+VGc669k8XyUB2jisIgn1Iw9vXtviKDATnjHlK58Boaanpiktbf/ndFKQV4b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p4ATjdDrJnF7n2MB705/DQBrQTC8zzSKCcOSopCCYVBLBCUIIgM4wBTeRA/c?=
 =?us-ascii?Q?zYo3X5jT/71uVMqCZ7i32I4hXUxiOVAtEvp37tUWPKC5TIAZwtIpGvs+cVPH?=
 =?us-ascii?Q?LkAgksjpr3cb1r46+ydAlRb9MIkpg8pwG4pajB55fYJlULEUvQFer5B6OLtT?=
 =?us-ascii?Q?eLqodblnLTbBC3xeMK1jdZq9XqJxrJPU7LEHJ2Zb7elgwn2PVmeiEkbxqsOf?=
 =?us-ascii?Q?G+xIvtSEg27r5qFYF+QlaZdBXsIndsvU5x7+OuDcbvUWdeBrLObLp5gyufn2?=
 =?us-ascii?Q?tQG5As8sr1qiVkP59cyAZAcQzlLEwBGFursEzkcc16g9cMhHbNWpAr485RhC?=
 =?us-ascii?Q?Iclgr2ydsVYyhtoxFxBIOVRrLak7jlq3TQHzUF8fKn3hjzk8mGtXUqoAzAX6?=
 =?us-ascii?Q?M/8TY4X9EenSSFD5N3VWLLL3yldefbtOSAUeoQEWaQZSF+lEWLzYxqX8xtFJ?=
 =?us-ascii?Q?Gxu4bWr7SVuPbEwSvbK7JLB0cZ/KHy9x/5/p4JFFmerDP0/zANRAjOOJuFOu?=
 =?us-ascii?Q?O9mAwYTRrmC+yPKUZHySrvYb5aDDMr4cTgpnGRR1+5rspHXUskRrdkvjt31B?=
 =?us-ascii?Q?CBkmT1Y/+ziMvugNLWs7AGZlOQWogC10yoJPBSwE3EG+8u1qZAjIAxGW6w+l?=
 =?us-ascii?Q?+dUMyIiEaGMnBdkRVSdCyLuF9BmKfMIQd7buXmL42NN8EoLP0A4vQgu2zs1E?=
 =?us-ascii?Q?nzylwv2hAhIcVRcN346tcZhywW01el6ruMdIJy3INVVXSkj5bdkqOB4SnP5f?=
 =?us-ascii?Q?npIjLVvUFGubnKQXMYksF8qrY+pNa3hbZZnVQwl1wZTgJOpKypZIfPmmZAH0?=
 =?us-ascii?Q?AL3ioJGvoZlU7F3AoL4uvIMq47sH2FFsIUc5rBd3g5OzLiws6B5YxmdE9oKc?=
 =?us-ascii?Q?6T/AALG7mxVohPbNPlraXtt3sIlEpcogWUxZxcAHUL4pniPwKE6W1g21NnQP?=
 =?us-ascii?Q?yWu7MCskHB40Pcrgf8wLwNh7IYrASLmhQTJu3UhCxpIWaoHUuePn1wkHASzW?=
 =?us-ascii?Q?oUh1gyUPczpW/yNMgBsA48y97Zc/dugHcIF9MJCpUnJigrNrbU353XFkLzsf?=
 =?us-ascii?Q?E7SAF8ZvNSFeiueT+zsA2F3TCWMHVPZQ8dxPGnMeDQEEE037S+Xdsto7c+NA?=
 =?us-ascii?Q?Mq1Be0711D+RAn50iGAwg44eDYuxbaOUjOnDsfHiLsgs4/+n2w5BdEKZtfE+?=
 =?us-ascii?Q?Bt+hhu4ZFrg1/5pzDi1TKwB9mlrHkoBDhHTiVrQ1AvNMtgnohqr+swcCnWKU?=
 =?us-ascii?Q?F4Xm1kpZg2AlA0bQIz3hdzfaPr1G+1MxY1/UP24vN4qDtjdk3ONWa7FPiae3?=
 =?us-ascii?Q?v8G+eeW4WtH3JdsHtJmMGFf7o4/myQxATplh/AmbV7/dMjo6oI96dQ44hcfb?=
 =?us-ascii?Q?z4B6UmdBrT6uAkoxRfobYdr46BgbVwI+upl03fyGlAEdWXGYI6lXRdp5TUXz?=
 =?us-ascii?Q?Vm6x8g2Dqo8CTqi1kWAjQJ2eV9E0sit6+wlnXnJGImm5ZhBtfHuLpEJqLSV3?=
 =?us-ascii?Q?/Ym7xq06EScTrihrEvkphxpYNKUF0mCi307iC/NwyGwRjjQTVCaautndq7md?=
 =?us-ascii?Q?IjsVp/K74IkHJdcYYAzS0I42ThYHl2RuSX8VBljGSTp5qNsOObUaE7WyeWqg?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4862c3-3634-45d3-26dd-08dc6812b7d2
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 06:07:58.3851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+mQlKvQXLQtcUIjqA6wtYoPLxWkAFZ6MGw5nK7Em3CeYPBOVb473jzCqw79sEIPWieB3TSAB3If5hXjCzvCvcFP8EIHH0J4zGiU3sNgTAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1278

RSA text data uses variable length buffer allocated in software stack.
Calling kfree on it causes undefined behaviour in subsequent operations.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/jh7110-rsa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/starfive/jh7110-rsa.c b/drivers/crypto/starfive/jh7110-rsa.c
index 4d7eb3d1e764..33093ba4b13a 100644
--- a/drivers/crypto/starfive/jh7110-rsa.c
+++ b/drivers/crypto/starfive/jh7110-rsa.c
@@ -276,7 +276,6 @@ static int starfive_rsa_enc_core(struct starfive_cryp_ctx *ctx, int enc)
 
 err_rsa_crypt:
 	writel(STARFIVE_RSA_RESET, cryp->base + STARFIVE_PKA_CACR_OFFSET);
-	kfree(rctx->rsa_data);
 	return ret;
 }
 
-- 
2.40.1


