Return-Path: <linux-kernel+bounces-44678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD138425D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615641C25E53
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367DE6D1BE;
	Tue, 30 Jan 2024 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FL4Jtlu5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6417D6BB28
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620228; cv=fail; b=sgwMfvSVmp6aBpKedSRlC7POjKukNzrz96fKy5LVaHFEHTiurpaDZMz1WjULjpg13zaikNJrG8yF8k4Ya8mS9SySjt51bt9YaGxN0J6RqQ5aHF8Nyr/cHUtkntTnfFEmUZUjnSO9/YmmchFjw4P2sC+oCl7qS1HI4n6wuXlxQW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620228; c=relaxed/simple;
	bh=+oxBTRzdZeCbcB+mpGfhPp6eJSyCnDanTyuoIPy4cas=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FsXE9GKewGoDf4otYbdxohN5we59xgbbpG1RcRbvIvM3GNM81jIgn260mmX1iguyzpb16SufSNA/55Bmtrr25vn+BrddR4fTUdkB5LWO67Ue0RPTY0iuiiF033Vnq+/qGtMTfsLIqUMpJfAqTX3AtQ3tbx5bmFKQmVlF5LhURwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FL4Jtlu5; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706620226; x=1738156226;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+oxBTRzdZeCbcB+mpGfhPp6eJSyCnDanTyuoIPy4cas=;
  b=FL4Jtlu5QAofdRqyAggR5pAxr/Mtjq8pQLl0RKmNRnsNarQuMwOZz9rl
   SsZrMFsJeyJpJb9RFa9cAkpoLkv5aPoD2UVu2rXacw2m5fQbQGhRRwKzr
   xFjoJez4lNc2FRWPCw7CFoqMmg2gINfiJFsWz5KkorfweTxtCzXxsxKID
   Z9mGRPbsdICmmObW9HRkAw637WSIJl5Owy2vAr192yCeM8RJFVZQ5u54d
   nFYSZDqwJAAliiOSlnsLPBsD/76LDAEg7f6wrPyKaw/F2I+MMAiZ20QZU
   7AGPcDY6kuctFH92v3LSszL5JcJLzYph+SJpByMSXJg996jKPASSBX4DN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="10009697"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="10009697"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 05:10:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3794773"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 05:10:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 05:10:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 05:10:23 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 05:10:23 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 05:10:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVChuqTVYCNVu+O2VdU34QKY/MWrhWCd/LDnG0AtltnR02m9NUQUOcCoC2oKpVPC+DWcjpyhi3+38iE68dC+ynyPw5aLP45Fzslwudxhd9PzEC7VKBAP6YcIobywfKW6yXvAHwnJ74y7oRxURWEFgnKW3IQ8GnSyL3P6q/9GsxPmbk+Gvqg0Ini8ogetAmxTHPfO05ENI8e3DSl6a5GdUQGrpNU6fD5xcX0fIJXmCKs5VM30mGi2hNJxD8yxeSOoHoLLzTdgead8GRnpr7whn0ktYuZ6fNSzuDLfTrHn96rEoRT1TnxvIfMCxcqz+TX9EEc0H+w8Lrb4PwicessN/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oxBTRzdZeCbcB+mpGfhPp6eJSyCnDanTyuoIPy4cas=;
 b=dTI6vvLzn9vWVUruSUMddtyOR9JLwKqOQjHE5Tc5vHX4+o/q/piMi326kI82pQ6fBa9jqxGGTVEZJKQF3EmIPhzTPkGuNAAgyz5oIaUZuZJ5MfvMOsacEu17Zs2By02YfN8ozPaX8c+uU+RdDRL3t/Nr0s2BS+qwNK0CNKnFmTwFO0yMYzgWaY6jhPYN1YuaudxIsDYlxMxcJ1pEHey7zkGEYGzaI9elfuHcTchNPsQ9DIjYA5CqNfGZstWPexeZLspXZLHJGOHdkN3rHZKTFYaWdsujTSYPoyHg5V/p69MMgGxsAaQZCJFbzV2p9lkLy4O8iuekZgLD5HLkfCyUyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 IA1PR11MB6074.namprd11.prod.outlook.com (2603:10b6:208:3d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 13:10:21 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 13:10:21 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Nakajima, Jun"
	<jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Kalra,
 Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] x86/random: Retry on RDSEED failure
