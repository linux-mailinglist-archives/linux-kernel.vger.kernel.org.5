Return-Path: <linux-kernel+bounces-66365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5E9855BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4949297D15
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C90DDDF;
	Thu, 15 Feb 2024 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RFXvpJUr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C8BDDAE
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707982244; cv=fail; b=EuqW5Z9/AsJbUGfnXk7fTVbGPwEKYPcQLRRiBgy3jbaCCN8U2NjccpF4nlPCzwZsMui2y+X14jMubXUM7ClRKmX8vrrHrviFaknT3E94rkB5xuO/P8j2in/aumtlpBpfFfDIA5zDFzU+umb5sO7fnW9Rqp1uckdW/VmpDAx8EGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707982244; c=relaxed/simple;
	bh=fDYfADE9AQtBZhrWgcyTjGLN/z0yZcmfF4Fea6l2e/M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K0r7auYhD8O8HFtXhpYKYQVU+8+JDQsesZHI0C6jTd/Mq8ijRtEB/VUmJXJhmWPq64tSQxW0zXiCssRMQJm1IwMogq5CbqmfOA93zEdSTFlkKGyX4KfVXKz4iTkVdL0BLSunVKo3Zle+lRkIEbNeKhWxL1zz7cejLbxPw3U74XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RFXvpJUr; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707982242; x=1739518242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fDYfADE9AQtBZhrWgcyTjGLN/z0yZcmfF4Fea6l2e/M=;
  b=RFXvpJUr7QHvhAMZgz3yrv49BOjH47FUal6SVDD4/riNfnC5r70v4MFc
   u43CLe8/NC3zLHYZTupJanpjkdGQzVMgCXr0RjKtAoORXLxqIlBet+uuQ
   GrG3dywfcsx7sl/aO/vFZZmznsNP0pcaxJ333r4rnvxGd8SarRQVCSwyl
   7A5io5PvIme4q7B81pxWkH387fo65fPPkXw7Xtg+SGwEMeA+55PEKLAss
   EC2rnSPr6SRl9///UeA+dIIyKo7AKpkeHs2uCTRyQPZ55fajMTxfBD+2M
   YXM3F6W9aqhrUYcJRd6VEG2h4NvbmH95KMCoPNSpdNKMmQqGymbgSh4KX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1934493"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="1934493"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 23:30:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3386652"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 23:30:36 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 23:30:35 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 23:30:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 23:30:35 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 23:30:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7Pz7Z2nkS0GLBA16OiDAqKJmOT4H+l56VZqppJFtwGylV8DSqjnNdcrROTbsSKUK8OKL5qmLumm7bioynvvOBdABLgERDgKq2xlzm4qT6iNLAwH/6oLeLupmZDKmEtI1Y/EKIPCbqwbFUEVn8WoHYYB2APzeaQdAYhieBUB54oM9bvjIzDdD5yUtBt7uOebqq6/j9kJw0IGa3oameCPEX0vQzRgO0Snkz3cP6oK4zAr8Y4vTdvM47z4rMDgBl+U/0jDAXvRl4vV/C59dOFPi1OQSM3wndLcQ+zmDigdcWlp1r3fb6xLZ9WOIJuYKN95rrzxllqSh7v2ToYPygkWcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDYfADE9AQtBZhrWgcyTjGLN/z0yZcmfF4Fea6l2e/M=;
 b=EoxCKDNjmIHhdg8EY4LJJn+VkPdDVdYPVE2is/itiLLJdCzD0Exx2dzKRM2nmmje6AAccZU46mjgQoQmaNb7X5zISPVFCH3roNLXYwKVkyJf+lnW3DC6+brYXUxux+1bimNdsI8MCWR/9y+HtZ3kf8HEbUd3O8yudmBJ6IWFJ1iZdw/zQpmCsG4OHDoIPwY6eYl7FLmRQU6xOabJz4eaMH8tXX3q2O0c+y9Uy3LkQ10oNzBAErTL5hozcnHU9UQYbNTnug/6XGxmMoXY6pf80dk9mJ7oHmcPsBFBC4vji3Wwg7tjemWwedXl8fqwWvWwRFIZ/TlF48v4kl2egVHC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 SA1PR11MB6661.namprd11.prod.outlook.com (2603:10b6:806:255::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 07:30:32 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190%3]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 07:30:32 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Borislav Petkov <bp@alien8.de>, =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?=
	<berrange@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter
 Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A . Shutemov"
	<kirill.shutemov@linux.intel.com>, Theodore Ts'o <tytso@mit.edu>, "Thomas
 Gleixner" <tglx@linutronix.de>
