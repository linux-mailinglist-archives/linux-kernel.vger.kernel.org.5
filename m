Return-Path: <linux-kernel+bounces-153150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513598ACA3C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736441C20E49
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC3113E40A;
	Mon, 22 Apr 2024 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="HFr/Rb5K"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2130.outbound.protection.outlook.com [40.107.22.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFBE13D611;
	Mon, 22 Apr 2024 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780471; cv=fail; b=SP1I12L5Yhmry+8bm5awocYCoXswqsCaMphU6VHfb4r4zYL9krt8aDEwFWvIlB+6W3iy5Ei1kWb78jKJNT5Luv8zNAqKpr3Q32QPaQfNQLGj83rf9Falyr5uTudVnHzn8erUrJb/NG7Nj7yAq91biLhza9EbT6X+Ou9g/v7Cb6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780471; c=relaxed/simple;
	bh=xqSujAmAV6/3SRa4nYhyKQa4ADU+qccjdvBXJR5CB0w=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=jtRbw8BH5eDHpMzirSZr14UfLBRw095ZbamkmL9un3huhv12OFfrHkOVDe8xWzD9ffEUHKOhvOQJmAkjeoyMkAh4SvUtxFEbxsGt9CH/NRkcxu5+UMSqVjrlGs8NS1ZjJdS0fmpN7jLGu54bANun2cguRVfmPIVP9w1HuFJT2KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=HFr/Rb5K; arc=fail smtp.client-ip=40.107.22.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGTF5WqN2ENSvfb+ZaTCH0T3P5tlc11R/so6jQdjBkoxhtuMguAdwZNDScjEH4pz6+dESpe3c5qRs0WHtJkzRVctHRzHO0fpgIuUbnqVptpvvhNkpAgj/4/Y9/qNZCxDsl+m08z73uzJF/d6es5mLcFnmtctBOHb0nqs7i4VNoiOHjyAhYyCmLOCNErPi4LBvStXXsvaYIPFfX4yPJ3uxYEkpIziOzxXn/k2PpAq6lautTf/NhTF3IhK7/TrPmLfyFjlsLF2or9rk9AgEyWgD3X4JOoO/EpkY1ZeeuFXqGdtug6+AJ4wJZb8i8AFJuLsRs1ucqcH54l+m/Thn7SUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWBj8+b4lzxBjqPTVkhmewDiQTK1BlKfm1lKWS6844Y=;
 b=jNyKc+gx2ri/+Sp90A0jga2wRSRrstQCa8aHPhc16+XIMNxfLBzrIuklzK1AI+Zb3fdigbFz61sXDfx+PPoZdFtq9kRAjJW+DMdgaIiyxoNdMcJdQrgsqnI080toXmcH7ppIiWPbB7ShzXn5bNbENbCOx05z+sRTjU3XEXl/PidYfpSPl2w05xbgxlhJq3QVRPnpWgVv8+gICJIlNeOJYMJZzxPLwmZC8TOxbeTvu1d4blFLk7xEoNu31NWB04XZY+GahC7HGhn5hIZQSHnNzi8qS5Wv3PHYe1ZHxIBhLAXlD1a2iUc+bQQV6liGkGUZPlrK2RmrE3ZCaRQiqzS/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWBj8+b4lzxBjqPTVkhmewDiQTK1BlKfm1lKWS6844Y=;
 b=HFr/Rb5KXpyGgsxzDgVhl0mBjwNKNM7Wj64hKYw7MzYHnKfme5pMV/lmKVdiBbeHHZK1avf39KaxvnBH5/a8JrAuPwKqOjTr2g0KE0IuJJxDChMhm0vf7xJVgDE9RnrUdowWllbcvIrWpnqXMC68YPER3+s+RY8ng23asPUKDzE=
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
 10:07:43 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH v9 0/4] Input: support overlay objects on touchscreens
