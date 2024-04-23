Return-Path: <linux-kernel+bounces-155348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297188AE935
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92AA91F23809
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103D313B2AF;
	Tue, 23 Apr 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zk9lVuFo"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB306136E1A;
	Tue, 23 Apr 2024 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881488; cv=fail; b=nYwIYFmKIJKh7iqIbizBuo9X6Wvpp1XC8LLETt22hyNjYCIUCfKqm6VwwVHrJSSi/hXvENjp0WOCoQTIfcXvWg1cHs+OxnYXp9tHTcBCSF3RmAIRyQv9clq0bMMy5qZ1tf99kkBRI/Mbdi/UvbcFMP8vlwVHAaVGnoG2Piu4GCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881488; c=relaxed/simple;
	bh=nIsA92kH+dTE1q6837ZeyJonA2cCKpn1NS7UdXzvIXM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=FZDqMjlqdq7UngET/P/nwyFu9BAz2keXra/y7gb8s03tk8687nANo7cORTXuCcGsUXcEBMEtSBXlP+upJbF/exIeUzbjcuK49folECqYYka+m7gxJ6mgYK6daojT5JW/ZwuDag/ZNbTPgqv2JaLcQB1SGkNgux4nSmCc8mJruDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zk9lVuFo; arc=fail smtp.client-ip=40.107.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaQP3qXFYyCaXuopN06bu9WNQcxQRpH6k1PyEyFBuoyxsplurS7CyHkW9pYJ9DEB5h5hkfsXhu3J3+mFpmcvHJ3W/YQ15rYZ1K+KMkBHj4prPdXX79lT24jmkVPT1I12OelBw4PBAzAfEXqExImDLcyCFfW8SYCJn4Tm6aVOp8aW1azb4CZZOx9A8KKqI7OYuKOSV0y6mU4HjX4l0cWUIs4caJ5IxTBFJ+SD/gvtuWSaH7TC3BNENsoXKs0pKXTmfvujzYsSoLfv4CeuhIUIEwfeXWPgDYvmujHM6N7864ounHA7n6y/5THj2Ky/CuFv49RWIgw/WAfykOMm36B2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hJ3PIj7GLE2GBmAEO9vSb17I8+m/Zteo18s9rPF0o0=;
 b=FLnsMsxkoHB6jYHOoJaAC9vQSfjYms680/sp/G6fl2YibkMKFtKXemVG0t7jjBGtM8ZHY6s4oDKB72EcehOkkhzUe5yyKFmezsC6Atuuej1xEKFeFv9eZMAY1fUQs7YRdAm1mhNbqnIRhzl2MGmvHed7YirokFjT+HF931jxvBEZM8pt5ttj9FOgwQr/3P15q51llRBXJZTTIsdAIuu2E9bSrYN5gZLUiJSXI729760pfS8vvb0ZXnqGm7vqDFB0505jrSbjW7P1OYKmOboNGFZT7nORrBv7Epb+4X+HFv+KG0br1maSoSUQPiUnMa0wUKuedple1qkWuJlhaLyUvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hJ3PIj7GLE2GBmAEO9vSb17I8+m/Zteo18s9rPF0o0=;
 b=Zk9lVuFo8g/zqrUSjbM7j6I9ehjqnKk5P+J4mYJUfGqy6rHG1CErBuw8x7l+QHaU6TQvB9iraMVbZ5z4+aCHQLYOJeO9WpQAyc6k0ssJh7HPicm9w1fRMYvhOuHeAb4q7kBjWq36lJ2vIeTW+jOh6M0Iql5dLxPprCrC04hpAZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9018.eurprd04.prod.outlook.com (2603:10a6:10:2d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 14:11:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 14:11:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 0/3] arm64: dts: imx8dxl: add audio support for imx8dxl
