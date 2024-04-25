Return-Path: <linux-kernel+bounces-159131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E1B8B29C3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE90B284D11
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354FD156F2D;
	Thu, 25 Apr 2024 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eI1C7ZaM"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9809015535E;
	Thu, 25 Apr 2024 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076733; cv=fail; b=DGmrAruMU2esX9AytgW/OPLwi8dxQmT+9X5p6xQdnQnpaA84VpYQjyiGS1CeUKYDZVSYRbtXWwP+BIDsFEKw9jYtKptlR3Yk53w4ULFdK3QPtYIyhK9oIV2JYRDaRSO5G/Wp+84onpmSXXylY1nk9pNhDaBkrDbKWjwysle654g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076733; c=relaxed/simple;
	bh=znXmOAR8oiAmewQWmXkowufKc/whgbYUCiOGSzFY+Vo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VzWpJ9wojFQ11pyhPOR/V0n/sDHHaDJYXRn0Ase8SflRKZsdV4s/fwZr0FCkB4kBtHyRh7Ml1KvNzdjPq0yWBE9IMyFErop0i7Yw7WTBpbSrRKc3mQqb137Wzod2b0Jtm2vVBghMMMBgLiR0KNGCeKz9YpUnZL1gdoPH1MitF+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eI1C7ZaM; arc=fail smtp.client-ip=40.107.8.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=og2DDFDUEp2F9AT0Kzxq2PFavjplNNq5nsCNpQc3Jiy44drcrz6hpRzNdqFcPY54x0iarYPvrf/nwgnUJuQqrTUSbKxT5rhx3dOLNYPCvJWByUp2A3o5FJA2crRkFflaaOmCTbpbYuedKJ0UFu2jQ28omoW8ibNz9r4IVvy7sM8jWMPPW1uFakPxWK5eO9gTZiRXfmwYEhkPGyRjSD4z9vYGdGYndl4vXIkok5IM991daVrH+i5vp4dkeKCNcSSdw8eHazFqtIFkg1hxXMeWgtdMGtiLiwjKCQw5JYvryDRZgcyzwIBROJP9wrsKrjiPEmto90w1Cs2wOemOl0SwEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIEtUyndz5TM3L2y8jsBM36tWKCtkVCkgkvbrBlqLXE=;
 b=SS7/J4/obG4wkFMOvDN+jTsltXXodXOh51p+LGL5uudQk52/y2EqoxBiEk3K0H7g3K30wSbSGe8KZcczc1QDRn/x88sgMHUFwEICrs+CW3n77a9H9owjk4jOi8CZLr6Xr7vviA8i3Frt556OUfpURgtF+02Kx1azvWD6z8WmIgYnd6LJTZXoZGcFthnxah4RdbZWfrXkUFh5OgO30n3GWPzG7fW822ciOvxLdt5PM1Ep8EDGj0OnxkOttyzCIHhkk926rHLbEqQ90fXe1meTEMJtSQ9Bs31N2ScAUvXoQrz4+gjwew5u9y7OzPkEWz9WC4aIqhAtqldCC5ODOpEi3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIEtUyndz5TM3L2y8jsBM36tWKCtkVCkgkvbrBlqLXE=;
 b=eI1C7ZaMT92aSAU4InjIWdoNsAPM5XXRzpIAZZZDZ+k8H6GBFXL7a9QJOj+SUYshD+KcFrqRZghy16mnvaHqY+z/IPVUpAMUP8ukLKJUUjUrmNsIp+K6zsmGkstm6p6TVZ1tzWd6v0Ls1VaKnupGvRyVaoZTJmr3KAbl6A8pq3o=
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
 20:25:14 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Apr 2024 16:24:43 -0400
