Return-Path: <linux-kernel+bounces-163259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D83C98B67D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF431F22C13
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5284CA6F;
	Tue, 30 Apr 2024 02:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lX8XA+9x"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70B88BF6;
	Tue, 30 Apr 2024 02:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714443234; cv=fail; b=gvpbwIE/zd0HTVt3wmMwV2UVF7mL3rteWwoPihG/4d1NgXpcHjmpPgKaKYmlH8OAdyhsQZSC9DOolq15BeCClQMnLkFtW4Jn9OEjVQMUsLdWdPKbWU0buPPiavcGBWs098OM7hvbXHj7fra9SRCuXeEIvj7NyE+Fl+QlqwiyQLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714443234; c=relaxed/simple;
	bh=UXrbkQ/u4XM7BCqHDdk9hMz31Id+EKfV5CrIb7KNhPI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xa50180ZmQIax/SXCNQ3/+dFewJdkkcBfVuolK56+nJdbQANpp9sVmgI+BIHan1qz6pYq4WK3tcREKB5lfWvmcpPh6JkwMot/zV4dgtpgWa1XKYEiRJfv3MamDtu+8y6sLqiFIP+JVHFog9cuTT2zZ3/5+Zt4/OG1O8cPM6rt6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lX8XA+9x; arc=fail smtp.client-ip=40.107.7.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmvuW579JHM6UazSVxAHNXSVkoQ56c65c/MDUq3XCtk8vuPa5j80VPUBbTwgkgi53irFTxnqkfMRBZQCh40U5VCHaW3RD5jECAMtRi8oMNbOxPxSIcU5pn5EiSCDA0rnf0lF8Ln5U5k9rYbRx1XV098atOozPMZUE6KmnkwMSRNx2gyhvOs4B0fMIejIvimmLkQIY9cfNHBTfsp/185CYVix97b/0A6UpbhIAoEx+zlzukU5a4I6WDimEcdBATcKrohtWn3y8tIqYL25YnbKu7ba8TXjJi7PtEhB444zanFmvYNpAHq/JNdIyAXtTFfSl5nQM2k/gROhX5DYlxDucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7Gx3+ATZ/wJJB3BPRygNld5XHLVp1p1ajZk3USx8To=;
 b=htW9EHansiVyS3LdrTp1w0U9M8DJCFQXoa/1QUDO2xZajvv4rK9pV2SzDaDyMguseBMFku7o5NBcAOwV4utIMouKSe7dHQtlggN6EZYj9ZYuo4yEXtX5erdo7g4homhOmhJzlk4vxZY3fe2Il5Dvdwy6ETGRdglKvnzmnSadV/MNBaImIKdhcXwd7SDMT+205JrouT3u5J6WH4eaMlGS53d4V07NIUc0SaOP+nmdHfAbQ/WJZ8DUAYo3ZI5ELfQP3zie6BYwl0qnJPK77larKneHV2gBLsxJxv8wJlfXlKzsJ5Qqa69v5vwc0nQsOR+f1oLDv0Fdm8XvbVM9iEZuHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7Gx3+ATZ/wJJB3BPRygNld5XHLVp1p1ajZk3USx8To=;
 b=lX8XA+9xhhWl75iLxQL6tYvL+/JEf92C88o2fDmSCGi6gJ0pCLyocpxuQgNOLDZVo5Dy4uKkMth4Jwz3k2bMRxNd5Yvjj+jt8qHtY9Ekr+4KRsjfBPA0Iuw+yfN9+yTLJWFLWejhwgIr143d1RTnhitJqJZV4KWq9PM4dEojABQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by VE1PR04MB7296.eurprd04.prod.outlook.com (2603:10a6:800:1aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 02:13:48 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::8589:eb00:ecf3:b4ca]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::8589:eb00:ecf3:b4ca%6]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 02:13:48 +0000
Message-ID: <383b6e30-1266-4db1-9c5d-10db7ab17957@oss.nxp.com>
Date: Tue, 30 Apr 2024 10:20:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] media: v4l2-ctrls: Add average qp control
To: Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
 Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc: shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
 imx@lists.linux.dev, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240425065011.105915-1-ming.qian@nxp.com>
 <c9fdf07d-f434-430e-bb41-8bc8f6bf1bb8@collabora.com>
