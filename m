Return-Path: <linux-kernel+bounces-20432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA15827ECD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33E61C23522
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858288F67;
	Tue,  9 Jan 2024 06:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MfMesNEL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA84E29A2;
	Tue,  9 Jan 2024 06:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704781902; x=1736317902;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/pwsT3XzHADy5DIVDMcjwQR1jvA1Vagl9ti3wdbwxpY=;
  b=MfMesNELY0ycy/QcZXzWUumQuBQ2PD0ATGxdIRQzY/qZiISrzpf2NuAa
   OW0rGOmYwDLq20E7uF5JaQxZ4diufHg9P+ziem8JYdBa073nss+WIYq+y
   07tiD/KKIcoUJ+cEBUwBj/f6eKlQZlCqI67WiVVbvl9U3+6e9ahl2VZHV
   1e2Yuk4XlzHkytXvF7UigLsHAcYqLC+nD78VYHRGGuDSdrUvPvklx9yY7
   W7CvQ7ZEXEEYxpMHkq5QDbz1z1OPurQCpPW7RKeuYmSLoGsx3l7PAcfiy
   nVfpgpya0RaAIv9yz2Ju25/kRK4bfrl2y4imK+NraoVdx2rZtaMLPFmEf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="19597812"
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="19597812"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 22:31:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="757882196"
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="757882196"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 22:31:39 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 22:31:39 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 22:31:39 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 22:31:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jywtm1lGJz/+QGHu77s55iZApoTocSEWc9jXZIHd3dABOg20IpxeHB5PNQd1SOGLoMuW4zTp5PXsU5UMzdvhNSsq1fgrCiWfhtLGNtbhrgOR/FlPmptxPgfWa1+DC70yw84bU9w16aGHsMiQ3+R6JwV47gVkUUY+wf6IjcB2EtRbBZqG/dZD/CF7NzyySrMt5/a+jph2sjP7S3N3H2fu4zSRb+v72d82KIpt+AwRs9+ec3RyjefDM1Lu5tc7ezt6dhfN/uXITe1m2n1RB0N/yepsxPvCT9RV7r2sONEo+20V6eRrlrJYiMx9jg7DyWpjsJlk7SVWlBurYj4c0nyIrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pwsT3XzHADy5DIVDMcjwQR1jvA1Vagl9ti3wdbwxpY=;
 b=nn60R0Ovmmo4zjoNr8AaLn+QsruO3k9Va+aRGsrVMtJkYntcp2mJDQfXNRMZwoBgTv84crSnXQuVCOh4has1nNc+ELhhACaLMn91L3440amkIGPstbfy1GxoWiPUs6SBLVGiLsNrrsAYQ0echVfoBiwRKp0ol+ZB9UTQXZ4r/0jb/2mDxTR33NrKDKp40NGtIWU8ddLCMHF+YS909OHZMuPxeVhGMRumUC19s3o5PINAmJAM3Bc+iTZ6xu4fXe54pOHBgc3Yt+QsdOhZRa17ajuffskWGVKHboB4uWClNrgBG/S+UMBF9HzrsfkAS5Hm1BuwCWH0510CrwcHQyEG3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by CH0PR11MB5473.namprd11.prod.outlook.com (2603:10b6:610:d4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 06:31:32 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::aa4a:f2aa:f6cf:367b]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::aa4a:f2aa:f6cf:367b%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 06:31:32 +0000
From: "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "jstultz@google.com"
	<jstultz@google.com>, "giometti@enneenne.com" <giometti@enneenne.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Dong,
 Eddie" <eddie.dong@intel.com>, "Hall, Christopher S"
	<christopher.s.hall@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"joabreu@synopsys.com" <joabreu@synopsys.com>, "mcoquelin.stm32@gmail.com"
	<mcoquelin.stm32@gmail.com>, "perex@perex.cz" <perex@perex.cz>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "N, Pandith" <pandith.n@intel.com>,
	"Sangannavar, Mallikarjunappa" <mallikarjunappa.sangannavar@intel.com>, "T R,
 Thejesh Reddy" <thejesh.reddy.t.r@intel.com>, Peter Hilber
	<peter.hilber@opensynergy.com>
Subject: RE: [RFC PATCH v3 00/11] Add support for Intel PPS Generator
Thread-Topic: [RFC PATCH v3 00/11] Add support for Intel PPS Generator
Thread-Index: AQHaPjvbeo56FQye9EuoBkh8cNhPW7DM6zQAgAQhyxA=
Date: Tue, 9 Jan 2024 06:31:32 +0000
Message-ID: <CY8PR11MB7364D6EDCCBCCDBF9DCB0BE5C46A2@CY8PR11MB7364.namprd11.prod.outlook.com>
References: <20240103115602.19044-1-lakshmi.sowjanya.d@intel.com>
 <ZZlvqvYQQuse_P4E@smile.fi.intel.com>