Subject: [PATCH v4 07/10] arm64: dts: imx8qm-mek: add flexcan support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-dts_8qm_audio-v4-7-7fa6ab2fd64e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714076687; l=3063;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=znXmOAR8oiAmewQWmXkowufKc/whgbYUCiOGSzFY+Vo=;
 b=ILi+0GcxViv/tHW0LD0h2UISFxufnqNzwzWSefYCdN5dCqZ8yBXcmVn4mgToPGWY/+pEIyshS
 /5Ouo+LULt9A8waj42AGfSECtkqOaDgRNl5fe+I808wsEpC2IL9bN+L
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
X-MS-Office365-Filtering-Correlation-Id: 517d242e-2131-4b79-7007-08dc6565cee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|366007|376005|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3lTZC9VZ29Da1MyS0V1VE1meUV2RHFSVnY1TVRHQzJVYWhsaHkxVi9BRE5l?=
 =?utf-8?B?dkUvTDBFMnVIb21wZEVvQmpFMjJjRHFHRExZUVR6amZBTnhENzRtSDFNWGND?=
 =?utf-8?B?RGlkcldVaFVYSWp5bGo3NXhiTmgyK1M4RUNTbnp2ZFJEQUNRQ2JIMWpmOXJU?=
 =?utf-8?B?M3BBeEhDNUU3dy9Oc3J4WlBIUzFFK1R0WkNuQ2M2STNpK3NuT0RVOW5Ld2ds?=
 =?utf-8?B?QjVPbk9JUG9qdURXRXFmUzNZdmk0RjJpc0NOQ1RyekZQZS9iRERzKzZ2UHNY?=
 =?utf-8?B?UnFiMkxZVTJSdnZDNmVxWlR1aDdwOWlPOGh1MmxIYnVrdlA1NlBBMW80ZDJV?=
 =?utf-8?B?cXp0WDFLdmpsQkhCVlEyemF2YUJPcVoyQksrQXI5V29uZ2ZSL21GNmtqTUV2?=
 =?utf-8?B?YS9IMUdqamxzbk9MN1UvZ1RBOFZUL20vTFcvR3dRNGhiQkRTakxkbTQ4Kzhu?=
 =?utf-8?B?RThtVU4rYnkrYjQ5V21aZHlXaEhDamRIM0hiUDk2NWNYdzg0K0IzNDF2djB1?=
 =?utf-8?B?eUo1NmpJZlJ0bzRrcEFVLy9lSWZJQUtJejg4WklHWWhvYkJqUlV1dUVTWVh0?=
 =?utf-8?B?NzRGMENUV1pPWHZHWDFVcStoNDVWZGtWek9INDFjaXd1SWpLK0dNVGY3TE8w?=
 =?utf-8?B?dktXQUt1V3lPdkp5d01OamZXK0cxblpCTERPR3R5eUxPTWZORlZQNXIrWEFp?=
 =?utf-8?B?RHF1L0w0U1lSQ1FjUE9LemIxWGhUMkRUczAvWXVOaVdBTXEyWUlWUW00MHBh?=
 =?utf-8?B?aUZvRFJ2VndVLzJOK0RpQ1FPZjJqR2pESXFDVEwrekxwaFg4Z0xScFBpcGR0?=
 =?utf-8?B?dFZXZFBMMlZ6VnRGdmliOHlkazhpblNlTDdvS3lteEozL2c0Y2dtbi9ZVTEx?=
 =?utf-8?B?ejFmTGRDSXBBTjNDZC94WTB6TXlqN1FuQ3ZsZ1FTUEdlQld4alZncmxna0Yx?=
 =?utf-8?B?SDdNQ3JYa2VLTW9IRnFxekphM2Zjd0Z2SS9SVnR2cG4yNUZCb21EajM2SmMr?=
 =?utf-8?B?TmhXSEdRYVBua0xZSUJTZjgxWTNudFpwR0E0MXZLdVVwVEI5ODZCL3crNklm?=
 =?utf-8?B?MjJ3UDdKbFhsVlhqWWJ4Y3hOaWV4a2E5RVBybnVOb2lmUGR4cjVEckVCRVI2?=
 =?utf-8?B?ckJwS3pPVGZ1QXpVWjhDRVU4M3VxTXBzU2pKOFlMYVJNUkxzQW9oWGRCUXdy?=
 =?utf-8?B?djRlZzZ6dHJjWWJnMGhLMlhWTzZ2UXlxaXNtSm5CbGp5d2RDaTMzeTd5RktO?=
 =?utf-8?B?dkovU3kyQmVLSjBCelFxMy9WRzcyenRmZllnanpoWGFMU0Vlcm9UbFVOcFZx?=
 =?utf-8?B?R2N3Mll5YlpoSUQvRWdzTUljc0NnOEZHeE43bit3VmVNc1Z1clIrV2tIQ2ph?=
 =?utf-8?B?eTkxYkdxQ2pRWGhVYmI3YVJvazlPNWVtQ2NtY3dRb0ZFRzJXZDZVSkI2VFpY?=
 =?utf-8?B?a040QmxXa1B2Y2lkb29DOU1VVVFkTlZqbWJtaHZyeGoxZHhDOXVyQlVtMVNP?=
 =?utf-8?B?M2JtOFNmZWQ5YXlMWTUzRmxLbytobXRDSGxvUWVha0VSRTQ1RVZ0cmNGNjN2?=
 =?utf-8?B?bkhhZHRIc0xzbVNkenhWenBtSGR2VkVMSWoxN2ZQVmtyTUJTZEM1bDdoWHM1?=
 =?utf-8?B?SlowREhEaVdDWVpxVDhiRGNBa3RkTU81WmRkNHA3K1BGa2xzMlVqNzI4L3FH?=
 =?utf-8?B?QlVteldSSjdIVGk0Qkxsd09XcmZVeVlwZHV5QzhYNXRxQWJMOW02TXhlWVNP?=
 =?utf-8?B?N1lRZzc0Qm4zOXhWTXlhQnJsSlM0ZEZYQ09XejdSL3hoRVk1elkwUEhpZ2ds?=
 =?utf-8?B?c0xkWWo4Ymhza0h6TnJXQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnFqSGZ3Q29TMzRGVXpteGxTWTZNK3kzY01EUDlyQU94cWNxL2JtWXVMUUVw?=
 =?utf-8?B?NGJsTXFLSkV0OHpOaEo1bWhoK2J1dTc0UHVPTlRhVmovTEo3dDVyaWZmWWRl?=
 =?utf-8?B?OTdHMzBBMUh1S3lSOVYyck1UWWlSYktjNU1jY3NPdWhuK2lpWXBWLzlzNDdD?=
 =?utf-8?B?RGUrNmlLMVYyNitiNndOMmYvMHpGQXhiT0FPSDVHd3R6OFUxN0xMQ1NTandk?=
 =?utf-8?B?UnJYaXdSeXg2empsdHlOdGJLbFhaaXQxd280Vit4L3hkN0xLRElETlNXZTdP?=
 =?utf-8?B?QUozMWhrZFJWajNUZVh5YnFwemMxV0QzZkk1N0FQcXRMbnlzdjVncVlSL0lF?=
 =?utf-8?B?cG51bWlFYVZGV1l6ak1aYUVpTzRlN0c5YVBEdWFUVmpwY3FWVkQxbDloYjdy?=
 =?utf-8?B?RnZST1djdGV2YXBDR1FuOWFndzJzN05hUmhhdWhiWW9uQmlJRG5rcE5CaXI3?=
 =?utf-8?B?dG91YkhMQk5aTisxRzlHWUlmMm5scS9pSHdUYzhyMHF6WVFxaWFCdXZuUG9J?=
 =?utf-8?B?SjdRQy9Pb1RoSmk3b2lIV1BVYlBlelZ2OG92cnRKNDZKWThXWXlxR1BlZDZQ?=
 =?utf-8?B?Q2tpa3I1VUcxakFrTDNZaWp2dEtCUk1udDR2RTRWQktnWXZrM3FlT0FRL00r?=
 =?utf-8?B?R0xEbElZdC9naldaMUlMNWlMUnphcXBIYVJ0UUlQekVVZXBDTUl1djdUTUFx?=
 =?utf-8?B?NkUwNGttUTZQeExKVkpLVExwNzJ6ZDNnMjFyVlBycmtpTEtoMHM3RE5FZGVW?=
 =?utf-8?B?OWRhT1M0WlFFZ0FyR1lBaEJLamttS2M3SUlDU05CQnpGM3lxbU5DYTNCYUJC?=
 =?utf-8?B?cVE5QjFvcTB2bDdJR0FGd0lTYktZa0dFV2xRdkprckdmRnc5bXVtSGx1N2ZJ?=
 =?utf-8?B?bmoyTmNsTngyckpwWHJ2eUVJRW5LNThPSThGT21peVVtVHhSOXFBcGljWktV?=
 =?utf-8?B?ZzFNdGJiUG1mTFhlSE9vQjJVREVjYzkyUWpWK0E2dVBBU201RVhvK2tkU09R?=
 =?utf-8?B?RmMxWGI3YlNacVQ0eFpqT0JpUk5xUlZZZ1VkejRtQ2ZNSXkrMEtBSHNuRDdl?=
 =?utf-8?B?NjI3NE1ucW9pV0tiVlEyZUI5Z0NOOFFKaGdzSkttSDFwTXNKY21BZWtZSUhO?=
 =?utf-8?B?bFNhR0R2aTg2WktmUWhQSlZ1bHU3MjhDck5vSTdiZXM5OXVhcEdtNllDM09K?=
 =?utf-8?B?NXFKeHVSNzZ3L1UxV2xEKytkZ0xjMUtKWFdvL3lxRHVycHFBNmw1R2J6V2ZM?=
 =?utf-8?B?V3FqeGVwaCtPSVI3TXpqZGVOODJUTHRKbVlZYTVMeTRRU3ZRREM0YmhvM3l0?=
 =?utf-8?B?RGRzandjcktzRkpLSHI1OVZrcGFWUVQ3SVdkL3RkMElNUWw3RXNXb2VPZmVD?=
 =?utf-8?B?cXp2SzZtcXVIcEYweGtLNkY5RVRMdG5FUHVFVnR5RmpXemRVOVpDS2Y0c0tC?=
 =?utf-8?B?dldwc1NsMXpRZEJzMno3QWtUOW5HdDlPeGlrZzNZOWMzTWwyNUhqV2VoZVFB?=
 =?utf-8?B?aGNkcHViQjU5WEw2UW5Zd3pvOU1ubU5uTUVCWGF5cHoyWUdmdllKdXU5Vy8x?=
 =?utf-8?B?SWJ6VmsyWlAzSkJFRTBmaVV5bHFFd09zVGRKQW9HVHA3dTRSNDdVS1FvYzRL?=
 =?utf-8?B?dytERmJaNklETS9YbDdIOFhZNUlrTlBOVVRvcUVMZkVIQkFIczllSTd1VFlE?=
 =?utf-8?B?ZHVIMGhvYUFmbVRWNUcrMU16L05tdlZMVXhIWHlKb2xqVzdHcHBQZVQxaW9B?=
 =?utf-8?B?dnU0eTFyUk56VlNraVY1TkdJcy9UOFIwNVJDMkFOOGYvbDdGWHNnb2ZBU3JO?=
 =?utf-8?B?SkFlbGZaVm9qVzBGV05vbk1tMGFNWVZvNEgzL05GYU9SYlYrTDEwM0VUNkdz?=
 =?utf-8?B?ZnBnRnZrdFZkRXZQMkUzSWRyamZyS2FWaGhUck1BODF2SGVod2xFZlk5SjhB?=
 =?utf-8?B?V1prSWgzL2VQc3VJNERGWXdQTVQ3WFg2SUpFN0JMY243QzI5NkR6VGR1RlVB?=
 =?utf-8?B?QVlMQldab0o5OG0zNTdQN2hzTFdMZ00zVzZCUDlkYU9aN2J4STE1Zk14RDJZ?=
 =?utf-8?B?dFI0b005QlprTHJrTWRlTkJEZkxMSHNBZERWbUtmN1kwbFlxQW02T3QzREha?=
 =?utf-8?Q?eYy7GfIQ9nY1T+vL6qNsXXJQq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517d242e-2131-4b79-7007-08dc6565cee8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 20:25:11.8026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1uA4OqwEjoN4GtxAXI3gj3wMtdTEGSTe01zAVjAO2HvSVaelirKMmyf0pjHgiddGDW3Fdh/Q5SHkxWo+5FU5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472

