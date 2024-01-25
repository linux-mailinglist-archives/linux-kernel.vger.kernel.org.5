Return-Path: <linux-kernel+bounces-39407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A242C83D084
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5AA41C230A4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3617C134A4;
	Thu, 25 Jan 2024 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFLEiJLz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3832212B8A;
	Thu, 25 Jan 2024 23:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706224824; cv=fail; b=CbR3PCP09cAXCzvLXs/xj7pzT24gCmJGCU2QckWarjy/iNL08CUaxXe3dlrykuNiP86Vav6AQ1JE4LdXZuUQTWhlsjRAB7dEJbX3Y5kvN/+gAtuZXNfv0qoZ+NNQ0DUhwcanyD0J2dgXKNn2ZwG6YFTX2NJwjgta+4aDrERJDLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706224824; c=relaxed/simple;
	bh=DP2Ye4IDgBdfntjMRZxX2hJlP36NDNXCNzYTdu9h62s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CKPGzot8ziSk8k0yhD4s3ZcgDM1/sN11D2oW0YHHq69UeZAD+adVeU5VY/BIwPU74cr/zXH7Ahyw2wmbOe2SGRN7f4y8WAvoSRF8FJWa/5M//6+66qtR1CQEmi+FjpyLnSTTwgIRwbVYfTGAbBAGdlMurilpey3cbcWPrn/kBD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SFLEiJLz; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706224822; x=1737760822;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DP2Ye4IDgBdfntjMRZxX2hJlP36NDNXCNzYTdu9h62s=;
  b=SFLEiJLzMJQ+FLM2+y/qmF/wrci5JJDS4rD8hay4tqy2cVJihOol85zw
   1tTy/DJvDQLxNkaAy4OjGfhC51Wo0qbk4XbovuTtYSbiahgFjsEKzdIa3
   VCTvsuGM2tT50qZXi4wvwrWNKtg3BpL8sCavkBty61VqbiXcmE75yn7tE
   FahGBBs5jys/mKV0pPMHdo0Q5gQaR+821LL/B9pgj5wv6mCUuUCBniQp1
   2V3Yf+LU3NVY3D3SBMxeNo65l/3ZPd1+wLTA3W8PfUd+qVD59ckJ4A+3F
   lBU0LyV0W8NojnyN4YqKDP0rO6SWv3o8Ezyx+kMCXHxlPe/qwCjSNQEdu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9017999"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9017999"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 15:20:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="28940970"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2024 15:20:20 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 15:20:20 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 15:20:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 15:20:19 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 15:20:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5uQmwrOiWIGCMg4Gco7ArVx4w3nEYNZn6JUTpOyRq5/vhi9o5abJ7oqRxmR9Lpo82oUFnrSo1dbg7bKSWaVOJ22vGWDqREAyeC/KR4K5Z8YFODwdoXrlZ9fuqWrwYqLGO34qubm/bEk/zj22LK6KGhh1fdzL41S2KyIeCzpNkABNuXcCUACIln3mBFLCTTxD68tlWj166VXGNBD9U+IgboDz+v2nGZnAlU44nB8JszdaLoXLboCFvOPc+O4pKsyRqkeuyNWvo8ptLnCCWZ8RupsClnCEn1bAIFC2OGowyGdKSNv8DHmqyyCaxSGu5tdPAGxF+B+xysiZpDXg6BvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DP2Ye4IDgBdfntjMRZxX2hJlP36NDNXCNzYTdu9h62s=;
 b=JXPr/0JC7amMyXMbwT4OYJYHtPUskzDG7AQ2E1alFdEkKoTEnB7QdaElmgG0V32GdtFp51R4zjLbqqL//4pNcfDANVh4cmBIlcqH98Qcd0sKOMvfkyh4Nsy6AdG0L4kkZYI3LbnZAYatMIj/BbYo+wS+NdTQK3K+6rNmV7UKkpI8j6kEDx17KYdvEErpzMkRQ3B3ubbI7AupKjELtlnil9Ab8N2KZ15wenxaeXvUQpnd0QnBgWUHqx+GlqfiWWvZtfpBJUY7ZHoHqgkj0PJxfJLw04XXi2d2py3R+FNDqexkhrwsproLBpl0RpM/D5x1pcHMcTuFx3cHWDvMKy1+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5370.namprd11.prod.outlook.com (2603:10b6:408:11b::8)
 by CO1PR11MB5138.namprd11.prod.outlook.com (2603:10b6:303:94::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Thu, 25 Jan
 2024 23:20:18 +0000
Received: from BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::3d32:2de7:4924:4f2f]) by BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::3d32:2de7:4924:4f2f%5]) with mapi id 15.20.7228.027; Thu, 25 Jan 2024
 23:20:18 +0000
