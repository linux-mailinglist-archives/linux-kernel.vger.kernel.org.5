Return-Path: <linux-kernel+bounces-44447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEFB842220
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4461C24043
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3F3664A4;
	Tue, 30 Jan 2024 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bJ9AKLi0"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5833565BC9;
	Tue, 30 Jan 2024 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612521; cv=fail; b=Cw0UBAIdrltePQCk4Gw+60+DCNzZqSokYDfx+YUtC6q+LjPzVvJ52HLreQezwOtAolNDw06OEreRMrc6GSjM04NLvv43lJ0w7k7YGpX4aIszGQ6mtJgHjGLedtq0czFQN/+Fqjm+9ERpI6mlkY++EErH15UqPcLKGnrODwLRH6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612521; c=relaxed/simple;
	bh=VeMxttSBfJYUbB2NJ8aZ9Ikt1dWoejm5mqGUGT58jH0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZVmYMtOb0QlVf91oUq34aMT+ZeVHZ0oa4+XOHDfNq1EcusDK8sIHXLwheFKxKZHNU+aO7EASDgmZU1ijaCi377ayXPqEpABgSI2+ot2Kn4BylWmtAPHc3zCtTdtNeCM3ygawV9FVqFibS1k0ELGBIHMzPi7SIKHgbuNTXosKIiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bJ9AKLi0; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gch3IH+8+J/GUouKxlpWt3P6K3JOnv4hU4+atcl1wqDqqFZw0RxJo2iXw0/3l5+KBE3qg0e9SprPGhEVoY1FIv2Vp+TNxGE/3vJqiAok9OrjdHL6emWnGT853TYWRLeNa8sjjyXvTxFueIso7kPBZqitILbHmlMTTstOow0cRFLSyeGpmtMpHP3gluIhmHC+yhiUojLpBmBd2NuHYGI30JV/19AiR7+ny0z/GXCfgBG0EjeemmT/iBv+9gT4FRLf6Nx4TWJeW7dYlaCXHyhE+sffVMVT7qbadswK3rbXoWz8md9oibNl6xLqkA5M1TezAI8u031eNXAPRKD/ixXSqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0s9AXloHCThLyBQh3qXIRaItHHiqxDzh60A2yOobqtY=;
 b=ORlM60+1Z6qhao3nDI7RbxGNzdyO+MUsnCeBLbquGoxiqzGj19oT2cL8VPtvNBRA7S2v9RTjGBUTad1pi0XjUy4Zoy3T0nRpvlC5XdsNHD4UNZjVdDrTPaDQ2RQ0q/enfIufjEnQtiS7L6CgK80SdgnZmHT5I/2lcRcpQduyWXt5fev3lXaCkKSbC0dJG1KxHd93HuqYHmC92aZFrj1jew11NPUq0eW/Ygf/8GTspVbIOhEJKwALW/Kv9sqVtEeaQCIJad/wnGU7zAPCy9Gqr3mgMNTkunvqRNl3VzQZEOPboE4h9Gy03opWkpbRcAfMh8GRdzmxMNv0/EkeLIJN4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0s9AXloHCThLyBQh3qXIRaItHHiqxDzh60A2yOobqtY=;
 b=bJ9AKLi0urBrfzgFCeTYPA9Kbx7qQSeYSROOfwWkbOLkXSXTN0jINzdVppZ/qmDrrAr35AVPdJlWvhgcefIYxuGmZkecz1J9Yrjqiq+n1CptJQZFIf4ze4z7cmQ7+jtR8Aw7tP1FsvCTDP2h551wvhZX0+t4HFLW9frgxhYy2XxFSgeRQFaMgchBhxvUictWVBidwHakBobwdHfg0zKMaYmJ0jWqEHLyVEJm0flPdR/yzex+zJIpbAoOUWTcYm+HFYWYpHZYyvnOUapARMRyDwvePDLXKpb8gRB8HQMzsow6vERuFFvGTkwVDtP5aOu2gtDY87dK9ZikooQO3TKnMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.22; Tue, 30 Jan 2024 11:01:56 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 11:01:56 +0000