Date: Mon, 22 Apr 2024 12:07:36 +0200
Message-Id: <20240422-feature-ts_virtobj_patch-v9-0-acf118d12a8a@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOg2JmYC/43Q3U7EIBAF4FfZcC0boPx098r3MGbD0MFiTLsBR
 M2m7y6s8crGcHkg8w2HG0kYAyZyPtxIxBJSWJcaTg8H4ma7vCANU81EMDEwxRn1aPN7RJrTpYS
 YV3i9XG12M0WhjZLMWjSS1HGwCSlEu7i5AUUfJY2Ot6trRB8+71ufnmueQ8pr/Lo/ovB22rGvc
 Mqosqhw5OCElo8f65v/aXBcMJMmF9Griap5PVoNHo1lflcberWhaiA9GO8kWDC7muzVZGvqtGP
 eccRJ72qqV1OtqdegnJxAn4ZdTfdqumpT/TamTkZxta+Nv5pkg/hPG6vmLGg0kwPu/zbdtu0bw
 5RkrbQCAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713780463; l=5105;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=xqSujAmAV6/3SRa4nYhyKQa4ADU+qccjdvBXJR5CB0w=;
 b=fmxxqBdBNNy9Pp5XfwiBYiXjJiypAOnULXDgsjUKr3wSRPiNn8pnXlB9rs/06m3sU6H0sR1jt
 bifSR6ml5/8DtvjwxqmW90HhxGAHJTmLLAwX/OHnreGIWNtC4909F3Z
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
X-MS-Office365-Filtering-Correlation-Id: 5e81507e-e936-4135-8f20-08dc62b40d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVgvSmdFTkNYcmZYM2ptVlltV2czcVllQnhpRE1YYkxUTWFpZ0xhaldZU2FI?=
 =?utf-8?B?VGg1ZzF4VXEvMjgzcm5BU2NlSGMvSTZqVGd2UWdaNThzUjh4bllBenNjS2RP?=
 =?utf-8?B?eUVORUdDVFltNzRkaG1DUURXQTNZaUdkaDBlUDdsN09tL0hJYWNraHE2dGNx?=
 =?utf-8?B?RXdpbGxpSmROd2twN2t3amE2T1N1ZG5kRWsxRnpibFV2VW55T1ROOFRYbzF5?=
 =?utf-8?B?K3FDYUcxTVJpbGNIRUM1U2VTQTEzSE92RElxZW1WcGE3MmRrY2wvQ1NRUjY1?=
 =?utf-8?B?K2hjdHFqdDBtR0VFNkgveFl1Vk9jWXJEU0hxN0JtOTlyUUo0N3dRSlBCM09S?=
 =?utf-8?B?azMyRXFpaVJVSTlsS21Ib3RxaENYMklGaTNhZE9TVGdZQ20vZDNRMnJWOFc1?=
 =?utf-8?B?KzhUUWJINmVHdDVSRGRwdGRyMlluUVA0cEp0OWs4d2RXbFc2WWJxTy9PZ2xt?=
 =?utf-8?B?TDNJL1ZId0hXOXJBUzR2aFlJSkg4QkxRNzluWXA1QkJ3RWRUVDkvQU9kSVlK?=
 =?utf-8?B?dkJPL3JOZ2JjSEtWdnUxcTZsbDZEZTNDN2lRTkVjQ0QrVW4ySmxBQ3ZiUTNU?=
 =?utf-8?B?bW95dXNsVW80V1V6STVHYURid1ZWNU95SHhNbGZ4Q1ZBNUFtWkNkMkVUajhK?=
 =?utf-8?B?a0tuNVlmcnJ3cmtuRTBOeXJsazJMaWxWZHdaKy9RM09ONGsrWXBybG9STW1y?=
 =?utf-8?B?NDBuNHNpdGtVZ2cwcC94WXZSeUJqZ1ZET3ZyTWdaSzRTRXRjM1E0bmMvakFh?=
 =?utf-8?B?K3B2b0xUR3NyNzhWWDF3cCtyQlJHdWx1L2E1aTFyMWkvcStMY0RuL0V1blV4?=
 =?utf-8?B?YnJyUDhjdUdzSWxZYXZTcUl5TVJTb1FwRUdlY3ZTMXhJSVN1dVhvS2FYV1Rn?=
 =?utf-8?B?UmMxanlMRTRndVVJMXNvN0l4UTlrMit1WEZWMHZBVkd5cldYZHdWWitNU242?=
 =?utf-8?B?OHpoSVk3VllpelJkRTNWM1BOMGhicDlBVldGSjl5c0RDT3UwQVhoKzNTdDd1?=
 =?utf-8?B?dmVLREFaNk9KTWRwMTZ6YXVBd295SkE5T1JZVDRhMW96L2h5T043VGcrTWw4?=
 =?utf-8?B?TjBOeDI4bk9rOWt5ZjBGcTNaOGlBM0NKM0lMTWRjSHpsci9INzNFZy9sZ3Fh?=
 =?utf-8?B?azlHTk1pM3pjMmFwQk1XdWYyTnFkNDdyeWQzcWFLdkZ3d2FsT1JsRFhqVHRB?=
 =?utf-8?B?TkJ6c093T2lLRC9HT01JbzRsWFRRUFp0amsyOHROekZEN3lqWjdyUFFIVC9s?=
 =?utf-8?B?MjV5d2lyR3EwUkJBTWp3VzVDbkJ1U1NDbDZ5ZlEwdWRUZWNzMDFmTC9mNWJF?=
 =?utf-8?B?R3pQSDJGWnhyOFBoUGkyaVFmZFE5bnZ5bUc5aFcwSDBLWlA0d1Bib2NRd1Vw?=
 =?utf-8?B?bWtsMXVGRjBBdTNMUytEdXQ2Zm12Wkcrdm5HRXgwYkdUZ0ZBdVJpTXVjQkN4?=
 =?utf-8?B?Ymh0OVJFVis4MFAvN1BlaHRzcU5KdU5YWXUvVTJsQjdlanl2RldxVmt2b0lk?=
 =?utf-8?B?MFhvNjhyRHA4Nlg2Rmo4eGpDaVZOdUdrd3pKcWhwS2FYVElhNlM2cytRL3R1?=
 =?utf-8?B?bEgybDBlK2tLU0JFRW9tZkViVXhLNE9SNTU0Nm1uMElqQU9xeE8xWE11b1ZD?=
 =?utf-8?B?aEhwVk1ZL2p0c01YSDRoOVI4VzAxZ2Z4OCtHWno5Ym9iQllPOThJQlNSNnBD?=
 =?utf-8?B?RkF4RzZYVGpjUHcrekpVOEp0a0s1Y2p0UE9pWHZFc0I5dHprV0UwdCt4T1dx?=
 =?utf-8?B?TzJPTEQ5ekFaWUU5V0JVREo5SkVQanZOczRTdElTL2tDTDNnaHFNT0xWWEYz?=
 =?utf-8?B?Mjd0cEhySkVqZjQ0SklhQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFJUY3FQSCtFL2xSSlljYkdsTHczUnRlMnMzaWx2QXVSSXVRdk5sOFlNamox?=
 =?utf-8?B?VmxzTCtsN2xjS1FrMjZ2REpTMVJFK2ZxNlJhOHBwOXdQS1o1RWZ1WUZIQ2FL?=
 =?utf-8?B?dDc3UHBCRVozc3JaMkg0NGdIMENuNWpPNE5NckFuYW5CZTRrNUNyTFExQzJY?=
 =?utf-8?B?c0ZNcU9hMzNLeVlWM2Y5U2ZVUkl2SU9DRXpLUVNBL3NFMzlGaFQ3QVJvNmZ6?=
 =?utf-8?B?TWVQY0tlWGlvZ2NlU1IyK1hrZTBlMWRyZUpmZGgxRW5GL2xhT3FuOHdaMUx5?=
 =?utf-8?B?MlUwSHNIcWg3akRRK3dVaHp4ZjRVQVJUUm4vd2NwTWdnZlB5aWFwNHdWTDBi?=
 =?utf-8?B?YkJ0Y2t3d0NVN2tpVW9OcnhOakhuS1B5eDlycm9Uakl2TEJKaFQ4b0dUSnRw?=
 =?utf-8?B?SGJwUEVsWG9jaVBuWlJ4QTVwMU9jTmlwU2tST3g4U0lOUS9YaUZoeFlCVFFG?=
 =?utf-8?B?MXpjNVE5TnBRck1YM1FRZDkwZXV6Q0xKU0h4eTY3TGwrbWNHRFU5ZVJTWU5L?=
 =?utf-8?B?NWdyZVc0dkRLVGJIWTdyYjJQd2RGZUtzNG8wcjJNdjkxNnpNUjJpVnJZVzdh?=
 =?utf-8?B?RXZtK3JTRjNpTXVHUTFOYUcxdlorNGEzZGNiVW5ybmc2Z3lUVEV1Q3d2WVhr?=
 =?utf-8?B?Z25JeThLbkQ4K3YzZDNDQXNlZ0pCMWRkOUdrWHF1b0RoSTdhNVdPVVJ2SHdy?=
 =?utf-8?B?YU56SjcrZ09xdE5EUE5qQWdXdFp6WjZRZk0vcFhDeFU3a2pSVmErSVdia1ds?=
 =?utf-8?B?Z2NmQms0ZERvb0xNdkJzSDljUFU0YjVvK1EraGNtTUx1YkY0U3pHQjJtQkor?=
 =?utf-8?B?cTdjQUoxL2lobEdNK21TOVA0VHAyVklPZUozYzdBcGlrRkxybGNna3RqWjRS?=
 =?utf-8?B?VHJPNS9Va0UwejQ1VGhIQy9OMjJQTTJ1OVRBcSt5VW1NNXdrZE9wOUFGU3Av?=
 =?utf-8?B?Tnc2VlM5TjJaNXRSOURaT1pUV0N0aHVlNEVGeGs5d0p1d0pFbkZUWXNmQTdJ?=
 =?utf-8?B?RC9EcU4wV2U1YWI1blZFbmFIa1dTVmRCY2dGbVhYMkVhZUc0WFpGTktodFNC?=
 =?utf-8?B?NnBwT21idzZnRk5TcHlVNjJwYWJ2dXZKdXMyYXdaTzc3dnc4YkhMczRmaUhm?=
 =?utf-8?B?algrakQwM3JlWDlTQTVHeWZoa2djVG15dEVkbXJ6eittN3JyUngrenBmbWN4?=
 =?utf-8?B?Y0gxc2duUkZSUE1NeDIrQm9Qby9zUEQ5d2x3bHp1MG1KaXI0MFJpL3hYdlJV?=
 =?utf-8?B?ZjljSi80RkJ0VzlPMGpKQ3k5eHRuOEJCeVNRa0VNM0F1em1yNVEyZG1DMkZY?=
 =?utf-8?B?dVVweVBnL3VrUzF4anVWWEQ4eUJjeHhOZWR3dHpSR0x3WEVyMDI0OEFMZHdJ?=
 =?utf-8?B?Tk40dStEVmJzME9aZVBuVG15VWNVMWt5Ry9KZ1pYcGVrMEU3UVFjM2tpMkRy?=
 =?utf-8?B?R3htTWpaZVN4UzRpYmRKQ2hDR3hhMi82QklkNitTZ1MybWV5a3E2L0pTZmZm?=
 =?utf-8?B?UWNiMjBqK1MyQ09LemFrWGNkR3h2UW1lWjFQTjdteXFhUkp3TzB4SXd6S2x6?=
 =?utf-8?B?ZjBtTWlDU0lyYkdQTmNhaEhuRUt3WDdJUitIbEtBSmdaR1owMVpOSXpoL3Vn?=
 =?utf-8?B?WTFxT2ZnZUVBNjJMMnFnUE9oTFdEeWpJK2VjdjFIcWU3bHB5V2MvZlJDdVFK?=
 =?utf-8?B?MEsxZHprTENLdFVkb3RDYTdrUnhraHI2SStNb3NwcytuKzNjckgyeXpIemtL?=
 =?utf-8?B?MEM1Z0lRZmJ6b2lQdGt0dXhtZUFlSWhUOGlsZ2lRRzdVSG5wOVg3czVKQys2?=
 =?utf-8?B?NDFGTXh0S20zMEFmM3lzbEJ6Sjk1Y3l3WCtxaHczalV3NDUxU1o3NzRuOTdR?=
 =?utf-8?B?Z3piQXppSUkvSEhLNEdyWFRBK3VmTitRVnVjaHVTOU5yckQyeXg0NWVPZUZq?=
 =?utf-8?B?czArVDUyL0tXL3ZNZFFxS0JDaCt6bTRibjlNL1NCL1FNQWVGdTlhT3JIU0Z2?=
 =?utf-8?B?SXlsMGc0Z1FaQ3NNOXRLNVNVRzZiUDVYUEp2R3ZDN1hrbFc2VzAvZVJVRm5X?=
 =?utf-8?B?ZlVGbGlrZGUxRko0UEpHaTlsMWlzbDF2L2psdFo1MHFhWkRtUzU1ZXU3SEYw?=
 =?utf-8?B?eVExMFdNT252bko0THZSdjJ4ZnlVMlRGa25IdU1zRGVQSnpTeXRmMDJpQmpp?=
 =?utf-8?Q?Q5j6w1Hw6Lec25IbCUKyE8w=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e81507e-e936-4135-8f20-08dc62b40d4a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 10:07:43.7707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Wybz9jA2ZxsQdRibtxuJI0ZWo1dweiTk8ka3qXKTk+A4nk3m5eka1Pya37Rvn96s2iWvVNemKiif5toDj5NlWhDxsIjiq+5hqEU1jvRxi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7885

