Return-Path: <linux-kernel+bounces-69370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D327E858825
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3965DB220EA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C282C145FFE;
	Fri, 16 Feb 2024 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ltnx4wm/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EADC2FE28
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119733; cv=fail; b=dfvpMzmlFWR/2ZKpUqE1IEJAwkJ/hZ2qMHaCAAiUIWd+Xz1dliDIHMpLa8Fi/5hw/A2SEkBMPHOpwJ/zk85uDFk63C0C8rD+l2cs+8dkZ4+R8io//KEcXDyBO2t1POlHq1W7IbLIKAk8d957wcFilznSwf391GAiSS2CdNgcCNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119733; c=relaxed/simple;
	bh=8GjGMr9NVS0qG9VhiMJ/ZWFM7NaYXSmlIUZifUrVBOs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dJvPQ6nwOI/qZSmG1yBu5WH0TOPZEImwsNaOkpbaRTx+WTaqnKh7VixBPhzMvBaaH0bJSTkDkubPUaRbxBEyUDjLmFYXGmzOrMA3JwDnsUkzT7Cc9TiyAA4ApqM3lAtxz0QXEn78kfDR/WHhdp+ha5x4Ae69Kjtzh6R7T3XTSd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ltnx4wm/; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708119733; x=1739655733;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8GjGMr9NVS0qG9VhiMJ/ZWFM7NaYXSmlIUZifUrVBOs=;
  b=ltnx4wm/cpaBYDskEUYZZM+K8YupStK8fZey7VkRBIt13eC+hqSXKizG
   mcBOBy1XmQiXdqgifj78KLsMP5DPfDzBwbTc91qpkKEnmMBr01SZ7KR9i
   6qu1zeiQ9/dzs14EZrkgL0KKXEDRskUnAcI5gIvwpV1AplqAruDkqwxws
   Rah1tun14a+EwXUaTOOy2Ma7qOckMLBjfw3DHm5775m476Htr84jW+jsO
   zHb/kcoBAXhBmyzvLfgOO/sFz1LWYVkjEIykvyGEKlgCfrtIROgfhtqM7
   5XgsEyAWy9bh9GX2Ax1YrCu8ctWHvXDJ29a0G2Dcd34F6eF+y9KAVlgaJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2169407"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2169407"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 13:42:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="4237089"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 13:42:11 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 13:42:10 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 13:42:10 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 13:42:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWqiWVQIyAFybeDirfe477IlHpZ7tQrCvmfxw0ewAxLCwno9iK/K1TghDeTv8rE+e5cxM75qSYKtdQDK1GpYkf5NZlQ0kg6+h1WZaZpZjoCZPFJI/ve4vZnkI8eJ+5vXRCg6JmkfRo55kAQIxoOLx9TJfmbQ8bBuzsle2Pm6doZwsSGoa2CXwkmd0I86lfeZHcfFePa5XSQ1MBWvGbd2RwCeRVZMTVnI37AyEDX77oun/FgeKIR9T3TeEFHXH8CVHsczoeUrzbiOtcPPzPHKj1rfqU14EASEWrtTOvH5fO+fcRb+HMELfXb/XV7/DsFlXv3GHnfyQU0u+8C6FpxMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GjGMr9NVS0qG9VhiMJ/ZWFM7NaYXSmlIUZifUrVBOs=;
 b=VpMRFHryK//uWZ1YQMgPxzyDIzrCIZmQyaHrqriB4rIobTBpbUBGl/vh/opmmHXqnMw8knInBMayDq5i0b2/6TAB3Xx0jA+UG0vVQQLhQdccyYoGsDrDKAWqPpuEbnZxanCPB36+xBN/dCWd4k6WSXOIYWW/48xgZdQD1QboxiRSlBdtJGIi5Ie0UT8EiZS9rF0dDcm/xebvt85nsva0LFzJy7p4w7oMsiz3o4kJ8N++ulgBSP6ZxE+CJuHAXQ87mpUm927WV8tDSXgjtOL2lF2fwAf9ahqe0w0tt7LPkfm4RffcG27Ixb8e7aS0XolRWIxiAZcpsP/ajZO8p2lOqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH8PR11MB7968.namprd11.prod.outlook.com (2603:10b6:510:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 21:42:08 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 21:42:08 +0000
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
Subject: Re: [RFC PATCH 1/8] mm: Switch mm->get_unmapped_area() to a flag
Thread-Topic: [RFC PATCH 1/8] mm: Switch mm->get_unmapped_area() to a flag
Thread-Index: AQHaYGTEKf96GFhAWkioh52NHqqmQ7EM5x0AgACaE4A=
Date: Fri, 16 Feb 2024 21:42:08 +0000
Message-ID: <fcb786b631c8c15b629e6f2b855460fabd010018.camel@intel.com>
References: <20240215231332.1556787-1-rick.p.edgecombe@intel.com>
	 <20240215231332.1556787-2-rick.p.edgecombe@intel.com>
	 <b65wvw4nghmwt4w4xsxoqwgc72efn7qo3s2p4dtatbcbvmxord@jopa2yxxbu6n>
