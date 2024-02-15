Return-Path: <linux-kernel+bounces-67643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9C7856E68
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24201F23467
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0D113AA3E;
	Thu, 15 Feb 2024 20:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DHpQiSyH"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E6513AA32;
	Thu, 15 Feb 2024 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708028100; cv=fail; b=knHGTdimxu2hNYm8lIctn/XYbyNhlpwIt0o9Dzr/4RLfnARIhLqK0ZPpEFw3OXdJyfNDUdzIqoi/ww87yopWUbMVcelfBvHEnMsxMDRdu1SfvcrdD3AzqmHi1lEen9GDw2+hXb3tAG+tTJoiMp29f1RbdRWHcFSShLT5TswLW2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708028100; c=relaxed/simple;
	bh=cYXj8cDkzj8BziMzapplA6EUugmW21/o952HhrWHMf8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aFrEQFNaQq2gvxN8en6bzpH/hUeYIoaGhaW21GuZayGDktcX7qAV/GSgG+vRicPP8EdfSllCbDqFq0i/E1juSPYUTsTErJvOrjp9MUUwGAErol6UqASILVpD4G8Pr5AouUsest+z3ZBuqVRnpGJfTMSRaR1+pK5+Qldfim/qK/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DHpQiSyH; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D33DNdk4kgSh4RG4cHAhgXCe/sdr8Zt2y71keFq5TrLQGzTZea8YspYJyCZrp5OxXh2U1kJaIO3BRSruiDsfXfA72FRlFp2aLnQVUSHeW+EmJZU3nZLUY4mh14mes+YdF9xgZunOOF8QVe0EXqniWXUhFQqxZiX5GU9PxzYkyKkTdHqFH6fyQG7YFVNvJzQDBtoB2RMKo+YbDi/O4prSyvL/SfqKgzbkUhCqBpUT6USHpXsRp/Liiu/YU7F4mn2w68dzDuOiaxXOL7k/NYxFBel7odNv+Vfd3C4I75rz5cyKo7gRkHfFfpYbUo7Qz2/L81ynF78UICwJc0MI7Rhz5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6jhNm6Zy0Lt7NYAG2E2l71BUC0l5vl+OLd3puS6oR0=;
 b=Cvly4DbnfknsOQ5bj0TY3QnzrIuZih56lon2rBC50Wp3CYXlxE7d8rYAGpymrD10I/VI+Bhn3QRUXBqBHBk6T1jt0CRZNtKHuiePfjDl1VOZM1Wywwa8YZsw/89Feu6rwGaAg3fHSvMkU3H3ry8Q/2RPZOR87fhsbEbuM1wwrenIwI0nvMwmC/R/LAYTMGmkWTzw3ouLUn13mq5ux95lts88wVSMjESyDCbViBmDkM42oDjroJ3Hn8VlCIvAgf1utBR2XqLEMLdHdp0Ws/r+rBRNqvIu14UEVVeCCqyof83TH4bacbPtpqY33Wk1JF2UA6Nkq1G9kQbrIKBTa+x1Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6jhNm6Zy0Lt7NYAG2E2l71BUC0l5vl+OLd3puS6oR0=;
 b=DHpQiSyHuP2NJGZCLn1sJVdbmWpBCO0COUEIAdBMPfx3ci3ggBQRgp9CVWxplbPWAvDQPm/WICkl/Le9I4ljQWpj4QwMw8OlN+by1ObQkFl3cG2bb+kWNEFJ8R84+1AGaV1AcZvB5wgb0NYEn5hbedP462U/eb00u9TzVjI1DZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 20:14:55 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4%4]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 20:14:55 +0000