Some touchscreens are shipped with a physical layer on top of them where
a number of buttons and a resized touchscreen surface might be available.

In order to generate proper key events by overlay buttons and adjust the
touch events to a clipped surface, this series offers a documented,
device-tree-based solution by means of helper functions.
An implementation for a specific touchscreen driver is also included.

The functions in touch-overlay provide a simple workflow to acquire
physical objects from the device tree, map them into a list and generate
events according to the object descriptions.

This feature has been tested with a JT240MHQS-E3 display, which consists
of an st1624 as the base touchscreen and an overlay with two buttons and
a frame that clips its effective surface mounted on it.

To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bastian Hecht <hechtb@gmail.com>
To: Michael Riesch <michael.riesch@wolfvision.net>
Cc: linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>

Changes in v9:
- touch-overlay.c: trigger a button release if the finger slides out of
  the button segment to be consistent with the button press when sliding
  into a button segment (see touch_overlay_button_event()).
- touch-overlay.c: (nit) remove braces in if with a single statement in
  touch_overaly_process_event().
- Link to v8: https://lore.kernel.org/r/20240320-feature-ts_virtobj_patch-v8-0-cab6e7dcb1f6@wolfvision.net

Changes in v8:
- touchscreen bindings: fix description formatting.
- Link to v7: https://lore.kernel.org/r/20240119-feature-ts_virtobj_patch-v7-0-eda70985808f@wolfvision.net