Date: Tue, 23 Apr 2024 10:11:12 -0400
Message-Id: <20240423-b4-dts_dxl_audio-v4-0-0c57eb7399a7@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIDBJ2YC/33N0QqCMBgF4FeRXbf49++3aVe9R4RMN3NQKs7EE
 N+96U0G0uU58J0zMW87Zz07RxPr7OC8a+oQ6BCxotL13XJnQmYISECAPCduep+Z8ZHpl3ENV5R
 rQJCgFbLA2s6Wblwnr7eQK+f7pnuvD4NY2j9jg+DADZ4MxnlCGpJLPbbHonmyZWrADRfJDsfAL
 VlUpHKpKf3lcsNx710GHoNQsRClTFP75fM8fwBjHrB+LAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713881481; l=1528;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nIsA92kH+dTE1q6837ZeyJonA2cCKpn1NS7UdXzvIXM=;
 b=6AntlBSnJugsMP9ptpYSt/wRh5PQiEFgOji+UsFcCkG0iYy3iZkjFDBryti2UeG3LUJfRqrfG
 Q42xOnCEP0oBUmLclzEAHjFUR9dTiu+KFhFPFBS3WCoW7fLhGWgZnuC
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c8b134-b8ee-4e7f-6bdc-08dc639f4182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|7416005|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVFzbVY2eStSdkZ5THRXYkJTc0kycnJEUzc5a05WRnhWUDM5eUZLb2dYTCtK?=
 =?utf-8?B?Rnd5aVlQSGZKSlNkY2VSenk4ZWxUVjNzRHMwczUxR1hyRXhNVDNQNldrLzhu?=
 =?utf-8?B?eU9FUUVIb0k5WHNNYUlYZzF3WmJYcnF1MHJ2RGl3OFkrbHhHWjdjVEluaGxy?=
 =?utf-8?B?VklnM29OaE85OXFZQklrME05allsa21mekZpOGc2YXNtbDNMb0ZkZjJPZjFp?=
 =?utf-8?B?YkpIQzMrc2RXL2M5S2RBTUlRY2xQMy96Y1pCVjQ5Y2RoS3FDdGVoTkt3M1pn?=
 =?utf-8?B?aDl0MDJIT282NURtY3dJODBpSFVsNTZ1S0w2R2IrVkR2Y21GSnVvQW9yUEN0?=
 =?utf-8?B?MnhBY0Y1SlVMWXA3aTRGYjJIY3hrTXFPSGNiNXhabUJGc0dZYjdJdC82bHdj?=
 =?utf-8?B?aXFWd3dOWFN1eG5Kdk1idTl5U1loK2xjOWhLbS9lNU9lK3haV25uZ2xiNHRZ?=
 =?utf-8?B?THUrc3NIdENHM0QzS0h0Z3g5cno2WmtKVytGMUJrTjRTbDk5T296QXNHTWsy?=
 =?utf-8?B?WUp6Y3F5VW14RUJKdEg5aVNNYy8waUpRTVgvaXczaUpFM0pkUlh1WjkyTE14?=
 =?utf-8?B?QVF3VVBPUVlWU1VCaURZWTc2Y2VvbUNmNmEyNGlGRWlzYVBzV0hydkxBWXN0?=
 =?utf-8?B?MzlnWm5tcFFKV2QvSWVvZkpmai8xbXh1WjVHZEpvdFQyQjYxVkM0akM4QWxU?=
 =?utf-8?B?VzNVMllmcDlqTVhnREVQa0Z3NGQ1OVRRMWhtQm16NXcxelRIdDJLdHZWZiti?=
 =?utf-8?B?YnY1ektDOGFQbmZhRUkvdkRmdUE1Zjl5cmhUVUpUSlJidEdrZCtjN2ZibVVW?=
 =?utf-8?B?QzFxM2xvR1ZQT1YvMDNFUitOVDJubUVzNHV1VjRUWTd1bXNMMmsvR1B3VVFk?=
 =?utf-8?B?TmRUUW5vYWttYzBNSHVLNElPWmlnZlg0SGhoUUhuOXRpTnA1dlBKMzAxd0xy?=
 =?utf-8?B?cGJGWWlYNTRhbFZjZ21vQXlJbS95N1JSdmMwUGhDQnY1Zm5mVTVUZXFwRGU1?=
 =?utf-8?B?Y2hhMUoya2dKd1N3L2NSV01qbUNwMWhGNS94OHNxdVVyOWZmS0xYS1g0T0k1?=
 =?utf-8?B?ZTNMVFJrcHpCNThMb0I2cnBVWnRGUzdQYTF2QUdmM0p2UFJjWFZQQ2d0M3dD?=
 =?utf-8?B?SXZpN1oyd3B3c3Q5cll1K1lwMS9yeWxlbGhGVHR0akhQZ0xnTC9SaGxIZzBG?=
 =?utf-8?B?VktBTW9mU0FlY0tZckJXU2lHM2ZhREpLaFU5alI0UXFubFJpbG4xWXFMSDA4?=
 =?utf-8?B?Z0s2ZUdaRStzWXBrME8yakRRcmFUZHB4K2ZYSSs0Zm9YTGdzMkNDanFFMmlD?=
 =?utf-8?B?Snp2aGJteVl2WTI1QzNTN2dnTzJOTXlKemttZUtpRWlBSm1qWmcwcDBmcGJs?=
 =?utf-8?B?MGp0aDFhSC9NTkpzQ1NMdldKcjdwT1FpV3ZyTnJrSVRxSEt1RVdESXNJcGV0?=
 =?utf-8?B?T3Z1ZXl1Y1BGeGhwSkM2V1lYMXUrMW0xUUUyZC9YMTN3QmNMTHpEK1lGbzdR?=
 =?utf-8?B?WnoyWGNQb3lOQkc3UFg4UTE0dXNtbktqRFc4c1Y1VnNKVTNuSnU2YjNZckV1?=
 =?utf-8?B?WGk5aG5KcEFHb0RxdXNEdERQMzhxZTJrNUprN0ZESTJoMEYzQm9TV2JrdlYv?=
 =?utf-8?B?eUx1Q3JiUEtpQ3BoWEN0cjZTNFBwWWwwZklWdjU4bkNYN0hxVTVQR1ZlVUxI?=
 =?utf-8?B?bjdoZEViVzhLa1JqeGVMSTR5T2xWOThDanRPdEFkVVhFdUU1SFpvaVBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cERWN3ZkdXV5VDdLYURYR3lqSHBsSGhTMEN5SU9mQ2EvS0VFOTJlcW83aUlL?=
 =?utf-8?B?QXdzNVo4N1JnUmMxTS9oWXNPandtNUZlSWV6cWVXQ2cwSjB1K3lCOG12dDI0?=
 =?utf-8?B?NnNjQjZGbTJleW81dVF2ZVVNb3lrdk83RE5JeHp4M3BLcW5LL0Ewb3ZjMmNk?=
 =?utf-8?B?NnJlTmY2YlpmbTl3c1FpR3dXaEtKOEJlcHQ3QlBFc291R3JUWmczTkQzbjdL?=
 =?utf-8?B?VVdhVll5Ukl0WHlmV1ExTFNlWWVCdVpjZk1mMHpTWXAvOVp6QjV1bEVTejI4?=
 =?utf-8?B?c3Y0U3BXdVNhY1Z6TnQ5RDJpb0c2cHFOd1Ava0lXZlN2U2JsMVg3dzRoRDV6?=
 =?utf-8?B?dU1mc2w2bWNhcy9Kb3NnOXhsS2lSL0RuWGlFTjFJTjFvSUpRTU5BNTBEVnBR?=
 =?utf-8?B?eU1NeldnOFE5UTArak5rUnEvclk0OVhrRzRJd3hvSnJuVTJqRGUzeXY0cXZk?=
 =?utf-8?B?RVVSTFpSR291bDNpbEZWU3haQWkzVXZtZmU2bUFkaHNBNmJvdnJvVzVwTytk?=
 =?utf-8?B?R1U0cXU3WmR5MS94L0lyYk9sdmZ3N2dkK1RaWTNKSExnV00wb2sraE9jMmVO?=
 =?utf-8?B?T2tRTW4zdy83RlRXMmVhVWdJZWFUQWFzdEJkaG1uZHVMMC8vMnE4eDVlb2Nw?=
 =?utf-8?B?d1Y2Z3ZVd3RvOEV4N1JHdi9ta3pobnhtZXY0OUFXZDJ3c1Zmd2NPMmJYVC83?=
 =?utf-8?B?a0JMajI2SExTQlNJVFJtNDJuWGtyVkkxTWF0K3BpcDIzc1h6bTArYUE5UmJ2?=
 =?utf-8?B?TVp3bjZJTGJDQWhWNUpNdnRJdEVqS2g2K0dReXBKWGEyblpPdUZhWGtiUUNM?=
 =?utf-8?B?SzhxclFzcGRuWjlqaE5Ed01yK1JVQk03MHpBekFta3FRSUR2K1M1R0EzYXZB?=
 =?utf-8?B?ZVlXMnVXVkFMZFJUQnVrNGZwYWZmZ0F1cExUaVVCbmplVkdrTDdYazRXbmJy?=
 =?utf-8?B?c0E5NVVDSlhiYlFaS1M1MHhTdDM1Wlh2MzJxTjVUNnYrc25Xcm1VdVo4VFBS?=
 =?utf-8?B?NkNHYlBCSU5rSkM1T0ZQYVJtUk55Z1NuTzFZYm1ncXpDbVk4a3M5QWczZkZx?=
 =?utf-8?B?dWhiaHJzcDRJNzZCQUdBRk5kZ3ZCZTVTRzRNNVZWRTE0NTB3cGJPdXNLVnla?=
 =?utf-8?B?WlZFb1RzbVlIYStVSGdoUUYrQ0hsbXRHaFJ6dytCRUd4L2dRTE5IUUt5c2ZZ?=
 =?utf-8?B?ZllRMk5iNDRzWVh4eXhxbzB2NWNqaDQ4cnlrZE5HajZtNmNWQjlsZ1dZNml0?=
 =?utf-8?B?RHFWblRpaUJScWxtbjdtYjV3MHRxYlgyelhyMXdzTGRlaDlRdjA4OXlDM2Zr?=
 =?utf-8?B?Z3NGQU8vTnNxQ2NOWVc2MmV3MlphajlQNWsybE1hbGlncUZvR0ViVGkrN0d5?=
 =?utf-8?B?dGxGMEM0ZGxpRHl6VjhnZG5nNytJSHpKZEpmSnVxTEZveGZYZEQ3bG1rUHFL?=
 =?utf-8?B?VVcwSkVncWFhd1BCYVg4dnU5QnZnY0dWeXVRMjdXakYwK21CTE9ya0labUhM?=
 =?utf-8?B?NmE1NUQyRzlSSkdsaVR2Sk8wcitEWXljZnVBOXlmTU02NzlDeHA2L1lSSHFm?=
 =?utf-8?B?QUdGMjd6SnBsRXNYc3pxWEZIZnFoVzNzUFk0NE9RaVUxaytBZk9pRHc2M0k5?=
 =?utf-8?B?THhGb01pZWlGU0xIKzhrNDhZRHN0bWFialhKTjJQVCtjUlFybGJJRERTeG9q?=
 =?utf-8?B?QThVK1RsTDRaYzMzQjhUdWxiZWF0N2h2N2EyU1JzK05iZldrTEU1R1BpMDVO?=
 =?utf-8?B?clcrTVpiYmh1aW4yL3NtMzlRZTZzMkM5SXFuNlNoNUxYR2lIcGdib1pURU5P?=
 =?utf-8?B?UC85TVN2d08xVnYwNEs4aS9ub3hwcFVpVWx4cEN2dmEyamhKZWJ0aWd3UFFk?=
 =?utf-8?B?aEJjSnBLYW80ZkI1RDA5MVZDY3JleWlWa3ZiUVZRMDlhU1pWSjg4RE8xTXdK?=
 =?utf-8?B?bjhvOUFlT25TaUJxNzVmWWRxN2NkRWs5REFaaWJQQklhSWRIVUFXaGtHYVha?=
 =?utf-8?B?Yzhia2hVc0xzL083c1hLZzRmR0FYa25WR3QyRWQ0aklMYlo0VWQ2SnJseXBa?=
 =?utf-8?B?a1ZvYkpjMGpnOFFWVkltbnhxa0NHRWJsc09jcEVEZEJCeEgwamFlZEZvQ1Vs?=
 =?utf-8?Q?jts8NPGpPQkhaFkQ5PC7l3DNV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c8b134-b8ee-4e7f-6bdc-08dc639f4182
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 14:11:23.1107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUclfNDMcqDIc5meGv19UDP/pAvWAGY8+h+bsGKsoN+SVHtmbt/wNta0BbZtRG/VRwA/2hGRMhspDs116Ykmzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9018

