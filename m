Return-Path: <linux-kernel+bounces-159134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 686568B29C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79BE5B25D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D43215572B;
	Thu, 25 Apr 2024 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s8V9ov4J"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F53158A17;
	Thu, 25 Apr 2024 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076739; cv=fail; b=TLieS9/LLpJDvcwYf3TeLN0doZebiHlaIrBb/xx5n68tD5WAuHmXlnCzWCmExOV8lzdNc+EpsUYlTyW7XPpCtLUeMxgn19ywiAJandZ2Z2iANA+Rz9URKf82g/6E5x8whm0PhnvKnSe+0FfK9GIp6sFK6f6Ru2zo60dWCMjkYQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076739; c=relaxed/simple;
	bh=qgtpZs8h0sMtJnWa1Uf9rdRcA/9df8/3X0jXedEQWJ4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=auv0ysNYpInuv/pdcfP1wBtH3CtkBjT24b853iw0e/QtQGkIMz0AKCu3EXRyX0ScQZsz8b7WtLRfVe2IaXuoCyhZs6+ajO12aP/EcSxya2L0uPKHjsvZamqv4vacNvtcBW2If+V9WRSXDKhDB4XL5UPBQzuUokBx/MU1ugz1wM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=s8V9ov4J; arc=fail smtp.client-ip=40.107.8.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5OLUk2xQlXPZNTNHuEZn55cKk9FSXQTc6a7I9muhLmglkxjxEEx734NsUEUI3gqNpQQR+UGaMBV7ryKTvU0BgTXA099lM5Vj5GgK3C8amLExPmj2lK3IWXF1jlGvQr0w+DdRqjWMGA46pbP1wbEKjdV3KUqX7P1/xHSSOuE7Xsp6ll/JmE3up2qj1ECvOtxSuyJ3w1TfIRj/k3QhZ8T6WBzSwtse16X6TAO3cwcLZfTdpOUbkYO+bhYTDt0AEfvNYOh7BKfAzKdT6CVucYph1pDpK4qWzfBz/ywweM5x2DLIrksyRr55kvzd9Zegy3N6ccjfirbA5bhHcYdbkai3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvcYlTa5/HNkjL4SiohDX/DdXdyQ9Nx1QmcSfyAYkyg=;
 b=bBlkdruYyXu+PaUdgpQ3Y7opW6yc2OiAlRubFLTAJQuer4A/6x8orviCkLAM7yYKRdF4GQgN7ek0F08IVSjamsTwLFGuz/LvRJxsiDs/8hMgUFWHoYO/ZTyx1OkobJYRjEUEOWeqh44+IH7WEDhFUdVZyEQsoX2pulGgAj7fxM28oLdZXnONuNU/cwt/5V/tsikBdkFHSF4eqFJ3c8wSIRE3qcOzugOyQPTpKHbPXrDHFUHNK4UKwVTTDQ8tt9jAKAUG11CkJd67FWSBHL8MhBld4stzdOwE5/P4tkGvB8cpjxXjFmOgKbC9unSQtF8vlsBTfuifACwr+zx3HuriLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvcYlTa5/HNkjL4SiohDX/DdXdyQ9Nx1QmcSfyAYkyg=;
 b=s8V9ov4J3j6nMmtOjAvfv3UCqq9zgbG3MCvJyXzHqMIqPAFQq3yH+1iNp17PoCylSoKpJu5H8wMk/XzEvmHo0T20a+Qn8TczbOpeb+QvhMiwWNza1TQlMtgc2Fc0m+ozG5Mwq1Nt0BjhKrjPCO8xbSWHQ5cwlUiJba97gI/QrGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7472.eurprd04.prod.outlook.com (2603:10a6:800:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 20:25:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 20:25:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Apr 2024 16:24:46 -0400
Subject: [PATCH v4 10/10] arm64: dts: imx8qm-mek: add fec2 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-dts_8qm_audio-v4-10-7fa6ab2fd64e@nxp.com>
References: <20240425-dts_8qm_audio-v4-0-7fa6ab2fd64e@nxp.com>
In-Reply-To: <20240425-dts_8qm_audio-v4-0-7fa6ab2fd64e@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714076687; l=2438;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qgtpZs8h0sMtJnWa1Uf9rdRcA/9df8/3X0jXedEQWJ4=;
 b=nyk8eXi0UHM5KyxQOwC6grQsTgiMYznWQ63YAuXFzPjBkeSJFHUszxVtfdo6NjfHQQYxUhmWE
 ECPNZ0FjzauATKsLIvJMg1HzfTRERbis4P+qwcQxRtOretMtdR8ABE+
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 1450dd20-caed-4eb5-ddd2-08dc6565d465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|366007|376005|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ek1oQXJJWHpRa1lnR3NxalNpOGljQ3pqQ3h2V2ZITkFHNm4xOGd3TE9QUzdP?=
 =?utf-8?B?QXNCQWxzOVpYU0JlMTRuazArbWNFUTk2UHVVbGpHNlZSUVp6czNGWFkyR0pM?=
 =?utf-8?B?eUZQM2dsMTk1MzVUdURYeFdKU1JjZHZrbTZJUkxCVkN0ME56R3V2bGRNYUpL?=
 =?utf-8?B?OFdEQU9sd3VuS3hjZXFQS0p5Z0FIYUFjR1JNeVhtMmp3cE5qeFEvNjF3Vkpl?=
 =?utf-8?B?R3NhVDJESkZXcHNpNDE4TUlGVE4rL2l3aGlFdUFKSFcyZkRMS3ozWkZ6MmNR?=
 =?utf-8?B?UStYN1lHQjNuZVU5OUZpZFJldkszZ3pFSFcrWjM3NnVNZytCL2hVTVZkRVBM?=
 =?utf-8?B?NXM5WnZPU3dxUmIycGR3RVRaQ3Y1ZElIQXJHSEVLZjN3WXFIZk1lVGdHbVEv?=
 =?utf-8?B?NUpsSmRoUG1td29kTkREbVVEUzYwWm5FYm9Yd1gxTXU0aFRpTDJtaTlMQTV3?=
 =?utf-8?B?UjE4bGlJTkFqNEUvMEZwWkZsenlBeEd4R3g1dms0RGJnVndrdnhTNWpHdFMz?=
 =?utf-8?B?UmkwaXhJeS9BalVhMVpMdUQxdC9idzFxejFrdkxQZGMyU0tyTmhaZmJ3ei9x?=
 =?utf-8?B?cC9xaWhQMUxBb0laa0VzUXY3SHVrSTk4d01wVS92d281S0VxVmRZYjRkeWJy?=
 =?utf-8?B?b2trRk14bHU1Q1pZbGNJV042MWtWSTQ0Z01mSE8yUS9vQzlPenBFVzFIaEd4?=
 =?utf-8?B?Mk5WdEhBS3FSMy9mcEczZmU0VWlWNWVHbDRpNnhlblgzOWhxRWcrSTBXdXdR?=
 =?utf-8?B?aFRYUjgrU2RxT2FFSVRORzZORlpsb2RTTEpkZG1weUtZa3RwWGQySVZ2K3VU?=
 =?utf-8?B?Y3BxdytTQnR5RWFNNGtkbmUzNEF5THljdVlPSFoyY0IxZFhzdy8rbnluT3c0?=
 =?utf-8?B?TXpRcElHMUcwSjBuSUlXNkJVMTkwWVg0SXpFK0tSOE1JM2Fxci8rbUYzdHY0?=
 =?utf-8?B?citOdzNVZmJjMllvY0lmQnI0dnM4UG9xSTF1N2dsQVk2SHZOcHNVNkgvQndL?=
 =?utf-8?B?dlBvSG1ibzVnb2xidnluaUlWeGdrM1VCdXM1M0MyQXJjQ084Wi9JeS8zdWdx?=
 =?utf-8?B?NjBjTW9JaTkwTzBIWHlKM0h1Z2tybGx1TTE3YVhqTmlKMmFQZWJHTFJBTVFt?=
 =?utf-8?B?anpCalhEd3dtZVBsVklndDgwK0FSdEtwNjJQakxSdlExVElaTTRqc0psbjVF?=
 =?utf-8?B?Nk1lclRlVEs5WGR1bUUrSVZzN1QyendGeUcxYUdQaFdXZnZTSy9wTDR6U3Z3?=
 =?utf-8?B?YWF3SFc3L1lrRXpTMDNmSDliUHZBQWlUaFNacU9HZGJHODRWTTcxVHRpRE8r?=
 =?utf-8?B?Nk1DZTFxZ0hibHVvbWZBdVhpQm1ZaDVld1pzeGc1bzhhREVBUnNxMXN4c2Rz?=
 =?utf-8?B?K3FaenVvazViY0ZQZVplK2M1VjlGSHpNQ2ZZZVQ2KzAyc1lySmFIWEFsa1pv?=
 =?utf-8?B?cmViQXlHSkdEMnI2YU9ja2JxMjBxSDVjUmc2d0MzVEt2SlZncGZGRkgzUlNS?=
 =?utf-8?B?RXVEcjNQa2xnRTZyQUI1b3FzcERFUHhlQmlTRjlZWlVJWVBRdWJXZmdVUVBy?=
 =?utf-8?B?eVdpblp0UEFCQld4Vjk2NjFSMUtmeW4wbVc0Mmw0U2laelBoaEdVZHFVVFVF?=
 =?utf-8?B?VUZ4eGw3cHF0QnkrNjhYZEZMRDFZNGJKODdSY2Q1Ums4NXJERm1QRFJNT2tt?=
 =?utf-8?B?dmdQR3I0ZWEzWTFkenFoRzkraG9ScTNTcEpkeUJFY1VVWlRkTEQ0SlliMlFM?=
 =?utf-8?B?dGx6aWhFY0hhWm13b0VvV05yZEZuZEhidFRTVEo4VEUwSmVtMVFOSkR2VWZa?=
 =?utf-8?B?N3dPRlI5Yk1na0toWnpwUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MC9ZZ2FoMjluLzJUbnJ4N2hudHBzd1RlUlFObnM4R3dnQnBTcFg3cHU3VVRw?=
 =?utf-8?B?WHkwVE5OVitsa1l1YUIxSmNPelRSYlVhRVRyeHNJbS8vY0RmY1hDUEdyYm5N?=
 =?utf-8?B?d1AyRG1RR2huNDV3NmduWHdaU0pmZTJFeEJWRU1Ub1N1bFVnL25ZeFdHOFNr?=
 =?utf-8?B?cWd5TUVtNXBYQjh4Tzh0aXRVSGFEbWlVbUFtNEx5Z0M0MS9UbTFoWTNiWUNK?=
 =?utf-8?B?aEwrRjFKMnBKT0dkQm10RVRyZ3BVRVRIZEkwY2lQWVA2WnFnT2lZU3doVFVO?=
 =?utf-8?B?eW8xM004SDNFKzVQTFlhbUhTU1ZudVJIOXJNQklDVXkyZFZNbUFNelBjdmtk?=
 =?utf-8?B?UHpWR2crOCtqUEZUYW9mN3JEUk9CeWNnM2JXQ05BSjBHNnE2M3UxNldveXJ1?=
 =?utf-8?B?Yjd3cnhwRXkwNXJlcmcxc0w4QjZXUDVOK05oMFpOR1IzWEh4NS9ud3JLV3Ir?=
 =?utf-8?B?ZWpSblQ5czZtbkhHOEJCN0dpd21PaC9WL2xiQjZ1WnVVWnV5NmZpV1lqNUdz?=
 =?utf-8?B?TElpNUpzV09BN3FvZ0gxMTA3RW9XaHYwQmNnbjZId0hmbGRXMTIrZTBWd0Jv?=
 =?utf-8?B?R3pnUGtWcDdGa2tBS01SSCtHWVJRSmxPaU1NWjJobEl2RUowSXhMckU5V0pm?=
 =?utf-8?B?SCtDZDhuNmUzNmtRZDZRc0JuZEtHemlHWkxyWVE5eHBoNWRDSjRkZi9oOXNQ?=
 =?utf-8?B?ZnE5R3R3T3czRnI3TmFiTzFrcmM5VEhuc0owQ3hta3dNS3Bld1Q5Y1RBMEhX?=
 =?utf-8?B?WkZnc1NsRVMxNlY5aEJXTXNwc1k3aWpJRE4xTUVoeDFDRUhQT2dVTVVjeTho?=
 =?utf-8?B?bGxkVFk5ZUI5cEovZFNIVEpVUnpydVlzNlA4Ujl4SEUzdmNuRmp6VUxUaGtn?=
 =?utf-8?B?ZUpXaGZodEJ4bDRRNjJlNURXRmlQcjZjU0QvNG90TTNGMVR4djVEOFlKSnNZ?=
 =?utf-8?B?bXV6SHJMRkd3cE40SmcwN0xKdkkyR1hMUlpTdmhvYmkvdnJ3akNyYW5jT2hn?=
 =?utf-8?B?alN5Tms0L0p1RjFtNzlDb05PUjVGQURRWGVCcDNabDBZRjU3VTMvNzNTV3hO?=
 =?utf-8?B?ZWcyQzBzeTVEcmFyVFJHa3hQSXNKSllyS0xlUUYxaUlBQ1NpNTVZMmFaR0JQ?=
 =?utf-8?B?NXYvczRnQVoxNDRZeUxOVUx2SnlMdFRWRERRRmZqc2tqU29uNm5pdCs3U1pY?=
 =?utf-8?B?MFYzVHpFOFU1azNuUmxEY0k1M3pBcVJhR3JaQTFCZ3BBMWlRdUxrSXVHUjRx?=
 =?utf-8?B?akRNeHFEckRMTnZueDdOdmwweE9nUWJpd0VESStZNDhEL3hpSFlvQlE1aG9y?=
 =?utf-8?B?eXN0Wlkyclk3dm9oZG9xaVNXdXZLNVRTT2ZrZjlsbnBxK1M1WXlVc1NiM2J3?=
 =?utf-8?B?MmlrWjlpK2gwT2dTUlJKUzdoWnRzZnlML0hxT2J5ZmwxV1RVbTBJWlR5RWVm?=
 =?utf-8?B?aFIxc0ZJa0Y5cmYrU210YkZUQlhQRXAwSXFVVXBRVWUvQWFKamQwQ1RJcjhk?=
 =?utf-8?B?RHQ1WUFUOUxjZ0tJMUE3ZzJPbUZTZlJnZlU2d28wTUdtMVp1OU56c2p6RDh3?=
 =?utf-8?B?STJ2Z3BZbkFMTWtWTlgwQ3ZDRTlVYmNQRDdxQkZIb0FqZytxLzg5aFZtbUtB?=
 =?utf-8?B?WWd2bHBOMlpHN29BN0l2SXVrZFhyelI5aXBsZC9HYlZVUDhtbFhqVC9uckVk?=
 =?utf-8?B?TXdMR0V3NVl1NHdXQ2RrNWNnTlIrSHNHNThTemRGSXVraXN1WE55bGNFQjg0?=
 =?utf-8?B?dFErVytkcWVUekJlMlZ0YnhsYktnUlA1UFJPTVJ3R0JmY1RJVlhsL3poL1Zt?=
 =?utf-8?B?OVkxVlE5TFVMMmtBTmRPdStrMGU2OEJIZVBKaGt4bi8xVldHT3Z5dXdsSXUw?=
 =?utf-8?B?TEIvZTFOcEM1dW5MQ1J0VmlFUkdTZFZUVkxnTGp0aTBVaFZSY2s5b1JGR0V3?=
 =?utf-8?B?OWRXUHFSdjBIbXB4cFZjSjlMakNwVHVvK3pkejB6a3FvY0wvNlR2T1NtNEE5?=
 =?utf-8?B?U08rUmRiNCtwTkxCaEM4VXh4SXVIbTQzTmJhNzJwcHlCS0ZZWDRIa0FHeFRu?=
 =?utf-8?B?N3h2MnRqNG9ROUVNVm1VcHAvTGVHK3RwM241cUFxZTlWUnlGMkxlTWhYbndp?=
 =?utf-8?Q?V4X78fI6yy1gv8LAyPP/Gd1tu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1450dd20-caed-4eb5-ddd2-08dc6565d465
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 20:25:20.9941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RL3/RZeQJrj9bBqhrbFMUcgqU+PELdrKANzhlgrBvlONghFUTpBUrPwul9lV/dRjQDXLQbQ469Ecb5fl8HMw+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472

Add fec2 support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 3e57c760e40a5..c024be33fbcce 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -40,6 +40,15 @@ reg_usdhc2_vmmc: usdhc2-vmmc {
 		enable-active-high;
 	};
 
+	reg_fec2_supply: regulator-fec2-nvcc {
+		compatible = "regulator-fixed";
+		regulator-name = "fec2_nvcc";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&max7322 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_can01_en: regulator-can01-gen {
 		compatible = "regulator-fixed";
 		regulator-name = "can01-en";
@@ -334,6 +343,19 @@ ethphy1: ethernet-phy@1 {
 	};
 };
 
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec2>;
+	phy-mode = "rgmii-txid";
+	phy-handle = <&ethphy1>;
+	phy-supply = <&reg_fec2_supply>;
+	nvmem-cells = <&fec_mac1>;
+	nvmem-cell-names = "mac-address";
+	rx-internal-delay-ps = <2000>;
+	fsl,magic-packet;
+	status = "okay";
+};
+
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -500,6 +522,24 @@ IMX8QM_QSPI0B_SS1_B_LSIO_QSPI0B_SS1_B     0x06000021
 		>;
 	};
 
