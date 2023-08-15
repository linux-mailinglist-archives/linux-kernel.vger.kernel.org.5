Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C99477D365
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbjHOTas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239871AbjHOTac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:30:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E9B10FF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692127831; x=1723663831;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bC1xYljXvqNEyyY+IYXtDJtbCkhx6uoHZRHkwCxfU9E=;
  b=kkIR6a4mXwB4bPxMId0NE8qE7IjCUGXmorzJTsqgIKRidSy7EusmZVTE
   z1TN31Iwh3m15ZST37LnWp2h62pHVrM9nIoYzXVZJ3NDvY9GaKUWHqhGg
   by+gDPHJXrEO88wvPZttpvcv7h1dxsjqtb/EdX6Kz5anyKOPIVtTAuOd0
   1iPPyaTMd9eqStiaqR2wYeQ15gqwyiJFJY/cFNhtjvLO89POQOhlE4IFB
   C/RVCO23YWPibAaPbGHwsSzSzcxtYcwrSMhRgG9HMkZZQYwQiia2iwCtM
   Qmiw+8gTicsx1nBAhFI53iorlJ6cP4t2SkQfOBZCiREbcU8IWWeEF0NVY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375128095"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="375128095"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 12:30:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="877468023"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2023 12:30:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 12:30:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 12:30:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 12:30:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 12:30:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxEJVl/fguneBM5TbE3TogEuI1vG91Szmb/tsBurlmOJhFTWjMdkIlm0Pu74FtjT+G+yWTQVQXNi3tHy3Cu3jCL8OsnRzlZCziVUJskvfvRHqFLCerEGNFYAjh3q2mx57cOYrAI+7XNyK1xIWjuRP3JY+xiFMB8xysy/QBKIEZUrgB8w20YwGQyhYwuXx2wQl22beg+Smq7IWKhnAFn3WTu0rirAktyLmnqkLu2LfZt20MeUu/Cc7WHgJoyPJlZdgJbjh05uTyxvCXeQT9v1L28J/scZMj6Q4X3xKoZ/OnrCAOEKqmfBObZ3wF3k4FSwrsaPGYLGN3zDBXRGqc9X3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZzAn3VsJwHyHQrn5R934rzw2S0GsUb49Z3Ns6y29P0=;
 b=NvtIbTD1ADzlgEdaygs3O66rm1UHHVWcxCw4TvRIJ6aO/ln1J6DylOJX30W4FwhM2HVUSPYmot1tPmEI48Hvnap53i+kUG0fDODAHuKLQknAgjvkkKGIJ7AZeeni0SEdngSdqhYcITMq+w/3bzVPnHu0AXu92UE0aVAWNCZz3asDQdTLCv0WA1JOf1ofwa55G87C7KKplMQ8/LpDg0bTpr1/1BDS200VIxeQ8/P8hfgSbzVFB9G6ceT73Zw9+JpWfvrwvaErGcMUkqbb4NWhK4CVjJ++Z5sgZbzXtHMkRs080Khwj04RbfisxWqkxE/DRd9hNG7n6YlROiOuIXwk8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB6010.namprd11.prod.outlook.com (2603:10b6:208:371::11)
 by BL3PR11MB6459.namprd11.prod.outlook.com (2603:10b6:208:3be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 19:30:27 +0000
Received: from MN0PR11MB6010.namprd11.prod.outlook.com
 ([fe80::3f6a:413a:ffe4:7b5b]) by MN0PR11MB6010.namprd11.prod.outlook.com
 ([fe80::3f6a:413a:ffe4:7b5b%7]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 19:30:27 +0000
From:   "Brown, Len" <len.brown@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Gross, Jurgen" <jgross@suse.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: RE: [patch V3 27/40] x86/cpu: Provide a sane leaf 0xb/0x1f parser
Thread-Topic: [patch V3 27/40] x86/cpu: Provide a sane leaf 0xb/0x1f parser
Thread-Index: AQHZxSuNHqTVYruCfUiH6AgMgzkGq6/mYcAAgADEZgCAAT52gIABItGAgABDd4CAACAJAIAAH1qAgAGk5gA=
Date:   Tue, 15 Aug 2023 19:30:27 +0000
Message-ID: <MN0PR11MB601007E7DAE4C5FC86E58DB0E014A@MN0PR11MB6010.namprd11.prod.outlook.com>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.258937135@linutronix.de>
 <8e5bbbc91ff9f74244efe916a4113999abc52213.camel@intel.com>
 <87350ogh7j.ffs@tglx> <87ttt3f0fu.ffs@tglx>
 <b8637c8c92751f791bf2eae7418977c0fd0c611d.camel@intel.com>
 <87il9hg67i.ffs@tglx>
 <MN0PR11MB6010CB72411BA723BEFC5565E017A@MN0PR11MB6010.namprd11.prod.outlook.com>
 <877cpxioua.ffs@tglx>
In-Reply-To: <877cpxioua.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6010:EE_|BL3PR11MB6459:EE_
x-ms-office365-filtering-correlation-id: f99749c3-981e-46bd-2188-08db9dc6147b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LU6JBRI2YIMSRHQguHQ4fuGd1uADAOqmPn1VhPj5Kb/j8IONJ48c9477Bqi5xV98s0wMMk37sXoHW7qNrWlFDTFKjXY1TVlJFT1XFf2xKecl6BSyV3rScYCTlESlaNFQMQ1BrgGIsNorTYSnZ9wUZMFm5MSGZnwSj4cLvRDuTDHnNUZMunxXwGqqS51Gc+4W8MgKvtRvkXZyyxE6h6Me6ApXsIFcZvqmi133dRmnDIY7Z8GjtGeiSWlvSqmqhBn9lSC52GUZZRFOBa7Fhwn58OLJ6/kRV+ab9ZunB+SQI1GitH6ZXzCbX2aPhasQwPzCwPkX5M4fG/K6fCAjA+WxzHJXQ/yEhg3kuK/sQ8cS8DwhOcEWO3vLIsiPtdw0rcVDXqLXt6uLvfXc+pbT7ypZ4hGMhBnfQ+4hveYONoCt/Vp9g7cVdfv4tSjGDQjCHzPaq7S2aEPbC2vTib+5F79gUTS9iQBYppbkT+cIrOhXkqTJ+ivpdkaIHa0s4Nj7uPhiO/7DtdRSCBTnBReOjl/cOk6NqmAAP6Bky7W/Ylgjn8AmXb+CEDzz8EkitPaUF+qiwm5v4ALZnFfu4g8df88YXn/aYv95jOKI30QIrWd3yeNkyl9WngdzQuAbeh4/y8c+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6010.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(1800799009)(186009)(451199024)(76116006)(8936002)(41300700001)(66899024)(83380400001)(54906003)(110136005)(82960400001)(55016003)(5660300002)(38100700002)(2906002)(52536014)(33656002)(86362001)(64756008)(66476007)(66446008)(66556008)(66946007)(4326008)(38070700005)(9686003)(478600001)(316002)(8676002)(26005)(6506007)(122000001)(71200400001)(7696005)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EZjuCopOuvm9M7Nm98Ls0vd2KpKLd8M1n5OKUTcvNHBMQqeexUtsdKy0Gy1B?=
 =?us-ascii?Q?Ij+P/hbKfNFZ6HvEwNc+v+A/WKrRRlAKVoNfRv+I6ERmnf4CDzXHewWseGy3?=
 =?us-ascii?Q?xByg8B3B+jKupRs7mgX10TtLNqgx3ZG0zRIksxLZDNbdL46x67F//fFRovH5?=
 =?us-ascii?Q?FUxKUfhI1L+hNDMUl4VQrqiKUECu4XU4sd4W2SZ1s1zQOKE168G1UyXdiw3s?=
 =?us-ascii?Q?D5uI4sWYpKO157juCWicar5EDENyMIOmVb0fjd//nnEVeEK6rhP/1owiJm8C?=
 =?us-ascii?Q?WOslEKdHS/bl5bSFxsi8cvfHvnIuPTKbsKoIHB6fO0FOkJuqpoVzpNAcLI8P?=
 =?us-ascii?Q?uY1XbhWscxjuqZM7ieFAtyFDDVLQMFg0KatNdJYxG2p7xnVI7VbV8pquenCB?=
 =?us-ascii?Q?hMXg/l4jae0tyJMjap48UsjqwahdmlcHELEBpPR7M5r3kfl/AmLsqRHTWVTK?=
 =?us-ascii?Q?uGiNiApkHFhXwCmmIVl81HMnz07+C2YV0n2SzAeqx4q1BNUugpn4zzKDRP3I?=
 =?us-ascii?Q?UkfumYFeI+jcd3bVxE51J0zBb2pecVSQAn89+dyuz/iXQfmSG1xXMXWEsRZy?=
 =?us-ascii?Q?yv7AQCbLVQ9+R5Es1q5Yp4iePIp6Z8H7FASny4SGnkycitAKlAAnU/oz37bX?=
 =?us-ascii?Q?RXKcUvjBuqS3futqCMBi2dfGgIZL2HIdeuwXeT1IzhWMnxFjCENGDfVCX41R?=
 =?us-ascii?Q?3szNiEG9XYPiCWuYag1v6gHdOWEHRJ7IsGPv7Q1bJ0g1sdbEfiRMtTQJEgkV?=
 =?us-ascii?Q?8CwYsQbbFbshuctiENoRkDtXPvfnfuBW1f9/UKKydNhQuZ4/XdeF/1yYQ4En?=
 =?us-ascii?Q?d29aYw/Q5v2wnmh/wOmV2Qz+dXKrL22J0qKym3XGELX3EoEwr9lLGI6QxPqP?=
 =?us-ascii?Q?w529+FqET1sfVplh5lsal0RC8QsdgDry/defGIJycU01JpFEXQfmGH6DA3J0?=
 =?us-ascii?Q?/JI8C1WSaJkGEp4WDqczut/9AMKZoRAteJt/S9S/KihAW5kv8pT92lDQY6JJ?=
 =?us-ascii?Q?zELKuxwQQ54pgYceZlPo1Yn6WnueD9ek4dSkCp8N6guDHQJABpFraV3+JwqS?=
 =?us-ascii?Q?1Kn90VioDG2LE46ZTl6qVitdlGVNCNnfidqYf+DS0581BoLGsbI68vJ+8h1e?=
 =?us-ascii?Q?HSqYzMCGXLU9xKbm7isOU29la4cMMAsKCQtQ1QeQa/Ap0E/NmCYME4oZwD9Y?=
 =?us-ascii?Q?EKlFQImUWFuWVoZL4fgoPFCPtDxV5wAn3Gn8K32uzRMhnL1uTS90FLsGJ115?=
 =?us-ascii?Q?2lgeX9odAC3qcTmWK0EnknweUc3qsFOAfHxoIuovklNHrJj/O2fP5ba2QyUs?=
 =?us-ascii?Q?FXjoe1TOMD8Lu4ogq1pQLvprvT+Hkd1tbe/1BlIJZaOUb4eeuHvZbDlVMQrU?=
 =?us-ascii?Q?muzKpeoRCrCHyU/8tCZT5EpC2gN7drd2xzd0UCWlAVO1nbDhyeBTrRsTg2nt?=
 =?us-ascii?Q?EtU1+iMHUSNJ0def+USgMWpnrY8TjDdDIxpZrCFtW5cInlwNg1lsSx0bIy+3?=
 =?us-ascii?Q?7ATqrdj2VLAruBTZG+ckgQTSpB2ofK/SpFqmEmFzTRb+Bqed2lwed8FVBJOF?=
 =?us-ascii?Q?s8+bkKhwu36qqjFhJTVfRfvf9NRJfZd+xb4VFaya?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6010.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99749c3-981e-46bd-2188-08db9dc6147b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 19:30:27.5376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kW7p/HvwoMjO3RtC3TOaTK3oJ+/LHy1LgL1LE+ADQlqgxQp5cRsUWjLw2iJnJHbd1QN6+WRxsWj+mQxVKCzysw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6459
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

It seems we need to take a momentary step back to step forward...

First, the Intel CPUID context...

Even though CPUID.B was created to be extensible, we found that adding a "d=
ie" level to it would break legacy software.
That is because some legacy software did silly things, such as hard-coding =
that package level is always adjacent to the core level...

Enter CPUID.1F -- an exact clone of CPUID.B, but with a new name.  The new =
name guaranteed that the old broken software will not parse CPUID.1F, and g=
ave Intel license to add levels to CPUID.1F at any time without confusing C=
PUID.1F parsing software.  As 3-year-old kernels routinely run on the very =
latest hardware, this future-proof goal is paramount.

Multi-die/package systems shipped as the first test of CPUID.1F.  Enumerati=
ng the multi-die/package was mostly about MSR scope....

In retrospect, we under-specified what it means to enumerate a CPUID.1F die=
, because it has been a constant battle to get the HW people to *not* enume=
rate hidden die that software does not see.

Indeed, we were equally guilty in not codifying an architectural definition=
 of "module" and "tile", which were placed into the  CPUID.1F definition mo=
stly as place-holders with awareness of hardware structures that were alrea=
dy in common use.  For example, there were already module-scoped counters t=
hat were hard-coded, and enumerating modules seems to be an to give archite=
ctural (re-usable) enumeration to model-specific code.

Second, failings of the Linux topology code...

I agree with you that "thread_siblings" and "core_cpus" are the different w=
ords for the same thing.
This will always be true because the hardware architecture guarantees that =
SMT siblings are the next level down from core.

But no such definition exists for "core_siblings".   It is impossible to wr=
ite correct software that reads "core_siblings" and takes any action on it.=
  Those could be the CPUs inside a module, or inside a die, or inside some =
other level that today's software can't possibly know by name.

On the other hand, die_cpus is clear -- the CPUs within a die.
Package_cpus -- the CPUs within a package.
Core_cpus -- the cpus within a core....
Words matter.

Specific replies....

Re: globally unique core_id

I have 100% confidence that you can make the Linux kernel handle a sparce g=
lobally unique core_id name space.
My concern is unknown exposure to joe-random-user-space program that consum=
es the sysfs representation.

>> Secondly, with the obsolescence of CPUID.0b and its replacement with=20
>> CPUID.1F, the contract between The hardware and the software is that a=20
>> level can appear and can in between any existing levels.  (the only=20
>> exception is that SMT is married to core).

> In theory, yes. But what's the practical relevance that there might be a =
new level between CORE and MODULE or MODULE and TILE etc...?

>> It is not possible For an old kernel to know the name or position of a=20
>> new level in the hierarchy, going forward.

>Again, where is the practical problem? These new levels are not going to b=
e declared nilly willy and every other week, right?

It is irrelevant if a new level is of any practical use to Linux.

What is important is that Linux be able to parse and use the levels it find=
s useful, while gracefully ignoring any that it doesn't care about (or does=
n't yet know about).

Yes, hardware folks can drop something into the ucode and the SDM w/o us kn=
owing ahead of time (see DieGrp in the June 2023 SDM).  Certainly they can =
do it in well under the 4-year's notice we'd need if we were to simply trac=
k the named levels in the SDM.

>> Today, this manifests with a (currently) latent bug that I caused.
>> For I implemented die_id In the style of package_id, and I shouldn't=20
>> have followed that example.

> You did NOT. You implemented die_id relative to the package, which does n=
ot make it unique in the same way as core_id is relative to the package and=
 therefore not unique.

The point is that  like package_id=3D0 on a single package system, I put a =
die_id=3D0 attribute in sysfs even when NO "die" level is enumerated in CPU=
ID.1F.

That was a mistake.

>> Today, if CPUID.1F doesn't know anything about multiple DIE, Linux=20
>> conjurs up A die_id 0 in sysfs.  It should not.  The reason is that=20
>> when CPUID.1F enumerates A level that legacy code doesn't know about,=20
>> we can't possibly tell if it is above DIE, or below DIE.  If it is=20
>> above DIE, then our default die_id 0 is becomes bogus.

>That's an implementation problem and the code I posted fixes this by makin=
g die_id unique and taking the documented domain levels into account.

Your code change does not fix the problem above.

>So if 0x1f does not enumerate dies, then each package has one die and the =
die ID is the same as the package ID. It's that simple.

Unfortunately, no.

Your code will be written and ship before level-X is defined.
A couple of years later, level-X is defined above die.
Your code runs on new hardware that defines no packages, level-X, and no di=
e.
How many die-id's does this system have?

If you could see into the future, you'd answer that there are 2-die, becaus=
e
There is one inside each level-X.

But since die isn't enumerated, and you don't know if a level-X is defined =
to be above or below die,
then you can't tell if level-X is something containing die, or something co=
ntained-by die...

The proper solution is to not expose a die_id attribute in sysfs if there i=
s no die level enumerated in CPUID.1F.
When it is enumerated, we get it right.  When it is not enumerated, we don'=
t guess.

> What do you win by removing them from the SDM?

When you give HW people enough rope to hang themselves, they will.
Give them something vague in the SDM, and you've created a monster that is =
interpreted differently by different hardware teams and no validation team =
on the planet can figure out if the hardware is correct or not.
Then the definition becomes how the OS (possibly not Linux) happened to use=
 that interface on some past chip -- and that use is not documented in the =
SDM -- and down the rabbit hole you go...

When the SDM precisely documents the software/hardware interface, then prop=
er tests can be written, independent hardware teams are forced to follow th=
e same definition, and correct software can be written once and never break=
.
=20
-Len


