Return-Path: <linux-kernel+bounces-39246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFE283CD69
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4571F238A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3FA137C38;
	Thu, 25 Jan 2024 20:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0Eh27rwu"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A73135A5E;
	Thu, 25 Jan 2024 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706214446; cv=fail; b=VD46GDbF0LaGDEeE2pAq4vZiCXn8b2S4CQnPo3bSX2MF50s6FzaDBq2AOwx91Skuia4z+8qCKYJTl9RK4cUxrSMDrrCCsx+XGTgULwrFdBz0JbEI0gQ7wDoGkqxNpw49WnZ7PWXpi9Ghxdi8iXtFpaNWr+xXojW6FdDpzv5YTIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706214446; c=relaxed/simple;
	bh=3uVlqXnnf82gJshvX125VcjvHME5NYOoO4DTEDz9s/Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NntRGTW/JJxMGHaftamgBlLGH7vi6qpqNyAuL4K/0wnxKCFy+agw0lgaIZIGOJyYAhNrosXt+Ih5m6xZr+Aj2DD1qvIhdFkFHOHqoM86MlUi6Hl58sIh4OcN2v2GBFp5tedHBtGLrWJAH74T4tAf6DZAYmAhN2b9c++D3ZxV1V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0Eh27rwu; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckvjRzM5r6VA4EfCODt5jfk49M3PycsRngn4zL5BLLZ9LnoaZQIDfVa3fdXgn+iufkFUMiO3zydGo08X+ZAD7ounGuDnNNzMYbhsw3VzZ9o6RikOlTEE1fbYraqqpqumbGbhd4+RNc3Vxh+7oPKjqnCzCa9JdEYBV/QyWWJJJtC3dzsfTqNpdlEQTExkt3C13INLxFxXLS8JgCxYOwDphoqJBV1vd98EsDNiDOcB1EbhLNXzIysrLsY3B99LFkHO9LnaBlaXMY6Nmyct1lxTsClo2A4swUI8HsHr5ZWb8QTsR3Kmhr0v7FRKNacM9Cd7ZgV/UgE7FkMinFW+Yyrcwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAj5esoDMPQuTXi32h7bsfi2tTRWLJNj9D+Mqh2AwPY=;
 b=hsK3svyRQyimouVkfGI6SHq6UH9xUttBgfxfHUKWDxOQzo89nz41iW+IOErnnj5fA9B7vNDQV0dBFZGPivGMrBVhnCj5KRami0ThdXrjDe9Byn3QUvr9qDzlitLOnFFvmQ90gBHKDofJMIl3VUGucGLVxD70RytN9OZfF5YQgydIpTxUiniQZ4p7KULXUqBBqedVrW0UgIBTW+WyiLwR7o0p1Cz7uTEVvj8rlfSNxrIV4haQhIlsqTWkfn0i2HRTcW/WF1/hE4r1eAIBzO7roKJ3OuGF72Ixrdbwo5OL41/r3x03NdF3qrCp2RcaSg2kyE6i0KD7I4xMuIH3D2bvSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAj5esoDMPQuTXi32h7bsfi2tTRWLJNj9D+Mqh2AwPY=;
 b=0Eh27rwu6+ejdGLYdd6yzzwVX5Ppe/ZCdYZdQ2CFNLKDD39obRh5ZYwI7ZRbLBbfS0SjDHKN3sK7xnshGqkhpT62pKSqktLotErap2BHyNmvPczyMhvK2mRTnubTmpSG+vloIfwu9pwk+OUUH/kYuVwSyUn91LzGtsZ9b+FqNKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by SN7PR12MB7785.namprd12.prod.outlook.com (2603:10b6:806:346::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 20:27:19 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4%4]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 20:27:19 +0000
Message-ID: <5de5637f-6572-4817-aab5-af60fc1c81bf@amd.com>
Date: Thu, 25 Jan 2024 14:27:16 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Update mce_record tracepoint
To: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc: "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>, "x86@kernel.org"
 <x86@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "yazen.ghannam@amd.com"
 <yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>
