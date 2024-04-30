Return-Path: <linux-kernel+bounces-163852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959F38B74A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41BCE281C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A71812D76F;
	Tue, 30 Apr 2024 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZjRNHxrj"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1ACDDA8;
	Tue, 30 Apr 2024 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477219; cv=fail; b=q48zMJGMQf6rp7MJ2D2S7FzojAwV5h3YSMqDAo4l7EPty/BS4Jku7VtdrtA42xartk+L+TXGE/VOlOyyCbZ8/PhPjr9a3oqVCdAKHW/ilXiK6hFj0x09Gy+TMgTeCWONsib0/yAmrYVSpVstcnpaERUnxzHbAHqfCq6HXV8JZu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477219; c=relaxed/simple;
	bh=Hk+1SqyWtY+CRn1npuOH3Eo+a29+FDWdwe8MDQGOvKA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZI40JtixBayww9Y7dDQ4QhNTj1evH1Dgj8Suj7cNaTdJiBucyrpZhMS9xeGoamkajfUAiY0Udnrc6WV2svp6Cl7e/aITleEvz1Wm0Ypfs7ZpzZXgnfVMGjb6W3s8RT7J0fbBxQHP4Ax7QdwPRlmkPded548c0bd/DGydnF9672s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZjRNHxrj; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IisNJDZ8fnt3s0/ambwHe9XZ6G12Wmz51wHnjyOqXyMtzS12aiGgeNv07I2k7albt1u21qo4Q+efKlYcQn47wM4tIobDlS1UCvogH/+7MILiRu0j3BKMBulkGdqYWscw/wjWxFkwQfSU/rabAU7DBaJIMx8NAotrRkI2RT5Ur8Z0J3ePAD+Zs7rik3FC1nd15plTvQFNP2qLeIc2+RmTVbvIPCtK0AaOdQCDPovLXgf04zJJAyoseP4TUJJp9tIBuyQ9zcgTNveXcMwsudTiSWyKJJDIhtnE/aCsjWu17CaWxd/+ahWOJJgtscPTL3OJLVIoBh0StAHkS12JlcFEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pfi2YU0hIsfl2AX3ULpZFi8tWgZnGNPqpL3HuEaj+Ho=;
 b=IPMZIEGnuWpTiWieUf5PY/YK+nviHSrC8raQvFg5cintX3qJ5BntufJqDQZbF2ok2GcZOC4NROnsIMtK0TybYRT+4d72CBRSVv5Fk9KJhTBYel1tATyKBpA3X9e0Jo28vBM9TqUBmYAFZtPBgWrXN626txZbwlho9F/TbgggPAyjDXRAzT5XYrKk3JzdUetwCIrqhUpaYN0HfBw8abSUcPyHUki1voUk9cw5KZby96h6v7Wp5u5LCgli4BXs0dn+1D+yVzjqLKbhKQ4H7eRcDsDMjt4Ja/GpwjkcGuvFoL1S+HqYQ5g2Lvjo795PymDVru/u7OmnznFgbJe1MKu1yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pfi2YU0hIsfl2AX3ULpZFi8tWgZnGNPqpL3HuEaj+Ho=;
 b=ZjRNHxrjiyWg9SC/vsFbu+v6J7fM7KrTWx0HMtiQDG9tKMG72pB3ko3sR02hqvDMKkI28ILkPn45/PdgG9LdqkiwBNiWHb7sPCklEZM7BEpAbBD19UVfwHnO5bRMSNtqXNGR31dONymuYdDux+LW7ThEwa9XUDC/07uXM25HslNtgJUoKpHTrGovF7tRPOCesut7k94w1pYbgeyIdHEu+ns0qZMEgjStp5qcWiQ/fCFbpgWtjVe34ToSxCnreitpSEVBlrostlAnXGopxoOPtphTSayWoQDwt2wfSCecerHSn+JxfoUnWiT2/mKaLV/HsXoOuoRJcTELZseMC8BUMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MW4PR12MB7311.namprd12.prod.outlook.com (2603:10b6:303:227::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 11:40:11 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%5]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 11:40:11 +0000
