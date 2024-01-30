Return-Path: <linux-kernel+bounces-45481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E0F843148
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB661C2333C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BEE79949;
	Tue, 30 Jan 2024 23:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iG2O59E7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B367EF1F;
	Tue, 30 Jan 2024 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706657458; cv=fail; b=lUf6ZsgYsv8RtK8yXT3FFOfHMxe8gy5CwEUjDwCG1Oj94ZqFfwJO7gDQPkVBFfuMDXp25AuOAPr1z5CaNeyOGanSTyTl95tdoiW3ObGWv2Q1i3Ye8kpXd+eqGUlc3Ik46UVrnbAEIV4eh7ZbNcLw0nb1N0d7P5h3zZVtKA7SfNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706657458; c=relaxed/simple;
	bh=bzUtrIO2PAycf7IrGf/5iR/bRt77lcyfavOKFb7wi5Q=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=I3WQh4du2chW9LieP9wleTZ+oh7Vu5F4qa0hJPJ+BS+36WAutuXMy1srRfdqlKYRq8kVNZlgoeP3CgNrhB1jBdl0imTWjspKq/V/UdeH5Q/1fn3WUMuC7dqBCgDEGnjiFxGOwayfHpUw+XcqtwOHshXz8NlF56voiNveyz0Nrf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iG2O59E7; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706657456; x=1738193456;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=bzUtrIO2PAycf7IrGf/5iR/bRt77lcyfavOKFb7wi5Q=;
  b=iG2O59E7SfJz+IgQ46BAI+69zwJjv+W8qVjsPwzqGvYonJsKc2+WjgfK
   TIUgUd+2gjkvac2cvaWruBPUHJM7Dvq4JURvZguZ0vPD+Fr+yxBDmXeY3
   WjsEd/o7rEDctsZQ6wOlf9bIs5BKYL4UIgSTY6jRVCPzJzm3VsiJo+4UH
   isFQJOI+W9xok7yGJu+sWcKZ5UHucu2Wokeya2Dtb4Zd9GOyD2cyBWHsa
   kcZYnJiB59Q7wwQBSZg5uLVnAYLbp6TaNvheHVmP89kIQXf4xkf/siTuM
   UqTJ4GUXic7zU4bMiNu3Yud/8OPOrqrDJcaJxL6yqaEJuC10G2TNXUegK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10810327"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="10810327"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 15:30:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="3884866"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 15:30:53 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 15:30:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 15:30:51 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 15:30:51 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 15:30:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5uoMpfZpVyKj6rTzPNDobs43Lf9bpONeJt2rr5ZICjmVGekbcFpUUzT11TIHrihJu5A7rBB8/+uiikZa90/fL/59WaqOdSwyGI2jiC84LCxrpXUkTg/MFRpW0nTspycWu/riTu2y11Bj8RkljZwgTMhGcAQO/nS/msnvQtpQdj4LqahBIL5dR4o1GA4Nng1xI4pHZfQeqsZlvjFSsjkalqmnLvN46X77ffUlpqSZ5n/hlaHM0ZKnSjyee1OLgfU/4AoIQ65yykBsjNhpHsPc/Keomg3mrFH1rZNY+JECrNJWuZnJN844WKibhlycdotzv/jEQu9En7G43JQp88UKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ryqh5Cd445kh4HVkWzxeABM+/cJzY+RQ8EpiNjJ8K9I=;
 b=dtUWWM95vUJhbiBEzOENgFkG7o22fyN0cZIKFaJu6ZBucWn7hodoQrwn5nGUdy2JmcSqIuo/K7Xsr93wkzkP9SuJEysf692KjU8aQ7CnHaZdng8Cs1fD50k9XpEs6aLbXQhFGyK+ywUbW7C+kXc/SRwjhaRwr6MR1aD3sW98aB18QPGfdc8pArABzChWwJRnpvovJpEcsZTYct9C9BM4JblxwYJwpKn82CVzbRA3joG7SgP4+MGbX+FW9damZzRjx+MiU8RabFOKy/kX/H9R7NiKqy/fXDDGSVzFvdK1O4N/B314R1rrUGxa4Kj69khIh2F71vnCK0kqBT9ylE2LjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV8PR11MB8463.namprd11.prod.outlook.com (2603:10b6:408:1ed::6)
 by DM6PR11MB4689.namprd11.prod.outlook.com (2603:10b6:5:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 30 Jan
 2024 23:30:47 +0000
Received: from LV8PR11MB8463.namprd11.prod.outlook.com
 ([fe80::5262:6eb1:2787:8cb9]) by LV8PR11MB8463.namprd11.prod.outlook.com
 ([fe80::5262:6eb1:2787:8cb9%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 23:30:47 +0000
From: "Corona, Ernesto" <ernesto.corona@intel.com>
To: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
CC: "Corona, Ernesto" <ernesto.corona@intel.com>, "'oleksandrs@mellanox.com'"
	<oleksandrs@mellanox.com>, "Castro, Omar Eduardo"
	<omar.eduardo.castro@intel.com>, "'omar.eduardo.castro@linux.intel.com'"
	<omar.eduardo.castro@linux.intel.com>, "'arnd@arndb.de'" <arnd@arndb.de>,
	"'corbet@lwn.net'" <corbet@lwn.net>, "'arnd@arndb.de'" <arnd@arndb.de>,
	"'mchehab+samsung@kernel.org'" <mchehab+samsung@kernel.org>,
	"'linus.walleij@linaro.org'" <linus.walleij@linaro.org>,
	"'manivannan.sadhasivam@linaro.org'" <manivannan.sadhasivam@linaro.org>,
	"'jhugo@codeaurora.org'" <jhugo@codeaurora.org>, "Filary, Steven A"
	<steven.a.filary@intel.com>, "'jiri@nvidia.com'" <jiri@nvidia.com>,
	"'vadimp@mellanox.com'" <vadimp@mellanox.com>, "'amithash@fb.com'"
	<amithash@fb.com>, "'patrickw3@fb.com'" <patrickw3@fb.com>, "Chen, Luke"
	<luke_chen@aspeedtech.com>, "'billy_tsai@aspeedtech.com'"
	<billy_tsai@aspeedtech.com>, "'rgrs@protonmail.com'" <rgrs@protonmail.com>
Subject: [PATCH 30 4/7] Add ABI documentation
Thread-Topic: [PATCH 30 4/7] Add ABI documentation
Thread-Index: AdpTxfhfBw4DJ+euSnqm7SdimEhg1A==
Date: Tue, 30 Jan 2024 23:30:47 +0000
Message-ID: <LV8PR11MB8463E4402495BACB9E3ACE588B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8463:EE_|DM6PR11MB4689:EE_
x-ms-office365-filtering-correlation-id: e6128001-91fd-49b7-09b7-08dc21eb7ced
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cwKg6jIRInppqHwRlKTOcMU2VWSCa9cpwI1xFP7Rg8oiI0eS5zsmvsipTeUujEFKjRsCxTZIFgl3iU/2uZcztZAbg63uWJ67nMd/QSjbKVijJSs9K0R/2jC7o7ODWz1SaCpJV1arwNhDhTljS1SjW/th4iFvc1vfkz3qZUxs//TS2IHkZJ2MZBKdfQWOaCwfRAJH0MshM11Zdu49ZVfbqr9fAWmYp1+E6HTZqXvBC234nRXPrttd6DSGQpb0Gv0ah0cCKJ3E9vG4e6mo2IVyXGM16hzJhp6zNS46gYSgN6lx4KIIIE9QeL+WmQyDigQ+Gdglr+29wkbX9j7FHUDZ8X0K8wS2z18bCzas0/OpxjBS8LG0jr56TZMfa+UnaaThVyrZjvGUUcXVfMEMgTcyINvOaFchc9c9JNOC7v+FUZ0/mVWAG7xNMO1mo9bpLTHPr5n9yxG5qg3B5Xndnt/QnXVgFKgQESoBKELXl0vFhFyS52wsh2qhsu3Hov/VZiS8AKNMUfJiae/Nnp6AIEdyplRilwfwoHfFThvpGM5gWQrCk453XVIMXPP2c311hO+LZRtEomTeY1S0netp9Czm51R38mSGNsjXK1S55Ohy5+LWgRCy2zfx6M+ak71Imd0K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8463.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(9686003)(38100700002)(26005)(30864003)(122000001)(8676002)(52536014)(8936002)(4326008)(7416002)(478600001)(76116006)(7696005)(64756008)(54906003)(6506007)(2906002)(5660300002)(66556008)(66476007)(71200400001)(66946007)(66446008)(110136005)(41300700001)(316002)(38070700009)(82960400001)(86362001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z/GOd4SfTjjVkj3/MpEDzHMjw9BKCUgHxOXIHrEY0HyCObzZeurNWAtt+Ytb?=
 =?us-ascii?Q?DCeGsjx+BomlNCVtU9Z5eJWEgRKleJcxPLQMGstUGbd973+0i0ApB3owvasp?=
 =?us-ascii?Q?X67WWjJdcXHsP0Ll4h30mTVPDFO2oUjIUuGCpQgl+l4kPIZCJGOv1ZExqvim?=
 =?us-ascii?Q?KGt+hK2PVBz67DPp6HVQNKuf6s/UlVymGa8DEGPLifCTIqnMRpPreKHyKnrL?=
 =?us-ascii?Q?s59iZAKI8L7GMSXm9lHIWkSWi3ZpvVj8DLctcjtbvNQrvWXR4Q+NeRVPjtm9?=
 =?us-ascii?Q?V2sgC3cbRAf+YcwECX0TGmQTKoKJ28ppe4u/nsmK/6rLbZaUL5Qz/1xEQfUc?=
 =?us-ascii?Q?DJb4jbCuFtBOPYVy0JDh7jDuVhyM4zgE+/HX39spu83CUlZuNpD7fhcYn/jA?=
 =?us-ascii?Q?O8QPSMLuQfDVm6zuSh/6NvpuoWHIKzFuzu7U8I8d3SNypY51FRSezOLsiipC?=
 =?us-ascii?Q?hWYM0ahJZYD31TEw5gVpF+N6gLtpI8XsaIBK0VVEq5n5mWhofV29qDod+kmU?=
 =?us-ascii?Q?WQIIE0ITy+SJNp3v14n2VJKikQArNF3YaN98u/05x44/1Ee6n4lHz54Xw/sP?=
 =?us-ascii?Q?9cPX+SCb7Jv97Q0ZNYG29FLp8PEvW8XQCd1dgZ7KdCCHMZ9uz1UzuvexRDCw?=
 =?us-ascii?Q?dKRoTxkrt4fbjFn+u0Rq+Kb0Y99sjWivlA4BuMYcGktxXahTvMnfcTeLEe6w?=
 =?us-ascii?Q?Z3UVeCvdz/K55yUSpPg4OTXXpRK7cGKWf5eCiiNBcYZSDatSyfrUI2B8VyP9?=
 =?us-ascii?Q?pw6bhhmFAUpUNV+ZIG2Ui/qV+PekeiTHwxeJHlGYuCop9EjedKwNcXgT7Jvt?=
 =?us-ascii?Q?ACzx6jApQwXs0yoAkkNHUp0y0jY2fVw46Kr+cRjHidreP9OPiG7Sn4si1E6E?=
 =?us-ascii?Q?KVmzSVE7oiIMmmxSilb9KXPP2j091L0NLlXmo5j2eFpyh60QZ5KbJknw9kYv?=
 =?us-ascii?Q?A0waAtspkVE2HID6P9LJryA3oIuXAmSNS8aoXYsdMYSajv8yU1LWl8yJ87+8?=
 =?us-ascii?Q?QI5bcn5rxDiJlVtXilZGW6a/nPrQFQFFem58Tmgl3/DDqICuP0TEM6+z1fbG?=
 =?us-ascii?Q?FYlJ+8OywefwkPl2GG9IaUyvU4vDxPgwpJ3i3myB/TBD/c6qcohe1CW4BeVk?=
 =?us-ascii?Q?PYCFFVBPiHpVqY7cVxkOtXIbTwYR1zSBTPBFT4ZnuLT338ynP4mZb3YxASsb?=
 =?us-ascii?Q?dQ7fhFR+FGsn2FWRpIIPIE2w4Jdlm+bZUgWHCLOfEanAuElNgRfmXeXZj2BZ?=
 =?us-ascii?Q?z51aNYphBGcpUcxU2hIx8uMEWKuoHGqYPCwG6HKH6HV8qnKQEQgm4OYe/iYe?=
 =?us-ascii?Q?2F4/MVkTJCBcxk8YZrSlcJMHf+lzUc6YI+WVtlUJwbMMEp03EhEXF+7Mmkyw?=
 =?us-ascii?Q?QQGUOfnijtnyJm1OR1JEOueBxagj7pXaQ+z30ghCmkhDDGPo7Qe7W6xK4blM?=
 =?us-ascii?Q?dJk6oj8iN3TW++62eQaRrM14AldPX/Sr0YDF8nZI/luGDYYchn/MglZQzy0b?=
 =?us-ascii?Q?cYoe1tuRObK3doeG6GTABMa/on/dZKhq+uzAX8h4Tjc/4IO+WvT9nN62shk2?=
 =?us-ascii?Q?bw3G07aEa7HRUi50IIfhcdsbLay8orQLsK1ex1sJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8463.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6128001-91fd-49b7-09b7-08dc21eb7ced
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 23:30:47.6137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U07cvQ0TA1L18fYb/XLWG8nIXBHE6kvlkAWm6w4ceou5epgAEyefziNuCNQIY77caqd7UI9GkkYB4fnWS5qwjKDyQbZRKFQXKfCBKHBr/Ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4689
X-OriginatorOrg: intel.com

Added document that describe the ABI for JTAG class driver

Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
Signed-off-by: Ernesto Corona <ernesto.corona@intel.com>
Signed-off-by: Omar Castro <omar.eduardo.castro@linux.intel.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Steven Filary <steven.a.filary@intel.com>
Cc: Jiri Pirko <jiri@nvidia.com>
Cc: Vadim Pasternak <vadimp@mellanox.com>
Cc: Amithash Prasad <amithash@fb.com>
Cc: Patrick Williams <patrickw3@fb.com>
Cc: Luke Chen <luke_chen@aspeedtech.com>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Rgrs <rgrs@protonmail.com>
---
v29->v30
- Change ABI documentation to reStructuredText (rst) format.
Comments pointed by Paul Fertser
- SRST added to documentation.
- Remove call flow as it was confusing.
- Replaced unsiged int for signed int on file descriptors.
- Specify frq for SIOCFREQ and GIOCFREQ in Hertz.
- Remvoed usleep that was not used on examples.
- Documented padding.

v28->v29
Comments pointed by Steven Filary <steven.a.filary@intel.com>
- Expand bitbang function to accept multiples bitbang operations within
  a single JTAG_IOCBITBANG call. It will receive a buffer with TDI and
  TMS values and it is expected that driver fills TDO fields with its
  corresponding output value for every transaction.

v27->v28
Comments pointed by Steven Filary <steven.a.filary@intel.com>
- Replace JTAG_IOCRUNTEST with JTAG_SIOCSTATE adding support for all
  TAPC end states in SW mode using a lookup table to navigate across
  states.
- Add support for simultaneous READ/WRITE
transfers(JTAG_READ_WRITE_XFER).
- Support for switching JTAG controller mode between target and host
  controller mode.
- Setup JTAG controller mode to host controller only when the driver
  is opened, letting other HW to own the JTAG bus when it isn't in use.
- Include JTAG bit bang IOCTL for low level JTAG control usage
  (JTAG_IOCBITBANG).

v26->v27
v25->v26
Comments pointed by Randy Dunlap <rdunlap@infradead.org>
- fix spell in ABI documentation

v24->v25
Comments pointed by Greg KH <gregkh@linuxfoundation.org>
- Fixed documentation according to new open() behavior

v23->v24
v22->v23
Comments pointed by Randy Dunlap <rdunlap@infradead.org>
- fix spell in ABI doccumentation

v21->v22
Comments pointed by Randy Dunlap <rdunlap@infradead.org>
- fix spell in ABI doccumentation

v20->v21
Comments pointed by Randy Dunlap <rdunlap@infradead.org>
- Fix JTAG dirver help in Kconfig

v19->v20
Comments pointed by Randy Dunlap <rdunlap@infradead.org>
- Fix JTAG doccumentation

v18->v19
Pavel Machek <pavel@ucw.cz>
- Added JTAG doccumentation to Documentation/jtag

v17->v18
v16->v17
v15->v16
v14->v15
v13->v14
v12->v13
v11->v12 Tobias Klauser <tklauser@distanz.ch>
Comments pointed by
- rename /Documentation/ABI/testing/jatg-dev -> jtag-dev
- Typo: s/interfase/interface
v10->v11
v9->v10
Changes added by Oleksandr:
- change jtag-cdev to jtag-dev in documentation
- update KernelVersion and Date in jtag-dev documentation;
v8->v9
v7->v8
v6->v7
Comments pointed by Pavel Machek <pavel@ucw.cz>
- Added jtag-cdev documentation to Documentation/ABI/testing folder
---
 Documentation/ABI/testing/jtag-dev  |  23 +++
 Documentation/jtag/index.rst        |  18 +++
 Documentation/jtag/jtag-summary.rst |  49 ++++++
 Documentation/jtag/jtagdev.rst      | 222 ++++++++++++++++++++++++++++
 4 files changed, 312 insertions(+)
 create mode 100644 Documentation/ABI/testing/jtag-dev
 create mode 100644 Documentation/jtag/index.rst
 create mode 100644 Documentation/jtag/jtag-summary.rst
 create mode 100644 Documentation/jtag/jtagdev.rst

diff --git a/Documentation/ABI/testing/jtag-dev b/Documentation/ABI/testing=
/jtag-dev
new file mode 100644
index 000000000000..93821506d70e
--- /dev/null
+++ b/Documentation/ABI/testing/jtag-dev
@@ -0,0 +1,23 @@
+What:		/dev/jtag[0-9]+
+Date:		July 2018
+KernelVersion:	4.20
+Contact:	oleksandrs@mellanox.com
+Description:
+		The misc device files /dev/jtag* are the interface
+		between JTAG controller interface and userspace.
+
+		The ioctl(2)-based ABI is defined and documented in
+		[include/uapi]<linux/jtag.h>.
+
+		The following file operations are supported:
+
+		open(2)
+		Opens and allocates file descriptor.
+
+		ioctl(2)
+		Initiate various actions.
+		See the inline documentation in [include/uapi]<linux/jtag.h>
+		for descriptions of all ioctls.
+
+Users:
+		userspace tools which wants to access to JTAG bus
diff --git a/Documentation/jtag/index.rst b/Documentation/jtag/index.rst
new file mode 100644
index 000000000000..8a2761d1c17e
--- /dev/null
+++ b/Documentation/jtag/index.rst
@@ -0,0 +1,18 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+Joint Test Action Group (JTAG)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+
+.. toctree::
+   :maxdepth: 1
+
+   jtag-summary
+   jtagdev
+
+.. only::  subproject and html
+
+   Indices
+   =3D=3D=3D=3D=3D=3D=3D
+
+   * :ref:`genindex`
diff --git a/Documentation/jtag/jtag-summary.rst b/Documentation/jtag/jtag-=
summary.rst
new file mode 100644
index 000000000000..07cfa7a761d7
--- /dev/null
+++ b/Documentation/jtag/jtag-summary.rst
@@ -0,0 +1,49 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Linux kernel JTAG support
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Introduction to JTAG
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+JTAG is an industry standard for verifying hardware. JTAG provides access =
to
+many logic signals of a complex integrated circuit, including the device p=
ins.
+
+A JTAG interface is a special interface added to a chip.
+Depending on the version of JTAG, two, four, or five pins are added.
+
+The connector pins are:
+ * TDI (Test Data In)
+ * TDO (Test Data Out)
+ * TCK (Test Clock)
+ * TMS (Test Mode Select)
+ * TRST (Test Reset) optional
+
+JTAG interface is designed to have two parts - basic core driver and
+hardware specific driver. The basic driver introduces a general interface
+which is not dependent of specific hardware. It provides communication
+between user space and hardware specific driver.
+Each JTAG device is represented as a char device from (jtag0, jtag1, ...).
+Access to a JTAG device is performed through IOCTL calls.
+
+Call flow example:
+::
+
+	User: open  -> /dev/jatgX -> JTAG core driver -> JTAG hardware specific d=
river
+	User: ioctl -> /dev/jtagX -> JTAG core driver -> JTAG hardware specific d=
river
+	User: close -> /dev/jatgX -> JTAG core driver -> JTAG hardware specific d=
river
+
+
+THANKS TO
+---------
+Contributors to Linux-JTAG discussions include (in alphabetical order,
+by last name):
+
+- Omar Castro
+- Ernesto Corona
+- Steven Filary
+- Vadim Pasternak
+- Jiri Pirko
+- Oleksandr Shamray
+- Billy Tsai
\ No newline at end of file
diff --git a/Documentation/jtag/jtagdev.rst b/Documentation/jtag/jtagdev.rs=
t
new file mode 100644
index 000000000000..883df46ec117
--- /dev/null
+++ b/Documentation/jtag/jtagdev.rst
@@ -0,0 +1,222 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+JTAG userspace API
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+JTAG controller devices can be accessed through a character misc-device.
+
+Each JTAG controller interface can be accessed by using /dev/jtagN.
+
+JTAG system calls set:
+ * SIR (Scan Instruction Register, IEEE 1149.1 Instruction Register scan);
+ * SDR (Scan Data Register, IEEE 1149.1 Data Register scan);
+ * RUNTEST (Forces the IEEE 1149.1 bus to a run state for a specified numb=
er of clocks.
+
+open(), close()
+---------------
+Open/Close  device:
+::
+
+	jtag_fd =3D open("/dev/jtag0", O_RDWR);
+	close(jtag_fd);
+
+ioctl()
+-------
+All access operations to JTAG devices are performed through ioctl interfac=
e.
+The IOCTL interface supports these requests:
+::
+
+	JTAG_SIOCSTATE - Force JTAG state machine to go into a TAPC state
+	JTAG_SIOCFREQ - Set JTAG TCK frequency
+	JTAG_GIOCFREQ - Get JTAG TCK frequency
+	JTAG_IOCXFER - send/receive JTAG data Xfer
+	JTAG_GIOCSTATUS - get current JTAG TAP state
+	JTAG_SIOCMODE - set JTAG mode flags.
+	JTAG_IOCBITBANG - JTAG bitbang low level control.
+	JTAG_SIOCTRST - Set TRST pin for JTAG.
+
+JTAG_SIOCFREQ
+~~~~~~~~~~~~~
+Set JTAG clock speed:
+::
+
+	unsigned int jtag_fd;
+	ioctl(jtag_fd, JTAG_SIOCFREQ, &frq);
+
+JTAG_GIOCFREQ
+~~~~~~~~~~~~~
+Get JTAG clock speed:
+::
+
+	unsigned int jtag_fd;
+	ioctl(jtag_fd, JTAG_GIOCFREQ, &frq);
+
+JTAG_SIOCSTATE
+~~~~~~~~~~~~~~
+Force JTAG state machine to go into a TAPC state
+::
+
+	struct jtag_tap_state {
+		__u8	reset;
+		__u8	from;
+		__u8	endstate;
+		__u32	tck;
+	};
+
+reset: one of below options
+::
+
+	JTAG_NO_RESET - go through selected endstate from current state
+	JTAG_FORCE_RESET - go through TEST_LOGIC/RESET state before selected ends=
tate
+
+endstate: any state listed in jtag_tapstate enum
+::
+
+	enum jtag_tapstate {
+		JTAG_STATE_TLRESET,
+		JTAG_STATE_IDLE,
+		JTAG_STATE_SELECTDR,
+		JTAG_STATE_CAPTUREDR,
+		JTAG_STATE_SHIFTDR,
+		JTAG_STATE_EXIT1DR,
+		JTAG_STATE_PAUSEDR,
+		JTAG_STATE_EXIT2DR,
+		JTAG_STATE_UPDATEDR,
+		JTAG_STATE_SELECTIR,
+		JTAG_STATE_CAPTUREIR,
+		JTAG_STATE_SHIFTIR,
+		JTAG_STATE_EXIT1IR,
+		JTAG_STATE_PAUSEIR,
+		JTAG_STATE_EXIT2IR,
+		JTAG_STATE_UPDATEIR
+	};
+
+tck: clock counter
+
+Example:
+::
+
+	struct jtag_tap_state tap_state;
+
+	tap_state.endstate =3D JTAG_STATE_IDLE;
+	tap_state.reset =3D 0;
+	tap_state.tck =3D data_p->tck;
+	usleep(25 * 1000);
+	ioctl(jtag_fd, JTAG_SIOCSTATE, &tap_state);
+
+JTAG_GIOCSTATUS
+~~~~~~~~~~~~~~~
+Get JTAG TAPC current machine state
+::
+
+	unsigned int jtag_fd;
+	jtag_tapstate tapstate;
+	ioctl(jtag_fd, JTAG_GIOCSTATUS, &tapstate);
+
+JTAG_IOCXFER
+~~~~~~~~~~~~
+Send SDR/SIR transaction
+::
+
+	struct jtag_xfer {
+		__u8	type;
+		__u8	direction;
+		__u8	from;
+		__u8	endstate;
+		__u32	padding;
+		__u32	length;
+		__u64	tdio;
+	};
+
+type: transfer type - JTAG_SIR_XFER/JTAG_SDR_XFER
+
+direction: xfer direction - JTAG_READ_XFER/JTAG_WRITE_XFER/JTAG_READ_WRITE=
_XFER
+
+from: jtag_tapstate enum representing the initial tap state of the chain b=
efore xfer.
+
+endstate: end state after transaction finish any of jtag_tapstate enum
+
+padding: padding configuration. See the following table with bitfield desc=
riptions.
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Bit Field        Bit begin  Bit end  Description
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+rsvd             25         31       Reserved, not used
+pad data         24         24       Value used for pre and post padding. =
Either 1 or 0.
+post pad count   12         23       Number of padding bits to be executed=
 after transfer.
+pre pad count    0          11       Number of padding bit to be executed =
before transfer.
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+length: xfer data length in bits
+
+tdio : xfer data array
+
+Example:
+::
+
+	struct jtag_xfer xfer;
+	static char buf[64];
+	static unsigned int buf_len =3D 0;
+	[...]
+	xfer.type =3D JTAG_SDR_XFER;
+	xfer.tdio =3D (__u64)buf;
+	xfer.length =3D buf_len;
+	xfer.from =3D JTAG_STATE_TLRESET;
+	xfer.endstate =3D JTAG_STATE_IDLE;
+
+	if (is_read)
+		xfer.direction =3D JTAG_READ_XFER;
+	else if (is_write)
+		xfer.direction =3D JTAG_WRITE_XFER;
+	else
+		xfer.direction =3D JTAG_READ_WRITE_XFER;
+
+	ioctl(jtag_fd, JTAG_IOCXFER, &xfer);
+
+JTAG_SIOCMODE
+~~~~~~~~~~~~~
+If hardware driver can support different running modes you can change it.
+
+Example:
+::
+
+	struct jtag_mode mode;
+	mode.feature =3D JTAG_XFER_MODE;
+	mode.mode =3D JTAG_XFER_HW_MODE;
+	ioctl(jtag_fd, JTAG_SIOCMODE, &mode);
+
+JTAG_IOCBITBANG
+~~~~~~~~~~~~~~~
+JTAG Bitbang low level operation.
+
+Example:
+::
+
+	struct tck_bitbang bitbang
+	bitbang.tms =3D 1;
+	bitbang.tdi =3D 0;
+	ioctl(jtag_fd, JTAG_IOCBITBANG, &bitbang);
+	tdo =3D bitbang.tdo;
+
+JTAG_SIOCTRST
+~~~~~~~~~~~~~~~
+Set TRST pin for JTAG.
+
+Example:
+::
+
+	unsigned int active =3D 1;
+	ioctl(jtag_fd, JTAG_SIOCTRST, active);
+
+THANKS TO
+---------
+Contributors to Linux-JTAG discussions include (in alphabetical order,
+by last name):
+
+- Omar Castro
+- Ernesto Corona
+- Steven Filary
+- Vadim Pasternak
+- Jiri Pirko
+- Oleksandr Shamray
+- Billy Tsai
--=20
2.25.1

