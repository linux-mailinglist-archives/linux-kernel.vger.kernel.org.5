Return-Path: <linux-kernel+bounces-103640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E050087C248
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5451C21957
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E65374BFA;
	Thu, 14 Mar 2024 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OPF0Bqaa"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57A11A38EC;
	Thu, 14 Mar 2024 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710438911; cv=fail; b=QR1WUrqKLyll8LuZPHHJq0jDjhl5Qb/WdksNtr12KdyfB0ZVyDShcUeGIDjam0FDTo3k7frc8YWWA1xD7dk2Kys0HadSY6v7lJIgPSVdfL/kzQLkzpJS2BDUr+UyxYB2XBBwHIFiQqGNjDROxhqp+6fUvVIztbpmYX2JFgNfU+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710438911; c=relaxed/simple;
	bh=60WaEQ/uK611eyE/NBD4ZKHkiSC/f0nF7jged5bf7LY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=foEuVWUmOxAiKY3aNukq/y6KSN8TpUhBemPrT6Nhp0onxQTcTH7YBjPYyvAI6XWloRgPgu0c7gEyyYasa2BYxwQmKBdRj38Ln+/vpUAHE663W6/LWusgjHQSsY3FuNYWiWRHrjhF1qpCrPo67I4uIyWK/WAYD/VKiUjNaVFGXpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OPF0Bqaa; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWtVFKznc8AsmmbQ8GrCz8NeBzrjEABbO7cuAO6FlIUDN8KGQ4qKLYLm+6ZCtkVB++tG96jPymtxZirD9RvSczqcHpLyRUEOs5OyofybQtsHTMj4OsUbEVWFvdVrV+xiUO/Ft6x3aMkGpxs5J1xkc9miFdAl3an8PQpyx3bDdS/d5vut3f5RMY+P4hI19+sXLqlOIOhSXLRUMv/8qdwSY4zBD1NGeMw6I1li5yLLTOMCP2FRB4/uJ+orYjizMETnFK1sqN2s5N1yLy8hHUFG5liv8/2nlUZHK7NIZ8AbVkOdlLJ/wWy5aS7igN+8CSvqlGngDJp58G6FusZ/dXSUQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzrQyRn8FOBWwAHFeXZtVylHvT3IsyT9SrWdZbsN4go=;
 b=m6338/jdTgg7pEvVYRuxPPRwGMFTi7tuttsYPwv9RWxMjFs9wQVzZFAU9R2H6J1U2kw0PT//Moytzn/0etM/CKPxvr9VAGboocizXjeWx/4m7R4f4QHPyY0gmdykWwA5xCznrr5gW5xWBPTv7R6fCZ/h2m1IoEKignWS7Ip8QttXVjdGaMHzPT+/EGBJgDkNpXenp5GToBjUdO+J4QreNN21arB7KbyRrbGUfiihopcRFuWFoljj5cNyV+t1tnpPWE0FYUkBESYbJcAQyZ0P2kubNqMj4FLNgQO8cTffbgDqVAbm9/UgQOPUP5KjWKUlbHGuHP1MEPTtzSmq+E4bXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzrQyRn8FOBWwAHFeXZtVylHvT3IsyT9SrWdZbsN4go=;
 b=OPF0BqaaD+Tvw+k0kQQkvqpdxBcGwG9yN7ebIx8avDK6BhwdLpSAIp7HQeXwKnvZNvV74y2A3FhX7TqjKrlkpxQcSioq/MOLS+a0tv8Bh1JtJOcoxW9U2zpbl+jf5JocZWLxdLm+9abr2VKbL1eJTkJathCPcQoDk8bRGzasjUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Thu, 14 Mar
 2024 17:55:05 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::c325:df95:6683:b429]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::c325:df95:6683:b429%6]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 17:55:05 +0000
