Return-Path: <linux-kernel+bounces-153153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 922EE8ACA46
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471152833D9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D5F13D637;
	Mon, 22 Apr 2024 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="TJrIVUHz"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2130.outbound.protection.outlook.com [40.107.22.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72AA1411D1;
	Mon, 22 Apr 2024 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780477; cv=fail; b=jCNjWiz3tdseVG0EwHyyreQ7F/DFXzgtOTRTUdSQ6/wKAa/k42lhN6alp42oKhJJPOedZlbaXUDTqEuqhjyYrwMUscWRG6gS4ObtNFZb0DallFBcdEPTJufBxzX1dRFwt8BLehT4LeTbQHfuNU4W0kSn1FsFn+gS1fAt8MWgfrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780477; c=relaxed/simple;
	bh=CRZ0sSYsoUecSbz+oUC0fLIT0nSbJZhwa7o6rQIIR/k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bhQDKs4NZZUlbZI3Osr7LRBGhG6hheAdej43+aQecAkRr9MgDrBsf79lkBJrgfCaJ95EM1XMw/iTwSmvPSjlMW4cPFoWrSAVVtOsKECUcpSUCcBFh4iBK1NNk5geu2EVMhIp6VbtkIjORA6Xw1LrO+9YDPbepep5FtOFrKBSfGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=TJrIVUHz; arc=fail smtp.client-ip=40.107.22.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuSucri5qQvu25UGjaoHG1R4KVp+QDId7qN8ccU2QoMQf/wZtfTPJ5ccF/oBPWKUz0hxFr7bqxAUak2+6IgPjhkupRxYbTqDf4aVkhwYCcYiL+b+WUoL6ajLSEST1TO3Nk6oh11CEx1ZbRGn6qkwB/mZgW+upMJokGJdU2GXXyCDSHxRdX4R3sps/YrL87ASSLIVwHPpP+uIsMV9Mup8z5Va7h27+PeMuAGmPIxzmRBOpvJke0sEhiYEkneonfma0HUkQlR4nDk+spAXcsFah0MopqQjwBrRuRxR9JJStgsArGOWQoy/TC0EvoB4UQ3YaRurQSY8qxS5kq19vl3bzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+IO+awHoDqlqKjGNEtdGlN859aV5MdUs044vwjEIJE=;
 b=Dqr/QABE8caWa/a56ol4ReehKCkecS4iIPcklDA2OMhQGk5qM/jlWC6ZTZo/q84QWvfvKZyYy3TvF/vWDWSaOVyMuXUPJQQsz7R7r9VWjWxRFKY4FWUWdOb5kPKHaCtHiAQlDBGT7D4rKcidsBoEYzPUa4pJuZACLK6mQakkfKxGbc8BTfA/HIyBUyyttU6/xcB7de1VoBT46ZCVo5L6bOZ3Rzo90ppc+8WG79NKD0q6BYtveKU1jSA2hzXnVaYzLgHwluZX2ua2hGK3E/QU1Sv5y1TSRq5J9wllqNvgmkH2nxwkyT40tPQmaiS/gtVvz3LMo4NsJMZeDq8X4VW60g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+IO+awHoDqlqKjGNEtdGlN859aV5MdUs044vwjEIJE=;
 b=TJrIVUHzmiX++ET66TtSabvP7/Cxn9Yz17RKtlIwFvSBrdJkjwL4UEtM1DMqFx9c4xiftAfrD/5S1LW65uuZhGKXwNBW6mOyCFvdwOPBfU0HQ30Bhn8xvrrsG/k/BP5xWJvjvheqh2N49h1aPlN1D9ndjXf2DG1An1llk+rkqcc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB7885.eurprd08.prod.outlook.com (2603:10a6:20b:508::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 10:07:46 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6621:68a6:ab00:c040]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6621:68a6:ab00:c040%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 10:07:46 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Mon, 22 Apr 2024 12:07:40 +0200
Subject: [PATCH v9 4/4] Input: st1232 - add touch overlays handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-feature-ts_virtobj_patch-v9-4-acf118d12a8a@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713780463; l=3456;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=CRZ0sSYsoUecSbz+oUC0fLIT0nSbJZhwa7o6rQIIR/k=;
 b=Ij3WXv4AoCK198k/VO+yiqFnjQJkIXg8miW7U4oxVJMKoYov+VSQ9g/cn+ydgNQ/LsEN69lSl
 SM8zeRKAkK+CbRB9XotPC9rb7ISei1Wtuq2k0KZa7m8QIlVSfF5xATd
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
X-MS-Office365-Filtering-Correlation-Id: 5d7f46a5-6868-41a9-1b22-08dc62b40e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1dyLzVucFZ6THJJaWpzbEZKWDZqWDlENWpTTDlxVmRGWXNsb3psaERlYXJ0?=
 =?utf-8?B?NUl3UjlsVi9BR0xHa2JaWTJpQmZtcGVhWFYyQ3cyd054M3IzYkNOTWlnbDJT?=
 =?utf-8?B?YjBUNWlxc1FLb0doRW5vU2tlRjZLTmhQVGZYMGcvNDkzRThLakpwODg3Wi84?=
 =?utf-8?B?OGkxZkdHTDhuQ2NFVDE5VXBFb2U4UmFwV2Z5Z242SUNaV3BFZWt4eWdKZEU0?=
 =?utf-8?B?b0xXSXBwS1JlUTRrSE53NG83ZDJMV1ovR3FNODE0ZGtvRHcxaGsrWU1GNmJW?=
 =?utf-8?B?MkNnWXVPU1Q1WWRFaDRxdWR6MUFtYXg1eU9aRUQ4bER3WCt6TEdjQm4rLzBm?=
 =?utf-8?B?V0dBTFRNV3hZeUpFQjZXbVM2V2s3T2xNTThtMG9NVUtzUjEyQ0k1UlZmV3oy?=
 =?utf-8?B?YStpcU9PeE11aW9kZDBtU2FWOHdYS3EyU21BL2pvRlpSMVpaQzRIUEN4QXRB?=
 =?utf-8?B?Wkx1RUtEb2NCOFRiQmhna0s0UXVyNmV3TnZ0S2FDS3d1U0dpK3R0eURKMUlM?=
 =?utf-8?B?OVRZZ09HRmJ5bG54OUw1aEpKSTZEdmlYcmg5N1RaSHZpQjdmeHZaWmhkQklj?=
 =?utf-8?B?bTg4Yy92VUFMSXVQUUFEakFMZTR1cEx1M3FDamVlS0FoRWd2dU14c2hXRmtC?=
 =?utf-8?B?M3JaRjUwZ2dWWm1IMnd3cHBDKzhDNVJZUDF2U1N4TllTaDdUeDV1L0tqSUt4?=
 =?utf-8?B?WGtWQjJKN1ZRSHkvLzY4Z1ZkRERZWWRQekg4MGRZdnBHUkh0SWVmZkZnZlAz?=
 =?utf-8?B?VmJheE9qQkxhdERmdWNYeVZuTTJzTDdZWVVPdWsyUERuL2JjOHoydndSNTBm?=
 =?utf-8?B?UWl5N0VIWEhCblFYWEJ6dVF3YVZXVU90YmJlcTNRQVRycitTWkZzNmZQb01G?=
 =?utf-8?B?YTFFc2ZlbFBZQi9mMWdZVSs0K3plTDBiVjYzaXdOeEZZOEtOVGZYMTB3dzJp?=
 =?utf-8?B?TzhTUkJkc0RxQmhzSXNZSTB5dm00MXhyejFnQmY4UHhJaDVSdkJOYUR1RFpC?=
 =?utf-8?B?dC9lOE42ak93L0lsS2xDT1hDRjVpYkZ3UllUd0dpS1d2TENBbUNrTVJJM3pJ?=
 =?utf-8?B?eUFUSjlJZjdXT2NsaHJxcFdZZUo0YVpsRzlFUVdNN2tZSzFzdkFZclIzTU5W?=
 =?utf-8?B?aFcxYzIwaWNYZzBoNEFHMUVMUS9QeDBiOVI3bkNINGRKaDVtenlDNlZQMXRy?=
 =?utf-8?B?OGJ0TXRmL25oVDl6RWJUMUVqZ1BDWGx4TFJDclBPS0VnSUV4NllyTlFQUE0z?=
 =?utf-8?B?U3NCT29IaEJock81TG14SWtCSHQ5R0pPRzBlRTlIVFZpYzNxNXp6MEVOU2Fw?=
 =?utf-8?B?a25iS0R2cXdPMHpCMVR5cS96RVZVdXB4OWNySGNoNCtoTitNd2lGZ2pES1dp?=
 =?utf-8?B?UnhUWDVlUVladGM2SWlLRnBqem1tUjh0bG9rN1J2Uy84WHRMZWV3Y1ZFc0Jk?=
 =?utf-8?B?czZOSEkwbmNwLzM0Nm9hQ2lWaUdqSjFRaThpUHZQWmo0L3IrdnFDeHlVMmpl?=
 =?utf-8?B?K29kTWo2K1hiSGNzTy9jY1JRTEJHNUFkMzl6aEkvc1FNTXdNdURDaUFwdUlE?=
 =?utf-8?B?SXhnOFJVZ3hnQ2VZVnR1VnlUdDJVeFRUbUJlOW02Y2xrQVJReHB3QzIyakN4?=
 =?utf-8?B?eDNDeG02ZzEwM2tjVXhMVFM3L3l5dTczZGJUWDBjV2NLUitrTElwM3hPOExP?=
 =?utf-8?B?ZCtqTG9FVGgxdGtLdGE4ZVdrNWUzajhOMVNGcGkweElSaDl0bncwSS9mY1d0?=
 =?utf-8?B?NFM5aThjVVVwbklDQzhyNFNTak56L093SnF6MEh6UStrNzg4bkxPdHhtZkxI?=
 =?utf-8?B?dkFHSUtNOEdJakxJSXJVZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnlHSTBqcnJNNFFXSndKd284eld3aFpGakNoZVVFYitKZzg1Zk90bHhjSjV4?=
 =?utf-8?B?RE9GRHpEcFZkRm9UbDVGVGF0MmNpUFZ6WWQxbUhpaWIwWTgxUVhzcWliY2pu?=
 =?utf-8?B?Vk1EQURjUFFUeC8yTzlNTWEwcEg1emhucVI2R1ZhSjVlNThSODhIVHhuU25w?=
 =?utf-8?B?Tk00ckhkbm94VlpDS0N4M0lnVjJUQlFxU21adURTNm1iWkpsZENNV3lLeFpG?=
 =?utf-8?B?S2R1NFdRak1NQlpKaHNORGZTbm51eUx6RHM2RGxpTWVkTlhrTFNqWUFYWXRs?=
 =?utf-8?B?L1ozT0QxcnlaSUxqUGtYTDNleGVLUkg2S2lwbU9DYmJoNU9qdCtXeFlxUGda?=
 =?utf-8?B?eXNDanJtdStlS0x5aUZlRHFBTVF5clh2SGc0WHFMOXRtb3NQK3FUYWxhYXZh?=
 =?utf-8?B?bTZOa0xnWG8zS3ZGWEIxSVFxYmNSK2Eva0pRY1MyU21KZUxSQXpYZjMzVWRK?=
 =?utf-8?B?STh5S3p3TXhtbTd5YWo0Vms0cGx6RFVOSHJxdUJQOGVmaTUwdFd1RW9sb09p?=
 =?utf-8?B?VWJ1NFlxZVBHNEFTM0xKV2V3U2wvSm5LTFEydmsvbm1hbFZEdUp3eENmeEww?=
 =?utf-8?B?Y2oxTWlCRi9FdEE3cVNHYXlWZ05kbWI2blArVFJwZmNtSTNtVmF3NHZXOUJV?=
 =?utf-8?B?aFgvcjZudlpJVDJ2QmhMbktHcXZVbVQ0UmNCclBmMUFoYVdSTFpJNU1lWHBZ?=
 =?utf-8?B?cU56akZqSnRHczdnRFd0bFk0SWtqMEJFSnllclNoRWdkc1p6cjEwN0pzbnFw?=
 =?utf-8?B?TmtEeTFDZ1dEQUZDaE9leU5ZMnRYei9TaFNkVnMzMkZncVRGaHBCYU9aQVpU?=
 =?utf-8?B?TDhLTkJRRUdzbjBuVDVPZ3FPa0dOQlJneHJkRXdoK3pRQU5SNXBPc0JEK1Iy?=
 =?utf-8?B?UU9YUlVtVU0zZHVITmNHb0NadU8rdWI3YmdwZStpVGZORGZZdDFSR0ljNEdl?=
 =?utf-8?B?clRqbENRaXBMQ25JWDIraC83TDZpM0lkQ0lzR3BoQXptTkN4QmxOdVpyZVo0?=
 =?utf-8?B?eWlmRWthZ3BDYzZoa0UrZUpkUlIzSjVRMjREeFJDcVpwa0NGWHhpUXorL1p5?=
 =?utf-8?B?YzVGbjBWajBmdEtYVTluSk5HT3FKZ3RBVW1mN01mdks1eW9lbTk4WWpTMHFz?=
 =?utf-8?B?L2FJazE5T1NzVXo5YjkzSVd2NndxczhnMUlVZTRmb0NBRC8xY1dPUmoyZWpz?=
 =?utf-8?B?WkVFaklJRU9IeVJkOUYyZTF0NTlpbE9SVjBKV3lEVVE2cTZkZml1Q1Avcm9W?=
 =?utf-8?B?eWVvMnVtbDU1YnprcjZrSTZkWUZKdTBZaHFBNVY3bHpXNWlKWlNuZFoySEgz?=
 =?utf-8?B?eFcvNzdqcU9paVBDL1BXVHRUMmcwUjRUT2Fya1licFBRcC9ZUVFOakZGbmpE?=
 =?utf-8?B?SFZmRkVEdTJlMUE0R0cyVG1hR1E2Z0k4ZzJMNFJ4R3BCdDlRNExTekk2TkNV?=
 =?utf-8?B?eUEyQVVZc1ZpcUF1Q0c3MXhwSmozK3BSRUpibVB0S3JFYnYyTFhDc3dJcUwv?=
 =?utf-8?B?WTVHbXJWRHRtUVZNRjIxNGpET1FKeDczZTRQanY4R0RESUJiRVlHYjVVcEVK?=
 =?utf-8?B?KysyR0ViVUIvMmVTdnllaHBjeFIwU3JPVDA1RUh0citsNmFWWmpJcVhVMzFQ?=
 =?utf-8?B?TU1VZ1pyZW15YkE0UHh5eC8yWkJPaEZLelNWL0NnQWZFOEZjemMyT2MvVjg0?=
 =?utf-8?B?dFpZWlZraWVlZ3ZvNEFDcU1VODlFNkw1d01PelNPQk52UEI2cDlONWR0WGNw?=
 =?utf-8?B?WXdEcjFLbDB0alJCUmVwSS9aV0xTTWRRRUJkKzhxMWpIcER2WWdXZ0cyT2Zx?=
 =?utf-8?B?cUt5VGVDbmRWM2dzU2RzVXAraS9SY1RJZ1pGNnlDV1g3d1dEZnczSkx0VjNq?=
 =?utf-8?B?L0tCSzJKS0R5T1Z1RnlwMEhIOU45eVIwU2JaQ3p3N1dRYzhoc1NPUG9tc2NR?=
 =?utf-8?B?VGdIRCtvZVFEMW9kR2RRczB4R3JOUTdTN0lOWTVGQ1l5cHBaMzY4cmJIb3Bi?=
 =?utf-8?B?ZUlyUE9VTkNzSmFpSDBpUlREbVFKd1BWYU9IK3E4aXFma1oxY0Zlc2VJVDRK?=
 =?utf-8?B?Yzh6ZGl1dXNZWGpwb0YxakxGUkpiaElqc21EOTB6YnlhNTBCcFdsdlh2Q3Bk?=
 =?utf-8?B?RHVhMWpxWHEwYk1sR1pGdk1teUVkWFJvdHZjaVVja1lEMTFJdlRWOVpJTTVH?=
 =?utf-8?Q?PJieC2c1zKL7QRzoyi/cz3c=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7f46a5-6868-41a9-1b22-08dc62b40e4c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 10:07:45.4293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9CbdI3PImcHTPKXIgC24z6TEsBz6qx49E7RRPHbx659H63BDRXG76wcJu6HZ1ATY4AJOFhVZy5EgsNNxZK6TVZHO0cqwhAyOF7QpFVtLzw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7885

Use touch-overlay to support overlay objects such as buttons and a resized
frame defined in the device tree.

If buttons are provided, register an additional device to report key
events separately. A key event will be generated if the coordinates
of a touch event are within the area defined by the button properties.

Reviewed-by: Jeff LaBundy <jeff@labundy.com>
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/input/touchscreen/st1232.c | 48 +++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 6475084aee1b..4fa31447dbc1 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -22,6 +22,7 @@
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/input/touch-overlay.h>
 
 #define ST1232_TS_NAME	"st1232-ts"
 #define ST1633_TS_NAME	"st1633-ts"
@@ -57,6 +58,7 @@ struct st1232_ts_data {
 	struct dev_pm_qos_request low_latency_req;
 	struct gpio_desc *reset_gpio;
 	const struct st_chip_info *chip_info;
+	struct list_head touch_overlay_list;
 	int read_buf_len;
 	u8 *read_buf;
 };
@@ -138,14 +140,20 @@ static int st1232_ts_parse_and_report(struct st1232_ts_data *ts)
 
 	for (i = 0; i < ts->chip_info->max_fingers; i++) {
 		u8 *buf = &ts->read_buf[i * 4];
+		bool contact = buf[0] & BIT(7);
+		unsigned int x, y;
 
-		if (buf[0] & BIT(7)) {
-			unsigned int x = ((buf[0] & 0x70) << 4) | buf[1];
-			unsigned int y = ((buf[0] & 0x07) << 8) | buf[2];
-
-			touchscreen_set_mt_pos(&pos[n_contacts],
-					       &ts->prop, x, y);
+		if (contact) {
+			x = ((buf[0] & 0x70) << 4) | buf[1];
+			y = ((buf[0] & 0x07) << 8) | buf[2];
+		}
+		if (touch_overlay_process_event(&ts->touch_overlay_list, input,
+						contact ? &x : NULL,
+						contact ? &y : NULL, i))
+			continue;
 
+		if (contact) {
+			touchscreen_set_mt_pos(&pos[n_contacts], &ts->prop, x, y);
 			/* st1232 includes a z-axis / touch strength */
 			if (ts->chip_info->have_z)
 				z[n_contacts] = ts->read_buf[i + 6];
@@ -292,18 +300,30 @@ static int st1232_ts_probe(struct i2c_client *client)
 	if (error)
 		return error;
 
-	/* Read resolution from the chip */
-	error = st1232_ts_read_resolution(ts, &max_x, &max_y);
-	if (error) {
-		dev_err(&client->dev,
-			"Failed to read resolution: %d\n", error);
-		return error;
-	}
-
 	if (ts->chip_info->have_z)
 		input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
 				     ts->chip_info->max_area, 0, 0);
 
+	/* map overlay objects if defined in the device tree */
+	INIT_LIST_HEAD(&ts->touch_overlay_list);
+	error = touch_overlay_map(&ts->touch_overlay_list, input_dev);
+	if (error)
+		return error;
+
+	if (touch_overlay_mapped_touchscreen(&ts->touch_overlay_list)) {
+		/* Read resolution from the overlay touchscreen if defined */
+		touch_overlay_get_touchscreen_abs(&ts->touch_overlay_list,
+						  &max_x, &max_y);
+	} else {
+		/* Read resolution from the chip */
+		error = st1232_ts_read_resolution(ts, &max_x, &max_y);
+		if (error) {
+			dev_err(&client->dev,
+				"Failed to read resolution: %d\n", error);
+			return error;
+		}
+	}
+
 	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
 			     0, max_x, 0, 0);
 	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,

-- 
2.40.1