+	pinctrl_fec2: fec2grp {
+		fsl,pins = <
+			IMX8QM_COMP_CTL_GPIO_1V8_3V3_ENET_ENETA_PAD		0x000014a0
+			IMX8QM_ENET1_RGMII_TX_CTL_CONN_ENET1_RGMII_TX_CTL	0x00000060
+			IMX8QM_ENET1_RGMII_TXC_CONN_ENET1_RGMII_TXC		0x00000060
+			IMX8QM_ENET1_RGMII_TXD0_CONN_ENET1_RGMII_TXD0		0x00000060
+			IMX8QM_ENET1_RGMII_TXD1_CONN_ENET1_RGMII_TXD1		0x00000060
+			IMX8QM_ENET1_RGMII_TXD2_CONN_ENET1_RGMII_TXD2		0x00000060
+			IMX8QM_ENET1_RGMII_TXD3_CONN_ENET1_RGMII_TXD3		0x00000060
+			IMX8QM_ENET1_RGMII_RXC_CONN_ENET1_RGMII_RXC		0x00000060
+			IMX8QM_ENET1_RGMII_RX_CTL_CONN_ENET1_RGMII_RX_CTL	0x00000060
+			IMX8QM_ENET1_RGMII_RXD0_CONN_ENET1_RGMII_RXD0		0x00000060
+			IMX8QM_ENET1_RGMII_RXD1_CONN_ENET1_RGMII_RXD1		0x00000060
+			IMX8QM_ENET1_RGMII_RXD2_CONN_ENET1_RGMII_RXD2		0x00000060
+			IMX8QM_ENET1_RGMII_RXD3_CONN_ENET1_RGMII_RXD3		0x00000060
+		>;
+	};
+
 	pinctrl_flexcan1: flexcan0grp {
 		fsl,pins = <
 			IMX8QM_FLEXCAN0_TX_DMA_FLEXCAN0_TX			0x21

-- 
2.34.1


