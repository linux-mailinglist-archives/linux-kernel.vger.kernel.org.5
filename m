Return-Path: <linux-kernel+bounces-39689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2B683D503
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4525C1C227EC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06F024A03;
	Fri, 26 Jan 2024 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fnA/H0O2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5BF67C47
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706252832; cv=fail; b=mvYeSPv+3PgiGOO/qvIDLQnCQOBjSSZBEmLm5HhQSrYHvOviKh+gIvN8cQ7jGa3Bslf91g+RhF0GK1ilTcUJbgPUDSe3dd4hJBvt1N9hwbh9dUWjqWcMxXBLCoaRrFsJlNGzYZ3td5R6MY2Le8T83c23R/spejtiQnOd1AfFp28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706252832; c=relaxed/simple;
	bh=HBAnPNtBlSIS5QNFppbLa12KLSahWquMpPT6E79X2yk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pAR3E8CXcexDbaDDutoIhZecBVBrs99ycM32nEnTEviB6y/xq2ODa9GiumURDj7oIWJp+VW2tFWFNe4lg67FA5fSgSTz/ECBAu/7S8MuZlAxJ6rBtZ/N4zPkbAG+KDL+R5fOxY5X9Q7Lqh7dCP6ut/qJUJ/EKHSTgwh4ZK7Ow88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fnA/H0O2; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706252831; x=1737788831;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HBAnPNtBlSIS5QNFppbLa12KLSahWquMpPT6E79X2yk=;
  b=fnA/H0O2Dplna6AWHaF3UnrM5qJniaOSnNdnTbqnf04v7zWcmMH5hbbb
   Vvmuuhp/OGYabbhfI2VAT+S60Ekvt6+gFyC9k2a9zQTCeMW3UAtr4u4x3
   noyo4EKkr1Z+zbM168VNUDJ6U9L7ZKYSkacqlF3YLP9jdDgycKVN1vttJ
   Nou2wrko/osxsBKxpPlmogIjG18SQDqRsm+zjhk4Fj0/FNgzvGeVsQMqo
   dytMKdRJYPc7fzMMzhccjr0RdPIREV63A6a8hdTO+VR+CyTy9NNcxovdf
   AI5xqtSLvIg7k9mI5ctliyM8a3So99KirUTI0WdeJJi0Q5aPGth1r5ly6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9159392"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9159392"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 23:07:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2594462"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2024 23:07:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 23:07:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 23:07:08 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 23:07:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDY7MQksn7YF2I0PaxwVJucy2vtlHBKjYFN4VBpgoAudgt2T0LIwe5bdqCJGmCIP07bI6JquV5ORZeHdwFk4IZ0gldD4Z5ZEUIlT7WmVP7n3SWxC6eBBsgygg3F0BFzZkkD6OW/Fcun0XbAJqjYzTd6pZUxGNLCxuec39b82i3r5tkyd9UZ052Mwk5R+IxYfsJE+Nq2FcjqeEDcP7GcV1GgTQaZ1xNiAK40vSJILvsA2wt8SeCQcy3nVwJsXXKiHkEPIoX29vVDUBs3eKyw5tjzwJaliY//WNCrmGL99enhkgaENfMArXCyZ1DnGj9Tg/z/GvpJAztADC2Cf/XPMTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBAnPNtBlSIS5QNFppbLa12KLSahWquMpPT6E79X2yk=;
 b=jdc0w+s1n7ScB8YXd9iNwsBsrcLdUyDLDbOHleASoA/sNDCqiT9iIAlT87yul97D10jlqi8T7lDpkWL1+r8q2cq7x7Ahvv0tB5DWmTkpKOUZIqARus7pfXk0woK+ivEOgFrM/5GhMundvH2aMqKMtvBGM2jrDmG0yi04rpXcjHoMPrp9kINy6VvLF6JtLdgj0pdTHIBaWztwj+Atx7X8ILvvhPZehglvaUDd1h5S++aRCQgl7VKD2u9eh91lRftqZk0PEgzeykXiaPulSDVa/S1hexgypElXLyXQ7mgupeJfaqUvsrz64BP2A05ol4MZ3ForU+SehIAnedJBcpWq+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DM6PR11MB4706.namprd11.prod.outlook.com (2603:10b6:5:2a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Fri, 26 Jan
 2024 07:07:06 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102%4]) with mapi id 15.20.7202.034; Fri, 26 Jan 2024
 07:07:06 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Raj, Ashok" <ashok.raj@intel.com>, "mhklinux@outlook.com"
	<mhklinux@outlook.com>, "arjan@linux.intel.com" <arjan@linux.intel.com>,
	"ray.huang@amd.com" <ray.huang@amd.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
	"Tang, Feng" <feng.tang@intel.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"jgross@suse.com" <jgross@suse.com>, "andy@infradead.org"
	<andy@infradead.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [patch v2 21/30] x86/cpu/topology: Use topology bitmaps for
 sizing
