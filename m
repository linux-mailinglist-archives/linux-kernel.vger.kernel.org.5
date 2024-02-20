Return-Path: <linux-kernel+bounces-72708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FEE85B7BB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFAAC283741
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0E6605DC;
	Tue, 20 Feb 2024 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="iRZ64pif"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2128.outbound.protection.outlook.com [40.107.21.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216F75FDB2;
	Tue, 20 Feb 2024 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422001; cv=fail; b=Q0FGNE29RA1oZiW5t8Me+s5R3GNq7jLLjBLOBk/44uH48jQkb/bYeta4VXbbl4CgkUDqVLrXNlL0LaUKgzUEp9BpY/Aiqxuns6ZaC6L31/DbYRtqO9Knw4dvbMn4DcMVy6rQgwOKaZuRg92cUQWh0jcMIJrYzs7K4THznizxRHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422001; c=relaxed/simple;
	bh=SSsiyR5F+baV5Wa4Kxv1QNdEidSQJbzpUuAR4CTA43w=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Ux8tNuIo3t4i8A9FWy0VtlUMfxqp2JL7a7qL9XRnj3z1Hc2WobKb96ZLnTfE902HzU9+APJpWxB1C5E8al3MAVTkqUqZYPpVgbz4M0QwJRwOtmMuD7g1GRAAKRyrQj08+Gd1wLpBPjpgoOae3h+HjlEFpIq+P76Zx9Xi1pb00w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=iRZ64pif; arc=fail smtp.client-ip=40.107.21.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPCDV78F9jqojCELD2ld+FCEbVWb0qfIBuDwLRsaWOF01kDX0wXxlhL+WbuXrpnh2rV8YK4SOyuIWIt5EljJpklutgzmBpgIfXL1KgErKNSCWD47SMBcZ7VpdCCYrwrA+6oXa87R7+P9+v0FfsuWQrYmmR+gp4ufkkeLXBuYPbdAepunz4Boetzs2SLf+nc34uB1k9kPCQ1OIzFcMeWNYPypnl7VU/6of0lONlszr6FNHCvJzDxp4+UXe1Un+PH1tR7r/1lhYEI5zHt9CUDZQMObgXngszNjMsBvwLKLFwxJhbXcn+mqkTEkHry0obmivMfdtLbPzzDliqTBAcOqgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiaN7W5eiyPC5VUvBvlFHU/wq4/L3G2u5D+qOHcU4BU=;
 b=O2kSNE0GCcWDHhY48XpOKfmaXaRUnSJ8i7HWuV/Dqgizo1XSPvCl2qVcY0GYa+kH4q14ewSpwcaHsRqOMJEUZxyFswdREG9AFZLKt5bS/Qhi3/JG2J9kz2fPPfVbD4c6IYZCxEi/5Rzsk/gUFTMlocfWmdxOr2pYcz9zzDoyX2tNImq6yLdvLouAJ7c5VN5wRNhOALZEQTg/qYK076uThDIzujUBTrxoqbWr83pqXLvfb///senZkE0pJlpADZ/mLSSeK9gl1grGWJ9NJpRG7PcHE8Ys3XbRULLa4wr4+j4ppK3zZfZaLcIzZvP6axoDkg2nKKpuM2Qh0Y9wzSWxXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiaN7W5eiyPC5VUvBvlFHU/wq4/L3G2u5D+qOHcU4BU=;
 b=iRZ64pifm7lqhFysipYQG+gx3yR9FsLL3Zj0z6DJVEeCyDP64H0AOzq238Y3mok7kIKicuPRFlGTpNnXD+SWT9rdRIwGsJvGrViftsHRs2FVG8E0Xx9TcTyRbFUN+WSHLg99q84XWN8y/EyMQMc/IqWg9+6lSMvUfzWyRza2els=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by DB9PR08MB6763.eurprd08.prod.outlook.com (2603:10a6:10:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 09:39:56 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::7409:db60:8209:c9f4]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::7409:db60:8209:c9f4%6]) with mapi id 15.20.7270.043; Tue, 20 Feb 2024
 09:39:56 +0000