Message-ID: <f68b684e-0b06-4175-93ca-3df869b5e164@amd.com>
Date: Thu, 15 Feb 2024 14:14:53 -0600
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] x86/MCE: Add command line option to extend MCE Records
 pool
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
 linux-edac@vger.kernel.org, tony.luck@intel.com,
 linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20240207225632.159276-3-avadhut.naik@amd.com>
 <8b4f8ec2-7534-4f77-b44f-6728c699ff64@intel.com>
 <51255499-0b5d-45c6-9c72-f353bae83c0d@amd.com>
 <20240209200920.GFZcaGcOr757W9O3IG@fat_crate.local>
 <7a4945b0-322a-444e-a0ca-860a062a49c3@amd.com>
 <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
 <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
 <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <774e7ca5-154d-4ca4-bc4c-2f945c20b938@amd.com>
 <20240212085801.GAZcndma4UTPtKm33e@fat_crate.local>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20240212085801.GAZcndma4UTPtKm33e@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0103.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::7) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|SJ2PR12MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ecd299-ff5f-49fa-feab-08dc2e62c69e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pRFAu/EybHxbXnM5y5cepx+kcUskSPrgu1zvDIr16Utx4FGaPXuGiKN3ocTpu59aJUs/ozRKeQW9GAU5V1HOTWW+Y4lUJGKNDKAj8XhH3HatRmR6mrWB3DoTTght8qKFOJfvUg8Kn+8Bv93vjQxCoFHn1r+JH/0UyffDDvyUb/qH6YqEdAvzhFQmtz5CzifzQeNmrGyN2T2Fs6BWH6uYVdc1D2HxOKvQVXII1OkPAdC2NqWF5Dgytt+Nx3FbzeexmUIlWj6G/KHndfijwAWGsksOEo5g7xyt9Zs4aq5Aio7fhkwf0DdHqqhIg8mIVPrJLMDmMRbWKWMvRg+gUK2mA08NTBV3oTsAZ97HDFyI167GgRSAFM8fLWmamtgONo7ctLzRoi3lvrIktllx09jdx9x1jQHDGd4oukpCF0zKwI2z3xYKe/J/eEAGjFnjCd0v25SYoG0HEMnf5ieL/6bDLhxKL0yMgmrWT/RoliTT5MwHwV/TckVgVziV4hbt2LFTiwJtKPCjKAG4ow45LOFmzz68BIz7TD4FLl5pQzrNL3ppuVnQJYWpYRKqpiMbEc7I
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(6486002)(6512007)(478600001)(41300700001)(8936002)(8676002)(4326008)(2906002)(53546011)(5660300002)(6506007)(66556008)(66476007)(66946007)(54906003)(316002)(6916009)(83380400001)(31696002)(2616005)(26005)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MldBOW9DN2w4RFV1ZUNCUkp5aGRIR0crNUNWeFlad2xVN1ZtYTRzaFpHUGMv?=
 =?utf-8?B?dHdVazh0VmthWUQ2clFVdU8wWDhLd3JBU0lZWGwwQ2h1bFdGVkJWVlFhOWZD?=
 =?utf-8?B?bDRpa3lpc0ZzSnNSUk5KK2tNYmFKMFEvaDhvOTJjZ1hJUDBZSnFpNk9DM29J?=
 =?utf-8?B?SEh6OUpkZWdtNXpLV3lGQ0IxWG5EK0NtVnpPa0pLQnNrVzYzU2tvc09xUjJQ?=
 =?utf-8?B?Vmd4NmFrVmZoNjZFWmxGK29CREFpL0ljbXNJMit2UXlwQ01nWmxwVFhEVW5K?=
 =?utf-8?B?SGJKSG9ZWHIxekhYdDNIZ2t6Ykx1M2M3WmszUkF3TVlRc2Y2SVRmMEVpaytX?=
 =?utf-8?B?TlhFaDZOVTFvWkVIamZxaXh5NjRWNFc5UWRCUW0rSDA0Q0RHa2tHMU4yQ2NN?=
 =?utf-8?B?SmhsT0ZiNHprckZwd053WnV6Skg5VTY5dGNtK1MzSDk4Z3dJQWRzZjFvaVFz?=
 =?utf-8?B?L0JSZDM4UnJkNjJVSFcwRERwK1lUeVlEOHhPUmluY01YdE5mTzd1V1NkVlh5?=
 =?utf-8?B?NFVPajQ3UjUrWGtCL3RFVWhXWVgyczIxRW0vRitsLzVyNEsxZGNsUzRoSWQ0?=
 =?utf-8?B?cWk1bUpSVVF0b2RRbmFraDl5RHVLeEFiOXB1TTlCTnFuZDBVUlg5QjJnRlR0?=
 =?utf-8?B?VlBCMzNxVDNSUlRUOTlhbWlaaVZsbU4yQm9QSHVyelZLNlFhWFBXYW9TUmVP?=
 =?utf-8?B?RGk5TDd6b21PZ29iQXViTVdjNUtXZ0l5NW0xWFkzWGFjUFBmOFlFUFFvcmRZ?=
 =?utf-8?B?dFk2dWVqK25tY1ZtaythejNSKzFJTEtxbXNROHkxNVYyR25PUmphbWMzMVJn?=
 =?utf-8?B?M3NsVjc4WVJ4K01rTUxURlVxeVRDOU5VTDltSzFiZkZFbFdlbUVhSC8vRll4?=
 =?utf-8?B?M3ZPcjZPd0JIZC90TGhFUWdLKzBqUEk3aXlEZjlNVG81b0tFa2FrN0M2N2Nw?=
 =?utf-8?B?MFFSaWxGdHhobURhaDREOGl5RzBYdVczYklDclZ1ZXJPd0VINlpNdFN1ang2?=
 =?utf-8?B?NGZXU2lSUFhaQzFuTGluc3VFZFpWcktLbkloNUNielYrYk5jNWpYTlN3YzRm?=
 =?utf-8?B?K2Jkd2dpK0Nab2ZVUDQwV1FMTkhHTC8yNEpabVlvbVJyN1RMbTY4cWhaYis2?=
 =?utf-8?B?cFpVRW9nZTkybVN2RjFLS2Vpa3crTFNZK0x3UDFsWFFGU3pYUmU5dlNabkx2?=
 =?utf-8?B?WEp4MExCVjd4VjBtM2todHo3WHBJMkc2dWVta1p4STg5WWNua2FWY01rcmJp?=
 =?utf-8?B?c2E0V3Z5YkQrTXFZMmlzbmcxQ1hmUGdwU1RPako5UDdDcENKUHhqaWltU0dR?=
 =?utf-8?B?K0pOcmNyY2xFYTZ5WmVqMnZQRXhFK3hReFBIcldIOVlmL0VFWjVTSGdBVjNa?=
 =?utf-8?B?REI2NlVYTVh6WDhzN2h5cEw3MUJadm5TRzZaWVFyTWRtOUNwMndDM3BzdW0r?=
 =?utf-8?B?Nk42Sk9tZVhEOGlCYlNSVEZiLzJDclNqejg2K3kwY3BSV0NQNGtlWGJGbTZV?=
 =?utf-8?B?aVFFVkcycU5wakRxNlpoSjhON1VRTVpLVm5SblVtL2VBMHhDMnZUdHh0SWtW?=
 =?utf-8?B?aEtNZGE5RVhSV2N3bElZK3NkajBPZXFhNDZ4dmxEZ01SaTFqOUlMRWV0S3Fm?=
 =?utf-8?B?RmJEbFQxT1hvVDNGM3IvdWhDb1JuQjkrRVV5cExLZnlidHhqMEd3a1BVc3pC?=
 =?utf-8?B?eEREbnV6eWhOZ1JPeDJMc1JRU1htNjFnOGhxSFA5YWx1R2g4TkpJM1UzdlpZ?=
 =?utf-8?B?SGxOUG1jb3BFdHdsRGNjNTBYc3Bmck56WkNoYjd0ZENUNGZsWDZYVmd2Z0Zw?=
 =?utf-8?B?K2JzSXc5QytNUEliMzVnbGpIVXl1S1ZxVHdKQ1N1SVNLYkVYeWgrUStPZEtO?=
 =?utf-8?B?T0VVY2huMzVBK1h2WUtYWkpTdjFPclU4WHRGaHdLaHdIWktZWFpSMUpjd3dY?=
 =?utf-8?B?UDQ1bFZ6ZVdtZU1RREEwdGpQY3Z4L0t3RVlJVys5a2FCWDg3L3FTQkN6TmZv?=
 =?utf-8?B?VzM1NWlhdWJ5ZHhkYnhwSE4ycEZRa3Q2VUVvUy9rUlJLTitaVDRjWXRKVk1Z?=
 =?utf-8?B?ZkdBTmVEbXZwN0hqYzlldEJYd3dVaDFTS1FndXlVeHJYQkQ2c0p2VWVjcGVi?=
 =?utf-8?Q?XUJ+2yxc1M1FwUwXZQr8GlIX9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ecd299-ff5f-49fa-feab-08dc2e62c69e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:14:55.6015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /P4uGOUn/OOit+NwP1rttM5NkjBc0jFXTKUO3zl0Xh/ery0HjQxcu56n3MjOUOBsvfoBqnPXCqb5TSBAxWe1Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111

