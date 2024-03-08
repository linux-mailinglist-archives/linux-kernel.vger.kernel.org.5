Return-Path: <linux-kernel+bounces-97532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC10876B8C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52E67B21DE0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4025B5D9;
	Fri,  8 Mar 2024 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WsLn76h4"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99755A7B8;
	Fri,  8 Mar 2024 20:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709928407; cv=fail; b=sZrhRuGlxRM5bDMiWj8wbEAew0DqAWln4BvLI8vDSiqpIAO3ZRtkKke0YSBRJ04QGQzPd2Ntx7KmDnOvBRqhMq1UYGjthDqF2P2H55utFgq5DxhZI+ZRUdDuyHYg5povGbiGTbMB0nsvtw6evXnqUKlkGsWjBJYkWvcD9Ax42lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709928407; c=relaxed/simple;
	bh=ygjCVVu95YUlKx7WCUKAknaQROXvrG5DqPzqqtfllgw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hjsTvOYcGH0P9gooQUIzLEEGYYCFn/wd9EajtOeMXr6NuB1tSrHacjDDhu6Esvy5e2gQ+vzaaM9VKP52z9KEztcbfJfKGijzapanO2219ZW+FlUIVGb775dvfYuGDsba0EoF6h02CjQ6HpR7PGywhZRrrb/ETIAjBM5x4oqZKc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WsLn76h4; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipoBXnpokfsz61A37kWdIGaeIr5RhIo15o9ywCEfk/KJquAN6/A6qNZza//xRf+ZbI3PFAGeGSpGcvavQMHNmVa7PvsNogyLovh1zHJElB1AV911B/RLWU64YYH3tGnu6nvaectJCtstvybbKZ9CeR445SrmTP9EQr4z/ZKxmSekmp6nB+XigNFoCVzjRqPBgT4cLKK+RIhN5nhnySGOKFJYO0n5qhxJkwBa7LFOz3/LKSJdP1KgZhGDY5Ue/18BnKWNZPF5NA/b6YDK9h+MJWCEbqwPd+djHKhTV7gTZa7HeJsTCu1fwVeegfqXd0VSPMG1KdUuoI/ngIZwD6ZIUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJDuTzwd1Pm2r/fQKM4UhgUFQfc0EMBEHt++qimQQd0=;
 b=SFBQkAyMVxTwL+cwa6qbJqkHYjiy4Z9pff0UFBrq3HBoJAOlRORcwBtiVZOaBKVaD3CInJPMpFiMMKFlh+VriSpdLOG10gsqQUChfTdQ54SkKQ+y5Sk2nQE+GxzOdDr2f2FnFlxDSdz6kdm8CA6MhEDX3aWlmJRJWC9MqIrGDF2niWrG37ynpiZ2t0vmD2IAMwo50jxNSzzO4eX/GSC6xKqZc8Ljc4irecYQZNzbt0tmXX4SYTNY8DViVW7Vt8cXk0z9yW5V73CVIy2TM+yirGW5ghRcigOObkXuDxLALrkRUXuYNXokD5ykvmgP7ITjUBM6jn9RsX+UH7CT+gyvkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJDuTzwd1Pm2r/fQKM4UhgUFQfc0EMBEHt++qimQQd0=;
 b=WsLn76h46gsL8xXyDnV1GSQxBCI5F5KPzk/lBvZAHX/JrJWDs0gZ3EE40ay2q5CkywDLgDsiNns9yKUEsp0nNiwN4x+YPMgJRrxglDZ4/FKU42Y0D3e1dBpdeDAKfEdVJD2mFqdh189lsIO9JLBp730y91r2lOZ57urgoF694UA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 20:06:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dcf1:946c:3879:5765]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dcf1:946c:3879:5765%4]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 20:06:40 +0000
Message-ID: <9ee40386-7367-4219-9833-54bffc173aa0@amd.com>
Date: Fri, 8 Mar 2024 14:06:38 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] platform/x86: wmi: Support reading/writing 16 bit
 EC values
