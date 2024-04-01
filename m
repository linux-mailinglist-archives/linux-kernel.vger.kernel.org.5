Return-Path: <linux-kernel+bounces-126884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5049B8942F2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000B328374C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6964C4D108;
	Mon,  1 Apr 2024 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHp/RCnS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD41487BC;
	Mon,  1 Apr 2024 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990665; cv=fail; b=sLcXR1d5yMS4/1QfK+0W3755yS9lvj++UmfwbXXPPV28oMIvO5CwmzPM+2YSBKfIRkkqbqBZRDpJAZOGWycvbqKKhru0JYLrvnRBcV3P/lX21somZ3hG3bsqt3IlbKpwOE6MUU09fuLjSKZOn68eKy56piRsahvoKXlUbAGXsrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990665; c=relaxed/simple;
	bh=a702SssXQ/FTdJU4yVp2ADGsa7Z9qQcd1JSSOPAmZB8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ghzQ1zOxGJjUXTqJyVgJ6/T/RWjfyhIhBEnaEBEfN6MgGGCBkJgM/+jO5fEs0w5i1sZfjigezcHJN54jKlDrJdhfc6337I7FD8EaQRZVZd0Y3yuleVNDZ2b9u1P/xVaAnNU8+kxN+KuitrMvEpdvBVRAJf45g/eECcedMRiEUc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHp/RCnS; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711990663; x=1743526663;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a702SssXQ/FTdJU4yVp2ADGsa7Z9qQcd1JSSOPAmZB8=;
  b=UHp/RCnS8Mlq3vOqe0/MaUqi+zfpPDbLHSyuygyOQ7AgxK5fzeS90GQd
   KJudSHO3qww6yQilU7F1Ud/hVOh9BWLm3PIV4CVxqOdn8l/tX/eg9h10X
   Vtuor27LfWl8eYuUNveE+AMdf5GoDOqJC8xeA/6Yg1K0VAzgMeh01gFvS
   vpYTLkU036Kp4262PhYlBDrhrlfnm8Q84bASklHe+tW7F35EN5bM3rHsv
   PDlFdEKN0a42ZEsKWlmOJRfkoWuIOWjZD9S9xUj/DiSHhNZqOsibr3ldY
   2o0vfNkg4MbXcUXc7i2rInReKjd6EV0X2Ctr7iwZmPiVvtcpoKMnBjdxZ
   g==;
