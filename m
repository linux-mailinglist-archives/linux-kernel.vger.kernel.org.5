Return-Path: <linux-kernel+bounces-69442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A7985890A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EAFC1C21602
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A92148310;
	Fri, 16 Feb 2024 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJ/3h607"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E83A38DFE;
	Fri, 16 Feb 2024 22:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123073; cv=fail; b=IXOo+vGZPTQiTW3bAho3hk+Gnl2B/WrrCq667tr5urBCY89J6MVH2p8eXQiEgdoOiQjlHjxOXNHs8SXzhvA4G++fEY+fiRxEBArQ7XVt+VXE+hyqOTLenx66X3gz3YP0zlIFVWbP1D+Vv5J8g0a9CQOVreAe9MA9KXnzqHctUgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123073; c=relaxed/simple;
	bh=/3aXtAuPwgP1LO1+nZZrfII8zrVajmM5kR9LFs8Ji/w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CyExpX1jFjtWdqoOIb8Mqs6xCV9Zg8Ueo2YZRuQgtdpXkKuybJoQGjJM/QfsZ3nv5hzjpaGA2LO8BWaq4IMonZ7cgo3iZNZpJNAE30u8WOX8IpCFAkt2E5E7uEMqw3jYWv++L8niGLuUVk6rIw+S/3RM9juwcKh7aowg4oYzPGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJ/3h607; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708123071; x=1739659071;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/3aXtAuPwgP1LO1+nZZrfII8zrVajmM5kR9LFs8Ji/w=;
  b=KJ/3h607T1XLnmJG8d4yOSfFK20vEQtsEe+LtK+GytAGdQZRHjY/EewV
   p7Pj2SAjE7y/Z6yKrbnwRrTAuUhQ4pbvKvC4Zd6zqaipwurty79Q2MrVd
   pHe9EO8f5youZ1G5P67WW5DLhD7vmoJgTw8H8b/iXirXeS+mlz+6gzEnh
   hTfs4DJXonAjG0AOB4f/xywrEGpBE4J5HR8fZR+25YTK8bbLpqGrwyrx+
   s6waxULIBbMZgxmjtIs/HBggbZTCNXMEi9plaqQHRJcooR3nZP569oWIf
   FQv3amoIAPdyfvhHHRC8p8hzuZhbmAmga36ro2hQaqsuXlcycO287mSra
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="12821400"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="12821400"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 14:37:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="3923227"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 14:37:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 14:37:49 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 14:37:49 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 14:37:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Urf03F5VQhx9VpshUbVl+enzfqW2tYEmu9N5sECE43pYBl3z2ANhXZOxx9eSBJfLUDGPa///83h3PwSOnOefIAr8bqKoIw1ysyl8GvSikNBudAWKV1h7npd4IeE71OLPLlBqUFADdKdlrSfCX0bd5VPdvcoVrlzdz83XhrfdaKbiKG40I5cDAhI29ErzdPIu6D1rKYFqJ9C4lc4YXREoScOUEO6g+fvDNIpgtVzeRRnGqlW2PwWa+P/1ZzGx3WDxm59CjE70qWg2Na6nN5BlBqmBBFUIHYiqFKCInKK336oco4yTIhBlOFvNfxL+jQf1oIzr+zvPZiyqUV9PNzl1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faNmyZac49CTGhWWQTLXDqq2yCfnBsybLPLHHgVR9Zc=;
 b=eEqMs+rlkCser72c4mRTpcu+0rltJwXu40kxZV+9SBoOwr9VxBVhUvCYQfT7gqFkChJio4QBDhTCWIiW4Y1e/2n1v06bk5Mlcz4k+44y4aI9RT1eyoGRbZi5DJChLxQDGyQpC/AV3X2VVvZyw9NJPdwAoh2L1NS7BlVQ8NwM5ZT6IMr+trOiIHJpQ6DWIgEZIEd0PP79LmcxPkQc1jxu6k9yHcAwVGB9CgkMdZ81XnGaPj/O0O0dPgE4eePXdGeOT9CO3MiQjW63gEBENDc+9sFUe0EKO564BP/8qhe7UOurdi8QPYHjXRt4GVkaX/cdF1OYnw+6sGLNDKBdKDb/Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB7495.namprd11.prod.outlook.com (2603:10b6:510:289::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 22:37:47 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 22:37:47 +0000
Message-ID: <9229efc2-832d-4b13-b3ce-8b3db22653a4@intel.com>
Date: Fri, 16 Feb 2024 14:37:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: mdio: mdio-bcm-unimac: Manage clock
 around I/O accesses
Content-Language: en-US
To: Florian Fainelli <florian.fainelli@broadcom.com>, <netdev@vger.kernel.org>
CC: Doug Berger <opendmb@gmail.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, open list <linux-kernel@vger.kernel.org>, "Justin
 Chen" <justin.chen@broadcom.com>
References: <20240216184237.259954-1-florian.fainelli@broadcom.com>
 <20240216184237.259954-2-florian.fainelli@broadcom.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240216184237.259954-2-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0327.namprd04.prod.outlook.com
 (2603:10b6:303:82::32) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 049fc1d5-db76-4df2-01a2-08dc2f3fe644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3GGiyWcBmNKJB8I6tjbFjk/andeXs9LHsrqXCCtDRsKaHouFC+HykYAPc8ncIXyQJiATarR1hE3QvLK/pMapMI0cKIx/bdTkuRxPYEC5ffa4hfq4n9bNvMpAVh5Oy4Al9eWjDhY3ikL5GzHc9/c9q6mxyYGB/4C+wiVo33sXm/EUkJjzuHwFCn0z1UkJr3HC8KIZ6Vd+u7DvshPfq9XnVLXfyD3dj/Sq8IMn33UPoCDqoVa94/wQUIifiX+VFBS6mPoaiNrMzKa9rQWEFJqTSaktj3MwBjC8RrojAQYfs5pU8Kg4VJxtkc5m60UPTAsjCb4CNFUoU65v+ioJNJGPZV4lLZ67WK2Tc7B11bxzITQkA014bvXgXiIm7a9g9o8vsuMf6mq60AWsu9BLYX5vGGXofHJCDyPl9H9R1QSHF3cE2ftWrjUOx5zngxQNeDQzz7nJPSu1DciqR3MMPfhwo3tVz06ZXNcH/k0AdLo28K1E/vvAwLw+kDyCVYsvF5ZWvRUgY2i2rirXNgS/ZwNAn4ey0TE3x9RtHk2W7SAPr0TqeFHp7ra+m3ejFW3pj15E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(54906003)(478600001)(6486002)(36756003)(38100700002)(86362001)(31696002)(83380400001)(82960400001)(6506007)(2616005)(26005)(316002)(53546011)(6512007)(7416002)(66946007)(5660300002)(66476007)(41300700001)(66556008)(31686004)(4326008)(8936002)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUxScDUwdmdsQ1Q0aXhZRUxYTE9MOGM2TU5oV0tsbmdWQWtxT3c4eHI1Znhj?=
 =?utf-8?B?QXU2cEZkelZTcis5V3BaVnNjNklwT0JXRnZWQThubGpOZFBudjkyS1dVOUU5?=
 =?utf-8?B?VzdJL0lGZ2hVZks5S2FJWGpUMnZTSWRPTEYwS3haVEVQbEV4SVgxU2NWWU51?=
 =?utf-8?B?aGgyRk9yRjE4eEErcXhxUnl4VUlDTjRBUk1qTHNLbGYxRERCQWtVNmRVOFlW?=
 =?utf-8?B?dFV0SEg1SDlpSjljazN4cFkwWDlBMXU1RHFhRHFhdEIrVnJFemZ4VGl0VlJN?=
 =?utf-8?B?d0k2Ui8rc1dMTzd3Q1lldjJwM1o2VEZRMGhlMjVXenBwbVFvVUE2MzNlTE1R?=
 =?utf-8?B?Q1BWZi9tUURVWXJnSG13S0tIUHhodzNlU0FLT1E0aWt1RFFVT1NNYTFRWTVG?=
 =?utf-8?B?ZzZ4R2hVZEtpVHdodmFZcVRNUk4zSWlKaFFyU0Y3K2RiWGRhRXpWQXhxMTdD?=
 =?utf-8?B?STVncnB6eFpYVGhGeWxKZEFVUnBQZThTaDlOdTZNblRHb1JQaTNuQ0xwUytV?=
 =?utf-8?B?V3BNbkt4aU1rNjdmYUwwWmRtOEFTQ0tEdXJWL0dnN241ZTAvNlhQWHRJZDJM?=
 =?utf-8?B?eDF2WVk3ZFVWemk2ZWdjZjZBUEhkbFM2RTdldE14N1UzTnhOOW4yZDcrSmMv?=
 =?utf-8?B?MXlFaHZNNW1PYnlxUXZVS1JnajdqbktiUjJsZE93YUhrVllUSkxaTnN2Ty95?=
 =?utf-8?B?RDgySmRTd29EWGdaZmx1SG43S1VKcGpEbklLYXY4MkZEMWtjckR4OW9ETW9w?=
 =?utf-8?B?MC9IanVWdWZIZVhkNHFJSGNLSGcyVFQ5L0huYktvWC9QdnI3cGtEN0NlRWpV?=
 =?utf-8?B?TjBRMkdOOUVsdCt4VGs2R3dKVWIvY2pQMDg1V202SnZqTXp1eVUzdmk2UUxh?=
 =?utf-8?B?YWVWcjNLSW5NU1p4YWFNbmovVWZWSG56QXJNV1FpRGN1QnJUQ05ETi92TzUw?=
 =?utf-8?B?ZTh0V3lNcnFTNUZnaGJXTVlYSmloL1dJREgxZENlakJET3lpNm8rZHBoNVo4?=
 =?utf-8?B?ZGFCdWtHYzhyaTltbGRTVXUvWkl1OEhNbGJJUlZaRUZxNTg1TjgwdTF4Wm1R?=
 =?utf-8?B?RjFJRHl3RmpTbWFuWGZzalZzYjhheFJrZm5HSkkyY2w0MWxyaEFYSUdRUkJN?=
 =?utf-8?B?YnlSSDBBNjF2bG52L0J1WHNkcTFYN1UwTVMxS3ZHeVU3L2E5eXVyR0w4d25G?=
 =?utf-8?B?Wkl3VzJQRWFPQnZPNlcvSGswT2JDWjFHRHVoT0VJalljbUQ1aG5YV0FEcks1?=
 =?utf-8?B?d2dNeWVGVndxbkhmSng3eWVBQ0tEVUE1UUZxTms0QXVvYnJ6dllYQnpwazd0?=
 =?utf-8?B?dDJpQmFCR0dSZDRrV1o3bDlGSTdZbFk1akhURkxWVUo5RDRybTFiNE9tNjhV?=
 =?utf-8?B?UG53MFR6WlMzNzIzVWxuL3MxbXVvaC9pV2xxbHNheC9taEo1R1lwYmZWdWw4?=
 =?utf-8?B?MC9LQmIwWnhoRFJza2VFUGtzWk04elllSmg4NHVpb0tCdnZXVktrZmpiSkw3?=
 =?utf-8?B?anlEK09Da09VUWtGYUxZTXZjRG9la0NaZmFZQUo4aXNuZG40TFE2c1paTTZt?=
 =?utf-8?B?YjQrK04rb0NaQy9wNFNIRkdlMTZIWHBXeVVJMEI1dHFmUmp4L3lOaFdtRnhD?=
 =?utf-8?B?aHpNUWlHYUtQR3BCbGdieGd3U0FvZkxueGJYTXA2UFdmMDhCM2w0OEh3N1Jj?=
 =?utf-8?B?TGVQTFhyc1J3cGJreTlyVURZOHMrcGpqT3grUzBoUTRuTjE1d1lzaEZqRlRh?=
 =?utf-8?B?MVE2VHNMQVh4aUxud0FZeGdXYTdzMG1ianpQYzFOOGR3bzVGQWhTWFN6QzdG?=
 =?utf-8?B?ZGMxbDBvd0YvWUVpcXlLdnNZY2JsV0dzTkFtdHNHR1BWRE0wRGwvWGNCN2Fn?=
 =?utf-8?B?eHhOL0N1cFA0cGdONUZCZWVrVE0wb1I5UzU0ZzQ3dGlYYU9CZThJVVU3UnNW?=
 =?utf-8?B?MXY3cXR3TFFjTTRhZUgvNktkK1BZcGV2cUx0QzRhM2hyNkY4K2ludFpwTWgr?=
 =?utf-8?B?akM4dzRoQ2E2TlNzcVVIdWZmWFo3TmRJd2RPcDNTV3pMNldCSi9zbFBKaFVx?=
 =?utf-8?B?RllBOHMzMmY3SCtaRFU2NGRFa0JJdXorNzZSckZUVWJMbkxpNjBIZkJTQzIx?=
 =?utf-8?B?UEpaVE5kbmRtQUJNR1pnc2NYMWQ0OWY1QWRERjExekUzNmFVdmRjRm0xeC80?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 049fc1d5-db76-4df2-01a2-08dc2f3fe644
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 22:37:47.3214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RfVMpKyWG4yl0jJpjamEMY6GApIqU3cFZu2knlSwgbb8GEvgH1nTQBv/c8YK7Wbs2SObspkehgNqXS6Sqsk1KZHwKDuct9FTs9U4lKSZts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7495
X-OriginatorOrg: intel.com



On 2/16/2024 10:42 AM, Florian Fainelli wrote:
> Up until now we have managed not to have the mdio-bcm-unimac manage its
> clock except during probe and suspend/resume. This works most of the
> time, except where it does not.
> 

This made me chuckle :)

> With a fully modular build, we can get into a situation whereby the
> GENET driver is fully registered, and so is the mdio-bcm-unimac driver,
> however the Ethernet PHY driver is not yet, because it depends on a
> resource that is not yet available (e.g.: GPIO provider). In that state,
> the network device is not usable yet, and so to conserve power, the
> GENET driver will have turned off its "main" clock which feeds its MDIO
> controller.
> 
> When the PHY driver finally probes however, we make an access to the PHY
> registers to e.g.: disable interrupts, and this causes a bus error
> within the MDIO controller space because the MDIO controller clock(s)
> are turned off.
> 
> To remedy that, we manage the clock around all of the I/O accesses to
> the hardware which are done exclusively during read, write and clock
> divider configuration.
> 
> This ensures that the register space is accessible, and this also
> ensures that there are not unnecessarily elevated reference counts
> keeping the clocks active when the network device is administratively
> turned off. It would be the case with the previous way of managing the
> clock.
> 

Good description of the issues.

> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