In-Reply-To: <b65wvw4nghmwt4w4xsxoqwgc72efn7qo3s2p4dtatbcbvmxord@jopa2yxxbu6n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH8PR11MB7968:EE_
x-ms-office365-filtering-correlation-id: 14a84ff2-3a80-46e9-e631-08dc2f38201d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: as6qL/QWcUu5t2DY8mT+CmvRYdJ91WYALyrbum5xMYPp3pxP5UGFwkTs0N9B7WGrC21XpvNhU+b9tgKP3+x5gaG1SjYLkiOPq5cndygXS6Gq4z67ta591aBtQXM2khERrnpONigMJjppGAh0EXKjd99zpAq83QJQB/Oz2JY3YrFKHtePyGyRmZyo/kiHtOFDuUNyLk3VEchuIHmb+3+7fugVCCjW5jhYq5SopyShxqCEom+ndvrDEILQnQ/zHwA67vN6aZ0jyI2fj8ebHJN51QJ2WqGEEK62xlit+hwxEqlhcoauVGMvV/QkjW3L3ASfIxODL6rrgN8qCkf7zR6mctJFPbaW9FZTxfYoQartlsOUvwh9m6t2RWX6vL/TvfWlbgk/JzuG9IP5f4HPme+0fuKdNVHmDzsIC598i22LkaZKzLTg1xovqWemLJpyOcNW6nd1xjV9yM6unRwzutOgpx5uQWcOq0BBppBV9Rtw5ktt4Rcaem/X5irNhUzcgIxGBATpTmLQMqZmk39kI9TaQh9GWafTOO872dVskC0vk2gXdbRwWQaeKm0XshBuc/rThlYrEm7MXrhRvLKOvGUzOi7Iz5FHcU0nAVizPv3VY08=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6506007)(478600001)(6512007)(6486002)(2616005)(7416002)(2906002)(54906003)(5660300002)(316002)(4326008)(8676002)(8936002)(64756008)(6916009)(41300700001)(66446008)(66476007)(38070700009)(82960400001)(36756003)(66946007)(71200400001)(76116006)(66556008)(122000001)(38100700002)(83380400001)(86362001)(558084003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGpUbVZRQUEzeE9hUEFrd002TUlMSVVyTW9VS0RoYmsvZTNEVmxBYTdIQ2h4?=
 =?utf-8?B?Y3NTRE9YK1dvNlBvMkFLNVZKaUhkMkNCSnNSWFVFbDVtazhqcWlFb1dxZUxF?=
 =?utf-8?B?YUQwUlVaUjhGeHg3aENYR2VwbDY2V0JTbys4T2NwaWl3M1dpRXJYZjU4VEtX?=
 =?utf-8?B?UXJVZnpVOVB4RzllT2xybkpIWHp4REV4c1B4NkZ4SE94SU5VdlZxa0I5V1Fo?=
 =?utf-8?B?MVFnUlN2VVpnWStIVDlJOVppM245TVJLNzV0UEdDK05HSEpZV1ZSdFkxL1BT?=
 =?utf-8?B?R25ybG1TcmJ2RWk2WVdQaFZiektMRWRib09NS0FMOHFjekFYaDJadkViOFJ1?=
 =?utf-8?B?aDJWY1QyVGFzVXBqWG1QMWtjOXFTaWFpRU1JVW9FcExsOWtnTG5IbDRseWE2?=
 =?utf-8?B?SjFsK3VFZ1gwOFFrVkI5SHMyQWY1cGt4aTlXVEdqb1loVlFacVBqa1l2WWxB?=
 =?utf-8?B?TTVqUjhGdUZpbFNCYlRNWW9vSmREWjhIYi8xRDBFNEY2VlBySTdxOUhPM3F2?=
 =?utf-8?B?VzF5NE92c2ViVE1TTlJaY1pXbnN4TS9pRXUxdnFqMzFrQWVQcXZ4NU9kd3RI?=
 =?utf-8?B?ZlFHbEFVRU9NUE80WTEzTHVQZHd1Y2tReDJwbUZGWDZjZUQ1TVkxaWJ0UHFp?=
 =?utf-8?B?czdiVG1yZjU5UDhoRnRjdkZ2N00vTFBVdGdyR1VUc0NaR3cwcUJFZTVVMTZX?=
 =?utf-8?B?WEd3alVCN1VrckZyck82WE9LVEtTN1hWQTJkc3JSVVVLdVdJZWpUSUNDaVdP?=
 =?utf-8?B?THo0SFphY2hTK3ZJRG5SdUlDZnNPVnpocmVOeE1UNndGSit3QTVFVGpiempn?=
 =?utf-8?B?Wk5oZldMcWVLSjhYZy9CWUUwWUJySm10VXBTeE9NTkVzM1BLNVhXcWlYUldp?=
 =?utf-8?B?TVMreXhEWG9ZNzBzMC9QbXA1eU05dTRIYmhIajRTeG05bUFQeHVvMm9tT256?=
 =?utf-8?B?VG02MGpqQ1FLanpvenRPc0pYWmc1c0tYVEtUalVyQ2taZG1GTyszQy9PUHFa?=
 =?utf-8?B?TkUvRkl1ODRvTitVSXlaWVV4blJ0NDFiRzZCVUcyL00zbW9wbkNURU1XbzVi?=
 =?utf-8?B?YWFwY0xBcDg0YUhraEJrcjdEWVhCOWxKZjNRcUhjS1VzM3oxTnBSSmlFNHNH?=
 =?utf-8?B?ZmVaem9EalV3MkwwSWFTSU9DVWlYYll3UW5DQW15VmVhNDZwby96d2ZMVXVi?=
 =?utf-8?B?S3BTNCtaZmtydDZZczcyWG9nTU9ZeFdZSHQ4SlRtclhVbnZKaUdUQVFGNk8v?=
 =?utf-8?B?clJqdmdGMnNmcEpYa1lVWHM0a2dUY0VBaDRYTDM1akM5ajFNZ3Rod0tlbWFN?=
 =?utf-8?B?bXpmY1NTeWFlREdzRWVDKzZtRURPd0NsZ2R2OWJQUnFtTlA5Y1pXanBBSXV6?=
 =?utf-8?B?Y2dpZldBYXgyNEQ2ZjJxTmlUVVladCt4c2ErMXA1YndPZ0xaN0R1RHRoTXdL?=
 =?utf-8?B?elgwUXZvbE1UdlcrQmtFajd1OHVOTTJMYmF6eEFnOHUveGNHc3czemdjcUJY?=
 =?utf-8?B?NGZMb3laK0tYOVNEMjBhR1JlTXNDcG4xNjhjd0JUMU93Z2VydW9DTmd0dEdh?=
 =?utf-8?B?QS95NGNpOE5jMlZUWURtWW53aksrYUNFYUhqQjFWUjk1RncxT1JXUGxtbUlk?=
 =?utf-8?B?VEVKRzFBVzlnVjhUOGJTVlBQYWVRNjRzWWpYYlBtWmVYcVo3eE9CUFdiVkh4?=
 =?utf-8?B?WGNwZmE4c29GZDRoMXZUTTB5djRobXhKdkdjQVlUNTdoT215anNZSzJqV1BH?=
 =?utf-8?B?YWJZd0I1S0t2TzBPY3piUHVTcmwzMldFNEtrUHBOSkswTkcveEk4VEF4QS9L?=
 =?utf-8?B?Q2RiU1FOVmZZRjhZR3hoZEt5Q3R5U01wblBMbzdmRGlpRmZNUDloTEFtRXNN?=
 =?utf-8?B?Y2N4VStIbEtVaDBPWmtJSXlRS044R0c1U2JRYTlHVGVZVHBXa3JMTFM2U29U?=
 =?utf-8?B?M2xjaTEwUlNHaFo4TU1XQ1BjVVRya01sVVk5MUVlekNRRnlFc1N5VmFSL25I?=
 =?utf-8?B?cDBKODJQQkJ6RUhCbjNCK0JvS1pqb0c1ejRJWVA2QzRxYTJaMTFSMXJmRXVO?=
 =?utf-8?B?alp3QkIvdWU1SWRrTU1CU1ovMWFlZVl1eU9zZnhWM3E1MnhBU3EwalpPTTla?=
 =?utf-8?B?TkZhRlBsUWFQR2tza0tXeWIzd0d5a25DM3d1Z0w0My9JQXdWWDBxakNROXJH?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D58C9B933485A547B973EE3533A21CD2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a84ff2-3a80-46e9-e631-08dc2f38201d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 21:42:08.3082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8HJpFikhRwXOKeQ1tO6X1+4tkx/UTlb8hUWo9VrC+oMjOnwhXCctyQ3DTWDqvOYDZ34TxdFm/ONMEiA2bNBHHYoTVRxv23xTq61QHtcfMVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7968
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAyLTE2IGF0IDE0OjMwICswMjAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IENvbW1lbnQgaGFzIHRvIGJlIHVwZGF0ZWQuDQoNCkRvaCEgSSB0aG91Z2h0IEkgZml4
ZWQgdGhhdC4NCg0KPiANCj4gT3RoZXJ3aXNlLCBsb29rcyBnb29kOg0KPiANCj4gUmV2aWV3ZWQt
Ynk6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4N
Cg0KVGhhbmtzLg0K

