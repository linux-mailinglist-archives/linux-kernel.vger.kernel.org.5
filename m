Return-Path: <linux-kernel+bounces-27017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4C282E939
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068AC1C228B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C27F507;
	Tue, 16 Jan 2024 05:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VZ0ShFkb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121A4848D;
	Tue, 16 Jan 2024 05:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705383645; x=1736919645;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uNOnouCTGoqaJgI9qxLyr+kKNiu/YyVu+gItTjamiLs=;
  b=VZ0ShFkbhuhTCrDvUJyXk6FgLclFtZ4avwqfHcK5bUtGxqRGEJ2d1Wzl
   8EABjkyzQo4jQDf0ahvc/f8iO0qQN7AtE6uwR5h3if09Y+MBWwIu10xpm
   mF2w+flxaJvveZ8X5ESxNXlz7cqTQNK+TDxMy7YAvn5BMkzl/I8E5HM0I
   ZxEWl2R2Vg1/HME9+MoFuz7MABn27OcJphf6ggObbnN9B9JhAi8t2H4ja
   GKniK8M6mHh038z9wBZoki3xnHcYYSkgKs3Oi6X60qfDQPIpZDteQzcIu
   f3MZPRCyltdwuhUUWUgeomncrI97LI/NS26dZPVFKAf3gMUL4fYxVkfmW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="21236249"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="21236249"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 21:40:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="760063965"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="760063965"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2024 21:40:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jan 2024 21:40:43 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Jan 2024 21:40:43 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Jan 2024 21:40:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wss3KuJN1n7T485VWJLx3y8XazraGB1T83PD0seD7M0b2VZomgScsK9iwAJ+kqr61CFUOK20+YSKhv4CfNSI/YafMqijqHGHV3xSUARHb/uRCm+1pxjuSn7/nwH0hTwrCCNHUKu7L+x8f/0ElY7MMCVM6mFR+lDCMePS+5hJ3Qx3K3utAGX2IG9BeIKQV5qKm4Fu3HdsPNEgesLnK80IoJARvtgaEYzhcgiMpftvGYqg0Gm2qFiVvOYaPQgP7lzm4iz4U89B1iWqBS8wkNzQyg5hCPpVES2ktVEv8j9iTRp3GnqHRE51o/xVFxOwteekKCJop3B1iuYjk9lnytQqdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNOnouCTGoqaJgI9qxLyr+kKNiu/YyVu+gItTjamiLs=;
 b=JBu3oufGgwWkEpDPogkDNe1WOsylf0JE1KlHM+L72tWkIUKhgNN/FLe3yjP2rpBe0d86I2ID7rLBtt0wGPZJG3T8K/siwxLpEgHrrcGraYh3VoprfVo7NELqlqH0SXKCNtEpKyupAjB1yJ/zbTg/J08OobueVYRbcZfx6ij2epxMEfAyMQdv2Qdqr1K004jn6a6KfyVjUKOKyHxFsrSrk4sGDO5DsEWbzd7HiLXmFAQK38CJzyFghnF9mP6G8bCg7J+rxN1s/X5eX/xBPBfrAvJ7SGM1tyoMib4D2LRdGlve2ChNmHnGn79/p3X15aTyhDZv2lkgd5s3dER5SXBTxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by SJ0PR11MB5648.namprd11.prod.outlook.com (2603:10b6:a03:302::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 05:40:33 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::2579:9681:f8b5:ca71]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::2579:9681:f8b5:ca71%4]) with mapi id 15.20.7181.019; Tue, 16 Jan 2024
 05:40:33 +0000
From: "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
To: Peter Hilber <peter.hilber@opensynergy.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
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
 Thejesh Reddy" <thejesh.reddy.t.r@intel.com>
Subject: RE: [RFC PATCH v3 00/11] Add support for Intel PPS Generator
Thread-Topic: [RFC PATCH v3 00/11] Add support for Intel PPS Generator
Thread-Index: AQHaPjvbeo56FQye9EuoBkh8cNhPW7DM6zQAgAQhyxCAA32jAIAHdFog
Date: Tue, 16 Jan 2024 05:40:33 +0000
Message-ID: <CY8PR11MB73646780CEE6CF49B0E35359C4732@CY8PR11MB7364.namprd11.prod.outlook.com>
References: <20240103115602.19044-1-lakshmi.sowjanya.d@intel.com>
 <ZZlvqvYQQuse_P4E@smile.fi.intel.com>
 <CY8PR11MB7364D6EDCCBCCDBF9DCB0BE5C46A2@CY8PR11MB7364.namprd11.prod.outlook.com>
 <4b863e76-31f1-475d-9056-764439318010@opensynergy.com>
