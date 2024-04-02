Return-Path: <linux-kernel+bounces-127368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05180894A66
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72CE61F22EEB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CEA17BAA;
	Tue,  2 Apr 2024 04:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Row2Ztg2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094CE175AD;
	Tue,  2 Apr 2024 04:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712031717; cv=fail; b=DVMCSuNcFahWujwrDKqs3BdSKGqjU2YzVOw3yHWDztJWpyB1CNu06Rlx5imzVjWb19V5v04DFehQxk+i51xh6uKb2zI8OpcalVmcbxN2tgoWfSmoIBUo7bcupswxHednBzkkXCl3xd4Aa/E4IXWnJIToZxX9ljfVxDuWUrcjCAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712031717; c=relaxed/simple;
	bh=A1q09PDj6cuAvIbWybmnkhVYS+IYGrUTIiEyneKVZ+Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AKeInItJAO0kj7GTtdjzmFqVqo5tVHgudOfdg2VGQYOW0XkmfbvVqysl6sWBFgNHXvMnmi0BnXFv0bkX9KyUIXpHhfX8x1Gu3iHxfGPeVmFyvpnu+3KC15aM2GAV/L943MM2K9E5iRW/nogDmzQTqnUodlNG50iuHmFowp5kiGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Row2Ztg2; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712031716; x=1743567716;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A1q09PDj6cuAvIbWybmnkhVYS+IYGrUTIiEyneKVZ+Y=;
  b=Row2Ztg2CFzVgV1039OPfAsE6JBTWFgUxS9qfBM3woWCjTvrIdSk0pK/
   VpEy5DHwGkVl7GBg7J4RwbU+D74OTeb4osCD3jf141Z601ui0o2ua7Qql
   tLJDadBpSK+z2/Q+dLH3/PPPeyS3HTIq55Emp7phRzP6jWBHNGADAArhF
   50ZaaAEaNrgxN91/xwNRQdgtIoq7ewGC2IsibRhmTBVWm+Uo/b410BGyd
   L6ux5zbmclLSm+0at1hEr6z+BlECGxnsQuJ9T2fJeYaDUCMXlN8t5fJtw
   FDJbnb3DnEFfWcRqh4QDndWwevn8WGnDvXiXgX6cOAtRQLPUiBiMHb+Cu
   Q==;
X-CSE-ConnectionGUID: phVcLSVhQR611svJa8ZCuQ==
X-CSE-MsgGUID: heeNEKKBTyGDeA+lgMcYNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7083025"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="7083025"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 21:21:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="22665404"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 21:21:55 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 21:21:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 21:21:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 21:21:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAh/X0nROoVCmWFQngq5l/YCYEXUacfiqAbn6ddUElRKppQg3Z/oKFpBheSil11DCXOunzP+4OmEWNpahob6oAQ94Rv+/1gKPTchrlmOQIgSDrwGEuJ7LtuoVJFp11RGesfJeUc9nn1JFs+JaNIqgOJFSW5UWi4o2pTY3atlGD0fkVFUaZjNjn2nB5y2lgd5i/FE26FCYx0Ce1oFE6ZtPCqXub3erGG9xa8RTsR4Wy4tXyEF6xFff4hNKnhJ9GtrdYDXn41lXef/Pms9z2x7p7zJxEcOGw+pgmAGH+594gYPDXoLF7FziQAafljfC/j8Mynj73GwBp8f+IvGympc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MX56InfsqDzKVSQF7gMu9s+lDaleBIEAiOJHeu52XDk=;
 b=TT2AtshEK/UoEcsx2ZGsjHJ5ZcCFWQIA5Pkcsh72Kw8KVu+IRs7nXe1n83dsk56KYy/eN2VEFASXRM8Mw2ZtAmKcYzchruaNQPufAAvFlWCjxplnUhE9pOwMIdSnwoOOZXrdjm2jc7l5vZqxms/YQq/5utkCrSExELVIBS32t4UIDxqzffSCICCVKA2U/VuZRI8pTxOYlmdVQoKd9H7LY4JHkpRrRWcM6zeqXrlowSDyi1NCt/O6IQBMraSRSYvTUO5aUvNorTqJhtdku+wb8DKsvzlVZ+XGf5ghZ/pMKwqnhzJGdFexlcrwB3uCrBm5Y8HhWBaBoqjb1Pxv2DRa6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB8419.namprd11.prod.outlook.com (2603:10b6:208:48b::22)
 by SA0PR11MB4718.namprd11.prod.outlook.com (2603:10b6:806:98::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 2 Apr
 2024 04:21:52 +0000
Received: from IA0PR11MB8419.namprd11.prod.outlook.com
 ([fe80::f1cb:2c2f:e082:c0d]) by IA0PR11MB8419.namprd11.prod.outlook.com
 ([fe80::f1cb:2c2f:e082:c0d%4]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 04:21:51 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: ivecera <ivecera@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>, "edumazet@google.com"
	<edumazet@google.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 3/7] i40e: Refactor argument
 of i40e_detect_recover_hung()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 3/7] i40e: Refactor
 argument of i40e_detect_recover_hung()
