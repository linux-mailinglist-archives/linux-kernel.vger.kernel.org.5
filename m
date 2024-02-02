Return-Path: <linux-kernel+bounces-49306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D834284687A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1C1B239C6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B1941218;
	Fri,  2 Feb 2024 06:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OEHKOd/i"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9023FB37
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 06:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856333; cv=fail; b=i6JFFvM3ZjtEfaFB3pZgVB6uKBgL8tHsd2kh77MdeXgWRLK2Gg2OkslWUkLn3xzqNyRkoe2UjmB6Im7I404D6J6y5yCHjJGYAZDoCOOwqVAVR4Jk5uP2FEEBYBKZZOTp1WNUsfqhyYbb/AFZIe96pqBSPnzsxBCbwFAH0n1gK84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856333; c=relaxed/simple;
	bh=tiXutWL+EUFFRUvE1UpmwLYEJtRhXOho4n8ohb49TPM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e4sOFVXK/uK10RRJhvmFKD+pdZ8YWA8Kctmysuk5+mANpdq6HlwV4OXzSSzNJQWzrDfpeyQkA0lb01c0rWybhgdm35vihz4kqa7nH+ptL8UpGzuevJ4IV/RxyEws3jVEGjCpMlyPQ5JUIRDEqqNwHV3Cpiy4k5V2mBgKcoGQ91A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OEHKOd/i; arc=fail smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706856331; x=1738392331;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tiXutWL+EUFFRUvE1UpmwLYEJtRhXOho4n8ohb49TPM=;
  b=OEHKOd/iik8K7HiznKSjMRlXwb2ftVUhe99RMUjdQMkGMR9aBqgkLDMy
   dhcLUUAU8/L6ZaNkxCT+RPIngjiS0rbN1PZb7tbG/r47cQ2CLnH0rD+eC
   +MWt0PBYjHgDvLxYzmfx8FGO02XG0hnHR66X8OacFNVxGI0LG6nvnlQB1
   oweVAabHwN1MAs1oO94yHHIWMEzlPc8v3NQy4IVT60Wp+tq5Z7+h9cMPt
   eFawJoO8A4tjpYRmn6ZjBKtus/mgfSqyqqvvxo/aHuH5lP78Iw+k0vPtE
   jShqxqweyHKBYbYelbjDH0o69Z0UO8BdJlJW2R6TpFEiCCt088CqcqXOy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="401216964"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="401216964"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 22:45:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="65642"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 22:45:31 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 22:45:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 22:45:29 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 22:45:29 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 22:45:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzgcj9VbFkjxR4ssXfFWqfpBHUAU4TfygaEh9vwtaiHv1S7c4c1+BvInPbd8KffG0g5En3cy6kpV7OWlHrWN6FglLH261MFrfRzuJFgW76OxkKLpkjKLwmJNimafxbGJNSpxe4/5OjezdTm2JKfIKAxkwEsYuFY5kKhM2Fv27KvoSbDhnDnciJIbRJ4XxvUwrj2Zak+VO2Y0K7eAQnT1nfl+QKQFWW4Cp9p3HoM6yz1tOH8g6M9zv1r9s0n7i9mw2KmNxNuonSt96L/yGvNTNBl3UaiVc4ei+rLjO1uiXmCXsYyf1s9L7MLcjj5wbLPcgmT8GL0jBlkhdcSb0nzh3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiXutWL+EUFFRUvE1UpmwLYEJtRhXOho4n8ohb49TPM=;
 b=f4JxJk7koXi2zfYMnDlVV+wsDk/YuP3t567OFORW2yRwIEAHlVcjZrqRNt2ABt93Hvop8/EyQibrD1DQ/K1tNHvs2Cm8xL+J233plou3VGaF+5MHtGFO0Zjprt6p4BsNP4LDHd2P3z6o4L7oFW4Z7pxSO9m4bOcHdfZ0UNNo+g464qDZcMcb/kDFWRAr9MTuNGel+mSX9wFuYaKM/9+Qe5iiom+ArQ4hFyUcVNt1+cB0U/dSaiP2oApHVEeWU8IF81y1a7J0XubV0nTewCUiQwintmIBpJhSHPvRfI+KrQkDV1YrBKBa5O+Ef5LdHlvMdze8kniZDnjlFHMX0whm1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MW3PR11MB4652.namprd11.prod.outlook.com (2603:10b6:303:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Fri, 2 Feb
 2024 06:45:10 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102%4]) with mapi id 15.20.7228.029; Fri, 2 Feb 2024
 06:45:10 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "mhklinux@outlook.com" <mhklinux@outlook.com>, "jgross@suse.com"
	<jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>, "arjan@linux.intel.com"
	<arjan@linux.intel.com>, "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"Tang, Feng" <feng.tang@intel.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "ray.huang@amd.com" <ray.huang@amd.com>, "Mehta,
 Sohil" <sohil.mehta@intel.com>, "Sivanich, Dimitri"
	<dimitri.sivanich@hpe.com>, "paulmck@kernel.org" <paulmck@kernel.org>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>, "andy@infradead.org"
	<andy@infradead.org>, "peterz@infradead.org" <peterz@infradead.org>
