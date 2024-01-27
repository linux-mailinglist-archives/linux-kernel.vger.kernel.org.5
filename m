Return-Path: <linux-kernel+bounces-41252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CBF83EE04
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9403283FD5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3D628E02;
	Sat, 27 Jan 2024 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0YOu/NEm"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA7828DC0
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706370191; cv=fail; b=rkmAvUmVYUYWo041poDx2V87AefEVMAJWdvi4J6Eg6Hxd2KiuiKh1xgUZXHATQIZbk2DH9TxnhWVC3/c5GH/E1It2X8rVmx9uGqHkXrSzcKblRlWgOU1qw1nF4RjmkVnwjj3jvuamaPPK+b3v4HZ9hZGA+end8pO8ph3g4J1JJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706370191; c=relaxed/simple;
	bh=z+L6UM2uNLc3ymDcNLdgmSqDrOGxckDAQ0P2QBuTrEs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SoTCq036Mgi1th6HHRAzyhxW/U232yb9oKpQxOgNplaD06zeKiVjgz7UtIOhKJX76WQ/39oqoVEl7X0zywkebl5RSg+aHFjAjQkzF4WVLzo7QDIcSvekPMwq9iLmdDrD9nySGmkv1ccYAkaaGaheNRiYwSpfjGqvKTMOpDLraCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0YOu/NEm; arc=fail smtp.client-ip=40.107.102.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pbfax7P/j7fYvnfLSLfe8vvdW0MrAYuZ7/2OReMXPt9qycKO+95LoyPQvESYRJtwEbF1v4u0Z2lOrpTBsO4FSyM2m5gUYbLFD7f6S4FO+SZit/KzX8FhSGIw60C1cFPbp3EpaJuhtKgKpUIRhE/U0JZztB3DAvK1NVtY1JNKK0ScpBdRtlR0m35+xhNLGKkUmn8jabTWCtH5kdqa6waXnEC8bK3omtroaU4B/fwGNShSNPsMwMW78kljgaLsU3Jv4vsdpNNhOKrgn0LE1n0LkunA1L18dd2bB93gQGH/j/EcTgCk2roTuT2h0lPF7H2n0+FlnKNewDDDruZvYpm7NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0zcwWnAKRNY+t+hGY9Czn07b5DmaFybNx3THyCPopY=;
 b=TSiuOg7spFYrhilJzBskstwVdrVvJ8Lrarh84+6ikZItm6DzmCWv/1nvwskoRJgm+sLzxcp5DZkPtkqRFTajR+vCKRjBPnpkBydOiqfO4sgt3OurKqate7DVqRQLHTcpiw6tboFYkcX9z9Ipg+RdH7vm+KEgBBvkHZSBNeRpCyctDUTbq9OAxrWJzaCtwleu0Tjl8jZPfFnnXDNMPTQ9te5k0jjwxPO8D9OGeBKzXKtuf0pppPzko+3+fErkKCgdg1PjzfJCfzgoF0r8TbR2cM7X3C7KHRSBQA2Ydjs+7/onZLk7YE4Waf6cd08nkzEAz3MA8Zy1Khd1xKNVfB1rFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0zcwWnAKRNY+t+hGY9Czn07b5DmaFybNx3THyCPopY=;
 b=0YOu/NEmQUxbj3og2PzijVIna0hRJ2diGfX+llvZiSNAp65RooERwp2aSAUGtRM41K1BSnh+aOfmLOLEx9VJ+CFRCWfE4KIhdhiTupZPZ0bEMjcgZ4PpvIIWxyRGlpoJoU3H+IkZsX27Apvghzj+wiEGCnGiY9n4zkZT/fglD2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.29; Sat, 27 Jan
 2024 15:43:04 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c%4]) with mapi id 15.20.7228.029; Sat, 27 Jan 2024
 15:43:04 +0000
