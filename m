Return-Path: <linux-kernel+bounces-62222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D4F851D36
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E679C1C22428
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3893481B7;
	Mon, 12 Feb 2024 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UMdGmz/t"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6862B481A8;
	Mon, 12 Feb 2024 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763543; cv=fail; b=KlFVl7ZlKtD5sPgZRV+Ez8f41ano7qD3MpnGabs1Ugo5pSltgg0mxixFBuZbNWRueyEUOkZvgaq/PbpbTJH07lL0iF7JkcFUWNRcDBYp4v7pSLXqCIt+w9xFpkee9Pr/1llwgLMKrkdsfuHtz0r7lrs2hSZImaKTj11N2M/xb+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763543; c=relaxed/simple;
	bh=JVG+3SqxU2elgctEdB0KDPPF9h+NR+Ooliwyq/2JF8o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kFvdcTTnxkAl+O1NFecBK9bEt91wvjnde9NMcp1A81C8pvB2RjSJ6BVjrknQrVxfx1baL+INsiQ88jP45GFr2eqzUG4BIJJdhjJyDQZNPNVvQ7/t+CRTwtu+xMnI+U0xU6IMvj7bdjjllHYnbOjy4NLJMAWIBVQS3On0FaQFcEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UMdGmz/t; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707763541; x=1739299541;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JVG+3SqxU2elgctEdB0KDPPF9h+NR+Ooliwyq/2JF8o=;
  b=UMdGmz/tEGI5ePC9sW48neDiKOX7tBoO2hjhEHBcPy4UDm/zw7ky/iec
   fWeZzWQe9k2xoOjwl3ofqNaKzzQ6L6fbc05T4lOwiRsz2Dh4BnW8j6WXW
   apU69Pxpsahiug6k63IlxKjteVF+IJfzo1E57XRY7FAhsmiS/dpt+Jujp
   yIObpG0DR3AMXV95P6eH01BnDlf36MlUqxP5Rs7CbUtzi6gthp3GUnmWn
   YjbwdCCZrNrvJGGjSd+aYrNOGjPf88LD76v6B7Z+U2VCygr/rrkBm2gmS
   nvrrxhOW98MdECdO0FkVWNU0BPdEjiIamKvGTYPWN5KrZw6MfXxHbSKep
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1892299"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="1892299"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 10:45:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="25862726"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 10:45:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 10:45:39 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 10:45:39 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 10:45:39 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 10:45:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9Pem4FkQ4/j3FysCwseBq/Lpr+4cZzLlJsSy239nfHJ2/HWJVnK7E21f8hWIFYBqQWNNZjZAgwK+x5pU7qXNatFtquCB+F8rTc9Vx5qgpgboyQl7L+aGb4eY61Twj2KcqX4Y0+yy9OkeHKN6AhBA08p9naDsxOsno8uLUOX7Rlp8hHvJkoA493B/Nqm5UMN4dTfH/N4wY8Ammnhw9ZplDoC6Tfy03ngJPN1d2BwdLPG51fLljC5/hZildNSHitu2x1SPk0/ssp2VUgXhshoEsBNiu+6UIUNc0EFxnvwwCgiNCxUjgFdV5ROVVoh6jCM2fTBBBKGRJQPDM1RdNHvuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVG+3SqxU2elgctEdB0KDPPF9h+NR+Ooliwyq/2JF8o=;
 b=NKHNe1+8YiNRkfE2DTxWk81TE9a1K4TRwd+ZC54GfS/+kArF4Bwi3GU51yVReR0SVe20NIpgtF88nid62HBrGZ/1mv54WcTW/Tv0KDpcy4iRcySYR9kMN/437grfD4MUcuZ3++eN1La3I91HHIu9Yca7BIDc8oeUvhJjk20jNnMQbKLoZ9M0GMLH9PLXWDZnlbNfWHx+Q7SqS7+Hn0Jy0eqyajZ5gHaT4yVNweEft1FZ3Vpbt/KgeGABzQUvCrkMy2t6uowgWCfMAHuinhs7pD700KObU4VNxu1XylcwKrB6k4pNHGJ+UbMAeRYTDgzj17nX5xkLXr9G2G6KNTb6Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BN9PR11MB5516.namprd11.prod.outlook.com (2603:10b6:408:105::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Mon, 12 Feb
 2024 18:45:34 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802%3]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 18:45:34 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: "Naik, Avadhut" <avadnaik@amd.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>, Avadhut Naik
	<avadhut.naik@amd.com>