X-CSE-ConnectionGUID: PMVv1tlSSseIqfN5iqznVA==
X-CSE-MsgGUID: jebnq1/NQHiasCHSpW0X5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7336874"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="7336874"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 09:57:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="17809480"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 09:57:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 09:57:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 09:57:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 09:57:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkQO+VbZucTYRAlb6Qbwy0H4PWU8ItottPU65RNcw74K4oQ+94bTLsJtGgJJlsCaChfzn33R6wwKhXVuyeMWkumIN6vl4ZVdCqQud72L5wkIfz02I71PBZKZydcUIn6G8jIeCU9RdJX0CDBeEYiU7v+DDIsXhTWaNZNDd54AMyx8QIOguVtXtdexUClBFsWwLsUww443ZZxbKcoeStH+RjcyGYHLozFwhL1N4Cbgi8PsKx7g7flTML4OiFUkx0AGKtRhV0N8bcYm6CsOloNS3KRq1jOnn3q6DYstNpsKrfAgdv6Y+gARs+z8OpMkbpYRPbOAl9/1IfYqTiIQW5JOZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a702SssXQ/FTdJU4yVp2ADGsa7Z9qQcd1JSSOPAmZB8=;
 b=MMr2XhF+7EJ1PTp4z84Y2+lXva9lTGz8UEoSJU/oB1OZKfT5BLPOfgENdEG4pe+ay/P42VMA3ALO3EpFqOBXFggyPcb2KdE4SB3ZpdL9MqJnJ6mqoQqDD0McPYndEZvwWd8vVmCXE3i+SIqkUNyzJQpn/x+PaEFuPp2bdT6uWP8izmrUVQtbibfHtf/DKmljaVPQ6BMPfQrX/6bhz8y7XieywvltG5+qFSeir7kw8FqmWfijVYL5u8mH7lfjESHAxBJwaUqnhNbDy/SDGpOV1NEbvzIg6AKG1T1FUqZl6fqTzdR+TWuIE2KRgJj7AbZJZgbcSEykGo8bxq/ibeftVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH8PR11MB8288.namprd11.prod.outlook.com (2603:10b6:510:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Mon, 1 Apr
 2024 16:57:30 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7452.019; Mon, 1 Apr 2024
 16:57:30 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Haibo Xu <xiaobo55x@gmail.com>, Sunil V L <sunilvl@ventanamicro.com>
CC: "Xu, Haibo1" <haibo1.xu@intel.com>, "ajones@ventanamicro.com"
	<ajones@ventanamicro.com>, Paul Walmsley <paul.walmsley@sifive.com>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, "Moore, Robert"
	<robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>, Guo Ren
	<guoren@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, Greentime Hu
	<greentime.hu@sifive.com>, Charlie Jenkins <charlie@rivosinc.com>, "Sami
 Tolvanen" <samitolvanen@google.com>, Zong Li <zong.li@sifive.com>, "Jisheng
 Zhang" <jszhang@kernel.org>, Baoquan He <bhe@redhat.com>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Chen Jiahao <chenjiahao16@huawei.com>, "Arnd
 Bergmann" <arnd@arndb.de>, James Morse <james.morse@arm.com>, "Russell King
 (Oracle)" <rmk+kernel@armlinux.org.uk>, Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>, Marc Zyngier <maz@kernel.org>,
	Anup Patel <apatel@ventanamicro.com>, Ard Biesheuvel <ardb@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>, "Schofield, Alison"
	<alison.schofield@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>
Subject: RE: [PATCH v2 6/6] ACPI: RISCV: Enable ACPI based NUMA
Thread-Topic: [PATCH v2 6/6] ACPI: RISCV: Enable ACPI based NUMA
Thread-Index: AQHacGqJQBWRJiNhuUyCbQKEpDrv+bFTKNEAgAAMuICAAJRPQA==
Date: Mon, 1 Apr 2024 16:57:30 +0000
Message-ID: <SJ1PR11MB6083B43290D216B1568642B0FC3F2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1709780590.git.haibo1.xu@intel.com>
 <01cb5780041565784d459cd94a5c4f55eaa87739.1709780590.git.haibo1.xu@intel.com>
 <Zgpf0rqUSEZcSiAV@sunil-laptop>
 <CAJve8om9-cTtYKLmB0R=6Wwh5KQ9z+16AFR-tuUkJhJjbn0UEA@mail.gmail.com>
In-Reply-To: <CAJve8om9-cTtYKLmB0R=6Wwh5KQ9z+16AFR-tuUkJhJjbn0UEA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH8PR11MB8288:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 72tV3NX2AD6uemawyj46pdW1evTCN5oa4DOOosr/qu2meGUQB/nUQ5YXhDIEYX8XVGO+bX9+MaomugAF0o9Vf5gKrFcPjS+nLJsFgJIQsrEKbNMMZusEsP07X+DQ5mw8HCqBn1ZWUotc4Wxz0Pr0ozxLI7K7n73CQ4NaA2oh1l/qmYhN/Wy9/WNHURwWsYI/qUKjgyn6wzzLcMRELEJRp5jP7Wt1P4QOJz88QhR0gh6QpWOEQiLD9cAvt+4Fd1HlRm61kUSaI8dK6pItqSTjMop18OTPes1RfRNC/Q/vYBHi4NyLMExrvHf4CNZ+GO58qRRXYiEMo7BQ+8DTgsYR6rTcOOcGhT86AJ5gK2hvw0kW+aIN4dBWbssrz3EYCNMydZjVYJDwOF+yj4XVIQLrW9VpNwhWzCe5ZE4cQNpmxW6W/EniPr6wn3BHhQSL1bS1z5ckGqQyL/NKxsadae88ku2bKZjHv/A30dLulbOzzG5KPkLdV8+KiGvJDHV/KDGuong+qn86lKCCQeBom/DUfwxops78Ufl6tKAc6d8dL1SIOk07BxkAtp/KHk4ctigzegvX9cTWwAPAc9Y7VZdoCL4/K/O7/wH32rVt7HKt8q2lGvPdyJFaDChgN/MuhB7VLNjgViRB9ytU7hrCbKTlC/aBVBO+feFsQG7sfcWEcsQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmdISzBNYUpWTXoxbjlkc1B6UTlCQVVVV3I4MG9RYWpQbWpPempwbWpudUJN?=
 =?utf-8?B?UGZTZk5uU1hXZFVUOUdadzBwTzRDNkF5VW4wTXlZVlJPbmdwQ05WZERpWTYv?=
 =?utf-8?B?eGZFYk5oZmIvbFJYRTdMdWYxQldnUkZ3bzkzc0xmUHJOQ0UwVzZzd2U0QVdQ?=
 =?utf-8?B?SkZ5N29LN1R2TDVUN2lPZ2dlMUUvQnUxNmplbEFwWkdQMjRFY2NUQnJKOUJX?=
 =?utf-8?B?WVZnSkhXRjZ3emhOemhhZUovYWxIZzJzWUZNNEVaY3Fqb1Jrb0NEV3VoMDlT?=
 =?utf-8?B?YU1pVHFwQjg1ZHNVdkUyK0J4ejN4L1dWaWM4TlJaQ1NXYnUrTXoyeER5VjRV?=
 =?utf-8?B?bzFUS0FjSnFRVEEwdFhMaHRBVHhWNStMUjNMZTNaTktaMWFNbmtuR0pEbUV5?=
 =?utf-8?B?QWM5KzVEdUZTdnRVYVVsb0docnRZN0V2WEFtWWVXMFp6eFo4c0wwZWdBQlMv?=
 =?utf-8?B?aEYwM00xMzhEKzY4ZXkrVTl1U1BjU3NDYm9sQ21nU2RoVGE4Z05zS3ZvUXIy?=
 =?utf-8?B?ZklKeHVuV0VFNTZLRjR4NS9xNGh2aXozVTAxOVlpbkFDNjM2d2xjdC9qNldU?=
 =?utf-8?B?QlVOK2F4bXpPN1Q1bkFlTHNkZnNUVFpMNHpIZ2I4SC9QQjVXUmZtWXZNRmdi?=
 =?utf-8?B?WVdNcXhvRHpFSUo4M2Jxak1RandmR251dVhUcXd6MmRBRklaN0l5cHFDSlVm?=
 =?utf-8?B?Z3RBRjVOejR0T0xFVVBlUVF6Qm5qWGpMNCs3NmtoTGJhVkNaaCtsYzFDVng4?=
 =?utf-8?B?a0dqcFZNME1XeWVBdzRuZjVnUTlZMmR4SkVYdnVPdERzbWx5OFF1NnhxWmh5?=
 =?utf-8?B?TFZkQVhLazNQK1dlSHEyQ09lWmdGdUIzT0YwK0ZsWVlVeWRKblpZME41T29a?=
 =?utf-8?B?RVR3SkZJcTV2V09VcDRoMmtqK0UvaFROVE5XMUVyZDE5eXZhMFpWSC8rcHVC?=
 =?utf-8?B?VDBvUmM4RkJsOEV5RC9iajNsamM3Nm1zUGN5ZTRqak5zemhzOElVQWhUUUsy?=
 =?utf-8?B?VmQyMmJZNkozK2hLcjRoUzRSVlYzVTM3YVRtMjVtYW9obzFQN3BrTzdyK01J?=
 =?utf-8?B?TCthbEV2K2ZjNTkwSWtFM3lwRUFwVkZJeVhBc0s4MXJtbEZ1eHEyVjB3N0ZY?=
 =?utf-8?B?T2VoMmluSXF4TnM1U2FjWi9nWGk3a2ZRdFpscXFML3ZwYXNacUw5YUVBNUg2?=
 =?utf-8?B?RTJETVdHdXhtV0o1b0NnQTh5MHN3eDMxeUZoNTkzbUxJTk8rdjZlNmxOZmt3?=
 =?utf-8?B?MDVLb1A3TGFKVUM2VmRseHJPV01xWUtaMjFOSTRXQmxZKzFoNkkxNVlpYSsw?=
 =?utf-8?B?QVlCYVZFRnFjY3FMaEI5dG9ob3Y2QUtMVHRuMXBnYjAzOWFZa0tlV3p1RFF6?=
 =?utf-8?B?d2owdC9sR0drclYrZEdycFNRVTdSZVB2UkFUdTQxODNYbk5IM1dKaUY3cXVK?=
 =?utf-8?B?SExlVFpYd0VDc0EyM2ZsY29KSWN2UDFydnZad1NSNUVTcFh4NzUwTkI4TGwr?=
 =?utf-8?B?QjJmbmo5RFBiaFhoYmQ5Tm1RNTNRdFlpeHFCb0d4SXpCU1FyazhJTTJhQlA4?=
 =?utf-8?B?Sk5uTzhiTEN3YktLSFJabUc1Q2xzYWJvM3YvMGNudTQ3am8rZXdoaXlqWnZK?=
 =?utf-8?B?NTVuaEsrdGhoRzFtTWg5alJZUUR4d0E2aFBwQUk0bDRUSFp1T2RxQ3BiOHlM?=
 =?utf-8?B?eENuU2xRWitjTU5UU1RDWFZXOUVGZ3FSTVVGRENaMGtwWEhuM1JPVnhsNHpP?=
 =?utf-8?B?T2ZSREs0MmJlSEthazFwTHBtSVAxVVUxRURHRkZUMmI0OWVrVW9ZTTVEOWdN?=
 =?utf-8?B?SzdjamVWaU85bCtHQmNxMzdSakpyS0Z0N0l3WEI0K0oyMFQvYm1Xc3dQcWd3?=
 =?utf-8?B?c0ZvY1pjZjd2T3lMckZmMVhsbTd6QUJ6TmlPR2VpV2NLQmhtMkxGVDNha1E3?=
 =?utf-8?B?bzRBYXZlL0locmlEMVA5djNUWWNwV3Qva3g4dFFnblVDaDhlNm5RSmNFNEoy?=
 =?utf-8?B?U243MFR5S0hrUS9yMnE1NzJmZXcrRWRtZ1poRnhtVWZXV2pjam5JVkRiSXNL?=
 =?utf-8?B?WTlTK0xZazljaHl2TFY1Z0R3b3JzRVlFU1dheVVhVGNtc0hhZ2dqN1FuZzA1?=
 =?utf-8?Q?Md0UN1yAZkGdn/xgUUborpjyW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0beb6b21-fe4e-47a5-719f-08dc526cd196
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 16:57:30.5652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bLj7dv8lVCdkizGlF6VPNH8T77E9G+ea1UJ2bTKdfJ7P5EY05qdZ6ZhXbGIhqr3ocByQ/q8h8Wj1ZawlIc3e+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8288
X-OriginatorOrg: intel.com

Pj4gSWYgdGhlIGZpcm13YXJlIGRpZG4ndCBwcm92aWRlIHRoZSBTUkFUL1NMSVQgb24gQUNQSSBi
YXNlZCBzeXN0ZW1zLCB0aGVuDQo+PiB0aGVyZSB3aWxsIGJlIGEgbWVzc2FnZSAiRmFpbGVkIHRv
IGluaXRpYWxpc2UgZnJvbSBmaXJtd2FyZSIgZnJvbQ0KPj4gYXJjaF9hY3BpX251bWFfaW5pdCgp
LiBUaGlzIGlzIG5vdCBzcGVjaWZpYyB0byBSSVNDLVYuIEJ1dCBJIGFtDQo+PiB3b25kZXJpbmcg
d2h5IHNob3VsZCBpdCBiZSBwcl9pbmZvIGluc3RlYWQgb2YgcHJfZGVidWcuDQo+Pg0KPg0KPiBN
eSB1bmRlcnN0YW5kaW5nIGlzIG1heWJlIGl0IGp1c3Qgd2FudHMgdG8gZXhwb3NlIGV4cGxpY2l0
IGxvZ3MgdG8NCj4gYXZvaWQgYW55IHBvdGVudGlhbCBidWdzIGZyb20gRlcgb3IgS2VybmVsLg0K
DQpUaGVyZSBhcmUgbG90cyBvZiBBQ1BJIGVuYWJsZWQgc3lzdGVtcyB0aGF0IGFyZW4ndCBOVU1B
IChzaW5nbGUNCnNvY2tldCBzZXJ2ZXJzLCBkZXNrdG9wcywgbGFwdG9wcykuIE1ha2luZyB0aGlz
ICJwcl9pbmZvKCkiIHdvdWxkIGp1c3QNCmFkZCBub2lzZSB0byB0aGUgYm9vdCBvbiBhbGwgb2Yg
dGhvc2UuDQoNCi1Ub255DQo=

