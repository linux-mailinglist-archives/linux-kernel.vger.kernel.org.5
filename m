Return-Path: <linux-kernel+bounces-44140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C6E841DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CBDD28D9BB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E927455785;
	Tue, 30 Jan 2024 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FxkbFjEy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F88456B70;
	Tue, 30 Jan 2024 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603628; cv=fail; b=Uh6sybad6cuFspD9mVAu+1V4Y1gsXnq9hDC/SXlDj5+Zz10QOOeQdRPwakweqWK+ORfnACbg0wuRtMX8BsFUqyV/79if/a9L7I0isguqTJvUmjOogtnOstF2JKFnirvc3GlmBWlZfUdyWKT+9YuNan9ARSMrDwPQp/JiNpdx1QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603628; c=relaxed/simple;
	bh=lmiZSjtiKohHYCnQTpfyGOOhBiKusASVH25ubycrz+A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qnwLb8YehqrAKeho4vkrR86uP5C6a2DjKyoK8TzCRWmsSlyrLsLxchic6FcIKZ6lw4Lo4I2ma98vKjlawgwo485MANsP89C5Ed6ZaHi7Yay+awdsKGvx6zsxlPLoLpyA/1lvXmlKsAz4WKnA/1FZoGimOaKJDBZxTLVf/SeJTGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FxkbFjEy; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706603627; x=1738139627;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lmiZSjtiKohHYCnQTpfyGOOhBiKusASVH25ubycrz+A=;
  b=FxkbFjEyCRd1bG/+1FDy8bgeihQN1UnKJEhMfwESTgswOttk2kNZDG4H
   ChJl1JNRrnSSS3lx5ej/SfkRddjiCphpUv+C4ai8RY5NtnimgcJlxST15
   MUKCzNK1cC/IGeLDyZj2SRBbUirn79fmA+EghKJODKTbGz2fCBl7k2lix
   5SWpBcmSAQWSYiaQ8gqr8ht68z15BtWtEOh+00N/c0IhtGPl3Wj1Yz6Ly
   9vgqko9x+0oJVlNEWE66aNaXeo48F4isBOMlsMHN2JRF2BTXXX/wFUEzE
   sADM7badFlJpi1tO39czmn26TkQiDVsjoYMfPcvSdXjr2PQg06G+2Nvt5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="10598007"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="10598007"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 00:33:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="36430061"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 00:33:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 00:33:45 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 00:33:45 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 00:33:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdzfYWBeAHotTz7NIvsAvRG4yQcY/1Fg5oKxebxc56pQGLceg76zeCFvgc7Y4/XQQapKDzMcxUxf6km+eQ4hG6VF1K3koXOxJOpmiysTa1dQI/e3cHKwTeelmWbKYgihABVxkJx6ER/20vdInVITRiyMhmhuXVA6HsmKsYK1YbLo+AB6wkybGSWAc1IsZwZT8G195IZip5sd4QHeRJ1vddsdGA7wUANjMSfnUNL+earurlXWytFkxSeSWPufpw7qZ3sd2qbG+nV6DlpPTf28hc5sN6hAT9B0Z17W1ASUR5gPJFyHDIyoIJMps/n7gdrjVshc3O4AVWGisYZ/OrjLHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmiZSjtiKohHYCnQTpfyGOOhBiKusASVH25ubycrz+A=;
 b=WabjXE7RZ4R1ue/gCn+O68fOjwYcIB/gz4cZD2OVSkvZT4GG0N9BhvoE5UO6uLU9ud+Cey8+PBpHARmo6XUFtXT15tWq4+Z2Ciy5MmS2SswyxycB1/EP8n4BkQytQFQYOnsO0ZXSn9Vb6VWTj9xpIbwh2WnGPDDQsq/Gwo9KkKYXvqlt8uueDXt8LMxhFNjchwJRd4xzHmNxGGWKf5M0JaO+k3pUO8mN+Urj5d/mMshDC1Y4jtgk9rzMU6VbAsglFSv0csZMNEqRa/g/OHoE+duQfdRadj6HMIljO0aZ1O2YlMkti0bbSmZ+7ZPKaKLnh7nmnL/Klhwg4bMsVdgkwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by SA3PR11MB7556.namprd11.prod.outlook.com (2603:10b6:806:31f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 08:33:44 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::c9fc:2945:7b2f:70e3]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::c9fc:2945:7b2f:70e3%6]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 08:33:43 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
