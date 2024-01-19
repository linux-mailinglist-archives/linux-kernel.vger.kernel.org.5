Return-Path: <linux-kernel+bounces-30969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1C08326F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8B00B244A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B2B3C6AC;
	Fri, 19 Jan 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dBIOVOoE"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8433C684
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705657790; cv=fail; b=IVyYkL9GhsYvoZ5iz8uY1rex673JG12KdYSQydz1ea4In3hiY0Rsz5cU/3/eJyawCpK+nkCx4ed/SJ3Z22P9YvVgJfsr1CZo+h0n/f46OqprnMrMmxcgMkliB0I+PifENr2Codb6FSpB3LHA+5om4UHHqD/loPDmlu0Wu7PbHSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705657790; c=relaxed/simple;
	bh=42+fpwlVV6yPErkbsUuZKKT6wPwGHAfEmORtuJnVXd4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d0CvLbkAELOYo8NLbK7NF+UbZHJTTsHk90FPipXZMfojzx9Tml3uu0hnzIrqn/Qpvx8MmExAGvjO3GCEazt7wnJnr9s0RhISqzFSKDfWcOPt65Q8paEc4RECI5zSA2zGap985cdSejFwqLW98DbBPgh/JiFJAGMe1XwU+eYp0sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dBIOVOoE; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705657788; x=1737193788;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=42+fpwlVV6yPErkbsUuZKKT6wPwGHAfEmORtuJnVXd4=;
  b=dBIOVOoE+7f7vbQa7VacyqMzGKVboJAzzT70a0ocdQLK7AnXQnu8KUFp
   1zwE0Wv5xJN1/qrP5wMLBJ2aNQrI5z/bwQEmipZtCb5rRa9mMuXoGLpwM
   5dlrvkmzkEJf9L1oKzgkDlSChGWpRd1sUnZ2xoWb6rA/Zv8mL27AgCbhp
   sr3LYPW83er8EUEgVJi7IZR8q4SaR2WontU7mxlKHlp6IWFffOzh411Mk
   Ioz73d2pVMN/XJT8B+COADgqQX1R/zDapF63+mIWT3UFlLf2UVcz9fyNy
   MxFUgMGlSwAKVcAbGylbrHM+1GPhBciy75ZXYPK7Hq0y/ignWeSJ9l3mO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="431878838"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="431878838"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 01:49:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="614967"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2024 01:49:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 01:49:46 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 01:49:45 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Jan 2024 01:49:45 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Jan 2024 01:49:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmUh8l0UpUUVMkk59fbCPvHs/4rOSqgQZgpDws6wHlrJwGPF3uZNJ2ZBz8OjRAJiXwO3GXs1UBWIsXVxPhlSQbimsBGLo0bNAGvdHwLXnJpWozrVvkMYgJCDELtr8/ERzXedQUSBPBje02f8MgkrzffDAEC6TjGoR+X+sDbsQgsCv82lRynI3j5TmHaAx0ajakySvNwwuZlH19VkArFS6S/xOnTMiE16fDBc/C1ZnDxCPf2uhwcnbZlF+/ngSx35fhOe6C9XOB2NBh0wD5yn9+2oNSrARepyed3LuuMMaqRy9E0/B3apMX7IE4axWutHnAGncXT0B+qGb3SeSirISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42+fpwlVV6yPErkbsUuZKKT6wPwGHAfEmORtuJnVXd4=;
 b=hmtjp7/ObtW38dbbxr9vZsoxYZutVq4no4y16cPo6v0IEoiTs4m+4e53SpuMMgpNz/ItqL47vlO4b5JV5J3l/6BiGrUyNHch32tWi3xJw8VUyqt2ctM/ZMnqsBSGkrNQiDZ3mUjdMbLHtLQrBZkBmc0joU/MNrYwnjTgGOWb2jy+uRtE4WKLStdiQSwDe96yWsS6utZ5w4P1k0NJnn8NaEIG5RKwyT/m5jX/x46DkSNHu35PBS7T6IT/7taR7RebHrWaB/bh3ia7sC1RWMt1pNsRa8oJSYgzRON6ni1df+uXt1FBVRhJLvby2auDtgTkz97hMgTRCHvyvMniuQAqrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH0PR11MB5379.namprd11.prod.outlook.com (2603:10b6:610:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 09:49:43 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::124d:fbd5:113b:16ec]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::124d:fbd5:113b:16ec%4]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 09:49:43 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "hpa@zytor.com" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "seanjc@google.com" <seanjc@google.com>
