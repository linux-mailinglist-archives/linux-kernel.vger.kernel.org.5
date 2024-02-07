Return-Path: <linux-kernel+bounces-57246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 922CD84D59E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33DE728EB0E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6B3692F5;
	Wed,  7 Feb 2024 22:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MsSuLiOc"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2041.outbound.protection.outlook.com [40.107.7.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BC4535AC;
	Wed,  7 Feb 2024 22:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707343253; cv=fail; b=C/T2SYbnGonHPH49imoDPQG/IzSEGxnROMUk4BOcLrUQ++lbzy1wcZ/220eaYpntFzjLmdl+N4VjUMIs8/UFzgpqPSx7tlXyzR6JZbH49ZXrvaHGsBzlXW8v04z2eLndzeyPYyQ6yvMxiQwh5+dQ0txwlG2CQMsZ7PIuL25bnGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707343253; c=relaxed/simple;
	bh=ul9Or8qT+jwK2TeYsZYZ2R+FHoVBsgluV8MmtXomwpQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lWfsrLjxRXRPSEtybLOXiwNUBS0t8T1sq4/G/l1n5mNkloyW/fjsE0BOIYIhksp1Tg0jyz/TU94Q1YqoJffa+X6Fh6FJK8lFfAKfbKU2DnwSgCkDtxSUJlMpAWwi6PNTpfO9rB0jkBv4NEa4c9Kt0FO5WvqDhmSlSUN1M08VQ9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MsSuLiOc; arc=fail smtp.client-ip=40.107.7.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Omx73qlowh+fBtaS5JStVpKoN+KsHSkLh+LzWcYs598zSUZF3n9f9DzxYk4fFSUTeYOEaGSaWDSa3AWclY3dQD0LkzT4Cn1f2724w+/0XKl73Q8StWO5/ZkYHOLYT6bK8KeVnoyvRf6PXhaUzWy8Vi0+1rutgDJEl15TdjLkvur19psaTyyHjHbm7G7aPbxTDjXsCYy2Yt7Uw13zffUkVg66aLr83AyMeRPIX62QWvKF3GJUiGHLKmGD+BCQuhGAIO3zFgOyMS+VzPH3re65/v5z86x2gFOWLyih/a6lHEEaAN2jCHYZbGqnRgED2qO55FsW2tzMFS7Fx9WpxVg8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0H3e9iuTkZup/+cOFHYTblxFmtuWoULDapGHoWCu4Q=;
 b=Tqf/hAoFbAZVTReX4t8/vs6RHi6yYBVykl0h8i4BmgryOl9CKOA1/sH1O14gkebecS7eMvJqiRFR/gcpHdnt5D7RGl6QoBCzr3u75wRNqtqzxV+3RcPz9fnklQ/Pd8HH93H0nmPFTVO+YRrumfFI2GnWXnHFh58I/kvfA4GgfNQPPx+rE7/b6v0ve5k7s+EGsaTdAPMo446fIubwiG3NjyjPtAjUq4Bkw4Vj1G9lvtXa4FySgpNnegw6jsDbkaOd6aH6bN8PPScN4gll2KS4rU7wgn022GfkVcEihj/61RpInsNbs/xZZvEV/9njS8wNQylp6QLatWqzQ3F0qMAosQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0H3e9iuTkZup/+cOFHYTblxFmtuWoULDapGHoWCu4Q=;
 b=MsSuLiOcI5wmoJ/NUYFA5DqjI8b/JXu/ZR2HpTF96wGaexK9CSGI619CrZPWXKgdFnlsQ20bI/gCZ0tS8MXiOKefE+aCAUkFOw81c12QbqAOsp27MgenvzqtvqpO0/4Kwyc7ERYUiWthB7967trKwbZyRM5AYli55BhjKwVatTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7789.eurprd04.prod.outlook.com (2603:10a6:102:c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Wed, 7 Feb
 2024 22:00:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 22:00:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 07 Feb 2024 17:00:18 -0500
Subject: [PATCH 1/2] dt-bindings: usb: dwc3: drop 'quirk' suffix at
 snps,host-vbus-glitches-quirk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-vbus-glitch-v1-1-7be87099461d@nxp.com>
References: <20240207-vbus-glitch-v1-0-7be87099461d@nxp.com>
In-Reply-To: <20240207-vbus-glitch-v1-0-7be87099461d@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707343242; l=1161;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ul9Or8qT+jwK2TeYsZYZ2R+FHoVBsgluV8MmtXomwpQ=;
 b=33R07pIoX6cpWqJ6tyqWbIZpu9ZfpWUZIPm1tgxWMqgXy72tITvuAS8t9ym7xQ7LUHOEhlZ5K
 IO1PDB3epIUB5poldyawe4NDxvtGFKyehfOnmNN+BU1xbAnsSOPUEQ3
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c75ffed-3dc4-476f-35bc-08dc28283ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yHAtXFU0X7bDBbnXzKpPB3zSmsiAl4FGW/fCUrAlSa9vCIwjbslixwfVILmdGSNZ2z43njVwjMBpv5X902nPgAkIzRrQJ8PR9ZUDH1Vm2O7Z5KJRc/ijm8Nh4cUounA8MtOJaKWOTypgf15Z8KblQGNjKgMMaUGO5GvI8ziWwuKu/by5fH30hKUco99pxofj2D+K6YPTH1Lk7WPj1Xh109PsIUR4Apql7T+0y11wsJca89ReZdZqVIB32EKyUpaf29RAGLY9EhsNt0xMbauE4321+eTYlYthZzKuzHJ5M3eZSt9iOEKVoORZbQqp0dQJldwCmkXVrG92OAvGrZ1U9hmw+xGiQTQoNNitSqei1TSIATH+6jQe95WRiWxvZGzvPOtw6iGsnEeUTNz/MACepXbGA+aYj/GVrIVqQrAQcdc8yo2gJypD3worJdDKTSLqdGs7bOgGBo3oF106lqskZhLKZZPSgPklx/wcBvWwmMG1ruPNMdRKPtv0bUjRjPeP7X+k77PID6Hd5Fbr73GZ0t/f8Xgg2PyHMwIpuk1W9jmvGmfvzoEu8MxDecieD9vWXoYs8NzGZwtR7Qp2QlEJ8+UR7TUL/yk9CCC4d400snwsxHfah2aalBXca+iYruHO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(366004)(396003)(230922051799003)(230273577357003)(1800799012)(64100799003)(186009)(451199024)(52116002)(6506007)(6666004)(38100700002)(83380400001)(86362001)(26005)(41300700001)(2616005)(8936002)(4326008)(8676002)(6512007)(36756003)(6486002)(2906002)(478600001)(7416002)(5660300002)(66556008)(66476007)(66946007)(316002)(38350700005)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vkk3Q3U2UGtlbjZud1J6cFltZWdBOXF6R1VuRlJTWDFXT2ZCdWNkNmtIUWlq?=
 =?utf-8?B?RHNXeXpiUXFZYy9qR3hQM0pwVkI0RExkMzNmUEd1d2tLVGVLWGlNY1U1dWVx?=
 =?utf-8?B?QlNTb1g4VTRrVkxCbGtwRWlMdW1pL1V5MCtyRUpjMzd1VjVyaStGNUk5K01F?=
 =?utf-8?B?OWIrTkp4WkEyeU84NGFVb3YzdjNOYXY4QmtRV0NpR2NlK25qc1ZwMkVUWElB?=
 =?utf-8?B?KzhFN0FUa3BXSUxYZVNyVTF0YVdlLzZ1RUpuemwxVDBMUHg3Z3JpbDBnWXVa?=
 =?utf-8?B?ci9hQlJkOUJZWUMrTExFY1Vpc2JqUXZMNnlkY21UMU85ZmNlbzZWTEVFTW1C?=
 =?utf-8?B?Zks1SVJJWGxSMDRHaUt2SUx6VmF2MURlS3R5SGVBRENPU3phWlllOHg3SDhS?=
 =?utf-8?B?YXhqWlM3czVyUnNicUpVT0daRVlFaVdLOHVLMlFTSkttcXFVd1QxbzhLNEhv?=
 =?utf-8?B?WFZSeUlRMDRKdDBCaHo5R0FBQ21SQzZ1SExzUEVNcndycFViZWE1MzZqN3Z4?=
 =?utf-8?B?b1dUMk5aemxOTkp1YmZmbnlpL3o1MGVBTWxVVkFMZENjUXZROXUreERJNHlv?=
 =?utf-8?B?YTJLNFhDYVdQQXRKSFROWVRkRVNCZElRR0x5U2dGUExWOTFLVmdhdnhRazNr?=
 =?utf-8?B?Vm9nRG5paTBlbHI0SHg3S2gvWlFYMmM2VHZtZzQxWTI3TktOQzY4MmpzQUFG?=
 =?utf-8?B?ZXhXNnFPd2k2WnkyRWtTWjYvZmdicXpjQisxS3RVZmVPOHZsZVZLUjE1Q2hJ?=
 =?utf-8?B?eHBJTCt0SEtBQTlQempUaHBpcUFMQUM4cVBya3FZVlNJWEd6azFXZk5MR1FW?=
 =?utf-8?B?NmVzNi9RVC9FdEFJbVhQaFVwTTBTVmpqeTM0ZXE4bFNqRW5VSUFVRDdDN05K?=
 =?utf-8?B?OFlXd0RXMGN5T0J4SVJkNmYzV1hTbi9GY3A5dzQ4WEtUMmlQMGJ6aGk2NVhn?=
 =?utf-8?B?S1FIMHJvOXhYUXFHVW0rd3N2dHFrSjdIZ2pHa1pGVVE3N0hWdERxSm9GblZx?=
 =?utf-8?B?aGQ2YVgvYnpqNUkydG1oN1BWRC9mckxIUzEvN2I1SHY0bHFjZHFsSGpSV0pn?=
 =?utf-8?B?eDYza29DWE9SMUU3QTZ1VS9TVG1Rd2RqQXU5dmhiamo1cHdWWXQzaWxMWmo0?=
 =?utf-8?B?ZUVLYVRtVHRyKzAyNmtGSytPeWx3UXVYNFFRZ2RicTk1N3phU0N0RDFjeU9u?=
 =?utf-8?B?VGp4QVNQM3hQTVlPUVozc2RKTFBIK203MmgrVTRxUVhqSnhmZFRmbENZMjEx?=
 =?utf-8?B?dXgwOUdpa3cxcTF2alZGZ3hXZWtlT0dRbzlXV0txenZrTWZQSG5YMEd0WnI0?=
 =?utf-8?B?TWpoNVUzWXlxNVcycVlzQVNSSFFRNGtLbVoyRlJuMlFrMEY4MXlmZmtFOHMz?=
 =?utf-8?B?TUhwYnRJMURiTEJMbXdTWWFrMmVnL1VLeDI1citPclExejBZUmtaaXE4NnFC?=
 =?utf-8?B?VlRKNzE1Ui9WcndzOXk1dlo4YnQzUExidlc0ejkzOTFwZ25VcEJNMTRvSk5B?=
 =?utf-8?B?UE9tYTRvUHIzREEyek5Vc25ET3VLam9MMkFveGlFVUN2VWZieTNiQkYyUGFI?=
 =?utf-8?B?NmtBTmN6QVhNMDVxTSt1cENXSzI3NDVoSi9HdGUxdzVWaTAraHI2SXFabTFi?=
 =?utf-8?B?V29KSEhZVEpVaCtxWVVpZU5vcGdmWmxvUkpYK2xWZktFUnRTSWl6NXVjemNT?=
 =?utf-8?B?MXBBWHpvQy9mN21KOEdSUmg1ZGppc2lzRUx4MWFJbk5LMXZJWER5UkRaV2VL?=
 =?utf-8?B?eTIrakpxcXdvMmxWQVhKTkIvU0JqTzQzVDh4TklBS0JGMlVNMkZYbFBLNDlI?=
 =?utf-8?B?QnFSSCtlVlFLeDI3TUJYU2s0TENnT2FXZG9YMDQ0eEd4ZUFXbnBzamdpNW1Q?=
 =?utf-8?B?bEpCWW96WkxERjAzdkNmR1czQnI5Z0VKbXh4b1ZPMjJBY1FnNUt3cFNYOXAx?=
 =?utf-8?B?K1hqUDhQTGNNSy9LTzEybFlPd0kreWRCbFpxdmVaVHU3TUJMdHNpQXVtNmEr?=
 =?utf-8?B?Nll5RGQ0cXlLQlIrWUdoZEJOdm9QTEpLVk1Xc0J6MVZBdEUyVVdJVHJNMUlB?=
 =?utf-8?B?YUN6SmlVNHFvZjNtcjc3MFRFYnB2bGRoWG1LK0RMV0wyQ2VRcHFid0FyTXJh?=
 =?utf-8?Q?S8pU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c75ffed-3dc4-476f-35bc-08dc28283ddd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 22:00:48.2076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGRV/Q+IT21TDr4xBwXa2GoPmn3Rz0QpHeX3uGlC9vLC++CLMdq1q0zi+3wcpXoS369BgBpg8+Om/VZftUsyuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7789

Rename 'snps,host-vbus-glitches-quirk' to 'snps,host-vbus-glitches'.

Just describe the problem in the binding. So needn't 'quirk'.

Update description.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 8f5d250070c78..6685e6579e64c 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -273,11 +273,12 @@ properties:
       with an external supply.
     type: boolean
 
-  snps,host-vbus-glitches-quirk:
+  snps,host-vbus-glitches:
     description:
       When set, power off all Root Hub ports immediately after
       setting host mode to avoid vbus (negative) glitch happen in later
-      xhci reset. And the vbus will back to 5V automatically when reset done.
+      xhci reset. And the vbus will return to 5V automatically when reset
+      done.
     type: boolean
 
   snps,is-utmi-l1-suspend:

-- 
2.34.1


