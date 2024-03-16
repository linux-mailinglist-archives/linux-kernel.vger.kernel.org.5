Return-Path: <linux-kernel+bounces-105003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B894887D781
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30197B21122
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B037B1109;
	Sat, 16 Mar 2024 00:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="egEbyGtx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD267F6
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 00:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710547702; cv=fail; b=G1eUi3MJeGm9KEKnOLYpiS8JRfqtcK5fjN1kH4JDn7QMnV36rLj/gQvxIVWoINBxzTEbq+9zSawWSsE3pMPOj9y37jhiScwCnFp5zltaPhd4YNTjDhrJpU5AA8p+mu1qszLNUHobJlRo6guvLsVHHi3iTSCBpp1nUCdYLV51Tfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710547702; c=relaxed/simple;
	bh=XE2W9kz7NZWfsqo1xyGGCuG/VeME2Pv0uEdRb9PNWXs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bnh8Zf0bnc9+mDh/ygY7Vg6e8rQDg5slYdudOVx2UhnTcyK+dT5H6eIR5OT5ILDFVM0wxoe04zqT+zF7dppZzIA1xDipUzpQpUbQiUbiByhyd+xBS7jLy6qDPUUiDc8XbP5q7uDhcGjE8BUAx11x/rymP1gvIYQMJSh/kvGeu+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=egEbyGtx; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710547701; x=1742083701;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XE2W9kz7NZWfsqo1xyGGCuG/VeME2Pv0uEdRb9PNWXs=;
  b=egEbyGtxoHhlY0OvPaPQrHAaeOoVI6QJhIPEY1QyWhgwQtNfE/IUdjYD
   jP7MAYSQ7gGPzJiwVmYkgOB7szcjmPvQsf8whq/ePvQ4GXzP2T6jgQ+x0
   L6Wmd13RtPjHMVT91khz2u1VEYDUcn5FeqxCs8ygL0NC07H6OseXnUvB5
   6VCpx9wRhFooNNk/D6GicUYEg4lMWlhgB75T+brah1r0OdMviPb88ptBn
   K91bsH4pnUtq1akPcOzUi17KumDhS9k494K614hRxeXMfrcRRcJ0ZhC1b
   G8ZS5MAiy9G1xOCNCGKtpp3QpU3UMYlUsO5Tm/pSzd2gz2nVsWtUVnfxe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="5304469"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="5304469"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 17:08:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="17522560"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Mar 2024 17:08:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 17:08:19 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 17:08:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Mar 2024 17:08:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 17:08:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABdWE/7J3NJKPjltRqulDIfJCEKp+PM8omNRB2wGKKdn8mD6MkoWfguz+a1pylSE7lWCV8wv/uu3nA9PTAsdRgV8q5V7zlcJl8DPVLRwzUHts3hST/5gdHk+fYkQshIcf7WAcLUSEg1KoTTIORXQjbozEjTPxvJCuYCu+PPAh5nUCPop8vuS3MAgAvrFm2XrzZsxTRGjt9HrjszJp0Plv1ITA2uW63KwHAjgRF5DMZSKTAPbE2hGScr3jklZb6HxXZhJx3VcCDhBlIK6eawNe2mgXvSZYKs019F5hkFPJPmpHys5se/SL6pFIZTTUQqjXVkkGmWlOPVtn83DK9Ef8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kf9SR3PksHV2uGaaZxzn9hMpYGiF7JHKJVq9y27gc1I=;
 b=Tv6AWuetYdCEnfJgzMIiAbA/IrVVQ8RZpiiaZFJu/K4M7eyK3Ek1iNV5oxoQ7aXytWqZDVv8rvEmfqEo09XInk3Bch2GxtGrC1Uu4qy9vV9YjYAnXPtmNnrqDTUmMtTWMsgyYACs0Gk2EON4czxzzWMgFnvuHGDPvbKjkwWtO7M+dX4/XmyOTNyiE2n5NxxAg02Gi5BwQ0f2UWLac6ZMCWJNHB74GtK08LMKhQeKsDSE2wX9rBCWUZKRr/CJMwcJPHH8RjKXWSRIAD6dxU8r+6Om+xt3keNwToYpmKh7TefXTtXVtQs8LdJSqVilky8l6G8dHlreuWXx/eUuIxW9nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BL3PR11MB6506.namprd11.prod.outlook.com (2603:10b6:208:38d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Sat, 16 Mar
 2024 00:08:12 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%4]) with mapi id 15.20.7386.017; Sat, 16 Mar 2024
 00:08:12 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"james.morse@arm.com" <james.morse@arm.com>, "x86@kernel.org"
	<x86@kernel.org>, Babu Moger <babu.moger@amd.com>, Peter Newman
	<peternewman@google.com>, Borislav Petkov <bp@alien8.de>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: 32bit resctrl? (was Re: [PATCH v2] fs/resctrl: fix domid loss
 precision issue)
