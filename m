Return-Path: <linux-kernel+bounces-128581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 346A1895CA9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5815D1C22ACD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DE215B975;
	Tue,  2 Apr 2024 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zchu99GO"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2112.outbound.protection.outlook.com [40.107.101.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA25315B55A;
	Tue,  2 Apr 2024 19:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086434; cv=fail; b=n6gDyKvTGURik/wes3rro/R/nlFhxwRcUWH2c5vve2tA3J14Apcz3pF2AgKdXYdRZTMnukMq+2TeC2iml7D7YHp/lB1foBNk9pi4tLujrKurCXIYc/4PaDxb/gPlbFTv5oqFtWlNJV42L0Fc9aAjsMwHIHO2WSJh7ezlLMgOZC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086434; c=relaxed/simple;
	bh=l2UZGX9k2A+NHLED7AQ7cV+45iOw/oOv72QwZQHuGv8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PtZXDV7XA4JG8ma3ecoGExj6aVVORGQCJmOuxikP7+n9de/uxrfUknqOVpYQ9OCPt4ImJFYN9fp6S2C3MvqvDnCVpNKtZ9vnSgg0L4QEaQgGh/J7ZbcDy+VdRb5+yQBYRTpjL68oQmCeeWP9PbWnsf5+/s1+vFzi6KwYIk/RV38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zchu99GO; arc=fail smtp.client-ip=40.107.101.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cqb+l8uId8USMGXmtVOB8oVv+K6e7BtvEX73cCm5YjY1RIf0PE+o4gb/iBz0tF5SUdjMbj0jQuKtkqc5HhXAUY/S3hjRQTRF/eBG6j/v7HICIGIZRHn44umju2vXX7/lWNd44+zdn+H8UQFXWZAvk0DMStacejimFTt/eO5ZwZq1U283PtNYgz12NAkXSXbcm/69njqYo3DsxW4zUodSKmVUOH0R+fsB18Ey2C/lL7Gzb3eU+Dk5oc4fGmiQu9EWAFbsRPsqVlg+Vxcvl0mb27HdnMUdTSu91dHYhTh2RNtDJI9Z9hT42TF8oahVAf/ocqJXAnCnI7BLPvhJK7Pp8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ts7lH4uHMWNKUywHjlURIHZa1sDLUanphi6f5Ag1fDw=;
 b=dAsvDhg39tUAJu3vuAgncQXSTlY+P7xzMUuL9tEBas1qt8+guHZZxdGf9XOFabZi7d4iuN6R6Qshfdnh1yKpeLVl/nKpLiqKJSbewUlON3KV9EfTb38eJQmyKHSvMEVMZGaCb36H7A1tK4fhP50LzNH5JIs31bQBXC9nUlJP94v/0FFsoRBiBYdSfVvcFqU+2jJiviOqI7L3iDuhCb9GFqA0CaRDHeIKBH0XlL5tdphXbwSQuxkX6tWKyMam8hNBZw8lerrleLqRrFQYmHMgQgiszOUURj9NII+jAp8WuT+MQKShXV/PYmI9Rpy2eW/iTt9nM4hbPex1tIWCj9w8XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ts7lH4uHMWNKUywHjlURIHZa1sDLUanphi6f5Ag1fDw=;
 b=zchu99GOUGi488Ot9wj9Q1a9Nd/0ihY09wwkXwxgLbiXpA2+nF5NKWzGCWcJ6QBgFWDNrU7dQ6pgzW7fFLSFpuoyjor5ZGtqBLAviWRGIVrLsmR+I5QLXGz7Z9Tpu5VyiLVdIPxGr9iIx2h4gmF3Lv0m+fU4j7uNQYMQEmzfaTI=
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by CH3PR12MB8756.namprd12.prod.outlook.com (2603:10b6:610:17f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 19:33:46 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 19:33:46 +0000
Message-ID: <8daf448f-eb52-4b1f-9f98-099a83665321@amd.com>
Date: Tue, 2 Apr 2024 14:33:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Apply RMP table fixups for kexec.
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: bp@kernel.org, thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
 linux-tip-commits@vger.kernel.org, michael.roth@amd.com, x86@kernel.org
References: <2ab14f6f-2690-056b-cf9e-38a12dafd728@amd.com>
 <20240402163412.19325-1-bp@kernel.org>
 <6f0d2ccf-243c-4073-a470-21e2f404595a@amd.com>
 <359264a1-e4ef-438c-8f24-32848e131272@amd.com>
 <20240402174540.GAZgxERNxsRJUCb1yp@fat_crate.local>
 <37321af9-aee4-4ba6-81ac-0df4cef38644@amd.com>
 <20240402185039.GBZgxTfwvEP45OxVjm@fat_crate.local>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240402185039.GBZgxTfwvEP45OxVjm@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0176.namprd13.prod.outlook.com
 (2603:10b6:806:28::31) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|CH3PR12MB8756:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uODqqSZIlvKa+QN5If09DApD62rjVy40xjdlK4ZovhqinTpR+Q5D7r4ceYeqE3vBC5rgghPq+QFJOAOK05zWiBWjE5l54D1uKa3Dz6RQo+m82g5R+7fZXm0kvYupwlpC5SLtAUacXw5oJfbQUPMsOi4xk9X34f2E9tM8i0QcaumXzmSbRoWJtNlcc0dHPfmn/nZ8P+HIeBSLWIhdC2jYeTzDOo/RIK9nFwn7Su9w3bjU8laYjYpkQCZOCUKG8BV4UYu/NjB7h1keCguDlEqGFrxkp7YMFj1VhbW8ZOvvF9jydNmbVCBCrWZCXn2ZnuMmw9nrfRLYGh1FEe0P6Q7HphMQJfsmAiZpI0SfHHDEOyLz/cXnp+WYhwl9s7nVF9Tp0Ef4zvH0XsvbWh5/bIOCTv51dW3bGbmar225MbkfLElCR1dHkk/0tLD4vcwoNkHPbDnPp/pgKSBu6E+xODq/gtiIv4bo//WVAxiYPBgl1YXHIqwcHqTmIVQjpDHqJ8kYFIQxpQ7vg+ZSr+mtMawlZbzhdLgys3u2tAJMq5tL5CHT7v1OMs4u52oSOF88PeS72G0xNpmyq8YaMoh6ntqHfLz2CjkNu6xZnZjD9pjDAbsOjeNXN3+se9ua/+q/A151kZhD0nZ56jliuibPVGE2tliUxUmODPhpTx7a6rVEXNA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djdGVHREdzRHdTBKODF2NjdYTGowWGNWUGVxNms2ZmdYYngwa3dzY1hybnFw?=
 =?utf-8?B?ZENhS0FiZWhIZGt1NlV3T1cwTHF3VSthZUZ6Mmp1NndLUnVrQXAzVG1PZkw3?=
 =?utf-8?B?TVJ5NVZKT1JvQk54djVraFFRNENpTWxUR3BuTnNMY0VqekNkSlR6K2xFeUlJ?=
 =?utf-8?B?NkNMcS95eHdsUTkwWm8yelljT2w0cWMxK1o4TGF3MEI5U3Y3UzdKK1l4MDFZ?=
 =?utf-8?B?WjRGVXVrUUhKWGhDdmNBV1AyNnM2YmFHR1l3VE5SVzIrNnE5ZDFmNDRsUElC?=
 =?utf-8?B?azRQNzVyaElEMVhlZWRSQnhUVXdwU3pTZUV4V3hPcUdONTJ1QlVOR21sQXIz?=
 =?utf-8?B?MjNoZVBBYVIxZnJsbEk1dDhsK2U1NUhCN1dJbStNc0RsOEFjUjNiSzlSN1Rn?=
 =?utf-8?B?RkR2N1ozY0xWb1dmU2wybkw1MjZqS3BJU3ZHbEVKSW1yVDgxNTNUWWx5MXhK?=
 =?utf-8?B?UnNsRXB4bGUwVVVicUdieUY5blZoWUh2SUdqMEN4MUUyR01lSmNPR1NYTldP?=
 =?utf-8?B?T05qUVVpVUVUdWswM2xpQWJWZlZER29LcHpaNCtqcDN5N1pYLy9GSGgrV1ZS?=
 =?utf-8?B?Ni9yb2lJdXVSYTQxQzBadFZ4a2tpUEFtN0hEbDJzTWlsSmF1TlQ3NkVoYUZW?=
 =?utf-8?B?WEowZFB5RE9TZDlIMDVHM3NVbDJ4dWtKN0FhSlJWSHBYaFFqOEQ5YVh2a0Uz?=
 =?utf-8?B?by9nc1hSOHlwTmN2eFNyUDUzQk9DTU1CRlFLYTljRkhybEsyOHltSGEyRkx6?=
 =?utf-8?B?ckVEK21DVmc1M0dUMWt6dkp6TFFiVTdJR2RMa3NEQTU0ZlpBN1ZGd2RKUHhK?=
 =?utf-8?B?YzFkTHFPQWhpaTIvT09iS2hsRFVja0JZcFp6blFzY2NrY2prRjF1QjdxNG9h?=
 =?utf-8?B?dzgxeXVpUG12ZmxNTUhBaEgvcXpnazlKaXFBM21XRnNJbS9GWVBqVUJwZTQw?=
 =?utf-8?B?RDQ0eW84bDBjdlNBNU5Ed0xwellUZmNkWjBWeHFWWmVkcHZ0K1hKMGl3NDh0?=
 =?utf-8?B?K3UvenFPTXF4QmUrRVFUMFlNWmx4dkZyUnVjc0lXd1pEM3dWYWs1UUdlMnRU?=
 =?utf-8?B?a1JVODlLUXc1QUVGaWkrc0NQQlNpVzdYY0RmeGhnUjNycE9zbzd5aXNoYTdx?=
 =?utf-8?B?NU9ySTJlUWc2MzdxMlFOUWhnVk4yMjdQV1VtZEYvWG5vVnhYcURudjd3V2w5?=
 =?utf-8?B?bU1nVjZBNEluVC9kQ3N3UTk2YlRkWCtYQ0MzRnNNZ2tsT3FTSVlXS2JXVXZl?=
 =?utf-8?B?TnA0ZUFKQW5iZVU0dlE3T2RMYkhpaVBqRGpDU2Y0ZzRpUlQ5U2drYTQyMHJv?=
 =?utf-8?B?TExLV3pVVTZuRkxxNlgxNVRnV0owaHpIeDFDVnFBNlAzQXU5L0w0ZEcvUURr?=
 =?utf-8?B?VmkxUXJQVGRYQ3FDNjlaTlg5UFBiSDA0TnBXZTR4MHJid09XcEN0WldCeU5D?=
 =?utf-8?B?cFU2WDVhZTJrQmZPTEloOFFGVWRYd3NKbHcreTVHUHY0Y1l6NGZoLzR0STRZ?=
 =?utf-8?B?MEtWQnVIcE10TkNuak9Oa3AzZXlNczVUdk5hN2R2M2pLWXA5UzFybGxHTkZ0?=
 =?utf-8?B?RkVGRmEwWUo5bHJhV3A0WVlsdnpybjJuMUhicXRQQmNNS280bmdxUkFjSzdW?=
 =?utf-8?B?Y1hOVnNMVUhjNXkxOGlJdnhhVlJINWxtOUpkeUU4OUMyZEh5MjVMUnoyVkxZ?=
 =?utf-8?B?TmJnZ29LMzRqK2hCUHhFN1QyLzIxWmlCL0tFaGRGZ0JwMlBuNkhETFRXZUd1?=
 =?utf-8?B?NjJqOE92aUFEQ0ppVnFNd1JtSTBLSVh1Nlh4UW5NSW9iOGppVFFsa2pjNXg2?=
 =?utf-8?B?RDRjeCtqUS9PUVJNRkhXbjNvbHpNQjVCT3MxVW1uSTNkWWdwTDVEY2hYYU15?=
 =?utf-8?B?dUFRdHBpR2k5Yy8zTjFzWC9VdTBqMjN0S3l2SnJ2ak41anFWcjFVQlhBVnl0?=
 =?utf-8?B?U2xReWNWZEN1TXhHeDdkNGw1Ri9MU0JsL2NxU0dZbkVvRWJZUUNJaXNJY1BY?=
 =?utf-8?B?TDZsK2JNTi9IVExHbE9kQUkvN1J2VndCNmZhZUpNc3NoZmw1bVZ1cTBlMDAy?=
 =?utf-8?B?MmV6cll1QXNxcUlFTmpyVWk1U09EZmhNK1lnU21GNWNPR3ZDbTFoYVhJd2wy?=
 =?utf-8?Q?4HQdoeGv3jJeBd6vpzTIqmc7t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175691a9-c9bd-4aa5-d508-08dc534bd029
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 19:33:46.0753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoQ5qmMt9KH33SjL7qCFsFBueLVLkfoc7i+zzEgrnVJFSB1CLm+XmdQLe4rifrjluSgp0SE6nyOhqsVLkxhEcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8756


On 4/2/2024 1:50 PM, Borislav Petkov wrote:
> On Tue, Apr 02, 2024 at 01:41:05PM -0500, Kalra, Ashish wrote:
>> But, that's what the e820 table fixup is doing,
> And can it be doing it in snp_probe_rmptable_info() where all the RMP
> table stuff is being done?

The e820 fixups has to be done on both e820_table_kexec and 
e820_table_firmware (to handle both kexec variants) and this has to be 
done when e820_table is used to populate both e820_table_kexec and 
e820_table_firmware and this is done in e820__memory_setup().

But, snp_probe_rmptable_info() is called as part of early_cpu_init() -> 
early_identify_cpu() which is called earlier than e820__memory_setup() 
and e820 tables are setup much later e820__memory_setup().

And we can't do this in snp_rmptable_init() as e820_table_firmware can't 
be fixed at that point and by that time this table has been mapped into 
sysfs (/sys/firmware) which is used by kexec -c variant.

The function e820__memory_setup() has an optional platform quirk 
available to override/pick up the firmware/bootloader e820 map, and 
that's why i am using this platform specific quirk to override it with 
the SNP specific RMP table e820 fixup function which internally calls 
e820__memory_setup_default() to pass the firmware/bootloader e820 map 
(set in e820_table) and then add RMP table fixups on top of it.

Thanks, Ashish


