Return-Path: <linux-kernel+bounces-112664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DF8887CB9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D0E1C20A9B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE1F17BBE;
	Sun, 24 Mar 2024 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Wy7qE3ow"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A16D179BE
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711282854; cv=fail; b=MXIXea0qsh8GQiWDpKO6tO0qgAlqRHPM/hjYeccIj4JLkWPkZiTa8Bb4VslSzixpUJqeVt9A7qJocUyl+BjpGefx64PTLUmtdXBXP2obortdOC9B5bTjuME++4Mk4Qp+CzWw4po4mcw95bpLv9Reb0fwzHjV714E6SuHphiABK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711282854; c=relaxed/simple;
	bh=s/cWqj24kjpME4NCiI/Hx6vxW6OsMO093cb3/6nL1lE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=WYI7/G0VPRQxWQLE+PgXAA+DawVa9AohavQiACU/thjqwWmO4RJ3L+msS5jxw3RYj2wbB7r7dvxBgvpyTNG2IEx77+KT/Ne6/qOL6UGRnyFTuWjnjgQypUHH7DGBxiSTRBDRwprO1YIyCWi900+TCprRqrWgdjAHDunbxY7uG90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Wy7qE3ow; arc=fail smtp.client-ip=40.107.20.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1ghJ4stsYDA4OKkXIzii3GP+RZo1n47BEqeQWICPU2GeisuiG5a3+TVEa8Ki+vvqyNtJ0pbcaY+DpsumEj+0U3Y7+OUWBSBPCq31XgC61j4VNuy3TqOxWSEA3FEhBHiL5QVRgBWAalgr6YFiREHJ0EDhJg4BZxpzPwLSzSFiCnLXIbXCJU7c+YmAJN/f+JCNI3nmm3IrVEXQV1Jpe8EAUk1nQlvMK+e2iCJqECdQHrlN58S0QnmnM3l7SCXiv8nKr+yKUWqMejA2Y6KEle2thX5arLyGn1e1Igd7OwZ3XhW6FIcoDH5LNolQMQ8dTNS9n66jAf+RM35jhr8cs1uGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhPASNj3ACADanKWtr3Th9k+TfknSsbDgvXdFKr9U6Y=;
 b=LqB1evqKyJI5ZMb0hARa4hjSJ7q1Puq4RAOjl8qOs7MAZWplzK8gm8bVA5znAX3UJt51LbLuxEkwf5jtONqef+Ob0QMe52oqZ9MoZjuAEftow99qz194YRZlx97ZkHmTvCYFQJl+tcjcIKwdDGoQyflIqKC9TffARnH5Ph5hmmFkPuUVvO9IAcjDwRl2VRHS6xvJN4lBVow3FE69IEH0YUFCb7o0BaxUpM1IBzpc82xkA33m+pzF59VzkMUXhHsulKd+6bIh5PfcNkKjhMfM0+f+J4uDQCfxNj3wkgGdUlHUJ2t+T1B9qNo2MuF3RM/G7vtyCNZKykUhJwNYB/E1bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhPASNj3ACADanKWtr3Th9k+TfknSsbDgvXdFKr9U6Y=;
 b=Wy7qE3owmHyw95LiN7ufc+r/AkO/20HBeFlsDTDbbiBiyONc/M6VsBH6wy+AMgEnE8AfqEt1nnp6u2DYqp5a2dgEMYqCfHQyijM4rYuItUMY3eq1KcMSVSxXLYsHruSL4djcsfI9vYuXtWESApICDTEiu3hHC5Gg1xHS+EkZ3J0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GVXPR04MB9901.eurprd04.prod.outlook.com (2603:10a6:150:113::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Sun, 24 Mar
 2024 12:20:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 24 Mar 2024
 12:20:47 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/3] iommu/smmu-v3: support suspend/resume
