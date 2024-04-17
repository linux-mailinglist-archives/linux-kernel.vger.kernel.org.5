Return-Path: <linux-kernel+bounces-148195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACF18A7EF0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD04F281657
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C78128392;
	Wed, 17 Apr 2024 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N/zE5qVb"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5558127B40
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344239; cv=fail; b=ISR1w7ucsLh9BFOrj3BM5RTMOO9brRjybwQMSGXM41T1pEpWrGtI9L77LXvCgfkbHuNPUiCItOxN5jyV3ixvNG/mWku/Dr6bLmL/wbfvo+Tb1EWGfcAGejH4Xry4vWOmOcTQuSBfsN6mbhhfWPrtglVYRu0FkgEO21L5oLN5Pzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344239; c=relaxed/simple;
	bh=YqGVjwv5Xkvg8F69bxp39mneOBIt/Kyi0rQlsUMeeVs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=esF7+0dgsDXerki23IovvHyeHnxM8Kq90JpRgUeXZT1llbbJRXRCPZjVKGXyOitz2ObwqUe+opyurC41dEF2e3XJcZmIR516KJcHu+8ZPtzxDtix6uoUffUVn+juetoJ91HqpabtWX4QmMs6PE3WmQhnJCcTRlU/KRUXOuegb70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N/zE5qVb; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hy/BJNaiUkpoBgY4eSHpdl10GeDcj8V2kG43zeR8R4JyZbzZ+1LHt69f4OUPrsc0c8O6Sh0HPRWIC1lq9Q2Zvp3CijuuX9pCubTVNxavN/ToL3b67vFlN7nUffO5S6keR9dBar2HH4gXPnzW65Oe3SOd0NEkY+EfOtMIGa5toyuAfHdpjRnfpMwcbzNAoNNP/Q0XM0+hTxfEXXo8LpxrXz0P+MhkV4VjFi4Wja2/s92FpCuY/KTJBOtyNBGCZc7QtLMF9spSEXb9edogyam6H+H6s9H7YvBc3aFTI6tkuOeqaQ8LidKOYYctcK5rEHoPoBEHzo94ZY/y9OxnRvYtew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqGVjwv5Xkvg8F69bxp39mneOBIt/Kyi0rQlsUMeeVs=;
 b=QSBuKwN30JinUS0f/g2X4p2URbM/VUuYumFqtf+60iZVRcMOLL8IwvrqG5Z4Q/E02ZooenWFTVjhlMniqSChACR6/QLGi1YB7GAyH+IYG2XuuAI7ZaSrvxYbEuzHLtsOMSzAbHkkQyguffiXP9uzj1Ar9bmYJhhCXlg09NvhXTr/YnyCnSiVzCAz247J9RL0NVUYNSlFGnu5NW0jBJhPWGI6ZEBOXxNSzGR8iphMuMDaCfjGu+4NqDLZES4oVwmLGI0VZDKRCFmzr8YuAX+GjHP4uKj2kMzFPo/E/ua/K1K62mI5x/Ql27Jjo/SFEwNYFmacx4jvnHf5etOaMISZPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqGVjwv5Xkvg8F69bxp39mneOBIt/Kyi0rQlsUMeeVs=;
 b=N/zE5qVbuPlLlWLRJFjtZg6fPHXt4/ltE3AdaDFcKnFFj5M43qMWAeWyTbP/y47r4MOB8jOhLKGPWmcJedTO7+o7/+aBHJhB7lFo38jZI5bMskgtUz6dH90U4TpOZPrnii8aZfx7wS3WfLDu+b8PR1gKn1fEc+Uez5+nbzfeyN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA3PR12MB8046.namprd12.prod.outlook.com (2603:10b6:806:304::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Wed, 17 Apr 2024 08:57:15 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1%4]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 08:57:15 +0000
Message-ID: <6a83ebdc-0c9f-47d2-967b-d4ddea039da5@amd.com>
Date: Wed, 17 Apr 2024 14:27:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel 6.7 regression doesn't boot if using AMD eGPU
To: Eric Wagner <ewagner12@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com>
 <20240415163056.GP223006@ziepe.ca>
 <CAHudX3zhagFWBv4isZzAtC8dA7EAAtY6Yk7fkJ31hf0D9zrNqw@mail.gmail.com>
 <65d4d7e0-4d90-48d7-8e4a-d16800df148a@arm.com>
 <20240416003903.GR223006@ziepe.ca>
 <CAHudX3x-ofB=-K6UwWpf4r7Ge9AQbvLQ2qq2C7N-R5LG2qMz7Q@mail.gmail.com>
 <a80df9b9-92a5-4430-8802-1f8d159d6162@amd.com>
 <CAHudX3w63VPCjP5mxOePPosa+KkUw7eMRcJF=MJ-ktNO7CwXdg@mail.gmail.com>
