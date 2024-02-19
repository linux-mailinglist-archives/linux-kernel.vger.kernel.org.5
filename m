Return-Path: <linux-kernel+bounces-70646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F85859AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E60C1C20A66
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 02:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F821FDA;
	Mon, 19 Feb 2024 02:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOt8Cu1i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBA71FA3;
	Mon, 19 Feb 2024 02:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708308669; cv=fail; b=LMfirUEE2DkCRdfql9ecA1rP/4YpIW9HmisXqe4HXUGX4JhtwMgfaxTFOjaK5VbK7q2yw4tgncqnhxtNnUGR/dwOxPQ3oxjNY1mTZbUz1Pvx/6qyqVPnW7kJXr6gqxioHYAJlcNiR+93RHgaLcVWEw6TBSfr0eMHxp62o7X+7w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708308669; c=relaxed/simple;
	bh=YHLf59T/5/IMJP62ikH2yQRmrblzIsyKZKINDV19Hhc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SdS8S1bdz1MTkr3WBkxFUpROb69qHHcMPftK6KmQgGV55feY/kknHL2jGpqXpvtYX7QtykvMeKSp9a069I9+Q7gYiTiFkpJUXHth9QDDdTy2LnQhaauXvDFHn093OC4lcmpkyk1qVUHQLXnb7iPWZxTwoE0XFGMLZ5I7UKetU7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SOt8Cu1i; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708308667; x=1739844667;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YHLf59T/5/IMJP62ikH2yQRmrblzIsyKZKINDV19Hhc=;
  b=SOt8Cu1iYeUKG1SMqS2SWeGv4ldUc1klv0WKeQPokwkv/MgU0ncm7H0/
   shXJLX9x4nlv+ylUV+Lhh8er9lfamCt8teKLaXcu9y7WGM7N6o2o0ttEO
   EPYSu2OtMeJqg69WqLp8/I5uS1XJh3cdUuj4tt7qTdMxomMMqlsEYKkO9
   8d/ABbqqf08aMt8/8Hv3zkYmi+8LOXje6c6zNwxo2KU+QUXt7KXdFmeJ3
   OnD7+mHHxSqP9xXRg1ZTszloWTIvvDIUz82xwyee7CpbCsEASTqwtVwb7
   zLn9Mk+09hKl5oYP0hTc4DnEcKuYofwaS7kEzlqxjks1o9Z3Ri0ax2uga
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="6197660"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="6197660"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 18:11:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="9020589"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2024 18:11:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 18:11:05 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 18 Feb 2024 18:11:05 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 18 Feb 2024 18:11:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZAw1YTEnpLMjfnOLohMF36Z4h2jpPWk4+Q6A6ardiGtTFqsmljOaG0J8XndLx+HYghv6pagOb59TMN3oHulKXLCz0YoxpRoP2dII/Pc6560+NtisPr/25YqwASjaliypTXY8B8K46G6ZiermSlc0AtnvZqBSlphiHoLwY2SLlGqymscq01G5HGQuFRLe4ayBbgQMI1hb4occ+xRW/icMNVQ+GcNJgdHTe0SjF9FN3bGSKz633P7eEdMCVPkUOYusSutgRXIPzMpOnvrCO90KTPM4Ltc//4F8GJs/0KWCtg/6SDfdKwlbPzFSvgKN5zjFD2gJ7RFnxOPwQ4W9+SXLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHLf59T/5/IMJP62ikH2yQRmrblzIsyKZKINDV19Hhc=;
 b=KOIVuETspQqkqdhueehDSRJslQdvLELaIXN0scCLSoKtRVGnXEmZ33+pDjtPZmsmmbRrrgLtVXBrZLKcmon9mBZoposSM893LzyzDeAh8oov/j3qYfP1Lq99J8m3M/pMwC3M3eS9rb9A1jRY9NSw+Hv77axneRabloyFaK/H+Rs+6jQsViUQj1yy7nCgvqgZHcQ3g9R7vU4WqoWUDko8fL99bHIL+ln/s4pA5VxpRSdz5fAWVdA/AfAN/erjf8psismd0PD8nLOBAdgqIvoQTk0xcpv0jkBv0Hcm7Ior6LgBGhymo8RtWtnA8uZwNtYlJSb8ktJ944lhBsvZh60sQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by MW5PR11MB5908.namprd11.prod.outlook.com (2603:10b6:303:194::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.43; Mon, 19 Feb
 2024 02:11:03 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::f8c9:b23e:f29d:7a41]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::f8c9:b23e:f29d:7a41%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 02:11:03 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Jiri Kosina <jikos@kernel.org>, srinivas pandruvada
	<srinivas.pandruvada@linux.intel.com>
