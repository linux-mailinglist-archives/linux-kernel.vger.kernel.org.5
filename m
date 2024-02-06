Return-Path: <linux-kernel+bounces-54965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D5784B591
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C1E1C23094
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933DD12F382;
	Tue,  6 Feb 2024 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EdM/HsDR"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFB112E1D8;
	Tue,  6 Feb 2024 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707223905; cv=fail; b=FruYdZ19pkHe34nKgBJKMs9t+POJyFc4+jPydobrzZDWn4MjnKCZK9A3n0EXPyN1kZ3Kmi2cZXVeJjQKlcPE2Aapc3A/JlrNnaxJcLXPkRYebGN+BPxmKzv1q9MpkDSEEmg7VC46vu9JQH0E6vLTG5v3+tTRW9PpI3eSFMY4L6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707223905; c=relaxed/simple;
	bh=nwZSEyhkivcKPUsTIOR8WXc68V6eBzEpWenP7Ppk5oM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qVXRXATmSAIKjmzq9/a096lR1twfGUyzQlAjiqMKWSKFhY37/6iR676XnTfNQ5bwnv3AAhS4Ee2qV3acK4S+33KKI+IfTKrBWLCUfEKFdozppRW1Gmwx6EEzyVzC5gS0kdp/sQagdGVr9FnJGjog/ZaPbTfaz4d7boB7y+YxwMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EdM/HsDR; arc=fail smtp.client-ip=40.107.101.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNyJtXD3n3hzlpetohDmOsOfQ0uFDN2RKOSHMBeamOAf01gmSSf2JTRRbswaBsSTAVV9ocYIqsvYlhU+1sBE2tMVH3ihSoNDoklwb3PFow0UrB257VwPAAk2+qRPyp4BQUcDI/0xJeYcIWioSl5pkBBZLDfJUC9qAuCdp+G3ojHmAhnyjhAG5/LkC5dwKV9XWnxESJyirWKr1DZ/bY0JTxwa9fmOtjzn3NuUm1xJ1Jekmb+CUm4O7uS14oQB6AD3F0he/qlYYuUd+F8IBNBwF6khxCJlzkcDYtAZ83p/WXcD0qOzbl92O62Ak88H4xGwE1vo2hKoXH3PmRyROaxe9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1eza8fI4qhbU8UoCdE8XQyrzGZ5/0JE12EamSLnKXo=;
 b=CUrkMcJ4rtGZP4mannATYHQmoJOdrVTxSQBV+gv7U4ZcTFsI7Z9yzeHHulqRp5/C/E0eWb/ih6CupojzFvDmtPNG9ZYYb15BrZqP9kzXlaFGwiVO7IQKyyxZs5FKelKPvMoD2HwqasDuwCbZ1YHFXFjuj7BaruIV/hrGgBjXvF0IWkpa/cwR/UATkvHocOPIRnMtsBuf1uQEhWFHi/RqqtEm3TFWbAq/bUpoiE0BuYWgRw9zXjKNE7drwnhg+/2oXmYXKtdCMBFWlwQx8HZLDlm/Zh5sSIUi6/2RhEJ+NJgh6qcM2ZX3f8VlQLXLLEcktK6Nwfl9Zi6kAaO+35HJkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1eza8fI4qhbU8UoCdE8XQyrzGZ5/0JE12EamSLnKXo=;
 b=EdM/HsDRLQcVttvTBFoYs32cxvHEQ1rEP2rRnj4Q9lQCqjhlHZsLXZj5GxanI7B24j0tyQShc7ANWVQ6wd+linMbksHmG5B94ZR40tpRWZ8Pg8VdzKTaBYNayF3YVAGHlI0Ren3Q4Lx6iVcRUF9EzIBufsm9ct9bCkc2EXvWeW3yK39PiIfAbg7hHaMhTvgJ/idlHcOlFW0Kh2c/1yqxp15hoM6+XA2OdN9iWU9whsTjoowsROg3TCs2+SZF/MIdvd/tpfjaqCbUhssIF1p6tmdiUQ/sGMMRfd1n0y/J+M37ttRfqsj09AjvqRtye+m/AvYtj/cnRZroYgq59O8YgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 PH7PR12MB6417.namprd12.prod.outlook.com (2603:10b6:510:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 12:51:40 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe%3]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 12:51:40 +0000
Message-ID: <c7e71e7e-ef01-4539-b481-9f4a95e6a444@nvidia.com>
Date: Tue, 6 Feb 2024 12:51:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch] memory: tegra: Skip SID override from Guest VM
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
To: Marc Zyngier <maz@kernel.org>, Sumit Gupta <sumitg@nvidia.com>
Cc: treding@nvidia.com, krzysztof.kozlowski@linaro.org, mark.rutland@arm.com,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 amhetre@nvidia.com, bbasu@nvidia.com
References: <20240206114852.8472-1-sumitg@nvidia.com>
 <86wmrh6b2n.wl-maz@kernel.org>
 <252d6094-b2d6-496d-b28f-93507a193ede@nvidia.com>
