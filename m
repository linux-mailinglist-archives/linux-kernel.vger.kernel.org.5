Return-Path: <linux-kernel+bounces-147217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A59A8A7117
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B412DB21D6F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994EB131BB9;
	Tue, 16 Apr 2024 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hhDylQkD"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D9913173F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284265; cv=fail; b=b5a/uVEew7PkicY8Muewez2Wgt5wY8shRiNm6gLPGt8VXJYZ+jE7f1dbjxK8hZJg7otQvHtcMYvKSpWZ/x5roC7/Q6GvlFkxxXCqJH7EPY/sTscanJK6TpKOr5eCVLzkpN2KFxC7tiLBM0/P4yty3RVKMQvGqwpyRf9qwRISJZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284265; c=relaxed/simple;
	bh=Od9L+I+4nR/RorJhpqxRxteGKOyvLUmF4MEPfOSaYzg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q1mpelSQdcY0UEsx6PgnTqL2shFUQuZZJrDCX6YtFWK7HNAX2Ay+89hzwomw/RDADxjfqG/h4iJHjH0PZnBoIdZPlz/u0IH1ziEdaLJXqCm/BCsYnkvr+k9it3jzz8LgiwgdP3nXgooLwz0P1m77wcLXo7s9l7hLMzPLcvrfT94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hhDylQkD; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbAyjbLugWVSSidV09i+4fEHkzoh2FXaIYd/3PsnIvsGlpBBUjTZfB+5AyGHWWtieEEZ6qoxhykG2UIBFJN7jJfNc6awlC3QfGO0ccsrUg/1bA9GIc0y7sIGJLJy+0OiNg7NfIoE3goYXgg/wmmEzlMcTmX7AgSDCadK0XM9DSHKaaspGPjSixK5LQmHGSkllWHEJCbY2gUcrSDqdatrtGDTQBILUGKtYNQrz0dDS4Tj217cEbjklQI1nlBOuZrSExKcyYR+uiJDhlRw9DnepCEKgy8RYMVX2FP2toAPuGqRH1/CVKhXnYpyPAgdrKVJajq+6KgAXogJVDvU4P2M8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tM1tEwro2rjm4FGZZZCeUi509ZVthQoM1tWA6AA7Sbo=;
 b=l9cn6tPtnbkoJj8kYsvKaSHWU26YhDCHK7oOJJHexv+T0awLa1axSHXOoklbyfGOPh2yvmE/VK/4Dv24O4QGsvbcBLqEyMojCYDpX+/hm/m0zEwzoxHWPi4Tn4xTILR1tQmbW8T1kfDAJpII2/YTP7ZFGT2i2qGcacah2UkSTnx759T6C+C35AYZjuqUgAEUKD3s2E0U9wqy/yOu+VDGV3jwJN6bfhKJRlyQS89E4PvknNtA5BW820AO5V/VdTyudzVzHBhiJ6PO6XmJeQtvM09snvBiaLTOtS6TDxlD6OgezVtPay5Kgrvt40A7YFPfENP1l3JW5nsdEgPxE3uDKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tM1tEwro2rjm4FGZZZCeUi509ZVthQoM1tWA6AA7Sbo=;
 b=hhDylQkDH7+uZc1J7PU2tcSsfkre+y+ziye8Y6ZlRMpHw7amVWRDX2mY0q+ABb1XvyIyPN5fORpwC1AJhEWyunlAGQvpQT9etKAkRGWMIO6MjPxRZ9fEWXYKbvRAasdcL5W/eE8eV9L/vCG5Vj/pmIfFa+wXTfHQhQldYlaICzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Tue, 16 Apr 2024 16:17:41 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 16:17:41 +0000
