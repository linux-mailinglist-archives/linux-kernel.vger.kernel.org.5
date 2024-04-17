Return-Path: <linux-kernel+bounces-148417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087138A8244
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA99283C6F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B3F13CF87;
	Wed, 17 Apr 2024 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQRAY4qT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE54D127B45
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354149; cv=fail; b=WFZheqD4KLDXRL0fzxxczBHgxKAIibGkREg09gBvetsdQ5b5/FdjATwhCD7dbT25D5INP3OGEO0Oxn/8wR8XOkpeDx6DRn1hLWBMpG/7pFmEG61RRk0erOhA+e69jzLpGFdy/cVi8wD1nSGf8vMvdMkCFG0VQuNQFn773LYdQhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354149; c=relaxed/simple;
	bh=/6u30+r4HyWTAqbxy8qd6liyRAYdYk+oIU9oItECcbE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YwnJZTyIpDinrrbGLvspU7wv++pPJp+/RAR1sc2ZvcqTZ8OAgf8Q0SJIwlgVxYQ0IXPj0Zvwq6DN2cvY76Ja/8iOYfy4JQVQNTRdRpOC2NTZwwIomMMolA64lR2dhuG1OMK3GqBx39ByRCk7sR3U+6yESHYm7eaOoQ3c4ZQMR2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lQRAY4qT; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713354148; x=1744890148;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/6u30+r4HyWTAqbxy8qd6liyRAYdYk+oIU9oItECcbE=;
  b=lQRAY4qT4cHG4iv5IrJmm5w2bjKVnvy0QqhnFMmBDm4fuYEtjQpmTJbJ
   ET53R7ramArk+1Uc6tL0MQ3JUvVQqcm7fktg4LpgDltkHdZpdZ6LDNWOq
   oa4Sd2mJMBt1XqUVTkNbBt49IO9No+6nwHaYDfMQLC3dOROgGT5Du33kW
   /L29SwCGIhwOzKirt6g7lIA5bd/gKoGLEQ1RShZeoALKkD4Bk8INdDiwy
   GNRQ/MdGsHOWS6ogKxjdAQS98N525wTiE9Bxv56S8MMTP3gd5DabS8ygd
   dTt2krAWU1gyl7vWLQUAa3OQekAXrrhKWN2Uxl+BLz+Z0RQZZhJmaBzRC
   A==;
X-CSE-ConnectionGUID: iIzKa2C0SUOORdFZK7BSpA==
X-CSE-MsgGUID: LKKjDdFgT/yIjHz2ey3cGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12625086"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="12625086"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 04:42:28 -0700
X-CSE-ConnectionGUID: ed20tlWkSC++blMn2AeVpg==
X-CSE-MsgGUID: vRIOPudCT/yTXX+WGvs5cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="27382753"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 04:42:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 04:42:26 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 04:42:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 04:42:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 04:42:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2sebsc4SIxJ0ukxMbJVx1iEe7xmjiET9cQVCsMIRNm64NXgAuD0ezmdRylq0d0I6wtD1uw66kjDLF0ya8Qb4PLm+OQhlDi+MSYPtyMA/5q0LM1EoIfNjWpZ1YxVd2+C19E+70AbWMLtSA0C60QgKDbCExTSBneEWozUzaBdpc0VKNMwGfFIpe7Lg4poTGy+czAZk7HbyWfmTFDGhj4YDzFnsWvZ8kVgCA/n7UsTwZnxzt1779onYqTVcYSrQ8V3yBnX+Ntai9kHKIXRZbypDk4qKq0qYZC3cvqzoxXH8p33wd0ApM0XkdTKlHozFf37tBPa7aEkOclY4UbJTvRzwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Qoj272mVuVUU8ywY76KO/Wt2XEqCeWEjLpkk1RkfKg=;
 b=PlY6JvamnVnTqfB8Oyscz9DIRM5/w7eWcFmm4Bw/MXjUOKSndN+laj6TVYJ/pgJ6Z80M2UQUgbMnvjg9UMHoIDt0Nbv0etZVloQtc8QsBF3zcoLv/0yEanYHXDXVgw2PkqYhwhL3uNbF67uQdx3Y3laoKAAlRHj4RpUqZRG0G/APmfCBIUIm7sSTGX7bR6Cmy9kyMjzlTajqot9IEU+isO5L59qKwRSiIuAaAHc+xoa2nf/b/tZTVZmJiXQESEFfIbSWB2nezdUOZMxsCv+Y36HUE7m017+BvE1N8a3PaaVrj6DBC/8pYTkaN/x5YEmgNnWcDadWPfI3kN7zgxkaOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB8175.namprd11.prod.outlook.com (2603:10b6:208:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Wed, 17 Apr
 2024 11:42:19 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::9c8d:938f:e1f4:ef4a]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::9c8d:938f:e1f4:ef4a%2]) with mapi id 15.20.7472.025; Wed, 17 Apr 2024
 11:42:19 +0000
