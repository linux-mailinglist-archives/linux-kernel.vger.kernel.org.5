Return-Path: <linux-kernel+bounces-33909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC1183701D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EDCF1C29690
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F96655C34;
	Mon, 22 Jan 2024 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VdGo1I7j"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB55B55C20
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946888; cv=fail; b=m2FFYlKybnXCdM9OFmO3rkAEL0Pd/PA95aCVVwcfbpfG7t5/F7JED0yjaksvC3XzI8JY1vmh4p+Z+ttK3C0sghsc5kUEiyrMDLEbPHn8TNrWM6PvW4jpwuz5k32rzWJIPuJT4OOo/Zf2HIvts6yuw1N/Np3rWidLQB1/K8EVS98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946888; c=relaxed/simple;
	bh=v/aO1nFZoJ0kIufG85BMFU/aqH81hf/PltD+VBDXQqU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H24p0/7AvsTWtGxxr4WqGc5GmQsCdT+zBBLeie3sKhOMh2vASSeafko9kYQmiUcebxpcWBZLMLBofAfF6162pbQoglW+v2XLiKtR862u8LQAgCRcGAElj75n3lz6ulXhTT3ju5094+KxjT9E0zmfhz54ID98858fw0Y60AJXATM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VdGo1I7j; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705946886; x=1737482886;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v/aO1nFZoJ0kIufG85BMFU/aqH81hf/PltD+VBDXQqU=;
  b=VdGo1I7jH/SbXmjA0B6ocM2xEL6m6fv0md3fA3OCzaLc1/47chuzVhCp
   wnvunPEL9EhU3An5QS6STzUe0/+dCFh0df/Dit1bpqVf2GAY/+IkzRKjh
   msWz14uKGIXUUBOiUqIceFwmzIG3Ja8ebkHJXFrQ7NGFEc0nLANLUoRw6
   vVk8/pSL9GJpdIBLu4zXejvf0ruBWiZZgA2sJLF02Z/2DRfBEqeRx941Y
   Gj1alXtSOipAhr8wRr0n8vtu8jX03UtJu0ri3BddKCSrtVzluLuOWJxIV
   hHQ0EkriYDq59YFIFIKSfNLbrjAdX/iaA2b9qTEUD8zZnm8oAGMKHMje4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="173476"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="173476"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 10:07:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1252131"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 10:07:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 10:07:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 10:07:56 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 10:07:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vf2WCN37eYpjIfB0qH9vpnrvzJ5JKJQPsNqonbk/tp3DJyz8h2HVJKo5tN+WPuG1JbeJIV9YNgxIQ8OOO4GbvlqTvpNQMCX24lRmYff7QASteWqQUoThp4xNfnozKYprzv3WxgSdpyT/qo/bAr1NAVCBp1Xb73R5CQ8zJo9nNm2bciJkwWZRj1Jp3qBRCD4lnu300Wc0Ts3aNgyXEtR5XthKkB82mWEdrm5h/L6bfsBhiAgvN1Y+R/yIJC3CPTeCzntjZz5RfSvNLEPbSX7hM7BT3H85BAapTZi54pbrCo4FXxDvs736Nckxoa+OwT7bAWLzWnsGJKVkdKUfRwVe/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/aO1nFZoJ0kIufG85BMFU/aqH81hf/PltD+VBDXQqU=;
 b=Zaf9QXgUlysQK2ddFi0Anksz1Sf/Pg9SEaP++eRPu5/OhXk9jdMlc3KQcoXTE6uFWm/OIj4sIGHlfVGst+VL1p9IX1NV9S2Y2ezfIyFJjRNoBC3/w++5Bzy/0/mUZEILDUzTWSzqtyeya55UP8+WkARZvRWplY9SILva7v3MmxsX70mFkcqifrLk4kissbuQ3R0Uj2ro23DdYzSMk9MThUpR/35g64Hevi/j/44WMKFDfKzzuEOnBbRm9IW53YlVQAFP67/n+xmO/J9KZ0w8hJaJtycF4ypEpRql6eeXk11dKo434ZLoybIuxAn11Y9ztjcVM3SqswDZWA3QjTrIeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MN2PR11MB4565.namprd11.prod.outlook.com (2603:10b6:208:26a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 18:07:53 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a136:fb19:acde:7670]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a136:fb19:acde:7670%7]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 18:07:53 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, Peter Newman <peternewman@google.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: James Morse <james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>, "Shen, Xiaochen" <xiaochen.shen@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v2] x86/resctrl: Implement new mba_MBps throttling
 heuristic
