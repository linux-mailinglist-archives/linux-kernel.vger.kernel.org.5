Return-Path: <linux-kernel+bounces-44422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5CC8421E1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C235C1C2067B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66D467E7C;
	Tue, 30 Jan 2024 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hc13SRIr"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B38467E7B;
	Tue, 30 Jan 2024 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611627; cv=fail; b=ATO/VQaiP8cJhEMHm7lNSOCISMcMevTgMDiL9XhI7V0yzUFWgwBO5Hn/cPMKirxnBPP47ExhoVbz/4YzLsd3Gowr78f9lFvMv4M+eyzSfs1AY6lw9SuN3xtOaSEXyqmlF3u6M0RKXfHCuvvY9nK/Xk7EriMG1en6Tda66eqUE7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611627; c=relaxed/simple;
	bh=KVtKXXUpGnuHX6VsDwDz4UGdPoerCPH1EulaqDVw1tA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZVWKWxjJW1ni2jl4kVqFFSu4sma65E61hi2LrmkXPLgS+8quOD37Zxo4V6THiFeRzi28iGEsUKlEQc/7jDFCsjue1hOc/xBvxBlPHjWKpsqqhwSkZ4JodFNJdf68/I7sNjJb6a2JkzdQtAzayyFMNVOBqsPbvpbhmEu+8JRu6CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hc13SRIr; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0T2fozdVTTHnYRjfLgdHyeBG0eJHix2hgyJiDyMdZrUzlsSuPC9dz6hrvQvBlltPVaB9WYuPJB9sxT8RzLT+rtWXotPah9YMYzqzXiDxwyq2WHq1BzOYvfaFX4lNnruZmDQy2YhA7o/5pKMJaacCHScqQ6EqHsBM4PnIH9pWkALB6r7xb3tqhXruDE9Qb2///WCnir7BLzANd6f1Psl98Hk0nrqjwfy5aIhCgHGzSeIPDr8L+GGNWNzsl7Q8CRWPRzD86GYWs8l7jEIWjW+qi455ze3zHz+UDEDgy3vh5cG/jDT/OlE3Rjahp+9gk/Ni0H1h1DQE2c8aWH/PRQRuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XvJ5oKF8UhAbj9zinE4CEERKRI99BPl5MAUC5RvmTQ=;
 b=d6sJIEeQoeFhG5PTc1vneizLzFtsPfZBxihwUyeHoeoScq6A8aIAAD/8jatRH2ml+Bhq65IKeOJgxIrvUVJLwdzNDlI6yMpzMOfYltnMJEawva5Xjn/wdy0hiluXGZ2WIAt2sP+FPzjcLdmB6ygAXW1GBcexEuLKPwJb2qQLuxSduBWbl/zTuF+H3R/4bLTNKrdemdLvIswS+y4gY0ckYnkaoGlnmZyRnwJ8N0rqpHpoE7o/wu2E7DQQg/ue71lYPg6IoRPf+djbP2sBoPcaPlElmdpo/qxKYWca2tPpLmEt0qsUwmTps0EICC2CegKnGOX3L4AaN7YceQMC4u52dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XvJ5oKF8UhAbj9zinE4CEERKRI99BPl5MAUC5RvmTQ=;
 b=Hc13SRIrfiCDcIBdhHQlwO3Fy2bnzVH0wqhT3R0q2vUjG+fzSMeIa8N+MsBo5kgDCRx3tn0eGKw0DqZtLB2kXXjWKYGOqzKW+kt5TTem6Yr38ubN23W1BKS8NePa77manMdECoVt5H6CVTpQnFsE41ok8Y3uWaEL+to/1OzxPL38gLp6DDYpX0BL3WkOQaCgSXk9xkLE1GAthfcOhP7SczsgZVnNlxzwgLPuuFqH+ZNwLKehoMT2uF+kln8cmNuTP7kWgUF1ZtBU0pJJl7dpmjx3iCDVcuM3ffNCkwI2naqSNWQ2LBjQQRCo+OtTRcf9TZxRQZZgWexINJrXBue0XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.34; Tue, 30 Jan 2024 10:47:03 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 10:47:03 +0000
