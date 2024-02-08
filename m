Return-Path: <linux-kernel+bounces-58018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDD284E045
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C581C26169
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC42580C05;
	Thu,  8 Feb 2024 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMFuy0A/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97FE823B3;
	Thu,  8 Feb 2024 11:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393441; cv=fail; b=dxs/scqLnPsZAQrDO1nuNo1LZ7unXydSoL7tLUTRU7/TPqQvbpgYUgpfqxjPnKl1JdclyjowOKtD0J4PJiRQB79tUI9yN/32r8mV8DVSc1OTLxMTkHvf6wedwXGngE5Mdf36wi0kJlu+a0eevH43W3cJqIrdO3plCJRjaPs1qmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393441; c=relaxed/simple;
	bh=r5A9ohtK0hw8op7987kt9qoEXZDXNbXQVPJ4n+JWWG4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dgSfbteQWHwUXu54KE3jdwdGH4tePr3/+PTuh6LrFXGVzRj3Zg3Gpo8yVij5ALdZLgWEBt4LvsIL7OXnBYsOO1Hlgba9T+FInix/sAINerYjSgAw9csjKmVsGAB2cOSnAI/42d8el7MdCz+xuNnyIqH6WLY0W3vRwP05QkpM1V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMFuy0A/; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707393440; x=1738929440;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r5A9ohtK0hw8op7987kt9qoEXZDXNbXQVPJ4n+JWWG4=;
  b=YMFuy0A/Mk6sjM0J5YXSKMY/zllcUvZKAMso0f0xR5B69e/14KyzDT5u
   +3wRwUpRg2Ew1EIX9E32mm1rFtkyjPBqKRMjD/fJ68W/T6yp5TaJ94Irc
   w6yOIXDRNw3BN+qu8apSqMojmeUCILmwC8I0M4/+RHhMLcgl4TfxR9xgg
   oQs01aiZxqHLMaUasHDvZKBDilHFJ+LkZ4HzX8BYWDg8y0QeJkFYYa1JP
   bBsfRsJx5XSU4BP8cJZqEXGNjCYSX3EiIrJffmoR5U/wk1VziuKSqH04V
   ozx4HuJTNM0P3P5Nkks72YXgPJs1+spFp3ct9TeJusRJLoaeYapSAb+wf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1089144"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1089144"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 03:57:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="6265244"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 03:57:18 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 03:57:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 03:57:17 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 03:57:17 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 03:57:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyoelcJJfumiKqsk4xb8Y+sCy8hnALDD2szUnAGLqMyKjd+c8nFvEjybljpDmI9HjMNoUNMFQbE7RAp/a9uhkH2pUWyqJ/bHcmDh13I+5q6/Qt3BAexTDVZ9GgRMY45QbpFLNgB+jVe4KsF/YyCrezGCXtf6L4n9gfh1UME2JatmJo8W4nSTZJzV/vS2V4EFtcMmWn++KywlStmIHgSqjjLs63o0fBD4FvjlidYQU6f44A+dUBofY7tdVnlPKDNXx/Gm3KcXmIMmFPCkIEsGTZp1O5a8pAhPBuNuHjIYVR3wZNVi9BGv6zjpHmf5FJyLeWiYsvRdTMHJsSpV5Yk1/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9P7O7vmUjhSWTcostT104o4dy7dJTQPKUsMsCVL8Yec=;
 b=YDT9x0jDq1gQoD7yG+1LL1LVSqpNi/9/QNyv4MhrthA2grqzDoCF9Pa3UZENxAEF8B/LKc+caqYQOBt379FxuUlY9DquAkQvn9MTSkjJkbW2c/w6Y5djk3hbbvcgWxL1w0TzfxAftAr4oqiDRjk80fGAkbqWchS1szdL80s20upzYfhrUvA4xV9DA9cp2h0vmXznOJNinGr50Y4b4NJKsoCwUAK6LmsBadHxgikPpaZ68nL1ZtwhJoEwVxSD+sPYP8/Uw5NICFpzKtaMaubPoK5x9rAe0aeMnVPrEWemqaGZN8cWmsc0nbfxihDxglmA+W6x4wcOjy0tCnqJB1iLQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by SJ2PR11MB8565.namprd11.prod.outlook.com (2603:10b6:a03:56b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 11:57:15 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::1859:eed7:cd98:cc08]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::1859:eed7:cd98:cc08%7]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 11:57:15 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, ivecera <ivecera@redhat.com>
