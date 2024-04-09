Return-Path: <linux-kernel+bounces-136179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D4D89D0CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE341F251CC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB8454BED;
	Tue,  9 Apr 2024 03:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFI8tqx1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEBC54BC4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632510; cv=fail; b=dnjfVb366242Vty7IL5Q4mrwjmYVJtI3l/B2C/zmfIEe6GmZdqE7Dul5/t4PYTkgXwQRRlfle7l5vMZnJJZ8nyLF3hKfB1BOJmWoduMZ1OFQhcXEbx7HvyyvoBg0bER6yd01bcYEgaxmpfzKsyQnGpNl0csAyjz1WSzMpPvSdxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632510; c=relaxed/simple;
	bh=JKqPZ7MVIP1w278nALWluULjRw0wDAlf73BHyvvVwo4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oSz5KNR0N/nZ4uVIQjCkCKkQW/UdlUeQT/5o+AHbUyi2Z1O5YB4FTKx8rfCmC4bt17Om08WsaFbZKrKvCC+s9bGKRA7AdWr6ZxEll79XL+iZqgyZABeQfxOV4ANSzxy+LePG0RNS1ND7XD/s3lXUCm6KkFPzpT+qeBFixsEN6yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PFI8tqx1; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712632509; x=1744168509;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JKqPZ7MVIP1w278nALWluULjRw0wDAlf73BHyvvVwo4=;
  b=PFI8tqx1ybT4lgv+G/Vum3YDJga2DJ8eGI+N4nklBx2qCsS4/KH2ChKh
   d6ODyj2MTsyqpRgRVc0AXEYGfINrt9MXDn7fIAHgO8cf835NTsMtL6iPS
   xqdFpChuY+7PESLGH+cqxupYVI6xpnTCSh/DHW+p/81HXB4jZyhp2gqf/
   r6c1LMWekihrjSB0QiXOZm56VM2xGChDcF7pa1lb8SiM/vNbnSKEgbu2x
   U1UzDfKf9s3YrSLckHCTxhTYHCOokiyRJ4KnJ9xCBH5dY3qvedLbS5W7t
   JETJAgQerfT8DUPqeHLFTESSI6c6IoisFvItXfvgCv9xdHamt1OESp/va
   w==;