From: "Chang, Junxiao" <junxiao.chang@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: John Ogness <john.ogness@linutronix.de>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Li, Hao3"
	<hao3.li@intel.com>, "Li, Lili" <lili.li@intel.com>, "Gao, Jianfeng"
	<jianfeng.gao@intel.com>, "linux-rt-users@vger.kernel.org"
	<linux-rt-users@vger.kernel.org>
Subject: RE: RE: [PATCH 1/2] printk: nbcon: move locked_port flag to struct
 uart_port
Thread-Topic: RE: [PATCH 1/2] printk: nbcon: move locked_port flag to struct
 uart_port
Thread-Index: AQHaTb7WI2Skm3nhUEimTu1KM9GNnrDouRsAgAAFGACAAPeVkIAA1WuAgACikNA=
Date: Thu, 25 Jan 2024 23:20:17 +0000
Message-ID: <BN9PR11MB53704D5616C125B321120F6EEC7A2@BN9PR11MB5370.namprd11.prod.outlook.com>
References: <BN9PR11MB5370AED9C562F9DA75093557EC742@BN9PR11MB5370.namprd11.prod.outlook.com>
 <20240123054033.183114-1-junxiao.chang@intel.com>
 <20240123054033.183114-2-junxiao.chang@intel.com>
 <87le8f9i75.fsf@jogness.linutronix.de>
 <20240124100524.ZyAPfPU5@linutronix.de>
 <BN9PR11MB53701E5CF2737908FA9EB532EC7A2@BN9PR11MB5370.namprd11.prod.outlook.com>
 <20240125133523.W7aDeBqt@linutronix.de>