CC: Mateusz Palczewski <mateusz.palczewski@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Williams, Mitch A"
	<mitch.a.williams@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, open list <linux-kernel@vger.kernel.org>, "Eric
 Dumazet" <edumazet@google.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
	<davem@davemloft.net>, "moderated list:INTEL ETHERNET DRIVERS"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH net] i40e: Do not allow untrusted VF to
 remove administratively set MAC
Thread-Topic: [Intel-wired-lan] [PATCH net] i40e: Do not allow untrusted VF to
 remove administratively set MAC
Thread-Index: AQHaVEf5VS5h9VRQmkOA7cxvQbQI87D3AioAgAlhHVA=
Date: Thu, 8 Feb 2024 11:57:15 +0000
Message-ID: <SJ0PR11MB58652DF7738CBACACC7B8D9F8F442@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20240131131714.23497-1-ivecera@redhat.com>
 <20240202124304.GQ530335@kernel.org>
In-Reply-To: <20240202124304.GQ530335@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|SJ2PR11MB8565:EE_
x-ms-office365-filtering-correlation-id: ed1b79b7-60bf-40cf-15d7-08dc289d1817
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GQehOXI8ceO/yQyFYr8NhcLnSkh3J8NGkuIZrAniixMadtRJ1UzgDEBGnrM/o5h25n7HjXpIVNPx8YBXAVCaupL68M6DszIUpIxEjMNvk34DYMd1kzc43pqjmXRC0sXXRS0g1E2CmJereqzmFhVHn8vsDREHjtVXMbROhrhOSh6P2qDgRIICw+vteJ5sUHZnjkPWuFcMX9KFup3yhaTUX9VMCAS9DBRZRh9mVy21mvIqHAOlAs7uzis9xiN6Lm/3mCSxGNn/Jx2iRdhJpD0b3vRJl3aJeRPVqT0cuH9+m7bYe4C5oax2CXlcUXrFNj43HNWW5s9ISnPODQpJXQWC3LHlI1a+dBkot3alY4HOYBM3YU4k+jSR8x8AwkJdUgKb8oPKRxCAySscJ4nTtFv9KWnKLK6JKKwhuZvCTZB29tw0/6aZG9Ws2OZ3PEgvYv1Wi6X0c1UZZbi7Jg6/X6MbNYAe+uZfSED1OXH9oN9SDI52A3avFheL7XcjNZBSDNTEcsDg8/dhBEBxI7OE50jWT97jbtdoKNSF9DqdLxqnrKUwJfd3QDi76gkELuWcpV/gctXCV9uTI4KPGDoNPXgQE2sib8J/jDfsAzNBjhRphjfTvGUY/dLGDmTfmCnKc9C/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2906002)(5660300002)(52536014)(55016003)(26005)(38100700002)(41300700001)(82960400001)(83380400001)(122000001)(86362001)(7696005)(33656002)(9686003)(66446008)(66556008)(478600001)(66476007)(6506007)(71200400001)(110136005)(8936002)(76116006)(66946007)(54906003)(64756008)(4326008)(38070700009)(316002)(53546011)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0kmgaF/FtEcyOqtemW8o+BAmwMsIVYLvhQB/2YaVTvCg69t+B8yETEDiRt5h?=
 =?us-ascii?Q?nJ2njb+FvG9Sf9WdI9KIYTyzp1Iem3akxVU8DOwWbI/7BV+KkK9Sa1aalz8u?=
 =?us-ascii?Q?5eGHNzs/WB6n6JSJSTo3IWb37zQnNAbi03yfrx7LDNLS/Dh+tchtpabPyr6l?=
 =?us-ascii?Q?4a9d5n8jcTzuCiJqh0D87WLUtGZWedRfj+Rg4DG79VJfH8+WlzbghxclW1JQ?=
 =?us-ascii?Q?wq1zocnsrrgGhy1GoKO3d0Uxf6JlKG4SPDjnyGJ2TDeFnZ+ZQF6ATT4UPqUX?=
 =?us-ascii?Q?feqCD81f8Ikwvkk6kxAQVwHTJBO7TvyFiTX1EVjeLtp8NZ6A6G7wxUulqQ2W?=
 =?us-ascii?Q?C462nmnoBjLcZruSVHu/tydawT4PpdqS7J0V8fkE7pitd+fhgX3N1DMfBkQj?=
 =?us-ascii?Q?+2mI3Ppn4bxV+2FByGQIDYgnmiUtI7xw3Qf80jIml+PucE7P6nmVpFBZpYFW?=
 =?us-ascii?Q?trKJKMxCQs9PZeWlK1SjlAroQ5NIAdC00TP7QBStkiuwtCReU/rUbUUZlTOY?=
 =?us-ascii?Q?Wr3N/3hZ8wZLmdDl3OzAHtxrgyMWXd+nBJloJXVm+IRHS9pc2dUd1Wo5Y2i1?=
 =?us-ascii?Q?f5zGE/8UIo8+h72hJrwgmO7jQ0Tx+m7fLCbkllMtMaRf8AoYdtQ89Gso6gBO?=
 =?us-ascii?Q?2WUwPSihz8203dPcw6evtYh+pLWx5oRJqVi5Jxwd/tjSiUtW0/ilJYy1ESf7?=
 =?us-ascii?Q?rWQEhGtmcA45rlJZ3yc/tAE3h1iT4BEuMg88pfwZaoasbYFBm/3fL+0V4bVz?=
 =?us-ascii?Q?sxLabI7eOrFZzrc1P7vIq7LZmbiLP8tNbvJZ0tJ6Af8/zKSvJaqQ5fxzmhZs?=
 =?us-ascii?Q?vKJ+Aalws1qpb64SyFdfTDDZGEsDCs3Qu2nrbjUxckj57IpN1xXGho+4vpva?=
 =?us-ascii?Q?xIrapOluy5Xczq3YJlz1QYYPU/T9WxFP2F+T1U2RkQDqNM5//ZxXh2YkkLHG?=
 =?us-ascii?Q?1ux1gtrlFXCtt2ZB9uYteAhMAKkTucjbUtf7++blZ/ZX6MDkmWR0FgB8Iqw+?=
 =?us-ascii?Q?hFXMMSiErYrdiZJxR0Jj7o32TittX2tgKSrMj6ywcreUam4/EoE5RxZ1tcfm?=
 =?us-ascii?Q?ru1C3AyyymM6pMOu4vX/bc3+TNRK/APLEvZFe3aumwPLPgoniaA6f1cxeIir?=
 =?us-ascii?Q?GBwG58n63Neih4i4d95nOE953mxDQO2IeaYjP5OvW7gAv+kz+au1BBfcPMZG?=
 =?us-ascii?Q?fXQeGVbRcl5EMEVAQV7ogF2shEL6z6nE/gx6ojA9l8jSdaLwZE6E7pldVkmD?=
 =?us-ascii?Q?mQHZFjVRYyghN9buiFNglC6/m5iI4+bwAm36rMIauXMuCZeZpibZhaMaCPDN?=
 =?us-ascii?Q?wrBFFfvxMEtkG3KCl+DzFYGM0+CfPgeurFT9k6W/fxhiFVZ2zA860xiqLbV9?=
 =?us-ascii?Q?C62h9H4pFiB/EhWCIhbjts+EMTwfmUA6V3dENEKzcDy5qzR1mY/MvKy0st6f?=
 =?us-ascii?Q?XJZN5LkzBPvyXn5i1XcjLGn65bljWsl0Ct+q7jFip8MK8JGDh6WEAaouUigM?=
 =?us-ascii?Q?e8TZkztBW7vk9s6yeX0+qJx27Q3/me9Gkr/Q/73xjUziotUZNdK6zY2Lgdea?=
 =?us-ascii?Q?0fXhJ68T4N/gisVBY69T9m2B0DKT3o95yCZlMoHC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1b79b7-60bf-40cf-15d7-08dc289d1817
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 11:57:15.8868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /G767KZHday7/dfXATCQ7IkeB+3hleX7Oh4FF17ekIsOPrScwKNuFjz1KEK+Ss8Q+drG8OTMoU7POGwl8t7zytl5lEhC+MtLeMlVIPOuudU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8565
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Simon Horman
> Sent: Friday, February 2, 2024 1:43 PM
> To: ivecera <ivecera@redhat.com>
> Cc: Mateusz Palczewski <mateusz.palczewski@intel.com>;
> netdev@vger.kernel.org; Williams, Mitch A <mitch.a.williams@intel.com>;
> Brandeburg, Jesse <jesse.brandeburg@intel.com>; open list <linux-
> kernel@vger.kernel.org>; Eric Dumazet <edumazet@google.com>; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Jeff Kirsher
> <jeffrey.t.kirsher@intel.com>; Sylwester Dziedziuch
> <sylwesterx.dziedziuch@intel.com>; Jakub Kicinski <kuba@kernel.org>; Paol=
o
> Abeni <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>;
> moderated list:INTEL ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>
> Subject: Re: [Intel-wired-lan] [PATCH net] i40e: Do not allow untrusted V=
F to
> remove administratively set MAC
>=20
> On Wed, Jan 31, 2024 at 02:17:14PM +0100, Ivan Vecera wrote:
> > Currently when PF administratively sets VF's MAC address and the VF is
> > put down (VF tries to delete all MACs) then the MAC is removed from
> > MAC filters and primary VF MAC is zeroed.
> >
> > Do not allow untrusted VF to remove primary MAC when it was set
> > administratively by PF.
> >
> > Reproducer:
> > 1) Create VF
> > 2) Set VF interface up
> > 3) Administratively set the VF's MAC
> > 4) Put VF interface down
> >
> > [root@host ~]# echo 1 > /sys/class/net/enp2s0f0/device/sriov_numvfs
> > [root@host ~]# ip link set enp2s0f0v0 up [root@host ~]# ip link set
> > enp2s0f0 vf 0 mac fe:6c:b5:da:c7:7d [root@host ~]# ip link show
> > enp2s0f0
> > 23: enp2s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
> mq state UP mode DEFAULT group default qlen 1000
> >     link/ether 3c:ec:ef:b7:dd:04 brd ff:ff:ff:ff:ff:ff
> >     vf 0     link/ether fe:6c:b5:da:c7:7d brd ff:ff:ff:ff:ff:ff, spoof =
checking on,
> link-state auto, trust off
> > [root@host ~]# ip link set enp2s0f0v0 down [root@host ~]# ip link show
> > enp2s0f0
> > 23: enp2s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
> mq state UP mode DEFAULT group default qlen 1000
> >     link/ether 3c:ec:ef:b7:dd:04 brd ff:ff:ff:ff:ff:ff
> >     vf 0     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff, spoof =
checking on,
> link-state auto, trust off
> >
> > Fixes: 700bbf6c1f9e ("i40e: allow VF to remove any MAC filter")
> > Fixes: ceb29474bbbc ("i40e: Add support for VF to specify its primary
> > MAC address")
> > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>=20
> Thanks Ivan,
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



