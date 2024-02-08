Return-Path: <linux-kernel+bounces-58621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA3B84E8EE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE62A1F30983
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE23376FA;
	Thu,  8 Feb 2024 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2bdldpr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD57374FF;
	Thu,  8 Feb 2024 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420447; cv=fail; b=oRMMT/WWuiBpfJIrbP6yiTqUIqawL+H8eQWAJEwVJp/xTSK5bCpkJiRmMEGLOt6qCY701cmyMgT2IoFxyJvXagY5pgQxw/XkUctD6JWAEv64mvIBNmuEiJhoGJbiP1z977EO82YvyCbIKAtFsiPKNxwd7wl2aPv2lbDcwFiiuw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420447; c=relaxed/simple;
	bh=EV52+tHzxG5e6WI1AxNJXHAVvWcTCwEa9dA8nxAndnI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O+lcIUxtEaCKWXxv8cjUW4pZfjgRQE7tHDm8d4h8Dk8VpfTqaHpNPdLm98lHotgaqV0nNODIFDb/azoLmOU4PmmsH1LyhfB7U/hlxx7z5AhvIozd+lo05HyjJKCfRxPIskw7Go5PlDtwfuixMzhVwOxoTfF5NlgOeTMUSeki5C0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2bdldpr; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707420446; x=1738956446;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EV52+tHzxG5e6WI1AxNJXHAVvWcTCwEa9dA8nxAndnI=;
  b=d2bdldprLDp1pBaZC+J7vZQafN12gdb8dALAN6n990xTJDwzwKzIGaTV
   DwZQloRYMHARv4cs3x4xy6o7d6voaWfwWSAbpu47XX/i+dJ1cwM2FQIrF
   FFSXC+QW7RzQfasFHsHhRTp0+7+8RPzL/BO5lSzHTOnJSaOfJKUl9M5dZ
   ym+pMnVY1zrGQirPP2xIWOo9/JkampnqZes8X5J+sM3Sg1H354Dw07oQ3
   XxOn1luRBdlSEF7AoHDNclMue9AtxXCJQx9ZZRJ6a9JbpGr142NkFOwEP
   Xth+HMr1YuPQ7wBIbhhLFsQblz8iEOYZbM4Gqkmlsu1NUn3ACWc7jZQ28
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1156997"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1156997"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 11:27:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="2113808"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 11:27:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 11:27:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 11:27:23 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 11:26:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2GtD6ld8Sn7KVIA+4/QcZQ396dJqe0DkbvMQsSuJJW2aaaILDMR+pFhWsx1gn3P8Dab15cNheT3Ax2Z6TLp+6EwP9Tq0FwEKFoMEPJl7z6I068vN+jSDt1aNS7l3kR71+RuNcnfopUb7SvB1TqvvQd7vXO443U9uXAlN7PNZoCAAq+BWJ9kFR8f24SqyUk74O1SIF0PocNZRi5V33shcDMa6JSzzv2MrSBvIga4n6aaalJh9WeLV4I8FFmtAm2niin2j0TBvSNRcApigk+gSgBH94ZdFAs5N3k+Ls+QDWCyxU2b+xNXC7W+BULVvWmnVcXXggfI0eks1Ws2lofFwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EV52+tHzxG5e6WI1AxNJXHAVvWcTCwEa9dA8nxAndnI=;
 b=lzML5ININyXQlPZXQBJy9cD7Q42mXDxDRR/IuYozYUnPQ9gvlQDce3pBSmS9L1PVWrAjHZGS0+3GwAihFUQklnDU7d2zK58UetJZ5qFq7qQXCYs+WWBf0KXFJ4fO9cRQAs4aSsYXC2C54yMR4XPeuVsgeuI4wRQAYjl8eYbIqU5gTtMunCXYgkX2GPQ0VXlptm10xVRF+TNW/XcyIvLfQf/RX/D7koGNaWxopvA/UwD01NHgo+MRi9nPu1dAaLjyHZAsBP+2KYije46ZXINYAMHgdhjRAJLxNtoGba6GJJ7/Yn3L0Ot4OTii9JvPcC/NtSM8tKVrb9X9mMd11piuAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MN0PR11MB6184.namprd11.prod.outlook.com (2603:10b6:208:3c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 19:26:53 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802%3]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 19:26:52 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Drew Fustini <drew@pdp7.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, Peter Newman <peternewman@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	"x86@kernel.org" <x86@kernel.org>, Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, "Babu
 Moger" <babu.moger@amd.com>, Randy Dunlap <rdunlap@infradead.org>, "Drew
 Fustini" <dfustini@baylibre.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v15-RFC 0/8] Add support for Sub-NUMA cluster (SNC)
 systems
