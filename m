Return-Path: <linux-kernel+bounces-150960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0928AA72D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A241C20C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9216520326;
	Fri, 19 Apr 2024 03:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QcZBnQFH"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2071.outbound.protection.outlook.com [40.107.6.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B508C17552;
	Fri, 19 Apr 2024 03:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713497386; cv=fail; b=q/PBtdayfdpTTgaAMefb7TUzNgou0gmoU1eGgCi7dSwxXavm2AH3OeOo058VF2Qsh/uBARb+e20RRaHHvmM2uSvt3JFF1/6KrAMt1IQCE0PiWUnedpAbfsOjT4WxkVOapMMb18ntFWbdTGXkK7i+CooHJHQXxjeV+xfBx+w+TQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713497386; c=relaxed/simple;
	bh=ZZxWoJKqd6K7aM8UajXja7mZqYAzMPtibD5VVZYWVwk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Zus57LeDvqztZW2rGGe1D49qBxOgnaXN2Px7CUVhuzG1KTlOx6yOMj0GDx1sHN/0mY/jCFYpLwXAex6ie4oYuKXbpytBXhlPVK4rf1G0nxROY4alMh3SCyvH1kc586ko3mMtMabRCF/7dlbkqEQlHOCJHcyTEfd1+63w/c8bl1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QcZBnQFH; arc=fail smtp.client-ip=40.107.6.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WykhtMwWoJHIbHlqUx+ky6CsUZTbMou9nhM1iGuNDalbe5AMZAckjbZWmkqVr2qJ8r69U9YlQCsBEl11UuRwXFqmfuaUotM0KroxhSwZSn5yNYyXiwOrZl98/e4yYhMmdIfRwnzgcsYGQ2JQWhklVee1cgEKtdnRFqLAKsC8ZphpAjALkVrXzRdc/tGohZeQIxE9YREeviIJG+XUJlKEsjy0vaoUmS1EdQLgsIbA6d6bMPxGzTIE/hYEwgZfxVifQaFrINOYnzy/8pmWp7658FMTyWxFSBOLaLQuQuBu9iaU56DzFY2RUUV2vUR+CyEd1A1Fxztexrsv4pqU9MjF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQk7VAJ6KCLx2mT26CZlgdYkv8T/VVxP5LKqa2hQeNw=;
 b=YZyKTsSmHu7mYIF8W4SRvsoc2WjMCRE8tAjeGcSUOiHYdYEEUNIMvLkXdH/lg4y+jle5V6McWo8XniVlROE9tKTBoAJFFH/nMUSGrZz1ZOWkP2YYvYH+a55ncNkn+S65usg7O/biz+HJ/cEzpvTUVhZzLpS7EWrpBGZlMTEPLxUa4R5NZX5iVx4LRwJ5rT66fCZaV8oC2MYA//uKAFMuaZpMKxjfAkBzFgoN4ac/3voHP6VcFT877vjbrNLO6iAAUi9B1zbKM6IzOrH6mm0UG7ECazL4Bf/VplhXNqi8Cbp0NfTbHu3tL6k8HGwxMSLGrLQYy7bxtaMk23Ov1e5hJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQk7VAJ6KCLx2mT26CZlgdYkv8T/VVxP5LKqa2hQeNw=;
 b=QcZBnQFHuZO7Cx4u+LvK3O+LSeCAs5clkZM2RvSukbY2b7zS3MuPy7GhiR04I0rIezv1SZub8fo/05zCWLg2yciZDvWjfPaXoJXMzXZzPTiXCHoqkR7xa+2OsPFhUPhvLflfu+UWJ7PeXtJgNNIZ//YISeIea3y+f/j3V8XGwws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8802.eurprd04.prod.outlook.com (2603:10a6:20b:42d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 03:29:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Fri, 19 Apr 2024
 03:29:38 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 19 Apr 2024 11:37:02 +0800
