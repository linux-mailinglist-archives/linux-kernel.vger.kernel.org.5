Return-Path: <linux-kernel+bounces-36083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E80A839B44
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912491F25833
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01A83D99A;
	Tue, 23 Jan 2024 21:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NqhW7a+7"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90113B2A6;
	Tue, 23 Jan 2024 21:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045999; cv=fail; b=rCRE42H3UVCfVDUdyywXjvVf4zRclu/zOXTp87LacA+ONBy3mfe19olC+tPhKtLqiG3uEc5KEltttQtpnXrnO8i/OjPYzW71C3zW7KIbp5M0xBzJJ50OLE0MRVuqSnM69oqXO4nTlll50Q7KL3FlRWvh8c1cDxSbh9yDXPPIOVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045999; c=relaxed/simple;
	bh=3776sbsAvHyE7pUv+vk19lINNPnZJZ5xjNrKKn8YZ4Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U3lAFwi6N10omHg7oGwyR+M+iy/cdTzH65ookhXlGYIZ6FoqlAJFpaNztkWDys7a/WbeG3/AkJ7lSKlHclFJAt9WlxpIArJWMa2rMctuHnaFXT/hi4B6dmRgQ4uij/fcHWtbqmcExx2Ij9tDQlj8RRpKRf7rZFdYFrTC8bfvTDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NqhW7a+7; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPdKNaJ1e7b7VRvHD53O43hrwQtXQxHvz62zoxhBWzMzZwlZusLnFyIvd/0Cck8e2Kd+IJ4pydrm5SQhQ4mPDFe7JJZL2h80LwBgjY+4ndnaMnFirkoltOjXMyTLjauxsOSk0cj5qLjozKO6w4oZuItaTvqyaoPTFhOdQ6lDGD73I/1zfgQaJoftGC8MRXfQIb0hIZ/8j9okZVzDWV2XcRr2VqPIPn5G/XLm3cG+ke4sqSC+ELXlNejyiWF9XpOa61+I027KvNlOQCs4PLodllbB5kJm6LD3FhaN3EhxA+Kj/yO63YMaeHoEI1/QRuMILG7xSM0ADaiXfzdqVtmgCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXroSFejYeUKONL18S3aM6Xa2As7SAAr4v4jAQsuXIA=;
 b=JWSNaaNSjXKgjjUlgU1ZwfflPY6CyK+PpFNAbCJfuOdAh4Xz+FbyFDAg2QV1pc848XXGLynNujCYOTSXHB37qyHpdM/adwxAZhwAOEtOEUww+XcC2kQlJjZjZ2SNUQ0XOpXzbh/Alpn8H2hl5rASosoSH/91KjnlwUbamZ7YYimRyn8sdrL3+w60Wuj8X2yAXzP8DxWUk8YIXvBxquh/lwE+Z7vTa48/qqXtklUzdSthps7kYdEN1BjRFjqUjy3i69mPQAdjLEjn7iwt5IwJ7u5pRwdwL3M3yXTEgoQQi/ASipesJN6CUfjNIH0VWt/LitqmqypHDGi54a/XXP+x4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXroSFejYeUKONL18S3aM6Xa2As7SAAr4v4jAQsuXIA=;
 b=NqhW7a+7PrRCiODXYwfNUigmsY9MtxQdGQ7sDq/jhv0gUy/glSA/yt7cvWGHQhrKp8IqxDZH2VGE6BV6Vhvc8ElIO2xMYjnAyv2aalWJ7y/A2M67klRdA6/ylyU5+6NljKZ9VIehI+O6yFyi71n0nGNhrdBPH9r3+4rLaxqrlnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by SA1PR12MB8142.namprd12.prod.outlook.com (2603:10b6:806:334::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 21:39:52 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4%4]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 21:39:52 +0000
Message-ID: <c86815fe-21dc-4dd7-bf10-74e3cc754413@amd.com>
Date: Tue, 23 Jan 2024 15:39:49 -0600
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] ACPI: APEI: Skip initialization of GHES_ASSIST structures
 for Machine Check Architecture
