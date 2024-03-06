Return-Path: <linux-kernel+bounces-93915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1788736D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B30AA1C20CBA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4EC1272A4;
	Wed,  6 Mar 2024 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OSzt853C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39485126F02;
	Wed,  6 Mar 2024 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729118; cv=fail; b=KRTc9bxhQmj5LeIHuAy58Pbqz2BWF4D+x/vtMkHjuHIZtdR8bJBYzz1tHsn4Uv4VKy9d2KIrl6zZgOkBJZJ57Llm23wWIVZnqfK4gb3Ix8WLZ5uSIVUOWBaqScvkPiFhIvDsuqgfd/dByDMLjl65getnZ7kfbDcMUfVBnJxVUfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729118; c=relaxed/simple;
	bh=EUAXpCpnHJxxDbCuBE70L9JgIcPprIH3uUlfnyfcyn8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SeEqyQFhxeTbuVygWDlH42ojNzqxF3mCBRn6LB1Dn1Smqyn3WsQADRNFtgXYS5uiE1RR05V3oFKlOdtpuMjliVmXJgwwFx5HPs51fNV54RAYasxHzxD5xrhE8nUsBmtWwR6R14Z5f6KiVA9sbxYo1S6I6cZTrlAzltOgJMhlK5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OSzt853C; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709729117; x=1741265117;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EUAXpCpnHJxxDbCuBE70L9JgIcPprIH3uUlfnyfcyn8=;
  b=OSzt853CcNXBjyQaD5hHCVokIlhzMNcAkHhr9ZZORXO4emG01lNBI2T6
   rhmaSXIw9GLs8HwG5D7QzDsWATe++XLHTp64jcOrfqJl5ZuzFzmimEqjN
   s8JwMqYB5vkJ9Z1EpKOxHan0dAhbDIAvEUJa7JH4yzK4JyY1hy7rdcPXB
   PEtaEhHDGVJ/ucfMrpFFcuyQr8Yrk4tDlhkNqthr7i3/b2bf3a7Di4vDD
   R+XLXSaLZ1ri98Ft+2OKZawYLwCKseAtzLj/11IkCAaZJwI2P9zrpNpgp
   4SOTVtRcwzWr9LRsNzi0jMsLEO3bDYjURPbzXleDu6rdyDiYsJPSMsKi4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="8142506"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="8142506"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 04:45:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="10162804"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2024 04:45:17 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 04:45:16 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 04:45:15 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 04:45:15 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 04:45:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vdyt7OWtSa1fBGvpq2ot6fun/An43mvDVJLeP4oGSOCFBxtTZKcb2IwBZJL8+hKiqgwPzIs8FWPWrf/aXfke/+hOhQDJdMFD8x4MMhVcmVYwmVjvEEf4OuVDu8v1wMOIs9qEhmeGt0u8xpVaELVwJjezs5xkoV8II5NcldmLTKiVsOpuwZipIOJWGmodVUzqtw/DWOnJfI1oXOohMYNw1dYswS4wuE+f/hNvS8P953iGMJ5Eudwy4lIW5c1LnGKMmOQfAScYBkANPL4EI1NKu0/u8waz41tT/rneA/OQbBW6NgPNBGPU36PEJ3ojnwLaMa3mSBR2bKnabPejkHGwmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCrhIKePIvyzS+aElWcrZ/DqcfeAoPIiU/ZFfUsx8Z4=;
 b=IJUSR77CDIX+FZFmEtnKmDtliHy5tjvm/a9UN6tnouiqQq+nvQ8QdCQjr0j4A1WJobefZL5gSruxAVDmdKeFxng0UDgDgA11rlJqqLl7J7MEYgwP5xfr5tuQYs1eEOgOl2zK53Pnx/gx8L+AN7t0FEExJbs4JHqADtZx/vPVrfgFirNvDfRElKlypd0uMyIUcFtkr82AevrYYJMMbrNwCwZEZmv+hpcKWUKFykGrd+3FZ5sMtxe9oMW9reEGbdXEq4aenKDCa8f6zY8dKy0zHX3yOu/UtRTD8osizXgJiPv6JjhfCSf3yBmM6KdVxld0zIjtMjc4qUyUKn5f4L3ZLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH0PR11MB5189.namprd11.prod.outlook.com (2603:10b6:510:3d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Wed, 6 Mar
 2024 12:45:12 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9%2]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 12:45:12 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: ivecera <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "moderated list:INTEL ETHERNET DRIVERS"
	<intel-wired-lan@lists.osuosl.org>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, open list <linux-kernel@vger.kernel.org>, "Eric
 Dumazet" <edumazet@google.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net] i40e: Fix firmware version
 comparison function
