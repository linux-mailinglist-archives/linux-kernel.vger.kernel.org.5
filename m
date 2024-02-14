Return-Path: <linux-kernel+bounces-65873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD7985531B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5001F2579A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B0F13DB80;
	Wed, 14 Feb 2024 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TN9d91ff"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA3D13B78B;
	Wed, 14 Feb 2024 19:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707938376; cv=fail; b=ugxHGCDRmSZeL4dvlm3JjGYAoQ7w9ql6QZLx8td2+XVGNsZcgzIbIZT+v3kLy1iT1jRCX6YSJH/gKyo3cfmm9KEsYRkteTGA71V6izit8yGL+UUSMv8TBRt8824AuFI51OGtDADGlfXkhGGT0L4nZ3oQ42PRG9oYj9VuHA41sbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707938376; c=relaxed/simple;
	bh=DvgIrxC4Hqe3MFnHbT+MdfxNLoF5ub3DjKbHEmduG0E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kclcNGHEq0f89RScOAeUqlHpmh5olaLYPb6h/Ibs3NmfByXWrzTa4D+ErH5EbC2dhz8CuNLBVlXxhql3WYqX7e4BKOSyzgRk47JMGq0+atnFuXAMKfDjd89IgV8maA4/k9w34Hzhz/mBm0lHBmcg2I9po4SC+0MbM5q8fUbBTOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TN9d91ff; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707938375; x=1739474375;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DvgIrxC4Hqe3MFnHbT+MdfxNLoF5ub3DjKbHEmduG0E=;
  b=TN9d91ff+a4thg/b8UjvFuPushUGBZ89++8O7EWdyOioK8MasBa8w1oO
   LtrjYKlRdUP43aIEWNxgeN9DGoqXJshLbjhBmmsEvjdWcNy1l6xlABMk6
   bKQq/ymgmqCH9NncKWpi/IdDaeJgC+KSp9SpKvVuEyre5vaKMxr+6V5O2
   fa6j56UDJJBPKSYD0CddOOTGaxIJlYGro4WXKKENWp6PX7z/3TmKr9RtM
   Nsj8syvJ2tR9u47lZbZ6JIpTj1UXsc3wAAU0fKMlnnYAUtXWCndKw6U/K
   iDY8JSQS2T4q5RjEXLzW2wCaFXufp3bBrxQ3Y8ImC4eU26EiIQzc0uwcX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2129363"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="2129363"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 11:19:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="7948586"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 11:19:33 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 11:19:32 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 11:19:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 11:19:32 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 11:19:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDvcWkLs7INymxHW/2FeEYA0sSYmuzwU5kTYRw1Z5fyG5ndn14Qun9hyFP+PmfB8D5/w7uKYdTM3iWNd6IJQSvaxg3/GBFOgJz/J2b8gJEi7CXOg05nbOyCMzr7769C4lNGjdN0A0+8EnTyNL3vI/FElnA/KzkEDB5YH1y5hFBxZM1suhK0jZkbheyT+wEbIRGq7rWOX54of9wrjmOU2Pyi9gd4oCd2Z76+emQ7K/BI4PPf9Qx5YdHT1FNtCl7HfEx2H/oo1G0evyJhystdAY3XYyg3lHd2eRjSNAw9P0SiyLhAvpRvuGSI4P+IoCquwwKdGlt/VEOJ2YyCLs+lBkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvgIrxC4Hqe3MFnHbT+MdfxNLoF5ub3DjKbHEmduG0E=;
 b=hyAXuBeXVhTrq6HRC4aSHwq7vJDhSW3abKBcF/xEd6G1v1DIvzb2oLJ1aGCgT0HArzFUPwtOlU9unJCrxJYQHHw10uCCbxkFIyubyk5h7N7EMZ9dSEkyn2YhPnHBNb/TB1K9MzvArm/wO9v4ZAwiseaButnUZ4glR51m9wPS0rjSPSdMzFRap97PoDmq78EgJQrPFiuGwfsHj1wWIZrdTbz3647uQB2e+riJhqlS+vjq+4aRMkTj/MORQnBuu8fw8C5+Fjl2E0bybGxvsLsT/Bcjc/eAw+sKYYsXQ6dExzqKOpd7rhwCZzscmgZAmGZtnwxxsIwopZB0hDOgD15sEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by BL1PR11MB5956.namprd11.prod.outlook.com (2603:10b6:208:387::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Wed, 14 Feb
 2024 19:19:28 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7270.031; Wed, 14 Feb 2024
 19:19:28 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "petr@tesarici.cz" <petr@tesarici.cz>
CC: "Xu, Pengfei" <pengfei.xu@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "luto@kernel.org" <luto@kernel.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"brgerst@gmail.com" <brgerst@gmail.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"corbet@lwn.net" <corbet@lwn.net>, "Li, Xin3" <xin3.li@intel.com>,
	"roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"petr.tesarik1@huawei-partners.com" <petr.tesarik1@huawei-partners.com>,
	"dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "x86@kernel.org" <x86@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "peterz@infradead.org" <peterz@infradead.org>,
	"rppt@kernel.org" <rppt@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>, "oleg@redhat.com"
	<oleg@redhat.com>, "keescook@chromium.org" <keescook@chromium.org>, "Huang,
 Kai" <kai.huang@intel.com>, "jacob.jun.pan@linux.intel.com"
	<jacob.jun.pan@linux.intel.com>, "zegao2021@gmail.com" <zegao2021@gmail.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "Rodel, Jorg" <jroedel@suse.de>,
	"Zhang, Tina" <tina.zhang@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"petrtesarik@huaweicloud.com" <petrtesarik@huaweicloud.com>
Subject: Re: [PATCH v1 0/8] x86_64 SandBox Mode arch hooks
Thread-Topic: [PATCH v1 0/8] x86_64 SandBox Mode arch hooks
Thread-Index: AQHaXzn8yQ0cq1LpsEep6xLElvfqRLEJ7IWAgAAJ+YCAABRvgIAAGgOAgAAE/oCAAA0RgA==
Date: Wed, 14 Feb 2024 19:19:27 +0000
Message-ID: <78fe4fdefa4f427b3fb1b6968d8799035c0c4124.camel@intel.com>
References: <20240214113516.2307-1-petrtesarik@huaweicloud.com>
	 <c424618c-d6c6-430a-8975-8851a617204e@intel.com>
	 <34B19756-91D3-4DA1-BE76-BD3122C16E95@zytor.com>
	 <20240214174143.74a4f10c@meshulam.tesarici.cz>
	 <a27c9c32e410fc3582f3593f209cc1cf3b287042.camel@intel.com>
	 <20240214193241.7447a082@meshulam.tesarici.cz>
In-Reply-To: <20240214193241.7447a082@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|BL1PR11MB5956:EE_
x-ms-office365-filtering-correlation-id: e07f2103-2a8c-4045-8621-08dc2d91dcf4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EyVd0C/zVEbVTmx/z2sbfdyeD0E6h58Wn7NccM5e3y4h5SzCmiviEKPyHVp/eCLhBWuwGOBh2K9GhfCYEU8IqDWmn80mhN/xgAiiM/cuAm8Fa3GfQuMn5twnQmD+dDwR8Y8bf+FJCFJI7JzGvSHfizljgQlPFZ/yAqcMB4dToxzaMBWygYKmZ11vdFaN51lbE3OYA8H/Hd6+63LP922xLv3MSeXIlC7Xk03wc5vqzjJPqiBBKvKkOCYM/Zw0vIfAsiaqYu1xtWENRWHzYD4b8IFc7lmL9wnPiUzp8i2yAPFBtDO/9omZACiXRh+J/XdRfdQkxHjv8/R3Nq/xdgwBqSLLSSRG0GBsu6T+ByieH1SETn4vyUtxZW9z8VjfQXPva3DT9NIg/l8iaWLMJEe3jHD/ZjGG63Uu42POoMfENFcrJdE1QWhWm+a7Kwrm3xTczb/Yj6COi7J7joU+sYoI7Pndva4Qt4ZQI7cDTch8lE1qhxwWDzLzKheQULe7SMCbpJjcAroZl8xvOARJqfWJvj3DjQ0BSr+68vJseyliDdPonCmg85PU/PLXzn1HtbYzPo7raO7zWEC79b5abdW5CvyJJKZ9P8cX3blbMNR+5LuAMYQ2NmEI6co7Nq5mLq8V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(136003)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2906002)(6506007)(7416002)(36756003)(6486002)(38070700009)(6512007)(71200400001)(54906003)(64756008)(478600001)(4744005)(2616005)(41300700001)(83380400001)(66446008)(4326008)(66476007)(5660300002)(8936002)(316002)(66946007)(86362001)(8676002)(76116006)(26005)(122000001)(6916009)(82960400001)(38100700002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGg2cG9XQ0xrRHAxaSt6S0pIREhCeG01WTh5Q21UVDdHek05TFZFZGc2YlJG?=
 =?utf-8?B?VGh6eWxWNVhaVEFyb1g3Z1ZJM0VGckN4QzFqMksrTFg2eGtsRFdvclV0a050?=
 =?utf-8?B?bE1tWERaSWhLSlZwa2JIUXQ4ZFNUNkJpNGM3Y25MODNONStuOVFSdmNMUEEy?=
 =?utf-8?B?aFRqN2YyWFlacjh5bXJzMUJscE1SeHRzSHNtb3dJNjdiTUh2c3VheGFzeERj?=
 =?utf-8?B?NXFBaGtRNUU0RVVlNDAzZWc3Zkdpc3BrblFtb0UzNlRBTU5FNE1rZWUyN3Ur?=
 =?utf-8?B?OXlGcyttTXBYckNkNjQzZWpQa1lNQzVBRmFaQnNLT3RWYmNLUmRDUkNNYTh5?=
 =?utf-8?B?TVZhNDVGSEtiRnJJK1hRNWZKYVJJYTNKZFNiWmprTFdXSk44SUY3ZUs5ek5x?=
 =?utf-8?B?MlByWE5GZlkzR2J4bXVwTXM4VDdBNThFd1VHVndlMjMxUUVUOTNrakNtSjdi?=
 =?utf-8?B?MDZlZENnSWxGaHZvZVVEOGJZZTV6SUNrUVphcVhDNlhIa3k3cmxwUW9PQUZB?=
 =?utf-8?B?UjlrYXpvZk4wYmlORHpDMUdzcEo3b1BBR1hqQStobDlBN3VvUXpXcGpKL0Fz?=
 =?utf-8?B?Z3pBNWhkNStTNExyWERQT1QzT2tLcTJGNTEwTHZ4eDJOZzJJaUZaMDh4UXRr?=
 =?utf-8?B?L2VRSDdCTUIydDJnY2FGc0IxYkZCUDBES0gxcHI0S0NsaVBTNzRyS0VKYVpJ?=
 =?utf-8?B?eG9EdDJIVlVUcWFpVEcraXN5bnpFQ0NTZloweG50SUo2WjRNb21WVVZPbjJK?=
 =?utf-8?B?YjMwUWxKOGovNmMrNnlYQWRYTENMOFo4OXNxK0poN0lIWC9ncGFVZk1mU2lh?=
 =?utf-8?B?aUFvczhVVGRPM216OWVBZTAxWFFhNnFQRUNtaEFnTWIzRjZ2eWxWSTZGcE5N?=
 =?utf-8?B?QXNoTjdHbnhVVlphTS8wNi9lb2x3MitLMjZRcjJUY0hFemRiSTYxWjloa0pU?=
 =?utf-8?B?dVRpU1FwS2daeVlVNmFRK0x2V0RtTmlqZHhUNXh6NTFvcElxMVNKajBJTHI4?=
 =?utf-8?B?Q0phZVRZdXBqa0NNNWtzdFNjZUJ4cEU2RWdZQ0VYdUsvOEIzR0E1cnFQQzls?=
 =?utf-8?B?MDBqdTJWMzQ2WTdFeDJORkowUCtNZjREVS9sbXVXU2NTYzEreEpPMDEzYjFr?=
 =?utf-8?B?dXJ2RUFFNnM4MXBDWGhHemRQck9Cc1NiWUdoZzg1QXZtZDY2cFJ2VmR3QTBo?=
 =?utf-8?B?SXRuK0ZCNXJ2ZE9mLzI5L3RCM1RQM0sxQWNONG1QaHZsYUxZL0VUeDBiczky?=
 =?utf-8?B?cGI1MVBxOGxQZjcxZnBCTHdsaW4wN2Z2VW1MUEdNWGdIU2JEYnNSVjlnYk5M?=
 =?utf-8?B?VjUrdmFBTFNKNFZUeVdWL2RQWTBTdVE2b0RFV2xlRyt1Zm5GM2RPNmRDNlg4?=
 =?utf-8?B?b0pVa2d0am9nUzB1TlZzOG1wanhMVzhuUWVaV3F4UlFhLzM0M1ViQlRJdlhJ?=
 =?utf-8?B?QUdyUUhQaXAvVXBpdkdNbDM0L0NEbWMrZzdGUEs0OE9yc002cC9DcXhDT2g1?=
 =?utf-8?B?WGpxdXg5WXNmd2NvMldmdE9MT1VCazVXcnM0UUJaazJRY0ZQcmJiMGxySERG?=
 =?utf-8?B?UlhWZ1JpOG5lTG1MSmM1eVV5cmpFUHAyUDZnZVlHMjExblc1d2RsRlVuOXUw?=
 =?utf-8?B?RWplNGptUjM5czE2dm9wZVpsTGVDRmJGS0V1cHdQVEMybjlCL0dES0ZVcFQ1?=
 =?utf-8?B?S01tNk8zYWxCV1RVektENWVPWmFtVThaWTM3ZUVUczJpb3dkR3ZOT1k0aHll?=
 =?utf-8?B?Um9uT1grMXhQd3dibHUzVTR2UzlnTUhxYTlJQmxpSk52N0todGtPK09hZE9x?=
 =?utf-8?B?aHFvbStzMDE3Z0tpYVo4RjYyaCtmNzZ1OXFIV2lYRXBuam5Cb1NpT0FORWV1?=
 =?utf-8?B?Uk1iVWtEZDZFWjFWemlIYnZSV3JtVE5qRHhHK0xsMjdERG9wSDk2OUhXNEwv?=
 =?utf-8?B?bkdBMjh4Mm1iTEtMVUQreDNJYUJaRDY0Vi9pRFdGWHpFM09ld01MRERXNFMv?=
 =?utf-8?B?cHRqSVh2MG9WUzBKZ2k5eVR5R25YWFRPWlU2MThVWmxuUjBhdFlEVWY3R1A5?=
 =?utf-8?B?V2d3WlcrUVU1Q2p2V3I4TDE5OEtnNWJRNHhacWFpUkNOSE9iTVh6MXRNLzhU?=
 =?utf-8?B?cWgxV2JKUnJYUnBmYlp3NVRaT0RvQkdYSlIxQXZnYU0yZldySm9nZWdqZml6?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72E3040DE2F91745B9A7A11BCA99E058@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07f2103-2a8c-4045-8621-08dc2d91dcf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2024 19:19:27.9942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jeu4zv9EgB566Q6sVXCQQfuSiiuQHy9q+5nCQJ0O4xs+mULsuY9OwkGJtJIoAMsQkZFWVKxscSXhLlzIEYWqgPZ71ZypKhiJ4Eosp+91+1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5956
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAyLTE0IGF0IDE5OjMyICswMTAwLCBQZXRyIFRlc2HFmcOtayB3cm90ZToN
Cj4gPiBXaGF0IHVzZSBjYXNlIG5lZWRzIHRvIGhhdmUgdGhlIHNhbmRib3ggYm90aCBwcm90ZWN0
ZWQgZnJvbSB0aGUNCj4gPiBrZXJuZWwNCj4gPiAodHJ1c3RlZCBvcGVyYXRpb25zKSBhbmQgbm9u
LXByaXZpbGVnZWQgKHRoZSBrZXJuZWwgcHJvdGVjdGVkIGZyb20NCj4gPiBpdA0KPiA+IHZpYSBD
UEwzKT8gSXQgc2VlbXMgbGlrZSBvcHBvc2l0ZSB0aGluZ3MuDQo+IA0KPiBJIHRoaW5rIEkgaGF2
ZSBtZW50aW9uZWQgb25lOiBwYXJzaW5nIGtleXMgZm9yIHRoZSB0cnVzdGVkIGtleXJpbmcuDQo+
IFRoZQ0KPiBwYXJzZXIgaXMgY29tcGxleCBlbm91Z2ggdG8gYmUgcG90ZW50aWFsbHkgYnVnZ3ks
IGJ1dCB0aGUgc2VjdXJpdHkNCj4gZm9sa3MgaGF2ZSBhbHJlYWR5IGRpc21pc3NlZCB0aGUgaWRl
YSB0byBydW4gaXQgYXMgYSB1c2VyIG1vZGUNCj4gaGVscGVyLg0KDQpBaCwgSSBkaWRuJ3QgcmVh
bGl6ZSB0aGUga2VybmVsIG5lZWRlZCB0byBiZSBwcm90ZWN0ZWQgZnJvbSB0aGUga2V5DQpwYXJz
aW5nIHBhcnQgYmVjYXVzZSB5b3UgY2FsbGVkIGl0IG91dCBhcyBhIHRydXN0ZWQgb3BlcmF0aW9u
LiBTbyBvbg0KdGhlIHByb3RlY3QtdGhlLWtlcm5lbC1zaWRlIGl0J3Mgc2ltaWxhciB0byB0aGUg
bWljcm9rZXJuZWwgc2VjdXJpdHkNCnJlYXNvbmluZy4NCg0KRGlkIEkgZ2V0IHRoZSBvdGhlciBw
YXJ0IHdyb25nIC0gdGhhdCB5b3Ugd2FudCB0byBwcm90ZWN0IHRoZSBzYW5kYm94DQpmcm9tIHRo
ZSByZXN0IG9mIGtlcm5lbCBhcyB3ZWxsPw0K

