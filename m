Return-Path: <linux-kernel+bounces-19058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8192826758
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 04:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88CA1C2177C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 03:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4083779EF;
	Mon,  8 Jan 2024 03:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hyhwixAM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1239E79CD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 03:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704683597; x=1736219597;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p+I233PhA1LU4sJBoibk3bkd7BPUU41xKkXjKdRvEdw=;
  b=hyhwixAMnF2WrjMWCWHWF5hFr1UkfRgSPsIjMKp3FcfRH+EzgkPDnscO
   Ec4MidaR1YXsvFTsC3hgB3lpKl4nvCXBfpQxQ9kJFnmwWix8EydE+ivoy
   Wy69cWUhhF1F7W7IogsDLgEJH11kc7M+bZvWaBnLQz3h5p4xp1fqE+C3O
   EeV+yax4LuKJEoaZRBKcHtAuXoHqWsSmQr2wPhagOnS4JHBrP7Tc2P4tJ
   Vv0oJKNkLidE7jB/T1mwHhA+GTrAyM8O+Gx7TBi7QC4kPLtAJDK+TJmfr
   i2UAZqjokF5eAzUiv9JCvHpJxFSx5Er0nWV6IiHFSFNUuSKjkfxbho3X0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="394953244"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="394953244"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 19:13:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="23033341"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2024 19:13:16 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Jan 2024 19:13:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Jan 2024 19:13:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Jan 2024 19:13:09 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Jan 2024 19:13:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiMpQC7KzyxeN8V6/bw+05IlMMqtks+56tzqskwHQ9U/zv6KoMuT7LAS7nXjbgqib/YJx5jLedOxK4GR9onWlZUaCC7RglyN5nvuHqOSbqqL7oL1uXpNGsww5pGRIqhEGjZYTqUxkP8Dj0gU8G5DwnqFWuW+laSAMU9T6cty91Nq7BhmEQXMnBOuRR0RF19Zsg9zSRR7amaRSCu6hdO8u7sLPrHVF8+5Id29tkPRTDIq4WnjeCQ+UJYnsWu1f2bEkTVvNMSS90jQlrDQ6myCml1sICQ3FJVBG2CsfAXuD5wqF1eSAX7KghUa5sNNYMWtYNBVLsKCHZLD9VkQ6keavw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+I233PhA1LU4sJBoibk3bkd7BPUU41xKkXjKdRvEdw=;
 b=BmMJBONMo5EEisaDwNRKj1SgPaGMN6Ik/eNjYHykgbsbDML3sv3y8XL3uE5OtBcLzumgF82B4NDb/WSgdzIYWF2JV9OzyxGdpjKrL37idBRm8iUpI71Ep0Ybibgt0whmqV58uUFzy5PApS459kTjHYw2qL2VtGxmvCwnTUi4Go9KVi9OhK2n3PGlS6iUbYl+qT2XRvLloXsmyc0qn2D5QJrP1NU6KCnTM6XFfWdeLSOvk/pvNPp9yqKpGjkSHlMpGaY2rFq7vwdFto0wvsp2RXVfc+WQs6FULPwJnMUSwp9/Ttec3JWZSsrucBOTgKY14iMuBoJBehNm7OLs2qU73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CO1PR11MB5025.namprd11.prod.outlook.com (2603:10b6:303:9e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 03:13:07 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 03:13:06 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, "seanjc@google.com"
	<seanjc@google.com>, "bhe@redhat.com" <bhe@redhat.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv5 15/16] x86/mm: Introduce kernel_ident_mapping_free()
Thread-Topic: [PATCHv5 15/16] x86/mm: Introduce kernel_ident_mapping_free()
Thread-Index: AQHaNTH0QWBZ51600E6mdH8oHBHhWbDPVskA
Date: Mon, 8 Jan 2024 03:13:06 +0000
Message-ID: <ba8265977a4b30f48b6b33fb135b714d5ada2a52.camel@intel.com>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
	 <20231222235209.32143-16-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231222235209.32143-16-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CO1PR11MB5025:EE_
