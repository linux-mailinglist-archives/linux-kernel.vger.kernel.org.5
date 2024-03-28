Return-Path: <linux-kernel+bounces-123833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8548D890EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCC90B227B7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186AC13956C;
	Thu, 28 Mar 2024 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="eh7wC19G"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2092.outbound.protection.outlook.com [40.107.244.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7054E38FA1;
	Thu, 28 Mar 2024 23:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711669285; cv=fail; b=ivT93aXg9SO1UXMA4A52xLlnCqs1yOYEdbdr5N5QrShGJrfUIyMlW7X1bT8X1SdVItHgPusz4faYyXv3BZIYS9Cl4RFGWZ2U/+zJ1CKsaqxXCMYcp5whyiDz515eNdUws4icv3a1UvB8uwWycVeY9cAVXcXpSjf1fXTlAyNP1j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711669285; c=relaxed/simple;
	bh=K1EbGR//cNxoepaVsUt2asFYmA562aoc7bpv4D1h5fI=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pr8kSbG8cpAZxEV99PyEOwXjZODUXWRA4gI2GWFClLxs33HIA1bKMWgft9Od5RAChrhjPasbRDSbQrCbjPVVep7ly+FFNgEYsVpVdfAhe5Mho8+LiMWra9H4kCVPXdzZ5c33DvWwvSbfl03uxlN3/gYnq91hlOou7+YAn3ZmkR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=eh7wC19G; arc=fail smtp.client-ip=40.107.244.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLlYYa4IgswAHo/W6RKf4nvc9OC4Zndg2oWfTKOhQQM5Uw+HrDrNe/oEoqEMTSTrxG9ONyCVKbfQ1AwQ+R/qxylF2ERuue2OrWjO6wlUdtmclfyVuIz2etGf0C6AsUf2O/+8pG2ErQjGxtrceGX0d9KFKjiCP7zeHqQatfBG1JPKJHv/plEZsbTw3+XIVM/g1aQmLwE7fDCPu2LSQFGTrSv69WkiyO2uuf7ksNtAsFjOZJ3k7Q4azhoZbBl8ZeKGXkoC+Ds5AWFPDRuxqtEVA1P5VOsl+11Vls5wS0jo+7w1hZPTJokQMcxWWHvBna3zMg4a9JmaBusmJv+sivp7lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJx/YV0TFwouXt8PvLCFfp7+wDAcQhhbNpHx+MrnQzU=;
 b=dACxjbmp7mWBgEQYfSo8kNZqk+RNjprHqM8PL75aNhpjezYcwp+dbBW6b0kQQvqIW78oavNApHUNjWJbY9fR3sRLHMHiCdJz8YpZIwA48I++nPo6p0PdUjrVQZcyy0qzqiCJ08V9slU01aY8r0VESGA7P/BO5+CFAtaneG26WTQxtMjgdUZ1tXF8Amr4gxLVyeBOp/taEJxNwnm3KB3Yr9LjY1xbjBibkCsdUXCk0owzSF1ypnxhzb7nn6AMGXuRUk97kD+S04AvotUZOZz8SwsF5j+E11tzusIpM2I433kaQdGfCH030+WUPCGxeYL5BXOboqVp1S6x4cn/yiVyyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJx/YV0TFwouXt8PvLCFfp7+wDAcQhhbNpHx+MrnQzU=;
 b=eh7wC19GpSgHDW+SCNb6hoM5KZn84YLMeO+L1mzjcs7NxAbLApgs4SzugqWxlz/7MFr1XURM/R7vY5KFpK+OOySicZmUjfWH1R8m4usy09EGw1cW3WqNMxd6ug47VhYY7t7bkQ/8UsOW0g/QGUvtB8StX4CSrzCFaLBxlT6HEu4=
Received: from CO1PR01MB7370.prod.exchangelabs.com (2603:10b6:303:159::16) by
 SA1PR01MB8180.prod.exchangelabs.com (2603:10b6:806:339::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.33; Thu, 28 Mar 2024 23:41:21 +0000
Received: from CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::994c:4200:8a4b:6882]) by CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::994c:4200:8a4b:6882%6]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 23:41:21 +0000
Message-ID: <0d398f19-b8df-4936-97e0-fba8eb041d88@os.amperecomputing.com>
Date: Thu, 28 Mar 2024 16:41:17 -0700
User-Agent: Mozilla Thunderbird
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Subject: Re: [RFC PATCH v7 11/12] ACPI:RAS2: Add driver for ACPI RAS2 feature
 table (RAS2)