Thread-Topic: [patch v2 21/30] x86/cpu/topology: Use topology bitmaps for
 sizing
Thread-Index: AQHaTf2yZ5H2x7vY+kOhDG9u7FOoNLDrqfiA
Date: Fri, 26 Jan 2024 07:07:06 +0000
Message-ID: <7c8874d971c69fb4c22c1b771983f8d5109a9387.camel@intel.com>
References: <20240118123127.055361964@linutronix.de>
	 <20240118123649.739960607@linutronix.de>
In-Reply-To: <20240118123649.739960607@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DM6PR11MB4706:EE_
x-ms-office365-filtering-correlation-id: 3c18239f-e6ba-4ed6-28c1-08dc1e3d67bd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: if3AVt08nAsvN4EEzzenvKCCzpPyzmo17V9wfUNZ2p3aluwwIItRofT5NgWn9sclY0UTh6OR7g4cOd4wfJo4c9cLh010Iz2/3Zh86D93FyR7VJdvxWca+NWm/tboE3rtFjSi/nkfix5w7XVvOier40gs9ssKqSe2Bhz+E8xhPHrjBfSsXFQRx/qh13kCZL9i3nIoj22gY2NHCI99VuxTm/QkiHQlDrtsJYUBGw5oK30383ZZi+3D/Lvd3GRZX782/c62+hoB/SO4vIoGoTE6Fihy8W3ZIm9X90WSQegPj3QwzUUm/wSu16m72vVHYMUgj8FFJ7t1n+JBtyQrYaumjK5gJNi1mgPOz2IG5NhELKfCWvmUBnwd1F+qcftoN1KPDKkXmM4Oq/SKrCVU4v9vDeWw8V/fPuB7QoT1tshmDR2NT1hv+8PKmqQC/zxlIXRrZt2qZ9RwMlS4FS71o4Yra7Sq97Y+eE6ESwF7C2pGgBLGeDQ2Ek4Rb5rlDrRmpuMIu5YkmWbWhBZC39OzMNB4G7TEgus68l5W2GB30lZw69L3jQlqhrDf80AeDUwKCwmsNAp0S830VV0DASrqcwAAMYaGOnHsKLoEfYifGGTvPeIeE7aLWg2BuwXBqSpsyGJ1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(6512007)(2616005)(26005)(38100700002)(122000001)(5660300002)(4326008)(8676002)(8936002)(7416002)(2906002)(478600001)(6486002)(6506007)(71200400001)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(91956017)(41300700001)(110136005)(38070700009)(82960400001)(86362001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnpDNDh3dG4rMlFOK2xSOVpqMU4zNDNaNEdjWENqWXhua2hKR2duaEhFM2NV?=
 =?utf-8?B?RmpLU2UxaHNHNTFtN0ZKcWh1SGJuZzJ6aHJnd3NhT0pwMmt3UTI4TUlXSThE?=
 =?utf-8?B?ZlM5VE5GbFRBbWtRUUEzMy8wbnZuSitvb2JZc0dqTUpOTmtad3U0Uk45V1hG?=
 =?utf-8?B?R1JHZW4wNnRIQXNOd2VpNEhYQ2dFTGdKTENTMnJJbEdpbFlhdjRGNlVGbVdn?=
 =?utf-8?B?eGN0YzJOSGtsMlg3ZWx5U2Z6VTEvZkFQY0xqTmpGRDZjZ0RqVERxTlRqZFk0?=
 =?utf-8?B?eXhhN0tzOEFyMjdxbUlyVHhhV0g4UGJBZHVNbFh4ZkVRMk8yaVY4QjR5OEJH?=
 =?utf-8?B?YTU4c2t4UDFBRTZzRXhHd0tVb3dJa0luWmZUd3dNZ0FaTStUdnhkb0x1UzJh?=
 =?utf-8?B?VGdsU0Z2WlJVMWlJYjUxdXhhYTcxQUdXbFZhbURQWVFsV3ZwOU5SRzB0c2dh?=
 =?utf-8?B?N0h3WXl2RlNmZFo0bC9zM3htT2M4V1d1QzdIbTdSa1l4bFJiWmprOFN5a2Nu?=
 =?utf-8?B?d1NtaDF3SE1BK3ZLa0Q2S3Zhdy9IYnpLZVQvcGVtbmV6N0pTTUVIRVRzY3FK?=
 =?utf-8?B?M3JQMzgwRnBrWmFJUURZS1JEOFk1UGV0ZmlmWUxmUlk4NXo3aGk0Ry82Rzhk?=
 =?utf-8?B?cUlhblg5TmxDWFovMTl2K05kYTNYbFhzRVBraHRUUk82a0Z4YWZYekNWUXRI?=
 =?utf-8?B?Qkw4a2x3b1QyZG40cnRRSHloWjZhRDV4OUQ1VzJ3Yk13cEN2YkZ5K0h0N3ow?=
 =?utf-8?B?Vkw4cTQ4aytVQXMzWE1TUGtjRnVhSWZxbTN4Q2FyT0RuTDVobTI3V2xmLzVZ?=
 =?utf-8?B?cnZ6L21EZ3ZidjUyaENWQ3U2dUVUYlFnRDI2eXFjVWJkUzZJWE5VV2p3NVJE?=
 =?utf-8?B?dWQ3NWVMYzVJUktFV3M4MFFLaG5MQ2FUSXFUUW0zUitZTUlFdlN5MkxWOUdN?=
 =?utf-8?B?V2VGYnN0cFh3UHZtMTZ2MHRjeklMOUtOUTFvSUhQVithbE1laVVPMzdPclZx?=
 =?utf-8?B?ZnlMTDVXczRFS1VSOXJ0b1FxVExVdTM5YjZ1b2taZ2MyNzUzZFgzT3JPL0Zm?=
 =?utf-8?B?Z0hNc0ZZa04zTWZOeWJ0eGtYNzBnNm84Yzk5TGQrNkpIdTZ2MGIzaW5iZVV6?=
 =?utf-8?B?VXFWVjdyem44d0YyTW5rdEhPVi9RZU0zYzcyM1lvZ2pISTg4MEdmVHprSDQ4?=
 =?utf-8?B?L0JlSTRaSm5ybFpqN3RnaTE0aHo3bW9ycTd6aGJUTE1hZjIyYzhwU1JkalNX?=
 =?utf-8?B?bzJtRit1ZFpZVXZMYTJDY3JvRGNoYTVTR1hNdEdrL0g3MUQyOXIzOXdYakZM?=
 =?utf-8?B?aGxpdXZYdFVoOU9aSHVPWGQvRjNmMEgvMGJKeE9UVDk5RnVJVmdWTzRpNThR?=
 =?utf-8?B?S294U2lHanNsaVBLR2dISVpIYWtFRDFvL2dBTlJtcjJKVWxtMGtmRVZjNDJt?=
 =?utf-8?B?RVZnYUFibjdxRlpaZjBRVTg5MmVjY3dpY2R1U3FSem55L05iL1IxVjAzdjdO?=
 =?utf-8?B?Y20wNEJLUWlycE1FcWloK1B6T3FFUCtMUlVob0hUZVlKV3NTckF4OGVOOTB3?=
 =?utf-8?B?YjBnY2tVWWxXSVVob0dySGZPcnVEQ1JiR3Z1QmlmU3M5UENaMGEyM21LOTBZ?=
 =?utf-8?B?TWxTci9neW52c3BpbUI5dWh1M1RZbWtwbVQwMHF6YmhESVpZVnpiS0VFeEV3?=
 =?utf-8?B?WEdNSDQzejIyWEx1NnNGQ1lXRGV6R0VoS2tXeXNJQS9yNENTbmJFRnR5VUtv?=
 =?utf-8?B?c0JmSElHbDdQRTJCakNmSUc0TlFzaTR4MVU3OG5uaU1iSlppTWQvNlVlajJv?=
 =?utf-8?B?M1FkVE5jWEZkYTJsZUduT3ExVmNNOVRDZzkveHB0di9mbDhHYUNuQU5jOGNK?=
 =?utf-8?B?ODVOdFM5T2JSRFlnQWhpV0FuYnRNeG9mMXovVUJEN01sYk01Z0JTYkU3cHNZ?=
 =?utf-8?B?SW9LQkFpMmcwbTR1dk91SUk2cjI4QUJWVnNPMGZMaHdNaGluVGMzTUc3RmM0?=
 =?utf-8?B?WTMvZW43aHF1NmxzSmtBUkY1dk55OE5FMXRNSElqMXB5dVlsRGNqeDMzcTdy?=
 =?utf-8?B?Rm1hdW1mZTc2M2w5RHgxS2VzKzhBKzkzeU1UUW1kb3E0Rm1sQWY1eGFUUUtx?=
 =?utf-8?B?V1hFTXpjaXFUMS9ScVJoQko3elZLL2dDb3BTUVR1V2gxWFJBT0tFNWdIYjlM?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEA8CE377326E74EB76A6E499AAC001D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c18239f-e6ba-4ed6-28c1-08dc1e3d67bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 07:07:06.1731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IGcpGDkkEMLEbraFt/OPN9IL6H9AXlEzkrzHPUCe3VPde9pM0byzFqE33Zi4h4oACsDTGzIUgsgZrjqBzjWH4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4706
X-OriginatorOrg: intel.com

DQo+ID4gwqANCj4gPiArwqDCoMKgwqDCoMKgwqBjbnRhID0gZG9tYWluX3dlaWdodChUT1BPX1BL
R19ET01BSU4pOw0KPiA+ICvCoMKgwqDCoMKgwqDCoGNudGIgPSBkb21haW5fd2VpZ2h0KFRPUE9f
RElFX0RPTUFJTik7DQo+ID4gK8KgwqDCoMKgwqDCoMKgX19tYXhfbG9naWNhbF9wYWNrYWdlcyA9
IGNudGE7DQo+ID4gK8KgwqDCoMKgwqDCoMKgX19tYXhfZGllc19wZXJfcGFja2FnZSA9IDFVIDw8
IChnZXRfY291bnRfb3JkZXIoY250YikgLSA+DQo+ID4gZ2V0X2NvdW50X29yZGVyKGNudGEpKTsN
Cj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoMKgcHJfaW5mbygiTWF4LiBsb2dpY2FsIHBhY2thZ2Vz
OiAlM3VcbiIsIGNudGEpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHByX2luZm8oIk1heC4gbG9naWNh
bCBkaWVzOsKgwqDCoMKgICUzdVxuIiwgY250Yik7DQo+ID4gK8KgwqDCoMKgwqDCoMKgcHJfaW5m
bygiTWF4LiBkaWVzIHBlciBwYWNrYWdlOiAlM3VcbiIsID4NCj4gPiBfX21heF9kaWVzX3Blcl9w
YWNrYWdlKTsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoMKgY250YSA9IGRvbWFpbl93ZWlnaHQo
VE9QT19DT1JFX0RPTUFJTik7DQo+ID4gK8KgwqDCoMKgwqDCoMKgY250YiA9IGRvbWFpbl93ZWln
aHQoVE9QT19TTVRfRE9NQUlOKTsNCj4gPiArwqDCoMKgwqDCoMKgwqBzbXBfbnVtX3NpYmxpbmdz
ID0gMVUgPDwgKGdldF9jb3VudF9vcmRlcihjbnRiKSAtID4NCj4gPiBnZXRfY291bnRfb3JkZXIo
Y250YSkpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHByX2luZm8oIk1heC4gdGhyZWFkcyBwZXIgY29y
ZTogJTN1XG4iLCBzbXBfbnVtX3NpYmxpbmdzKTsNCj4gPiArDQoNCkkgbWlzc2VkIHRoaXMgYnV0
IEFzaG9rIGNhdGNoZXMgaXQuDQoNClNheSwgb24gbXkgQWRsZXJsYWtlIHBsYXRmb3JtLCB3aGlj
aCBoYXMgNCBQY29yZXMgd2l0aCBIVCArIDggRWNvcmVzLA0KY250YSBpcyAxMiwgY250YiBpcyAx
NiwgYW5kIHNtcF9udW1fc2libGluZ3MgaXMgc2V0IHRvIDEgZXJyb25lb3VzbHkuDQoNCkkgdGhp
bmsgd2Ugc2hvdWxkIHVzZQ0KCXNtcF9udW1fc2libGluZ3MgPSBESVZfUk9VTkRfVVAoY250Yiwg
Y250YSk7DQpoZXJlLg0KT3IgZXZlbiBjaGVjayBlYWNoIGNvcmUgdG8gZ2V0IHRoZSBtYXhpbXVt
IHZhbHVlIChpbiBjYXNlIHRoZXJlIGFyZQ0KbW9yZSB0aGFuIDIgc2libGluZ3MgaW4gYSBjb3Jl
IHNvbWUgZGF5KS4NCg0KdGhhbmtzLA0KcnVpDQoNCg0K

