Return-Path: <linux-kernel+bounces-99196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2FA8784B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7262844B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E90481C0;
	Mon, 11 Mar 2024 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XbDt92Tl"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF5C2B9B5
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173775; cv=fail; b=eCRN7ryQa2gadf/SW0ENykkK5a0x8ogS3m+IWkvOwKmUZJCmuw+BsmFK+fRzK5KmT/aTl0CwckWkj8yrOpQ3GZgaeNuzkUsC+h8ohYIBLTWt80INA8eENA5byYyaLbjOPwbKM8IGysN/mFdydQQfJw1lj+RzlIaHeElHCG2dr6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173775; c=relaxed/simple;
	bh=KDUO2XTStZNFd/S5yKI9DNelQQo1tODPkjN5LefM6KE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b1IaLPYR8WfJV+oonyM4xClUtebA+sK+J9m8hrl+HfTcSa6bd3fBb3apnhmZ32YkHKVaWyUPLikBwKWG5sZ2iV+lKxd8vrVqUPB3GLY03pSp3SOaKWkEM3qA52ta8ZJ5/rLGFxcYuzMtAEHM3oaqUWbAYt1eXozKAZIg5DHCiZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XbDt92Tl; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IStbrlcaR3jEucxjaHXhTW7D4q2FW2QLnkejV12oqwn1HyEPEYas1TjfNCsWAOqILbbFoei5GyRGBmXtYqL+tZ8+0sPWiKeNQutdu2w4rV3n80r9qCfN+WX1MS6v39ODp0YCa4tujYykyTGW90lPLJfv8nPNQ0mOEW2W4OiereW6MxmUOUKybTaT/oEabH85Qi+XKEXolURxJfBLrrPSsVaA5V7hIOjRCj3LP0Cs1tI7oCCoHG3l8bjBtso6rYNtOGzuGvXa97Z1UnmRQwI9XV5R1ajV7wIqIC58bBN4fm92Hq51KGm1OD76+zQf2b/wElBPA1xs4WOjU9MyVO6UuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sNflOGn6fs++FtNn6RD/JqhmSDaUxy9WE+eBLL8tuc=;
 b=M7iF0lDg5wphxjLlNPSg4Ii6fl34yRf9LWzTbYmPdfobacjCoVDZmj8BxGvJRTiuaJWfH6h9DlaleXWFkNciRjajdPbV3kWegck4zHPXqhCqp01YUq6XNfKEsz0RQDj7yjOIOaIvj3WZf0IhN/rMIvgM+cNOWXhZl2r/5yRtP49yXbY+fN6ppGr2ux+IKW9lolTcrl6qtmQl7H8Bwgdy1NiCluhuBJeaT2UxpZpeMLZHxr+ot7MKG9Fs+4tvp/vuYOfqa1oFz5szQz8muMFkJNMeVCYSqgCwqT2xt7A7ASW7gFnWs3NSRndr68zR1A9kgn88AgKlhhXVr98OG9nuaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sNflOGn6fs++FtNn6RD/JqhmSDaUxy9WE+eBLL8tuc=;
 b=XbDt92TlCsrdRm9ZcEn/XXFi5ESf6q6btmPgh8onSPbcBQSdUfluTQd6LsJ2Xw7kupT1k7YOak7qOgBRX92Sqcy+jGoDidnwl9l1nVPrcwbAlkY+nv6ZoxrvgMzEM7OLKyvp3z7id4aCWfKbe4dUBhQHaGbQhL+FjRf7vd64ZoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 16:16:10 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::4c26:40af:e1fd:849e]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::4c26:40af:e1fd:849e%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 16:16:10 +0000
Message-ID: <805b863c-1631-477d-9faf-f7569a8d80e4@amd.com>
Date: Mon, 11 Mar 2024 11:16:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] x86/sev: Extend the config-fs attestation
 support for an SVSM