Message-ID: <2be81e12-9c62-7fa0-5f3c-ab195406b6b6@amd.com>
Date: Tue, 16 Apr 2024 11:17:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 10/14] configfs-tsm: Allow the privlevel_floor
 attribute to be updated
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Michael Roth <michael.roth@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <bb088b1409283cd323515138feda224759a247ec.1711405593.git.thomas.lendacky@amd.com>
 <661e04cd345af_4d56129468@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <061802e1-7c95-f1f0-b462-3aca27583d76@amd.com>
 <661ea007d1844_4d5612948c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <661ea007d1844_4d5612948c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:806:130::9) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc44203-06aa-42d5-92a0-08dc5e30bdad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yZEmqPdcQkofu8qbO8LzXNaQ8xCjIaaWgtX25aAqe9kVPI1UWKMsxIOpA7pSfQ28BAxs69mmGYw8Xu0sqdslko5nlcuvCqc+9zvAxxyWE2/AM3UI3inXNyvutr3IryvgkGt8T1gZHgZoFriE775qyDQZfNpvQA2D4vtjcVrAE0r3KIg+wtBnHO9pN+ZZVPgFfOdiL3h4sjq8OZka37lxZ18bCZMaWnWKJULxRe1jSBPgExs6YN7xTuKObizbGqvCJJEOG18o8ZgFasS3KXgcNihpMk6tIbTAAp8Rk55sPVJWe7qYgb6N79juFnTNnHtThuKIT2XJQYTF4sCWSebw49RNCjWklljDvSUnK3U9Ny5zsP17trUWVoVgUnh3cNIQ/vxUC9HDtaIcEfPMxOlv8bxtO4FlDX8ytFxPQRDxHZ8f3jc3t5HFhfNY49UuJ1hMhZcUj9JAReUT8WJuC6gp47rTfijLLnFXMzUJ34+jSP/g9YmEbb8Jh0kYmA0Ny4FTJzIHUjPLzg1h2VWLExaEKb364xBloTy1ehFCGlOj2k6sx0LSSWkDYozJM6FKrRtTwq7knjVys+DgmNNeGXctiACsidVF4jfixjCOGLyjxhpmnlu++g4VuzIuN+fPg0HQWrvVGS/CaaFdYOAI7NQAcrxSPnOAftvspk2Zz0I0O/4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjVQQ1NZdXRJMVhycWVuRGh0dDZBZDhGYnJUWTJrSmdvVlB0MDFtUU00ZGM5?=
 =?utf-8?B?ZzEwaGUyYkVUMVNyN1dIL24vR29YdUlHajNLU3lLSzl0cDZpb2JlZ2dGR1Fo?=
 =?utf-8?B?VWh1R0dTZDRMOW1oUVNEOU9lZXdHbWJuUUw1WFF3ZmFhanpiYkJBUXVOdTFM?=
 =?utf-8?B?ZnJvaGs5Z1NFdXg1RzRnbEVEUkFGWGlvM0w1RDE0MVJUNFJIL1VWbmpZaUgr?=
 =?utf-8?B?TW1CV0lNdVh6M0VMcWs2dXBWSzBZRmtFa3hWeVdZU3JSWFVtZFd1Yzh0eUtj?=
 =?utf-8?B?Qk4zN1R1Wmx0cDRYOU1RdG54Y0xtb1ZaZ3FWN2FIQnNRZFVlVmN5dXE0WjVh?=
 =?utf-8?B?MkF4UUFCR0lIQy9YZnJXbUNRZmNSZVI5Znc3Qm5SNjQ2aVRreDVueTUxK1VD?=
 =?utf-8?B?em9IMHcxWXl1UUpoNkxtYjJGazFrQzZ6UWlBZFhQL1V5U3B1cmsraVNTcXk1?=
 =?utf-8?B?ZGVWalI4N3hzZmhuSERmNG42WUMwUWhoc3FxK2V3UHMyY3lSUDFVZ0FIM0Js?=
 =?utf-8?B?emQycE8wbU1RTkNydGQzRXZONFVXdXFnTEtVTlY3UTdabHlMQUsxUFplbXgv?=
 =?utf-8?B?UWxXemp1YTNzM3E2MVZKdDVrRUErdjZZWFBHdGZvc2VhRWcydjRzNFkvL3Zl?=
 =?utf-8?B?bU13bVpBbStabWhGQ3FzUVdBYVZCeFdSeXVRS3V2WFdQUWRoK3FoZnFvdlNj?=
 =?utf-8?B?L3FZbTF5bmRTMldvOVM0SmZoVXdPV1dqR0FJS09tTUdneG5rd3VZZkVkdlpD?=
 =?utf-8?B?QjZDZUhML29qZk5KMjJTNTlieW5wZ2c0eEdqY3hHY1ZLU21Ea3JpbisvUC9s?=
 =?utf-8?B?S0pGcWRVVHVLNmxhNHRReGt3SHp2MkpUY2VTb3RKSWFONzNDeS9ZbkhDRWV6?=
 =?utf-8?B?cTVXRWVwVVRRcmRpVnJHNENvd25MWDNyamdaSlRseHc2MWFrUmlvU0dPenJO?=
 =?utf-8?B?RnFNRDVvY0w3R0dpcUVBSDg1MU1SblkwMVZQd2tvSnFUby9jVFBzVmNQOEto?=
 =?utf-8?B?TUhBZ0Fhb3R6eUxIUFlsSTZNUFFlMXNvaWN2QmJ5RU9GK3hiRU1zaE42Rmh0?=
 =?utf-8?B?aWh5VkVla2dsaU5GUk9sWUNDNjI0OEZkT2kxQXR4bW1IbHpPZmVTVzloOVpu?=
 =?utf-8?B?d1JMSGJWZzN1OGxsWW5NWWV4Vk41SnVqczBqV3lBbkNQUDA2eDR1SEtEQ0h6?=
 =?utf-8?B?VEFsd3RpY2ZPUWw0NHQrY25naFQxU1VBSkJEcGQ0NUdtN0E5SlF6ZkUrSXZB?=
 =?utf-8?B?YkVjSHdxY1NFWk9xMDhWTHVtd2E1SjJqVktaMmVJcmQ5dlFOVDA3aTRhaHow?=
 =?utf-8?B?WEcyS21saUxmREtmQTdKMmRmWnczUGxjdHNDQ0FNdmNUSkJsZ0w4RFU5VTRX?=
 =?utf-8?B?Y2JYNERBWW5iQXd0NTRzdHFSNWdWSE1EZXlSMW5XbGRjRlhXbjlQRWJUQjZa?=
 =?utf-8?B?YnJNTDZnOXh2bGg2YkRpcE5vVXIyeWJlRHhLSXFGaTdjOVVHMlJXMXFYY3Bj?=
 =?utf-8?B?TGhVVExzVmJ3RSswbC80LzZ5Mmc3ZUlJK3ZUVXlHelk2SThpSlc1Y0tDUk8z?=
 =?utf-8?B?NHUrYTRNQnBCdWExeG82MDNsVlVvcTFraytVdlIvOWRTdUxtMWtQWVhZOENu?=
 =?utf-8?B?QWRrN2dNN0U1ZmZDS1RpdTVGWXhhcFdocHltQTV6MGxiaXN2U3BYb1pXTWx1?=
 =?utf-8?B?OEVuVFRKd3JLd1hSR1MySVozL1h3ZCt2aWs0VCtqVytXN3huOEk4OEVLMk0r?=
 =?utf-8?B?Y0E5enU0aE82aEJ1MDE1dmtzSGJXRms3QWU2S0dhVGk3V2pPMEFQOGNNV3N3?=
 =?utf-8?B?RlU3MlhLNExBOGRMY1BEQ2RrTTBRMkdtZTF0TXh3cExjWmdIN3RnRWtLS2JD?=
 =?utf-8?B?dUtTZWZVbHpjczZ0THNWOG5HTURzYWkrT1lVK0pQSGZzbExjTWpNUUdYZ2pI?=
 =?utf-8?B?Ylh2aE1OWkh2K0d0WlJlN1REMGlmc200NHNvbW9DdE9wZTdVUEhzYUNteEdP?=
 =?utf-8?B?dUdJL2kvWkM3WmR0WWUvRGFZOERDSzNKY1dqTXJUK29uVFRkditUTFd4WmNw?=
 =?utf-8?B?MmRWR0VGL3RSUkVEK3V5ZnV1RHUydEFaak81RzhnTnBsMTdqeGpvendabDF3?=
 =?utf-8?Q?G0/YAlebHa4gtcyyDdHF7AsiO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc44203-06aa-42d5-92a0-08dc5e30bdad
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 16:17:41.5014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtcILDQwWjvPWbe8oWK4dq2DnpimzwmAEDt5pP881JAEjdHO3uVHob0C7cxOYc6Mw8QZtkYQHP+/Zbno/yFI6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372

