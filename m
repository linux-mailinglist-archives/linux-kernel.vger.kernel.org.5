Return-Path: <linux-kernel+bounces-73406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2497685C213
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4948F1C241BC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A52E76910;
	Tue, 20 Feb 2024 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xVV8sCgX"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5956768F5;
	Tue, 20 Feb 2024 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449047; cv=fail; b=V+Q53SLhcK0AtTaWLbLEQ+x1z1P4I3anMYIaxlz8pNUNN060uYj9Fe4BlERMFnu5LC9TjdvmwVSWdRHaquXbCLlZrC/Ic+A78QF+DHF9/dE+MbAoJZIj0ISM6lmJrABexblJ0NBtTHKRniOsQfr2jn2GCfMT22OYLH42lcH98OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449047; c=relaxed/simple;
	bh=wdwFNNyM2iMZdMv/Ak6/yCUvOLBXHB2wg4HcNE4hz+U=;
	h=Subject:From:To:Cc:References:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=Gmjnj4xa4JIGZtTrt3KSldG5njA4M3+g7pv2UHwE5d/iYJDqfi4GXslhxkQ80xnKAM+kTBwXR9ZzGfzg47RseIE99PeDSddGG+GtBg4C5dqg7okxfLBmaqTmCaJheJ3L+DADDa4M6K98TrSpYr3Ku+YO3Uokis4Q9b1BokrLOQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xVV8sCgX; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQA3Gi6M6ETSL7BWjOinkRGx2ytTfET210eAqeOkbxPuenJP4A2Y8Kq18uhd652TIXHQhUgDAlmgoYtAMIyanHhMSXYfmL86X8wnvOxAiJsvz2h0DXAX5A4ZA9qk7D+M57LM2b7+HJhtAxzH1uZzYwVYo/NoHuxPgTKObhYVus6jvtB/CfGJ0J+HI6rySqY56ASO9HF46AZ3YNbm/g64ByqqTw86WBHUpY5lbwt4IfZsguOReVTi6IzW6TQnUQ4mVrNJP5zy/QpXKIu3V3MQE/SS3Dr4F7y82k/xu6R85y5MnW969x7eWXstXrhiev2i0awQmUmz2trFTIdum2PaNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07hyiW4HkE9yWqRAhsDa7bcZubFOyKu9biw4V0KKNds=;
 b=Rmxj3oMoIg+SL7ILgbO5a7llZyFgAQv7nrUnICkzMwZoFKeBREqNsOCz+ydisnVx6LkYuoztWhO5PF48rv5B/gK9IbWQnvJc/AcWmTF+cOWGZnA5kMT7a2wE5TyAxlKwuMHhJAtlY0FNqClEFC9rNNON9KhY9z6r1qLKlf6M6T4USEa1+H2J8mV9XSgtV2LmAtTG9UILqCL9CfwZAepMWPTQ9gixIUuH6LBF0CGxTUjS1/lfdHw4OC3HUSW8/sQmKZ1Hi8nB7UtrVQwuo/cs0JzCDW/ThFkUwyv1aWu4HN4E5HmR6Dat0wq61scFqqjdmoj8tGQ4NpGuAzIKZgRd5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07hyiW4HkE9yWqRAhsDa7bcZubFOyKu9biw4V0KKNds=;
 b=xVV8sCgXN4IuUIWp2tcaQfPq/8dR5fRPqda8x9oux3ilLKFnQfaZ8mpYKrVLzTJ3pXXcvGttDeG+0hlmi99mFJqsiay01jU9Lc/KaTI9vddmQj97w8EMOPmqXVfus6GCPp9SexCIbif/eX6yMH1y1kY4ng30XaLUEYlm6MiJdXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19)
 by LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 17:10:43 +0000
Received: from PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::a2e6:c3b5:4e05:825c]) by PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::a2e6:c3b5:4e05:825c%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 17:10:42 +0000
Subject: Re: [PATCH 0/2] FRU Memory Poison Manager
From: "M K, Muralidhara" <muralimk@amd.com>
To: Borislav Petkov <bp@alien8.de>, Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, avadhut.naik@amd.com, john.allen@amd.com,
 muralidhara.mk@amd.com, naveenkrishna.chatradhi@amd.com,
 sathyapriya.k@amd.com
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214075242.GAZcxxSiMsDoacvC1M@fat_crate.local>
 <953d9c1a-b504-cde5-5de1-2ce9b838204a@amd.com>
