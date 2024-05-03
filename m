Return-Path: <linux-kernel+bounces-168371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356FB8BB7A7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 542F7B2334E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE328126F2A;
	Fri,  3 May 2024 22:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="eAzZGPxq"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2133.outbound.protection.outlook.com [40.107.101.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFB48613B;
	Fri,  3 May 2024 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775774; cv=fail; b=uqeTrEIVxgBMkIsvJ7FRNzi59YAMjr1txwgmm8BLnxFRKXGthhXv81ziikKv8uJgVr+5KlwbHu8J0bmvlJ2WMxsQO+spw78DvKJs3CDywMZM7Y48304HCV4dHkHm3yfYru/VhW+pzi0lHQ1LlfdxEKvgLvdZwPCuYcpWR572yk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775774; c=relaxed/simple;
	bh=IrFJFH+p8YFvJA0Fjv1eUqv9QBBxKnfgD45+6COcHSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SzYdIEpF4q6yaDCCyVt6GLVGJe4XG6iJRUe0V2KIfJu8ygM78JulJmR8igrYYepPgKpcbQ/3vZDaEwHsMo6d25zA6XxeO2mmf9c1xrQKDh5fuDF4YPSJjpcLB0EIUq9AlookOwneJH1rfgFrybyDk2NgZDEsx71jVVD463Sp2Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=eAzZGPxq; arc=fail smtp.client-ip=40.107.101.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRO+sZNLA+dK0PV2TRxNmRNqb/lSgXig5aNAd0nkPPrLXp+33l8SP4KFvvm45HhJGWGTGjr9O/5qrcg1iTbhwWzS5T3EnY8li04T4WYwN+Rj4sIG4HcPDA91UL9MVO6D/Ma5LtQbC47uD3sM19BP2ilcdVuCBYzAN4btGbvp3FH5peNMsFMvt6+xIce4afqbkOtwkUdVGRywC61Vk2f1+qF2wNWBKl89wkn3aTV4BX+PiJNI/5avd8KgG+eM7IUqy0aC+Z1cwdeM09hZItHxwPfcBu3rn+0Zzs9MAdy89xM91N3ts1DhoVGSzP4V/kHa3QWyna5dGN3AJPWjGIzYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOK2hIBSCeFX/ytEFz8gi7/aXuphtvwYFS9dGChI4Iw=;
 b=fNqtBcFY+gik4+ozrnqM2fatDGZAiD+QmW0mADZVkdB/QwWL+fAZXMfuTl6xhfRWUFAvmAHDQiQZpT79PioNM54x7nznUF44mAVIIES1HOEw+nOtv/svW7zZk5cR00hnXijdxnfUV+plopoNRsa4NrtWBe3+TlLXr+gC2yUMbI+Gw5hjWVlQec0q8EJc96sZOenUupWIJc1O/YTePDgZrNvt925bucJsflau/KVraSpxqCov31A/RjnfqKEcrrmQ6TJu1IicDX/j503oaTfArr0GkfrAmAuKFKNYnuyPbjDn71zSRBWSXfn1hFjFLgi9Drenj5iLkJl6j4l76xMm8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOK2hIBSCeFX/ytEFz8gi7/aXuphtvwYFS9dGChI4Iw=;
 b=eAzZGPxqehSu7/WN+BaBecwG8VBz7/LWdbr4qdiRGSL68qu742Ij9VY3Z6YN77mincKjS0u0G6lYU5EWWfKzrw2PCE+bIrpZKVQXhKqlong3AoACAvR/mbizLOIIyArTk32zAdvM4lz+FjYZ+QS7X4ozl7zr2kxVakrrptPW4mE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by PH7PR22MB3616.namprd22.prod.outlook.com (2603:10b6:510:1d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Fri, 3 May
 2024 22:36:08 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 22:36:08 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH 1/2] arm64: dts: ti: am642-phyboard-electra: Remove PCIe pinmuxing
Date: Fri,  3 May 2024 15:35:51 -0700
Message-Id: <20240503223552.2168847-2-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240503223552.2168847-1-nmorrisson@phytec.com>
References: <20240503223552.2168847-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0056.namprd04.prod.outlook.com
 (2603:10b6:610:77::31) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|PH7PR22MB3616:EE_
X-MS-Office365-Filtering-Correlation-Id: 885d45fb-261c-4dc8-8b9b-08dc6bc16cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|7416005|376005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SRvYFcZKa5fQcjNr3E2ojToJaoDMmBQiS6shnxcv+3xTWRNx4RUMFD4ibf1W?=
 =?us-ascii?Q?fIiHMJuBRx94yiA3qztIWzclexDHd/jUfhuKwfcJo4KianeCebNrSI5uxmsP?=
 =?us-ascii?Q?l4vLS0fTcPcFhRRP4EkzMMm3d5WsFUtpQIl6c1/hJh2MshsB8Yat1TnPImF6?=
 =?us-ascii?Q?j4kepJ+NgqPOZy2EAm57cfQb83ydwTsf3wiqJJdjlqC3h+Q4gqwsNf+xEmVD?=
 =?us-ascii?Q?THtR6xLrX9lu5vPSNlLQxAWkV5vrEiKfQxznaYLw12MPVSDpTSb8iVb/OY6b?=
 =?us-ascii?Q?ROZBn+oKOdk7GX1iEDl0m/vq8yt1cdS4aI+6QI5P/0un0qQHoWsIlRoyT4UH?=
 =?us-ascii?Q?XP23TB78icpdzsdmcJhL5ss74/d2wdy+uh8MlBg7721VZMRIjfj5x+4L82rO?=
 =?us-ascii?Q?gPveIMFarBF9MCc1bWC1v2jGmgMUM3DX9h/NmtQ5R0B+3ax58vlC42W6kan2?=
 =?us-ascii?Q?2Iz5HpdpMe+bSyVDNQ3glSKCiJjjpOO1a0nQrt77Md/go67UVyhI8z/7szna?=
 =?us-ascii?Q?5c7rfxAysLVmvjUkqyhRlQuPu4oMRgwODN5BJzgguzffowp83kLPgPJw43UL?=
 =?us-ascii?Q?q3efvR+/uuBe6lxQJkFeYcpo7695KMdHOIHkxiQnzt4Rrk3w2ycMt/VFZnmX?=
 =?us-ascii?Q?h8wC5YsmS7S12LoDysoSXsnbstk1wurIcPMnU9ue+b3IoHuzuqgnXPa1o21A?=
 =?us-ascii?Q?GoE4+w4UOP8JiYIJYztoKRJrNe/0QrugjmGY2VCgnhbgV6mju6rj9is0+VRK?=
 =?us-ascii?Q?ZLqHGvC+/2Q1s/xH6rE4iRpOK0mM0IYElH03997QPCwFeFB5R5kp9wpO/hXX?=
 =?us-ascii?Q?LyIZOgKU9XJbUGQG8If81Zu3l736ZFU3o+VzGuJ5vs3f++9O6ZXxnb4MJsnv?=
 =?us-ascii?Q?uwO8j4EwkmqimCcd9z7aX1hrpaHGeVd4wIF1d2MS9K9QjqLZfjjIk4iXC8Lh?=
 =?us-ascii?Q?+nB5wt+nTRBtNKt/lzhObaV/uEeET9WUnLsW4RMxcbRPs+DzCE10LUZgBj30?=
 =?us-ascii?Q?pBeJbSp8w59pVecNGePlP4wpnij/s+TtgObBSGHCVlfrqZbhXnzB2DBGhCNb?=
 =?us-ascii?Q?qjfa87EtPzR/8ul5AM+xQK8/T7m+vDmYQYDnfMoCkBjjqrrY06JyQZf8F2PU?=
 =?us-ascii?Q?xqKnLh3DUwl01GHb82ueVEC0TvgH1mbLmD1uEqBt0kiRrav6qyOmDmEnOI9C?=
 =?us-ascii?Q?c/2oNeO17caRdPh+tZAbh+jfXuiMWk4l1L4r5mWJEqNevxuOj1LQp4SPsH7R?=
 =?us-ascii?Q?gCX8mjUf+RtTb2accye401AmtnYfE5+265bp02iEr3mOJ0q7TLz6s+EYPeb7?=
 =?us-ascii?Q?VibaOLfbq6ebZgbc22vmGAnPR3SMyTgBPxTnQFxn8hMX/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7QS3Ry8cFaXDf/ZQ0sczxuuO0s0Zj7ZXGc+AAC2IXuW7e5pB9lIOPNUvI7HV?=
 =?us-ascii?Q?FaPAwMeY2SussDDYLlLEMfxXTuTUjlwJefa4NWf8ES613y3ftg6q9fowvbMu?=
 =?us-ascii?Q?QWlP/Z8uArA9nFmUce6fgVYKpuhG90y/xUqwWxAg4GlaiGahmcKTx9JOMIs/?=
 =?us-ascii?Q?x6cnXj+t1yNwZgubGxhYF6gVSXep1bXFFczX/fKQgXSeeoJ9bSht/W7O0C05?=
 =?us-ascii?Q?wsjQSmNlDlrZaLAIohz9m8iK9e8TmNa97lpk89rgTCwpFJgL5VNl3ToM1Hxi?=
 =?us-ascii?Q?k0CdXWDx5++qADgONUUpk80NhRlF/As/Q5Mcl3ldB0wDiy/hC2nQhltNak9/?=
 =?us-ascii?Q?+iialmQHI/8GKnKkobKyYGqdGPVUZOODPr0I1v/QqbcGI308cDGXleaw5oxK?=
 =?us-ascii?Q?TeHEeouZQRokHdl5GZLf74e72CZ1GRyiyvF/BxeWyufl4gE4OEr3zmq9BWqH?=
 =?us-ascii?Q?b8ZiUfP3883aNJt58nCu7dCxQnXNPIhmxgz/RC6kwzqmZeZJx0yd1/2lM9di?=
 =?us-ascii?Q?oa8McDl9dDEhWMiqNlNygVsY2VSgkfVebpfyCaYcrtWqvBrOL0rd2GLFsd2e?=
 =?us-ascii?Q?dPw09U02pkj0JZsjcCSwfSuRBj9uikKvAiPZo0TZtxhZmz0qpErkDcYsyIr/?=
 =?us-ascii?Q?5bIp+E+xJV981ZAHyhWNuytMrkLJS9RkeeYtx2Wdgfir23BphIWbz6omaYom?=
 =?us-ascii?Q?//+n+6lE6jozQGriNOeFqHzWtXlgc2XkH47usJDONLXRm6PZSAZ1BUsZZHEo?=
 =?us-ascii?Q?aTWtQZ5z4adhkKRU1vHGDmTh1ErK7DbpjD1cirPgSXK///Bquxm7MJIKalcs?=
 =?us-ascii?Q?5NlYvJu7prxc+8Nz6kEH6BPcC2PHqPzqmJi27tXk7rxX1LO9X97GJZT+n34r?=
 =?us-ascii?Q?A1zMRoXf9tuGQNgFJfhWqkVDQ0PzSkLugVz1U+mpKMgCRlXU32d3fAnQmXfp?=
 =?us-ascii?Q?gfdDZNjAjNTPd5fvNecz3c3SGwf7up7OBD8h8giwaD6l+3AycyLBehudZf3d?=
 =?us-ascii?Q?0ZY+XBFGQLWBiF7km1mm7d1d4IOSMZxlp+eUR+jaDOnYOGnc/qbTa0G4BmfF?=
 =?us-ascii?Q?WKJgRFfF5j+rw0VMl0gqGMmEKV7xpFe1KsBVtH/hG0HVspsRJYxWtZ/ufvtl?=
 =?us-ascii?Q?u+3Qt6KiKm3SqPvMS46lSIFYzlrLY4Vlbmpb/YrwZEB2FD57518klC3TV/Mz?=
 =?us-ascii?Q?B03Ko5HqKbZXvQ+LD3x85V+cvivEuuKcHgZvn2TA6uaNp43xwaR9NNxJMPSx?=
 =?us-ascii?Q?88YKaDXX/Cx5IM5xv3pULfbP3a+0kk0zptuG/RfNNxkiHdIHeRhgITFTWbid?=
 =?us-ascii?Q?MxJ297ljHgJdB+YH1nGC65Jqp2U3SytneCQm4cNLImVo2Yyt0wW4f3Drwmdd?=
 =?us-ascii?Q?MdZ1lo1iRsF6zjt8KJkv3IbDa7yEA02kKIgfwfKQ+X6hsNbWztvKPOcUh4lk?=
 =?us-ascii?Q?21gvdUGhZEKA9p4xPEwdgkG9yHDoMAIqP9wXV5BFQRZxwXldXUJYCoD5/ae0?=
 =?us-ascii?Q?+AKZceJ+DJvrQWzM+A8j/SXfPUeEGgl8i6BrSotENum6wZM68gSbi2gisJn3?=
 =?us-ascii?Q?1sXzU1r873umJBTgX4rujVoG0diuxSlGml8ZpgYX?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885d45fb-261c-4dc8-8b9b-08dc6bc16cc8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 22:36:07.9126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WO3pr4WF614g9cgnzSQ3wUzUJqeBqOg1IXOvSW/JbYA1KNow/eYqZJhf7BNnQV6Bb53AzCAvG5sVa5ESP+C6cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR22MB3616

Remove pinmuxing for PCIe so that we can add it in an overlay.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 .../boot/dts/ti/k3-am642-phyboard-electra-rdk.dts    | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
index 8237b8c815b8..58cee0a8412c 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
@@ -190,18 +190,6 @@ AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0)	/* (E19) USB0_DRVVBUS */
 		>;
 	};
 
-	pcie_usb_sel_pins_default: pcie-usb-sel-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x017c, PIN_OUTPUT, 7)	/* (T1) PRG0_PRU0_GPO7.GPIO1_7 */
-		>;
-	};
-
-	pcie0_pins_default: pcie0-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0098, PIN_OUTPUT, 7)	/* (W19) GPMC0_WAIT0.GPIO0_37 */
-		>;
-	};
-
 	user_leds_pins_default: user-leds-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x003c, PIN_OUTPUT, 7)	/* (T20) GPMC0_AD0.GPIO0_15 */
-- 
2.25.1


