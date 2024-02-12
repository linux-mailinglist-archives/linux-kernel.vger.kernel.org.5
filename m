Return-Path: <linux-kernel+bounces-61944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 700BA8518C2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E782817E7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C008F3D3B4;
	Mon, 12 Feb 2024 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qUpUoUR6"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D3C3D3A2;
	Mon, 12 Feb 2024 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754421; cv=fail; b=YUSfBoTVRPv52ZYqKR3ZuoGRcWQdC2OfOWI9AVgsQudQmIi15LZodq+eRUbRD0rzYyCOznue9bYRVLhLW8YzYt+5nVCr7A7WoKM5dwbEpWb1hgVsQ7WMHcafS51dRMO3syIoiio0VpC2g8Kxj2RcNDb+PKtMqMuEE+MbjI8/RyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754421; c=relaxed/simple;
	bh=bNVKvUDyi18Q3jtAO/VOyQFeVfhKaSmP1tTLpjllBQI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LqEWkEHYbgP7GcNGZzGwHWqN9hwKjUFQaVbIdWOTm4fvDOB0apF7l6aai6zcDmNxnauY/z3waLViyo4Hp4hQLLVvOTCXjM3zxju3QrWpC/kwPJ1aR2Yo8Ja+M9J1RJQT5/TBpMoIrupta0NkxorQUFzzVmtw92ncmSuWp+GwkhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qUpUoUR6; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETJhbQegJQLrgjElklE/s9GUMKPiua4EA1L/AXPJakRl5/B/fkHUbgcYc3avuzbOvDs4zGxeDLJsJFCwMxFHkemWcA7W306YPPrMcATUVafWLtfTAjzth6l8uQkOXjukE9RhgmCe9RPUwS+a/yBR70aXyJN71h03Gea2ZXHPcs02Uia4a7S90Plj3cgDdZWUQMogurAIvUpTdYArzly59tssEhq+CruJasppKShQmLr+aAiHyfXkv+tQNfcUnO5fBDUDr3Z5+JXHGFCVic2i8dM/jD1WBGkoyhuJwzNGtO1sVdBeJ29YcBl+kqkMJ1W94y4eVfYasD9dFq1h/vQIvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75k9uMqr6e018+Q4KcuZtpC1Bdfy/Wr9H7QyISWuQRU=;
 b=mzCZxlAEuliXOEwtVFdMRK+rqAj9BBaYxI2QHi34CIrNJ7eyRYF7bRC9+MCIhKDumh+NvKZEW1HNldDgy5xI8lQxK6m8rZcx4jhRyqfSoSC70xsrODD3F/hrJLER7kI8uY3ic32BLY7w5b978Hq4opUeb+1C9GvKet58p5VidUkgDzNqVEyTmTJrDmFd5t8a9I+h8DnKR34tshRALTO12jZZbobHrYu0ASmlJfWIz6NhyXlsyxqG5NRibGBTOBZHxpDT57MnjvjMIyMlI72RMkgN8CkVLdFZhrcYna+Ope4aE/Ly1GWEH6xQ1IuVcxhRlaXYdvrP8/AYuMkxr7g9oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75k9uMqr6e018+Q4KcuZtpC1Bdfy/Wr9H7QyISWuQRU=;
 b=qUpUoUR61sLOa3eEdkK0tj3l0jEQYwUm7YzbOiHw9rlvdKkOKAfkBLTeQ8JS1iEqEsGJ6PtFUA2Oj2VNT/CJDK4qct8KUvMu5QmKzfLBAfKgylvAA57Uq5Q40G9A5h8rZTWlzztWtypWDYacUcvqGei/eBZDwVBgT7M44myHHHdtm74nLT1k3qLnRYmSi4EEF8JOwwc1C12hGXi9tNd5EcjVM8bEHz3Oti1TVt/kFFBj6mdT3MIKzd+pKlIzgSUD4mejstrpbHXrkEuvLCEDUWmSVTFf+vrdxa3V1aOH7OAALplRLAg+eavMGT3mvFFY9fmLdpNl4s4bNx5dBt9J1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.21; Mon, 12 Feb
 2024 16:13:32 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7%5]) with mapi id 15.20.7292.022; Mon, 12 Feb 2024
 16:13:32 +0000
