Return-Path: <linux-kernel+bounces-44714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3C0842660
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2F61C250D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1D66D1BA;
	Tue, 30 Jan 2024 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P9ekY/jY"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C12067E7E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706622314; cv=fail; b=d0lVoSNmezJYF/13E/gvm6a6AoZrQzFXDyXmqXBoFKzpMATTnap2/FVlY+v10LbUZ0xQF/AY2NHm60R7yjuM0Yutsxe52MtLmktER94zGNjDyyyBV33G8lQUbVga7oskR28UDFjKU7xpZl08NdLeN7RZ5xCXKt4t4pSpsXyFkjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706622314; c=relaxed/simple;
	bh=Yuf5tA3y2LaMIeWm0HZ0OCIFjgubNia/di43tsrH2xM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IHn6ja3SHkCEsONnCugn0U436ksT0zi8CgxgAuOJ1ZYf+PUfZv/O33lbXN9ijQhzE+MFvB4Tvs86f9H69+H4xkIw9QiJpeK7OXw1dAHz14R5KeeWCEV7KtSc8rbueDO4cxwaIgkYXtoaVx+qTHyNzlIOGTmDZMBIo6/aFap5xBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P9ekY/jY; arc=fail smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706622313; x=1738158313;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Yuf5tA3y2LaMIeWm0HZ0OCIFjgubNia/di43tsrH2xM=;
  b=P9ekY/jYyQEDI+KY7q8fLJFGQd/e7RM4PAyh7ymMxC968LFxyh/lIM5z
   EI4HbALjY3Jc8NWOg76loVLk1TgMXxgumGreMKc/KlokPHzFL3JsDy6iE
   5mSHUeSMp3TtNJEOWlF5xpPkkelw8eeQolNLbsFiFFW8qS4wr467kkKNC
   d1b/a9P9n0o/V+65/IoC4rawd/VA9CBx28eWq588YdyUMoGt+auW6cRrW
   N/ylnYLrYSymiFi7DvXnzDwmMZiG0Vp3AtT8ISg5uN3ir8xEbkqh1e35F
   KjDu2+1VXT1xgTfM+zkvfjEVOccGLeMRy4aaiE0oCgwe6yXCaCRW0vUwS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="467536901"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="467536901"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 05:45:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3706536"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 05:45:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 05:45:10 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 05:45:10 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 05:45:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJtga6+NGDd4rh7NDGbb5TEZhuivgX0ia13uygfx74ldx7ozAnAHPI1LeOO/o7JRjxv6y2IwwlkVz+AEE5819BoIhhKpHYB9WMNR3RHScGAt8fN5wP0QjchaY2fJPLmE5YodH8dyFKG6DlBASD+a4+bgeU2uCihM5rVMWe6XjXNm6fiO84BPl0Gr+7hGvkc4/xtyw9P82jvKY0Im/nslecHZabEmC/CaiI3YbmK/OVO+WKMR8RG4kjl/wnpRrLutoFUcRyMxPX7XFOQywQelXQBXvzApyP2R2TyzWNByGBh9QGgglRI6twOAa8z7cRc8TA5tZPRpNS57qdI1JCo9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yuf5tA3y2LaMIeWm0HZ0OCIFjgubNia/di43tsrH2xM=;
 b=MWQgDvK+6YJhbRefKnY23ezT+CfNQSyrk7JWXugJ2QtRJWyC2FEr+tl3w0lRCGW3YBDiwdGq1d3ViYwkkaIxnOojOuTWcUJjtat55BW4C0rNb2s9cSMeI8o65W7sxrVt9wJMsVdz1l96oSRoURHfmICsCC8wsHcVC3X/hxi3eXekyDhWkojA2VU4fF+34v8zwq+3EzfBW6j/dOfYYTwfVRf9ISh3+ru1vMZtawgmaSzM8FPiWvJWRQiRRsLtlvMtUtANH+dhW0lCuwALaO5sl6D06FGjH4We+J9eqYU5j0bnXnqard9kC4Bd0zADL4ug0B2y75e/cr4R5shcVINwXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 BN9PR11MB5355.namprd11.prod.outlook.com (2603:10b6:408:11c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.34; Tue, 30 Jan 2024 13:45:06 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 13:45:06 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, Theodore
 Ts'o <tytso@mit.edu>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Nakajima, Jun"
	<jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Kalra,
 Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
Thread-Topic: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED
 fails
Thread-Index: AQHaU1aXalf71JpekEOiHH1k7Csdk7DyS4oAgAAJSVA=
Date: Tue, 30 Jan 2024 13:45:06 +0000
Message-ID: <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <20240130083007.1876787-2-kirill.shutemov@linux.intel.com>
 <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com>
In-Reply-To: <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|BN9PR11MB5355:EE_
x-ms-office365-filtering-correlation-id: b5687270-9069-43e7-35b4-08dc2199aaea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e+UF99wjlARwb1yhD4sxfUnFFANy9jw6qNxUDwXptNe+x2rdJs023sUCuu5ZBjeqoWZlO19RtQ0o07kltC6Z6D210A7QoOaEe7Jk1a9ELV0rOz/hIy1+fI3eHfPEokaj3T9rV0QtiCRqUY5reTSJ8eKfKcR6+Df2XHfFdnBUZcE3VSimViozFuTjIBYMgvcNLLJ+FI16ihnJjtni2VNXE/YTD6YchFQErT3QfqkWtd7AafyaitSdnhTJ2Q0+p9umkUgjXfmFt7v+hlaqYuCbDlQMxf+bIgerCJJ4tkJ+kj+SNWw8nAHwnO90gEgo8VSx6eCNUirvlLXYhqxYfjQg3hsovTYZr7h0Oz1uzyz/TZ1LFz14ZGLMjmUpFCZC7rf8baiaLLrLJwYHgoYrB1v0fJgxnsTSvOyVr32yKtdTQBX5kj3hh/lUvqLbkns9PnlG8ZNSLdRTDMHnD+RSAwiwu9xVtnqZxwqxdXmrw36TpLVjSwo401KGKDXM46+bbTfhaU+YIqlSoGqYzVc1NRmM9sIAmqkTkuaY+yxKcAryQEaM3JjoY5h1JGa7m+pXyGayaJ1L65cZXLEI5p8t3eTtoUZRGEyQHux+xEjNV/I/75fZ25wKyQ5VjbD/eqTeBvNM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(66446008)(64756008)(316002)(4326008)(66556008)(66476007)(8936002)(66946007)(33656002)(76116006)(7416002)(8676002)(110136005)(83380400001)(478600001)(86362001)(71200400001)(5660300002)(52536014)(38100700002)(82960400001)(2906002)(54906003)(55016003)(7696005)(53546011)(9686003)(122000001)(6506007)(38070700009)(26005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3hTTDNiR0N4clRnbVcxNTdmU0ZBT08wNzUzQkMrQW9aRit4YU9RTjZ6MTFn?=
 =?utf-8?B?Q3MvWWc5alAvQVYvUThVRXJQd0h2cUhFdHVDSnVnVkJZbVhnSW0waFM3KzRp?=
 =?utf-8?B?ZzQxWUVLY1JvK3Nlc0ticTBkUUNrd1A3a0YwdDZ4ZU5kYjZQU0ZrTVJnK3J3?=
 =?utf-8?B?NGFNQ0NRMS9vUmtncEgxaldxUzlZRkNsZkZzN0RPNDV6Um1Pak1Fc2V1ckM2?=
 =?utf-8?B?eE5sL0tOQzlEdzFpd1lqUHpSa2NycjJtb3hDd0J0cSs2R21WQ2dOTDhjMEo5?=
 =?utf-8?B?VVhuY1pDQTNBR3oydDZpY001RVhiRHltaG9hL3M3SmFLM3Y4ZlJHV2syU0k2?=
 =?utf-8?B?WDE3OVRTZEd4d0hIWE5HdXd1dzlkOXYxZFVvL2RTVUttblJVcW5BNkx3N3Mv?=
 =?utf-8?B?M1p1QjhGeHVYUWpYYnBtdk9tNGVMNjlGMGMwZUVNUng5YjNWUjAwclpQV1Zp?=
 =?utf-8?B?S0s4WFE1WTR1V29jeVpaRGhaK1hJaHgvQnAxVnlabVE4SlQzWDhIamR6VEp4?=
 =?utf-8?B?S0pZUEtUanJ5NlQ1eHlGeVZLMHdEclh1M0tmSzQ5UHJCS0Z0R2oyc2xHdnpv?=
 =?utf-8?B?am5QeTMxeG5SY0lKR0RXdmZTMnJNbElLWmkxMkU5TU9hb1JIbDArbE8vMmRr?=
 =?utf-8?B?c2krMGQ0cUdEOG8wMm9mRzJQUEZGaHRnWFN3VTlDckw0cG1LUit1bGtnSlBi?=
 =?utf-8?B?ZHlEamVsK2U3ZDBneFBlK0NES20wRG1ycVBDUGl4Tk1KdFU4U3lEbHkyckZS?=
 =?utf-8?B?R2txMWxkZ0tvd2E4MjM2N0Npdm1kOEcvV0k1aFZvZncxNkY5dFY5dDFkZ0NL?=
 =?utf-8?B?ekVkYnBQTWw4dWZKdm5ldEhNTmRSYWpUU3B6TlVlNWRyZ2lLS2t1Z2dkVHNs?=
 =?utf-8?B?U2xqWXZ0TlRBcjVnK2NCV1JtV0RJMy8yS2hDRm5Yb3N1aU9UWTV5WDBHMEdJ?=
 =?utf-8?B?YTcwL3IzK3VNTGxmbmpsZlRTbXpBNFZpTFcybkZNQzV4YnJMc3ZHV1granNz?=
 =?utf-8?B?NHFuY2dPUHFxd2RMVHczcW1WWjV0MnFkYmNBUVRTWlpaR0QyUFYvUUdXRzdB?=
 =?utf-8?B?cXpVY0hQVkczUmVBUms2MldvMEdCeE1CTVgrVTRrR2h4VFhtRGhYS2dwSDh0?=
 =?utf-8?B?dlJsUWFXQk12UHVneFgrbFJJUklxQjJBSGN4UDZvUXhlMXlRdjE0eEMzL1RV?=
 =?utf-8?B?aXlqU2F2WGtldWpFODVnOVEvSmI1UjBiVDlPbzBndE9PbzU3SHN0U0pFTzcz?=
 =?utf-8?B?NXpaenpzS0xvTVIvWjN2VEJWSWswSTBBcFlETmpNcWNQTDdReUdMNzJqcnVm?=
 =?utf-8?B?WlNYd2xKTHM0MHBFM0lWQTh6VHgwSCtVY3E2Y1lmN0ZRT0RmRjFscTlMbHRQ?=
 =?utf-8?B?Ky9tdm1wWGFKWnliOE9JVlJsL3hwam40RW5pZFFxWmorNTVQdE1oNU40dzgx?=
 =?utf-8?B?RHljaXk0MUg3QmI1b1ZOZll1VWF2bUhjV1htZHVQa2o1U0k0em9IZmRlNlgz?=
 =?utf-8?B?SVBFMmtMRk95MGc2aUlRb2hQQUhPWVdUZ0hVSHd3QmhPSzZqM250RU9RSk1u?=
 =?utf-8?B?Kzl3Mlg4TXoyV2N3ZU82U1Fia1VBWWRkZE1RZFNrODY0bG4vQXBzcm0vUjh1?=
 =?utf-8?B?NEVSM2Zud0dEazAvcVZHWTV5ODMyUkM0R25maE5mZE1ORnc1RjZRa0c3V2NM?=
 =?utf-8?B?ZHdTbkRNS00wWHMxSnNiQXd5MG9XNEpGNjAvczRpYlN0VW9PQW9pZitTYXdV?=
 =?utf-8?B?d2x0L1BrQUZzMmFscnRqOWpLcklsV3llRVJjcmR1T0NEMXVMeXcvcW8vSVJt?=
 =?utf-8?B?VEJkcUo5bDQrQ1gzYVAyUHhlcTdqM2xTQXBRYUt5WS9HbkZRVE9uMHI5K2RE?=
 =?utf-8?B?TU9VVGtWWGFSTTEraTJVK1hKYmNBb1JUN09xUWIzMHRQWHRhSld3MmZNaUVE?=
 =?utf-8?B?Wk1sZVZPVmNXTnpIUlR5bFJ3dGg1UWxyS1VXelgyZGZiZHBUSnErYndRenVJ?=
 =?utf-8?B?SkM0djJkamlvZ0N5VHRWclFnZXNMUXQ2QW1XOEs0Z2lseTdaSVdmR3A4bU5R?=
 =?utf-8?B?V2drRGFOM3Rxc3VldTl0Z1F0R093cDFhK0dmbHoxVmJubHFpSkJCd2dRb0lZ?=
 =?utf-8?Q?+032cb4drvdxvMwX6I6gJB8e+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b5687270-9069-43e7-35b4-08dc2199aaea
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 13:45:06.0350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TG1jAgsItjMUo9+Fm2T9jdwqgqRbZTtM93yu7lzTHFAfGd1Ju87oLggQsVyNRnUYlBblMAAyeY1+rlhR8yB/RN+KMaAE6wQZ1BJAe0sqLPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5355
X-OriginatorOrg: intel.com

PiBIaSBLaXJpbGwsDQo+IA0KPiBQaWNraW5nIHVwIGZyb20gbXkgbGFzdCBlbWFpbCBvbiBwYXRj
aCAxLzI6DQo+IA0KPiBPbiBUdWUsIEphbiAzMCwgMjAyNCBhdCA5OjMw4oCvQU0gS2lyaWxsIEEu
IFNodXRlbW92DQo+IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4g
PiBSRFJBTkQgYW5kIFJEU0VFRCBpbnN0cnVjdGlvbnMgcmFyZWx5IGZhaWwuIFRlbiByZXRyaWVz
IHNob3VsZCBiZQ0KPiA+IHN1ZmZpY2llbnQgdG8gYWNjb3VudCBmb3Igb2NjYXNpb25hbCBmYWls
dXJlcy4NCj4gPg0KPiA+IElmIHRoZSBpbnN0cnVjdGlvbiBmYWlscyBtb3JlIHRoYW4gdGVuIHRp
bWVzLCBpdCBpcyBsaWtlbHkgdGhhdCB0aGUNCj4gPiBoYXJkd2FyZSBpcyBicm9rZW4gb3Igc29t
ZW9uZSBpcyBhdHRlbXB0aW5nIHRvIGV4Y2VlZCB0aGUgcmF0ZSBhdCB3aGljaA0KPiA+IHRoZSBy
YW5kb20gbnVtYmVyIGdlbmVyYXRvciBoYXJkd2FyZSBjYW4gcHJvdmlkZSByYW5kb20gbnVtYmVy
cy4NCj4gDQo+IFlvdSdyZSB0aGUgSW50ZWwgZW1wbG95ZWUgc28geW91IGNhbiBmaW5kIG91dCBh
Ym91dCB0aGlzIHdpdGggbXVjaA0KPiBtb3JlIGFzc3VyYW5jZSB0aGFuIG1lLCBidXQgSSB1bmRl
cnN0YW5kIHRoZSBzZW50ZW5jZSBhYm92ZSB0byBiZSBfd2F5DQo+IG1vcmVfIHRydWUgZm9yIFJE
UkFORCB0aGFuIGZvciBSRFNFRUQuIElmIHlvdXIgaW5mb3JtZWQgb3BpbmlvbiBpcywNCj4gIlJE
UkFORCBmYWlsaW5nIGNhbiBvbmx5IGJlIGR1ZSB0byB0b3RhbGx5IGJyb2tlbiBoYXJkd2FyZSIN
Cg0KTm8sIHRoaXMgaXMgbm90IHRoZSBjYXNlIHBlciBJbnRlbCBTRE0uIEkgdGhpbmsgd2UgY2Fu
IGxpdmUgdW5kZXIgYSBzaW1wbGUNCmFzc3VtcHRpb24gdGhhdCBib3RoIG9mIHRoZXNlIGluc3Ry
dWN0aW9ucyBjYW4gZmFpbCBub3QganVzdCBkdWUgdG8gYnJva2VuDQpIVywgYnV0IGFsc28gZHVl
IHRvIGVub3VnaCBwcmVzc3VyZSBwdXQgaW50byB0aGUgd2hvbGUgRFJCRyBjb25zdHJ1Y3Rpb24N
CnRoYXQgc3VwcGxpZXMgcmFuZG9tIG51bWJlcnMgdmlhIFJEUkFORC9SRFNFRUQuIA0KDQogdGhl
biBhDQo+IFdBUk5fT04gc2VlbXMgbGlrZSBhbiBhcHByb3ByaWF0ZSBzb2x1dGlvbiwgY29uc2lz
dGVudCB3aXRoIHdoYXQgb3RoZXINCj4gZHJpdmVycyBkbyBmb3IgdG90YWxseSBicm9rZW4gaGFy
ZHdhcmUuIEknbSBsZXNzIGNvbnZpbmNlZCB0aGF0IHRoaXMNCj4gaXMgdGhlIGNhc2UgYWxzbyBm
b3IgUkRTRUVELCBidXQgeW91IGtub3cgYmV0dGVyIHRoYW4gbWUuDQoNCkkgZG8gYWdyZWUgdGhh
dCBkdWUgdG8gaW50ZXJuYWwgc3RydWN0dXJlIG9mIERSQkcgaXQgaXMgZWFzaWVyIHRvIGNyZWF0
ZQ0KYSBzaXR1YXRpb24gd2hlbiBSRFNFRUQgd2lsbCBmYWlsLiBCdXQgZm9yIHRoZSBwdXJwb3Nl
IG9mIExpbnV4IFJORyBhbmQgDQpjb25maWRlbnRpYWwgY29tcHV0aW5nIGl0IGFjdHVhbGx5IGRv
ZXNu4oCZdCBtYWtlIGEgZGlmZmVyZW5jZSBpZiB3ZSBnZXQgYW4NCm91dHB1dCBmcm9tIFJEUkFO
RCBvciBSRFNFRUQsIGFzIHNvb24gYXMgd2UgZ2V0IGVpdGhlciBvZiB0aGVtLiANClByb2JsZW1z
IG9ubHkgc3RhcnQgaW1vIHdoZW4gYm90aCBvZiB0aGVtIGFyZSBtYWRlIHRvIGZhaWwuIA0KDQo+
IA0KPiBIb3dldmVyLCB0aGVyZSdzIG9uZSBwb3RlbnRpYWxseSBjb25jZXJuaW5nIGFzcGVjdCB0
byBjb25zaWRlcjogaWYgdGhlDQo+IHN0YXRlbWVudCBpcyAiUkRSQU5EIG9ubHkgZmFpbHMgd2hl
biB0aGUgaGFyZHdhcmUgZmFpbHMiLCB0aGF0J3MgZmluZSwNCj4gYnV0IGlmIHRoZSBzdGF0ZW1l
bnQgaXMgIlJEUkFORCBvbmx5IGZhaWxzIHdoZW4gdGhlIGhhcmR3YXJlIGZhaWxzIG9yDQo+IGEg
dXNlciBoYW1tZXJzIG9uIFJEUkFORCBpbiBhIGJ1c3kgbG9vcCwiIHRoZW4gdGhpcyBzZWVtcyBs
aWtlIGENCj4gcG90ZW50aWFsIERvUyB2ZWN0b3IgZnJvbSB1c2Vyc3BhY2UsIHNpbmNlIFJEUkFO
RCBpcyBub3QgYSBwcml2aWxlZ2VkDQo+IGluc3RydWN0aW9uLiBVbmxlc3MgdGhlcmUncyBkaWZm
ZXJlbnQgcG9vbHMgYW5kIHJhdGUgbGltaXRpbmcgYW5kDQo+IGhhcmR3YXJlIGFuZCBzdWNoIGRl
cGVuZGluZyBvbiB3aGljaCByaW5nIHRoZSBpbnN0cnVjdGlvbiBpcyBjYWxsZWQNCj4gZnJvbT8g
QnV0IEkndmUgbmV2ZXIgcmVhZCBhYm91dCB0aGF0LiBXaGF0J3MgeW91ciBmZWVsaW5nIG9uIHRo
aXMNCj4gY29uY2Vybj8NCg0KUkRSQU5EIGNhbiBmYWlsIHdpdGggZW5vdWdoIGxvYWQgYXMgSSBh
bHJlYWR5IHNhaWQgYWJvdmUuIA0KSSBhbSBhbHNvIG5vdCBhd2FyZSBhYm91dCBhbnkgcmluZyBz
ZXBhcmF0aW9uIG9yIGFueXRoaW5nIGxpa2UgdGhpcyBmb3INClJEUkFORC9SRFNFRUQgaW5zdHJ1
Y3Rpb25zLiANCg0KSSBndWVzcyB5b3VyIGNvbmNlcm4gYWJvdXQgRG9TIGhlcmUgaXMgZm9yIHRo
ZSBjYXNlIHdoZW4gd2UgZG9u4oCZdA0KdHJ1c3QgdGhlIGhvc3QvVk1NICphbmQqIGFzc3VtZSBt
YWxpY2lvdXMgdXNlcnNwYWNlLCBjb3JyZWN0PyANCkJlY2F1c2UgaW4gbm9uLWNvbmZpZGVudGlh
bCBjb21wdXRpbmcgY2FzZSwgdGhlIExpbnV4IFJORyBpbiBzdWNoDQpjYXNlIHdpbGwganVzdCB1
c2Ugbm9uLVJEUkFORCBmYWxsYmFja3MsIG5vIERvUyB3aWxsIGhhcHBlbiBhbmQgd2UNCnNob3Vs
ZCBoYXZlIGVub3VnaCBlbnRyb3B5IHRoYXQgaXMgb3V0c2lkZSBvZiB1c2Vyc3BhY2UgY29udHJv
bC4NCg0KSSBndWVzcyB0aGlzIGlzIGluZGVlZCBkaWZmaWN1bHQgc2l0dWF0aW9uIGJlY2F1c2Ug
d2UgZG9u4oCZdCBoYXZlIGFueSBvdGhlcg0KZW50cm9weSBzb3VyY2VzIGFueW1vcmUgKHVubGVz
cyBhc3N1bWUgc29tZSBzcGVjaWFsIEhXKS4gDQpCdXQgeW91IGJyaW5nIGEgdmVyeSB2YWxpZCBw
b2ludCB0aGF0IGluIHRoaXMgY2FzZSB3ZSBtYWtlIGl0IGVhc2llciBmb3IgdXNlcnNwYWNlDQp0
byBtYWtlIGEgRG9TIHRvIHRoZSBrZXJuZWwgaWYgd2UgcmVxdWlyZSBSRFJBTkQvUkRTRUVEIHRv
IA0Kc3VjY2VlZCwgd2hpY2ggaXMgbm90IGFjY2VwdGFibGUgKHdpdGggZXhjZXB0aW9uIG9mIGVh
cmx5IGJvb3Qgd2hlbg0Kd2UgZG9u4oCZdCBoYXZlIHRoZSB1c2Vyc3BhY2UgcHJvYmxlbSkuIA0K
DQo+IA0KPiBBbmQgaWYgdGhlIERvUyB0aGluZyBfaXNfIGEgY29uY2VybiwgYW5kIHRoZSB1c2Ug
Y2FzZSBmb3IgdGhpcyBXQVJOX09ODQo+IGluIHRoZSBmaXJzdCBwbGFjZSBpcyB0aGUgdHJ1c3Rl
ZCBjb21wdXRpbmcgc2NlbmFyaW8sIHNvIHdlIGJhc2ljYWxseQ0KPiBvbmx5IGNhcmUgYWJvdXQg
ZWFybHkgYm9vdCwgdGhlbiBvbmUgYWRkZW5kdW0gd291bGQgYmUgdG8gb25seSB3YXJuIGlmDQo+
IHdlJ3JlIGluIGVhcmx5IGJvb3QsIHdoaWNoIHdvdWxkIHdvcmsgYmVjYXVzZSBzZWVkaW5nIHZp
YSBSRFJBTkQgaXMNCj4gYXR0ZW1wdGVkIHByZXR0eSBlYXJseSBvbiBpbiBpbml0LmMuDQoNCkkg
ZG9u4oCZdCB0aGluayB3ZSBhcmUgb25seSBjb25jZXJuZWQgd2l0aCBpbml0aWFsIGVhcmx5IGJv
b3QgYW5kIGluaXRpYWwgc2VlZGluZy4gDQpXaGF0IGFib3V0IHBlcmlvZGljIHJlc2VlZGluZyBv
ZiBDaGFDaGEgQ1NQUk5HPyBJZiB5b3UgZG9u4oCZdCBnZXQNClJEUkFORC9SRFNFRUQgb3V0cHV0
IGR1cmluZyB0aGlzIHN0ZXAsIGRvbuKAmXQgd2UgZm9ybWFsbHkgbG9vc2UgdGhlIGZvcndhcmQN
CnByZWRpY3Rpb24gcmVzaXN0YW5jZSBwcm9wZXJ0eSBvZiBMaW51eCBSTkcgYXNzdW1pbmcgdGhp
cyBpcyB0aGUgb25seSBzb3VyY2UNCm9mIGVudHJvcHkgdGhhdCBpcyBvdXRzaWRlIG9mIGF0dGFj
a2VyIGNvbnRyb2w/IA0KDQpCZXN0IFJlZ2FyZHMsDQpFbGVuYS4gDQoNCj4gDQo+IEphc29uDQoN
Cg==

