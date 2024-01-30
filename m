Return-Path: <linux-kernel+bounces-44778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA838842745
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6392D1F2A472
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8027E798;
	Tue, 30 Jan 2024 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DnWYZMiI"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3572C7CF3A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626516; cv=fail; b=sbYM9LTCq5MT2gsrqvqo/HG3dXxQ1eXgD17SpsFr1qLGwUXch06ulXvnCxlwpKf8lqqKLOb7FBk6Kkcv+BHeuRxVHqOZyDH5EwbsfjLuKPaL8I6kEjw5leSBoTUX+YysVq1R8IDgmy2aLRbAWbTEAz+B8FTOLkNxIB1jEzdVEU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626516; c=relaxed/simple;
	bh=99I+msu2OVo7arzuQQg/suWM+p3s8Jnh7ucn0emWTLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kdsAiqyqhnZ6TynodLIsiYbsHQffntiE3/FiHYxrvEWY5vCzmNMMdo2uoH8IpF2Y3jgO5ufu8BNgMFKMnc+BzpKXZGoaI1F7R2uEVZkkb53RJKXdvQgYaVC0aDX/hufecaMDgtMcNaJ9Tq0eY8DQCkBpaGpM0khrXscWIJicd2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DnWYZMiI; arc=fail smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706626515; x=1738162515;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=99I+msu2OVo7arzuQQg/suWM+p3s8Jnh7ucn0emWTLc=;
  b=DnWYZMiIumzRtrm2uidLTMUQPAYfcarBFruWCPVGMTisa7cgJroOc5cK
   03xVD8ltbrGy36uSQM1jYb4qNTBPeZNjB/g9uoucgyANfzbkECG2ggrSk
   wSj7QBwH7ocrz3Y1TQXkaGl5kgQid03lpfZ3ZCPCSkd4gIo4vevmc8MM3
   uGopgCT3D03Nk+sH+nrmDRZVjqaY+DGh49IVkgV6jUlrwh4KsTDw9Hev3
   cSZ/D5X63b9uKDJU7T/NnsSFwTiYspEB59wl1vLM3tyLVqkOqO7FwUQjq
   tIFF3kixxOg8fV9kdY6r3y84l5XswTStpkg9zBx/R6w2u/a1otHblQgaL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="467554290"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="467554290"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 06:55:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="858508744"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="858508744"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 06:55:11 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 06:55:11 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 06:55:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 06:55:11 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 06:55:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUkZlaUK6v8IY9HM7kXUes+OEWusVLgsNiNLHUFvfBZaMwuRzzuRx8T76XD8h0dYztTWazuflEpQyWfvFGMwj2uN9zgihMXrQnZITFfbnLpIwd6oXqOAke2o5mqIjIrIv42BQXy2x8T6NuXnvVlYLgPaMxgbPD2TdWA/sAqkNfgyueJlRuhBQe+m1ZmBiqubigVoV2DzEm2W5BmxgZk2YybXcckCnxrYytF/KuQJhWAwbgQO7MtFzfX7QXQnugZ7yu1BG0xWJ/F4n7ly9wNI0MrI5S65+hmNNzjBOZ/ZSVCP/VE7NZXXu9TpyyZasLkgbroy78D566o4D9kx8FHpzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99I+msu2OVo7arzuQQg/suWM+p3s8Jnh7ucn0emWTLc=;
 b=HP8Mn5efABA1qVeWe/Sbo7hH7KdSVUEulx6xnRbOrxZ6aIQsmSt0kkULjmCZ8uJn6gokvA6rscHqVQrJpWoNH8rPLqZ1mHvo2nAk3oTwCY+Fhml7Ioof2OqJRaohcKDGBWctGen6tAl/J3lD7HkmPF3aPmlb6Zxzo8m7ztAAVyAlgf9m1qAYBpYJCX2K5TDI5HdcPOi0bdYJfkk131nVH7AL6DtkovEz+8qpvu4aa0PzDj/hipe3bEMdoUi3jSmAz6vI4qsYRJdhvrqi2bW/MVZbj07V1Gsa3MG0MU6lcpgd/DBUYfN/INGPSik2Zr+INLu0CqA8N04Ay+mJ+ApZMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 PH8PR11MB6562.namprd11.prod.outlook.com (2603:10b6:510:1c1::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.30; Tue, 30 Jan 2024 14:55:09 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 14:55:08 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, Theodore Ts'o
	<tytso@mit.edu>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Nakajima, Jun"
	<jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Kalra,
 Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
Thread-Topic: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED
 fails
Thread-Index: AQHaU1aXalf71JpekEOiHH1k7Csdk7DyS4oAgAAJSVCAABPAAIAABe/g
Date: Tue, 30 Jan 2024 14:55:08 +0000
Message-ID: <DM8PR11MB57507D16E4A4679AD4B4B964E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <20240130083007.1876787-2-kirill.shutemov@linux.intel.com>
 <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com>
 <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9odqcxdak3HK-XD6-H0SjYmecnTsxzDhYy+-0shhTFygQ@mail.gmail.com>
In-Reply-To: <CAHmME9odqcxdak3HK-XD6-H0SjYmecnTsxzDhYy+-0shhTFygQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|PH8PR11MB6562:EE_
x-ms-office365-filtering-correlation-id: 0b844d14-d849-4544-1831-08dc21a37400
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZA5WeR9U3kHBu6Dom/mNTfA7aPJRzSQpKw0kV2Qr0fbekrc5FV721YBigY/Mp6RUWmgWq1em8At7B8nQGW/R4ma6y5Xm3D4QP4E/N6CtbJl+G5wDB0UMNAHvsoHg7/y3v0MFm+iPHi/VZupKO87hD+KMfrtwucQ/NpYBE6CFMBn+7oEqUeOmFjXKlhKUY0VVkTepJeBRuvF+bRS/nbE9iS7lX2vlc/BQCg7ic0HjpehjZZeRXFJXOttHGFxU/TsyL0Z78KCRzd0V6NQgxwIl5pXR13Nkqr3HrkPnjP4oELEIoMuy/Tbto4voF+vHYia6k+9VEacNG94xik0sebWSN/ucA0oLPQq8WXBqTknKE3zlBroo7nSxS+v+ivezZu4V2OVxLIj1pEvsAXcecnmkUNB1IG5Vv4hSElys9vtTFBt3KgK9qlhw8CoVlghxx/iyK1C5p55I3MOTkot/32KefDYODkKuda0JwJtilOAD7i9qI5UOyMHdU8iZFkO+tw1q8n78aS4qXBeKS9FcqsIhLqPEL1jC0bn30CFL7odvjX4nk8br+IoGBL1sWKloDKbn7LLZKgrJjhR+Rr9GrOzFne2nJrPwKGgxvTFgTbu4Fvf5uxFWUEyayv6ozhHLZcl5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(54906003)(38070700009)(66476007)(316002)(8936002)(7416002)(86362001)(6916009)(5660300002)(52536014)(66446008)(8676002)(66946007)(76116006)(66556008)(64756008)(4326008)(2906002)(83380400001)(26005)(41300700001)(122000001)(33656002)(38100700002)(9686003)(6506007)(478600001)(53546011)(7696005)(82960400001)(71200400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHhYUS9GOTZHV1BySzFGOVVVbHhqRUFJYjF5cm1SSmdYUUQ5SEd0SDJuWTZO?=
 =?utf-8?B?SjNyZkozbUM1ZTFCbkhmT0MreldLNnNSK0JPWVZnSzREUk9WYnFKZ29wRlg0?=
 =?utf-8?B?N1RYSXpraXhaZzhqdEZpdDJ0U1FwV1VFbTRaQTVhblBBYmRxWGJ5aEE0Nlph?=
 =?utf-8?B?bUZubjIzM3NjYVJQeWlkNVRCRFdiQWRqR3kybFd0Uk00c0lNdEc0emRvODhG?=
 =?utf-8?B?cG1wdnZIZHRwU0ZUeGNvczBNV2lGNCtVZkxXbE1YdzhnK0xrRkZCeG45ek90?=
 =?utf-8?B?ZjYrVVpkb2kyY1pOVlpoOHJ6ZzZrbmRHelk3RjAybVM2SVlKcUs0emFDNTIz?=
 =?utf-8?B?STYzUDFrWWsyRXlVamFUM2VDWVkrZ2ZIb1NXTUMrc1V0SnpldzZQZ0xSR2FF?=
 =?utf-8?B?alVuM2JvU2JXanhpTUo4cXMrOGMyTk5nSTJ6SDRmRzNieVJlMlFVUGozNERQ?=
 =?utf-8?B?WXJnazVmUnJ0NWVLNTVEeElYN1FOclAxd2hNeW5td2FzN2p4OUZzcG5hYm9v?=
 =?utf-8?B?M1QzL2Z1c0lmdUM2V3A5UUxPSVB2UzZFZzVKYTlSc2lsZTB6UlNKdkhQSUg0?=
 =?utf-8?B?S0NCUmZZYXhhaVVLdEN2bmJ4cHU2MWpWRFRKcFJDd2FXZm1jQnlVU3dkM1k0?=
 =?utf-8?B?Z3hucVlWZjM1UGQvVzlpZVA0S2prMUJHQnRRenFtSk54a0dud2pKSnZqMHpW?=
 =?utf-8?B?M3JVRTZFaTRoRWJlN1hINkhXRDU4UG54NGNLaHZGdHRpMFdCdVpTYVZGQnhJ?=
 =?utf-8?B?YmpLeGNMcGlObjV4SDhsZTE3cTlkZnB0MlF3WEw5bkdjSjI3bTlRQU9KZ0d5?=
 =?utf-8?B?UE1oYitkNzVyclZNcWxFeGN0bStpYzNYTEZzZnN1czBBUkpxUC9peE5vSDA5?=
 =?utf-8?B?UXQxazhzQXpuUlFFS0lPMXNodlA1c2xlbW9ZRlI2TENPSWo5UjQzUkV4TTBP?=
 =?utf-8?B?aHlwMllYRXVEcC9udjkxMTRUWWU1ZE5uOVVGYnhsaG5mdHlCTTdmRFFKMml5?=
 =?utf-8?B?dVVhK2kraysyZEZnY0dlK3hwWHB2UjJ5aTAyaWVwK3hmZFVSNXRNY0xSekNt?=
 =?utf-8?B?WE9UcXhKMUNBK3M3U09tQUo3NXFna3BHdE9jRmdOZ2JBMDdPRFpNZThsdUFi?=
 =?utf-8?B?SUhyWGRDMVRIK1FNRk9md2VmVVVqUVhqWDh1Qjhrck82YjRiT1FxWVpidGg5?=
 =?utf-8?B?YmtzMGltcnMzVVc5RHNpejVmUGk4YWY3bmxLRzZVQ0E5SUV6NnBNdnFaM1hW?=
 =?utf-8?B?OS9KdmRRSTZFTWFML2dsQmExNUY3bmVFS3lVMWl2bWc5KzdDOTZZOXBCaE50?=
 =?utf-8?B?c3NJU1d5clFtcUd1NXFUM3VjM3Jia1hVU2Q5MjB0YlJVOGlCY0pnamJqV3A2?=
 =?utf-8?B?eTQ1bU5NV3picEw3eTZ5R3VsenNhS2ptaUlvTGFuUWJwS1lneCtLZit5VURJ?=
 =?utf-8?B?NzZYREptcnhxVVU4UnR4K05JQm1UdWRsOVRKQWpBMG5ORzBHemRlQTRQQ0lT?=
 =?utf-8?B?RmY4UmhKK3hVZG4rcTVHR1pHcWIyZ3QzdFBFQ2dQRzVJU0wrL2F4dXZFK0U2?=
 =?utf-8?B?NlVwT09HeWd1R2sxbG55b3ZGczVrWXoxbHFaeVdwMDJBb2tGSGRPSDVNUE1k?=
 =?utf-8?B?MTBPM25HS2lqaW1iN21zbm4xSjljU3JUbXYwa3ErMDVKTVYvaXNIWHhsY3gr?=
 =?utf-8?B?cVZGd0pNQzdEa0pRS2ZySnkwNC93NEt2V2NKdHZVNE8vL29Qb0cxQkZyckY2?=
 =?utf-8?B?OFYyenJ1Uy9lb09mR2tud1BFUmMvK3Zkd2pJbjFFYStXaXM4WlAzajAzVnZq?=
 =?utf-8?B?Qk5tanZXVEhkVkFhS3pTaHUrdjJXNUtmNkFUcGRPbnZsSFNDWWI5bUtmaDl3?=
 =?utf-8?B?aUJVWTJBR1dqcWJHeS9wRGtPbnhjMHJ0SEZkV2dVZkNvd2RBY1I4T0JjNFlp?=
 =?utf-8?B?ZHB3bUtuY3FWVzRuVEc4aklJNXFIbjNwUWNsTzQ3MWFiNUZsak9xZDR5ZG1t?=
 =?utf-8?B?K2RMcXZEUkk5NUM2L0xCMmZjZU9ROHZPaGJUaXdQVWtEOEtHZmJ5UE9meFJP?=
 =?utf-8?B?S1ZyQzM4RmZ6UFFUekgvT3BPeHJJQzdEQVhFL1MvOStXeWhzdzhOVW1zUG0w?=
 =?utf-8?Q?GcQ/BFCJQC1l1t4YIlck7uvhu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b844d14-d849-4544-1831-08dc21a37400
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 14:55:08.8840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3oylRFftrQvOnY7AgnkPyHE0StWUBknhhVxcIvJBdfDsfevnPO50tfXQHPzCG5tivwUWAq88p3QeG/pc9Bec4vzuMMERuPr9hBjhtIGPIyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6562
X-OriginatorOrg: intel.com

DQoNCj4gT24gVHVlLCBKYW4gMzAsIDIwMjQgYXQgMjo0NeKAr1BNIFJlc2hldG92YSwgRWxlbmEN
Cj4gPGVsZW5hLnJlc2hldG92YUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IE5vLCB0aGlzIGlzIG5v
dCB0aGUgY2FzZSBwZXIgSW50ZWwgU0RNLiBJIHRoaW5rIHdlIGNhbiBsaXZlIHVuZGVyIGEgc2lt
cGxlDQo+ID4gYXNzdW1wdGlvbiB0aGF0IGJvdGggb2YgdGhlc2UgaW5zdHJ1Y3Rpb25zIGNhbiBm
YWlsIG5vdCBqdXN0IGR1ZSB0byBicm9rZW4NCj4gPiBIVywgYnV0IGFsc28gZHVlIHRvIGVub3Vn
aCBwcmVzc3VyZSBwdXQgaW50byB0aGUgd2hvbGUgRFJCRyBjb25zdHJ1Y3Rpb24NCj4gPiB0aGF0
IHN1cHBsaWVzIHJhbmRvbSBudW1iZXJzIHZpYSBSRFJBTkQvUkRTRUVELg0KPiANCj4gWWVhLCB0
aG91Z2h0IHNvLg0KPiANCj4gPiBJIGd1ZXNzIHlvdXIgY29uY2VybiBhYm91dCBEb1MgaGVyZSBp
cyBmb3IgdGhlIGNhc2Ugd2hlbiB3ZSBkb27igJl0DQo+ID4gdHJ1c3QgdGhlIGhvc3QvVk1NICph
bmQqIGFzc3VtZSBtYWxpY2lvdXMgdXNlcnNwYWNlLCBjb3JyZWN0Pw0KPiA+IEJlY2F1c2UgaW4g
bm9uLWNvbmZpZGVudGlhbCBjb21wdXRpbmcgY2FzZSwgdGhlIExpbnV4IFJORyBpbiBzdWNoDQo+
ID4gY2FzZSB3aWxsIGp1c3QgdXNlIG5vbi1SRFJBTkQgZmFsbGJhY2tzLCBubyBEb1Mgd2lsbCBo
YXBwZW4gYW5kIHdlDQo+ID4gc2hvdWxkIGhhdmUgZW5vdWdoIGVudHJvcHkgdGhhdCBpcyBvdXRz
aWRlIG9mIHVzZXJzcGFjZSBjb250cm9sLg0KPiANCj4gRG9uJ3QgdGhpbmsgYWJvdXQgdGhlIFJO
RyBmb3IganVzdCBvbmUgc2Vjb25kLiBUaGUgYmFzaWMgcHJpbmNpcGxlIGlzDQo+IHNpbXBsZXI6
IGlmIHlvdSBoYXZlIGENCj4gYFdBUk5fT04odW5wcml2ZF91c2Vyc3BhY2VfdHJpZ2dlcmFibGVf
Y29uZGl0aW9uKWAsIHRoYXQncyB1c3VhbGx5DQo+IGNvbnNpZGVyZWQgYSBEb1MgLSBwYW5pY19v
bl93YXJuIGFuZCBzdWNoLg0KDQpPaywgYWdyZWUsIHlvdSBkbyBicmluZyBhIHZhbGlkIHBvaW50
IHRoYXQgd2Ugc2hvdWxkIG5vdCBjcmVhdGUgbmV3IA0KRG9TIGF0dGFjayB2ZWN0b3JzIGZyb20g
IHVzZXJzcGFjZSBpbiBzdWNoIGNhc2VzLiANCg0KPiANCj4gPiA+DQo+ID4gPiBBbmQgaWYgdGhl
IERvUyB0aGluZyBfaXNfIGEgY29uY2VybiwgYW5kIHRoZSB1c2UgY2FzZSBmb3IgdGhpcyBXQVJO
X09ODQo+ID4gPiBpbiB0aGUgZmlyc3QgcGxhY2UgaXMgdGhlIHRydXN0ZWQgY29tcHV0aW5nIHNj
ZW5hcmlvLCBzbyB3ZSBiYXNpY2FsbHkNCj4gPiA+IG9ubHkgY2FyZSBhYm91dCBlYXJseSBib290
LCB0aGVuIG9uZSBhZGRlbmR1bSB3b3VsZCBiZSB0byBvbmx5IHdhcm4gaWYNCj4gPiA+IHdlJ3Jl
IGluIGVhcmx5IGJvb3QsIHdoaWNoIHdvdWxkIHdvcmsgYmVjYXVzZSBzZWVkaW5nIHZpYSBSRFJB
TkQgaXMNCj4gPiA+IGF0dGVtcHRlZCBwcmV0dHkgZWFybHkgb24gaW4gaW5pdC5jLg0KPiA+DQo+
ID4gSSBkb27igJl0IHRoaW5rIHdlIGFyZSBvbmx5IGNvbmNlcm5lZCB3aXRoIGluaXRpYWwgZWFy
bHkgYm9vdCBhbmQgaW5pdGlhbCBzZWVkaW5nLg0KPiA+IFdoYXQgYWJvdXQgcGVyaW9kaWMgcmVz
ZWVkaW5nIG9mIENoYUNoYSBDU1BSTkc/IElmIHlvdSBkb27igJl0IGdldA0KPiA+IFJEUkFORC9S
RFNFRUQgb3V0cHV0IGR1cmluZyB0aGlzIHN0ZXAsIGRvbuKAmXQgd2UgZm9ybWFsbHkgbG9vc2Ug
dGhlIGZvcndhcmQNCj4gPiBwcmVkaWN0aW9uIHJlc2lzdGFuY2UgcHJvcGVydHkgb2YgTGludXgg
Uk5HIGFzc3VtaW5nIHRoaXMgaXMgdGhlIG9ubHkgc291cmNlDQo+ID4gb2YgZW50cm9weSB0aGF0
IGlzIG91dHNpZGUgb2YgYXR0YWNrZXIgY29udHJvbD8NCj4gDQo+IElmIHlvdSBuZXZlciBhZGQg
bmV3IG1hdGVyaWFsLCBhbmQgeW91IGhhdmUgdGhlIGluaXRpYWwgc2VlZCwgdGhlbg0KPiBpdCdz
IGRldGVybWluaXN0aWMuIEJ1dCB5b3Ugc3RpbGwgbW9zdGx5IGNhbid0IGJhY2t0cmFjayBpZiB0
aGUgc3RhdGUNCj4gbGVha3MgYXQgc29tZSBmdXR1cmUgcG9pbnQgaW4gdGltZS4NCg0KSSBhbSBu
b3QgdGFsa2luZyBhYm91dCBiYWNrdHJhY2sgcmVzaXN0YW5jZSwgaS5lLiB3aGVuIGF0dGFja2Vy
IGxlYXJucyBhYm91dCANClJORyBzdGF0ZSBhbmQgdGhlbiBjYW4gcmVjb3ZlciB0aGUgcGFzdCBv
dXRwdXQuIEkgd2FzIHRhbGtpbmcgYWJvdXQgYW4gYXR0YWNrZXINCmxlYXJuaW5nIHRoZSBSTkcg
c3RhdGUgYXQgc29tZSBwb2ludCBvZiB0aW1lIChSTkcgY29tcHJvbWlzZSkgYW5kDQp0aGVuIGZv
ciBSTkcgYmVpbmcgYWJsZSB0byByZWNvdmVyIG92ZXIgdGltZSBmcm9tIHRoaXMgc3RhdGUgdG8g
YSBzZWN1cmUgc3RhdGUgdXNpbmcgDQpmcmVzaCBlbnRyb3B5IGlucHV0IHRoYXQgaXMgb3V0c2lk
ZSBvZiBhdHRhY2tlciBjb250cm9sL29ic2VydmFuY2UuDQpEb2VzIExpbnV4IFJORyBhaW0gdG8g
cHJvdmlkZSB0aGlzIHByb3BlcnR5PyBEbyBwZW9wbGUgY2FyZSBhYm91dCB0aGlzPyANCklmIG5v
b25lIGNhcmVzIGFib3V0IHRoaXMgb25lIGFuZCBMaW51eCBSTkcgZG9lc27igJl0IGFpbSB0byBw
cm92aWRlIGl0IGFueWhvdywNCnRoZW4gSSBhZ3JlZSB0aGF0IHdlIHNob3VsZCBqdXN0IGVuc3Vy
ZSB0aGF0IGVhcmx5IGVudHJvcHkgY29sbGVjdGlvbiBpbmNsdWRlcw0KUkRSQU5EL1JEU0VFRCBp
bnB1dCBmb3IgY29uZmlkZW50aWFsIFZNcyBvbmUgd2F5IG9yIGFub3RoZXIuDQoNCkJlc3QgUmVn
YXJkcywNCkVsZW5hLg0KDQo+IA0KPiBKYXNvbg0K