CC: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Suresh Kumar
	<suresh2514@gmail.com>
Subject: RE: [PATCH iwl v2] i40e: print correct hw max rss count in kernel
 ring buffer
Thread-Topic: [PATCH iwl v2] i40e: print correct hw max rss count in kernel
 ring buffer
Thread-Index: AQHaU1YGwLKgtO7XO0SZEBb5xKIVdLDyBrcw
Date: Tue, 30 Jan 2024 08:33:43 +0000
Message-ID: <SJ0PR11MB5866EAA3CBAF4E28842305D5E57D2@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20240120072806.8554-1-suresh2514@gmail.com>
 <e524c57e-fe43-4582-bb05-c50f3e529848@intel.com>
In-Reply-To: <e524c57e-fe43-4582-bb05-c50f3e529848@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|SA3PR11MB7556:EE_
x-ms-office365-filtering-correlation-id: e3db0d47-d869-4458-34b6-08dc216e2b40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Qv3NZohlqoOFmFigBo0C9YxUILKbOdXTxvKz5cVg5tImryQeoWkg/kYuXzst02WvBB3N5JWCYaBhz63INPNQZFwF6D5Fz3nqu0LyMXSDvAa8z+x3u5RtZFlmM1TzKQCCuxLfUPruz5cJps85y4O8PrHyUXZkl5KPME9ReoSr3xUdwaQ5yzrWyVSeGvLCEFzLhsIaTO4wYpClcHlWBMNVij+pRFpVPBbbVi1DPpQESkb6Nmg+n9p5X5/il9Rub+hlBADCy1nCUtMG6PfJIokCBy2HiOCXVaQ5rc7dLYuwgW2Jfy/OXVETKQg1xAox7iQGZq1k63viMCaMuCgSgJEy/I0TLBZWSO1SinkuS/kf+PewwU8o4r6/oXZLg8WoZIzD06/fHz3mMq8SkNR1n666U1AcA/pOXi7xkseJQusnVuce+tJLGXgwDJVgk1McmsOKbaz8UtZB7oQPLF+y0Aw228qYUfRs9Tdeel+iPU0RvcFhtuQd13p7me6GTM9jfGOmMLp7A8bgSCBnAepnvxVbGftnUPbIRPnZL6eBay5l6y+76Gkq2x750mVkvCgLQm8ubRHu8XkBIRL0CXYYCLn0wHZGrkbay+U66q51JW1pJYO1Qydj5iuNegxM7RhameG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(55016003)(7696005)(6506007)(53546011)(83380400001)(33656002)(86362001)(38070700009)(82960400001)(8936002)(41300700001)(52536014)(6862004)(4326008)(5660300002)(66946007)(38100700002)(9686003)(122000001)(478600001)(316002)(71200400001)(66476007)(54906003)(76116006)(66446008)(64756008)(66556008)(2906002)(6636002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDNBTm9OeVdXNm1QUm4weFFTTldleFRacTVrSmlmYjZkZUpyaTZBTVJOQW1s?=
 =?utf-8?B?VGEwNitvM3pXcVNXWm5mbVlIUDgyZ2lnNHp2czNjT1N1RDdackg4UVA4Uk1k?=
 =?utf-8?B?R3VkSmFsMW51UnlIYWthS3dkS0FoSThXejAzZW9JSjlWYnBnakFnaTZTL1RB?=
 =?utf-8?B?MHQ3T1N4KzVHczN3VDB0elk0R0JZdFV6b0R0OXBUQ1drLzQwWlZIdmtMVE5B?=
 =?utf-8?B?a3BndjJHTS9uTHF6TlFZSnFEdXB6Q1JNZVRjWHRuSzFzR1Zxbk9wQUtMdVJt?=
 =?utf-8?B?L2oraTZMYkZQRnh0aFRKTXo5Y1ZxQXF2S3Bpem41cFRiL0Y4TUdsV2wycEhS?=
 =?utf-8?B?ZFh4cGlBRmhPeTV3RXlDMTdSMTJmQ3RocFdLSmpEZE1sTTExOEFPckdqRTB3?=
 =?utf-8?B?TzQ3R1ZZL1BTWVFlTjJ4ckFRVXZBRVd6dmQvRFRRV2MrKzcyUzBTN0lOcjAz?=
 =?utf-8?B?S1FOUkxDV2tUZVM1WnhZNW9rZzNSVVdkWkxKYXVOb0llSEhtaTVnREdYMHZr?=
 =?utf-8?B?UlFkME1yVDFZV2l0eE9vUjRaSitkaVN3Uk9YN3FPNDlHeUJKbXZFbjgrQkwy?=
 =?utf-8?B?SEk5aVRXQWxxQ2N3QXBmVHU5dEhnMThiZksvSnZxS08yMkZRL2RPZVdFWGdu?=
 =?utf-8?B?NHhSV0M4bjhTMDZFaVJVbXhlZ0R5bGpYVDlpczJmNTArMVhxdkVodmJOOGwy?=
 =?utf-8?B?aG9lZ0lkbGk2ejg3S1o1MXJUWmVySmZGZzF4R0VlRk1ER204T0JQL1ZIQVRY?=
 =?utf-8?B?RkVlS2huRVIrc2FBMUhvcXJGTkRuR2xVVmtRUThhMDVUOUhkaUdialo4MERO?=
 =?utf-8?B?c25MOUl2UVNhRG5wUERZOXJ0WVJVTFJjMXMyck5TT1FIMStIRmZhbHpUZHRn?=
 =?utf-8?B?aC9jVFg5bGIvYW0xbnNNR3gyenVLREpDaG9oVWZGYi9MTTNxZmNsU2tHR1JH?=
 =?utf-8?B?eGJmaFVxVklJaWJNNmEwMWVJeS90Z2wvWHpRZyt5c2lUUFFhazdEeXZ4RXR6?=
 =?utf-8?B?UzNjS3h2SHI4WUMrcHFISXUzd0tCY05qZG5IN3pkUUNhN1YxWFY2aENMNi9E?=
 =?utf-8?B?cHdHMTVaVGVTRHRrSTloVHBIZmZhMS9VSm4zU2JHdjRkMkpZSEV0dUxqMjJt?=
 =?utf-8?B?Y0pTWm96Tm5DOSt5ejduR0haamo1Q2xUeU4yRVgyWjd2Sk1zL0FYZERjTUcr?=
 =?utf-8?B?RUpmSmkrVFZsQk1jT2k2UVR1YUk4TjVkVThtbk00c3EzdXlDalVZRUZxb09W?=
 =?utf-8?B?RnkrSWVOeWRYY0dQVlJ4dHVWMzhJZm9GK01uVWhnZnlYcW10SDBNNmsxZWdk?=
 =?utf-8?B?YUxOdnJHeGtzaGFlZlluMnUvYVJCcEw1K1BnRFJOS0dnL21rRjgzMHhaZHhm?=
 =?utf-8?B?SVpDbVowL3lNbWs4MDZDSEFnd1lhN3M4TFZWOHQwM1pSSDI5a25adWRiMndp?=
 =?utf-8?B?WEIxSHdjS2FXZW00Nng5cUFCTVhNbTRJS1RCdG9PWEtQUDBkaWl3Qk4xR2ts?=
 =?utf-8?B?MzJYL3lycHNLMGxhWFYxNVJqWW8xdVBHV0lYeUZ5dVl0Umw4NEp2ek90V1J4?=
 =?utf-8?B?VytlM2xRR2xGWFJMd3Q4V050Yk1COVk1cEFJajhGVXdOdkREOC9YOFdKaWhT?=
 =?utf-8?B?OWUweGpXSUZCVHhxZDZoL0ErWmxldWRCaDRRaHFMa2FwUmJ1UDQ0SlE5ZjMz?=
 =?utf-8?B?RHZhNndoYzE5VzNzQlJVMGw2TExoUm5wemlnZDJmVzUwTGRsVXBiNFloV0JI?=
 =?utf-8?B?eUNSNzlTRVdJRVU3RlZrUkxWR3dLYmlLZFNHRFo5Y3ArblZMeWRGbEFZSGlt?=
 =?utf-8?B?V0o2UEFrTXZUaTk1MHQ2UFFMWGVxT0NtbEY2ZEFrZmF0enlVZ2c5TXBNM1Q5?=
 =?utf-8?B?MG9QRVZYLzhGZlN2SzcxRDJZRGdwdXVnbUxnV2hqajg5dmlReDR6QkpQUHpC?=
 =?utf-8?B?VklGRVgwNVRPd0NBVTUwVk5ZQ1l3NFhzUXpRSHFqVVRxbFNzUDhjWjMxand5?=
 =?utf-8?B?WHorMjdmaldXc0IxM0FJVnE1QzJaY3ZJZkJERzFSdXdXUXFqSUE5SnQxeDV1?=
 =?utf-8?B?Y2hkSXllS0xhSEJRTDJwOHVEUXJHQm8vdHNhWjd6OTdzTjF2NlNRbXB2REk4?=
 =?utf-8?B?QnhaSTluV3BPMHZSdG40NU05M3FJanFNYkRub0t5VjlSSG9Cd3ByTVZCZG8x?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3db0d47-d869-4458-34b6-08dc216e2b40
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 08:33:43.5258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RhIiiJyk78hYdJXKOYX2t9z5BEoQkmzJUgWR+YhWTt8HOSNvJYpAEJwux8Qv5PFZxm5YcHBgdhFRWUB4ZTwDrSqAk47Tmb7O4czUT04XIjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7556
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLaXRzemVsLCBQcnplbXlzbGF3
IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5
IDMwLCAyMDI0IDk6MjYgQU0NCj4gVG86IExva3Rpb25vdiwgQWxla3NhbmRyIDxhbGVrc2FuZHIu
bG9rdGlvbm92QGludGVsLmNvbT4NCj4gU3ViamVjdDogRndkOiBbUEFUQ0ggaXdsIHYyXSBpNDBl
OiBwcmludCBjb3JyZWN0IGh3IG1heCByc3MgY291bnQNCj4gaW4ga2VybmVsIHJpbmcgYnVmZmVy
DQo+IA0KPiBGV0QgdG8gQWxleA0KPiANCj4gDQo+IC0tLS0tLS0tIEZvcndhcmRlZCBNZXNzYWdl
IC0tLS0tLS0tDQo+IFN1YmplY3Q6IFtQQVRDSCBpd2wgdjJdIGk0MGU6IHByaW50IGNvcnJlY3Qg
aHcgbWF4IHJzcyBjb3VudCBpbg0KPiBrZXJuZWwgcmluZyBidWZmZXINCj4gRGF0ZTogU2F0LCAy
MCBKYW4gMjAyNCAxMjo1ODowNiArMDUzMA0KPiBGcm9tOiBTdXJlc2ggS3VtYXIgPHN1cmVzaDI1
MTRAZ21haWwuY29tPg0KPiBUbzogamVzc2UuYnJhbmRlYnVyZ0BpbnRlbC5jb20sIGFudGhvbnku
bC5uZ3V5ZW5AaW50ZWwuY29tLA0KPiBkYXZlbUBkYXZlbWxvZnQubmV0LCBlZHVtYXpldEBnb29n
bGUuY29tLCBrdWJhQGtlcm5lbC5vcmcsDQo+IHBhYmVuaUByZWRoYXQuY29tLCBpbnRlbC13aXJl
ZC1sYW5AbGlzdHMub3N1b3NsLm9yZywNCj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZywgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDQzogU3VyZXNoIEt1bWFyIDxzdXJlc2gyNTE0QGdt
YWlsLmNvbT4NCj4gDQo+IHBmLT5yc3Nfc2l6ZV9tYXggaXMgaGFyZGNvZGVkIGFuZCBhbHdheXMg
cHJpbnRzIG1heCByc3MgY291bnQgYXMNCj4gNjQuDQo+IA0KPiBFZzoNCj4gICAga2VybmVsOiBp
NDBlIDAwMDA6YWY6MDAuMTogVXNlciByZXF1ZXN0ZWQgcXVldWUgY291bnQvSFcgbWF4IFJTUw0K
PiBjb3VudDogIDEwNC82NA0KPiANCj4gd2hlcmVhcyAgZXRodG9vbCByZXBvcnRzIHRoZSBjb3Jy
ZWN0IHZhbHVlIGZyb20gInZzaS0NCj4gPm51bV9xdWV1ZV9wYWlycyINCj4gDQo+IENoYW5uZWwg
cGFyYW1ldGVycyBmb3IgZW5vMzM6DQo+IFByZS1zZXQgbWF4aW11bXM6DQo+IFJYOiAgICAgbi9h
DQo+IFRYOiAgICAgbi9hDQo+IE90aGVyOiAgICAgIDENCj4gQ29tYmluZWQ6ICAgMTA0DQo+IEN1
cnJlbnQgaGFyZHdhcmUgc2V0dGluZ3M6DQo+IFJYOiAgICAgbi9hDQo+IFRYOiAgICAgbi9hDQo+
IE90aGVyOiAgICAgIDENCj4gQ29tYmluZWQ6ICAgMTA0ICA8LS0tLS0tLQ0KPiANCj4gYW5kIGlz
IG1pc2xlYWRpbmcuDQo+IA0KPiBDaGFuZ2UgaXQgdG8gdnNpLT5udW1fcXVldWVfcGFpcnMNCg0K
UGxlYXNlIHJlamVjdCB0aGlzIHBhdGNoLCBpdCBicmVha3MgZHJpdmVyIGxvZ2dpbmcuDQpUaGUg
bWFzc2FnZSBjbGVhcmx5IHN0YXRlcyB0aGF0IGl0IGR1bXBzIG1heCByc3MgcXVldWVzIG51bWJl
ciB0aGF0IGYvdyBzdXBwb3J0cy4NCg0KVGhhbmsgeW91DQogDQo+IFNpZ25lZC1vZmYtYnk6IFN1
cmVzaCBLdW1hciA8c3VyZXNoMjUxNEBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9tYWluLmMgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX21haW4uYw0KPiBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9tYWluLmMNCj4gaW5kZXggZDU1MTlhZjM0NjU3Li5m
NWMxZWMxOTBmN2UgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0
MGUvaTQwZV9tYWluLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9p
NDBlX21haW4uYw0KPiBAQCAtMTI1MjQsNyArMTI1MjQsNyBAQCBpbnQgaTQwZV9yZWNvbmZpZ19y
c3NfcXVldWVzKHN0cnVjdCBpNDBlX3BmDQo+ICpwZiwgaW50IHF1ZXVlX2NvdW50KQ0KPiAgIAkJ
aTQwZV9wZl9jb25maWdfcnNzKHBmKTsNCj4gICAJfQ0KPiAgIAlkZXZfaW5mbygmcGYtPnBkZXYt
PmRldiwgIlVzZXIgcmVxdWVzdGVkIHF1ZXVlIGNvdW50L0hXIG1heA0KPiBSU1MNCj4gY291bnQ6
ICAlZC8lZFxuIiwNCj4gLQkJIHZzaS0+cmVxX3F1ZXVlX3BhaXJzLCBwZi0+cnNzX3NpemVfbWF4
KTsNCj4gKwkJIHZzaS0+cmVxX3F1ZXVlX3BhaXJzLCB2c2ktPm51bV9xdWV1ZV9wYWlycyk7DQo+
ICAgCXJldHVybiBwZi0+YWxsb2NfcnNzX3NpemU7DQo+ICAgfQ0KPiAgIC0tIDIuNDMuMA0KPiAN
Cg0K