Subject: Re: [patch v2 25/30] x86/cpu/topology: Use topology logical mapping
 mechanism
Thread-Topic: [patch v2 25/30] x86/cpu/topology: Use topology logical mapping
 mechanism
Thread-Index: AQHaTf223YeKb2yg6kiOmSs4ACKo7bD2qreA
Date: Fri, 2 Feb 2024 06:45:10 +0000
Message-ID: <5024c989133441608592ef86bc78ca2573bcc728.camel@intel.com>
References: <20240118123127.055361964@linutronix.de>
	 <20240118123649.971809766@linutronix.de>
In-Reply-To: <20240118123649.971809766@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MW3PR11MB4652:EE_
x-ms-office365-filtering-correlation-id: 4aa47841-cc5f-41fa-f08c-08dc23ba8024
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: niv68yGNVnsjwU+nZYYp7o2FX2h6yfQpjie+mBp97W3QrTOzjgm5wN8j0nk24IXMB+If8z0pZsRv5dygRD4EKQeGLgS+i8VTwxLevPxb01FbGP8b1jobkglhYV1TITzQeNDA2zJasW7ER+sjQT1aGSyTLVbfMIJmDFaFfbhaz2kQeKhwGXcsH24e+CUYEY2mDWwWoSR9+LK2d98t46G1E16oO+BIVb89Nhb+G+L0Hn/Jhfk9vTjI+9kIbiXkZ84lqTsDZL9/RpC7bBbHiJt+x4Jq18Fm7mjUETEy4Q/jfvgW21CtoiMkallL9d7Rp45dBWtJOg++dQuiXRR4EzMOK7tWjNwU8CaQ/+iQFABxbFrmXJpafY6rDivzjE/QRh2maRq5cEC48rbc14WAb4zIwlM7SUeNaaTDPSK0Qmb6gvgbKPIMSz4U9DVHDuL127xvTVe4JtSm3x4TouXIEfJ+Z6qp9L7SxiOt4gYXFS/038GMAgUgP9mvJzMO8AeWbNpETSkRvXBBGQJe7ZODyhkV3acTDH1Fd4np6ZtmGjV9rRkl8oMvtrCZFn9jMojdV/AOp5Cc93iE6mW0lqoV3/E9gEhsqkTlm9By55nSgKpgGNjWr9poGZtNj9nQQuXHIJlE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(36756003)(66899024)(6486002)(478600001)(86362001)(6512007)(38070700009)(41300700001)(82960400001)(2616005)(26005)(4326008)(91956017)(7416002)(4744005)(316002)(66556008)(54906003)(66476007)(5660300002)(2906002)(71200400001)(6506007)(110136005)(64756008)(66446008)(8676002)(66946007)(8936002)(76116006)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEZBZEVjNFNjUjNpTDZBcmp2eXI5S2hLbVhYbFo0dUMrbjFlZndaM2xPaUx5?=
 =?utf-8?B?UGNkVEh3U2VWZm1VRHpQU3VBYmhkTGhhUGpiMElxcFBEeXJwVnB1T3UrOWZa?=
 =?utf-8?B?cVgvY0ZCVmkxQjkxOW95aXdJOFF3WlNaZktGb0w2MW4xSHBLclZ5ek5qY3Y5?=
 =?utf-8?B?bnppV2pNVVArNlZpRzJZU3ZpR1pDOFg2VWFYWWlCR2JaVEhzU0hFd1V6T3ZQ?=
 =?utf-8?B?MGRFNzNFTFl2dGNjNGZpVnNhYkI1SE05M2d2N3pFcVRYN3k0OXVjcENIcEFE?=
 =?utf-8?B?QjVjVExFb1BzdjZZcUJGK3N5Y1VYdlRjME9YQ09vQmxIQzd0cDlsZ3FZZjk1?=
 =?utf-8?B?Skd2dFU1N0lPUTJjYzRQM2VjaVdPTHM2eEtxQTlxUmd5bHlzM3NRbkRqSUFz?=
 =?utf-8?B?cHc3enN0RnV2WU1NM0tEQWNFeEo1RUo3Sk0xNVJwWDh2V1VNRkZJU01nK05X?=
 =?utf-8?B?Vk85MzA1YnNIL1laUVpOKzMzSzFKOWRUUngycE1McktDcEliaEVuWm5ZYXkz?=
 =?utf-8?B?WjdNcmRjR3lNVGdMV3ArM2RaTGpCN21mRTZRN2RHQnNjZGxzMGZsSHgzY29u?=
 =?utf-8?B?b0NBeUQrRk44b1p2QmdBbVlSckJoSHFOS3lYR0UwZEx2cWZJNkVxQkNkS1pl?=
 =?utf-8?B?SWtPdk00WXRQdEtzc3pVb0RLQmZqaGpqb01iS2tsTDQ1dUE1bitwdUVsUlV3?=
 =?utf-8?B?cS84M2Vwek5RUk1RWG5CK0tnM2UzZUFKZVg5eGNmSEpjL2lwT0NGVHBTUkNS?=
 =?utf-8?B?K3NOYXhNV3hZb1lNOFo4R3RGcitiTjF3UnVtejViT3piVDlrcHQ1RlQxMzBT?=
 =?utf-8?B?ZTdzV2plOWt0U05VTGRCUytrL052NkJUMGFRZCt0Tm5Oa1FvUGh0WUlOZkw0?=
 =?utf-8?B?MDlxc3RVZWMrRXlncHlxaFF6bXRXZlUzemkzL1lPK1gzREdZdkJQRkFuczl4?=
 =?utf-8?B?ZjZ4UVRhWHlMUnhoUlg3NE9lNTJGWk9aRVV0bG0xSXVJbmgrdDhiUWxiNHRQ?=
 =?utf-8?B?eUwxZ3FzanBiNjFXWDkzb2xwNmVTSEl5a2QwaCttR2c5d0c1TkszUTBMUm1h?=
 =?utf-8?B?OEJMNXI4OC9rc0JwMzdrZktOSnprZzdLQjhMN1RJL2dMbGl6MzEvblNLcEJn?=
 =?utf-8?B?dWw1d2h6UXRQZHJpT0lTQ0dBa28rRlpDeGU1ZnVtK1YwY2NxSXpmZFJUbFBV?=
 =?utf-8?B?eHBrVEFBSExWb2Z0TENJNllBbERIdCswK3hJYWxvTjhPMVBBLzl0RzRqRWtq?=
 =?utf-8?B?ZStmaE1kUWxkZkxhRnZZY01hZXVxajV3MXcxSVpUZGdoYTFaS0FYZno0S1ZP?=
 =?utf-8?B?cmJ6bTRlYjFwN3EwckFOY0JhTkZURGt0alBuWkdKeW4yZVNDYm1uWjM1eXp2?=
 =?utf-8?B?d2pySDlwTFRuNndtSWNyelJVUHp4ZVBOKzgycGxDMnYxWjQ0TDFJTlMzc0pQ?=
 =?utf-8?B?WkxqQ2grTVFJVEtaUDFkRkNLNlIzTkxhYWgvemdSY29sWE9pcEtGY0VrQTNM?=
 =?utf-8?B?NDBIUEVRYzdzMlc1VmRvLzF5b2VaWk5EQ2lZVEZZcDhiSml1c0pZT2hPUmJV?=
 =?utf-8?B?TEEvMXZ0a0J5cHVrYWtyeFgrbUQ4UTNralBPMFB3ZXBtbTNNK1lpTjArRU9R?=
 =?utf-8?B?R2lrV3hYWGMzdEZXUDl6bTBtZ2Zndi9sUHZ3STl4VE51ZS8xYjVtTnhObmVn?=
 =?utf-8?B?VmVZbTlZZzVVait3UTljd2VBbTdDWnM4cnpzaTRDa0pnYVNuY3VaMzJuZnEv?=
 =?utf-8?B?emJzZXhjVGgwNWpZZjcwVXV2eVlLMjEzNURqd2c1YTFEajJFS3VBY0s2MjQy?=
 =?utf-8?B?d3N5Yk5wSnNmd2o4MjZRSGhPV3pIc25vaExYVUxTNjVWSEEwZ1RQZWJxQktY?=
 =?utf-8?B?S3BaSjVnek0yWmJNU3EvK0NsVXUwU0l3MWtkZFRoZ04za3RXMjFhZ2M5OXg0?=
 =?utf-8?B?T2UxbktqUkwycVIveDFpUlByMlVOK205ZzQ1YXFkSkhwemNRNTJ1RCthNDBZ?=
 =?utf-8?B?MmlyZG1weDh6d1BudVZ6cnIxT1Q2NW5EVFEwVG90RjZXZTdSL1R0Y25pKzBV?=
 =?utf-8?B?ZWtKVTd5YkZkczYyQk5KMTl4NCtadmlwK21wNVZZSnpyWW4vMjRHVWNQOWc4?=
 =?utf-8?Q?Q9gjTY25XVtrU6jirlQOQdpNT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CCAA40142D3F147BEE6C3E6BE3BDB2F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa47841-cc5f-41fa-f08c-08dc23ba8024
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 06:45:10.0305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ki/BRu11aON1t9SFxzruKuy3bqwWIGdTd5/V0e9um0pU4GkCAJhgbHOpJ6qbn3P3LHXjQxAG4kgOw81Nqq46QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4652
X-OriginatorOrg: intel.com

