Return-Path: <linux-kernel+bounces-32274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85CB835950
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6961C2155E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1CDEBF;
	Mon, 22 Jan 2024 02:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PuRVKScW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138CC1849
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705890191; cv=fail; b=FY5hGlY21799KU9ujThv8HkDKtKy4zYCypzLAQkYi1/lY8itrNTVs0Y/LAHyLSne/6/7C9UF4So/XxpeXJQWk74L4EPohs/FuGW1HkbYR9b/wV5SmQcM6NxtDQnpBF8c8ZOK0zWJ2JKqog5LkeDLIvdBu3ppdFl3J5jvDUdtn8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705890191; c=relaxed/simple;
	bh=3rXQZsymLPqpjrtdjuN1TTJnCjA7nF4bp725iqWYByE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p8bdXNUBubKiyjNhl1ohLEIhsVLbE726fBvzCV8bUhARrFGsDwt2sobza9rAhkPl1kJ/wrqZqMnD9tMBL9OAN7AuJcaTa0qkUh3/opnCJXEg/6Nb3poHuwiDXDxouzBcEpv6BCDDQZltAzuZRcS+TOAsM24rzD6mcKoHuzm/4PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PuRVKScW; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705890189; x=1737426189;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3rXQZsymLPqpjrtdjuN1TTJnCjA7nF4bp725iqWYByE=;
  b=PuRVKScWJz0U+4fNbVCxCtX0r3Ulgefhk+m9ilfsqCOBpXKAJYewbikE
   6CUdmiEtTixwGcXvNZPyqaDfLWb/rSdrUySsE04hp5jJNO0pctXQOh0D6
   tGfUeOdi8xcKZkqRDRGiFgYbOyufyOYchOnlezHrGdaKCx+vcGV+BBtBI
   0VXMLkh2WuW0xDxFy/6tVuAzDWdCH5VDaN5ixskUP2sHCA1cSXJgvXZq/
   8TkNftASN3zjy/K8PcUKy4Pp+C/0qMjeeyimjOI+JwD2CjJARnndAlpA5
   fN4W9qPj/tBv3CxbZ9r1n2BT0By+xvzZfeTsi5oOV4Jsg5reaBZnAlcrJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="8469921"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="8469921"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 18:23:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="785534825"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="785534825"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jan 2024 18:23:07 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 21 Jan 2024 18:23:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 21 Jan 2024 18:23:05 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 21 Jan 2024 18:23:05 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 21 Jan 2024 18:23:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6DFdK/UbmNplUZYwC5ssPfKfrKaGaGQpKn3xiW74MKvpjkPGXzXAO8xH85jNHxYn3c7dcMsKp6BdKbeSluI6rXOKLDut45AEireF7NgdslWGJeZJMOLau39U2jHMeXYl1uA8BnYRaX/+SDNsiFzqP/ng/VvtcdnBS+hu6TgefMyNJo6jeus+PbBrkJXAIGXoAjirykpIar4ONOuOgp9vtlqvBL4oJht88t6McUcowbsmtHkbHlyEY+lNjx3mk9hm+bT+mjtEc1yPTgpLrEQpG/nS/rYae/5make8+wIOMOH3ES5tu2qvQj7C+SAf8f2xyRYdXL0Mkczlv8TrW3nPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rXQZsymLPqpjrtdjuN1TTJnCjA7nF4bp725iqWYByE=;
 b=VjBMrqlq/iufG9M2vEGaTyJlSFlxGt/7hA6RD3wpoujpCktaOUCOmwulNQGBkVKHILJHH5JT8NjxDMGCFT5zO/l8DlsWjpMQkks4n+zN0Roi3GRYsJpP3TLC5/4be3wd9RBh2WjqPiakMpgGxXLTs9o/Pncayeyj7FHPkI/UrUa0jEE5DGp0F6K6BpLKYf31dbIe0+OwUAGsTPbU24ldIthR+VvAfUu6U1rYvFR8o4iwKkGaG8L1PIaqOw/8VM68PfYErKEc4V0vI+oo9XsfHf85V08QmoHx3ru7yShBzurFUuOB4Q8eO1KGEaf7CbbLr8gjrJxe/pIBkTRAf7kg7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14)
 by SA2PR11MB4890.namprd11.prod.outlook.com (2603:10b6:806:117::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 02:23:03 +0000
Received: from MW4PR11MB5872.namprd11.prod.outlook.com
 ([fe80::92a7:f6a2:9262:d150]) by MW4PR11MB5872.namprd11.prod.outlook.com
 ([fe80::92a7:f6a2:9262:d150%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 02:23:03 +0000
From: "Yao, Jiewen" <jiewen.yao@intel.com>
To: Qinkun Bao <qinkun@google.com>, Samuel Ortiz <sameo@rivosinc.com>, "Lu,
 Ken" <ken.lu@intel.com>
CC: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v1 3/4] tsm: Allow for mapping RTMRs to TCG TPM PCRs
Thread-Topic: [RFC PATCH v1 3/4] tsm: Allow for mapping RTMRs to TCG TPM PCRs
Thread-Index: AQHaTNiWmK5wNKvZgEmrjpBk25Oo5LDlF8EA
Date: Mon, 22 Jan 2024 02:23:02 +0000
Message-ID: <MW4PR11MB5872F46A2089C8C2D8EF7A008C752@MW4PR11MB5872.namprd11.prod.outlook.com>
References: <20240114223532.290550-1-sameo@rivosinc.com>
 <20240114223532.290550-4-sameo@rivosinc.com>
 <1bbf8d3e-aa94-48c7-a1e4-76f9eefc4af7@linux.intel.com>
 <65a72c305291f_3b8e29484@dwillia2-xfh.jf.intel.com.notmuch>
 <5539c533-37b2-4b12-a5c5-056881cf8e3c@linux.intel.com>
 <Za1G9I+tYuIL9ser@vermeer> <CF3D8DE1-AD47-4A77-B8BD-8A12A6F7E9DB@google.com>
In-Reply-To: <CF3D8DE1-AD47-4A77-B8BD-8A12A6F7E9DB@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5872:EE_|SA2PR11MB4890:EE_
x-ms-office365-filtering-correlation-id: 069776fc-a813-440b-8794-08dc1af10f8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z0u4tBTV1pLP1x28jfThAr6zEZ8WV4r2+JE/cFI6V6TiZEdxNdoezy8p1ODiaplscEu7r+BYWmEM935s1UZ+wJhg7LHeAWBzMyKOfmEdomE6BC1qo83yEQPvclZuQW10udg+H4bubGr2ewHUdpTShs/AleKRUes3u7u1RRbiBcvNoD4pETomkpoZqMeNS587Aq/a0hkUcjJzDxYA1Du/4viODDVPb2sB1ePeOI5wWsvKBOwWJdeVAk0y9F28MnN/YAFykpgNkyHyC3BYHSqwFeRk8t/rDr0Bz1+/DIGt5rKi9+4K6crXIRmWFcJYKwh7dmeFdvBAekRLlxsuOY9lOawRigSCRhvwpwZJUFHHOzZv1DgyIIAmL7CtDAendbNAMpwdrBS5mWWz+Pn2uLLv8Xj+p87cQPWclpWn4wKdA1bEID21of4FMBf87ssGKmFake2YkDDJ4PLVIAXxGhtRqyqj0BHG1cVZzMMSRa2vo2svop2/ghxiJGJwuibqETGtK42PgTE2hUVpiuBx02s4zeUylhf3Xnq0gmq3GarrJs1+XLoK4lksoQPOzO5V2pIq4+3kNw9PhGJ0fRyNdNY0wbLFPjaTiVsNwjUa0KTFPxBN2ow2ZZyw3025qCZCg44vN4vMM7njVC7YoPmR9SCyYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5872.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41300700001)(55016003)(26005)(38070700009)(478600001)(6506007)(9686003)(71200400001)(83380400001)(7696005)(53546011)(38100700002)(82960400001)(122000001)(5660300002)(966005)(33656002)(110136005)(66476007)(54906003)(64756008)(66556008)(66946007)(6636002)(76116006)(66446008)(316002)(86362001)(8676002)(8936002)(2906002)(4326008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDNqQWJjcThCKzhmWmVKaWgzS29UVmpqU0VuTkttVEMrc3E4SUxwVXlaM1lk?=
 =?utf-8?B?ci9TQzAxbkJ5M2hxOFQ3S1V1Zjdtb29Ga2pzTEZKSExkdUFQbk9Wd0l5OGZE?=
 =?utf-8?B?OGlteHU3T3NTU1VZakhrV3VUVFFYVjhVS3pkTUJTSU9SVXBWR3J1U3R4VWVr?=
 =?utf-8?B?ODE3WG9kb2ZwS0k0OHJNQTVjaWhNREJnRWtoU0sxanN2QXBHdFdpanZNZ09Y?=
 =?utf-8?B?MXE5S0RVbHlDNC9VRVJYWjMwcFh1V3BFYklySkM2UUNXdXRwSktTODFjK0Jj?=
 =?utf-8?B?VnhyS3N4UTFKblZTbUs0bUlXSlFOc0krTUNVY3YwenBRcHROWXAzczhRamF3?=
 =?utf-8?B?UkRkb09CNUx6eWxLektLR1ZPYkI3Q09JSVpsUHY5WHFsb3ZlT3crdU1OOWt2?=
 =?utf-8?B?OFR2ZDlkN1dzWFBRaUYwQWd3NDZFN1JwaitKaHk3M2VaQU9Ta0hXclk4czhj?=
 =?utf-8?B?Yk9yeGVaN2hCcm05dTAzSGt5QTRNTnJnSnZuTm96d2hCUXRoQitQRy9jSjMz?=
 =?utf-8?B?a2dSTGJSdWN6RDNDSXFSYjdmMis0bEZJSFd0WWs5cWJsTU9tRUlWeWtEN3pD?=
 =?utf-8?B?dHVpVjNET1ZwTEt0eDJ6SHlMeXloMXpXd1c4UE5ZWmdiT0xIWDhUa0dHWlpJ?=
 =?utf-8?B?UXEzR0ZhQXIrUXoxWkwwbzh6MFlJVGswcWFQVU1iNzhrYXc3T3BmR014UjlH?=
 =?utf-8?B?bzNmWWxkS2RmbGNKK1lSb01pMkdFRzhweWNvVThWNTMyK3A4d1ZublpQQjBh?=
 =?utf-8?B?ZTRRRXZRK1k1UWE1Tkx0a2ZRNGJsOFNHS1VXUjl5clJUNHY2NTBBRnhycWNl?=
 =?utf-8?B?QlRJd1VQaHpJMXFvYUpmSDRsejdFU0ZRb3JQU3BuKzJUbEVKbE5mKzl5dDZq?=
 =?utf-8?B?U2cveXUvbTBaYng0NjhOcVRaSHBDZUI2ZmRRekxjNkJWbnJhTlB1VU4zemJt?=
 =?utf-8?B?Z2xYS2hmWDdTVWIxRkNxYStNZnFPNVVLck5NUzQ1RDRyWkhVd01IZW90UTM1?=
 =?utf-8?B?TjVmY0EzYWVTZEUyY3hWRWVicW8zdVZnVkNqZk5GME8rTll5WDVjeVc0SjVy?=
 =?utf-8?B?c3Qvc3BsZE45eEZqV0hxMnNyYlZBZ3VOdFAzN3UxNUV3VXBLVm1TTktYWnF6?=
 =?utf-8?B?Y3dYMEM5elBKVjdad0VhR2ZTUlNZVTlEZ0oxNWxoOVBDL0dua0NRWFJKMkw1?=
 =?utf-8?B?dFFJUHdnOXRqd1RBNGEreGVyVWRFNEdJekxNZ0tNRjh1SXdJbmNkdEhiNG9V?=
 =?utf-8?B?SWtrS21HRkdvb0E3WWIzdW5hTFhtN09aUXFveDJWWkdvc1J4VzdBYWdjY3NN?=
 =?utf-8?B?TmdRS0JCbXVJZXA5akxuc0JlaVJXQWFiVS95NFNQbEZocVZKblNxNGYrb3hn?=
 =?utf-8?B?c3FhOEdhdGVtaVQ5c29CTzZFY1BOT2VTZGo4Q0FTK0dXeW1RMFNWOEVKeTEv?=
 =?utf-8?B?eWt4N0h0S3F6cStGNTQ1TXZHWnIwcjYxbnN3M0pMUXB3Rm1WUUFvWjNyeUht?=
 =?utf-8?B?b2dsZWMxWWpvN0ZIM2h3bXJPTFZMNWhpU2tyYkZmYzFIK29yN01rQkpCUDBD?=
 =?utf-8?B?VG84em84OFZKNlhXcXpjR3FXNFhWUEk0d2tld1B4MFpYTE00YThnOVZzaXp1?=
 =?utf-8?B?RFpUdlJlUXZPSDRHYWRZSmpPdm1jUkI1M1B5K2IrdDN4ek5Pc25QRUVwME8v?=
 =?utf-8?B?cnJtZGxIdHEzclVjVk5BZ1lZSGxXL3RsdHVERDgyQmRWNEk1Qk8wWkcraTht?=
 =?utf-8?B?eDdlY1BVcnU1N2pyN1hJYlgybC9ycUZudGhRUUNTMUZUWjhVdWtWK01lMHox?=
 =?utf-8?B?ci9WWWFyaVE3d1VUaHBWdWwrS0pLSkt2OWovRnJNeFJDZzRJekdIV2d5aUZr?=
 =?utf-8?B?OW90bGZwRFZzWk9vcFA2b0tMNW9yZnhaOVhvN2lGS2sySXozaTVLbUVhaVBt?=
 =?utf-8?B?K3dGOUlCY3BzL1F2NEhnLzRYSldROXYyL1ZBeEh1UzRGOFN5M2t0RExWMFJw?=
 =?utf-8?B?RUsxVEQ2VDR5N2lvSW9xaExHYzQvaGVzNFFwaEdsRG9UcHo2ai9VT1A2SnNP?=
 =?utf-8?B?TGFHZzFpa1JpTjRLT09KdWhxcTgwSFQwR0J3QVpnenFMcGpFbjlPczl2OXpR?=
 =?utf-8?Q?tXHwbkd6C2QdLyM0f7dMWxnWW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5872.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 069776fc-a813-440b-8794-08dc1af10f8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 02:23:02.9828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LzY7YKIwU8vkDw9Br5nUG360bQFGPyyy1JcaNO9h98BtV+iaoNKXQ0q5FeeJOg6nrLCJPA444tQ6KhB/QMISfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4890
X-OriginatorOrg: intel.com

Q29tbWVudCBiZWxvdzoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBR
aW5rdW4gQmFvIDxxaW5rdW5AZ29vZ2xlLmNvbT4NCj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDIy
LCAyMDI0IDEwOjEzIEFNDQo+IFRvOiBTYW11ZWwgT3J0aXogPHNhbWVvQHJpdm9zaW5jLmNvbT47
IFlhbywgSmlld2VuIDxqaWV3ZW4ueWFvQGludGVsLmNvbT47DQo+IEx1LCBLZW4gPGtlbi5sdUBp
bnRlbC5jb20+DQo+IENjOiBLdXBwdXN3YW15IFNhdGh5YW5hcmF5YW5hbg0KPiA8c2F0aHlhbmFy
YXlhbmFuLmt1cHB1c3dhbXlAbGludXguaW50ZWwuY29tPjsgV2lsbGlhbXMsIERhbiBKDQo+IDxk
YW4uai53aWxsaWFtc0BpbnRlbC5jb20+OyBsaW51eC1jb2NvQGxpc3RzLmxpbnV4LmRldjsgbGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0gg
djEgMy80XSB0c206IEFsbG93IGZvciBtYXBwaW5nIFJUTVJzIHRvIFRDRyBUUE0gUENScw0KPiAN
Cj4gDQo+IA0KPiA+IE9uIEphbiAyMSwgMjAyNCwgYXQgODozMeKAr0FNLCBTYW11ZWwgT3J0aXog
PHNhbWVvQHJpdm9zaW5jLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBUdWUsIEphbiAxNiwgMjAy
NCBhdCAwNzozNTozMFBNIC0wODAwLCBLdXBwdXN3YW15IFNhdGh5YW5hcmF5YW5hbg0KPiB3cm90
ZToNCj4gPj4NCj4gPj4gT24gMS8xNi8yNCA1OjI0IFBNLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
ID4+PiBLdXBwdXN3YW15IFNhdGh5YW5hcmF5YW5hbiB3cm90ZToNCj4gPj4+PiBPbiAxLzE0LzI0
IDI6MzUgUE0sIFNhbXVlbCBPcnRpeiB3cm90ZToNCj4gPj4+Pj4gTWFueSB1c2VyIHNwYWNlIGFu
ZCBpbnRlcm5hbCBrZXJuZWwgc3Vic3lzdGVtcyAoZS5nLiB0aGUgTGludXggSU1BKQ0KPiA+Pj4+
PiBleHBlY3QgYSBSb290IG9mIFRydXN0IGZvciBTdG9yYWdlIChSVFMpIHRoYXQgYWxsb3dzIGZv
ciBleHRlbmRpbmcNCj4gPj4+Pj4gYW5kIHJlYWRpbmcgbWVhc3VyZW1lbnQgcmVnaXN0ZXJzIHRo
YXQgYXJlIGNvbXBhdGlibGUgd2l0aCB0aGUgVENHIFRQTQ0KPiA+Pj4+PiBQQ1JzIGxheW91dCwg
ZS5nLiBhIFRQTS4gSW4gb3JkZXIgdG8gYWxsb3cgdGhvc2UgY29tcG9uZW50cyB0bw0KPiA+Pj4+
PiBhbHRlcm5hdGl2ZWx5IHVzZSBhIHBsYXRmb3JtIFRTTSBhcyB0aGVpciBSVFMsIGEgVFZNIGNv
dWxkIG1hcCB0aGUNCj4gPj4+Pj4gYXZhaWxhYmxlIFJUTVJzIHRvIG9uZSBvciBtb3JlIFRDRyBU
UE0gUENScy4gT25jZSBjb25maWd1cmVkLCB0aG9zZQ0KPiBQQ1INCj4gPj4+Pj4gdG8gUlRNUiBt
YXBwaW5ncyBnaXZlIHRoZSBrZXJuZWwgVFNNIGxheWVyIGFsbCB0aGUgbmVjZXNzYXJ5IGluZm9y
bWF0aW9uDQo+ID4+Pj4+IHRvIGJlIGEgUlRTIGZvciBlLmcuIHRoZSBMaW51eCBJTUEgb3IgYW55
IG90aGVyIGNvbXBvbmVudHMgdGhhdCBleHBlY3RzDQo+ID4+Pj4+IGEgVENHIGNvbXBsaWFudCBU
UE0gUENScyBsYXlvdXQuDQo+ID4+Pj4+DQo+ID4+Pj4+IFRQTSBQQ1IgbWFwcGluZ3MgYXJlIGNv
bmZpZ3VyZWQgdGhyb3VnaCBjb25maWdmczoNCj4gPj4+Pj4NCj4gPj4+Pj4gLy8gQ3JlYXRlIGFu
ZCBjb25maWd1cmUgMiBSVE1Scw0KPiA+Pj4+PiBta2RpciAvc3lzL2tlcm5lbC9jb25maWcvdHNt
L3J0bXJzL3J0bXIwDQo+ID4+Pj4+IG1rZGlyIC9zeXMva2VybmVsL2NvbmZpZy90c20vcnRtcnMv
cnRtcjENCj4gPj4+Pj4gZWNobyAwID4gL3N5cy9rZXJuZWwvY29uZmlnL3RzbS9ydG1ycy9ydG1y
MC9pbmRleA0KPiA+Pj4+PiBlY2hvIDEgPiAvc3lzL2tlcm5lbC9jb25maWcvdHNtL3J0bXJzL3J0
bXIxL2luZGV4DQo+ID4+Pj4+DQo+ID4+Pj4+IC8vIE1hcCBSVE1SIDAgdG8gUENScyA0LCA1LCA2
LCA3IGFuZCA4DQo+ID4+Pj4+IGVjaG8gNC04ID4gL3N5cy9rZXJuZWwvY29uZmlnL3RzbS9ydG1y
cy9ydG1yMC90Y2dfbWFwDQo+ID4+Pj4+DQo+ID4+Pj4+IC8vIE1hcCBSVE1SIDEgdG8gUENScyAx
NiwgMTcgYW5kIDE4DQo+ID4+Pj4+IGVjaG8gMTYtMTggPiAvc3lzL2tlcm5lbC9jb25maWcvdHNt
L3J0bXJzL3J0bXIxL3RjZ19tYXANCj4gPj4+PiBBbnkgaW5mb3JtYXRpb24gb24gaG93IHRoaXMg
bWFwcGluZyB3aWxsIGJlIHVzZWQgYnkgVFBNIG9yIElNQSA/DQo+ID4+Pj4NCj4gPj4+PiBSVE1S
IHRvIFBDUiBtYXBwaW5nIGlzIGZpeGVkIGJ5IGRlc2lnbiwgcmlnaHQ/IElmIHllcywgd2h5IGFs
bG93DQo+ID4+Pj4gdXNlciB0byBjb25maWd1cmUgaXQuIFdlIGNhbiBsZXQgdmVuZG9yIGRyaXZl
cnMgdG8gY29uZmlndXJlIGl0LCByaWdodD8NCj4gPj4+IEkgYXNzdW1lIHRoZSAidmVuZG9yIGRy
aXZlciIsIHRoYXQgcHVibGlzaGVzIHRoZSBSVE1SIHRvIHRoZSB0c20tY29yZSwNCj4gPj4+IGhh
cyBubyBpZGVhIHdoZXRoZXIgdGhleSB3aWxsIGJlIHVzZWQgZm9yIFBDUiBlbXVsYXRpb24sIG9y
IG5vdC4gVGhlIFRQTQ0KPiA+Pj4gcHJveHkgbGF5ZXIgc2l0dGluZyBvbiB0b3Agb2YgdGhpcyB3
b3VsZCBrbm93IHRoZSBtYXBwaW5nIG9mIHdoaWNoIFJUTVJzDQo+ID4+PiBhcmUgcmVjb3JkaW5n
IGEgdHJhbnNjcmlwdCBvZiB3aGljaCBQQ1IgZXh0ZW5kIGV2ZW50cy4NCj4gPj4NCj4gPj4gTXkg
dGhpbmtpbmcgaXMsIHNpbmNlIHRoaXMgbWFwcGluZyBpcyBBUkNILXNwZWNpZmljIGluZm9ybWF0
aW9uDQo+ID4+IGFuZCBmaXhlZCBieSBkZXNpZ24sIGl0IG1ha2VzIG1vcmUgc2Vuc2UgdG8gaGlk
ZSB0aGlzIGRldGFpbCBpbiB0aGUNCj4gPj4gdmVuZG9yIGRyaXZlciB0aGFuIGxldHRpbmcgdXNl
cnNwYWNlIGNvbmZpZ3VyZSBpdC4gSWYgd2UgYWxsb3cgdXNlcnMgdG8NCj4gPj4gY29uZmlndXJl
IGl0LCB0aGVyZSBpcyBhIGNoYW5jZSBmb3IgaW5jb3JyZWN0IG1hcHBpbmcuDQo+ID4NCj4gPiBJ
IHRoaW5rIEkgYWdyZWUgd2l0aCB0aGUgZmFjdCB0aGF0IGxldHRpbmcgdXNlcnMgY29uZmlndXJl
IHRoYXQgbWFwcGluZw0KPiA+IG1heSBiZSBlcnJvciBwcm9uZS4gQnV0IEknbSBub3Qgc3VyZSB0
aGlzIGlzIGFuIGFyY2hpdGVjdHVyZSBzcGVjaWZpYw0KPiA+IG1hcHBpbmcsIGJ1dCByYXRoZXIg
YSBwbGF0Zm9ybSBzcGVjaWZpYyBvbmUuIEknZCBleHBlY3QgdGhlIGd1ZXN0IGZpcm13YXJlDQo+
ID4gdG8gcHJvdmlkZSBpdCB0aHJvdWdoIGUuZy4gdGhlIE1hcFBjclRvTXJJbmRleCBFRkkgQ0Mg
cHJvdG9jb2wuDQo+ID4NCj4gPiBTbyBJIGFncmVlIEkgc2hvdWxkIHJlbW92ZSB0aGUgdXNlciBp
bnRlcmZhY2UgZm9yIHNldHRpbmcgdGhhdCBtYXBwaW5nLA0KPiA+IGFuZCBwYXNzIGl0IGZyb20g
dGhlIHByb3ZpZGVyIGNhcGFiaWxpdGllcyBpbnN0ZWFkLiBJdCBpcyB0aGVuIHVwIHRvIHRoZQ0K
PiA+IHByb3ZpZGVyIHRvIGNob29zZSBob3cgaXQnZCBidWlsZCB0aGF0IGluZm9ybWF0aW9uICho
YXJkIGNvZGVkLCBmcm9tDQo+ID4gRUZJLCBldGMpLg0KPiANCj4gVGhlIFVFRkkgc3BlY2lmaWNh
dGlvbiBoYXMgZGVmaW5lZCB0aGUgbWFwcGluZyByZWxhdGlvbnNoaXAgYmV0d2VlbiB0aGUNCj4g
VERYIFJUTVIgYW5kIFRQTSBQQ1JzIChTZWUNCj4gaHR0cHM6Ly91ZWZpLm9yZy9zcGVjcy9VRUZJ
LzIuMTAvMzhfQ29uZmlkZW50aWFsX0NvbXB1dGluZy5odG1sI2ludGVsLXRydXN0LQ0KPiBkb21h
aW4tZXh0ZW5zaW9uKS4gVGhlIGN1cnJlbnQgUlRNUiBpbXBsZW1lbnRhdGlvbiBpbiB0aGUgYm9v
dCBsb2FkZXINCj4gaXMg4oCcaG9va2Vk4oCdIGluIHRoZSBpbXBsZW1lbnRhdGlvbiBmb3IgdGhl
IFRQTS4NCj4gDQo+IFdoZW4gdGhlIGJvb3Rsb2FkZXIgbmVlZHMgdG8gZXh0ZW5kIHRoZSBQQ1Ig
dmFsdWUsIGl0IGNhbGxzDQo+IGBtYXBfcGNyX3RvX21yX2luZGV4YCAgdG8gcmV0cmlldmUgdGhl
IGNvcnJlc3BvbmRpbmcgUlRNUiBpbmRleCBhbmQNCj4gdGhlbiBleHRlbmRzIHRoZSBSVE1SLiBD
b25zaWRlcmluZyB0aGlzIGJlaGF2aW9yLCBJIGRvbuKAmXQgdGhpbmsgd2Ugc2hvdWxkDQo+IGFs
bG93IHVzZXJzIHRvIGNvbmZpZ3VyZSB0aGUgbWFwcGluZ3MgYmV0d2VlbiB0aGUgUENSIGFuZCBS
VE1SLiAoU2VlDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9yaGJvb3Qvc2hpbS9wdWxsLzQ4NS9maWxl
cykuDQo+IA0KPiBBZGQgSmlld2VuIChvd25lciBvZiB0aGUgUlRNUiBjaGFuZ2VzIGluIHRoZSBm
aXJtd2FyZSkgYW5kIEtlbiAoDQo+IG93bmVyIG9mIHRoZSBSVE1SIGNoYW5nZXMgaW4gdGhlIGJv
b3QgbG9hZGVyKSBmb3IgdGhlIHZpc2liaWxpdHkuDQoNCkkgdGhpbmsgdGhlIG1hcHBpbmcgc2hv
dWxkIGJlIHN0YXRpYyBhbmQgZGV0ZXJtaW5lZCBieSB0aGUgaGFyZHdhcmUgYXJjaGl0ZWN0dXJl
Lg0KDQpBbGxvd2luZyB1c2VyIHRvIGNvbmZpZ3VyZSB0aGUgbWFwcGluZyBqdXN0IGFkZHMgY29t
cGxleGl0eSBhbmQgY29uZnVzaW5nLiBGb3IgZXhhbXBsZSwgdGhlIHVzZXIgbXVzdCB1bmRlcnN0
YW5kIGNsZWFybHkgb24gd2hhdCBpcyBJbnRlbC1URFgvQU1ELVNFVi9BUk0tQ0NBL1JJU0NWLUNv
VkUsIGhvdyBtYW55IHJlZ2lzdGVycyB0aGV5IGhhdmUsIHdoYXQgaXMgdGhlIGJlc3Qgd2F5IHRv
IG1hcCBpdC4NCg0KSXQgYWxzbyBhZGRzIGNvbXBsZXhpdHkgdG8gdGhlIHZlcmlmaWVyLiBGb3Ig
ZXhhbXBsZSwgdGhlIHZlcmlmaWVyIG11c3QgdW5kZXJzdGFuZCBob3cgYSB1c2VyIGNvbmZpZ3Vy
ZSB0aGUgbWFwcGluZywgdGhlbiBnZXQgdGhlIGV4cGVjdGVkIG1lYXN1cmVtZW50IHJlZ2lzdGVy
IHZhbHVlLg0KDQpJIGJlbGlldmUgdGhhdCBoaWRpbmcgZGV0YWlsIGlzIGEgYmV0dGVyIHdheSB0
byBhdm9pZCB0aG9zZSBjb21wbGV4aXR5LCBhbmQgbWFrZSBpdCBlYXN5IHRvIHVzZS4NCg0KRG8g
d2UgaGF2ZSBzb21lIHJlYWwgdXNlIGNhc2VzIHRoYXQgYSB1c2VyIE1VU1QgY29uZmlndXJlIHRo
ZSBtYXBwaW5nPw0KDQo+IA0KPiA+DQo+ID4+IFJlZ2FyZGluZyB0aGUgVFBNIHByb3h5LCBJIGFt
IHN0aWxsIG5vdCBjbGVhciBob3cgaXQgaXMgZ29pbmcgdG8gdXNlDQo+ID4+IHRoaXMgbWFwcGlu
Zy4gSWYgd2Ugd2FudCB0byBwcm92aWRlIFRQTSBsaWtlIGZlYXR1cmUsIGl0IG5lZWRzIGENCj4g
Pj4gc3BlY2lhbCBrZXJuZWwgVFBNIGRyaXZlciwgcmlnaHQ/IEV2ZW4gaWYgd2UgZW5hYmxlIFRQ
TSBzdXBwb3J0DQo+ID4+IHdpdGggUlRNUiwgSSBhc3N1bWUgaXQgY2FuIG9ubHkgc3VwcG9ydCBw
Y3JfZXh0ZW5kKCkuDQo+ID4NCj4gPiBFeHRlbmQgYW5kIHJlYWQsIHllcy4NCj4gPg0KPiA+PiBP
dGhlciBUUE0NCj4gPj4gZmVhdHVyZXMgc2hvdWxkIGJlIGRpc2FibGVkLiBJZiB5ZXMsIHNpbmNl
IHdlIGFscmVhZHkgaGF2ZSB0aGlzIEFCSQ0KPiA+PiBmb3IgbWVhc3VyZW1lbnQgZXh0ZW5zaW9u
LCB3aHkgYWdhaW4gc3VwcG9ydCBpdCB2aWEgVFBNIG9yIGRpZA0KPiA+PiBJIG1pc3VuZGVyc3Rh
bmQgdGhlIHVzZSBjYXNlLg0KPiA+DQo+ID4gSSBhbSBub3Qgc3VyZSB0aGUgVFBNIGNvbXBhdGli
aWxpdHkgaXMgYWx3YXlzIG5lZWRlZCwgYnV0IGZvciBzdWJzeXN0ZW1zDQo+ID4gKGxpa2UgZS5n
LiBJTUEpIHRoYXQgbG9vayBmb3IgYSBUUE0gYXMgdGhlaXIgcm9vdCBvZiB0cnVzdCBmb3Igc3Rv
cmFnZSwNCj4gPiBwcm92aWRpbmcgdGhlIGV4dGVuZCtyZWFkIEFCSSBhbmQgdGhlIFBDUiBtYXBw
aW5nIHNob3VsZCBiZSBzdWZmaWNpZW50Lg0KPiA+DQo+ID4gQ2hlZXJzLA0KPiA+IFNhbXVlbC4N
Cj4gPg0KPiA+DQoNCg==