Message-ID: <d16ff01c-4a01-4871-93de-a5c26a352301@amd.com>
Date: Thu, 14 Mar 2024 10:55:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 iwl-net] i40e: Prevent setting MTU if greater than MFS
Content-Language: en-US
To: Erwan Velu <e.velu@criteo.com>, Erwan Velu <erwanaliasr1@gmail.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240313090719.33627-2-e.velu@criteo.com>
 <4e203331-62f7-44e7-acd9-f684c30662de@amd.com>
 <c0ccaef6-44eb-4851-b336-cdb06647e1d2@criteo.com>
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <c0ccaef6-44eb-4851-b336-cdb06647e1d2@criteo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0226.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::21) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|MW4PR12MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: 66187f94-b92e-4f45-a9c8-08dc444fe13b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZNNaQY6K/ovxfeOhuozFklahIQ2GsTXTyiSpAHCVIhSI2o3gO3k0AdgJtbcDY5qQyQKrI9vnyBltZARNalMMPm6dR4zWjb/jhAlHWFVtbxEGjBjjCc9jiyt5CfP3jyDsqqQGyEQBIlk1XE5CdyqAEkSeh431jqiqDMYPhdxYhGSs8O8J2OoA35QQVdn9IlMEFGPPBjwhm8tlVpdcAh5+yDE//FACawhTUwgT7C1RoRQAmeAVa2QipdNb8XDkHEp1v0uLf4JJ6YFy5PV2tZwOgxDOltCKlEUoN07JG7a23RHCaENUJf8B+0p1TluVNDRbzUqweJsF9/5qtGlSQEvST9SRXZ2DvY6O/cfnNrn5gfWZ47hKpr1RZ2W4/osgpPIQ0eaeo38VC8h+YOYNbPc7BIcgfg7sOdsMOptq/xTBU7kW6SpiasOJ71EauHiRVSAh9p77rLSvZG2NnL+LP/RFQlRrFuEhKSOkTklxoNjwEkWHdHCrqluNXXO0jEbyUv5I4Y3vq/iQ+6/BEoTXYGNwZ41WBiqhZ4NvkHDQ6Q1BNHhBErGZ3HaKJD0KPNo7tkUhebYWw8Kj5U8biB8Pnwp+vuAnUGDrjFpRq0VlCBU0YK9/tcy1+r1Yy+EHqy4Uc4uosnVw9HtoslTOoKaEjlIakA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVh5clQ0ZmdDRTJPSXQ1TVlLLzdUTFg3NWY5VHZzVnVSNGhWTnVzQjNuTlVU?=
 =?utf-8?B?cy9GNE9wN3JqbDhmK1Y4UmdWcW9vWEsyc05xbmJQeUMxTk1GRWFqbTM1dVo1?=
 =?utf-8?B?NDNQWmw2cTVmWGNCN1VxM0tEdEVHdVpHWkNSY0M3eXJISDJ5ZUpON1FNRGFr?=
 =?utf-8?B?QWZkeDNrZGx6QWJWL05IaENSa3VMOWZlaWU4bnA3VnlZKzJSVGltQlhjTDhE?=
 =?utf-8?B?dTAvaWU2ZVJKdU95L1VTUHRldnhNRDNab0VyZXVXb0xMT2pYYjhIWFZ1dThW?=
 =?utf-8?B?dDRTZnZ1aHJ3dDBDM1BUUkFYY29yd1hNd25OQUNpN1E1REp3bm5jdmNlN1Bo?=
 =?utf-8?B?d0J5ZnJsUHZ6d25WWm10TzhMVzRQVDJVYkEyODJteHFSVHdSRXcrdnF3emI1?=
 =?utf-8?B?K0NmZjVUYUhZZlNsdk1zVTBpalpOOU1mSXNoVCtmVVJ3UG9TMTNGUVFCcUd3?=
 =?utf-8?B?NmNZK2FOTVZnVWlneUtrcVRCZ0Z2OFcrbHVRQWlEVGNKd1dxUGJIbXI2UlNC?=
 =?utf-8?B?M3N2bXgrNy9aNkl0NHQ2SW9lTVJtOUtkWFFuWVdiMGdrWkRxdkFRbEMwcFlm?=
 =?utf-8?B?WXlkcFRXNEMvb1Z5bkxiRktBVGQ0NzlUZ1JtemZvRGNZYUVuaUhPL1BYSWN4?=
 =?utf-8?B?bklIbUU1djFZWEp5UkNnMnFxTHdqazZ0enNwRlQvT21MdVd3cENjRFZDV1FE?=
 =?utf-8?B?cVlDVnpoaElBd0VuZFM2QnJ0ek9zOGNvazc5cFJBOFBUUC9KcXlPazdYY0RR?=
 =?utf-8?B?OHQ4bExrOENaY2pZa1R2aWhvVlhVdEZmdFhsYXVRbXN4UmJSSFhHZDMydU1E?=
 =?utf-8?B?L1RWNEllYVduK3RQSnVTcFk2Z3pQdjQyR3cxUHdtVGFyY1FWQkkrZUoxVTVl?=
 =?utf-8?B?NlZ3VkRlNThGeG91Z1pOZ2RMemJRL2krTGpyelB5NHY3b2kvOXhBV2xCbHRk?=
 =?utf-8?B?d093YzJmcHJORFY0MWd0RHl0LzNDWUNUV2F3c29kMUdqVktITFdYcmNiNk56?=
 =?utf-8?B?SWFCVk1SZGE5Wk1HRkpDa1RBazFMSXZSMWpnd3gzandsRjdLQ2UyRllQV1hv?=
 =?utf-8?B?SHNJN3EzZ2o4NDZ4VDJSL0VCVnVBVWpseWYrM3AySmwyU3J4QzFIK3J3alp5?=
 =?utf-8?B?WUkzeERIM3o3VkFNaDkrMDAyUUsxOFJFOXdOQmF3UWhOR1ZuQzBTWGtvNXdJ?=
 =?utf-8?B?dWlwaHo2WVNMdlZyRDdXUnVsSHRrbWZTT1NSV21tN1FxN1RGcXIyWVJtd0RF?=
 =?utf-8?B?bEZLblR2L08rTTFoQmtXR2NUcDZ5YzRLd3VYVjVxbUJ2S1ZpZ1hGUVBXTFhj?=
 =?utf-8?B?dWZNMUF1ZGQ3TXZFejZOaWVFdkhkKzVXc0sweTZiSW5vbG9EcHl1d0R3clFy?=
 =?utf-8?B?RS9wSlhBUitvcXBqRGF5T1pkM3czZUZPV1V6eEs1dmFUMnlLT0VOdXFaK0lw?=
 =?utf-8?B?dXZybU4vOWJGSVR4dHpQUjBjWURZQXBIVnBaNnR4VDd2WlRBaGhOMmdhakJU?=
 =?utf-8?B?bTIrZFdia1Y2b0FBaEc3L25FcEdJenJET3pJNGYvNC9jcUtjT1pQbzk1K1E1?=
 =?utf-8?B?WURsL2JhMUM1TTNsak5kSDcvQXM5RG90S1lQOXRud2NJWXpvUWFzbWFtWGV5?=
 =?utf-8?B?ckI2d0Q0TmpMakVYVTgzajdGZXFSZ2IrUXdVc3lFQm1qelVReVluTy9HNzB5?=
 =?utf-8?B?QTZDS2NJbUF5MW5XL1RQVmZvbEJwa2J0dWtRbEtHQSt5MnU3aStYYklWem90?=
 =?utf-8?B?bTBxN2NpS2syYi91eHdnWHpSZFlQVndpNWR1dS9LNUkwNVlMblpzeHFEQ0cz?=
 =?utf-8?B?bHRIT0dXNHlBbHRndEhDYWtrWERmT3VkM1gzV1UxckJ3SVovQ2RkaHZpbDFt?=
 =?utf-8?B?SGphdHdPZjV2aEk0SmpjdTc2eDdzM2RrTlhoWUhnYmdCbno0K3FwRnYvdHpQ?=
 =?utf-8?B?Qy9saWh3d093VHdQOUhYRXRtL0RvQkpYV2ZqTEIvTmxQc05kYllpMDFHaGhy?=
 =?utf-8?B?N3I3QVFOTjF0SVJGWGxmdHpPSXlQZWc5ZUZiY1R5ZXZ2L3BOL1d6bXhVUHli?=
 =?utf-8?B?T2EyMlVuclFxdXIxTC9rSmM1c0c5eVhvRURsTDlzTnhlc1hycER6NDlmZGxZ?=
 =?utf-8?Q?lgnNW6x+Fz3KAh0SjqNvpWa1M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66187f94-b92e-4f45-a9c8-08dc444fe13b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 17:55:05.3054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1H9SH7N1n7dxCPeM3b5ste5Y84zUr2pyTVAR93VLxtQlCNKkM+vJN5eKcAv6AfU/j0kuBQOl8Vwm+p72daCPzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6921



On 3/14/2024 10:10 AM, Erwan Velu wrote:
> Caution: This message originated from an External Source. Use proper 
> caution when opening attachments, clicking links, or responding.
> 
> 
> Le 14/03/2024 à 17:10, Brett Creeley a écrit :
> [...]
>> If this is how the max_mtu is determined, does it make sense to set this
>> before registering the netdev, i.e. netdev->max_mtu in
>> i40e_config_netdev()?
> 
> 
> The absolute max is properly set but I think that's only true if we
> ensure the value of the MFS.
> 
> So if with another patch to set the MFS to the right value when asking a
> bigger MTU, having this value makes sense this is the absolute max for
> this device.

AFAIK there is no API for a user to change the max_mtu, so the only way 
the device's MFS would need to change is if it's done during 
initialization time, which should be done before netdev registration anyway.

I guess it's also possible that the driver's XDP configuration could 
cause a change in the device's MFS and netdev->max_mtu, but that would 
be under the rtnl_lock.

Seems like others are happy with it, but FWIW that's my 2 cents, 
otherwise LGTM.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>


> 
> 
> Erwan,
> 

