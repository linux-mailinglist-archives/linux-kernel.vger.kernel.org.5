Return-Path: <linux-kernel+bounces-59837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE8B84FC5C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB0F289320
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9433A80C19;
	Fri,  9 Feb 2024 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQue+NhF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6EE50241;
	Fri,  9 Feb 2024 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504898; cv=fail; b=R0fpTnzmY4hP3FNdDQhcK4OIRa9cVM5AbO7wq+uoszqcZQqXUShhCSM/Vk1ccIzImPi3SrlvVuFvMaM9ZCfSHe/Y5zbfZibnNCGHlbOaqakBUOFAqI3cEmVwpQcXpPrcJMUV9BXXiggiKVb2pWm7jASbdCJpLC5dNmCHiiJ+KzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504898; c=relaxed/simple;
	bh=nM3MPA15ezO9vtb/eSDl65fq49jNOgZrNaxwMlCs4pI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DADIlwn09iJi759IO+pzzM75hrFcO/MSzhL4/U9HDlQeiMVatKIJfg+KIDtThVt62oygQwRWoARF0TfiQsSnmBGEp0yj+3Hd+Uk9QNEkAlE07BQt21yLR4mMCfFzGc0GOLR/7Oz0DIuz+bQtk2v/zhLmONzTaN1ql5Zz4YyAOZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQue+NhF; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707504896; x=1739040896;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nM3MPA15ezO9vtb/eSDl65fq49jNOgZrNaxwMlCs4pI=;
  b=IQue+NhF5jfM3ExoZDb7b1YnN1t+WhTLpsjtNBHc0MAPTBNX51DHOV60
   MAybHm477l9uFP/PRU3tDgn0Se68fTSJlpSiF9sogzkQV5CQmTQXCJHP7
   j63JGrNC/kOHNbSSvLFzkfW83dvZia1Oq1k6E5r21INTGsKJLAKK3y2YH
   G4f50zpkjBL+fqTLGUDD39NmCoycFXphB3K4cKWU2rrtmqs7cff5TdSv5
   p3m1iT9mFfNbo4Kk3Cn4KuNSHtAB/asyqLtTohAuarJwWnc3qNgm1VUfJ
   iiARlyPr1ZA8uyJnHdEZrXrI3ULn+vBeaG4C2yXFt2ekejdaoX+qpOBfJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1618904"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1618904"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 10:54:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1998107"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 10:54:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 10:54:55 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 10:54:55 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 10:54:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llgZFlgttJtKsFaZ0o5dkas3utWguAnzUp4SlbjpcKtzQ6FXNKQx8sklVj6ibXfDtH9OPu0+xUC0COsoJMtAybspbO5hDq6qEFehqCVTIPgrkWtyUYArWmU4NU4O3gtz2ztiQ9GW6xAUKQTzTNXTX0OPze5BjnrAOZdXHbRo/VEs0KLwiUb8nxRH0GZWFLFd9yFMfl2xBW9ntzyPV5j5P0rhHq3Tx0OiECpj3oHlRWHv5anLyJTw6dHQwJ06eV1KRbPE7pDIPayJy2aY32Gc63hU8Uqk92FQKYCIfRdUX5QeLEATq5fvkD5jcH70oG5JWM7vC2IHkzUGckD04BYLrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1E28VEHsKLEF3VwiCfvMXoxnTFNIWsJMpjMb398tsLk=;
 b=i1DWzpDdmZAIFaccXiKxohyxlU0XjQo8mh4drUkZo8KQAa/RDLvJQy4l89CcNTvNPcnRKVNZ+ui4fJErkqprfrxwE2vHvPzdr1Qcbv3DDDQLt/d5s9i017aQyksy+ohg6DrBRFra+eBY3leI5UF2eCkZJF5/OEuaWkHez/DyDg4zWjLxAjh5yVTgGE0VUhFYZ49oHrxYWlud1BGA7/EfK+a1rEtDFZL6Dw62cT9tMA1mvYjwt7ceqYLl9xCB7ZIPj65womTfZsk4fHadJe4WcxS3wa4La1de9UaGjgUr8VEoyso96gFC6nHz8eVbOhUvZEHz1PXOmXnWOZh/5xfPLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by SJ0PR11MB5940.namprd11.prod.outlook.com (2603:10b6:a03:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.41; Fri, 9 Feb
 2024 18:54:52 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda%3]) with mapi id 15.20.7249.041; Fri, 9 Feb 2024
 18:54:52 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: ivecera <ivecera@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "Drewek, Wojciech" <wojciech.drewek@intel.com>, "open list:NETWORKING
 DRIVERS" <netdev@vger.kernel.org>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, Neerav Parikh <neerav.parikh@intel.com>, "open
 list" <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, Jeff Kirsher
	<jeffrey.t.kirsher@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix waiting for queues of
 all VSIs to be disabled
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix waiting for queues
 of all VSIs to be disabled