Content-Language: en-US
To: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1709922929.git.thomas.lendacky@amd.com>
 <a6d236e247c4a0258e5e28c7378350389997cc59.1709922929.git.thomas.lendacky@amd.com>
 <93f36ae1-35b3-4852-8b36-3277f250408e@intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <93f36ae1-35b3-4852-8b36-3277f250408e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::24) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: dc96d0fb-9450-4472-2811-08dc41e690ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xtn/AOuByk6vPIIphsB0KcGS95VsOPSLcz1YoPCX9j1lPKDlWYFv3VQvI4bECWH9lDK18W4TPs8Sfygc/WWQfQ2z86EDGCZoqAjkaYAUQM///6uS/3bl2OLMA7BxGxdr0Xvv4n1to5G0zl1vJsg9guMhIlXzVbI2PG+lgQgASIOAi7Z+uygia8BbXoeOpmz/7fix4btt0Qnxm/97mE7bwJTE4fbY3O2Y2lEPsoRFsRgA6SzCwCYbucfFvZvx4Kj9zacBWQpbb1/dgOZ//IR+W9V4dQUJrrrJwpBhiweWu2w9n+SHfX8I+QwvM6CKp+wG9hlO8earn3jRm7uJm0amBkpOTADueetl4olmqgMeqDQ/mehtgflRbsdcrJKAjB9NE8D2LOWWEt3zl3Jvs85EXxVepznrQbvLH0m+YpQDeiiMKsmmv/Me1jGJj6dCWFHae5/qGIx9+7avsl/eTU5+yyWh/MHZgtqU17CN7EOFNVC/upiSSjT2r1WAfbkPlLcsT63RA0zCoefT9bHp7owfyUMSuSbxh8X03W5tqTj+qSw6BtXPZrm6PXcqHvBpdWkuBcpoDsCPhRAVbmqc5Sx3w7lurZHYPILgFMsHGABLZ6k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWRkVkx0TVV5QnMzdlo3VGJweFVJRFlickhxZmxpcytRWkJKRVl3VytaazVZ?=
 =?utf-8?B?cEVtZzRkL0FIaHJMSGFMLy9YRG8xVzRoNzhVQ0p0blJZR1NsSFRLc200WnFt?=
 =?utf-8?B?b1ZrdVRMMFZBZUVUTWFYK05URjJibE5vNzkvMWNaOUJzZXh4ZUZBR1p1S1JB?=
 =?utf-8?B?VnlzbzBmMFBVY0hLdVdPUlVxM25zYmJtQ1p0eXFIZExoWXNiWFFVUy9GL3d0?=
 =?utf-8?B?WnIwd2xpTXBhWE1pU2VSc2xXZWRHTjJMTTg2Z1JMdWVJbm9xYXdweWsyQ25x?=
 =?utf-8?B?SnE1L09HTmVrK1RvSFJBNEdJZkJqUlpuNmhybHNCcDMrcXNya0JxZkYzUTBx?=
 =?utf-8?B?cjZnR25zV252QXFBODhYYXdiS2k5MEY1ZmpLVEdmWnVHSUZWdWZHOXVHS0Nu?=
 =?utf-8?B?STlFMHhZRkRNRitmeEVTa0tzNVpLbEhSa1NkR25sVTR1RmFMcVNac01WSGpx?=
 =?utf-8?B?NmFGN2tmVk5oQk42TytFU2ZlUDFka2RRNEM1TE51WnhoK0NmeTN5WDUzbjQ4?=
 =?utf-8?B?MEVLdVJYVTBKbERRVEJ0Q2dLVktEdGhHME9PRmdENmJOTmZKVklXL0ZqVzdx?=
 =?utf-8?B?VU9Kd0QvamJTL0ROUTIvd1JFYTRhcEFrU0pyV2svMGNMZ00vUFE0cUNXTnVW?=
 =?utf-8?B?dGo4V1B0azNybWVRN3FhSElsOFRIREZ2RVg0RUkwcmZESG52MXY1NXRML0pk?=
 =?utf-8?B?SlorOVdiamVWVENWUVBsZ2hiS1BmR2lGWGFVbUFsc01GUnc0dWV3OUtuMUgr?=
 =?utf-8?B?VzBoU1dyYjAzWWlTdUZOb05scnV6cFdYV0VIM3pma2o1SWhiQmFDd2ZrNFJo?=
 =?utf-8?B?YThESnlKUFN6OHROa21WTzVkbVpaUmdZcE03S0dvU3BueUpPSDR4WVhtNFJU?=
 =?utf-8?B?NStuM3FYVUozb3VvUU9SWENnaWJyUFFUeFkyd2p1UklKUlVlYTZXVnpxdUZH?=
 =?utf-8?B?SGRZWjhXN210Sy9DWDRRS3ROdDRaTUlhejh5TjdKS2ZIMDRKekFyblVCYmZL?=
 =?utf-8?B?RHluM2xzYmtMYXV6cDNIRC9rMmtjYTdyU3NlYXBCdGtuRjNQVWhvZnk2VzBj?=
 =?utf-8?B?K3g4TG8wQ2NjRXZDUUVNRGd3QUcyT3pOOGZFMWNRdWd1ckxUS0tFREoxdjN4?=
 =?utf-8?B?bStWdDd5ZndwNUZoRTljMStKZGdTbVJKYWVHaG1qZ1A5VHNGbjVBdHhpWjMz?=
 =?utf-8?B?ODRCelgrbisrTGE4V0Y5NWZ1eURDQ242eFY5NHNtSDJvR3pMdERqK3U5cUdV?=
 =?utf-8?B?UElnNS8xUTZ0OStlRm9SVTR4a2s5clJYQ1pSQlBFbW05V0o1YVlHRFlYNzJv?=
 =?utf-8?B?blNxMmE2djl0eFBuQ3JUcWlWQmFyajlJMU02Smhibk5GWGV0LzNlbTM3TWRa?=
 =?utf-8?B?cnJVdHJ1RWNSZ0hHUVY2MDRicGlTRmd4VExoeE1iLy9hWHR3N1lwUXE5aTVx?=
 =?utf-8?B?c0ptSmxKelptTlVnT2Z4UUNwcGFsYnQ5Wk1CZWRETENMQ2pPV3B5NmlhYVRV?=
 =?utf-8?B?UkhGMXF2SHlUUjF0VjNzaUMyZjk0MHJBWHlTTTFQY25oL1JBdEMvc1V1ODJJ?=
 =?utf-8?B?TFI1T1k1SXZvR3pMVDQyRnQ5VEMxQ0pFY2NqSHVlMmxxc1ZHTjlIaFRCRVVC?=
 =?utf-8?B?NjB1b3BBYVEyL3Zxa1dBQkF0RVY1TjlrSlRONk1aK2JxN0tUdW83SkFCNlFG?=
 =?utf-8?B?WE0zTE12YklMeTF3K2VoQnB5QUg2TGNjRFV6Um1MME9mTWtHeE93S0hQQjlx?=
 =?utf-8?B?eXo2czZSRzRNYTY4OTVKVkhtQkxZNkU0a1FCa0JZMitWQXNCcFVrWVR3YkNq?=
 =?utf-8?B?bmQ5ZXFBckxUYmNLdkRTYitld1pXbUdEY2ZkUEFLM1dRRCt1WERqZ0N6WjI5?=
 =?utf-8?B?RHpFUEtNT1k5dlNRUkI5QkxmSkRqZWR4VGxhUzZWTjZTWnI0Sk5PTW1ubExE?=
 =?utf-8?B?c3RjL1B0cmY1aXRJMWNFK1VnMkhuQTBuOGhEZWpHbGR3ak5oRDVheCswNXpQ?=
 =?utf-8?B?UTkxSXltcHZCVXVuNjQxOTMwQWlQRVZoVmxoRFp2SnBsZ3lsZDB5WHR4aW1K?=
 =?utf-8?B?bHpIUmh4Z0dxWVcraWwzU3U3QWtBTEVHZDk1dzhLTHZHK1JKeDNSZnNqd3NC?=
 =?utf-8?Q?S4h0c6Dp3RD5Pm+hXpAjftsds?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc96d0fb-9450-4472-2811-08dc41e690ba
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:16:10.7598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8EWn+MREa6qrLJnXSTPYLqbMQqPUQpNcTpxpm7HCwPjjT3CUrO+jsK65P/Kl25ZPjKiWg2aYRjXs4+dEm1UQFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413