Message-ID: <61e8b6ae-fd30-4443-8473-6429f6de8768@nvidia.com>
Date: Tue, 30 Jan 2024 10:46:58 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Jan 29 (soc/tegra/fuse/fuse-tegra30.c)
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Kartik K <kkartik@nvidia.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Thierry Reding <treding@nvidia.com>
References: <20240129143030.16647483@canb.auug.org.au>
 <d0e1a7c1-06a2-4fa4-b4f8-df149af8eccb@infradead.org>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <d0e1a7c1-06a2-4fa4-b4f8-df149af8eccb@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::20) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CY8PR12MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: 7368d6c3-56da-44ad-c4fa-08dc2180cb3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K5M+nEOxqb1BXMKicP0tR6bZK1hWbeihx88K0IEUGrQ2VGXsJeoY16WcgaD/Vk/swHvG3h2BSRZIXcF/1jOuLIa0DR8RuNqiNHNAVUKZ9R2YW/8Mntbvr6N2+pIxnBsrZJmrywBegFT8IP5isFEb91FBNshohbgnI0RmPpklEtuLSAG1TTO8MK6kZyrXAvE6Z6A1BH9rA2R5PmD3UQ7qP5z8planOpl+7H6GLH+IfdcAz+mj1TeYyXtzZbUmACUR7V/IqoPEVM6wQYQF9PaQ13dFndLYgZAyXsoqb7shXEqvJo9uT1rnPY3+lpUveQ9wuUSNO5UxahG+KANvfGIGP6+gu8HSgau4ik+jtykkRo6fP+xakrmidk17bkSdoUhnaOCEzbcfEdxYI/ws+XKN0Er0xBcXilsIAeAmr/G8kV8TZBjJQcapZbKBLTu6nrckTyceZDaKLviOpvvMMPAOS7hjUVjDxyXDOaPcANOP9TFE4S36PACS1QUmrQs/IrNIyclqe/FUiXmO53GG4IlVaPDjlEgfJKszwa7nIKquIqoPn54iGz6oGIyyw2pt7nEqhf33d1x/xUt4nOca/Q8p5UALgvoN5vTu50ZPrOJiAhOSCWJHQJtxZ3GGkBUj0sFSyEWm2IJ68ZrK2kzP74ajJg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(136003)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2616005)(6512007)(107886003)(26005)(38100700002)(110136005)(5660300002)(4326008)(8676002)(8936002)(478600001)(6486002)(6506007)(2906002)(54906003)(6666004)(53546011)(55236004)(66946007)(66556008)(66476007)(316002)(6636002)(41300700001)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mkk1V0dOZnNQZDROdkk4K01neGl2NmRqc3pkcnMxb1luRkxSVUgzSm5wUkg4?=
 =?utf-8?B?NmZxY2NUYlVoY212V3ZmWkpacjduN0ZVcmtzdVZmK01IT2JZQm55VWoyTVFQ?=
 =?utf-8?B?VHdtc3BNSWtnZ20xSDdyUWpvT1kwZGdiUmtrRVFVV2h5THhkQmllemI2VHZk?=
 =?utf-8?B?blZ1Qk40MzNzS3AyN0RlNEV1WkMvVk9sSGNFNkZoQTZteXp1RklXUm1tbE1G?=
 =?utf-8?B?c0J6d05jY3gwZ3dhMkFLS3NyN2FUQTlKTXladFdXTjJ6emJmTGtuV2VDSytv?=
 =?utf-8?B?SUhWRFBaUUJ5aDd6bzVpaW4yR1pWOW9jZVVHSzlzSjEyZmZWQjdMSUlwUGc0?=
 =?utf-8?B?dGo0aCtpbEpTRHBTN1JzQkZnS25ZZUNzejFLU1NlU1ZXek9KdEd2QmdNMzB4?=
 =?utf-8?B?SVZuOTFxdk16OEZCMExaSWllYjRiQ1BEaUVLSGRiUVJiN0xuOE9RT29kNTdp?=
 =?utf-8?B?ZDVZblduTnBGQThvcktYNzd6SFFLMDY4TTdCVHZGcldnYmEvdUxLSHVhSHFj?=
 =?utf-8?B?cTlyZ3phV1V1blZJUStIQzJoMmIyTWFNYVMwb2k4NktxMWhrRU1PUXhVQ01R?=
 =?utf-8?B?R3FtWEcvU3h1QUo3WDRWbDV2ZmxsWUFvcE0vQXpmYzdpWjdzb01qM2U4c3BX?=
 =?utf-8?B?Z3loaXNaZHRibjBzNHRBWllmdE5obDV1cmdVcGROT1M3Q0kyaStGdVBrdlI3?=
 =?utf-8?B?NlRFbTdlNUdnU2NEa01RaG5FYjBRb2YyRVhzdkYrQi9FZ2ZOaGQ1ay8raXgz?=
 =?utf-8?B?TWw2bWFmWUMxWlFGZTNxMXJ0eDl3RFNab29tN0lHaExXdEloVVQ1bUFPdnhJ?=
 =?utf-8?B?TnFONFZ6NS9FZ1NjZlJyc2Q5VmZUUXNLQ25ienI4K2ZxNnZaN0RUZ0VOSy9X?=
 =?utf-8?B?cUhMMzBkWnRleUJKV28wRTJJN3lIRmgrVDBkVmxOZ3MzLzkrU1BzMExocGhK?=
 =?utf-8?B?eTVMVE9MQVQxOStyWks3STdxWjNWanlndWYxZXlmbnlUNTQzSFNxcGJJVzVK?=
 =?utf-8?B?bnlPekxhZFNJNmU0NUUwMHZEamxKdVdkVWVTUlBQTXdwZnBSdWM5RHp3TlBs?=
 =?utf-8?B?T0l0dXlFNXhVRGswYXppR3hIeFJWRjQ5TmZraDNwZlBFdFNmaVBTVitLKzFm?=
 =?utf-8?B?cnNyS052cmdyTTlCMjErNVBDRDhEMGRjdTRQd2xEaHRkd05qTE1FdTlFVHNG?=
 =?utf-8?B?VHhGREhLUis4cVcyMGt0SmU1T2J1TjI0QW1iVlE2N25VNUh1cW41ZWxWWFJh?=
 =?utf-8?B?a0VDd0UxaTh3Q0R0Sm00aGY3dmhocHVldE05R0NTR2lEVStnVG95MTZnNXNk?=
 =?utf-8?B?S1ZVVzZJTjQycXRuWHFCcXZ6aklQREc4K1BlVmlqNzc3SjdWOXB1WDBUVkor?=
 =?utf-8?B?OHZFbTN3cWlhOHhTeEU2WE1NT0oxdDZkMmF2MHVTL0NlN282enBVNkZUTjJK?=
 =?utf-8?B?QklEVFpvR0s1SHpmcUs2ckJKMG1TMjU4UHdIcFM2TGpBUDRaQnh0VGhiUjV1?=
 =?utf-8?B?eGM5c1pvK3QvazZPMUxzbUlnUGU4djdDVjRSL0g1RTlOYkdOeXVmNnpnR2wx?=
 =?utf-8?B?UmZ2MkkwancrZlpHeHdhNnBkUUsvc0hWTGtLTDV2RWNNZWdCdytlMzRmVGJY?=
 =?utf-8?B?R2MySW5LWi9qcjJUa1lSYk1YQ0VSQTR0dmViWW0vT2JoUHdnaStPMmRsYlNV?=
 =?utf-8?B?T1JBdE5SdSs2Qi9qRjlld2JrM0Y5c0g3TGpOZ2h4RnlLSkZmaldJbnNRczNR?=
 =?utf-8?B?Z1hHaTEvMHdaenZEblUxUkZ3ZENHSmpEdGdaTnJOL1dmdmhxa3VkcnlVT0FC?=
 =?utf-8?B?ampjMTFUUWhnNW9zd2tjblRNSEp3UjlNTTdaOUNCNy85SlpTYS9YRndrWXVZ?=
 =?utf-8?B?aC9ZQXI3eVhac0toVmx5aUI0WUpQS2tiZFMyaUpPT3RiVkpXM2R4azAyK2xl?=
 =?utf-8?B?WTBWeGRscWFzQjdlZnA5NEdySFlENFJiOFRaSldZRUw3Y2V2cnp1MWxsVHhI?=
 =?utf-8?B?TnRFcys0KzRGdHpqT2pIYTd2QkVhcjFKaS9TakwvSTV4dStPU3RvelZyRURP?=
 =?utf-8?B?L2Fndk9jTDUvNFRtZWpzekhla2M2ZE4rMGNhMUpFd2ZpVmZyTzdxUzdTdnhP?=
 =?utf-8?B?SS8xSk1hMElZaGF0R0FVUzJpamtveUdsZDBmUktZSkNIeHRQK3lrY1BqeHRn?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7368d6c3-56da-44ad-c4fa-08dc2180cb3e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 10:47:03.1699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: taMvnjwqj+rFxGxgErAp7V2CQG9c4IrwfJKULobUIJ9go3k3Qg5GFhJZ12UvrJZUjloUqh+w0of4tkFk3rH+6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435