In-Reply-To: <4b863e76-31f1-475d-9056-764439318010@opensynergy.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7364:EE_|SJ0PR11MB5648:EE_
x-ms-office365-filtering-correlation-id: b261fd37-2ad1-4b29-8d94-08dc1655a86e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gqgshSYBACSXg90UUyVS2ZEVzNYGhDKnPJPKB19uFHDevzbTSVT4NgvF79XizvTpPqXWu41lB9KWCFjLGJpyTxY0PCKip+kBIXUFI49ImyhQ++8qXPs/NWTnoFVdjl4YtYuA3AXOA9aRUm1JYgaBcfgdM2JwJg4WB2A6Ez25ehjSbkqpMnf/wmx8XK8aXM6dwINIcSuamwpQrqQm0Uk3zfDzd13N/f8na/miqSdZ/SINISQxZtbZMLctlqjCf81KIHjDsJYT/16gilduaxYjNLD4+xCZmMOAp+QVSbsOiyb1CAxYb6ed2YQOtUymKxkF9IRSzuBG6pbhx/U5IUDXbY8s8yWeJPvyA6C3/9GnWKehAH1wGv03JEkqRdBVHaYh/PIPmvzwGnMEwrkhnBbn48UFPk2rr5H6i4nf/HpYsBbYqyTUtoH4W0/m/BRZTLd2IZsVtb/THVD2R2WuFw89tOR/KnnptajqTxwLWdkyZUFyndm6k159nrqcO9fwX9gn1uZL4bV9trBtlrXiM5cEKauSZHAwsvYrIVkT6pR2qmEU1qqIuxwhy7ZB7+c/KRz5f49/mBE0xX0gtKmH2So1PPSydRCzcdIfx9X3ELun1Mo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(9686003)(53546011)(26005)(83380400001)(8676002)(52536014)(4326008)(110136005)(5660300002)(478600001)(41300700001)(2906002)(966005)(76116006)(66476007)(64756008)(54906003)(316002)(122000001)(66556008)(66446008)(66946007)(8936002)(33656002)(82960400001)(86362001)(38100700002)(71200400001)(7696005)(6506007)(7416002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THNHVjZRdXpwVnoycS9NeDhOSFJXbjYxZElKb3ZTWnFkZ3NzVmRCbi9LanN3?=
 =?utf-8?B?THY5eHdOZEFMSVhDK25ScnVUNE4xQVRFV0FlWE5ESTVCaVdLS1ZEY1pRZ1c4?=
 =?utf-8?B?WExZUVE2K3RiVDBmSHRIZERHeWx5bU1nT2hOWStVMUpvL253b2RBSnNGWlVl?=
 =?utf-8?B?Z1FmSEVqVTZKd0R2QkU2UUo5T0tia0ZEZjREcmtZMlZPRWxrOEFZUWdjalox?=
 =?utf-8?B?dDluWk5lVERtM2tNSWNIeUxyZmNCMmJEVytPQy9WcnRYMUFGOTVvTUVtaXQw?=
 =?utf-8?B?K3V6aDdFNW1NSzJoaW9mOUo2ZkZlTFdVY3ZBT1dhSDVMUkQzY3NmN29Mbzh5?=
 =?utf-8?B?ZGVYbzJSSmFzOVpnY0xnZlRpT0FySXk5U0pLTmhwS2NZNlo5RWZiano0OWNI?=
 =?utf-8?B?c3NXNjhIMTUwdndDSmMrbWttc0NUT2FENVZnM1NYNjNZeVVYTXo5Ty9uWHda?=
 =?utf-8?B?TWJlc3FzL3drMSswNktnenMyelhZR0tCYTd5S1FuNXM1V292R0VLRW5VeCtE?=
 =?utf-8?B?S3NFRjRTODdUaWlFdFYwRDlROGt2d2Y2Z3l1aXJHN0FDMHFGVWVSa3lrWndX?=
 =?utf-8?B?K0IyOFV5aEFIMzI5RmtRT2oycFlBYTdSVyt5VVVrSllRRndyNy92Nm9TN1dm?=
 =?utf-8?B?aFY3aVJZSGJRVjNCWDBFa1VGVVlDVUg4Wisyd0tmWEFOQVU0ZnNhUWV1SFp0?=
 =?utf-8?B?cWRBbG5wWWZlVnpZTnlkdWxLTGpiV1JySnNZcDVNRGhsM2RaZS9WVlZ4Um5M?=
 =?utf-8?B?Z21oemhYN3dJYkt0M2xWempjRGZPbUoxTUZkRVRyeG82YjRmeDlPN09yNVR4?=
 =?utf-8?B?S21oNmhmODl5Um15NjRPN3lYKzUwTFo0UndCTXp2Q25RejNidldoNDJya1RZ?=
 =?utf-8?B?TS8vV0R1YUlEamUrMnBwSWN4bUVWaStZbjVhaitIU1pqVEg3UGh5WERJV2VG?=
 =?utf-8?B?Ums3WEZrZU1LMERkWksvV3RWWG9CQ3BoL3owVnI1MEtjUWcvZWQrZU9jejFT?=
 =?utf-8?B?YTZtYW9xUThoc05MQjdCd1JwcVJFd084U0RwMUFxRyswS3kvdW4yajZWZWxG?=
 =?utf-8?B?Q1pWdFRqWlJVTmFCbXIrWVNOdFlmQzZmQ0tBZ08xMGlhYnZaWGxJdEpyL0w4?=
 =?utf-8?B?WGxLZStSbkMya1I2eGNPVkRaSFNKZ2RkTmNSRkJ3bDNjVU94NFcyTDFKS2Ex?=
 =?utf-8?B?OGJRRjR4L000TWhCWjI4eFVMTWZTMXlHbHZOZnltR0JCZkk3YUNRNDdVTlNJ?=
 =?utf-8?B?YUFBQmx0bXhGZnY0SlVwb21JdFVUdGlVSnkybzdBbzhhQVNkSDNMQzhzNHdG?=
 =?utf-8?B?am1mSlJaTnN4UUlhbHlWd1BXVURlYm9qd0hlekk3V09xSEFHSmNrMENIR2Nk?=
 =?utf-8?B?ZysxaHBxdHJKS2tiTFV0Y1dGU0dmMHFxa2kzbys0dE5Nd0RkRmozaEVzOGhr?=
 =?utf-8?B?MlJVMjd5SmlCbzdMNWkwRGpzRE04YXY4SDBqcFBqalJJaEo0eG1aVjZUdy81?=
 =?utf-8?B?cmpKS3BRTHd4QlJnMHRhYS9oNnNQM09qaVhhZENzSHRNaGJ6a01yYTU0SkhE?=
 =?utf-8?B?eExJanZvMDIwVXR2ZXBCKy9KeDVia29EeDhLWk9zWDl4WkRZNzRvMkJOblk2?=
 =?utf-8?B?UUpKakRCa2NZRkhxL2hlbjdrak15dnpGRy9GSEo5bXdJNlJqUktzY2RqRHlI?=
 =?utf-8?B?WE8zaFJreEU2aE0rdnllUGI5cTZpTlpVTTNLTDF5MHBNekZ0UDJXUVNNYlI3?=
 =?utf-8?B?eXNrYTZUTjF3MVlQcXV6dTZkcGFCNGhsem9HbTA4VFJ2cFE2dlgyVjVBazJi?=
 =?utf-8?B?UThTVkl5VGlKbm1SOHp0UnpSSUowb29NOXpyNUpOeGd0TVlmbjlUNjlwaHhZ?=
 =?utf-8?B?d09mMGJiejMwYVpKY1FaeXc4eEFHcFhvRXhuVk9USUJjM2ZtSlI3cE1MN1lH?=
 =?utf-8?B?UzEyNnIwdWZsaFNxMlVLdHhJOXpTazJabkJpQXpoSzRJRC82NmtpamQwT2lV?=
 =?utf-8?B?OGM2QTRvSlNiVW9ZcUVkQmdsZnFXcmxJZHV6VXJ5NE5yZVVDUjY2aENuNHZr?=
 =?utf-8?B?NEdOdlBZOWVsWWY2OVdUajNiYmIzZ0NYRXlEYklUbVNmZDZqakxtS01iVWZK?=
 =?utf-8?B?RjE2dENkWktReTdtTldPTHl3NG45R1VPK0pHRnk3Ulh0Rm10RTNVc2JrWWtq?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b261fd37-2ad1-4b29-8d94-08dc1655a86e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 05:40:33.3024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vn4Lvjlsdy4gVYONeBKCB5eNegMJLF1vgd6Li16rn3U0xuHCtniComT5iz+nZSEoj7TlwYzI91aKg0zM8kbWdT2j0qSOSReJIzH2mqGeoPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5648
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgSGlsYmVyIDxw
ZXRlci5oaWxiZXJAb3BlbnN5bmVyZ3kuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSAx
MSwgMjAyNCA1OjE1IFBNDQo+IFRvOiBELCBMYWtzaG1pIFNvd2phbnlhIDxsYWtzaG1pLnNvd2ph
bnlhLmRAaW50ZWwuY29tPjsgQW5keSBTaGV2Y2hlbmtvDQo+IDxhbmRyaXkuc2hldmNoZW5rb0Bs
aW51eC5pbnRlbC5jb20+DQo+IENjOiB0Z2x4QGxpbnV0cm9uaXguZGU7IGpzdHVsdHpAZ29vZ2xl
LmNvbTsgZ2lvbWV0dGlAZW5uZWVubmUuY29tOw0KPiBjb3JiZXRAbHduLm5ldDsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgeDg2QGtlcm5lbC5vcmc7DQo+IG5ldGRldkB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGludGVsLXdpcmVkLQ0KPiBsYW5AbGlz
dHMub3N1b3NsLm9yZzsgRG9uZywgRWRkaWUgPGVkZGllLmRvbmdAaW50ZWwuY29tPjsgSGFsbCwg
Q2hyaXN0b3BoZXIgUw0KPiA8Y2hyaXN0b3BoZXIucy5oYWxsQGludGVsLmNvbT47IEJyYW5kZWJ1
cmcsIEplc3NlDQo+IDxqZXNzZS5icmFuZGVidXJnQGludGVsLmNvbT47IGRhdmVtQGRhdmVtbG9m
dC5uZXQ7DQo+IGFsZXhhbmRyZS50b3JndWVAZm9zcy5zdC5jb207IGpvYWJyZXVAc3lub3BzeXMu
Y29tOw0KPiBtY29xdWVsaW4uc3RtMzJAZ21haWwuY29tOyBwZXJleEBwZXJleC5jejsgbGludXgt
c291bmRAdmdlci5rZXJuZWwub3JnOw0KPiBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5n
dXllbkBpbnRlbC5jb20+OyBOLCBQYW5kaXRoDQo+IDxwYW5kaXRoLm5AaW50ZWwuY29tPjsgU2Fu
Z2FubmF2YXIsIE1hbGxpa2FyanVuYXBwYQ0KPiA8bWFsbGlrYXJqdW5hcHBhLnNhbmdhbm5hdmFy
QGludGVsLmNvbT47IFQgUiwgVGhlamVzaCBSZWRkeQ0KPiA8dGhlamVzaC5yZWRkeS50LnJAaW50
ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAwMC8xMV0gQWRkIHN1cHBvcnQg
Zm9yIEludGVsIFBQUyBHZW5lcmF0b3INCj4gDQo+IE9uIDA5LjAxLjI0IDA3OjMxLCBELCBMYWtz
aG1pIFNvd2phbnlhIHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPj4gRnJvbTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51
eC5pbnRlbC5jb20+DQo+ID4+IFNlbnQ6IFNhdHVyZGF5LCBKYW51YXJ5IDYsIDIwMjQgODo1MCBQ
TQ0KPiA+PiBUbzogRCwgTGFrc2htaSBTb3dqYW55YSA8bGFrc2htaS5zb3dqYW55YS5kQGludGVs
LmNvbT4NCj4gPj4gQ2M6IHRnbHhAbGludXRyb25peC5kZTsganN0dWx0ekBnb29nbGUuY29tOyBn
aW9tZXR0aUBlbm5lZW5uZS5jb207DQo+ID4+IGNvcmJldEBsd24ubmV0OyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyB4ODZAa2VybmVsLm9yZzsNCj4gPj4gbmV0ZGV2QHZnZXIua2VybmVs
Lm9yZzsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgaW50ZWwtd2lyZWQtDQo+ID4+IGxhbkBs
aXN0cy5vc3Vvc2wub3JnOyBEb25nLCBFZGRpZSA8ZWRkaWUuZG9uZ0BpbnRlbC5jb20+OyBIYWxs
LA0KPiA+PiBDaHJpc3RvcGhlciBTIDxjaHJpc3RvcGhlci5zLmhhbGxAaW50ZWwuY29tPjsgQnJh
bmRlYnVyZywgSmVzc2UNCj4gPj4gPGplc3NlLmJyYW5kZWJ1cmdAaW50ZWwuY29tPjsgZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldDsNCj4gPj4gYWxleGFuZHJlLnRvcmd1ZUBmb3NzLnN0LmNvbTsgam9hYnJl
dUBzeW5vcHN5cy5jb207DQo+ID4+IG1jb3F1ZWxpbi5zdG0zMkBnbWFpbC5jb207IHBlcmV4QHBl
cmV4LmN6Ow0KPiA+PiBsaW51eC1zb3VuZEB2Z2VyLmtlcm5lbC5vcmc7IE5ndXllbiwgQW50aG9u
eSBMDQo+ID4+IDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IE4sIFBhbmRpdGggPHBhbmRp
dGgubkBpbnRlbC5jb20+Ow0KPiA+PiBTYW5nYW5uYXZhciwgTWFsbGlrYXJqdW5hcHBhIDxtYWxs
aWthcmp1bmFwcGEuc2FuZ2FubmF2YXJAaW50ZWwuY29tPjsNCj4gPj4gVCBSLCBUaGVqZXNoIFJl
ZGR5IDx0aGVqZXNoLnJlZGR5LnQuckBpbnRlbC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUkZD
IFBBVENIIHYzIDAwLzExXSBBZGQgc3VwcG9ydCBmb3IgSW50ZWwgUFBTIEdlbmVyYXRvcg0KPiA+
Pg0KPiBbLi4uXQ0KPiA+PiBBdCBzb21lIHBvaW50IHlvdSBzaG91bGQgYW5ub3VuY2UgdjEgb2Yg
dGhlIHNlcmllcy4gUkZDIGlzIHVzdWFsbHkNCj4gPj4gYmVpbmcgbmVnbGVjdGVkIGJ5IG1hbnkg
KGJ1c3kpIG1haW50YWluZXJzLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXJpZXMgaXMgZGVwZW5k
ZW50IG9uDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDIzMTIxNTIyMDYxMi4x
NzM2MDMtMi0NCj4gcGV0ZXIuaGlsYmVyQG9wZW5zeW5lcmd5LmNvbS9ULyB3aGljaCBpcyBSRkMu
DQo+IA0KPiBTbyBJIHVuZGVyc3RhbmQgbXkgZGVwZW5kZW5jeSBzZXJpZXMgYmVpbmcgUkZDIHBy
ZXZlbnRzIHRoZSBQUFMgc2VyaWVzIGZyb20NCj4gZHJvcHBpbmcgdGhlIFJGQyB0YWcgKGNvcnJl
Y3QgbWUgaWYgSSBhbSB3cm9uZykuDQo+IA0KPiBJIHBsYW4gdG8gc2VuZCBvdXQgYSBub24tUkZD
IHZlcnNpb24gb2YgdGhlIGRlcGVuZGVuY3kgc2VyaWVzIG5leHQuIFNvIGZhciBJIHRoaW5rDQo+
IHRoZXJlIHdpbGwgb25seSBiZSBwb2xpc2hpbmcgY2hhbmdlcy4gRHVlIHRvIHRlc3RpbmcgYmVp
bmcgc29tZSBlZmZvcnQsIEkgd2FudGVkDQo+IHRvIHRlc3QgYW5kIHNlbmQgaXQgdG9nZXRoZXIg
d2l0aCBzb21lIG90aGVyIHNlcmllcy4NCj4gDQo+IEJ1dCBpZiB0aGlzIGlzIGJsb2NraW5nIHRo
ZSBQUFMgc2VyaWVzLCBJIHRoaW5rIEkgY291bGQgc2VuZCBvdXQgYSBub24tUkZDIHZlcnNpb24g
b2YNCj4gdGhlIGRlcGVuZGVuY3kgc2VyaWVzIGVhcmxpZXIgKGJ5IHRoZSBlbmQgb2YgSmFudWFy
eT8pLiBQbGVhc2UgbGV0IG1lIGtub3cgd2hhdA0KPiB3b3VsZCBhbGlnbiB3aXRoIHRoZSBQUFMg
c2VyaWVzIHRpbWVsaW5lLg0KDQpUaGFua3MgUGV0ZXIsDQpUaGlzIHRpbWVsaW5lIHNob3VsZCBi
ZSBva2F5LiBXZSB3aWxsIGFsc28gc2VuZCBub24tUkZDIHYxIGJ5IHRoZSBzYW1lIHRpbWUuDQoN
ClJlZ2FyZHMsDQpTb3dqYW55YQ0KDQo+IFJlZ2FyZHMsDQo+IA0KPiBQZXRlcg0KPiANCj4gPg0K
PiA+IFJlZ2FyZHMsDQo+ID4gU293amFueWENCj4gPj4NCj4gPj4gLS0NCj4gPj4gV2l0aCBCZXN0
IFJlZ2FyZHMsDQo+ID4+IEFuZHkgU2hldmNoZW5rbw0KPiA+Pg0KPiA+DQo=

