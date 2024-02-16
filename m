Return-Path: <linux-kernel+bounces-69400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BF4858872
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7077B23878
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF62B12FF9B;
	Fri, 16 Feb 2024 22:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NyobAI21"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FED7131750
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 22:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122078; cv=fail; b=u1z2taORnaBIgnaw2QYfHUOC1tiC5CdcHisIxXlqOnWaVspvk4vZzZzJCY6bPKWPoeHIiVreRS720M9ssoz4fF1OvNaNQWjc/Wx14EZ7OVjeb0NQAjIgNLydGHqTdT9uqIwcIVQGlq0YfY89e0B9DQU6Ihhod4zgmhR5d6J+j5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122078; c=relaxed/simple;
	bh=6ypEpfEcwu20t1NkzUFtT28+QlxW9hkuCvJl/UZEIeM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gqVPR3W7UGxQhvp6k5g+5tFrw0fuyJHU3jVbDlragHzocThU2OTawU0A1QGENVbW92kfoTYm+8vGXsCe3s0ztqL3hWINduaJkeo6EjxakEoI+JP5HInNM6Lgq9v4RJm4x5+/lH/8S89IBrNGrMcZBrcynhtrBRkaJnIS7FaKEs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NyobAI21; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708122077; x=1739658077;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6ypEpfEcwu20t1NkzUFtT28+QlxW9hkuCvJl/UZEIeM=;
  b=NyobAI21IYPE+bVfvXEqZQ0ykBU/vpIb1u0EJhd4lRe8J7cHh4dncglH
   8pMGTQ2FO4dII62trXz/XyscaFejHsBN+V3TxZsp7VIm0UZw8rgMHN0jN
   WCN0g6MDqRtgRcReDWdNi0AHFxpgUB4/SRfI8XOlTaNBcyordD6k+AS2s
   k33g7N/KsprESTHhW0GH1PnMWrTr2eBqeRdaobIJiVcn/4mxxWhKk/5f6
   rC0nxMS7YzOhhSytGRsDZ3aAXY/dyE4BFP+l+P3l/CEDFPGl7iKrXBYBp
   18lD8gZnR3o/i0fWdBdGpEluoqZtbVr0MLyhEHnPGQZtTaYj52RmE37Kw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="12892833"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="12892833"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 14:21:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="34995019"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 14:21:16 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 14:21:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 14:21:15 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 14:21:15 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 14:21:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpOajljO743FNsZgziGUunS9TVKoI41q0ZJqjsAzN8Yh+PRSLPHJ4MkGdLS9ZiW/y5mESSluthOTANqlR60dOWxGEF4l3CNsgmZ7tsIJXsV9N1qxFNLm5/uRMQ37XeMGwXR4mi9myAwWoEgRQOIBEMbJi3VuDmOyD+zjWo9hkcemYv/qysCqaOhzbE2dp5f0pI32nEhxbhU69y+3kf+kPkv3J54kaU8p5Vtmh99zt4jaU4R6yiMu4LshUk8pwtBO2VKEREsIA23FX4ay1wbbtz/MJsUaHvXKW5dTHaGRgSQpLZVeZ2t7N2QtLGVJlxepcnlNctMb7+p5YrtbJB9wxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ypEpfEcwu20t1NkzUFtT28+QlxW9hkuCvJl/UZEIeM=;
 b=MM428jQD5/mBYS26+jlUfR1oD47u54K8573VaCJEVT3LduAcOLvaGyjR8qOWlT3eaLJoJMUNajPn8fjMjJgJRnfQFQTHMS1mLSDVZp4641ZMnQHpmu3T3AfpEeWgYwXjNkbkZgJ0hxAfDwTZ/ZTBgurSbA+wk/KxGO+8lcsJcURaWQayucMiZC2eCVS0afDZOtp7Y1kUQq2U42F7UpuhaqpxGvjVhUZH9JXdlp3/FbxUO1MYZGvL2rHDUzDQmdanKtf/1uQMrXpq2KxJrrhFyfB+aljorkT99QoCcQzhdbKd5X8rJmt6JbEr92fMKv2kpliINJi+EKo31wVwyn2zIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CO1PR11MB5202.namprd11.prod.outlook.com (2603:10b6:303:97::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Fri, 16 Feb
 2024 22:21:13 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 22:21:13 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "debug@rivosinc.com" <debug@rivosinc.com>, "luto@kernel.org"
	<luto@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "keescook@chromium.org" <keescook@chromium.org>,
	"bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 4/8] thp: Add thp_get_unmapped_area_vmflags()
Thread-Topic: [RFC PATCH 4/8] thp: Add thp_get_unmapped_area_vmflags()
Thread-Index: AQHaYGTF8QWdhWktO0SgshFdj34DmLEM70oAgACc0QA=
Date: Fri, 16 Feb 2024 22:21:13 +0000
Message-ID: <cbc567bd38931a1fba6009c97ec935fabe15a01a.camel@intel.com>
References: <20240215231332.1556787-1-rick.p.edgecombe@intel.com>
	 <20240215231332.1556787-5-rick.p.edgecombe@intel.com>
	 <bfvjvaeuan5ojbfleq425lajj4vfgcomgubksqpxlvqdo2g5o3@44nolzrcuea2>
In-Reply-To: <bfvjvaeuan5ojbfleq425lajj4vfgcomgubksqpxlvqdo2g5o3@44nolzrcuea2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CO1PR11MB5202:EE_
x-ms-office365-filtering-correlation-id: 60f0bebb-6384-4650-f266-08dc2f3d95e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EmUNp4hkU7kr42gyHg/1JRraxHThwVm1pV/C0ECyO5fWDKBs4MR6WZfQnyL0f/DAcneSDaPeLDEpcyfVCYbG+EvYbO0iNjOHJFfGDFdwyQWZhyRl2xxhb2VhPgYHKDUtczEuLR4NdzGlqNAaI7gnNQcdsk+3WJ8Bcy9Tf93ON6tjCOFSdycyB8rztX7yvYPFjCiq+pCzX6gZICVOatwbYJdmMbryabJnTVQSxohV7goGrd51eqhQpaCloDjk5yUcLULAzR2EIou4Wv0gvOj8NUlHqHwW/SsAV9wDKy4jeihetYgo83YBvqMFoD04b9oJLpyimq27JJXz4LJhmYu51LhhqKxJkHQAbmK8rA4FNEiH/gg/MnrQ34hBbxe8FMKqPDsbbHmJ2LG8mKKo2mSTHXrCwgK7wjEH3+x96jTqs+mlXA9YP7Yx7axXG5lOnaRRfYuKAktxbi1YDa++2jjSeJlVxbXlk4q2B/44/r36HJQS8i3jWpSqjAdd1C0HZmpvG2AoAHVUZ7mInJlxI8kN1zkj4CIJxiCgj072Br/Wz/g0BsaOKYTtmSWP8MxnEwngJtR09rnNI127Cb282c3uCGUCcHv1bT7E66Xo2gjO123KyRn6SQCUPiAp06dPBSOh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(36756003)(86362001)(6916009)(82960400001)(8936002)(8676002)(66556008)(64756008)(66476007)(76116006)(66446008)(66946007)(5660300002)(122000001)(2906002)(4744005)(7416002)(83380400001)(38100700002)(4326008)(38070700009)(41300700001)(71200400001)(316002)(26005)(2616005)(54906003)(478600001)(6486002)(6506007)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3JYcmg2YXorRVp0VTlUdzBxWmo5V3NvcWlNVkp1R1B2NWtHVFljRkJPVzBH?=
 =?utf-8?B?TjI4MFVUblFMOGFieDc2d2FIVk11aTljdnVnMXIxYjVCaFQ0ZUF6TUg5aGNU?=
 =?utf-8?B?U2FHRkRSQktuSk5pL0h1bHRKSDlQWHppWTNhbWR5Y1d4V1V4RUtGRzJnTFd2?=
 =?utf-8?B?SiszMHJaSmRWbzAxU3RlZmF0TGc5OUdKa0tQMDdCV3ZFOFRkaHd3dmpEZlVQ?=
 =?utf-8?B?Q1YwM0dHeTUvd1ZJZUF0eVlnSlVxdkFYQnQ3OWphVmZITC9SOFo3dW11Q0NQ?=
 =?utf-8?B?dzR1WldqWkdjQ3h1MU94YWg5dXFIeXZ2MjlvQWljK1lBMUZoUkl5cFRRaVBR?=
 =?utf-8?B?R3QzUVdCQVlEKzRUSXBNcEh2YmVnc3hLeGZPY3lHQVRZcXY3UlBJeDhOR1do?=
 =?utf-8?B?dXJOMlI1RExjc29zbkhXM01oSzFGVnAwTjA2clFUSWY1aFJycWtGOXpqYXJv?=
 =?utf-8?B?eVhGbFRqd2tKSnV0c3E2UjN3S0lxU091T3RWZGhLYlkraUEwdmg3MHlDSUIx?=
 =?utf-8?B?OS92VWx5bkIwdEtNcmgvbUIwU1N4WVBpbDAzRzU2NDVHRjg0QlFFVlBITEk3?=
 =?utf-8?B?dlZOZ3RkWStacStiQ3d3cHNiY3cyMCs4dndEWEtuMW5GVEtzWnpxb1dDa3pO?=
 =?utf-8?B?L3drS28yWkxRZGtKcHhyTE1EQ2NXZHNCcTFTMmkzOHZqa0NoQmZDdlZRZGZY?=
 =?utf-8?B?UGtueXRPNVBvUFBORFVzRms1akoxYWpUa2g0QnhEVC8wUkw3TTBGTGxRb0Ez?=
 =?utf-8?B?RTEvR2lMeGxGUVcvOUYyU1U4TVliNDFHUzc4SUtlajVMZTFHR1VFdUhOY3JC?=
 =?utf-8?B?eGgySTM1akEyeUxXN1YrOXMyaVJFL2o3end6Z0l1TTdid1JmSnNrbCtxSG9H?=
 =?utf-8?B?S25uWkNmM05uMEI1eWRISjhJeCsxbWNNR21qSUdaMzJxZU5pK00vbzNaVEx5?=
 =?utf-8?B?Z25ZQ09xbEVRamZpZUxDY0tpYjJoMHN4dnlzQjNDN2Rhc1dnYjZJNlVkcXJL?=
 =?utf-8?B?NHZlaElMaGFONWxvd29nZ0U5bFY5Wnk0c3htWWZLYnVNYVdIckdObW1wQk8v?=
 =?utf-8?B?K3BIM0RjWWdlRmVNL0psd05iNmFXYm55NTZMUlN4RTcwQk43Q3VRTExhM3FI?=
 =?utf-8?B?elduWk1PWlpBZDdyd1orSm90NWNwUVVkMS9KNmlLaUY1VE1SWWkxTGdQTytw?=
 =?utf-8?B?cG1Oa1hUc21abXZyK2ZZQW5LbStJNzhCTUkvdkE4MDM0QTZ5RDhEWmVmTWF5?=
 =?utf-8?B?NXlVdm5zNVpGeXRjbnRpaHAxL0paZitpUXJLeUN0YjdmVjd1V3dHQ0FtY1Ey?=
 =?utf-8?B?bnBMWEJqenBqT0ZSSGFVeUkxZTJkN2dEbUJTTlc5K1BHb2sydDNLS2I1MjF0?=
 =?utf-8?B?aXkyaGNlK1JnTjdKaEdudkJrZCtuK0U4ajFnSDdoR0ZWeTh3aTFjMmNPRTVX?=
 =?utf-8?B?MGJEdVZUZTBHUnpRc1FqSkxHZy9GUDhIRkp1YlFRQVNqL3pZVSs2TTJOVXVm?=
 =?utf-8?B?QTRLcFg5Q3lVM2JUNXlWQktTNFdhTVJ0c3VFRnB4RUxuV0FVWnVxb0JFU3dY?=
 =?utf-8?B?NmRoUVBQTG54TlBuT3VXWE1wOWFYWDBOdmdLa3ZwYXVSa2grVUVoL3VVTzBr?=
 =?utf-8?B?U1VOd2lBRVNMMldUSlFxK01YZjhhdjlRK2w2ODF3bDhIZFhPZG5ya3p5ck8z?=
 =?utf-8?B?djAxRmZEZUdoUkpUOUw2MzRtTG9HZzJnNzNkeXFucW9UMWltdlVza1FSd21r?=
 =?utf-8?B?Skx3QU10OW9HT2VsZnljN3MxWDYyZmtEYVFJTTE1SmYxV2ZpL240V1BybTA5?=
 =?utf-8?B?MlZ3cm51dFdqRUc3dzFuMFNZQWlLdjNxTTEwdmdwOUNKdGpyLysvWU9XLzg5?=
 =?utf-8?B?UURieDBEbEFzS1E2ZXNNNFZzNmNyY0hSZVVOL0dwTUtrUFF6UUZRQi9zenpo?=
 =?utf-8?B?T2RJMit3cjk1UFJYMlRYUzZhMHo3Qk5PRmd5dnhieFpLWFpLa2RTT2lUSnZC?=
 =?utf-8?B?Lzd2a0RsbWdvS1JGeTZhdnBmUkV5NWVqdGg2RHJlQUo0clgzblZMMGYrVmtI?=
 =?utf-8?B?Zi9jL1lRYjAxRFhmWVJ4TWhSZ01QOVlhaUxjSkkyQWZUTFU4SjVpdmJwTTdG?=
 =?utf-8?B?aFE2VXJKRkgxSHhwZUp1KzgwRGpzM3lRUEx5ckcvak5sK3ByamEyUWNuWi9Y?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AC6080751429745A2FA04B6981F357E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f0bebb-6384-4650-f266-08dc2f3d95e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 22:21:13.3199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KS6QFIYYlxHPQHdmMRpY1INhp7U3SfBu/gDx+q+mcj3tOx2/Ak7Z1Mp5bD7w8+OSJW2JTL8YVk3c1QDMu4JFgPBgz7veKxqkdp90Wq0JvLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5202
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAyLTE2IGF0IDE0OjU5ICswMjAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IE9uIFRodSwgRmViIDE1LCAyMDI0IGF0IDAzOjEzOjI4UE0gLTA4MDAsIFJpY2sgRWRn
ZWNvbWJlIHdyb3RlOg0KPiA+ICt1bnNpZ25lZCBsb25nIHRocF9nZXRfdW5tYXBwZWRfYXJlYShz
dHJ1Y3QgZmlsZSAqZmlscCwgdW5zaWduZWQNCj4gPiBsb25nIGFkZHIsDQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGxvbmcgbGVuLCB1bnNpZ25lZCBsb25nIHBn
b2ZmLCB1bnNpZ25lZA0KPiA+IGxvbmcgZmxhZ3MpDQo+ID4gK3sNCj4gPiArwqDCoMKgwqDCoMKg
wqByZXR1cm4gdGhwX2dldF91bm1hcHBlZF9hcmVhX3ZtZmxhZ3MoZmlscCwgYWRkciwgbGVuLA0K
PiA+IHBnb2ZmLCBmbGFncywgMCk7DQo+ID4gwqAgfQ0KPiA+IMKgIEVYUE9SVF9TWU1CT0xfR1BM
KHRocF9nZXRfdW5tYXBwZWRfYXJlYSk7DQo+IA0KPiBBZ2Fpbiwgc3RhdGljIGlubGluZSBzaG91
bGQgYmUgZmluZS4NCg0KTm90IHN1cmUgaWYgdGhlIGRpZmYgbWlnaHQgYmUgYSBiaXQgbWlzbGVh
ZGluZyBoZXJlLCB0aGUgc2lnbmF0dXJlIG9mDQp0aHBfZ2V0X3VubWFwcGVkX2FyZWEoKSBkaWRu
J3QgYWN0dWFsbHkgY2hhbmdlLg0KDQpJZiB0aHBfZ2V0X3VubWFwcGVkX2FyZWEoKSBpcyBtYWRl
IGludG8gYSBzdGF0aWMgaW5saW5lLCB0aGVuDQp0aHBfZ2V0X3VubWFwcGVkX2FyZWFfdm1mbGFn
cygpIHdvdWxkIG5lZWQgdG8gYmUgZXhwb3J0ZWQgaW5zdGVhZCBzbyBpdA0KY291bGQgYmUgdXNl
ZCBpbiBzb21lIG1vZHVsZXMuIFVubGlrZSBnZXRfdW5tYXBwZWRfYXJlYSgpDQp0aHBfZ2V0X3Vu
bWFwcGVkX2FyZWEgaXMgYWN0dWFsbHkgaXMgdXNlZCB0aGF0IHdheS4NCg0KQmV0dGVyIHRvIGV4
cG9ydCB0aGUgbW9yZSBsaW1pdGVkIHZlcnNpb24/DQo=

