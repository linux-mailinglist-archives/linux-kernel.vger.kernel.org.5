Return-Path: <linux-kernel+bounces-120697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 962EC88DB92
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAEBFB220CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5A3524C1;
	Wed, 27 Mar 2024 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ATd3b627"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53695524A0;
	Wed, 27 Mar 2024 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711536714; cv=fail; b=E5JK42a0wwgI/FYirKNNO3AbHDw9aO1/+0hLqQ6qMY4X/guG+cpSK2IsGexSdB0CfXZf+igIaYBOYudhx4FHwW/xRZwGaoHhaVhgZ5e6xpTdU5SYU05UyuCMgQpNnHr/K2SB4AZC6BNVTzn1wk5BxPebrBvYhjf4N8sbawCJCeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711536714; c=relaxed/simple;
	bh=JF7NJ7IedCZTa9KbDis5ka6bZln0zmYZgKooop/Rr24=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PlqVUk0+NYFf+nPX2UY9PBRQGHo9dV0wradgbN1pUmSum2jDkoOdzxGjf+RlaROTQnKer2qTJl4GhvWBMr2zUdvVaudtx5jaQrLaWSI/6dD1xD2jlc3RfVpyU0/vWIfTEqzR4Zyk1SEIJdpbRtsGjgs4l8Jams1rgYsH670lxtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ATd3b627; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711536711; x=1743072711;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JF7NJ7IedCZTa9KbDis5ka6bZln0zmYZgKooop/Rr24=;
  b=ATd3b627VEoDzG5rMjiHghsYbqvXsGeD1Zss5CsQI7txkvuaLTbQdfC/
   HonGDAyv+r9+ccy5ij91uEh+A5U3HAwkAEZzDkpPPs57+eeaCJUWEm549
   qIkST9NNll7tSZlbKUKT3I5Jn5eCMdTbTjwRBzIpTpvcqnPm5O1j3ASRq
   6nbkSVDL7bimJEqAQwrGvHBWV8OhK0zqZn1MxHidhWYTj1xdLMRbluFWs
   AHeb8cXGVj2tLj63elRviwI9NPiQTwJY4tJTn/FNi1/lU0XjlDgmcDnMN
   5L1n7mOeKnw1iZ05o3roOFCCydMhIZogtbm1+TeZrqri+9ORJsCRbjmm1
   A==;
X-CSE-ConnectionGUID: 6Hr/rSHnRIyi9QR/BuIiWg==
X-CSE-MsgGUID: M0BkG5wvTtGNbxId1wlB5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6760474"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="6760474"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 03:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="16291021"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2024 03:51:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 03:51:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 03:51:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 03:51:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 03:51:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKD5A7cBcyKjeRXiB7SvCW4vcuIVQ8Dlo2NyaC8mCRr8cvLeBATz6iCSDNlgvy4SD78FJlS6Fex4TfPFny7JHA4wvT7VqF2Sx4uS8CFbO25cLyK3BQlj3DtmPOo91b0UEDWwh2UEcGBoZFcJd+YOEgCvTnJihsEGYmV1lZ9MBfZbK7NCbb6yIleRVD4U7niAXlOcwYacf6rIWv06YCNalDDyCbbR2ZmvaYUUA7OwsaVbNDGsS+D+n3eJtErMK17wWT2QA3LMR+4Nh8E3aDEwwI5e5VaRi8v09nOtbZvlaoB05GBWlIktqy6dPZsHmWtBI/OUx3iEaM+4cpzRFpuYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mENwEPRWZmitugpqovM2DhrxhWOFfZTUJk6B+hdW1dA=;
 b=XGrwGFkf/Fujj+U9Gwd5VGxjLWEsvnikj99sXfFOlRJxHmYRBVPj6dnfCmTEQ2tZj2Ix6J0xMkHQYHg1XlRwZ0kfiwmsarq0ecaorOa3WLQZyoiKg/fIKVMTbaAhuLkTYkrEjgS/GDhVuR8l4IK3kBteoDcjla88rgAiTsMjcL0Y/fhssC9m9Cyjz0Iqsi9gZuEJ/XX0c5vMTWCJMsZ3AW+r0VC4dqz/aa7oDN085Rar66BAdxUXLo1OERezrZhNmx+T2obXpTlFK+sYNUZFRvnWoWIKrnFbNhZ/AAwa0w5DVTdDq0a5lHVgysaYHGrd/ujO3l3pV+B8tFcQGB5fqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by MN0PR11MB6060.namprd11.prod.outlook.com (2603:10b6:208:378::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 10:51:45 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::aaf8:95c2:2724:9688]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::aaf8:95c2:2724:9688%6]) with mapi id 15.20.7409.028; Wed, 27 Mar 2024
 10:51:44 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: ivecera <ivecera@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, open list <linux-kernel@vger.kernel.org>, "Eric
 Dumazet" <edumazet@google.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 4/7] i40e: Add helper to access
 main VSI
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 4/7] i40e: Add helper to
 access main VSI
Thread-Index: AQHaeUEPPd5hlSf3S0WHrGBCPhi4trFKbXug
Date: Wed, 27 Mar 2024 10:51:44 +0000
Message-ID: <SJ0PR11MB58667EE4D51EA98F16771B29E5342@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20240318143058.287014-1-ivecera@redhat.com>
 <20240318143058.287014-5-ivecera@redhat.com>
