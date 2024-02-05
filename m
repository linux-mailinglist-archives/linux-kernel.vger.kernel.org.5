Return-Path: <linux-kernel+bounces-52160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 340518494BA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61CA2888F3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E7511183;
	Mon,  5 Feb 2024 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J52qMw7w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD7710A0F;
	Mon,  5 Feb 2024 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707119166; cv=fail; b=r2A/eJzv5ekp61hqhGb7jIQPQ9NIxMEo2PwXSsDfIvIEKVTBH7WcKoGf4Gsy6ISzgQXcquJnAJQgp5OvTD6m37D+HklbDQ0aGE0RQvfIm8iuU6pHU5U0WxOXTIGjX92oUTGaqed+BwP5CKlWwJz4N1mOJMKb0GOQLrl+Kq2wlo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707119166; c=relaxed/simple;
	bh=6EgczzDPHy50IA2Qel3qgp8SnJLO6jR5UK1jY92JbkM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Whj8NQuEr2Bfe7bXszZolR44WFv0UrKJDVwhDxlZGezTRvJ3SlUN4dPLkqUCAVgDvVT05Fy4Dk64CCNzTVk63KeBR5ogMQ0bJOxjAQM+RqVfkwF1kL7JHyJfc2ENRJ/FYfXknZztXKR4IQO8jVRcdKTtoKrT3VHgQ7aWoQgBEYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J52qMw7w; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707119165; x=1738655165;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=6EgczzDPHy50IA2Qel3qgp8SnJLO6jR5UK1jY92JbkM=;
  b=J52qMw7wJdVn6ZWGpx1yL+qUDz0QAEOVpkOsSjBc8S6TkhOgG1PTBQjB
   yq6oIihm9OSkzyovUAVcDv6uvOkTw0fycraZvZKkxL21EUht7SSOE4XuZ
   HnO9VryJsiXl41kZDqw15pyAgkK1PlJO1T9XtXp1ZHrkOp6RsU0t/L1oj
   QseXa3bigj1R+m/ujlU5IcbTBGRy41SqwffYEyXq7bw9kZqiI9ETLGocs
   vksHaBHQSEp41+s9VRnLO512MLq7qgPT1XYby6JnxIMVl8bwXCWReK1sn
   DKxV//2GvyzfOhH93su6+p3lDvf0dyIC0OBWqnTs4Uudab94nhHxm3EZ0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="17997567"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="17997567"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 23:46:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="966653"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2024 23:46:03 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 4 Feb 2024 23:46:01 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 4 Feb 2024 23:46:01 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 4 Feb 2024 23:46:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jllW5kUPkGQs4rabn7FyMov5Xd/xW2SvzmuKSAHvAgmMmIl8YOPX3KvPWZEF1fOPyQcfBu1l0bWNbL28o55gjXoAjpuEC7pQMEp9uQldss+/zzNGwS9atw6U4E43HQgvWpfAs70K583LyKgRWixUV9WhBnGiJSgn4UCO+orzQXbvMmXv1RcmCuVn6v3ZTJJYg/G0z7vPTOJiPEgzb08QTZyDeO3XI4U0AOH0gFZfF+1JcsH0qStNz6ck5hvGgHGssnvej3I3v/40n80b2dYMIpFfwQvmVlrTveGX95+/e0kgXcTrZuByyxouVuqxZ1CCy/2IASViO6vaKSoJBRJa3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EgczzDPHy50IA2Qel3qgp8SnJLO6jR5UK1jY92JbkM=;
 b=YxxF4EQTDoiL3kBThLX0UnOleOwmcu9piwo4UL+xHeLYCTorDUxoTI3HycBidItbFN7yWEgd47UsZJ48RBUWTQ5kr/2Z8SsJrR+RfZv6e6sobODP49vHWXpUmcIasyqX3rVhrVksIYjF6VMJRO0UD3xPQ8Mf3KU0ioeQn+B5ERulgwF+wC8p32qsj+iCL7bf88IveKxco8kuXGY0yaXIjrfFuRYGzGGS8BWAQeM/xPUKrrl6AVmuDsdB8tSdSBEP0kV5umOmyly39kilfSBtYx+PlsDNJ/WwFsaJp2oHqBiLz3wMyKtFVlE238AECcKToWL1jZ0CO8SQCYKK24+pRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 PH0PR11MB5157.namprd11.prod.outlook.com (2603:10b6:510:3d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.36; Mon, 5 Feb 2024 07:45:55 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 07:45:55 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>
CC: Linux Security Summit Program Committee
	<lss-pc@lists.linuxfoundation.org>, "lwn@lwn.net" <lwn@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, Audit-ML
	<linux-audit@redhat.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: [ANNOUNCE] CFP: Linux Security Summit Europe 2024
Thread-Topic: [ANNOUNCE] CFP: Linux Security Summit Europe 2024
Thread-Index: AdpYBxxL35PBiKqFQVecMZsv5VhDPA==
Date: Mon, 5 Feb 2024 07:45:54 +0000
Message-ID: <DM8PR11MB5750E47F77559C0C8E903908E7472@DM8PR11MB5750.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|PH0PR11MB5157:EE_
x-ms-office365-filtering-correlation-id: e8af542e-c462-42ec-7215-08dc261e7bea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RbOEaFd+AuxR3wuJ0dtubkfX6xvaPe403OXXjvq2iBnFPofgE0D9Xob/tbv8Bi0HfkD5SPAvsAeiMyEMRHtQHYPBxTUlmW4P+4HnVo2A7DVaz7fqOyLuOwXTWy95/sexbI2Ay6wvfHX7lP2U6nMGASiH2ybmeoVjYD18XS4UWTpUM3uLvMh5pqzcDjCjF8Lldbo6XqEDqNuX6943BldfIjoaHqSGO2xgaEewtKpXBog+e+0rkNpGzM6JrkSpLga7hXArFC+ipSgD1fcEn3lf2/PLcCn8vlrgFNNO1QNbJw2lhR4K9/T6JEUujC8llC+tWYggdk+M2sL+PDv0+zmSHYMB6BuA9vkzbbTI4aG2vHLofORqFWLrN4ZG8hVzsPui8F70FIYTjRPMnhuyk069AUQKpSAlOv2tmJXRgUNyNBa6MCkFaQjDBnrln34XCFPL1rwlXnEQnidl5zGSAoxki6TqnrqsIVv1ax61YjDaPrIyxi1jZEiUTKklcgd/rr46gR8X2lT3qYNHY/q8BaC5m/e7/+sZy0Ov1mIaXZi0JYuvMqqB5aDkVMhmUkfpfGMsgIPZc+FAGp9Gzwowoca6lEvCT/+CbBeea4CU7+W35E4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(38070700009)(66946007)(6916009)(54906003)(64756008)(66446008)(66476007)(66556008)(76116006)(316002)(66899024)(5660300002)(15650500001)(2906002)(52536014)(8676002)(8936002)(4326008)(83380400001)(82960400001)(38100700002)(122000001)(55016003)(9686003)(71200400001)(45080400002)(6506007)(33656002)(7696005)(966005)(86362001)(478600001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2RPNGE4MFNyQ3FadFg3c05EcWZRMUw0QUdPU0tNTkpFSnJqQ3NVM3NCeUtj?=
 =?utf-8?B?RllEYmtPUlJvQS9kd1R4K1NsNDk2MWFmcXpPTW1jRWM0QTdtczFMQnlNMHli?=
 =?utf-8?B?cENEaFdnSlNpZzVGa0NCUXE0dmV4RVp2WmE4ajUyREZtMjhRd0FQTVdhcS9H?=
 =?utf-8?B?Y2lobzE2WVZzcitYcVlkUkkzZGlndjhTb05veWxKMDFIN0ZiT01ZVFpLS3F6?=
 =?utf-8?B?djY2cDZybTlKdUdCZ1VXZ3EzTlBxdTdBUVY0emZLVGpLWEJKS0RIdnJKVUtk?=
 =?utf-8?B?dVhuYUFBazZqby9tUktheWxOZU5aUEFVM0wvendSdFZ0dTFWR3lHVDc0VVJ1?=
 =?utf-8?B?S21ERmM3cG44QnFRYmZRNXBZKzZSR1hMU25jY04rMkZIaGhVMDRQTnFxUkRn?=
 =?utf-8?B?UG9xVGxPbmZFaklWc05seWhHN2hnaWRMWGVIbGZvQXJPQ0hXdnQrTHhkT0do?=
 =?utf-8?B?aUw1WnhRNjhRSCtGemtCWUpNQ2hGS0pCYkRqRWVGcFRPRXlDdTNvbUhsN2ow?=
 =?utf-8?B?ZEkzOFB5VWhUNlFoSDRqS052a3d1eG5Ybm1YQmFJNmk5Z3JaNWRha2ZhdzVE?=
 =?utf-8?B?dXA1ZllDQmZVY1AwdVJaY2M4VHM0ZUhQUXhOd2RpMTBNN05XRW5HVHNQeDJj?=
 =?utf-8?B?NDloWHNRMjNWWG1zZTRncC9BeWpRTVRvb29BbFErNEFPK1JFODMzY3Eva3Yy?=
 =?utf-8?B?SVRSbkp0VFJPcDY0a1NhT3FUbGlXYXJPRkIyR2RweFo1OXlJRW9CSDQwMTBG?=
 =?utf-8?B?WWtyUmhnZ3Rlb2hUd2kwSzJGQ1RQczFLVTlydTdvKzJGQ1lRN3hqMFJ5QXZz?=
 =?utf-8?B?SkJRZ3A0MXREMmR1dSsxcGVFWXExbVBwOCtKRy9pM0Q4WGV2TW81WmUzUS9X?=
 =?utf-8?B?QVllR2lqM3M0dG5DWTh3Mk5Rc2JpaTRpOWNTd01nWjRqdmdxYks3MlRjVnFR?=
 =?utf-8?B?dFp0K21QTm40NlJFVjJuUVZ3eGlXanV0OGgrUEg3TCtIWFdhU1JjZnlqWDRx?=
 =?utf-8?B?QkNVaVpZZXdnc3hobGFicjQ4QnlqNGsrTHJ4eW5idE45MHRBdUlpUDhTM1Br?=
 =?utf-8?B?V1dqck8yQzNNQUJmc3FyOS9xbyt1RXZyMUgrUHkrK1J0Vm9tRjZ5a1FabGdZ?=
 =?utf-8?B?RkcyeDdXZy9lcWkvTzJaRHUydGU3QnRyNVdvUU1pV0ZRdFRvVEVUUkh6WWZ3?=
 =?utf-8?B?WndlSldiNWxwaGpycDd6NVNIaG1VWGtCMWNudWdPS0lHZlNqSVRBVVpoM2hi?=
 =?utf-8?B?YnRkdGxRQ0N5d1VVMVh5OWdsOWRFM3pGKzliamw3Mi9Na05nK3B4RjhmeGIr?=
 =?utf-8?B?QWVZeFQyb3NGNkNhYjArSWQ5bFBteG11aVNxYmQwYzh1MUkzdHNoYldKWGkx?=
 =?utf-8?B?RjA4emU4c2tBZzNLcFlBM3FiajVoQlR0NTZkQ2doMmliYUZPVFBqTkJpV05V?=
 =?utf-8?B?VVI1VzhyVitDMU9xWVU3aWQ3d0VLd3FhR1A1RkZzR0dQNElzS3IrTiswV3Ft?=
 =?utf-8?B?cFBaNUZaa2V1YTBWZ1BsSmd3bDNGR0I5UHEzZ1RVbXBYNG5IZVMvYXhGMm84?=
 =?utf-8?B?dE40L2tXazhhQmhLMUpqVGdndzRnMlNYZU05d0dWcnJwbndVT2F1ZERyL2pR?=
 =?utf-8?B?R0lxU3ZnTW5NTnJmQ3BJQXltcmN0dllLZlM5TUtYVFdQSEgwbEVrWUQ1TVc1?=
 =?utf-8?B?eng3V2xaU1B3ZmFyWHRLclUxbTRYZGU4RTJDc1V0NnVac0t4T2E1VHF1eDN2?=
 =?utf-8?B?VjJoSk5JQXltYldDNkVrdVRCVnZZWjlMU0RpNjRGcUtpemx0YlNzdElMTDVv?=
 =?utf-8?B?VzY3OXFORVNPanpyZHFBRVYwYUIxdlY2VTRxcFpoZjNtN29jOWpibUg0TmNM?=
 =?utf-8?B?WlcrbTdGclNLbEFyR0ZUSnhLcnVVRTBuQkRtc2Q1aUtRUGg5Nm5MQktOMzlu?=
 =?utf-8?B?KzFUZXhFMUIyeTNjNkdSazdsTGVDZHBTVVBZYzBJb1FmOFRudkN2dXRMVytE?=
 =?utf-8?B?Y0pyLzNhVVM2Z2VUbFZJdFZwakhTOHJhcDh2aVdOa2hRU0I3d2YxVC9LdUNV?=
 =?utf-8?B?YlVhZ1o5UE5LRVVZT0V5S0lpK1h3VkllQTQ3Y2dGMkw4U0cwN0ZzUmtlWEVJ?=
 =?utf-8?Q?p+qOJoLbU85Z4EhUKXDG+YSUd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8af542e-c462-42ec-7215-08dc261e7bea
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 07:45:54.9130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SfFaWg/Kr0bWKroSJ35zU4FZwSb86Fp3wkx8UwicrwtP5HdW5xZNBxhsclDymgj8ROCCudknpx3qTbc0Y+dB4b+fpHyWpAQAfVnM0if88JA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5157
X-OriginatorOrg: intel.com

PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09DQogICAgICAgICAgICAgICAgICBBTk5PVU5DRU1FTlQgQU5E
IENBTEwgRk9SIFBBUlRJQ0lQQVRJT04NCg0KICAgICAgICAgICAgICAgICAgIExJTlVYIFNFQ1VS
SVRZIFNVTU1JVCBFVVJPUEUgMjAyNA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgU2VwdGVtYmVyIDE2LTE3DQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBWaWVubmEsIEF1c3RyaWENCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K
DQpERVNDUklQVElPTg0KIA0KTGludXggU2VjdXJpdHkgU3VtbWl0IEV1cm9wZSAyMDI0IGlzIGEg
dGVjaG5pY2FsIGZvcnVtIGZvcg0KY29sbGFib3JhdGlvbiBiZXR3ZWVuIExpbnV4IGRldmVsb3Bl
cnMsIHJlc2VhcmNoZXJzLCBhbmQgZW5kLXVzZXJzLiAgSXRzDQpwcmltYXJ5IGFpbSBpcyB0byBm
b3N0ZXIgY29tbXVuaXR5IGVmZm9ydHMgaW4gZGVlcGx5IGFuYWx5emluZyBhbmQgc29sdmluZw0K
TGludXggb3BlcmF0aW5nIHN5c3RlbSBzZWN1cml0eSBjaGFsbGVuZ2VzLCBpbmNsdWRpbmcgdGhv
c2UgaW4gdGhlIExpbnV4DQprZXJuZWwuDQoNClByZXNlbnRhdGlvbnMgYXJlIGV4cGVjdGVkIHRv
IGZvY3VzIGRlZXBseSBvbiBuZXcgb3IgaW1wcm92ZWQgdGVjaG5vbG9neSBhbmQNCmhvdyBpdCBh
ZHZhbmNlcyB0aGUgc3RhdGUgb2YgcHJhY3RpY2UgZm9yIGFkZHJlc3NpbmcgdGhlc2UgY2hhbGxl
bmdlcy4NCg0KVGhlIHByb2dyYW0gY29tbWl0dGVlIGN1cnJlbnRseSBzZWVrcyBwcm9wb3NhbHMg
Zm9yOg0KIA0KICAgKiBSZWZlcmVlZCBQcmVzZW50YXRpb25zOg0KICAgICA0NSBtaW51dGVzIGlu
IGxlbmd0aC4NCiANCiAgICogUGFuZWwgRGlzY3Vzc2lvbiBUb3BpY3M6DQogICAgIDQ1IG1pbnV0
ZXMgaW4gbGVuZ3RoLg0KIA0KICAgKiBTaG9ydCBUb3BpY3M6DQogICAgIDMwIG1pbnV0ZXMgaW4g
dG90YWwsIGluY2x1ZGluZyBhdCBsZWFzdCAxMCBtaW51dGVzIGRpc2N1c3Npb24uDQogDQogICAq
IFR1dG9yaWFscw0KICAgICA5MCBtaW51dGVzIGluIGxlbmd0aC4NCg0KVHV0b3JpYWwgc2Vzc2lv
bnMgc2hvdWxkIGJlIGZvY3VzZWQgb24gYWR2YW5jZWQgTGludXggc2VjdXJpdHkgZGVmZW5zZQ0K
dG9waWNzIHdpdGhpbiBhcmVhcyBzdWNoIGFzIHRoZSBrZXJuZWwsIGNvbXBpbGVyLCBhbmQgc2Vj
dXJpdHktcmVsYXRlZA0KbGlicmFyaWVzLiAgUHJpb3JpdHkgd2lsbCBiZSBnaXZlbiB0byB0dXRv
cmlhbHMgY3JlYXRlZCBmb3IgdGhpcyBjb25mZXJlbmNlLA0KYW5kIHRob3NlIHdoZXJlIHRoZSBw
cmVzZW50ZXIgaXMgYSBsZWFkaW5nIHN1YmplY3QgbWF0dGVyIGV4cGVydCBvbiB0aGUNCnRvcGlj
Lg0KIA0KVG9waWMgYXJlYXMgaW5jbHVkZSwgYnV0IGFyZSBub3QgbGltaXRlZCB0bzoNCg0KICAg
ICogQWNjZXNzIENvbnRyb2wNCiAgICAqIENhc2UgU3R1ZGllcw0KICAgICogQ3J5cHRvZ3JhcGh5
IGFuZCBLZXkgTWFuYWdlbWVudA0KICAgICogRW1lcmdpbmcgVGVjaG5vbG9naWVzLCBUaHJlYXRz
ICYgVGVjaG5pcXVlcw0KICAgICogSGFyZHdhcmUgU2VjdXJpdHkNCiAgICAqIElvVCBhbmQgRW1i
ZWRkZWQgU2VjdXJpdHkNCiAgICAqIEludGVncml0eSBQb2xpY3kgYW5kIEVuZm9yY2VtZW50DQog
ICAgKiBPcGVuIFNvdXJjZSBTdXBwbHkgQ2hhaW4gZm9yIHRoZSBMaW51eCBPUw0KICAgICogU2Vj
dXJpdHkgVG9vbHMNCiAgICAqIFNlY3VyaXR5IFVYDQogICAgKiBMaW51eCBPUyBIYXJkZW5pbmcN
CiAgICAqIFZpcnR1YWxpemF0aW9uIGFuZCBDb250YWluZXJzDQoNClByb3Bvc2FscyBzaG91bGQg
YmUgc3VibWl0dGVkIHZpYToNCiAgICBodHRwczovL2V2ZW50cy5saW51eGZvdW5kYXRpb24ub3Jn
L2xpbnV4LXNlY3VyaXR5LXN1bW1pdC1ldXJvcGUvcHJvZ3JhbS9jZnAvDQoNCkxTUy1FVSBEQVRF
Uw0KIA0KICAqIENGUCBjbG9zZTogICAgICAgICAgICBNYXkgMTksIDIwMjQNCiAgKiBDRlAgbm90
aWZpY2F0aW9uczogICAgSnVuIDEwLCAyMDI0DQogICogU2NoZWR1bGUgYW5ub3VuY2VkOiAgIEp1
biAxMiwgMjAyNA0KICAqIEV2ZW50OiAgICAgICAgICAgICAgICBTZXAgMTYtMTcsIDIwMjQNCg0K
DQpXSE8gU0hPVUxEIEFUVEVORA0KIA0KV2UncmUgc2Vla2luZyBhIGRpdmVyc2UgcmFuZ2Ugb2Yg
YXR0ZW5kZWVzIGFuZCB3ZWxjb21lIHBhcnRpY2lwYXRpb24gYnkNCnBlb3BsZSBpbnZvbHZlZCBp
biBMaW51eCBzZWN1cml0eSBkZXZlbG9wbWVudCwgb3BlcmF0aW9ucywgYW5kIHJlc2VhcmNoLg0K
IA0KTFNTIGlzIGEgdW5pcXVlIGdsb2JhbCBldmVudCB0aGF0IHByb3ZpZGVzIHRoZSBvcHBvcnR1
bml0eSB0byBwcmVzZW50IGFuZA0KZGlzY3VzcyB5b3VyIHdvcmsgb3IgcmVzZWFyY2ggd2l0aCBr
ZXkgTGludXggc2VjdXJpdHkgY29tbXVuaXR5IG1lbWJlcnMgYW5kDQptYWludGFpbmVycy4gIEl0
J3MgYWxzbyB1c2VmdWwgZm9yIHRob3NlIHdobyB3aXNoIHRvIGtlZXAgdXAgd2l0aCB0aGUgbGF0
ZXN0DQppbiBMaW51eCBzZWN1cml0eSBkZXZlbG9wbWVudCBhbmQgdG8gcHJvdmlkZSBpbnB1dCB0
byB0aGUgZGV2ZWxvcG1lbnQNCnByb2Nlc3MuDQoNCg0KV0VCIFNJVEUNCg0KICAgIGh0dHBzOi8v
ZXZlbnRzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbGludXgtc2VjdXJpdHktc3VtbWl0LWV1cm9wZS8N
Cg0KDQpNQVNUT0RPTg0KDQogIEZvciBldmVudCB1cGRhdGVzIGFuZCBhbm5vdW5jZW1lbnRzLCBm
b2xsb3c6DQogICAgDQogICAgaHR0cHM6Ly9zb2NpYWwua2VybmVsLm9yZy9MaW51eFNlY1N1bW1p
dA0KICANCiAgI2xpbnV4c2VjdXJpdHlzdW1taXQNCg0KDQpQUk9HUkFNIENPTU1JVFRFRQ0KDQog
IFRoZSBwcm9ncmFtIGNvbW1pdHRlZSBmb3IgTFNTIEVVIDIwMjQgaXM6DQoNCiAgICAqIEVsZW5h
IFJlc2hldG92YSwgSW50ZWwNCiAgICAqIEphbWVzIE1vcnJpcywgTWljcm9zb2Z0DQogICAgKiBT
ZXJnZSBIYWxseW4sIENpc2NvDQogICAgKiBQYXVsIE1vb3JlLCBNaWNyb3NvZnQNCiAgICAqIFN0
ZXBoZW4gU21hbGxleSwgTlNBDQogICAgKiBKb2huIEpvaGFuc2VuLCBDYW5vbmljYWwNCiAgICAq
IEtlZXMgQ29vaywgR29vZ2xlDQogICAgKiBDYXNleSBTY2hhdWZsZXINCiAgICAqIE1pbWkgWm9o
YXIsIElCTQ0KICAgICogRGF2aWQgQS4gV2hlZWxlciwgTGludXggRm91bmRhdGlvbg0KDQogIFRo
ZSBwcm9ncmFtIGNvbW1pdHRlZSBtYXkgYmUgY29udGFjdGVkIGFzIGEgZ3JvdXAgdmlhIGVtYWls
Og0KICAgIGxzcy1wYyAoKSBsaXN0cy5saW51eGZvdW5kYXRpb24ub3JnDQoNCg0K