Date: Wed, 17 Apr 2024 13:42:13 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
	<alan.brady@intel.com>, <jesse.brandeburg@intel.com>, Emil Tantilov
	<emil.s.tantilov@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lukasz Czapnik <lukasz.czapnik@intel.com>, "Michal
 Swiatkowski" <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH iwl-net] ice: Interpret .set_channels() input differently
Message-ID: <Zh+1laRuDhNf21Lm@boxer>
References: <20240416125856.1263314-1-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240416125856.1263314-1-larysa.zaremba@intel.com>
X-ClientProxiedBy: MI1P293CA0028.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::20) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae75f91-ea30-4113-d883-08dc5ed37002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6w7HsjLUd8rYw8cakvdtPWOq0lIPKKloiYIS27/PyxB/alVUb16b6T9Vm0c71a6R5g713joQ2UAqgo8aiFFldDAsAG64Q/lNgC4vwUUaYTRGNfO98vVSSjQ6iFaIPoX3Kc2kApIUBJ0+iYVY8PJj61UngwZH05LeqN6WWCdnVUGLGw0YzZQ8S55lowhYi8VFSaTzaewyRj8nsCsuK/VPe6Pf09wQ2QHPRgC6/UwVjhnxMiPE36F4UMqOgz1heWmwEgRNzQVv5WY+AuBf6OthHobwpQVIFg6FVmCXcVXQ3uEfyP+821FOukhNDkuWy6TfILr6RdFP5Ss8rlakt75lu5XJesPqUQqLUYauv8HQi2xEvKVypMzyj44op8jspQN06AEMGpBaS1+AJ1RFTLWjekS5mydykGLYGEnz/Lhmzh5EUuxDGS/ldMc2I2pBhzQqMFg3gm93XmeT+zrQkgxKyQXZkfjq6fWr6hFZ/+KVNce10Vh6uWu/ldVG2SaFtRV8cEcjdmVIPhzY8i/xkdgGFyZsoOpsvr5oIigDV37kLG2W0UU8Bi9sG83nS4B11KrDtGHD8EfU07A38pAK8pEoJS46ZFCcweKRIqOYC16wHKY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LRmpf/K8Tw+3+kKaImiKvv+SRRBYCIOmsNt6uQ6jA2kzM2mMFvr0tlvMSmAn?=
 =?us-ascii?Q?JcwqxsOdxC7QuA6Q0n4cPTYuURWeRFVDQLP9wQ8dxD310qd2TrlKC1p57rA6?=
 =?us-ascii?Q?CZkpGWUppujV1KZBwpvPXi8Ht+kBuUsFWrIsSb8Kw4bpONg5cHqxV23qQOCX?=
 =?us-ascii?Q?4HmoZQX7lxCcyYjhfzPgMsTNMHzzHr4nOQ6QfP1shluhdH1qzVcF/rFrzfb/?=
 =?us-ascii?Q?nSl94HQVw0qJLLfhqLrkPRuysZh84wG/4Ex8P0C4crjfcAMi2m64jOnTkIVY?=
 =?us-ascii?Q?jlZqSrLk0HWLRs3D+6h+/r3Aei5ZsWe5VcMtgro56phZ1GRD4/mVwpt+3UL2?=
 =?us-ascii?Q?O66g8YxuhOpjpg2gkVVzcEEpNtbwZtGKSHC82T2Alhzq3e0dZTXm0Cqkw7x8?=
 =?us-ascii?Q?MztR5fb4WF4lao+Y6hRDQM+Xtshlr+j/piDsIltOr/bHZQMFDMJQNVAkz/49?=
 =?us-ascii?Q?x1+87OuzNj79m9puYIBq+TYPvcPWAY0RuZe7AkQR07OgmK/w6mSHdCYUzmFj?=
 =?us-ascii?Q?Rr1BeiIMnOyOPgC0/P1XAJK/xSQd4Bow1tlus3WPg8tdxZuO50ln77oQwrn2?=
 =?us-ascii?Q?ogg6yHGcU2246wFUQ9ngynplqSZvugtSzRaS2I2vf4G+/eUQ3sd/pXiogUW2?=
 =?us-ascii?Q?rbSeN9vT4j8u2h4tAyNPmleH0UBWqMMHQrn1NEtvSIHwUz3deMnIPvk2hQxt?=
 =?us-ascii?Q?0cXLG4f21soePt8NGrgmSuR75RNnNeUVQU7WOSe35RFZUpv82s4yczERKVwO?=
 =?us-ascii?Q?oSybWXlUeFW5rs0J5XJSmiBNkjVt+R7S30BKj7IJ5nIED95nsJEzeZdZWA4R?=
 =?us-ascii?Q?WekXBqf5ZzgmbGdTAH5yegZYaTDXJbV4shj+3ALvaeRQ/QvmDuMgZhdENZ4u?=
 =?us-ascii?Q?IZt6ZhzooDyrH67Ts2okBRwW63er+xC3annmpC9GOd0XCUYeuJycD4xswQIG?=
 =?us-ascii?Q?TdyJu9iRsegYherTLWNj6utZOXya/hND6nwDBDwCLauxiBKyc+sdIlCdAJkh?=
 =?us-ascii?Q?XBo8UsH+VQYyrfoLwNLbr4jySdmmxjlHhlcIMB2k+iV1peXII2TC89CUYBSa?=
 =?us-ascii?Q?8SVn5nelI2yQuDhEaxZ1nZzgsz989N5aCEvoLpAYzzhjT09mEBydF9b1E92l?=
 =?us-ascii?Q?yJ36FsdBTeKXZ0EHT74JHqacxP1XtMdqTMcA8UYwKLk+tH9h0U/HWNZCN29G?=
 =?us-ascii?Q?77SwxN+3ogrcGUPVxKxsf4G+zberEUb78hza19id5S9Ius/UZI3vDAd0Qj8d?=
 =?us-ascii?Q?oE3xLUq78FiMU/dv94z2UYPZAo5twXoxFk5qk85mzLjdUZ6aIxAGqsobbG5m?=
 =?us-ascii?Q?LV2D1I2CAFDsJS1YwTSio0DFnW4IVPa0fHg90+7G0bi+XMK41gm+MSGk1/gc?=
 =?us-ascii?Q?MrjvUNSRCMRZlnXZS04Qazs9/LhiIPbtI0lKV4c/JnJ3s+V+UcCjc2LcZ0Sx?=
 =?us-ascii?Q?QzRRhJRkzywzO6LYVPZ+PWGkDcQIMCXsecWmqupnXDBvkg6fdih8RsIvsSoy?=
 =?us-ascii?Q?xBsWQD2HNf//dM2QY4JfoXsiTu7SFw0vfoGIkkDA/s2fE3IIQERuuCRoWtl5?=
 =?us-ascii?Q?amW4/DBcnqcB0GL/QOYoJxb0blIFkbF4JMqtfMpNtHvBW/sY99H/FljnPKQy?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae75f91-ea30-4113-d883-08dc5ed37002
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 11:42:19.1424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzRvtO2qnhWl9JIrJkiP8oqV6g00kFcZupFkV8ZU8CLvegfbNmIxUJLG96pCVbaYo07QHltI6fZUkNHiKSNbZf7Cfgtj8EoHDER6x/BZqwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8175
X-OriginatorOrg: intel.com

