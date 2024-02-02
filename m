Return-Path: <linux-kernel+bounces-50438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B318478F8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11451F218CE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEE280622;
	Fri,  2 Feb 2024 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwQ0JqW+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FA915E5C3;
	Fri,  2 Feb 2024 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899482; cv=fail; b=uYCqsMQzoQDYPODgWwGThxUc/cQf2IRuQ1Ja/tl2Q9ZWDFHJfDW6ZT+V/ZDLcNlw4HMFl0mDxOXd1zGdKUAcPqnT5d/GGaSriXvXmyv++GaSFANihb5u7sZCagJxHMf9IthGNmrJLV+FffPgsWZ0o1ypbT9Ptk2qg0tk7utm7Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899482; c=relaxed/simple;
	bh=Ej5P54bTu/1sDs9w6iIuD/80eRyFN/PxZV0jXvPEBik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q+znb5IPTf0JRv+DmyhIuAGiPYh7EXllbt6vfFQw9JA5dcyRKJZh3Uyv2ONxMiLxLOHPNxnjXgVPwl5Y99A/qHQBZz82+PJheR9BzG4juEXhzOSPwyMzbnwgUZ8TKqg5ikULPCpOXNmyYVvhfjAEfIL2yOcSoYwksrR3sfMtZT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FwQ0JqW+; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706899478; x=1738435478;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ej5P54bTu/1sDs9w6iIuD/80eRyFN/PxZV0jXvPEBik=;
  b=FwQ0JqW+mjk9ZJY00ZOhJ7zmOOyH2n0MBiwt8uMCBC/Kf3qxcY0kWKJV
   IMhuQVlZMuuiXFs+0s9reedA66gjI/ZowjBdh+A1GmpKOF1mzZbmSytCd
   bedodPJb2i7lf2XouB0m9Jw5QT+FJDQ5gBXKwsBgI6XvUprMhPcWUb8xG
   KXhfMIBAA9joqT1ZCQb6WIShlnLas9uIB1fuaLeX03fqsGYHutvrkc5/O
   BLhbBkCZr9DqBuLJ0xbWoX5W+7PLnAVY1D7+9wtMDl6G5Ws0DZIw5e4OO
   O2p6lhXgpF7gYjhtpS5C5AAFLeTUMmXqr24DmYyZqQ/fEyjlSRr5NYixX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="17629187"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="17629187"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 10:44:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="139446"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 10:44:37 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 10:44:36 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 10:44:36 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 10:44:36 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 10:44:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPLpx0P6HrYbG1pvh4nt99rwpmCqgt13GjBZ4wCldyG9+NciqkU3JCpA+P2Fi0UZtb5dQnx4nJMUbgWkla86F9eIGGcKUxmk+CO6tYV5fCIGrx8JSB3qyLDodf6XjiH8dDb59c4gFGwvWu9oj34dAkNFLhdxe8V2QA4UfuurDNdxV3pIt2Gr3QyKlqUl4l17ltDw7XRcJgumDQqTka3N4sxr/C8Nl9/ykGsPd/UYOz6+R3mWD4njJ3bc8KbaklxbCte7SarWRVD6H7sGbLAcvC3k1sXULyCSg6DZkDKN1+S4hLdDfSoyav4cvdBJKzoz1nsmTNA2O9Ob2OwTRigREg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ej5P54bTu/1sDs9w6iIuD/80eRyFN/PxZV0jXvPEBik=;
 b=RuxGwXEDMwJmmymshfxz6wyz5J/tRUU9bx+0we/LQzXvCNHZUPN9GZmqP1K0bLLuFEZCz+5BIikBdKUbxZ9m6bMTrBxIt2c0Y5sQlxKy+p3cYEiRAkxqc9BELRxu5M/2qi/y458qcKFAQXL0PTLax9o4MqCkmx29RHpQAKDkZ4fAwBAtJ++5KeR9SRf81b0EM9PdWP7h0RYsCmVKteC+hmXUia2togD4go1lNQGkDoj40JPurnhSkZMC8bIap3VIX6Z/IVgr/MFkjpz/DQyH1T7QbFeG3ja/3QNsp9imWz8N6zrwdzbf1CKJ2wpQJd3JQvKi0ovLMM5nfZH0MPWgoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA1PR11MB7319.namprd11.prod.outlook.com (2603:10b6:208:425::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Fri, 2 Feb
 2024 18:44:33 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 18:44:33 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>, Tong Tiangen <tongtiangen@huawei.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "Naoya
 Horiguchi" <naoya.horiguchi@nec.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	Guohanjun <guohanjun@huawei.com>
Subject: RE: [PATCH -next v4 2/3] x86/mce: rename MCE_IN_KERNEL_COPYIN to
 MCE_IN_KERNEL_COPY_MC
Thread-Topic: [PATCH -next v4 2/3] x86/mce: rename MCE_IN_KERNEL_COPYIN to
 MCE_IN_KERNEL_COPY_MC
Thread-Index: AQHaVBOfhwOTM8ynF0GL5a5xXZOLP7D1XeaAgAAtgACAASWhAIAAYTmAgABUMXA=
Date: Fri, 2 Feb 2024 18:44:32 +0000
Message-ID: <SJ1PR11MB6083A60DE19FBFB1B0CA6B3DFC422@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240111135548.3207437-1-tongtiangen@huawei.com>
 <20240111135548.3207437-3-tongtiangen@huawei.com>
 <20240131070258.GGZbnwov0g918F-FGz@fat_crate.local>
 <3009aadd-69d6-c797-20b4-95cf926b6dd9@huawei.com>
 <20240201142016.GFZbuooG9CRoK90U2C@fat_crate.local>
 <39c1e4d2-b1d0-91ae-595e-1add4698dd7f@huawei.com>
 <20240202133911.GBZbzwf-M37M-J3EJX@fat_crate.local>
In-Reply-To: <20240202133911.GBZbzwf-M37M-J3EJX@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA1PR11MB7319:EE_
x-ms-office365-filtering-correlation-id: eef1fae3-5b2f-4403-5aaf-08dc241eff33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k+mCxvdUrKZ/gFPwcUd1vd/q8ghIpDsJs0mivugrDSOlKQ4fqg789WYmP0PMojuu1YZW6bYvWa2rDG+RActR2Fsf1u7ZFvMOX5BaqEF8xkYqFrLqCL97Ig02hTA7NjVC7Y9Ye1wiI4vb5al59fDTT8dBmzWgemzl+cxwkkOLUIHehMt9tbW9CLCwAisFfGqHpygQFnZeQu6ep77aHUM0gQvUk1+Q+bx/h3UC45SjV2BuOJ5kVhKjrp8kl1Dl4Dt6Ojb7omO+2jeeY6fm07uYVJQvnSQtxn8h1mH42wf0nK/r33KToVWnLhE+emPCMGk/mqkOOUlcyT2oTTqp5rBQjKuyuEWsjSmweeNMBx7PmFJ1S0cI9iGy5N2Lf2iDHFrX1Q3c9ofiVC5JNW9uKcfciBuW485/Qc0YWbNA4u7WNTkkfHZIeWgciZeRgm//bqP1mLazL5e5EvyFhq2brmOYIzYaEdTT7qMbBupLezKQHJwLLsuXLgzjVlFXCbmOlP76Rt6sInZxUV5e7sUQlCJmhy1quK8EH8dhLWGUQIEkkX4iOe/g/rY4XxQ/RRY5tENxAHLYBNooZetT+ZfZ9abuBa0UcbWSdEz6f1d+OCjVksU9Dp5TC6OgAzXpCzGzMKpe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(478600001)(66946007)(66446008)(2906002)(52536014)(4326008)(8676002)(76116006)(7416002)(4744005)(8936002)(33656002)(86362001)(110136005)(5660300002)(316002)(38100700002)(64756008)(6506007)(38070700009)(66476007)(54906003)(66556008)(82960400001)(83380400001)(122000001)(7696005)(9686003)(71200400001)(26005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXJhcmM5ejQwUy8yWm9RTmlVVitLWW5tSzhTbU1KcVlHVFhURzNxNm1SYzJq?=
 =?utf-8?B?WkVSdjNpWXlTeE9Rc2hrNy95WTBlc01hZVk3ZytrME5mVGNBdk43R2x3MXg3?=
 =?utf-8?B?UXozNHNXU24wZkY5SkNyMTFQVk5DMDVVbzNXQ2Nza0V6NW5Yb0pveEFKdWNM?=
 =?utf-8?B?dlZFeXFwUzJTZS92blZhSmJhcnRYLzRXQ0JSTmRrYW9jQTAzcG1XNjAydmNl?=
 =?utf-8?B?M0FKYnZBbFhpQUx1eHZBZk1Hd2JNUnB0cXdBYU5FQWhhOG1MMWIrekw5Zk1o?=
 =?utf-8?B?UVpEaGhIMXhWbEp0dFNnZFhXdmFwNmtIQkkyZ2ZiR3hTQlFiR3NWOTNza2RE?=
 =?utf-8?B?TUlac3FBTGNhcHRsam15WERBamYxQ0Y0YmRvTUZyM3oyUXF4SlZqekxRV0tE?=
 =?utf-8?B?U2tiSWtBbVBFbmdzWlFGb0pXbXBhZWRxaWF3R3ZzT2VkQnlFNE03WWluR1hP?=
 =?utf-8?B?eWRhL3l2c3psdUZIWEwxQldBdlNyU2hkbkErQ0VWSXZ3SVRNc1NYWFlDMXhn?=
 =?utf-8?B?MFRyYXBONDJ3OU05QlFzUjJMaTZWc2hubUNFM0JkK1MrTldvUm1EWjJ5bDBX?=
 =?utf-8?B?Y0syQWxWNDNudzI4Sk1jdGZ0L3dsVkE5KzhnQW5nTy9NQzhHOGc0MkRjQmtM?=
 =?utf-8?B?REdXNGVTSUR2ZXd5R2tPcWNBR00rVmRqaVNwUDFZRm82eXFOOHFXYlhJMHhD?=
 =?utf-8?B?Q2ZSZWFSOFdoQ2V3WURLYTVHaVhxS0VUbFU0TjBRckdDL2N3VjIxK01YR201?=
 =?utf-8?B?VURhUkUreSt5U1VOWnoxa2Y0VnNWTllmVEREc2FIclhRV09tUUxyeW5kQXZi?=
 =?utf-8?B?TTNJc2RNb3hremszL00rV1VqRTNtN3hLb0ZmdHJkTGNhcmVrK1FBd0JWdmVI?=
 =?utf-8?B?ZEovdmtEVTVrWjlpUkdIc0k2eDJMb0NxKy9pMnBmazF2N2ZSR0NYb2lQbzBm?=
 =?utf-8?B?bFVkZnpjSHlEQW1qalFnUVlGYmI2b2t6TmszQlZKN2ZDMjNJRmxtTkFhZ1Zh?=
 =?utf-8?B?eUoyaWdmQk5FckkrYmFubkNEanJpcFRHVWRGT2RQeEk1d1VMV3hHTjB2ZDBj?=
 =?utf-8?B?RWxUMVZwbTc4dHNhREhPZUxVSUY3WldPYVBXbU5FSTJibUdJUXpuVUJqaGZi?=
 =?utf-8?B?QWlWNFBEdjdrQTVvRGdnR0ptU3dzUHdaTEl0alJVMFNBUGZWSDJLZFYwSElV?=
 =?utf-8?B?R0VvcWNLaDlyMkMzanNyMFJVM0p3R08xcmVkSndrOXZjTFMxOXVZQ3pUemJS?=
 =?utf-8?B?OHBTdFhDcHpNN3ZMVDhLaXU4MnN6NDdjRngzTU92VlN0UGdDdFZJNmJURkVY?=
 =?utf-8?B?N1ZuRkx0UDhORncwTWJOUXZyOE1OU3lud1FBcUJVVDBqYnJzRUQwWW5GUXhL?=
 =?utf-8?B?SVphOEF6dkhxT0xHNS9DMWtTZkdBN05WREJGeStvZzRqK1Q4QkxQa2EzV3Ix?=
 =?utf-8?B?cWNWR0VTVDhVYWd6aUJnL3dJQmVvSURKdzR2RGhiMk1mZm9WZlcxdlYxQmdK?=
 =?utf-8?B?aGpNUmJpQU5TUkFSdWNnZGVNRVcvVVcxNVoyczI5QVVkMmlTQXJvMU00bFV4?=
 =?utf-8?B?T0NCdVBkaVZVTnV2S0JRbGFBUlZiNjhWbkxtcXVXZkR3V3FySWpkR3RPTEdB?=
 =?utf-8?B?UTlpYklFQVFhcEtyUWEwTy9SekVPMjhsUmpSNFJFOUFwOHBHeWtCeU11cVRF?=
 =?utf-8?B?ajlMbWUxU21SRGY0NmhRdEFiR3cxdGQvSDhxRTAvbkp4VHhGTVNGK29wWGdU?=
 =?utf-8?B?UTVkeTJTbkVLVjlHaGNNVkx4bjd6dm03K3RnL2NuZDhjVHVjNmVITVhORWVj?=
 =?utf-8?B?MExQS3JFWXRyT1JwRFAyb0Z3SFQ2M0doS1Vaais3OGZhRzZxdk95MUZWSFhJ?=
 =?utf-8?B?MHZySlA2aHZwTmFPSFJDUUFiVXpINXJ0VlI1U3hCZExjWlZXY2Nhc2d5Smpx?=
 =?utf-8?B?OVBTV2hkbzRncFBSbnhxZCtNSEdnZ2pZUDlEaTdXMlZTdWJKaTJ0b0FsY0NK?=
 =?utf-8?B?MkRIZmFRK2s1WEVzdlRZOXNSVm9XdDlwQk9QK0t5cW9FYU1uZjgxUkZqL2xv?=
 =?utf-8?B?N0hIeTlEbXJncFVML2NuckhqdUgwWDRINGlwTFZJTFFYNE5icWhHOU02R3BW?=
 =?utf-8?Q?iaWM3g1anFCfTYIcHAz2IWNeT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eef1fae3-5b2f-4403-5aaf-08dc241eff33
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 18:44:32.8706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/+PoIy3At9mJ+TD/V7MXpFKVw0BdP5PD61GbvXXqFTE9euxSroZPgJmyKQr+lYzqoxT8xlOLD3yxlYyyCM5TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7319
X-OriginatorOrg: intel.com

PiBTbyB5b3UgaGF2ZSwgZm9yIGV4YW1wbGU6DQo+DQo+ICB1bnNpZ25lZCBsb25nIF9fbXVzdF9j
aGVjayBjb3B5X21jX3RvX2tlcm5lbCh2b2lkICpkc3QsIGNvbnN0IHZvaWQgKnNyYywgdW5zaWdu
ZWQgbGVuKQ0KPg0KPiBOb3cgaW1hZ2luZSB5b3UgZ2V0IGEgTUNFIGZvciAqZHN0IHdoaWNoIGlz
IHNvbWUga2VybmVsIHBhZ2Ugd2hpY2gNCj4gY2Fubm90IGJlIHBvaXNvbmVkOiBkaXJlY3QgbWFw
LCBrZXJuZWwgdGV4dCwgYW5kIHNvIG9uLg0KDQpBdCBsZWFzdCBvbiBJbnRlbCB5b3UgY2FuIG9u
bHkgZ2V0IGEgbWFjaGluZSBjaGVjayBmb3Igb3BlcmF0aW9uIG9uIHBvaXNvbiBkYXRhIExPQUQu
DQpOb3QgZm9yIGEgU1RPUkUuIEkgYmVsaWV2ZSB0aGF0IGlzIGdlbmVyYWxseSB0cnVlIC0gb3Ro
ZXIgYXJjaGVzIHRvIGNvbmZpcm0uDQoNClNvIHRoZXJlIGNhbid0IG1lIGEgbWFjaGluZSBjaGVj
ayBvbiAiKmRzdCIuDQoNCi1Ub255DQo=

