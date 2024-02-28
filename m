Return-Path: <linux-kernel+bounces-84803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA67686ABCD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943CD286D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043C8364C0;
	Wed, 28 Feb 2024 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jIsKWau4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED066364A1;
	Wed, 28 Feb 2024 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709114354; cv=fail; b=E9Ph/OE/wB2EGDeGYpnld6LGdtcy8/1GQ4suwWwLLgWtVldBrpRwVVWq6P/lcQZloWSpWL0MbRLz0E/0yvCQL7mjuznDue7hcENwvrFc0dp2R4ycD1yTFYXW15q9FlY9zDkgEWe5YnUUtByF0O88outSyHOw0yP7y6nHvL1xKnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709114354; c=relaxed/simple;
	bh=6b74PYGttap25WTK0hrfVUKxplfVRvX7oREyaEobW6A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nrRTqDbN5VQxmaurUl4iJRfKDMxQ5pTY7aYBUhTjZPEKKwgde2L+CYq0ixhYxI0ehmWfwuZWXOMQ1dfHZ5T1HixCo4z14fvZ5o7CDZvcw61dTjYf9RVMpqdZVs+MtnDM818t9mTk3ij5xK/XDEUsGKabpAgLrwQziONiYGuNIRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jIsKWau4; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709114352; x=1740650352;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6b74PYGttap25WTK0hrfVUKxplfVRvX7oREyaEobW6A=;
  b=jIsKWau4P6PjLB+NPbxSgb4mEZxXGBy3hF3KsB8TfeoVy+JEtxGnNIO1
   QCYfnU1H4vOcN4N/UzD9wiTDYQidRkdNreWmkm/tPaJ9DuMnqtAT3wqtS
   N7UQA5gkg/jEzFCYdQEsys0tuISg2KeVe1V4q/Doa0gep9gMqdbc58jUN
   E5K7sFx/x3Upugq/jcSwQBu4LxR8ySN9t94W53OWjzUECGFf6uBKkGhJa
   MnaBHFVfSgYxuHt57HfL7GGbYRGpCdk26zvvNOZ4aiX2qM4EpO7GT5fU1
   8ZG0ajcuzRDxVQ+W0XJvd5ftqpRLjTDXh0CHvI3KloD9/Fta/Ihhw9dH3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14055269"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="14055269"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 01:59:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7590126"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2024 01:59:10 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 01:59:10 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 01:59:10 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 01:59:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbKs7Uzhed915QHi1kVyFXljjp3fX+t7+CImqKh7yA4uQxbTiF5Uc1A5j1ZBmsGrMu8+IjSdzquejMFU+W5Cm9ir1oQroe4bS7Hgq//eBAI69Vpr5Wal7c5QTD56oe8JGkAkA+L73jMkvuDcoBJJ2cyA+SjEYX1sIOsTcQ+jxL0AkWTwSzUblbQva13S9+CieqHwJsPXlnd138kkFzTTKJLMpCGQLr4Lb56huDuBbFqY09/JPP+r7pOgi2UjqoRHsYvb/Ht3yTX8sxrohdgJ9v2xcPP7xx3DdeuCykvp2+sXUUoSrn9zvrumnQEEJoVK26qaEFByNVPenfAeL0sxNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cw+JSWrrRmrLB3XrxHYKRfIx5K3CNaBWPQttnd9Igsc=;
 b=nGsMR+PJp8Mp24xg/Nhj7PVDHHXezOaLbdy2htgwbnjaSRU6NoIFsJjtR4pUs8HkslPZIgcz83e2IFkM3IyRL3PstDBdDIH4HwSe285szmtJUHqJUYLshOxfysY7D7aBVXdsYRogBD47sJlyecMhdB4GFYNgQBGdQURXTv75FftxQZ8uranbL9FWTsBSU7PgDmHmFeDoNXdNp6WhAtVEL2uRWtlxkhYKVGx70wDHPIbGeL5RlCiZ/+GUNS4AQGU0Dc3yXZXwyUSzayiR/djHsWpTrYYsNtrhh/JetHmUaarPYXRawNeiOFd8/cBkRh0YJTUr/Or/mYw1VLrkedmKUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by MN6PR11MB8145.namprd11.prod.outlook.com (2603:10b6:208:474::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Wed, 28 Feb
 2024 09:59:02 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::8079:6172:11ca:5fe9]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::8079:6172:11ca:5fe9%3]) with mapi id 15.20.7339.019; Wed, 28 Feb 2024
 09:59:02 +0000