In-Reply-To: <252d6094-b2d6-496d-b28f-93507a193ede@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0204.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::24) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|PH7PR12MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: da4dcab8-9278-419d-fc6d-08dc27125ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mernuPbYYGveJs/qg410WkOg0KEIzSvFUPuNqQnbCzs1kExrixZzowsYe1iH2oLbX/krqqbzpnQWeYzwu3BdD4JYzn1YsnPEC8tkyln49QbpVzQq0/ECDQLZD0pAASHhCnKocx3rqMKrHShxgO/Mst518p6YrohLsuPazy5lBuK4dzXR8cF1SytVw53wn1ta0iLIrOFiQX9ROMEHKBjtdVh7HeT9X4NRVLXGcsf46ZgQ2SgwPMkmBf39nyUQPHLbiD1WPqBMSYtXxFvfX5/ZICSSlVimMGmi0PB9B4CcAr6OOBmqZN7oJeHbwrKCXpBvVUUhjKzAdvp3/NHCuyyKu9qIjM6EKd2oDLqNCEva+31hEy9k8PVRVLzwTsZV5Bd7V0/T2Zqxulb29+/hT3/NztadSrwXupmhKecMDa/kYsuzITjRh2tUM/XDDV/3O8jjJutRwsoTarcmrmT0A3il2h+itUV8NCRxSSJoLjGkirCLd087t2FSUVTQI+IPAc+I/A66UvBl4eMzfvkgtUMYH79/NCl16wpCBHIfCwxXonBowVSRbkee+ssUGiL9rhY4ciba4LKGProN2pLYvTQL2IslyOZaP3Q6Sn9HXH+8ul6n9vaRbGZhI4Se6j9rE/4gSu4uQo4PZ1PXZKzycWtfb1pkX5vMtp34gtW/SL/JjzfKkzCJ2Hugq2VRE9E0nEAx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(41300700001)(26005)(53546011)(55236004)(6512007)(6666004)(6506007)(107886003)(66946007)(8676002)(66476007)(66556008)(8936002)(2906002)(4744005)(5660300002)(86362001)(966005)(478600001)(31696002)(6486002)(2616005)(83380400001)(110136005)(6636002)(316002)(38100700002)(31686004)(4326008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WU5oWGx3S0dHbDNuUk85NlRQTXhKUzFrY0YzUTFoWTFTbEdZV2E0d0tGa0py?=
 =?utf-8?B?ZklCUXlhT2VlZDg3c0lFNXJxTi9WWXlEa3lOandMTUlSM3FVT2hESkFRZG5a?=
 =?utf-8?B?NE9xbHhqM0YydVN4RVpwVk1yQW5VdWIxTjdQaklLTWNHNGRGYzZpMUk0UURE?=
 =?utf-8?B?RDUzVHlnZmhYUjZwZ0xTTTdsU1VvdWMxMUNPQ3UzSWZYNGZSbXRVZ1ZaQWM0?=
 =?utf-8?B?cS91bzBadUpNUERPSFBkSXQraythQ0UxSER0ZkRaU2pUclYwVVNkc2h5TWR4?=
 =?utf-8?B?elhOS3NMM0RGeklBY2pkM0lORHpIZ2JRVmg3a2Yxb01lVDBOc1R4ZHJBUXBp?=
 =?utf-8?B?NjJVdFhTQWE1bGxPVEg0T25xNWtRYlk3T25rTG1rbGdlL0JqZkJWVjJpQUxD?=
 =?utf-8?B?VWJJRVlaM1kxTVNweUVicUhPMGhTUzBpczFCQ0VKZEViUk9jSUk3QVBmMFVr?=
 =?utf-8?B?cTM1Q0xJQXdlcDRoNUNhMTJmeFZGTnpBTnE2cGpBcVg1MWZXdVY0V0ZucFFo?=
 =?utf-8?B?UVVBOXE2N2JMcndFRGF0aEU4UkE2S2ZIOTlHN3ZYMVpjZGh0aU1HSlRBaHFt?=
 =?utf-8?B?Y1RNQlIxc3JGV0MvTzV3K0xZbDN1L1F6eVFjeDJGeEd0VHhuemluU3c2Tnl1?=
 =?utf-8?B?cG13aWhYSUJTWlJvdEdHeDVNUzlYTGViVDlkZTFOTDhLdTBSWkhCS2U0R0o4?=
 =?utf-8?B?dFVMdW44WXVMcmkzS1J2VFcwM2FiWDJyM3pxYk9VZjJ6T0JQRmdNTGtFelhD?=
 =?utf-8?B?cXlDMVNWQW1FakxOSFpWRmZrV1h0WTM0aTZNeUloSlEvYmw4NHpBMU84QWlL?=
 =?utf-8?B?eW5lLzcyRTkzZ04vWDZ3SU0wT2JZamJld05VUzRKRHd1S1VDUXhSd2dZWTlm?=
 =?utf-8?B?WjJ3NFZKeW5aQ1FXeHE1eFlBaHBldjB4KzNVWmZhODBNTjhtVC9JK2g1N1E2?=
 =?utf-8?B?VXU3MFl0YmF6V3FjMlFaalFzS2lyYU45cXhsUGc4SE5mMk5KWktqYTlhV0d0?=
 =?utf-8?B?NzFHL1B6aEpKSldKT1pEOFJYUWNZRXVNblBuTGl1OHlPa01XamtHK1pBaVBT?=
 =?utf-8?B?aHVDYlhXMG84MFBSYk81dmViYXpRME1Tc2FsZU5lTUR2b0JZZHNHdUY0SGph?=
 =?utf-8?B?ZnhlM3BuMm0wQit0QnJOeEZiODQ5UUNCQW9VcVRQQk1tRW4vakNvVG5hdVFu?=
 =?utf-8?B?TDhrUWFtUmVmdEl6K2NKaTV5b3lWQm03clU0SGFkU0ppUHlvdWlkWUhibHA2?=
 =?utf-8?B?SjVtc0hMZkU2ZGN1ZTg2Y01vSG1qTXVvOVFjc0tzZlJyNUI0L3lmZ005czBJ?=
 =?utf-8?B?MlJQaUZYbytwczhzaDBxaHpOODZmendiNGY2QVhic05raW95ZVc2Z2pkZllz?=
 =?utf-8?B?TTRBQjdMY2FCb0cyOUlkalErWjhSTnpPMHlOdTdrWC9NbkxJT1kzM0U5K3dv?=
 =?utf-8?B?M3gyUHJaSTBKNGplUnFRVkdtNVpXTnc2T3EzMGJSR01qMEdpdWhoZlRYNU0y?=
 =?utf-8?B?d05USHVQYmtTRUxJTkpjdTFudktQNnQzZ2NCNmlJTklXZXJTNHpkeFpHSWRv?=
 =?utf-8?B?UzhvN1BlckQ5STNJcW1qa3ZyUjB0ekJyTm55SGtza05XazhFTjZycW9xTXhZ?=
 =?utf-8?B?ZE5ZN21KSFlaRFBJVjNMblhxaVRkZ3BROC9kaGhFT1kxdHRWdTM1Mk5OZTFQ?=
 =?utf-8?B?a3dIQWZBaGw3VWZDUi8wRXBXTUxZd0tSd0FLVE95R2xudStlempGOGtsTCs2?=
 =?utf-8?B?VkdJeXM1WWZWZEdVZ1d6bFdpcFV4VnVnb3VnNUwxQ2lnMzhqYmdYMm5qWGRw?=
 =?utf-8?B?U2tSWlU5UlNiQVdYMUl0L2swWXVLSXFlcEFmRFoyaVZXYm10QTdsY0pqbjdv?=
 =?utf-8?B?Z1NHbVdaLzdWUXZxTmxUeUg3emZSTlFhQURsNjBOV0d4a0E4YkRMRTlibGlT?=
 =?utf-8?B?NTBDaWxiRWFSWFlQWVdQMEJNTElqWFZWR3JJNWhLUXpyaVRudFIxb2tCSldz?=
 =?utf-8?B?MHY0NzFkM3BQYk9VRC8wYVVXWXlVUlV6NHA0MTM1OUxQcm1OQkZuMGJFMWIr?=
 =?utf-8?B?ZTZVa21pMmp6N2prUGRxOVE2VkZVU0NZei9qcXA0ZlVBT2pvMlJmYm9CLzgr?=
 =?utf-8?B?Y28wcTFGQnVyeFBlZGtDSnlxZ3lSY1BSSkgyVkVNcndGZFcrYmJzbDJaRDFX?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4dcab8-9278-419d-fc6d-08dc27125ce4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 12:51:40.3606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLByMU2wECGsb8ZQpQJFAD35UTfdGHeLSj3abneUz/zOhjdwmimbaIBtom8WDFRSCvjoB39PdoRjYLEf3j8B3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6417


On 06/02/2024 12:28, Jon Hunter wrote:

..

>> - My own tegra186 HW doesn't have VHE, since it is ARMv8.0, and this
>>    helper will always return 'false'. How could this result in
>>    something that still works? Can I get a free CPU upgrade?
> 
> I thought this API just checks to see if we are in EL2?


Sorry to add a bit more info, I see EL2 is used for hypervisor [0], but 
on my Tegra186 with no hypervisor I see ...

  CPU: All CPU(s) started at EL2

Jon

[0] 
https://developer.arm.com/documentation/102412/0103/Privilege-and-Exception-levels/Exception-levels

-- 
nvpublic