Subject: [PATCH v2 07/12] arm64: dts: imx93-11x11-evk: update resource
 table address
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-imx93-dts-4-13-v2-7-9076e1d7d399@nxp.com>
References: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
In-Reply-To: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713497841; l=1122;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=FH8g35tYve4Lnb3pbEjT2iovncc33YnZXMgpBy+eCac=;
 b=ZWtdxmkFUauMpLKQkItp5VCqU9+DX7rewc8xP0i2WUE7n+1rSQVxh+dbHhoi84yWcG1IJuTs9
 u5daOeRF9C7DVZ4q7z3pCYcU3w2CvbMTjgwSCDCwPlC/7vNDHQemiBW
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: 447f05a7-4807-44ac-edb3-08dc6020f104
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WhiaDnoQYydIsMf0Yeg590i4W5k5iaaHEbIAQismxwHNu6jcsdzHiSY9RVH66yu/NZM8m2dwptBA05LCCPwdbCgrhTIO6uedIo03HuRHFBdK9SVZt8L2dujzxAev/QaxksygYTtTwKkMoqqErJ033u616TvOYfx+pIajJVrUu4sLC3O2tg2qY1b+RkFzQccsCE0+MKJKbXms0x5yK6RwaiT3fLuz4bm4FupgRUKG1D0AYJyNrmosiB/yrDfve3YaBMa5QW0jgrWSuW8n/Ggo9WlqpDRL5Fk6d0GmKfypVPPqIqL7sYb7qQYOyGfvHQy7AGeEZFV8holeo55LwowHz3gEqAv+mdE9HWxrnMeFrYaD0VGb3kURGvpWKzPri7l7SADsxCQkS1yhxbpnv8UZl5uOBlgwuEULQC9Ys2kXPJhvm83The7PO9TSKT5y/7Qsnujx3wgKg7q52dpnAhs9sV+rSLyWnq+GQSjId2XWKKHG6q1cx+NDIsOv6hopfwh2RsmParJDDKZ1b7jlnXSmwqpGE1EvV4ezkPEv52/EawspzAIPc6cNdnQPOcd6Eg1nElHbs5cO4SgYhZmzi8AQy0i1vcsWHTxAZKqhEnMNZp2OX2eJDjKlAt6qXUdmHbbT+wSlZWWvuqVXMlTyJcQ8fYI5I95EiI+N542t8g7OMqK29JkFYRyWTDE2bqispINNIFv9rEG/bSapq56AwHCaHc5fpEofkk1cRUmFQzjdYZE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDZjL25ZeUxkWWYxSHl6QWI3c1FaUzRjclZycngvUEtKdURJYzdnSnpXR0VJ?=
 =?utf-8?B?ZmkwS085eTVmSFRiVHQrTkNaVjh3Wks4YzBkQTlESktWbHNORC9aU0xmeUM2?=
 =?utf-8?B?ZDZranV0V0VwM3EwZzlmRDBwbU9qYmYvbHVEeHI3SlBsWTNiOTNaOHBMSkZJ?=
 =?utf-8?B?cnpkRWlrUnhTZU9BQmo4c2dNdU5YNjBJSkJkclZ6T1N3eHlBZGdZcTM5NWxX?=
 =?utf-8?B?MnZMMVhmTEhXRjFXQ0FNTTJWQitHU1pKSmx1SXJMckR3RXFPbGtjV0Nscm5R?=
 =?utf-8?B?R0RmWndBU2QrM1g1RDBhNnQxd1FnWTJCRkkzWjVrR3lRK1J6d29PbW5zU1hN?=
 =?utf-8?B?NmNNSnNPdnJHOHBVOGMwR2ZyRVBndzJCUXVKeDhBSERpdTAvYjFaL3VtOUg0?=
 =?utf-8?B?dGxhQjBjbDFOcEloNGd2RnhmVmVwWFB0ZzdRcHJoS241a0Rsa0dleFlvUGNX?=
 =?utf-8?B?c1dCYzF6alhPTmJYMXFHVHp4UnNpOVdjcUY0TDAwanFPK1lOUUc4emRmYldW?=
 =?utf-8?B?b2hjOHZTZHVndXhGc1p1QUU4dVNjVkkxQmpyUVR1VXQzK09IYkV5enVia0RN?=
 =?utf-8?B?bUkzVkFiOUxPL3lnTGY4NHVxa3NuUWZhWlJWNVZKc0g2dU4rYW9NTkE5UUky?=
 =?utf-8?B?UGladmgweDY3am5PR1FnZitBL0NRUDZhcEQ4QVBsc0ExV0ppRXF3a2FlTUZ1?=
 =?utf-8?B?QUF2bTFpdDljTWdWRmZKSTQ3c0MvbURMb1dwUExoYysxbzM4ek5aaWVCb1Zy?=
 =?utf-8?B?RWRpNnNCa1BjK2ZvWitvTGpjc055eldqRHQyM2NTYS9LOHhqbXREMmpkUXN6?=
 =?utf-8?B?dTdSNSs5a1pWc0E4RVc2cW5qeGhISWh2WEUza1l3eDdVamR1cjV0dCs1QXhF?=
 =?utf-8?B?QnVreTM2YkYremtmNlNUOWRaSHJlOHJOcjNEUTNJaE9RVjd5T25pWGtxREdP?=
 =?utf-8?B?ZWZnakM2Y0NaeHVPbFM1VUlObGdTOXJnUkxjNjBqUDNWQnFNVzgvbXN6akJT?=
 =?utf-8?B?N0FoVk05KzhGc1lTRE1peUNOOUVtTzFFaldOUkRTaUh0VStEMzJUQTR4TzM1?=
 =?utf-8?B?ZllILzlHWG5FTnhyNzlXbGVzRW5TZU9kYjlCODlkOHdlYXMzU0VQRDJOMCtM?=
 =?utf-8?B?a2p2K2VQM0JhaWkxSVU2MVlOOFlNcWQ4MzZ3VzdaeDJhdFZvbmRuYU8wTDNt?=
 =?utf-8?B?bmRGN2IxLzNaVzFxVlp6TWE0TktiS2xBcm1yZkNwYmp2RW9ILzFUSFA0NWpv?=
 =?utf-8?B?L3hwaFdla3gwRERGRkJGem1EL1lSbFJDZDF0VTZCbDczY2dFUmk2WllmL1RW?=
 =?utf-8?B?UnJyOUxvK2tNSnRQcjFzTE1IWFRVOHVOWUhVUmFVd0pWSGdhTk02OStGK2Rs?=
 =?utf-8?B?eVY5cUxKUm9sazg0S0V0emw1aHdsdnUzc3ZKSTZINzkzK3crMm5ZejdhSTFM?=
 =?utf-8?B?WE53L25Nb2IxQkZEMHljWXRodytVcHE0aXk4ZW1IUHJ4VUlHMFRuSzM4UTJX?=
 =?utf-8?B?SndJc2JTMTY0WFlqZzgraUtXanpNWEdIaHFvejlJR1V2aktieWJyREp6enJy?=
 =?utf-8?B?VXgxTVp2M3E2SEFYMnJjRWQvRk5CNVZtL0p6WWk1TzNia2MyVmJ0bUQreDc3?=
 =?utf-8?B?VTdGdDNtODJldGpnQ0V1M0dQZkp5VG4velB4YVpzQmdFa2xmaEVNeXNRbmxL?=
 =?utf-8?B?K3ozcUZabXllbk55aENlNnJiRFhIZ0hUMU1WUGprVDFYeXpzeDlEK0tJRlZq?=
 =?utf-8?B?Rmp4aU1wMkpaZ1JlOHZBcVFUMy96RFZNWGhsWEl2RkZ1YTkzWml0QnREMFJa?=
 =?utf-8?B?MENhWVIzSTBqTUs2VzM0UDh1RXZmdTVqS2d4WlN1a3BsQXJiUW81cDZtMlRw?=
 =?utf-8?B?eVJEQUNoNldvQmlYRWM3QzdhdXErVzN3VzJnd1Q0Tk82M2dDTCtrWmM4Nkpa?=
 =?utf-8?B?RmFldm5pV200eitEd3h3R2M2TXpvY01JWnNEU2p1WWZnUnUrY3BhV3ZIWnVV?=
 =?utf-8?B?TUl4WWYwS1prdVhtM3dYRzNtZmVxQVJxU0xRUit3UnFTcXZ1VVNQNERSQ3B1?=
 =?utf-8?B?QzI5dEdmK0VwbTBGa0w0ZUpzU053RFZ1SXh0dVJMQ25pajZsTHNPUWZGWGlL?=
 =?utf-8?Q?uEKT5VhqnNcDvfmDzsj4BEa9C?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447f05a7-4807-44ac-edb3-08dc6020f104
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 03:29:37.9535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aribhvfw1pq9KUwKpsryPdjuHnTauSLA6eDorw48FZvgNgHkKJN/GQcE5KWiVgko/GQ0UNFdpvSumo9hULaWPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8802

From: Peng Fan <peng.fan@nxp.com>

Update the resource table to avoid conflict because iMX93 ROM use last 4KB
TCM aream. Also correct vdev1vring node name to align with reg.

Fixes: e1da729459e6 ("arm64: dts: imx93: enable CM33 for 11x11 EVK")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 07e85a30a25f..b7b52576586f 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -38,7 +38,7 @@ vdev0vring1: vdev0vring1@a4008000 {
 			no-map;
 		};
 
-		vdev1vring0: vdev1vring0@a4000000 {
+		vdev1vring0: vdev1vring0@a4010000 {
 			reg = <0 0xa4010000 0 0x8000>;
 			no-map;
 		};
@@ -48,8 +48,8 @@ vdev1vring1: vdev1vring1@a4018000 {
 			no-map;
 		};
 
-		rsc_table: rsc-table@2021f000 {
-			reg = <0 0x2021f000 0 0x1000>;
+		rsc_table: rsc-table@2021e000 {
+			reg = <0 0x2021e000 0 0x1000>;
 			no-map;
 		};
 

-- 
2.37.1


