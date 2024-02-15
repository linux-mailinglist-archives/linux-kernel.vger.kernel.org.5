Return-Path: <linux-kernel+bounces-66348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3B9855B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9461C22852
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CE1D2F7;
	Thu, 15 Feb 2024 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRTAbYnV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8387DF5C
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 07:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707980871; cv=fail; b=j6NqjlvaQSPflmBt9nnXaSZkcy5cHwnBXPKEkNU/VOQ9VBpGWJkSJl43guBs96kKyBbO82kPwgnznDFlkgTyNaqyLgKdk72FOb3W0Qb3md5lASPRpDNPWnlIVLdooJujhylxSvP0ZGlAkKp9BRvH4IBJUNMXXbD7B2THFSvZdkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707980871; c=relaxed/simple;
	bh=23S9GhozXn7uVALJ/3QR00zwOfInIl7/KRjmlZElz0s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qw4wLbaEOBbePZU/yBhHYUkkYAGiYrll6YKoURFMbTiEqPksA22tUjXUvbnp0sfCRtAevsfG91OB328NXYvSjZ6YIABegYJgTUah0qiDE4nmPwFlLMJ5h3FY6rGa0Kl4tylpFd7Pspu4kzpn9q+hlxpS0m7DphjG6jIXHGh3pgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KRTAbYnV; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707980869; x=1739516869;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=23S9GhozXn7uVALJ/3QR00zwOfInIl7/KRjmlZElz0s=;
  b=KRTAbYnV2RaArY/6cximkENme4BxYt0w2YD4sZyCN2zjX4YugK0kd+lY
   ytBspFf8cuIiFYx9meiPlNOBjtpYTAUFq08G0PDRcf8VINdyMqTLuh/9H
   0Yxs+blrpgfOiaSIPyRxZVGVFogu9A1HGE+87fRPk8Eb7hlcaj6IJDior
   ywniL32teFBa5lNn16iFyTv3La19bp/IwJqo8L8V+xRkNo/MuRseVeqiY
   uSupFQMjyLgo6t7zG0TIz/mZt8P0RGFp2Gn8B3A19b/G6/p26C/rt+5ip
   YXMz1Qw12GOaGZvVFKGrGmNPVDLJEBKIRAGUJJ6J0m4qTeS4tpsZsOjkL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="27502440"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="27502440"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 23:07:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912110908"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="912110908"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 23:07:48 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 23:07:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 23:07:47 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 23:07:47 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 23:07:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYM6GF9UFuIsbtc2eAYmBhPu8ldsteJRayJTvDwaWwENe0o72bHD3tpxYe9NxAOkrUpjgnbQnPSUa9IqPkNV0ZUYpZ1LF/3N0f1WgldPhHpmOv2DVWmsXte5cL4moTpqcIFqAz6/oA4Cy6U6gznRBwu/4THKOTrSNpFDEKGziHPIiNiFITShWJiCGsMxwYoVeX2ikdtB91h80bu1FXScGlAxlQKRVCgC6O5V5QQbVKy44IOiQQWtNTI2qlnoQoPKE20EWvWJGPCSSn9opFsbDMu/VGMUl0x2re1EZf1SDD1r2pdbywhAOwnnLelRE8c2mozdqJBYrYKGuRgA4ElTWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23S9GhozXn7uVALJ/3QR00zwOfInIl7/KRjmlZElz0s=;
 b=hPqlYtbDG+LzlRsHdrP4eYFJUzzhYeuqvF6PVDboK1kD6mAOouGgon2e3uQDW0vHARfkqJwstnkwgjV4+KIzH3fvsqo5Q/IoUIU220ehrKIIvIYT/NujiSK7T/5iWLtXVeEYiztB+MXRcGjV023F8mbdf418TFv4iM56W9lhXqe6ggVnBg8KMQaKN9gzcw4WgARRNUREAcQW7l0yEsw8w9sCk6xIL6PzzDP/4yOgFqqpB/I8BNxsirt0WCT6d5tGtP8bd/phkLpk8CVfQi5hRWSWgP4Zw0icQuwKKz2DEXPXaaW6xDE6T6OChUXed5+DMv7tR7taquKWU2xGVVQAmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 DS0PR11MB7682.namprd11.prod.outlook.com (2603:10b6:8:dc::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.27; Thu, 15 Feb 2024 07:07:45 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190%3]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 07:07:45 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: Theodore Ts'o <tytso@mit.edu>, Dave Hansen <dave.hansen@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org"
	<x86@kernel.org>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Nakajima, Jun"
	<jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Kalra,
 Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] x86/random: Retry on RDSEED failure