Content-Language: en-US
From: ming qian <ming.qian@oss.nxp.com>
In-Reply-To: <c9fdf07d-f434-430e-bb41-8bc8f6bf1bb8@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0032.eurprd04.prod.outlook.com
 (2603:10a6:208:122::45) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|VE1PR04MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e13990b-6417-44f8-4c74-08dc68bb2bad
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VER3UTNwWXNnSTdPRWxCMnQyMFR5OHNJRG9BSENvdjlLTHo5b2d1MC9nZ3dw?=
 =?utf-8?B?QksreGZ1QmF4ZUlVeUJyK3NtaXdNVGVFakk3ekZodEVtdnJNQUxyUExDamg4?=
 =?utf-8?B?VlloZXcyQmxkY0gxNDlFZkJmMWNUZkRjQTVjeVFyaUVoOGRoK1dEenpqc1RJ?=
 =?utf-8?B?c09hV0JGa3hZWjNZYWZYQWtCMU9BdEsyeHdBZkVuZWhUM3lBSnFEV3k4MnBE?=
 =?utf-8?B?cUt1WTZtUkZrdjltT2VpUWt4VmJtNFp3cERVYUtNeWp1MElQTjM2OTkwY3li?=
 =?utf-8?B?WTJXcm5lL3ViWEY2Wkh5SDJkbzVCVHBZZHE5emN3ZTZZait3eXp4bExUNWZq?=
 =?utf-8?B?YUh6QWQxeHRxcXIycDU2YjZYcDMwdmxQeG8zbWZScmlEV3JrSlNWWFJsbXFH?=
 =?utf-8?B?WXZ3VFBpWm9hczY2dk1QcEdGZ1BqaEtJZStPemFTb0xFVWpWQzhwZHhRczhm?=
 =?utf-8?B?aFRmTVJpY1pIVzRsTkpnTy9kUlN0NTQ4akdhVHZwbms3aUo3UXJjK2NkZ1ZG?=
 =?utf-8?B?MXUxYk9xS0QweUFMQUNEdVY0U3NaUlVIbEZ0YlJmVGZlS2pHV3c0WThERm9M?=
 =?utf-8?B?aW5wZFFYdUs1dVFPNWxxTXF1aE5CY0pHQmZXR2lwYXFuNUR1LzBCdkxCVGxV?=
 =?utf-8?B?L3BXZnorNVlIUTdGRWM1MHlXaERoQlZxbEhYZXRSRHhGWTlZRTRkeThVTExK?=
 =?utf-8?B?clZ6WHRidHlQRnBDUU9yWEtyRC9XRDhiSmZTaFUzeWo1emk1YmdxYVhkc0Ey?=
 =?utf-8?B?Mm4xM1VHamNMM2EwVUs0QU1PdnpZYXZ5OG5nZ3RaMXRtSmlCMERDK1owUk04?=
 =?utf-8?B?SzBzc2Y3VE4wVVRlck9od1E4OXZTZXFiTEdpa0VZQXRRRlMwNzhtQVdhZ3Ri?=
 =?utf-8?B?WlpSRHJrN1JhSmp4SlB6Tk9EQlFCM2VzNHJuaWtBbXA3bjVKZkdmVjREZ3p6?=
 =?utf-8?B?UFZqZ29FU0Z5Rm8wdjVTNHBtZWtLVE12UXBzU1Q5a0tVYjQ5ZmRlTUU0MmdB?=
 =?utf-8?B?NU04Q2xwR2JicEhCRnhZa3I5MDhqQ0duVVpoM092ZmduZnBoNklTdmdQSEZr?=
 =?utf-8?B?RHFTNjRreVJ2QXB3c21qMUNqRnZmZGE1cCt3TllvbzNIWkZMY2p1VFNjZVRN?=
 =?utf-8?B?RWwwSVQ3OVVmOTUrYkFsOFREd1JsdTUyOGhsUXBaMENVekJ6WWYwci9LUG5M?=
 =?utf-8?B?RTh1UkFXNUtxTHo5VVU2bHY5UWRvZE5hNDJ1bHVXb0VCTGNTakVJck85bHRF?=
 =?utf-8?B?YnRpU1V4SDhqKytNbllDWThQSS8wdXQ2ZTFkQXNINzIwY09QaUpOWFBjVytt?=
 =?utf-8?B?OWVjNHBjcDBvdGRLTVYrdHpOc0hQOGp1WGxwakpsblZCenVZNm9ZZDlqRkMz?=
 =?utf-8?B?elRZSGM4QzhDbXlXdTlvKzQ1bE1ZYS9oMTJDMytIUjY3aVJkWVcxMDE0WDV1?=
 =?utf-8?B?RVhPUEJzQURoWEYwTjFIVnh4NVo4ZU5mOHZZMFF4ZTlFRE8zY0NjTWNqV2Yr?=
 =?utf-8?B?ajg4OEY1b3pDSFpQYWlRQlpQT3pHM2JOT2pFbG13SVVyUm5zSDlEVkdyZ3Av?=
 =?utf-8?B?dWxTV2ZZckRCS1FWOVd1OU5nMHRacFQvbEdZZ0lHR1ZodWsrajdqZkVkbHpO?=
 =?utf-8?B?bTVHZjZSLzNNQ1dsRkZ4b1FPaFY5NzNXR09VWisvS0dXYVBpc1hRMTNsRVM2?=
 =?utf-8?B?RUJBUlRRWjlUU2NKL2V5Y2xhWjJtaFI2TjEwRTdlMWdaNEdGWlJETnpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXdrMDdFMWlOWmYxOGZ2K0F0YUhOY3VtNUNURUdkVFA4TkJmclNIUElsSklm?=
 =?utf-8?B?bzJnQy80V1FpTzkrcllwT0doaU91Yjh2VmNXSGFacVdHT0t5R09weGFtS09F?=
 =?utf-8?B?Rm5qaWUxNEZsODVXUWVIVHg3c2dqUnJLR2kyV282aTdqcGlOZCtJS2YwdUJa?=
 =?utf-8?B?MUxlSHVMODVYYXpWVTR2SnZSM0UwUUtOVHltNGNBbVVuMzZ0ZU5vWU1yLzVp?=
 =?utf-8?B?L2plTmtRNFIwRTB0TmdWKzRpTnN0UVQ0S2c0WjE0MnUyc1labkxTVUFlY0RS?=
 =?utf-8?B?Y0JYRDBzQmZ4TndmL2hSSEZ6Qjg5UzRubjd2Z2hKcTQySXpjeUhGME1DOWNR?=
 =?utf-8?B?YjZuSnJkUFBDSW5nSEhnRE1yUmhXRFJIemNoZVd5RVVGWFppUGlybDRUZDcx?=
 =?utf-8?B?UHBIUG03SzhKNllVNnRWVDc5S0duVmpoUXFEUFNDcTJ3UkgxWkxVK3RrWVRQ?=
 =?utf-8?B?OHVNZlU0MFA2Uk85cyt4N211K3Z4WFZSak5uUmQ2Z0RYNS82OE5TSWs5UklD?=
 =?utf-8?B?TWtUZzhXMFB2VVZ6U2dkUjZ3NFdhdmZtZFBxRWQvQmU4M1pvaTNRNGRYd3B0?=
 =?utf-8?B?OUNlMTlHdE91L0FqTmdzamlXQlVnR0pBNFVTQkRnTm44SnBVMXI1Qk1vUG03?=
 =?utf-8?B?K3FxL3grVkp5Kys3eGhrckF6MmVMVTJxS0h4SmhTOHAxblBneGRHVHBDSjd4?=
 =?utf-8?B?SlpDekppVEtSdUl6WGpDN0hQbFQ5L1NNSzJpcG8zQ3F0VFBYQ2Nvd0FJYXBq?=
 =?utf-8?B?V1d6blhxbElDVFVna1BzZGVUakQ1aUtuTnhmUVNCM00wY0owY3dxb1UwUmR5?=
 =?utf-8?B?aldzSUNGNHdQZW9McWlUOEx3NG5kSmtQK0FuSUMraExzTEJ0VTVRNlo5UE1l?=
 =?utf-8?B?elgySWtTOS9ZQlN6TXhPVVpyQ2lrQ1BhazN6V2ZWOFNpVFdRT1l1OU5CbjFR?=
 =?utf-8?B?Q1NnSmNySmZTaC9MU0lEQ1VCYk05TjdNMERMdG9NUXZ2b0FGZ2R1Z3JXczdl?=
 =?utf-8?B?bkFPRW1wTDdhdU0wcFlVZVNuVE85Z0lwMHBwZUNoMnljL2NlR2pYWFd0dWs2?=
 =?utf-8?B?dGNrTUp2RWRBZlZqNGVjaFY1ZVF4Q21hUGVRU2w0aVhhRmlPYjhTNjJOSElh?=
 =?utf-8?B?Vnp4NVJNT1k3UEo0eWt1RmdBODUrTVYxclpsK0JUVjZBN2lJWUxLeUJld0R5?=
 =?utf-8?B?NTNrL2Fjck9peWFvREY2ZW1YT2E1OFVmM3RlUkwycXpVeXphR0NiVmNhWTlB?=
 =?utf-8?B?RnBCRWx2bWZaL1YxbHpUdy9uWWpBRlhtR1VPczdMKzBobmN1bjY3Qll2S1Q3?=
 =?utf-8?B?UmlYZWJNRHlkMnZ2ZjlIdWhIU0VYK3NpR1BlSTdqU3kwSTBxZFM1U3lZK0U5?=
 =?utf-8?B?ZUhwOGxSREU4alNVSkJIend4bmZGUTdxZHNqWE1PclhqNXNZNHN2dE1zb0tu?=
 =?utf-8?B?VWJSdjdaT3RPbVBVZmltT3Rxbyt4MmRNRDZXREhLc0wyS2FJWUhYcS80eEZz?=
 =?utf-8?B?cUdKc2p4U1JFNDdmakhsNjYzbk42SnYwRjRaUldZWHp2SE5iWUxJb1pFMEtp?=
 =?utf-8?B?bGNJRXFEVlY2NlV4T3N3THUrb0RrZTB4WXI1ZHI1c2lUM2JkeHByYTcraFo5?=
 =?utf-8?B?TUY5WXY4bGVxMm56VFRXTldHUTZ0dUZmL2R6VzQyNnhXUDhHY0dHclhDbTdm?=
 =?utf-8?B?TGFmS2h1NE8rWWdDdlV3TE4reFRzNGdXMFN4enFyaGpEcjJkSDlpY1h2aytM?=
 =?utf-8?B?WTlucVpmTEpwQmg5TnVrZ1hJbmp3ak9mVFVEWjY4SVJPaDM4WGtGWHc4TmlJ?=
 =?utf-8?B?VzhqNnAreWd6R3dxdk9yVVpOZWh6aDhlOGtFenZhZTFZTC9XdmVCT3dFdEZY?=
 =?utf-8?B?enZJczhmYXE0SVMwOUIyeHpERERCMWduVzJ5cmo2SWdFL0pTSjNEVHhUb25n?=
 =?utf-8?B?MThUN3plR0VmTWljVDZBSDdyQVU4ME1FN3p2VnYwVllMTUxzdlBuUjJzNG94?=
 =?utf-8?B?aUFsTkNZbHoyTEVUaG5qejJlZUptRjhkZkM4VERCTkVVM0lwSXFraEU0SThs?=
 =?utf-8?B?bWJEeURNL2twNTArcWJWSFgzanVYODk2MWs3Tkg5Uk1aSjdVYVpPVjBZY2Np?=
 =?utf-8?Q?DMdCo//qcJ9o1UBT51OEdYHyA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e13990b-6417-44f8-4c74-08dc68bb2bad
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 02:13:48.3749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWS9UpKknbuydlratJ3kSiydvZLCvQJD3QjgH66qnV8leu8X+W53IUItwkQMea///JbQpoUCG+3lwIaa4lWP9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7296