Content-Language: en-US
To: linux-acpi@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
 tony.luck@intel.com, bp@alien8.de, linux-kernel@vger.kernel.org,
 yazen.ghannam@amd.com, Avadhut Naik <avadhut.naik@amd.com>
References: <20231204192549.1953029-1-avadhut.naik@amd.com>
 <b519a7e0-77a7-44b4-809b-caf96536fe1c@amd.com>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <b519a7e0-77a7-44b4-809b-caf96536fe1c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:5:60::16) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|SA1PR12MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: 7856f821-186e-4161-e711-08dc1c5bd4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kIpho/MM2BAgq80W08mAR3k7ZX/sJh5Uxu9Pr6DXl6COjKO7sFfgvx30lhf/m1qY0GXlZYmdMF87pe4vj2Az+caHmlcaq03aY2UwCILXBJLxsrXRgcxC6eLXwUZM3ZdhK58VHrur8Om0+aTxYB5lD4rMJzNAc3zEwUEqwcMJf/+luejrmXZqx9i5X0n4aXo2bfNtKXX91a8QE3k5IO/NpkeiVCCWogA+1awl2u+ezb8N4MM+4QtAEIgJELGrpcYQxS8zjRZucmtNYKWrEcjETLh2LNpJO8o8jBBqxAOQKIGaEZ1TzazHTY3GuwZpVn0alGhqpznEp3MWmMKlHMW863ifdyZG6if0tQBFt6EJYwAOtarL7R5LhixyaV0JKwgb2zPSbjYfx6UjehFKkfV8WSXuuVEy2Z9lsqGFcNISLgnKTdeXK50SfL7W1+HosI3PFijiG9LnrmOpuzYVhF3JSCFRPq+EXebYFKWaFFFBGHSqghyEP4Yf89+L/x6tt+BUKzWZUSzo55GwHgh+NMqQiE9+lasUBKDexVM4nTIWRoaPFyK6qjJGiE3NJUujjrVODut7tWC5jNxy733BJ168CpEv14WWhjv+Rk4zZVxBJ7AtP4KVwU43ZPja6/EPC+Ygy5kRqSqDe1oIRxFSyROy2Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(4326008)(8936002)(6512007)(83380400001)(2616005)(5660300002)(6486002)(53546011)(66476007)(66946007)(316002)(66556008)(6916009)(8676002)(478600001)(6506007)(6666004)(26005)(38100700002)(41300700001)(2906002)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFpRdEF5UEhxNHNDbWlTTnF5ZTJ3Tk9YS3lMOGZjVWk2Ry9QMEg4cHp4VnY3?=
 =?utf-8?B?N0hDam54TFJBNGxFWTFHN2tZQTVObndGdGROMVBjMjJpRm50MmNEc1ZjNnhY?=
 =?utf-8?B?WHBTamwxWEZJODZUQkIvbFVTd3pmQWljRDV6MkRsVkZ1MFZLU1c3RDVCK2VV?=
 =?utf-8?B?VUJXY2N2czNxK2NrbzcxKzgxdFYrZm4xbCtSTHBOQk41UFp1RVZCZm1JYUhh?=
 =?utf-8?B?Z1JhVWdwSUN4Y3JwY0tMTUFtWmZQRlpwU3dKTkF5OFQyZm1LS0ZmNG0yMkw5?=
 =?utf-8?B?M0RiVCtRc29OeEs3aGQ5K1lZTklCYzc0YTdlT0QyWCs0eHYrQ2s2eHVFUnc2?=
 =?utf-8?B?VEZZTDFjaUNmVVRtdDVEYlk3SVJQandzOEJUUjlWdkMwSGNVV1I1WXYrbUt4?=
 =?utf-8?B?T3l1eW81N3JpNlZZbFVZakxhSUVzTWx4NTRHMEFTSVNqMlF6eG5oRXdkM0pB?=
 =?utf-8?B?dkJud3NrczNJa3JNMDZtWVhkcGc0dDdvNjk1V1JNdWdvaysvMG80SU1Cb2Jh?=
 =?utf-8?B?NE1aV294Y2czWnVnZFc3dFhNWERZZlk2OEdtZ21CQS9IaC9XenVjMW9Hb3NV?=
 =?utf-8?B?UGQ2UU1LU05hRW1LMm9OSW9MTU94d0N2ekVkNFRQSnc3WTk0a3l0bUpzallI?=
 =?utf-8?B?VXFENjl3L2ZTbHdrREZQSmdhR2N1MjhQaUxWKytZVnhLTndCOTN0VFRKdmRx?=
 =?utf-8?B?Qk40ckNOMUZqeXIxWmE0OElBcWluSXQwdkZrYU50MmsrcHdVVnQvS1RCM2wz?=
 =?utf-8?B?OFp6b1ZIcXVXZHViNXk3dk9LbGRibkJjT3dkTDFhcjFwdE1xZGpqTVkyS1V6?=
 =?utf-8?B?dGhHZk5xTHhKMk5oL2JDVEkyellWOVVFTkxSZk5xMXB5ZzRkWTRmUnJtNmZH?=
 =?utf-8?B?anM4ZDcxMUJLMEZpRlFTMFpsOEdFZ3dZb0dKZWF4NDBrNGxCRFRrTWpuY21i?=
 =?utf-8?B?V2JKNGlGeTFLK3dVTGQ1Z1IzTlNXd3JGTlkxUHdMOEdjeXA0L3JNc1ErRnBz?=
 =?utf-8?B?YlNwcVZUM0F2OWplZ1pKdFhUeUFBa0UyYTljTXVuSHRaWk52YXZuTWVkYUtD?=
 =?utf-8?B?VVVORExrZjlkVmZhVlp5dktucm04aU1sMW5DOWtOcHNiNFhGbzFETTFGMmNT?=
 =?utf-8?B?SFUwU2JjZ0UyTFR4bU9sKzhMQWFVN3pJZFhacHk1djI5M3VNaFhJTnBrSUVV?=
 =?utf-8?B?WEFiZDBIdjdFcWYzTXduY1hoc1dzalZ4V2ErOHR6ZXcwbjN5ZWJSMktZeWdP?=
 =?utf-8?B?aWpWcThlTXQ3L0wyUHNwRGhwVmZTYjFhMEZtYU90MEUvaDI2b3htUlEyVXRz?=
 =?utf-8?B?cVBVclkyUTFNa2xDNHlPSzZXWS9zbjd6LzdUUHpzdzNaVUtxZlBERXpNVUto?=
 =?utf-8?B?UEVxdmdnb3JWNzB2RlRSZDZPNXdBNW5tYm44eWVSTlBsUFdWZ2t2SytyalNa?=
 =?utf-8?B?cWVxMnhxajVLL011anVZMCtWUktCQjJrVjZaNWE3Z1ovRjBUTEc1VlNpSnF2?=
 =?utf-8?B?NDRpTk4zc01vSFpEWTRmb2IvSnphQVFuN0g0bTRHY3VVeGZxTG1NUDBaZmx5?=
 =?utf-8?B?bktNVWFtRmh6bjdaRUthWk5rZ1F5VDd4UXVpaklscjg1c2JBMkNyL3hjSCtp?=
 =?utf-8?B?SVJNSHArSmlYbFhrZ2hHL001UDRiditYaWFOY1pRTVk2cHhUR0E4MzdSaVFR?=
 =?utf-8?B?cnpLZnZtZWg1bUlCN0VJS1lqQ0ZkNmZ6TS83aFJBOEUxNHFFVXVwWmFzUG9L?=
 =?utf-8?B?NEJ1R3JtVmM5T1dELy92OU5McXZDR0ZRWDdHWUpUdXUzRFlTOU8rUzNydzUv?=
 =?utf-8?B?cXhwU2NaYUVEQ3NHL01MYkZ6c1pXK28vMEgzbHQ5dkdZQkFHeXhFRVgzcVU0?=
 =?utf-8?B?aXIxNlN3amFrRGVlR24waEhWQ0NmZ1MxWU1qQzU1eVVIeDVZajI2dHVGUnV2?=
 =?utf-8?B?Ny9mc0pEOWtDODlJZGlTdjJPdllqQUtUYUVhVGI3VUNTNkdaTUZhcitwQlpS?=
 =?utf-8?B?bzd5eHQ2TGtpbWV1RXl3WHJSV3RRb3MvaDZMTnRzR1U2Z0ljd0FkVU44MkxB?=
 =?utf-8?B?Q3hZY1RZL3BvNDhVVEhqOHNyUWRHczYxOFJ3cVN0cmxLN0hBbjIvQ21DNlFu?=
 =?utf-8?Q?UMOXr751pRGLf/vBWaVnIsBAa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7856f821-186e-4161-e711-08dc1c5bd4fc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 21:39:52.4653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2+tjr6A5cNSVTcfjx/gWe+ERZ2a9ng4yaEq8kX1+pwmXuIi0eH1f4dFvvBnPEcmF9vjOZDcF945576+I+8FZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8142