X-CSE-ConnectionGUID: +yd9DLfWQIibyEcJQR410g==
X-CSE-MsgGUID: gaGc2KUhTIqBDlmhlYvB9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7801232"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="7801232"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:15:09 -0700
X-CSE-ConnectionGUID: GC+t+dgcShaGkrMMt3N7Cg==
X-CSE-MsgGUID: MB1y3FnHRK6LhLIu0il+/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="51098006"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:15:08 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:15:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:15:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:15:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lw4uXdPd5ifpx/K6XtcC3db5HUffCMPkhlcFLFdQYh6XMmA1iNtCsYPbP2mi7KfLAGLDou/EVSY0MrBCTVpeQwQnTGM+c2pRTEHQI0b08eh4Dhhk8IK8W26LH5Eg4VvJZiDmnwB/LR1eDh7MZchZgefZNgUTMiZSp1RKkrz08uhMsOuqkV5OzK0tH5qKoVxyGPMsHaF5Sj6z04PbIOvtrI26B+96WgJ2Vcx5TBKFX4kg12RFC3JE85OCUeHZNLy71GLy6tpu9oKaXtMvnetpJUXiokgqnm44PUcnjKD0XAD8EHNo5fgsBRO4xPArcwoKiZTsdZBuA+z4FtPj4uGI3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP+WhEYDVH6kWnahRae92OB17sq15T1ZAd+o19q8Vw0=;
 b=PKnHaTB2PT4KSWyAmI4G393UOOjQ6p8umwERo570w931/ukyKH+X3Eh7v9JmAbpk1z9Fmt4lOUCveMoGWFH7KkqGTDfpyQ5ALh47fg5RgCm6EbCyTcNgtkvLMU6QGhi13MVrYKltE6DEO8BTok46/ynq8bykvFcd4Vi0We9C0H2hWWfUrouyW/nNoZhTF6YaJh1XBTFambZpGLA2yUIBBvOdHh5y9jV3xM2BAeD9dfFFcVf3mspjbEwA3g2wykQFvyUHvmD5XxBQO0me5U4e6YlUA8wG1pVF8yCKGpNGAB30jxwc/BaCyfajYIQ47pW1j0aAWcCjr8BzWId0IZfFlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4783.namprd11.prod.outlook.com (2603:10b6:a03:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.23; Tue, 9 Apr
 2024 03:15:06 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:15:06 +0000
Message-ID: <c8d1f4ec-eb38-4846-a6ae-722e39ab75f9@intel.com>
Date: Mon, 8 Apr 2024 20:15:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/31] x86/resctrl: Add helper for setting CPU default
 properties
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-5-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240321165106.31602-5-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:303:b5::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4783:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8KtczvacLh15Ux4BAKO0+yklw2C+G45i37wpIGWlYBZ5sQaR8BZEE7FbuE9+RON2ExvnPjxUq5yW7o6bOKV5mi6Q2fWMtPLsq4eBhc3Oje0lOP0RSOdnQr/uWB2OhQxJbFwBmd4YXIrHvTyCO9bAhQCctEyhIzRJUqEkzufQpuef8ht9R60FkSWfhHSIU3dNDlsxzmtBCiqbM7Y5Wp8B60kfeg53tx8PLKtcTeISK/HlG783HNgBt0cSaAlUTLfLxtpFIJ88P9moyaBZ27U7M1vilNAs468RRkL/dt2oVIyPDqX0dXWQWbXr0pT7UB8G4Grn/vB/oa32UYqwQyfDRpOmbMq4u+3sPZbn950HBxa+6tVS1wXeborjeXLN7sg49EfOsEIbBBffJlTMS+henIAhY+1Huzt3VRgCnXII829AXOap7Frh2Ztxt2oxScPLAjD8o0TkpOeU0T5FRnn4zRlbKgDW44Narin8kgoxZC2Brdaehe/HQgFdsCJjC4Z2yXr9Akoi9RrEMegVYFp1zCkupauMjvPWz4PgAVeR/4v24SIt8zbQ5kCKYPKti40wtmbqklMYRz4JH4CmPOX+JIKeHHMvhW9107CfRBZ3fBIxFw7n9Lx6Fl2rER6ogVHlm8cDtGOLcgcckWc8MKeTr178Im558ZHH+B1rktFap3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFBJU3RyY1d5ckl5UE11bWV1T1BnNjMrWWJSTHdxZjhqZ0JGOTg1dXAxNktI?=
 =?utf-8?B?dEIzQ0tiYWpDUEg1S1Q5NGFvUStDMFQ2TFgzQVMzK3M5NnluY0pYUDlOQjdz?=
 =?utf-8?B?alVYcy9FcUZreVdYTjNMQi9uTlJMcnZLb25RM1VleW9tS1hrVmpONUR5d2Zj?=
 =?utf-8?B?REFpSmJlOU9meXh4dXBGRkl4NFF2SDJjYVZpbmN0NmNMWmJHdWJjWmY3TFdE?=
 =?utf-8?B?dm84QnBjdWp1bXpzOGVtdmQvODlxSHlURVpLQ2s5OW1wTlcvTXd3bzAvaHRq?=
 =?utf-8?B?Q0kvUWNkeWVmdUxSMXlhbi9ISzM0TkJhSldhVmdWK0ZiaHhFR1dxbWJCTlpZ?=
 =?utf-8?B?cXBtL0lkOFlnNGJLbTE2aEVVOHFuY3N5YVhwb1VqR2lQMWQvUW1qWFpnc05R?=
 =?utf-8?B?TU1GM081QlplQzQramk2b3F2Mnp3TFRONEtmL3pJMDk3ekZ5V2ZodkIxNVhj?=
 =?utf-8?B?d0I3ZE1IeERBbVNIcHFJYUgyMzMvbE9KWHZnbytLRnJWemVTdTVDdDRmaDlx?=
 =?utf-8?B?R2NmSHo1K3VBUlZrMXdQTUd0TTcvNXhvaytlODBFTHJiaGZjYWhzT1I1VDdS?=
 =?utf-8?B?ODZyTEJxbnFwaWJXTlVZSTgxeWlXcWRRV0o4bkRtY2tLUzBSK1BrYmNTaFZM?=
 =?utf-8?B?eERwRko2bUZVdTQrUEhUanNtV0FEcDNiRjZheDVEUTU0bVNHK2RweG1BV1M2?=
 =?utf-8?B?TlV3WTFwa1ZWNnUyRWpaOVc1ckNob2VIT2h5d3RnaGtMdEFRa0h4WmJoTlM0?=
 =?utf-8?B?N2J0UHZYMTBVVWNEeVphSWh0N2J1dGZ4L21NMzgrWGM0TFN5WGdxQ1dzY1B4?=
 =?utf-8?B?ME1ScVdOYnBNcitVNGh3ZjhCOGxxTVVSWVNkb3dEbmg4MXlmaFd5UTdaWEZO?=
 =?utf-8?B?RGxqKytwOUdqTTV0dExSTmhWK1ZIVUNWU0RzTVRpbmhObE9PR1pWZEg5TGkv?=
 =?utf-8?B?M0E2aHBTTFdpdlJSWFRQWUZrN0pYNTkxWU9mSFY1cXRsT2tldFA3MW5mWnI2?=
 =?utf-8?B?RmVEcTJObnJwUEw4NXlyeGFXZG8vcFYwT3VPdjBFUmpiUkh6Y0xaM2gvdERC?=
 =?utf-8?B?MExSdVl4dVBJbGM5a21YK0RZRjJFbW1yMTVKUWtjS0dHMXB6R1Nvd2svWDhF?=
 =?utf-8?B?UXB6c0NqK2UzSmhHVCsvVFJVb0UzMUw4S3gxOVFLZU5ZYWJkMThkdUYzNFVM?=
 =?utf-8?B?Y243aVVuUGF3amNoQlhxSmpGNUF4M1ZhRmRPdkYxY25WQkZDeSt3bWdhRFdz?=
 =?utf-8?B?UUJWMzVuWXp3TkxyaFFyVm9xVjdXTnpjTGlESk9tMzJUUmpIRGQreUp2M1p4?=
 =?utf-8?B?T0M3ZnpHenNHdklaZEIxeW13eXNBeTdWQld5RVBoZ3VOY0NjUkFxd0Jib3Jy?=
 =?utf-8?B?Zy9iVlgvSmZiS2RpNzNNeDk3c1JZTUpnWURQZUtKOG82THVuS25TYmdxc3Nv?=
 =?utf-8?B?dXFwdzRmbWJWaGdlT2UreDJyYm11N21kVHloNWE5amdRSStWbjNQdVNTRVVY?=
 =?utf-8?B?TjcwYnhHREdsT3lOOWp1NFFXbUNUaEw5ZWFjZDFNV0VmSHZmZi9aRmlmSHRr?=
 =?utf-8?B?MDJaa0o5eWszanB1ZWIxVjhoaENyNHNCYnVvU01vSkZUT1BmZS9yVzhTQ05z?=
 =?utf-8?B?aDhNaHowN21uWjIzaERNeGZuaDc2OENnTXJ3Wm1BVUE3bldIK0ZCblgrd3g5?=
 =?utf-8?B?eGNsTGpnVW1scWJtMzRwWnpGMlRVSXg2K2JrVHhBNFlsTk9OTU8vWGdLQVMy?=
 =?utf-8?B?c0VNYmxKWmNZbndCbm5GQkg3alNmMVVCdnZWZnNmRTVRN0RsbkJ5T05DdlBC?=
 =?utf-8?B?dlFET2N5UlhjN3ZleCt6Mnp0cVpPbjRLRkJXVHI5VWViM3NtZjRrUjJ2cTk1?=
 =?utf-8?B?ejhabzBPeXRyVjdXanBYZENkMlJsaTVpS1RaV1JOSEJmWUdlN05jZ1Aza3FC?=
 =?utf-8?B?RkJKUUtXeit2YkRpUU4zeGNhWCtCNGl6R3NrNFJiVy9jWnhScmVUS0FMSlhs?=
 =?utf-8?B?aHhwdytLYnJFVFlTbkt0ZjhmbVBTaXZqN0lRcW1OekdDWVhBTEwzQ296TmNI?=
 =?utf-8?B?QTJxU0V1TXB0VmtoU0NBMVdiOEtsRmdla3VqLytWa2U0VEFia3BFMXJwQ2F4?=
 =?utf-8?B?U1lpZU9INWVZZHBCQ2dUbFpWUDJEd3h0NFdCM0hyYkgvUStmK0VBU2FnR2xh?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c97a8f-bd21-4a0f-a5b1-08dc5843413a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:15:06.1250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMvCBClxOOOXhwQ/Oo45x3tFgdDqV2Uc+8BqImkJfMuWsWIgvY8a7edsiNnHRaO9lf1Pm7SAoZPsLLjVZk5fPO4Abr7xtrz4rxLTP0/Gt5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4783
X-OriginatorOrg: intel.com

Hi James,

On 3/21/2024 9:50 AM, James Morse wrote:

> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3623,14 +3623,18 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
>  static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>  {
>  	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
> +	u32 closid, rmid;
>  	int cpu;
>  
>  	/* Give any tasks back to the parent group */
>  	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
>  
>  	/* Update per cpu rmid of the moved CPUs first */
> +	closid = rdtgrp->closid;
> +	rmid = prdtgrp->mon.rmid;
>  	for_each_cpu(cpu, &rdtgrp->cpu_mask)
> -		per_cpu(pqr_state.default_rmid, cpu) = prdtgrp->mon.rmid;
> +		resctrl_arch_set_cpu_default_closid_rmid(cpu, closid, rmid);
> +

While I understand that the CLOSIDs are the same, I do think it looks unexpected
for the CLOSID to be set to the CLOSID of the group being removed. Could this
be set to CLOSID of parent group instead?

Reinette