On 4/16/24 10:57, Dan Williams wrote:
> Tom Lendacky wrote:
>> On 4/15/24 23:55, Dan Williams wrote:
>>> Tom Lendacky wrote:
>>>> With the introduction of an SVSM, Linux will be running at a non-zero
>>>> VMPL. Any request for an attestation report at a higher priviledge VMPL
>>>> than what Linux is currently running will result in an error. Allow for
>>>> the privlevel_floor attribute to be updated dynamically so that the
>>>> attribute may be set dynamically.
>>>>
>>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>>>> ---
>>>>    drivers/virt/coco/sev-guest/sev-guest.c | 5 ++++-
>>>>    include/linux/tsm.h                     | 2 +-
>>>>    2 files changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
>>>> index 1ff897913bf4..bba6531cb606 100644
>>>> --- a/drivers/virt/coco/sev-guest/sev-guest.c
>>>> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
>>>> @@ -885,7 +885,7 @@ static int sev_report_new(struct tsm_report *report, void *data)
>>>>    	return 0;
>>>>    }
>>>>    
>>>> -static const struct tsm_ops sev_tsm_ops = {
>>>> +static struct tsm_ops sev_tsm_ops = {
>>>>    	.name = KBUILD_MODNAME,
>>>>    	.report_new = sev_report_new,
>>>>    };
>>>> @@ -972,6 +972,9 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>>>>    	snp_dev->input.resp_gpa = __pa(snp_dev->response);
>>>>    	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
>>>>    
>>>> +	/* Set the privlevel_floor attribute based on the current VMPL */
>>>> +	sev_tsm_ops.privlevel_floor = snp_get_vmpl();
>>>
>>> Why is this not vmpck_id?
>>
>> Good catch, this probably should be pulled out separately and submitted
>> as a Fixes: against the current support. If you think it's important
>> enough, I can do that and put this at the beginning of the series. Or I
>> can just modify this to use the vmpck_id value. Any preference?
> 
> I dunno, you tell me. What breaks if privlevel_floor is mismatched vs
> vmpl and/or vmpck_id? If it warrants a "Fixes:" it should probably be
> broken out.
> 
> However, I *guess* it is just adding some sanity checking precision to
> userspace requests and makes some input validation not catch errors when
> userspace tries to generate reports from the wrong level, right? I.e.
> privlevel_floor may be lower than expected, but userspace should not be
> depending on that since the report generation will fail.

Yeah, it just results in a different type of error. If the VMPL 
specified by the user is numerically lower than the vmpck_id, then the 
request will fail with a specific return code value. With the change to 
privlevel_floor to use vmpck_id, then you would just get the error that 
much sooner when trying to set a value that is lower than the floor.

Since I don't think the vmpck_id module parameter is a common case 
today, let's just leave that change in this patch.

Thanks,
Tom

