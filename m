Return-Path: <linux-kernel+bounces-4643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C8F818037
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2BE81C22F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4FD7486;
	Tue, 19 Dec 2023 03:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XIFxFf5e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E9D7468
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 03:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702956610; x=1734492610;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DHgaOvk5fyjkxnnD+dp7KwEcW16R5vmOqnngFRsCoiM=;
  b=XIFxFf5eDBnxJGIndnVdtd/6+L+Fl9YA7yrRvwKpvtUCK0SS5E5iViMZ
   WXco2Lrrl7+vPH15BPNEA5Hmw+iyiZsZ02rsSpgocmU+ZE57+5SHPShLF
   qydztjcyL/tk1T/e/GoioWv2z4KDXepf2F0QXp+GNQeiX9oOjpTmzeDNw
   g+90GOOR1jCui3JMkER7AXEK4MFKKi9kvVRqGwJ8Dmuq3SQslH9CW0fA+
   GLGJv+XLTzXwUTzSS8qGtyWReqo+YGcTjb+W8mbbOCkARXmwaMWyZ9GXA
   qqWQkDsbxSXvkwDxJ7rEHUjcSM53PjcIZAhIdUItdjWPKKk+pksd/NJiL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="14291693"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="14291693"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 19:30:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="846184768"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="846184768"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 19:30:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 19:30:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 19:30:08 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 19:30:08 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 19:30:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGvDAsufd6fyS9RCm9xPDRSYRevNMf7iXBcekcC+RGY5neS2JAAcijrwkEf17GrmqAvuKAajbJ+RQ65zwa07DTE3C674cVWXvDFAsEZwaH2mZOOqoZbSg28lhMD9yVQGVdgEh3ZtxTOxqESZ6jpNLe5RDVAVPgs0oByhS6WF2xgN58ukMY87rYYQGYwWK1f/6PmWvukdmaRakDNnoWS51VRAy/SBnpTSYrU2GHOq5dP5wQCSC3VNnUGItWW/cN492+6GNI053wIB7HKHib/noy/pS5o6XY+GBVHyiZxJEUURSrI+NUN7keYlcdLU4bMwAo8EIjK1kgRNVa4o03Hfyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTowLLVmpzgHf++ZaS3cjAIMC+SIg63xsiMdmKaJL0A=;
 b=IW3EetbEZNvmLv79NXph8c6sy8VNhCfsDmMgcYxkKZ23UtKhddll6pk4FMBWya76PqeuqafybA5lKa+KC0c11FcRrfDSpTWBDkol6NYe7QxXZWOc84oW9M+AkP+JDJ2gmClYjuj9FGqdXuY3h6IRzfvHvA44XAuBqn0WhGJkouEiBTTSYv8DbhnTXpaaOGExoww5/kVK0tANBECSfjpUyqCR1C0cewnqYcuPpAxvOhdeLTv8DS34zPZkzSloZjITfthwSF0bwWTFaTQ0UKil1pmQFHcr1iKT7iHbpEGL/Kr/8O5s8lJgCL8forSAf6gBRsgIzl/By7HAwCfhJ3Itaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3164.namprd11.prod.outlook.com (2603:10b6:5:58::25) by
 SA2PR11MB5179.namprd11.prod.outlook.com (2603:10b6:806:112::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.38; Tue, 19 Dec 2023 03:30:06 +0000
Received: from DM6PR11MB3164.namprd11.prod.outlook.com
 ([fe80::d5d4:83aa:9b83:f40c]) by DM6PR11MB3164.namprd11.prod.outlook.com
 ([fe80::d5d4:83aa:9b83:f40c%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 03:30:06 +0000
From: "Wang, Xiaoming" <xiaoming.wang@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Wang, Xiaoming" <xiaoming.wang@intel.com>
Subject: RE: [PATCH] kernel/cpu: The number of CPUHP_AP_ONLINE_DYN (30) is too
 small that stops the new dynamic states hotplug.
Thread-Topic: [PATCH] kernel/cpu: The number of CPUHP_AP_ONLINE_DYN (30) is
 too small that stops the new dynamic states hotplug.
Thread-Index: AQHaLKaGkoT+yzskUkKe6mEiubwNYLCqw56AgAUpVQA=
Date: Tue, 19 Dec 2023 03:30:05 +0000
Message-ID: <DM6PR11MB31646E5034B747314510C9E6EC97A@DM6PR11MB3164.namprd11.prod.outlook.com>
References: <20231212025235.775986-1-xiaoming.wang@intel.com>
 <87o7ermf0c.ffs@tglx>
In-Reply-To: <87o7ermf0c.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3164:EE_|SA2PR11MB5179:EE_
x-ms-office365-filtering-correlation-id: 9f2e0963-2c78-47c4-9548-08dc0042cb2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JkFQjpagY4ITirFbt7Wq6VrCLKtMAc8q9woNsr/tMyCY3jS2Fp+Q3JlzNZ6c9DDPyWoV7PfeNZ6nsllrJwzqjuluT6alx7mwNVau8XwlRk0BAki25wOYP7GIJSjg5+imX2LNv3D9/X9s5vrieQkkROBH3g+sk9zXwRfrHMLRmIP9JD5owk6V66FtIWZdyTrOgec0madGtdOxNIEpOhcJrrSf3KTEvIG5APJ7UgUS/HxyfX5/yNZoy9Fg6V6EEzUcUpdji7tOOB7dB9ex5mxAmSiOA8zThv/la3Jg5c86EmV7b+8iUPRXzt7MfR8Vp/Ju+eA/uKE0o1byGPrlq39bwHHMeYdn2UqY8iQtuKuevctBQohv4FERKBQgEqa4jRg4GdbpwFkmaKJ5AeRTZpd8BH31PsbRcIPgLbp/VFhobKFcD0+FhKVvebImu912X2q1Gr5bVM08ODw16fuFVxyQD61lPjavK1xexA4G3hc5M2FsjeF6M9CS7ypsf8HUTyg9gKB0c71El+S+B/Kye+8rdrRVJ9b3cKLZdVrJE7ZqKtsrrGUChFXMQmK/htBOphQHypzuIQMk8KxFThRlafM+MqNXunrkTYQe1EfjE9gNTr+b83lnXngf/i3Z3VWEMf/zbDS+JzuiueQysaMd0jqJrfrd8ew7X8hoVCaBlA4tgWw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(9686003)(966005)(478600001)(107886003)(76116006)(66476007)(66946007)(83380400001)(66446008)(64756008)(316002)(110136005)(66556008)(8936002)(53546011)(5660300002)(7696005)(4326008)(8676002)(55016003)(71200400001)(52536014)(26005)(6506007)(2906002)(122000001)(82960400001)(41300700001)(86362001)(38100700002)(38070700009)(33656002)(160913001)(15963001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nhgDWO/fvgP4NibACbJUuUdwWPOdOxkOO/aWN0NVt33M/m0covWuL0jzefS6?=
 =?us-ascii?Q?XnOrzczA0It454yZEHfqTUQhGGdGaLQyf4oc8bfdzLub5D5UFLWL9Ld1vNQD?=
 =?us-ascii?Q?E2ch08bzm0jd5ra9UNqWmeVrIEECtwMFZYCWQcUe4Qtma1fNUw/7K+cSEHH2?=
 =?us-ascii?Q?BzHx05Y3dW9g7Y7Jhl4uzx4LGJS0TTI87BBtxrSTVcrZFc3Hll2OV6qZnrH3?=
 =?us-ascii?Q?JT9+qZab4sENdGK17cujx90ofWyVAJ/S2d5DX97urCEpGoEjWjWZVttf5f9Y?=
 =?us-ascii?Q?jKwwmDElZFqFdIFRwTESTGOtrGSPBAmjUY+Cgd+2LprSyGHRCzFuKgGAlZSn?=
 =?us-ascii?Q?XbojicHZuRfbdheQoRy+7wdPjjZMDBF7DZwZZ2OLVQ+p8lNCLf5mbDaZjMtj?=
 =?us-ascii?Q?5qkx55gQScyo1Biw/xSZ4uZbOLEmBbQLkMbV3lRALO5A312ewazwVSEHLy+v?=
 =?us-ascii?Q?yDGxB5wG7ITsLO0eqcY4GFjnlvqwr7gV2BKVBuokq5v+1g1aZD8uEr75dPHz?=
 =?us-ascii?Q?G87ZPk/G0SDin6gTHvb/O8OzHjiHpnCArBDByzre4FEzaFnGPhv9zvFXU7Lr?=
 =?us-ascii?Q?kX8FHSIq6XiV27uR9OVq2n0KtmbrLusqS/PkK3C2hYkXNORvVfQtDRYe5tY6?=
 =?us-ascii?Q?oMwKprufSst3qRKPeM8moAhGeDs9NUNMhIe+i00KnWJmrqA+NWh5dKzL3v6G?=
 =?us-ascii?Q?rUAbMa4nuhsl04C28O6XBPveS2PQ6NC+3bN0THRWat9dju8rxzfGD1vqxmV1?=
 =?us-ascii?Q?0z+cIWdiXr0EhU9dFJLeJVFEi2vCm22op38CNStvYNnTEDo+uMCowFx5eJAZ?=
 =?us-ascii?Q?XbjyM6pbMk3Pl9+FUC1AnbU5HBUydLUguT11dvObI4F4nsRIjxcEH2QY9Vj7?=
 =?us-ascii?Q?uTg0K2Uj0VxQXZ/3v+HQLTlPspQ6DrePfF+2N04x0Nx8OyTdpEWq4MZL44WB?=
 =?us-ascii?Q?KUsZ33BiZ0RlSbbC7mmUV3QPbfU0GsuxAulTnRoYj5W5mJDbojOOBqt8gX9B?=
 =?us-ascii?Q?OPCH2bb4yRwFUtq5l4RbHpa8xorAIwTA0vhQojU2NvlaBGl0Kea4bmK+4t1Z?=
 =?us-ascii?Q?ns6I/J2CvdnRgCUKlV9qYWO4FcUPBBRTzKShN6ViRMQx0TraXNcYeuXv72C6?=
 =?us-ascii?Q?grK2WHAlxde2vThvFPXm6OLQf6HiqZ4bGXHgihfN9M5Xab8KEpvvstVInAbp?=
 =?us-ascii?Q?lAB0+o7IHghVEzBT2c7p7TU8+wAJmtMu8joZlYpCWIJmKRkYKIQSR6O2SzcJ?=
 =?us-ascii?Q?lZd7JtcjdoOKO/WXs9wdEhEf/z6utmCMW+8FTaqYOg/y5kR1PaVrA2L7ULze?=
 =?us-ascii?Q?grLIOdomYILqdnjcA5euvsBR20Ph6RsrIy3bFT1cfQ6XPBEI5EfVlGrz6IPy?=
 =?us-ascii?Q?oRnK3fl/3VSj2efQKa+jaLJW3OzXAIRNae/Mg2ykBQBooVi+gamCKfl5sp9s?=
 =?us-ascii?Q?6H4jx6Rt0c+HQD7ZdCWJNQnxKIg9I9AiANLrKiHjnnFLt0OjQ6M7V8VO3q4Y?=
 =?us-ascii?Q?IK/gydAVhMSGsxKeFVD0TKy5uUaMofbWCIL91n35UbaxTb2hi9qW8Y0BqTfJ?=
 =?us-ascii?Q?GNd8+WaW2jCDVvrYuS6tnQIle/mxZCH+AFqTNrYC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2e0963-2c78-47c4-9548-08dc0042cb2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 03:30:05.6063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qRQSHiyrSAgdJrQpm84nnxIlDYRftaluastooMYrDdlDaYYCqSe0szCX6NP2YO0Rk53QXwh9epvPHHFMOZuISw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5179
X-OriginatorOrg: intel.com

Thank you for your response Thomas!

You get my opinion exactly.
I will modify the patch under your guide.

> 191: ia64/sep5:online
I do not know what this dynamical state mean either.
Maybe this is an irregular naming driver for X86.

I list them by cat /sys/devices/system/cpu/hotplug/states | grep online
And find the dynamical state is over 30.
So I think it need to enlarge the room for dynamic states.
Do you think this make sense?

-----Original Message-----
From: Thomas Gleixner <tglx@linutronix.de>=20
Sent: Saturday, December 16, 2023 3:40 AM
To: Wang, Xiaoming <xiaoming.wang@intel.com>; peterz@infradead.org; linux-k=
ernel@vger.kernel.org
Cc: Wang, Xiaoming <xiaoming.wang@intel.com>
Subject: Re: [PATCH] kernel/cpu: The number of CPUHP_AP_ONLINE_DYN (30) is =
too small that stops the new dynamic states hotplug.

On Tue, Dec 12 2023 at 10:52, wangxiaoming321 wrote:

The subject line has a two issues:

    1) the prefix is wrong. See
       https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#p=
atch-subject

       You find further information about changelogs there and in other
       parts of the documentation

    2) The sentence is too long and incomprehensible.

> 144: perf/x86/cstate:online
  ...
> 195: online

I have no idea what this number salad is trying to tell me. Changelogs need=
 to explain the problem they are trying to solve. This listing of hotplug s=
tates is not an explanation and completely useless as it even contains an e=
ntry which do not exist:

> 191: ia64/sep5:online

Even if it would exist a ia64 hotplug callback is hardly relevant on x86, r=
ight?

Also the fixed entries e.g. workqueue and RCU/tree are irrelevant for what =
you are trying to describe.

So what you really want to say is something like this:

   cpu/hotplug: Increase the number of dynamic states

   The dynamically allocatable hotplug state space can be exhausted by
   the existing drivers and infrastructure which install CPU hotplug
   states dynamically. That prevents new drivers and infrastructure from
   installing dynamically allocated states.

   Increase the size of the CPUHP_AP_ONLINE_DYN state by 10 to make
   room.

At least that's what I oracled out of your "changelog". Hmm?

Thanks,

        tglx

Thanks
Xiaoming
  =20