From: Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH 00/14] media: rockchip: cif: add support for rk3568 vicap
Date: Tue, 20 Feb 2024 10:39:10 +0100
Message-Id: <20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD5z1GUC/x2NQQrDIBAAvxL23AWjJsR+pfSgZq1LqRENUgj5e
 02PwzDMAZUKU4X7cEChxpW31GG8DeCjTS9CXjuDFFILKQW2GRfct8wey1tN84KNvc3ojFPBGDk
 FraHXzlZCV2zy8eo/FFfGNqrL5UKBv//r43mePxv7mtOFAAAA
To: Mehdi Djait <mehdi.djait.k@gmail.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Michael Riesch <michael.riesch@wolfvision.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708421995; l=2934;
 i=michael.riesch@wolfvision.net; s=20230803; h=from:subject:message-id;
 bh=SSsiyR5F+baV5Wa4Kxv1QNdEidSQJbzpUuAR4CTA43w=;
 b=4Gt2zT7H8uLDKAB1s7mcmlCld+BsMMgsMSMLMdVL0jA9wOav2Nx4y/HzJ/o+7OSLNr9MqSrlp
 DERkXmFTThEAuviKmHOqoC5o2nUovK/blJsbu6CZVTaJEOong60CFIm
X-Developer-Key: i=michael.riesch@wolfvision.net; a=ed25519;
 pk=9ral3sulLe95bLcbaiNXTgUTRiBayRBEFZ5OVIEHp+0=
