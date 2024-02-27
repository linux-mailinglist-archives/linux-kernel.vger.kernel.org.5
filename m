Return-Path: <linux-kernel+bounces-83459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B778699BB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4684B1C22916
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FCD145B07;
	Tue, 27 Feb 2024 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELmuzgzb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0510514533E;
	Tue, 27 Feb 2024 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046054; cv=fail; b=JJH7nmGFWNgRHb9v0ZIa9MOd9Mb/u4kKcBdFoKaMU0o4HsAiqlcucdxa5QMWvlVfqZ+NFRMomGS9COxRtcM3Zi+NbECrN0otwZ50KN6VqiXj1WeamXdzeD51HIX7K7Cp19GsOVqprPVBrvkO3gnb/xwqA7Ki/yHVG+OkWtca3To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046054; c=relaxed/simple;
	bh=RaO181aJpDLW0Gx31CoopQlCEx26CfFWFo5NJgjOsvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WoggbIqnjcM/zPfWQwRRYPEiFH5bs6y2o2wUQQbqWi4EuuP2idCJQQxw4B4auv3vZC/M18SiziqaEEX1ZQOwLvwcJMZdJfR/DJ43negT1WmPtSjX4bmt1OGbFctZzam1Mq+n9bsW6rkPlYys2fWJaIrMyIxPsFsddPKwjxV/0no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ELmuzgzb; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709046053; x=1740582053;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RaO181aJpDLW0Gx31CoopQlCEx26CfFWFo5NJgjOsvU=;
  b=ELmuzgzb6hwst70ip9GmRusLgA9/JQqXOHxd10JbCts5lXoRrKdBrGSm
   npCchAA8JVIgujs6QKQtx/p1wBqp5cmXXAtLAPPPRvtb5rPk7H1w3Ms+6
   f1N+6Tv0rur7b/E6wI+rkSNyi0nlYLnwjLCXiahR919nsAKabwSvCG+6I
   duwslBSnaPHdIwpaEycw4ZfoIRg3PJ7boqNJWXYbHD2pa1dA9n/IsvxJf
   P7M7wqaBqiP7osMEgRIOQ25SvYwIla4q5wjEET1rhRTN/QD8A2VfqmK/J
   PAfE4l9uScPgxdB+mVE3sJQ1Cs3fjWCyUh9S+TBF5cEXaQsC8TuZSlCXF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3943870"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="3943870"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 07:00:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="7422398"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 07:00:51 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 07:00:49 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 07:00:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 07:00:49 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 07:00:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rhx5OCNPR5DqxxSiH7VWBzNuF5O6pnD3MB2KUGgC0DExHSLeoi2Jkj/ZXaa3qTe6YiKr302uW3MHUa182e++UMNnjFmWrcqoM7gy7OI34ezr8Z/0eKQQRSte0kF5tuSUO2HyaLjoJZztiFjt7opCetp61ZuVRqqbZdayps71wNjfGQkNSQ7ofgR34UX2v0a2INukggHhDhxjXqmY9sj9058qhJgDnYNTEWFdf49aF5y/Lg+C/U4K4nmcPGKsdPclohOzs7w/WscTkIGL7WE95hkFUTdS3gOVHDr+XMo4HrpV4CbsozCoHLt5JWUkwOOcCc8r++vPY97+1EIsxJ5sJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaO181aJpDLW0Gx31CoopQlCEx26CfFWFo5NJgjOsvU=;
 b=oB6xDuRHh4HS3S5/pWtZSHVFZu6TpC5JOQz4i4glpNeBH8tuc4w2bgD8k3Nf61nTkSREX6x5cJsCsioioBCDPJ+h657kERVZHFkrBOFmC/MrDocvsZ0t5poz+gZrmfK/FI+vIPlf9QMzuzGKOMWUQ8g1PAcN9sr5nP+DmvmE3CU7X6DI3Rr+lJnXshCncEI2NSlrJTGbDUMgbaE0DKwvp4hRvwhVMhzGB9MYsDN3hFFhTh4sDHM61oPeU1UhewCPSS38HpwtPBaXuuRKOiWjDx9Sd0GEZ6Z33tim4J4G/U2JKIpUy+lc3/nUzUYSDukuukb1UP13JNqlKIiXHsGNOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM4PR11MB7397.namprd11.prod.outlook.com (2603:10b6:8:103::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.23; Tue, 27 Feb
 2024 15:00:46 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b%5]) with mapi id 15.20.7339.022; Tue, 27 Feb 2024
 15:00:46 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "keescook@chromium.org" <keescook@chromium.org>, "luto@kernel.org"
	<luto@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "broonie@kernel.org" <broonie@kernel.org>
CC: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
	"linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>
