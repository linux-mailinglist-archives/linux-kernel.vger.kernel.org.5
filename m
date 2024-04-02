Return-Path: <linux-kernel+bounces-127380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F274F894A85
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681D11F22B29
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC85C17C6A;
	Tue,  2 Apr 2024 04:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvyXtdje"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9285F9DE;
	Tue,  2 Apr 2024 04:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712032499; cv=fail; b=LVb7bTr/cEqYVQMG1QadX1xxADhXzvkjQw+iIMQG6am5HL7/+eKF8p/f9x7ahgrbx6w0okdoLhFfjgKHz4SQCFAR1TzYb3b58rak2UKOwcTGNHXI11VrHnFxhmekNAMG5rs4zXr3s3UQ4l+nUHTq+ZjIuEMw2iQ1/MZc4WuQivM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712032499; c=relaxed/simple;
	bh=CgexgZkjfnfrZRpv9AKAsNQb8NQWYDY/99H4oBtF/iQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=krbjGv/gIzoxrBBmqkll6PjIP9hQxw7FPi7y9hotsdv2dPTWyQr7Wa0IOav9zwKCF4f/WBFPOoDTLM/UpJS7rX2/n0ORwZDHjTaC9C8VHIkOrBWDrYbjNBA8YwJm7WSMcBN0U7AvKV1RaptJ2E5GERz0yBAcqWDoVWIOvPvF/Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvyXtdje; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712032497; x=1743568497;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CgexgZkjfnfrZRpv9AKAsNQb8NQWYDY/99H4oBtF/iQ=;
  b=nvyXtdjeXFruOyQcHjBmG41pBpZy4h/basHM6q8IHHPWZf0zDc9n2LV7
   8SNqdhA0EBEviFShRHrchcGUE3sKCDJKPDkW4FBrGp8nZSsvOX78ZPE9S
   FRaWrO/hyvC8F0Ev5i+j43Dra2Q6E5Ra1aiXEt63iM/Opic7bodvfNPKN
   flUVf3Q6mFZlsIfScpSTGNl6DWye2QnvFmT3bd0QpIvFBZOCOWHCjg4uK
   h8Kl/rwqEfTQoc4UoLE0iwcFDUAGl2ARJRkAQpBOgUphuYv0A3rWnCZJe
   cLbCpV0AOAmrbHJqU55fT6h6sk0cZyi0Uz8e28I7hNvgcy71f1uiL4nhE
   g==;
X-CSE-ConnectionGUID: ou5J3JUNTqiB9N6+OaAIWQ==
X-CSE-MsgGUID: LLtqgzwoRX6FBxfhvzR36Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7117565"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="7117565"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 21:34:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="49151061"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 21:34:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 21:34:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 21:34:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 21:34:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 21:34:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eA55QO3rnujsJBvVpfHp4xALddwYh3KzoAnhnRBl6M2n0avFH2W6UKtnvBOR7o/0eOnjfsdTWM47dBVYmz/kxbl1RzscBHMlpk0Mo2cq/KW8JydUtQeHJxvNVulhnXK3QkVlHluq1Ega2GwvveSdZ+GaLF/EuUCB9f8NotliFe/6IhG1y3WraHvc015pv0l58aL5lZcXcDdY4yMYZu0A3uNbkJ5Md2HySVaSFi9OwDBxUkrFtu2C2RhVhrvOz3Vu3M/ulsXTxGdiz3Gn4q5VAAyZAHeHJeUCSpx6G4g21ed+/vOvVbdmhO7vWeFqMWqwO7aPL0vZ/1bE31L3ln80Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/59s/lu/g3BMp45xZhyqwmr2+TBjjwWwvCVI3RxSZA=;
 b=EQynnpTAd3k1ywV3bWAPHYervUtZfE26YpD2x9cFmRaYmtWimM3hCo97u+/gtnsWQlK/ELsKEr3hFmnYQfCnmu2UrnxXG3u2R9Vug7Qe2I94XgWRtJza/iqUCgELvMVnqdMZV69WgDChWUTi7w5k32oeicTJqNJgIpWrzAfQUL/JAJl0ZXhRTWoKgk10QeXX6dKpFOYth6XP924Q5FgV5ay1KZxXKAxWVtCP3nBjdDBGy7Pai76sCf0G6z69tIfJgDjC5G36rGRs6fm+x78WvSgfemTAi/cUAz5Adb9c9vW/qKOoM+KyzsFy2sTpvAuW7b1/MiuFC7yywMbgkGh+8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by DS7PR11MB6150.namprd11.prod.outlook.com (2603:10b6:8:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 2 Apr
 2024 04:34:51 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9%2]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 04:33:59 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: ivecera <ivecera@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>, "edumazet@google.com"
	<edumazet@google.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 6/7] i40e: Add helper to
 access main VEB
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 6/7] i40e: Add helper to
 access main VEB
