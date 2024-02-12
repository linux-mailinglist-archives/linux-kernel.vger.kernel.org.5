Return-Path: <linux-kernel+bounces-61434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4602585124C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0D82826E8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D833939857;
	Mon, 12 Feb 2024 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTO+/o+a"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB5E39FD5;
	Mon, 12 Feb 2024 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737521; cv=fail; b=RHITZ1ABilKP+IsSxFVUhoek9/TFSLP1XlfQ0MRXWfLwK7e97u4gQFwZ4zw3oPC/Iy2a4ImbjQxsfaTLQWRfDyOgQwbuZfkvOnBfXSEunBn5TIYnmFKqfrZ6AJlrmsBfsOGUSTIlFvEbVLvc0KHyLcE/bacYDOpmbgQ6cx+h0VU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737521; c=relaxed/simple;
	bh=x5HpBQFuNzb6vDJUrXHrubAdbfrdGfQn0x6kB2ztcew=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sOK7gMfBc18XfUbpn68HQY8mYOAytRyUeHLWh4L9JTDrH4jWR062wky3VCy/umRnQ9N/gYyWYG1cmAXFSSe9+9w+JDsqLgM7gYNAPMli5QnMgSzFs88pbGLNODioTnJDEN0LCLsZdTJZQzv7yrfzEJ6jHMEayW+ABv/KgPK5tGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTO+/o+a; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707737521; x=1739273521;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=x5HpBQFuNzb6vDJUrXHrubAdbfrdGfQn0x6kB2ztcew=;
  b=UTO+/o+aqicDjh3/rrSCMaUowinymCozl/kAD49M9LAvWEAG/blY2aVw
   4ZNtpWukWJb0497oQoHxzjV06KIJbVIFU0s2kn+hthwvlbuxt3TwfjMnr
   A3obff7qTk+2L1ny1amxEQ1rTQ+I6nGvmV9TrY3PlCn4FLtw2fV4vBzRA
   FXXRmve9Z8v583PpwYXRYuuJ1CWskqh50B4pj1rudHymmDTFDdm/q1J4j
   jKDeZOw4nJ8yVg8eZiqFhnhuxcXf5qT7/Vg4FjnZhbJVuPXShrefunsjz
   9hobZuP8ME+DSgmSHndf7TIVSVAT5En/Z/lOAfc3vaAbobsiVNi/ViA/g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="12798707"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="12798707"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 03:32:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="2956442"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 03:32:01 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 03:31:59 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 03:31:58 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 03:31:58 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 03:31:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeHcV0WO+VuvlvCOipkOu/NDYCamuiP58kqzumT/VZ5XGM5zKTHfD8Xdh/IjkmwXFnYfBhMwBj2AKXV47JiM30301cIiGR9XyuFLCYaNe+H24eY9ZPST29q67ohkFTuV8HnhO9K+uIXBLmJ3Tl3WnbvIuNY07TyWQSslIRFO9VIB0g7PjiP9cF7aqXCBn9KI5BL0+kwu0lt8fihj429CMNOqR1NYLzjoPJtHtmUSXRhlegsfD+9YkD1JbSgLhK7FDyOqpZKUPVzZvgHrQuHUehslCgfkkuy7NhpK995xxlHaHQibD3/AiPVJuCwlDPG9WJdQhTevlU6Pdx428DtClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=et0sfPFiKM2Yp9mdCCvF4ZERrpt5mPDn2TR9WhVVLU4=;
 b=QnPL3mb4+mwbxR/VbO8e1dp55q2aK6GhfmN9Jma+55+q2/i6+877w9CMQfKU+Kt/ej7jSK4Nkfbs3FDKrEdU0cF5IFo7qAWVgRzfodNKGtSZeqUrbnFYGmLOFHtLjrdJCKp20wgtzfi7vK6XNqrcvo+iQ5vvKG9HyCJwX0gj8Oy2i5DLFYK0SgLyrhYhCPF+LecjSmESpfbvXY9IP3zMA5c2PnAmAeLUjwNAy1JI4hBbgpFAOaFuDs+Q9P5z+EEsjcmnN57maODHc/II2TZ6DHDmMS95SktZjTazTs+FEcg7nqlubyuOD3yqu8Vxu4kHhZWaTnaWT3fVVfn0FUcnoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by CY8PR11MB7948.namprd11.prod.outlook.com (2603:10b6:930:7f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 11:31:57 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d140:9bf1:fdca:b206]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d140:9bf1:fdca:b206%4]) with mapi id 15.20.7270.036; Mon, 12 Feb 2024
 11:31:57 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ayala.barazani@intel.com"
	<ayala.barazani@intel.com>