Subject: Re: [PATCH v2 5/9] mm: Initialize struct vm_unmapped_area_info
Thread-Topic: [PATCH v2 5/9] mm: Initialize struct vm_unmapped_area_info
Thread-Index: AQHaaOdsOIuf9v8cz0SXVaOI9gIdJbEdxC+AgACFfgA=
Date: Tue, 27 Feb 2024 15:00:46 +0000
Message-ID: <ad24469275325b86ed316df36153fcdb2863454f.camel@intel.com>
References: <20240226190951.3240433-1-rick.p.edgecombe@intel.com>
	 <20240226190951.3240433-6-rick.p.edgecombe@intel.com>
	 <94a2b919-e03b-4ade-b13e-7774849dc02b@csgroup.eu>
In-Reply-To: <94a2b919-e03b-4ade-b13e-7774849dc02b@csgroup.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM4PR11MB7397:EE_
x-ms-office365-filtering-correlation-id: b0e66ae3-1da6-4204-2f5b-08dc37a4e0f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mn748FgbHOul6iHua64XtMugo+/W6AWuTL2ZmEvCn/32vRDqj+An2YUhXTj5Kd5XgKWfSIkBmW163vFa3DmgpDSX1lWxzXnp9rLmmMy3oTa4ueSz1SJauO+w5cUXVjApSuUEsI1BbBMZkTOqNR9ra6VV+GWu/xCgFV7hNhEg7iqzolFBCSt52ioV+fq0PkM7AY0YG1lfNFrwU8Y3myfAoWmZ1LIZyq8X95N0lq8e/IU5wLVoClym37DOUkspkNpLSuV2tEUoxhRXhgwEi4Fv9ln045T/p8yINSWhz9vt3hfDpSLpsJVc+b5v5ccbuOJe8YjiYb8v9F8gOHBG989W4XuV4VzuLGsiYBVvUdYEFR8w154ivNrxDmzFEKduyFdywrZ4ctwGLM023Yya3EOi2vd9tHqlWi9LihxbLthz0HrvwyQJ41P4p/t3X6p4b5Kz4WzOakooRIRrc1nSBp1xl7E/ZdZI3i93nfzDBJILjTRxiyeKizKhQYvYLcNz/AD6+1SdlUOlV4CmdFP/V4UhOGsNz+YYpjehUlLxsdNo08N7pT6GkdQlZt9LzoD5PRCnVkrMcPD3kK+NZ84HV92W35IzZnv80i9jtBL4Z9Yvqv/yszMOWOHoGwTeV2V6Nf+EMUUMddGl7TTWfbxNekvS3uMb/NLR777XfryrdAd1PYlXzS/D6tHAlHJ0/9EzOLdMVKegGl/h3CXOtQYQdytWwcJr17JEPTzE1J8hPQdi1nk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blNCZzN4eStxZVV5am1FdjN0Q1MvTVBFS0Z6aDZGOU11UXR4SmNjR1B5cXRy?=
 =?utf-8?B?OFEzcm9zbFJuWTZkMTlnRGV2ZHN3MG9MZURUdm5jTlZERlhIMDFmT2tvcERJ?=
 =?utf-8?B?aU5JRnB6LzBvZmZ6cVllOTgzRDg1K0VDYUYyZGlUaUhGZXNyaThiSFV1SWNm?=
 =?utf-8?B?U29QRDdxQ0Rib0F3dVA2d3FIMmFyT2M1ZS82UTZFRDE4S0FoTFNnS2d1RDBW?=
 =?utf-8?B?UU54Ky9VOEsrY3lqQ3FBQ1JlN2lXMHFvbnB3OUlvbTVIcGI2djB3d2YrRmo3?=
 =?utf-8?B?QnRYWXVHdDFUWUhlVmNsMk50cXgvTHV5cXZ4KzI4QzlQS01XTnV2N2Zlejcr?=
 =?utf-8?B?NFpwbVdzaURMVGQyWkJUMFVBSjRMZytnZEpzeThOSzdZTUhDUldpTS9hT09x?=
 =?utf-8?B?dU1meFFpVlY4MHRUZHJXUVM0QVk3MFNHR0hUTStyOUs4Mk1PZ2pmYTRpd3ZD?=
 =?utf-8?B?NjlMVnM5SEEzOVlGV0ZiTWJUazZ3WVBrMUozZHl0K2Q5amhOSmppenkwdEtN?=
 =?utf-8?B?Y1p0VjZBejhuRm9OaWxqaGZnU1RHZkZxajdaRk8rTUlka3AweFh0TjlzeE5G?=
 =?utf-8?B?QjlmMXpkU1VVMjRidDJ4L2dJdXFNdU1UT1l3YXNEaFBWWVVBQ0llNHozazF1?=
 =?utf-8?B?VVlHbnMrLzRkUTlUcGpNUWliMGZ3d21ERGFKZ1AvUDZXZjFhUFRURDRoNkhr?=
 =?utf-8?B?NzlaMTIyZTNZdFdKQmN6QWVJR3ZNVHVLV0pIQUpCR1JhbzliS0YzUnZVY25u?=
 =?utf-8?B?ckYrUmhsbUJIcVdlT0xWL0ZZcG9uK09wVzkraHJNaUlHZzhjaTY5Tm9rRXEy?=
 =?utf-8?B?byt3MXM0LzVaK1VvTitqVHpJcHNiYUkwTHRma1o0dEdXWXEzeUxxQjA1YWNJ?=
 =?utf-8?B?SnZUVlJsRmxIakJZVWpMdEpvTWRHOUU4QzVPZ1F5V2xGeTVFcmhsWEdoVHhJ?=
 =?utf-8?B?dDcvd2x4aStBTFN1RXBUZnhndW1jdGxHeG5qNHFENWw0N0ROeUVzRG9UTmJQ?=
 =?utf-8?B?a0txUVpkZ25CQzFiZ1VoaW0vMG45aDhBVUwrbkhuRXM4cjZhNFZnYmk1WUxk?=
 =?utf-8?B?NkpYV0V2MXZQeVh5Q2U3ZnN4QTdEOGZqUDVzc1FWQ2pQcDZDdGhXUU5icDNq?=
 =?utf-8?B?WnJzZ2hIVEIwZWdjdllJYXJhM215b2Vna2pDMUJvakNwb2NWeUQ0VGVHd1BB?=
 =?utf-8?B?dnAwNmJnMzZYZThSQnhIMUZndFRQSWtTdlJZK0lpWElQb2YrbTE0MFF0L3V6?=
 =?utf-8?B?RjRIUEhrakJvVW9tbGJsdlJPV0x1V2Yvd0JJaENSRHNkRnJVb3FISFJKYlk2?=
 =?utf-8?B?aXFpYVRmVm1SdUFLQVJodUtRV2Y3S09FRlh0UWNFczJPTWNWamU3NzJtYTVK?=
 =?utf-8?B?MDcwdXZzOEl6MCtkbWdwK2liYVQvdWlHbWlSd2RvbUtETVU5V1lhK3E5Mmph?=
 =?utf-8?B?cmpQSmFPUDRVeUhscGVLMjNJMlpGR0o1cGxqOWRURjRiVElNNTlTc2tad1hl?=
 =?utf-8?B?ZHUyVmpuQXVkb0VKUTFuOXZ6SDJnNWJIclJ2SExaSWdqVy9ZM1laUU9aSnBk?=
 =?utf-8?B?cEVwM3UvejFGT2I4MFp6TUFVSVA4c3RQNmwxOXNxc3hPNEhXZmxYZUJ1bE1p?=
 =?utf-8?B?TWJBOG1IS3IwZytONU8xOUhsYy91dHM1UUh6SXpERVhFYW1rbS9mVnV3cm12?=
 =?utf-8?B?UHlYNTMxSWxkZmExV0I4UGRsSmdCbGV2SG9UZFkxczNSS3BraVB0b2tPNnRx?=
 =?utf-8?B?OGJ5Rkh2QURHWUtBcnRZYnh6dkhhaTI5bW4zVTdNT2x6Z0FPSG9NeGQ5L2l1?=
 =?utf-8?B?eG5MWTBMNzVyVXFoVDJqZjFwNElRMGNGY2pPVExKM3dWN1p6eFdFbTRNOTY0?=
 =?utf-8?B?bjRoNU5mMlpib0dGK2ErT0xBTUJPV3FXNXVyZEd1ZlkrTGtMdk5ZbzRsNzBJ?=
 =?utf-8?B?OTF2ajh3bWlhSVpHSjNNaUFBTmMrbXdDTTBtMC9WRTdXS2pHRGRXZzN2R2tK?=
 =?utf-8?B?UUZkWVU0N2ZqWHVJeHZxV0VpWXVRZ3pDb2dpek9Zb2NveEUrK2c2eG9TWTB1?=
 =?utf-8?B?U241NWx5SW51MmdkMTc0RXZOYjA5OHc0bkV0bklSWTZSTjFKNFQ2ZUVhTE1J?=
 =?utf-8?B?bGZ4VzZHbWhneitlYjh0QlhlLzYySFF0Q2Z1WElVaks3Q0l1WHkwcWgvVVVI?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7382061C02003347A4536E29B25683C7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e66ae3-1da6-4204-2f5b-08dc37a4e0f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 15:00:46.8284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YXvuilbxmInYW6g2+xc0p3GXzLHwOPF9ZMYN3tJcDo/yeVM4+w48BtonVZlfjOnvxCCRB2x5fs9OSwqNhAeTMAvzaq+T/M2/Etj7M/QuabI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7397
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTAyLTI3IGF0IDA3OjAyICswMDAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3Rl
Og0KPiA+IEl0IGNvdWxkIGJlIHBvc3NpYmxlIHRvIGluaXRpYWxpemUgdGhlIG5ldyBmaWVsZCBm
b3IgZWFjaCBhcmNoIHRvDQo+ID4gMCwgYnV0DQo+ID4gaW5zdGVhZCBzaW1wbHkgaW5pYWxpemUg
dGhlIGZpZWxkIHdpdGggYSBDOTkgc3RydWN0IGluaWFsaXppbmcNCj4gPiBzeW50YXguDQo+IA0K
PiBXaHkgZG9pbmcgYSBmdWxsIGluaXQgb2YgdGhlIHN0cnVjdCB3aGVuIGFsbCBmaWVsZHMgYXJl
IHJlLXdyaXR0ZW4gYQ0KPiBmZXcgDQo+IGxpbmVzIGFmdGVyID8NCj4gDQo+IElmIEkgdGFrZSB0
aGUgZXhlbXBsZSBvZiBwb3dlcnBjIGZ1bmN0aW9uIHNsaWNlX2ZpbmRfYXJlYV9ib3R0b211cCgp
Og0KPiANCj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCB2bV91bm1hcHBlZF9hcmVhX2luZm8gaW5m
bzsNCj4gDQo+IMKgwqDCoMKgwqDCoMKgwqBpbmZvLmZsYWdzID0gMDsNCj4gwqDCoMKgwqDCoMKg
wqDCoGluZm8ubGVuZ3RoID0gbGVuOw0KPiDCoMKgwqDCoMKgwqDCoMKgaW5mby5hbGlnbl9tYXNr
ID0gUEFHRV9NQVNLICYgKCgxdWwgPDwgcHNoaWZ0KSAtIDEpOw0KPiDCoMKgwqDCoMKgwqDCoMKg
aW5mby5hbGlnbl9vZmZzZXQgPSAwOw0KPiANCj4gRm9yIG1lIGl0IGxvb2tzIGJldHRlciB0byBq
dXN0IGFkZDoNCj4gDQo+IMKgwqDCoMKgwqDCoMKgwqBpbmZvLm5ld19maWVsZCA9IDA7IC8qIG9y
IHdoYXRldmVyIHZhbHVlIGl0IG5lZWRzIHRvIGhhdmUgKi8NCg0KSGksDQoNClRoYW5rcyBmb3Ig
dGFraW5nIGEgbG9vay4gWWVzLCBJIGd1ZXNzIHRoYXQgc2hvdWxkIGhhdmUgc29tZQ0KanVzdGlm
aWNhdGlvbi4gSSB3YXMgdGhpbmtpbmcgb2YgdHdvIHJlYXNvbnM6DQoxLiBObyBmdXR1cmUgYWRk
aXRpb25zIG9mIG9wdGlvbmFsIHBhcmFtZXRlcnMgd291bGQgbmVlZCB0byBtYWtlIHRyZWUNCndp
ZGUgY2hhbmdlcyBsaWtlIHRoaXMuDQoyLiBUaGUgY2hhbmdlIGlzIGVhc2llciB0byByZXZpZXcg
YW5kIGdldCBjb3JyZWN0IGJlY2F1c2UgdGhlIG5lY2Vzc2FyeQ0KY29udGV4dCBpcyB3aXRoaW4g
YSBzaW5nbGUgbGluZS4gRm9yIGV4YW1wbGUsIGluIHRoYXQgZnVuY3Rpb24gc29tZSBvZg0KbWVt
YmVycyBhcmUgc2V0IHdpdGhpbiBhIHdoaWxlIGxvb3AuIFRoZSBwbGFjZSB5b3UgcG9pbnRlZCBz
ZWVtcyB0byBiZQ0KdGhlIGNvcnJlY3Qgb25lLCBidXQgYSBkaWZmIHRoYXQgaGFkIHRoZSBuZXcg
ZmllbGQgc2V0IGFmdGVyOg0KICAgaW5mby5oaWdoX2xpbWl0ID0gYWRkcjsNCi4uLndvdWxkIGxv
b2sgY29ycmVjdCB0b28sIGJ1dCBub3QgYmUuDQoNCldoYXQgaXMgdGhlIGNvbmNlcm4gd2l0aCBD
OTkgaW5pdGlhbGl6YXRpb24/IEZXSVcsIHRoZSBmdWxsIHNlcmllcyBhbHNvDQpyZW1vdmVzIGFu
IGluZGlyZWN0IGJyYW5jaCwgYW5kIHByb2JhYmx5IGlzIGEgbmV0IHdpbiBmb3IgcGVyZm9ybWFu
Y2UNCmluIHRoaXMgcGF0aC4NCg0K