x-ms-office365-filtering-correlation-id: 082e49c4-79ea-4ef6-bdc9-08dc0ff7bbc2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h4slw/bWAY+znazMMyp/+Qht4M/qGTs8IPU5axLyARkhEThVbmSLTB+jU7CG55xJVro4yP8CFfq6+icP74Vw/lUQFJ/aM9WCaR1q5PMmJ8/xuumF4NPzTA3vBTDvIEUZAQrZtytzQdqV1ZALrh1/H7B9IUlPnU7dNPf4NzwyQqKcoBwex2QIam2oJy1KV5wkvbV0oCM8pO6UqIWABx2ie1uD/weY72SHMbu1LFx7WMb3eumxojKKJd2dQfLYEOLVvVM+WPKAi50Rl+YuYRopTz4uVyYTi1bU+4kRZu2Lhd7qqqJdXctfXShPJJDH9S2XDx6jpMLwlPStUgoIMc5ovymhCwgXK1CUqnGyqn5wPj7dNM0udJZuR3w5Bd/0cxXAixCTFCfRZG8dug3CuwKSmfB3+LK0SUPSNa7esyKBft5BueX80mYFLwhOhPE7HVxUry/AuVPMyyphFFrHVmvitlvKdyH2XnxIZ2HAq5EKNshHGlPOqorAqMMSWaPCLJO8009JFrU4pK91POZr4tk17qKCnTKR/uv7rVk2ho1VM1hk7FXqb0QsRjqNxNwIBn1t8riUScR0+hBFKpuBDUz3vaR4dYvWxj98tALRj0FPQvy015hv4i4qeAWfM127N3nL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82960400001)(478600001)(122000001)(38100700002)(6512007)(6506007)(26005)(2616005)(8676002)(8936002)(110136005)(7416002)(54906003)(5660300002)(4001150100001)(2906002)(316002)(86362001)(4326008)(38070700009)(66556008)(66476007)(66446008)(64756008)(71200400001)(91956017)(36756003)(66946007)(76116006)(41300700001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SU0xMEg3N3pkSWxLb0JzN1BCYnJHRWt0MGxZZFFqZnphNXJpeTljZmtVQmFU?=
 =?utf-8?B?WXdPaW1YbXZUK3FHSytxNnZPZzN4UkQwd0FSNHpZZmhDSm5tRkFkbU91R2N4?=
 =?utf-8?B?b01BK3VBNTN4Sm5xNHgzM0sxVFVhZGFuYlI4S0xCcE9ERjZNOGh6OUhFUmda?=
 =?utf-8?B?bi9yWDlDMmdpSjF0ZE9WN2pVU05kSXZoYmJ0UXE3cWczaDZrcUlReFhqN3lj?=
 =?utf-8?B?UmVZL09ZYXFRUW5tOVp4TytmeXlyRUFFVlBSTTJQNXV3ZGVoQU4zOW94N0tO?=
 =?utf-8?B?M05Cakcxd0JleitPSG9VOE95TG1IMjJLQkJybTRzUC9HRVJLdG5MeGhXVXA0?=
 =?utf-8?B?cWdJbVpIbXltcHQyQnFkbXhBSHhpNmJiTWcwaTBUeEVsSEk2MDdPMlJ1V2Ni?=
 =?utf-8?B?SjF0RmNsZmc4bDBsTWh1ZDFPdDZmNUo1K3dkQVRkRFhEQWRwd0lwTXVFT3pp?=
 =?utf-8?B?emhLL0dBQm1zMlQvdTlhNUZSR0RKMDR4OVNEd01TVy9zU1RINXJDN2lJckpF?=
 =?utf-8?B?MjlKWXdNMkNRaWU3RlJad1I3SHNKQk81Si9yRlYyM1E5dXJMSm9uZFBHV1U2?=
 =?utf-8?B?NnFsVUkvWTVFKzVobXJlcHNvK3cyM250cWh6S0d3elpmMU1FcGlPdTRwbzQ3?=
 =?utf-8?B?RDlvbGhvaWlQbUxjMFh4amVCd29mR255c3hYamphWU5hUVpubXF1MGVPRTBr?=
 =?utf-8?B?RnpZREx5NXdtQlorbU43d0MyQTAwbXNDY252ajducGZub2JOWTN1V0tYVVVm?=
 =?utf-8?B?TnNSRDRwWjM3S2YrdE8wZW5tMUhtODRVeUdCbFFSbEYvMHdrTlpKWHJaMWZy?=
 =?utf-8?B?WjM2V0tPNFB6NFM5K2dGUXY5RmRxOFAxT3pZUFNHS05PZEh5SG9mOG03ejVw?=
 =?utf-8?B?aUVkT2pMR2JvQVdDTmc0eUdOK1dwVXRsWHRWUWJVdXl2QlphZk5rZzNpNHBR?=
 =?utf-8?B?SkNUdFllSC8yYitiUEw1ZzZIQTZYU2thcXc1cDMvbkZaZUdxK3h6dFhWZ3ow?=
 =?utf-8?B?ZkM5ejVXYkVRR0FWd2xqQlFpTUpJVDNZU3ozNHJmVUJCTkoxUmt0RlJSZlZu?=
 =?utf-8?B?RHA2Ui9uN0ZQc1ViL3B3TjNBZEV5L2ZEYWVlRDFPUFUwdy8zMGhrTlp6YzZL?=
 =?utf-8?B?RDJOWDVZdnpFeHdVOFZ1eWsyaEFqMXRURWFWTjRocCtOcTlDWTFGWWZjVFlx?=
 =?utf-8?B?eHNEdm9kejRKS3RGa1hrZTNoSU9TdGQ2TTBXSGo0VThuK05YM2tOcHN3elZw?=
 =?utf-8?B?N0FLbUFGejdRR1gwMzhDMEZjcE43WGVURUdURkVnOTQ4MWxOZnYwQ1NRN2Rw?=
 =?utf-8?B?ZStvWEROYnJ1QkV0ZDRYdzkrVE8xS21mOTdKa1FwVHVMYTVNa1JnalF0UGNn?=
 =?utf-8?B?YVN3MmU0S1VUbU5ZUUoxY3hWazJuS2hsUkNYaFNqNkZOVHpsMlFZQVgrY0ZJ?=
 =?utf-8?B?a0dhTVpvRDNORlNma0RkdVhyNlBub2lDRWhWQXZUSTZobTJuckg0aVRnenhK?=
 =?utf-8?B?aEs4Ymc0RG54S2VCWVd2UXZiQi9tZHlpamtHZGcxTkRsUkZrWm5tZXVnTksx?=
 =?utf-8?B?ZW42dld2VEh6dlBweC9TYXVrZUF0TlByMjF1M09JNDZYQm14QWNUTHpsYXpM?=
 =?utf-8?B?Q3M2d3FtUitOMmh6TElTN29xVisycXNoRStYOG1zSU9jK0lCeFY1MWpsMGw4?=
 =?utf-8?B?Y2lEQTB0ZURqNHlnTWRVWE5WaVFGZXkxS0dPVzVseUt3c1N1NWdzeE5MZFRy?=
 =?utf-8?B?MWQxR2RFQXp4eW1tRjdWUE15cmlBNDNuNkpFd0JMejZCYldmaUkxR1lhQTFj?=
 =?utf-8?B?QTVHTmtHbXhuanNDaVUrdEh0K2c1c1FLbWFkbEpYRHlDYStucnkzRGtGTjVz?=
 =?utf-8?B?S2hEUkVIV2J3YlU1WTBHQzg5dGdWRExtVCs0R3ZWOEtzRTU5STFSRzgyTEwr?=
 =?utf-8?B?TEJmZ3dhcVdpTzM3dUlLTVUrSFdua0Jsd3Z2cC81UFhlbUhrNEI4Um1mMDMx?=
 =?utf-8?B?UkkzRXBWZmk2YXhLOEFoaTFwSEtwaEppVFZoYnVCUm5haURKT1BjN1g2Z21h?=
 =?utf-8?B?MUZXdlI2Tm8xRGg5TmpRMGV3WWZWdlRHZVEyVU5RV3pEOTBYbGpRMDJndTBH?=
 =?utf-8?B?Um5XdW5pazh5ZDRodkg0Tk9qMCsvdmd2dFJNRXVhMHBNQmY3MEpSalBmcThS?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9698360C291F9241B61026CA714DBDAA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082e49c4-79ea-4ef6-bdc9-08dc0ff7bbc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 03:13:06.0979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nWuN/dMqw/S8M83gtL9Ua/q+/GKmcLo3ppKQ5ook2PttBMruxh40Kk7DkdxMYRpJ44Sp7kQjUQocOSXFe3ENw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5025
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDIzLTEyLTIzIGF0IDAyOjUyICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IFRoZSBoZWxwZXIgY29tcGxlbWVudHMga2VybmVsX2lkZW50X21hcHBpbmdfaW5pdCgp
OiBpdCBmcmVlcyB0aGUNCj4gaWRlbnRpdHkgbWFwcGluZyB0aGF0IHdhcyBwcmV2aW91c2x5IGFs
bG9jYXRlZC4gSXQgd2lsbCBiZSB1c2VkIGluIHRoZQ0KPiBlcnJvciBwYXRoIHRvIGZyZWUgYSBw
YXJ0aWFsbHkgYWxsb2NhdGVkIG1hcHBpbmcgb3IgaWYgdGhlIG1hcHBpbmcgaXMgbm8NCj4gbG9u
Z2VyIG5lZWRlZC4NCj4gDQo+IFRoZSBjYWxsZXIgcHJvdmlkZXMgYSBzdHJ1Y3QgeDg2X21hcHBp
bmdfaW5mbyB3aXRoIHRoZSBmcmVlX3BnZF9wYWdlKCkNCj4gY2FsbGJhY2sgaG9va2VkIHVwIGFu
ZCB0aGUgcGdkX3QgdG8gZnJlZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtpcmlsbCBBLiBTaHV0
ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+ICBhcmNoL3g4
Ni9pbmNsdWRlL2FzbS9pbml0LmggfCAgMyArKw0KPiAgYXJjaC94ODYvbW0vaWRlbnRfbWFwLmMg
ICAgIHwgNzMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMiBmaWxl
cyBjaGFuZ2VkLCA3NiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
aW5jbHVkZS9hc20vaW5pdC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vaW5pdC5oDQo+IGluZGV4
IGNjOWNjZjYxYjZiZC4uMTRkNzI3MjdkN2VlIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9pbml0LmgNCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vaW5pdC5oDQo+IEBA
IC02LDYgKzYsNyBAQA0KPiAgDQo+ICBzdHJ1Y3QgeDg2X21hcHBpbmdfaW5mbyB7DQo+ICAJdm9p
ZCAqKCphbGxvY19wZ3RfcGFnZSkodm9pZCAqKTsgLyogYWxsb2NhdGUgYnVmIGZvciBwYWdlIHRh
YmxlICovDQo+ICsJdm9pZCAoKmZyZWVfcGd0X3BhZ2UpKHZvaWQgKiwgdm9pZCAqKTsgLyogZnJl
ZSBidWYgZm9yIHBhZ2UgdGFibGUgKi8NCj4gIAl2b2lkICpjb250ZXh0OwkJCSAvKiBjb250ZXh0
IGZvciBhbGxvY19wZ3RfcGFnZSAqLw0KPiAgCXVuc2lnbmVkIGxvbmcgcGFnZV9mbGFnOwkgLyog
cGFnZSBmbGFnIGZvciBQTUQgb3IgUFVEIGVudHJ5ICovDQo+ICAJdW5zaWduZWQgbG9uZyBvZmZz
ZXQ7CQkgLyogaWRlbnQgbWFwcGluZyBvZmZzZXQgKi8NCj4gQEAgLTE2LDQgKzE3LDYgQEAgc3Ry
dWN0IHg4Nl9tYXBwaW5nX2luZm8gew0KPiAgaW50IGtlcm5lbF9pZGVudF9tYXBwaW5nX2luaXQo
c3RydWN0IHg4Nl9tYXBwaW5nX2luZm8gKmluZm8sIHBnZF90ICpwZ2RfcGFnZSwNCj4gIAkJCQl1
bnNpZ25lZCBsb25nIHBzdGFydCwgdW5zaWduZWQgbG9uZyBwZW5kKTsNCj4gIA0KPiArdm9pZCBr
ZXJuZWxfaWRlbnRfbWFwcGluZ19mcmVlKHN0cnVjdCB4ODZfbWFwcGluZ19pbmZvICppbmZvLCBw
Z2RfdCAqcGdkKTsNCg0KTWF5YmUgcmFuZ2UtYmFzZWQgZnJlZSBmdW5jdGlvbiBjYW4gcHJvdmlk
ZSBtb3JlIGZsZXhpYmlsaXR5IChlLmcuLCB5b3UgY2FuDQpkaXJlY3RseSBjYWxsIHRoZSBmcmVl
IGZ1bmN0aW9uIHRvIGNsZWFudXAgaW4ga2VybmVsX2lkZW50X21hcHBpbmdfaW5pdCgpDQppbnRl
cm5hbGx5IHdoZW4gc29tZXRoaW5nIGdvZXMgd3JvbmcpLCBidXQgSSBndWVzcyB0aGlzIGlzIHN1
ZmZpY2llbnQgZm9yDQpjdXJyZW50IHVzZSBjYXNlIChhbmQgcGVyaGFwcyB0aGUgbWFqb3JpdHkg
dXNlIGNhc2VzKS4NCg0KUmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNv
bT4NCg0K