Thread-Index: AQHagBzBUBoiN35sVkqmX+WnHDWhvLFUbW1w
Date: Tue, 2 Apr 2024 04:33:59 +0000
Message-ID: <CYYPR11MB8429270046483657412760DEBD3E2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240327075733.8967-1-ivecera@redhat.com>
 <20240327075733.8967-7-ivecera@redhat.com>
In-Reply-To: <20240327075733.8967-7-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|DS7PR11MB6150:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ql5qDV3wqMwYbc1HR+VMAgMmLN9lLH6mMpbNo4GAHzOeU1bKkqfAF1Qj9OMHSfKZMWyoo0sUnCINTFEQ8MfUpy/TOK9oC5R+FaSb3iH4N0bKbmtSddvD1BD3VwUrA7Dt8BZVCkU5uIgCikJkKUHcGwRR1SZLTjqGdp5I5RQCu1/miNHIaBkjsnBYFNrJui+57whdyxkxV/+fVGE6TO0A8GaH8AaN/phBEajmQKlsNdGrxFj4c39fxJGozryV9GZ0h4+NDvU8c0JfKDX5pn2y4McnCq4RfDEPX5jlypOOxKheOjNjDp9GcUpjcbDidfDkWaOi7rOgH/nQW3EshpN9yhX9vg/zUc6pnCGS16LTJ0gQpgDbx1ROcXNQS2J//jvymlS8xN3gcInAPngzaG00u9J91R3Lma0qoVWVQyqhR8jhBuzrZ4LBBZQuj2RNqOuhVjPbj4ea3bml+vlT1d5oEwD9rxDLYHAfJCObV2V5d80gtujyUSFRC8vspprhmbjwYiudUYkU8DhrVje5eSJz1pgUT9kttNTPRMjQwU6Bwqb9/HgJ+jkOYJgNJ485FZ+vgQGEC/eSXuAntX0FmYuD8zxlHfhjEqiynGs1A/7GO8peBLGQOCpkxD39tQpLwtt8gYC8R21aJ0q1RkH7M22fnUBFdx3ysQ4/LnzTKqO5o1s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w9VHM2Mr5q8dfA7y2DFCeslP59cG0L3dsVIjS3arCfsI5d96zwOGi+/Ahmxg?=
 =?us-ascii?Q?ynomtwwa3TPecs8ohNrQYLAgs+JH35x3d77Z95z5/9a8HGEgVKh4v35veAV7?=
 =?us-ascii?Q?NZGEW2CxvgOzFXCR8X8K/m4uR8BYthN2JTmAxQkZTpbBdqpr5NylcoIw5lRz?=
 =?us-ascii?Q?odaqKYurb/s5VqZ7O4L2XU+WenKZ4azBXDY9S43MUC0BaAthW3ssb3HRTJpD?=
 =?us-ascii?Q?T787oRduhp5N/JXapNV+kpd/Av85RI3jGtSXkHkhd0mRgxyJ5h55GAgmsrzZ?=
 =?us-ascii?Q?r5PpYOOU63bj8ysFI1uO1y44UWGkS1Y+M9+lpTRCN8X2I2KzRZNAM2EjAAdQ?=
 =?us-ascii?Q?zIz01hWYPAe4NNZd44QIzXc0Mei5wEyoNHO/iSXQyQGKf9En5lDPc/d4hrtR?=
 =?us-ascii?Q?1ZtPmDiPjGjiNJvNaEvBClLRvyZdKe5Fm+Ta0yE9o4TarukHffKcYKKOTLQY?=
 =?us-ascii?Q?c510D8NTEDHm3sZmc0YYgqSzv9XfBYUtXuqviOmdpqCcIbhyn4Y5McLFlcFN?=
 =?us-ascii?Q?h5NWhB8kbIO7S0s7Z8vVNlJcQq0GOnyxkghWqKbwI3yRWnro8IQOXIJ+kuxr?=
 =?us-ascii?Q?ULmGduZWaT8OGd8F4zlmrtIZgIrAdis+BvuKM0GuOQLa1z2X7AvJm75dYxxJ?=
 =?us-ascii?Q?G7Igyz6qUaDkQ5qtKs1uGkI8V140KXp8eN2LLa6YAL33TMAS9S70dVf27WM2?=
 =?us-ascii?Q?qoMAqTTW/3wMd/Y6+mfk5jsndRWbTUFV2I7qPGOPNXIzkqPiAGvyR5kVKSKY?=
 =?us-ascii?Q?5VA+gqAHBepsZzWDczNC55nCwo3VLpg6eR1m4nBM7owYy5K8++rwAosiruq4?=
 =?us-ascii?Q?KYGz1R+pdF4hMlVAd6rolH/De7wbhbN2i76fwTdsAo8MCjb8k8qhiVDebxPP?=
 =?us-ascii?Q?jlRPIeKkUc26rzrFEUqvMOcQxRo1nMSxC8tfZPKpiq8YCXGZFiz/xjKp1dum?=
 =?us-ascii?Q?ydYkOwBPWa34VQI/tElQ8t4ZMhwvTlPxPKPwcVqTLEHZa8MfWeZsiAIvnPz1?=
 =?us-ascii?Q?LaBMF5qWRpvjyXvW/hhUOvgvvxs43UlvJQKoVAQbFqKYfkXtmJEvAPonktI1?=
 =?us-ascii?Q?Z/SGlhKwfBtaeorD+FTwNXlCkdDlGASPhDxqw5Iy9bv4zrzeI3FWc8w+af1d?=
 =?us-ascii?Q?ApKuTcpiz3zqu2XDfEET+LgEoWQcQ0jQR9gjlePx/plQbQci9Fv+1lmgQZXU?=
 =?us-ascii?Q?qkQEHc4EBj1GdNJBGWoe19dxjnO2ZyAClHhP9SJRghQGrPQ+5B//tf/ZgE9h?=
 =?us-ascii?Q?RaJU7dyaO8VowAvyolzMKYZGoTDawhFyosw+LtG6szUaEyNPHtZkCsQDtwOh?=
 =?us-ascii?Q?jW25bmocUnqrWPo7Ye0ZQMenrYGBnV5V2pEprAmZOurf8Rrig0TmbE+3p7dV?=
 =?us-ascii?Q?hNan6jxzI13krMkmVIeWZ5wJMwDQk6Thd4YeFXzrW7XhYvxaOuf3YW4j2TDE?=
 =?us-ascii?Q?mQPSvcmhp+F5pBMmd5ajghXlE1obRKcfIx24e6QPu0kfAglycTYaPlUm1lKr?=
 =?us-ascii?Q?ETSJvv+oWyTw6cNLGexJvjIh6TgL6hLIWnxIxqMOSeWQ3QwDlRJbwj8GwFoE?=
 =?us-ascii?Q?5V+MX6U/fQoX8Ktg+ahOm/GY7r+VXoyMJDYsAe2I49xXYREpYDlgIOm8cYkd?=
 =?us-ascii?Q?Fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832d773a-4447-4a94-700a-08dc52ce1db0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 04:33:59.4423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yfMoh5U/IafCCUowZSh6hMTzV2b9JoDRGN2INhSLxzqd0foKCWK8rYDI8lME5SK25Z5uWfPgTQA7Br9hbPlx1cS8V1yVRDt4CH344dZVjSgB9iQZYrUPAEzMahDh/Tou
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6150
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of I=
van Vecera
> Sent: Wednesday, March 27, 2024 1:28 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Loktionov, Alek=
sandr <aleksandr.loktionov@intel.com>; edumazet@google.com; Nguyen, Anthony=
 L <anthony.l.nguyen@intel.com>; kuba@kernel.org; pabeni@redhat.com; davem@=
davemloft.net
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 6/7] i40e: Add helper to ac=
cess main VEB
>
> Add a helper to access main VEB:
>=20
> i40e_pf_get_main_veb(pf) replaces 'pf->veb[pf->lan_veb]'
>=20
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        | 11 ++++++++
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |  9 +++----
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 27 ++++++++++++-------
> 3 files changed, 31 insertions(+), 16 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


