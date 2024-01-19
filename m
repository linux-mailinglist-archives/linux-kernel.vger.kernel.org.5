Return-Path: <linux-kernel+bounces-31466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDCF832EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108841C248E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4844A5644B;
	Fri, 19 Jan 2024 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HeldQZSZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD7F56442
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688039; cv=fail; b=gVxK8D+cbnTae2mJXaZwYO2CJFl0C8WqFsit51GyvELR083d/jayrZBQSco/272WNWB2p9l1Xje3QubxGZavfaG8fndhgBbaIiApoOrSFIfTWDHotDb5A8eWCZTGeFVjTDS8Xex5sqp/DQPj4AKo3eCXzoJ/dqfG8U+CDXcR30U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688039; c=relaxed/simple;
	bh=x3EPMBdcncok+XAH94NU+GhJYwBlZntiEb26x8d8RkE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hMfv62ZS+zoCCD5gkrjTQiwmOJ7dIOdbQH0DoaOom7hmQpp1qxeY1DWJwWMd8FBq22hjEEOyN71cilJgH/22mqQUIxXYDZXrCV9AhAJ0KwWRHxG0dwyltQv2dy6gpu6GXrwACNSCYed6kk7dL7rJ9aWv/tYHVgrLWfa5tF52xlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HeldQZSZ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705688037; x=1737224037;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x3EPMBdcncok+XAH94NU+GhJYwBlZntiEb26x8d8RkE=;
  b=HeldQZSZKVhXzw8LRwTGYA9ZT/R2AAcKu1fWZ4Bh/S7dCw1Cx273vvGT
   mT+U9gzz16C/V5ncKBgJxeLtjuH+E8b9U94cpAFl33y89dhqPxPGRBNFV
   CJAyEUPPUBtXuUxoRznQWkXdf5z1U0j7fvsMk5bmZ3Rt4WgmF+/Tnhnbi
   F9Wp01eD8XNuaESzJ305VP9Q6UEbB0lZuS9vBIO/11kw42hMCztQ30YmC
   C8jOaDu4uriQrRHIFVmIJYLLHMikDYDNN+WFm1B42J19E7NvefVeSJT/E
   4Aj4mqbZJDE+i9CYFn5u+Pq7zeFrUY3D3HMXwspCob/KHvMOe5g945LPP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="7497377"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="7497377"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 10:13:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="855389359"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="855389359"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2024 10:13:55 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 10:13:54 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Jan 2024 10:13:54 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Jan 2024 10:13:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFID7I/CAihwi1UzRVwA4W0lMBo+O10a9UdchTTJQL6akoKndBcmWmnN4FKCBY06iZz63yXDpcOP8FL+04ihsoff+E/ef0GMN1RP7XbOi9DBsW2bE3ycnXWceRakI/QvAPXA8FVeCwYm6aLQ5dt5Af4fDfIc9KRuS9gQ2ryZNbUfdMyFe6lu58xJnn9Br3gAmqIr7SNUvEw4RaqyzBwMcEflCOKjBT9kxzdwxUHZyPraLO8yDTK4jrYfPZenzCGJJxRnL77sFKyPVaJ2hrEFfBNwXQ6XCUaxdr+CEaLkGXLP5PftgG7sty8eGuXDsXNeD9SC+2gkatRfx5ccVsh45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3EPMBdcncok+XAH94NU+GhJYwBlZntiEb26x8d8RkE=;
 b=XD5RY5mCAVx2A4uaS8L9pBjV8pIaTntcxtd5EhUZjsxBrXsJwpWdCN9Nq7LgmKk1D1yxRBCYYizqcSH1IrWpw+HR1PBbI+aKkYUMTARcqr3XyAW5lZynB6pczJYtviVdFYsMcilv3uG+QafcnQ0ucPd+ghGbA7y9/texx4liBmkDtTDCwb7Z6Lzlt70KI2D0/LueJ4sCpEkPbCue1zlWLSeky4o90t0j+N8mx/g9QmnB7f0Ay3buUinLWvy7cfMIwzcC2wWhnA5rUAVYrjmaSll5CblhOdnpSvn5ot0KwKaPY5jJ3tda+m23w49240NTQgsn5eYYsD25cH7eSnvp3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by SN7PR11MB6971.namprd11.prod.outlook.com (2603:10b6:806:2ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 18:13:45 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::5b82:196c:15fd:3931]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::5b82:196c:15fd:3931%4]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 18:13:45 +0000
