Return-Path: <linux-kernel+bounces-100834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381C4879DE2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13AB282D45
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CB8143751;
	Tue, 12 Mar 2024 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l34fCoBx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5DA4AEEB;
	Tue, 12 Mar 2024 21:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280268; cv=fail; b=E4ttJHWhJZGUMOd9VowOvnCkL/SRmOxR8lRhsMuwzaAyouJMfSUy1jtM0SDQPUTyliZ1Df3uo0o4bMrJ+92cjByFGZq9kKhSQhr35AV7MFTTwP87G5YN+k/JVKhPX5YiMLVEBhKEMBVuzt9HoXPooSoPl4IjSKsioMnrN6aTqi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280268; c=relaxed/simple;
	bh=R7elNealj0Tc86WFXYnDP3FtPqAxkxxbRg505MW4oks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z6BPIeL1VyqQ2bvmBtL2Fh6W4EW0p2U8/4hcyiUi9YuoNOv6ryuUSKwPF0eF579wTRJ7BxASZRkSinwJAtMdtZMT0E6OsgvxJqVwmIQh2GjdzWzJ5T7SWBuNP/HJoVjlcWeVnv4xr0trnMujQy4F62/Cg4mwaVVlxGezGkVL/GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l34fCoBx; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710280266; x=1741816266;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R7elNealj0Tc86WFXYnDP3FtPqAxkxxbRg505MW4oks=;
  b=l34fCoBxW+I3D8Kb1yMGn9kQ5S6NBmK8daZVNMwhhWINuVjQC0yhm+gf
   yBsQwGxSFgwh31vS35eF6yjzKuBFXax0GRS13uwB8yBkxN/FXHm5thCJs
   dBreLQlsDgZHgfpeoUV+nFiXN9a1QxWm/cBK5B770y/vFXJnJ9TF6MeaJ
   vhsjnFZR0PGT5fGjt65gLR4MVbF5RKZTMucHJo90vpp14NJhachc8SEn5
   z9FvuNfDDM4+CskZ6cPQQTFav4/Z4WE1yUVlFhaxa2XVghePrqLJIjd2h
   TpUo92Te7Mq/TA20dw+s/Yax4WoY52iDB1RvxUfHLV+wIeLZKN89gVZj2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5186926"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5186926"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 14:51:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11770341"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 14:51:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 14:51:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 14:51:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 14:51:04 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 14:51:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H77iKSs2fgQNIzdv+lYXYJfdCkF/Hl531vY41aKTigJaq22eWzTnKxGOm48jaP5UpbrkHwq7Tb3qyNLJbw+i8AgwJ3MqpWZdtAfxi6FZOmY/nwWIevx8S4QygAYKVTS8SjkByjRkMLEBdNDtNpEIWWTqGLe63sPrau1EXhr7tobuItwefhE/N1KeeqD0zBWWsd4MH6eSxXDfaU4NrVAbwKldelSm/QGNOrCX/r/VkZe2EinD3tDhOse2orshVC+FjSxbI5UygJOG+od7T5rdeTJRn3uEWOkx7zvjCTpQ7OcE72dWHLBVymbs65IoktkoRskqh5Zwo7ks7umCKL6HgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7elNealj0Tc86WFXYnDP3FtPqAxkxxbRg505MW4oks=;
 b=V+sGx1irm0MqE1OdMFx7g1gm6LFEHQppi98GNaaLREu1qiljkQO4XoyJ9cua6PDM8s/rPWmaQeF2q1NCBfj+vU7J8nOibdsD6LyAn/xUHFVVVTb8RnXFcI3Ty2tSXKM990CkPNDNAHdDkEHi54dvskxAGrfyWawAEAQ7vz/JETXkbi3pucbPpOWg1Uy3WuXsgctS/pBUEeaI4B19cqcd0DiO0Gp0qcbxDWuqznCQsaTRSdkU49jZSuKec2pIjkwHnoBEe6x4Mdwrct5q53BfO7Vs2LgUUAV6E6FyUCst1Quxbh7J/3j6EimV9avhuYiIEsPYIaY6TRcKuTEhO6LyvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by DM4PR11MB5245.namprd11.prod.outlook.com (2603:10b6:5:388::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.13; Tue, 12 Mar
 2024 21:51:02 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e%3]) with mapi id 15.20.7386.017; Tue, 12 Mar 2024
 21:51:02 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang
	<kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v3 4/6] perf stat: Create another thread for sample
 data processing