Message-ID: <a06713d9-5e29-466c-9eb9-ddb86e2f0677@nvidia.com>
Date: Tue, 30 Jan 2024 11:01:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc/tegra: fix build failure on Tegra241
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Kartik <kkartik@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240103102654.3779458-1-arnd@kernel.org>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240103102654.3779458-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0244.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::10) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 43839504-7c35-4f7c-8a9d-08dc2182df8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6dXONRCEjt5mIKBl8E3Ow2eM7HGKrBIsLrwaSHCI4sk6/sFdhNsp8g4gEP4+1rIGUR2LZ/lNawlPonXT/2Qezh9VROz1cGE5CydnG6MuGZ26UPs7XQG/BzM5ePqFMkYVoo7Ze5Jbkk1Qrw6HsDSLWGL9cqxE4mOUU808RD9R1n6dGAkIA4gJu+jy5x4oVwal18P7Etb/00DsKXNuS4njPrc+0NWHqdRD5BzM9LtFjMoj75enX5KTOIF5HS4+LPEjLM7n2dRZHqboz5i7cH/39V0xVo/QArIjq2YEfZO3Gg2XsLBVJ80nmY7osguSw74VjdEkScmQGd5wtPMdP5SU0SPe7J3zCtCm+OyGTW9MuQzPpB+YpPpJet/FSZV1VDcQb2aik1Klm1Ute0yygBjkONISlbsZXUfqOdlD/P8481myhDRpGKykGSAU1ZywL8lsygt0QWG/7e2fOaNm4H+S6x4RFi584ELkLZXGFny4+byWq1p7Sf95wpNtgRFKOc72XprkWtYDJn+rMIGqPMba8+V5tGg8gN4gfmjYfuaxV+Jjzvdu3HVVfSy8L2VHd/Y3i/PWQXT5YsNZcwqp35d/xSKGcu9f8vPkYnxNlx/MP5XuI2QxUmA2VG7pFs/JhKKhHokip6jDReyY2w+wLj4NZA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(2616005)(5660300002)(4326008)(8676002)(8936002)(31686004)(83380400001)(110136005)(86362001)(2906002)(6512007)(478600001)(26005)(36756003)(54906003)(66476007)(66556008)(66946007)(316002)(6636002)(6666004)(31696002)(6486002)(55236004)(6506007)(53546011)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWsxd0t3M1BoS2l1ZGZuSWpIVGQ0QWFsY0JNN2dFZngwbHNjZGtlME5jdmpK?=
 =?utf-8?B?WjdJblVzZy9Ia0orMEEyQXlJcHorTnZ1NWtlQXVrblNBUTNTamcvTUZjUk9y?=
 =?utf-8?B?cUZLVnNGV3VieHNDbWljSWxHajgzcFk5LzhBSmpQNTBTWXpZMy83WnZqamxB?=
 =?utf-8?B?Ky9td002RnhRZjAwcHRENkdmVXNmeEdybmtnZEJSWktJM2pKOTB5dG1Bbnll?=
 =?utf-8?B?elVLMHQwYmJPYUN6NitvRjB4WE5ZOGVWemJzNVZaRWJjRnRVWm1hTUJsaVk0?=
 =?utf-8?B?ZHR4K1dKMStlRHNSVkdiMmkzWjgxZEZuM1RiTzErNEJLRU04UHVwL1BUZ1d0?=
 =?utf-8?B?b1ZoUStqV2laL0pXWEx5K2d4c0lNK3NkQzkxQldKTnM4SlN1ODBWcVVkdEpl?=
 =?utf-8?B?YmNZN2dlalpUZnoyT1FJdTNvajhpcFdVMmFnMGNMb1dkRGVXOGdCZTd1Q2Qw?=
 =?utf-8?B?LzlkOVNYeHdzMWRWdG5hdHRpR3ZVWnYreUZJSzVTQVRzcEdBQi96MWhmdktw?=
 =?utf-8?B?ZWoxTlIxQVFzYlYxMnJielFWK20wMU5lQzJFWWZyeVVFbVBHclNuK1ZIVHNE?=
 =?utf-8?B?eVRLUlhqZDN3YUtCRnhWaHpsdnFlTGhuMmVBQlR3bFZVdm5GRmMyeDlaMUFq?=
 =?utf-8?B?aTBoRDhadHhlQWRlblhxL2srUVlka3d1c1BuekpaeEJyY0pVOGxMZWdtTGZY?=
 =?utf-8?B?YkpnTDJPVkxtNzNkbFJlRnBncjFqNk9TQStCRkVOOVVidFRlRmVISm5Bd1Av?=
 =?utf-8?B?UWhMUFlOV0xwYXkyZm5PaGRqTE05dkJKQ3Z6UFU2T25jaHF5aERlbGo3R3E0?=
 =?utf-8?B?SGtvMVZoL2FsRm5zOXNlSzZzNWczOEc3SFkvUmlkL0NJY0NPTmxDb1FtZjN6?=
 =?utf-8?B?U1pZZTZMemdJQlAyNnVMT2NrQkozdzdCalhoVzFRNFlMbmFiNGxUd1ltZzZo?=
 =?utf-8?B?Mk1TU2FlTlJ0c0FKUlRib2lYMU1xelZJSXhvaEU1OWRtbFBtc3FkU2dyUkpJ?=
 =?utf-8?B?eCttNHdtYTR6Ykdkd3htR25QKy9sSG5yVjdJUUJqVHE3emcvK1YzeFpxVHJ6?=
 =?utf-8?B?UmxGUkdSVWJENlJMbDgyb0RpYlJDM2lTMnQyV3JtTWEzTEhHd1Vid2dIcTA5?=
 =?utf-8?B?a3B4bURLZXJJTDlEanRiUDVWR0I4eWk0SEFsUkVpeVc5d2tqVnZSQmRQRXAr?=
 =?utf-8?B?ZjdDWjMyTDlJYXVUcWNpTzFzM1lvOXRnNEFrRHNjeWM2eUhmWHJ6QnR5Um9O?=
 =?utf-8?B?TXExUVVXNUs4OTdicVVGV2dHQXcrU0F4SWhEdTNicmFRa1JsRDRhNlgvamg5?=
 =?utf-8?B?bmdFaGFQbW5ENmE0clBBQTBGWkFWamNjemJPak9ad0dFTGNOaG90aGJVMFN1?=
 =?utf-8?B?bXVVOHI3RTBUWU9HNjh4QW5qT09mN1VBckxudHMwZDFqOFBFUTRsSGFGMmtP?=
 =?utf-8?B?d1owZDdEb05EbEo3N0ZXNnk0bXhZcE5weUtqcjNTUG9mU2JLQWEwM2krcjVS?=
 =?utf-8?B?SWd2STd3aytHZWFvK21PeVRzWG9lc2srVEJraXpPdVp5dHN5ZmU3R0x0aDNu?=
 =?utf-8?B?c0VuRmxMSWZaWXR6L29DR1c5K3RsRm0yZ2Y2UDRtdEV2QUlqaFJZeE5qUWQ2?=
 =?utf-8?B?RHJZUGFlSy83V3FKRiswVERDeHRtbDdIRkhzN0d5TVZmRzBvRm0ray9IbFlN?=
 =?utf-8?B?bmJaUlB1M014bG04ZjVhdGNsYmNyNm13TWpnYlJFVXVxYlg5VEc3MGpoYm5T?=
 =?utf-8?B?YVNMZ0w4dlpKOFZEaVhCWHdobXcvNEVqTmZkRmlncDNUVU92V3pmUVZUNmdm?=
 =?utf-8?B?alBHR1RsclJIQmtnUWp1Z1NsVVVJTHZQVk01NTZQSGNOV2w3Mm9LNHdaY1hB?=
 =?utf-8?B?b0xEZmIzZDBRd1lhWmsyTlFtQ0JzNkY1aVRWejloVXlUcVlKM0g1MUQ1U3hX?=
 =?utf-8?B?aFU3ZFcxM3RUUE5wV2pGQTV2QTlmSVQ0eG1DdVNrNTZhNllBc1owTHJRenpv?=
 =?utf-8?B?dmpTYlJsQ1JMRzFEVHltbUdsdjZ2dm9oMmg4T09YWW5pem1kK2hxRElqK1FL?=
 =?utf-8?B?OWFlN2ZBT3Z2S2k1bEJoOHB2d2tMN1grVHYwV3VWcXJMZG9UUk1Oc1pKdExL?=
 =?utf-8?B?Q3ovQlExeTNaZlF4RTBLajhOUVYxVmZDanBEVmF3emhxemJnaU5ZZWdaaHJX?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43839504-7c35-4f7c-8a9d-08dc2182df8e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 11:01:56.2240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fe/Z9Y2NR1v9C+2tKOtOWZLl4eRbZqaietDC9PqN6lwUu4V/iW7lmodxJsQOQNISUbBg9z4F+Xbiu3GGewCJpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077