Content-Language: en-US
To: Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240308195027.7640-1-W_Armin@gmx.de>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240308195027.7640-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:806:21::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b3b26e8-9bef-423e-207f-08dc3fab44b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jMfhdROIuO/Ypcppjq8VTRVOcM4RS1F54JCKapjtAJhxeBkdY7fJ1rbvBjPMXplFLlxvUckfJcfUr1BCOnya0N0jZrQ5dJ8+P/ig28oPNqQg4pm3NcXPODZgy5JHGo4T0k7TBct78YCCgDD7WSo9zrIkoPJvCik1ejDYPNfiW89HxyzZtET715TVU1NavqVDM/GpeBda7Q+mlkw3DsZic0jPhfy9fd8yHHSHPZeMbiM0L9A9B95IDtUCM+mwTUu/H8881l0Uq0elqlKsLJ6+VqfENthsutT4a/oL4gNp3XGIKnsyXs6DWpCuqyaOSGhitgA4uIPO/MBEtgis7p2eGxeojbsQ7jf3AgRbXoQkE6S25O7ZxTpdXsCgY8IIpGXsaWpjnRFgmP8vOiOQ40HsouCLkLY5H1kNKISqRllvNHtRRqbIl7Du19bNeu9qjGaKS33ZOm2QilSoF/pof/uLnjO4wGYZ9/o8FkZ7H5B8vY8U1qYnKjfMhYJs65sh/4lFtDLah8r5wclhsJG/887TCECN21Jf6RWxtcskLd5CwL1F4Skqxy7OaM/bYaPIITsKTDu+F0FmiX0DkAphUrsa5v2OwCge3eL8/k+WBL5EIXS55rzSsDpcVjSzi+YH7Vd9ZYYf67b11hwNfh1LNcXe0Y80l4KDKgAFbml/MqAKt1Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWxtT0p0RDZNdFZBdDNNYWVVWThaZGxnR3FvL0pxcmY3WjRYam9Pb21qS0F3?=
 =?utf-8?B?VHZJbEJOcExvbHl5SlFpSFdLVUZaaHZjZndva1YxYmozT1NqZTFvay9mT282?=
 =?utf-8?B?dUJGS3ZxN3crU2pweDBHbE50NXcydkRCanU5MFpWZlUxazZaZDArRU1SNkl5?=
 =?utf-8?B?eVN5Uis1TlhRKzMyeCtjaTM0M0djUzhNVEJUM1ZmS0EzWVhjVlYvWFVJQnlK?=
 =?utf-8?B?OER3RUNObzkxOXQyb0ZvUlBBT1JMYlhDcFNSTzJrdUszQmRKbS80SE5iSFh6?=
 =?utf-8?B?OUg0cjB2YVNHS0xWMVZaK3VUb2xPU1kxbjBySGJSUDRIcVhDbVN5ZGVMQzdO?=
 =?utf-8?B?L21OTTRYMWFSNFdzejNqVUZ3bTVMQno4Y2dyNGZVR1doRTRuU2psTGlPTUo0?=
 =?utf-8?B?TjhxWXRmYm5BbHd6SGlXbTA0OSsvSzlOK0IzSWMrZUpFcHB6Y2VHVk1Ba1Za?=
 =?utf-8?B?L0xVN2VwZEtJZFJtTjlUb29OWnlzOFdjRnZvQlV6aDhWLzRUVUVYSEtCcXMy?=
 =?utf-8?B?MUszejNrRmRNTVFJbktRUVJvdW5La3pBeTIvN0MyVXYvZ0dhVjJnQXN3Z3Nl?=
 =?utf-8?B?Y3YwYjZWSlM0MlZJYm5yU3QrbTNpQmVuRE04NjVxL0NUUnV2ODVreEZ6MVFG?=
 =?utf-8?B?YUNZRGVEZmR1S2QzWUMvNTFkVzFjbmdzeGVmK0pldktlbk1xbDhWZ3NWWDFp?=
 =?utf-8?B?akxrMnRraEVvWGRvUStzWEVNYkxTdkx6QTRoVWtORGRTSm56bjZnN2tvcXRV?=
 =?utf-8?B?SVRBN3FUbjNZNE5qNlhYa0wzcUtqV1hzODlyVlNvU2NnektIMEh6ZFg3bTFR?=
 =?utf-8?B?aGV6Zm9PbklMT1BHd2N4Qml1TnhSaUFuQTR2Mjl3Vm5saXhHQWJhQllreHdS?=
 =?utf-8?B?c2s5aFhyYWlzT2tjK1BPQ1V6dUl4SVJ0bUk3a0RCVDVPNkdVeXJCdmNmMnlM?=
 =?utf-8?B?WFA3RjBBSTRWTndxZ0VRMDJ3Zk9CaXNXQTdSaFBRSmxtZEhEcHZqaHBJNzVL?=
 =?utf-8?B?bGZULy8xbU5wYjNGaFVTSzIwSy85UFkxNlhuSDNCUFdCcjVCMmNzYjlYdWZX?=
 =?utf-8?B?b2JkRWhWMzc2WWpSbzFZSFJocVhCZ3VLSTlrWVZXczhJcHh1UkZQQmJzTXFP?=
 =?utf-8?B?bjMrRVNOeWFoQXB5VTlSYmhyWGxVZXpKVU1vSW1VYXhBZ2Q5ZXIrdU03eUxI?=
 =?utf-8?B?RXhHb2V5LzNVMU04YUJaelBvR0xEMjllNElJdW5Ub0dyUUhyNG5vNFdnZCs2?=
 =?utf-8?B?OHA4bFpEUXZ4QkYreGlRMzRjamg3K0FpbWpzTWhVd0FVM1ZoNVYxbExseHVP?=
 =?utf-8?B?Rm9xMjBML1o3Rlhyc1dtTElLT0RSL3FEUlhNaEp4YlAwM2EzWFdjSnU3U2lN?=
 =?utf-8?B?Y2lZVFg0cHY3azdvTzk2QXNHd2c4Nm5YL09rVkk0M2hpV0lFMTlFcWtSeXhj?=
 =?utf-8?B?L0pjaVZnK3k0NmdrSG9hMXROeGdTZHlJUnRMeWlKazh1di9lZUg4WHZQRGQy?=
 =?utf-8?B?QW9UVEdQRXRRS2NRTzgybFVwcGF5NUV3VWt3emFLOFdyaWh6eXNvZ0tRRG9U?=
 =?utf-8?B?ZzlBVWUyU0tIVDBEUWhPbmY5YmZTdThIblFsMmxJSmZLd1orcDhNOHozalJ4?=
 =?utf-8?B?ZUxSbzdqVTAveEI1bURUN3BUUTI0elZsTmxuQ25HeU1sekZPby8yNDQ5VTBn?=
 =?utf-8?B?OTVkUENJa3ZBTTl2ZUNOeVB1N1JOdEQvTmZidlV6SENYTVhqSkE5SXVOM3Qz?=
 =?utf-8?B?UHV1bzVKcTJpaFB6SEtPNUN4VUlCMENHV0dUNHMrdEoyTjd0N0Y1cEtHNEd4?=
 =?utf-8?B?cVc2ZTBCUS9nQkRROS9waHJGRDdTa3NCVjI5d3QyWFQySGxJUmVMUGVvTXNl?=
 =?utf-8?B?OWt6RWdDNkw3cXVHUkgyMUxLWEpObmVMT3d3TG5pMFdXOTNpSlBWN3VmeHl1?=
 =?utf-8?B?b3d1YkErMUNuTjdkb1NwNlhRUXN5QTFBWlhmRzBYa0xPNU8rWkJqYmsvSlJq?=
 =?utf-8?B?djF2dTZIRit6VnE3K1dLRnQ5OWc1WmVoMUM4OHpoTzZMbUNtTDhXRy9hWCtq?=
 =?utf-8?B?RThIZnNjSDJuSmQ0Mkw1K3p0cUc2R1htWE1JZzNNTVFLWkxLMDlWdFpicmNR?=
 =?utf-8?Q?Zlx0wshzNxACEjzw3UYSiRVJc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3b26e8-9bef-423e-207f-08dc3fab44b3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 20:06:40.5541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cWLSYt7tJi6mZ1aJ/l9jnxldfAXV+gFeklZRvi/oWP0V/FgmUykV/LlgNPdSmLMvCQ9/SWjk7toY6VLKZblbwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7095

