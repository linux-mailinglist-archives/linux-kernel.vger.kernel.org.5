Return-Path: <linux-kernel+bounces-153148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4EF8ACA38
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC9D1C20C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD62C13DB83;
	Mon, 22 Apr 2024 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="H8WUzLp+"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2130.outbound.protection.outlook.com [40.107.22.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712BF50280;
	Mon, 22 Apr 2024 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780469; cv=fail; b=hqSHtawKvCjs/4HXdwGPtMqTa6N8scfTXgfrXP8wNoX5VbTWBwgS5KaQ5w2XhqAlTWePjp9WJ1QGBeKpUiPipoYInFZ9wYqC5BGtEOj+DUZJi5qO4/zyjsXwXcMPamQgNyzuW04gpyJpd4WAhneN3t9vCCq8Iy0TQdKsxTG6wsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780469; c=relaxed/simple;
	bh=We4djLZrQmwTewoy3TXvLCuEcuRF2BZn64gf0yEafpU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nejg7ieqakLzDhNlsMXwTVasVLI3BAbi6BJqwyJA2sNw8BNSkkGXlyhtaUX3yEBugU2YJUGCrSu1RrSMJ5llr2ZVvgLBWL/FhPGBi8fHBUpyjTlzvmKFTbMfBXVz/GITmKH//qMLX/6lInYVL7NB/r7Mk//NiqZy1+ymf/9WNec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=H8WUzLp+; arc=fail smtp.client-ip=40.107.22.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVYmKs2EJB0bRBy0l+ZPHIz/FHjPFZNjU0j37qLoSakvDZIX0M3wssO1R/9qavRGcnfqwCY3W+T6JAFbRrXa9h10opyRN7k/k4U1zF3fTk24HOU2dAv5C6ZcbFfMbhu00DYzrd3CYWwzstZLJyWUMadeqCQDOGjAR8SI7o31yHJK7XgJAbiMlOXC1X4wY05RLElwfyS/tLq6iUyJ/gRtB4/p+gNjoHhBaIelOL1mihj/rMRHx+RqB5GU1F2nast20osPGvL5Z5yeSi7pbT7PhVXRZVOx+BdIujZmMk8T3iYshr9S5ZooOfAG9TXnaM5wcu74CsafVsZkfAHKxp67DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRUe7KDkC01XwoHUft0RG9xZV2wyedfrobtHpSyaX+g=;
 b=adibL7lvQiAIXT1YwZmP5G7daAB3Kuwxo1L9KUSFaz4gzsP4EMFr9VlboIJIAW5f+bybEZyG0cKh/LtY2KHgCHYRfgUnndNhER2HBPUeTB1WnkUqLOsEt5C+BQvNpqpaXs1UwjLL9TvOBOqHuMHuu2DxD/0VPbYXN6Lbhon2SqZcA/JxET1o0R3PWv3M1SFXPTF362hSrI8lcfYK2RUhCud50fr0+V0QvDHrRdZkR2BlQ+YYm4PHrjI8UUa7s66+T7PYOmzkJWynIS0JKqzKSU1xCmZp8C0DpTh4K3mS9yV6j9BnCIeHuBd9jwNDF84/eulzpKRRXowUT51cNyQ4qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRUe7KDkC01XwoHUft0RG9xZV2wyedfrobtHpSyaX+g=;
 b=H8WUzLp+rXEtwEw0nx3+XvNC5+3Gt/E6g08B8H33aD2+2C0qLxfgjDz50rzebpWQU44reH/H/vhl54eNuaUd1wT+1wWRPh3Lb1JtZv/rnHwhwi8whf/9zw+gmZkZsSdPNdUxv/DysUj5PJMqjrMrVEuPcwEpjYJWDuJew8nGBWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB7885.eurprd08.prod.outlook.com (2603:10a6:20b:508::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 10:07:44 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6621:68a6:ab00:c040]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6621:68a6:ab00:c040%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 10:07:44 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Mon, 22 Apr 2024 12:07:37 +0200
Subject: [PATCH v9 1/4] dt-bindings: touchscreen: add touch-overlay
 property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240422-feature-ts_virtobj_patch-v9-1-acf118d12a8a@wolfvision.net>
References: <20240422-feature-ts_virtobj_patch-v9-0-acf118d12a8a@wolfvision.net>
In-Reply-To: <20240422-feature-ts_virtobj_patch-v9-0-acf118d12a8a@wolfvision.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bastian Hecht <hechtb@gmail.com>, 
 Michael Riesch <michael.riesch@wolfvision.net>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>, 
 Jeff LaBundy <jeff@labundy.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713780463; l=7148;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=We4djLZrQmwTewoy3TXvLCuEcuRF2BZn64gf0yEafpU=;
 b=iUybbeYwnurMTqQP5jqT8XMsCqrn4WHlnrhQK0/wtZO9q7xzpPON4JsIdKsSJ7jipH6YpeGNf
 0/Sb8Utv9m6DszcLtI1YmBUo8Pg5MfXpdLBWXrVNIYXamQyhxFPe/hs
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VI1PR0502CA0004.eurprd05.prod.outlook.com
 (2603:10a6:803:1::17) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e8eb70-faa2-46a6-d2c3-08dc62b40da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1Q0Y0F1ZnBSR1hGcTJLdWphd1hQMzcxbW5YT3ZDZ1VlaHpKM1diMG1wbTM0?=
 =?utf-8?B?L1VvUkZuWVVEbjFlOEppdHJmNjRvRFQrOFBPMkpoUGlMK2JEN20wMGk4bHdR?=
 =?utf-8?B?UVBsSkE3QkhPQ3ZQdkFnZTJaWmxhbXR6M3lOR3laZGpWdjBvSkNnTXI5dTd1?=
 =?utf-8?B?SUxWaUlwc1N3V1RkWE9oTjQyMzNtUVIvb0lnWC81aVJFZDBETlRHRkQ1cHlr?=
 =?utf-8?B?dTJiNHQ2Q2RRcDgxT3VnVDhSU3lEQ015djB6QkhwRzlZb3RvZzA1ZXZsdlVz?=
 =?utf-8?B?d29KL3Fpb0xrWkVFRVpIN3lDWEdpemR1ZGVydS8rNlU5Mml6SXdFT1hNTXh4?=
 =?utf-8?B?aDFJR1RHREtoNURsK09GZWMrTlgvT0Iwdk5vRWVHeER6YS84ZW01SzFic1NJ?=
 =?utf-8?B?Qlc5ZUZ0Y1lxWU9WRXBmMlZyVW41UU1YVmdnbmExZkpaM1hoSXNtT2p1dGdn?=
 =?utf-8?B?NXlRUkw5ak1OeTJFbDIrR1Y3dHNuaUU5b0IwMUd5MXNCQ0RSL1lOdXNqd3Fw?=
 =?utf-8?B?ejh1RDdMK1FlVjVGb08vQ3hsQ0tZR0kzQjgvbTdxVWFJNXpCY1l2V0c4Sk5W?=
 =?utf-8?B?MzdMRThxK1dJZVY5STVzUHViTWU4RmlPSktFdERCKzRlTU9TOVQrVjg1UUlS?=
 =?utf-8?B?RTV6ZHl4UG1IWUxkSnYvOXh0Q0xPUmw4QjFJUEpncjlsTTltUENoODZOc0J5?=
 =?utf-8?B?T1Y5a0tzQ1lYQnplS0FGMVpLZHlRTzlJMCtnRm9QTUNNTUNORlNkQVRqWkJh?=
 =?utf-8?B?bVhiaStTR3hmL0kwY1dyalZJQ3llYkRYNjhzbS91SnY5QkVkWjNKZThTTFh0?=
 =?utf-8?B?VHJXWStiUzNlZlNSdWRoaEErc3p6TWdjanAvNFpRS3I2aEZCRzNWeWdCamh5?=
 =?utf-8?B?R1VRek1nZ3hxQnlUTHRreld3b2w3eEgzTkwycGZadEEzMm5NR1R0NlUvK3FL?=
 =?utf-8?B?YWxGM3FTN01Gc282MWNtM00ySWUyZjN6a0hMdmVPQ0p6eEdyMXVhSzJIZkJK?=
 =?utf-8?B?R29LcmxlNmMwWW05Qmh4TTdLOGVVc0RmOE9YSEZSZWxuL1lhZXlHeWJvdmEz?=
 =?utf-8?B?eFZ0QXU4Nms2MEZrWm5WNzhiaGkrNitReEN5ZWUwU3J4M0dpbEhWa3RUZm0z?=
 =?utf-8?B?YSs0Sk51eU5SOUVBVXlhMmtnc3hacHZ6ZWgyRGJZbjlBeVo2bWNENm5rUTR2?=
 =?utf-8?B?Szl5VUZhek5mWkZTMERXUm0wQTBRMmpoZ2IxcUExcUZ2ZmlmUllwSU9uUytu?=
 =?utf-8?B?R1YzTWtZUUFoY0RZYnpQVEVobW04di8vZlZielc4dVRwdVd4YXdkeXJZU25I?=
 =?utf-8?B?TCtDMXB6LzN3N3pGbDVzQUhRd0ROQXY3dk8xekNhc1hTaDQveEtmNHhNM2pJ?=
 =?utf-8?B?OFkvV1BHekdyeGlzS0pEc0tXOUVOKzk0SDN6QzhzdUhFUlZXTFZTb1BRM204?=
 =?utf-8?B?Rk5BeHc3eHZZanViM3lOcjA5TzErMU5HMDBLcEg4YnJXb2xERnRPQkY0OW1U?=
 =?utf-8?B?THVxMHltL0I1WmRZaVVoYTBUYStSeUltT3N2Qk4wTUFaa0NGdXlrNlBLb2ND?=
 =?utf-8?B?THh3b0pHay9TNzR0NjRJYk9XZTRBVHRSM2M1Z2VlWE9ZZDF3YzRFOGZDZndy?=
 =?utf-8?B?N1VPS1ZlR015SmtxcHZhYldEMUN5V3lUY2dLSjdnUEVCd2RnL2FPL3pldVd2?=
 =?utf-8?B?bjhuckl6RHpkMi8rUEdWN2dKVW1LcG1tMTliSU5WelVvam9ja0ZhcjF6Nm5t?=
 =?utf-8?B?OVlkRjNNMUtOeE5ZN2hYTm9uczk0S1N2cmw4T1NWNWljaXpCSXd0T2hCcVZn?=
 =?utf-8?B?TnB3ZHREZ1FES1R6eFNFdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vi82cm90V0VkWkJsKzZ1Rk9sWlMzcmJzcFRiOHNHaysrejl2YWVMTjBxc2dI?=
 =?utf-8?B?bkpNR0JFTXVXSDcwRnUrT1h5ZFEzUitodWRmL2xqN0ZwZklXTUlCSWRJZ1ht?=
 =?utf-8?B?MWtIaklsZWxZblo3Y1VWdUFWUWFBQTlxbXp5M3puTm1lNHJWdHVDSFEwdlRJ?=
 =?utf-8?B?Z2pLb21sYWFLS2J0YVpCNUNmNE42Wm43OGluaHlHcDJ4RytlNUZQV2hHM1lw?=
 =?utf-8?B?Y0Y5d3NPbCtuOE5RMlBuNlg0V0FPbkhWWFMyK2J4TVpIVW8yTlVMcFBiV0Uv?=
 =?utf-8?B?TWdDcExocmlzVXZiaVMvc1ZEcmxtdnNxQ2I0Yzdwekxibnk4RXF5Ynh6aVBz?=
 =?utf-8?B?MFlyODBUbEw1QXoyRlZ6L0hxUW50c0E1TEZlVms4YnZ2aGFvQisyUlgyOXNO?=
 =?utf-8?B?YmlPenBnd21lYXNmYS94aW8yZFpLSy9vditwdlBpR1hIQzc5dEp1S3ZQSit5?=
 =?utf-8?B?dGxKZlFOeG0xNk1kcUlweFlTeUlVazhCdXJmdjlPYTg1Mm5hYXJzd05ubE52?=
 =?utf-8?B?ZXVmMEN5TTd0ZE9NTktQc1lRVmhvSWRxRWlpNXU5Sk1lWmtsVzNnWjNJeHha?=
 =?utf-8?B?NnA5NGtxMFUwRHJ4cHB5djBrZGFEbEU1YVRSTnJrYzZOYUtOVHFDZjZlSjZa?=
 =?utf-8?B?MVdzOUFLK1N1NkkyUWZFbk0zN2ZiTnFsTFdOQkRKY1ZOaUpyTmFHWjcxOFoy?=
 =?utf-8?B?OVM1Yk9CeE1CRlk1K0hPS2I1dG8wRHNjZ1JCNGsrSTRBOVZJaEdSbXJCWXQ3?=
 =?utf-8?B?N2JjWUFCcVRsaDhZQTlxcTJtbmRVVEMzS1FxNTlBcVJINEswSFV6T0M5Qm5S?=
 =?utf-8?B?YWtCdlNYTDNFUlBpZ211YUh1dlBjaDZySnM0UGI3RzFyOFU5VnV1SVV4bSsv?=
 =?utf-8?B?czFzVEY5WitMQis5UUVWd244TmxRSWowdXgzcitVVXNkbWpyMHdkdk82ZW9D?=
 =?utf-8?B?a1hTdnBoU3pvZ1hja2d0ODBwMFB1SGM3MUxXV3FKdjFHSitKTHI4d2NDQzAy?=
 =?utf-8?B?Ry9zdzdCdVcrWEtXK1FZN0pjOEs4bjgwNnYvUVlIVnU1QWV5eVRsSUZoUzVQ?=
 =?utf-8?B?N2J2ZkNKRC9reDRybmpxMkg0MGNNS3hqTE9kNTNpTkVoWFdGR3IxZWtyQWJZ?=
 =?utf-8?B?QmFWOE1kOXZnTmFXekdycm5EWkxETlZMWkxtRXBPUDhoM1lCZU1EeDhUOXNQ?=
 =?utf-8?B?V0daZEFxY3hkdW5sbjg1M0pNL2U3TFIrT3FjZ1pTOHJQeG4rams4UjhHOHNn?=
 =?utf-8?B?akFaVzkvWXdFUjErSngxWmZScDlLWXlVc3h6VkluZzRUSWRNeTVxejFlMmVN?=
 =?utf-8?B?TFNmZkR6VG8zSWFidHMxZzE4R0lSYVpTcGV1TTBjMGM0YkU4Tllza1lRZndG?=
 =?utf-8?B?OHpXei9ONzJqUmZiRmVIaDc2eWFoZTRZb1hIWWlkKzRRUXc2dW1haU44WVlF?=
 =?utf-8?B?RGwrQ0lpUGVZMm5rck4vQWpwdnM5UmErY1J1djJKQXNHM1JxQU5kZWYwa2dr?=
 =?utf-8?B?WEhuV2RrQVZyQ3VpT3hGd3ZUNHdjSUU1TC8xN0kxOHFMeGhaeFJkUFFqTmpQ?=
 =?utf-8?B?eEN1QkZWaGZsRnRLSURVV1p3UkYrMjdjVVJsQnJRd0xXTGY4WkQ4Mk1tMFdO?=
 =?utf-8?B?VTYzS29NQjJEbFVxeW1KWDFiRGlQb1dIRWtpQmpnaFEvbU0xMGtSWmhtUXpx?=
 =?utf-8?B?TDEzZWhFeDYrNDBkL3k1UVlZR2ZhNjR5Y3Q3NDVxejZhNkYyT290SnpFT2lM?=
 =?utf-8?B?cVVnYUszUThVYzVrSE45aC9lMjB0cEwwRGRuT2NCMDNYL2NES3FZMW1DT2Fk?=
 =?utf-8?B?RytyUVIxa1JmNk94ai9JOFFycUh0UFowZFhuaEp2KzZ0TE4wMFBHWlVrZkEr?=
 =?utf-8?B?STZBWjBYdkNJNmFNaXZwcDVRdGZGeFRHR0xwazdVeklhVG91ZEZsRDdrNHgv?=
 =?utf-8?B?RUFqc3ZzWGxOQVc2SGg5YXhXSzRUQlAvL2xvakhXbWNuYmVQRnFjMXlYaEMw?=
 =?utf-8?B?SEtBVjhadEtFYnJCenc3Zi9Vcm45SURsdWJIdW1BOXhScC9SNlhsQXFBSUZs?=
 =?utf-8?B?NVVUQWtIVVg3RVRoT0hkdmhGaXlJdDN1NUhyMU1Ncm1LeWZXenN4V09ZWlph?=
 =?utf-8?B?L3B1QWk3ZzgwN1R6dmR6RHJxaUttTi81VGtDUzljZkgyWjhnR3Jrc3VCUURT?=
 =?utf-8?Q?IwDpxtnUmVlv2l4RZqfGb+s=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e8eb70-faa2-46a6-d2c3-08dc62b40da4
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 10:07:44.3662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpKWzflexGb6shr0zRBwBw4vKr0oXv5MB3169SMSahMfovafnb9qWftXbuWkPA9lcFaBk9o4DcKvG9RuUbaeH7/Hccf8DalPaKImcCXB+u4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7885

The touch-overlay encompasses a number of touch areas that define a
clipped touchscreen area and/or buttons with a specific functionality.

A clipped touchscreen area avoids getting events from regions that are
physically hidden by overlay frames.

For touchscreens with printed overlay buttons, sub-nodes with a suitable
key code can be defined to report key events instead of the original
touch events.

Reviewed-by: Jeff LaBundy <jeff@labundy.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 .../bindings/input/touchscreen/touchscreen.yaml    | 119 +++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
index 431c13335c40..3e3572aa483a 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
@@ -87,6 +87,125 @@ properties:
   touchscreen-y-plate-ohms:
     description: Resistance of the Y-plate in Ohms
 
+  touch-overlay:
+    description: |
+      List of nodes defining segments (touch areas) on the touchscreen.
+
+      This object can be used to describe a series of segments to restrict
+      the region within touch events are reported or buttons with a specific
+      functionality.
+
+      This is of special interest if the touchscreen is shipped with a physical
+      overlay on top of it with a frame that hides some part of the original
+      touchscreen area. Printed buttons on that overlay are also a typical
+      use case.
+
+      A new touchscreen area is defined as a sub-node without a key code. If a
+      key code is defined in the sub-node, it will be interpreted as a button.
+
+      The x-origin and y-origin properties of a touchscreen area define the
+      offset of a new origin from where the touchscreen events are referenced.
+      This offset is applied to the events accordingly. The x-size and y-size
+      properties define the size of the touchscreen effective area.
+
+      The following example shows a new touchscreen area with the new origin
+      (0',0') for the touch events generated by the device.
+
+                   Touchscreen (full area)
+         ┌────────────────────────────────────────┐
+         │    ┌───────────────────────────────┐   │
+         │    │                               │   │
+         │    ├ y-size                        │   │
+         │    │                               │   │
+         │    │       touchscreen area        │   │
+         │    │         (no key code)         │   │
+         │    │                               │   │
+         │    │            x-size             │   │
+         │   ┌└──────────────┴────────────────┘   │
+         │(0',0')                                 │
+        ┌└────────────────────────────────────────┘
+      (0,0)
+
+      where (0',0') = (0+x-origin,0+y-origin)
+
+      Sub-nodes with key codes report the touch events on their surface as key
+      events instead.
+
+      The following example shows a touchscreen with a single button on it.
+
+              Touchscreen (full area)
+        ┌───────────────────────────────────┐
+        │                                   │
+        │                                   │
+        │   ┌─────────┐                     │
+        │   │button 0 │                     │
+        │   │KEY_POWER│                     │
+        │   └─────────┘                     │
+        │                                   │
+        │                                   │
+       ┌└───────────────────────────────────┘
+      (0,0)
+
+      Segments defining buttons and clipped toushcreen areas can be combined
+      as shown in the following example.
+      In that case only the events within the touchscreen area are reported
+      as touch events. Events within the button areas report their associated
+      key code. Any events outside the defined areas are ignored.
+
+                  Touchscreen (full area)
+        ┌─────────┬──────────────────────────────┐
+        │         │                              │
+        │         │    ┌───────────────────────┐ │
+        │ button 0│    │                       │ │
+        │KEY_POWER│    │                       │ │
+        │         │    │                       │ │
+        ├─────────┤    │   touchscreen area    │ │
+        │         │    │     (no key code)     │ │
+        │         │    │                       │ │
+        │ button 1│    │                       │ │
+        │ KEY_INFO│   ┌└───────────────────────┘ │
+        │         │(0',0')                       │
+       ┌└─────────┴──────────────────────────────┘
+      (0,0)
+
+    type: object
+
+    patternProperties:
+      '^segment-':
+        type: object
+        description:
+          Each segment is represented as a sub-node.
+        properties:
+          x-origin:
+            description: horizontal origin of the node area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          y-origin:
+            description: vertical origin of the node area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          x-size:
+            description: horizontal resolution of the node area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          y-size:
+            description: vertical resolution of the node area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          label:
+            description: descriptive name of the segment
+            $ref: /schemas/types.yaml#/definitions/string
+
+          linux,code: true
+
+        required:
+          - x-origin
+          - y-origin
+          - x-size
+          - y-size
+
+        unevaluatedProperties: false
+
 dependencies:
   touchscreen-size-x: [ touchscreen-size-y ]
   touchscreen-size-y: [ touchscreen-size-x ]

-- 
2.40.1