X-ClientProxiedBy: VI1PR04CA0128.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::26) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|DB9PR08MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: a4661655-c3f3-4491-77f8-08dc31f7e5bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t19GDH34ejbyJn9s/RmngRzYVgJbXgkWU2sJa9vzgGcocEunlRoNet4sIZk+PnEVAG20dWJB4ty5TQqJsT9dYKIfsK8oR+bokVJ4Yi6BckAvc5HflmSRzEfkq+wW4WQ/WxdF1JxmarGW32KFiln5NKrgPBUXd0buRPH6W+W76dtZKO1FKC1kry7as5A6YdFXWy2lxuLTpglILvI8I21QB9kpRn3gW6As1xhCdZZIuLTPuZXmaHS0dVGllZEQAHgI/ibe8ow4qkGql3HICfvmcoImUItgC2GyIjjDi8oQdkqKjZfJGtxQygPHqrfXRh2Tw/9iE4A3O4ABtCc/jOjQmW6YSpm2u3KlK42bWKR0x9powmuodsFaai7Ou7eAgvuRZECymQ6kAcNxbLL05gc+7czBfOzIJz2SEwocyNWJSMcRJ/j7fU9YSiKxE130n3lbl2vShMQvv8qfx+xeZh6GNsTxLxUWPClfyr32DeBBU3fl2JYv2smqO3Vo16TqrnDvFIo3jMi9mFmJvfaJ4Ce3KpDo0FFaV/p/Dpoa1KlG6oeJU7MlVw+HOqHV3qlHtZvOTCn54QiB2F1xdIMXMxyfJgNUTt5VhYDcHOPV8EkEI5Tjtbe6DEW9JPNY8OPOB2no
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVlCNENOUnJHSFh0R2VVTEkrQ01mdVVZVlZFVmE5d1NaQzdMY1hWWUU1andu?=
 =?utf-8?B?dDR4c25pUWg0ZWZ4MTFXa3UyckRVSC93LzFia1hlbWZDcDdTV3dZeHB0MWVz?=
 =?utf-8?B?NTBJZ203M2lLeVRLMVlRZm1GOWFrT29CWnVkVWcwdWp2WWRjWm9DQTFQN0JR?=
 =?utf-8?B?ZktXT0l5WmROVGs1dm1GV3I3bTR5M2JrbFN4amNvZjU3aVlQTVdhVnhZWWJv?=
 =?utf-8?B?dEpWekcxTHFuT3UwOGwwWVc2R2dQL0JaVWhaTUNRT3pLYmUvdWpnZitpRWQ1?=
 =?utf-8?B?OWZUZnpUL1ZsMGVyVVB6VDUvSHV6S2xpdXBnWGJoRlV5UUdwMFZwS2p4ZjYy?=
 =?utf-8?B?Y0dBSWM5VFdrd3E3V0w5MktKVnNJNm9pckViY1BzMmdtQnIzQlozTzBKUktS?=
 =?utf-8?B?Q3hScGVmSFVuZStoa3E2WXNiZU9BVHcwQndCUWR1SWZrZWhwelExN3RoUjdt?=
 =?utf-8?B?R2pURUw3TGs4dnZrYk94cjliVVVYandpRjJDM1BBRndvcE9pQ2NzbENzeTBW?=
 =?utf-8?B?M1Jud0poYVc1MTV3SlpoejlzWjRVc2RoRlpOWHJvZENYYm9iV2UyNS9hdm9H?=
 =?utf-8?B?N1RmdHVEVmxIK1dGbmsweFpWaWd5b0owMkVEZjFwdlVKVWdhek02QTBCSDVK?=
 =?utf-8?B?YTlzTWg1WWVTQi9IMFVGbG1nVjFhdUxWSXJvN0JvZmppUllhZmZoU0dyelor?=
 =?utf-8?B?YWUrT1NJY01BTUFLb2huVlZuM0s0Z2NJTEJKZWtMbUY3b0ZacE9CY0w3dFlY?=
 =?utf-8?B?ZW5SQU5TR05yMWZxcWFXaVdGNGs0K2YxQ2YrT3JhUUtraDFxU3BwTmJ5RGtK?=
 =?utf-8?B?QjVYb2huU0k4ek1QYUxrVmpySktDODNMZEE3a0h0TURjYVBiR1RVOWpoK2JP?=
 =?utf-8?B?U2JzaEFaUkJncStQajdoM1dzczBmQ1NtRjBPQ2VEb1d3bnQ3Y2VjMTk5akll?=
 =?utf-8?B?c3NnU1VHZFhraWdLUHdKc3M3SGFHNWlVZ0p4dVk5aVdFWXY2MWNERmVoSWdB?=
 =?utf-8?B?aWJoaGlYS3FSaFRtV0tkUVJHTlkxR3ZUbU11TmNsMEREaFJmbXM5WXJnbzJY?=
 =?utf-8?B?am1rZlVxRzNUZHlaNzIxQWkxbnAzcGtyK05WMnNiOUtHano3ZndCN3M5Zm90?=
 =?utf-8?B?eHNDdFIxdnl6N2QxdGx5VFZhMFM3TEE4ZlpIbFByQjQ1OXlBM2dWV2h1aCt0?=
 =?utf-8?B?YTJjWmR1OTBJM0I2QzR1WHlWdUtYNzlwVnpTOVd0YnJBRTdlOTF2SWdLZEMx?=
 =?utf-8?B?aUNjeFc1akdqT09xTWRGY1ZUVG4wNC9nYlU3Z0k1ZVUzMG1jN0c3eUZrY0Ft?=
 =?utf-8?B?TGJRMHBuTkZKQlJleko1eVhOekViYlhudmVPMkc2RVRUYlBGWWtXZHl6WWlV?=
 =?utf-8?B?QXhFNGlLcDJtRnE0aVMxbnk4R2E5L01heTFqQi9CUmVzaXRzRjczQnp6aXFz?=
 =?utf-8?B?YmFzUWp3RkRPd3ptRnpSVWlvV1RVTEwwbWg2ckRFK2lxenJpUUNXZ0N5a2hM?=
 =?utf-8?B?Vm9CcWFSL0gybmdCNzQxMkgxKyttTXJxTWMvNnZ0akFOUERpaVFmb3NZekpw?=
 =?utf-8?B?eXRqaHJnV1hZVmplTVQxV3lOMmVRZzNjZmdaby9wRmI5aEF0Y01EQVIrUkdq?=
 =?utf-8?B?elh5MWllcXc5T0s3MUdWcFY3Qno2elpxZnlqK0JlS3EzQlJPUjg1UEhSbTZK?=
 =?utf-8?B?TVZvOUg1ZGQyeEpOMWxDNFBndEpUbmMvRlVsWHQrR0Uzdys2eGYrQlU5NWl6?=
 =?utf-8?B?TktiNkU5MHkrY0pDVDlIL0VPU2NlaFQreXREUE5rVmN3MGJ1eUc3TUpUL0Fj?=
 =?utf-8?B?emo2RU5JS1RXbmViNG9JQTFCd0k2QkJ1aGc0QUV5Q0ZuN0lnOEhGWlFjOUVk?=
 =?utf-8?B?T2JLMXpNejNCYjFRYXZHR0VsNmg2ZEdpRkhnUDZ5WmlyeDZBZmZucnNIWDlC?=
 =?utf-8?B?Qmt2dHUranczWGNFWDVRRkJVeGdsUlFpNGFZQzRBeDd5aXhLWnNPT0tuYVAv?=
 =?utf-8?B?MUUrMzBwSGdhaHVNUFIzY09HV0VhZzYrMHNaR2RkSkI0Rkd0R0N5ZHNqaDVB?=
 =?utf-8?B?Sk9pZ2t3RENuRjlxV2hYd1RDR290a2hXT1hKenRKaSswZGY5UVdLY1U2VWFU?=
 =?utf-8?B?MXl3TnJJekF6dlkyMHRuZkZ5WmRkZkQ2YXc2UVNvYnhOd1JDWXRncGV0Y1pq?=
 =?utf-8?B?M3c9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a4661655-c3f3-4491-77f8-08dc31f7e5bd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 09:39:56.1474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezrTDzn7lypNij9mtyqJgOPbIdHNs2bZWUkaEtWT9O74z8U8g4/OvvGKOjB6hDWuN/pETlxx3SmRKjCGwkXTXUzsp7KOWHyrvfa+f0qDUTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6763