Changes in v7:
- General: return to a single input device implementation.
- touchscreen bindings: segment instead of button in the label
  description.
- touch-overlay.c: define button-specific data inside segment struct.
- touch-overlay.c: remove fwnode_property_present() and check return
  value of fwnode_property_read_u32() in touch_overlay_get_segment().
- touch-overlay.c: simplify return path in touch_overlay_map().
- Link to v6: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v6-0-d8a605975153@wolfvision.net

Changes in v6:
- General: use a single list to manage a single type of object.
- General: swap patches to have bindings preceding the code.
- touch-overlay.c: minor code-sytle fixes.
- Link to v5: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v5-0-ff6b5c4db693@wolfvision.net

Changes in v5:
- touchscreen bindings: move overlay common properties to a $def entry (Rob Herring)
- st1232 bindings: move overlays to the existing example instead of
  making a new one (Rob Herring)
- Link to v4: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v4-0-5c6c0fc1eed6@wolfvision.net

Changes in v4:
- General: rename "touchscreen" to "touch" to include other consumers.
- PATCH 1/4: move touch-overlay feature to input core.
- PATCH 1/4, 3/4: set key caps and report key events without consumer's
  intervention.
- PATCH 2/4: add missing 'required' field with the required properties.
- Link to v3: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net

Changes in v3:
- General: rename "virtobj" and "virtual" to "overlay"
- PATCH 1/4: Make feature bool instead of tristate (selected by
  supported touchscreens)