Subject: RE: [PATCH] iwlwifi/uefi: remove CONFIG_ACPI check
Thread-Topic: [PATCH] iwlwifi/uefi: remove CONFIG_ACPI check
Thread-Index: AQHaXSemF2bqCYvELE2YNO3yk8KMWLEGPWNQ
Date: Mon, 12 Feb 2024 11:31:57 +0000
Message-ID: <MW5PR11MB5810B584F7C1545941E8C3C9A3482@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <20240211201919.3751551-1-max.kellermann@ionos.com>
In-Reply-To: <20240211201919.3751551-1-max.kellermann@ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|CY8PR11MB7948:EE_
x-ms-office365-filtering-correlation-id: 49866d81-14af-49ed-5db8-08dc2bbe38af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xF/nSmeRGeSo3vpfba+4ofKIxThT6ecHhcrOUBGv7cuGKUqDkLVkxJWa/E3rR2AZ/VdOeLfsLnfJF6rXc6UkltHNfyssKNbJtyUQ2L7BUXzeXlJ2CxHmBInhqF8Cnc5e8QMplohkEDoMkmJ4aUqd7g+PODU+qV22EKeHa9SEyLvKN+lWksOXAkmaqiE+Uf+U2ellpbFTyBs6NMiV5ZDA/G2sV2J70uG1g/ivVJEtTRJtW2OljMkH/fOZ23YLdevFXbcZ7cXINR6OLn3AxlDK43s99eVEjbXhaQfZbvBORWDHxCehKburNGe6chJ354UwmTHZJhv5EqslQ58TYan5O/xCk3KCXzV9Uzx7voK83RhUq3qHd1bjA9L+Nt/8gxNjXVaRwi1TjsPacDI97l9D5ssiXx2Tmgi5pVF6+udY47ZVPp4lM2llxVpPjV9NOx0cWa0uheGd4N3+CO0hGSRWiOJLHhAHIP9+3ro2K1dcvxKfyFXU3fyQQmrVd99MLHnIe/bfvlizIc0Qr2X86rQyNXBBIqTS8XHMSjcQeF+GqnxuTbbRienEXguSwXeKxkIKeCwO7siu8gdWRxom00900Z3Sb0rjSDBM9GCvsEvTsIGZNZyl7ApFRoeurYQ8Fd2t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(9686003)(478600001)(41300700001)(55016003)(8676002)(8936002)(52536014)(5660300002)(2906002)(110136005)(38070700009)(66446008)(6506007)(7696005)(71200400001)(6636002)(316002)(66476007)(66556008)(66946007)(64756008)(76116006)(83380400001)(122000001)(86362001)(26005)(82960400001)(38100700002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tvaexTPcJ1pLEgpZrPZdYoOaPpxeVQaPltCOH/bXgmxiqw8oDZBonbi7JPMj?=
 =?us-ascii?Q?ZnY36hwaVpefuk4NXcmvoowmQAEVRb8w0x0HxDzsT1I22TvvKLlAw8jMoLkK?=
 =?us-ascii?Q?/2IVCrqX/QS9vP5p/g9zdOZXJlknX9l4hiqag2wJAFjm/S60tb40Nztv2KXl?=
 =?us-ascii?Q?zh1vdX48h2VX3UP22n98UBSqE1LgVsTbG2+omuNwL8pmPlFDvBejnah04rDq?=
 =?us-ascii?Q?SepXBb+4jA5b5LcevLHf98WvVE+AscU0g4i9nVnudZLy6EbcQ3ws8pTNwRu/?=
 =?us-ascii?Q?AG3OnO+S2DpkOzXbaaVtDk0MCoqBPJ57XhoMk761eXhXDF5yltQ+0z891VPn?=
 =?us-ascii?Q?pZ88eBPTyFZjwUSITh/UyoNNprGuFQYG6ydlcGdLmO8yHGFzWc4oiUILcJJ8?=
 =?us-ascii?Q?/M+brLm/NZT/Qb4FrTcr88Mndg8tlGYZrJlo9R2Siyr8kTP5aoJkwE3HrVUh?=
 =?us-ascii?Q?AVaN5n5HchkRQIseAnDum1oAHyP2TzMyMsj1E2g6dJE+Hq0gTPS14WZTmEJ1?=
 =?us-ascii?Q?QbigufXkY3dFoV2bOzHwXYDefiCzlXL3PDdLgdBvOwl6dbrge5MxmDxL+eba?=
 =?us-ascii?Q?OUwe88b/CRcPGUkr4OUKmiJcDr1KKN7qTfENIkQMCSyuw2KseXhI8JykleXh?=
 =?us-ascii?Q?SzW+JOZLDRecR1BBSQHJkvBWehF5URQEy09mQDquyUDfTPjCga4x6vHujydk?=
 =?us-ascii?Q?ocf11ZqSZBCzPiJ7+xAVKJHXLOE8WUKwIqwJZBRQTt/A65H0PvLJuMWCUfFD?=
 =?us-ascii?Q?GdDBEwHeW6a3iI0p2H6yzi4HS2kCN9BIIjMg0I9TDQu6rCydcO4gTKNYzzPB?=
 =?us-ascii?Q?1cwdW2RQU0Ow4MyGJEApA8IAXMCRdd6/1GV1xkhhZEbmxBZue/ttRasp8NTG?=
 =?us-ascii?Q?bqieFr+ycuSG0JcI8ZBdhAH2T9eNsqXDEVuYGw3wBe53H/A7ZBSkwPG0Hyhv?=
 =?us-ascii?Q?l1beezhdT1DruzC8Dw69rh6UPjsjJQjO1yJWo9FL8of1GFajLo8TP/EAnaMN?=
 =?us-ascii?Q?Pt9k7J69LLQbu8O4WAOBbRq/KPFb/7qZnX/GZtxvltmLFlNZ7G6Wvbl4dpdy?=
 =?us-ascii?Q?AnXhkN3G1ARPskGPuax9Svkg5Z40sYts4gM8eiPJPYXLt17wr1WSRVLrDUfK?=
 =?us-ascii?Q?3Z9AisCqrzm8XidCtPM5fDZ4lWy4PXWxr53y4baVSPSk4Q3VQm+i6PtDhrD9?=
 =?us-ascii?Q?I+Rhd5RcoreEucg/TRw2TKGfQL/GHtu5rA5qXaFtO0CDMzETMjOSIrPUX4N3?=
 =?us-ascii?Q?rjMJE6Tgo3Loywf+8NSmC0iTDArOKCc+6IiXgFcjtb0riuSMbgSbO0aJho77?=
 =?us-ascii?Q?a6YA2tz/g9dRGu6JhFQdHHC1WdhgZ2ks0oJvwIyJE4917e2wkHj+DQAEs/L0?=
 =?us-ascii?Q?Yp2m4rmx0NDxIOfWHK71cdqZSQs9njNWzKROAyB2DTydPbcxb2m05t+WNlzc?=
 =?us-ascii?Q?oI4OzBdV8qN/8hSRg4+zJCAdD8dvaTkSvbM66N8yN/LnPC5i4Dsd25bcGpBf?=
 =?us-ascii?Q?rNeyNdwvnOKLSnxkG/Cc/fV3G//cFmWUiyDyJCilPxaWOyJNQMZ0zW05vDqK?=
 =?us-ascii?Q?/hEArhbiHNPaYtpUMo0iCgHyZEH++Kw8Mfm/4EqJ2LEVvhon4RBFiPDmIR9X?=
 =?us-ascii?Q?OQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49866d81-14af-49ed-5db8-08dc2bbe38af
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 11:31:57.4006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t1eJ5vKY747Xb8HE45eTdH3CQABpctq+UpoH4dT8E+n0NZZVW3wVa62pChkIMUjLxe/vJsSWxw6GsnJUuipHlA3bqZ2MdP9b2T8qco6N7TAh+l68lTPRlwLIlDj6hbAb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7948
X-OriginatorOrg: intel.com

>=20
> I don't know how the driver works, and I do not know why the CONFIG_ACPI
> check was added in the first place by commit c593d2fae592a
> ("iwlwifi: support SAR GEO Offset Mapping override via BIOS"), but since =
it did
> not add the same #ifdef to uefi.c, my first guess is that this piece of c=
ode shall
> be used even if ACPI is disabled.
>=20
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/fw/uefi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
> b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
> index 39053290bd59..8617fe8b65cd 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
> @@ -285,7 +285,7 @@ static inline int iwl_uefi_get_dsm(struct iwl_fw_runt=
ime
> *fwrt,  }  #endif /* CONFIG_EFI */
>=20
> -#if defined(CONFIG_EFI) && defined(CONFIG_ACPI)
> +#if defined(CONFIG_EFI)
>  void iwl_uefi_get_sgom_table(struct iwl_trans *trans, struct iwl_fw_runt=
ime
> *fwrt);  int iwl_uefi_get_uats_table(struct iwl_trans *trans,
>  			    struct iwl_fw_runtime *fwrt);
> --

Hi Max,

Thanks for your fix!
I think that I'd prefer Arnd Bergmans fix, looks cleaner to me.

Thanks!

> 2.39.2