Subject: Re: [PATCHv3] x86/trampoline: Bypass compat mode in
 trampoline_start64() if not needed
Thread-Topic: [PATCHv3] x86/trampoline: Bypass compat mode in
 trampoline_start64() if not needed
Thread-Index: AQHaQoB5SStmYY565EOmJ+tpQwWKr7Dg9KMA
Date: Fri, 19 Jan 2024 09:49:43 +0000
Message-ID: <23568229ee014c9f61c27ee310573782fa0d1e8d.camel@intel.com>
References: <20240108221659.11167-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240108221659.11167-1-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH0PR11MB5379:EE_
x-ms-office365-filtering-correlation-id: 3405c6d4-4b8e-4212-74d1-08dc18d3f68f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1z/u7eXsyuC/L0UmsXytvoUX5DmtLqNWFFPbca3P6At1n3wB1Ru0gXgA8hE6RGuR8PbjeSLaQp0FRk/Y9pMNHuepWdYzHm0C5EzeEE4I8sHAeg1kSpr25m9tSbWFFc8A0CWsdAzpZz2Q0auXn+ze9zWemoaIQY2WdZ34C/0jPRLVEomOd/Nitpt58kW2EuDdbCulhWAcS/ekiNSRVohS6a3hpM/U57ZeUvNkSBYD+mzxR35+oyCC7xbEu36FJt2kb49mJPq/Ew4XL90MUW+0Lst9BUG889gliAyrwe3SMzUVJvBjFio9i1meRl1u+Gjot11UJp2//EoYTGg4kbC6DIzxF61m92gltE3sa/rshdsNmG8x3v6t3Ne2hAWD1cEy3aPjD4coIn5XGcJJZE3u0t1XLl3FjRnOVJjO2JDARJ5n+KulvV78QtwPUAeXdTQqr5s/9oOrO2PHfNAkQ9O2lHc3vg6oN7rzKe6Pa70+ZguKK1Iv6g5Y+MLIIMnBlem/0yW+pBTbXk+ALdVesSZScKeihhBahoajVmqIk3rhFz//AP55g/ynu/pXEnqQkA+Q2yN6jmNsKh2LjRIAb6xTobAGW7+0wEFYbVQBmxtxogY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66476007)(54906003)(66446008)(110136005)(66556008)(76116006)(64756008)(36756003)(66946007)(478600001)(316002)(122000001)(6486002)(5660300002)(966005)(82960400001)(4326008)(8676002)(8936002)(7416002)(2906002)(38100700002)(41300700001)(26005)(2616005)(38070700009)(83380400001)(6506007)(6512007)(86362001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clRLcmdHbU8wRGNoaUxvZGFSUU9UZmFEc2p4UHVXK0NCT1IzOWs3eU5UZUtE?=
 =?utf-8?B?SjVROUVua1lCeWlMZHN5Vmp0aEp3OHlZM0FKcEd0VkhBbVNGaXNzNDBQTTF6?=
 =?utf-8?B?U09lbGl0cTNiT2k1TFAyM0lGeDJYWk1CV253ajFaUVd3QWxmN0tiRncvUngw?=
 =?utf-8?B?aTZtcS9LU2NmZmdFSXpEQkFGeWtZL2htMkpablBZOC9oZkl4TXVBNDd1d2hN?=
 =?utf-8?B?Y3Y2UXFLQ1JwblJwTE15M1ZtVyt3WU5SdDJWdWpsRDRCZVZMSitET1Jrc3Mx?=
 =?utf-8?B?dE5wdmFKcjFGaUc3OWlTZFg0WktFbzFHdUprdVFsbGtSMjdTOWpKTE9PdUtk?=
 =?utf-8?B?STJkQ3FxNUQ4bUxmYko5SUJmT1ZTTmx1Z3FVUXZONUQ4bWhma2RiVkVwaThF?=
 =?utf-8?B?UnBva1NxNTIrUDU1OWJDYWJEVFlLVjNCUkEwM3c1dmorSFFIT1E5VmFOZ1F0?=
 =?utf-8?B?SUtFUnNpQmw3R0hKU3lraGNmVzhDQzNHdUx1VkFndVZDSkYzRnZONDBXQzVQ?=
 =?utf-8?B?ZmZJZ1hkQlpjelRxWnhCNE9ucFcrOHlBK2lyQ090eGdEY2oxbEMwd3p2UXpM?=
 =?utf-8?B?MTNjU1crUko0WDNqSGZNYytCSjlnMGc3TTVFMElucWJQRVJuM1hWME5WWGxW?=
 =?utf-8?B?TGEyTW5yR3Y2cW1jRVhRb3FncHpGcENDb0RMQ1A4Vnk1VEh3SUNtOHE3ZFd1?=
 =?utf-8?B?QnIyMnl1ZTdRL0Npc2VqVE1WOEVwbnRvc3VFaHdRbmlzOTZ6Rnd3Z1kzOVBp?=
 =?utf-8?B?YnNoVGVWMGlOMU4zZGJQdGhDVy9MZmhpWFgwOEtHYzFaQU1XcTM2bHBjMkFp?=
 =?utf-8?B?ZDFRbnNueW44UUtvMndTMTlPNldGZkxoS3loWXo1TUgxSWhBZjhRTmhGeUUy?=
 =?utf-8?B?STUxbVY0YVpNNHFoMFc3NFI3ZWw2c21kZFZqeEgxVDFNRzBwbkx2UDY2eWFk?=
 =?utf-8?B?UnFXd3BSVGtJMklkZVhyQm5CVkwvYmkzSjY0VFZjSVJDcnJLaEZBLzY0V2JJ?=
 =?utf-8?B?K1pzR2FvZGc2enEvWU1TWDZObmUwV0UvMUhSM1BjZVpJWWk4Nk1PSytqTEsw?=
 =?utf-8?B?WUZCSjV3VFh3SFdvSXArZUxmdnRzT1JjUmFDOEJidk5tRUJGMTJsZ05SR2Yv?=
 =?utf-8?B?aHBjMzVZY2QvaXdySjVaUDJSSDV0QkE5NWhFbDczTG9mZCtjSjg4MGpKNk5y?=
 =?utf-8?B?SmtJRlUwK243L1owSXkyVGsySUNZVWk1bEhySFFhQTFpemgrd0ZJT0ZpWWFq?=
 =?utf-8?B?RE1hYWttTDlOUEhwSTVEOGIvaEZjdXVRT0lPSUo1S3ZYVFp1N2xkekcyTEw5?=
 =?utf-8?B?YlhLR3BRbm5PM0RuV0UzSXFrcHFKZENjQm43N1NjM1J4ZC9rZVlFZUFiV2dL?=
 =?utf-8?B?LzdPeURXTDdkRlpLTm1wVGpCODB0Zml3Tm5DS3EzTXNDcWx2eC9CQ29mbkFL?=
 =?utf-8?B?eTB6VmErOW5Dck5Nbm9vZjA4N242aFpUOFA4QkVJNVF6NnYxL1d3TGRIcXdR?=
 =?utf-8?B?VHY2YU9WYWVFZ0RVSWNpS20weTA0a0FjRjREd0N5Zzl0Qkw2dFYwSVpjT3d1?=
 =?utf-8?B?QWxKTDRVUUplN2lyVUpFOXBTanlhaWpTZFhibEo5ZDhYTXJYTGxHakJ6LzVU?=
 =?utf-8?B?NkVOcVRKOFlaU0lsQ09OZllJQlNRRStGdHh5RklmNGgzZ3pXMHh1cDJPREhT?=
 =?utf-8?B?Tyt0elF0Mmp3NFdWQm1XN2FNQ3FtS3ovMlBhbjAzUWdsanVCUmFmRmFzN0Iz?=
 =?utf-8?B?Ty9YaTN0LzhmeUFBY3NEQkJyNGptdHlsY0xIRmFYVGpwMWxVaW9tTGdrdHlL?=
 =?utf-8?B?YkFLc0ZMaUxVbDJOOGpId0FHU3VzaW9oOFVnRjRxN2VJRStNc0JnSzZROVlp?=
 =?utf-8?B?TTdaWXdIVlFhcEY0ZFd4NjVvSEZ5U09zVXdwRVFGc251amhORVBnbFI1Vkor?=
 =?utf-8?B?VlBkTTMzNU9oNUF2OXZMaGhUUWtlN1RNR2I5WDBhbDlFaE1qVVBieG9CcFZP?=
 =?utf-8?B?dyttWmlRazZpTFJHVGRKUTVnSGdsbTBOLy9vTXdWTW9NVWU3MzdYeTFmeGls?=
 =?utf-8?B?Y0Y0VjBtTU1LZFZrMkZpWS9nNjlmZHlyR2NKQ01URDRINFgvQ3FQSE5rQ1Jo?=
 =?utf-8?B?ejEvN0JKYXFiWm9nZ3BTZjJISlJxbE1KRUFNM0dvdnl2VU5tUEFTMGwzcExX?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B29029ABB2F634BBF9E12D29F3298F8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3405c6d4-4b8e-4212-74d1-08dc18d3f68f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 09:49:43.3440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MAxUgCKkXRNlgHZW8ZMUlX5EIfeeXSHXW+dkTOMgtdMNwlFztn8lTSW/jHBSrK+K1d1y+463MHwiuu/QlL2jqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5379
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTAxLTA5IGF0IDAxOjE2ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IFRoZSB0cmFtcG9saW5lX3N0YXJ0NjQoKSB2ZWN0b3IgaXMgdXNlZCB3aGVuIGEgc2Vj
b25kYXJ5IENQVSBzdGFydHMgaW4NCj4gNjQtYml0IG1vZGUuIFRoZSBjdXJyZW50IGltcGxlbWVu
dGF0aW9uIGRpcmVjdGx5IGVudGVycyBjb21wYXRpYmlsaXR5DQo+IG1vZGUuIEl0IGlzIG5lY2Vz
c2FyeSB0byBkaXNhYmxlIHBhZ2luZyBhbmQgcmUtZW5hYmxlIGl0IGluIHRoZSBjb3JyZWN0DQo+
IHBhZ2luZyBtb2RlOiBlaXRoZXIgNC0gb3IgNS1sZXZlbCwgZGVwZW5kaW5nIG9uIHRoZSBjb25m
aWd1cmF0aW9uLg0KPiANCj4gVGhlIFg4NlNbMV0gSVNBIGRvZXMgbm90IHN1cHBvcnQgY29tcGF0
aWJpbGl0eSBtb2RlIGluIHJpbmcgMCwgYW5kDQo+IHBhZ2luZyBjYW5ub3QgYmUgZGlzYWJsZWQu
DQo+IA0KPiBUaGUgdHJhbXBvbGluZV9zdGFydDY0KCkgZnVuY3Rpb24gaXMgcmV3b3JrZWQgdG8g
b25seSBlbnRlciBjb21wYXRpYmlsaXR5DQo+IG1vZGUgaWYgaXQgaXMgbmVjZXNzYXJ5IHRvIGNo
YW5nZSB0aGUgcGFnaW5nIG1vZGUuIElmIHRoZSBDUFUgaXMgYWxyZWFkeQ0KPiBpbiB0aGUgZGVz
aXJlZCBwYWdpbmcgbW9kZSwgaXQgd2lsbCBwcm9jZWVkIGluIGxvbmcgbW9kZS4NCj4gDQo+IFRo
aXMgY2hhbmdlIHdpbGwgYWxsb3cgYSBzZWNvbmRhcnkgQ1BVIHRvIGJvb3Qgb24gYW4gWDg2UyBt
YWNoaW5lIGFzDQo+IGxvbmcgYXMgdGhlIENQVSBpcyBhbHJlYWR5IGluIHRoZSBjb3JyZWN0IHBh
Z2luZyBtb2RlLg0KPiANCj4gSW4gdGhlIGZ1dHVyZSwgdGhlcmUgd2lsbCBiZSBhIG1lY2hhbmlz
bSB0byBzd2l0Y2ggYmV0d2VlbiBwYWdpbmcgbW9kZXMNCj4gd2l0aG91dCBkaXNhYmxpbmcgcGFn
aW5nLg0KPiANCj4gWzFdIGh0dHBzOi8vd3d3LmludGVsLmNvbS9jb250ZW50L3d3dy91cy9lbi9k
ZXZlbG9wZXIvYXJ0aWNsZXMvdGVjaG5pY2FsL2VudmlzaW9uaW5nLWZ1dHVyZS1zaW1wbGlmaWVk
LWFyY2hpdGVjdHVyZS5odG1sDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLaXJpbGwgQS4gU2h1dGVt
b3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBBbmRp
IEtsZWVuIDxha0BsaW51eC5pbnRlbC5jb20+DQo+IENjOiBTZWFuIENocmlzdG9waGVyc29uIDxz
ZWFuamNAZ29vZ2xlLmNvbT4NCj4gDQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFu
Z0BpbnRlbC5jb20+DQoNCj4gLS0tDQo+ICB2MzoNCj4gICAtIHRyX2NyNCBpcyAzMi1iaXQsIHVz
ZSAzMi1iaXQgWE9SIHRvIGFjY2VzcyBpdCAoU2VhbikuDQo+ICAgLSBVc2UgMzItYml0IFRFU1Qg
aW5zdGVhZCBvZiBBTkQgdG8gY2hlY2sgaWYgTEE1NyBkaWZmZXJlbnQgYmV0d2Vlbg0KPiAgICAg
Q1I0IGFuZCB0cl9jcjQgKFNlYW4pLg0KPiAgdjI6DQo+ICAgLSBGaXggYnVpbGQgd2l0aCBHQ0M7
DQo+IC0tLQ0KPiAgYXJjaC94ODYvcmVhbG1vZGUvcm0vdHJhbXBvbGluZV82NC5TIHwgMzEgKysr
KysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9yZWFsbW9k
ZS9ybS90cmFtcG9saW5lXzY0LlMgYi9hcmNoL3g4Ni9yZWFsbW9kZS9ybS90cmFtcG9saW5lXzY0
LlMNCj4gaW5kZXggYzlmNzZmYWU5MDJlLi42MDhmMTA4Y2JhN2QgMTAwNjQ0DQo+IC0tLSBhL2Fy
Y2gveDg2L3JlYWxtb2RlL3JtL3RyYW1wb2xpbmVfNjQuUw0KPiArKysgYi9hcmNoL3g4Ni9yZWFs
bW9kZS9ybS90cmFtcG9saW5lXzY0LlMNCj4gQEAgLTM3LDEzICszNywxNSBAQA0KPiAgCS50ZXh0
DQo+ICAJLmNvZGUxNg0KPiAgDQo+IC0ubWFjcm8gTE9DS19BTkRfTE9BRF9SRUFMTU9ERV9FU1Ag
bG9ja19wYT0wDQo+ICsubWFjcm8gTE9DS19BTkRfTE9BRF9SRUFMTU9ERV9FU1AgbG9ja19wYT0w
IGxvY2tfcmlwPTANCj4gIAkvKg0KPiAgCSAqIE1ha2Ugc3VyZSBvbmx5IG9uZSBDUFUgZmlkZGxl
cyB3aXRoIHRoZSByZWFsbW9kZSBzdGFjaw0KPiAgCSAqLw0KPiAgLkxsb2NrX3JtXEA6DQo+ICAJ
LmlmIFxsb2NrX3BhDQo+ICAgICAgICAgIGxvY2sgYnRzbCAgICAgICAkMCwgcGFfdHJfbG9jaw0K
PiArCS5lbHNlaWYgXGxvY2tfcmlwDQo+ICsgICAgICAgIGxvY2sgYnRzbCAgICAgICAkMCwgdHJf
bG9jayglcmlwKQ0KPiAgCS5lbHNlDQo+ICAgICAgICAgIGxvY2sgYnRzbCAgICAgICAkMCwgdHJf
bG9jaw0KPiAgCS5lbmRpZg0KPiBAQCAtMjIwLDYgKzIyMiwzMyBAQCBTWU1fQ09ERV9TVEFSVCh0
cmFtcG9saW5lX3N0YXJ0NjQpDQo+ICAJbGlkdAl0cl9pZHQoJXJpcCkNCj4gIAlsZ2R0CXRyX2dk
dDY0KCVyaXApDQo+ICANCj4gKwkvKiBDaGVjayBpZiBwYWdpbmcgbW9kZSBoYXMgdG8gYmUgY2hh
bmdlZCAqLw0KPiArCW1vdnEJJWNyNCwgJXJheA0KPiArCXhvcmwJdHJfY3I0KCVyaXApLCAlZWF4
DQo+ICsJdGVzdGwJJFg4Nl9DUjRfTEE1NywgJWVheA0KPiArCWpuegkuTF9zd2l0Y2hfcGFnaW5n
DQo+ICsNCj4gKwkvKiBQYWdpbmcgbW9kZSBpcyBjb3JyZWN0IHByb2NlZWQgaW4gNjQtYml0IG1v
ZGUgKi8NCj4gKw0KPiArCUxPQ0tfQU5EX0xPQURfUkVBTE1PREVfRVNQIGxvY2tfcmlwPTENCj4g
Kw0KPiArCW1vdncJJF9fS0VSTkVMX0RTLCAlZHgNCj4gKwltb3ZsCSVlZHgsICVzcw0KPiArCWFk
ZGwJJHBhX3JlYWxfbW9kZV9iYXNlLCAlZXNwDQo+ICsJbW92bAklZWR4LCAlZHMNCj4gKwltb3Zs
CSVlZHgsICVlcw0KPiArCW1vdmwJJWVkeCwgJWZzDQo+ICsJbW92bAklZWR4LCAlZ3MNCj4gKw0K
PiArCW1vdmwJJHBhX3RyYW1wb2xpbmVfcGdkLCAlZWF4DQo+ICsJbW92cQklcmF4LCAlY3IzDQo+
ICsNCj4gKwlqbXBxCSp0cl9zdGFydCglcmlwKQ0KPiArLkxfc3dpdGNoX3BhZ2luZzoNCj4gKwkv
Kg0KPiArCSAqIFRvIHN3aXRjaCBiZXR3ZWVuIDQtIGFuZCA1LWxldmVsIHBhZ2luZyBtb2Rlcywg
aXQgaXMgbmVjZXNzYXJ5DQo+ICsJICogdG8gZGlzYWJsZSBwYWdpbmcuIFRoaXMgbXVzdCBiZSBk
b25lIGluIHRoZSBjb21wYXRpYmlsaXR5IG1vZGUuDQo+ICsJICovDQo+ICAJbGptcGwJKnRyX2Nv
bXBhdCglcmlwKQ0KPiAgU1lNX0NPREVfRU5EKHRyYW1wb2xpbmVfc3RhcnQ2NCkNCj4gIA0KDQo=