- Link to v2: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v2-0-f68a6bfe7a0f@wolfvision.net

Changes in v2:
- PATCH 1/4: remove preprocessor directives (the module is selected by
  the drivers that support the feature). Typo in the commit message.
- PATCH 2/4: more detailed documentation. Images and examples were added.
- PATCH 3/4: select ts-virtobj automatically.
- Link to v1: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net

---
Javier Carrasco (4):
      dt-bindings: touchscreen: add touch-overlay property
      Input: touch-overlay - Add touchscreen overlay handling
      dt-bindings: input: touchscreen: st1232: add touch-overlay example
      Input: st1232 - add touch overlays handling

 .../input/touchscreen/sitronix,st1232.yaml         |  29 +++
 .../bindings/input/touchscreen/touchscreen.yaml    | 119 ++++++++++
 MAINTAINERS                                        |   7 +
 drivers/input/Makefile                             |   2 +-
 drivers/input/touch-overlay.c                      | 263 +++++++++++++++++++++
 drivers/input/touchscreen/st1232.c                 |  48 ++--
 include/linux/input/touch-overlay.h                |  22 ++
 7 files changed, 475 insertions(+), 15 deletions(-)
---
base-commit: 0bbac3facb5d6cc0171c45c9873a2dc96bea9680
change-id: 20230510-feature-ts_virtobj_patch-e267540aae74

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>