Habidere,

This series introduces support for the Rockchip RK3568 Video Capture
(VICAP) block. It bases on the work of several Bootlin developers who
have been tirelessly submitting support for the PX30 Video Input
Processor (VIP) block for inclusion in mainline. The most recent
iteration is Mehdi Djait's v13 [0], which is a prerequisite for the
patches of this series.

The PX30 VIP and the RK3568 VICAP are similar enough to share a common
driver, but there are some subtle differences that require some tweaks
in the submitted code.

Although the v13 patches are still WIP and need some revision, I have
decided to push the current state of the art in order to gather a
first round of reviews and comments.

The patches are functional and have been tested successfully on a
custom RK3568 board including the ITE Tech. IT6801 HDMI receiver as
attached subdevice. The IT6801 driver still needs some loving care but
shall be submitted as well at some point.

Looking forward to your comments!

[0] https://lore.kernel.org/linux-media/cover.1707677804.git.mehdi.djait.k@gmail.com/

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
Michael Riesch (14):
      media: dt-bindings: media: video-interfaces: add defines for sampling modes
      media: dt-bindings: media: rockchip-cif: add port definitions
      media: dt-bindings: media: rockchip,px30-vip: add optional property iommus
      media: dt-bindings: media: rockchip,px30-vip: allow for different variants
      media: dt-bindings: media: rockchip,px30-vip: add rk3568-vicap compatible
      media: rockchip: cif: store endpoint information in private data
      media: rockchip: cif: fix formatting of find_output_fmt
      media: rockchip: cif: use port definitions from new header file
      media: rockchip: cif: add support for grf
      media: rockchip: cif: add variant specific input format list
      media: rockchip: cif: make scaler support variant specific
      media: rockchip: cif: make register access variant specific
      media: rockchip: cif: add support for rk3568 vicap
      arm64: dts: rockchip: add vicap node to rk356x

 .../bindings/media/rockchip,px30-vip.yaml          | 110 ++++--
 arch/arm64/boot/dts/rockchip/rk356x.dtsi           |  45 +++
 drivers/media/platform/rockchip/cif/cif-capture.c  | 172 +-------
 drivers/media/platform/rockchip/cif/cif-common.h   |  33 +-
 drivers/media/platform/rockchip/cif/cif-dev.c      | 434 ++++++++++++++++++++-
 drivers/media/platform/rockchip/cif/cif-regs.h     |  56 +--
 include/dt-bindings/media/rockchip-cif.h           |  12 +
 include/dt-bindings/media/video-interfaces.h       |   4 +
 8 files changed, 652 insertions(+), 214 deletions(-)
---
base-commit: b465b3c117718e5b8f4f3100d6ee780f7dc7b59d
change-id: 20240220-v6-8-topic-rk3568-vicap-b9b3f9925f44

Best regards,
-- 
Michael Riesch <michael.riesch@wolfvision.net>


