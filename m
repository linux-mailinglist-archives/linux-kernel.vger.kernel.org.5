Return-Path: <linux-kernel+bounces-12485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5846D81F57D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4F81F2271B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B5B440D;
	Thu, 28 Dec 2023 07:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mL37iMrv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36DC3C1D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 07:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703748516; x=1735284516;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=mZVFZB46nxUodm4yJsew7PpB72xUaihEqbZ0yJ1eURQ=;
  b=mL37iMrvNlot3SPKLJ4ATCIJXx6hHEH21jxnIJRH2kR3YxNW2EM6XRkx
   Wj8kzvP0F4DH/gtjTESova6fgf1TkWP4XXFjNj1yGXEuNnHdvpX02y4yM
   5fGdzAEX6AI8mJSzf6R4NiEErmQW3O/H9vsKsdYHneTlVQCEWnf2ZMSiY
   L5FOwkSVFqsnOcoD0e7DLajnmqgNQW1IZzCfWESdxcMH3kHuX+5IbWo1G
   ixIACIl3GKOiCV+QehXT/0rKiO1/z1ghJl9jhCGnEAVv/sjG40qXDc8cj
   7V9pH4muaNjH3Wc9UIWkWLGXzHEOHobI/QOFa8rjqynIshdV9OW6sTHFj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="15183042"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="15183042"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 23:28:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="922032561"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="922032561"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Dec 2023 23:28:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Dec 2023 23:28:34 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Dec 2023 23:28:34 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Dec 2023 23:28:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8P9SQsazlFRq2Cbtq0cxmgexf1LdXBoZhJFySJE/F1n+Hv4IZL/D+mhlSFmpfXTn4cysq/7yrnFcfMA0NUThMVc8/FVvZnR0vxxbs54MpUofar7u2ObPLLAH2zScTIDZ3x542xaRjmXSiFIGS6gfKujTuek09xUPhT5riG7YCbv7Sjeb2VkMLBuqTEubgqkkWmPLBh+UYquBdniRFNzfvC7lvsziZxNrkN5pcwHCCDOCdiDD4gHVEp9AdmV8NMF+FQmRY4xr/hmu/aSmqDHu6G6IIDA9bJ+vPTCKX4jt2T3dYzZu7y/HW6ZB100kKoq2Z57HEI9KF2HQMqKy7BiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZVFZB46nxUodm4yJsew7PpB72xUaihEqbZ0yJ1eURQ=;
 b=GcJTVjd0mrXM+WyetN11zPr9WZqr1PJlqj8Lg1qywx7ly9dZpE1hGBO40GVjVRAjB4sxaztFqcStMmWvyyOlySq/2F7ztv5WUpCgTkMzoOWzjAiRRw9n/Cforvy779GEyNvYe1v//t1j6MBk+6187UyNyMd5qg9V6Vyy5zymcy4ed4UwSCjQT0udQEdvOtHh+Z4vqFQeczPTMCYZFRQCpUWTuMsDOQzDDC4eoQjySVegpQbACN7XThyjpOmrakZZ7L5bBHo7Fn4KKo5iU7IFLbaIaIfvpqw8vMcdaE+2iSHQdIr+OOkRu7JGiXXBm2/b8S8LVl9cIKhsiI+QhuyYKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4568.namprd11.prod.outlook.com (2603:10b6:208:266::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.30; Thu, 28 Dec
 2023 07:28:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7113.028; Thu, 28 Dec 2023
 07:28:32 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Zhang Zhiyu <zhiyuzhang999@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: RE: A bug was found in Linux Kernel 6.6+: KASAN: slab-use-after-free
 in iommufd_test (with POC)
Thread-Topic: A bug was found in Linux Kernel 6.6+: KASAN: slab-use-after-free
 in iommufd_test (with POC)
