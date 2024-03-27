Return-Path: <linux-kernel+bounces-121707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9555F88ECC8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25571296C46
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC34714D455;
	Wed, 27 Mar 2024 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aEYXWLXT"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1476614A60E;
	Wed, 27 Mar 2024 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561149; cv=fail; b=KL6d9eSzv+2iRMRg8OzG8mTxqXVtzq4ibdejcRr+fkHwgTDW0bGbpHeauiEeVSxZdhqaNDuQ5OZBq1odBx9tKNUzSB9asbB91rG//kF3WsDdhDpDpLG+n9lwEfto44R1VgjWVfD11djjNqh6RWoV7UtaBqwbUSyA9MsrvasKgGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561149; c=relaxed/simple;
	bh=c/xn3DdC75ltmdmTomxh5iUaPXcqjL0AwC6SeD3lYT8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bS+GXAr7E1486iSZs6a7wwVow2K8tzPNPwurTIhdCYUhuGlJfX9CfXZ9smGFufewPa+z0NcZ2qx9u8dz4Az1ZWUEBaCIcs6X5U8FpzbMYtsIhZ78MzeovYWcP6ovkkAvitXZ1m5O6GpxRrLNwc3j0hEwdU5Y/xr/zjJ0E7kDZW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aEYXWLXT; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmcFhTSDt3PkFLGAEa+sLa2I3tBGV5KwNa12SabGsihpZwS04K/Z7s4n+Kl9qJzHhCDFcSrjC2gjc90NAQYirczwWpvvODfnPokEFFVNaLDSWJ6AnSnZYgeSNFNnz3C6xFVtv2i6SEUOmoCUj83Uxh4Ndg/MqwTt6mI2+kkPf5jHEEFLy2af7+Gk4FPR2isTaO2qYr3m85XvesPQZEdwMvglMYBsxwnkgEJa8EtSu79/L1wf5mLfhw+azGTtEL3T2S6Js22fla8NgxZvBRSeiT3g9nENAV78CasMQ2hHOWX0lOAsbnXet0qztoco5EBDAc4RG/1roFT7lJkFyBVe/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJtE6jwcycvt8404fw6iaSnuivG4r6AFoNcMmLTNkMg=;
 b=CIa5fRnUCE6bmoisZrwO1BnDp80ygzQYBP3k7B8ZOkKu1b85qsy91XZUUEK+u+Ab7MW64oBz6AAW4czwoIhjVaEr7fc4TySMm8yfNP7BKY7mZVvyytvq7busczI2cxzVMCeweMDGdp1doIKOQZAA5Ty9wRbrSze5PxErQ6JojJSXttBKT1/bJHWtriIPa2dqo/KzV23JxG1f+ISjgdKfVc0x70Cak6xJu6SdKBy/CP1kUgR+FFTdySBlSPnuCkuu22L2fFVv/3BIwN/N3NUXoz6vs//xqkZRJDUbqIWxD5luqZwTTXKWZz3J8Zds3nGfU7T3ij+w397Nccyj9LIxmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJtE6jwcycvt8404fw6iaSnuivG4r6AFoNcMmLTNkMg=;
 b=aEYXWLXTUM8WD+Kb/9hxfLOrorNkLjVKqmM/xFSUrEFj4xdlfVUbT29lRTimO64kbb4DYnQzPhV5llLMykKzCZKyfrunpeOtzchn+LrGxjowJNDoSNo2wX954SZVAmzxmV9sGQaFqqxgZcWLEoP12CzHTLw4ZWQA9b+Xy3JoocM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by IA1PR12MB8239.namprd12.prod.outlook.com (2603:10b6:208:3f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 17:39:03 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3%3]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 17:39:03 +0000
