Return-Path: <linux-kernel+bounces-101706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70FA87AAD2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D7A2855DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEB9481AA;
	Wed, 13 Mar 2024 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V35MNrhz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08BB47A7C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710345613; cv=fail; b=hGbRAQkEh12n4kDrsZaLZ+7pEQe+tW3j5SJwYWZht+EZ4P6MKaeagZSD3ksR0182BeR8ubtM0zyfbZHM1uPD+cG1nDQRJTtuz/00bAVqbDQgcyswwRWv/zsDIFhS+DRluv/Vz5m2VaI+8KWb+0OE1iGkCeeT2mGLdOLcpJHYJow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710345613; c=relaxed/simple;
	bh=A41MUMYhww5++YsOnKYzwnyooY0C6J++el7UbCPp72w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=orT02hJ0j2gyhI1Vl6+7ldGJEJWTToSThpY2mgKzz/+e747G0RGb50mq1KgA0omsvSVYkeKZrf7LSxf+rSg01d2cCqRo+YHyKZRn160eNJn/51iveCV5YMDKnulQKAn8vaERanH0rI1s668ZNuAjhXPCkbAn2ILbvSulEPfKEGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V35MNrhz; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710345611; x=1741881611;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A41MUMYhww5++YsOnKYzwnyooY0C6J++el7UbCPp72w=;
  b=V35MNrhzvAkNwJqZuDZ/sF7Lbh5tiwzusYEW8OJl7axPERcZQfJb76O2
   ATKTghHsTiw6CStiId1NFLSjSspSFZOU/OdORasP0VarQOzi6cZCNW637
   1w5Ul3yWWRNr81zfevzRim1UMdpnG60MymCyCyWLYBCUWaztbBFzmtxvP
   q8J1HKAnqkBAK4Z2RAL6M1MVUesPPrWVZ5uJorGvWjmNvBzmf1HGRvb2q
   Lt5xrXDu1MDC4gxZjaJpjrW1HpmK7P8R7J3FEV7mouAVNvG24WPShQ9yQ
   PmaHIkP1gcEaX3ShQS7uIhIw1ViwE/LTAARaC2Me6Dx2QrJYfrea7rpvR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5051624"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="5051624"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 09:00:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="16551472"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2024 09:00:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 09:00:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 09:00:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 09:00:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 09:00:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hfnme+tQBcTqOXQvEeznT6AHwZciHiz8zOgYKmxjTy85ZapsRZhYkwNfsb4MzAd+exJyVSI0fd5JQjKWaBx3aVa6s/C90Vk2+ifdD8fm7J48BCEdoYKJhKZPWxJS26hMbkh4i+g6iLDX2iMW3OcAOuFWXDEMfbns18AdIY2TOXZb3ZWM31zCkEtjnpc7lme/We4hQijxNi+UsQhQto61qQ1XK7g9pzjJrpNZ/64oSQ1fOPHLqBXUej1h0WYIGxjlYan0gK2GlDOxTr7krl16U3DAcJEQ3a4f8A0ZwP13syk+9wyQwM8KWEJOEdQDRhxzqdx4Bgl5n9LABexeIMM86w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A41MUMYhww5++YsOnKYzwnyooY0C6J++el7UbCPp72w=;
 b=DvibCfYwHt8REsDbQdUnE95qR28jjvnf2hUg/Ply5V1oBKSxjK98p/7tV6LcHbCF/mZYpqnQK4zfoTiy9GYEEtKCZNSoVch6kcBagMR6A4w9gkCEys92HDR5+47NseP7RCFTs70G8WK/fCmX/XIkOOjhHu/Ga7YWMYREPby/yLRmFAyEknnQimXjfDNbTqUq7Ht2pmvjWWr7c/AfJ2UQ+gjmtCLLh1dWxkOzPiyOZf09KD9qVJ0OHacJTk+xlBuDDqdpbrWMQH7AxwOYLGGM/26tg4kfPNfAPO74gfzHldnEuMtNQwAKxn+xX8E6SWVutX098BK/qui6riBWRT9+Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA0PR11MB4528.namprd11.prod.outlook.com (2603:10b6:806:99::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Wed, 13 Mar
 2024 16:00:04 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b%5]) with mapi id 15.20.7386.016; Wed, 13 Mar 2024
 16:00:04 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "debug@rivosinc.com" <debug@rivosinc.com>, "luto@kernel.org"
	<luto@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "keescook@chromium.org" <keescook@chromium.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 10/12] x86/mm: Implement
 HAVE_ARCH_UNMAPPED_AREA_VMFLAGS