Hi Andrzej,

> Hi Ming Qian,
> 
> W dniu 25.04.2024 o 08:50, Ming Qian pisze:
>> Add a control V4L2_CID_MPEG_VIDEO_AVERAGE_QP to report the average qp
>> value of current encoded frame. the value applies to the last dequeued
>> capture buffer.
>>
>> Signed-off-by: Ming Qian <ming.qian@nxp.com>
>> ---
>> v2
>>   - improve document description according Hans's comments
>>   - drop volatile flag
>>
>>   Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 5 +++++
>>   drivers/media/v4l2-core/v4l2-ctrls-defs.c                 | 5 +++++
>>   include/uapi/linux/v4l2-controls.h                        | 2 ++
>>   3 files changed, 12 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst 
>> b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> index 2a165ae063fb..7d82ab14b8ba 100644
>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> @@ -1653,6 +1653,11 @@ enum 
>> v4l2_mpeg_video_h264_hierarchical_coding_type -
>>       Quantization parameter for a P frame for FWHT. Valid range: from 1
>>       to 31.
>> +``V4L2_CID_MPEG_VIDEO_AVERAGE_QP (integer)``
>> +    This read-only control returns the average QP value of the currently
>> +    encoded frame. The value applies to the last dequeued capture buffer
>> +    (VIDIOC_DQBUF). Applicable to encoders.
>> +
> 
> What is the intended range of the values? And why? Is your intention to 
> make it
> a hardware-agnostic control or a hardware-specific control?
> 
> Regrds,
> 
> Andrzej
> 