On 3/8/2024 13:50, Armin Wolf wrote:
> The ACPI EC address space handler currently only supports
> reading/writing 8 bit values. Some firmware implementations however
> want to access for example 16 bit values, which is prefectly legal
> according to the ACPI spec.
> 
> Add support for reading/writing such values.
> 
> Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> Chnages since v2:
> - fix address overflow check
> 
> Changes since v1:
> - use BITS_PER_BYTE
> - validate that number of bytes to read/write does not overflow the
>    address
> ---
>   drivers/platform/x86/wmi.c | 47 ++++++++++++++++++++++++++++++--------
>   1 file changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 1920e115da89..e6cab1cf611a 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1153,6 +1153,32 @@ static int parse_wdg(struct device *wmi_bus_dev, struct platform_device *pdev)
>   	return 0;
>   }
> 
> +static int ec_read_multiple(u8 address, u8 *buffer, size_t bytes)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < bytes; i++) {

To make sure that you're comparing against the same size data you should 
either i "size_t" instead of "int".

> +		ret = ec_read(address + i, &buffer[i]);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ec_write_multiple(u8 address, u8 *buffer, size_t bytes)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < bytes; i++) {

Same comment as above.

> +		ret = ec_write(address + i, buffer[i]);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   /*
>    * WMI can have EmbeddedControl access regions. In which case, we just want to
>    * hand these off to the EC driver.
> @@ -1162,27 +1188,28 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
>   			  u32 bits, u64 *value,
>   			  void *handler_context, void *region_context)
>   {
> -	int result = 0;
> -	u8 temp = 0;
> +	int bytes = bits / BITS_PER_BYTE;
> +	int ret;
> +
> +	if (!value)
> +		return AE_NULL_ENTRY;
> 
> -	if ((address > 0xFF) || !value)
> +	if (!bytes || bytes > sizeof(*value))
>   		return AE_BAD_PARAMETER;
> 
> -	if (function != ACPI_READ && function != ACPI_WRITE)
> +	if (address > U8_MAX || address + bytes - 1 > U8_MAX)
>   		return AE_BAD_PARAMETER;
> 
> -	if (bits != 8)
> +	if (function != ACPI_READ && function != ACPI_WRITE)
>   		return AE_BAD_PARAMETER;
> 
>   	if (function == ACPI_READ) {
> -		result = ec_read(address, &temp);
> -		*value = temp;
> +		ret = ec_read_multiple(address, (u8 *)value, bytes);
>   	} else {
> -		temp = 0xff & *value;
> -		result = ec_write(address, temp);
> +		ret = ec_write_multiple(address, (u8 *)value, bytes);
>   	}
> 
> -	switch (result) {
> +	switch (ret) {
>   	case -EINVAL:
>   		return AE_BAD_PARAMETER;
>   	case -ENODEV:
> --
> 2.39.2
> 
> 