Thread-Topic: [PATCH 1/2] x86/random: Retry on RDSEED failure
Thread-Index: AQHaU1aX7QKpTpzPXU+lq+SGmZ3MRrDySSwAgAAHtwA=
Date: Tue, 30 Jan 2024 13:10:20 +0000
Message-ID: <DM8PR11MB5750E38A8B2BCE66AF7F9812E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <CAHmME9pOt=uEmuBzBpgUHw9DqAD2FZTZ3v53AOZbQ3Cd2p97xQ@mail.gmail.com>
In-Reply-To: <CAHmME9pOt=uEmuBzBpgUHw9DqAD2FZTZ3v53AOZbQ3Cd2p97xQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|IA1PR11MB6074:EE_
x-ms-office365-filtering-correlation-id: 8ed12fbc-6fd2-4a73-6beb-08dc2194d016
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NKEkZcX53Q9RKYvyhoL/3qW/ZBcg6CUw9kxpM9BviBZzHcVWZ1JvTONiVyIk2ohB+rU2bYEt6Z1ioFkO2vtk/g9q8oNTkHKIP/TVJiFeucNQggsmlSS/J/YlaDaQzYTZ306mAXFshjzayzad3woj17TJu54vW8uWtla9syAJj/BdRyMHGU9m4ypWekAP2zbR0b2/A2F0mm6ixm2R3KISyeGzAx5+RIw6j+j7izLd3s21Rm0Ly8bFHAt5D1H6MqJqs0GbHU8e7bnA7XL3mpAuEVNx78mQHQvX+e/CzF3D/uD93Tv4L6HlJ9MzYY+VREPpTXAIQp9NBc5RXRt3g98lDtLkGZ/nh6q2nSeJ+7VOmUa8thOr8kkX1h7oIlLn8SIteVbPNpztN6Sk4Vopq0qvZGzmwbewRIKO97yUe/tiSXLoucnvOw/euK1ZRksIu+2mZ5WjFFz+6t8FYwFDxFgffrc/ua1nuCE7VHYvQ6TwHmUehiuTjCylTKOz8ejLqkihQutW4KPpGndkra5Qva7n9H26TxFvlbrZ7S3ZcAzD6/ReBB6G44BJQKFP46EJorLgTsEP//187IQ/0aVXxnMmmIbQ6H0OaqC9S3R9wO6mx/4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(66476007)(64756008)(66446008)(7696005)(53546011)(83380400001)(6506007)(9686003)(5660300002)(55016003)(8676002)(76116006)(54906003)(8936002)(26005)(7416002)(66556008)(316002)(66946007)(71200400001)(110136005)(86362001)(478600001)(82960400001)(33656002)(966005)(122000001)(4326008)(38100700002)(52536014)(41300700001)(38070700009)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ny9Ob2tDcm9KeWt1OVgrVGpVSVRSbFZmenBqeFZUNnhDeUhUNEhVVDlzS2xC?=
 =?utf-8?B?MEU1eUhxdkh4d2ovWnZsZmVZSFZxVXFUTWMyRldIL1krRVZjdUZSVWIyOTVI?=
 =?utf-8?B?Y2RML3M4TlNlWEF2TnRSbXpYM2tXLzQ1S01UTUZ4enhqZzVFaE9yZ3hEWTd0?=
 =?utf-8?B?aWZ6YXIvTlY4UkcyZEVraHhEZ1F3bTM5eEcyNWR6alRVUjdWcVRsYVo2RFNz?=
 =?utf-8?B?Nlk0MHlMbzBMVXJTNlFvSFRCWTFuSWFWV2VuRWl5dEZDRWJJU0tOcU5IR3dI?=
 =?utf-8?B?aE5mTHMvZjdjT1lzQlN5SmtpQVpVcnZUZWhkQURHakdjUXJxd0crb3g4MHV2?=
 =?utf-8?B?N1NNaGRRQTQ4QXlyUUdPcmQ3Y3FVVHlldTF4ZFR6eXlDRERseUcxVVR1NnNi?=
 =?utf-8?B?THhDQ3F3VWZoQUkrZGY5NnV1eGhJdFFjV2lzNjBhY0xLUklKYTdBenNxOUgv?=
 =?utf-8?B?enBmOGtTelFTaDN6ektidHpQZjhpNUxRQ1Q3SW5iM3J1czBUeWE5TDAvRm9l?=
 =?utf-8?B?OTBmMnRreFFSakpjNUlZVHArMWxzK3VhU1Q1c1N5V3J0OEZKcDZraytKMjR1?=
 =?utf-8?B?TjIwNmN4T1daSGRxLzZRcytvQWJCc0FqdkVIMm9aY2tnNEFsNU04WXlSV1A3?=
 =?utf-8?B?NFpiajRpWDRLSkpsMmhHamhqSGxvTm92L0hXWUtEOGREWmFlMk9HZmZicUN0?=
 =?utf-8?B?MnZ3ajVmUVJQUWdqRzRJQ0RHZ3pla0hCbVJxaldSdmh0c00zamwzYXNtQ0Mr?=
 =?utf-8?B?WTlWTmtsbnI3REdYa3FBQkV2dE0wQW9LT3dpNlQ3MGkrSm5WNUEyRk5acXpM?=
 =?utf-8?B?eXBXNS9SQjZnVTg0MUNncTJpdHh5Zzd4bHRjVitwbk1iNDVYbGNsSkpOTWFI?=
 =?utf-8?B?RkI5dG9xZXd6VnREcnd2OXBlSkZuN1djS092RStqOW5Hck8vclAwc1RFWEFP?=
 =?utf-8?B?Z0N6N21FQkEvVjBQRmZma1VlQ0NURDQ4NmpZOXBueHZGSjh4L0wxODBzclR4?=
 =?utf-8?B?UlBBTUZtaXlGRXFscmZ2NnpFNUpjWWhxNUQyRUdCSDFPM3RENVp4RkJmZDNW?=
 =?utf-8?B?SjZyQWdvZnZUbDRZVFpNL1pSbzdIdk1xeTZrRjdQV2diK1hzNVFQejdSaEEy?=
 =?utf-8?B?VkRwOG9VOVZ2eXR3WEswNzYrblhXUHRtTGpubW0zNk42NnAzMFc3c2hKYTMz?=
 =?utf-8?B?UlpXclcreVU4UWlmbmJQQndmcG5UVXkwRXJyazY3cmZBeGEvTDQ2ZTNadVhX?=
 =?utf-8?B?N2VkZ3NFbU51aTNoNXIvcVlReU9CYnJBdCtXUEQ5Rm5YUWZyamhpU3hlRWVF?=
 =?utf-8?B?dVVpN1NYbWxaT3hPRmliUmV1eXJmOXc2M3lONnRDQ1pyK3R1ZktmMlo5Um0w?=
 =?utf-8?B?SitvWXBCK1pmbWdpQXdiNUYxVytkemRFak1MYS9NK2dpL0c2QUtIbWJ5cFdH?=
 =?utf-8?B?Z0lSUVRGelQwWEJBRHdTQ0JaeHY2UHh3OERnVG5zZXJ1NGt6RWMvMnVlZnRq?=
 =?utf-8?B?K2pxcnN4SEx3ZU1ZV3lmaENPMitDS0hTZXo2K1NwNTZUa0x5OFk3TDNPSzZK?=
 =?utf-8?B?VVh3TTl4UHFoNURjT3RIQ2h5RW9RYTF0eHVKOUVJVEFaY0pvZEJ3MGNCcEhB?=
 =?utf-8?B?STBRQ2VVbzZNV2xHa3BRbGtKTSt2UHY0RExNTGR5clFlSmdxejd6c1Bnd04z?=
 =?utf-8?B?VC9MeHRQSHRwNjZQeWJkU3d0cjFjaENJd1NPTU5Oa01zYUxpZTFNMytLYlhv?=
 =?utf-8?B?QUVwSTZvTjJQWWdYczNYblZnVnU3WXljaVZNSlEvOW4wQmpBV0JiYVEzdm9r?=
 =?utf-8?B?b0U3ZVNBZGhRUnRPNW5ZTExIdkF2UXFLeGhXRXFtdFNleU14TGdqUUlxWXF5?=
 =?utf-8?B?S0NvMFQ0MGZzOVlhMjJSL3NxdWlzVTlPSnlnWStNUnRxYTNYM1I4cnhhNEx3?=
 =?utf-8?B?Y3FqYk16bE9MTFVpRllIWFBnMUw4QmdPMXBDcXRyM3BNak4zNjJxbmt3cXN0?=
 =?utf-8?B?N3BxSUtjRUlmU3ZuTlFhajNFWmhuVHIyekZoT29QTHBmR3IrdEozR3ljUmZ6?=
 =?utf-8?B?QzNqdk05OFhpcEtWNWtqRWtOWkZtM25vV3MvUm5jZmV4dmZqcG9FMHEyOG5X?=
 =?utf-8?Q?/RGK3aTVFAcBD3uDKCzKyBHq/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed12fbc-6fd2-4a73-6beb-08dc2194d016
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 13:10:20.9483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GiB3h7BwSL2ZNuJw+BxnsX7EAvFDdwdxmNKPlQuD+wA69lyyLCP2HAohkHY6rQ8Q7ub0kylm+/9GsGxi7MmDLg8GtsD8sSO85/rjYPD5FlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6074
X-OriginatorOrg: intel.com