On Tue, Apr 16, 2024 at 02:58:54PM +0200, Larysa Zaremba wrote:
> A bug occurs because a safety check guarding AF_XDP-related queues in
> ethnl_set_channels(), does not trigger. This happens, because kernel and
> ice driver interpret the ethtool command differently.
> 
> How the bug occurs:
> 1. ethtool -l <IFNAME> -> combined: 40
> 2. Attach AF_XDP to queue 30
> 3. ethtool -L <IFNAME> rx 15 tx 15
>    combined number is not specified, so command becomes {rx_count = 15,
>    tx_count = 15, combined_count = 40}.
> 4. ethnl_set_channels checks, if there are any AF_XDP of queues from the
>    new (combined_count + rx_count) to the old one, so from 55 to 40, check
>    does not trigger.
> 5. ice interprets `rx 15 tx 15` as 15 combined channels and deletes the
>    queue that AF_XDP is attached to.
> 
> Interpret the command in a way that is more consistent with ethtool
> manual [0] (--show-channels and --set-channels).
> 
> Considering that in the ice driver only the difference between RX and TX
> queues forms dedicated channels, change the correct way to set number of
> channels to:
> 
> ethtool -L <IFNAME> combined 10 /* For symmetric queues */
> ethtool -L <IFNAME> combined 8 tx 2 rx 0 /* For asymmetric queues */

