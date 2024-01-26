Return-Path: <linux-kernel+bounces-40398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A207A83DF83
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574C2282035
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9141EB24;
	Fri, 26 Jan 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jOjb1lX1"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE321DDEB;
	Fri, 26 Jan 2024 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289026; cv=fail; b=OErthwsua4lIeQoK/8IzBuuOT5aqbDjEa1K3HGdCrxkutCxpYygy61N472d/0mYd86oxp0cCqgBxCLRQjR5vAwvg6zWF8evjTmMoy0E5WWUYV33SVcZQ9I9K/espvxOv2YbbgFCydXtn1s7MAdpYJO8zu6LssH0LQrYE7kfG6IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289026; c=relaxed/simple;
	bh=gM86mgDE0AnGltU6UmUoyNqG/JHOAc9FdjSP63Xe69Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kw92aN4dl0oyNVcVabnuZjhqg1c36gcJ1MrxWJfKpj6dPwNFX1VvJhsPH6/K1PLPwdwujbURt2Mhdf1doQ0PxuzAEu0T4aQxlNovfW/Z0AnJ/l6awU9R+PpYwDGGDZqy/VLE7FB/brZmSK4qb8bHNIe3KZBTGxaYQnlEYyeXFRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jOjb1lX1; arc=fail smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706289024; x=1737825024;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gM86mgDE0AnGltU6UmUoyNqG/JHOAc9FdjSP63Xe69Q=;
  b=jOjb1lX1ooB+MoUnj+6MwPuBLzYZYx5kGx2xAU/NUhDkesCo/5yIAciW
   PIcMkxk5qzEbKKpOe52wUaCVgQnXvGK4pyxNGLOd5+ZmDuGnqZRVqkLNg
   NrsVLHeLbcpTeVdUP+h1kCIjFFqBJ2GSU1KjsrsDI1wprqD1iSGY214jr
   /3Ott3PSTMdKDbafQIe/MtaM/A4pfyzvIx3cf1iqq+5DlwaTfpW6jDgdA
   bMI+wp15sWMm0jhpr1EgaIH2q+p5oy0rnhCwMeit1nWpUaFsnXfx1eK5W
   7RWtxf2aUMVG1zMPf3ZCVJe8VBqMFmhFTW+/CWr4fQQqjIuor57HApzYT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="399680329"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="399680329"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 09:10:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="28876975"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 09:10:23 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 09:10:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 09:10:22 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 09:10:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iu66Ov0CrCvLk1VgC+LhDH2kZUbA+ePBMnzLQ+JpAiI+Lwci7TTrZv9WPxTIfvbIfcAfHp7M2/WA8MBnPkdkn1IWh0OIME9UOJEkfmebdEHvCrQOugNC9AKNJsU2Jj1Z6tERQOLfvY+ZXvcFa/jOfGl2IDAJRn1sJwkFdQgK9QCO9Y2YWxJTExiRsgnkB2FXyJQ6xhdLyUg6sUsA8lK3aEiQGyKGDfNsrufkJzQQ5CSuv6FZal6IBujRNRYYguIRnPe2eaSVELzwZfpZ0sOMJKAqbY39aaYtKTUcJz3kQ7i9TQI3+yvbgc0x6ejOSKWIouRufZrAQLOyQ+gyBmJ0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gM86mgDE0AnGltU6UmUoyNqG/JHOAc9FdjSP63Xe69Q=;
 b=m65GhgkvPTM9DakC8OtE5P3L5XLDijPQuRomz0j3FZDjMhfG9PmrgCAOCwDcfsl0rudh4qfUc5UX85rUDNCHsIxuxh9UYdGZyhLWGPRIITlnqKAN9fa5BYWoZqnehmwx+U7NgGN/f5CjB9iZw466LQcqrwiulQXFfMTJN/mfOZ32iV3fqU4wHzky1K/CqAX0p2KZRBAJE5anc4iotrRA5XKT4olnP4Xcu+0f60XPCivhEcOrPK23WLPSaCuOu2+nOuGiS89oyNBZ3GL1j2MaX9Lm3ixKeDhu1NX8DSdGTTLy7V/mKhGwjuYTKcWBnw9cqUWlhGFHvD1xZo/pX9tmvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW6PR11MB8411.namprd11.prod.outlook.com (2603:10b6:303:23c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 17:10:20 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a136:fb19:acde:7670]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a136:fb19:acde:7670%7]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 17:10:20 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Avadhut Naik <avadhut.naik@amd.com>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>, "avadnaik@amd.com" <avadnaik@amd.com>