Thread-Topic: [PATCH 1/2] x86/random: Retry on RDSEED failure
Thread-Index: AQHaU1aX7QKpTpzPXU+lq+SGmZ3MRrDySSwAgAAHtwCAABNoAIAAS0IAgAAD1CCAAAeOAIAAyKKAgABkhwCAAA8BAIAACmIAgAAorwCAAAX8AIAACBOAgAC3UwCAAN1RgIAA2w+AgBNiW/CAACOkgIAABWPAgAAfLYCAAMAssA==
Date: Thu, 15 Feb 2024 07:07:45 +0000
Message-ID: <DM8PR11MB5750D504AC62AA407441901BE74D2@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <Zbpc8tppxuKr-hnN@zx2c4.com> <20240131171042.GA2371371@mit.edu>
 <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>
 <20240201045710.GD2356784@mit.edu>
 <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
 <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
 <DM8PR11MB57503A2BB6F74618D64CC44AE74E2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Zcz2r51Tbb44ywjl@zx2c4.com>
 <DM8PR11MB57503E654C8A0E9A41CB68AFE74E2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Zc0VW_NQGLWCSJwF@zx2c4.com>
In-Reply-To: <Zc0VW_NQGLWCSJwF@zx2c4.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|DS0PR11MB7682:EE_
x-ms-office365-filtering-correlation-id: 2ef387e1-bd8e-4791-1719-08dc2df4cf74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YQm5SvgHszezqM1v0KKk0KghnHcva1MT8SM/HGCquHgmYyvbtjhO3EL1q3qwXJeitcYx3PRsXKQ4Dn6HkkNT3Ffp/VKstZqdukqXIQ98Peu42HIfqX6UoOujHt9TX1oQbfLtEsfY4iPHiPEW7Jfu1FyDDdam33UIiUOd3YBBJBpl6GPjzTRip2mjXHjP6cMPZ2KSH5I/Z0VGS68wJ+Zd5cWSv7qB7Df6L7l4MryhKnZ90DDU4hnalZmoSA+CMmr938FLcg58MjOWR0U2SrgNIspnmMjosDXclSea3qNqL78Rj6pdWMzJ7L0tO3AKyQrofmQvsVZiO38xd0PkkQcmOuDRZ4CjxV+S/KEO5MpFb2Fth/CAZoA940hHVzh4DHbiDyufH+m5THKOgxONuu3/Ftr/1y1vMP1MsZq019ExMxtXb53AEwI+JN5HV8fZPxLHA47PYCkaAX9iJAHYVN5dAXVZ7hynC88aQxITPKBUPPrTX2JbRjCCR3tnSW5cdtSQWLXp2zfWTTpjLviUknFptNyAWu39rJuW6E49w7l5Bx4zxXszZLmqTNH721qqbCTqjF6dnpFySFQnfnQpEB2BpgKxO6OAmkE12WLjTFEKCY8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(86362001)(33656002)(55016003)(64756008)(66446008)(8936002)(8676002)(76116006)(5660300002)(66946007)(52536014)(6916009)(66476007)(966005)(9686003)(6506007)(7696005)(478600001)(7416002)(4326008)(2906002)(82960400001)(83380400001)(66556008)(41300700001)(26005)(122000001)(38100700002)(316002)(38070700009)(54906003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0tCdW1CQm1jS2FqN3VsUHpRWS9ReDBRTnNMWVBTaXhyL0RKMHBPVlAySHZ4?=
 =?utf-8?B?VFpsemJIeDRwNnptdE9pOU5DUGloM3RLTHN3YUpPTmpwL21kZlFqL1dWS2lV?=
 =?utf-8?B?UktLRXd6aHhJaHZEWFRoM2VhMTV5SGV5TkllWjN4RjJZUlZsYytwZkFJaTFo?=
 =?utf-8?B?azAya2phME94enpCTE9KaENBYmlnanRtNWkwcWIxM3Q1VFBPVVNISTlxaC9v?=
 =?utf-8?B?dWNVcHVkR24zM0dDN0ptTzkzeTdkS2RPNllYa0xrZ1pRNkJrUVZQVEpQQmlm?=
 =?utf-8?B?YisrcXZaR0xEM0lXSU9zemE3Qzk4L2VZTzZmaWg0dnB4K1JSNlhNRnRSaXJS?=
 =?utf-8?B?cEw5U0szTnY5OTFWWjlCbmljMW9SKzVmb0dyV0RDUnpGSGNxT2hMb1R5L2w0?=
 =?utf-8?B?Ykh2eE85NkxwV2Y1VXBYU3JnTGdsRGMvYzRvTjF5akZoQ2Naam9EOHg1ZU9V?=
 =?utf-8?B?VGY0Vk5Da1l5UWJJNUg0YSsxWWdRbnBnV250VnZzRHJad01HYmNvajJ2Vk9G?=
 =?utf-8?B?Nm5mZ2YzNWgwR05GQXlVMkFYZThLSWpRQnU1Rk9oNVlaM2ZTWXRkdUE5YWY0?=
 =?utf-8?B?M1BuTVRQbEpGZ2hoY2NxMkZlU2JvOWJza0RQYTNWaStzcm5mTnJQZURHdktS?=
 =?utf-8?B?MFkxcWVEYXB0ZlFZYjc2TWdzVUdlUG5KNlllN0dUNWR2cmZPV25iQ1Q1Q0dm?=
 =?utf-8?B?cElVU0lCTVZ4OFVmWllPZXZuQnhOSkZkeXV6YXBJbWRMblNPUURFQ3Y4Z09k?=
 =?utf-8?B?V2Z2SUtLaGpXRDA2QWVqSTNoYzEwN2FLUmRERFl4S2RiWUt6OVhQbzNLaWoz?=
 =?utf-8?B?ak9scmtKWVlQRDVhWlBmWUFlWGpiZ2NaU2dlS3BBVi9IUk9mcFl2VEJ4V1FD?=
 =?utf-8?B?V2lBWmZkRlllM1dCb00zSDg2N0FKS2lzVFBMWmFSK3gwcjNXQ3pLemJPMkpr?=
 =?utf-8?B?ZEVkMklQYmNzS2V6RU5ub1ZQam9NUEVoUlJJK3pMQVVmZ2pvVnkvY2lJSzZn?=
 =?utf-8?B?SXdMSytDOVRjanp5Q01MRTA4UEh5ZjBRUmJKL1NWWjFGeVVpOXdjRzJSajJY?=
 =?utf-8?B?SlZTZGVYQnkzaGRDYUNKTVlzMzZqMHdrMjk0bGZTVHRodkwzMG1QK29Yejlj?=
 =?utf-8?B?K3c0anZUSFFMaTNEeTBPOWI1aEwxcTdSRHM3aGdLZ3ZldVR5QWVJMHV0SW1o?=
 =?utf-8?B?RlJLb2JpMHVCZktpTmZRQUxvbkpmVitiaVRNVUwrS0pranZCaU4zNnY2WmhU?=
 =?utf-8?B?YXJzcVVmQ2JTaFJBRU81V25jM2tETEJjcUxtaTROS1hHRy9ISG1ISXZkU2d2?=
 =?utf-8?B?dGFmM2N2ZkdKM04rVTBDaFJEREdjNDZXcFBaeWVHbjhZci9vaXVwaEFvZDEy?=
 =?utf-8?B?V2Z1U2RkWjFDd2pvOTlFejRRQTdFbS83d1lhRWJmWWpiMmhOQUdDQ0tHb043?=
 =?utf-8?B?M0tLZ0ZUREdsQzZGcEFaR2wxV0tIQm5ONHRuM0tRTGVGSGdpSDlxVnIwcGxN?=
 =?utf-8?B?bjBOVjFqelF3c3JheVdzRExLUUpSaElXZjh2Q1g4aFJsYTFvaklxd3MxZTFY?=
 =?utf-8?B?b0x1ZU44b25JOW9uK0g5KzlOU1IrRm1URG04eERKR1NDQ0hmWjJOZS9Lb290?=
 =?utf-8?B?bWlJRjB4WDBYQTlSbU9SU2Q5TVVWUnZPT0h1eWFaNEN5S3V6UDByOFJ3dUlM?=
 =?utf-8?B?RmtQcHltN1h1dmhNSFVOcHRldXZUdTVVTCtVRWdhZ1VkVUhhY2JHVWl4NG9T?=
 =?utf-8?B?Y2wrSHFwY3NaYzVLWjBCVUtwMTA4VFVnWlNHcm1NamoxNnBIZVdvT29wV2Uz?=
 =?utf-8?B?NmlNSFA3NC9aSklldzRFdW10bEkrOWRqWFFONVZ5OTRDd0FPd0VpMUx0UWFR?=
 =?utf-8?B?WlQ1TkdUSFZDSkQxMXVWRmtUemtPekxTdDV2Y2NoRlVZRnVjdW5VdEtuUVBz?=
 =?utf-8?B?VTlmazJvdWRZUjhBSTVmRXk5NkRrK3RacDMrbmVvYUo0RlJ2QUpuWTdycVY3?=
 =?utf-8?B?VEtta0NCMmlyc01oZTJTYmd4bnFDaFdWeDhYclMxTUhRa2lYejhYQjF5YW9i?=
 =?utf-8?B?Q2ZWY1dlWStBWllrZDA3RWl3amxuajdiZHZQS2ZMdmVFY1hnbjVRdW9mNExO?=
 =?utf-8?Q?O8epDvk0QucKsKGcTgCOwe1J9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef387e1-bd8e-4791-1719-08dc2df4cf74
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 07:07:45.5511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zOxBXCGuuG4Ta3Ve9fyfQ+uY37NL47r/PYVzVPjosfTONANBHGfie2VQmgWsZDVJ/FEz1141BI/qJ2/qFIzUiJuS7Bw0EH43eJ8xkIJDUZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7682
X-OriginatorOrg: intel.com

PiBZb3Ugc2FpZCB0aGF0IFJEUkFORCBpcyBmYXN0ZXIgdGhhbiB0aGUgYnVzLCBzbyBmYWlsdXJl
cyB3b24ndCBiZQ0KPiBvYnNlcnZhYmxlLCB3aGlsZSBSRFNFRUQgaXMgbm90IGJlY2F1c2UgaXQg
cmVxdWlyZXMgY29sbGVjdGluZyBlbnRyb3B5DQo+IGZyb20gdGhlIGV0aGVyIHdoaWNoIGlzIHNs
b3cuIFRoYXQgbWFrZXMgaW50dWl0aXZlIHNlbnNlIG9uIGEgY2VydGFpbg0KPiBkdW1iIHNpbXBs
aXN0aWMgbGV2ZWw6IEFFUyBpcyBqdXN0IGFuIGFsZ29yaXRobSBzbyBpcyBmYXN0LCB3aGlsZQ0K
PiBlbnRyb3B5IGNvbGxlY3Rpb24gaXMgYSBtb3JlIHBoeXNpY2FsIHRoaW5nIHNvIGlzIHNsb3cu
IEJ1dCBpZiB5b3UgcmVhZA0KPiB0aGUgaW1wbGVtZW50YXRpb24gZGV0YWlscywgUkRSQU5EIGlz
IHN1cHBvc2VkIHRvIHJlc2VlZCBhZnRlciA1MTENCj4gY2FsbHMuIFNvIHdoYXQncyB0byBzdG9w
IHlvdSBmcm9tIGV4aGF1c3RpbmcgUkRTRUVEIGluIG9uZSBwbGFjZSwgd2hpbGUNCj4gYWxzbyBn
ZXR0aW5nIFJEUkFORCB0byB0aGUgZW5kIG9mIGl0cyA1MTEgY2FsbHMsIGFuZCAqdGhlbiogaGF2
aW5nIHlvdXINCj4gdmljdGltIG1ha2UgdGhlIHN1YnNlcXVlbnQgUkRSQU5EIGNhbGwsIHdoaWNo
IHRyaWVzIHRvIHJlc2VlZCAob3IgaXMgaW4NCj4gcHJvZ3Jlc3Mgb2YgZG9pbmcgc28pLCBmaW5k
cyB0aGF0IFJEU0VFRCBpcyBvdXQgb2YgYmF0dGVyaWVzLCBhbmQNCj4gdW5kZXJmbG93cz8gV2hh
dCdzIHRoZSBtYWdpYyBkZXRhaWwgdGhhdCBtYWtlcyB0aGlzIHNjZW5hcmlvIG5vdA0KPiBwb3Nz
aWJsZT8NCg0KVGhpcyB3YXMgb24gbXkgbGlzdCBvZiBzY2VuYXJpb3MgdG8gZG91YmxlIGNoZWNr
IHdoZW5ldmVyIGl0IGlzIHBvc3NpYmxlDQpvciBub3QsIGFuZCB0aGUgYW5zd2VyIGlzIHRoYXQg
aXQgaXMgbm90IHBvc3NpYmxlIChhdCBsZWFzdCBmb3IgSW50ZWwpLg0KVGhpcyBzY2VuYXJpbyBp
cyBhbHNvIGJyaWVmbHkgZGVzY3JpYmVkIGluIHRoZSBwdWJsaWMgZG9jIFsxXToNCg0KIiBOb3Rl
IHRoYXQgdGhlIGNvbmRpdGlvbmVyIGRvZXMgbm90IHNlbmQgdGhlIHNhbWUgc2VlZCB2YWx1ZXMg
dG8gYm90aCB0aGUNCiBEUkJHIGFuZCB0aGUgRU5STkcuIFRoaXMgcGF0aHdheSBjYW4gYmUgdGhv
dWdodCBvZiBhcyBhbiBhbHRlcm5hdGluZw0Kc3dpdGNoLCB3aXRoIG9uZSBzZWVkIGdvaW5nIHRv
IHRoZSBEUkdCIGFuZCB0aGUgbmV4dCBzZWVkIGdvaW5nIHRvIHRoZSBFTlJORy4gDQoqVGhpcyBj
b25zdHJ1Y3Rpb24gZW5zdXJlcyogdGhhdCBhIHNvZnR3YXJlIGFwcGxpY2F0aW9uIGNhbiBuZXZl
ciBvYnRhaW4gdGhlDQogdmFsdWUgdXNlZCB0byBzZWVkIHRoZSBEUkJHLCAqbm9yIGNhbiBpdCBs
YXVuY2ggYSBEZW5pYWwgb2YgU2VydmljZSAoRG9TKSANCmF0dGFjayBhZ2FpbnN0IHRoZSBEUkJH
IHRocm91Z2ggcmVwZWF0ZWQgZXhlY3V0aW9ucyBvZiB0aGUgUkRTRUVEIGluc3RydWN0aW9uLioi
DQoNClRoZSB1cGNvbWluZyB3aGl0ZXBhcGVyIGhvcGVmdWxseSBzaG91bGQgcHJvdmlkZSBtb3Jl
IGRldGFpbHMgb24gdGhpcyBhbHNvLg0KDQpbMV0gaHR0cHM6Ly93d3cuaW50ZWwuY29tL2NvbnRl
bnQvd3d3L3VzL2VuL2RldmVsb3Blci9hcnRpY2xlcy9ndWlkZS9pbnRlbC1kaWdpdGFsLXJhbmRv
bS1udW1iZXItZ2VuZXJhdG9yLWRybmctc29mdHdhcmUtaW1wbGVtZW50YXRpb24tZ3VpZGUuaHRt
bA0K