In-Reply-To: <20240318143058.287014-5-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|MN0PR11MB6060:EE_
x-ms-office365-filtering-correlation-id: 1587826a-e2de-4673-1926-08dc4e4be4e5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vi1Bjk19Gv3cqU5zBD8LW6agLi3shjeOkATsjTlKb7OH3ESL/8B6NJJmVQa/FhPrXIdzVyCdQdTWzB7E/2W0mRiQ1+imSpvL33a8Hf1/RPTK8tyfFJANz3CEa46d7mFplmj0SGBgwVqoDqgueafES7ZkLCNHgsG4CsaDa7zClsYLtpTsjKHJS7Mt31xN5stZZyGww4K+ht06aieT/i0XjjUppcI7UPuXttO7VS30fdJKeQ0V3fgC+gi4aaOEFNYr+Q8LhCF72QGWNX0x53mvSEN32yXGajAWZVadnecv7CuQAWBrFmJ851ZnnBBvlpfE8Bhmfl5HMJKFX88ifY+pj+4L/X5uvUuoWgxnMs+y8KH9NXm1CLWna5tGNl0sJUT7g8o9O7bVr53YU2fm8VQe1c8Ca15q9RRuEgLRy9kZeA6BVDOPm603yFBdmZEwwVOyIkr3Zb8blK5zvyHRZZ7GmRBJmZA09O/B7RPYSB9hotXT47Y4swr2ptLlhHIUR8HjvWoZNaNq0VjOR42H+Ia023GtwHMUkp/IQG9n/KC/5xmjw60sbUR2daULOoTCxWilikZRutugjipp8ax+/CgNeLmVr31EYZHhQTwgVC8pnn2dxtzLuYKAHi2gB891IGkd2P5z5SIcDX3x6bzEnfPdQNBs/JtaTRXF0c/ovnBnqCb7WtL5cD2BBvEa3sPSizjvjq5hYBP+vsD36cuCa8bXkTRxDJMio+9bDgZCVsub5Wk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2/rYI+vai6UteegBsoTtXkh/MqnxcDIcfeelUntogTj9fetLqb+ZLpnYXzK4?=
 =?us-ascii?Q?l/2vBWqMEAuP/b2Li5XPYjxxgwQ6QY3ekzrTbymPLpNh9MC2qf+oXlRuPOFk?=
 =?us-ascii?Q?Dy6R0tImIGEFW38UHG4cVhjfKMffAVRzI//t9mjQNWq7KNJposzYUVKSbwjH?=
 =?us-ascii?Q?jEXjD6xoNOBhXHUv6DNCeQQt2BEl0j+ypEt96Jm90wiwTQum0vUTKlqiAmF+?=
 =?us-ascii?Q?wJV/FTsa3m2q0GhwovRyfHwjtZk0shOS6yh6kmoadxk3sny97Z9JRiKTekfH?=
 =?us-ascii?Q?CE6ww3IvwhMtHHSbIgFOKqJW1kKmY88y/T+Oi4GsCKF0ov6dj8IUXHrTwRkS?=
 =?us-ascii?Q?gpZ4VJWgMMu/Q8NNHEWfqPnv1ch66BP4uqtiBSyUN/6tdyXGNcTdxfyE0WQ/?=
 =?us-ascii?Q?3B4lc8EPhym+VeWN4LNnCP8cqraeJEOIdKw72FQwASbUmPiqixhwiMdUfHLt?=
 =?us-ascii?Q?DH/iGWuh7J7l9c0CMqaiLjYR5Oj/916Fjyx7OWgMgHZ6G07Fqfx+6uBhylQI?=
 =?us-ascii?Q?kCbDQwFaU9RUbkDbmkHvO0pmSYLUInJvLG35Ky/uINMIXHXvLDYmrLOsYZVM?=
 =?us-ascii?Q?cmQ8KN0/v/RBq42s5cIwtzCIHpwywe7TM65uQUcAXg5RxvThfntCGq/pzIrN?=
 =?us-ascii?Q?DKWjXhMCvHyL/OPMwguoOYbHp+WeCoP+6WSuoCT9GM93TfwAEnW1zKJLrlGL?=
 =?us-ascii?Q?kt6ZqK5f5P6/ilet67S+buJGAUzT5kzowrwr2Hz7GVSQG6bQ6lMD/ImoUmbN?=
 =?us-ascii?Q?qDmm8WBAzndPjrPpWF0GvLo09fT3wPnGrceexSqDI0/yEYVzSqYbKWBglE2Y?=
 =?us-ascii?Q?rNpvbXFmeuIV2bQjDnHlRWyNzUXK8f4xZspSuSGd23wRSLhSaftFDOwjmDIA?=
 =?us-ascii?Q?HbBYSTulbB7O9mEECcCjfgKQ5wcYLfuH54nRAzV+Iz/hncbj5WMZUUhQlUp1?=
 =?us-ascii?Q?WYkUpnkHw4866ZRLxWgHQZmDr2uBGDmBx9Fe9PzBffqcxMVqXtWbRxMp0pps?=
 =?us-ascii?Q?y2MBDPpGa/9mg2a8/BLhwLniFwWJW0P5Y07Bg6lHv2rAx9IpICKZI2eCd+AU?=
 =?us-ascii?Q?5qCDuwuCsqucB1/1iA/RvuttMBb8QEQ4Gqy6q6r2UwzH/tJa6pJG39xmMPXm?=
 =?us-ascii?Q?n/Y1WiU47XkSbjLj8lZypadtbHwvS+X68XLzn49hmCt2R3BEQ3fEmIfxoqz0?=
 =?us-ascii?Q?vUrxhU5Bo67SwhkguFIXZb4UzgzYpcH0GggfRpZYonEhCmzhmv/yjEECpvGY?=
 =?us-ascii?Q?zcnilguo7sWmfKbcL9HEDW4vla0v3f9gfbgigNLSVX9rr5bH5iBYoElr53fE?=
 =?us-ascii?Q?mvcNRkXSG9JDOS2+dmBG/GkBXPROpYxtnrIfg7MhrFhVkyt5rLx7+Z4+Cau5?=
 =?us-ascii?Q?V6pOjPmxMxGIifz5o2pb7nVHC/yQSppC//KwWN/8yMcO4cEUf37JE1EhXdDy?=
 =?us-ascii?Q?upPEF7tWaHyykg25lSTL7o+Iex+0CZ/hS59kpIJozg0gc4LVIQ2DrnDpI0Yv?=
 =?us-ascii?Q?CZiF5ZsTre2EE9H9uJcs1TESXEkU6ZW8A52S9GlCZyUQ00ZwZhsp9Cd3N+oY?=
 =?us-ascii?Q?ca9VmubO2iLAfXRDRv70akR13i0vjTgPy/wHsouEI+ptONYwKcIQz26Bn2R2?=
 =?us-ascii?Q?tQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1587826a-e2de-4673-1926-08dc4e4be4e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 10:51:44.8893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X3ueyy75IqRq4Y2a4Db16I3oneh4paoJ8URWLaugeEn8xwzVl7x609/KQDWTY9Jh/swADLFTwNNN2dgx4I3z3yqWnYSVh2qXdIB2kFeB2RE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6060
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On
> Behalf Of Ivan Vecera
> Sent: Monday, March 18, 2024 3:31 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: open list:NETWORKING DRIVERS <netdev@vger.kernel.org>; Richard
> Cochran <richardcochran@gmail.com>; open list <linux-
> kernel@vger.kernel.org>; Eric Dumazet <edumazet@google.com>;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Jakub Kicinski
> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S. Miller
> <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-next 4/7] i40e: Add helper to
> access main VSI
>=20
> Add simple helper i40e_pf_get_main_vsi(pf) to access main VSI that
> replaces pattern 'pf->vsi[pf->lan_vsi]'
>=20
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |  11 ++
>  drivers/net/ethernet/intel/i40e/i40e_client.c |  10 +-
>  drivers/net/ethernet/intel/i40e/i40e_ddp.c    |   3 +-
>  .../net/ethernet/intel/i40e/i40e_debugfs.c    |  32 +++---
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |   8 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 107 ++++++++++----
> ----
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c    |   6 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   8 +-
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  14 ++-
>  9 files changed, 116 insertions(+), 83 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
> b/drivers/net/ethernet/intel/i40e/i40e.h
> index 0792c7324527..fb0b913692e1 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -1372,6 +1372,17 @@ i40e_pf_get_vsi_by_seid(struct i40e_pf *pf,
> u16 seid)
>  	return NULL;
>  }
>=20
> +/**
> + * i40e_pf_get_main_vsi - get pointer to main VSI
> + * @pf: pointer to a PF
> + *
> + * Return pointer to main VSI or NULL if it does not exist  **/
> static
> +inline struct i40e_vsi *i40e_pf_get_main_vsi(struct i40e_pf *pf) {
> +	return (pf->lan_vsi !=3D I40E_NO_VSI) ? pf->vsi[pf->lan_vsi] :
> NULL; }
> +
>  /**
>   * i40e_pf_get_veb_by_seid - find VEB by SEID
>   * @pf: pointer to a PF
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c
> b/drivers/net/ethernet/intel/i40e/i40e_client.c
> index 93e52138826e..59263551c383 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_client.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
> @@ -107,8 +107,8 @@ i40e_notify_client_of_vf_msg(struct i40e_vsi
> *vsi, u32 vf_id, u8 *msg, u16 len)
>   **/
>  void i40e_notify_client_of_l2_param_changes(struct i40e_pf *pf)  {
> +	struct i40e_vsi *vsi =3D i40e_pf_get_main_vsi(pf);
>  	struct i40e_client_instance *cdev =3D pf->cinst;
> -	struct i40e_vsi *vsi =3D pf->vsi[pf->lan_vsi];
>  	struct i40e_params params;
>=20
>  	if (!cdev || !cdev->client)
> @@ -333,9 +333,9 @@ static int i40e_register_auxiliary_dev(struct
> i40e_info *ldev, const char *name)
>   **/
>  static void i40e_client_add_instance(struct i40e_pf *pf)  {
> +	struct i40e_vsi *vsi =3D i40e_pf_get_main_vsi(pf);
>  	struct i40e_client_instance *cdev =3D NULL;
>  	struct netdev_hw_addr *mac =3D NULL;
> -	struct i40e_vsi *vsi =3D pf->vsi[pf->lan_vsi];
>=20
>  	cdev =3D kzalloc(sizeof(*cdev), GFP_KERNEL);
>  	if (!cdev)
> @@ -399,9 +399,9 @@ void i40e_client_del_instance(struct i40e_pf
> *pf)
>   **/
>  void i40e_client_subtask(struct i40e_pf *pf)  {
> -	struct i40e_client *client;
> +	struct i40e_vsi *vsi =3D i40e_pf_get_main_vsi(pf);
>  	struct i40e_client_instance *cdev;
> -	struct i40e_vsi *vsi =3D pf->vsi[pf->lan_vsi];
> +	struct i40e_client *client;
>  	int ret =3D 0;
>=20
>  	if (!test_and_clear_bit(__I40E_CLIENT_SERVICE_REQUESTED, pf-
> >state)) @@ -665,8 +665,8 @@ static int
> i40e_client_update_vsi_ctxt(struct i40e_info *ldev,
>  				       bool is_vf, u32 vf_id,
>  				       u32 flag, u32 valid_flag)
>  {
> +	struct i40e_vsi *vsi =3D i40e_pf_get_main_vsi(ldev->pf);
>  	struct i40e_pf *pf =3D ldev->pf;
> -	struct i40e_vsi *vsi =3D pf->vsi[pf->lan_vsi];
>  	struct i40e_vsi_context ctxt;
>  	bool update =3D true;
>  	int err;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> index 2f53f0f53bc3..daa9f2c42f70 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> @@ -407,8 +407,9 @@ static int i40e_ddp_load(struct net_device
> *netdev, const u8 *data, size_t size,
>   **/
>  static int i40e_ddp_restore(struct i40e_pf *pf)  {
> +	struct i40e_vsi *vsi =3D i40e_pf_get_main_vsi(pf);
> +	struct net_device *netdev =3D vsi->netdev;
>  	struct i40e_ddp_old_profile_list *entry;
> -	struct net_device *netdev =3D pf->vsi[pf->lan_vsi]->netdev;
>  	int status =3D 0;
>=20
>  	if (!list_empty(&pf->ddp_old_prof)) {
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> index 6147c5f128e8..09db46de2994 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> @@ -53,6 +53,7 @@ static ssize_t i40e_dbg_command_read(struct file
> *filp, char __user *buffer,
>  				     size_t count, loff_t *ppos)
>  {
>  	struct i40e_pf *pf =3D filp->private_data;
> +	struct i40e_vsi *main_vsi;
>  	int bytes_not_copied;
>  	int buf_size =3D 256;
>  	char *buf;
> @@ -68,8 +69,8 @@ static ssize_t i40e_dbg_command_read(struct file
> *filp, char __user *buffer,
>  	if (!buf)
>  		return -ENOSPC;
>=20
> -	len =3D snprintf(buf, buf_size, "%s: %s\n",
> -		       pf->vsi[pf->lan_vsi]->netdev->name,
> +	main_vsi =3D i40e_pf_get_main_vsi(pf);
> +	len =3D snprintf(buf, buf_size, "%s: %s\n", main_vsi->netdev-
> >name,
>  		       i40e_dbg_command_buf);
>=20
>  	bytes_not_copied =3D copy_to_user(buffer, buf, len); @@ -786,7
> +787,8 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
>  		cnt =3D sscanf(&cmd_buf[7], "%i", &vsi_seid);
>  		if (cnt =3D=3D 0) {
>  			/* default to PF VSI */
> -			vsi_seid =3D pf->vsi[pf->lan_vsi]->seid;
> +			vsi =3D i40e_pf_get_main_vsi(pf);
> +			vsi_seid =3D vsi->seid;
>  		} else if (vsi_seid < 0) {
>  			dev_info(&pf->pdev->dev, "add VSI %d: bad vsi
> seid\n",
>  				 vsi_seid);
> @@ -1030,7 +1032,7 @@ static ssize_t i40e_dbg_command_write(struct
> file *filp,
>  				goto command_write_done;
>  			}
>=20
> -			vsi =3D pf->vsi[pf->lan_vsi];
> +			vsi =3D i40e_pf_get_main_vsi(pf);
>  			switch_id =3D
>  				le16_to_cpu(vsi->info.switch_id) &
>  					    I40E_AQ_VSI_SW_ID_MASK;
> @@ -1380,6 +1382,9 @@ static ssize_t i40e_dbg_command_write(struct
> file *filp,
>  		dev_info(&pf->pdev->dev, "FD current total filter count
> for this interface: %d\n",
>  			 i40e_get_current_fd_count(pf));
>  	} else if (strncmp(cmd_buf, "lldp", 4) =3D=3D 0) {
> +		/* Get main VSI */
> +		struct i40e_vsi *main_vsi =3D i40e_pf_get_main_vsi(pf);
> +
>  		if (strncmp(&cmd_buf[5], "stop", 4) =3D=3D 0) {
>  			int ret;
>=20
> @@ -1391,10 +1396,9 @@ static ssize_t i40e_dbg_command_write(struct
> file *filp,
>  				goto command_write_done;
>  			}
>  			ret =3D i40e_aq_add_rem_control_packet_filter(&pf-
> >hw,
> -						pf->hw.mac.addr,
> -						ETH_P_LLDP, 0,
> -						pf->vsi[pf->lan_vsi]->seid,
> -						0, true, NULL, NULL);
> +						pf->hw.mac.addr, ETH_P_LLDP, 0,
> +						main_vsi->seid, 0, true, NULL,
> +						NULL);
>  			if (ret) {
>  				dev_info(&pf->pdev->dev,
>  					"%s: Add Control Packet Filter AQ
> command failed =3D0x%x\n", @@ -1409,10 +1413,9 @@ static ssize_t
> i40e_dbg_command_write(struct file *filp,
>  			int ret;
>=20
>  			ret =3D i40e_aq_add_rem_control_packet_filter(&pf-
> >hw,
> -						pf->hw.mac.addr,
> -						ETH_P_LLDP, 0,
> -						pf->vsi[pf->lan_vsi]->seid,
> -						0, false, NULL, NULL);
> +						pf->hw.mac.addr, ETH_P_LLDP, 0,
> +						main_vsi->seid, 0, false, NULL,
> +						NULL);
>  			if (ret) {
>  				dev_info(&pf->pdev->dev,
>  					"%s: Remove Control Packet Filter AQ
> command failed =3D0x%x\n", @@ -1639,6 +1642,7 @@ static ssize_t
> i40e_dbg_netdev_ops_read(struct file *filp, char __user *buffer,
>  					size_t count, loff_t *ppos)
>  {
>  	struct i40e_pf *pf =3D filp->private_data;
> +	struct i40e_vsi *main_vsi;
>  	int bytes_not_copied;
>  	int buf_size =3D 256;
>  	char *buf;
> @@ -1654,8 +1658,8 @@ static ssize_t
> i40e_dbg_netdev_ops_read(struct file *filp, char __user *buffer,
>  	if (!buf)
>  		return -ENOSPC;
>=20
> -	len =3D snprintf(buf, buf_size, "%s: %s\n",
> -		       pf->vsi[pf->lan_vsi]->netdev->name,
> +	main_vsi =3D i40e_pf_get_main_vsi(pf);
> +	len =3D snprintf(buf, buf_size, "%s: %s\n", main_vsi->netdev-
> >name,
>  		       i40e_dbg_netdev_ops_buf);
>=20
>  	bytes_not_copied =3D copy_to_user(buffer, buf, len); diff --git
> a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index 42e7e6cdaa6d..0905c1fb2337 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -2029,7 +2029,7 @@ static void i40e_get_ringparam(struct
> net_device *netdev,  {
>  	struct i40e_netdev_priv *np =3D netdev_priv(netdev);
>  	struct i40e_pf *pf =3D np->vsi->back;
> -	struct i40e_vsi *vsi =3D pf->vsi[pf->lan_vsi];
> +	struct i40e_vsi *vsi =3D i40e_pf_get_main_vsi(pf);
>=20
>  	ring->rx_max_pending =3D i40e_get_max_num_descriptors(pf);
>  	ring->tx_max_pending =3D i40e_get_max_num_descriptors(pf); @@ -
> 3370,6 +3370,7 @@ static int i40e_get_ethtool_fdir_entry(struct
> i40e_pf *pf,
>  	struct i40e_rx_flow_userdef userdef =3D {0};
>  	struct i40e_fdir_filter *rule =3D NULL;
>  	struct hlist_node *node2;
> +	struct i40e_vsi *vsi;
>  	u64 input_set;
>  	u16 index;
>=20
> @@ -3493,9 +3494,8 @@ static int i40e_get_ethtool_fdir_entry(struct
> i40e_pf *pf,
>  		fsp->flow_type |=3D FLOW_EXT;
>  	}
>=20
> -	if (rule->dest_vsi !=3D pf->vsi[pf->lan_vsi]->id) {
> -		struct i40e_vsi *vsi;
> -
> +	vsi =3D i40e_pf_get_main_vsi(pf);
> +	if (rule->dest_vsi !=3D vsi->id) {
>  		vsi =3D i40e_find_vsi_from_id(pf, rule->dest_vsi);
>  		if (vsi && vsi->type =3D=3D I40E_VSI_SRIOV) {
>  			/* VFs are zero-indexed by the driver, but
> ethtool diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 1ba28893f49e..86bc3fc0579b 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -2475,7 +2475,7 @@ i40e_aqc_broadcast_filter(struct i40e_vsi
> *vsi, const char *vsi_name,
>   **/
>  static int i40e_set_promiscuous(struct i40e_pf *pf, bool promisc)
> {
> -	struct i40e_vsi *vsi =3D pf->vsi[pf->lan_vsi];
> +	struct i40e_vsi *vsi =3D i40e_pf_get_main_vsi(pf);
>  	struct i40e_hw *hw =3D &pf->hw;
>  	int aq_ret;
>=20
> @@ -4330,7 +4330,7 @@ static irqreturn_t i40e_intr(int irq, void
> *data)
>=20
>  	/* only q0 is used in MSI/Legacy mode, and none are used in
> MSIX */
>  	if (icr0 & I40E_PFINT_ICR0_QUEUE_0_MASK) {
> -		struct i40e_vsi *vsi =3D pf->vsi[pf->lan_vsi];
> +		struct i40e_vsi *vsi =3D i40e_pf_get_main_vsi(pf);
>  		struct i40e_q_vector *q_vector =3D vsi->q_vectors[0];
>=20
>  		/* We do not have a way to disarm Queue causes while
> leaving @@ -5480,7 +5480,7 @@ static u8
> i40e_dcb_get_enabled_tc(struct i40e_dcbx_config *dcbcfg)
>   **/
>  static u8 i40e_mqprio_get_enabled_tc(struct i40e_pf *pf)  {
> -	struct i40e_vsi *vsi =3D pf->vsi[pf->lan_vsi];
> +	struct i40e_vsi *vsi =3D i40e_pf_get_main_vsi(pf);
>  	u8 num_tc =3D vsi->mqprio_qopt.qopt.num_tc;
>  	u8 enabled_tc =3D 1, i;
>=20
> @@ -5497,13 +5497,14 @@ static u8 i40e_mqprio_get_enabled_tc(struct
> i40e_pf *pf)
>   **/
>  static u8 i40e_pf_get_num_tc(struct i40e_pf *pf)  {
> -	struct i40e_hw *hw =3D &pf->hw;
>  	u8 i, enabled_tc =3D 1;
>  	u8 num_tc =3D 0;
> -	struct i40e_dcbx_config *dcbcfg =3D &hw->local_dcbx_config;
>=20
> -	if (i40e_is_tc_mqprio_enabled(pf))
> -		return pf->vsi[pf->lan_vsi]->mqprio_qopt.qopt.num_tc;
> +	if (i40e_is_tc_mqprio_enabled(pf)) {
> +		struct i40e_vsi *vsi =3D i40e_pf_get_main_vsi(pf);
> +
> +		return vsi->mqprio_qopt.qopt.num_tc;
> +	}
>=20
>  	/* If neither MQPRIO nor DCB is enabled, then always use
> single TC */
>  	if (!test_bit(I40E_FLAG_DCB_ENA, pf->flags)) @@ -5511,7
> +5512,7 @@ static u8 i40e_pf_get_num_tc(struct i40e_pf *pf)
>=20
>  	/* SFP mode will be enabled for all TCs on port */
>  	if (!test_bit(I40E_FLAG_MFP_ENA, pf->flags))
> -		return i40e_dcb_get_num_tc(dcbcfg);
> +		return i40e_dcb_get_num_tc(&pf->hw.local_dcbx_config);
>=20
>  	/* MFP mode return count of enabled TCs for this PF */
>  	if (pf->hw.func_caps.iscsi)
> @@ -6485,6 +6486,7 @@ static inline int
> i40e_setup_hw_channel(struct i40e_pf *pf,  static bool
> i40e_setup_channel(struct i40e_pf *pf, struct i40e_vsi *vsi,
>  			       struct i40e_channel *ch)
>  {
> +	struct i40e_vsi *main_vsi;
>  	u8 vsi_type;
>  	u16 seid;
>  	int ret;
> @@ -6498,7 +6500,8 @@ static bool i40e_setup_channel(struct i40e_pf
> *pf, struct i40e_vsi *vsi,
>  	}
>=20
>  	/* underlying switching element */
> -	seid =3D pf->vsi[pf->lan_vsi]->uplink_seid;
> +	main_vsi =3D i40e_pf_get_main_vsi(pf);
> +	seid =3D main_vsi->uplink_seid;
>=20
>  	/* create channel (VSI), configure TX rings */
>  	ret =3D i40e_setup_hw_channel(pf, vsi, ch, seid, vsi_type); @@
> -7055,7 +7058,9 @@ int i40e_hw_dcb_config(struct i40e_pf *pf,
> struct i40e_dcbx_config *new_cfg)
>=20
>  	/* Configure Rx Packet Buffers in HW */
>  	for (i =3D 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
> -		mfs_tc[i] =3D pf->vsi[pf->lan_vsi]->netdev->mtu;
> +		struct i40e_vsi *main_vsi =3D i40e_pf_get_main_vsi(pf);
> +
> +		mfs_tc[i] =3D main_vsi->netdev->mtu;
>  		mfs_tc[i] +=3D I40E_PACKET_HDR_PAD;
>  	}
>=20
> @@ -9812,7 +9817,7 @@ static void i40e_fdir_flush_and_replay(struct
> i40e_pf *pf)
>  		dev_warn(&pf->pdev->dev, "FD table did not flush, needs
> more time\n");
>  	} else {
>  		/* replay sideband filters */
> -		i40e_fdir_filter_restore(pf->vsi[pf->lan_vsi]);
> +		i40e_fdir_filter_restore(i40e_pf_get_main_vsi(pf));
>  		if (!disable_atr && !pf->fd_tcp4_filter_cnt)
>  			clear_bit(__I40E_FD_ATR_AUTO_DISABLED, pf-
> >state);
>  		clear_bit(__I40E_FD_FLUSH_REQUESTED, pf->state); @@ -
> 9910,7 +9915,7 @@ static void i40e_veb_link_event(struct i40e_veb
> *veb, bool link_up)
>   **/
>  static void i40e_link_event(struct i40e_pf *pf)  {
> -	struct i40e_vsi *vsi =3D pf->vsi[pf->lan_vsi];
> +	struct i40e_vsi *vsi =3D i40e_pf_get_main_vsi(pf);
>  	u8 new_link_speed, old_link_speed;
>  	bool new_link, old_link;
>  	int status;
> @@ -10281,7 +10286,7 @@ static void i40e_verify_eeprom(struct
> i40e_pf *pf)
>   **/
>  static void i40e_enable_pf_switch_lb(struct i40e_pf *pf)  {
> -	struct i40e_vsi *vsi =3D pf->vsi[pf->lan_vsi];
> +	struct i40e_vsi *vsi =3D i40e_pf_get_main_vsi(pf);
>  	struct i40e_vsi_context ctxt;
>  	int ret;
>=20
> @@ -10317,7 +10322,7 @@ static void i40e_enable_pf_switch_lb(struct
> i40e_pf *pf)
>   **/
>  static void i40e_disable_pf_switch_lb(struct i40e_pf *pf)  {
> -	struct i40e_vsi *vsi =3D pf->vsi[pf->lan_vsi];
> +	struct i40e_vsi *vsi =3D i40e_pf_get_main_vsi(pf);
>  	struct i40e_vsi_context ctxt;
>  	int ret;
>=20
> @@ -10393,7 +10398,7 @@ static int i40e_reconstitute_veb(struct
> i40e_veb *veb)
>=20
>  	if (veb->uplink_seid =3D=3D pf->mac_seid) {
>  		/* Check that the LAN VSI has VEB owning flag set */
> -		ctl_vsi =3D pf->vsi[pf->lan_vsi];
> +		ctl_vsi =3D i40e_pf_get_main_vsi(pf);
>=20
>  		if (WARN_ON(ctl_vsi->veb_idx !=3D veb->idx ||
>  			    !(ctl_vsi->flags & I40E_VSI_FLAG_VEB_OWNER)))
> { @@ -10536,7 +10541,7 @@ static int i40e_vsi_clear(struct i40e_vsi
> *vsi);
>   **/
>  static void i40e_fdir_sb_setup(struct i40e_pf *pf)  {
> -	struct i40e_vsi *vsi;
> +	struct i40e_vsi *main_vsi, *vsi;
>=20
>  	/* quick workaround for an NVM issue that leaves a critical
> register
>  	 * uninitialized
> @@ -10561,8 +10566,8 @@ static void i40e_fdir_sb_setup(struct
> i40e_pf *pf)
>=20
>  	/* create a new VSI if none exists */
>  	if (!vsi) {
> -		vsi =3D i40e_vsi_setup(pf, I40E_VSI_FDIR,
> -				     pf->vsi[pf->lan_vsi]->seid, 0);
> +		main_vsi =3D i40e_pf_get_main_vsi(pf);
> +		vsi =3D i40e_vsi_setup(pf, I40E_VSI_FDIR, main_vsi->seid,
> 0);
>  		if (!vsi) {
>  			dev_info(&pf->pdev->dev, "Couldn't create FDir
> VSI\n");
>  			clear_bit(I40E_FLAG_FD_SB_ENA, pf->flags); @@ -
> 10841,7 +10846,7 @@ static int i40e_reset(struct i40e_pf *pf)
> static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool
> lock_acquired)  {
>  	const bool is_recovery_mode_reported =3D
> i40e_check_recovery_mode(pf);
> -	struct i40e_vsi *vsi =3D pf->vsi[pf->lan_vsi];
> +	struct i40e_vsi *vsi =3D i40e_pf_get_main_vsi(pf);
>  	struct i40e_hw *hw =3D &pf->hw;
>  	struct i40e_veb *veb;
>  	int ret;
> @@ -10850,7 +10855,7 @@ static void i40e_rebuild(struct i40e_pf
> *pf, bool reinit, bool lock_acquired)
>=20
>  	if (test_bit(__I40E_EMP_RESET_INTR_RECEIVED, pf->state) &&
>  	    is_recovery_mode_reported)
> -		i40e_set_ethtool_ops(pf->vsi[pf->lan_vsi]->netdev);
> +		i40e_set_ethtool_ops(vsi->netdev);
>=20
>  	if (test_bit(__I40E_DOWN, pf->state) &&
>  	    !test_bit(__I40E_RECOVERY_MODE, pf->state)) @@ -12402,7
> +12407,7 @@ void i40e_fill_rss_lut(struct i40e_pf *pf, u8 *lut,
>   **/
>  static int i40e_pf_config_rss(struct i40e_pf *pf)  {
> -	struct i40e_vsi *vsi =3D pf->vsi[pf->lan_vsi];
> +	struct i40e_vsi *vsi =3D i40e_pf_get_main_vsi(pf);
>  	u8 seed[I40E_HKEY_ARRAY_SIZE];
>  	u8 *lut;
>  	struct i40e_hw *hw =3D &pf->hw;
> @@ -12474,7 +12479,7 @@ static int i40e_pf_config_rss(struct
> i40e_pf *pf)
>   **/
>  int i40e_reconfig_rss_queues(struct i40e_pf *pf, int queue_count)
> {
> -	struct i40e_vsi *vsi =3D pf->vsi[pf->lan_vsi];
> +	struct i40e_vsi *vsi =3D i40e_pf_get_main_vsi(pf);
>  	int new_rss_size;
>=20
>  	if (!test_bit(I40E_FLAG_RSS_ENA, pf->flags)) @@ -13767,9
> +13772,10 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
>  		 * the end, which is 4 bytes long, so force truncation
> of the
>  		 * original name by IFNAMSIZ - 4
>  		 */
> -		snprintf(netdev->name, IFNAMSIZ, "%.*sv%%d",
> -			 IFNAMSIZ - 4,
> -			 pf->vsi[pf->lan_vsi]->netdev->name);
> +		struct i40e_vsi *main_vsi =3D i40e_pf_get_main_vsi(pf);
> +
> +		snprintf(netdev->name, IFNAMSIZ, "%.*sv%%d", IFNAMSIZ -
> 4,
> +			 main_vsi->netdev->name);
>  		eth_random_addr(mac_addr);
>=20
>  		spin_lock_bh(&vsi->mac_filter_hash_lock);
> @@ -14281,6 +14287,7 @@ static int i40e_vsi_setup_vectors(struct
> i40e_vsi *vsi)
>   **/
>  static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi
> *vsi)  {
> +	struct i40e_vsi *main_vsi;
>  	u16 alloc_queue_pairs;
>  	struct i40e_pf *pf;
>  	u8 enabled_tc;
> @@ -14315,10 +14322,12 @@ static struct i40e_vsi
> *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>  	/* Update the FW view of the VSI. Force a reset of TC and
> queue
>  	 * layout configurations.
>  	 */
> -	enabled_tc =3D pf->vsi[pf->lan_vsi]->tc_config.enabled_tc;
> -	pf->vsi[pf->lan_vsi]->tc_config.enabled_tc =3D 0;
> -	pf->vsi[pf->lan_vsi]->seid =3D pf->main_vsi_seid;
> -	i40e_vsi_config_tc(pf->vsi[pf->lan_vsi], enabled_tc);
> +	main_vsi =3D i40e_pf_get_main_vsi(pf);
> +	enabled_tc =3D main_vsi->tc_config.enabled_tc;
> +	main_vsi->tc_config.enabled_tc =3D 0;
> +	main_vsi->seid =3D pf->main_vsi_seid;
> +	i40e_vsi_config_tc(main_vsi, enabled_tc);
> +
>  	if (vsi->type =3D=3D I40E_VSI_MAIN)
>  		i40e_rm_default_mac_filter(vsi, pf->hw.mac.perm_addr);
>=20
> @@ -15001,6 +15010,7 @@ int i40e_fetch_switch_configuration(struct
> i40e_pf *pf, bool printconfig)
>   **/
>  static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit,
> bool lock_acquired)  {
> +	struct i40e_vsi *main_vsi;
>  	u16 flags =3D 0;
>  	int ret;
>=20
> @@ -15045,8 +15055,8 @@ static int i40e_setup_pf_switch(struct
> i40e_pf *pf, bool reinit, bool lock_acqui
>  	}
>=20
>  	/* first time setup */
> -	if (pf->lan_vsi =3D=3D I40E_NO_VSI || reinit) {
> -		struct i40e_vsi *vsi =3D NULL;
> +	main_vsi =3D i40e_pf_get_main_vsi(pf);
> +	if (!main_vsi || reinit) {
>  		u16 uplink_seid;
>=20
>  		/* Set up the PF VSI associated with the PF's main VSI
> @@ -15056,11 +15066,12 @@ static int i40e_setup_pf_switch(struct
> i40e_pf *pf, bool reinit, bool lock_acqui
>  			uplink_seid =3D pf->veb[pf->lan_veb]->seid;
>  		else
>  			uplink_seid =3D pf->mac_seid;
> -		if (pf->lan_vsi =3D=3D I40E_NO_VSI)
> -			vsi =3D i40e_vsi_setup(pf, I40E_VSI_MAIN,
> uplink_seid, 0);
> +		if (!main_vsi)
> +			main_vsi =3D i40e_vsi_setup(pf, I40E_VSI_MAIN,
> +						  uplink_seid, 0);
>  		else if (reinit)
> -			vsi =3D i40e_vsi_reinit_setup(pf->vsi[pf-
> >lan_vsi]);
> -		if (!vsi) {
> +			main_vsi =3D i40e_vsi_reinit_setup(main_vsi);
> +		if (!main_vsi) {
>  			dev_info(&pf->pdev->dev, "setup of MAIN VSI
> failed\n");
>  			i40e_cloud_filter_exit(pf);
>  			i40e_fdir_teardown(pf);
> @@ -15068,13 +15079,13 @@ static int i40e_setup_pf_switch(struct
> i40e_pf *pf, bool reinit, bool lock_acqui
>  		}
>  	} else {
>  		/* force a reset of TC and queue layout configurations
> */
> -		u8 enabled_tc =3D pf->vsi[pf->lan_vsi]-
> >tc_config.enabled_tc;
> +		u8 enabled_tc =3D main_vsi->tc_config.enabled_tc;
>=20
> -		pf->vsi[pf->lan_vsi]->tc_config.enabled_tc =3D 0;
> -		pf->vsi[pf->lan_vsi]->seid =3D pf->main_vsi_seid;
> -		i40e_vsi_config_tc(pf->vsi[pf->lan_vsi], enabled_tc);
> +		main_vsi->tc_config.enabled_tc =3D 0;
> +		main_vsi->seid =3D pf->main_vsi_seid;
> +		i40e_vsi_config_tc(main_vsi, enabled_tc);
>  	}
> -	i40e_vlan_stripping_disable(pf->vsi[pf->lan_vsi]);
> +	i40e_vlan_stripping_disable(main_vsi);
>=20
>  	i40e_fdir_sb_setup(pf);
>=20
> @@ -15101,7 +15112,7 @@ static int i40e_setup_pf_switch(struct
> i40e_pf *pf, bool reinit, bool lock_acqui
>  		rtnl_lock();
>=20
>  	/* repopulate tunnel port filters */
> -	udp_tunnel_nic_reset_ntf(pf->vsi[pf->lan_vsi]->netdev);
> +	udp_tunnel_nic_reset_ntf(main_vsi->netdev);
>=20
>  	if (!lock_acquired)
>  		rtnl_unlock();
> @@ -15245,6 +15256,7 @@ static int
> i40e_setup_pf_filter_control(struct i40e_pf *pf)  #define
> REMAIN(__x) (INFO_STRING_LEN - (__x))  static void
> i40e_print_features(struct i40e_pf *pf)  {
> +	struct i40e_vsi *main_vsi =3D i40e_pf_get_main_vsi(pf);
>  	struct i40e_hw *hw =3D &pf->hw;
>  	char *buf;
>  	int i;
> @@ -15258,8 +15270,7 @@ static void i40e_print_features(struct
> i40e_pf *pf)
>  	i +=3D scnprintf(&buf[i], REMAIN(i), " VFs: %d", pf-
> >num_req_vfs);  #endif
>  	i +=3D scnprintf(&buf[i], REMAIN(i), " VSIs: %d QP: %d",
> -		      pf->hw.func_caps.num_vsis,
> -		      pf->vsi[pf->lan_vsi]->num_queue_pairs);
> +		       pf->hw.func_caps.num_vsis, main_vsi-
> >num_queue_pairs);
>  	if (test_bit(I40E_FLAG_RSS_ENA, pf->flags))
>  		i +=3D scnprintf(&buf[i], REMAIN(i), " RSS");
>  	if (test_bit(I40E_FLAG_FD_ATR_ENA, pf->flags)) @@ -15923,7
> +15934,9 @@ static int i40e_probe(struct pci_dev *pdev, const
> struct pci_device_id *ent)
>  		dev_info(&pdev->dev, "setup_pf_switch failed: %d\n",
> err);
>  		goto err_vsis;
>  	}
> -	INIT_LIST_HEAD(&pf->vsi[pf->lan_vsi]->ch_list);
> +
> +	vsi =3D i40e_pf_get_main_vsi(pf);
> +	INIT_LIST_HEAD(&vsi->ch_list);
>=20
>  	/* if FDIR VSI was set up, start it now */
>  	vsi =3D i40e_find_vsi_by_type(pf, I40E_VSI_FDIR); @@ -16425,15
> +16438,15 @@ static void i40e_pci_error_resume(struct pci_dev
> *pdev)
>   **/
>  static void i40e_enable_mc_magic_wake(struct i40e_pf *pf)  {
> +	struct i40e_vsi *main_vsi =3D i40e_pf_get_main_vsi(pf);
>  	struct i40e_hw *hw =3D &pf->hw;
>  	u8 mac_addr[6];
>  	u16 flags =3D 0;
>  	int ret;
>=20
>  	/* Get current MAC address in case it's an LAA */
> -	if (pf->vsi[pf->lan_vsi] && pf->vsi[pf->lan_vsi]->netdev) {
> -		ether_addr_copy(mac_addr,
> -				pf->vsi[pf->lan_vsi]->netdev->dev_addr);
> +	if (main_vsi && main_vsi->netdev) {
> +		ether_addr_copy(mac_addr, main_vsi->netdev->dev_addr);
>  	} else {
>  		dev_err(&pf->pdev->dev,
>  			"Failed to retrieve MAC address; using
> default\n"); diff --git
> a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index e7ebcb09f23c..b72a4b5d76b9 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -1472,7 +1472,8 @@ void i40e_ptp_restore_hw_time(struct i40e_pf
> *pf)
>   **/
>  void i40e_ptp_init(struct i40e_pf *pf)
>  {
> -	struct net_device *netdev =3D pf->vsi[pf->lan_vsi]->netdev;
> +	struct i40e_vsi *vsi =3D i40e_pf_get_main_vsi(pf);
> +	struct net_device *netdev =3D vsi->netdev;
It's not visible here, are you sure netdev is used?=20
Why not just use vsi->netdev directly?

>  	struct i40e_hw *hw =3D &pf->hw;
>  	u32 pf_id;
>  	long err;
> @@ -1536,6 +1537,7 @@ void i40e_ptp_init(struct i40e_pf *pf)
>   **/
>  void i40e_ptp_stop(struct i40e_pf *pf)
>  {
> +	struct i40e_vsi *main_vsi =3D i40e_pf_get_main_vsi(pf);
>  	struct i40e_hw *hw =3D &pf->hw;
>  	u32 regval;
>=20
> @@ -1555,7 +1557,7 @@ void i40e_ptp_stop(struct i40e_pf *pf)
>  		ptp_clock_unregister(pf->ptp_clock);
>  		pf->ptp_clock =3D NULL;
>  		dev_info(&pf->pdev->dev, "%s: removed PHC on %s\n",
> __func__,
> -			 pf->vsi[pf->lan_vsi]->netdev->name);
> +			 main_vsi->netdev->name);
>  	}
>=20
>  	if (i40e_is_ptp_pin_dev(&pf->hw)) {
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index e35a08de16b2..8f38a969e20e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -23,7 +23,7 @@ static void i40e_fdir(struct i40e_ring *tx_ring,
> {
>  	struct i40e_filter_program_desc *fdir_desc;
>  	struct i40e_pf *pf =3D tx_ring->vsi->back;
> -	u32 flex_ptype, dtype_cmd;
> +	u32 flex_ptype, dtype_cmd, vsi_id;
>  	u16 i;
>=20
>  	/* grab the next descriptor */
> @@ -41,8 +41,8 @@ static void i40e_fdir(struct i40e_ring *tx_ring,
>  	flex_ptype |=3D FIELD_PREP(I40E_TXD_FLTR_QW0_PCTYPE_MASK,
> fdata->pctype);
>=20
>  	/* Use LAN VSI Id if not programmed by user */
> -	flex_ptype |=3D FIELD_PREP(I40E_TXD_FLTR_QW0_DEST_VSI_MASK,
> -				 fdata->dest_vsi ? : pf->vsi[pf->lan_vsi]-
> >id);
> +	vsi_id =3D fdata->dest_vsi ? : i40e_pf_get_main_vsi(pf)->id;
> +	flex_ptype |=3D FIELD_PREP(I40E_TXD_FLTR_QW0_DEST_VSI_MASK,
> vsi_id);
>=20
>  	dtype_cmd =3D I40E_TX_DESC_DTYPE_FILTER_PROG;
>=20
> @@ -868,7 +868,7 @@ u32 i40e_get_tx_pending(struct i40e_ring *ring,
> bool in_sw)
>   **/
>  void i40e_detect_recover_hung(struct i40e_pf *pf)  {
> -	struct i40e_vsi *vsi =3D pf->vsi[pf->lan_vsi];
> +	struct i40e_vsi *vsi =3D i40e_pf_get_main_vsi(pf);
>  	struct i40e_ring *tx_ring =3D NULL;
>  	struct net_device *netdev;
>  	unsigned int i;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 232b65b9c8ea..662622f01e31 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -795,13 +795,13 @@ static int i40e_config_vsi_rx_queue(struct
> i40e_vf *vf, u16 vsi_id,  static int i40e_alloc_vsi_res(struct
> i40e_vf *vf, u8 idx)  {
>  	struct i40e_mac_filter *f =3D NULL;
> +	struct i40e_vsi *main_vsi, *vsi;
>  	struct i40e_pf *pf =3D vf->pf;
> -	struct i40e_vsi *vsi;
>  	u64 max_tx_rate =3D 0;
>  	int ret =3D 0;
>=20
> -	vsi =3D i40e_vsi_setup(pf, I40E_VSI_SRIOV, pf->vsi[pf-
> >lan_vsi]->seid,
> -			     vf->vf_id);
> +	main_vsi =3D i40e_pf_get_main_vsi(pf);
> +	vsi =3D i40e_vsi_setup(pf, I40E_VSI_SRIOV, main_vsi->seid, vf-
> >vf_id);
>=20
>  	if (!vsi) {
>  		dev_err(&pf->pdev->dev,
> @@ -3322,8 +3322,9 @@ static int i40e_vc_remove_vlan_msg(struct
> i40e_vf *vf, u8 *msg)  static int i40e_vc_rdma_msg(struct i40e_vf
> *vf, u8 *msg, u16 msglen)  {
>  	struct i40e_pf *pf =3D vf->pf;
> -	int abs_vf_id =3D vf->vf_id + pf->hw.func_caps.vf_base_id;
> +	struct i40e_vsi *main_vsi;
>  	int aq_ret =3D 0;
> +	int abs_vf_id;
>=20
>  	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states) ||
>  	    !test_bit(I40E_VF_STATE_RDMAENA, &vf->vf_states)) { @@ -
> 3331,8 +3332,9 @@ static int i40e_vc_rdma_msg(struct i40e_vf *vf,
> u8 *msg, u16 msglen)
>  		goto error_param;
>  	}
>=20
> -	i40e_notify_client_of_vf_msg(pf->vsi[pf->lan_vsi], abs_vf_id,
> -				     msg, msglen);
> +	main_vsi =3D i40e_pf_get_main_vsi(pf);
> +	abs_vf_id =3D vf->vf_id + pf->hw.func_caps.vf_base_id;
> +	i40e_notify_client_of_vf_msg(main_vsi, abs_vf_id, msg,
> msglen);
>=20
>  error_param:
>  	/* send the response to the VF */
> --
> 2.43.0