Subject: RE: [PATCH v2 0/2] Update mce_record tracepoint
Thread-Topic: [PATCH v2 0/2] Update mce_record tracepoint
Thread-Index: AQHaT780LVN5GzQCtkupW37k1NP6AbDq4W+AgAACUMCAAQE/gIAAbNLA
Date: Fri, 26 Jan 2024 17:10:20 +0000
Message-ID: <SJ1PR11MB60839509241AA98A59B78D15FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240125184857.851355-1-avadhut.naik@amd.com>
 <20240125185821.GDZbKvTW93APAiY1LP@fat_crate.local>
 <SJ1PR11MB6083DAA7A6EDBBDAF5987A80FC7A2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240126102721.GCZbOJCTqTVmvgOEuM@fat_crate.local>
In-Reply-To: <20240126102721.GCZbOJCTqTVmvgOEuM@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW6PR11MB8411:EE_
x-ms-office365-filtering-correlation-id: cdcf93f9-ad8a-43b8-1629-08dc1e91ad50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /kRBVeiC/p1RWFFkR5hnuUUjdsk2hepM8/6NRh1+P8p8KVKxvubtTxmpqq9nqjfcUP5Th/tHUhE5Qj7aXtWMRIvkGnN5xzjU7OAj7w+9lq3z3Gc6dx6cXzx+8i7OWm6Zmxp72yINPuqsy2RbmX+4t9YnFoxL8jMrfExpQox/Mbl4p5xhMfx+f3JB+mUo29Dn/HcfjwFgiaMirJaOGkh5X56JS8tpQeRug1X/JGvVoUz39RmyWHohsml75RcbkXZ4rymV/M2BwH4y6PU1ZkiCQ9aqqJOLKZsR5LYCxFLysKl4IZcolw+tjzCkrxwbUwhCooB5FRdQGHtfy6SKoI38e6hvUPlBmHyrRq2t+L6BfA/8Ww9Bk7No91vCHeuKlzM4U9X3Rj/wkqu4kQnS+SVQ0TB7+JFhnsv3DvOYNXkTiXyuUuZFKG4xICqi06pCGv9IqgzoQHN6vHE7DUjUietQ9o3MpVnLZYeRyvpqP+aclZgr33N5xsB8L01p8CBQwZIQLvXDfZzqk0MtfSElIn2HhmRiNx/ot5AH7RCJZ61yQXOcHTQswIz3OoPnUsMVC4lsZ8SCPj/5dztC6KxIsAH5jEPysRaPxOeeG7gew/1HCXBtvXYEMYXJHn4T048+4wVX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(15650500001)(33656002)(86362001)(41300700001)(7696005)(6506007)(71200400001)(38100700002)(66946007)(26005)(55016003)(76116006)(54906003)(6916009)(66476007)(64756008)(9686003)(82960400001)(316002)(122000001)(66446008)(478600001)(66556008)(38070700009)(83380400001)(52536014)(8676002)(4326008)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2ZEd0U1UjVCa1I3MjZYUlBGQ0hRa0I2U3dHanNIOUlCWkdnMWVpRzhXUVg1?=
 =?utf-8?B?K3hKSUx6Q3psc3VUYlJzMVJPVjIzQjlIMUUvU0hROHFZb0pLaXh6bnNDK20z?=
 =?utf-8?B?OUdyTEExV29TRTB3bEdDZE9vSHlSK21tdHpNQ0ppeFNVRmprTHdTMldMSFZo?=
 =?utf-8?B?WlAwZ3Z5M3NnbjVXUitSeHdycnVSQXlLbjRQUGpzTnFyTlBRd2c5bnFXQUtk?=
 =?utf-8?B?UlpyYmZlVHZvVDdCNUZwdlFueUo3NE42ODQvb3U4aDQrZUoyZk9rZG9lbFVx?=
 =?utf-8?B?TFhkMVpYSzhacU0yTDhUd3pjbFpYQmlzWE5DbmxON3hmTDAwN2JDR3VSamdG?=
 =?utf-8?B?K3U0RFNKZjlhUWlyNzVObGVQTENWMklmdEhqc2Y2U3BLZnQ5TUUyc2w2REtx?=
 =?utf-8?B?QUt1YVpXbkdmQTBQdm9xUkhPQTBDeGVWbGE3TWREcmZuRUVHczVUOE5rK2ps?=
 =?utf-8?B?UUFOV2NWZmRuTkI4V2ZkdTNBSDdLUElKVXcraTQ2SlVVbytjZDRSMW9EdFhr?=
 =?utf-8?B?NE02cit1aFZqaitZVHZBSHhKTmN2eEdaNHBiRVlLS1JtU01SNGFpV1YvbC8w?=
 =?utf-8?B?RlNZYThwVW5SNHhPWlBWbWR4YkNtenJ6ajE4RHZFSXQzYTk1SGY3WmRoZnRt?=
 =?utf-8?B?cnVYK2VTNjdGb0tMUVVUMmV4L0ZPR0FJbHN1c2hGUE1xMUhPaERQMkJkUy9l?=
 =?utf-8?B?bGxEeDdHVUJUeXpOL3J6V3FGeGJxT0JmVFdxcWlwZ0VGR1JVZlJKK3pCMFRP?=
 =?utf-8?B?aTkrL3h6U294TGdaNFU0d2g3THl0VnhwMDlxdVJnUmRoZlpQWkIvTzlSZXBG?=
 =?utf-8?B?WW1sRW9xMVNvUjhIMjY3ckJ1bysvNVZ1SUkvMnhtVU5SbXg2N3l6UkRNVUZE?=
 =?utf-8?B?VmFJaDhBNFJiZmpjci9yVmh4UnRxUWFOT2FMYis4MkZ4L1dPajNuNklhSFJP?=
 =?utf-8?B?Tit0bm1panhCTmFqV0FqOFR6Y09hVU5mcURIN2ZtcXNlMTNCbytmZUdObEVv?=
 =?utf-8?B?MXNkTndVUDlwWVU4WEVYbTF0UVF0UStva1ZldWI2WEErdG9US2xqd1JyejNx?=
 =?utf-8?B?SWJFRnhVZmo5eUY5TytKQ0hpd1JFTzZucVAwRVIvaktnaTg3dXhodnVweUFP?=
 =?utf-8?B?eTJCdWJ0RlA4MXJQaVcybmV1aThieStQTlNTa1JIMWVUSFRYcXFZSXVqWmta?=
 =?utf-8?B?RWI5ZE9TYnVnS3hnODd6Qk5kSGk1OUJGZmVzb0ZneENEKzFVaFNnZ3B0L1hy?=
 =?utf-8?B?QVZUSWthclVXRUs4VUxJNm5OVUx1UXBzKytsYVpYNUxRUVkvMFBGTlFEaTda?=
 =?utf-8?B?YjVmNS9vRWk2V2VUbWczVXNOZGJoRWJvanJOK0NLUTRQV2ZnUkpmZ2tVZkho?=
 =?utf-8?B?aDBieVh3RTN1YmcrQ2E5U0tMWWdEVlpFUnlFSjNCL1c3d0JHemhKbFA0T0l4?=
 =?utf-8?B?MFhJZ0U3cllIZTN3U2hzWjdSdzhmMU1ZeUdjSnNDTWlUQ1EwL2pMUStuK0FF?=
 =?utf-8?B?NXBoNkNPem9PcTNDUjM0UkVGZlFIZTlabGRHZzlDejVON0Q2OG5YaktBYnI0?=
 =?utf-8?B?QmdIREtLenBOMlBFT3lHbjhIdm93Qis1NFdzT3hXYk5oMitvYlc2bTh1SHNZ?=
 =?utf-8?B?eUM0d0V1ZWpwRFF2aTVtVExmU3kxaGMxYktCYUJPdHcrNHUwUHpFaVdwU21q?=
 =?utf-8?B?VVJRTWFhMnN2alJiZDdHVExJTjdvcDB1Z0d5SW92ZzNLWVhxS1YxUGpiN01z?=
 =?utf-8?B?SGg1T1pOMU8vM2IvRVZqSFNMUFpRN1AxdVBvL2ZhWUJ5dmppRDlVRHFMQXFy?=
 =?utf-8?B?QVo1bW1BZDE4VGdUTUEvdGFXY3NjRjlHTXQ2dE9taG5OSWtBejY0R25YWEtY?=
 =?utf-8?B?RHVTWjE3N1Z3TjdodXRKWCtXZFZVTGRkK0YvdzIzM0d4WXg2MC9NUTNuWE8w?=
 =?utf-8?B?cUdvN0dBZU5pVmdHcFB5ZWllSnVXNTZkcFNHeFR6NFRTTmwvak5JRElUU3NK?=
 =?utf-8?B?WmlUbU9TdElOT28wS1pLRU15NUdOTkhja1pkUGxEb2VTYWs5b2J4MFlNblVq?=
 =?utf-8?B?RDVoZWE2dEgvVzkybDNYK0xQOEFYa3hZZkNrT0VFSENiZGVseCtsZXJheGNH?=
 =?utf-8?Q?xjgZxgwItU6n/vxkYcFQ+NdXF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdcf93f9-ad8a-43b8-1629-08dc1e91ad50
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 17:10:20.6084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HfWRglBlApuxVoQfnmi2fGdWlk64JS+P8k0LPEJuEKWeZgcCuCLFHp1mBRGyra3oGHU90UH0enfYoUB7hwfvDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8411
X-OriginatorOrg: intel.com

