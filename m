Return-Path: <linux-kernel+bounces-50615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A26D4847BA5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D54FB29CBD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1F87C0B9;
	Fri,  2 Feb 2024 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RM2jcMrR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C2A65E04;
	Fri,  2 Feb 2024 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706909795; cv=fail; b=BCCBLdHiteZueEqhxCCD68zzE5I8OEdSloEHgmV0qcttQx3lagE2etlxdDXjAHHwtZjop+Fl0Ot1Zp8kkEIrDIPtugM0uNld9cQbnQhcNuwvpKOno/5YYR5hiFcBTHVpMWF1FgO+zJoFAMC2mNyXJmIL+TircPwxki7kBQYuFUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706909795; c=relaxed/simple;
	bh=YMloirNwbf6hAH/5FD0I2g9N3otRCU4yqazUqISTqXY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LcL2Gv+VEXQRqzWKstUDeod+pfUgt61aqLuolSn3zRABZPbN1XUU7FrOUvpPsK5RS/ykrigvFd1CnOdQnUYilutdfVao7kic0xjIR6hEDYnPHqs9P0WgDinmZQij1Et5mMys4s0tZjyB2XvSJqsgluIQaV0SIrAGUnZQRdZutPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RM2jcMrR; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706909794; x=1738445794;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YMloirNwbf6hAH/5FD0I2g9N3otRCU4yqazUqISTqXY=;
  b=RM2jcMrRZFsrJ6MlLcM9lxFYyCMUObMmWf5nBY+160zbwstkiimA+Sbx
   NYcmzmaZS4Fvc+lmTPuTYmPxTmhth9Rp5qHmtEIZvUZX0AawN/DFp/mDT
   KuwFM4AuzgvwKb+x8Oy5/pRokEzrrFf9XoxSjDcuZhXXj3OHzNGndoixv
   1iVj+2GSAjSnECMfvydcgjz0iOhYbYYh5I7wReBYaJNcdAC7+zpSR77EN
   1ZvjjCTMbh6uBsWSVWkYS+hDDJoXFK6Xb83IH0I8ko+Ypc5VVzPL53xbb
   Y/PAgmFiaKlY3GL3mFgAQdJYIt9+pXw+7TmW8XCoL7dmm4P7QTt0Vlhpa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="402973"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="402973"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 13:36:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="823316992"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="823316992"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 13:36:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 13:36:30 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 13:36:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 13:36:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihBwLjmKk8FFl9rfl0rE5K0e4FMv+Ko58kxyHKnx6nfEme62DHKWgcS6MUiuOaorAzf+ZRyTWEqiONyqQXJfuHHHpLzF6F1CR5boa9lAV0vfbrQFzYo7E30LGOBvTpZmjPa5F3TSpci2UYYWnpnlK3Y6kK+bn30xTRCJGSk/6lYMezpNA0IQYH/LzG58lk+fCmdE1PngYcDnFzEF/nGoM2ahKkOBbpKlNJMZc4yt/CrOym89iPaYZmv7ax88tFe5/MkoqnIJA3zucRMsZChVpIUaKaEaAAeGzqbQNt4DAuCW3U2T+SGQcbtGe6G67+wlLiCKX/sFRwlzIcAaPSrpUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMloirNwbf6hAH/5FD0I2g9N3otRCU4yqazUqISTqXY=;
 b=ImLXUa6Zp24WWpe42C8xSu7atIsYkeEX2cqYgho2ZWwLaXtGvsOupG5tUivT0xTxDrinMXAcvf6ePLjGozqnMP72oZatLDD14v18iGkKgUq+9Svz3vDGAidIpyaSghFqJe60CsQtnDYI0VVAfdiO0FFqFOQvpV0N6U5PFPuFDz+/eGF2Kx5nOqm60p3Icg06oiraeb3wHUfvLu3ZaFUSLfxkCTpwhNn3BYsbqjQ/3CB/hhPNmFlDw2JHwwFmSwlt3307Ena4hRrTUr7LmHCDWQ/Xabl8u1OW60Zem2h5dnRUrXUQd8GIxJTgTeHRNa+xb22qgdYHrZ3hH2PS3e4Gsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH0PR11MB5410.namprd11.prod.outlook.com (2603:10b6:610:d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Fri, 2 Feb
 2024 21:36:28 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 21:36:28 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Tong Tiangen <tongtiangen@huawei.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
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
Thread-Index: AQHaVBOfhwOTM8ynF0GL5a5xXZOLP7D1XeaAgAAtgACAASWhAIAAYTmAgABUMXCAABFygIAAGmrg
Date: Fri, 2 Feb 2024 21:36:27 +0000
Message-ID: <SJ1PR11MB6083BDC3A0596FA87BC25259FC422@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240111135548.3207437-1-tongtiangen@huawei.com>
 <20240111135548.3207437-3-tongtiangen@huawei.com>
 <20240131070258.GGZbnwov0g918F-FGz@fat_crate.local>
 <3009aadd-69d6-c797-20b4-95cf926b6dd9@huawei.com>
 <20240201142016.GFZbuooG9CRoK90U2C@fat_crate.local>
 <39c1e4d2-b1d0-91ae-595e-1add4698dd7f@huawei.com>
 <20240202133911.GBZbzwf-M37M-J3EJX@fat_crate.local>
 <SJ1PR11MB6083A60DE19FBFB1B0CA6B3DFC422@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240202194257.GFZb1FwcPPO8WXF86H@fat_crate.local>
In-Reply-To: <20240202194257.GFZb1FwcPPO8WXF86H@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH0PR11MB5410:EE_
x-ms-office365-filtering-correlation-id: 404ec9f2-a093-4ce6-b846-08dc24370362
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sIsyNGPLqIrzBbpUmQ626xK96RdOHsNFTTISWFSY/z2fW3d5TJF5tg7GngNX4yL5qXqQdNKY7kNqOCMiT4ihVcHPwFln5zATTXWbZi2YIuXpi8W6eN5Gt2194CJQl65WF36AQf3aSUO+ClqUKWhVJqDy3/mGFjyRoGMBleNb0/jsyroHQJwI3SJqJXPesVCicOZZcx6ZI1bGvFNPup586i1RH4IlzEDJbbWjvgu/J6DMQYV8yTQNovr7pCWVL4XYC+6j/EyovtV1QDTu3SzH4+RcSRtx8NfSwGRyzQIPKeyZoZcTTqvUyAB2EBkEKkxwE6eFSrLlkxTrTiJjFbfO8Mdl7cyt5SQphcysBt0kDeQzjKUdnMhWJI3iJ4Oi3qKJ60QZpvYpbzTIgac3p2mbxAHhBsrbygAtD9tnDQ+LOZlw2tGgN7MmDdfzhmTrhPvrIbLbf9+3bHGl8ISgnAVFxbaAL25fdvCkgePLb/y1v5ZaTO1lA29S9VhPZmE5tg0bfL7qTLKCWI+ZFnJYYu1DJv3B9cUGKOIfc/oU6200H2KRqbBfCf+iHl2wUNk2+Htazc3qEgZhMVJPuXKcIRQzhziB37HU8h0T7p5IRWRFTgca0lGFFZg0N4+QTpMwvMZ+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(7696005)(6506007)(83380400001)(82960400001)(122000001)(55016003)(4326008)(9686003)(5660300002)(2906002)(38070700009)(7416002)(33656002)(86362001)(52536014)(316002)(6916009)(8676002)(8936002)(71200400001)(64756008)(66446008)(76116006)(66946007)(66556008)(66476007)(54906003)(26005)(478600001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkZ0a0g4RW9PdGRpQ3gxKzRGTGd1VCtjMzRlUmZHczdzdE9PTjZiSy9BMkJZ?=
 =?utf-8?B?eEJvc3Z4M1RQSzgzME5mUXVPM2p6UWFsWFBWU1pxSlF2Vy9IMkpaU2lUZ2NJ?=
 =?utf-8?B?aW9ORGxwRTFiaDFqR3lXS3ZUWUc4L3hjdmVpWDN4M0s0N2ZlWWRHaDNvVUh2?=
 =?utf-8?B?SGlZKytjOHNNcS9GTUZ6TFl2VmEyNjZFbW5zMHIzb21Zei81NjhtUURUUEFs?=
 =?utf-8?B?Ynljc3V3NTJFVlZSdFl6VEFrWlVMQ01NNWVXZkxFWjU0YjVxZmRGbFhTSkEw?=
 =?utf-8?B?cStoTGdrdFE4VnFaSG02WUVtNVVyckFLeWYvL2kyTlBXNUlkaWlTSkQ5TG9K?=
 =?utf-8?B?dHZ3bjcvc3A0VjRDcERndXdXejBuWnNBMmhIU1RzNTlMaURKNHFRZGRoeng2?=
 =?utf-8?B?WnRkQzdrdlU3N2c5anhsWmlkdjA1N29CMDliTUZtV0NsS1VDSkJydC9MV1BW?=
 =?utf-8?B?QXY5bWd4NjNnQ1pVTjJ6SzhFeXYzUmFHTDVvWWp4Uk5Kb0xydmxFUHBPcWxS?=
 =?utf-8?B?STRzZE9LRDUzREFsQjdwZHRXMnExTlgxR3NqRVpyZldONklGWmhraGVTZmdQ?=
 =?utf-8?B?ZzE2VldCeXcvSklQSzU1VU9UQ0dkVWdiMEs3SDZnTXlGOEpEOGpWWWl1RklG?=
 =?utf-8?B?YzF5eE1jOXQzbzRMeTQwUlE3TWp5N3JHNXFUekNmRldkcjNuOEk0ME5VQ2lP?=
 =?utf-8?B?M0syQ2hjRUlpamRudDY3OTlvSWF4UlYvSnlLSnBLVG0zNVdGVHVidTN5ZmVI?=
 =?utf-8?B?VmVQcE5JeURQRVpuSzBvRTlibDQxZ2RyZFdZUkw0Y1FscUJBaXBxT2RBUTJm?=
 =?utf-8?B?UGZuQUE3U0VnRmdZZ3RBaS9mMkRwNWZZZ1EwenY0bkZ3eTZlTWpBbDdnRTY5?=
 =?utf-8?B?WEVpZUxscXFKSnRLRUhDcUhsTkNjYXUrVjFsWFlkdzJ1YzlmMGZ0THJXWjNV?=
 =?utf-8?B?WlBXZXk0VmdsTHBLRDdYZ2N6Qmx0WVd6b1loOS9BbDRnL2pDSUVLNTZ4TDM3?=
 =?utf-8?B?UjFrcWZMYml2bnkvQkVJaDRVUG1rV2RnUjBRQkFIQUhIRFJvUWZhMnMwdThs?=
 =?utf-8?B?S25tQThqVHpOSGg0TzZreVcxL1RFMm8zNVcwY3JGYnlNalprWkd4UDhrMzlK?=
 =?utf-8?B?WVJZRzZlZ3kwakFmNUVCci9hOUd4ZlJNemR6bGQzSkxWVjRqcmt1aGVMTG9D?=
 =?utf-8?B?YUxQZURpSFQraDBHYlRWbHlrOUZUYkZOdHRuRTAwTlltNU9pV2JjOXM1NHBt?=
 =?utf-8?B?NUlzNTl0ekNxTjlLaWFSYzkwL0oxbHBMZUM1TTlMRzg4K1NvVHI4ZnF0TEdP?=
 =?utf-8?B?Y1dpZlQ2SlBRQzNLVUIvcDVGbklyZjExaUNLMFNXdlhuUmhuaU9VRlF5S2JX?=
 =?utf-8?B?SjVTWlN6VDhsSE9VRXlPQWYrY3Z2MXpla0J4VTN4bGllSlNuYlNYbGxqVms3?=
 =?utf-8?B?RWVsTVdYL2x2MHlxcDRrNGNPV3g2b2Z5dWVDdm9GQjRzcWd0L3ZrRSs2ekhE?=
 =?utf-8?B?WHpNSzBxbUQ0V1VPcnREWkt3ekg2MjI3NmZnVm1QcDQxd0ZoV0pJaWs2UDNE?=
 =?utf-8?B?UmxjQmFaYjlVazk1ekMwQjE4RDRpZVIxZmxhTy94QlMxTG1xb2xpWEZrdXdm?=
 =?utf-8?B?WTJwd2JlclhtOFljUDAyQjZkZW5pRGN5ZGFKVmgrdmw1YklMUWVkaytUYmMv?=
 =?utf-8?B?d1U0Q2QxdkFRYVBHL3g5dDR1SjcrT0dkcVpSSVVsaFdBYy81amlIc3EzZmlS?=
 =?utf-8?B?ZzRuelEvUE1EUnF1UDlkSExUaVlxeFZvNlVncXBzcmltRVdGYSt1SUhTYmFV?=
 =?utf-8?B?RE9HMGJjcm94VVlQWXUxdWJvd1FjTVVJa09ybGo4RFAwb2tuTENRSEFxSTBV?=
 =?utf-8?B?QXE2bzN1VG1QQklIVWRKWUJJZGNIbmJweVpGemtoTHV4bVNhT2c4SXlwcElE?=
 =?utf-8?B?VE4wM0lDN2JRS2pPYVVtMmlkUHZ5S2s4UHU3YTN5aU5LMGoxNTVzN2EyVmEr?=
 =?utf-8?B?OTEyZnpGU3h1b0ZVSHo3VXZ5cS9HVDJRdUJXSElVTm9ic3dZVG9IOGY4QVFJ?=
 =?utf-8?B?QTlUSytUZTdlT0RpQjRYNWl1b1AzdFRwTmJYczJwZlVKb3JkRERNWFhvTktk?=
 =?utf-8?Q?YNZ/ClJ0dmCi1Yyf9VoqqjlZo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 404ec9f2-a093-4ce6-b846-08dc24370362
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 21:36:27.7933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M9uXXR34Vfz/vDk1jDdcaE4sF075tImV5+JwfqEKBhNMjJ9VX+1BD7pgHytuwuTTtEVJOW2EaKpuCg7R0bG00A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5410
X-OriginatorOrg: intel.com

PiA+IEF0IGxlYXN0IG9uIEludGVsIHlvdSBjYW4gb25seSBnZXQgYSBtYWNoaW5lIGNoZWNrIGZv
ciBvcGVyYXRpb24gb24gcG9pc29uIGRhdGEgTE9BRC4NCj4gPiBOb3QgZm9yIGEgU1RPUkUuIEkg
YmVsaWV2ZSB0aGF0IGlzIGdlbmVyYWxseSB0cnVlIC0gb3RoZXIgYXJjaGVzIHRvIGNvbmZpcm0u
DQo+DQo+IFNvIHdoYXQgaGFwcGVucyBpZiB5b3Ugc3RvcmUgdG8gYSBwb2lzb25lZCBjYWNoZWxp
bmUgb24gSW50ZWw/IEl0J2xsDQo+IHJhaXNlIGEgcG9pc29uIGNvbnN1bXB0aW9uIGVycm9yIHdo
ZW4gdGhhdCBjYWNoZWxpbmUgaXMgbG9hZGVkIGluIHRoZQ0KPiBjYWNoZT8gQmVjYXVzZSB5b3Ug
bmVlZCB0byBsb2FkIHRoYXQgbGluZSBpbnRvIHRoZSBjYWNoZSBmb3Igd3JpdGluZywNCj4gSSdk
IHByZXN1bWUuLi4NCg0KVGhlcmUgYXJlIHR3byBwbGFjZXMgaW4gdGhlIHBpcGVsaW5lIHdoZXJl
IHBvaXNvbiBpcyBzaWduaWZpY2FudC4NCg0KMSkgV2hlbiB0aGUgbWVtb3J5IGNvbnRyb2xsZXIg
Z2V0cyBhIHJlcXVlc3QgdG8gZmV0Y2ggc29tZSBkYXRhLiBJZiB0aGUgRUNDDQpjaGVjayBvbiB0
aGUgYml0cyByZXR1cm5lZCBmcm9tIHRoZSBESU1NcyB0aGUgbWVtb3J5IGNvbnRyb2xsZXIgd2ls
bCBsb2cNCmEgIlVDTkEiIHNpZ25hdHVyZSBlcnJvciB0byBhIG1hY2hpbmUgY2hlY2sgYmFuayBm
b3IgdGhlIG1lbW9yeSBjaGFubmVsDQp3aGVyZSB0aGUgRElNTXMgbGl2ZS4gSWYgQ01DSSBpcyBl
bmFibGVkIGZvciB0aGF0IGJhbmssIHRoZW4gYSBDTUNJIGlzDQpzZW50IHRvIGFsbCBsb2dpY2Fs
IENQVXMgdGhhdCBhcmUgaW4gdGhlIHNjb3BlIG9mIHRoYXQgYmFuayAoZ2VuZXJhbGx5IGENCkNQ
VSBzb2NrZXQpLiBUaGUgZGF0YSBpcyBtYXJrZWQgd2l0aCBhIFBPSVNPTiBzaWduYXR1cmUgYW5k
IHBhc3NlZA0KdG8gdGhlIGVudGl0eSB0aGF0IHJlcXVlc3RlZCBpdC4gQ2FjaGVzIHN1cHBvcnQg
dGhpcyBQT0lTT04gc2lnbmF0dXJlDQphbmQgcHJlc2VydmUgaXQgYXMgZGF0YSBpcyBtb3ZlZCBi
ZXR3ZWVuIGNhY2hlcywgb3Igd3JpdHRlbiBiYWNrIHRvDQptZW1vcnkuIFRoaXMgbWF5IGhhdmUg
YmVlbiBhIHByZWZldGNoIG9yIGEgc3BlY3VsYXRpdmUgcmVhZC4gSW4gdGhlc2UNCmNhc2VzIHRo
ZXJlIHdvbid0IGJlIGEgbWFjaGluZSBjaGVjay4gTGludXggdWNfZGVjb2RlX25vdGlmaWVyKCkg
d2lsbA0KdHJ5IHRvIG9mZmxpbmUgcGFnZXMgd2hlbiBpdCBzZWVzIFVDTkEgc2lnbmF0dXJlcy4N
Cg0KMikgV2hlbiBhIENQVSBjb3JlIHRyaWVzIHRvIHJldGlyZSBhbiBpbnN0cnVjdGlvbiB0aGF0
IGNvbnN1bWVzIHBvaXNvbg0KZGF0YSwgb3IgbmVlZHMgdG8gcmV0aXJlIGEgcG9pc29uZWQgaW5z
dHJ1Y3Rpb24uIFRoZXNlIGxvZyBhbiBTUkFSIHNpZ25hdHVyZQ0KaW50byBhIGNvcmUgc2NvcGVk
IGJhbmsgKG9uIG1vc3QgWGVvbnMgdG8gZGF0ZSBiYW5rIDAgZm9yIHBvaXNvbmVkIGluc3RydWN0
aW9ucywNCmJhbmsgMSBmb3IgcG9pc29uZWQgZGF0YSBjb25zdW1wdGlvbikuIFRoZW4gdGhleSBz
aWduYWwgYSBtYWNoaW5lIGNoZWNrLg0KDQo+IFdoYXQgaGFwcGVucyBpZiB5b3UgaGF2ZSBiaXRz
IGZsaXBwZWQgaW4gdGhlIGNhY2hlbGluZSB5b3Ugd2FudCB0byB3cml0ZQ0KPiB0bz8NCj4NCj4g
VGhhdCdzIGZpbmUgYmVjYXVzZSB5b3UncmUgb3ZlcndyaXRpbmcgdGhlbSBhbnl3YXk/DQo+DQo+
IEknZCBwcmVzdW1lIEVDQyBjaGVjayBnZXRzIHBlcmZvcm1lZCBvbiBjYWNoZWxpbmUgbG9hZCBh
bmQgdGhlbiB5b3UnbGwNCj4gaGF2ZSB0byByYWlzZSBhbiAjTUMuLi4NCg0KUGFydGlhbCBjYWNo
ZWxpbmUgc3RvcmVzIHRvIGRhdGEgbWFya2VkIGFzIFBPSVNPTiBpbiB0aGUgY2FjaGUgbWFpbnRh
aW4NCnRoZSBwb2lzb24gc3RhdHVzLiBGdWxsIGNhY2hlbGluZSB3cml0ZXMgKGNlcnRhaW5seSB3
aXRoIE1PVkRJUjY0QiBpbnN0cnVjdGlvbiwNCnBvc3NpYmx5IHdpdGggc29tZSBBVlg1MTIgaW5z
dHJ1Y3Rpb25zKSBjYW4gY2xlYXIgdGhlIFBPSVNPTiBzdGF0dXMgKHNpbmNlDQp5b3UgaGF2ZSBh
bGwgbmV3IGRhdGEpLiBBIHNlcXVlbmNlIG9mIHBhcnRpYWwgY2FjaGUgbGluZSBzdG9yZXMgdGhh
dCBvdmVyd3JpdGUNCmFsbCBkYXRhIGluIGEgY2FjaGUgbGluZSB3aWxsIE5PVCBjbGVhciB0aGUg
UE9JU09OIHN0YXR1cy4NCg0KTm90aGluZyBpcyBsb2dnZWQgb3Igc2lnbmFsZWQgd2hlbiB1cGRh
dGluZyBkYXRhIGluIHRoZSBjYWNoZS4NCg0KLVRvbnkNCg==

