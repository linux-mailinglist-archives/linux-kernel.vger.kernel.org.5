Return-Path: <linux-kernel+bounces-65931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE248553EA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE82F1F2272D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0E913DBBD;
	Wed, 14 Feb 2024 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nr7DOj6X"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20EF13A89A;
	Wed, 14 Feb 2024 20:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707942198; cv=fail; b=cLWBs5RxZj3W3SZSlnDz89afgC/VV73LqIMHqQQLh37V2ahQ4NBpEfph04jkHaFJpVsFZ4CuBvH5aUmXYUyEkkY0zqVr2dnkYlEfn/Ucgh9DfLVEmgtLjAxfY34TIzyNnYECDsnPBr0QrLE0PvVQrTEGmC0CR3DYbUfCvfas3HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707942198; c=relaxed/simple;
	bh=d2N49HARO1EboJRLYJnCYztvTP/4WVtjbcge+2tE20s=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a6ol2bY/Fk8iqbH9PZGhgxng7oIxo5c6dQjMuA9tlGnfHrPdGNehZivi6DFInwbaYDeRk7uGRYxa4JoNAiiKYnrcY9UMdNBDRJw014wCcNa2n/APgx3mQprWTdakCeD8178wnLeHeTjBmp1b2+jyF0ITsC87t8npxjUZ09IpbKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nr7DOj6X; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvtF40gPJ/YQch7zWrMh7C6FYwsFNj0xWApjPvb2klz2BLdfb46kFBD11+bwD6IH9AtgTuotPMaplqGJ4YHlQPesCVxVyUbjXoirxnM+KCllMa63U9gF7MGmyn4n9KYPOQZDGYviUlH6Y6KmUNGPMJ0GDEDIZSJ1dqV7LSLihDf3SSwhmmbUWgApaLJ7EtdNMvS8Ef/iMKnuy1LFExPUhFEXw6eyL+uqu7pTC7uJNY+1ymA2sZKzg3QfDyMI+nKd9kkPsNsLEHGe65EerSj4s4d0Zu3689Fl0tiEG5jeFTor2Jf7/hwghZGUmkXlCEmZlxIw5dKq1sv5MKmgakePPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TD9sgQD+ivkok8pmdNpaJeCrwuO5rwrvPK76WC/Q+1s=;
 b=YTu40SLIxnV2Cv373mMGHSX3uYwjCgnYc6iXxIUP3QnB1n1xEV13PMpCC9Eh9SMNdeS/op1UiH5Cf1pqPavtxmPj7KmpHtOwO4yvuFC5jlu1qI61q/8xKj6k4oZuYn5aYs+1NBR8dacr99JmZjaAoU/TaQ+8sPOvzSmKmn4/ARrXjqYwWVPPZdT+tiuLjtgONVnSOnlrrkTZMbX7Jvz/lqv9UX6x42axqYaclGvFkFsugiUMJCYTIB6CV5TRmQl/zGdy1613dFzAEUvzSdnfdYUF6ESmSsCJQ2roWLmKCSR3Zl0p8FkJtTPjYTtGF3uL2xxzKXswGEPcwFTfnHIm2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TD9sgQD+ivkok8pmdNpaJeCrwuO5rwrvPK76WC/Q+1s=;
 b=Nr7DOj6XzxcJR7HK9fon3OgLix4KcJo9YYGtvOuL/jVzhlHeOMLZ7S3iR7V/pJE9TCt3GU4zAALjmogGkm+5LwTjN0xciWnqNEyWwN4JnY9fTvMbbEJjHHnaCsPtg6ffbeXVJOnBEip2Sy3pMydkkPrIdIVhJcSBv3ukej8CWwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MW4PR12MB7287.namprd12.prod.outlook.com (2603:10b6:303:22c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.21; Wed, 14 Feb
 2024 20:23:13 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c%7]) with mapi id 15.20.7270.016; Wed, 14 Feb 2024
 20:23:13 +0000
Message-ID: <fc83e824-f37e-4164-95b3-e57bee60b2a9@amd.com>
Date: Wed, 14 Feb 2024 15:23:11 -0500
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
 Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, linux-edac@vger.kernel.org