Subject: RE: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Thread-Topic: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Thread-Index: AQHaWhj+DLVtkWOA50OiEqZPMnN2ZbEBPHkAgAE1PoCAAAHSAIAABzoAgAAEd4CAALjhgIAA4DsAgADqjICAAQaDgIAAZZKAgAAJtgCAAIJw0IAACaQAgAALi8A=
Date: Mon, 12 Feb 2024 18:45:34 +0000
Message-ID: <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240209200920.GFZcaGcOr757W9O3IG@fat_crate.local>
 <7a4945b0-322a-444e-a0ca-860a062a49c3@amd.com>
 <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
 <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
 <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <774e7ca5-154d-4ca4-bc4c-2f945c20b938@amd.com>
 <20240212085801.GAZcndma4UTPtKm33e@fat_crate.local>
 <20240212093246.GBZcnlvkPKDC8C7rv5@fat_crate.local>
 <SJ1PR11MB6083B3511D18787BE823AB2CFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212175408.GIZcpbQHVjEtwRKLS-@fat_crate.local>
In-Reply-To: <20240212175408.GIZcpbQHVjEtwRKLS-@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BN9PR11MB5516:EE_
x-ms-office365-filtering-correlation-id: 3bcc5992-52e1-44ac-2238-08dc2bfacc2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ecfqoCvXwEBi+AeokA1Iub2B3TA3LbC9NamDdV28l5/7jCQ2r1ORgU7C2rdQsEUUhETbK7/fP7eM9esPbWrOBr0QrHGOski9fH98TI9E2Sy9W9Pdrz4WiE/HODM66PQISpRCz8nRWZgu3JfnnFxVYhkgprjUDtqWnSm5RRvrTz9U7KEKJokJSj0Kg6FhzmbciTjVxctGCXyZXtL5+CGXweRyvJQMx1jhZBhUBxmCTci9maFhDT/TE92HrpczZhmBnkW0P6eVRTKs4cpq++cUvgpnjqjg00wrQYnHzijkuEltgG1XWTRF72TXDU/ru4vOeFuLzlhP0BiKw6J4EGp5cs/rVOMleN+ZLOgmHf7bSqXvci7NBgxb6/z6f6G9BOgiCsnn5MQELaXmGJfQOn1vJWbZzlLXzmuCmEV62OOzuY26t5GlMzQ9Wo07tDWHrEawel6C5yOAin5K53+tgUtzSTi3Gra3ulLS3Nf66lvsUXSVzY3SsryIaGUUoifEwXiPKGEWCk8r/d8uURyhGD8XCvmHM5mTUXBvwfMw+TcAbve+weX9Cs2G0EzLCwfUlZqo0NE/fgSLKA+LuxnBcRGct9MUp59brZ8RONJ6lk8HOHH6HAmD5FFwxz0QUY9QA51q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38070700009)(4326008)(8936002)(8676002)(76116006)(66446008)(316002)(54906003)(66556008)(66946007)(66476007)(6916009)(64756008)(5660300002)(2906002)(52536014)(71200400001)(45080400002)(122000001)(38100700002)(7696005)(26005)(6506007)(83380400001)(9686003)(86362001)(33656002)(82960400001)(478600001)(41300700001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEVGazUrdWRqM29mcHI3V2tBRG5DdkcybnZkM3J1aEg1bEl6QXpka2hKL2xL?=
 =?utf-8?B?WkJ5bGJmQ3BjWmF6eURFVjBvb3hrRnc2M01MWlhvSDk3V0EwZys3aXJaajBJ?=
 =?utf-8?B?clVUMG14ak1lQmhOU0FHVDNhTiszYUdjQzBaTDFuMEtybU5URU5HQjlQMVha?=
 =?utf-8?B?UVFTb1hjb0dFMkU2c1UvRzlZdFN6RlBSUHZXekVYRVEvdGdQUjFRS3FucmVI?=
 =?utf-8?B?SjFpcnlXL2k4Zm1VckdlUWNiNVh5aUhtNnBRVll2aTM5bSszSzhXR0krbGlQ?=
 =?utf-8?B?V2lCQ090cnBlRFZrYTNSN2p4R1JYVTFtV0ZYU2E1NHR1Z0tMM0Izd0RvRVRP?=
 =?utf-8?B?cWJGSEUzaTJXVlBCeWxiQ1BZWjVTQXhITm9RN0Irdk1GTTJjSDQ4cFVSZ09a?=
 =?utf-8?B?R29Md1VnTFlkbExIZDkySUM3YkJoTmFQNGtteVVYZy84aHhweWJOWjRHUlFE?=
 =?utf-8?B?VzAydFdwM25OUmhLZU9BZHJaZ0lEd2FWQ2ZFdFFqemlvbERGSmllOW16bG1G?=
 =?utf-8?B?U2VIN0VGV21sRVRoaEdiOUw5SWhVVU1MVWVhWWRaYTNmVTdHY1oyV3RZeXls?=
 =?utf-8?B?YitaSklIUlZibzNKeXdkeWk1ZS9uU2VvNTZsZHl5YjAza0VCeU9LaHY1UWxo?=
 =?utf-8?B?N1dqYTlQcjFyT2RmaTZ3Q1BWTWl6WUdFSXdQS3o5aCt1SmtlczlUdzZRNXRz?=
 =?utf-8?B?b0xJNmJRa28xZXlESEdUNk42dnBPcnBKTXVoWlg1QVVGODhWMkdrbzNuOFFV?=
 =?utf-8?B?Mmo2NHZKSzdJdldHWmJ5TG1rZjBGU3p1L0FTZno1Zmg0OFdnQzNYenl5SXZu?=
 =?utf-8?B?UGJ6d2ZrK2M4UWIrZjVwN1d1R3BPRGxMV0NCdmYxOFpzWE1yQVora1Y3RFM1?=
 =?utf-8?B?VHZGcjRYdVhyTExIQVQzNVJWUHZERXExMmlKb0pzcTZENnpJOC9WVDBRQU1Q?=
 =?utf-8?B?dEN4ZW1qdHNIbWpJZk85K0U4YVhOSklBMmJwdnc5TmU5aDk0MHIrbHFkZWdv?=
 =?utf-8?B?NDlNZS9qOC9NNThoalZGbkdadUw2RW4zQkFGVXpIZnd3S3dwRmJ6Z0ZZeUo4?=
 =?utf-8?B?eUt2VDVnV1dJWk0wa0ZOcFU2d3JuY1VhaDkwSWNpYVVmL3JqRFBRSXU0ek1M?=
 =?utf-8?B?VkRQWnZuREpXMUZIWG5NYlVRTGlwbUhUL202aGQxZTJGTE1UUVNoamlZVHdu?=
 =?utf-8?B?ZUxuZzM4WEhhaU5vM043cnRmVjhlc3N2QmliZ1VVQzFJRGlVdHJLNnBEVjJp?=
 =?utf-8?B?SC84TUpmNnY2dmg1dldOM2NCeG9CbitHVXR3SjZraXdEdVdpMUZ4Z3JXMERQ?=
 =?utf-8?B?b3NWVU1wOUtrY1YvcGFiK3J3b1hiOW4reDRPRE9PR3dvSnhuUEJXYkE0Y1hX?=
 =?utf-8?B?bnY5UDRVZVdVV25uUE5leUtvRUlUWGdmNEQxbzVXdGZlT1NSbDVTam10c0Na?=
 =?utf-8?B?emhiQzFOT2c0UkliYkNLNDdWVW1pRUhwRnptMzd2UU5JTXdPdzdHRVZjak1F?=
 =?utf-8?B?c1EzbHl6WWpybVpCeDU2OExpUGdpMDlQM3BPYldLVm15R3MzZDJHYVZhaEVs?=
 =?utf-8?B?QVZzM1VnTWhtOUdrbXA0a0hRTm1KRHFKRDk2TUdhQ2xYS2NXSVpJaWxPQUdz?=
 =?utf-8?B?emdHL0o4M1ErTEhLc2ZCakw0dTRya292UkdLM3JxNkJKVW1MUFZ5RkU5VFkr?=
 =?utf-8?B?Nk5YNUZQVDZyNE85R0c1TkdUeWFkakk5bS9TaFJUcEpBU1J6RnFkOXBQNzFo?=
 =?utf-8?B?SGppVWtjMlB1YUkxR3hIaXkrNDlCenMvQ0QvQmYxSFBaVS9MWk1vWmdZRkhK?=
 =?utf-8?B?bkpyMFVoUFcyWnRBVnhQMnAxRWRhSnBPc1RGSEhNTit0c3dHVmo0cldkR0cw?=
 =?utf-8?B?Z3J5a1d3WlRDY2pKcWlCWk9XS0UrSmpBMytpYTQvQVd3TzcwRjBFWDZIZml3?=
 =?utf-8?B?TVVDbjl6NWJTNVZRWnIxZUlrU093b3dMSUFMa3JJZVEwMUxCWE9OREprdWJ6?=
 =?utf-8?B?UXhWSlBpbjg3R1hoY2xGYWs1OWZVL1RJK3JSSlFYV0lJb2dZK0l0TzY3WTdh?=
 =?utf-8?B?VDUzb1doc1NsYXRFcEp5UHFjQ3R0MGg5bWZjcnlpSnRVRFBQNHpuUlFpQXdO?=
 =?utf-8?Q?RMBOWgW7dhgtDdAtNqzLIoOIL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bcc5992-52e1-44ac-2238-08dc2bfacc2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 18:45:34.6367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HsMiIIuYBocG2dqWkteXdiExjD6cZNgCda6rML+1t8MyR9pQD+fqxjmr6Kvt4bUgyQ7LYmS+OEfOUKsYiNZ96A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5516
X-OriginatorOrg: intel.com

PiBZZWFoLCBpdCBpcyB0b28gc3RhdGljIElNTy4gRXNwZWNpYWxseSBpZiBOUl9DUFVTIGlzIGEg
YnVpbGQtdGltZSB0aGluZw0KPiAtIG5lZWRzIHRvIGJlIGJhc2VkIG9uIHRoZSBhY3R1YWwgbnVt
YmVyIG9mIENQVXMgb24gdGhlIG1hY2hpbmUuDQo+DQo+IEJVVCwgd2UgZG9uJ3QgaGF2ZSBhbiBh
bGxvY2F0b3IgeWV0Lg0KPg0KPiBTbyB3ZSBlbmQgdXAgYWxsb2NhdGluZyBpdCB0aGVyZSBvbiB0
aGUgaGVhcC4NCj4NCj4gVW5sZXNzIHdlIGNhbiBkbyBzb21ldGhpbmcgd2l0aCBtZW1ibG9jay4u
Lg0KPg0KPiBCdXQgdGhlbiB0aGlzIHN0aWxsIG5lZWRzIGNvZGUgYXVkaXQgd2hldGhlciBudW1f
cG9zc2libGVfY3B1cygpIGlzDQo+IGZpbmFsIGF0IHRoYXQgcG9pbnQuIEJlY2F1c2UgaWYgaXQg
aXMsIHRoYXQgd291bGQgYmUgdGhlIG9wdGltYWwgdGhpbmcNCj4gdG8gZG8gYSBtZW1ibG9ja19h
bGxvYygpIHRoZXJlLi4uDQoNCkkgdGhyZXcgYSBwcmludGsoKSBpbnRvIG1jZV9nZW5fcG9vbF9p
bml0KCkgYW5kIGdvdDoNCg0KWyAgICAyLjk0ODI4NV0gbWNlOiBtY2VfZ2VuX3Bvb2xfaW5pdDog
bnVtX3Bvc3NpYmxlX2NwdXMgPSAxNDQNCg0KU28gaXQgaXMgY3VycmVudGx5IHRydWUgdGhhdCBu
dW1iZXIgb2YgQ1BVcyBoYXMgYmVlbiBjb21wdXRlZCBhdCB0aGlzIHBvaW50Lg0KDQpTbyB1c2lu
ZyBtZW1ibG9ja19hbGxvYygpIGJhc2VkIG9uIG51bWJlciBvZiBDUFVzIG1heSB3b3JrDQoNCj4g
PiBbRGlmZiBwYXN0ZWQgaW50byBPdXRsb29rLCBjaGFuY2VzIHRoYXQgaXQgd2lsbCBhdXRvbWF0
aWNhbGx5IGFwcGx5ID0gMCVdDQo+DQo+IEhvdyB5b3UgZXZlbiBkbyBwYXRjaGVzIHdpdGggb3V0
c2NobW9vayBpcyBtaW5kYm9nZ2xpbmcgOi0pDQo+DQo+IEF0IGxlYXN0IHVzZSBUaHVuZGVyYmly
ZC4gVGhhdCdzIHdoYXQgSSBkbyBmb3IgdGhlIGNvbXBhbnkgbWFpbCBidXQgdGhlbg0KPiBhZ2Fp
biBJIGRvbid0IGV2ZW4gdHJ5IHRvIGRvIHBhdGNoZXMgb3ZlciBjb21wYW55IG1haWwuLi4NCg0K
SSB1c2UgImdpdCBzZW5kLWVtYWlsIiB0byBzZW5kIG91dCBwYXRjaGVzLCBhbmQgdXN1YWxseSAi
YjQiIHRvIGdldCB0aGVtDQp0byBteSBkZXNrdG9wLiBJIGRvIGhhdmUgIm11dHQiIG9uIHRoZXJl
LCBidXQgSVQgaGF2ZSBtYWRlIGl0IGNvbXBsZXgNCmZvciBtZSB0byB1c2UgaXQgdG8gc2ltcGx5
IHJlYWQgJiByZXBseS4gSXQgcmVxdWlyZXMgc2VwYXJhdGUgbXV0dCBjb25maWcNCmZpbGVzIHRv
IGZldGNoIG1haWwgYW5kIGEgZGlmZmVyZW50IGNvbmZpZyB0byBzZW5kIG1haWwgYmVjYXVzZSBv
ZiB0aGUNCmZpcmV3YWxsIHJ1bGVzIG9uIHRoZSBsYWIgd2hlcmUgbXkgZGVza3RvcCBsaXZlcy4N
Cg0KLVRvbnkNCg==