Thread-Topic: 32bit resctrl? (was Re: [PATCH v2] fs/resctrl: fix domid loss
 precision issue)
Thread-Index: AQHadiPNgVSWe3T980i4MYFdFsC7abE5ddGAgAAIGXA=
Date: Sat, 16 Mar 2024 00:08:12 +0000
Message-ID: <SJ1PR11MB6083B9EC479B6B20684FC1C1FC2F2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240312075349.977-1-rex.nie@jaguarmicro.com>
 <fed6affb-c7f4-4992-8646-8f5a52c33966@intel.com> <87jzm3jckw.ffs@tglx>
In-Reply-To: <87jzm3jckw.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BL3PR11MB6506:EE_
x-ms-office365-filtering-correlation-id: e890375f-5f44-472a-3e64-08dc454d2b4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tJIXXkXp63sN1mJ8bUTdPYChrd0+KBj33Yu8HzYCqgz4WcQL6P4grVHUgxc+3f5SRoJwsdvOb5w4NEHBkh0BT4T4AieBKbkBjF+12tL9452JXqXfI/BwIAASSVk4WgjFWeYn0G6q9HQ9t34ksB3Tg55zcKd8iMPC8HaKOrSKzsCK98ze2nWI0cAR9XIL2UjuThtPeDXKFq+Uq6dlRSLDHWK/zhaf3l9K3sc2ij3hpKTVZQ+C8daJ0Vf9bxtbhEe+2AW+XIr0K9ElC646ssYUWxQ4azdaG9vp5FZAc9lt62zlz+8a9rK6cQPHgLQVvjeGETE7/oVZyW6FtphCD1dQurKjdjyoxgWlbG9kuRALZoIzLRwALCuLsWJauLrmdAoR25h4JkkG4F+T5GaBrUb49vfnlTw8/wL4AdXfesMBLLJikgtnfTf6shv5LB8WbXo7K7l20gFjNDOAfOU4nvDlN9AzO+1n2T+0UfLgZOhrbZGK/yV6XyhNX70AeQUF+DqF8ptIrtvwYqTwD9FokqtExdUJm6CEsBjaTDbd0KfBY4241JzXwnlT03DzAzIalAq3wOyzf22a051sxONmeVyMcPq2VRfhqeh90wqgBL+f8O4oXm+u2v+g76auKCcBRneHhtHoCHPi+FiJMcN0KQUtzEqebpRVZqNIB0evGfIOI9VXx4hXBA/o07K9xngovnfb+Y9CvCVRYwo/JQkanc7UEhxa96K+E5zJgCyzsI8pBu8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VAXZo64VRt+/Ezn2TPprrfhjBxPf2Hd1/Pf9TtevYCJpgkgisuggFhCZBCBy?=
 =?us-ascii?Q?9OiHhIpExK5UOGGu1m+5IBRyouEST/NRN6hhwzzUrzGNkAOwzNtV90bb/q/T?=
 =?us-ascii?Q?5ZYZHyQsMyTTz4wofP3t/O2LLl3Q4au9qREnZeliSjd1bgwC9MABWYtCjs+p?=
 =?us-ascii?Q?2hTDcwtS5ibedoohfxSNf/GOi89IntZQ2+S5TpvGFfLHyk5iPwVZQBvnRUwv?=
 =?us-ascii?Q?D504ca3cgT55UIDiXfIA0YTBB1OHstqjvT2N4qsCBbtxu3TdDTZF4BSDaSm5?=
 =?us-ascii?Q?lJPBVIrhmr3sylCJxKyzSMAFx2C2UWYowH90dXO1+iFV63y0q4pT6SYRrVB5?=
 =?us-ascii?Q?IzStvsaZONUoMsEZYKTnjZn4en0t7I2m0MNuTCXCL1T54R/TXKvOghnC+93q?=
 =?us-ascii?Q?kt1c/wzohZo2t3HuhBi5txsL7IzWHdrQiWUtv6S6UflWfAwTXeDUa0LrYLX5?=
 =?us-ascii?Q?ILuxFrakICd1DhTjiLP94jDTg/AxQrxsxZxnN6a3P+rOZ8gk5CMY9O9Gvx1o?=
 =?us-ascii?Q?QSZvuwUS1CqX6nwjy/TYyKbvBOhaDz3jgAJxfJtptXmzZOfA5ETAVlyXSnEZ?=
 =?us-ascii?Q?7L9Qoxe30QBa21Nur8glauG6cgULhvrLYRxs2FEyuZaqi8d3EEivdTdsEj3N?=
 =?us-ascii?Q?WFItmM3VA12TbaOQqKjereIftvgZDArpQHsX5VUidYc2hIpEKms6HaTBI9gv?=
 =?us-ascii?Q?8jO62dRmj3z7M0o4L21BAaFIHixdNB5KD5fxytdCmUErg4pyfYDlezCZapD+?=
 =?us-ascii?Q?eOyt80DKbzpU/qT+dj5B9VEfXqoG9Co7EHttklCKeHyHGklD4sWadOW0e9HW?=
 =?us-ascii?Q?54/yogEO0SHHFUTxjvrOAfmvDsGCY7Ejp+1SpNjVjwvXQKuLF9s8s5OeF60v?=
 =?us-ascii?Q?BZA79w9eCqRNVScx+LD48xAhz7siXM3mNdFD/UVsUia5MGqTwv7M0vouynf5?=
 =?us-ascii?Q?CssHTbc1eNZD6iXItEwalTaiiw4jqn2Rvf5GHtikZoQ00en2ci5Kkr5907kR?=
 =?us-ascii?Q?ng73J72bObFWYAoVSrNHbUmBMpebnd9CQgs86vtV0Vk04KbA4/FjgejOqi+i?=
 =?us-ascii?Q?sjhv4E4qTXjEQMhjLALqLbnggpqUP+WrMEX4KPTUPG2+yZMN5/5S3CW/EpcW?=
 =?us-ascii?Q?NDkuNsdJ4g2oXWBJIj2CKNP9PCRCuoYAFSm6KKD6sWqGXjJphimlQefPTXey?=
 =?us-ascii?Q?yhZxXN3Ve843VREPlN3DCVphKB7Iy/4K8B/7yt+NbPZlG4ivowdAWirJA5/z?=
 =?us-ascii?Q?+izqVVC0A6egc5turiaRFUXM2unQgZPgVUx4HZ8f1FdWRhl1xpOPwXRWut4u?=
 =?us-ascii?Q?Ou2r6YtiwVqjGEmjmwq4js12lRnkTVsR72IQUXxoKIBEPKjg7R1UczpcLx4F?=
 =?us-ascii?Q?iYxSlQvtqzKsnYJx24E3mhTkavLedVbS85AMeude5Q06/Obj4KGSicF+jxHT?=
 =?us-ascii?Q?gdTOER4iO5YRMtzLzv9tpSB/0txPhVlpJRmYVX6MP2D/N4jDQ0YcFp8Mt2YB?=
 =?us-ascii?Q?o2jn6+wWxrVtZRGXLSG3gPGGZRR+yf3jqYySeeB1SF6os4lfG116876UBfc3?=
 =?us-ascii?Q?MbaXOcNnxCxpJfihUsrk4E4NOHrnkWhXIRR0HOn4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e890375f-5f44-472a-3e64-08dc454d2b4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2024 00:08:12.0738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: za/QgiBf+LY961QCbOGhsrSeQADDqg9Bdl2RVxC9spJiBb/nNt0zYuzeTwERpyQZmA6lT5XHDscrHoUHz8PTIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6506
X-OriginatorOrg: intel.com

> Why? Making mon_data_bits::u larger in the way it has been done does not
> have any dependency on 32 or 64 builds unless I'm missing something.

That union is copied into the kernfs_node "priv" pointer field. So it has
to fit into whatever size the system is using as a pointer:

See:
	mkdir_mondata_subdir()
		->mon_addfile()

> Caring about 32biit resctrl on x86 is a pointless exercise.

Agree 100%

-Tony