Subject: Re: [PATCH 1/7] EDAC/amd64: Remove amd64_pvt::ext_nbcfg
Content-Language: en-US
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, bp@alien8.de
References: <20240213112051.27715-1-jirislaby@kernel.org>
 <20240213112051.27715-2-jirislaby@kernel.org>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240213112051.27715-2-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:408:141::19) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|MW4PR12MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a6e758c-e4ae-4e05-c357-08dc2d9ac517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IaWJ93eR+deFsU29mrbD8XE//5/XiLo1ysSUfhCs9g2IELJNkWUd/F7m46fcgPBuE8O1yOA0usbDDmayPDA6rNFrOCZIjIHOt3Z71jctDNr/u5EhGVDxb6E+iYcrQh0tjBpUOlQr9+VzG0m1whh3j+YqgylYl1KAXwbTbmbNro57kTaHnGC2RAhoucd23zX5Zf+a+eXUWxqQqL5qfeNF6x2YzGzRanLRFgAFQguwRhpV3ynZyYmqHaMbcLb2s1h4zbtxuO89Xq/Kj0gco6PSztLgyBl2lma06qEvnUEHbh7LdFHJzv84OVJa3+CR7Ra1yA9+jStCkxV5oIz7CGuAxa6Rnv6gqYUpQKzOLccubczrIDaF/WSuWLIe9dUIcY01IYOk0NQdhvTezIKnAYKpOW2XQRhswolym7aQG5C9w4+bCrYCFaR5nahJsD7yxoKNDfzVq2dcIk833Ic/jW6sQSw4dpXTUo4jOVs7K0wktZcgiGR8RBy9P+gmhgy3EXSZk7GbVpntmk2rXOzoGrwqbmbjPflST+2H24x0U1rblrQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6512007)(6486002)(966005)(478600001)(41300700001)(31686004)(8936002)(8676002)(4326008)(2906002)(44832011)(5660300002)(6506007)(66946007)(53546011)(54906003)(316002)(66556008)(66476007)(2616005)(31696002)(86362001)(26005)(83380400001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkdHcWU0TUtXTnlxUFE3Nm1uZW9sZWxqdHdhaCswajgwTnE0RjhsclBuSWw0?=
 =?utf-8?B?NmJOZ0JLOHd3NDhrdkZNSHJrWW1vSG9KbU94aTlkTmtnT2U2UWFsdWROQjRi?=
 =?utf-8?B?T0pmYlpRaDhGbVdYZzFMV29mTkJ1NkFic3hNb2V6YU8vaTlDQVdKNGc1akV6?=
 =?utf-8?B?VzlVSWtBa3IrekJqSzFxMElDeVl2SFBtc0MxWXg3U0pxU0NLV2JhZkpxQVRo?=
 =?utf-8?B?ZWk1WW0vdjlIeDZTMndvNjhCNHc4T3NMbWJZMU9xRjhYL0ZiMXhhZEN5TEZV?=
 =?utf-8?B?dlFuK28zM0pXRXlweWhOQm9kNHNOWkdublI1V2l1N2VNU282L0w2NXlaeCtT?=
 =?utf-8?B?ZStQYkFwejRwVStPOEpjRDFVZkU1cVM5NTRXQ2dsU0pHQjBnMDJ2cU13c3d0?=
 =?utf-8?B?ZWtDS2lMYTVhYkpyU0MwYktMSkpiNE9NMEhnS29pT0U3UFpaL2pGWlcxSlVO?=
 =?utf-8?B?ek9lbVBDOEY3ODlzNWVpcDhSRHN1NWdDbFdMam1sdm1CMkVQcmUyL1lRclBo?=
 =?utf-8?B?UGZEczgzTE1JK3pVM2R1OE1nWjVtQWVldm5FTVZwUGlMc1JOUzRvK3daQTZT?=
 =?utf-8?B?Yi9pa3J0bGNOczcxMXpFNU84NUtnMU95U2EydDVOYkVpYmF4dnJPTkI2RjNz?=
 =?utf-8?B?RDhuTkZxaWlyYndFY3M0RGllZER3dEdSSUtJZ1JPR2dLN3JCdGNkVmtDSDBM?=
 =?utf-8?B?cTdoNm1QeVExMXZIS29zNTlESlZmazR5QVlrL3hjaUo3K0NhM0UzczBYcEtv?=
 =?utf-8?B?Z1JOMDNhNlhRcStFZ2FXZld6cWZDMDBKckZISTkwTTlCNUlsSjhSN3BhdXRI?=
 =?utf-8?B?MnprbklCcjJ6a0d5WFJDV3BxK2ZwM1pSRzNHUGNMeVAwYTFmd0N0S2hhWUtL?=
 =?utf-8?B?Nmtaa0h4RGxId0hBQlpkQ0IvZi9aeHJjeWJ1WEh5YXE0bWRFbm0rcS9QLy9O?=
 =?utf-8?B?NkRCL0xjSDhYMVFScUx0MEVENmhwWi9xb08za1IzaHd5VVg4TGhlMVBwd2Yv?=
 =?utf-8?B?Z0xFcGh0akJjeFF0TDFVaTFuZDFEYS9vMlZITXpHb0d2SGJFSGpTWDBSM2Q0?=
 =?utf-8?B?eXBvUU9wTllFT2tJUUd4SzhaNnhVa2JQbndBK1QrM3J4S0JIUWJTYmU3c2lp?=
 =?utf-8?B?SnZ4N3pWRFRQSXlmbS9rMUNSbnpKUnZqdlVNbGNaNitRMDBTaUhYb3NPVUJZ?=
 =?utf-8?B?Z1ZkclNKRVBzUFhiNElXQnhVTFdmaWhNZlRrNFZudmU4SjZHdkZEcEpxdmt3?=
 =?utf-8?B?SElBaS90bDErOHE2TnlCYi9INTJ3WnBleDVTa0NRZ1dkL2tqZGJXcTlGVHAz?=
 =?utf-8?B?QnR2c3JWZG4ybjRjRFhzUnJmZTVJTm0rVThjcGZQT1ZFcVVZd1JMSWwwNURx?=
 =?utf-8?B?ekJSWVhvMWdhM0doN1N0eGN1MEpaRWZVajFYdyt0WXk0eXplYllCU2NiV0dR?=
 =?utf-8?B?b3MxOUhMRUU2SVhYY3pYWG1GcWxLck9DeWUzSHpuaDlWcFduQnRxa2tTUGFZ?=
 =?utf-8?B?QXpYMHRUVStCb28wZFhmMURhVG5ndzVRejBZc0IxaWpTSmw0b1Z2eU93ZWNz?=
 =?utf-8?B?ZExMUGx3aFZUdFc3UCtrWU96ckF5Y0VYS1hNSThhWUFMbTNjL0ZFcGZzVmZL?=
 =?utf-8?B?QVpKcWpEc1ZlTFpXdFIyY1o1ZUFzcFp5N0toak1WQ1EzQUIrWFpIM1B6cFpO?=
 =?utf-8?B?cDFuUDdnN01TWGFadkdvcnlGUGRNSnFBaDVaMHZxK3hpajVCTWNCbkRkc3Zz?=
 =?utf-8?B?d3RPaGsxa3V6cFhYZFRycS9uQnpUN1NjTngwS3p3WDlhb3Y5NXN6UFUzZTk0?=
 =?utf-8?B?ejdoTTFuUlVDdHNONHQrdC9QcDMrU2RDaThlSEUzWU1HRDFvbE1jTzJPNzNq?=
 =?utf-8?B?YjFhZ3ZDOTdycEN3dk40L3U4V3pHcFI3dmZld3hyaUxVTGVpRTZYS2dUL2ls?=
 =?utf-8?B?WXZNeWFja1BqNnRZalYwekJ2VWhjeEdTODdpZ1VVRURVdkVvUlZ4VFhCWDRi?=
 =?utf-8?B?OXhqZzZKb25yWDFzeVhKVG5RN3M2VUh3a1luenYwZjVUNzB6bEtXUllIdjZT?=
 =?utf-8?B?aEhYd3hoVFZ6UnRZRjErenBPdDd1dkU1ZUZlbmEvOEI1OUdCKzdZNkNERHFQ?=
 =?utf-8?Q?1lue1OUvMwDm3g8+KbbWv/NbB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6e758c-e4ae-4e05-c357-08dc2d9ac517
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 20:23:13.6093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1REgjI3eScKmI2o4YXoDVRCDtMUM6z6VzHiMk912yMtwlrZMmUUuAmHGtFzYQpBzstUQ3LShRPJuXHkomACBGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7287