References: <20240125184857.851355-1-avadhut.naik@amd.com>
 <20240125185821.GDZbKvTW93APAiY1LP@fat_crate.local>
 <SJ1PR11MB6083DAA7A6EDBBDAF5987A80FC7A2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <SJ1PR11MB6083DAA7A6EDBBDAF5987A80FC7A2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:805:f2::21) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|SN7PR12MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c74bf4-0508-484e-9a7f-08dc1de4076b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r/1/mbuV1NOWsSjoS6gMRSOX2+XWqMy/G8IA1VAeOa/fHRXZhnjZdIOnLOckDGqMsNLhq8WkgbtlnELifZNZ5IfejNcvpUgurS6CKxwgkaTX3KmtxYsUbB/8dCBgbOgIhWrp517OAUjPCgUrRToaUnecA56SFHV0+i7Ng6PwxwRTqWJgs56saBegMgfeALVAT2sDsL4GR+iuUxWiCcFu57XOq7Ry+gJIeO0Zz56heZFre5wq/Uc6uatX1UfZdSnIxwSGiTmQbABJ6GJ/18+58KJC0Sh325iZ93ZipJKls1JqKC3xpkY2QqE/Yu9WSyyU/lVgVxqYZL+ZpCnMQUH73D3JTMqGTR1XzIfp5zMneuryBNqidYFeOca6IxabHn6nxZMwKG99+Pd6JRPFYfA+gGju6vKCuzSxsTXAE55wvpBlXSNV19Z4es1kIe+WtCpN0qQ/wtyGlR6iIQrcuCmooZmtpNK/VI6gDl7J/yf0D9TnbFJfmDUjkENszJPBP22c9iH2yY0+mkGUhJ0skduNPxjUV3nlf+DEP+tEDT6WTcn+t+8YlG63hzeBvdMW970eLoF41ikKn4YNI/9s0cYyoCpdd2yaLhNyIGWQg/Va1RtkuyqmLZqmeLQ+pO/A5khvN/JRDMshjO0rg1DHQ4CjPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(396003)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(110136005)(8676002)(8936002)(2906002)(4326008)(15650500001)(5660300002)(316002)(66476007)(31696002)(6486002)(54906003)(66946007)(66556008)(36756003)(2616005)(478600001)(53546011)(38100700002)(6512007)(6506007)(6666004)(83380400001)(41300700001)(31686004)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0crTi95TUtQRTJlZWhXbngvRFZOZWppdjUyMGp3LzFQYXBFVWN2Tkg2blpU?=
 =?utf-8?B?YlZkMW1zcHhwbzRpNFNqc1hKTXhlRmhCNkc0czJQYktKeDdQS0s0OFI0dSsr?=
 =?utf-8?B?QzUyWlRWYmZheUk3dEFGN1hoUkwzcW9POWh4MEJ6NXFFTWlMTXErU3dLVEVZ?=
 =?utf-8?B?dHJwVG1ZRjFjNHJINmQzVFdndGFyeERQYnVuU09PTCtCSFFNYU5Cd0pUbks2?=
 =?utf-8?B?YWFwUGNRMkR2Vm50NUVKdEpxZFZlOExiRks0NGNWV0NGL0piaHEwdXk2WW94?=
 =?utf-8?B?MGlyRytKaURsQVBEc3V6YW1vSmppV2dXS2IrcWhGRENyVitaa09BREI1Z013?=
 =?utf-8?B?aFlBYkpPTEFUcGs3Smc4S1RmQXd1K0s2YSt5ajdZdm5WcFJGdDIvcjdCVllQ?=
 =?utf-8?B?VGV0ckNCUVU0Qnl2VUpFTnNPZW1HZmw0TzVhck5ZSktjdHBRbXlBWGMzSGtk?=
 =?utf-8?B?aDN5Z0FEVHpUWkZDVDFabDd5dGJYdHBtRE9GTHdzM202NHdFR3VLdUExSEFQ?=
 =?utf-8?B?WXFGVkp1c1dvL1pSS2xVSUszcUcrV2s3RFIrK3Z6NXVzbGVScjE4SXQ0dWZF?=
 =?utf-8?B?dmVGOEpYQ0hMQ0tseWtRT285bVhzY2JBcmR2a1BiS0drNDZGNTR6cFhFT3lX?=
 =?utf-8?B?VVRpdXE0UURPdVdqeVMySnN3aEVoMVNueVdQVGRhWGZ3QStVVjhVcWtwWnJY?=
 =?utf-8?B?UlExRGZrVnIrYjdKRld2WTBWRmpxNXNvb2ZONWhTODEySmgxTTNqUmNYNGRW?=
 =?utf-8?B?UTdET05sZWdaTDlUQkJYOU4wQ2JEZ0J6VnFqL3ZMbUdUS0J4OWpaampmTVpY?=
 =?utf-8?B?K2U3TDc0YXRUK3N5VUtYdUlRZUlWdndnbzN6OHhyaDdtSmZhbmpFMWRJZlNB?=
 =?utf-8?B?VmR1ekZmOTMvaDJzVkpXZzh1Njc3RUR0bUMvUnRvKzZYaEE3cGEzVGVla2Zh?=
 =?utf-8?B?RXVnS3hPcFJxOGozbFJIZGdWTEJuczZEOVZwYnZjeDNYdmlicTNxdWptcXUy?=
 =?utf-8?B?bHowMWMxVHdkUnJzRS9mVTl3aXJTS0w5ak54WUVjekRSYXQrUVgxc0NNY3Ju?=
 =?utf-8?B?bWtZMm44ZHFZai9ZYTJxNy9oRDRsakQ1NTJtREVnSFRVSkE2NVdvSmlGNWVu?=
 =?utf-8?B?bnZmWHNXSjVJUXFMTUoxU2VxVnkxcDd6Tk82Z0k3cDFZU21sZDVpWFpCNldq?=
 =?utf-8?B?dW5NZ3AxZ3FLZDgzb0p3MitZb2RraXQ1QmtVNnF0ckI4SmllYWNKOTNuUzl2?=
 =?utf-8?B?T0pjLzdFY0gzUzVpUzQvNHpoWUk4VFV1anFad0dKNE56VDZ4RkxGRGRVOUVI?=
 =?utf-8?B?cnU4ZW9IbEJJVDNwNEkyWnYwUjkyODJpYjlucWNMZEV1dFkzQjdpUHdLKytt?=
 =?utf-8?B?bkx3dDZKQXFTNzdLcWUyWi9yU0YyUWpQd0dYT0VmaURHTjdJOXgxNUdMNUdX?=
 =?utf-8?B?Q1pNc2VBV3RKOXd6QlBTQjlmSWkrVHdpWS81T1N6OFFOcE54QU16QkZMdXlI?=
 =?utf-8?B?US9mVFJGbWdkWmdsTGdxalBuTGR3cVN1MU5kQ0daQVhpK09DYjhtRmxXUXNB?=
 =?utf-8?B?OThtZk5VS0tBcU9naW5ZK1pqWG50SmVRTTZ1Z3poSjZQd2dRQUhwSlRhdldp?=
 =?utf-8?B?ZUxGanU0bkh3VjdtVk1GYUdGVjAvVFVrSWswc0pMV0poQmJwL1M4S2licjRV?=
 =?utf-8?B?TzVUb2MrcVJ6Vm5abk5VYU02ejFTeHRrdW4zTGNZQkxWMTZKVFdrT0E0eFgr?=
 =?utf-8?B?blZ5clZ1RzBwb2l3MGdkcHU5eFJER3cxRENQWGtDNTVyRGFYRGJML3phcGMz?=
 =?utf-8?B?TVlESzBsVmgrYnY3dHNLaDRFWkVmVkxYaGJGeXVyU1hlV09NMklJTFp6SnhZ?=
 =?utf-8?B?L0Q0ZTNHc1R3MUJEcVFvWjUzU1dXYk9kRlE3bmQwSEdhTXdpYm9JYU1vYnhi?=
 =?utf-8?B?bG5RbFp2Ry9ieFE5RVNobjhOT3kreDViQW1SU1MySmN3azFqUU1KYUlHZEpC?=
 =?utf-8?B?Mk95OFk1ZFM2dytjMlI3V25YaHJvUnZlMllRajBTbkRLVCtYUTRndTNvVTI2?=
 =?utf-8?B?NW84RXV0V3hwOVBpVE1IWk5NN1ByV0haWDEveXVMelVyTjd2Ly9aTWtZU09k?=
 =?utf-8?Q?jdzTzdDeOhCzWE2jyqphoThXf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c74bf4-0508-484e-9a7f-08dc1de4076b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 20:27:19.5772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIphPM1O7ZiB1x6asqyTWRAeFFvOlqOVAX7iyOPEjBBkBntc3SIWjBIygxrrfgIPFM/47f9p/roYgMK+LkLybA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7785