On 03/01/2024 10:26, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> If all the other SoCs are disabled, the driver fails to build:
> 
> drivers/soc/tegra/fuse/fuse-tegra30.c:684:17: error: 'tegra30_fuse_read' undeclared here (not in a function); did you mean 'tegra_fuse_readl'?
>    684 |         .read = tegra30_fuse_read,
>        |                 ^~~~~~~~~~~~~~~~~
>        |                 tegra_fuse_readl
> drivers/soc/tegra/fuse/fuse-tegra30.c:694:17: error: 'tegra30_fuse_init' undeclared here (not in a function); did you mean 'tegra_fuse_info'?
>    694 |         .init = tegra30_fuse_init,
>        |                 ^~~~~~~~~~~~~~~~~
> 
> Fix the list of SoCs using this function to include the newly added one.
> 
> Fixes: dee509eb9cd5 ("soc/tegra: fuse: Add support for Tegra241")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/soc/tegra/fuse/fuse-tegra30.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
> index 2070d36c510d..eb14e5ff5a0a 100644
> --- a/drivers/soc/tegra/fuse/fuse-tegra30.c
> +++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
> @@ -38,7 +38,8 @@
>       defined(CONFIG_ARCH_TEGRA_210_SOC) || \
>       defined(CONFIG_ARCH_TEGRA_186_SOC) || \
>       defined(CONFIG_ARCH_TEGRA_194_SOC) || \
> -    defined(CONFIG_ARCH_TEGRA_234_SOC)
> +    defined(CONFIG_ARCH_TEGRA_234_SOC) || \
> +    defined(CONFIG_ARCH_TEGRA_241_SOC)
>   static u32 tegra30_fuse_read_early(struct tegra_fuse *fuse, unsigned int offset)
>   {
>   	if (WARN_ON(!fuse->base))


Thanks for fixing!

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic

