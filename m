Return-Path: <linux-kernel+bounces-159130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3408B29C1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EF90B25401
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D3B15350E;
	Thu, 25 Apr 2024 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oaeIXI9G"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC3C156885;
	Thu, 25 Apr 2024 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076722; cv=fail; b=DvNO8s0RhGb9BVEyJ/PledqB7U0ssGXo7l6z8KbpEeGqEuDGSMXHmkD8Y8ecu2Bam4HqPLaziIuTZSlVguOYsQCrAsz1tF2iiqKRAZ2QJzZ/JZz42EeoZiV1quAE9FCEamtqmp8Re0aVWPVZjoC49aX9OXp681VscCJ1CFiI4ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076722; c=relaxed/simple;
	bh=B7Nh1K6fH5lap/DYtq4PngWnZFswFEAuSD/w/w3Kb1o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GYJ121+on27B5lZG9m8yDLJU1VMgetpWDb11/pdy1uqc8hKQxT9Tma7cGWLzg9IUH/su18Dv34CpVy1JE2k+6+W8MCD69JlUhTAcpsJ2loDbdwCfOrwC0n0QcE2XT+//khPSkvJ+T6a54C2F6bIBOJDiPndJFq2U5M+2+jawjVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oaeIXI9G; arc=fail smtp.client-ip=40.107.8.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2X94zcSa1IVKOoeZweoPM0XF2sOeC7bF3aOx09F1upZiOR7zMFHXHhg11oLN0TEDyt0csNWZylAF9owZsAxv1IonIErV66/Fji+BSeV1VPTj7Y77nOBBOsRRKJQGcpkB65B6g5g8m++8RbrmErvCgHi/JV5NcELx9CtpPWW9b4in9Lu49DpUPOPaBUqap1YxXuPrxJbIpGjd+qOkvx3le7c9oX2ucnRVgJYHed0HYemvWKV9OW6I7ycK0dRg1B9htCdvmY3WpYvcOJTYEoxTR2+kVN5J/HjYirTxD3FExWEmR6d3mp/RP7fi6jaJ1YoCT0W7P+lVFVWRRQ0ISYLag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/F5fwrIyb3wOOZMN9+AtpsorSlVS80TwRyoDyHcj64=;
 b=nldCZhlPW/O90HdIFRYgQYsXF0WbYEFPH95SMaFItGAoELkTB9sMSH5NfZ+tI6tV1+zdP85eNzUgs/bjjx055Far4f/5f2N2ns4e/csydaXtPBJG8DlMhR4X2K2w6QX3k6DOKbUYuW39u/vjzFdTtlTgiRu3JXD06ORxMkLkqIJ680QLfe2qbvHHqgrgjyO3/e90TK8Q4U0Vb1gDuTeDfmDhQv310v4WDE0q76nWeDftbuNWLzuolZ9YTabdO4U9PYoc9j20EkBqEBrXHNhmZZ8+1zPLArIfT7H2oalXFsA1qoUnL8jGrqPiIxziYfBh6Jj97/J34oADycp1TDr6BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/F5fwrIyb3wOOZMN9+AtpsorSlVS80TwRyoDyHcj64=;
 b=oaeIXI9GF45o6aMh8YhxYolQGNycPkAb5ToRA9X9qFDSzxVfC38mCOH0RLdQwv1CDyFvWoc33c2IRPZjoYwJyMDx1dYF0JVkig82SVjUzAqczpRxYjNsceTBsYHN55T7gBsXOXGCtmGyIkiBHVZ84EXSQtbr9PxjLZDYeR84R0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7472.eurprd04.prod.outlook.com (2603:10a6:800:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 20:25:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 20:25:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Apr 2024 16:24:42 -0400
Subject: [PATCH v4 06/10] arm64: dts: imx8qm-mek: add cm41_i2c and children
 devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-dts_8qm_audio-v4-6-7fa6ab2fd64e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714076687; l=1308;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=B7Nh1K6fH5lap/DYtq4PngWnZFswFEAuSD/w/w3Kb1o=;
 b=3wn+5kf2+OV/5Vlp7XaO6oWBAJKB1LspSRnPYr4xgJQHUZHmMi6IFJAtYUT1Z5B7m0vwnwB++
 q7Cna4rSi/cC73QxgrVol+mnU8CZSIpZLhWDzDf7ebCci42Kk+yc6Ko
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
X-MS-Office365-Filtering-Correlation-Id: 9904bb1d-155c-4fbb-47c5-08dc6565cd0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|366007|376005|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzZQbGdxZzVmWTVhdVlVdXhIWE9OWW4rY1BRV3BGVXo3THhUVTRpYUo4WDRN?=
 =?utf-8?B?NkRiM0RDUkVJZTVxdnFBc1FZUTZkdEZhUm5OTm1weGtqbnJRcEVuNm8wbTZu?=
 =?utf-8?B?bkNSbXNLdmRXM1RSR3hoamN1dG1hODZvN3YyNEcxbTFYd01GenFSSjJLTmVV?=
 =?utf-8?B?L2x6ZFhJZy9NWm9iYWRQT2dxTUxCK2c2WjdISURUUjNOQmhXMTJEbFI3TVVt?=
 =?utf-8?B?aGkxdFhIbXNJU1lvUEIvU2VTRHBlSVA0Y2JCL01zVXpvdlhSQUY4VTFtSjNt?=
 =?utf-8?B?M3VDV0psT2VDL2s3T3EybWxZM2ZQZGpNTUtOZ1p3UE51bFNiWEVKMkQvY0h1?=
 =?utf-8?B?S242MmE1Y2pGZkd4SGwybXJDWXlJbmQrNlZwbWNHM3JYOFRUQTVnaFFmM3B2?=
 =?utf-8?B?cjBoY1k0NkdBV2t2cTk2aDdGUVhFZytpMEpjWnBzbEFxekFsUFN2MklPbEE2?=
 =?utf-8?B?UEkrVklSMlorNGdINXdnS3NrZlBDb2pDMGlVYjZmb3Z6TmxKUnFKcUdueHh6?=
 =?utf-8?B?UDM0MFpLMXdQZUVlc3JaaWlxWXh0UEl5WFQyV0ZjVTFNaXJIS040Rkc0ZjY3?=
 =?utf-8?B?czBLMlRIRGNYOXF2bjZhSFNsWFpIb09NYU9rOWxZdHArZEJlTEpRSE1kelBT?=
 =?utf-8?B?bGJsQUFNZmFYVUtCdFFWbkNQcDBiQTFwWU5JeHMrWmpuV1R6Vy9HYUY0UHhW?=
 =?utf-8?B?OEs4Z1BzMjJpZktXVnNvMmtuYUZOQW80MGVUZDVhSzBsYnhrWFZaM21Ha1NC?=
 =?utf-8?B?cExvTGw4bnF6amtKKzA1Mnd4TFpsdjc3N3Y1dzVDQm5aMnViNjB3NktEWTdw?=
 =?utf-8?B?aHlMSVAzRHBteUtUM2JkbGNQcXhmSDVxYVB0Nmord3JnYytLeEhidEIzQ2dp?=
 =?utf-8?B?OTNmM1d6cnFRSys1bGtrOGtlajRteGFITWMzU2pNQWxUMlg3MVNjMXhDUXpP?=
 =?utf-8?B?NUdzQWNQWWl4VmMwSUx6SXdGcnBlMlhHWlpIL2VzZmhyV3FqUXo3aDBEVkNR?=
 =?utf-8?B?d3Nrd1JpcFdXeHllaFFDVTBrUmpWb1dhZmd5NjJQS2ZVZ3dLamZUZGxTaDg1?=
 =?utf-8?B?RXQ5ZEtZOUl6ZllmTDBnNGJYcytRQkVDbjVhUGtUa1htYW9RekQrMGIwTUpk?=
 =?utf-8?B?S29taXlDZ1NKU3dXaEM1a2crUzFDRnJ0d0xWNmFYVncybkZUUUhCUkd1aUt6?=
 =?utf-8?B?anNPL0IvRSt2c2Q2MDErTE5nUjk5Y05QSXlmVlcyUU84K1dxUlNIRElFNTVq?=
 =?utf-8?B?OWJpcFhacW55NEUyK0EzZDc4dzVFK0NWM2FIUFk3QlE2SDYwTWtySzlhUkYz?=
 =?utf-8?B?eXVzQ0JJNWI5WXFNL2tqbVVHblNSSm1QUXBVYmZxZWxvNklOMEhRYzdMcW9Q?=
 =?utf-8?B?V2pvZ1hOVlZqUFVIVnlRbmNwZEhTdXozQ0JLR2VsNHVrQnBsOE92WkM1MGV0?=
 =?utf-8?B?VmpwWXJ1b0lNYlAxOE96M3dNSHd1NFd1ZXAyUnIyL1ZhUUpNcVdUK21ZT2Fn?=
 =?utf-8?B?eE9BQ2kvT1h3b0NXNXNIMUxCa3JwNU9vdmhZZzRYWHdUOUtXczg2NDdXSHpw?=
 =?utf-8?B?Y1ZibFZjaUFrajBmYkJHQlRldlIxdnhTVHo4eDVKYW5JTWdhNUNpbEs2MUNE?=
 =?utf-8?B?UkgzWExHNjJoMkJ3V09CZU9rT3puRVpwMFZuZkZsRFVKSHBVdWhwU2VBUWFZ?=
 =?utf-8?B?SzlWQUpNckFxZWxrMWFwVklDOEpzN3poWGtPN09kZUQ5ZnJveUlHZklhZ3d6?=
 =?utf-8?B?THN0cjhTbzFFY1g2ck1RWXRyUVpqVmxVL0FMWnhyMzB2a2VNMDN3ZVJXUnpv?=
 =?utf-8?B?Tml5MDQ5Rm5sbDFKMWxLdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MndtMkhhKzdNWU0rendpQnEvVEx4MEhlWnVoaVNWcnZ6aVFGZElRcldrRC95?=
 =?utf-8?B?RUwwdWxRVFBYVTMyVndWeFBoOEhDOHpsTWpKZEdKY2xuUEdkVWZHWU0rMDhR?=
 =?utf-8?B?SW5QL3JUbGlhTWRGMFdhcDZCLzNEbEQ0VTBaOElVcUd0QlplQWF2MVVxc09w?=
 =?utf-8?B?VkJ2RGJnMy9meXBJWkZNTHl0aXU3enUxYnhRTHJFY0dtMnBxcjZBUEI3NWVP?=
 =?utf-8?B?ZGhhaWZkMkJRNVFteGhXaEFUbVlxRmVtOUZibEVCdmFDMXJvRlNJeDBmZnFh?=
 =?utf-8?B?K2dweEtaNWVudVRlNThqNU9sYWtDTzFTdmkzTTZrSXZQcGxQSWhEN3hkWW1G?=
 =?utf-8?B?TnlPZ1FoWlVGc0FzRzFEWFovUHFzUVhCa1Vsby9SSFpYaEd1cXlkZ1Vha0d2?=
 =?utf-8?B?d29UUmlNaGIrMDl0VVdrWjlpYWFqTWxCM0luTUNKKzYySUlleWlEMHRTdE0r?=
 =?utf-8?B?WmxkZXZXOVhVOXdEdmJpRHVhZXhvWm5lY0xUR2JlbXNaVTZ5RTkvaEdUWXho?=
 =?utf-8?B?LzhMdHU1UFdGK3NQL21VNWNPb3dHVW9SZjg3eGlCcXo5YUMrdHlLd2NqMW5G?=
 =?utf-8?B?ZHgvNmxvejltVGtCTDM1ZnlCTFU0cG5ENkRhWVpnY2VwY21kQ3orYkdyc3oz?=
 =?utf-8?B?a2FEcnJOc0JxQkJtSWdSaDZUeElwdHlnTnhLUEd6K0FLQlJpb0o4MzZJcHBu?=
 =?utf-8?B?RStFSzBicnp1Zm92YXZvQnlWVE02alZhaCtpdzArMWFVMmFVOTRoc21HWjlm?=
 =?utf-8?B?OHBMSkdFMDZKeGlRTUhmcnhzaWh1SE0yZ01KZE54U05XNThOU2g4cEJaWmlE?=
 =?utf-8?B?NUd5VVZEQVlhVTVCMkJ6VVVqeVJIUXBVWHA3UkRLSEFDRkJPbFNYd1BmVGh6?=
 =?utf-8?B?TU5kMWIzU0dqRXdIcXBtMXQ5dHF4Zmo3djREMTd6SGgyVC9IWHNwcGYyY1VT?=
 =?utf-8?B?MDV0VkIyVXllY2crbHZVUGo4VDYxblhKUW1sMFJpaDhsUGM5b1Ftc0NnenVT?=
 =?utf-8?B?Z3JHVU43R2lvMENwZXpwbUFrWTIzUXduQ0xYRC9SRnk1ZDZwSzhtbmQrZXlv?=
 =?utf-8?B?VXd0NkU3a3dRcVZWRW9vM2lrclNaZG1JU1RhNjRWTllvdkJUcCtZUmRnSHdh?=
 =?utf-8?B?c2E3QWI5NXlqQmNUUTJGV0drR1Y2UWpjYW84L1hLT1ZvRzR0Z2M1VkVQekho?=
 =?utf-8?B?bU5EVDZVUFlGS1JMbExFV2V5OGwvN2gvQ2JTUFRTOGFmb0ZOMmJTNWVGbndJ?=
 =?utf-8?B?YitVYlVNTjNmd3VQZTZXdTg2MUpRRTIyZXF2azFYeHl2MEJrM0JKTWt5SVlG?=
 =?utf-8?B?U24vUERwQTVQYnNENjViQ0RvWTdPbHZGektCSGUwV2pLMUtRVGNrSk5ZRFlL?=
 =?utf-8?B?MVlHZEErcHlIM0RwTk91OUp5cVJnYzU5bVZLdVlPVkwwaDlueTFMcnBScUdJ?=
 =?utf-8?B?MFhnMUkxSkd0N0lSejRPbWdjM0pkbzBxZ0RKQ1hXZi92Vzd6MnowdmV4Nm96?=
 =?utf-8?B?RXhtc2pjOEo5RFk3ZkFqY09vQnZFN1N0OVFJSkVrUHdoSjNBeC9lOTV6REZK?=
 =?utf-8?B?TzVzODR4cDZMSUtXMnBHMnFHR0JacUdJTEhmSStmbFgwaTg2ZDlJTXJ1cHpY?=
 =?utf-8?B?TDdyUVJiSktnZ2tqQXJySnRucWpmS0F4LzFMYjQvMER2RHFXaXlFcVdkUUxD?=
 =?utf-8?B?V0RKMXFobEZBalhrTUR2QmhRYy9EUjZxekVKRUdpbnZrYTgrdTEzcmd0VHl4?=
 =?utf-8?B?SmVvRXVCdkYzbWFEWjExNEVRWnU5SENEYnZEVXZ4b3ZtMmJzdXM4a3lvVnda?=
 =?utf-8?B?ZDV4K01CckF6NXoxRGIxTE80dWtzK2tOeitYUDUxam56UDNJWjlEOFZiOEkv?=
 =?utf-8?B?cElDa0k2QmlhQ2d0ZWM1S1ZQUXplWURkek03SnFOYzcwTWlGa1dPY0NFaWF6?=
 =?utf-8?B?V1ErWFFsTnJFMUR2V1ZVUWhBT1hoUEsvZnhaTXV0YWRsZHo2UUEwUXlWTFlQ?=
 =?utf-8?B?ZzMzLytvRVNCemRUZkZISE56SlhCK2hYajZ5S0g3UWh1SWZZb3o5aTA2L2NH?=
 =?utf-8?B?YThiSXkvV3JlZWxubHdyQUNlQncyS0xRaVBvZWpkV3BKa2N5dzk4MGlvdlJN?=
 =?utf-8?Q?INcoAXLbQH29HCfb+gFkEBaw4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9904bb1d-155c-4fbb-47c5-08dc6565cd0a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 20:25:08.7429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGyMy23BXeqfsFr1NUH+P9ervZVWMgyp6hYjgoENaGpqj4f3KGmd1Q5c+lYA9sqo0hwdvUjmXRtljO24edYBaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472

Add cm41_i2c and devices under it for imx8qm-mek board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index dd9dd3cb7d47c..c5cb461c30c97 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -104,6 +104,26 @@ &asrc0 {
 	status = "okay";
 };
 
+&cm41_i2c {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_cm41_i2c>;
+	status = "okay";
+
+	pca6416: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&cm41_intmux {
+	status = "okay";
+};
+
 &i2c0 {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -352,6 +372,13 @@ IMX8QM_ADC_IN0_DMA_ADC0_IN0				0xc0000060
 		>;
 	};
 
+	pinctrl_cm41_i2c: cm41i2cgrp {
+		fsl,pins = <
+			IMX8QM_M41_I2C0_SDA_M41_I2C0_SDA			0x0600004c
+			IMX8QM_M41_I2C0_SCL_M41_I2C0_SCL			0x0600004c
+		>;
+	};
+
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			IMX8QM_ENET0_MDC_CONN_ENET0_MDC				0x06000020

-- 
2.34.1