On 30/01/2024 04:06, Randy Dunlap wrote:
> 
> 
> On 1/28/24 19:30, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20240125:
>>
> 
> on arm64:
> 
> ../drivers/soc/tegra/fuse/fuse-tegra30.c:684:17: error: 'tegra30_fuse_read' undeclared here (not in a function); did you mean 'tegra_fuse_readl'?
>    684 |         .read = tegra30_fuse_read,
>        |                 ^~~~~~~~~~~~~~~~~
>        |                 tegra_fuse_readl
> ../drivers/soc/tegra/fuse/fuse-tegra30.c:694:17: error: 'tegra30_fuse_init' undeclared here (not in a function); did you mean 'tegra_fuse_info'?
>    694 |         .init = tegra30_fuse_init,
>        |                 ^~~~~~~~~~~~~~~~~
>        |                 tegra_fuse_info


Looks like we are missing the following ...

diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index 2070d36c510d..eb14e5ff5a0a 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -38,7 +38,8 @@
      defined(CONFIG_ARCH_TEGRA_210_SOC) || \
      defined(CONFIG_ARCH_TEGRA_186_SOC) || \
      defined(CONFIG_ARCH_TEGRA_194_SOC) || \
-    defined(CONFIG_ARCH_TEGRA_234_SOC)
+    defined(CONFIG_ARCH_TEGRA_234_SOC) || \
+    defined(CONFIG_ARCH_TEGRA_241_SOC)
  static u32 tegra30_fuse_read_early(struct tegra_fuse *fuse, unsigned int offset)


Kartik, can you send a fix for this?

Jon

-- 
nvpublic