Message-ID: <501f7f57-99e6-4826-833c-b8414ebe8176@intel.com>
Date: Wed, 28 Feb 2024 10:58:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: phy: micrel: lan8814 led errata
Content-Language: en-US
To: Horatiu Vultur <horatiu.vultur@microchip.com>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
References: <20240228062813.1007138-1-horatiu.vultur@microchip.com>
 <20240228062813.1007138-2-horatiu.vultur@microchip.com>
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240228062813.1007138-2-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::6) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|MN6PR11MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a1be0e9-9e7d-4a5e-b998-08dc3843e448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yOGCfZ5SmNU9aCh2Ka0vI/OscEhBniJdFNSXcFQOv8nFVbq7rTCJpT59I/HIe1YzbZL1dXFon7rSN8O2akpMtOtG+Q9VxHEO65RHz1w72EOfl90p0yaeFIEsYSiC8O5lmEx7k6swKqCkvMFB3DLNKjHp6sDqk3xVIRo2KfdKVYEDW0YTSil0rMYBzBMH4OXQ7IA+cJZGPuAxvufTOfhBDZ5LJx0M36o0n4AJot8KzFkBpeHbumy2r4CfHnach35T+1Id6ofI5DssSTnNwTaKVlyIbdm8fwTrdlxB3DqiSVfLIQQHj8cSx77kuPRAbmE1WKICLszGgKH6SMhe+sIGRTP1QoGnTLflv7TN1c+jd8n/2Zpnsm3cgXn/w8NCjFNSRpg5Zd3+QnFLWsLurI+iIUL2NyVApwAxiqKMzmR1WuaMuGt0IsQES8PCrabErV4FNX1KJgmz7T1SKgbsCkPQY9Hxc3L9Shve/SnDXg9Tc6cuJEwBEycy6I8qTgXXdjqqjs/xf3Ywi4Lsbu5tP38VlBaaPGGGdLpNrhVDvxOAf2TBFEvRANx8NmqN7dfLp2hqkIJKwSZKKvXZjCzV6IJZa4ZNSX02KQAk2gAocGknJU/Tc6Xl6vWI/2SLvqfJT9oUUE24mEzq0Q9RHtf3ALJTwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk5tbWsyMXVhbGgxcWRwclMzYUY4S1lyWWFUNThuRHVCUEJlNFEwaWRGS2Q4?=
 =?utf-8?B?UU92Z1k2R0ZGTTljVGpOZEpJemZiYSttUVYxR0FvcmJSUUJEV1d3ZEVhVVBI?=
 =?utf-8?B?MVJtQktNSUVyV0NaNnIxYnVWc0UvcElvMnpCTFVOVDdyU2FybjBTUEE1N21m?=
 =?utf-8?B?YkVzQk82TUVtR2doSW1VU243bUJ6bW1xYXpJZ0lkaElhVkJYdFhpN2dFcVpk?=
 =?utf-8?B?V2ZacWZrei9Jd2o0N2k4ZnppK1VJNUVUdjRNdTJUQk92Tk5DdVNtekVhZXhu?=
 =?utf-8?B?WktoeUppdnk5K3dZemtUblQrN2t3a3M5M0JHeFZmdmZpY0w5UnhUMmRwS2g4?=
 =?utf-8?B?UFh4VVhGOGMrM1JVdnNYYzhQNUlBcTd4UnRISGdRUEhrU2FYbWtiQitxZnBY?=
 =?utf-8?B?RVhIYTcvL1B0YitUQmJrWVZoeVRqSkRZTDRUYzJxR05DRUxQcXA5Y1BUL1Rk?=
 =?utf-8?B?dWtuZSt6ZDVwQStMSzd5WnNuc3ZaNGYrL3dZZHZ4ZU9TVG9vc0cwUUZHTFBY?=
 =?utf-8?B?N0Q5czBDZ1RwVTgrZ0VHV1QyeWRoYUpDRk5jK0Ztb0p2QWlwcjQ3aWFRb2Zm?=
 =?utf-8?B?SHlORENyT0I2blZTanczalJselpNY1gxS3I1T1VQK21Zc0pkUGtoczNIazhQ?=
 =?utf-8?B?RCtFMmJhWDUwQ0N6WWZ6MjQwTlpSOXZDMVRPMFFOcTNkc0JBSG9hQmpVTHhu?=
 =?utf-8?B?OW9oUUNlUDBkWWFTeEhQblFTWU5EcitwRXJ1VzBYTUNCVWhmQjMrQW5ZZFhm?=
 =?utf-8?B?Z0dMbS9JYmYvZUduZEF1NTRudm1YQU5QMmx4SmFpYjRIY3FtWVdTeHR3dXdz?=
 =?utf-8?B?bmZBMjhzSXdPbThQbWZPTGhWV3ljSzEzeHg0dFZVcjFyZWxMRm9rVWN5QnNP?=
 =?utf-8?B?TC9BcWZqekpxUnZCVDU2aTZ3bmlNZGp1QUJGcVYzQ25qcHJRdDAxZVpwcW8w?=
 =?utf-8?B?U0wzdXlOaSt6Vys5eC9nSFI3eXVxL0hwZ0hITVNZQm5YaExXMjQveGhWZVZ2?=
 =?utf-8?B?eUVzNXJpTWdFV0JWaHpGUkhDQlFxdlcra2ZxMDZvbUg2UHdTV2NBa21qa0Yv?=
 =?utf-8?B?YzZvSkFFNWUyck1JZXYwd043dWRZTTQ3cjJaeTcrQmpXUDNlNm9pMUsvUldq?=
 =?utf-8?B?bUhrK0d6dENETk96RG5QZ2xWbm5sWlJDQSs4ejBTenRLL1lXeXk4dTYzTDhm?=
 =?utf-8?B?YTFVV3ZxK2VOdStCV2pKMm55bC9oa0JKY0R6eFFFMzdzdGJsV1dpRzB4dHU3?=
 =?utf-8?B?UkJub3IxZHlUa0xpbkdhMjF1OGxJMEhyWmxjR1F4QytRWkE0NTNreVNkb0Ix?=
 =?utf-8?B?bXdYUEV6MWdYcHFUSSs4UUU3WFlVeWFXVm4vSWRCMkV4akE1S3JLaEJDNjV3?=
 =?utf-8?B?S21ieEluZkdqMjdzU1J4WFkxbTd5M2FMa083VG1lTGxhTktDOUVwemFiNHZ5?=
 =?utf-8?B?MmN6cFZ6cEJiKzdDYWU0Snd5dWs5WTFmV0tnRHBlZWJMbDZCMk5CUWxqK05J?=
 =?utf-8?B?YytJd3Eya2ZkOUFETlVuZElYYnpGVEc2UTBGT2RHeXAvSFNiNmxSL3g2MUxz?=
 =?utf-8?B?TmN6R1N5WVVkVjRJWTJtRUVaZUE3ajZLNUNJbnA0UTBqNzdkamI1MjhKd1NM?=
 =?utf-8?B?ZVFlMjB2cEY0dG9PeVEzSWUyKy9WY2tla1NrSkxFb0FXVWxxZU1kOXkweEcw?=
 =?utf-8?B?N0dRMStqNGxqVUxvZW9PSHFNU3Z3T0tuU2JQUnNoSlBVRWMza3hkSG9BM0Iz?=
 =?utf-8?B?cTRvZkQ1K0hNVjQrTTRXM1FWSEdtSnJIQkp6M24xT1A5NnRrS3ZGc0UzamJB?=
 =?utf-8?B?ZGp2SmszSVF3N1RyWEdJczRnOWVuekh6bE5aVlAzTFR0ZUJ6OWpnTWYyaGlj?=
 =?utf-8?B?aWxpZkZvbHBXQUVrNEtrL1VqVFh2VFYxMmZLL1FGSG16YzZ4T3plTmJaOWdK?=
 =?utf-8?B?aGIxQkhFOEw2MUtqODdiTWpCcDdMOXBGR2xDR2dBcFhsN1BiU3lCNXUvemVZ?=
 =?utf-8?B?M0MwL0NIZ3NHcHo3OFYrNmlJS2pwRXhTRFBZUngwdGpLNFRGbEZoWjNzejZ3?=
 =?utf-8?B?SDRVQWJJcWlEL0Nxc1pZOFV1Vm0xdDc1RnpOekV1ZUQzSHVmQW82OUwzNDd6?=
 =?utf-8?B?NzF4U1J3dFBiKytHbUpBc2ZRTEJIWXNIVUFUR1p0MC9GSTBkZThkQmRJVHJF?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1be0e9-9e7d-4a5e-b998-08dc3843e448
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 09:59:02.5812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvZbCaaWkOtakLd4dCGpBOfQPP1eMK2QWb04xlMtkapOYcGhexPQBVTMnvlw7gNN3vUznPjzCwhiBqlih6j3sn1pQWOX7gw0MuQTmvnzFf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8145
X-OriginatorOrg: intel.com