The value range depends on the format,
For H264, it's [V4L2_CID_MPEG_VIDEO_H264_MIN_QP, 
V4L2_CID_MPEG_VIDEO_H264_MIN_QP],
usually this is [0, 51].
For HEVC, it's [V4L2_CID_MPEG_VIDEO_HEVC_MIN_QP, 
V4L2_CID_MPEG_VIDEO_HEVC_MAX_QP],
usually it's from 0 to 51 for 8 bit and from 0 to 63 for 10 bit.
For H263 and MPEG4, it may be from 1 to 31.
For VPX, it may be from 1 to 128.

I think the driver that supports this ctrl can set an appropriate value
range based on the format it supports.

Users also need to read the value of this ctrl according to the format
they set.

Best regards,
Ming

>>   .. raw:: latex
>>       \normalsize
>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c 
>> b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> index 8696eb1cdd61..1ea52011247a 100644
>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> @@ -970,6 +970,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>>       case V4L2_CID_MPEG_VIDEO_LTR_COUNT:            return "LTR Count";
>>       case V4L2_CID_MPEG_VIDEO_FRAME_LTR_INDEX:        return "Frame 
>> LTR Index";
>>       case V4L2_CID_MPEG_VIDEO_USE_LTR_FRAMES:        return "Use LTR 
>> Frames";
>> +    case V4L2_CID_MPEG_VIDEO_AVERAGE_QP:            return "Average 
>> QP Value";
>>       case V4L2_CID_FWHT_I_FRAME_QP:                return "FWHT 
>> I-Frame QP Value";
>>       case V4L2_CID_FWHT_P_FRAME_QP:                return "FWHT 
>> P-Frame QP Value";
>> @@ -1507,6 +1508,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, 
>> enum v4l2_ctrl_type *type,
>>           *max = 0xffffffffffffLL;
>>           *step = 1;
>>           break;
>> +    case V4L2_CID_MPEG_VIDEO_AVERAGE_QP:
>> +        *type = V4L2_CTRL_TYPE_INTEGER;
>> +        *flags |= V4L2_CTRL_FLAG_READ_ONLY;
>> +        break;
>>       case V4L2_CID_PIXEL_RATE:
>>           *type = V4L2_CTRL_TYPE_INTEGER64;
>>           *flags |= V4L2_CTRL_FLAG_READ_ONLY;
>> diff --git a/include/uapi/linux/v4l2-controls.h 
>> b/include/uapi/linux/v4l2-controls.h
>> index 99c3f5e99da7..974fd254e573 100644
>> --- a/include/uapi/linux/v4l2-controls.h
>> +++ b/include/uapi/linux/v4l2-controls.h
>> @@ -898,6 +898,8 @@ enum v4l2_mpeg_video_av1_level {
>>       V4L2_MPEG_VIDEO_AV1_LEVEL_7_3 = 23
>>   };
>> +#define V4L2_CID_MPEG_VIDEO_AVERAGE_QP  (V4L2_CID_CODEC_BASE + 657)
>> +
>>   /*  MPEG-class control IDs specific to the CX2341x driver as defined 
>> by V4L2 */
>>   #define V4L2_CID_CODEC_CX2341X_BASE                
>> (V4L2_CTRL_CLASS_CODEC | 0x1000)
>>   #define V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE        
>> (V4L2_CID_CODEC_CX2341X_BASE+0)
> 

