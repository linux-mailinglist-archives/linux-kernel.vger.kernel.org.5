Return-Path: <linux-kernel+bounces-45935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7391984380C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0030D1F2716C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A8A55C04;
	Wed, 31 Jan 2024 07:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ArY8iBL9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8713E54F88
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706686821; cv=fail; b=qA27P3chgjdK0NZmNO22qeOcPOtby13g4zA40nhhb610ntH9FdGirCgB1sGhBjIeY69JF+saYiUx30g4dqAYTlNWDCsNoa0jZe7WpgGjlEA6mUbJehH8dE6aLNv+QIHB0GmBquGABekeny2HgH+Prfa6HfhEM3YmIUVDF1E0//8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706686821; c=relaxed/simple;
	bh=bu11Uo07bFSwH1niLTqk7bk0CPFzTw2nOz9o2u5C8nM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ghkmC7tDJSBUyVGLGfwAGxqcyLO2WaLVsrL11sE+r+KkZBmj04HYe7UfnZbFHw1SOAnourdy876yY5uhD27xmH0tVqL6r43woZyUk+vjWob0gOFzxCHQeWgS/7vg81aLcC5s3ok447fkyYSwAZfoL3vyKizfcq3VRzWkTmOe77k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ArY8iBL9; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706686819; x=1738222819;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bu11Uo07bFSwH1niLTqk7bk0CPFzTw2nOz9o2u5C8nM=;
  b=ArY8iBL9v27l76tsP6mrnAVTzd7QmhaxvNLru8pCfhzODV6cFurH6BdH
   5v5mHd8zD0dhZCLmAfXDeH0HIZLgW6G0jk5QafTEgZB5q5kyfzy75VkmL
   fI7OEyYMRVv3NqXhtWRh2CX54BkWSzvGmQcKiEVlxi6hQF0HImvhbnXQF
   VVheTwOXOHk4WgR83nm8M58G+XP9wgSHPBR0et/JY3upUIb1nnui66vJy
   cfTtfRUVSiAdljxJV1N3Jzc1QvFJQMloRed5faMfa/xCfTZjitHHBLYCE
   2OuXXLf0mA9oM72rQMJ+dDiHKH8lg4qxTj3XwvTVWHedC0TZG4t6ObYqE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10891529"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10891529"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 23:40:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="738013004"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="738013004"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 23:40:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 23:40:17 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 23:40:17 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 23:40:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVZozP8rkm6DW3ZJ12cki+9tB8ttaID/MYKpbWML1Ko1EN1zmkoFFegmXT+MSV4t8Cwdew5LVBPMv4PWqKRc0wIA7llLgYW0EJRTAclXey8xxiJulCfWWcWhpFGrd9DgmaY/mx6jd1fhVGUyYyUHkmTOyyuXpJ+h5UWiOfSPTQjx1Ln3RfLKEsXs/5NZ/2ghPMT21LhErVwSjIXVimj78duObB66C0C20SNXHGP9+6N0uMT3o3DoORiflnytXejiW1AVu3FYiK4vGhcUDkiOFf21JRiuTDwMCozOPrmVJMWL80YbntLo3bGfcRuRN0R9Hl+4hG/rSAZoW3KfpFY1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bu11Uo07bFSwH1niLTqk7bk0CPFzTw2nOz9o2u5C8nM=;
 b=CCQeFHV88LB+fAevy5FwubO4OY/ooDUF6FgRVil5njsRR2WXb6DowP6cItYCpPCBcUwvuo6id5UZ0FTd6LkLZMl0q0Jd6TCBqGuTT+Acsrh+6XMaOTEYAd0GSADiZ/c0fmLr5c/y/5wyysmiOM+LEBRwBvk1hyMAMxwyRC777TNjeVbUzapn5pchn+4x0k7slk/sKFbq5dFCd25aUWEzMs5yzX+qcY+2xDTmqYoEQryD/FFuYJ0YYOoWIaUklMZDUC5Dgc7LKm09uY2a3qxPToTKx4cskU6zWmg/g7qkZhCoF4gZWNMeLJDkgbXWrrahQbMTmeOKcA5kKHWuWj/00w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by BY1PR11MB8126.namprd11.prod.outlook.com (2603:10b6:a03:52e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 07:40:15 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 07:40:15 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "arjan@linux.intel.com" <arjan@linux.intel.com>, "mhklinux@outlook.com"
	<mhklinux@outlook.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "ray.huang@amd.com" <ray.huang@amd.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "Wang, Wendy"
	<wendy.wang@intel.com>, "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
	"Tang, Feng" <feng.tang@intel.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"jgross@suse.com" <jgross@suse.com>, "andy@infradead.org"
	<andy@infradead.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [patch v5 00/19] x86/cpu: Rework topology evaluation
Thread-Topic: [patch v5 00/19] x86/cpu: Rework topology evaluation
Thread-Index: AQHaTfszYvzZD+rPrEaaGpxJfHp7trDzlWEA
Date: Wed, 31 Jan 2024 07:40:15 +0000
Message-ID: <c1dc5df7401e21262ab7cf373b59119fe29e32a4.camel@intel.com>
References: <20240117115752.863482697@linutronix.de>
In-Reply-To: <20240117115752.863482697@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|BY1PR11MB8126:EE_
x-ms-office365-filtering-correlation-id: b08c9f90-1338-4b4c-9540-08dc222fdd9e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Vf29W0hItNCNj1xq6zjol6qUlwWdx2ZJXH11Uht3RAkTdAoyLoHVL3F6DFeqkIOinUcE7ginTP818YneUAeqK/yblY16RLp0MxbpRWMrfUHQ3zSThyanNGcFXRKkB0M1M8vw9Qm3fo93xg1zy4l0E41qq2PALKjZ9HStq9oOiWUhpmuZDdSRklc4zOvkXF3xVRcvMxVIHxeaxL/FNOJWU1mSRP2tlTQRc7y0ifWGOyL0HeEPCZIrukehGAgwwImvGIFKCGgu27TgQ3smKwNS28RL0TwOlFA05ZNPWRNXuIzGVOXeuxm5xOt6IpkACwFvtJE3vWjyzS9b6JVvBzYd5HQCfkYGC8cYYxhSkQapCYGppJSzni/ew11DHuId4zXIS0UIgXJJGmM33kc4CBNisRN5+oAFQumqvVIJurnn7NCd5u/fD1aiWFM2Zc4qDXjtXS7rdXe5f5/jkRSKN95vze/2E/x2eCp19RFQKjg0BP/KaRXeNjJZ1klV4MUH++wKuTgjnBYzujoKBjjP/5jAnLsBZCJb3ieAFbWWooBP/cE8ShGXrdff4NwgdLjAXOYTbZzKtRG426ke7HilzKXRJKIX0fOedrg8S3vfUYQbro=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(966005)(110136005)(64756008)(76116006)(6486002)(66476007)(66946007)(66446008)(54906003)(66556008)(91956017)(6512007)(316002)(478600001)(4326008)(8936002)(8676002)(6506007)(2616005)(83380400001)(2906002)(122000001)(38100700002)(5660300002)(26005)(7416002)(71200400001)(38070700009)(86362001)(41300700001)(36756003)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2hWWEd3SVRnRkt5eS9SQ081QTd3MEJzZnp0S3BZNWgvQTd3L1dHK2FWOWJ5?=
 =?utf-8?B?RWxKK3EyRThaMUluaWJSWGYvZjFmVzZjTklIQmtScmdycTN4Wmcxc3lERC9h?=
 =?utf-8?B?eUptMTJ6SXJUUFcvMGc5UXBjV0huNncrRytCQnNocUlaWEFackc2ZmloKzRH?=
 =?utf-8?B?aXlmbnQxM3RQWEtqK3FKdW90ZHhOeVJ1Nm9YeXpMUU5pOE5UYjVORWVOWk9r?=
 =?utf-8?B?ckNGMTdjZzFBWmRTRVhIT1cxV24xVHpRWDFMc0VYQzBzWFM5ZC9qL245Q2lS?=
 =?utf-8?B?MFRVRHBld3J4ekYzUDUxUTRxbW1yTmpSN0VFbHJGWEpqM0s5WmtHM0xEZVJ6?=
 =?utf-8?B?WEJhUDVNTzk0SGM1RHFPRkFYRGhZMHpoOGZsM3RRSktjU3dmQnE2bTZEOEZt?=
 =?utf-8?B?akFiOU1DM3NudHh5VmkydEpGUWZRVmhhTXMyNW5DcGxpVGh4YmlYYW11Z00x?=
 =?utf-8?B?UFhWS2NKV3VwK1loZGtOZHVjbWdPTnZnbWJucVpDZmRGeHZTaDVLcHY2NU13?=
 =?utf-8?B?eW8xRlErcGluekpSV1lMZ1FBazYxSk1rSGR6dTZNa054OVZNSXhWeXFjUmFH?=
 =?utf-8?B?TzdySkkvOUxKU1RFNTdDaGRyeVh5TTVsamdHV3RXUFlWUktWUXZNN0s0TlVu?=
 =?utf-8?B?djNRczBBcjhhMVIrcWZzSW1xSUlHbUEzcm1NRlhpSnZFZkg4cDhmNXpTcXYr?=
 =?utf-8?B?SmZYOGFIRk5HRjROWnVERnNqSDgrekF0M2xRcmhoVFZkeTExMG9xY2ZXRnVw?=
 =?utf-8?B?eHgvb2dMbEhUaW4xeG9SN1dFVElPVzlBeGl3SWZJck5mWWlnVzJDRW5zVzRx?=
 =?utf-8?B?RFJZeGFFNS9CTlpCK1k2ZlJ5cUhkQ1puSkJKR0J3MUhlQ3RVQUN0Y1VacW5J?=
 =?utf-8?B?T1JkaDMvVHFNS1Nrc2Z6VXlpU0pCeDVwanBFN1hPUnlqb1hLZ3VKYnVqRERX?=
 =?utf-8?B?ZnNxZ3JOc0dFRExKVHEwNDdPT1FWS1pJM2wxNC9SclkwdWRDeWtjK1JNNzdW?=
 =?utf-8?B?S1FEUE5lM1F3QlJxNFluVURKaS8vODdOdW51dUtpelVmTWpNbytPMUIvZmls?=
 =?utf-8?B?YlJoY2RiUXJJNG1uSTRUUlNGZnFoVkx0Vm5yV1NPa0VRN09yUW5TL3k2eHZh?=
 =?utf-8?B?bHJ0UDJZRWd0Tkp2T1pxVTNTeU1EYVlua0pWaFhsQmFYVTRwOU0vQXV0T2JC?=
 =?utf-8?B?amxzUklmNnMvUWdmVG1ZVnpIS2VQSzQ3eFEyWnhIQUFjOXBKdWZLRHFZbHRz?=
 =?utf-8?B?YU4xQTBhcFB4WktNdEZvSzZSUm1YNFNMRGwwbHYvUExTMGQvb1k5UGdvam40?=
 =?utf-8?B?d1hGNWp5dnozOVI2Y1ZpYk9LbElTMTRsb09idUtybS9iczB3NVJMMDBlQmkz?=
 =?utf-8?B?aXo1ZVpPbUJabzF4WkhucnM0d0J4ZEdXVEtRcjBOY0VOZ0ZIeXp1cXRTTmZ5?=
 =?utf-8?B?VlhaZU5VWHAwSkNhMVVZNklTSUZVOEdQZ0lrbkt0RmtzU0Npd1Zjc0FuYnhp?=
 =?utf-8?B?L1dpOEFGV0JMMkJLWVpScXFkcDNVSXE0T2hqcWFnd1pRVDQwVjFReGhRYWdQ?=
 =?utf-8?B?TmRDMW05UjlveHlnWXk1OUVUOTRvWmh2ZDBMREhFQ3NlS0pyT09lOFAvRVVn?=
 =?utf-8?B?bXErRXQ0dkJMRGpTZzhGQm1RcGdIRjBQUTEvOG9LN1IzQzQybXJZWHErTHJV?=
 =?utf-8?B?SlAvZVdEd3VtanVzeFBlVHg0Zlo4dFFnV1NrR21YcEk2Z3pVU1JYZXRkaWpy?=
 =?utf-8?B?eHVFdUwrZ3VOK0hzT3F2UG1BY2t0R3BEK2oyaVpTcEpaeVlPZ0F6K3RXbnBp?=
 =?utf-8?B?S0xnTFREdEw5Z1pRbi82ZXFWaTcwR204a04rK0NHdzRyZkdHN0F2d2xLSlJa?=
 =?utf-8?B?cmtWelJjTWhGZk9NanVJOFRIMWNLRnlyYlAxcnBTRXkwTE1WU3I3ZjRLQkl5?=
 =?utf-8?B?MzhNTysrYllqVnErYVJ2dzUxTWV1NjlsUTV4cExnVFpOeWczTGhqcVUxNW9H?=
 =?utf-8?B?QmpURTNOV0RSdDM5UlN1c3BUUHpTSGRCdEx5M2NLUCs1Z0NVbU9oS1NXZDFD?=
 =?utf-8?B?a3FUcGh6TEpueWdkL2ZGWGJmcTBING9qbkIvM0tIQ0VwMGJtMjJiMTJ2cUJS?=
 =?utf-8?Q?Wi7XzkMRvf/t2ogfMZQla0MX3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EB63ABC37748D448E4BFCE598671236@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08c9f90-1338-4b4c-9540-08dc222fdd9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 07:40:15.5906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/qIsFWCgFNqnQOMXv6yW1rcCnd1gTGKecgpvBzGLd88AO8eX6m/Y4Nssm5QeocpCyx2t0AB+qiPCws3/1U6oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8126
X-OriginatorOrg: intel.com

SGksIFRob21hcywKCldlbmR5IGFuZCBJIGhhdmUgdGVzdGVkIGFsbCB0aGUgdGhyZWUgcGF0Y2gg
c2V0cyBvbiBhIGNvdXBsZSBvZgpwbGF0Zm9ybXMsIGV4Y2VwdCB0aGUgaXNzdWUgcmFpc2VkLCBu
byBvdGhlciBwcm9ibGVtIGlzIG9ic2VydmVkLgoKIFRlc3RlZC1ieTogWmhhbmcgUnVpIDxydWku
emhhbmdAaW50ZWwuY29tPgogVGVzdGVkLWJ5OiBXYW5nIFdlbmR5IDx3ZW5keS53YW5nQGludGVs
LmNvbT4KCkJUVywgb25lIGJlaGF2aW9yIGNoYW5nZSBpbiB0aGlzIHBhdGNoIHNlcmllcyBpcyB0
aGF0IGRpZV9pZCBiZWNvbWUKcGxhdGZvcm0gdW5pcXVlIGluc3RlYWQgb2YgcGFja2FnZSB1bmlx
dWUuCkJ5IG15IHVuZGVyc3RhbmRpbmcsIHRoaXMgd29uJ3QgYnJlYWsgYW55IGtlcm5lbCB1c2Vy
LCBidXQgd2UgaGF2ZSBzb21lCnJlZHVuZGFudCBjb2RlIGxlZnQgd2hlcmUgd2UgY29tcGFyZSBi
b3RoIHBhY2thZ2UgaWQgYW5kIGRpZSBpZC4gZm9yCmV4YW1wbGUsIGluIG1hdGNoX3NtdCgpLAoK
aWYgKGMtPnRvcG8ucGtnX2lkID09IG8tPnRvcG8ucGtnX2lkICYmCiAgICAgICAgICAgICAgICAg
ICBjLT50b3BvLmRpZV9pZCA9PSBvLT50b3BvLmRpZV9pZCAmJgogICAgICAgICAgICAgICAgICAg
Yy0+dG9wby5jb3JlX2lkID09IG8tPnRvcG8uY29yZV9pZCkgewogICAgICAgICAgICAgICAgcmV0
dXJuIHRvcG9sb2d5X3NhbmUoYywgbywgInNtdCIpOwogICAgICAgIH0KCnRoYW5rcywKcnVpCgoK
T24gVHVlLCAyMDI0LTAxLTIzIGF0IDEzOjUzICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
Cj4gVGhpcyBpcyBhIGZvbGxvdyB1cCBvbiBWNCBvZiB0aGlzIHdvcms6Cj4gCj4gwqAgaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMwODE0MDg1MDA2LjU5Mzk5NzExMkBsaW51dHJvbml4
LmRlCj4gCj4gYW5kIGNvbnRhaW5zIG9ubHkgdGhlIG5vdCB5ZXQgYXBwbGllZCBwYXJ0IHdoaWNo
IHJld29ya3MgdGhlIENQVUlECj4gcGFyc2luZy4gVGhpcyBpcyBhbHNvIHByZXBhcmF0b3J5IHdv
cmsgZm9yIHRoZSBnZW5lcmFsIG92ZXJoYXVsIG9mCj4gQVBJQyBJRAo+IGVudW1lcmF0aW9uIGFu
ZCBtYW5hZ2VtZW50Lgo+IAo+IENoYW5nZXMgdnMuIFY0Ogo+IAo+IMKgIC0gQWRkIERJRUdSUCBs
ZXZlbCBleHBsaWNpdGx5Cj4gCj4gVGhpcyBhcHBsaWVzIG9uIExpbnVzIHRyZWUgYW5kIGlzIGF2
YWlsYWJsZSBmcm9tIGdpdDoKPiAKPiDCoCBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvdGdseC9kZXZlbC5naXQgdG9wby0KPiBjcHVpZC12NQo+IAo+IFRoYW5r
cywKPiAKPiDCoMKgwqDCoMKgwqDCoMKgdGdseAo+IC0tLQo+IMKgYXJjaC94ODYva2VybmVsL2Nw
dS90b3BvbG9neS5jwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxNjcgLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCj4gLQo+IMKgYi9hcmNoL3g4Ni9ldmVudHMvYW1kL2NvcmUuY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgwqDCoCAyIAo+IMKgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9hcGljLmjCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8wqDCoMKgIDEgCj4gwqBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWlk
LmjCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMzYgKysrKwo+IMKgYi9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9wcm9jZXNzb3IuaMKgwqDCoMKgwqAgfMKgwqDCoCA1IAo+IMKgYi9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS90b3BvbG9neS5owqDCoMKgwqDCoMKgIHzCoMKgIDM5ICsrKysrCj4gwqBiL2FyY2gv
eDg2L2tlcm5lbC9hbWRfbmIuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqAgNCAK
PiDCoGIvYXJjaC94ODYva2VybmVsL2FwaWMvYXBpY19mbGF0XzY0LmPCoMKgIHzCoMKgwqAgNyAK
PiDCoGIvYXJjaC94ODYva2VybmVsL2FwaWMvYXBpY19ub29wLmPCoMKgwqDCoMKgIHzCoMKgwqAg
MyAKPiDCoGIvYXJjaC94ODYva2VybmVsL2FwaWMvYXBpY19udW1hY2hpcC5jwqAgfMKgwqDCoCA3
IAo+IMKgYi9hcmNoL3g4Ni9rZXJuZWwvYXBpYy9iaWdzbXBfMzIuY8KgwqDCoMKgwqAgfMKgwqDC
oCA2IAo+IMKgYi9hcmNoL3g4Ni9rZXJuZWwvYXBpYy9sb2NhbC5owqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgwqAgMSAKPiDCoGIvYXJjaC94ODYva2VybmVsL2FwaWMvcHJvYmVfMzIuY8KgwqDCoMKg
wqDCoCB8wqDCoMKgIDYgCj4gwqBiL2FyY2gveDg2L2tlcm5lbC9hcGljL3gyYXBpY19jbHVzdGVy
LmMgfMKgwqDCoCAxIAo+IMKgYi9hcmNoL3g4Ni9rZXJuZWwvYXBpYy94MmFwaWNfcGh5cy5jwqDC
oMKgIHzCoMKgwqAgNiAKPiDCoGIvYXJjaC94ODYva2VybmVsL2FwaWMveDJhcGljX3V2X3guY8Kg
wqDCoCB8wqDCoCA2MyArLS0tLS0tLQo+IMKgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L01ha2VmaWxl
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqAgMyAKPiDCoGIvYXJjaC94ODYva2VybmVsL2NwdS9h
bWQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTQ2IC0tLS0tLS0tLS0tLS0tLS0tLS0K
PiDCoGIvYXJjaC94ODYva2VybmVsL2NwdS9jYWNoZWluZm8uY8KgwqDCoMKgwqDCoCB8wqDCoMKg
IDYgCj4gwqBiL2FyY2gveDg2L2tlcm5lbC9jcHUvY2VudGF1ci5jwqDCoMKgwqDCoMKgwqDCoCB8
wqDCoMKgIDQgCj4gwqBiL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmPCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgwqAgOTEgKy0tLS0tLS0tLS0tCj4gwqBiL2FyY2gveDg2L2tlcm5lbC9jcHUvY3B1
LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMTMgLQo+IMKgYi9hcmNoL3g4Ni9rZXJu
ZWwvY3B1L2RlYnVnZnMuY8KgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNDAgKysrKysKPiDCoGIvYXJj
aC94ODYva2VybmVsL2NwdS9oeWdvbi5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEyOSAtLS0t
LS0tLS0tLS0tLS0tLQo+IMKgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2ludGVsLmPCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqDCoCAyNSAtLS0KPiDCoGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvYW1k
LmPCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqAgNCAKPiDCoGIvYXJjaC94ODYva2VybmVsL2NwdS9t
Y2UvaW5qZWN0LmPCoMKgwqDCoMKgIHzCoMKgwqAgNyAKPiDCoGIvYXJjaC94ODYva2VybmVsL2Nw
dS90b3BvbG9neS5owqDCoMKgwqDCoMKgwqAgfMKgwqAgNTYgKysrKysrKwo+IMKgYi9hcmNoL3g4
Ni9rZXJuZWwvY3B1L3RvcG9sb2d5X2FtZC5jwqDCoMKgIHzCoCAxODIKPiArKysrKysrKysrKysr
KysrKysrKysrKysKPiDCoGIvYXJjaC94ODYva2VybmVsL2NwdS90b3BvbG9neV9jb21tb24uYyB8
wqAgMjQxCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiDCoGIvYXJjaC94ODYv
a2VybmVsL2NwdS90b3BvbG9neV9leHQuY8KgwqDCoCB8wqAgMTMwICsrKysrKysrKysrKysrKysr
Cj4gwqBiL2FyY2gveDg2L2tlcm5lbC9jcHUvemhhb3hpbi5jwqDCoMKgwqDCoMKgwqDCoCB8wqDC
oMKgIDQgCj4gwqBiL2FyY2gveDg2L2tlcm5lbC9zbXBib290LmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgwqAgMTIgKwo+IMKgYi9hcmNoL3g4Ni9rZXJuZWwvdnNtcF82NC5jwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEzIC0KPiDCoGIvYXJjaC94ODYvbW0vYW1kdG9wb2xvZ3ku
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAzNSArKy0tCj4gwqBiL2FyY2gveDg2L3hl
bi9hcGljLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoCA2IAo+
IMKgYi9hcmNoL3g4Ni94ZW4vc21wX3B2LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqDCoMKgIDMgCj4gwqBiL2RyaXZlcnMvZWRhYy9hbWQ2NF9lZGFjLmPCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgwqDCoCA0IAo+IMKgYi9kcml2ZXJzL2VkYWMvbWNlX2FtZC5jwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqAgNCAKPiDCoDM5IGZpbGVzIGNoYW5nZWQs
IDc5MiBpbnNlcnRpb25zKCspLCA3MjAgZGVsZXRpb25zKC0pCj4gCj4gCgo=