In-Reply-To: <20240125133523.W7aDeBqt@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5370:EE_|CO1PR11MB5138:EE_
x-ms-office365-filtering-correlation-id: 4c3e88ea-ff57-45a7-1141-08dc1dfc3192
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GPzL9UOReGltlg9U18FdajddLqvNTgc5hJEsYohwXoxSR/Gi6UzStvwiEm/HhnziB4+XXVT4Zya1ovjoGCZPot34f9EHvDRx9wkK8D5imRfLO0jK6+S/PBHT7btmS0YpTvN+8ZGEPV1prbe3RilwKiicEjgW6F+txnxc0KPa40uPd6v0H5VKHvWHm56vz1oXK5V4PElFnnF3ONuB2EQxRUapaNYI9sGf8piolbFw/zDn+gQTGW402JwnGrjFBXboOVpcyBxb41u3aA8Zz1qN13c/Gwz0SGVWA/L4XdwsWmTxq/Y5RyMt77j9pjDd3Gj3om6xuvj/0a6K19xFNFIZi6/ZI3dran69DrIvxUWkNXoRorWkuj7LnwdF3GAs77feybp1a8zqC1zTO2OSGFIV+r+30EbnapPnv/l/bEorJNOcMalqLCx9OeixYrYdpajLAnySjl+CXp3KPcsToPckPzeOj4OPTMPqCj3zb7Evi1cf3lCl2T/cb5jS3um0rd6n9Q822AxrbIS6hmvJuGWMzecfedhwB+uVy9qVef3v/GOCa+E9AGukaLq4EyZ1CVEd4r4zQEm7qv8wIVm+BQZI3je7kq/zyPnSxfJ6h9Jei4sBO4wvBs4Cpo1d9KZbNbLx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(83380400001)(9686003)(26005)(38100700002)(122000001)(76116006)(8936002)(478600001)(2906002)(66556008)(4326008)(8676002)(5660300002)(52536014)(7696005)(66476007)(4744005)(6916009)(66946007)(6506007)(54906003)(64756008)(66446008)(316002)(71200400001)(86362001)(38070700009)(82960400001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTVncndtMUQrK2hiRnN4MnpoQ2hQRm1lTnBCSnplYjA5RERWOTZ3RmkrZUJ2?=
 =?utf-8?B?M3FFcW45QnNoUWV5RmNpK2JIcUhWY2RIdUJDOGIyNnpEVEFjNXN4d21kamdP?=
 =?utf-8?B?cXVZU0RUTk03eDNEVFBPQnNwenJhMURWQTl0WlJhT0VyYkRtRkZCVWpaY1dX?=
 =?utf-8?B?eVgwNy81TTliRHQ5WXhjRWh1QUYwNGY2V3dxNy9UOHhtcjl6bW0yekNsbytB?=
 =?utf-8?B?djlqZHl4YWp0Y09nOVg5NVdKQ0piRGpRdTc5bzlDdmdWejVJRzJEQVlFd3l0?=
 =?utf-8?B?cHhDMVhqN3VIWGROQWZ3bncwTTIvaVgzQmZ2WU1reEo0cGdEL3g2aVcvNHR5?=
 =?utf-8?B?SWdjZkI2cmhWY3FVZEdqNEVjYmlHVnpMZDRxT3FGNGVaV3ozWk9EaU9WcUdM?=
 =?utf-8?B?OEZMNTJ4NlliVDdsbDQ1TkVYb0N5aEwxOU1wVnFnU1VOdlNrSVptdSs5dDJi?=
 =?utf-8?B?Q2kvUWFuK2VkT2pjZi9LalJuQW9tK3ZldU5CVjNxSWplSkhsVzlVRlJCd0My?=
 =?utf-8?B?Q3ZwVXgxWk1QbUtPblJldW5xZVpkN1p4dlNKbTFGckEvV3dtZDlIYzlaNFV6?=
 =?utf-8?B?Zm5SQ2N4NzJjVmdhWFh1Qzh1YjIyWHhiSFk2RGlTWkFDK3F4UnVSamh0TEUz?=
 =?utf-8?B?bVorSW5Ma2RZbVV5b2F2SWlsbitmSzlGZURqMjFaVVZXME5OT3BqelNxRDdS?=
 =?utf-8?B?ajFzZ1hhWk42RVRrTkdZRDk2d0tacXJMemlTM09mUmRzSmZMTFpscmNNYnRR?=
 =?utf-8?B?OGppU1BtVVFFN284SllEUitNSnB1TWFWbjFvdkx4MEs5M2JXUjRRTjlyMDFP?=
 =?utf-8?B?cFlma1BHSzV2N1FuTGp1a21lckw1a3JFc1doQ1VTNVRlUnVjeUxvdnU1SUtT?=
 =?utf-8?B?dUhPZHIwUHNIUUpHbVc3SllpdFhyMVQvYml3RWU0S0NnYXZFZkFxLzNGai9u?=
 =?utf-8?B?cS9rNVR6ZHMxMnlWUnowVUJEa3pLZXRaNW9uQUUvYmhlbUVEdkExdm5nV0cr?=
 =?utf-8?B?c0hwUGpKSTZZWG5LSHhJbXVaRHFZNmxVcWpCMmdDQmpxQXAydi9RdlpmakRT?=
 =?utf-8?B?VVJiWElFVDcyQktmeWEyd01tSGNOditKSmtmcU52cE9KeTFIWWxyWWNCYVh1?=
 =?utf-8?B?RnRiMU1mQk4zT2hxSm5GMVhBbThYZVVOdkJtL2RrMVl3K0RLeWZsSG9iNFdJ?=
 =?utf-8?B?OStMTHpGSzFUT2U2UGFuZ2t5M1Fia1MxYVg3bXRPWGFOdEtOR0RWczBqNVpV?=
 =?utf-8?B?V0xKYlVpaXY5NU5QN0k3TTMvMnhXREtXOWZiNFY2bm5JMGJzMm9uN0FQamcv?=
 =?utf-8?B?T0pXUDFIWXRqb05RZTU2SGpCZWhGSWRHbTd2OXYzK3piZmhPcU04SGFNamZu?=
 =?utf-8?B?K2NzbG4yQ3hiWGFYSnhjd21oY2ZqNVVrZmFrMjc5cHFXdzdyYURkZEZZS3VP?=
 =?utf-8?B?ZVUrOWZYclZyOUs0WmNPL0dYTmc4UEsvVExSMHIzaUM5NytyWGMzUWQ3cHlC?=
 =?utf-8?B?ZWRJNGpRZS92MWR2cThuRVcweEV3SFFsRlBRVkYvWGQyenFiZEdGTVhCLzVs?=
 =?utf-8?B?ZzJyai9ZOHd2R0pFTzJCbjNQQTdnOUJVWGlqNWJDNHZXbWp6ZE8zRW5YYVdi?=
 =?utf-8?B?YklUazNaM0VTcE5WRG0ycXpydkN2ZE1mTkIyTnVvaHdUYXhYUTdad0lxY2FB?=
 =?utf-8?B?TlJJRFNhckx4dTdFemh0aEM5c01jdjYxMlV2ak5wdWZ6bnl0YjBtK0xMYjFJ?=
 =?utf-8?B?bmlXVGU4Q01TTEdCOUhvS0ZiZVc3djFhTXQ5OU9NbTR6dUU4YndJMEs0Umx3?=
 =?utf-8?B?YkNmbkNBWThlNGd6bnBLSmV2ZnVIL1N2YklicWNsUkphQXAreDlUcTd4bzNn?=
 =?utf-8?B?cm1QT2pra1NOeFZ5bHV3cjVNaVdWTE1vM0ZQTjFEdnpCT1ZzdjY0cUwyUGxp?=
 =?utf-8?B?bVNSOGxMTW8vMG9yYS8vUFA2SVh0MnZBSUxIR3VKUkZaVTMxNGxaU3BqMUg1?=
 =?utf-8?B?WUJvZHQrYk1PSnRETW9SQXBwQW9ZYXZLZElqSGRua1FsZnBldDFKUHkxMDBU?=
 =?utf-8?B?MDFkaGNWWC9qazJKSTM5dkN2eTh5YmhUa2lucXUvcEVCeEVTZHNvc1NuSVNP?=
 =?utf-8?Q?jCybh9OHEcSnhlHGo/6QpmjvC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3e88ea-ff57-45a7-1141-08dc1dfc3192
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 23:20:18.0283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uqeTdcjx/zxyI85IsUED5SNFp6pQlI3aRBCdmD5s4QAkBGLfiKq2bigH3CxHxVT4Uqj5IEmJQEKo5AHTHwbYUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5138
X-OriginatorOrg: intel.com

PiA+ICBUaGF0IGlzLCBhbGwgODI1MCBzZXJpYWwgZGV2aWNlcycgY29uc29sZSBwb2ludGVyIGFy
ZSBzYW1lLCB0aGV5IHBvaW50IHRvIHVuaXY4MjUwX2NvbnNvbGUuDQoNCj4gT2theSwgU28gdGhh
dCBJIHNlZSB0aGlzIGFuZCB0aGUgdW5iYWxhbmNlZCBhY3F1aXJlLyByZWxlYXNlIHBhcnQgd2l0
aCB0aGUgYXR0YWNoZWQgcGF0Y2guIEkgbGVhdmUgaXQgdG8gSm9obuKApiBCdHcuIFlvdSBkb24n
dCBzZWUga2VybmVsIGxvZyBvdXRwdXQgb24gdHR5UzQgKyB0dHlTNSwgcmlnaHQ/IEp1c3QgYSBs
b2dpbiBwcm9tcHQuDQo+DQo+IFNlYmFzdGlhbg0KDQpSaWdodC4gQXQgdGhhdCB0aW1lLCBvbmx5
IHR0eVMwIGlzIGNvbnNvbGUgYW5kIG5iY29uLg0KDQpUaGFua3MsDQpKdW54aWFvDQo=