CC: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] HID: Intel-ish-hid: Ishtp: Fix sensor reads after ACPI S3
 suspend
Thread-Topic: [PATCH] HID: Intel-ish-hid: Ishtp: Fix sensor reads after ACPI
 S3 suspend
Thread-Index: AQHaWySUd4KuM0noeUu7frgnDt/LqLECFfWAgAYDcQCACOHmcA==
Date: Mon, 19 Feb 2024 02:11:03 +0000
Message-ID: <IA1PR11MB60983C42AF98AAA481034EC7F4512@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20240209065232.15486-1-even.xu@intel.com>
 <64ee580b9969335d60966e23e9bd859e8f075953.camel@linux.intel.com>
 <nycvar.YFH.7.76.2402131131250.21798@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2402131131250.21798@cbobk.fhfr.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|MW5PR11MB5908:EE_
x-ms-office365-filtering-correlation-id: 5119eb2a-5a6f-4d20-e192-08dc30f00633
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MA0tg3K6LzOubeTkmsACZf5jNaxnhju4OCYZ/3GHn3vlfc3R7aveNxmDc6UBAt7C+oLJf7VtmdNrp+JwOGGwgz/8VdnoUjPXHkYsII+qIS5QoP58ykhDb1BfNhANKQqNSehwK4qbuZOTYYgQa3aQx7iD1r3eM0y+H3AXTCV2BrYVGSTAUl05Y6UOf2zrESMQ88pDgDs5R7Jwn8PadMAcO9UscRi/lAwYOM0MGoDT4ghwNipCcHlRTW2njjHGOrEXfp2J796etHDMbK81rGfBXsycHHV/OSULTrcTpFSOrEo3OSfEsXoipIQoZHm+KUBtoPBWoYCLSJ+QOPMWF4ighsOt8+3X/9h/Dg8rQ8FdFe99KmrUExDZ1U8nJdDEIKuRcD+45dNHCMFojGtXe+eqWpkROv3UqFnxO74uWSHXWnlBy2rTdKHfZgyXWGPzro4sAwe7dBvrUYhs3NujjOF1jkxEL3Yw3qY8u4/0aVMJbGNzg4wOfLy+mVtljbGefBwDacL8nD0rdICv3814TtDj+3coPYBkKN83tV2qSK9imQC/obYsPiKZBQjEKK0CJChK093qjQ+hHRkUJ6jpUed+ZEWYJaajvGjt98OqCfHCuiQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(52536014)(966005)(8676002)(2906002)(5660300002)(4326008)(15650500001)(4744005)(8936002)(54906003)(82960400001)(83380400001)(26005)(38100700002)(86362001)(38070700009)(33656002)(122000001)(6506007)(7696005)(76116006)(316002)(66946007)(64756008)(66556008)(66446008)(66476007)(110136005)(53546011)(9686003)(478600001)(55016003)(71200400001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vxd28RMXiwrTxvlS8Hh0VXqa0lnvIDleTS5yZTaxNUzQKHBgW60SBYhf3h/u?=
 =?us-ascii?Q?UmLH5tRZFqL6RxIyAwaxyzYoRjokVLrv6IVNDLk664htxuMyd3PHTY7e8DGW?=
 =?us-ascii?Q?t2A6u83+ZJ2lxkNPyPGlTKsccsmh4sihIxey5ZG3QwiarnpPYCem+RsnyG3D?=
 =?us-ascii?Q?ED8FHsoCEdLuUnC/G01mMYcqQJeOeDTPcqyOnW9p9Dxp9ARsW8jGVJfKCcjm?=
 =?us-ascii?Q?rQd36L/BnzH4MrgL1DnJSVZZcR8tFm9TyQ7b5+05UpouEF5levyeY4FHj+r9?=
 =?us-ascii?Q?xiQbZ1S9RFFhnwRJlhggg6Zk69JhB++8rtiBDwmlLgVmjHMNqyukiVlail+U?=
 =?us-ascii?Q?n4TwcWhzEw+rhPsWeysooSQHMdzn7oX3ZRs5K3ehsRBdGJ/TRWC4BcR3k2ho?=
 =?us-ascii?Q?c8HiAGcA67LlIl88/0AQBd9Hv5Zk3W17IFxzRxUjABDam0BLElar1zD5BU8Z?=
 =?us-ascii?Q?KO3pVDVoSUR79AaHNe5b5KDeyq1Zn2BzbAV1qWQ+LaVotrsj6MGlHY46XBwS?=
 =?us-ascii?Q?emR4dCqprE4cRfhW+k0KlneVix5ntHdVCZzvedbOBlDejH3FrnDohesPQSf2?=
 =?us-ascii?Q?C+9C4alwXd49Cx94RjmSdCYFBO7/aw110R+teJOQeQ/U0w3FsozZXGJrhutx?=
 =?us-ascii?Q?Mv/0LCOpoIpYZQxkrEG8xrRcoEDYv/AnkT3sBxAB96lbuBQkYdT+e5QBqdev?=
 =?us-ascii?Q?cSo2aTpniTFEoskDOW3sYpYfqP1Fr/UpMcdjtGacGwr/K23bqBIc+tSqmuQg?=
 =?us-ascii?Q?AB2BY/+gfl/3ns1Ar4CsH9Pg6TKlAF1qRO1W5p+uBI/cszyxn++0bd9+2Tme?=
 =?us-ascii?Q?juVsRXekuDRoh7esLBEh+433xEaPNje4PGzJtZ+qKLqJ4cHdTv61b9rzjlf9?=
 =?us-ascii?Q?Rh/wmFN8dAM5uyOHYlNklaXm9YIzIEJ5eyfw3MIFhVP80GZy2/gKsgPpbnIy?=
 =?us-ascii?Q?Lke8Ywwgm1CNNOwDBZuDG54dV9yF2XEZq3qJQORoxcNYM2k4N64ABMtjp+tY?=
 =?us-ascii?Q?F5CvLjvgVzgOtRplZHnx6V3+CJJHJPi5RC9rPh2t7DyQaKNII69jPieQfs7y?=
 =?us-ascii?Q?tHoBt0cJOcKSuQ58O/EY26JyuIQVkncT2TwQrW2VCXIrRBtKfQi3v7mE4YxS?=
 =?us-ascii?Q?8rNsXqRo9Sr7TNHrha1cKQRetL5H9ECw14diZ4vZRNBFeHmPsXhA7hGgLmIH?=
 =?us-ascii?Q?23j48/YVjvJ208Jr6EYf+baZjEBU6mE9+KD2MdyvH1BH3fnhYEVBqLFg1+Jp?=
 =?us-ascii?Q?gwxBm28C8iBvuBij3P9HB473KezTb/iM8YsschtdvTvxYVb1lumBlKHFSaG1?=
 =?us-ascii?Q?TVEu66jwMNp0yRocGj2iyZyqzIOF+RYirhQ0qPzxCrA3brxUmMTGYbfMivqQ?=
 =?us-ascii?Q?55io1pV1M1Eaf+O3FEniYGSfu+zjluKE4td7gna2dPeOVJ7iV5top8RgvRbo?=
 =?us-ascii?Q?uUhkE1fMmvl9DohYW2q2/PyeMlmlpi+ZNcYK8w2Wv8Xyi49fnyhg5PJme+4g?=
 =?us-ascii?Q?1WjzjzJ4xVdP/QbcAb4Gw8sjK722tNLgt8/yAafkEviWUI5JBFxD/+2iSJFL?=
 =?us-ascii?Q?494dqJHYTJs7mhUVXak=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5119eb2a-5a6f-4d20-e192-08dc30f00633
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 02:11:03.3619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ewSg1vTvr90QY5kadcLj3qVNhxxkhLvqoS1nRE5YW71AgmH4iXOE6dDTy6XEmncy6kDW43/3llyyg0CKG8mt8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5908
X-OriginatorOrg: intel.com

Thanks Jiri and Srinivas!

Best Regards,
Even Xu

-----Original Message-----
From: Jiri Kosina <jikos@kernel.org>=20
Sent: Tuesday, February 13, 2024 6:32 PM
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Xu, Even <even.xu@intel.com>; benjamin.tissoires@redhat.com; linux-inpu=
t@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: Intel-ish-hid: Ishtp: Fix sensor reads after ACPI=
 S3 suspend

On Fri, 9 Feb 2024, srinivas pandruvada wrote:

> > Fixes: f645a90e8ff7 ("HID: intel-ish-hid: ishtp-hid-client: use=20
> > helper functions for connection")
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218442
> > Signed-off-by: Even Xu <even.xu@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>=20
> Hi Jiri,
>=20
> This regression is introduced with 6.8-rc1, so need a pull request for=20
> this rc cycle.

Right; now queued in hid.git#for-6.8/upstream-fixes. Thanks,

--
Jiri Kosina
SUSE Labs