On 28.02.2024 07:28, Horatiu Vultur wrote:
> Lan8814 phy led behavior is not correct. It was noticed that the led
> still remains ON when the cable is unplugged while there was traffic
> passing at that time.
> 
> The fix consists in clearing bit 10 of register 0x38, in this way the
> led behaviour is correct and gets OFF when there is no link.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  drivers/net/phy/micrel.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 9b69735819896..5a0cc89eaebdd 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -114,6 +114,9 @@
>  #define LAN8814_INTR_CTRL_REG_POLARITY		BIT(1)
>  #define LAN8814_INTR_CTRL_REG_INTR_ENABLE	BIT(0)
>  
> +#define LAN8814_EEE_STATE			0x38
> +#define LAN8814_EEE_STATE_MASK2P5P		BIT(10)
> +
>  /* Represents 1ppm adjustment in 2^32 format with
>   * each nsec contains 4 clock cycles.
>   * The value is calculated as following: (1/1000000)/((2^-32)/4)
> @@ -3288,6 +3291,19 @@ static int lan8814_release_coma_mode(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static void lan8814_errata_fixes(struct phy_device *phydev)

This name is too generic IMO.
Maybe: lan8814_clear_2psp_bit

> +{
> +	u16 val;
> +
> +	/* It was noticed that when traffic is passing through the PHY and the
> +	 * cable is removed then the LED was still one even though there is no
> +	 * link
> +	 */
> +	val = lanphy_read_page_reg(phydev, 2, LAN8814_EEE_STATE);
> +	val &= ~LAN8814_EEE_STATE_MASK2P5P;
> +	lanphy_write_page_reg(phydev, 2, LAN8814_EEE_STATE, val);
> +}
> +
>  static int lan8814_probe(struct phy_device *phydev)
>  {
>  	const struct kszphy_type *type = phydev->drv->driver_data;
> @@ -3323,6 +3339,7 @@ static int lan8814_probe(struct phy_device *phydev)
>  	}
>  
>  	lan8814_ptp_init(phydev);
> +	lan8814_errata_fixes(phydev);
>  
>  	return 0;
>  }