Thread-Topic: [PATCH v2] x86/resctrl: Implement new mba_MBps throttling
 heuristic
Thread-Index: AQHaSlc7bUSCbHYfxkutH1GOiWvBRLDmHd6AgAAIRFA=
Date: Mon, 22 Jan 2024 18:07:53 +0000
Message-ID: <SJ1PR11MB60837D4884419BDC2DCAA2D2FC752@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231201214737.104444-1-tony.luck@intel.com>
 <20240118214213.59596-1-tony.luck@intel.com>
 <45d2891e-989a-45c9-a527-8b14ff5f8748@intel.com>
In-Reply-To: <45d2891e-989a-45c9-a527-8b14ff5f8748@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MN2PR11MB4565:EE_
x-ms-office365-filtering-correlation-id: 523a85ea-1afc-4941-ba32-08dc1b750dea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OIkpj8ZS5e4vvSalKLg1G96AhLlw0apWySox4g7Yqe5SJFVYCIkgfFXd9lQaeOevda8wvPn6iVXJHtv90R7dszrF73pJp8kmRwOi/zFRF0gIcvpAD3Okb5a12DKbNt8qY+sg064dYZXnomb6F/1G3QF1t/bNzWBGfxqjLQABN+L8EJwKC5GVp13ZAuTYt9Q/+lobibLKuHM/JN3et0EHtPBw0lWpGlYkbYofP7IMyaf5ipDOCRfvftufQx+6sOGtQd9vH41petBvk2U8qZBk8C0vGaT/YJ9bvp8awqSc75Pfqxg/F6uiQPL8TTBrcZyA7XAw/+vXirZuftx45KrCY3jhCaVt/1/OBnxEUg/q3r350hV9OhPKJK/zls2BRgJdshoflozPeTqZ0hENbdWdJrdyMWGxkF4AXsTQzotrv/9hVrA94ixgsMJP6cuvKZabyJ7F84+pTrTbU50Ui5rwurJK1HQGQODT9UxVfSU7Hgder16wG2SQpaFs5vZSMYtM5ZZl6ubAgE1+EmuJPFO/MLZleNvapEEA3R2g3pqGHFBw7+jl8dMpH05X2sjS5UDmNgqASllQMRK6ZvJ/OmjNhxkpK6WKtUQ8l0mN9YHwtem8GP2oebNBEcumCAEB/CkB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(8936002)(7696005)(66946007)(6506007)(8676002)(110136005)(71200400001)(478600001)(66556008)(54906003)(64756008)(316002)(66476007)(66446008)(76116006)(52536014)(26005)(9686003)(83380400001)(41300700001)(4744005)(2906002)(4326008)(5660300002)(55016003)(86362001)(38070700009)(33656002)(122000001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFZoK2wxWkd2clJwbVZHaHJZT1FIUmc5S0laYjVWM1hINVhOQnJyQVNXRjJC?=
 =?utf-8?B?M2lYZUg2Q0JyOTBLUnhDamJnV2FxREtmOWxDUmtXYUlYZkhBYTdjV1ZSMEdr?=
 =?utf-8?B?b29kMHJiVGtDeGszalRCM2dHaHVYSU55N2s5enhDNU5NNHdzSTZncVpQOWJW?=
 =?utf-8?B?aDFUeHpFdUR1cWlLVGlRZk00eElRZit4dVBvWHN6di9oZmMrMW14dEZxT2Js?=
 =?utf-8?B?N3FTbXVaU0UzdWlyNk9wcVNtVnMrOTBKeXFRbXRlaktZUlNFOVNFdnhHdTRz?=
 =?utf-8?B?bjRoUERpR0JuMUNwT3A4ZG9DMTFiTmI4T014Q1p3aXJXV0gvUkxUNlhWTnhy?=
 =?utf-8?B?NXg3NjZtUjVlbVdvSGtLM3BwU0R4TU9qUW1wdW4yWFpYb21ScWVBTm9XYWxC?=
 =?utf-8?B?YWFvUE1IbGZvMnQ0d2hCOGJFVWhQU09uOVdKUDFhcHZRSjZBMk1WRFZ3OElM?=
 =?utf-8?B?TFpJKzYvQW1ESVBrZEswZGV3bHo4eDByV2VQNDBQVGlESUFuUVJnYWhVS014?=
 =?utf-8?B?YSswMS9ER2NwbENkUUp3V0J5YWRBNHAzdjhHMDNZYklTSFAybmtZRWJOTjdj?=
 =?utf-8?B?SDRqd3JpaUk3bGFKZ1d4ckFXejBZZy9aZTdYbys4UWxOQk5lVFRjMVR4YTlH?=
 =?utf-8?B?bXJWTjJaTDNJUWx3N2RHczVDV0ZIUDhNWSs3UnhoOEdwK1lXQkkzcmlSei9H?=
 =?utf-8?B?ZGlndXRxSXdIenkzMzIzRlJhSUhmeWVZU0pmb3Z0Smw4bjBHUnAwMmphM2NM?=
 =?utf-8?B?alU5bi9UTTZLK0huS2NoWXZYb0VnMnEwc1lPSC9xcC9OdHVZcUdnT2swdXpW?=
 =?utf-8?B?b095R0l4QVY4NHpCMlp0ZFk4ektQMURJdENXRHh0SGRveGZ6cUh4SWMwWlBT?=
 =?utf-8?B?U1QzeDlHOCsyS2pMcUhYSzEzZDZYekNENFRzWmVXbHkwQ2dlU0R6dzhSYk5w?=
 =?utf-8?B?UWxyQWpJTUh1cW8xaTgvcGRBV3A4d3BocCszNUl3d1hrTk1Xc0NxaXBnaUdV?=
 =?utf-8?B?TU1MVGh3a0s0YmtWZXlHdVJDQWx0S2JJTDVLcVoyUnVEZ3JqU3o3eGNhL3Rp?=
 =?utf-8?B?WEM0VWVHL0h3TlB5U2NPOGcrMUdzNmtObmtJZWEvWEVha0F1R0d0MEY5RnBB?=
 =?utf-8?B?NU1idVQrTE1GamtRaHFPRlRWOXIzSkczYUZVRVFMN0xuREJ3VUJycVlvSlBl?=
 =?utf-8?B?bUMvekwrOTdqNmZMSnRqT3dRNHhpUGVJQ3F1VHJUNU9IMXhGU1pvQnZFOUdV?=
 =?utf-8?B?cGR3Vm9wcVNYUll4RGtIblVTb1pGbThrNS9YYWYwdzZ1NUJDMVR6VytsakFJ?=
 =?utf-8?B?KzdqdmY3dHErQ3VFdi9SdGM4MVVrMGdyNzdEeGRScEZ5a3BuOGdEM3owSlJV?=
 =?utf-8?B?eXEyM21WQXY0L01ZRUhBQ0ZORm83THNTaHlXWlJwdDd1M094OUJBSXh6UEtS?=
 =?utf-8?B?NGVuakhaQ3VXc3N6Vks5QjRFSm1OQXpldEF5Um1xKzgwSGtqcnJwWVRndHhL?=
 =?utf-8?B?N3FPMW5SVFdXVGdreUpnWFVocW12ZzNMU2l4QTBPOVg0SGxDb2RKUk1OWUoy?=
 =?utf-8?B?Q1I3SC9UMmlhcHYrclhGWW9NUmVZUE1yL0NpV2dvT29abm1ET2kydGJHNW1v?=
 =?utf-8?B?MkpoR3BUR2orUC8wOGdXdlBFa3FWN3I1dnRhR0NMRXpOekxXcUp2ZGtqZXlV?=
 =?utf-8?B?L2UrWjJmYW5YM2x5aWZnZkwyNnNtN2NBYnlwUG1SN1VmTGJUemNPbTJEUHh3?=
 =?utf-8?B?bDlZV2ZDMm01Um5Ra3YzTDhXNVlEaWtQMXVXcW85MCtqcFRYU1k3MzV1VThs?=
 =?utf-8?B?K1F1N2srUWxIRDhMeEg5aHpzak4xUCtXSGtjSTFXaWU1Zzk3dkU5bUo1UllQ?=
 =?utf-8?B?eHpRL3pYMk5xc3FSd1FPQVBqNVp4b0hSMzk2ZWloRWRMRzJaNTMxMmIwM1Rp?=
 =?utf-8?B?dnd0NnBGY2tjcEpIU09zalNJazhsdEdxcWtPczRjckU4b1FKSW12QWlqdEFO?=
 =?utf-8?B?VnNDdzg1YUxyM3p6MENVMGM4MkJMK3FBMlhOcHROSmlWemphdHZYeWttK3Y4?=
 =?utf-8?B?c0JkUlVlbXVGUVZwRnVBT3g0WUJNSDVKTVZXYUFEakRxOFVZUEFFVmkzaHp1?=
 =?utf-8?Q?3OD2oV4YlV42L2nXz3N3v35V4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 523a85ea-1afc-4941-ba32-08dc1b750dea
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 18:07:53.7865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: my6Tnb3XQtDvgGCZAhEgYCG54gkSHXWT4jUTi3u97iytbJhIfFnDr1+qNTeK72U0ex6BSix/XyszUOWY9GYAhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4565
X-OriginatorOrg: intel.com

PiBJIGFtIHNvcnJ5IFRvbnksIHRoaXMgcmV2ZXJzZS1maXIgYnJlYWthZ2Ugc2xpcHBlZCB0aHJv
dWdoLiBJIG9ubHkgbm90aWNlZCBpdCBhZnRlcg0KPiB0cnlpbmcgdG8gc2VlIGhvdyBiZXN0IHRv
IHByZXNlbnQgYWxsIHRoZSBwZW5kaW5nIHdvcmsgdG8geDg2IG1haW50YWluZXJzLiBDb3VsZA0K
PiB5b3UgcGxlYXNlIHNlbmQgYSBmaXh1cCB3aXRoIHRoaXMgYWRkcmVzc2VkPyBBZnRlciB0aGF0
IEkgYW0gcGxhbm5pbmcgdG8gcHJvcG9zZSBpdHMNCj4gaW5jbHVzaW9uIGFtb25nIGFsbCB0aGUg
b3RoZXIgcGVuZGluZyByZXNjdHJsIGZpeGVzIGZvbGxvd2VkIGJ5IHRoZSBTTkMgd29yay4gVGhl
IFNOQw0KPiB3b3JrIHdpbGwgbmVlZCBhIHJlYmFzZSBzdGFydGluZyB3aXRoIHRoaXMgc25pcHBl
dCwgdW5sZXNzIHlvdSBzZWUgYW4gZWFzaWVyIHdheSBmb3J3YXJkPw0KDQpSZWluZXR0ZSwNCg0K
VGhhbmtzIGZvciBjYXRjaGluZyB0aGlzLiBJIGNhbiBzZW5kIHYzIG9mIHRoaXMgcGF0Y2ggcmln
aHQgYXdheSAoanVzdCBmaXhpbmcgZmlyIHRyZWUgb3JkZXIgb25seQ0KbmVlZHMgYSBjb21waWxl
IHRlc3QsIG5vdCBleHRlbnNpdmUgcmVncmVzc2lvbiB0ZXN0cykuDQoNCldoYXQgYXJlICJhbGwg
dGhlIG90aGVyIHBlbmRpbmcgcmVzY3RybCIgZml4ZXM/ICBTaW5jZSB0aGUgU05DIHNlcmllcyBp
cyBpbnZhc2l2ZSB0byBzbyBtYW55DQpmaWxlcyAmIGZ1bmN0aW9ucywgSSdsbCBuZWVkIHRvIHJl
LWJhc2UgU05DIG9uIHRvcCBvZiBldmVyeXRoaW5nIGVsc2UgdGhhdCdzIGhhcHBlbmluZyB0aGlz
DQpjeWNsZS4NCg0KLVRvbnkNCg==