PiA+IDggYnl0ZXMgZm9yIFBQSU4sIDQgbW9yZSBmb3IgbWljcm9jb2RlLg0KPg0KPiBJIGtub3cs
IG5vdGhpbmcgbGVhZHMgdG8gYmxvYXQgbGlrZSAwLjAxJSBoZXJlLCAwLjAwMSUgdGhlcmUuLi4N
Cg0KMTIgZXh0cmEgYnl0ZXMgZGl2aWRlZCBieSAoc2F5KSA2NEdCIChhIHZlcnkgc21hbGwgc2Vy
dmVyIHRoZXNlIGRheXMsIG1heSBsYXB0b3AgaGFzIHRoYXQgbXVjaCkNCiAgID0gMC4wMDAwMDAw
MTc0NiUNCg0KV2Ugd2lsbCBuZWVkIDU3MDAwIGNoYW5nZXMgbGlrZSB0aGlzIG9uZSBiZWZvcmUg
d2UgZ2V0IHRvIDAuMDAxJSA6LSkNCg0KPiA+IE51bWJlciBvZiByZWNvdmVyYWJsZSBtYWNoaW5l
IGNoZWNrcyBwZXIgc3lzdGVtIC4uLi4gSSBob3BlIHRoZQ0KPiA+IG1vbnRobHkgcmF0ZSBzaG91
bGQgYmUgY291bnRhYmxlIG9uIG15IGZpbmdlcnMuLi4NCj4NCj4gVGhhdCdzIG5vdCB0aGUgcG9p
bnQuIFJhdGhlciwgd2hlbiB5b3UgbG9vayBhdCBNQ0UgcmVwb3J0cywgeW91IHByZXR0eQ0KPiBt
dWNoIGFsbW9zdCBhbHdheXMgZ28gYW5kIGNvbGxlY3QgYWRkaXRpb25hbCBpbmZvcm1hdGlvbiBm
cm9tIHRoZSB0YXJnZXQNCj4gbWFjaGluZSBiZWNhdXNlIHlvdSB3YW50IHRvIGZpZ3VyZSBvdXQg
d2hhdCBleGFjdGx5IGlzIGdvaW5nIG9uLg0KPg0KPiBTbyB3aGF0J3Mgc3RvcHBpbmcgeW91IGZy
b20gY29sbGVjdGluZyBhbGwgdGhhdCBzdGF0aWMgaW5mb3JtYXRpb24NCj4gaW5zdGVhZCBvZiBw
YXJyb3R0aW5nIGl0IHRocm91Z2ggdGhlIHRyYWNlcG9pbnQgd2l0aCBlYWNoIGVycm9yPw0KDQpQ
UElOIGlzIHN0YXRpYy4gU28gd2l0aCBnb29kIHRyYWNraW5nIHRvIGtlZXAgc291cmNlIHBsYXRm
b3JtIGluZm9ybWF0aW9uDQphdHRhY2hlZCB0byB0aGUgZXJyb3IgcmVjb3JkIGFzIGl0IGdldHMg
cGFzc2VkIGFyb3VuZCBwZW9wbGUgdHJ5aW5nIHRvIHRyaWFnZQ0KdGhlIHByb2JsZW0sIHlvdSBj
b3VsZCBzYXkgaXQgY2FuIGJlIHJldHJpZXZlZCBsYXRlciAob3IgZWFybGllciB3aGVuIHNldHRp
bmcNCnVwIGEgZGF0YWJhc2Ugb2YgYXR0cmlidXRlcyBvZiBlYWNoIG1hY2hpbmUgaW4gdGhlIGZs
ZWV0Lg0KDQpCdXQgdGhlIGtleSB0aGVyZSBpcyBrZWVwaW5nIHRoZSBkZXRhaWxzIG9mIHRoZSBz
b3VyY2UgbWFjaGluZSBhdHRhY2hlZCB0bw0KdGhlIGVycm9yIHJlY29yZC4gTXkgZmlyc3QgY29u
dGFjdCB3aXRoIG1hY2hpbmUgY2hlY2sgZGVidWdnaW5nIGlzIGFsd2F5cw0KanVzdCB0aGUgcmF3
IGVycm9yIHJlY29yZCAoZnJvbSBtY2Vsb2csIHJhc2RhZW1vbiwgb3IgY29uc29sZSBsb2cpLg0K
DQo+ID4gUFBJTiBpcyB1c2VmdWwgd2hlbiB0YWxraW5nIHRvIHRoZSBDUFUgdmVuZG9yIGFib3V0
IHBhdHRlcm5zIG9mDQo+ID4gc2ltaWxhciBlcnJvcnMgc2VlbiBhY3Jvc3MgYSBjbHVzdGVyLg0K
Pg0KPiBJIGd1ZXNzIHRoYXQgaXMgcGVyaGFwcyB0aGUgb25seSB0aGluZyBvZiB0aGUgdHdvIHRo
YXQgbWFrZXMgc29tZSBzZW5zZQ0KPiBhdCBsZWFzdCAtIHRoZSBpZGVudGlmaWVyIHVuaXF1ZWx5
IGRlc2NyaWJlcyB3aGljaCBDUFUgdGhlIGVycm9yIGNvbWVzDQo+IGZyb20uLi4NCj4NCj4gPiBN
SUNST0NPREUgLSBnaXZlcyBhIGZhc3QgcGF0aCB0byByb290IGNhdXNlIHByb2JsZW1zIHRoYXQg
aGF2ZSBhbHJlYWR5DQo+ID4gYmVlbiBmaXhlZCBpbiBhIG1pY3JvY29kZSB1cGRhdGUuDQo+DQo+
IEJ1dCB0aGF0LCBuYWguIFNlZSBhYm92ZS4NCg0KS25vd2luZyB3aGljaCBtaWNyb2NvZGUgdmVy
c2lvbiB3YXMgbG9hZGVkIG9uIGEgY29yZSAqYXQgdGhlIHRpbWUgb2YgdGhlIGVycm9yKg0KaXMg
Y3JpdGljYWwuIFlvdSd2ZSBzcGVudCBlbm91Z2ggdGltZSB3aXRoIEFzaG9rIGFuZCBUaG9tYXMg
dHdlYWtpbmcgdGhlIExpbnV4DQptaWNyb2NvZGUgZHJpdmVyIHRvIGtub3cgdGhhdCBnb2luZyBi
YWNrIHRvIHRoZSBtYWNoaW5lIHRoZSBuZXh0IGRheSB0byBhc2sgYWJvdXQNCm1pY3JvY29kZSB2
ZXJzaW9uIGhhcyBhIGJ1bmNoIG9mIHdheXMgdG8gZ2V0IGEgd3JvbmcgYW5zd2VyLg0KDQotVG9u
eQ0K