Date: Sun, 24 Mar 2024 20:28:57 +0800
Message-Id: <20240324-smmu-v3-v1-0-11bc96e156a5@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIkcAGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyMT3eLc3FLdMmNd87QUw0QT49QUc2NTJaDqgqLUtMwKsEnRsbW1APM
 2ko1ZAAAA
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Marc Zyngier <maz@kernel.org>
Cc: Bixuan Cui <cuibixuan@huawei.com>, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711283345; l=934;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=s/cWqj24kjpME4NCiI/Hx6vxW6OsMO093cb3/6nL1lE=;
 b=fxMEub+XS5omc4TW73HPvKQ/eTvnc7lmm+bnwOgTvvHtTfCcy1DZXGhEaOKNiwiYzF+N6ewoD
 3+/TGjktUGDDfAAz/iNc46rgvlNk4oYklxO/yVno9BV7UxcYpyFAHo7
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|GVXPR04MB9901:EE_
X-MS-Office365-Filtering-Correlation-Id: 2339e18e-03da-4b6b-0475-08dc4bfcd5b5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8RfHnLjLDo2+yrutgmPW1DMASB31A6IKvndd9C70f3uaEQ7aJdSvtqbr4sGo5CmSSFoPeyWI1dJuUGRn4wlDvg7lDoEB57UfEq+X8ap3P5CUfiFMrXmJ67J+idIApHMH/9dYvasYFvt6b2xnHklyzBb7cqaSoLO/6l8BsQvTi0CFh/ljkgGnbbmyLbDNlGIxhkz4U8ersb8DBYhSi9ZkclMMv/WncOTmPOu+PGShJv6WhBTSDZMSwNBwuzu4aW1uxkl44/m0e7aKcdL8EjgaLdSdYEGilmuVdZ9q6I1Q93vP3zpNBLDGaXM6adJhUIKf6HZtsOqWXdy5nSNBvTSh7QJvFOmZ70xzj9PXwyCbGY8tLdfvAX+adfG7TCjlvw1AZC1zY35aPhMlQAVwqgM7iyeaqDGZ3FwSJ4RzGZdzvXxA3ghKBbS+ksM329RY+M8WiKwtqIl2cSIynd8nTypyq6kMN4vA4YfnF9P5qe9ZltScz5Z4CbqfIIakNOXG694uSu+nrEtc9HTDZZh1nAtGZI1wqW0cu42xGiWJCZvxHy9WzsAOjgeuywukhNYR6dyAUJM0AIImu5sdVW/N6yUdN6fY9oMdLlgP4EvWupU9P8Ft9GeEO+Q3rO2ATipsLEl2COQQ28WvJN9lt/oaoDN4mDValuxKEr3Hf67H1AxtQHo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUdzWTFNKzlpNUlwa2dySUZvRkZOSy9xNkRsKzQyVTFWSkhRTk9yT2g3ZThn?=
 =?utf-8?B?aVJ6YnhGcG5MOCtlckJTUEVJWFl6dEpCdXlUWjdMWStqcktReStZbmFLS0hl?=
 =?utf-8?B?VFVUOEl6L2JHQlpSeHRxa0Z4NXRNb0t5Qk1IL0NsbmVMZ2FMem9wMHBOZ0xs?=
 =?utf-8?B?UEhCQS9DeW9oaXlnWHBXVTVaM0JjR2E0YjAyd3hvL0ExQ1JLN3VLclpNaW0r?=
 =?utf-8?B?Z1ZZSmM3VWI5TXQrR2dJWUxvazZvZWdWUmpwV1RFN2FJZVZtaSt5NWlpQUlo?=
 =?utf-8?B?UTM3eUVFYmxjRE5Pdmt0Tyt6dUJhZkFtUGROTmVITVI3Qkl5SDJTaE9BNGJT?=
 =?utf-8?B?b1F5dExXRlptcnFGOWRKa2dDeGdub1BpdEErTWNOWDlyMnB1Q09yTjJGNCtK?=
 =?utf-8?B?ZSs5cGxLRGh2MzlMOStrV0JqUnZwbERZaXVPb2NDeC9nRmgyTE5KU0xDdWt3?=
 =?utf-8?B?K1ZSem9VM1VEVy9rbEUrYURDdWMxQ2tXOGpIQVVGcTJRdzA5blRZTkRzVjFV?=
 =?utf-8?B?eHhOK0pHZjJZQ0tzd2tsL3c0bWRERDVYVm5zbVMwSE1TN3dMYit5aVBtMjh6?=
 =?utf-8?B?NExoMTFMWExDZ3ZyVGdYYnBJNlBCWWV6dzJCRitZUzQvaG5Sc09kdEdTamVk?=
 =?utf-8?B?Q0JXSG9pNUJQcWFpS1A4VXNHU3J5aHZKZHNmOTd1VlhJTy85dWhSUVArdUxR?=
 =?utf-8?B?UytDamRzak1rWGttaHp3Nm5zU1ViNUNzZytBemRhNThQdWJRZGdaTXhUUTRI?=
 =?utf-8?B?T2VMNEZ2UXJEWEZxaVBNTlBLcTlPa2pFTEpoRnR3dGs3clBWZ1diTlV6UHVt?=
 =?utf-8?B?UWR6aGp6Z2V6YWZvc0hSOTExdnpFWE43bHR1UGZQcFFKanE0K3ZyekhFL2c5?=
 =?utf-8?B?UFJtYkNjbHEvQmhBOXkzQWxMUGFTOXFoNFFqU1pmb2tIdXU2TDYwajM1S1VT?=
 =?utf-8?B?NEZDK2F1cUZzTkNSb2JJTFBCbWpiUVE1eWFtSFFZVGdGZlFJRWpqdmhvMmN4?=
 =?utf-8?B?WkV4a081RmFhcFNuTjJzcStRTVlHQmhlV0VBUHZjQ3FmZFgwTUQvQ2gxKzJF?=
 =?utf-8?B?R2wwaUJTUCsvNnRLYkdvMEh1enNPTmtYVHZWNTRHM3FDOWtNcFNORFF3U2lZ?=
 =?utf-8?B?MS81K3RPeG1KekpscmY5UE5ORFNlOEhpQjd2SVUzWFlMNTJieldhYmJDNkhF?=
 =?utf-8?B?L0QxclpOS2syRC8rR2tac1BRcHNZckg2bitrZnVpNjEzU3hKd3dkTHVlWUNq?=
 =?utf-8?B?Z0RlWTlOU2tCRG12T3I4TEI5T0ZxbzZSNFJnZ0MvdHJuTWxwV0h3L2MrOUZs?=
 =?utf-8?B?SE9WZkIyK0dDKzk1VWRqUUo0emV3QVRqRzJnWkdReHJBakVGQTIrekdjS3BB?=
 =?utf-8?B?em1CWlYrb2liNEYwS1EzdzN5MG1yYWwrWndNVmtTNm42Q1AyV1lCWDZzYWRO?=
 =?utf-8?B?eWI5cThWdDdiQS9RUWhYUTR0amZvaXkyVEJxVG1ubFFPMDRWbXpjQXZlSVlj?=
 =?utf-8?B?RXJaZmF2UjhDWEpUNy9aMTZCcFB3TzFESUU3N2JTTWVGaU9FTEJFdHBCK1RM?=
 =?utf-8?B?bXgvczNUODNXYTFXK2tSeTFDWDlwandUSWNKYmdqYjM4Ymg1WkRLejZScWl3?=
 =?utf-8?B?VlZISE52em5WVStzWkdxeEhCZVB2QXRsTTFvSnVjbGNRNXhETU5RQlk4YWJC?=
 =?utf-8?B?NUprWWl4azlJRjQzRytqUGVwdU1XbHNxVUpYem9LWUpjdzZqWXdjc1MzUExi?=
 =?utf-8?B?RzdnRklOeXp6Nno1L2VQRFJWYXQ0NndLOW1TdUQwV2s1SGkzeW9pMGFTSlIr?=
 =?utf-8?B?RHBEeDFlTlN3VVBDYmpPa0VJU0I1VGJ3dHBXSGxqTXdFdndJYlBrL2pNbXl0?=
 =?utf-8?B?NG1NYlNGa0F5NXdYMWFkOTV4ZFBXUXkvVVY2QWFrMk8vNzFTcUtqLytiV3JH?=
 =?utf-8?B?YnduUE1GcDFkUUFaYzNkRDJjQnZLUEVRdkx3ZHFZYkFNTFU1eThyangvSlRp?=
 =?utf-8?B?bFBETmJua1Q5ZFZ6QWE5WHJmTytSanoyQml5SlFkZHJxTXIxb000eDJPOGdq?=
 =?utf-8?B?TW95M2gxYlJJT1FZWVhDekUrWktDbWUwWndWVnE3SlUwQXhxRlB4cHpNcDhr?=
 =?utf-8?Q?t+gT493y1Oo8Ie+Hf3XzSfDkD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2339e18e-03da-4b6b-0475-08dc4bfcd5b5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2024 12:20:47.1260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6b/PfmkFf3X+VftSEZFnQVVb/F6pfeQWCpvSXIw1R5oCUKvcBd1BJ14zhcLQ414+HpP+PO2ORyr2gB6m/5c0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9901

This patchset takes [1] for reference.
Patchset was tested on NXP i.MX95, but since i.MX95 not has SMMU MSI,
so not able to test MSI part. If anyone could help test, that would be
great.

[1]:
https://lore.kernel.org/lkml/20210721013350.17664-1-cuibixuan@huawei.com/T/#m06bf92e2306ba52c106f2d4d24765921d4e9781e

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (3):
      iommu/arm-smmu-v3: save bypass in smmu device structure
      genirq/msi: cache the last msi msg
      iommu/arm-smmu-v3: support suspend/resume

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 76 +++++++++++++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 kernel/irq/msi.c                            |  3 ++
 3 files changed, 70 insertions(+), 10 deletions(-)
---
base-commit: 13ee4a7161b6fd938aef6688ff43b163f6d83e37
change-id: 20240324-smmu-v3-7fd1a43ed735

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