Thread-Topic: [PATCH v3 10/12] x86/mm: Implement
 HAVE_ARCH_UNMAPPED_AREA_VMFLAGS
Thread-Index: AQHadMzkrqf7F0uN1U+4RKWWb1IklLE1YUsAgAB0HgA=
Date: Wed, 13 Mar 2024 16:00:04 +0000
Message-ID: <14a2bc3add91981fe2f9d51d2b25507dc1c69131.camel@intel.com>
References: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
	 <20240312222843.2505560-11-rick.p.edgecombe@intel.com>
	 <887b3a3a-e4b6-4b0a-abea-bb47a593d9cc@csgroup.eu>
In-Reply-To: <887b3a3a-e4b6-4b0a-abea-bb47a593d9cc@csgroup.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA0PR11MB4528:EE_
x-ms-office365-filtering-correlation-id: b4edb13b-9470-4951-d3c5-08dc4376a5dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u/YthTPRWae6YfE8Ng+M7p/4hMYoEO9M0Ftt9aVOCSqK7FcAmk6jQPTho4nw6oKPINdnbmhYWSi8DZ5Nxkc+6DChzjCUx26/2GYaJQC5FO0lSEEBwRtcYihjrH1D1ztcZtZcC5X20HN1WkfUMYqiDSNbnLKaMkgwdUvzTMbvWhAIMHKdKFkHBpAPnI/HkojcjBaKnETTrGcSWNajuFuTTeMKjNl5wYGuPwq7gu+VUV8m99RP40N2VPiLSkYzuFNiMLF3hqcvG19hFq/DuSyzGsnzteCj4jqDhE+4o3tz+CtFNL624CY7SSGBNaB4xz8iWw5glMab/ACoPvO/pK3zA048ovqm/I0FHwBhpXRN+YD8nPysOuENoOlJoIe4TVCBgIXAvDKRIK5J7Iecgz0BzZPFr4GZRIJJ866Yh3ADdY9mxw2y8dKbd9Bm235YlGMtktN/NOCoa3dAk8d+vJMkXEiL7eRiILBRRIijMw8X7PZAf2ImVh/bBOIODwtCrYJ5AZAHlcn0Ke+vQkeXzV6zGIiCgbRxFnBUYkuIfcBjHxurlqWr9VmX16zwzYiXVSt8FW9VyxDXes3euKl74FROHD0JCVjJaL3drHjONGnbcUGEpRw/p1TzEV//GpgtMcunYzZaIck9uv7NEkGKghdB7B+nlx/TCsAn9NdGbCU4i5Lo9JJl92GwAHu6KjuFuOy3XABG68+u6zZJL7vCxaWa3GL1S6qvQg0YOq2a8riaN4I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGtGYWxKc2svNzBOV2w0RWFDR0xlYXQ1L0lBMHErUTF1RmVPZmJTOTluZ0NJ?=
 =?utf-8?B?NEtXa05aMlpuRkhMa0ZrVzExb1YwUUVWaU1IeTN3aUQ0dUQyNDFMak5kV0Js?=
 =?utf-8?B?aVNnbDVNU3lSRXNoNldoVndpTitXYjR1WnpDNnJHcTlvc1k1cGErVFlWMzNj?=
 =?utf-8?B?TnpGNCtmaFZHZVlzcEJ0YjhDUVIzSjVhMWpvYTBzdk1wdmdBY1owZUJvVW9z?=
 =?utf-8?B?eWM1UENXTDZ4QkJBUkMwckExRmdEdytLZ1NEMjNRMUhma0YvbWppMkFOUTJQ?=
 =?utf-8?B?bDdmTVBFWUErUUowaHU0N2tSY3lXamxlV29Uc2M1WE9TL2ZVbjgwQUlPdVQ1?=
 =?utf-8?B?UXM1YWdUZVdIRmRJUHVHUXZvaXJPTVRHa1ZMNnJ4QUNWak1TUGMzRlN5elky?=
 =?utf-8?B?S01UY28xdURINHBVNElNcS9wOEVycXpwMXgxcTY4bHVOWUEraWplRDdCcUsy?=
 =?utf-8?B?c1N4RjQwK3pURVI4UlJUbWsvWVlxNzJ2dWFFODBMTmcxekZjUzA4THlSRjhs?=
 =?utf-8?B?SXFPUlkrVk11UDUrNUhjQjVhODJBRmlmL0hCYTN2NGlkL1VjcUJZKzkzTUNE?=
 =?utf-8?B?VEtBUVdCS1pnVXh3YU53RG9BWDV0RiswTG9Edk1GaVpielZ1RlBRNDhJMDU5?=
 =?utf-8?B?MTlUMVdBNzJiU2pyelJleDZuR1A5QTFXT0xQdnpVMDVlcVZCL0Z6Q2FsdUpG?=
 =?utf-8?B?RVNreS9XanRFNTk0c3JLSGJpL3I4dThhcXhiYzA5VDk1UVdsL1lUQjc2MTNJ?=
 =?utf-8?B?Mm04YVlvenc5WjdEaGNOcVdlZWxRa0dHUDBORzlMaUhMc25sYnZwMVRjbVhO?=
 =?utf-8?B?UmlVMGNmRkF5Vmd4eXZSeWsyN2gvbFFjb3J4RlVnNVlmOXlqYUdjK0p4bkU4?=
 =?utf-8?B?MEdvNFNTUytZTDBYK1QwOGlZbVB1Qkt2TlJaeUw3cFloZGtmYjJ5OVRtS0RF?=
 =?utf-8?B?NVYrUW5oeHRhMlRwS1prZjF4em5RQXJIZS9wYnQzQUxIdEUwSk9XVmkrcWsw?=
 =?utf-8?B?TkVtVEVhUzMrUWlkQmllQm92TXAwS1Zkc29XcHNnR1pXWjdYTnZVNWsvclFM?=
 =?utf-8?B?SVhDNUcrQzZhNEZXSGluQlpZK1ZEdmVNNTVGSHRQVkwrd3ZKTmkyY21VMXB0?=
 =?utf-8?B?MTdoT1FHeE1RTTM3VnpRVjZsWnFBN1ZMTHNsN3grMFJ0c3poQjUvSmhwdStB?=
 =?utf-8?B?MkUxNnp4Sk1MY05mM3VXcjdGV0RRa1RzL0lZc0p1a29BUThyY01qMk9ka1Zk?=
 =?utf-8?B?WmZEa1c5eVROMllPTDh0SFJLakQxbEExY29ybGIrbjNBeCtUUVVrMFQxWmtZ?=
 =?utf-8?B?RnNaT2JvQk0vRHRUbWJPV1NSdWNkR3ZoamRnWUpwM3JYU3gzZkN5dnFwNFBM?=
 =?utf-8?B?SU8wMTJvSmluNzlKOEhxdzJ6QXpHVGlRd0NEUHBsYU51bUQ4NGg3Tkw4cThk?=
 =?utf-8?B?a09sK1BiYUtFRWpXSi81L2kra1V3eUk0WXNIeVUvYkx4RFRUV3NkQkNleUJC?=
 =?utf-8?B?bzlhbHZpcnhrSFJLWTRHMHNGL0pLc3hmS0RZTGhGZHpKWUhJQitHWWxhZEpT?=
 =?utf-8?B?N2JkYUk0c1YvVU03eWF1V3oyM2dFVVlSZEFSdXNyckN6NFpiSkZNN0V0Qkgv?=
 =?utf-8?B?YmNkUmdSTkV2d3N5aG9oTlY4ZEdpQnJsVmU5b2Y1ZndXcTl6YUdQdmEwYkVB?=
 =?utf-8?B?ekZ6SkdGWGIxb2FRbm5nbmlsS1g0L2VOZ3dOWTV1VG5TK1YxR0FVRDdSR09p?=
 =?utf-8?B?RXlGZFR0SVlUckVlcWdTZlAwRk5HWUJqQXpNbmtqNm5FdmpWeG93SE5RRlhr?=
 =?utf-8?B?bXhxNUZmeUlLSWNyeUplYVhxYnRVK20wWXc4YnVhWnJvbVRjbGFFZHVkUnZK?=
 =?utf-8?B?elJteFFjQTNBSjBzYWZQNE03MmRldFZxZ0t3ZGlTV0tSdEFkQXN3eVVzVHdq?=
 =?utf-8?B?NXVyaGN3TU9Wcy9URGF4NTFUaXRzWFZadU00NDRxd0hlNkJTUjVkNk01d3ZI?=
 =?utf-8?B?OGIyaTRyR0gzVTRzVEJhVkhRbDVMN0VSS0xNNUFrQllTWWhqUXdCRzFxSjVK?=
 =?utf-8?B?c0RnS04ycmZQT0Z2R3lGajQ3dElkcjVjdFBneFFSRHlJSFdLdG56ajdXbUpx?=
 =?utf-8?B?Z011YXVvZkVpRWxITHhEWVZTQmNaNGVlWSsrZWhVZ2RTT3ZwVXV0Sk9WZUt4?=
 =?utf-8?Q?wy0ogo6ZG++u+AtaFkbRM4I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D42A044619F4D545A46F7CF717EFB0B2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4edb13b-9470-4951-d3c5-08dc4376a5dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 16:00:04.7590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wc9A8G4M03SLXp7nu72te/B3SICWZWwJXDbwRCsQWx5ScC65yqhafqyqIQH6REnzsF3yE3j7KWYU6lZko0q5yyAm1tAtKvrsNSc2nY3MwzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4528
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAzLTEzIGF0IDA5OjA0ICswMDAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3Rl
Og0KPiA+ICsNCj4gPiArdW5zaWduZWQgbG9uZw0KPiA+ICthcmNoX2dldF91bm1hcHBlZF9hcmVh
KHN0cnVjdCBmaWxlICpmaWxwLCB1bnNpZ25lZCBsb25nIGFkZHIsDQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGxvbmcgbGVuLCB1bnNpZ25lZCBsb25nIHBnb2Zm
LCB1bnNpZ25lZA0KPiA+IGxvbmcgZmxhZ3MpDQo+ID4gK3sNCj4gPiArwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gYXJjaF9nZXRfdW5tYXBwZWRfYXJlYV92bWZsYWdzKGZpbHAsIGFkZHIsIGxlbiwNCj4g
PiBwZ29mZiwgZmxhZ3MsIDApOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICt1bnNpZ25lZCBsb25nDQo+
ID4gK2FyY2hfZ2V0X3VubWFwcGVkX2FyZWFfdG9wZG93bihzdHJ1Y3QgZmlsZSAqZmlscCwgY29u
c3QgdW5zaWduZWQNCj4gPiBsb25nIGFkZHIsDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCB1bnNpZ25lZCBsb25nIGxlbiwgY29uc3Qg
dW5zaWduZWQNCj4gPiBsb25nIHBnb2ZmLA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3QgdW5zaWduZWQgbG9uZyBmbGFncykNCj4gPiAr
ew0KPiA+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBhcmNoX2dldF91bm1hcHBlZF9hcmVhX3RvcGRv
d25fdm1mbGFncyhmaWxwLCBhZGRyLA0KPiA+IGxlbiwgcGdvZmYsIGZsYWdzLCAwKTsNCj4gPiAr
fQ0KPiANCj4gV291bGRuJ3QgaXQgYmUgYmV0dGVyIHRvIGRlZmluZSB0aG9zZSB0d28gYXMgc3Rh
dGljIGlubGluZXMgPw0KDQpZZXMsIEkgdGhpbmsgc28uIEl0IGlzIGdlbmVyaWMgZnVuY3Rpb25h
bGl0eSAodGhvdWdoIG5vdCBuZWVkZWQgdW50aWwNCnRoZSBuZXh0IHNoYWRvdyBzdGFjayBmZWF0
dXJlKSwgc28gZG9lc24ndCBuZWVkIHRvIGJlIGluIGFyY2gveDg2DQplaXRoZXIuDQoNClRoYW5r
cyBmb3IgeW91ciBjb21tZW50cyBvbiB0aGUgc2VyaWVzIGFuZCB0aGUgUkIgdGFncy4NCg==