Message-ID: <73a59667-ee41-4f62-8341-fc83a12516f9@amd.com>
Date: Wed, 27 Mar 2024 23:08:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: amd: acp: fix for acp_init function error
 handling
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, venkataprasad.potturu@amd.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Syed Saba Kareem <Syed.SabaKareem@amd.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240327104657.3537664-1-Vijendar.Mukunda@amd.com>
 <e4ba58bc-fa5b-4ece-8906-f7cc7cb5b0f4@sirena.org.uk>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <e4ba58bc-fa5b-4ece-8906-f7cc7cb5b0f4@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::8) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|IA1PR12MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: a61e9c91-07a7-49ae-1763-08dc4e84cb5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F9A54goXm7kRMN3Qn1ZGmArDXSMqJ7wfwc0rtwfh7PTE43WJL599dUKBD50MlTSZhYMagbrah2EsqBZNaxcwn+M69NFQNs3oozns5B3iWg8i+28WHghDuOmP7lFfTmt4baj+J+2FA9QLYF6c1U3dSCJ+sxv/2I+vY6EoHBAMtqBgLJqnF9FM0KpxJ+OxeSYLmwxnqST0Ou5mjso//HE4FYSppOa3jRp6WjseASlSyZbDuBDB3xKLtR9Q4V8Io5JnpvaDQQ0TZ1BIUVX06xlhf4un8ewrD32aKTGxCh+rZWlkqybKJPs27ps60WZm4bRmJ/iPUV7Zqdd/LLbrzgBG58UZAUAJhtvY1VRq6fOGFx7Qwb75v2PX6capGmb6u12jELehS1xRUSAk/AiqjBCi9YUSzV9eb3jlqqrAN+opNaXQ6sPY4dNWtKFmQMXfBA848rrupBMJ/nfkcyknv6u3NjH7LyE0c26MpxPUMClrjwZpKiN90cHRMf14+M2jhw7G5ydekfd0nD2pWSxIimVNz0VB/CitS3kGHnzHrveEYPx78HGr41cGHzjsOb3WDfZt5VmYMV1KZQsI9fcjbiKKmxqHGcX70P+zFFv9yKrupoZp31/KTY4rT5DFq9bdOrwfa4YStVXOioj9tFZVr6wIMqUBlVsc+s8F+IePVEo6jGk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1N5NEliLzlzcUhGZGhQVDJQUDl1SVoyT0NaRTViZjdxOUF1TTVpRkpaU2RH?=
 =?utf-8?B?bk9Zcm1kYXIyckJsRUs4a2xxSUxlWWZkSERkU3lZQXFzT0QxVElCVWhoR0p5?=
 =?utf-8?B?UXRkWVh3UW5PUFdjNUhOUkpWcTEzNjlub1VYT1NVdUtuNXM4b012UTJ6b3Bj?=
 =?utf-8?B?T3BVSGhMdnQzZGpUQnpBcDhhM21yVlBoc3hqTUpvTUhOZWU3c0RVNXBHd0F0?=
 =?utf-8?B?K2hscFp5SXlqYzlqMk5EdStoM2JZY2NXZ0VvVkF4YmF3U0EzLzFzN1VLV3dy?=
 =?utf-8?B?dEhMbTBoMGdHT28yblJtMXphUWV2bTNxeTBneHg1dkVCNnYvVHdpeHNSTmZY?=
 =?utf-8?B?anozS0EyZHR5cTJwU3ZmYmVSalR6elRENkQrOXI1dTBqNmhkaWxPdWkwWHM3?=
 =?utf-8?B?T2Q0SHB6eXppZVZCREU3SWt4ZHJsbktoT1l4ZnZ5U092dEJoV2NTWXQ5ckkz?=
 =?utf-8?B?MlNpNEk5RFpyWVJlQUpmQWtIaW82VzU4Uno1VS82U21tbGdwVnN4REt0L0lD?=
 =?utf-8?B?WWRaOGNyYU1raXY2Y2syMTBKK2Y3SE8vRFNQQTNGVnNQMXlSaXRGbldXTnhR?=
 =?utf-8?B?RzIrMGxSTXROVHIvS0JrTTdkaXphcDVGYSthYVJDaHNVaHFkUlZVSFRRaUdZ?=
 =?utf-8?B?TXFjWVdtL3BrakZXbXZnaFNBYnlFeHFiMzMxK1pzdTgzbFhRaFNvYXJVNjhQ?=
 =?utf-8?B?TlpvRUd4YUtkVjJHbjNvZVBwbzlLbE1nTUlTVHQ2QjlZcDkxandPWnBsS3cz?=
 =?utf-8?B?dVV5N2xXYjAzTTJGRStpU1FjQWhqQWFveU5KeUlNTnJaMW9kYk16TzBoWThW?=
 =?utf-8?B?d3ZKTmpnd0o1ck5JK0t4ZXh5Z3JNS1ZJTmNWWTh0dDJNcTJUWm5rUnF5Qytq?=
 =?utf-8?B?Tld0SVcwRXE5MktWYjg3SHJHU2VPRTg0Qkd6UTJmWE9DN21TOEtPeUM5TlNz?=
 =?utf-8?B?ZDhxS04wSHJSUkQwTi9XZnpkRFJjQkhnSFIvQUhxSXhqL1JyOGk1eEFSdVdz?=
 =?utf-8?B?cXRPWktKS3oxeTRmbVVXaXJkZzA0cndvdHVvSEZzVHBQeEpjUEhWeStOR3Rv?=
 =?utf-8?B?U2UyQnhuYitwRVlDM1k4anFxa25rWGNvdnVUVHJQMjQ1SU9PZTdaeXFpUTBJ?=
 =?utf-8?B?aGhZakNPZGcwTGQxVmlLSks0VHdaVm8vUVMzRjlHL2YxYjdlVldnSUhIeVFT?=
 =?utf-8?B?aERHUi9WTm45OXJpUmFuQzhvVDhQNXRmNC81YmtnTk1tOVhrbGRrNUx4RzM1?=
 =?utf-8?B?bnF4ZHU0QmFIcGo4My80YWV4UDJIREJKSGZBVHk3eFlGMW5qbjVYRURvbURI?=
 =?utf-8?B?SldTcXdlSkY3OGgzbGg3emdpYmJack5ac1NXRXh0eWRDYmJUU25mWnl0eDM5?=
 =?utf-8?B?WWFVVm90bFhEa3FaS095V0tUZWVGanZBQXhrWENQSC9LOHdwRU1Va3BaVXVO?=
 =?utf-8?B?YVdqcll1cHJHUWY0anVubHhJbGVnSlVKYW5ldEVuZFZKTXdhc2IxQnFldnp0?=
 =?utf-8?B?UjVrZmdhNGkzNVc4cmNzLzZXS3hRZUVGTHM2Q3Izd0RVZ0tiazhibU0wckZI?=
 =?utf-8?B?U2pQM1EwUHRpYWRwenZpdm9NNVRxM2tXSmd4REZyUXYvQSs4YUY4NDNSRjEv?=
 =?utf-8?B?NHlyTzhKenRhSU5xbm9xaG1MZUVuTFY1ZlJtcWswSU9tZzlaOHhXM0ZiQ1g0?=
 =?utf-8?B?TmREMlNUeFBmMGJVMHBIQkVCUDVCdjYxMWNQa2ViSlZVTENuWDNQS29uNi9l?=
 =?utf-8?B?Wk5jNXlsMUkrVzhLTGZIVENwYkhEWjNOaHJlOTVMTDlISTF2OC9JRThHRWZt?=
 =?utf-8?B?ZW9XeVB6Q1J3dTBPNUo3ektyNzA0N09RU2lWOFdQUWVjSXJMUmkrcVhwWHBP?=
 =?utf-8?B?eVZFc0FqajN1aFhsT3lqQ1EzNC96NktvUXM3NytRc0lLM2x3VjkvaEVlTlB2?=
 =?utf-8?B?WmJHWnQwb2RwSlBCN3JnWjdmSmpDTWZqMUttYVF1c0VMQWo4VktDcmlNL0NW?=
 =?utf-8?B?MXI0a1NMaloxQVNvWFAxSTV1SVZRNUIzeUR3MFpjY0lCb3V2RHZzOXNWSE1J?=
 =?utf-8?B?bjIrbHFnWExKK3FGeHFlYyszOENVTW1wem9jZllhTmw1TFdPWjJYem10OHZK?=
 =?utf-8?Q?u9mAw2HE2A1hKfM8IS3WKCvV8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61e9c91-07a7-49ae-1763-08dc4e84cb5a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 17:39:03.7343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNDRZFGN3LdMVwTVNg6n229ApSzFu3AWrrzhe2S0I1gvFaE92e7XCBDNCAbXKkOdl8icVit8XyDMRJop2JB7xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8239

On 27/03/24 20:28, Mark Brown wrote:
> On Wed, Mar 27, 2024 at 04:16:52PM +0530, Vijendar Mukunda wrote:
>
>> @@ -115,7 +115,10 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
>>  		goto unregister_dmic_dev;
>>  	}
>>  
>> -	acp_init(chip);
>> +	ret = acp_init(chip);
>> +	if (ret)
>> +		return ret;
>> +
> The return check is good but shouldn't this be a 'goto
> unregister_dmic_dev' like the above case so we do cleanup?
I do agree. Will modify the code and respin the patch series.