Add flexcan[1,2,3] support for imx8qm-mek board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 80 ++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index c5cb461c30c97..cb5cfd04b1690 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -40,6 +40,44 @@ reg_usdhc2_vmmc: usdhc2-vmmc {
 		enable-active-high;
 	};
 
+	reg_can01_en: regulator-can01-gen {
+		compatible = "regulator-fixed";
+		regulator-name = "can01-en";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca6416 3 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_can2_en: regulator-can2-gen {
+		compatible = "regulator-fixed";
+		regulator-name = "can2-en";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca6416 4 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_can01_stby: regulator-can01-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "can01-stby";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca6416 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_can01_en>;
+	};
+
+	reg_can2_stby: regulator-can2-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "can2-stby";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca6416 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_can2_en>;
+	};
+
 	reg_vref_1v8: regulator-adc-vref {
 		compatible = "regulator-fixed";
 		regulator-name = "vref_1v8";
@@ -194,6 +232,27 @@ wm8960: audio-codec@1a {
 	};
 };
 
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_can01_stby>;
+	status = "okay";
+};
+
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_can01_stby>;
+	status = "okay";
+};
+
+&flexcan3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan3>;
+	xceiver-supply = <&reg_can2_stby>;
+	status = "okay";
+};
+
 &lpuart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart0>;
@@ -433,6 +492,27 @@ IMX8QM_QSPI0B_SS1_B_LSIO_QSPI0B_SS1_B     0x06000021
 		>;
 	};
 
+	pinctrl_flexcan1: flexcan0grp {
+		fsl,pins = <
+			IMX8QM_FLEXCAN0_TX_DMA_FLEXCAN0_TX			0x21
+			IMX8QM_FLEXCAN0_RX_DMA_FLEXCAN0_RX			0x21
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan1grp {
+		fsl,pins = <
+			IMX8QM_FLEXCAN1_TX_DMA_FLEXCAN1_TX			0x21
+			IMX8QM_FLEXCAN1_RX_DMA_FLEXCAN1_RX			0x21
+		>;
+	};
+
+	pinctrl_flexcan3: flexcan3grp {
+		fsl,pins = <
+			IMX8QM_FLEXCAN2_TX_DMA_FLEXCAN2_TX			0x21
+			IMX8QM_FLEXCAN2_RX_DMA_FLEXCAN2_RX			0x21
+		>;
+	};
+
 	pinctrl_lpuart0: lpuart0grp {
 		fsl,pins = <
 			IMX8QM_UART0_RX_DMA_UART0_RX				0x06000020

-- 
2.34.1