No new warning add
by make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  CHECK_DTBS=y freescale/imx8dxl-evk.dtb

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4:
- fix wm8960-2 and wm8960-3's audio-routing =
- Link to v3: https://lore.kernel.org/r/20240422-b4-dts_dxl_audio-v3-0-5017511f399e@nxp.com

Changes in v3:
- change bt_sco_codec to 'audio-codec-bt'
- 'compatible' to first
- audio-routing = "Headphone Jack", "HP_L",
		  "Headphone Jack", "HP_R",
- remove extra space in fsl,asrc-rate  = <48000>;
- align clock at assigned-clocks =
- using tab in pinctrl_sai<n>
- Link to v2: https://lore.kernel.org/r/20240418-b4-dts_dxl_audio-v2-0-e4e2747b3a49@nxp.com

Changes in v2:
- use general name: audio-codec
- move vendor property to last
- remove undocument property 'capture-only', since linux-next/master merge
txt to yaml bind doc
- Link to v1: https://lore.kernel.org/r/20240402-b4-dts_dxl_audio-v1-0-d26d25b84a08@nxp.com

---
Frank Li (3):
      arm64: dts: imx8dxl-ss-adma: delete unused node
      arm64: dts: imx8dxl-ss-adma: update audio node power domains and IRQ number
      arm64: dts: imx8dxl-evk: add audio nodes

 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts      | 229 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi |  78 +++++++
 2 files changed, 307 insertions(+)
---
base-commit: 2d13a7797c3970a4eea160844d8905c93065634f
change-id: 20240402-b4-dts_dxl_audio-74ba02030a72

Best regards,
---
Frank Li <Frank.Li@nxp.com>