On 3/10/24 00:06, Kuppuswamy, Sathyanarayanan wrote:
> 
> On 3/8/24 10:35 AM, Tom Lendacky wrote:
>> When an SVSM is present, the guest can also request attestation reports
>> from the SVSM. These SVSM attestation reports can be used to attest the
>> SVSM and any services running within the SVSM.
>>
>> Extend the config-fs attestation support to allow for an SVSM attestation
>> report. This involves creating four (4) new config-fs attributes:
>>
>>    - 'svsm' (input)
>>      This attribute is used to determine whether the attestation request
>>      should be sent to the SVSM or to the SEV firmware.
>>
>>    - 'service_guid' (input)
>>      Used for requesting the attestation of a single service within the
>>      SVSM. A null GUID implies that the SVSM_ATTEST_SERVICES call should
>>      be used to request the attestation report. A non-null GUID implies
>>      that the SVSM_ATTEST_SINGLE_SERVICE call should be used.
>>
>>    - 'service_manifest_version' (input)
>>      Used with the SVSM_ATTEST_SINGLE_SERVICE call, the service version
>>      represents a specific service manifest version be used for the
>>      attestation report.
>>
>>    - 'manifestblob' (output)
>>      Used to return the service manifest associated with the attestation
>>      report.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   Documentation/ABI/testing/configfs-tsm  |  59 ++++++++++
>>   arch/x86/include/asm/sev.h              |  31 ++++-
>>   arch/x86/kernel/sev.c                   |  50 ++++++++
>>   drivers/virt/coco/sev-guest/sev-guest.c | 147 ++++++++++++++++++++++++
>>   drivers/virt/coco/tsm.c                 |  95 ++++++++++++++-
>>   include/linux/tsm.h                     |  11 ++
>>   6 files changed, 390 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
>> index dd24202b5ba5..a4663610bf7c 100644
>> --- a/Documentation/ABI/testing/configfs-tsm
>> +++ b/Documentation/ABI/testing/configfs-tsm