On 2/13/2024 6:20 AM, Jiri Slaby (SUSE) wrote:
> Commit cfe40fdb4a46 (amd64_edac: add driver header) added amd64_pvt
> struct with ext_nbcfg in it. But noone used that member since then.
> 
> Therefore, remove it.
> 
> Found by https://github.com/jirislaby/clang-struct.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Yazen Ghannam <yazen.ghannam@amd.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Robert Richter <rric@kernel.org>
> Cc: linux-edac@vger.kernel.org
> ---
>   drivers/edac/amd64_edac.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index 1665f7932bac..b879b12971e7 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -345,7 +345,6 @@ struct amd64_pvt {
>   	u32 dchr1;		/* DRAM Configuration High DCT1 reg */
>   	u32 nbcap;		/* North Bridge Capabilities */
>   	u32 nbcfg;		/* F10 North Bridge Configuration */
> -	u32 ext_nbcfg;		/* Extended F10 North Bridge Configuration */
>   	u32 dhar;		/* DRAM Hoist reg */
>   	u32 dbam0;		/* DRAM Base Address Mapping reg for DCT0 */
>   	u32 dbam1;		/* DRAM Base Address Mapping reg for DCT1 */

This field likely was intended to be used with the EXT_NB_MCA_CFG definition.
But I agree it's not used and can be removed.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