Message-ID: <b50a822d-e9f3-58b2-7797-be5de0ee4626@amd.com>
Date: Sat, 27 Jan 2024 09:43:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 08/11] x86/sev: Provide guest VMPL level to userspace
Content-Language: en-US
To: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
 <61316ac5a8217f0397da87c78c2db08580ad75a5.1706307364.git.thomas.lendacky@amd.com>
 <CAAH4kHZjqq5OTyTqhCGxeCSrgw==_FyLqqLOaWK3JxQytF=k7A@mail.gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAAH4kHZjqq5OTyTqhCGxeCSrgw==_FyLqqLOaWK3JxQytF=k7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:806:21::24) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 4189d0fe-06fc-42da-cfd6-08dc1f4ea6d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	95kBiLU5Vuw4I5do/Qh7BWhBmre7U8auOQp7lYZ8ZGuQJP2mIHSbiccxdtTsTqc9Qax+deqrM8p5+qrM26kqgWnok4JdlWuIE4PcmKNC8wyA40JHpj6jnchwqu0v9NNH+A3h+R1ygjJsi27IVZZ4GCUPTUCS6JwZtn7Xh9Zm+brby2EbJuc67Ta3njRuBKohy+ABIn/bD+HyH9USQ9tdMkm16iTBVYsz6YTbO/OQcy7Z8fgTF+K3Fk5vfP0VPAXRUPVRqaPvo6gEK4XZ+YLf6ciMawHoYS5jdcDOsCuwxsPGDQYNYcPUzHqUEFP2zPw1Si9iAw0G/Mf8rh4e2nZnPE/stdBKv48dhh5yp2slQHdlXU+O9ydhZ00p11hq7DFPezT9Yc1YYA6Oo3cpx+la8kxcnVitynnKZcLr/SYRL5SY0haE7AnCC9+zW/1jO0k8+LEqBBM2gpvaTROY6lbVG1Z4ZD903FG/NbGD2zdoa9eHUR4VeyU+MQleZYzza15cDVb1wtYXRhym4SDNjJnirwap1nMZn+7Ts9AN40gJSMfvrfmOnKO/hApQMSuym1J9jfv8i6iCrKRGZaS+M+0HakyWwytNZAUZTJHsGRyhb7W97ZsAS+ZsnTOF0gsZSOx2rFiLFr6Flun3MLFpMNL0CA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(136003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(6512007)(26005)(2616005)(38100700002)(8676002)(5660300002)(4326008)(8936002)(7416002)(2906002)(478600001)(6486002)(6506007)(53546011)(6666004)(66946007)(54906003)(66476007)(66556008)(6916009)(316002)(41300700001)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWc5c040cjZtenBlaE8rbjQ1QUl3SnlieTVJanYzWWJ3bDBYNVlhRWVKKzlt?=
 =?utf-8?B?dzM5MXVyRm4vcW9OTXJwTlloZUROM01FeU9wUkUvZEliSVFqaXY0QlN0aUlD?=
 =?utf-8?B?Tlp4STJJbEdBRGdEeFlPZ2JUK2dWV1B5bVhqcmNYVVlXTE1OQUo5Nm5JemtM?=
 =?utf-8?B?ZmVLdCtDdHFtbnpZaG1abktmdXN5ZGIxZkdSczc4MEVBMTRvemVncENaU1cw?=
 =?utf-8?B?M1RJeWR6YWV2ZHdKZDZPWDJtYk54dUFjMittSi9kZUZFQ2s1L3R1UlVUSk82?=
 =?utf-8?B?Vnh5eVRvVGN5ODdoMWsrOUExcURUYmJYaWhRV2pyYUNMUS93MTc5SWd1N3U2?=
 =?utf-8?B?UXlEQUNhQ240MUtkeTFUQ2VnWmhEUVZtejl4dUhoWXVaZGdOcExmUFZLMW1P?=
 =?utf-8?B?WEFLRCs0Z0FWczBGL3g0WEF1QTZ1TDYzR0FzWHBZS2VjNnI2Y1JuaGxOWURP?=
 =?utf-8?B?ekFzSE55andFZi81Wm9BbExYdlRiQkVLMUJLdFZUY3NRclk2bFZVbVpCanFI?=
 =?utf-8?B?MGNnQjgxTzFGSlN6OEU3MHQ2ZVZzTVFkOTdxMnNyRWFlakJrQXhQWHN5K0kw?=
 =?utf-8?B?bkhTNmxualV2ZXhzTE9kaGpvVHNnbSt1M25FQlZ6SkRrYmd0dE9wdERkWnpQ?=
 =?utf-8?B?d2UweFFYWnI3ZDJWQVVGYllXTDhVaUNWcjBUTm1jT3V0OWh1T3VqOWJTcTN0?=
 =?utf-8?B?T05ydUVUK0d0azF1ZVNvV3J4bkwzcllTM28wZ3F5ZTBIemlPVHFzOVlGeDdz?=
 =?utf-8?B?T25hZFZVYy9ONDFjdTdIUUVueG5uWUNQazhWc2U1TmNsM250UXZ4dU1YeTc3?=
 =?utf-8?B?RGpNNlNKWWtuYko5ZFp5TFowTVZWTmtBeG0vVjdncXZ4NlVrTTBMY3BoUVRJ?=
 =?utf-8?B?QXlCVHFvcmdjallHRUN0dVdtcVhBL0MwL3dDRUc4VGNpY0FuZjYzWGhXZjM5?=
 =?utf-8?B?SllwWURwTGdzcUl6WlJPUEZ5ZUJPS3U2NUJ2aisrZ0tOR1NwRmcrdlk3VURh?=
 =?utf-8?B?bENaamZZVGF4TnNmZkxpNEJ2VjlzR3B2S2txQkR4MEVjU1hBK2J1empRam9I?=
 =?utf-8?B?dysvazFXSEt0SDhxVHpNWDVMeGpVUVNldDBVUzN5RDA0cTl0SUwwWXZHdWJC?=
 =?utf-8?B?eGFrM0xMSDZ3UkFvZDdZcjJmU1AxbHJYS3RsdWxGOW9XUlNlMC9DZVhURUpK?=
 =?utf-8?B?bWJMRUZKM0lOcWVxb0ZmYW9oK2ZiRkU4dFNqNVA3L0QzbVFucU9Tc3ZUWW83?=
 =?utf-8?B?NHFaek05SXFIK04wV1dNRmNuSXVqZ3o5V042ditreHVjNW0xVWwyM2hleXd4?=
 =?utf-8?B?MlZzRUhiaVBoNlhRZDFFWGV6blJKMy84NTZldzJIZ0hJNDNORnZ3QjIyZDZN?=
 =?utf-8?B?bTB3cDFWK1FrZzNsR3lSWjZRSktVVkhEN3VxdFZqeURkWkpKZURlSlhyck1U?=
 =?utf-8?B?b3F2YmhhWm1NK3BjdWV5ZElzdlA1cXZSb0plSlRGRzBwcTF0VDFGN21lY25W?=
 =?utf-8?B?MVptZU9YWHhIazZSSGE5andWMnNQM1NQNVVDNSt1d0FIS2kzVGRPSkoxRWlq?=
 =?utf-8?B?UEFmWkc3ZTFCNis0d0dja3c4MUp6OW12OXQ0dVBEdDR2QWZFSC9uMlp3L21m?=
 =?utf-8?B?UkNzQzBORWQyektNaUt4d3pNa3dnN21ZNS82dE1XbE9rbWJpelhpN1RjMFR0?=
 =?utf-8?B?d1Vvc1RGRHcyenhMOWRQSUZYd1VvWTluUTBWZ0ZsL2Zwa0YrSElobjhwclJ0?=
 =?utf-8?B?OTNYVmNnY3g1MU1wY2prUlZITEpxWTU0LzQ4aVZ6ZEhpTjNKUzI3Z1J6TklF?=
 =?utf-8?B?UzErM01oZEtNSkNHakJ0dUcvODgyR0EvWDdFa3MyNExmek8zSWRJNU5aZDlB?=
 =?utf-8?B?T3VKby9zbkxaZVQrRTlYQ0QwODhZaVhjdDg3anVvQ2VZUXJ2c1pDRTBMQ3p6?=
 =?utf-8?B?WkI2SGtFMzR3NkV1ZTdCc1FoRG1pY0JMV0FUK2YyUXgrSFZyRTRsRVlnN3d4?=
 =?utf-8?B?bmg3bFZZUmxzanJzMjUybjIwQWFqdHBBejZKMUZPTTZ2R2Rmelo1MTJLOFBE?=
 =?utf-8?B?WER6UDRnY0VURkQ2UFVRR1c4bm9BeS9TSFhnTDlDNnQ2QUo2RlZXbS9tUURT?=
 =?utf-8?Q?mCSqHEEJqHKpJ16Qj3iYoXU0U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4189d0fe-06fc-42da-cfd6-08dc1f4ea6d7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2024 15:43:04.8211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zZ4AyHKaZ0Y6aTV5eijlzxW3RL5xYAxhQ2psi9ivy07+X2NzWUN6VKrkPkulJ03GzqNStd/gvlbi68Bpd7Y6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094

On 1/26/24 19:06, Dionna Amalie Glaze wrote:
> On Fri, Jan 26, 2024 at 2:19 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> Requesting an attestation report from userspace involves providing the
>> VMPL level for the report. Currently any value from 0-3 is valid because
>> Linux enforces running at VMPL0.
>>
>> When an SVSM is present, though, Linux will not be running at VMPL0 and
>> only VMPL values starting at the VMPL level Linux is running at to 3 are
>> valid. In order to allow userspace to determine the minimum VMPL value
>> that can be supplied to an attestation report, create a sysfs entry that
>> can be used to retrieve the current VMPL level of Linux.
> 
> Is this not the intended meaning of privlevel_floor in
> /sys/kernel/config/tsm/report/$report0/privlevel_floor?

Hmmm... possibly. But that would make someone using the ioctl() (which is 
still available) have to use the config-tsm support to get the value. If 
the overall consensus is not to have a sysfs entry, I'll remove it, but it 
could be useful beyond just attestation.

Your comment does make me realize that I did miss changing privlevel_floor 
for the TSM support. I need to set privlevel_floor to the current VMPL level.

Thanks,
Tom

> 