Hi,

On 2/12/2024 02:58, Borislav Petkov wrote:
> On Sun, Feb 11, 2024 at 08:54:29PM -0600, Naik, Avadhut wrote:
>> Okay. Will make changes to allocate memory and set size of the pool
>> when it is created. Also, will remove the command line parameter and
>> resubmit.
> 
> Before you do, go read that original thread again but this time take
> your time to grok it.
> 
> And then try answering those questions:
> 
> * Why are *you* fixing this? I know what the AWS reason is, what is
> yours?
> 
I think this issue of genpool getting full with MCE records can occur
on AMD system too since the pool doesn't scale up with the number of
CPUs and memory in the system. The probability of issue occurrence
only increases as CPU count and memory increases. Feel that the genpool
size should be proportional to, at least, the CPU count of the system.

> * Can you think of a slick deduplication scheme instead of blindly
> raising the buffer size?
> 
> * What's wrong with not logging some early errors, can we live with that
> too? If it were firmware-first, it cannot simply extend its buffer size
> because it has limited space. So what does firmware do in such cases?
>
Think that we can live with not logging some early errors, as long as they
are correctable.
Not very sure about what you mean by Firmware First. Do you mean handling
of MCEs through HEST and GHES? Or something else?

> Think long and hard about the big picture, analyze the problem properly
> and from all angles before you go and do patches.
> 
> Thx.
> 

-- 
Thanks,
Avadhut Naik