Subject: RE: [PATCH v2 2/2] x86/coco: Require seeding RNG with RDRAND on CoCo
 systems
Thread-Topic: [PATCH v2 2/2] x86/coco: Require seeding RNG with RDRAND on CoCo
 systems
Thread-Index: AQHaX4AnbFohebN8LUyJy3kolvDlzbEK/VhA
Date: Thu, 15 Feb 2024 07:30:32 +0000
Message-ID: <DM8PR11MB57501389AE5518CB26E037D7E74D2@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20240214195744.8332-1-Jason@zx2c4.com>
 <20240214195744.8332-3-Jason@zx2c4.com>
In-Reply-To: <20240214195744.8332-3-Jason@zx2c4.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|SA1PR11MB6661:EE_
x-ms-office365-filtering-correlation-id: 7b66e079-2b29-48c1-b4ee-08dc2df7fe1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EppCNpJL2aHq59GIs+q1i8U7Y+wWZPcsUJx6yqoqDbpPMYaeoZov1mt6YIhxkEyDb91D4cO734QMmRb3Epeqm+qW7W6GDXl2f7+d7n1tbt3qqwynIisznB0ipzE5e8KSJDLkQzvTt8sTrMp71AkP4tihzYcRwCzfqX4m0naydM779E1ginZ4NTyFgsPKWViMGblYeguYoxAEuiYavlqEFCnysEw7PMN1VxDkFi5lrMh5J1soUG9MIt89IeHD3iL2LPtm+2Qe+LZ3IuoktMLPTVp0y/+NgDjdU66hHM0dAAs6bzOxGhK9sPNl3FxYpsm+SXtPKBdqW6eQSMXznVMkcSWckMwUEexi0RcV47x20L1rOlMBh9kjyG5Wo04ujwkGN0qQIdlaqIs6T77e5oXrpmIsi7A6FJMzhqFwDBNyp8FCLAvo0zaCrLGLpho0MBrQ1xYY8riF5pyOcIbsXAopDuEx/46lmhHPt2O+oWyesv5u+vyhgtC+sqM3fFfI4S+TlK/COf2k+0vIxAnkMahWDm9dipuGZNfcZoLWaT5nMg9sAu+8eZP+qZmgD1WPU0fRTddpaDPC1lMq7aMvZlhcdHoMpunw0JvWlL4Ufx1ua5r56oqRkRKw/s8EJWgw5aoV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(39860400002)(366004)(136003)(376002)(396003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82960400001)(83380400001)(86362001)(38100700002)(76116006)(478600001)(71200400001)(316002)(54906003)(7696005)(6506007)(110136005)(33656002)(9686003)(26005)(122000001)(38070700009)(66899024)(5660300002)(2906002)(7416002)(52536014)(41300700001)(66946007)(66476007)(66556008)(66446008)(4326008)(55016003)(8676002)(8936002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXJGSFowUkJwYXlkOTlUT0pGOXpuM0Z2alRmTHQvaG5oa3hIRTBIRmMveFVm?=
 =?utf-8?B?a2NFU24ydUpHTjE2bWdMM3U5emFKdXNEOFBic2pzaXpDYzllQWhwMUJVdU81?=
 =?utf-8?B?azlKNFpHWVhVR00zaytwUi9UVlFWOEg0R2s5aVF3R2NERlJTS0R5SlpVS0Nu?=
 =?utf-8?B?Nlh1MDREdmEyaWV6YXlPNlF1REZiV200TDhVbFMxZ1BwNjRZWXBVckU5TjVL?=
 =?utf-8?B?dVJncGdtOWYwNU1Ia1VUbWtpSXgwZWdFUTBrMjVNSjRpUWs2Ny9PSjd6WFJE?=
 =?utf-8?B?blVaOXJTa1prWGowd1pMUHFMQkpRT0M2Y2hEV3F2U09PTW1ROTY4TUtKV0ZO?=
 =?utf-8?B?dy81QlZiNDByWlV1OFh0K082eDE4c3hXU1ZnNEJVcWhBdTZiWG5yaG45Z3o0?=
 =?utf-8?B?MXpPVlJEeDA4TEhqaEpnV2tZS1VvQnRadVlDazdmZDhZQ1dNNTVmWW52dmE2?=
 =?utf-8?B?RE82Yk1ML3FDdVg5TFptVTM3U0ZRR2RvZ2ZQd0FpNU15ZnFGY1dKcmFralls?=
 =?utf-8?B?OEszYjJGYjcyZ1laOVBJTlVQQjE2ek40aGNNZ1BZWjhyWXh3Nll6WWV5Vjho?=
 =?utf-8?B?OWQ3eEhxdTNnUFB4NzZ1bm0wVlJvcHJQay9rblNnWnJ2bEtpTzFER1NlTjZu?=
 =?utf-8?B?L0tZaWxVQUFIZDRVZDF4cFAwRzhwY1g3SGN5aVVkVnl1cmcwWmRUZG95V3li?=
 =?utf-8?B?amJ2UDhnVEhXTUFDU0NPak9taWVkU0NLb1h0TitPSm5wbGdhcEQ4Wk84YVRR?=
 =?utf-8?B?R2hoWHJVNDJuM0RHcS9SMVJweVE2dVRFOERjMmt3L2RtQTJiL2FKMm9QUFhp?=
 =?utf-8?B?RXFMOVkyZnlFSnYxWEFuWGlDUlV0a1lhMlY0VWVYSzF0Ky94WS9RYkFPa0RQ?=
 =?utf-8?B?TFpmeVltMFVsMEFwemxMSUk1R1lJTzQzY1B0aDhUTTBSM1REQTBhK3RWUUI0?=
 =?utf-8?B?TVNKQk5JMThHVm5jRUlNSHNFUFRLYmlldXVpTWltaU9BdnJBdlFhWFlSQlBq?=
 =?utf-8?B?eG9NMDdyQllVOVJaaE5DNUVWNEcrS2VYK3RqYUhlRkVEeVErRjJtS2o2T25Y?=
 =?utf-8?B?czlvSXZ2YnQwZi9BQUQ5WXN2MjZyTVZ1NjlhaHV0R3dqNW01YmdBRm1GSzI2?=
 =?utf-8?B?QnhhWkEyVHA2UGNZcWdmTzBhY1VVeGJVSk0zN1RTWTd5c1pZSHN3STd4Wkxj?=
 =?utf-8?B?aGo4MmQ3Z2FERzQ2SkpZYitDVU1yM1MrU2szcGhjZHJ1WmRmdEVXNHNvRVor?=
 =?utf-8?B?aTJ0YW94TUVIN3FPUmxGM2xHOTNLRWE1THF0ZXhkZVNUKytHYVE0R01UYzl5?=
 =?utf-8?B?QVA2Qi9uVm54SnBiVlk3bmIzUGtWTnRLQnEyZ3VXRkZIemMzc2E0WnVuYWtK?=
 =?utf-8?B?YW0rQjRuTm5ZUFNnMUFFdTVaZHpCTHNKYUg5bytPakd4QkpRMnRwQjJVRTdl?=
 =?utf-8?B?RlF0WHBCK2FtRWJ3OVB6a3BjVjhPdnc3YWh3NVZ6U2UrVUsvdkVNcFdCcSt6?=
 =?utf-8?B?VDRmbFR5K2JNU1VBUWxzejBNWFJSL0FRNGtLcUt2MnZJK085dCtWNnpSK0lS?=
 =?utf-8?B?eVd1WWlPcFlxYUxlZ3UxVmhpbHdJSUxvWHJJL05xUUMrTC9FaU5qalpmRXln?=
 =?utf-8?B?bWgyOTlEVE1wVERKelZsZnJJTFN4aDhnUVNhUHpCeHVwMWMvVzNxTW9DSXp1?=
 =?utf-8?B?TG5QYk01OXB1Tm9rSWhsOThCdmJIdUNuUDdLc3pLUHpkMDZ0NUI1dVBaVWVw?=
 =?utf-8?B?cTROcEdwbTVNdG1LVE9ELzBQciswaXNFWlE5a3BjMk9TeEJtZ3BqdjdWdXRW?=
 =?utf-8?B?YmhNTnJTbFRPVlpaNHRmMTMzVXNNYjIrWjBWdHhib2RxdnRsSnhxV2kxS0hs?=
 =?utf-8?B?ZDZqQW9yTUpodTVkTFp4TFVPNEoxNTBXUzZrUkRuUmxFL2dJdnFQQWdPcW0y?=
 =?utf-8?B?NDZ6OFRLZkpCckVUQ243TW9oaEFHMVM1YlFQVmdHaVM0c3FFY2RCMkZxLzRw?=
 =?utf-8?B?Ym5kdnppdHlTeEoxYmc4TXRoQzZpdEhIN2gvUjRsWDViM0k0N2xjamRmQU5u?=
 =?utf-8?B?TVlibmM4RXVwQVBZSFF2aGt6VmtPblhEd0p5bTc3aDFXNy8xbVRpaEZHYjJL?=
 =?utf-8?Q?ipBBi1huSA8/r8pIe4ult3Sv5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b66e079-2b29-48c1-b4ee-08dc2df7fe1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 07:30:32.3107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lLbe0z9YRbDycHBEaYwnLx7Px98svL/apLUExVuldwq9AXwmrIdsXA/rYR4QdPmm9o7Lo7Cm+aoMvRyTraAzuoQ0Lsqi7ICjGdDqKrbelIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6661
X-OriginatorOrg: intel.com

PiANCj4gVGhlcmUgYXJlIGZldyB1c2VzIG9mIENvQ28gdGhhdCBkb24ndCByZWx5IG9uIHdvcmtp
bmcgY3J5cHRvZ3JhcGh5IGFuZA0KPiBoZW5jZSBhIHdvcmtpbmcgUk5HLiBVbmZvcnR1bmF0ZWx5
LCB0aGUgQ29DbyB0aHJlYXQgbW9kZWwgbWVhbnMgdGhhdCB0aGUNCj4gVk0gaG9zdCBjYW5ub3Qg
YmUgdHJ1c3RlZCBhbmQgbWF5IGFjdGl2ZWx5IHdvcmsgYWdhaW5zdCBndWVzdHMgdG8NCj4gZXh0
cmFjdCBzZWNyZXRzIG9yIG1hbmlwdWxhdGUgY29tcHV0YXRpb24uIFNpbmNlIGEgbWFsaWNpb3Vz
IGhvc3QgY2FuDQo+IG1vZGlmeSBvciBvYnNlcnZlIG5lYXJseSBhbGwgaW5wdXRzIHRvIGd1ZXN0
cywgdGhlIG9ubHkgcmVtYWluaW5nIHNvdXJjZQ0KPiBvZiBlbnRyb3B5IGZvciBDb0NvIGd1ZXN0
cyBpcyBSRFJBTkQuDQo+IA0KPiBJZiBSRFJBTkQgaXMgYnJva2VuIC0tIGR1ZSB0byBDUFUgaGFy
ZHdhcmUgZmF1bHQgLS0gdGhlIGdlbmVyaWMgcGF0aA0KPiB3aWxsIFdBUk4oKSwgYnV0IHByb2Jh
Ymx5IENvQ28gc3lzdGVtcyBzaG91bGRuJ3QgZXZlbiBjb250aW51ZQ0KPiBleGVjdXRpbmcuIFRo
aXMgaXMgbW9zdGx5IGEgY29uY2VybiBhdCBib290IHRpbWUgd2hlbiBpbml0aWFsbHkgc2VlZGlu
Zw0KPiB0aGUgUk5HLCBhcyBhZnRlciB0aGF0IHRoZSBjb25zZXF1ZW5jZXMgb2YgYSBicm9rZW4g
UkRSQU5EIGFyZSBtdWNoIG1vcmUNCj4gdGhlb3JldGljYWwuDQo+IA0KPiBTbywgdHJ5IGF0IGJv
b3QgdG8gc2VlZCB0aGUgUk5HIHVzaW5nIDI1NiBiaXRzIG9mIFJEUkFORCBvdXRwdXQuIElmIHRo
aXMNCj4gZmFpbHMsIHBhbmljKCkuIFRoaXMgd2lsbCBhbHNvIHRyaWdnZXIgaWYgdGhlIHN5c3Rl
bSBpcyBib290ZWQgd2l0aG91dA0KPiBSRFJBTkQsIGFzIFJEUkFORCBpcyBlc3NlbnRpYWwgZm9y
IGEgc2FmZSBDb0NvIGJvb3QuDQo+IA0KPiBUaGlzIHBhdGNoIGlzIGRlbGliZXJhdGVseSB3cml0
dGVuIHRvIGJlICJqdXN0IGEgQ29DbyB4ODYgZHJpdmVyDQo+IGZlYXR1cmUiIGFuZCBub3QgcGFy
dCBvZiB0aGUgUk5HIGl0c2VsZi4gTWFueSBkZXZpY2UgZHJpdmVycyBhbmQNCj4gcGxhdGZvcm1z
IGhhdmUgc29tZSBkZXNpcmUgdG8gY29udHJpYnV0ZSBzb21ldGhpbmcgdG8gdGhlIFJORywgYW5k
DQo+IGFkZF9kZXZpY2VfcmFuZG9tbmVzcygpIGlzIHNwZWNpZmljYWxseSBtZWFudCBmb3IgdGhp
cyBwdXJwb3NlLiBBbnkNCj4gZHJpdmVyIGNhbiBjYWxsIHRoaXMgd2l0aCBzZWVkIGRhdGEgb2Yg
YW55IHF1YWxpdHksIG9yIGV2ZW4gZ2FyYmFnZQ0KPiBxdWFsaXR5LCBhbmQgaXQgY2FuIG9ubHkg
cG9zc2libHkgbWFrZSB0aGUgcXVhbGl0eSBvZiB0aGUgUk5HIGJldHRlciBvcg0KPiBoYXZlIG5v
IGVmZmVjdCwgYnV0IGNhbiBuZXZlciBtYWtlIGl0IHdvcnNlLiBSYXRoZXIgdGhhbiB0cnlpbmcg
dG8NCj4gYnVpbGQgc29tZXRoaW5nIGludG8gdGhlIGNvcmUgb2YgdGhlIFJORywgdGhpcyBwYXRj
aCBpbnRlcnByZXRzIHRoZQ0KPiBwYXJ0aWN1bGFyIENvQ28gaXNzdWUgYXMganVzdCBhIENvQ28g
aXNzdWUsIGFuZCB0aGVyZWZvcmUgc2VwYXJhdGVzIHRoaXMNCj4gYWxsIG91dCBpbnRvIGRyaXZl
ciAod2VsbCwgYXJjaC9wbGF0Zm9ybSkgY29kZS4NCj4gDQo+IENjOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gQ2M6IERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhh
dC5jb20+DQo+IENjOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPg0K
PiBDYzogRWxlbmEgUmVzaGV0b3ZhIDxlbGVuYS5yZXNoZXRvdmFAaW50ZWwuY29tPg0KPiBDYzog
SC4gUGV0ZXIgQW52aW4gPGhwYUB6eXRvci5jb20+DQo+IENjOiBJbmdvIE1vbG5hciA8bWluZ29A
cmVkaGF0LmNvbT4NCj4gQ2M6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxp
bnV4LmludGVsLmNvbT4NCj4gQ2M6IFRoZW9kb3JlIFRzJ28gPHR5dHNvQG1pdC5lZHU+DQo+IENj
OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gU2lnbmVkLW9mZi1ieTog
SmFzb24gQS4gRG9uZW5mZWxkIDxKYXNvbkB6eDJjNC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIHYx
LT52MjoNCj4gLSBwYW5pYygpIGluc3RlYWQgb2YgQlVHX09OKCksIGFzIHN1Z2dlc3RlZCBieSBB
bmRpIEtsZWVuLg0KPiAtIFVwZGF0ZSBjb21tZW50cywgbm93IHRoYXQgd2UgaGF2ZSBpbmZvIGZy
b20gQU1EIGFuZCBJbnRlbC4NCj4gDQo+ICBhcmNoL3g4Ni9jb2NvL2NvcmUuYyAgICAgICAgfCAz
NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGFyY2gveDg2L2luY2x1
ZGUvYXNtL2NvY28uaCB8ICAyICsrDQo+ICBhcmNoL3g4Ni9rZXJuZWwvc2V0dXAuYyAgICAgfCAg
MiArKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC94ODYvY29jby9jb3JlLmMgYi9hcmNoL3g4Ni9jb2NvL2NvcmUuYw0KPiBpbmRl
eCBlZWVjOTk4NjU3MGUuLjM0ZDdjNjc5NWU4YyAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvY29j
by9jb3JlLmMNCj4gKysrIGIvYXJjaC94ODYvY29jby9jb3JlLmMNCj4gQEAgLTMsMTMgKzMsMTYg
QEANCj4gICAqIENvbmZpZGVudGlhbCBDb21wdXRpbmcgUGxhdGZvcm0gQ2FwYWJpbGl0eSBjaGVj
a3MNCj4gICAqDQo+ICAgKiBDb3B5cmlnaHQgKEMpIDIwMjEgQWR2YW5jZWQgTWljcm8gRGV2aWNl
cywgSW5jLg0KPiArICogQ29weXJpZ2h0IChDKSAyMDI0IEphc29uIEEuIERvbmVuZmVsZCA8SmFz
b25AengyYzQuY29tPi4gQWxsIFJpZ2h0cyBSZXNlcnZlZC4NCj4gICAqDQo+ICAgKiBBdXRob3I6
IFRvbSBMZW5kYWNreSA8dGhvbWFzLmxlbmRhY2t5QGFtZC5jb20+DQo+ICAgKi8NCj4gDQo+ICAj
aW5jbHVkZSA8bGludXgvZXhwb3J0Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvY2NfcGxhdGZvcm0u
aD4NCj4gKyNpbmNsdWRlIDxsaW51eC9yYW5kb20uaD4NCj4gDQo+ICsjaW5jbHVkZSA8YXNtL2Fy
Y2hyYW5kb20uaD4NCj4gICNpbmNsdWRlIDxhc20vY29jby5oPg0KPiAgI2luY2x1ZGUgPGFzbS9w
cm9jZXNzb3IuaD4NCj4gDQo+IEBAIC0xNTMsMyArMTU2LDM2IEBAIF9faW5pdCB2b2lkIGNjX3Nl
dF9tYXNrKHU2NCBtYXNrKQ0KPiAgew0KPiAgCWNjX21hc2sgPSBtYXNrOw0KPiAgfQ0KPiArDQo+
ICtfX2luaXQgdm9pZCBjY19yYW5kb21faW5pdCh2b2lkKQ0KPiArew0KPiArCXVuc2lnbmVkIGxv
bmcgcm5nX3NlZWRbMzIgLyBzaXplb2YobG9uZyldOw0KPiArCXNpemVfdCBpLCBsb25nczsNCj4g
Kw0KPiArCWlmIChjY192ZW5kb3IgPT0gQ0NfVkVORE9SX05PTkUpDQo+ICsJCXJldHVybjsNCj4g
Kw0KPiArCS8qDQo+ICsJICogU2luY2UgdGhlIENvQ28gdGhyZWF0IG1vZGVsIGluY2x1ZGVzIHRo
ZSBob3N0LCB0aGUgb25seSByZWxpYWJsZQ0KPiArCSAqIHNvdXJjZSBvZiBlbnRyb3B5IHRoYXQg
Y2FuIGJlIG5laXRoZXIgb2JzZXJ2ZWQgbm9yIG1hbmlwdWxhdGVkIGlzDQo+ICsJICogUkRSQU5E
LiBVc3VhbGx5LCBSRFJBTkQgZmFpbHVyZSBpcyBjb25zaWRlcmVkIHRvbGVyYWJsZSwgYnV0IHNp
bmNlIGENCj4gKwkgKiBob3N0IGNhbiBwb3NzaWJseSBpbmR1Y2UgZmFpbHVyZXMgY29uc2lzdGVu
dGx5LCBpdCdzIGltcG9ydGFudCB0byBhdA0KPiArCSAqIGxlYXN0IGVuc3VyZSB0aGUgUk5HIGdl
dHMgc29tZSBpbml0aWFsIHJhbmRvbSBzZWVkcy4NCj4gKwkgKi8NCj4gKwlmb3IgKGkgPSAwOyBp
IDwgQVJSQVlfU0laRShybmdfc2VlZCk7IGkgKz0gbG9uZ3MpIHsNCj4gKwkJbG9uZ3MgPSBhcmNo
X2dldF9yYW5kb21fbG9uZ3MoJnJuZ19zZWVkW2ldLA0KPiBBUlJBWV9TSVpFKHJuZ19zZWVkKSAt
IGkpOw0KPiArDQo+ICsJCS8qDQo+ICsJCSAqIEEgemVybyByZXR1cm4gdmFsdWUgbWVhbnMgdGhh
dCB0aGUgZ3Vlc3QgZG9lc24ndCBoYXZlIFJEUkFORA0KPiArCQkgKiBvciB0aGUgQ1BVIGlzIHBo
eXNpY2FsbHkgYnJva2VuLCBhbmQgaW4gYm90aCBjYXNlcyB0aGF0DQo+ICsJCSAqIG1lYW5zIG1v
c3QgY3J5cHRvIGluc2lkZSBvZiB0aGUgQ29DbyBpbnN0YW5jZSB3aWxsIGJlDQo+ICsJCSAqIGJy
b2tlbiwgZGVmZWF0aW5nIHRoZSBwdXJwb3NlIG9mIENvQ28gaW4gdGhlIGZpcnN0IHBsYWNlLiBT
bw0KPiArCQkgKiBqdXN0IHBhbmljIGhlcmUgYmVjYXVzZSBpdCdzIGFic29sdXRlbHkgdW5zYWZl
IHRvIGNvbnRpbnVlDQo+ICsJCSAqIGV4ZWN1dGluZy4NCj4gKwkJICovDQo+ICsJCWlmIChsb25n
cyA9PSAwKQ0KPiArCQkJcGFuaWMoIlJEUkFORCBpcyBkZWZlY3RpdmUuIik7DQo+ICsJfQ0KPiAr
CWFkZF9kZXZpY2VfcmFuZG9tbmVzcyhybmdfc2VlZCwgc2l6ZW9mKHJuZ19zZWVkKSk7DQoNCg0K
V2hpbGUgdGhpcyBwYXRjaCBmdW5jdGlvbmFsbHkgZG9lcyBjbG9zZSB0byB3aGF0IHdlIG5lZWQs
IGkuZS4gYWRkcyAyNTYgYml0cyB0byB0aGUgcG9vbA0KZnJvbSByZHJhbmQgYW5kIHBhbmljcyBv
dGhlcndpc2UsIEkgcGVyc29uYWxseSBmaW5kIGl0IHF1aXRlIGNvbmZ1c2luZyBpbiB0aGUgb3Zl
cmFsbA0KYXJjaGl0ZWN0dXJlIG9mIExpbnV4IFJORy4gWW91IGhhdmUgZG9uZSBhIGxvdCBvZiBn
cmVhdCB3b3JrIHRvIGNsZWFuIHRoZSBhcmNoDQpiYWNrIGluIDIwMjIsIGFuZCBjdXJyZW50bHkg
d2UgaGF2ZSB0d28gc3RyYWlnaHRmb3J3YXJkIHBhdGhzIHdoZXJlIHRoZSBlbnRyb3B5IGlzDQph
ZGRlZCBmcm9tIHJkcmFuZC9yZHNlZWQgaW50byB0aGUgcG9vbCBhbmQgc2VlZCBwcm9kdWN0aW9u
IHdpdGggcHJvcGVyIGVudHJvcHkNCmFjY291bnRpbmcuIFllcywgSSB0aGluayBldmVyeW9uZSB3
b3VsZCBhZ3JlZSAoYW5kIGl0IGhhcyBiZWVuIHBvaW50ZWQgaW4gbnVtZXJvdXMNCnBhcGVycy9y
ZXBvcnRzKSB0aGF0IGVudHJvcHkgYWNjb3VudGluZyBpcyBzb21ld2hhdCBkb29tZWQgYnVzaW5l
c3MsIGJ1dCB0aGlzDQppcyB3aGF0IHlvdSBoYXZlIHRvIGRvIGF0IGxlYXN0IGluaXRpYWxseSBp
biBvcmRlciB0byBzdGlsbCBtYWludGFpbiB0aGUgb3ZlcmFsbA0KbG9naWMgb2Ygd2h5IExpbnV4
IFJORyBkb2VzIHdoYXQgaXQgZG9lcy4gIA0KDQpOb3cgd2l0aCB0aGlzIHBhdGNoLCB0aGUgbG9n
aWMgYmVjb21lcyBzb21ld2hhdCBtZXNzeToNCg0KMS4gaW4gZWFybHkgYm9vdCBMaW51eCBSTkcg
d2lsbCBhdHRlbXB0IHRvIGdldCBpbnB1dHMgZnJvbSByZHJhbmQvcmRzZWVkIGFueWhvdw0KYW5k
IGFkZCBpdCB0byB0aGUgcG9vbCBhbmQgY291bnQgZW50cm9weSAoaWYgc3VjY2Vzc2Z1bCBhbmQg
aWYgd2UgdHJ1c3QgY3B1IHJuZykNCjIuIG5vdyBzb21ld2hhdCBsYXRlciwgd2UgKmFnYWluKiB0
cnkgdG8gbWl4IGluIDI1NiBiaXRzIGZyb20gKnJkcmFuZCBvbmx5Kg0KKGlkZWFsbHkgaW4gbm9u
LWF0dGFjayBjYXNlcyB3ZSBzaG91bGQgdXNlIHJkc2VlZCBoZXJlIGlmIGl0IGdpdmVzIHVzIG91
dHB1dCkgdmlhDQp0aGUgaW50ZXJmYWNlIHRoYXQgaXMgYnkgTGludXggUk5HIGRlc2lnbiBpbnRl
bmRlZCBmb3IgY29uc3VtaW5nIGVudHJvcHkgZnJvbQ0KICp1bnRydXN0ZWQqIHNvdXJjZXMgKGhl
bmNlIG5vIGVudHJvcHkgY291bnRpbmcpLCBhbmQgaWYgd2UgZmFpbCB0aGlzIGFjdGlvbg0KKHdo
aWNoIGFyY2hpdGVjdHVyYWxseSBzaG91bGQgbm90IG1hdHRlciBmb3IgTGludXggUk5HIGJhc2Vk
IG9uIHRoZSB1c2VkIGludGVyZmFjZSkNCndlIGFyZSBnb2luZyB0byBwYW5pYyB0aGUgbWFjaGlu
ZSwgYmVjYXVzZSBpbiBmYWN0IHRoaXMgaXMgdGhlIG1vc3QgaW1wb3J0YW50DQpmb3IgQ29Dby4g
DQogDQpJIGZpbmQgdGhlIGxvZ2ljIGFib3ZlIGNvbmZ1c2luZyBhbmQgbm90IHZlcnkgY2xlYW4u
IA0KU2hvdWxkIHdlIGp1c3QgZ28gYmFjayB0byB0aGUgYXBwcm9hY2ggdG8gYWRkIG9uZSBtb3Jl
IGNoZWNrIGluIHJhbmRvbV9pbml0X2Vhcmx5KCkNCnRvIHBhbmljIGluIHRoZSBDb0NvIGNhc2Ug
aWYgYm90aCByZHNlZWQgYW5kIHJkcmFuZCBmYWlscyB0byBnaXZlIHVzIGFueXRoaW5nPyANClRo
aXMgd2F5IG9uZSBjYW4gc3RpbGwgbG9vayBhdCB0aGUgTGludXggUk5HIGNvZGUgb3ZlcmFsbCBh
bmQgdW5kZXJzdGFuZCB3aGF0DQppcyBnb2luZyB0byBiZSB0aGUgYmVoYXZpb3IgaW4gYWxsIGNv
bmRpdGlvbnMvY2FzZXM/IA0KDQpCZXN0IFJlZ2FyZHMsDQpFbGVuYS4NCiANCg0K