Thread-Topic: [PATCH v15-RFC 0/8] Add support for Sub-NUMA cluster (SNC)
 systems
Thread-Index: AQHaU8qTZyE779HfV0Os6ryGu61IgLD/49uAgAD7e5A=
Date: Thu, 8 Feb 2024 19:26:52 +0000
Message-ID: <SJ1PR11MB60839BA8E721970C34C1F3B8FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com> <ZcRVZYtmFMz0fdjU@x1>
In-Reply-To: <ZcRVZYtmFMz0fdjU@x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MN0PR11MB6184:EE_
x-ms-office365-filtering-correlation-id: a44547eb-78ca-4ea4-850f-08dc28dbe76b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6VvWkXVYaOoYsFemlt0MpXysTr+97VwEkWwfzSN1jbyE89VrsxfYsPwYUS83PyiPN/SlY4DXkLQumSW8p9ql/kjhlMUVQBHC4/kaj6W8GxHVfOu7ZoMDWyFb9++E0M7nSBshRGWS/qSGxcKen6nTuxup4socxF8GVMCTVyQhSAKMIOTyTLWL0qRuvl/DYpITV8IEL6lxSxNLs1Al1AwSd7k9YhqOkFTQIyMzdng/qKogV8sQBymuhxkRi63wYv7p+iIkMVE0iRxJOImB0lq1ruAXEWQ9IG5vewRDy68XfaI78lQNzcrqsWghrwaVV3080WXNPFo02fRh0uWJlxGwTH10b2KQWbBlniDs7+iLIwDhLcFU70RemEC19XqLosHktNVeGzSfH/q3q4MCh9oYdOtpz1rnLR/s94fH7BP25el8u7Kwxm2EOUrxfNhOaNL33m9zOXeQwqkVIWACxeJbClsTxBzMK38c6/bLMQQtXQ/XhSA4DP6a1oy32Vw3+XpNaqI0jTLI/xlsZg8Ma4VhUoofgsK/amBZKYSw4k4n+xeBlEMp3bGTxl9ra2l76ohtIVE5ReUfJ+fUAW2hKGD4b24t6oOIlVeBpZMgiOxgxuWIpW20VcZC2eMA4gzwC0Ue
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(55016003)(2906002)(5660300002)(7416002)(41300700001)(26005)(86362001)(122000001)(7696005)(8936002)(6916009)(6506007)(54906003)(33656002)(4326008)(478600001)(316002)(71200400001)(38100700002)(66476007)(9686003)(82960400001)(66946007)(64756008)(66556008)(38070700009)(52536014)(8676002)(76116006)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UuCELH9hg2QH+qvcoEFlZC5Hgox3F7Ifv3xTVFqFVDBJrvpc6dZ13E4POLwe?=
 =?us-ascii?Q?n1pMAevDt8ReBIJW06Molio85g/uj5VJcPu4E0KzzsayLXWalAX54a1gdb0c?=
 =?us-ascii?Q?uNdXes09dbdtIMCcXMPLi/8mR2pV55bvpwWdBt0m6tqClBwiRvknqBQ2w04P?=
 =?us-ascii?Q?20pQt8Wx2PK02XLu1zWD3Pjxkc+JE+AejYW5FEWxmW7e+6OsXbgMLLSED2Ao?=
 =?us-ascii?Q?BCpMXgNphHyFABKrtma32Y4nZb6Xl+LoZE10ySbFIEPDPIfiTddWIOvACG7d?=
 =?us-ascii?Q?4+4DD3Z4l08KERxU5ZRWrPAZNkq4CF1/l1obpYPPakZmFpdrZQVXZECIqpIj?=
 =?us-ascii?Q?UtvaVC6bclu4F3mTcdtt4gAtYNvhCtTH65H8yjnW1KWGoYzQzXC4xDx9mpLO?=
 =?us-ascii?Q?IKpgiaIyPZ+iHPx7lM/xEohc0EmtHGlNm6z/8V1lfxNZHmtUDNzDMoLYzxZN?=
 =?us-ascii?Q?+Szn5kFKSFmWv9TtaNkLDqFJEvVUFkXR84ZiOvenWADivUR3VOnsEl8YFVYg?=
 =?us-ascii?Q?21zoIlN0ENM7P0qmdZwP29bZKHFpjBCAXNX5is4E3rSl+xVX1Ldg83Ypwn4+?=
 =?us-ascii?Q?4iZI83s+OECIQ1srr8+DThzEq6fFKMU1QrGMr1bJVPSfLu5NrgdoZCXIA1jn?=
 =?us-ascii?Q?iDTJ/9LnTcy8bpLQvkD2bb0Rz88wLC6vmVM7KVyO6BiiEd3hriRgszFAQly6?=
 =?us-ascii?Q?s/207+mWbdt8FxncCmnGZ7TqkxvrmSUDuqpHu8la7bEoRJ6kBqQDNB7/YdqI?=
 =?us-ascii?Q?q4xUcBTrtMTjL1L/mLWA7iVq+Sk+2hDp+nLjWJkI8X//NNV2OfOyvoCf7RHL?=
 =?us-ascii?Q?LNrivr47Qw073XMfwcjX5HuDynoHH0eoG99p2KN/WuRGCMmhauYOgnodzqts?=
 =?us-ascii?Q?NnBFex57fI18GsMySjr5Csuk2E+pNPuUKMJ0wBh40Z2HzJ+bQXlxoYFPRCqY?=
 =?us-ascii?Q?SHhSiKo2YzOES5H0mPzcmg3JXcy22sNK/uOFrAQpQmvXOKNYJ4AJkvx0uUld?=
 =?us-ascii?Q?R/d+2Z+05GRUi9UQwk5H5FgSjad8TgoLdPai7ruUvbd+lvO1Ct7VHRq8puZK?=
 =?us-ascii?Q?QevgGEBCvgYv/KudeT51bthjqL7K9wd4M1LYsoBw2z10Mu7KLG3PHSbu7bkK?=
 =?us-ascii?Q?2Ec9O3h11EIeZxpXokO9FHEtrkB9jxHzFuCIaQUOTmTFJlt7dYDgiOnu25L/?=
 =?us-ascii?Q?pBX2HhHymexNCsMrTRHhbErg6B8SP3dZCRFRTwSfbhzpXnwrKDc5QtbijiXj?=
 =?us-ascii?Q?mjVBZpvziOvoTo6k+XBWgtg/t8E83HE+mFVpmOdLWYS+Sbw1M3D227uAvGlC?=
 =?us-ascii?Q?WOZhwkS4VrvCyfrGeU54d9Kp91Xme+dI+04bnOPlbZlYdT1+X/QlsPXoNuNU?=
 =?us-ascii?Q?JpX32fUT5H2UPrt11N+D/V1+uEwZXJ/4FdvUHov6deseihlZ4rEHLP/ya48D?=
 =?us-ascii?Q?lpeNZHNC1CEllYV2tmlx4CoejfHxkMfIbD+HeI0QcdQpOnvwljhfdM/9gnNA?=
 =?us-ascii?Q?UYBOgRxfXOmW56t4n2n2heIGZ3ce2z/x1g7ckAIoRQ2DyJJuo97EfSUc0T9f?=
 =?us-ascii?Q?NROeZbdXC5qkwLw4KaA/yLyn+qXBTqnZDGVc/Ly1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a44547eb-78ca-4ea4-850f-08dc28dbe76b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 19:26:52.4939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 65J5l4r6zPAra6Vg7NDnGPWSxgPi5C0LVShFsVv3GJ6PuobHx+aRq1oTZVfUjVSNF6UxtzUvj151lY6tHgnlaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6184
X-OriginatorOrg: intel.com

> > Patches 1-5 are almost completely rewritten based around the new
> > idea to give CMT and MBM their own "resource" instead of sharing
> > one with L3 CAT. This removes the need for separate domain lists,
> > and thus most of the churn of the previous version of this series.
>
> Very interesting. Do you think I would be able to create MBM files for
> each memory controller without creating pointless L3 domains that show
> up in schemata?

Entries only show up in the schemata file for resources that are "alloc_cap=
able".
So you should be able to make as many rdt_hw_resource structures as you
need that are "mon_capable", but not "alloc_capable" ... though making more
than one such resource may explore untested areas of the code since there
has historically only been one mon_capable resource. It looks like the reso=
urce
id from the "rid" field is passed through to the "show" functions for MBM a=
nd CQM.

This patch series splits the one resource that is marked as both mon_capabl=
e
and alloc_capable into two. Maybe that's a useful cleanup, but maybe not a
requirement for what you need.

-Tony

