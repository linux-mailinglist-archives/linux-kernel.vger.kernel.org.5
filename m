Return-Path: <linux-kernel+bounces-98974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B048781C3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5983EB21854
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7654207B;
	Mon, 11 Mar 2024 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZd+wRlz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B552B43AD6;
	Mon, 11 Mar 2024 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167829; cv=fail; b=WRbil8wMR6DiuPVW7glNqume3mio9ZiOBxpJLzE4sjGPpCYsm3aYXsZmF//pkbHenreWqZkhsj3pm93/6Hr3YKWk72iDnXtWosfM9kGd6Hs0wcNvoFUXA8mz9e5B5dtXrGICKTVPSFUEcDTkiF7ozkMZIDbu2LzJGEd4AtSXvzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167829; c=relaxed/simple;
	bh=3U2q9PYBOUYTr9RbvMdWzwIyaDAEZU92szSfoxkMihw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P2Ygj8Q7pyiEPAHuPtumqalKG3trdZOWlvnzIN8TwEOQ4lr2Zg+wbeUbRZQrvh1mVnuj361/HjLIR8PUb1lfc7dR3SpekjRqvRLvpUPXkQHEil7PxveA0Q2YATNJ502ugiTs2BqBTBfueMEqXRXTNktwv6Rk/ivvDAJzOu0pjW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZd+wRlz; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710167828; x=1741703828;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=3U2q9PYBOUYTr9RbvMdWzwIyaDAEZU92szSfoxkMihw=;
  b=hZd+wRlzWvfttnNYNHPSQG5Pe0v5qtvh6ZSEU7xvz6RHjIF89YoB8ZK1
   glUOCzIvEjtFEBL2/QjBQZbV4QcBuAJyGPmnWlK0G+sSVqNSIYDiGbBsi
   1JpRSHlokiWto/WbYujRWRljKQW1Oxo6MlP8S4mPBym1rym5X3lwEaUhr
   4tPaPe0ysTPVpw2iNFZq4QJSutcGUS3hVzudYC15rx8jPC86OQROpzWLd
   FuuhkXeJQgm7OAB6uKCFZzVm4+14AN4R0NaUeIP6kCBuh/Kr9tIB6VOfp
   iDipCOVzxR1DOFJalg/iUdEvNAxIA6bOmBqHrJM7Jxsrym8kixbrkeQuW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="8591062"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="8591062"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 07:37:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11262231"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Mar 2024 07:37:07 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 07:37:06 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 07:37:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Mar 2024 07:37:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 07:37:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvQ6AvlEalNlIrosuYLQgbWC/uuvD6cc+9lPccH7E03pPgjXB7Y1jP9WhTwXBecjUxZB8aNyA/gE1R+L3WrhsyLUM2ra9DZPb2V1Ht/14y2czdzaUmdFm0Bcr8iWPs+sYcHL1exSSRY46vI4wdgGU8y4GE+Q3R8rnxzoM4LiNiAMTzMeEhAbKflLVnNWrTDHtQDgM8aQUmjIz2mTAL4RSWPk92vR5z04nBCl7FbkmUxzyLbHN31CbPvsljPSPKZqdVrQ7z2mmeEmZX8/SDnh3Kv0ZZF6T3oRrdjFHtljOVZ6TkZX21LD45UitZu8SKoi/GCC2+vI6AHGtRZLY3JETg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3EtT4RNJsn2Emx6k/vIQ1pFqcKA92phqznTOZcs0OA=;
 b=mArehLoRjRFwVTnyE/ZV0e0n+KdGVaLKW1v2MJJRIds8VG7ZH0DAL6gWpf9nvTkxqwjZkbWVCnUk42xyPukBtG9GXBcc12c2Xk4KctkWV+L7L4mh9V0oUR27B4cg3n9soUaV9j822EjrhbhheS0/KUxFM2edAN0QQiyyq8PL6/Jt2k3f9uDfu26UOaGdVEX/0fj+Ubdwh4GA7MA8uJ/Hwne3FZMtTC2jubsw0rgc+K6qCqkcjTZxXjH0JB3+QH8x6pA8tMvzxWvjpdtXZQ1hdY5SltUVuLQb9W6OOx2SMKuxNNWH9yKJDvNJXMISCHR2CqQWMH+Dabl1v5coGCSGrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH0PR11MB5266.namprd11.prod.outlook.com (2603:10b6:610:e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Mon, 11 Mar
 2024 14:37:03 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea%5]) with mapi id 15.20.7386.015; Mon, 11 Mar 2024
 14:37:03 +0000