From: "Souza, Jose" <jose.souza@intel.com>
To: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
Subject: Re: [PATCH] devcoredump: Remove devcoredump device if failing device
 is gone
Thread-Topic: [PATCH] devcoredump: Remove devcoredump device if failing device
 is gone
Thread-Index: AQHaSX7mrWzDXAwsLkWbZYQ7k0wfPrDhc3qA
Date: Fri, 19 Jan 2024 18:13:45 +0000
Message-ID: <b0fb26b5912ca3e6f3b6239e15b4dd02ebecd919.camel@intel.com>
References: <20240117195349.343083-1-rodrigo.vivi@intel.com>
In-Reply-To: <20240117195349.343083-1-rodrigo.vivi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|SN7PR11MB6971:EE_
x-ms-office365-filtering-correlation-id: 08183fff-34dd-4264-e1ab-08dc191a605f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B1N9koSzgEfpAY0nFZ361ZITXpmIJjb9I1FSU5gwKkv5ukQ9Knq+d9R4iGlpjaQfTEKJokEVGXNShD7DHFa2yIHh6JFok/d3OXCnn51f1d4k75kXDM1kG5DDJfiH+KVrcm/0dn9sHQu52OR+8AA89jXQ2miSuEvpAoWIHvQw2uyBLPdaQdNuh1u/a1RBHT6IydfYPy/Y9uLU+qOfOY1s/+dCp+6xI//YbInavc8rZJxu+p05NWym3ux+nFS7Hx4LkHyr1owDvxJ8Wu6hgJPv17Ko9Xzlrm9txpiE0hvzvSlyecyckY3dngWrpKA2LsitsUGzgqh+wuwnA42+qRopAPIGXEBreuXScJY4KCyJgXg4Rnsp230eGfTfov70A+yFF/W3aO+UWxvwHiHf/sA6j2QJRbPAgbIQFxixU1hRrqXefoKo5vV5Yu00Vtu6fq0H4ecAeW4+VF439FnyurXt6l734FpdUWFjFV/vCM1ps/oQTGSCjrMHuZWTWI6vurxidakHblDnoffEHjKsPdNTIgZwUTx2s8hCKfmLF+oi4XeGl6q4kSyrvCN+xQpApXG2U7oOHLbCHvHfeYhkPg0z4o4cc7ZMsTVt/HGuRoxbC5IF0d+yIy+/SNHt++vkWnlM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2616005)(26005)(6512007)(6506007)(71200400001)(83380400001)(86362001)(316002)(8936002)(4326008)(8676002)(82960400001)(66446008)(76116006)(110136005)(6486002)(54906003)(478600001)(91956017)(66556008)(38100700002)(122000001)(64756008)(66476007)(41300700001)(66946007)(36756003)(5660300002)(2906002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cng2UFo0cU80Szh0THFNRkVKZWNWZW91YXpVOVZzbjNURlFFT3grN05aOGlk?=
 =?utf-8?B?dDN0OFRYeEtLZklsVUwrMWs4TFNKYWR5akxoeFBobGhsQmNvSU54b1pyOVgy?=
 =?utf-8?B?Y2gycFhvVUhwUkcwblRZNUxTdVh6QlFEQ1NFZ3FoTHFvQ2IrNnVVSDBFTnRK?=
 =?utf-8?B?L25xeHVOaitGYjhzRW11dHVESEptTVVYdlR3Ym5pck1sWWpyK2hyLy9GTCtI?=
 =?utf-8?B?S1hQcVptWU9HQWY1SytNM0FEcWwrdlZBeDhRMnFERGhRQ0VQa1JHbm5DZUR6?=
 =?utf-8?B?b1QzYW1IZFhrdHc0WVhQNjlhZERBeGo5QUg3a09oK1k0ai9GMlgzV2tPbFVL?=
 =?utf-8?B?bFFJZHdyd0NRN1ZHUDAwczdwTGgyQlFRQU1jTFdwM0tseHcrb3BTMnhWOVlh?=
 =?utf-8?B?Kzk2Y0ZtcW1zQVBJZUwwZllKQ0VlY0g1RGRVV3Z1dEg1aWpMMnIrbGNuM0J3?=
 =?utf-8?B?b2lDQkY5THFJU1NlLzVjb3pQTGpydUsrZGFwN3FvTkpvYUdXM2xKei9JQWtS?=
 =?utf-8?B?ZUt4NlRHYUxaNFFhMmpJcGt4M0ovYWJ5VVN4dU5zTGVPOHM3NExLSFhvT1dr?=
 =?utf-8?B?ZkRsMzlhNnJEd0ZiK296dmxkbTdJMXlpSjhzNGRJMWhhTUdtK0h1SlJoSG1i?=
 =?utf-8?B?VkJBb21jcTJXS2ZjUk1aRHhkMStGeEs2d050RmovNUhJYmwrSitpRFU0WkF0?=
 =?utf-8?B?QXhTQmo0SCs1NWJpUlFOTkJ4QlRyNnBZaUZuY29JU1ZldVJnaTc5VWM3cUUr?=
 =?utf-8?B?OW1lWHhQemFvVDJqUWxjSVFnRXBaTWVrc0tLdlhsUUxabUZPdlFhTmxzaXBt?=
 =?utf-8?B?NnYvdzV3YzRPeEQ2UXpnN3l6Z25qQ2NDbTBSeVhBM1c1bmd4Q09VVThQSm1v?=
 =?utf-8?B?aWZIZWpOcVJYeWtxYW4rS0xOYlZIcW9HbGFGQU04VEg1ZDF1eHdtSnV3U1Jr?=
 =?utf-8?B?NW03a2JlWkpBREd2WXJKUlY3aURvL2JSeXQ4TkZXanBmQkNzdjlGNWR6Smxz?=
 =?utf-8?B?TFR0SXQ1bWcyOU1hVHo0YnZmc3pzVVlLelo3TWs2Rlo1MU5QeElZZk5EdjhC?=
 =?utf-8?B?VUtSRldLazBiM3BMakIzOWJSV3V5akVoYzQrVks1dGFWV28xaWtpNUVUYnpX?=
 =?utf-8?B?MWY4S0pVSUlLNys0M0FxVDh2U3JaOWcrc3ZpeXJscTR2aW1hVm1hWkVhOHVQ?=
 =?utf-8?B?bUpnNzFsTnZYUFAyYmlvcXEvUnlNaWZLZEM2UUxUZ2lnd0FxTElySklFeitm?=
 =?utf-8?B?bFJhZG9MUTUxZVhKT2RCdDh4VFltNTlVZU5MRlhyQjNrYVRJYzg3bTBUbDA3?=
 =?utf-8?B?RTdCZi9Nb1V2cDMwcVNWcU9tWFMzV1pwRC9JZndtRER0NjBUcDVnVndzbWUw?=
 =?utf-8?B?MnBBZGFJYnUrZDlCeitGSHFIWGgvRzdOSDJWcW5oaVRmeVBpSE9BYm10a2kw?=
 =?utf-8?B?Vi9JQ21qZlVBUlpVYVlDTmxHb1RtU2Qxem84eDFNdnRxb0JmQ2ZiMm1RNkVZ?=
 =?utf-8?B?Yk41a1FpNDB3R2U1N0hyQWhWcFJoRDBtN3B6WEk2Q3hpSThPUkFZUWMzMXhj?=
 =?utf-8?B?QXJsdURINjRlbHBFeWowOTNGc29yblQ2QllUTm1vMTVaRmticWdmYWs1UlFR?=
 =?utf-8?B?eVpUcWdPS05wc0R5ZGliTlZQNVZCaDdTMzJwTFVCN09FSndoNXkycHBnekhU?=
 =?utf-8?B?ZXhOSlRZQSt1dkFwSXZNTWlzTFNBRUJUWnVlTTZyRnpYUi9GZHpobTZMak1z?=
 =?utf-8?B?ZTZTeGpKeC9FUnN1emYwcEFrQ0JGQ1Urd3pkUllOamVxaERXZXpOUXJ0cUp2?=
 =?utf-8?B?cG5oTmJqL0tHQ3p3bm1MWlhZd1dOWFh4RUZMb01zaTI4aGVFNHBRYllhcEp2?=
 =?utf-8?B?aVdrYW1VeUtzZlFrc1B6Q0hmUzJCQXR6YVByb3poT3E4Syt2T2FqS0JDNHZ2?=
 =?utf-8?B?THNhazZQcyt2alNXSTROdHN6c2tWRVluaFg0OHFidGNiZ1NLREpVSXVpSzlD?=
 =?utf-8?B?Q2k3bHZmWXNSNzMrMzUzSThXR2gvSE1TZkdDbCtQSEg5QWlzVC9rdm5FMzRv?=
 =?utf-8?B?cEVUME1GckU1RDlvczRtS0lMYW10Z0ViTkhiaDgzK1gvMGNoYjZHdlJ4dlhz?=
 =?utf-8?B?VnF5WW9vZEdrTU14cjNZT0tlZDRiZkxrdjNvcGR3RVExelNQOTZVd1R6ekVk?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FE663E0FA45DC419087292D83421542@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08183fff-34dd-4264-e1ab-08dc191a605f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 18:13:45.6061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XH+vxzFlmiROKuB2reH5FqdaeT2BHP1a5AuWaUwC+0uM9EjTL7myZrEqHxilsEnjOjChBnX0ytBTC4wY9l1BxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6971
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAxLTE3IGF0IDE0OjUzIC0wNTAwLCBSb2RyaWdvIFZpdmkgd3JvdGU6DQo+
IE1ha2UgZGV2X2NvcmVkdW1wbSBhIHJlYWwgZGV2aWNlIG1hbmFnZWQgaGVscGVyLCB0aGF0IG5v
dCBvbmx5DQo+IGZyZWVzIHRoZSBkZXZpY2UgYWZ0ZXIgYSBzY2hlZHVsZWQgZGVsYXkgKERFVkNE
X1RJTUVPVVQpLCBidXQNCj4gYWxzbyB3aGVuIHRoZSBmYWlsaW5nL2NyYXNoZWQgZGV2aWNlIGlz
IGdvbmUuDQo+IA0KPiBUaGUgbW9kdWxlIHJlbW92ZSBmb3IgdGhlIGRyaXZlcnMgdXNpbmcgZGV2
Y29yZWR1bXAgYXJlIGN1cnJlbnRseQ0KPiBicm9rZW4gaWYgYXR0ZW1wdGVkIGJldHdlZW4gdGhl
IGNyYXNoIGFuZCB0aGUgREVWQ0RfVElNRU9VVCwgc2luY2UNCj4gdGhlIHN5bWJvbGljIHN5c2Zz
IGxpbmsgd29uJ3QgYmUgZGVsZXRlZC4NCj4gDQo+IE9uIHRvcCBvZiB0aGF0LCBmb3IgUENJIGRl
dmljZXMsIHRoZSB1bmJpbmQgb2YgdGhlIGRldmljZSB3aWxsDQo+IGNhbGwgdGhlIHBjaSAucmVt
b3ZlIHZvaWQgZnVuY3Rpb24sIHRoYXQgY2Fubm90IGZhaWwuIEF0IHRoYXQNCj4gdGltZSwgb3Vy
IGRldmljZSBpcyBwcmV0dHkgbXVjaCBnb25lLCBidXQgdGhlIHJlYWQgYW5kIGZyZWUNCj4gZnVu
Y3Rpb25zIGFyZSBhbGl2ZSB0cm91Z2ggdGhlIGRldmNvcmVkdW1wIGRldmljZSBhbmQgdGhleQ0K
PiBjYW4gZ2V0IHNvbWUgTlVMTCBkZXJlZmVyZW5jZXMgb3IgdXNlIGFmdGVyIGZyZWUuDQo+IA0K
PiBTbywgaWYgdGhlIGZhaWxpbmctZGV2aWNlIGlzIGdvbmUsIGxldCdzIGNhbmNlbCB0aGUgc2No
ZWR1bGVkDQo+IHdvcmsgYW5kIHJlbW92ZSBkZXZjb3JlZHVtcC1kZXZpY2UgaW1tZWRpYXRlbHku
DQo+IA0KPiBDYzogSm9zZSBTb3V6YSA8am9zZS5zb3V6YUBpbnRlbC5jb20+DQo+IENjOiBNYWFy
dGVuIExhbmtob3JzdCA8bWFhcnRlbi5sYW5raG9yc3RAbGludXguaW50ZWwuY29tPg0KPiBDYzog
Sm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4NCj4gU2lnbmVkLW9mZi1i
eTogUm9kcmlnbyBWaXZpIDxyb2RyaWdvLnZpdmlAaW50ZWwuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvYmFzZS9kZXZjb3JlZHVtcC5jIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9kZXZjb3JlZHVtcC5jIGIvZHJpdmVycy9iYXNl
L2RldmNvcmVkdW1wLmMNCj4gaW5kZXggN2UyZDFmMGQ5MDNhLi42ZGI3YTJmZDlhMDIgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvYmFzZS9kZXZjb3JlZHVtcC5jDQo+ICsrKyBiL2RyaXZlcnMvYmFz
ZS9kZXZjb3JlZHVtcC5jDQo+IEBAIC04LDYgKzgsNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L21v
ZHVsZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L2RldmNvcmVkdW1wLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvZGV2bS1oZWxwZXJzLmg+DQo+ICAj
aW5jbHVkZSA8bGludXgvbGlzdC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gICNp
bmNsdWRlIDxsaW51eC9mcy5oPg0KPiBAQCAtMTE4LDE5ICsxMTksMjQgQEAgc3RhdGljIHNzaXpl
X3QgZGV2Y2RfZGF0YV9yZWFkKHN0cnVjdCBmaWxlICpmaWxwLCBzdHJ1Y3Qga29iamVjdCAqa29i
aiwNCj4gIAlyZXR1cm4gZGV2Y2QtPnJlYWQoYnVmZmVyLCBvZmZzZXQsIGNvdW50LCBkZXZjZC0+
ZGF0YSwgZGV2Y2QtPmRhdGFsZW4pOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgc3NpemVfdCBkZXZj
ZF9kYXRhX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxwLCBzdHJ1Y3Qga29iamVjdCAqa29iaiwNCj4g
LQkJCQlzdHJ1Y3QgYmluX2F0dHJpYnV0ZSAqYmluX2F0dHIsDQo+IC0JCQkJY2hhciAqYnVmZmVy
LCBsb2ZmX3Qgb2Zmc2V0LCBzaXplX3QgY291bnQpDQo+ICtzdGF0aWMgdm9pZCBkZXZjZF9yZW1v
dmVfbm93KHN0cnVjdCBkZXZjZF9lbnRyeSAqZGV2Y2QpDQoNCnRoaXMgZnVuY3Rpb24gY2FuIGFs
c28gYmUgdXNlZCBieSBkZXZjZF9mcmVlKCkuDQoNCk90aGVyIHRoYW4gdGhhdCBMR1RNLg0KDQo+
ICB7DQo+IC0Jc3RydWN0IGRldmljZSAqZGV2ID0ga29ial90b19kZXYoa29iaik7DQo+IC0Jc3Ry
dWN0IGRldmNkX2VudHJ5ICpkZXZjZCA9IGRldl90b19kZXZjZChkZXYpOw0KPiAtDQo+ICAJbXV0
ZXhfbG9jaygmZGV2Y2QtPm11dGV4KTsNCj4gIAlpZiAoIWRldmNkLT5kZWxldGVfd29yaykgew0K
PiAgCQlkZXZjZC0+ZGVsZXRlX3dvcmsgPSB0cnVlOw0KPiAgCQltb2RfZGVsYXllZF93b3JrKHN5
c3RlbV93cSwgJmRldmNkLT5kZWxfd2ssIDApOw0KPiAgCX0NCj4gIAltdXRleF91bmxvY2soJmRl
dmNkLT5tdXRleCk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBzc2l6ZV90IGRldmNkX2RhdGFfd3Jp
dGUoc3RydWN0IGZpbGUgKmZpbHAsIHN0cnVjdCBrb2JqZWN0ICprb2JqLA0KPiArCQkJCXN0cnVj
dCBiaW5fYXR0cmlidXRlICpiaW5fYXR0ciwNCj4gKwkJCQljaGFyICpidWZmZXIsIGxvZmZfdCBv
ZmZzZXQsIHNpemVfdCBjb3VudCkNCj4gK3sNCj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBrb2Jq
X3RvX2Rldihrb2JqKTsNCj4gKwlzdHJ1Y3QgZGV2Y2RfZW50cnkgKmRldmNkID0gZGV2X3RvX2Rl
dmNkKGRldik7DQo+ICsNCj4gKwlkZXZjZF9yZW1vdmVfbm93KGRldmNkKTsNCj4gIA0KPiAgCXJl
dHVybiBjb3VudDsNCj4gIH0NCj4gQEAgLTMwNCw2ICszMTAsMTIgQEAgc3RhdGljIHNzaXplX3Qg
ZGV2Y2RfcmVhZF9mcm9tX3NndGFibGUoY2hhciAqYnVmZmVyLCBsb2ZmX3Qgb2Zmc2V0LA0KPiAg
CQkJCSAgb2Zmc2V0KTsNCj4gIH0NCj4gIA0KPiArc3RhdGljIHZvaWQgZGV2Y2RfcmVtb3ZlKHZv
aWQgKmRhdGEpDQo+ICt7DQo+ICsJc3RydWN0IGRldmNkX2VudHJ5ICpkZXZjZCA9IGRhdGE7DQo+
ICsJZGV2Y2RfcmVtb3ZlX25vdyhkZXZjZCk7DQo+ICt9DQo+ICsNCj4gIC8qKg0KPiAgICogZGV2
X2NvcmVkdW1wbSAtIGNyZWF0ZSBkZXZpY2UgY29yZWR1bXAgd2l0aCByZWFkL2ZyZWUgbWV0aG9k
cw0KPiAgICogQGRldjogdGhlIHN0cnVjdCBkZXZpY2UgZm9yIHRoZSBjcmFzaGVkIGRldmljZQ0K
PiBAQCAtMzc5LDcgKzM5MSwxMCBAQCB2b2lkIGRldl9jb3JlZHVtcG0oc3RydWN0IGRldmljZSAq
ZGV2LCBzdHJ1Y3QgbW9kdWxlICpvd25lciwNCj4gIA0KPiAgCWRldl9zZXRfdWV2ZW50X3N1cHBy
ZXNzKCZkZXZjZC0+ZGV2Y2RfZGV2LCBmYWxzZSk7DQo+ICAJa29iamVjdF91ZXZlbnQoJmRldmNk
LT5kZXZjZF9kZXYua29iaiwgS09CSl9BREQpOw0KPiAtCUlOSVRfREVMQVlFRF9XT1JLKCZkZXZj
ZC0+ZGVsX3drLCBkZXZjZF9kZWwpOw0KPiArCWlmIChkZXZtX2FkZF9hY3Rpb24oZGV2LCBkZXZj
ZF9yZW1vdmUsIGRldmNkKSkNCj4gKwkJZGV2X3dhcm4oZGV2LCAiZGV2Y29yZWR1bXAgbWFuYWdl
ZCBhdXRvLXJlbW92YWwgcmVnaXN0cmF0aW9uIGZhaWxlZFxuIik7DQo+ICsJaWYgKGRldm1fZGVs
YXllZF93b3JrX2F1dG9jYW5jZWwoZGV2LCAmZGV2Y2QtPmRlbF93aywgZGV2Y2RfZGVsKSkNCj4g
KwkJZGV2X3dhcm4oZGV2LCAiZGV2Y29yZWR1bXAgbWFuYWdlZCBhdXRvY2FuY2VsIHdvcmsgZmFp
bGVkXG4iKTsNCj4gIAlzY2hlZHVsZV9kZWxheWVkX3dvcmsoJmRldmNkLT5kZWxfd2ssIERFVkNE
X1RJTUVPVVQpOw0KPiAgCW11dGV4X3VubG9jaygmZGV2Y2QtPm11dGV4KTsNCj4gIAlyZXR1cm47
DQoNCg==