To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, dan.j.williams@intel.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 david@redhat.com, Vilas.Sridharan@amd.com, leo.duran@amd.com,
 Yazen.Ghannam@amd.com, rientjes@google.com, jiaqiyan@google.com,
 tony.luck@intel.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
 rafael@kernel.org, lenb@kernel.org, naoya.horiguchi@nec.com,
 james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
 erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
 mike.malvestuto@intel.com, gthelen@google.com,
 wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
 tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com, linuxarm@huawei.com,
 wbs@os.amperecomputing.com
References: <20240223143723.1574-1-shiju.jose@huawei.com>
 <20240223143723.1574-12-shiju.jose@huawei.com>
Content-Language: en-US
In-Reply-To: <20240223143723.1574-12-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0195.namprd03.prod.outlook.com
 (2603:10b6:610:e4::20) To CO1PR01MB7370.prod.exchangelabs.com
 (2603:10b6:303:159::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR01MB7370:EE_|SA1PR01MB8180:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EaLGzZY7xB8EHyRyUgAuQJSuow52527ozdgFC9g0OnTW8SKdYcdcATqE8Pv35GVZQ73xTkhyP8LpDmAui4DqsRaDd12eWMEWvSrDL18zATUjouSgY5IqxkrJQ7E0bet8V9mYsaFujlX9H+J3R7JJlTrHJ5I1iUieGP5uXzZv/9SMpF2h5C51XN0xZDHtP/GKIZXWx+3CqBraOp+RyAGbB24X+OEDFHBZnAKz2FUWuR+Yg4bnVz2Qb9HjA/IpZ1ja8nfJrc8GW7EQwHc74ir4SbFDyPs7sSIeSQZCTe7R5Ehk5twhtv2IaPuhaKyc/WhOrXHwW6ycPlKRAwS22l9CUWKzFK8eMsJFf1qIoeh/lX9xGqbym85o3FpZEVAIfxCLnKeAM5vU1mDGIpaVAx6VATg73b4lhb5zheMRgdVtiKl+CZ5HGvdp0VGtKr49801kJTb+L/o/xQYjaOo/99ZoQ80SXwe1jfIwOwXOTcHf7J/v4ki3YnNMNXsMOVd4/Yi/yKkWMLl0koRjnhI0+NAJ3wlIt0yzhOjaW8LTYU7EtlcgFw0I9VGMR6ycsy52VM9V1Xkg64iPgQwmdcfZRmaHKNhdQG7jesFwWrXP+13BZkFfYYVSq9fP28lWjGKNaPIDXbCgKS+3JoyldjBOZK27gWpkrFdiEKIHJn4AHJKlZJXF6kcFHkMX/Ilw3kPwY7NKNoQWs8gRDB+t/bYe7J/EtVAh58jqidye/RZ8mT5omYM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR01MB7370.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(52116005)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmZXbWp6SEZaTUloczVUbFk2QTVYZmc5Si9yMWcya1J1Y0ljQ0krY09iUDJH?=
 =?utf-8?B?ciswc0hZK1V0eHpyTjBKVnExWjI5WnlkT3h4T2t3M0Y4eXJoV3llTmljaU5C?=
 =?utf-8?B?T2lYNWdIS3puSm5QbnRHTFgwRnVEQ0E4Y0sraHMxOEovNStGcnVhQjBYbmlr?=
 =?utf-8?B?TjNhNmhSaTdUQUk4cGVWd2QwZnZmNnkrZHF0V1luNTJJeDZ3SkliNjJRbEVE?=
 =?utf-8?B?WFRvSWRwNzJZbFVFRkRxemlsenU5RlU4RFlGZ0JKRTVlcUhDWnp2b3dydWxO?=
 =?utf-8?B?WjBZTTNkc1V5U1hVYXBIVWw0RmNyck1GVkRSL2N4b2tHUWQ1dDNaOGdoTHNj?=
 =?utf-8?B?NTVxU1N0MUMvTFIxMlVHYjQ4QTFXZXRhTDdGREV5TCttZjBGZUh5K3RKZkdY?=
 =?utf-8?B?emhPY2FCaWlPV3FlMTRzQnJDQkFvdlNna2VPOGZGaFpPMXUvSHVMYnptV3Ay?=
 =?utf-8?B?cDFHVVJMdjMwdDhTc0hIVFFxcHY5U3dPdmdLNENnM29vMUlsaVdsaUkzSlM5?=
 =?utf-8?B?MTRPSC8rcmlDVWN3dEFQL3VnR25sdkkwdE80c0tyWDdXMkgzUDkyRzdsZEhv?=
 =?utf-8?B?VkoyNXVvMm11WnRBRVJCUklYcThmUWdWMjIyemxWVXgrVU5mcTNLTlJVWGM2?=
 =?utf-8?B?NTBxayswSjBNSlZrdHBEZWg0VVZ4U0RQdk96c1hQTFlPWUlSdTFKSHVzbkVh?=
 =?utf-8?B?bTNaWkQrY1ZIeTAvOE1seUJWcS9IeU9WRlpKZyt3VHJXTGhMVWRmUm9YUkor?=
 =?utf-8?B?ZDVTLzRwTUVkZDgvWlc4dUlYK3Y2Qzhrc3NoZG01QnN6ZTdZbG9jOERlUzRP?=
 =?utf-8?B?YkU1ZzN1N2hGN0duOFVNUGdZU2VWQWZvc0NvSytGdFM2WXJwcWZEdS94YzdH?=
 =?utf-8?B?MC8xdnZSd2Vva0FWOW5JOEoyWGl4WFQxMnd1SlNESzZwY2dIWE9Va1NCZUFH?=
 =?utf-8?B?MHpKaUhMU1VNazQrZEFSbUhqNSszVHUzQ0sxY0NOU3JVVHZOSEZKaWlzeXFJ?=
 =?utf-8?B?QVhadjFGSlBQcVNLazdMZy9vVUs5Rm8rOUVrVmJqRTd3eENBa3ZCWG5WUWhq?=
 =?utf-8?B?TmJtTXQrbFI5S0pCSk0wQld0V2JzLzFlTUh0RG1GRzVlcVdlUm15cTVXTXlQ?=
 =?utf-8?B?Z21ueWRoK005M2dlcmJTWGNTd2NqaGV2b0ZLMHVvUENhanZiVUJFeGVRRGR3?=
 =?utf-8?B?R2tSdlJuSGIvL1l3QUQ0aGxSUFlYQ05GQUZ5OHJRUzhDK3lzc0g5OGh3NUhm?=
 =?utf-8?B?bUFOOFArOVVVdDRwSjNvNWhZNXdZYTJYYno5K2VQd0E5RWNPUHZEN3FXT3Jx?=
 =?utf-8?B?MTZZSWJvRm51Q1RIZkhjaVZ6a0daZ0NEU1VBb0NVUmZqc2ozV01kOHNrdjh3?=
 =?utf-8?B?WnQ3VjZBZHhRUFhRcmxma1ZSTFdaNkIzMFduK29yUXhOaDg1dmVCVGRuMEQv?=
 =?utf-8?B?T3FJYlMxQis4VFFDbEFzUjVFRDFmL2VVWXZwRjFQMWZzTUdMWExiS0lOTzRF?=
 =?utf-8?B?NjlEWCtlNGVESnllLys4aWs4VjJTaDlVVCtjRWZaalAzMjNVRHpUQkFXYTNQ?=
 =?utf-8?B?Qml5MmtXZmFOSkZ3V1V0SkV5L3ZZcUpScTNrUUJ6TUZLSTVDZmRXYStIa0lH?=
 =?utf-8?B?WGZudm1GL29OOHhoL0NmK05aVHpOM3pCNy9FVXlTYWlmVENmdDJNYnNXbUpv?=
 =?utf-8?B?WnByak9KVXFEQy9oUmJCV3hrRWRlUXBMMzhnTXdnbnpmZFF1Z0p3UEh6Vngw?=
 =?utf-8?B?MUViRHBqTWVhbVE5dFhSR1dwNHhndml2UkRkam5UR1AxV0lxZmdCU0xSb25T?=
 =?utf-8?B?RERlczUvM2dxanYwYTVPejY4Q0RzR0xyNUY1TDV6a0ZTQzdYTDQ1NitJNGVC?=
 =?utf-8?B?aUhPTU52QUNFRy9YZEszajlvY29pTXNhNjREQWNGYTVDc0dDSHhvTEkwdUxS?=
 =?utf-8?B?WjdVcVI5WHVxUWdhN2xESlIzZTBpQ29sRklMVlBHUHlENGpNQW5qaHoxWjh3?=
 =?utf-8?B?WjlRdENKS3RaNjd3VHNscHFDbGVmUGhDaXBlWFRKWGZmMDd0T3JvVHBwQUtR?=
 =?utf-8?B?bzRJdWJxZC9VYVF6N3FwN3NPMXdNRllJS0dybm9xUE9NUmw0TzV4ZmNXeHJT?=
 =?utf-8?B?M1lUdlB5b2hCdU4rSzFGbk1lOTczS0JRVTkrS3lWaG9kdldudWZDRTVmOU1E?=
 =?utf-8?Q?SKHFAVRB9PwXQgBx7KaAV7Y=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8870d1-fdb7-48b4-05c9-08dc4f809286
X-MS-Exchange-CrossTenant-AuthSource: CO1PR01MB7370.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 23:41:21.3307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bs6aT1qO1aA2smAkxHbD/Brb+wOXHYzhcfwd3/nSWNmwBJqwp25a+usPaXY52R8dOJZ1hOr74SeQh4sCaLQmGT9t3G71p9J80GsAOZqQFtr3cb7AslMRIu8pNxkVp2VQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8180

> +static int __init ras2_acpi_init(void)
> +{
> +	u8 count;
> +	acpi_status status;
> +	acpi_size ras2_size;
> +	int pcc_subspace_idx;
> +	struct platform_device *pdev;
> +	struct acpi_table_ras2 *pRas2Table;
> +	struct acpi_ras2_pcc_desc *pcc_desc_list;
> +	struct platform_device **pdev_list = NULL;
> +	struct acpi_table_header *pAcpiTable = NULL;
> +
> +	status = acpi_get_table("RAS2", 0, &pAcpiTable);
> +	if (ACPI_FAILURE(status) || !pAcpiTable) {
> +		pr_err("ACPI RAS2 driver failed to initialize, get table failed\n");
> +		return RAS2_FAILURE;
> +	}
> +
> +	ras2_size = pAcpiTable->length;
> +	if (ras2_size < sizeof(struct acpi_table_ras2)) {
> +		pr_err("ACPI RAS2 table present but broken (too short #1)\n");
> +		goto free_ras2_table;
> +	}
> +
> +	pRas2Table = (struct acpi_table_ras2 *)pAcpiTable;
> +
> +	if (pRas2Table->num_pcc_descs <= 0) {
> +		pr_err("ACPI RAS2 table does not contain PCC descriptors\n");
> +		goto free_ras2_table;
> +	}
> +
> +	pdev_list = kzalloc((pRas2Table->num_pcc_descs * sizeof(struct platform_device *)),
> +			     GFP_KERNEL);
> +	if (!pdev_list)
> +		goto free_ras2_table;
> +
> +	pcc_desc_list = (struct acpi_ras2_pcc_desc *)
> +				((void *)pRas2Table + sizeof(struct acpi_table_ras2));
> +	count = 0;
> +	while (count < pRas2Table->num_pcc_descs) {
> +		if (pcc_desc_list->feature_type == RAS2_FEATURE_TYPE_MEMORY) {
> +			pcc_subspace_idx = pcc_desc_list->channel_id;
> +			/* Add the platform device and bind ras2 memory driver */
> +			pdev = ras2_add_platform_device("ras2", &pcc_subspace_idx,
> +							sizeof(pcc_subspace_idx));
> +			if (!pdev)
> +				goto free_ras2_pdev;
> +			pdev_list[count] = pdev;
> +		}
> +		count++;
> +		pcc_desc_list = pcc_desc_list + sizeof(struct acpi_ras2_pcc_desc);

This line needs to be:
pcc_desc_list = pcc_desc_list + 1
because pcc_desc_list is a type larger than a byte.
This bug will crash the module when num_pcc_descs
is greater than 1

> +	}
> +
> +	acpi_put_table(pAcpiTable);
> +	return RAS2_SUCCESS;
> +
> +free_ras2_pdev:
> +	count = 0;
> +	while (count < pRas2Table->num_pcc_descs) {
> +		if (pcc_desc_list->feature_type ==
> +				RAS2_FEATURE_TYPE_MEMORY)
> +			platform_device_put(pdev_list[count++]);
> +	}
> +	kfree(pdev_list);
> +
> +free_ras2_table:
> +	acpi_put_table(pAcpiTable);
> +	return RAS2_FAILURE;
> +}