Thread-Topic: [Intel-wired-lan] [PATCH net] i40e: Fix firmware version
 comparison function
Thread-Index: AQHaamwRTSXU0ZZndECw8nAbQCCz47Eqsugg
Date: Wed, 6 Mar 2024 12:45:12 +0000
Message-ID: <CYYPR11MB84299E58D6895A18E741234EBD212@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240228172603.29177-1-ivecera@redhat.com>
In-Reply-To: <20240228172603.29177-1-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH0PR11MB5189:EE_
x-ms-office365-filtering-correlation-id: 4c37de77-9f25-42f3-b296-08dc3ddb4406
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qXxfXYo0Gl1Ltzo9ZSCE9m2mbouqW1OucfLhI+gZfRT/Ig81tw8vsaOe7dgVnhBg5LEi3L06zxxgO99f8iEH5aOx+oRxQbPQI6ycfkqoC7oNpnDks1yR9vSx4mcM7zXUXhSAvqH674BicG9+zQ7+gtxWlB5cAeO1yxi57leU5lL4JAk9cpvGlOCSr6TetALQWUkQ91li5MFxj0jyVFr9ZxoRACh+X60UXQ0znSbZDOzfjik6mKFJYR4nZRU8ja4BLmbF491QJQNDGBaJspWP8iRqYVKMSAG2py2GUVr9Gm0+zQZI1SfJEzdCicqb4F4N2LQRK6R9g7rdzyX6G9mEXFjjlwxJsKLnljMCTssobfThVgc2Ehel+o+hAkRG9jIH7VZiiPqkP1SI/dGz5XYCvJ1V+ewnb6tZNlLh9iL+KHQnfYsUGrrHooE6S46WZL9Meva1TUbHyMMkmEdVM4o75UxJFIEjqb0nXsuUwtxuV+UH4XIzxqO3k3OyPxuZiyysEnvpRpKrVkVf9ElIdW7SwavgZs5q0O/X9MHjwl6HiICrebsPh2FIYozSQFV0HzACI23Par5Qyu92wh11axG4sb+LNkQfDUaFvTYzyjVfeVE3qfiQPs7IzBIrYhWVldT8XtpcMVUmqbXjXJ7G+h1fk6h4jgWo7p/J667LCJwvvDN+MmW5hX24iXxFiAaGjMaj/nq6mxFGg2uYHu53VBuEdO0mt3SvwlkB81iugn9+ZaM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FVHLP/oSWzXOC/FWK7dxRCyzwjCRtn8FtHMbSHUzglmP9Du/gy2+Jqg1Cif6?=
 =?us-ascii?Q?Pc4sYGungGhF2emZYOJArXiUk5qi0MP+rcb8ce91KuJGvllKbPVhPD50YDCe?=
 =?us-ascii?Q?gRKR7bbV2NnpW5nzXf5YknIc6CzhIfNqZqUGTUsHcM0wBMP8r/bQWktak1jJ?=
 =?us-ascii?Q?hAOigZiyKw7KOTFEq3TJAkLEsvEn65NBfdN4xhxmFooQHjulCZWxHlk4Ho1R?=
 =?us-ascii?Q?GdaQGvit6kyNqMs2avPuwsqBQid4YrKHKIr3zhQGGUuf9x4uEg8scqvLalGe?=
 =?us-ascii?Q?VzBhMC4hm7orT0mlLa2zTcwI0THpwEApXhjc/LAoQa/voS7JXZZgmi5hhl9f?=
 =?us-ascii?Q?dDwPyrt7dIcotdg5Bz4BVkp34sD2Qxj7JbH+YqSzs0l8kbcsR65OletKPlnz?=
 =?us-ascii?Q?xgNqN1f9NYlz9hE76Uy8E2gq4rHQsN4/LitRJribw+Pgddox5I7YaB0bwJGO?=
 =?us-ascii?Q?Mf9owlsIM4ASrbL4q+Rm6uCeXL0Yzfs3fb3J15qLEgON7YOedaIaQUZgPcMz?=
 =?us-ascii?Q?vQbdoqdk70WOpTqKfkpmMXxV0+FkxaxwlIM8oIzoId4da2onWDoGmZXcbBsa?=
 =?us-ascii?Q?GEmmQin6BSTTEiDVH5/6wLF/fpblDUNLuev9sD3gqTYRjkGMnLyKFWSaDVaF?=
 =?us-ascii?Q?NV9KsRwl9ZbIckohf+8OiHuDQIr9U65lc6J94RxtALmcht1YdIMgnqr8HHou?=
 =?us-ascii?Q?wyRg5acIUNDwExXsW4uN2L/XEfIcRSwLQNuhtJgyn8Pg4EKUYZWM/Dgw5/eq?=
 =?us-ascii?Q?BZLO3/9S9SEijTDueggGpDLDhub3vSYKp/1DxobUumj2GCvFQr0d9F8+KRBm?=
 =?us-ascii?Q?NVZOKL/Mif1z2q7CNQVlFTrorKWGOlP+yhrwSOflJtFZ7uY523NS842eKzuK?=
 =?us-ascii?Q?l07A76wK0SbTWy0IpA+HiTsXlzlKggAJueXbjWQ1C7FdYRL8t5YOgmqWI5on?=
 =?us-ascii?Q?J7JSF6x7xmp+WK5njJaA0A8ZBB7/rIUhXE2AJezLfqhklIV3baSe9bXvnJZR?=
 =?us-ascii?Q?RquCFowtn5CmiHk/CRYyjJexUDwGjE7mEE4P1nXHewxRuP23YtQnEUITI3zJ?=
 =?us-ascii?Q?ix81pjB39JwYa01NTH2s0wgQgLAEAqRdfPYnT9M8UmriT/1R8ZLKfllVQbkY?=
 =?us-ascii?Q?4wnuSF8XpPOqPgZ+K5tArMQHR5jL/eO7ZyvSyLJCPAt4WPj33q1Fp0+4TFmm?=
 =?us-ascii?Q?s5DqhUmMQ0uY5ErZta/HZCU0lKT03w6mQESoRkH6CssrkEhJMMwhG1vhXnkN?=
 =?us-ascii?Q?X69TPO8NLdgYVXQCzqo+nzSFLqCounxBJ6Iq4KMHictWUXw0WaD9eCaavhtg?=
 =?us-ascii?Q?Foxbx6mLOav4MKAuMzG3uWlyWKeCzz1ZiwHoS1bipRa025fLb8B71mOoVqOh?=
 =?us-ascii?Q?9yKdOaipbp/NKxHCH3+KqGoQK8Q39gTpj6bzV6XIJ2HI2mNkpG6ysR+qtZMe?=
 =?us-ascii?Q?6DjAbszmzObWy8RP7j1K35yM+OYPAHmk8+2Uuyy1AiB64dy9N1hgfeCTVFiV?=
 =?us-ascii?Q?+IlMfICt/Tuf4F56QAqa58kcmM1NcoLABrXRnq2ZLH/U9OqT+TVz4ShvLTC3?=
 =?us-ascii?Q?l0Sr3JF8Q5z1IRHBfqUnxDCBQrF9KDHPFi6ud6hS14UJjIgoZDvRC9cwTfs8?=
 =?us-ascii?Q?uw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c37de77-9f25-42f3-b296-08dc3ddb4406
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 12:45:12.7979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m/PMLpnvDZl4pd7i0lRsod+6RTpMw2nBCrb361gdA47sFddKPWx5DqukIvmv26N9kfGKn4rMC1Uf4SNdB1YMQQvemE3JsQjKb21s2ipAUU6uMTGdJhOAZhgFPQo504GU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5189
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of I=
van Vecera
> Sent: Wednesday, February 28, 2024 10:56 PM
> To: netdev@vger.kernel.org
> Cc: moderated list:INTEL ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.o=
rg>; Brandeburg, Jesse <jesse.brandeburg@intel.com>; open list <linux-kerne=
l@vger.kernel.org>; Eric Dumazet <edumazet@google.com>; Nguyen, Anthony L <=
anthony.l.nguyen@intel.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni =
<pabeni@redhat.com>; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH net] i40e: Fix firmware version compari=
son function
>
> Helper i40e_is_fw_ver_eq() compares incorrectly given firmware version
> as it returns true when the major version of running firmware is
> greater than the given major version that is wrong and results in
> failure during getting of DCB configuration where this helper is used.
> Fix the check and return true only if the running FW version is exactly
> equals to the given version.
>
> Reproducer:
> 1. Load i40e driver
> 2. Check dmesg output
>
> [root@host ~]# modprobe i40e
> [root@host ~]# dmesg | grep 'i40e.*DCB'
> [   74.750642] i40e 0000:02:00.0: Query for DCB configuration failed, err=
 -EIO aq_err I40E_AQ_RC_EINVAL
> [   74.759770] i40e 0000:02:00.0: DCB init failed -5, disabled
> [   74.966550] i40e 0000:02:00.1: Query for DCB configuration failed, err=
 -EIO aq_err I40E_AQ_RC_EINVAL
> [   74.975683] i40e 0000:02:00.1: DCB init failed -5, disabled
>
> Fixes: cf488e13221f ("i40e: Add other helpers to check version of running=
 firmware and AQ API")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