Content-Language: en-US
From: Vasant Hegde <vashegde@amd.com>
In-Reply-To: <CAHudX3w63VPCjP5mxOePPosa+KkUw7eMRcJF=MJ-ktNO7CwXdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0223.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA3PR12MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: de14e1b1-2bed-4df2-20cb-08dc5ebc60ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ruWi42vH5WlPTLPKP0Z+0J2+9RkPzjouJHtmjpOTmpR+kTzPCLUZphVneUIcOl1KtYT+lEl8sOmg9gisJH4RtRi0TUBDqr8HktXLHA8hXHviFF7evWTkv2DO/loCOc17n8ELdkdYtM846ZOUd38FkaFgnDaec/7WFJqOyb5iUc0AFslaCKN9RxnSKnng9H9pX+eeVi0iyVPk3cxzEayoEHdzbnxhsq1DpCYFYleTSN7DIDLNSxgzmAonzQFJ4fh1U0kD+7Ru+vPCVHIczbHUrpXsedD55GrfazwtNZHS0GvRZFmz8XmWcI0MFK3Tx+/Mvg/RZb3bw9X0D+SGZTyBiNERTtkWDaAeZiyYdzqT/m4fT/sJUlahuzSGL9+zZJ3sV0M2mFw8N/svhcW4DuIs44K3AY7Qg241RrkFVcoaIlWMwVKM3A/Q2UnvXGLyVQxevbFo92V30Pq7q0MI7qgeh6c70LpTXZ9Mh4Tp50PTkNMWi7H7zkv74dJulcTo+PXTJ0Vn9tFGyJVgN0T5g75vPNqWQwhpUziOxllqbLYKxMSeQ+yikp0uEdxns5TrAJjjdS1iy0JdLinTDGbVraDu7vOHjLJS1FU1HtKRvIDwmo3mTHOFKPrgBrA5VuYn8n5u7AvJxVrBPV10Kc/j262Y7EFesexE3avpuNkJDfhkotM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDdrQ3ZveERkZjdPMnRjOUcyVUFYTmhRcG5Lekh4djdVRWZFbHB2Z2dIMEZX?=
 =?utf-8?B?eWUwREQvODJsdGR4OWE2R3FsUnV5WDczd2VQb1l2T1ZDUVBzYSt0d1dXTmdv?=
 =?utf-8?B?Zy9xdEV5bXE2UDB1dWJTajljYVFVM2dWOWtodGZGY2VGdGxSalZKWit4dENE?=
 =?utf-8?B?SzZudzNXSEJ1Vmpkay9hRWYzZS9GNWttazZzdkJmM1cvcWc0QmFWTFpRWVp0?=
 =?utf-8?B?OE1LR3YxZzAzSXI0aS9ubmRnaFRRbVp0LzJyeXR0bTFFNHZIaDJnU3BNeWpX?=
 =?utf-8?B?aTJtUXdHWVJiNUo4d2UweDRNQTNkQlFNZW4zcEgwVVVPcFcxNkllZXg0RmpB?=
 =?utf-8?B?eW1tT0NRbkVYNFZ2WDRyeVFzM21XRHV0OWRaUmdobDJlc0k4ZEVabU9BWVIr?=
 =?utf-8?B?WkszOTVTS2hYYkNPZjR3WkNEMHY3NFd0b0hzMEYrbFMrZkQ2bTF4M2J5aFN1?=
 =?utf-8?B?OFNGVDVGRTUvK1I0TUNYWGVPV1lWMzJkU3J0b1BtSU56TW9iK0tpZ1MyR21k?=
 =?utf-8?B?T2xndHExOWNqajFtQjVwRk9RU1dLMXpJWU1ndy95ZnVMWTR3Zlc3N3FCQUU1?=
 =?utf-8?B?eGNBT1lub2tEQVJJQm9hWHRBNkNveWxJY3FYWHBlUUFGdk1KK05QWi9vV3o0?=
 =?utf-8?B?VkkwWU5VZUkwWGpXQkNGdytNNjcvZm90VjdhL201cXlaenp4VnlENlFNdTg1?=
 =?utf-8?B?NHY3ZG5rZHFFNFJZb1ZjcXR0NkZzMGg2Z052UmdJMkRXaVJEVDZPZ09abmdD?=
 =?utf-8?B?NHdHUEhkRDRoNVhQYkxCY0EvdjR2dEROMzFnZ1d4ODFMcHZGK1ZTT1pOT2dC?=
 =?utf-8?B?OWlaVEFwZ0lNQUNtWVFGc1hDckJ5ZlgyQXIrL2ZrNUtPZWJwckhwVHNEVDBW?=
 =?utf-8?B?L3lGU0FPS0ZzNjk4bHFWOU1mbDA4bWFTaHJobWk1czVod3JtZzlCR0lFSUNV?=
 =?utf-8?B?Q0l5eEZua2lBcElqUitYQ1NkREVuNHdoL1JyeE5tbzR2RlU2Sm9MRytxVHY0?=
 =?utf-8?B?R3A1M2t6OVFRY20vSDZPWFdlY01YU2JMeFJjSWFYVXZqQXprMm5HUDhqTXJS?=
 =?utf-8?B?OGl3cWRWY3ArRkFROHBHakNSc29YUXJOeHBGaWJFVU9ySFZLblZUbTVHVWQy?=
 =?utf-8?B?VUNtVmVnT25uT2NBZlhWOWhJUm9pUXJDemNpdjNXRDBqbXB5ZHF2dnlPelJQ?=
 =?utf-8?B?dU1lZno0SC9JS3o3dHRwMXBicU4rQXd0ZVdhWVpDb0c4ZzcwcXh1QzBIZ20v?=
 =?utf-8?B?TjN2QTVLYUFFSzZmWi8vL1hId2xNaWNnWm84NEZHcUc4YzdWY1piTnRlMitV?=
 =?utf-8?B?YzNBbVB3VEo2VWIwRW5PNmczVDZMdTNLRFBKNmNBcEt1OG50YWlwNzRIM1hj?=
 =?utf-8?B?bkZISjdvaGRhN2pWLzhpdnp1cTg4UWVnaVl2WTJXTlJiSmNHWEFDVzk3dGc4?=
 =?utf-8?B?OWdZNDlQYW1MWnFveW5IUVI2czJoVkxOdUZCeXRZd1hBSVBXbjdtVG5XbWky?=
 =?utf-8?B?bVlPYml2Q0JHZUI5OVc3ZnRLeFBqSHVjTmNrTkpWRC9xQXhtRzlVaGg5QlpX?=
 =?utf-8?B?RnN4VVYvNmpXNmFkSEZiRkhWckNLU2FDOFoydDBEdXpVYW5Tc2k0L2Rha05u?=
 =?utf-8?B?bHdhOURwU0xrYkE3Y0VRT2JsVHFaVWdHeUNJQ1NjSWtTdE43TWZMME90V1lN?=
 =?utf-8?B?NVhVU3N3MVIxeXlSVXlQdTN4bkJ6TEc0TWVCODVDaStyODRHRnFNWWhRYlhL?=
 =?utf-8?B?S0FRN0RIVHNEN3ZJNjJ0WkJwUFJFcEF1VXhuZy82Q0Fka0NOZ1o1NzArajho?=
 =?utf-8?B?MmJYYzNkLzQwZG1US2hlMkhTcFRISnJIenhsNzloVHVkRjJybGNjczFQWFo5?=
 =?utf-8?B?S2VJVGZxQ0tNQ0hGVWxHSnlRYWJta3RJYi8wTmtKbWV6M0hsSFFxMkJLTURt?=
 =?utf-8?B?U2l4bHZLMVR4djV5WnZOSGhQd1gycCsyTU40OXdOU3kyUGc5ZXAzQTJ3WmRU?=
 =?utf-8?B?NTU5bXg5ZVhiaTZiVnRwM1pXMVNXejZUZ2dzaklIWURuT3FmMzdyZS9Fb2g5?=
 =?utf-8?B?NWw2TitwSWNZdWhEU3dTbGVOYmlEL3hVdGlTQWczZ0VDclB3MEVTSWx6UHVi?=
 =?utf-8?Q?p7WqZg0JPszcOa8iCg7Duab6x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de14e1b1-2bed-4df2-20cb-08dc5ebc60ac
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 08:57:15.1859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkbG4LjlQXxcEopxh3Xc4tTLKydyMaUFamAfF1AQFEu1inzIX0a2HfTh63g9F6INSKIMbQuc8DklkMB7ak7vFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8046



On 4/17/2024 7:46 AM, Eric Wagner wrote:
> On Tue, Apr 16, 2024 at 6:53 AM Vasant Hegde <vashegde@amd.com> wrote:
>>
>> Hi Eric,
>>
>

../...

>>>
>>>
>>> As it booted ok with Robin's patch above, these changes to
>>> drivers/iommu/amd/iommu.c didn't seem to make a difference for me. I was testing
>>> with amd iommu v2 off in the kernel config and I also have TSME enabled in the
>>> BIOS if that matters.
>>
>> TMSE is transparent to OS. So its fine.
>>
>> -Vasant
>>
> Output of lspci -vvv and /proc/cmdline attached.

Thanks Eric.

-Vasant