Message-ID: <14408365-0270-45a6-9ef6-42dfed18ad64@nvidia.com>
Date: Tue, 30 Apr 2024 12:40:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/138] 5.10.216-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 SW-Mobile-Linux-Upstreaming <SW-Mobile-Linux-Upstreaming@exchange.nvidia.com>
References: <20240430103049.422035273@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240430103049.422035273@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0253.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::6) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MW4PR12MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: 62243de6-41ef-49fe-8ce5-08dc690a4b44
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGlmR2ZOelZRVlhwRUVpazlORGtTaW05Ti9xWCttMmZjcFljaUVpeVJrUldo?=
 =?utf-8?B?SkpXcmxmT3ZnWi9zVFNCOEREc0o3eFVia0p0TXdGeThHeFNXMHhwcUl5Uzh1?=
 =?utf-8?B?UUpHaVUrdFplSFMzRFFEL05mcW4wb1NZT0ZaMjNzaFZ4OVozY0srTVM3ZHhv?=
 =?utf-8?B?NWFvR3hEYjYyb2VEVkJDeEVkTHgwZ3AxSkVjb2V2UENIK0gxa1AwN1lMWEJP?=
 =?utf-8?B?V2RiSFEydmtOTzAwekt1aHI2YWhVWlpycDR3bk1aeW9FV0FOckF6SXlYVkox?=
 =?utf-8?B?WiswZVVMMlM3VURTRlhuUE1lUDVNZ0dlUWFCMTVuU2l3TURtaHZ0STNEYmpU?=
 =?utf-8?B?b1VPS25OUDdQc2UzTjkrQ01xRTJ0Q05LdkNMUno2dFI3L2R6OGpJNmNiNnFu?=
 =?utf-8?B?cVY0bDRXVThUdmlTYmI1MTl0N1RKcGxMUjFCdlJIRDNmZUxDZ21EeXNwYmVR?=
 =?utf-8?B?c1VpTnd4T0pVZUllOXZteVhMRE1SN0V2QTh5VVlQMXc4cGhMTVhlTkVIZm5y?=
 =?utf-8?B?cFQ5bGtxcUNyZ3hGcm1MRmRvamhKK2hLTXBLOGY2bnNQdlo5MWJiUUpmU3VN?=
 =?utf-8?B?aER6VmVnL1hsUkhtNFlCOFAxZ3lhaWF1WkNCdEV1YkxqSkZNNXVXVXdJQ2c5?=
 =?utf-8?B?UWcxajdCb0pPOGZIQUdTbjFwQTFGM3N6TnhRRU9YTlBreGMzY0hHejNWUkNB?=
 =?utf-8?B?cDdNbnhFcWhuMjBoOGZSdmZJeTNIaSt6VlJFUFB6NW1lYWhQWkNSQmJzcTRO?=
 =?utf-8?B?b1dSaTdRNnZ0ZW5YNWlYQ0xqV2l3SDAzWlp2eEZCWlNFdE94UVRrMEkyVzR0?=
 =?utf-8?B?TmFvVTEySkNhM1YzYXpLYzRMcjFhcU1zNkRHa2ZSRFBtMDI2aWZKcjlDb0Vt?=
 =?utf-8?B?M2hyZTl6QjFNN3dsclp1d2c4bFBYc2NZMG9JWjhSZVdDdjllRzY0T201YVVZ?=
 =?utf-8?B?L2tBSFliVDJUVXUvZXhCNk9xUmgyUkVQSEpGTHNjOUVhQk1nbHZMUE14WmZS?=
 =?utf-8?B?Y09sNGhPcUdNbk15ZGY3WDJQekVvaHM5S0xBc3dab3E1YmlXRm90THdmNmN2?=
 =?utf-8?B?bXZEOEk4TWt2dEtBZFJINFRHcHQyMGVuUU9FK1Ivb0JXV0ZYQnVhalY3ZTJu?=
 =?utf-8?B?R2ZYd09yTTNrTDNqcFN6WEVkNmZvckpxVkdVbWdyNDg0ZHlWL3NWalpRY1I0?=
 =?utf-8?B?VlpyVlNIOGQxQ3RTKzRvUWFOdURqN1FnbU10YUdOekF0NDJFQ0tEU3RTeGk4?=
 =?utf-8?B?dURsVkFLYUhiY09SaUFWL3BlaU44Tnp0Z3p0RWExdXBIUVFXZ3lBVmVJa1Q5?=
 =?utf-8?B?Z2QxL0VYZ0k0ZGpGQkk4UktFZWRLS0dsWFUyMUhRN0RZNlc4VFBuaFhiakxh?=
 =?utf-8?B?M0syUk1KKzdjdUNZYnhLai9PZGtsVTFIWklteGpxWEZ0cHZ4Y2s5dm9wNncx?=
 =?utf-8?B?VlpweXRYNjNEeHpIdzhxMFg2WGdlVUh0QTFGc1daMjdhcUgrK0Qzem1XcFJE?=
 =?utf-8?B?WWxpVFJwa3NWQ29TOE9jRktzSlcrNVlwa3F6QlE4TGhpa0tMQ0ltVEpGem54?=
 =?utf-8?B?aTIrWk1Talk1MGtkNUUybElVdmlEcVFaVVh0WlpJN0tSdVExUGxuWDVhd1pq?=
 =?utf-8?B?dkZDSCtBbC9zTTZqRjgxc2g0TENHZEJXSHl1clR2S0djOUFEbTlSQ1JOcnFH?=
 =?utf-8?B?VFkzMDlHeFE0UldoV1FaV1ZIcHdrT2VLVk1IVXRvM3ExWXlnMll6QXJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0IwM2NpZzViTENYZCtWcElJVFlTWVBuOXFjOW1ocVJBVEFKcjZhT3BuZXhO?=
 =?utf-8?B?Ty80QTZYc3BrVmcyM2xkNnUyZS8zckFDWHNwYU9qYWpBSWtNVVplQXVsMXFJ?=
 =?utf-8?B?Q1pSSDI2SURraC9DMXUyWkFqUlJuT2N6STJGNUcydjBWK1hMbGMrRXZ2dkRT?=
 =?utf-8?B?QkVVWE1zb0RPV0lTZnpZQUpkNExMTEJ0WXN3bitnSUEzSXUwSkhiQ1NnSlQ5?=
 =?utf-8?B?d00vT3l5WjZ0UzRFckZBV0V6L2lFbW1FSytTUWJHaWNYWmJmR3loUWF2eTA3?=
 =?utf-8?B?N2dNMzk2T2JCbHRsN0luUlpUZFJHYzczQ2cwU21NSFRNTUJxQXpGYllraERY?=
 =?utf-8?B?US9SQjZxNWg3Y0U3Vml0R3Fpa3BRMnhGRk9HWVRqWkFLekVWQmdkcGl0WVpy?=
 =?utf-8?B?UldZc0Q1bnVFTnp0RnJ4dmpSWTA5T3dXTWxoVEovNXNLUkl1ZVljQVEvU25X?=
 =?utf-8?B?T2pVVFQ2UG9uN2RwZE8rN2tZNWEyZ3RrdTRzWHBLS21HakpDZDNxUEJzaWRQ?=
 =?utf-8?B?enhSR3hMSDZQUmJSdHFDYjNkUFhCVzR1ZUxzTUtMb2RkcXl5Qmcyamg0M0t5?=
 =?utf-8?B?NUprc1QxdWl3Qll1UG5XdWNoUlhwYU9XWHpoK1l0d3FyNGVUTi9oTldEU0xy?=
 =?utf-8?B?S2w0S3J4REZ2WmoxYWxSN3NiZDcvN1ZIaWZObERwUWhDSC9oL0RyQ082MzR0?=
 =?utf-8?B?RXk4LzVrQlNuUS9zSTI0N2Zaa2k5V2FpNUJkZWRkbHRNNVF3RVBOclBKT0Ex?=
 =?utf-8?B?Z3k0a295VmlWSUlIcEVJMVVCbzhiSFQydFRaeDFZak1UbmFUdDZoTml4VW9N?=
 =?utf-8?B?UGJieEdyUC83aXg4dW55SUJBZzRnall4YkFMNW1leHg0NkZmYzVJK3pEbUZT?=
 =?utf-8?B?a1pxU1RHbUN0WlFOQXVybVhVMW5ta21qSkJJQ0lzTVB3UElOdHFsV0xFRWNq?=
 =?utf-8?B?Vlp5bHRNWjQ0WVllVE1USXNqdDFKZGpVYnk0VmNydWxBUDltSzh5SVhMZzh1?=
 =?utf-8?B?YWF6RGg1cXBlK3lmTW84Z2Vha3R1Y2RmcG9iMzBONTZTcDZseEFvb3lZb3Yy?=
 =?utf-8?B?bW90bkFjMzBDR3czTTlOWStSQ0pxa2JPbFU4YlFwZTY3YUJQOXFteW5Hb1E1?=
 =?utf-8?B?UGtQYlUzZEFEZWZpTDRoWkJqZGhpMW56VGVZOXhNNXpXTFAwU3NhVnVrOS9a?=
 =?utf-8?B?QkJOWFpzSnphN0dydCsvU0JibzVNR21RTXNkZUlVUGQ1bEtic3V6S1V4OVpT?=
 =?utf-8?B?YkJybU16V2U3NG5DNkt4cTVleHJXeEV2WldEKzk0N3BtekdvOVIyQm1hSUFh?=
 =?utf-8?B?anVpVFNCK2ZOdWRRcWRPTHNHQ000M2w3WlpmNGxxdzhvVFFoK212YzdFOVIy?=
 =?utf-8?B?bVlwWHRJekZ2T0sxTnBvMnViM2lGLzFHVkxoZVE4MEF6Y0QrUnNYbjl1Zy9u?=
 =?utf-8?B?WmpKUTJYay9JYXRJdUNJUWtVbWdBTVVTNlJVdUNFaGZpN1hPYk9xd2RrWmhm?=
 =?utf-8?B?YmpRcHZIKzdIeUd4cGlodUlHWjF3Umk5SnJBZ3RWUjFtSktudDFET0NSVnFX?=
 =?utf-8?B?M2xJNFlYVk93MVppMnB1SmFxaEc5NjF4OSs5K2gwakRaK0p2aFRDL0pmc1Zz?=
 =?utf-8?B?YVVKd2trUVBiTW9CRzJ2S0svbDZlMGJPY0lKVk9KdTNUcVlVVGFzZURka1BL?=
 =?utf-8?B?MmhNVFMvTXZOakNNcnlPNTdKNXlmVDlheHRhdTUwQ0dUVDZHSWdjMktpZGs1?=
 =?utf-8?B?bVlVQzRDL3YzeU9jQzBsa2NQbCs2N1pNM3VwWTFtejl3MEZrZ1FSaHRMM0pW?=
 =?utf-8?B?Ynl6WWZEbHV0bjJtcGVTdDZHUUVRelp3TzEwVXU1c1A5L0FTYnRLd05iRHJ0?=
 =?utf-8?B?T0pXd2IyekV3RGZrUFhTRmFjQzN3QUQ2SmdldFhkeUdSQS8xTGQrVDd4RklM?=
 =?utf-8?B?RmhNUDMwN2QycjNaQlEreU5DZHVsU3E1c3ZFWWhkTDgrVysvTFRGVHRkU0Vo?=
 =?utf-8?B?MHlZR2xudHV1U1dONUdwS3BOYXpxMVhVK1c0UitvNDdxQTdSZThPR2g0TXVW?=
 =?utf-8?B?b1dnRGxIQnVJWG5Fay9yYnRPOCt1Z0tPNVNUSEZPenBuKzBRK080VkV3VTRu?=
 =?utf-8?B?WVZkbHBMVkgvaGJha2poK2JJVDVGQ3FTMG1FeTNBL05RbXFDTjlscmF1Qmwz?=
 =?utf-8?B?anB2MlRMdCt3dzB6RStpQjJvSVR1eW5DL1pKT0lSd0QvKythTkh2UGdWamd0?=
 =?utf-8?B?bC9vUThZb2NxWmZWdHRIdHI5VU9RPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62243de6-41ef-49fe-8ce5-08dc690a4b44
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 11:40:11.5911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxPYOHOMc3byuq43UMMmXhyDVx4qEpudQ9XOHi0wSLOJlCgZnZnG+TxuJLbxffnu+hhBVu5+XUUwfm2/ly57Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7311

Hi Greg,

On 30/04/2024 11:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.216 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.216-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:


..
  
> Ikjoon Jang <ikjn@chromium.org>
>      arm64: dts: mediatek: mt8183: Add power-domains properity to mfgcfg


The above commit is breaking the build for ARM64 ...

   DTC     arch/arm64/boot/dts/mediatek/mt8183-evb.dtb
Error: arch/arm64/boot/dts/mediatek/mt8183.dtsi:768.26-27 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:326: arch/arm64/boot/dts/mediatek/mt8183-evb.dtb] Error 1
make[1]: *** [scripts/Makefile.build:503: arch/arm64/boot/dts/mediatek] Error 2

After reverting this, the dtbs build fine again.

Jon
	
-- 
nvpublic