Thread-Index: AQHaElzoZCEbRHrliUO8Jgc1Y49/P7EC7csg
Date: Fri, 9 Feb 2024 18:54:51 +0000
Message-ID: <CYYPR11MB8429C4E5AF1435FF45883EE2BD4B2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20231108160104.86140-1-ivecera@redhat.com>
In-Reply-To: <20231108160104.86140-1-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|SJ0PR11MB5940:EE_
x-ms-office365-filtering-correlation-id: 6083ca31-d919-40fd-eb29-08dc29a09910
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GvBcdvz/HeMO8qqM9GXdklyBg5NTym7wW6ZfEHsUWNfumYx+pNNj/91ckIoxKwDKMMl+tQKpqBdWLSuCQeP1l2fJy2CW+t95tSveyC1rp/huFQoHluBpMIccX2ddrX0xLPHldf+gZg51jJQj3FPvjatk9BcB8lLWNF85y3NZ9nz4pqLSUpmdSIGnizGXkW2hqXBvG+IvZVo5rTKyufkzktrliDiNmOUYiaL0wqwxcHPRGi8wi+uMPNS6MFcW5jnFko+CSwLUEtcKER3ISKxX9B0qV5bBNvxznWvZVafDlLC1jUuGfJiaWnJtqlIS6E5g6UMN/TbGJ5DTs14voC04vJzcfSdVuDOaNInWFLnOMhUAU89WMrSzsoVaA5C11ULxczp1JtjANIXsmQSUkpL5nE9JiG6D4f3DDR9O+41A/Y2NWG0pdgaz1KZ3jnM9yKD60modwt8i0NlMOwoQTFsulPMTldk8idiIPCzSGl2Ub6QauGDRZCYMgfX1aamhCwM/old4/N+bKgpD5zUCg48sU51pJxYarQO1Sk7OXdQIDF6CDRHMqs3XX6VNu1QMqhs8th1eaxvcc798fV83B9d9xSkhT2v4KHEGX5sAVON/zVCu5Ukxbtyl84foj0xTiyDX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(478600001)(71200400001)(7696005)(41300700001)(6506007)(55016003)(54906003)(52536014)(2906002)(5660300002)(316002)(38070700009)(66446008)(110136005)(76116006)(66476007)(53546011)(64756008)(66556008)(8676002)(8936002)(4326008)(26005)(9686003)(86362001)(66946007)(38100700002)(82960400001)(83380400001)(122000001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sBu+PQGXpAUPOd+x5/ukrdbdw9+Bh8PpWmN2gXMyUzQjz9P0YWa7gLOwN4AG?=
 =?us-ascii?Q?EgQsH+rtyf9LHsd2L6l3NR5QLRksycO9fRqVPSN4RR1XSmEaK2Bcvzll3fRh?=
 =?us-ascii?Q?BeEAPPL6sE236sRwuuTdk8pKpvGlA5ZHO/VCREmkDAAPaiv51mxv5dFZpEdr?=
 =?us-ascii?Q?o00wHjdDc16NkSYq4G7X/1OPZzEhr2llT+pGfjPXWWHAmDBZLpB7t2wmXmlD?=
 =?us-ascii?Q?3wA1k83wwU4Wi5tfkbfxSHAcpFFTyHdCBbKJTDSfuIv4sqohnfITa19Rj/Al?=
 =?us-ascii?Q?aEnpQi9jZDanCo0G+p2ajeH4RNYKYMu4I5y1YJquTV7HQIVwCjc4mpq/8esK?=
 =?us-ascii?Q?uC+9Ufjg3tNBW3YJxdjD7UDpS24My7vhcBFqZ+10pG8YyjJYnNqKjjmT6BJr?=
 =?us-ascii?Q?M30/GiOAeF9472cw6tyZjPScn3KImo/qWX2+WjbIqe6IyNh6ZTazBrgVK6nF?=
 =?us-ascii?Q?pgWDNzZ+w/9wF4alUMP7joE4O3cpJmDLmtVWI8aqFvzfbbxObIGagAjgsbK2?=
 =?us-ascii?Q?OkhlyAjMMowWesToa8KvA+wA+nG2/6ctic5E9BB5lWRFfHZIO8LtGx8/AsYh?=
 =?us-ascii?Q?A9nX2Ts6x7Nlj4LRmdY6FbBvEW6toN0jACtmJWh1AQmPoQreL3KK45fkhvS0?=
 =?us-ascii?Q?vwqLBeVCYhgSjFdc7WXwzzMHS+8+80oYp2AGZnxupRbg/PUYN4AA5a2UTmad?=
 =?us-ascii?Q?oW6UQ21PXfTREt1cl1iW/N++0KteRhmNbBZvVPSMa5EzuQfz+FC0By9Sl90Q?=
 =?us-ascii?Q?FGlb1pDyuE7YCjALkwB/DVlfZ6kv91N+fEtPjnalitVpqOCe/QIV12BgB8Z2?=
 =?us-ascii?Q?LLB9IC+48Js3G/2A++UzMOgtfavPg5gdKPoMFvwSblBn7cw99FMVJoSdm7Wm?=
 =?us-ascii?Q?t5QMDKAREwf7is8lGHhr8JSog+HeVeXor4UCQYyPvsqEpfPfXPH2Y4u4z85J?=
 =?us-ascii?Q?vqG0bneOQB/zDfBP5RV8JXfQWiFUNC+gSyt+wMhxJW5n/7bethTU9+8uQshc?=
 =?us-ascii?Q?RtWKC4EF50OuyypQt29l04GZwNohkIWtfq1IQc1zX6F7DrRTha+K0MHcVG5K?=
 =?us-ascii?Q?SvSELej9brvL3kdogi6cePHRXZjOFfTTo/2w+epka99XjazsGPjwFix4Aik1?=
 =?us-ascii?Q?hq6XjK1tKc/1D8v3Wq0wliAebG7eQeSU5BI4FaeTZowDTmt76xVRxiMTNqml?=
 =?us-ascii?Q?StPpZIMVQWs3UqCzUmosvxKHITrrfd+bkvPszJVug1rxpUBBuxAwZ7hUQc5C?=
 =?us-ascii?Q?rVAWhQSzVCxOrfXaPg+qwBStoTeIrsMDYZ52yIMajWVJIs55aXzkq+AnrVHL?=
 =?us-ascii?Q?FqUcEK9bUCzEzyZlky5c6yHXRoOaxW5rVjLaaB+K0Lrv/ZyHH+jHiSB5AlqD?=
 =?us-ascii?Q?j0We67cXSn/VNYqrMS5kZ735BKoaNzDSkZnXw6fzt3WmGSBK9bTdFnoG+1Kz?=
 =?us-ascii?Q?e8ZMy8LjCg0hb8fBMeGOAyUSTFqQC4ArIyO0ZVoKHhlQkHnVWKdKewZYrY2I?=
 =?us-ascii?Q?P5hepF2YZtRy8HU2MzrPxseYYjBKV0OyzaRS46RbXTcB+YOd4Lp+KCThslSo?=
 =?us-ascii?Q?p2h5SX1UHZ1ClRk+AUCdHV/gMWk3RSrcm/sGsxEqdnqtUHwBMVLIPGMt5Tyq?=
 =?us-ascii?Q?PA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6083ca31-d919-40fd-eb29-08dc29a09910
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 18:54:51.9208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPmUk4cMBasVKlxV+EX+LnMVihM85DC1hgSJSidYaM5ieuzefEECIdj8+E47yW8Nve3H+gQAJsjXR3/j6aE33Bf+3SB2mcGAEmJj9sHD+/xrTYiEd/x4x1JP1kAYc7fa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5940
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of I=
van Vecera
> Sent: Wednesday, November 8, 2023 9:31 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Drewek, Wojciech <wojciech.drewek@intel.com>; open list:NETWORKING DR=
IVERS <netdev@vger.kernel.org>; Brandeburg, Jesse <jesse.brandeburg@intel.c=
om>; Neerav Parikh <neerav.parikh@intel.com>; open list <linux-kernel@vger.=
kernel.org>; Eric Dumazet <edumazet@google.com>; Nguyen, Anthony L <anthony=
l.nguyen@intel.com>; Jeff Kirsher <jeffrey.t.kirsher@intel.com>; Keller, J=
acob E <jacob.e.keller@intel.com>; Jakub Kicinski <kuba@kernel.org>; Paolo =
Abeni <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix waiting for queues o=
f all VSIs to be disabled
>
> The function i40e_pf_wait_queues_disabled() iterates all PF's VSIs
> up to 'pf->hw.func_caps.num_vsis' but this is incorrect because
> the real number of VSIs can be up to 'pf->num_alloc_vsi' that
> can be higher. Fix this loop.
>
> Fixes: 69129dc39fac ("i40e: Modify Tx disable wait flow in case of DCB re=
configuration")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