>> +
>> +What:		/sys/kernel/config/tsm/report/$name/svsm
>> +Date:		January, 2024
>> +KernelVersion:	v6.9
>> +Contact:	linux-coco@lists.linux.dev
>> +Description:
>> +		(WO) Attribute is visible if a TSM implementation provider
>> +		supports the concept of attestation reports for TVMs running
>> +		under an SVSM, like SEV-SNP. Specifying a 1 (or other boolean
> 
> Since service_guid can be used for non SVSM services as well, can we use
> a generic term "service" here? And let user specify the service type
> (like service=svsm)

I suppose that's possible. I think we would need a better term than just 
service, though, since service_guid is specific to a service within the 
service provider... so maybe service_provider.

> 
>> +		equivalent, e.g. "Y") implies that the attestation report
>> +		should come from the SVSM.
>> +		Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
>> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
>> +
>> +What:		/sys/kernel/config/tsm/report/$name/service_guid
>> +Date:		January, 2024
>> +KernelVersion:	v6.9
>> +Contact:	linux-coco@lists.linux.dev
>> +Description:
>> +		(WO) Attribute is visible if a TSM implementation provider
>> +		supports the concept of attestation reports for TVMs running
>> +		under an SVSM, like SEV-SNP. Specifying a empty or null GUID
>> +		(00000000-0000-0000-0000-000000) requests all active services
>> +		within the SVSM be part of the attestation report. Specifying
>> +		a non-null GUID requests an attestation report of just the
>> +		specified service using the manifest form specified by the
>> +		service_manifest_version attribute.
>> +		Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
>> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
>> +
> 
> I think it will be useful to the user if there is a attribute to list the service GUIDs
> supported. It can help prevent user using incorrect or unsupported GUIDs.

A list of supported GUIDs can be obtained from the manifest of a 
all-services attestation request.

>  >> +	if (guid_is_null(&desc->service_guid)) {
>> +		call_id = SVSM_ATTEST_CALL(SVSM_ATTEST_SERVICES);
>> +	} else {
>> +		export_guid(attest_call.service_guid, &desc->service_guid);
>> +		attest_call.service_manifest_version = desc->service_manifest_version;
>> +
>> +		call_id = SVSM_ATTEST_CALL(SVSM_ATTEST_SINGLE_SERVICE);
>> +	}
> 
> Above initialization will not change during retry, right? Why not move it above
> retry?

True, will move it outside of the loop.

>

>> +
>> +	/* Obtain the GUID string length */
>> +	guid_len = (len && buf[len - 1] == '\n') ? len - 1 : len;
>> +	if (guid_len && guid_len != UUID_STRING_LEN)
>> +		return -EINVAL;
>> +
> 
> I don't think you need above checks. I think guid_parse will fail, if it is not
> a valid GUID.

Yes and no. The guid_parse() function will succeed if the string is longer 
than UUID_STRING_LEN as long as it is a valid UUID up to UUID_STRING_LEN. 
In other words, guid_parse() of:

	aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee

and
	aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee-gg

both succeed.

I'm ok with eliminating the length calculation and check if everyone is in 
favor of doing that given the above behavior.

> 
>> +	if (guid_len == UUID_STRING_LEN) {
>> +		rc = guid_parse(buf, &report->desc.service_guid);
>> +		if (rc)
>> +			return rc;
>> +	} else {
>> +		report->desc.service_guid = guid_null;
> 
> I think the default value will be guid_null right, why reset it to NULL for every failed attempt?

Default, yes. But what if it is written once, then a second time with an 
invalid GUID. Should the previously written GUID still be used?

Thanks,
Tom

> 