SGksIFRob21hcywNCg0KPiBAQCAtMTQ3LDYgKzE0OCw5IEBAIHN0YXRpYyB2b2lkIHRvcG9fc2V0
X2lkcyhzdHJ1Y3QgdG9wb19zY2ENCj4gwqDCoMKgwqDCoMKgwqDCoGMtPnRvcG8ucGtnX2lkID0g
dG9wb19zaGlmdF9hcGljaWQoYXBpY2lkLCBUT1BPX1BLR19ET01BSU4pOw0KPiDCoMKgwqDCoMKg
wqDCoMKgYy0+dG9wby5kaWVfaWQgPSB0b3BvX3NoaWZ0X2FwaWNpZChhcGljaWQsIFRPUE9fRElF
X0RPTUFJTik7DQo+IMKgDQo+ICvCoMKgwqDCoMKgwqDCoGMtPnRvcG8ubG9naWNhbF9wa2dfaWQg
PSB0b3BvbG9neV9nZXRfbG9naWNhbF9pZChhcGljaWQsDQo+IFRPUE9fUEtHX0RPTUFJTik7DQo+
ICvCoMKgwqDCoMKgwqDCoGMtPnRvcG8ubG9naWNhbF9kaWVfaWQgPSB0b3BvbG9neV9nZXRfbG9n
aWNhbF9pZChhcGljaWQsDQo+IFRPUE9fRElFX0RPTUFJTik7DQo+ICsNCg0KSnVzdCB3b25kZXJp
bmcgaWYgd2UgY291bGQgaGF2ZSBsb2dpY2FsX2NvcmVfaWQuDQoNCmRyaXZlcnMvaHdtb24vY29y
ZXRlbXAuYyB1c2VzIGFuIGFycmF5IHRvIHNhdmUgcGVyIGNvcmUgdGVtcGVyYXR1cmUNCmluZm9y
bWF0aW9uLiBXZSBjYW5ub3QgdXNlIGNvcmVfaWQgYXMgYXJyYXkgaW5kZXggYmVjYXVzZSBpdCBj
YW4gYmUNCnNwYXJzZS4gQ3VycmVudGx5LCB0byBnZXQgdGhlIHRlbXBlcmF0dXJlIGluZm8gZm9y
IGEgc3BlY2lmaWVkIGNvcmUsDQp3ZSBuZWVkIHRvIHRyYXZlcnNlIHRoZSBhcnJheSB0byBrbm93
IHdoaWNoIGNvcmUgZWFjaCBlbnRyeSBtYXBzIHRvLg0KDQpJZGVhbGx5LCB3ZSBjb3VsZCBoYXZl
IGEgZ2xvYmFsIGxvZ2ljYWxfY29yZV9pZCwgYW5kIHVzZSB0aGF0IGFzIHRoZQ0KYXJyYXkgaW5k
ZXggZGlyZWN0bHkuDQpUaGlzIGNhbiBhbHNvIHNpbXBsaWZ5IGtlcm5lbCBjb2RlIGluIG1hbnkg
cGxhY2VzIHdoZW4gY2hlY2tpbmcgaWYgdHdvDQpjcHVzIGFyZSBpbiB0aGUgc2FtZSBjb3JlIG9y
IG5vdC4NCg0KRm9yIG5vdywgSSBkb24ndCBzZWUgYSBuZWVkIHRvIGV4cG9zZSB0aGlzIGluZm8g
dG8gdXNlcnNwYWNlLg0KDQp0aGFua3MsDQpydWkNCg0K