Thread-Index: AQHaOKOCc1QFGb+hlEeHePFloAgJCbC+TMPA
Date: Thu, 28 Dec 2023 07:28:32 +0000
Message-ID: <BN9PR11MB52761AA391479A55533BFE718C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <CALf2hKsJjDY3OhtMCxhHh7rS=2S4Oq9Ns=t-NFq1MPD=f0K02Q@mail.gmail.com>
In-Reply-To: <CALf2hKsJjDY3OhtMCxhHh7rS=2S4Oq9Ns=t-NFq1MPD=f0K02Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4568:EE_
x-ms-office365-filtering-correlation-id: bab5e6c5-a14e-4d0f-d149-08dc07769866
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xdD+jz+SjIXumRzX5Kj8Sa5ZcNg+z5YJ1IeJnv/xX6m5fgnnCPYMNRaYsVZgxTgYfYZj/Xb5TKoyNSo15F0PnMkeWusY9BjKSJ393lYWzeYxnaR0GgYy88Fs0E3N49u7/8vjdJ3T211RlUnDXaW4RejCt+RLMWOAqWn6xVDeemFKYuzfEUe3jIeUTKLmjvYOz2kwtvFUKnYC5QDeKv8tIcCu8Rbgr6FOvMgKmNVw4rbqyeWuQMfVlojquVDxUB3IxEYmoq9H2/N/+EWj01KwJTJBPTMUU7wNIQibFyF9/HIarKupTRm0e/XeeWP6/tHWwmfI3J7K4E6z4ItsSbpJmr1g2/Uhyq+/RyimYd2+slDCtkvZmHs/H1BWaJJ1Iga0tP3R2d6ZuRTkCKHlYgBdAZpI7QNjZ2pOSrDKlDnNTV5AfhZw8lsA0fpCl/e4aZE9WfovBjE7HvHzf2ahkKPwDhevKOpQpll4aOQ9ifr2ni2hfq9C0teGYKkPqfTbEM2fEhwyZN7QbhwheXzS0nqivaVNRIOHaCRCbDTNAG5NBpVlREWiiNF3YjMbieVGVbkmZsbRqJuQe0EimiyYRK7vi6dpqdHkpRG2zRLWSTNWviU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(7696005)(6506007)(71200400001)(38100700002)(9686003)(122000001)(66574015)(83380400001)(86362001)(478600001)(966005)(8676002)(8936002)(110136005)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(52536014)(33656002)(82960400001)(19627235002)(26005)(55016003)(5660300002)(2906002)(41300700001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0xLSWdmUVo1ZWxHSTBMVGRqd2Q1S1pMQytJR242WWFudzN0a2lHTDdGQVdO?=
 =?utf-8?B?M3MzWVYwbmJnaFk4NFF4dld3SFcxM1prbllycjZVZzEvK2U2Z0FidzVTcmRp?=
 =?utf-8?B?QzBXeDhDUlRlWi9UdlR6eXdmanhaM0Mxc0NFWE5nRHU4djlDS3ZDd2g4K2tQ?=
 =?utf-8?B?ZjFERmwrRDlyQTBpUXQrVDlVZHN5VkhkUWEvVk0wYktidkNTcll2amFxSncx?=
 =?utf-8?B?UGcxQ1FDbkRWdTVTbjlwNHFBQ002NjFyS3RONDdodFFuMWozbUVBblFYelVF?=
 =?utf-8?B?MVVjVjFmK3Nrc05lVVhyMzF6cExkczgwS0U1SGpPUGtqNFpoY0xxYlRiK2RH?=
 =?utf-8?B?QVlOaHVuYXJiUERhRGpTQkRaZjgwblFsNjdMRm9pYWxja2lQMjU2MTRuQk1S?=
 =?utf-8?B?NlhJOXdKWTJQQzNHQzJKby9kY0dxUnBoKzFmclozeERObG8vSjJVQXJSRFdQ?=
 =?utf-8?B?WlNPUGlFOEJXOWZjdW5LWEM1TlVWR2xVUVYrRlptbGZMMkd5RytzWTZyWmdL?=
 =?utf-8?B?S254KzQva2ZlK1JncFdtZmJMUmpDTHM5T1l6T3RURjlLN241UW8ySlBGaWwr?=
 =?utf-8?B?WnQ2dkZCUWhzSTVDZ0RGSXR0NktTUUc0bC9mNk5YR0JSNEZ3R2c3RFc1Nzd2?=
 =?utf-8?B?bmowZ2VlNjFCblBDVHV2SVpJbGVHdUwvdEpsWTZjcWs5WS80ZjZ5UXhPZkJh?=
 =?utf-8?B?VnU3NUVQckxXWkFWa3dDZys3RDFvUlJEYUV3U1NoOEtyaDh5M3EwNGh6MmM3?=
 =?utf-8?B?M2ZlTFFJVW9XUDA0QnBIUjRKUTZFZzFCeTVTYjBwa2NnL3hwZjRhY0ZNaTJ4?=
 =?utf-8?B?WkpCc0tFd1BGNVlwNjF1QkNNUWN5a0pLMWV2cmgwREFKQzdER01CbkxRMlMr?=
 =?utf-8?B?SzN2dWZjU3dhNHFFU0RCL0FUNUNkdjh3THZCNG12TjZlYklnOVJ0M3l1MWtn?=
 =?utf-8?B?bC82R2NvZThuSHd5Y3JTTnBtSThIaGZQUGw4SFQyVFM2UmUyTzBqd1FzQ3pC?=
 =?utf-8?B?MlZCYXlRSkl0djg5Y3NRZjlacncwdlBtckJZYmtvY1l0ZUtHUnRBOUM0T3Nx?=
 =?utf-8?B?d2hmWEJralJPd0owSWpGdzliNWg3Wm93cWlER29QKzJPTDRJTGtlbHBXWVR4?=
 =?utf-8?B?dmg2T1BiTEdKSmZDWlVOWjl5UkxRYlBQUGVqbEdsREJWMFV2VzBNRFRxYXEx?=
 =?utf-8?B?SGZGZ3NCNzBsenNTcTlrTFFkZDZJbUw2SWxkQ1RjVDh1cHJIb0U3OGRGRUhr?=
 =?utf-8?B?ejU3bnVScVpUQ0dJUFZzNHZRRWhkczdEMGZkZjFkbjdFU3NTdW9HcEEyUmkx?=
 =?utf-8?B?VlhOcXNIUXpFQStGUmROdThlbHNBU3R2WW1EdzNtSU1zSEVvMVJZSHMzd3ZY?=
 =?utf-8?B?SXNQNFRxRnZCMjVXeGRTZC9DVUNmNE9lSkdmSXUxSnRSWWE2eEpiT0YzWjc4?=
 =?utf-8?B?UVN4V3BxVk9EckdOVjdDZ3NIQkV1TVhrcVprN2FPeHBPS0wrVmYxbHR5VTFv?=
 =?utf-8?B?S25KeXhGT1cyY2hDUVRQZ1h2V2xXYjZaNFVJK0NrTHFNa0pGWnN3ZThURy9E?=
 =?utf-8?B?d3hvSkRCTkhZQ1BqN0FhZ3ZIcWl6TjQ5Q2V6eENZZHNHb1BnTTlDdTBzYnF1?=
 =?utf-8?B?VUcrVmR1dm5GZ01SRFhrcTNTYWFYSlpkcHhwNnNWaGRSNnZVK0JiS1dPN1Rw?=
 =?utf-8?B?UW0xZ21xTUdNQ2tPV1ZMZ2ZpVUxLMDFaMDI2NW1PQ2tSdjdoK1c1Vm9URjlu?=
 =?utf-8?B?VXRmQnpLTUxnd1NwVy90RmZXamtUV0dyWVJBbkRyYXVUV2lFb0c1MmRFR1hV?=
 =?utf-8?B?bS9zNDd6SW5DT1JiaWlHeXdvMGVXMlJ2b2I2L1RydElTWmZEWkoySnBaTU9o?=
 =?utf-8?B?dWdtSUN1V3ZuMXVLMTVJU1lqdXovOWUyQVhXYmF4aThzSXc5SEI5M1p4VEVH?=
 =?utf-8?B?eXpzelhsSkE4MXp3Q2hZZkdIY3RzZTU1OTFYRFgwMUJkSGRjZEpmYWFRQ1VE?=
 =?utf-8?B?d2diMlBpUUVmNmF6Z2ZwQjNDdGsyZGNYVlMzL1VGempKTGM4N3lpeCtnL3dL?=
 =?utf-8?B?OFVVQVdCam9EMU9qTFZ5L3I1M3U1WG5jSHRxMGtSREhQOTlROEx5RFZqWFZB?=
 =?utf-8?Q?SDo91rLPUI8+qdDTKMdvr/qnt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab5e6c5-a14e-4d0f-d149-08dc07769866
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 07:28:32.3568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CMsYLt9ZQI+u42FLospcEDxS+plo8X3K83phqozYYkAx0Fli3Eor9DjPn2EaDP6vvESPn95sZQqJJa5u/IKQ3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4568
X-OriginatorOrg: intel.com

PiBGcm9tOiBaaGFuZyBaaGl5dSA8emhpeXV6aGFuZzk5OUBnbWFpbC5jb20+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgRGVjZW1iZXIgMjcsIDIwMjMgNTowMyBQTQ0KPiANCj4gSGkgdXBzdHJlYW0gY29t
bXVuaXR5LA0KPiANCj4gSSBhbSBmdXp6aW5nIGEgTFRTIHZlcnNpb24gb2YgTGludXgga2VybmVs
IDYuNiB3aXRoIG15IG1vZGlmaWVkDQo+IHN5emthbGxlciBhbmQgSSBmaW5kIGEgYnVnIG5hbWVk
ICJLQVNBTjogc2xhYi11c2UtYWZ0ZXItZnJlZSBpbg0KPiBpb21tdWZkX3Rlc3QiLiBCeSBhbmFs
eXppbmcgdGhlIGNhbGwgdHJhY2UgaW4gYnVnIHJlcG9ydCwgSSBhZGRyZXNzDQo+IHRoZSByb290
IGNhdXNlIG9mIHRoaXMgYnVnIGF0IGRyaXZlcnMvaW9tbXUvaW9tbXVmZC4gQW4gaW9tbXVmZF9v
YmplY3QNCj4gaXMgYWxsb2NhdGVkIGluIG9uZSB0YXNrIHRocm91Z2gNCj4gaW9tbXVmZF9mb3Bz
X2lvY3RsLT5pb21tdWZkX2lvYXNfYWxsb2NfaW9jdGwtPmlvbW11ZmRfaW9hc19hbGxvYyBhbmQN
Cj4gZnJlZWQgaW4gYW5vdGhlciB0YXNrIHRocm91Z2ggaW9tbXVmZF9mb3BzX2lvY3RsLT5pb21t
dWZkX2Rlc3Ryb3kuDQo+IFRoZW4gd2hlbiB0aGUga2VybmVsIGludm9rZXMgdGhlIGNhbGxzDQo+
IGlvbW11ZmRfZm9wc19pb2N0bC0+aW9tbXVmZF90ZXN0LT5pb21tdWZkX3Rlc3RfYWRkX3Jlc2Vy
dmVkLQ0KPiA+aW9tbXVmZF9wdXRfb2JqZWN0LA0KPiBhbiB1c2UtYWZ0ZXItZnJlZSByZWFkIHdp
bGwgb2NjdXIuIERldGFpbGVkIHJlcG9ydCwgbG9nLCByZXBybywgY29uZmlnDQo+IGNhbiBiZSBm
b3VuZCBpbiB0aGlzIGdvb2dsZSBkcml2ZSBsaW5rOg0KPiBodHRwczovL2RyaXZlLnVzZXJjb250
ZW50Lmdvb2dsZS5jb20vZG93bmxvYWQ/aWQ9MW5ESldVc3RZSk5jQzF6SjZxMXINCj4gaEI1ekIw
dVYyeUd2ZyZleHBvcnQ9ZG93bmxvYWQmYXV0aHVzZXI9MCZjb25maXJtPXQNCj4gDQo+IFRoZSBz
dGVwcyB0byByZXByb2R1Y2UgdGhlIGJ1ZzoNCj4gMS4gY29tcGlsZSB0aGUga2VybmVsIDYuNiB3
aXRoIHByb3ZpZGVkIExpbnV4LTYuNi5jb25maWcNCj4gMi4gYm9vdCBhIHFlbXUgdm0gdGhhdCBy
dW5zIHRoZSBjb21waWxlZCBrZXJuZWwNCj4gMy4gc2NwIHRoZSByZXByby5jIChyZXByby5wcm9n
IGlzIG5vdCByZWNvbW1lbmRlZCkgdG8gdGhlIHZtIGFuZA0KPiBjb21waWxlIGl0IHdpdGggZ2Nj
IC1wdGhyZWFkIHJlcHJvLmMgLW8gcmVwcm8NCj4gNC4gZXhlY3V0ZSAuL3JlcHJvIGFuZCB5b3Ug
d2lsbCBzZWUgdGhlIG91dHB1dCBzdHVja3MgZm9yIGEgd2hpbGUgYW5kDQo+IHRoZW4gS0FTQU4g
aXMgdHJpZ2dlcmVkIGFuZCBrZXJuZWwgcGFuaWMuDQo+IDUuIHlvdSBjYW4gc3BlZWQgdXAgdGhl
IGNyYXNoIGJ5IHNldHRpbmcgdXAgYW5vdGhlciBzc2ggc2hlbGwgdG8NCj4gZXhlY3V0ZSAuL3Jl
cHJvIGFnYWluLg0KPiANCj4gSSBoYXZlIHJlcHJvZHVjZWQgaXQgb24gNi42IGFuZCA2LjYuMSAo
YnV0IGhhdmVuJ3QgdmVyaWZpZWQgb24gdGhlDQo+IGxhdGVzdCB2ZXIgNi42LjggeWV0KS4gSSBk
aWRuJ3QgZmluZCBhbnkgcmVsYXRlZCByZXBvcnRzIG9uIHRoZQ0KPiBpbnRlcm5ldCwgd2hpY2gg
aW5kaWNhdGVzIHRoYXQgaXQgbWF5IGJlIGEgMGRheS4gSG9wZSB0aGUgdXBzdHJlYW0gY2FuDQo+
IGhlbHAgY2hlY2sgYW5kIGZpeCBpdC4gQW5kIEknbGwgYmUgaGFwcHkgdG8gYXNzaXN0IGlmIG5l
ZWRlZC4NCj4gDQoNCkNvdWxkIHlvdSB0cnkgYmVsb3cgZml4PyBvciBqdXN0IHVzZSBsYXRlc3Qg
a2VybmVsIHdoaWNoIGFscmVhZHkgaW5jbHVkZXMgaXQ6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC8yLXYyLWNhOWUwMDE3MWM1YisxMjMtaW9tbXVmZF9zeXo0X2pnZ0BudmlkaWEuY29t
Lw0K

