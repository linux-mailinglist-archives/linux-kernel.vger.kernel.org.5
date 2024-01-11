Return-Path: <linux-kernel+bounces-23102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D5382A7AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45E01F272B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76962291C;
	Thu, 11 Jan 2024 06:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fedWJcUw"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481DA7F9;
	Thu, 11 Jan 2024 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704955144; x=1736491144;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mBdSfs0sBfDzJmrhp40t4auxlOvL0pilh6aZ8pfW22c=;
  b=fedWJcUwgyKHlxli2VUNQXwlgHNmgc3hSTFs2gQBKR7Y/lO5UBo2D80F
   b0ZhVEcj32rvt/F1VAZ2jwGkNfQNg6GdsUw9tLt7FtUrNnamGcVrkpHr0
   we0TOzZT8ZAxYMYj8ZvJbkVmYeEmzMR0tg1dI9PWSv2yL0u9Q+M7gZlfo
   gUbpf88yoQTrSKUoVjHkuc2KvF33QiL+K2cfHKw5COmJUeI9tnwfdhVhr
   K3mXKHN57iHVjmf297KyHCjt7rcQT6OdPlM/XLAdhYq9cR6fgVLeJSJjc
   tVZM5sjDLa71zOL06Uj0tM9/ChNBNKStgB49cj3UxzSMwXGlb6s1gOlbL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="465145933"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="465145933"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 22:39:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="24228487"