Thread-Topic: [RFC PATCH v3 4/6] perf stat: Create another thread for sample
 data processing
Thread-Index: AQHabDY/rCjOAZSfEkSw1OpOQwk2QrEzufIAgAD5SUA=
Date: Tue, 12 Mar 2024 21:51:02 +0000
Message-ID: <CO6PR11MB56357CAB40A05370512C0D3DEE2B2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240302001139.604829-1-weilin.wang@intel.com>
 <20240302001139.604829-5-weilin.wang@intel.com>
 <CAM9d7ciVnWkaLMwHcJwC58KYDTW9t4SQevEGnqKcNZmJ7XF57Q@mail.gmail.com>
In-Reply-To: <CAM9d7ciVnWkaLMwHcJwC58KYDTW9t4SQevEGnqKcNZmJ7XF57Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|DM4PR11MB5245:EE_
x-ms-office365-filtering-correlation-id: 72b1d869-6c86-4c93-b79f-08dc42de8295
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IUgT2y02tq6DfUDMmO+D4ZP9L8EDF49+dV75DAC9Mh6+F9HFxUjzz0gZDSr+4cGHiCgi7ESFrHKwKioDuyEi2KhupuQXj6LZAJpXJoHTHZoISnL7+4ZCsnil7w9APj0k0iEWb90mR6wR/3ytbtgT0uNd7noRR8Rd3sYQyFksqYFBBs1r8lz5impG5JB3x4UgIUB7fime5xF8V83SNxRZY6kd3HdZuSda2Btv/AXQgGui/eMWS7eSqSA8jVPRTN0KSJeK/8izUXbKsnnyyy6ShBC/Icd3FL6qOGNoGsrc4LII/zMATn6xJb7RXiPvkoSXNy1fO014/1a6q/34QkEH7oz1/fuvvPOLm1aXOjVdokV+dZrQY7lKyW4CyQygxwL2VbffpP0scSsEpaCxQ5RFT1PsXjn3TE2Dqm8/+Kbdn4vZzTZaXWlM0tVOHYFbervgcRVAaeRAbE74pjumOJoZtJVY4U/nOiJlTVSLzUFuVaAIhnyp7vBFIwqwukNWP0JuRWDxWxmbVMk3I1Xh/r/jHE3iVgZEOqRi4rl96Hj2XSqheE6lc4jXL91eFXu5Eq8Y8wH/ZFdBHqsxj8F8V7HjpKzP3drjTb5J4iha6CjnjQjMwUFWuIhF4qD2PEvUU/zetEe/J1uiTW2Y1mTEWjfPwfPd7MepXyeVuDLPeJ2PX32+G692GeSehT1usJnewefNlH9LaAEKibq8rLnrgNLQkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFNpMzZtdWhUbWVTMXFINkI1czA3ZWlMYXA2T00rU1hJdWlFMEJxYXJtenpy?=
 =?utf-8?B?d2FlRlhEcFdPci9mOXd4bEdTUjl6NkhOWWFaY3djellRYjdRUko4dTY5d2tH?=
 =?utf-8?B?TVR0aGdPbTM5ZVJCaFdOT3BIcGRraHExQ01GOWdUcTE1S0NIZ1pycGhsbi9z?=
 =?utf-8?B?dk1UcEZRbTg3aTlVZHVSQ2d2RC9PczNld1lXaFNqb2ZBMWQvL0FBakE4aFJh?=
 =?utf-8?B?eUk4L1E4dW9VaXg1YUNSTEhwcjNnTUpkSmt0WEZvMWdqQUp4MDJTczZQM3Rt?=
 =?utf-8?B?ZStMYS9OV1RiblJpU1dCYVF3V1Vpc04ydTVlMHF4UUVWM0VIVVp1L2hvTFZ6?=
 =?utf-8?B?S3Z0V2U3d2E0M2ZBVlU5Y1FxUmlTWjRQS1pJUVlybDZhb1dCeS9yQUQ3UFU2?=
 =?utf-8?B?U01qc1lWeXpoZDdoYXloMVFVUGIyTTMyQlVsOXY0bDFtdlN5RlpicjlIYkFF?=
 =?utf-8?B?Qk5nQmUvejExU2lON0RtL0s0Z25pR2VZMGIwQ0dnenJGV1VrcTI5YlZwaEI0?=
 =?utf-8?B?YktUV2R3YlJ0alJkVmVibGwxTTRVRVl6V3drTld2QVNsNmVZcnMrbjQxTGpE?=
 =?utf-8?B?My8vR0dNckdpbHRjSHVjTmMyUnQrMVdWWmxCSlRiMlQxS2tHeTNWRWJRSytS?=
 =?utf-8?B?b3MwYnNKSm1nVm9MbjRocjFoV1hkbitBMlJrU0JnRmZpd1drU3VFdUNHZDVR?=
 =?utf-8?B?Zm55NEYyd3pkRU5Mc2VvVy9qS2hmNEM5RE1GYXR5WEc4VFZiT210RWt6aUh6?=
 =?utf-8?B?T0lHTjdXRmZrUG13R1dadUJ3TTlRRUVzbHppNGRqM3ZhT0EwVzBSNndWc2lY?=
 =?utf-8?B?UGo5NHZSQ1FQUmlSL3V0S1U3em9hTXpBdWFUWDRkT2VpZUs4dTJGN0p5Qm1W?=
 =?utf-8?B?dTJGTmljSFFpZy8zOTFUZkhLUlQ3OVlCUjV2NVhqR1Rldkw3cDZlTERFYUx2?=
 =?utf-8?B?LzFYYlZZaVdwaDFOdFNrZEZudWF4Syszd2FVaG1VRW1GYkdUSnRJV1Rnencv?=
 =?utf-8?B?N09xSVgxd1BhdUtkSEpjbEErM3gxRXJvWkE5b2N2Y1R6Y1JrZkhyKzRJN2JM?=
 =?utf-8?B?aG9lYkI4NkhiRWdtZUROcm5lcHYwUG1LSkVPZ2hwaVNiSXYyaHIvbnllYmpK?=
 =?utf-8?B?eWdnSjJhSDNIeDYyVHVHQUU0QllKWEFBeitYU1BXZVNYbUNQb0dwemVvZDNZ?=
 =?utf-8?B?TlkyUGcycThDRDduaWNVUTJhbnhqTEhkM3hIN2pDc21aN2ozMjBvWTFSVmZW?=
 =?utf-8?B?S0Y1cjZ2RURKN2l6LzBUb0h2bll3VVJ4SitrRzZMQWFyQ0RSd0dNOVVFNzFs?=
 =?utf-8?B?V09RSjVRaThnV241TDFDc3BDbnBvK2NEdzhGMk1yV0R4VWN5NThLQzh1WUts?=
 =?utf-8?B?aDYrSFh1RHErK1M2bGFBbFNXWUdnN0Y1RmNOQUs4OXlnM1FNbFFLM0hpWnly?=
 =?utf-8?B?Q0RYN1NUVGF6Qmg4YU0vMkhIVzRBOHhBRWxJMUErTEhTU0piL2ZiQi9DZklD?=
 =?utf-8?B?Ym1rU2ZMdjVuZlgvS09GbEUybzJBMDM2aDZ3Zlp0U2lsd0FlRXVTa3RqcXdI?=
 =?utf-8?B?eldlYUVuVVNFVmNrYzNKM3N3emZ4UVQ1YnN0b1MxU3gvOFBmMVFSWWlDWEo1?=
 =?utf-8?B?V1VYQ2xCSlRJQkcrOVkwbzRuL1lJN1hVaXZlSlRBYlpqNGhxS1BHV1VmZklF?=
 =?utf-8?B?NDI3WmJXdGN3TWN5VWo2OVhIckk2TTYyUkhQSk5NWERYakJxdWxwemNIVy9p?=
 =?utf-8?B?WUx2RXlKbGpUQmxjQXN5d3RZOHV5OUhGdVJTcHQ0RC83SEZDMFp3dm5NNlBh?=
 =?utf-8?B?YlRmUnA1V3doVjY5aHUzb3ZucEUwWWZEMk5VMXdXTGJ6WTkrai9sNWl2SXYx?=
 =?utf-8?B?cVJDZ0lzcGhsMzd5Z3o0QzhwYzYzd0lxNXZmZlFINllxSXllcU92UHo3WEhX?=
 =?utf-8?B?Y2x3SktPcm4xOFBxQWRGN0hoSWYzV2tqM1h0REl1ZGZnMEN3QVExdHNBdzFt?=
 =?utf-8?B?UFZNZ2xtSjNSSTBQNzkrK2p1Y0p4eklkV3FCZ0tybzNwN2pBcVhOV0c1V084?=
 =?utf-8?B?aDVvS2J6UFRCNk5aYzhUY3NSWEVnOHlxUDZ6UG9UaGNzVmJhTDFHdktZU2V2?=
 =?utf-8?Q?HP1Zy1ct2bCFgyBYylzzmf1eJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b1d869-6c86-4c93-b79f-08dc42de8295
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 21:51:02.0672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cZEThaQN9fCXHJZ6wVtAzJu/uCLUmYDrWm3Rk+2rRF710wzbbXLRLCC+XqQJxy3PJORk0hGXXnlSBkZnRzsmiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5245
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDExLCAyMDI0IDExOjQ4
IFBNDQo+IFRvOiBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gQ2M6IElh
biBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT47IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz47DQo+IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgQXJuYWxkbyBD
YXJ2YWxobyBkZSBNZWxvDQo+IDxhY21lQGtlcm5lbC5vcmc+OyBBbGV4YW5kZXIgU2hpc2hraW4N
Cj4gPGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+OyBKaXJpIE9sc2EgPGpvbHNh
QGtlcm5lbC5vcmc+OyBIdW50ZXIsDQo+IEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+
OyBLYW4gTGlhbmcgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+Ow0KPiBsaW51eC1wZXJmLXVz
ZXJzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVGF5bG9y
LCBQZXJyeQ0KPiA8cGVycnkudGF5bG9yQGludGVsLmNvbT47IEFsdCwgU2FtYW50aGEgPHNhbWFu
dGhhLmFsdEBpbnRlbC5jb20+OyBCaWdnZXJzLA0KPiBDYWxlYiA8Y2FsZWIuYmlnZ2Vyc0BpbnRl
bC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYzIDQvNl0gcGVyZiBzdGF0OiBDcmVh
dGUgYW5vdGhlciB0aHJlYWQgZm9yIHNhbXBsZQ0KPiBkYXRhIHByb2Nlc3NpbmcNCj4gDQo+IE9u
IEZyaSwgTWFyIDEsIDIwMjQgYXQgNDoxMeKAr1BNIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+IHdy
b3RlOg0KPiA+DQo+ID4gRnJvbTogV2VpbGluIFdhbmcgPHdlaWxpbi53YW5nQGludGVsLmNvbT4N
Cj4gPg0KPiA+IEFub3RoZXIgdGhyZWFkIGlzIHJlcXVpcmVkIHRvIHN5bmNocm9uaXplIGJldHdl
ZW4gcGVyZiBzdGF0IGFuZCBwZXJmIHJlY29yZA0KPiA+IHdoZW4gd2UgcGFzcyBkYXRhIHRocm91
Z2ggcGlwZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlaWxpbiBXYW5nIDx3ZWlsaW4ud2Fu
Z0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIHRvb2xzL3BlcmYvYnVpbHRpbi1zdGF0LmMgfCA1
OCArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDM0IGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL3Rvb2xzL3BlcmYvYnVpbHRpbi1zdGF0LmMgYi90b29scy9wZXJmL2J1aWx0aW4tc3Rh
dC5jDQo+ID4gaW5kZXggM2U1ODY1NTcyMjY2Li4yMzcyMTc1ZDM0MDggMTAwNjQ0DQo+ID4gLS0t
IGEvdG9vbHMvcGVyZi9idWlsdGluLXN0YXQuYw0KPiA+ICsrKyBiL3Rvb2xzL3BlcmYvYnVpbHRp
bi1zdGF0LmMNCj4gPiBAQCAtNzc3LDcgKzc3Nyw2IEBAIHN0YXRpYyBpbnQgcHJvY2Vzc19zYW1w
bGVfZXZlbnQoc3RydWN0IHBlcmZfdG9vbA0KPiAqdG9vbCwNCj4gPiAgICAgICAgIGNvbnN0IGNo
YXIgKmV2bmFtZTsNCj4gPiAgICAgICAgIHN0cnVjdCB0cGVic19yZXRpcmVfbGF0ICp0Ow0KPiA+
DQo+ID4gLSAgICAgICBwcl9kZWJ1ZygiZW50ZXJpbmcgZnVuY3Rpb24gJXNcbiAiLCBfX2Z1bmNf
Xyk7DQo+ID4gICAgICAgICBldm5hbWUgPSBldnNlbF9fbmFtZShldnNlbCk7DQo+ID4NCj4gPiAg
ICAgICAgIHByX2RlYnVnKCJbJTAzZF0gIiwgc2FtcGxlLT5jcHUpOw0KPiA+IEBAIC04MDgsOSAr
ODA3LDkgQEAgc3RhdGljIGludCBwcm9jZXNzX2ZlYXR1cmVfZXZlbnQoc3RydWN0IHBlcmZfc2Vz
c2lvbg0KPiAqc2Vzc2lvbiwNCj4gPiAgICAgICAgIHJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4g
PiAtc3RhdGljIGludCBfX2NtZF9zY3JpcHQoc3RydWN0IGNoaWxkX3Byb2Nlc3MgKmNtZCBfX21h
eWJlX3VudXNlZCkNCj4gPiArc3RhdGljIHZvaWQgKl9fY21kX3NjcmlwdCh2b2lkICphcmcgX19t
YXliZV91bnVzZWQpDQo+ID4gIHsNCj4gPiAtICAgICAgIGludCBlcnIgPSAwOw0KPiA+ICsgICAg
ICAgc3RydWN0IGNoaWxkX3Byb2Nlc3MgKmNtZCA9IGFyZzsNCj4gPiAgICAgICAgIHN0cnVjdCBw
ZXJmX3Nlc3Npb24gKnNlc3Npb247DQo+ID4gICAgICAgICBzdHJ1Y3QgcGVyZl9kYXRhIGRhdGEg
PSB7DQo+ID4gICAgICAgICAgICAgICAgIC5tb2RlID0gUEVSRl9EQVRBX01PREVfUkVBRCwNCj4g
PiBAQCAtODI2LDI5ICs4MjUsMTUgQEAgc3RhdGljIGludCBfX2NtZF9zY3JpcHQoc3RydWN0IGNo
aWxkX3Byb2Nlc3MgKmNtZA0KPiBfX21heWJlX3VudXNlZCkNCj4gPiAgICAgICAgICAgICAgICAg
LmF0dHIgICAgICAgICAgICA9IHBlcmZfZXZlbnRfX3Byb2Nlc3NfYXR0ciwNCj4gPiAgICAgICAg
ICAgICAgICAgfSwNCj4gPiAgICAgICAgIH07DQo+ID4gLSAgICAgICBzdHJ1Y3QgdHBlYnNfZXZl
bnQgKmU7DQo+ID4gLQ0KPiA+IC0gICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeShlLCAmc3RhdF9j
b25maWcudHBlYnNfZXZlbnRzLCBuZCkgew0KPiA+IC0gICAgICAgICAgICAgICBzdHJ1Y3QgdHBl
YnNfcmV0aXJlX2xhdCAqbmV3ID0gbWFsbG9jKHNpemVvZihzdHJ1Y3QNCj4gdHBlYnNfcmV0aXJl
X2xhdCkpOw0KPiA+IC0NCj4gPiAtICAgICAgICAgICAgICAgaWYgKCFuZXcpDQo+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIC0xOw0KPiA+IC0gICAgICAgICAgICAgICBuZXctPm5h
bWUgPSBzdHJkdXAoZS0+bmFtZSk7DQo+ID4gLSAgICAgICAgICAgICAgIG5ldy0+dHBlYnNfbmFt
ZSA9IHN0cmR1cChlLT50cGVic19uYW1lKTsNCj4gPiAtICAgICAgICAgICAgICAgbmV3LT5jb3Vu
dCA9IDA7DQo+ID4gLSAgICAgICAgICAgICAgIG5ldy0+c3VtID0gMDsNCj4gPiAtICAgICAgICAg
ICAgICAgbGlzdF9hZGRfdGFpbCgmbmV3LT5uZCwgJnN0YXRfY29uZmlnLnRwZWJzX3Jlc3VsdHMp
Ow0KPiA+IC0gICAgICAgfQ0KPiA+DQo+ID4gLSAgICAgICBraWxsKGNtZC0+cGlkLCBTSUdURVJN
KTsNCj4gPiAgICAgICAgIHNlc3Npb24gPSBwZXJmX3Nlc3Npb25fX25ldygmZGF0YSwgJnNjcmlw
dC50b29sKTsNCj4gPiAgICAgICAgIGlmIChJU19FUlIoc2Vzc2lvbikpDQo+ID4gLSAgICAgICAg
ICAgICAgIHJldHVybiBQVFJfRVJSKHNlc3Npb24pOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1
cm4gTlVMTDsNCj4gPiAgICAgICAgIHNjcmlwdC5zZXNzaW9uID0gc2Vzc2lvbjsNCj4gPiAtICAg
ICAgIGVyciA9IHBlcmZfc2Vzc2lvbl9fcHJvY2Vzc19ldmVudHMoc2Vzc2lvbik7DQo+ID4gKyAg
ICAgICBwZXJmX3Nlc3Npb25fX3Byb2Nlc3NfZXZlbnRzKHNlc3Npb24pOw0KPiA+ICAgICAgICAg
cGVyZl9zZXNzaW9uX19kZWxldGUoc2Vzc2lvbik7DQo+ID4NCj4gPiAtICAgICAgIHJldHVybiBl
cnI7DQo+ID4gKyAgICAgICByZXR1cm4gTlVMTDsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyBp
bnQgX19ydW5fcGVyZl9zdGF0KGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndiwgaW50IHJ1bl9p
ZHgpDQo+ID4gQEAgLTg2OCwxNSArODUzLDM3IEBAIHN0YXRpYyBpbnQgX19ydW5fcGVyZl9zdGF0
KGludCBhcmdjLCBjb25zdCBjaGFyDQo+ICoqYXJndiwgaW50IHJ1bl9pZHgpDQo+ID4gICAgICAg
ICBpbnQgZXJyOw0KPiA+ICAgICAgICAgYm9vbCBzZWNvbmRfcGFzcyA9IGZhbHNlOw0KPiA+ICAg
ICAgICAgc3RydWN0IGNoaWxkX3Byb2Nlc3MgY21kOw0KPiA+ICsgICAgICAgcHRocmVhZF90IHRo
cmVhZF9zY3JpcHQ7DQo+ID4NCj4gPiAgICAgICAgIC8vUHJlcGFyZSBwZXJmIHJlY29yZCBmb3Ig
c2FtcGxpbmcgZXZlbnQgcmV0aXJlX2xhdGVuY3kgYmVmb3JlIGZvcmsgYW5kDQo+IHByZXBhcmUg
d29ya2xvYWQNCj4gPiAgICAgICAgIGlmIChzdGF0X2NvbmZpZy50cGVic19ldmVudF9zaXplID4g
MCkgew0KPiA+ICAgICAgICAgICAgICAgICBpbnQgcmV0Ow0KPiA+DQo+ID4gKyAgICAgICAgICAg
ICAgIHN0cnVjdCB0cGVic19ldmVudCAqZTsNCj4gPiAgICAgICAgICAgICAgICAgcHJfZGVidWco
InBlcmYgc3RhdCBwaWQgPSAlZFxuIiwgZ2V0cGlkKCkpOw0KPiA+ICAgICAgICAgICAgICAgICBy
ZXQgPSBwcmVwYXJlX3BlcmZfcmVjb3JkKCZjbWQpOw0KPiA+ICAgICAgICAgICAgICAgICBpZiAo
cmV0KQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKw0KPiA+
ICsgICAgICAgICAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KGUsICZzdGF0X2NvbmZpZy50cGVi
c19ldmVudHMsIG5kKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHRwZWJz
X3JldGlyZV9sYXQgKm5ldyA9IG1hbGxvYyhzaXplb2Yoc3RydWN0DQo+IHRwZWJzX3JldGlyZV9s
YXQpKTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFuZXcpDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLTE7DQo+IA0KPiBUaGlzIHdv
dWxkIGxlYXZlIHRoZSByZWNvcmQgY29tbWFuZC4gIEkgdGhpbmsgeW91J2QgYmV0dGVyDQo+IGRv
IHRoaXMgYmVmb3JlIHByZXBhcmVfcGVyZl9yZWNvcmQoKS4NCj4gDQo+IA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIG5ldy0+bmFtZSA9IHN0cmR1cChlLT5uYW1lKTsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICBuZXctPnRwZWJzX25hbWUgPSBzdHJkdXAoZS0+dHBlYnNfbmFtZSk7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgbmV3LT5jb3VudCA9IDA7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgbmV3LT5zdW0gPSAwOw0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgIGxpc3RfYWRkX3RhaWwoJm5ldy0+bmQsICZzdGF0X2NvbmZpZy50cGVic19yZXN1bHRzKTsN
Cj4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgaWYgKHB0
aHJlYWRfY3JlYXRlKCZ0aHJlYWRfc2NyaXB0LCBOVUxMLCBfX2NtZF9zY3JpcHQsICZjbWQpKSB7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAga2lsbChjbWQucGlkLCBTSUdURVJNKTsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICBjbG9zZShjbWQub3V0KTsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBwcl9lcnIoIkNvdWxkIG5vdCBjcmVhdGUgdGhyZWFkIHRvIHByb2Nlc3Mg
c2FtcGxlIGRhdGEuXG4iKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLTE7
DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgICAgc2xlZXAoMik7DQo+
IA0KPiBXaHk/DQoNCkluIG15IGV4cGVyaW1lbnRzLCBJIGZvdW5kIHRoYXQgcGVyZiByZWNvcmQg
aW5pdGlhbGl6YXRpb24gdGltZSBpcyB1c3VhbGx5IGxvbmdlciB0aGFuIA0KdGhlIHRpbWUgbmVl
ZGVkIGluIHBlcmYgc3RhdCwgZXNwZWNpYWxseSB3aGVuIHdlIHN0YXJ0IGEgbG90IG9mIGluaXRp
YWxpemF0aW9uIG9mIHBlcmYgDQpzdGF0IGJlZm9yZSBwZXJmIHJlY29yZCBhbHJlYWR5LiBXaXRo
b3V0IGEgd2FpdGluZyB0aW1lIGhlcmUsIHBlcmYgcmVjb3JkIG1heSBub3QgDQpoYXZlIGVub3Vn
aCB0aW1lIHRvIGxhdW5jaCBhbmQgY29sbGVjdCBkYXRhIGlmIHRoZSBleGVjdXRpb24gdGltZSBv
ZiB0aGUgcGFyZW50IA0KcHJvY2VzcyAocGVyZiBzdGF0KSBpcyB2ZXJ5IHNob3J0IChhIGZldyBz
ZWNvbmRzKS4gVGhlcmVmb3JlLCBJIGFkZGVkIGEgc2xlZXAgaGVyZSB0byANCndhaXQgZm9yIHBl
cmYgcmVjb3JkIGFzIGEgcXVpY2sgYnV0IGFkIGhvYyBzb2x1dGlvbiBoZXJlLiBUaGUgdHdvIHNl
Y29uZCB0aW1lIGlzIA0Kc2VsZWN0ZWQgYmFzZWQgb24gbXkgZXhwZXJpbWVudCBkYXRhLiBJIG1l
bnRpb25lZCB0aGlzIGFzIGEgcmVtYWluaW5nIGlzc3VlIGluIA0KdGhlIGNvdmVyIGxldHRlciBv
ZiBwYXRjaCB2MS4NCg0KSSB3aWxsIGFkZCBhIGNvbW1lbnQgaGVyZS4gUGxlYXNlIGxldCBtZSBr
bm93IGlmIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9ucyBvbiBob3cNClRvIHNvbHZlIHRoaXMgaXNz
dWUuIFRoYW5rcyBhIGxvdCENCg0KPiANCj4gVGhhbmtzLA0KPiBOYW1oeXVuZw0KPiANCj4gDQo+
ID4gICAgICAgICB9DQo+ID4NCj4gPiAgICAgICAgIGlmIChmb3Jrcykgew0KPiA+IEBAIC0xMDg3
LDEyICsxMDk0LDE1IEBAIHN0YXRpYyBpbnQgX19ydW5fcGVyZl9zdGF0KGludCBhcmdjLCBjb25z
dCBjaGFyDQo+ICoqYXJndiwgaW50IHJ1bl9pZHgpDQo+ID4gICAgICAgICBpZiAoc3RhdF9jb25m
aWcudHBlYnNfZXZlbnRfc2l6ZSA+IDApIHsNCj4gPiAgICAgICAgICAgICAgICAgaW50IHJldDsN
Cj4gPg0KPiA+IC0gICAgICAgICAgICAgICBwcl9kZWJ1ZygicGlkID0gJWRcbiIsIGdldHBpZCgp
KTsNCj4gPiAtICAgICAgICAgICAgICAgcHJfZGVidWcoImNtZC5waWQgPSAlZFxuIiwgY21kLnBp
ZCk7DQo+ID4gKyAgICAgICAgICAgICAgIHByX2RlYnVnKCJXb3JrbG9hZCBmaW5pc2hlZCwgZmlu
aXNoaW5nIHJlY29yZFxuIik7DQo+ID4gKyAgICAgICAgICAgICAgIHByX2RlYnVnKCJQZXJmIHN0
YXQgcGlkID0gJWQsIFBlcmYgcmVjb3JkIHBpZCA9ICVkXG4iLCBnZXRwaWQoKSwNCj4gY21kLnBp
ZCk7DQo+ID4NCj4gPiAtICAgICAgICAgICAgICAgcmV0ID0gX19jbWRfc2NyaXB0KCZjbWQpOw0K
PiA+ICsgICAgICAgICAgICAgICBraWxsKGNtZC5waWQsIFNJR1RFUk0pOw0KPiA+ICsgICAgICAg
ICAgICAgICBwdGhyZWFkX2pvaW4odGhyZWFkX3NjcmlwdCwgTlVMTCk7DQo+ID4gICAgICAgICAg
ICAgICAgIGNsb3NlKGNtZC5vdXQpOw0KPiA+IC0gICAgICAgICAgICAgICBwcl9kZWJ1ZygiJWRc
biIsIHJldCk7DQo+ID4gKyAgICAgICAgICAgICAgIHJldCA9IGZpbmlzaF9jb21tYW5kKCZjbWQp
Ow0KPiA+ICsgICAgICAgICAgICAgICBpZiAocmV0ICE9IC1FUlJfUlVOX0NPTU1BTkRfV0FJVFBJ
RF9TSUdOQUwpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiAg
ICAgICAgIH0NCj4gPg0KPiA+ICAgICAgICAgaWYgKHN0YXRfY29uZmlnLndhbGx0aW1lX3J1bl90
YWJsZSkNCj4gPiAtLQ0KPiA+IDIuNDMuMA0KPiA+DQo=