Hi,

Any further comments on this patch?

On 12/18/2023 11:13 AM, Avadhut Naik wrote:
> Hi,
> 
> Any further feedback on this patch?
> 
> On 12/4/2023 13:25, Avadhut Naik wrote:
>> To support GHES_ASSIST on Machine Check Architecture (MCA) error sources,
>> a set of GHES structures is provided by the system firmware for each MCA
>> error source. Each of these sets consists of a GHES structure for each MCA
>> bank on each logical CPU, with all structures of a set sharing a common
>> Related Source ID, equal to the Source ID of one of the MCA error source
>> structures.[1] On SOCs with large core counts, this typically equates to
>> tens of thousands of GHES_ASSIST structures for MCA under
>> "/sys/bus/platform/drivers/GHES".
>>
>> Support for GHES_ASSIST however, hasn't been implemented in the kernel. As
>> such, the information provided through these structures is not consumed by
>> Linux. Moreover, these GHES_ASSIST structures for MCA, which are supposed
>> to provide supplemental information in context of an error reported by
>> hardware, are setup as independent error sources by the kernel during HEST
>> initialization.
>>
>> Additionally, if the Type field of the Notification structure, associated
>> with these GHES_ASSIST structures for MCA, is set to Polled, the kernel
>> sets up a timer for each individual structure. The duration of the timer
>> is derived from the Poll Interval field of the Notification structure. On
>> SOCs with high core counts, this will result in tens of thousands of
>> timers expiring periodically causing unnecessary preemptions and wastage
>> of CPU cycles. The problem will particularly intensify if Poll Interval
>> duration is not sufficiently high.
>>
>> Since GHES_ASSIST support is not present in kernel, skip initialization
>> of GHES_ASSIST structures for MCA to eliminate their performance impact.
>>
>> [1] ACPI specification 6.5, section 18.7
>>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> ---
>> Changes in v2:
>> 1.	Since is_ghes_assist_struct() returns if any of the conditions is hit
>> if-else-if chain is redundant. Replace it with just if statements.
>> 2.	Fix formatting errors.
>> 3.	Add Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>>
>> Changes in v3:
>> 1. Modify structure (mces) comment, per Tony's recommendation, to better
>> reflect the structure's usage.
>> ---
>>  drivers/acpi/apei/hest.c | 51 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>
>> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
>> index 6aef1ee5e1bd..20d757687e3d 100644
>> --- a/drivers/acpi/apei/hest.c
>> +++ b/drivers/acpi/apei/hest.c
>> @@ -37,6 +37,20 @@ EXPORT_SYMBOL_GPL(hest_disable);
>>  
>>  static struct acpi_table_hest *__read_mostly hest_tab;
>>  
>> +/*
>> + * Since GHES_ASSIST is not supported, skip initialization of GHES_ASSIST
>> + * structures for MCA.
>> + * During HEST parsing, detected MCA error sources are cached from early
>> + * table entries so that the Flags and Source Id fields from these cached
>> + * values are then referred to in later table entries to determine if the
>> + * encountered GHES_ASSIST structure should be initialized.
>> + */
>> +static struct {
>> +	struct acpi_hest_ia_corrected *cmc;
>> +	struct acpi_hest_ia_machine_check *mc;
>> +	struct acpi_hest_ia_deferred_check *dmc;
>> +} mces;
>> +
>>  static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
>>  	[ACPI_HEST_TYPE_IA32_CHECK] = -1,	/* need further calculation */
>>  	[ACPI_HEST_TYPE_IA32_CORRECTED_CHECK] = -1,
>> @@ -70,22 +84,54 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
>>  		cmc = (struct acpi_hest_ia_corrected *)hest_hdr;
>>  		len = sizeof(*cmc) + cmc->num_hardware_banks *
>>  			sizeof(struct acpi_hest_ia_error_bank);
>> +		mces.cmc = cmc;
>>  	} else if (hest_type == ACPI_HEST_TYPE_IA32_CHECK) {
>>  		struct acpi_hest_ia_machine_check *mc;
>>  		mc = (struct acpi_hest_ia_machine_check *)hest_hdr;
>>  		len = sizeof(*mc) + mc->num_hardware_banks *
>>  			sizeof(struct acpi_hest_ia_error_bank);
>> +		mces.mc = mc;
>>  	} else if (hest_type == ACPI_HEST_TYPE_IA32_DEFERRED_CHECK) {
>>  		struct acpi_hest_ia_deferred_check *mc;
>>  		mc = (struct acpi_hest_ia_deferred_check *)hest_hdr;
>>  		len = sizeof(*mc) + mc->num_hardware_banks *
>>  			sizeof(struct acpi_hest_ia_error_bank);
>> +		mces.dmc = mc;
>>  	}
>>  	BUG_ON(len == -1);
>>  
>>  	return len;
>>  };
>>  
>> +/*
>> + * GHES and GHESv2 structures share the same format, starting from
>> + * Source Id and ending in Error Status Block Length (inclusive).
>> + */
>> +static bool is_ghes_assist_struct(struct acpi_hest_header *hest_hdr)
>> +{
>> +	struct acpi_hest_generic *ghes;
>> +	u16 related_source_id;
>> +
>> +	if (hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR &&
>> +	    hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR_V2)
>> +		return false;
>> +
>> +	ghes = (struct acpi_hest_generic *)hest_hdr;
>> +	related_source_id = ghes->related_source_id;
>> +
>> +	if (mces.cmc && mces.cmc->flags & ACPI_HEST_GHES_ASSIST &&
>> +	    related_source_id == mces.cmc->header.source_id)
>> +		return true;
>> +	if (mces.mc && mces.mc->flags & ACPI_HEST_GHES_ASSIST &&
>> +	    related_source_id == mces.mc->header.source_id)
>> +		return true;
>> +	if (mces.dmc && mces.dmc->flags & ACPI_HEST_GHES_ASSIST &&
>> +	    related_source_id == mces.dmc->header.source_id)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>>  typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
>>  
>>  static int apei_hest_parse(apei_hest_func_t func, void *data)
>> @@ -114,6 +160,11 @@ static int apei_hest_parse(apei_hest_func_t func, void *data)
>>  			return -EINVAL;
>>  		}
>>  
>> +		if (is_ghes_assist_struct(hest_hdr)) {
>> +			hest_hdr = (void *)hest_hdr + len;
>> +			continue;
>> +		}
>> +
>>  		rc = func(hest_hdr, data);
>>  		if (rc)
>>  			return rc;
>>
>> base-commit: 629a3b49f3f957e975253c54846090b8d5ed2e9b
> 

-- 
Thanks,
Avadhut Naik