Hi,

On 1/25/2024 1:19 PM, Luck, Tony wrote:
>>> The first patch adds PPIN (Protected Processor Inventory Number) field to
>>> the tracepoint.
>>>
>>> The second patch adds the microcode field (Microcode Revision) to the
>>> tracepoint.
>>
>> This is a lot of static information to add to *every* MCE.
> 
> 8 bytes for PPIN, 4 more for microcode.
> 
> Number of recoverable machine checks per system .... I hope the monthly rate should
> be countable on my fingers. If a system is getting more than that, then people should
> be looking at fixing the underlying problem.
> 
> Corrected errors are much more common. Though Linux takes action to limit the
> rate when storms occur. So maybe hundreds or small numbers of thousands of
> error trace records? Increase in trace buffer consumption still measured in Kbytes
> not Mbytes. Server systems that do machine check reporting now start at tens of
> GBytes memory.
> 
>> And where does it end? Stick full dmesg in the tracepoint too?
> 
> Seems like overkill.
> 
>> What is the real-life use case here?
> 
> Systems using rasdaemon to track errors will be able to track both of these
> (I assume that Naik has plans to update rasdaemon to capture and save these
> new fields).
> 
Yes, I do intend to submit a pull request to the rasdaemon to parse and log these
new fields.

> PPIN is useful when talking to the CPU vendor about patterns of similar errors
> seen across a cluster.
> 
> MICROCODE - gives a fast path to root cause problems that have already
> been fixed in a microcode update.
> 
> -Tony

-- 
Thanks,
Avadhut Naik