Message-ID: <a91d1dfd-f29f-1afd-c42e-b681450db052@amd.com>
Date: Tue, 20 Feb 2024 22:40:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <953d9c1a-b504-cde5-5de1-2ce9b838204a@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0209.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::20) To PH8PR12MB7325.namprd12.prod.outlook.com
 (2603:10b6:510:217::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7325:EE_|LV3PR12MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: eb14d8bb-fabb-4e7d-dded-08dc3236de96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TGpQH67U5l53iUF05jrKn9yVBWbPOTMdoD1lQVTbkLz/rwKAf+zuT5XXzl+31sTqYPleovNs/OR0p35AWTg/IgtUTY/39eM38I0uuvx0XGUocAIUtB7P1PpG9tg7JpDK2A0KvxlLTz5YSAcl1ryVEAqmY/h22oOj8tua9jJD6ra5YAo4HcAMlboQQfakUxryYHqUN0xAjzwznRu/AV2wpbOs+TFsRp+spAH/2ZRMjYEBNj7gFRT/8uCOfbibyLnSPIDgCnKeqvlpL5Y6TGu8S2Zoxaghdu0Kq8NIq6bfZfpj9Fwrz3H8zlCvpyGJx4H5i4cYPFl6W7t4qqzE+uroUluoYmuq2vDNCwW/kj/3jzjaDBtYvq4zkt3ExM6sAmxchzE+3TPrQLXQwfNYlRmv/DxQQ+sKabbQ7oQ2nItfJU6FevX5nku5PbgTy+UPEUPro+Vs19s11IKfRBFe102wyAU5RxaM0ZxXbh5v7AxEnc5WB+8IzYkp+DJfZgDru0SqXN8zQXNLy9FqN5HSA3N8UIVk2FoWZ9iSIvp5THXvVXcdCw+AYzGpW8jkdmM5ujdY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7325.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0hvcnE4ME1mdVRxckF1ME1UamE3bDhNUjZYREpuNnU4Wmc1WUZ2VHBsYmdw?=
 =?utf-8?B?ZXNTcjVuWnYvQ3Q4VjZxN1hGYXBNcERZYWhSUSs3eFFjRkxualhzMEg3U0Iz?=
 =?utf-8?B?dkVTK0tyUEFEeU96SExxYmY4VGxPVUJ0T0h2U3lPdVdWTjMrTXV6VU9DT1Vt?=
 =?utf-8?B?ZEdDaUg0cWQ1RGRjUnlQVDkxYU1jcERTMFFGb3FTQWprb1U3THd5OVdJMjUv?=
 =?utf-8?B?OWE4QVB2ZWdpbjN5dG5qQnErQXFibTJnOHpEV1VhOWh5VUlHRy92K0liUHd4?=
 =?utf-8?B?QXh1UWJGbWJaek5DUVNRMVZIUStXN2tXSXQ2QWp2ZmJtemZXcndHWDhmTjRM?=
 =?utf-8?B?ZU4rQ0RLaS9rM2lMTHc1YXViT2JYeVhSMmwzanB4a2w5T3R0WWZROFpObjRV?=
 =?utf-8?B?anZUWng1Z3M5VjQ0dW0vZE41QmxzR2lKMUVrcXQ4dll0ZUx5RTgwMFZHbXA0?=
 =?utf-8?B?RUFkSHpVbjVuU05ZdXdEeUU5NldmKzY4MXlXWXJIOHF5bnRRWndFUWFvSzA0?=
 =?utf-8?B?aTVBMlUrM1F3NUh3NzBROHZ0cUF1dW1KclBzZU1ITlpmU3RFT2tOTXZyZlVW?=
 =?utf-8?B?czdBc1k0S0lVVG5xcnVTM1NZeUlDdkRnU2RhcDdoVDlLY0lUbjBCQ3VRRUhq?=
 =?utf-8?B?b0FOZHJCdGZmY2hCY1IyUlBzSkkwQ1dXaldWSll3U0JTdXNIU0lXT3RNOHBm?=
 =?utf-8?B?V2UyRmYyUGc3bjYrbUMvM0JMSlRPWTZvL2hpUncyUU5DZVlrRG1tYXNpREVU?=
 =?utf-8?B?b1VVbEl3cG1JOVVoT3M1Ny9OaWt0dXdRV0FSVlVlZEY1TnMxNlZ3Vlg3M1JP?=
 =?utf-8?B?YjVuN0RWaWFHemp2OE43eHArY2hNTTFjT0FEcGNSSFBQZVQ3L1cwSFp6aExP?=
 =?utf-8?B?c29tbU1LZ3UyaXBqVWhCV3N5TmVOTnJvc0FDbDd3WUdIY0Q3dytQaHNPTE1U?=
 =?utf-8?B?bURFTkhyMUZ3TEhzU0w2YVhZZTRkM3JkQkpNUmtqTGd1NGJaSTh5RFdUTzZr?=
 =?utf-8?B?eVZ0UFBDSUUxQmpNaGFNNGhDSU12NHh5SHZJQ3F4aXhEQmpOSit3bUhCaG42?=
 =?utf-8?B?OHBzM2Faejg1R3EvdWpJd0JhcWJJRUE1Q1hBeCs4ejU0cGZuUGNVVENvK3J5?=
 =?utf-8?B?MDFZeGh3OTdmYkZIYzNZMTcrM0FDRXdYeFBVZzJyeko1WERBRE1hdlo2amh2?=
 =?utf-8?B?TElUSFQyV1NyRmVEV2d1TnNOcVNpajhNYVovelU1RTJabzd4YTVFNjArKzVr?=
 =?utf-8?B?dmhpdEQzZURjRmFsSXZwaFQzQW5jbWRkRk83RmJJNlZvZVdlclY1RU0xZlg1?=
 =?utf-8?B?R0RoSkVNV0k5WlVVNUtMSXc4MFhzenFuRWNlK3p0Wnh1YnREellpMkpLdUcr?=
 =?utf-8?B?YWNEdkd6ajlhODhlOERNa0VGamc4czVDVU02R3VUUGpLbEwrSnhKU2QvT01h?=
 =?utf-8?B?SEswSEVyK2o5QXh4enp5QVFweENIUCtTQ1VnOUFxSHN3bDkyRjU0dEdlU3Bn?=
 =?utf-8?B?ZmJXZVRQVnlEbzZ0NTRYZThNY2tZb1VjVHlLLzJhQ3BCS2NaNno2MDFYQS9k?=
 =?utf-8?B?RUFIdGsvZWVsV1Jxd2JwcDRaTm5CSk5qWkVKcDMvRk94OUViTnZYVDd5Ylhs?=
 =?utf-8?B?MEVPMkNFMkQ4WE1sOVpzTzhUdS8wRDhsRlRzN08weGFPek9IOHJqTk5Ec05X?=
 =?utf-8?B?UFhobGdKUVJtaTh2cnd2TzRNdWZzcU1uUVdlWVRuWTBmS25ONElud2pVSmll?=
 =?utf-8?B?UHV2MFhhQy9qOUFsY2NMUHhTUkVIcnZkZ0syaC9LN1RZSHRzMHIrb2lERmxl?=
 =?utf-8?B?a3FsZjBveHdoM3FFT0h5dEFrYkM1emxaV1d0NmNRSkxOdllhSndZbzZsUFF4?=
 =?utf-8?B?T1pzcFB5VnViaGpEdVJRMVdBdGxVZ2N1WFN6elVhdFF6eEZ6ZXFxRzJBMDBo?=
 =?utf-8?B?Y2tZUVlZalc3aWxrR0xReUdmeVBuTSttQ0wzeUNBUTZQUzRqdWVCRThwSENW?=
 =?utf-8?B?ak04STFuWlFlSUtONVhvbVhJTHc2Nm9hTTNOMDd5UGIwRS9lOW5IZ2tSeHNZ?=
 =?utf-8?B?RWh5N08rVnFyM3I0b3VmUUJpT3dqeDZFMThKRy9RVWVER3gxODBUWWpjaHBI?=
 =?utf-8?Q?IhZd/feeNAl6DgCahxBRTSI37?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb14d8bb-fabb-4e7d-dded-08dc3236de96
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7325.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 17:10:42.7955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xOOGu0YD3k07YTUCRzA20KVdQJYoTJxA7QS63WqFA3Fcg4nP170J0bILrdd3U9WjNE1bJJgPICOAYU9GZ0IZJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9404



On 2/20/2024 5:59 PM, M K, Muralidhara wrote:
> Hi Boris,
> 
> On 2/14/2024 1:22 PM, Borislav Petkov wrote:
>> Caution: This message originated from an External Source. Use proper 
>> caution when opening attachments, clicking links, or responding.
>>
>>
>> On Tue, Feb 13, 2024 at 09:35:14PM -0600, Yazen Ghannam wrote:
>>> I included questions in code comments where I think more attention is
>>> needed.
>>
>> Lemme look.
>>
>>> Also, I kept Naveen as a maintainer in case he's still interested.
>>
>> I don't mind that as long as he responds to bug reports from users and
>> addresses them in timely manner.
>>
>>> I did some basic testing on a 2P server system without ERST support.
>>> Mostly I tried to check out the memory layout of the structures. And I
>>> did some memory error injections to check out the record updating flow.
>>> I did some fixups after testing, so I apologize if I missed anything.
>>
>> Right, I'd like for Murali and/or Naveen to test the final version but
>> lemme go through them first.
>>
> Please include, we have worked previous versions of this patch set.
> Co-developed-by: naveenkrishna.chatradhi@amd.com
> Signed-off-by: naveenkrishna.chatradhi@amd.com
> Co-developed-by: muralidhara.mk@amd.com
> Signed-off-by: muralidhara.mk@amd.com
> Co-developed-by: sathyapriya.k@amd.com
> Signed-off-by: sathyapriya.k@amd.com
> 
>
Sorry, Just re-arranging the tags. Please add the below tags

Co-developed-by: naveenkrishna.chatradhi@amd.com
Signed-off-by: naveenkrishna.chatradhi@amd.com
Co-developed-by: muralidhara.mk@amd.com
Signed-off-by: muralidhara.mk@amd.com
Tested-by: sathyapriya.k@amd.com


>> Thx.
>>
>> -- 
>> Regards/Gruss,
>>      Boris.
>>
>> https://people.kernel.org/tglx/notes-about-netiquette
>>