Message-ID: <eb09593e-340f-41e0-b7a2-acfdb7d6fc3c@intel.com>
Date: Mon, 11 Mar 2024 15:36:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: marvell: prestera: fix driver reload
Content-Language: en-US
To: Elad Nachman <enachman@marvell.com>, <taras.chornyi@plvision.eu>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew@lunn.ch>, <kory.maincent@bootlin.com>,
	<thomas.petazzoni@bootlin.com>, <miquel.raynal@bootlin.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240311135112.2642491-1-enachman@marvell.com>
 <20240311135112.2642491-2-enachman@marvell.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240311135112.2642491-2-enachman@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0370.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::16) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH0PR11MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c4abfbe-5b8f-4986-83d5-08dc41d8b7c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PTiZFupkE2UWEW4TIEUk6r8KywLzzj0zoogRHeNKAoBjhV/9tc2v2EMplo2kd58Z2829aVUJcE1qSMVJDLsJv5gOt50tQwZ7CPWLvuvVefQq6jTlYBw3u7XOPDoRYwDadsRxkb/8MZyiXeqk3Na88vdjiZytSXdCn1+VAvOwB+6wVXyz7MsRF5ke+T3W0ouL7Rd/Dnotp+oczI5eRfbK5Bai89Kvp375pRRDmWkcntjoiz+ec1tWpANYHbgw0D6kywfU00TNYy5Qpb/V0CKAkhKMT96pdMkPv1bbyE6kLXtENBoYL1cyTlBD5tXU+fgzzatKbAgbQ7QEP6rosYp+a/ggjWs3VxAOLUpfoYbwzavWdEYmAJw5tcgAxl+9Qd7gZ34w5LO59zDaBbvF6phmsI6Fg9Nn3KkXH8zzZXtqfpkSq7kpxmcHv00V79EmRMebZLAZtz0xODdI7K4MgITiexOYBsa/9838er5EaI2QKkhbMggawVe6gAV51JZjK6zqXKMvoSmmVdyI3Zo374BpdIvrMOcDTR4fXBKmxeJikdA0JwTDKYQR+931llFbtPzM88dGqHM/ZGjfKrAqOmmlw54Gdr9wUTfBFz2Kqld19hbh7QsNMK1M8pAYt2R/QYlDjN4CsRoTGn/IbZPnS3aAWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnhoQTNTNU8ybUxhWTRjUVJNZFRrV0xrSXdmVVVKSnFxdDl2MWhuRE1JNFRs?=
 =?utf-8?B?M29ZdmIvOUh0R281MGVmMGx1dFVzZy9JZENTdUlDMlpUTm41MlpBWUFMeTVv?=
 =?utf-8?B?NS9tVWZOd0JuWTBYVXQ3a1FjT0ZPUmxRckpNTXYzM1hhMWllN0VZN0tpeWtI?=
 =?utf-8?B?T2lkMnR2NjNldlZpTUlpd1JYMGl4anRRWVJsTFlNYmJoaTRza2ZXRzY5TjB6?=
 =?utf-8?B?RVZRSE9JSFZJMGwzL3RYYzBaQjFpc1hQTStsOTJLRnE3L1VlOXphc1Q1bFBO?=
 =?utf-8?B?K1Axai9CUGNjbmRNb3N1bnZQeVJpNi9jMWJwWkhlQ3RiWFFlUjVIVlorZWRP?=
 =?utf-8?B?emZXTVdjYlhvc0ltMEZ6N3VlY3FoaUdVR3p6WS9vdnJWRjFXM0sxQmdOOGJk?=
 =?utf-8?B?azRDZ1pHNW1IUGhMMXBrc2ZydzRBT2FkeU5TeEtJZVc3OXpDNFlBRkY1Y1dC?=
 =?utf-8?B?dVE2QnVVWFljcGlyWVM0NFhPTUgzMVlNei9ra2xZa093VWJ3R2lHQjdMOVRM?=
 =?utf-8?B?Wjg1R1JjeUNyWXd2aFdtekFwSlBVMlQ2NlFwQitsZGhwd1kvb2dONHRaYXJJ?=
 =?utf-8?B?KzRybzlwQitXYTBBK0ZrTFRoa2RjM1R4Nzl0dkNlQzdLUUtZYU8wWXhHS1kw?=
 =?utf-8?B?NFZ5QnhiU1pubEVYZ2NzVklkRVd0QXdzRXhhRFVWcllXMUE3dTIzRFM0Z1M5?=
 =?utf-8?B?MDZUM1lqMDZ2K0pqWlBLcVF0Y0ZzS2VNd3BIemRteUZJRDF3TGJzWU5zMXFI?=
 =?utf-8?B?ay9vTi9BODVEREI1S0tKaUowZkZJSnJCNHI2YVJOMGVZckRON1RleEVoR1dM?=
 =?utf-8?B?NWlZVjEwY1NhdStVendTMXRTWnZEbUs4QTFCVVNrRTBZSWJyOEVwbzQ3d2Er?=
 =?utf-8?B?YWxxU3NKWUJZQkVUMGdmekkvTVVub1ZWeS9yeXBYTG1uaS83cDkvUjJsZWN1?=
 =?utf-8?B?S2pXUndqZXJaZ1ZaZnQ4b3ZmYkhLeThzSHhJTEZ6VDlTd0w3d0dMZkV3QTVr?=
 =?utf-8?B?REFubk80RktBa09kTjV1M3czRnBsejl5NkpKdUxkYjI5NnVvdTAzanJvYndr?=
 =?utf-8?B?SmF5OVhkWldzTlR1SmRhanI3Y1NJZzI5VklXVnlNTWc0OCtLUmZESEJRaXVr?=
 =?utf-8?B?MTN0UWVmejEyUUpIVFJManBXenNkcHJ4NUwzTWNFR1htb2RzelJtekwrVzkr?=
 =?utf-8?B?WVF1SkNNTWtsOThXY3dQaXk2cjdMZ3RQL1FOL2hibC9qemdJUmlnSUswVTJh?=
 =?utf-8?B?d1lDdVh3bThCSVJVUUgxeVlMUytJaVFwbWF6bytKKzBpeEpQNUYxYUswWTlw?=
 =?utf-8?B?akxrajBVUXFwV3lDcXpqUStnZHlTV1NKUWRYTHF6MHp2LzY0K2IvWWJvZjlD?=
 =?utf-8?B?TFJvYmhLc3k3Ykw2SDQwd2JlT2tRMWtFMEpNaVlONy8yL3dRa1B4UEtncXRw?=
 =?utf-8?B?b25aWmlUNStYOE9pM3BrSWErb0o2eXJ1TXJGN3lKNXNMN2lteE1qaEI5Ui9i?=
 =?utf-8?B?OXEvL2VZRXpaT0g5ZWhiZ2h4K3cwWFcxYmV3QmJYRXE2MkNWa3pBRjIxZE56?=
 =?utf-8?B?SVRwVzlDaG9ocUxsZ3U4MWYvN01Jd2xRSmRiUWUvUW44NVRtclE5K3RwUE5S?=
 =?utf-8?B?MFBvUVFYNHFUYnc4VERXNWtxOFUvWjV2NUJ2VmFsN0xOZktqVkplamtFN016?=
 =?utf-8?B?dTh3SVRSVGFodTc5NThaWmhHL0hYYkFDbXRjcnJQb1NQaXRUVGF4ajRReThK?=
 =?utf-8?B?N0dvT1U0d0xWVlFrWUhqcHB4OUl3RUNEeTRaUzN0RGdCaGIvRnBuMGJaU2ND?=
 =?utf-8?B?eGNvRjh3NG9pMG9qWU13N041STV4OEswWi9GZmVFQ3JqNFgzOXZyUkpFa3dk?=
 =?utf-8?B?MUdrSmVEUVpJYUxhRzdYdDJmb3Yrc2NtTXhoejJ1bVN3UFIvcUpUdnhOSERQ?=
 =?utf-8?B?a0lZelcyOXhRTk1NbVEyZ2orN2N2NU1rRGVudVY1L1Rtb1c0aHdEMWhYT2NO?=
 =?utf-8?B?bEhaZ0I2Kyt1dVhWSUpyVkRpSkdOb2dnbkV3SkpBU3hWaDkrbUlQZGp4K3Nn?=
 =?utf-8?B?WE9Ca0lPdFdKSkV4NFdqdzZ3cE1ONFdpcWZkb1JPclhXQ3JHTDJFZHNLV3RB?=
 =?utf-8?B?TjZrcUhyYTl4NmR6U2J6MUVVOWc4NERkcHg3UERxYmxLSWhlSWJYWXJBWEJR?=
 =?utf-8?Q?RY1B4zpbGMDEBF81lKq5sGs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4abfbe-5b8f-4986-83d5-08dc41d8b7c9
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 14:37:03.3573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vH6nkiCBZwl/XHdGiQ5rcQodIUYMFv6/nDzZSV3/HNonM5oHja3R5/xYRAFjv7H5MsjTi9rY/eVTnIBsX/rOxbykOoptbCHb0sN7WNOQQJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5266
X-OriginatorOrg: intel.com