Received: from unknown (HELO ORSMSX601.amr.corp.intel.com) ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2024 22:39:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 22:39:00 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 22:39:00 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Jan 2024 22:39:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yty0QWB+UaNLnvcIu1Ph6ay9D8RK8CKn1XubCwnZ8s8se62qKsBWY9KAMzNG8sp35hny/98Wy7Wqz82f9cKlV/h3R9O2E+BY78Rp6XkQ6WgF8FtvCxkIrezJFdJfwdhwqmYJAojMyVObIjeJcaaenSGump8kD9MyTVJpmqlOWPPCt24iYZ+c+UDRFlgxvVksJ9K/5dysxWAPFuzXsYtDolL/aeOVDB4cu+koZgMEdLIglF5pon+XPCsLhXHiKAS1LOvTC9zIvBTh0kyZvtz/+nuM3smM5t88YDeqNPj82v0jsm5ZyyrQZHxhEZ4j97gk25bjj22XZzhHuWs0zPexWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hTlBKxwjB68rtNb0uUewIiLx/UqcVzsSSLzWmAKjtc=;
 b=l+Fxf1jWobzPZq0lkYv9m0/xxQpgsm+BjY+ZuToo89i19ZSmlHMiNhGplDk9SjerzbaPKobQXAbfAViKQlhm0hi0jVhpnewQr8JYjMxjPSlUK1Zl9nGcoUyQe7mwimoM/GnrIMzz2zpxfZp0S6fHG5PG5nHxd0s5pnralJmYXCuNb0Vaz8aW79XsW/zA/ojxi02qwyywWfJVH1zjmWoBeyiMO7tooY2F/XbYL4XszcuRUDlheNkbVsLTSLeUUHigdT//EK+XwZCWq6HIdxTGD8k8pWbPpftXngGIexNfQCIyqTdrImTh9D4jig9uRYQTZl2tiTXlFDGzX6VrgRmQzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW6PR11MB8310.namprd11.prod.outlook.com (2603:10b6:303:249::16)
 by IA1PR11MB6443.namprd11.prod.outlook.com (2603:10b6:208:3a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 06:38:58 +0000
Received: from MW6PR11MB8310.namprd11.prod.outlook.com
 ([fe80::a40d:5f37:ee14:6e21]) by MW6PR11MB8310.namprd11.prod.outlook.com
 ([fe80::a40d:5f37:ee14:6e21%4]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 06:38:58 +0000
From: "Gan, Yi Fang" <yi.fang.gan@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Russell King <linux@armlinux.org.uk>, Heiner Kallweit
	<hkallweit1@gmail.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, =?iso-8859-1?Q?Marek_Beh=FAn?= <kabel@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Looi, Hong Aun" <hong.aun.looi@intel.com>,
	"Voon, Weifeng" <weifeng.voon@intel.com>, "Song, Yoong Siang"
	<yoong.siang.song@intel.com>, "Choong, Yong Liang"
	<yong.liang.choong@intel.com>
Subject: RE: [PATCH net v3 1/1] net: phylink: Add module_exit()
Thread-Topic: [PATCH net v3 1/1] net: phylink: Add module_exit()
Thread-Index: AQHaPvcS48imAJYtYkO0dKGHM8Fni7DJn3IAgAqTrIA=
Date: Thu, 11 Jan 2024 06:38:58 +0000
Message-ID: <MW6PR11MB8310698247DD950C5EBF5F2CB9682@MW6PR11MB8310.namprd11.prod.outlook.com>
References: <20240104101255.3056090-1-yi.fang.gan@intel.com>
 <fb1cc3a4-8615-4cee-8fe7-29966c4cb7c7@lunn.ch>
In-Reply-To: <fb1cc3a4-8615-4cee-8fe7-29966c4cb7c7@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR11MB8310:EE_|IA1PR11MB6443:EE_
x-ms-office365-filtering-correlation-id: 8d99efc0-6366-4bc6-8f28-08dc126ffd67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kXWvBebkwLYA1AxmOm4SjcIXLNNCLgSBFLTr5BLInuNgEvUpO3kxjL1GIluLWLq0/xEjWL+f7RKhrX394phWjNAP5HEz4IQGZtxwWBJrXhlYeyNPtt5yY8qCjCz1lpTzn4+UmmkuJEHNcg85qjybiyKVX5Iv4iJG7CjQycatXMAQDiuY7gBuDqC/JmsV5z0mfde4dJifh/P4QQto6cALioeJz7TTXDIjzqX2klMhbEFjdyY3H2vbKvhs6zn02S+awx4mUhwqzSp1Px1+dQbF/gDtRj0hlBLxP4O+4ljZolsKAswPCckXmH/H9f8uruIvDHR2tunYgm4Ombhhrro6R6VmGehlyoXXB6bSXEsRJonji7qJKs3f33YDnMORSdtBxyG1uxsiKrAtQ00DgCiMbMxltdBnbGSAy8YBTlacYE/qE+hYh7Urnh05Hu0K1QAmIcpSuoaoNsLOTZWsPBVNQZYJ7VUjbey41V9e0pmiYR9CPg5gMp0KrE2HZZqj579emclslIPRrtGhPjys1pzjnawF+dnHJ/8BfkcdjobiiNLFWsJrcNXxSoHZShMj+SXQXwxv9q2R2QTLv6f7OWXe9GoVnJdlb2ueBu8S8fpeLM6Dnh6/zLOVFuuAsHwRXaKK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR11MB8310.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2906002)(7416002)(5660300002)(38070700009)(41300700001)(478600001)(38100700002)(83380400001)(122000001)(71200400001)(107886003)(26005)(66574015)(6506007)(9686003)(82960400001)(55236004)(86362001)(7696005)(33656002)(64756008)(54906003)(55016003)(4326008)(53546011)(8676002)(8936002)(52536014)(66446008)(66476007)(66556008)(66946007)(316002)(6916009)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8fd7niZNxha3aiDRWk7guiDpW8q7eQgUznoRlG4Z+ADcCm4o5tmCtRs7Lp?=
 =?iso-8859-1?Q?lQ7FpkWPvzhES/s0e66WlQieCyaQ2foSqHcWAazvPUGARfzCi1pCtj9hmt?=
 =?iso-8859-1?Q?YAqjeSFvaaCgJ6MLgf/BDpz4qSPsRLd+KfUxhctFNE59SiH/pTbnjx3oqy?=
 =?iso-8859-1?Q?Ocrq3i8t2qF5jKsGGiLM4b73MK8HAFyEKKDXU1qtUGwPX46d8+3CSKzdK/?=
 =?iso-8859-1?Q?Se+mZ234O//y1votrEi/FFm7cMRMZRPwY2utkRZ7anRjkfk0DEjb4F7d42?=
 =?iso-8859-1?Q?+8TbfkjbfRGwsPZ2kSEBFhDDS0WxnGYD/AMA1p4C/FiDtyTTi3gFBEOUea?=
 =?iso-8859-1?Q?Rq6vmcNQ7bG8fMC3Z0o9BcJ1WB2y5rV8fSRvY2ESnZ6GYDWgjbPirlyjYN?=
 =?iso-8859-1?Q?uiVPNsjOHsg8yzTwndL0yjox9L++WxO6I48XtttRp8Vqm4IICwiSyA8K2b?=
 =?iso-8859-1?Q?tVfDE2/Y9SMq73/pClVC3o0j/zn+cmzIZFTmMxQ6bZn6wQN2pm4WNUDqnw?=
 =?iso-8859-1?Q?fDHpGcvuVsORUrJwG2KdAXLBTeKOJnExNYcsLbIzrAL1sIG+N2KYBqprwf?=
 =?iso-8859-1?Q?3/W8EtePtbDN30j4UQEGulye+30N8zhbPuljKkHnMUuSq8E9WNHE+Jx0L0?=
 =?iso-8859-1?Q?myNVbJp7WcvUNEtPrkvcnliUQob1SVbPcy5fw5VOdRWe+KD85XM0d4ahQ7?=
 =?iso-8859-1?Q?9dMi9TerRkqmDV+Ryc/+BIvFVeeONYwgWnxvr9wn/19paUOOM9KQ1jSIry?=
 =?iso-8859-1?Q?rTcMnCtCpWtyQsMYWbWmtJJL9c/BnStXIyHtC8X22nBCovd3xLpZQysqSI?=
 =?iso-8859-1?Q?WCWNM04ka3az9Dc0eaaUO6rUyFs2vwZjARtY5peBzmHB0XV1IHWiJLFnUY?=
 =?iso-8859-1?Q?48kWbJlijUuiND/UJ3aPnlHMD03VSGJa6v0r3+XYSkMZvQzGJiy0e4KLVX?=
 =?iso-8859-1?Q?c6TYuzG3U2GuGcZUoBKxIJGxFaw2ZHxlj/vpjrSPCP3oa4YOSHAgDFEH4o?=
 =?iso-8859-1?Q?ATzn3lrT6pU9YWwlhKT8nL7thaZOyYbNp4CzIpim5PuLmwoW57s7+OSOR9?=
 =?iso-8859-1?Q?0w/pRnqkocqxRE9MEvLCKxJMjV8S/WOh/+rjvozORg4fVTVnFpnQ9NyvF9?=
 =?iso-8859-1?Q?36C4Jqjlxh/Q6xUgmWykHMg8YPqefkBzdHC6GK4IL6hDTZN7t4JnKl8E8P?=
 =?iso-8859-1?Q?1hImD5kL7Y23T9msrvmWYTwfl8saqf5oPm1YHE7SyGp6F23WyQBXtRMiiw?=
 =?iso-8859-1?Q?vg253wkNR+NWKZ1YXgES7NFtQc8UWc/8+XCC2Il3N0EzL9tsrJV372Cfed?=
 =?iso-8859-1?Q?vsUhCECvKWWUTyDvBVC7MXpLsKfCZONm1am0yYAgAd7i79D4qUmwTjCWrz?=
 =?iso-8859-1?Q?6+FVcObJFdnIvnOgHKaZE8H8ZWDhwNDns3X6oVdtwt2oDZPx43QjfUGTKl?=
 =?iso-8859-1?Q?fxy60g5FjPbC1zzVLkwKvkwKPQSBulfNu7r65ULfCeL64vecr575GNvwQY?=
 =?iso-8859-1?Q?bCAkHMQy8AbB+dvpj7c9Cm2q6grx+6Zf/gMCOsrgQ9JtpLfhypiJUhUHjT?=
 =?iso-8859-1?Q?V3S/yF7JY7sWf3X8QnT9a5flC93ZYr4nvDMPd/jx+fA71eB0IR6a3c7U5f?=
 =?iso-8859-1?Q?qIQDHnaNznY6b0yqlvfhzMNQ7AVU9cXSEE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR11MB8310.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d99efc0-6366-4bc6-8f28-08dc126ffd67
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 06:38:58.1761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 62o2WE9AWAqFlId9AvjLhImroqlcU7d63YFKd8GijeDZ4xjJCgsrtPzMhCFhRp0iDBAdKkbN5wfWOI1/S1kjrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6443
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, January 4, 2024 9:05 PM
> To: Gan, Yi Fang <yi.fang.gan@intel.com>
> Cc: Russell King <linux@armlinux.org.uk>; Heiner Kallweit
> <hkallweit1@gmail.com>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Marek Beh=FAn <kabel@kernel.org>;
> netdev@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com; linux-
> arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Looi, Hong =
Aun
> <hong.aun.looi@intel.com>; Voon, Weifeng <weifeng.voon@intel.com>; Song,
> Yoong Siang <yoong.siang.song@intel.com>; Choong, Yong Liang
> <yong.liang.choong@intel.com>
> Subject: Re: [PATCH net v3 1/1] net: phylink: Add module_exit()
>=20
> On Thu, Jan 04, 2024 at 06:12:55PM +0800, Gan, Yi Fang wrote:
> 65;7401;1c> In delete_module(), if mod->init callback is defined but mod-=
>exit
> callback
> > is not defined, it will assume the module cannot be removed and return
> > EBUSY. The module_exit() is missing from current phylink module drive
> > causing failure while unloading it.
>=20
> This is still missing the explanation why this is safe.
>=20
>=20
>     Andrew
>=20
> ---
> pw-bot: cr

Hi Andrew,

Regarding the justification on why it is safe to remove phylink,=20
we had done some memory leak check when unloading the phylink module.
=20
root@localhost:~# lsmod | grep "phylink"
phylink               73728  0
root@localhost:~# rmmod phylink
root@localhost:~# echo scan > /sys/kernel/debug/kmemleak
root@localhost:~# cat /sys/kernel/debug/kmemleak
root@localhost:~#
=20
So far, we didn't observe any memory leaking happened when unloading
phylink module. Is it sufficient or do you have any other suggestions to ch=
eck=20
on whether the module is safe to remove?

Best Regards,
Gan Yi Fang