IA0KPiBIaSBLaXJpbGwsDQo+IA0KPiBJJ3ZlIGJlZW4gZm9sbG93aW5nIHRoZSBvdGhlciBkaXNj
dXNzaW9uIGNsb3NlbHkgdGhpbmtpbmcgYWJvdXQgdGhlDQo+IG1hdHRlciwgYnV0IEkgc3VwcG9z
ZSBJJ2xsIGp1bXAgaW4gaGVyZSBkaXJlY3RseSBvbiB0aGlzIHBhdGNoLCBpZg0KPiB0aGlzIGlz
IHRoZSBhcHByb2FjaCB0aGUgZGlzY3Vzc2lvbiBpcyBjb25nZWFsaW5nIGFyb3VuZC4NCj4gDQo+
IEEgY29tbWVudCBiZWxvdzoNCj4gDQo+IE9uIFR1ZSwgSmFuIDMwLCAyMDI0IGF0IDk6MzDigK9B
TSBLaXJpbGwgQS4gU2h1dGVtb3YNCj4gPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+
IHdyb3RlOg0KPiA+ICBzdGF0aWMgaW5saW5lIGJvb2wgX19tdXN0X2NoZWNrIHJkc2VlZF9sb25n
KHVuc2lnbmVkIGxvbmcgKnYpDQo+ID4gIHsNCj4gPiArICAgICAgIHVuc2lnbmVkIGludCByZXRy
eSA9IFJEUkFORF9SRVRSWV9MT09QUzsNCj4gPiAgICAgICAgIGJvb2wgb2s7DQo+ID4gLSAgICAg
ICBhc20gdm9sYXRpbGUoInJkc2VlZCAlW291dF0iDQo+ID4gLSAgICAgICAgICAgICAgICAgICAg
Q0NfU0VUKGMpDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgOiBDQ19PVVQoYykgKG9rKSwgW291
dF0gIj1yIiAoKnYpKTsNCj4gPiAtICAgICAgIHJldHVybiBvazsNCj4gPiArDQo+ID4gKyAgICAg
ICBkbyB7DQo+ID4gKyAgICAgICAgICAgICAgIGFzbSB2b2xhdGlsZSgicmRzZWVkICVbb3V0XSIN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIENDX1NFVChjKQ0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgOiBDQ19PVVQoYykgKG9rKSwgW291dF0gIj1yIiAoKnYpKTsN
Cj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIGlmIChvaykNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPiArICAgICAgIH0gd2hpbGUgKC0tcmV0cnkpOw0KPiA+
ICsNCj4gPiArICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiAgfQ0KPiANCj4gU28sIG15IHVuZGVy
c3RhbmRpbmcgb2YgUkRSQU5EIHZzIFJEU0VFRCAtLSBkZWxpYmVyYXRlbHkgbGVhdmluZyBvdXQN
Cj4gYW55IGNyeXB0b2dyYXBoaWMgZGlzY3Vzc2lvbiBoZXJlIC0tIGlzIHJvdWdobHkgdGhhdCBS
RFJBTkQgd2lsbA0KPiBleHBhbmQgdGhlIHNlZWQgbWF0ZXJpYWwgZm9yIGxvbmdlciwgd2hpbGUg
UkRTRUVEIHdpbGwgbW9zdGx5IGFsd2F5cw0KPiB0cnkgdG8gc2FtcGxlIG1vcmUgYml0cyBmcm9t
IHRoZSBlbnZpcm9ubWVudC4gQUVTIGlzIGZhc3QsIHdoaWxlDQo+IHNhbXBsaW5nIGlzIHNsb3cs
IHNvIFJEUkFORCBnaXZlcyBiZXR0ZXIgcGVyZm9ybWFuY2UgYW5kIGlzIGxlc3MNCj4gbGlrZWx5
IHRvIGZhaWwsIHdoZXJlYXMgUkRTRUVEIGFsd2F5cyBoYXMgdG8gd2FpdCBvbiB0aGUgaGFyZHdh
cmUgdG8NCj4gY29sbGVjdCBzb21lIGJpdHMsIHNvIGlzIG1vcmUgbGlrZWx5IHRvIGZhaWwuDQoN
ClRoZSBpbnRlcm5hbHMgb2YgSW50ZWwgRFJCRyBiZWhpbmQgUkRSQU5EL1JEU0VFRCBoYXMgYmVl
biBwdWJsaWNseQ0KZG9jdW1lbnRlZCwgc28gdGhlIHN0cnVjdHVyZSBpcyBubyBzZWNyZXQuIFBs
ZWFzZSBzZWUgWzFdIGZvciBvdmVyYWxsDQpzdHJ1Y3R1cmUgYW5kIG90aGVyIGFzcGVjdHMuIFNv
LCB5ZXMsIHlvdXIgb3ZlcmFsbCB1bmRlcnN0YW5kaW5nIGlzIGNvcnJlY3QNCih0aGVyZSBhcmUg
bWFueSBtb3JlIGRldGFpbHMgdGhvdWdoKS4gDQoNClsxXSBodHRwczovL3d3dy5pbnRlbC5jb20v
Y29udGVudC93d3cvdXMvZW4vZGV2ZWxvcGVyL2FydGljbGVzL2d1aWRlL2ludGVsLWRpZ2l0YWwt
cmFuZG9tLW51bWJlci1nZW5lcmF0b3ItZHJuZy1zb2Z0d2FyZS1pbXBsZW1lbnRhdGlvbi1ndWlk
ZS5odG1sDQoNCg0KPiANCj4gRm9yIHRoYXQgcmVhc29uLCBtb3N0IG9mIHRoZSB1c2FnZSBvZiBS
RFJBTkQgYW5kIFJEU0VFRCBpbnNpZGUgb2YNCj4gcmFuZG9tLmMgaXMgc29tZXRoaW5nIHRvIHRo
ZSB0dW5lIG9mIGBpZiAoIXJkc2VlZChvdXQpKSByZHJhbmQob3V0KTtgLA0KPiBmaXJzdCB0cnlp
bmcgUkRTRUVEIGJ1dCBmYWxsaW5nIGJhY2sgdG8gUkRSQU5EIGlmIGl0J3MgYnVzeS4gVGhhdA0K
PiBzdGlsbCBzZWVtcyB0byBtZSBsaWtlIGEgcmVhc29uYWJsZSBhcHByb2FjaCwgd2hpY2ggdGhp
cyBwYXRjaCB3b3VsZA0KPiBwYXJ0bHkgdW5kZXJtaW5lIChpbiBjb25jZXJ0IHdpdGggdGhlIG5l
eHQgcGF0Y2gsIHdoaWNoIEknbGwgY29tbWVudA0KPiBvbiBpbiBhIGZvbGxvdyB1cCBlbWFpbCB0
aGVyZSkuDQoNCkkgYWdyZWUgdGhhdCBmb3IgdGhlIHB1cnBvc2Ugb2YgZXh0cmFjdGluZyBlbnRy
b3B5IGZvciBMaW51eCBSTkcgZmFsbGluZw0KYmFjayB0byBSRFJBTkQgKGN1cnJlbnQgYmVoYXZp
b3IpIGlzIHBlcmZlY3RseSBvaywgc28gSSB0aGluayB5b3UgYXJlIGRvaW5nDQp0aGUgcmlnaHQg
dGhpbmcuIEhvd2V2ZXIsIGluIHByaW5jaXBsZSBpdCBpcyBub3QgYWx3YXlzIHRoZSBjYXNlLCB0
aGVyZSBhcmUNCnNpdHVhdGlvbnMgd2hlbiBhIGZhbGxiYWNrIHRvIFJEUkFORCBzaG91bGQgbm90
IGJlIHVzZWQsIGJ1dCBpdCBpcyBhbHNvDQp0cnVlIHRoYXQgdGhlIHVzZXIgb2YgdGhpcyBpbnRl
cmZhY2Ugc2hvdWxkIGtub3cvdW5kZXJzdGFuZCB0aGlzIHNpdHVhdGlvbi4gDQoNCj4gDQo+IFNv
IG1heWJlIHRoaXMgcGF0Y2ggIzEgKG9mIDIpIGNhbiBiZSBkcm9wcGVkPw0KDQpCZWZvcmUgd2Ug
c3RhcnQgZGViYXRpbmcgdGhpcyBwYXRjaHNldCwgd2hhdCBpcyB5b3VyIG9waW5pb24gb24gdGhl
IG9yaWdpbmFsDQpwcm9ibGVtIHdlIHJhaXNlZCBmb3IgQ29DbyBWTXMgd2hlbiBib3RoIFJEUkFO
RC9SRFNFRUQgYXJlIG1hZGUgdG8NCmZhaWwgZGVsaWJlcmF0ZWx5PyANCg0KQmVzdCBSZWdhcmRz
LA0KRWxlbmEuDQoNCg==

