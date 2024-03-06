Return-Path: <linux-kernel+bounces-94632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E049787426C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634D91F2488C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067651B968;
	Wed,  6 Mar 2024 22:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XfVMN83H"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682131B813;
	Wed,  6 Mar 2024 22:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762870; cv=fail; b=d8EAewLG+4FmlP0tg6IKSiYMaTpun1YYNPvRPOaXXwUm2U5yOzeCNn8EmcuIVFUVCwYRH7HH/dGtRs/LzbEhmWGtoWP0ayJqJm5NWId8EPVKwsO5NX5HhCVcMyH8IJ5+zyivUMtPVniIvZUmXoNuAYey/JUAwe78WYyYElBBCug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762870; c=relaxed/simple;
	bh=RfG60XNhBU130efMKqjI24wYEuViLaxwrTSNvETUaC0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KdcIDI84D5JFE+rpN7UW8gywt2bmxKk24iPUZkPjNvHiaUOoNAmDHDKKTf02aSWLgcpmpKdftmVieP7ijAc5EtJqTtzSOGj2LJf4h8fc2/8jF8XXRPP75ORqmm5MkpG2bWWVKxRl8QYs6Va7nB6RI+ieSgwpHj3haeCsUPtF3nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XfVMN83H; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709762868; x=1741298868;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RfG60XNhBU130efMKqjI24wYEuViLaxwrTSNvETUaC0=;
  b=XfVMN83HoUqUaTaWFTANFfYmAV6AUqoQ6Oht3S/DKQnn9eijXey5cUgv
   CFEK2ewk8TYShlMG4WkQ1z5dIlR6bSFNuywZLw7zzWP4ap6e1mT0KQp6u
   Fh4/ucaElfnOKPY2gnWh9ZHJwXjsXOoA/hkAxBfNGZVwDc/jUaeDB4QkG
   uRx8zu6HYTjHkWoEmekILriekH2sofGbELrp5dKuOuC9cSe2bL8XYkHMS
   cH/Got+KuIxTzRlyVIXhHxC+gwzm2oMukdWDvoLj9pYCW7iMZ1b7BMdIz
   8SKWoyGQ1Gvb3cdrC7HhjEnIa/+u39LKc5dmtaXf+eXUTN5Phmp5gqwBh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4529651"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="4529651"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 14:07:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="14458983"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2024 14:07:47 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 14:07:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 14:07:46 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 14:07:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWuZRMRNf2gF3jTWeOLkPQK2svY+820KJ+6muqIK7xtohvoAMAIsJLm6MAJmT5FoEByESk9XQMkF2sJvGj7LdgLEA5gv3PnZn/oIlcI4tJV2/0YfIxV8jdfZoblNjMjtPA7mdEPzs9kPxVq/hDNypO+xKnFaPKUQu2xg+dk9J3P2iSe63hZ1XnzvsG6ewux0gtGQSi/MMXunlUFVNLngGjwFRbin6wBK4PbYXEGtaWsmhL298zK8Maa7dNZkU31a4b2xFr6aaGnncy21HdrYRzTyPMnwshGDCNP3JCFiuLhZ4GMuN8AjdxjEHUxVqaYQXBUMRc/O9s1GRkCaI0r5dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfG60XNhBU130efMKqjI24wYEuViLaxwrTSNvETUaC0=;
 b=mBnRQbeHq5JGb2bVho3tcPUm6FzMQuPY5pZw81HxqCRvmoG5whgBG1DoWS60+NeOm6B51B3iOD2ywWV1/+YChA6UfTQ4l1pL40cFOM8a4uZJMQXDlaNJTHZrHSwNCW8mzmTAEmrL6FVVmUsxYzNsCElg+CI8LrQrgxcyR4c94x9udZP/DQYabowMFCp3LD94aVbB0HPvR3rBnfv0R/dKxcNBUWLHiIVrCCNbVmkv9P7eWhX1DE21fG2sKowjUjvSwjTD90aRb+8eb5TsclPgLXKF+MwDd3YPwAASKEBo1iIbVOVtRixp+i/flJnR6AMs6dHzIyHHlEj5cOoLLFCjow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY5PR11MB6091.namprd11.prod.outlook.com (2603:10b6:930:2d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 22:07:38 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 22:07:38 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Naik, Avadhut" <avadnaik@amd.com>, Borislav Petkov <bp@alien8.de>
CC: "Mehta, Sohil" <sohil.mehta@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>, Avadhut Naik
	<avadhut.naik@amd.com>
Subject: RE: [PATCH] x86/mce: Dynamically size space for machine check records
Thread-Topic: [PATCH] x86/mce: Dynamically size space for machine check
 records
Thread-Index: AQHacBCiokG4Q/wvJUuCviNw2Hg5g7ErQn/A
Date: Wed, 6 Mar 2024 22:07:38 +0000
Message-ID: <SJ1PR11MB6083F8541423267B852C510CFC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240212093246.GBZcnlvkPKDC8C7rv5@fat_crate.local>
 <SJ1PR11MB6083B3511D18787BE823AB2CFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212175408.GIZcpbQHVjEtwRKLS-@fat_crate.local>
 <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212191401.GLZcpt-XHFqPg3cDw-@fat_crate.local>
 <SJ1PR11MB6083C60D7584B02E9CAF19D5FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZcqPhVO_DtD2x5N7@agluck-desk3>
 <20240212220833.GQZcqW4WxKH34i-oBR@fat_crate.local>
 <20240212221913.GRZcqZYRd6EPTTnN97@fat_crate.local>
 <20240212224220.GSZcqezMhPojxvIcvO@fat_crate.local>
 <Zd--PJp-NbXGrb39@agluck-desk3>
 <e6675835-46ca-4183-86ce-008fde928e73@amd.com>
In-Reply-To: <e6675835-46ca-4183-86ce-008fde928e73@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY5PR11MB6091:EE_
x-ms-office365-filtering-correlation-id: 4950d0fc-aa78-41b8-9c54-08dc3e29d5d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BzuK9CtbDj5ytDQrjQSAyd3Eud5sOfK125GJfVhX91bfrT0pi4+Q8JQLMzDDi3bUts8x2mYkFeng0TCv6kKZJFZhpyx//XFEMnh5WRJUTcv3sHRY3BUfAcZ2Ymtb6QZd2hmXt/6YEaPXGN4y7tX9nt550E5t520MgzDgW4a1OKapKQwacr6VDhXev+lXA0W3VS6Ve77u4ZKZoj84q4a8VvcamoyigJWvGAFhPyv1QvOBqcO5Fm0GvwisaCCjwGRkrF3XZ3Du5ZBNEmdNrAeDi90FCrHav0u2pu6xbspCbZHd0LVAAhc10qlYcqoRbod/cA1f7oARCxOCxUsPBrZCXqAAz5MH66VQ4yBRMlp1sU4mXFQMg63rjOT/tpmgtfFZlBmLubTh7C36A3zmUjABx+tgA31PZ7NHiR1CV4J7nvwIGJ40w7i7baSkwafqk4BdqQgoKvU0x2samOTlx3wenBf/HAqSQU6lCNCYjFuwc2FBOyTtvoZ7ZNpIvD6g5zpSaiyvjwyOzdDhMzzfcO4nON0yRkgAoA8W04Zvydiq1Z8LNNJdLlsXkrFwHHMKHsipHv5t8WfByXl1ysP3vFu85bdUjS1BR+CsklrrKNST8iED3Cu/Gudc4BM26lpwM/0E12xMMPlmV9Lhe1UDFMwblfyFiTXvlLY9QGlA7gv6ykWnaSos8ZoFq6AduNPebOeeGQxM1UQugW5uUuNrfqqu5RVzRKccCR/Sigb+fvoXLU4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cm5PMDNVMGZ4OTNJVUN6UnhseGtza2QvS2JQelBFRHdNcUxsUGVNcU41d1c0?=
 =?utf-8?B?TlJNYTZwc3FEaFF5bFhxblVybUJYYTJKTnRCdStoVStTcnNaVENOMFZOZnRU?=
 =?utf-8?B?WEdBOUhSV1VkV3A3T2ZwN1QzOC9yL2c4Vm1hcCttS2JwbVlTMW55ZWF6aDN3?=
 =?utf-8?B?OUZKbW9wNGZFMXdqdE5iRFdXcHp3R2xnMzFuY3NZKy9BbWZIWElaNjN3QjZJ?=
 =?utf-8?B?RDh2bmhISlp3UjVzeFdXWXRmWnIwS0FZWmVpM1BFQ2x4U200c0l2NS9WRjdt?=
 =?utf-8?B?a3gvTlpTSnAvL0VTSTcyWW1WdUhXSzBiaWs1bFFObVNPUFZUaUljdnAvbFZL?=
 =?utf-8?B?MlpBa2dwd3JTMmQ4MXJtRkNON2RhS0llR1o5WVFSa2FkVlZOT3c5bVArMmtl?=
 =?utf-8?B?TDR5bVBxdXFnU0o2M3JuZmlaRUN2QWw3cXlMTUcvQmNpUEtnSDZDbXhYb0RT?=
 =?utf-8?B?eDRzcTN1dHpPendwYVlJMS9Mb1k0Wk8rWnJJb0FBU1pzT3VHYXIwZEcvZmJx?=
 =?utf-8?B?OW5ORGd1Vkx3eWlaVk84R0p1cWJNSHZkTEV0M05mZHVkbTF4aUYvVlVaZy8x?=
 =?utf-8?B?WDdzL1E5dXYrc2F2UTVYQmY5RzlDK3BWVEcwVlhZcW9HaFdWVUVjdU5TY0RK?=
 =?utf-8?B?b0NKRzZXcFRHMEI5VG96WHBQVjRHcXNyZFBwYW10WVp2K0RIQkRIUUhjL21G?=
 =?utf-8?B?TXNOUGp2WG1wZVhvdVlzQk5NRVNrOGpoY1ZsY1JGK3J4YlY5MFdJMGk5UmVo?=
 =?utf-8?B?bkJhRjZhZG5mLzd5Qk1YMmp1akNoaSt3emtRMjRVeGorYlFwK2xMeGQ4eFNs?=
 =?utf-8?B?cGMwOUxDNURORS9TcHNZY1I3eFNGS0ZCOHBzaXpObkpTczFBZWE1cnRSVTJ0?=
 =?utf-8?B?ZlRWbEZQTmJHSE1HNUVzK3lDRmR1ZzNpd0tBb0REY0FNMXJvdjZFTm5Kd09Y?=
 =?utf-8?B?TXhZbWZrWlJkSlE3d2t2T25vUG1sQWJxRUkzZjlZRDViUElEZ2VHYk5ZNUFw?=
 =?utf-8?B?eXp2ejMyNlM5Sk11UkVYdHFDaDBDR1VrcnI1TlZyR3grcjRybVROaHEvdmd3?=
 =?utf-8?B?MlBNak15QzRJay8remNUR3pZaWVUenZPQ1B1ajVGcVBuc2k0VHBnRGNENXlE?=
 =?utf-8?B?OFZWMFpmNUJXbXA4dGRKVEF0KzY4bWhYY1dRRExycWxRWmp4MzdFWTR1N2lo?=
 =?utf-8?B?blNuY2lOc2FTdU1NdTNTQnV4OWY2UFFTU01oSzR3emZ4VWhrcmpBYkZjbjhS?=
 =?utf-8?B?cWRpSkMzRXJDbzNvN3NkZ2F4STRNNGh1OGVmTkxaZ05USE9NVTdpSC8rK3Ux?=
 =?utf-8?B?WW8za1ovbGhhZmh5UzUxY3dNZzNpazVJWEFXWlRZaFRMd0I3cGZLMW4wNmFw?=
 =?utf-8?B?SVVTNkY0K28zSzJmdmYzQkhFK0V0Yml4THVzdGxIOUlhbS9XdjBnTTBUdFdT?=
 =?utf-8?B?Tk1uZHFhbnRlblljWTFZb2xDcG5nVm83UzZjU2UrMG5QekFnWXY2MkFxaUE3?=
 =?utf-8?B?UkV0eUlKelc2MWFpVkxySkljT2VydXc1OGIwTTUrTXlkTlZuTXQvQ1R4OXI0?=
 =?utf-8?B?aWdEcGw4Z3hEd1NVMDFZOEQ3Y0ZsMHNUSEhiRk5SVDhzeE4wamFLVVZadDdM?=
 =?utf-8?B?S0YzUy9UTzRPY255bFJLWjBGNURVM0l0S2laY0xsempHN1N1bml1djZHRVFo?=
 =?utf-8?B?VmZqbE52TFM2V01FOHROb1AwY21GTU5TTm05bHNUZnk2OVhzQ1JWbmFwMTdZ?=
 =?utf-8?B?bWVTYVY3bVRCdGJaYUE3L05vTERlNEpSbC9YUTJDSXZ4bHNncnVwT3BjNkM4?=
 =?utf-8?B?YXFYT0p2ZWtjZDJWY1pXSWl3b1cwVkdia3NmelFaTlA3emRuSlNQZFhoQkV5?=
 =?utf-8?B?b2VnRWlpV2dVQ2lSaXBqT1JybHJRZzRjYS9iQ1V6aGkxNEU0R2VTeVJGUUVR?=
 =?utf-8?B?ZE9VNHNWODZ1b25ZSFZ2K3Z0b2c2RWNpQmprTWR6OWNBVXFQVDBDMFJyeUNE?=
 =?utf-8?B?aGxCeFJ1c0hmL3g2Y2lNNlNQYlFkMU0yMWZhOW10NDZGcHRTOFV2UWY0MU1l?=
 =?utf-8?B?Z0REV2lwdG1IekphOVUyMlVicEJmUWhlVzVUeDJYc3NEbjVvK3dwVDBDOGR6?=
 =?utf-8?Q?ETJ9eGlAgc4V2O8/oO2DpLQ3v?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4950d0fc-aa78-41b8-9c54-08dc3e29d5d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 22:07:38.1787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rxDh4bSJjcUFzfF2Fd+542l1n+OxEhD3/MFirTVk7xI0ZOEMRAp3RqCb2fO2m3+wJw7B6Yg+cFIW+2zqJcqztw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6091
X-OriginatorOrg: intel.com

PiA+ICsgICBtY2VfbnVtcmVjb3JkcyA9IG1heCg4MCwgbnVtX3Bvc3NpYmxlX2NwdXMoKSAqIDQp
Ow0KPg0KPiBQZXIgQm9yaXMncyBiZWxvdyBzdWdnZXN0aW9uLCBzaG91bGRuJ3QgdGhpcyBiZToN
Cj4gICAgICAgbWNlX251bXJlY29yZHMgPSBtYXgoODAsIG51bV9wb3NzaWJsZV9jcHVzKCkgKiAx
Nik7DQo+DQo+ID4+ICAgIG1pbig0KlBBR0VfU0laRSwgbnVtX3Bvc3NpYmxlX2NwdXMoKSAqIFBB
R0VfU0laRSk7DQo+ID4NCj4gPiBtYXgoKSBvZmMuDQo+ID4NCj4gPj4gVGhlcmUncyBhIHNhbmUg
bWluaW11bSBhbmQgb25lIHBhZ2UgcHJvIGxvZ2ljYWwgQ1BVIHNob3VsZCBiZSBmaW5lIG9uDQo+
ID4+IHByZXR0eSBtdWNoIGV2ZXJ5IGNvbmZpZ3VyYXRpb24uLi4NCj4NCj4gNCBNQ0UgcmVjb3Jk
cyBwZXIgQ1BVIGVxdWF0ZXMgdG8gMTAyNCBieXRlcywgY29uc2lkZXJpbmcgdGhlIGdlbnBvb2wg
aW50cmluc2ljDQo+IGJlaGF2aW9yIHlvdSBleHBsYWluZWQgaW4gdGhlIG90aGVyIHN1YnRocmVh
ZC4NCg0KUGlja2luZyBhIGdvb2QgbnVtYmVyIG9mIHJlY29yZHMtcGVyLWNvcmUgbWF5IGJlIG1v
cmUgYXJ0IHRoYW4gc2NpZW5jZS4gQm9yaXMNCmlzIHJpZ2h0IHRoYXQgYSBwYWdlIHBlciBDUFUg
c2hvdWxkbid0IGNhdXNlIGFueSBzaWduaWZpY2FudCBpc3N1ZSB0byBzeXN0ZW1zIHdpdGgNCm1h
bnkgQ1BVcywgYmVjYXVzZSB0aGV5IHNob3VsZCBoYXZlIGNvcGlvdXMgYW1vdW50cyBvZiBtZW1v
cnkgdG8gbWFrZSBhDQpiYWxhbmNlZCBjb25maWd1cmF0aW9uLiBCdXQgMTYgcmVjb3JkcyBwZXIg
Q1BVIGZlZWxzIHdheSB0b28gaGlnaCB0byBtZS4gVGhlDQp0aGVvcmV0aWNhbCBsaW1pdCBpbiBh
IHNpbmdsZSBzY2FuIG9mIG1hY2hpbmUgY2hlY2sgYmFua3Mgb24gSW50ZWwgaXMgMzIgKHNpbmNl
DQpJbnRlbCBuZXZlciBoYXMgbW9yZSB0aGFuIDMyIGJhbmtzKS4gQnV0IHRob3NlIGJhbmtzIGNv
dmVyIGRpdmVyc2UgaC93IGRldmljZXMNCmFuZCBpdCBzZWVtcyBpbXByb2JhYmxlIHRoYXQgYWxs
LCBvciBldmVuIG1vc3QsIG9mIHRoZW0gd291bGQgbG9nIGVycm9ycyBhdCB0aGUNCnNhbWUgdGlt
ZSwgd2l0aCBhbGwgQ1BVcyBvbiBhbGwgc29ja2V0cyBkb2luZyB0aGUgc2FtZS4NCg0KQWZ0ZXIg
SSBwb3N0ZWQgdGhlIHZlcnNpb24gd2l0aCBudW1fcG9zc2libGVfY3B1cygpICogNCBJIGJlZ2Fu
IHRvIHdvbmRlciB3aGV0aGVyDQoiMiIgd291bGQgYmUgZW5vdWdoLg0KDQo+IEFwYXJ0IGZyb20g
dGhpcywgdGVzdGVkIHRoZSBwYXRjaCBvbiBhIGNvdXBsZSBvZiBBTUQgc3lzdGVtcy4gRGlkbid0
IG9ic2VydmUgYW55DQo+IGlzc3Vlcy4NCg0KVGhhbmtzIHZlcnkgbXVjaCBmb3IgdGVzdGluZy4N
Cg0KLVRvbnkNCg==