On 3/11/24 14:51, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>

Just a note, not an issue for me:
it's unusual to have "From:" line about yourself, especially that
you use the very same address that your "Sender", and your Signoff.

> 
> Driver rmmod after insmod would fail because of
> the following issues:
> 
> 1. API call to reset the switch HW and restart the
>     firmware CPU firmware code loading was missing in
>     driver removal code handler.
> 2. Timeout waiting for the firmware CPU firmware
>     loader code to start was too small.
> 
> Fix by adding API call to reset the switch HW and
> restart the firmware CPU firmware code loading when

'firmware CPU firmware' sounds off;
you could also reflow your commit message to use up to 75 chars,
instead of shorter lines.

> handling the driver removal procedure,
> increase the timeout waiting for this restart operation
> from 5 to 30 seconds.
> 
> Reported-by: Köry Maincent <kory.maincent@bootlin.com>
> Closes: https://lore.kernel.org/netdev/20240208101005.29e8c7f3@kmaincent-XPS-13-7390/T/
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>   drivers/net/ethernet/marvell/prestera/prestera_hw.c   | 8 ++++++++
>   drivers/net/ethernet/marvell/prestera/prestera_hw.h   | 1 +
>   drivers/net/ethernet/marvell/prestera/prestera_main.c | 3 ++-
>   drivers/net/ethernet/marvell/prestera/prestera_pci.c  | 7 ++++++-
>   4 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_hw.c b/drivers/net/ethernet/marvell/prestera/prestera_hw.c
> index fc6f7d2746e8..08de8b498e0a 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_hw.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_hw.c
> @@ -21,6 +21,7 @@
>   enum prestera_cmd_type_t {
>   	PRESTERA_CMD_TYPE_SWITCH_INIT = 0x1,
>   	PRESTERA_CMD_TYPE_SWITCH_ATTR_SET = 0x2,
> +	PRESTERA_CMD_TYPE_SWITCH_RESET = 0x4,
>   
>   	PRESTERA_CMD_TYPE_PORT_ATTR_SET = 0x100,
>   	PRESTERA_CMD_TYPE_PORT_ATTR_GET = 0x101,
> @@ -1087,6 +1088,13 @@ void prestera_hw_switch_fini(struct prestera_switch *sw)
>   	WARN_ON(!list_empty(&sw->event_handlers));
>   }
>   
> +int prestera_hw_switch_reset(struct prestera_switch *sw)
> +{
> +	struct prestera_msg_common_req req;
> +
> +	return prestera_cmd(sw, PRESTERA_CMD_TYPE_SWITCH_RESET, &req.cmd, sizeof(req));
> +}
> +
>   int prestera_hw_switch_ageing_set(struct prestera_switch *sw, u32 ageing_ms)
>   {
>   	struct prestera_msg_switch_attr_req req = {
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_hw.h b/drivers/net/ethernet/marvell/prestera/prestera_hw.h
> index 0a929279e1ce..86217bea2ca0 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_hw.h
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_hw.h
> @@ -150,6 +150,7 @@ struct prestera_neigh_info;
>   
>   /* Switch API */
>   int prestera_hw_switch_init(struct prestera_switch *sw);
> +int prestera_hw_switch_reset(struct prestera_switch *sw);
>   void prestera_hw_switch_fini(struct prestera_switch *sw);
>   int prestera_hw_switch_ageing_set(struct prestera_switch *sw, u32 ageing_ms);
>   int prestera_hw_switch_mac_set(struct prestera_switch *sw, const char *mac);
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
> index 4fb886c57cd7..bcaa8ea27b49 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
> @@ -1444,7 +1444,7 @@ static int prestera_switch_init(struct prestera_switch *sw)
>   err_router_init:
>   	prestera_netdev_event_handler_unregister(sw);
>   	prestera_hw_switch_fini(sw);
> -
> +	prestera_hw_switch_reset(sw);
>   	return err;
>   }
>   
> @@ -1463,6 +1463,7 @@ static void prestera_switch_fini(struct prestera_switch *sw)
>   	prestera_router_fini(sw);
>   	prestera_netdev_event_handler_unregister(sw);
>   	prestera_hw_switch_fini(sw);
> +	prestera_hw_switch_reset(sw);
>   	of_node_put(sw->np);
>   }
>   
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_pci.c b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
> index 35857dc19542..b75a263ad8cb 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_pci.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
> @@ -24,6 +24,11 @@
>   #define PRESTERA_FW_ARM64_PATH_FMT "mrvl/prestera/mvsw_prestera_fw_arm64-v%u.%u.img"
>   
>   #define PRESTERA_FW_HDR_MAGIC		0x351D9D06
> +/* Timeout waiting for prestera firmware CPU to reboot and

it's implicit in your driver that firmware is "prestera firmware"

> + * restart the firmware loading software layer, hence becoming
> + * ready for the next firmware downloading phase:
> + */
> +#define PRESTERA_FW_READY_TIMEOUT_SECS	30
>   #define PRESTERA_FW_DL_TIMEOUT_MS	50000

nice that you have separate timeout for Download and 
BeReadyToStartDownload ;)

it would be less typing and more consistent to have 30000 and _MS
suffix, but that's just a nitpick

>   #define PRESTERA_FW_BLK_SZ		1024
>   
> @@ -765,7 +770,7 @@ static int prestera_fw_load(struct prestera_fw *fw)
>   
>   	err = prestera_ldr_wait_reg32(fw, PRESTERA_LDR_READY_REG,
>   				      PRESTERA_LDR_READY_MAGIC,
> -				      5 * MSEC_PER_SEC);
> +				      PRESTERA_FW_READY_TIMEOUT_SECS * MSEC_PER_SEC);
>   	if (err) {
>   		dev_err(fw->dev.dev, "waiting for FW loader is timed out");
>   		return err;