Message-ID: <e8ebad48-e008-4fa3-bcd2-982ea960ba01@nvidia.com>
Date: Mon, 12 Feb 2024 16:13:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] Tegra114: switch Tegra Note 7 from tn7 to tegratab
Content-Language: en-US
To: Svyatoslav Ryhel <clamor95@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Shubhi Garg <shgarg@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240212071843.6679-1-clamor95@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240212071843.6679-1-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0136.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::15) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|BL1PR12MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: a74b7268-577e-4db2-fa5f-08dc2be58eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3WkX2+qDobc9pAD0gqA/b6uIDbd15OOP+5K95LqGSknHGIErms/YZqYwNIj5A3eZX2M6kp7dU+50ObEp+SjEBuLUBixM+9ix72UOa+BSg9oUaLTiiyz24hcDCDU8BBgS0e2IG7Xpvj2cX1CpjMbj3kIagAbTarnZ76psYjTafLnOslWssKfO+d25atHV7lZjWyq4u79xrOivfhOVAQNWlUrLQaqNIFt3LYnEX2NbZ3TUfoxTRbGGZ4KA5ZhDfRJ5ZDLlKX2HGxWIo/8zfcJdkWMYruESGdA5ITkfF2L+8Vew089nD0gZXGw9zk5aCLIjgDspqS8q27qiMi3n8C9gpqFasHZwTq1TyDSOSrngRD+yLiHInOjwHegnvm0loAEPQpmDmBMahq9rkrl0iDp6M77qCkDzn3av6obcGDSp94QWH1awT1oujAoLQ/NV5+RoDkCsMAtN10yymLowre+dicftzrq71yBFS+AOCKuJ79/T7TdIb7M0gw79rwwB/qyJ1V56x6PJ7LQ7qUZJFFL1vZI6Y1rU63GjWAm+E7xU5but6gsEMoppblODLnsT6At9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31686004)(6506007)(6486002)(6512007)(36756003)(2906002)(31696002)(5660300002)(4744005)(66946007)(86362001)(38100700002)(478600001)(55236004)(6636002)(110136005)(53546011)(6666004)(316002)(4326008)(66476007)(66556008)(8676002)(8936002)(2616005)(41300700001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2JjZ2Vpay9CdUJiYnRrVGpWZTdrVkwxOFkwVUhvLzBDVnJWajhBYzVYT2ht?=
 =?utf-8?B?ZzVRSGpVejZuei92cENqUGRXblk3MjF6QXdSVW9BSnpveDNsdU9kanVmdnpK?=
 =?utf-8?B?a3BqcXR2ekoyMEVCaWpxdFZVN0FZTlkwajBHdUtNOUFFeHNKQkZiMkQ1ZXVx?=
 =?utf-8?B?MUw5MzIvOWhwQVZwek9HZ1BBZXliaENrUHArNlR5YSt0S0ZZMFRrSkdsMU9l?=
 =?utf-8?B?bVdqTWY5WmxoRCtRb2xHekVzS0tZdG5Ea3B4ZTJ5bFh0OVQ1bmtyM3NZQnVV?=
 =?utf-8?B?TkJwUEtHbWIwMkdjTXBUdmdQdG95Q2N5enJVUzFjK0F3Q1FmdlRQMnF5U3p3?=
 =?utf-8?B?UkF6Q2JqTGw2VzdUMDdZVnJkcXNYcXhDbmpNbHNIZ0JMeFVVeDd5bUhqb1NC?=
 =?utf-8?B?MWFhWEd6cUFBQUowYWN4NkR3d25xbEt4aEMxTE5tUUNZNjhvSkNxbnorY1lp?=
 =?utf-8?B?RjJmNkZTbG5mVWlWckl6djNhYUlnbnU4a1JqS1RwSE5Wd0ZuTXZ6b25OQmt6?=
 =?utf-8?B?LzlWSXdHc2tJY2lzL0IyeEd1c0VKdThZa011cUNLM1VGNmNSUmZhcmVOVmpw?=
 =?utf-8?B?NXRIWjRFeFlWTFc0cGdpVE1jUndzVVJCckVjNE1HUVBvYW1mQlNRUjdETTFp?=
 =?utf-8?B?SmQ3NTgwK0ltWmwvUXFqdDlOY3BkbTlxMXlvdzVRMkFtcWJpSTl5SFRaMVZz?=
 =?utf-8?B?K3lJT25NeGxFZnpwWDZWNWVlMVJveVoxWHR5TFBEa2dBL29ONXJVbWUyUk9m?=
 =?utf-8?B?NFFhZ00vYTF2Qm1pRzMvZk90Z3BmTUNrcmNlU2h0STl2ckdXeHYwOGozZlR5?=
 =?utf-8?B?ZmpxSXRKTEE5M1JOMC95NkJVeVh4aFZpZXVUZXVuQW5kTmErenNFdmcxbjll?=
 =?utf-8?B?NmkrbzhIUGI2VjRKQzZET1dDbkxPWUNYVFdTUTFqb3J1L2UwV3NMc0dJSllv?=
 =?utf-8?B?OUVBaDNFa21MZFBlL05rOU9FT3NMZUtMVHBmV3VlcThVWFVOeEJIZjMvbWJ2?=
 =?utf-8?B?THRqWkpiVWRwUzZZUWx3N1pGNFBCNzdjMW1DdCt0cFV2NW8rOEQvSTlNUE1M?=
 =?utf-8?B?d2FBR21JWTlsbXVKTXZ0WkdCK0t6YlBva01oeStLTm96aW1HeWhleGxzMHpQ?=
 =?utf-8?B?cjhzeEczK1JxMVh4bTh6Ynp2cVNITlBqSlpacWM4MGZ0VGlRQk9nNzA4T3JL?=
 =?utf-8?B?MHo3aFQveHBUdW9zc3BkQUZ5N2p5S01JeXk4V3NxeVhiU2d6ZzJpOWpxQUhl?=
 =?utf-8?B?L0Fxcm9Bell5S3psSTRjNlo1andCYUJPVGRFaDdxemNFQzIrcHBLRUliZ0JP?=
 =?utf-8?B?ZVAyWjhxWTVzN3VyMW00YmlzcTB6ODNIaHdRSHEyM0Y1V09tcm1MbzV1Umcz?=
 =?utf-8?B?UjduWE05UzVWS1NsOXZCb3lWSzlDZ0tnYloyQmZlNkFNKzFmWTFZZ0EvM0M3?=
 =?utf-8?B?TUJqZ3FVc0FSN1ZidGZUNEdzZnNjeTZLcGFiSGhRSzE2Qno3d0dKT003dnB4?=
 =?utf-8?B?ZjhHYUFPMU5sS0daWGRkcC93WG5ZczdtMzIxWXNPTTdkUXVPVkNPQktDOGps?=
 =?utf-8?B?V2k3bEwzcVRXd0JGdlNJRHRHUDlueHl1M2pka2ttZmt3OHd4c21MZTJyWU1J?=
 =?utf-8?B?a2l0aEpKdEJ5cHg3ck43Z3dvODhqdWdFUmxVNEZqNTBnZ1dFeitXOGRqcjl5?=
 =?utf-8?B?MUsxV0dQVkNNakVTcjFTb3N5ZkN2eVlUYWdBT1laM2JZOFhBUmQvRWJKM1F3?=
 =?utf-8?B?QnIxb09qTDV1d1laR29tSzhtU3BzQ0hsM1RjVW8yQyt5dUN1Y0c5aHMvcGNO?=
 =?utf-8?B?WXk4NVhHNUZnYXM0RjNrZnVlWi9xU2YvdFdZd083VmdYSmt5MlQrYlNBaWhH?=
 =?utf-8?B?Y1EyMTVodDV1MXpRR05YWjcyc3BlTkNwb0xMV1hadDJFMXVnb25ROGIxUDVX?=
 =?utf-8?B?L1ozZlBlNEVLR0RVTkFHazN5c1FIbVFZUStyUnRnVTl2eXZWdjYrV3lnNFhE?=
 =?utf-8?B?M2xBbjBNUjBPS3duR1BYZUJuWnRDUmhIS0t0U2RWb3djQ0JuRHY4eVY4Nnht?=
 =?utf-8?B?VlhSQy9JZGdpaFZuRFJUVDhqZlhkRnN1RXBoSmdqa0pBRGV3QzFzTlk0NnJE?=
 =?utf-8?Q?Kx0Mn21hMOpyzSBr2TC6tppTf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a74b7268-577e-4db2-fa5f-08dc2be58eae
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 16:13:32.3917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9z+qopTMhonLx454cp4BCzpNWQtIC0Hf6QTmGOEqgj4/v59Ysf2DlHVo2B6Gqvc9Av2wtqXPGh3+cQ/5TH1TOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363


On 12/02/2024 07:18, Svyatoslav Ryhel wrote:
> Currently Tegra Note 7 uses tn7 compatible and device tree name which is
> not quite correct. This device has proper codename which is tegratab.

Certainly news to me :-)

I have always known it as Tegra Note 7 and so 'tn7' as an abbreviation 
seems fine.

Jon

-- 
nvpublic