Makes sense for usage above:
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Nonetheless I still think core should not allow user to shoot himself to
foot, but let's keep it as a separate thing.

Thanks!

> 
> [0] https://man7.org/linux/man-pages/man8/ethtool.8.html
> 
> Fixes: 87324e747fde ("ice: Implement ethtool ops for channels")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 22 ++++++--------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 78b833b3e1d7..d91f41f61bce 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -3593,7 +3593,6 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
>  	struct ice_pf *pf = vsi->back;
>  	int new_rx = 0, new_tx = 0;
>  	bool locked = false;
> -	u32 curr_combined;
>  	int ret = 0;
>  
>  	/* do not support changing channels in Safe Mode */
> @@ -3615,22 +3614,13 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
>  		return -EOPNOTSUPP;
>  	}
>  
> -	curr_combined = ice_get_combined_cnt(vsi);
> +	if (!ch->combined_count) {
> +		netdev_err(dev, "Please specify at least 1 combined channel\n");
> +		return -EINVAL;
> +	}
>  
> -	/* these checks are for cases where user didn't specify a particular
> -	 * value on cmd line but we get non-zero value anyway via
> -	 * get_channels(); look at ethtool.c in ethtool repository (the user
> -	 * space part), particularly, do_schannels() routine
> -	 */
> -	if (ch->rx_count == vsi->num_rxq - curr_combined)
> -		ch->rx_count = 0;
> -	if (ch->tx_count == vsi->num_txq - curr_combined)
> -		ch->tx_count = 0;
> -	if (ch->combined_count == curr_combined)
> -		ch->combined_count = 0;
> -
> -	if (!(ch->combined_count || (ch->rx_count && ch->tx_count))) {
> -		netdev_err(dev, "Please specify at least 1 Rx and 1 Tx channel\n");
> +	if (ch->rx_count && ch->tx_count) {
> +		netdev_err(dev, "Dedicated RX or TX channels cannot be used simultaneously\n");
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.43.0
> 