In-Reply-To: <ZZlvqvYQQuse_P4E@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7364:EE_|CH0PR11MB5473:EE_
x-ms-office365-filtering-correlation-id: b52126b1-e890-4459-4776-08dc10dc9eea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bNKkxFR+XtuKeuabOoGgXf+3EWO55PMOSRk5HtD3121/seBxYEWllu1AnSD9atQD2VV3bV5MNZQi0by40+G8nvG/3Zx1u81fPIsBF14PVRf/EN6QvE8RJMjWVeLrpxxirzV+z/LPqj1f+mVoX9u5/egYq0XcX4RmO5GSYAnoRfoJziwTRHv3a2tA6mEIefPz8/hma2kO3OnTrqrvolNr2dC3kpBC2xL0UvtfatqMDPuI8I2/dbHm86klApgUFDRlZ0u6lsAU/JXw64tLJnXgZDUbWmZiw3yYg7ZlAwQC5HFWL8KijeIUWebRHI7oc1l1LzbxJ8ZjfIj1cgNBGS4L4jPAsOdaHSScAuclKizfvgiNHVNfqJZyOy/P5H+Qrbn4xr/8/hCb40/odeEr0FcaGXQ31TavJ5p/dCBpVsI+kRYHRwo3tNJ+//Q0r7WaBHp+I5XGIWdrWEnccRZSdS0M8FnB3rW+TVM7mNL39r7Bxutxa7WrVtkAvJSBmMjEUNj8prSpeKlK6u8X+N/+Lpq7gPmO/RExhsOc358U6WEa1Ev1QWkmdp3zeCg9UsZXf8TpTyWoUqTKR6jh1pOTduf6oQglPadBuH7YIMIRv8w3DuU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(38100700002)(7416002)(5660300002)(38070700009)(82960400001)(86362001)(122000001)(41300700001)(316002)(54906003)(8676002)(8936002)(9686003)(55016003)(66946007)(76116006)(66556008)(26005)(66476007)(6916009)(64756008)(66446008)(966005)(478600001)(83380400001)(7696005)(6506007)(71200400001)(53546011)(33656002)(52536014)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lrLOdcvhJ8K1xZr0jLyIkPITBZIl6r1eumH93cSEE83/f7CHsnomLpsEhMYb?=
 =?us-ascii?Q?Thi+rUqqhBEs80Lmql9+IblvQ64eYZ3S+aFxNvEoVpThSq1msbTpwiBfMmCW?=
 =?us-ascii?Q?UKPn7Hl6kQvZAUPtGLR3qzpQvLVugNIk9vuBdQqXzr/G0W2XiHXINk2u0zk+?=
 =?us-ascii?Q?WHirjb8kzoae7GRQqWtBe7B6ESL88hFNO42p/FrtvYd1FX9rTMNJZrrZzDM7?=
 =?us-ascii?Q?IirISdGUmYjkqLASpZesKsB4tAgtlKqEjSY7MXr2ZgiHAx8nyTSujgYJXOY+?=
 =?us-ascii?Q?rMG8vho+ejfoyoSWm6eTU7FQkvmia/8eHw7gvsRqKiHvYNFsA1Y6WlsNcwsu?=
 =?us-ascii?Q?pPdNIvWBN9+L91uID890+NHGS4QHbcYsqzIHxGWmje8kHU/gHI5R/hKHCcHc?=
 =?us-ascii?Q?72eY2MfNICi0Eb/dRJzM7nHR7iD1iNLA0iPYhYAVC9zwDpaZrRxJ1PlzdVmW?=
 =?us-ascii?Q?dAD6T/V2NhYXtTZMHg9RbafUHJjpcG59NWN7SvykqsJurtoPc7UE9LFjHFOl?=
 =?us-ascii?Q?PxVI/kZWh1O3GBlhxkVGesuztK2q+5MECAtPRhkQmMouLHrhkXVJ/7s+tgsa?=
 =?us-ascii?Q?Qu4H98Yvzq/ImLQWQKQPO9hPCsU+O3BJVgQ4NY/xzKf6XTSqrVRqocwwmTdQ?=
 =?us-ascii?Q?WNHg9nHgpGya7XRuxWo7ApkkeJTl3v7d2r73SL4y45MwAVfNbDPsZteWzq1E?=
 =?us-ascii?Q?br9btYfGrTeFh45RuaSrdQAog8GIkcDE2dbPKarPSNzs2pU2k52H3C5nbqAR?=
 =?us-ascii?Q?hXixHiDpjSK3Ty0YYjpq0grP7LMtv5tHDRYQZ6zouRHC5uLUC1aKEaWIwM2/?=
 =?us-ascii?Q?69BiaFRghWcMBDpH8oHrkOzaJ9QPGNBPVewWI3gKVBkJy4RuUdgCLViJRimC?=
 =?us-ascii?Q?U8ZXiq74a3UqZ7l0UcMOLmhkdyHRe4lXPOsARWLp4b/YiTeJAJ4kEqIMJuci?=
 =?us-ascii?Q?QdPJ7M/moBjOSj+1GAEuGAKT+2+IsNz6pCN+ACT1RuYsegUb/HaJT8eUtvkE?=
 =?us-ascii?Q?5np9A8ol3Hn/6wIqSzpL0WxO1tkzzfkQH3if8HhmH+TVmnQjzT+BiGN0jSbm?=
 =?us-ascii?Q?mk2M8ocAOyIIkUJ7B6R1HgKm872+SDh7eCK9Oc50ZqdEJ9krCUetDKX5Tfh1?=
 =?us-ascii?Q?sVsbJMiOSaJPLjhbIeBfnbiGhDfbc7RrfUQMqBUM1uuU+46W8JRhfYllwmTN?=
 =?us-ascii?Q?5ZQEwgAGLyYgCXVDypmjzkJKOSr5j8LI4PU0KB3QMBimL/ZaIwezItXDq+2w?=
 =?us-ascii?Q?Spkfsrvr+VWMoVxL7g/7OAAzYV7nlmCA9H20g5Q9xjp5NrZZe0LnwGM9NebC?=
 =?us-ascii?Q?i4TrdSqMuCBP7/N1XVqgs5DHEUenPh0vD6KE8hZ+rQXIK604gb/32NdoRMU+?=
 =?us-ascii?Q?X8ZZK98jW4axvEUAxpkQIHcxat77kjt5rHTTUuIk0M6RaKPhHdHZlohGPe7t?=
 =?us-ascii?Q?PyNLxFQU8hIyk66bb7Cw/0+nBVxChhiUv+k+Z2kN6cT9lp3shabpNuBVVDAu?=
 =?us-ascii?Q?3wZ59H/nyuSwqbJlwz3oGt4ckXxzTTbYWnBd6M6eEnq4//9fC7D2A5EmlsX8?=
 =?us-ascii?Q?18dpa0tWb7rKWuvSeZkLbSoTlG+T7Xm/0quhUzF4DJ5wC+Fnk17q2aoR++G7?=
 =?us-ascii?Q?9g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52126b1-e890-4459-4776-08dc10dc9eea
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 06:31:32.4280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aeGk/qg6jWHRtj4kiHSXLFmdojeblcUkD4WdiERMGJsSwbJO6Ji3Iuzcsljz7GNusI8CjYkN+oZeeiUEVdJKB+1u9JkqRgSGefXFV5agacw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5473
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Saturday, January 6, 2024 8:50 PM
> To: D, Lakshmi Sowjanya <lakshmi.sowjanya.d@intel.com>
> Cc: tglx@linutronix.de; jstultz@google.com; giometti@enneenne.com;
> corbet@lwn.net; linux-kernel@vger.kernel.org; x86@kernel.org;
> netdev@vger.kernel.org; linux-doc@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; Dong, Eddie <eddie.dong@intel.com>; Hall, Christoph=
er S
> <christopher.s.hall@intel.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; davem@davemloft.net;
> alexandre.torgue@foss.st.com; joabreu@synopsys.com;
> mcoquelin.stm32@gmail.com; perex@perex.cz; linux-sound@vger.kernel.org;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; N, Pandith
> <pandith.n@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; T R, Thejesh Reddy
> <thejesh.reddy.t.r@intel.com>
> Subject: Re: [RFC PATCH v3 00/11] Add support for Intel PPS Generator
>=20
> On Wed, Jan 03, 2024 at 05:25:51PM +0530, lakshmi.sowjanya.d@intel.com
> wrote:
> > From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> >
> > The goal of the PPS(Pulse Per Second) hardware/software is to generate
> > a signal from the system on a wire so that some third-party hardware
> > can observe that signal and judge how close the system's time is to
> > another system or piece of hardware.
> >
> > Existing methods (like parallel ports) require software to flip a bit
> > at just the right time to create a PPS signal. Many things can prevent
> > software from doing this precisely. This (Timed I/O) method is better
> > because software only "arms" the hardware in advance and then depends
> > on the hardware to "fire" and flip the signal at just the right time.
> >
> > To generate a PPS signal with this new hardware, the kernel wakes up
> > twice a second, once for 1->0 edge and other for the 0->1 edge. It
> > does this shortly (~10ms) before the actual change in the signal needs
> > to be made. It computes the TSC value at which edge will happen,
> > convert to a value hardware understands and program this value to Timed=
 I/O
> hardware.
> > The actual edge transition happens without any further action from the
> > kernel.
> >
> > The result here is a signal coming out of the system that is roughly
> > 1,000 times more accurate than the old methods. If the system is
> > heavily loaded, the difference in accuracy is larger in old methods.
> > Facebook and Google are the customers that use this feature.
> >
> > Application Interface:
> > The API to use Timed I/O is very simple. It is enabled and disabled by
> > writing a '1' or '0' value to the sysfs enable attribute associated
> > with the Timed I/O PPS device. Each Timed I/O pin is represented by a
> > PPS device. When enabled, a pulse-per-second(PPS) synchronized with
> > the system clock is continuously produced on the Timed I/O pin,
> > otherwise it is pulled low.
> >
> > The Timed I/O signal on the motherboard is enabled in the BIOS setup.
>=20
> At some point you should announce v1 of the series. RFC is usually being
> neglected by many (busy) maintainers.

This patch series is dependent on https://lore.kernel.org/netdev/2023121522=
0612.173603-2-peter.hilber@opensynergy.com/T/ which is RFC.

Regards,
Sowjanya
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20