Thread-Index: AQHagBy6o2PyVZVsYEiLRXbiDu3fwrFUahpQ
Date: Tue, 2 Apr 2024 04:21:51 +0000
Message-ID: <IA0PR11MB8419BE9F4DF3FC61E3AE0105BD3E2@IA0PR11MB8419.namprd11.prod.outlook.com>
References: <20240327075733.8967-1-ivecera@redhat.com>
 <20240327075733.8967-4-ivecera@redhat.com>
In-Reply-To: <20240327075733.8967-4-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB8419:EE_|SA0PR11MB4718:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sltTpSmgQzny1k4naJEnnBVmpOFCTPLyiCwx0S4MovLYRIbg6eX/s8GWa3CC39DRehbOxLqkjh2mJ/tRigXvN7408D4f9mKIxQvO2kNQar/Yh7jYq9NS2endQngQyvFSecvKm3tBgptUoQ4Y/GAPbdj8yKBaS00xTzZzTYRkyNy9gVpiksw2vZh/iZ22fg3SkFuQZUdsfSIlry1W9Cb8xI1CvtCtLJOQg3wex96RVQJSYK+PDjlSnznOFeGt1ETR0PYgcbicpAXQYmpEh+XETUhnzIGqn8+tTuETbMG7TyzX9OLARxwkwJQOxQ9wMT26+zThFTAOwHEQD1XgmInP4jvC2/f1bESevVmaxx3xlcTLZJzMBK9cuP1S4Lfn1S/pCeS2KiuOzRB82rC1Jsz8XenFtBz+I92rEjKC3VR4yRwcNwB9phYJd8UJo3oHQnOJKljSpvozto6OqwkA5GyJuNbarz0Kzn/MiloyJ3AjafOlWCorodMDZ7eymcMqdtPIvm6qa89FcNebJDkUQHq9uOVVcnINHCf2YVZ//ywkRzlON8F6IdtptES/w5H+mOQwpyxS4/UlePa8CcM9q442GT1vFIfEkYf6cwl+zZs2H2UkT2aJjL/rChNoDtLGhYvV9JPY/YTjETQxGOpc3VEudZiVVpV9RTHsrDMDZTex5h4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c30MoVPlQ8B6lmJuFSWY56O/MSPY6UM1wq6/2mhM/EeEeoVWYHMK7fvX9CHt?=
 =?us-ascii?Q?/FUfcL5g2ht+YAaWq5ibFal0kaTbQV+NlEBsCeAiygp5d/+Gnp360odBCp4H?=
 =?us-ascii?Q?AP/Z0mDu4qFN7Mjc2zgaO2DFQuvMJ06WhUKHQ2eLvEIc3x2h99foT5Gk3RXr?=
 =?us-ascii?Q?YE6qAtRUXXUKluOh3q+M5rWmdVdxtZzzwIVz+UCUhkXQI4Qnm313mdNuhOdx?=
 =?us-ascii?Q?Wvsf+nRK9OPqgjx1pvnkF4d1apOZtjsVW8pyiwsRiY4VB24yZru9zRC4ta1R?=
 =?us-ascii?Q?kTK/2UVLBLpKVyQCWNAa0dhcFNeLeCgM0oEbri1nm5ZK7vCOFiI8VCydVFuW?=
 =?us-ascii?Q?AMBuB6bEhdWT2NL79fU31UmdfKF0SzqwsBPB+L8NSVpyU6ykNocHdNslIB8O?=
 =?us-ascii?Q?bcNVmxThrdvYjJJa0bWY88hMLrY5eyABvpkkroMBMoQRVW11dUmn7+78YiUd?=
 =?us-ascii?Q?12Drue+SF2y9ho0vlE9QoO/c6hWfPoa7XFd7LDSlnUxJwHzKE3GG9cjnW5dN?=
 =?us-ascii?Q?qFqOXKJkMpkx2iL7r14gAI0ghfAG59HsMboc7fHItL39xu5sBu04CdEOIpE1?=
 =?us-ascii?Q?nqYhLJEaEpcOeF3sAsjMcXzJETvUXT0P/pJQYQm7pLOiBhwe9w0v8MMIv1wS?=
 =?us-ascii?Q?YhN2SbjG5HTVibrVCmXcxAUATWcH98tjJwAWEK+qMdHlJghg5Vea+SYqoWK+?=
 =?us-ascii?Q?THL/ZftLFrzdN0KDrsSKRmyuyRlcHi2R2gBzkH3sYgSBfqfkRYptQpWEDqyY?=
 =?us-ascii?Q?FSiLkZG8OgONahGq97JA5cmbsyKYEQM/KWXUB1jhdqwDhGp95OL3jHwZ5dfi?=
 =?us-ascii?Q?9rmYa4MY5C+92224rPND989u6RaU4aN544FIOkIE/Lsy3XvZyUxkfffxDkMc?=
 =?us-ascii?Q?AM9vdizdS0xfxcSCGI/mxiIWbUzKU987VIDZYJvOG7pIVIZ8e6hq0VdMnAwl?=
 =?us-ascii?Q?nmpXomZA9EETo+uvPizf8IPpsyPPK01OOCC2c4g7Kq/mZtqVf4vA2Ef/RerG?=
 =?us-ascii?Q?QQ4QIGnAJyGD9EAnP//AoEK0FQpZOFj3Zzo1l6JBUM/Pg27dGuyy0+DUUyFR?=
 =?us-ascii?Q?2JQ/98ZX9OO/oc/wuSKJcWCn5MpDtvJ/wCRC+m+SrRPEWMONFBiLdmUfb2Qx?=
 =?us-ascii?Q?xqTiKQmqbk+h6UDCmRg4hn4c4tDkH9L+IxN932mpO0N6fhg4Z7KZC4IpvdxT?=
 =?us-ascii?Q?Ot2O53j8QUE5YZ6au9YiOsXyTGQtBZrO+GXMsai1Oo9wMM2SGyIZlEQaZFDB?=
 =?us-ascii?Q?sJbKFH8WhVp2gJ1aLd8iz77e2Fh07VaYLDvQs7EkZKvy20mOD19LQrhJ+clD?=
 =?us-ascii?Q?B7oKJdRq8M/xwLdhcRe/a/AyVeI9tRbrCILHHzRe5Ou/KsqTjUK7k1Ip0UoK?=
 =?us-ascii?Q?D4xZk+d6iz3IlyH8jYVXGy3KIHPfbh74yJUyn3uc6WItCIwtuvw0PNtEcg+i?=
 =?us-ascii?Q?0NLdMDJ8cALJ8GnGNyJbtoAgPVeSzmN19YxdgjuaIFc83NMf685Tg1VtcU7M?=
 =?us-ascii?Q?XnIyqvv63wsOvlZbbNlzLk4emKtNBNld35Ct1EAjlST4FWCJlfsbHfvBt2jn?=
 =?us-ascii?Q?lzneOsGtHag/JkA6DS2hlLEobBJoLGZwnZOGxM/5/H5fStzt7n5L90nqj0Er?=
 =?us-ascii?Q?2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8419.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a43e9c0-c41b-4b35-b992-08dc52cc6bf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 04:21:51.7294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lVWnMTgVHHG1GhmlnsSLLRlgo1B3GrCPZEZHs4eqpJh0C6WiREBpOoIrmtB452DzcxqzF3eeiS01z/Ijhzc6AJ2JBhMai3eiQ57Ctbn0V1a1oUVbRFfhyjxPNzFAgOzy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4718
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of I=
van Vecera
> Sent: Wednesday, March 27, 2024 1:27 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Loktionov, Alek=
sandr <aleksandr.loktionov@intel.com>; edumazet@google.com; Nguyen, Anthony=
 L <anthony.l.nguyen@intel.com>; kuba@kernel.org; pabeni@redhat.com; davem@=
davemloft.net
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 3/7] i40e: Refactor argumen=
t of i40e_detect_recover_hung()
>
> Commit 07d44190a389 ("i40e/i40evf: Detect and recover hung queue
> scenario") changes i40e_detect_recover_hung() argument type from
> i40e_pf* to i40e_vsi* to be shareable by both i40e and i40evf.
> Because the i40evf does not exist anymore and the function is exclusively=
 used by i40e we can revert this change.
>
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c |  2 +-  drivers/net/etherne=
t/intel/i40e/i40e_txrx.c | 10 ++++++----  drivers/net/ethernet/intel/i40e/i=
40e_txrx.h |  2 +-
>  3 files changed, 8 insertions(+), 6 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)



