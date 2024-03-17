Return-Path: <linux-kernel+bounces-105381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A13587DD1B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 13:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0492F1F2139E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 12:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2733A1AACA;
	Sun, 17 Mar 2024 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3JG/SJA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F83A175BE
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710676835; cv=fail; b=YfFngERRwtQNVHSCMxTz022tg3VWlPi7HZ1RjfWtzMehfpVVBtY2KzHNUMxj38vkpv1owrwcJFT3d5fD3JnHHv0eHXj9WzFK48S/fmdxyEkojbtBCE3sGbu96BUgQ3PMxLYPdpXoyg41+D7aQyXehoIwhZqWbryBZtkRBu1ANdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710676835; c=relaxed/simple;
	bh=5+QseHOCiMBTzE/B8tPhHYIbRFxpLC5kDyc56lYDaYU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WyZsWtxO+vmISmD/OiU7m5o2OM956vW7jSYNqjTqfSty5EoCRQ0pSpeJXaIcWA0faugHEexKELxxndSXcgmtHpDQqY53ZQFCUfgndTbKnpPbIn0mDoQymnoboqQFNYJdXP6kYfm+B1InANtAMGpK3V44Z/NAvrRGQJnpid96qZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3JG/SJA; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710676832; x=1742212832;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5+QseHOCiMBTzE/B8tPhHYIbRFxpLC5kDyc56lYDaYU=;
  b=W3JG/SJAMj3Mf7Usef1O0m29KYvCQfkECO+ZCD9jeIBIXRR9apouNwA2
   Q94wB/Qj5wWQ44+JtY08lb4zNj5OnWykVlyXy6gGcO+T3eVnfTLLEB2ik
   sKplJBjVz38taISn2MdIT5tfVIamB72y5cNR5ButKJkxWjwpqDpSsNQOz
   JmQxKw2qC/wY7q7OUlM87LrWi5Ziz/apyvgr4r8QJ7qWVnOC1WI5FBP4h
   0CRgo9y4lajKwgwneXVgo06N32mafgl3nS3zZgITaGhSIxNZDRl9cArzE
   iUdmR+yQJ7TGxU6N0oaTXNvXaKqk+fD1v/LEPkCq4hgfmYr0qu6XKMb/b
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11015"; a="16896464"
X-IronPort-AV: E=Sophos;i="6.07,132,1708416000"; 
   d="scan'208";a="16896464"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2024 05:00:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,132,1708416000"; 
   d="scan'208";a="44104206"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Mar 2024 05:00:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Mar 2024 05:00:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Mar 2024 05:00:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 17 Mar 2024 05:00:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 17 Mar 2024 05:00:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsSK7+WHisJsyot3ulxTsiErSvuaREq+PMRKGy8rAXsVy3xK31rk5QJIBFvzz3KC1s+KFPwdqk+dVyWbjU98+C8aoNAxWDOLvw2oLxCEdd5QpLQXGG7hJ38J8ZA4XFAN0e3OO8ResQ+ST8j94WGYImkrbQk2X+O9pwJRSycCIS7JYAy8DQg2oYhVaLMrme52L6L6LJCoQEzEqCnyVrNanv/k6NWRu9aTH7TDmSIRyzXxLmTTrjR9NFR3pdovNDYnm5CI5nzj6wYSxCl6bjGgzH/9U5RDPQYxcSPu1TjlTHu1IFxSVesPNdK02x9JWKz850/g+vdPMhZubp4brvkCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+QseHOCiMBTzE/B8tPhHYIbRFxpLC5kDyc56lYDaYU=;
 b=RCMuZx85iR6CKht71J+hKenon0nB8yQ/HLN3XeoT+VjZ4NRrk2ystz4wlbqQ2/HUaQIHw7PTWLXNGau/c0PnetBU+LLvg8FtVKp5gd1S0lVKgoHQxTJZHvuKnEnK9ZnwJRaxhIEffMITQ2igQgnN5gvd3JtEOffiQ8EB7PGZZMKyBEjU08MZyYOtsIyIVsvBhppx5hEcnp2brdao9+8NL1dJZVfFU0x/Byt0/y7HmSGdVnP53oFgfD7OxiZimaHvR0EdRxvOLV08hMMXK8Rr2FsKbcEK+9EhlF3GFq8uGTj2TI6FlnbtErl0CPCbwC6kG1vtNvfRmir8ppZsTBemRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SA1PR11MB6941.namprd11.prod.outlook.com (2603:10b6:806:2bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.9; Sun, 17 Mar
 2024 12:00:26 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6%4]) with mapi id 15.20.7409.009; Sun, 17 Mar 2024
 12:00:26 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "longman@redhat.com"
	<longman@redhat.com>, "Tang, Feng" <feng.tang@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/tsc: Use topology_max_packages() to get package
 number
Thread-Topic: [PATCH] x86/tsc: Use topology_max_packages() to get package
 number
Thread-Index: AQHads2F9BYWN/vYzEaPiWHm+PzQmbE5FzUAgALAkYA=
Date: Sun, 17 Mar 2024 12:00:26 +0000
Message-ID: <f9da97d86e5599edca74fa859053ba9caf2b4d9c.camel@intel.com>
References: <20240315112606.2248284-1-feng.tang@intel.com>
	 <ce02f1a8-870f-41bc-8650-4bd6103f9637@intel.com>
In-Reply-To: <ce02f1a8-870f-41bc-8650-4bd6103f9637@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SA1PR11MB6941:EE_
x-ms-office365-filtering-correlation-id: 914db6eb-a16d-44c3-4d3c-08dc4679d586
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2NUHJ5vfoEuTn7kym4RHXYruiSO7RtmYYXAj0DPCAFTxG33IHbi+/P0nBWFD34rXYvkMRO/vXtJoG/a52/WJHqDhuXKUJ2IPhuXaGUkHNgMXJcVL/HDDPr/hVzqlETr5SCnGimqVFDsjLj+F6kfrLVdwU5mi9X73VCBXOQPy4u2ZWcvUxfufLQzPXjnHwLju7fUaYGbvHQlUqq9YXrTL33JtP0qTt7E+1cvliLiW1KcB8JSfDgkDTlOiIr/SNBI9uv+TRhVgR7juFX6VQoiTMQJ5/R+xM9/bT2Tfyg2DxIgC8VmSj9D1LGrwDB1QeTWJQGXNb1iYB0VO4ZHS3P+/Y5YtCiX3wBoawNaSQzF2qKtwlw2jPGJrZqcFfMeaRXFNIJKHxbXe91HizcWN6mAmuKLOZ3znXwgGwD4Em1lhM059zxfUdbDKSVJ/xGy34liTlIkPlsZlVnTPb0MKzzR0VUR7whvHzAFWdbmagpSvJCoSCg3kbQe4LYr8QktiT5WtKi8Bzt93ZepNOzOS03zo1M4o7KD5mKqsRZUjBCr0BUY5RUi2f4zuV7t9Ns/YqzBr7BYxh+/ZGf/Oi9A5kb32psgaqiNkZE/uGxZ4706p0yamq68Q9S8wOcxpV1HX0r+W1ayvjtkypr8Du09bsdX9hnCOJ8+cw0GkvY8Ny6O86dk0N8szL0WLJWi/QaxZoygdk+tJYQ4NUFaT0YBAYpLoz5VzceDCnkJtqzpcxxKa2G8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEU5MzAxZktXQjlpMU1ReEloTW5zS3pHMVFTb20vMy9JSkNuSnVtR0FKcTIv?=
 =?utf-8?B?RVVoSVJtbk8yV0dxSDY4U20zNzRMRkVmWVE5WTA5VHpyS0k5V1lkZ3RIL2tJ?=
 =?utf-8?B?c1UyOENXTCtpVG14cmhrdFJ6MFVpcmdWTmMrOUVtUmZQblhaYnhSMnU4bDAr?=
 =?utf-8?B?aTNJcUYxUFJQTkxxR0Z5dGZtQjZ4cDNZWUIwQlJqamdqRWNqZmtHOXVkM29H?=
 =?utf-8?B?K0xucW1oTlgwWDdMY3p1QkNwUVhpTmc3TU96UnlXb3JPa0VKblZhSDhKS2Ny?=
 =?utf-8?B?Z2tINklVSVNKRUN0NnhhUEVvTVFUcXZKOXpzQWtwMGZscTRLMVkrUlB2bVFi?=
 =?utf-8?B?L1pXcW9RbnZhcTZuUVNnSVJGRWJCdDY1UGlHS3hJOXlLb1N2VTR0d0QrU0tv?=
 =?utf-8?B?eE1yZUJ1NUlVNStoV3hCendPWnFCVzNBZWtCM3gxcWovUUcrR0RHZjFFZ1cr?=
 =?utf-8?B?VCtGVFdiU1VmdDlxWk5qTndrRTZnTkdzeVdxKy9iRHFSRWdDM1V5NmtldHNv?=
 =?utf-8?B?UXdZNUNCWThySUozVmZiN3ZqMWkwVnJlZ3RpSGI0K3dLZUhSTGlkL3ZjSkpQ?=
 =?utf-8?B?RHdWZXgyc0c5MVp0U2E3emc4NnFHUFRqaGp4TS8yU1g3RTI1V25QdjdPdUd6?=
 =?utf-8?B?SmU5TkQ2K25wd09qL3oyYW1MMkpGeitneE0zQjRkT1BOTkVFVjNzdThPYndk?=
 =?utf-8?B?dFFQREE5Nnp1RWhGM2lSa0R5aTllZmJTUG8xNlBlRUtERkZreVNMT1JDVG1E?=
 =?utf-8?B?dEQ1aE0wZkUvOVBiSEVFemxCdURFT2dJMHEzRUZrNnlhM0R1TUJ4bXhrY2VK?=
 =?utf-8?B?L0pOS0VPWXJhYmQwS1d5YU9nTkN4NU41TFV1dWVNZ1g4V3pjNVNOVGpVKzRr?=
 =?utf-8?B?YWNLOHVmVm5JdEVUcXp0L1ZLUXVNNmF0OUdJZ1p6b0x4TzFDSkhZenVrb2hv?=
 =?utf-8?B?eTNlekt3REFzK05ScnloZjArUWdubERQNU4xVEZONlJOZTVWdjFGQzJ6Z1JR?=
 =?utf-8?B?NFk4c1pIWHNmU1JWUmJ3Ykd5NEJDL2xCckppTzRoOGV5Z0lJWUJHZ1BOL2hX?=
 =?utf-8?B?UUwwZ0ZDU2NyQ2g1Nk9uc0djWU9uOXlzYy8zeWc4MGplVDV1VVNtNU5CR3p1?=
 =?utf-8?B?Tjc0OVJTM3gzT1AwaE1qM3VyTDVMaVF2Y1lMd2lYeGsyamJ0Y24xU1hKWXlT?=
 =?utf-8?B?UjA2aG8raE1MM3ZsN3lyckU4YlczVlE5ZEpUQTNrbWo3T1kzUllCQVZEVVNi?=
 =?utf-8?B?L1h5a2JLaittRUVxTnBCM1ZnNThmRjBuZXZZYjRmMEt0dUR3RzhuUWMxblc1?=
 =?utf-8?B?U1A1YUY1aUFmc1RWRXc1RTF2TzZmY282UTRRVk42UkpZb0M2Z0l2TUNyODhT?=
 =?utf-8?B?bzU5NlBqN245VWRLc0o2TXRoQmFrQmJNb2lCd09TTWpJdUljSk1lM3ArKyt1?=
 =?utf-8?B?eGR0LzB0aVUwdTJzZ0NZMm4vTkN2TjNjRlh3TXJkRzRuWGUyVlgxTXRpaFNC?=
 =?utf-8?B?aFNja2YvU0RoY3haMmxISjJwZ21CLzRpRkR3M045bFdSZVQyRmZibHd0VU84?=
 =?utf-8?B?TFFBNGM3V3lHVUJKT1REK2hHdXh5UmdRaUwyN2VDSjN4blBrTUZVTG0yd1Jk?=
 =?utf-8?B?UUJoNnlRaGdBTGZYVTJkQW5YeWljY1N6aVduSEJ0STBuaDNlTVdrdHRpMFhZ?=
 =?utf-8?B?eEZLWUh4UnFQUVpJTHhRMW5wcmhOL1VOZjdwRExKVHdrQWRiUlk4MXN4UlVl?=
 =?utf-8?B?cnV6eVhBMERIcGdoWEREZmlwMkovdDUyNlg3YSs3aWRESVFlbXE5NzJkT0Jl?=
 =?utf-8?B?UTNTZzNUZFB0Rk1HZFhrUzFDM2dJWWRmdVViVzg4d052MzZ0L2pkdWdKazNN?=
 =?utf-8?B?UmtYWFg1bkxFbkVUTDZQaldNMFdORTc1SzlhQ2MvbStVaU54Qk9HNGROTWNk?=
 =?utf-8?B?NG9xN1RjenJ4REFnZjR0K2VZT1BzNWJjY1k1OWg0bjhjai9VS2NQZ0JOT1Nu?=
 =?utf-8?B?bFZwWGdlMVJWNERjM3ZXMC84cXFrQU5UUGk3bml1QzhvcnJqYVM2aDhIdXJn?=
 =?utf-8?B?YkU4YkhPZlVLT2tNRm5USHBxK1BzQWhiNG9FY2kyeDAvUk9vMlJ2WE5CZG1X?=
 =?utf-8?B?RG5zWXpsU3BwRi9MNFlXTEJGRzdQY29FL3ZHcklCbFhqQTM4a1dkRDJKV29z?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE2638566306FD4F864173DE7B20EB61@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914db6eb-a16d-44c3-4d3c-08dc4679d586
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2024 12:00:26.6516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xPGjyy/PkWqW7RMQLUG0aqUQcOSeGbhxNAqfaNtv3uJNRzWU8yndCyQvR/7GwBUFObiEes6TfvU3MoOLsNPQpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6941
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAzLTE1IGF0IDEwOjU4IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMy8xNS8yNCAwNDoyNiwgRmVuZyBUYW5nIHdyb3RlOg0KPiA+IFRob21hcycgcmVjZW50IHBh
dGNoc2V0IG9mIHJlZmFjdG9yaW5nIHg4NiB0b3BvbG9neSBjb2RlIGludHJvZHVjZXMNCj4gPiB0
b3BvbG9neV9tYXhfcGFja2FnZSgpLMKgDQoNCnMvdG9wb2xvZ3lfbWF4X3BhY2thZ2UvdG9wb2xv
Z3lfbWF4X3BhY2thZ2VzDQoNCkFuZCB0b3BvbG9neV9tYXhfcGFja2FnZXMoKSBpcyBub3QgbmV3
LiBUaGUgcGF0Y2ggc2V0IGFjdHVhbGx5DQppbXByb3Zlcy9maXhlcyBpdC4NCg0KDQo+IA0KPiBJ
IGFsc28gZGlkIGEgYmlnICpndWxwKiB3aGVuIEkgc2F3IHRoaXM6DQo+IA0KPiDCoMKgwqDCoMKg
wqDCoMKgI2RlZmluZSB0b3BvbG9neV9tYXhfcGFja2FnZXMoKSAoX19tYXhfbG9naWNhbF9wYWNr
YWdlcykNCj4gDQo+IGFuZDoNCj4gDQo+ID4gwqDCoMKgwqDCoMKgwqAgLyoNCj4gPiDCoMKgwqDC
oMKgwqDCoMKgICogVG9kYXkgbmVpdGhlciBJbnRlbCBub3IgQU1EIHN1cHBvcnQgaGV0ZXJvZ2Vu
ZW91cw0KPiA+IHN5c3RlbXMgc28NCj4gPiDCoMKgwqDCoMKgwqDCoMKgICogZXh0cmFwb2xhdGUg
dGhlIGJvb3QgY3B1J3MgZGF0YSB0byBhbGwgcGFja2FnZXMuDQo+ID4gwqDCoMKgwqDCoMKgwqDC
oCAqLw0KPiA+IMKgwqDCoMKgwqDCoMKgIG5jcHVzID0gY3B1X2RhdGEoMCkuYm9vdGVkX2NvcmVz
ICoNCj4gPiB0b3BvbG9neV9tYXhfc210X3RocmVhZHMoKTsNCj4gPiDCoMKgwqDCoMKgwqDCoCBf
X21heF9sb2dpY2FsX3BhY2thZ2VzID0gRElWX1JPVU5EX1VQKHRvdGFsX2NwdXMsIG5jcHVzKTsN
Cj4gDQo+IEJlY2F1c2UgSW50ZWwgb2J2aW91c2x5IGhhcyBoZXRlcm9nZW5lb3VzIHN5c3RlbXMg
dG9kYXkuDQo+IA0KRGF2ZSwgSSB0aGluayB5b3Ugd2VyZSBjaGVja2luZyB0aGUgb2xkIGNvZGUu
DQpQbGVhc2UgcmVmZXIgdG8gY29tbWl0IDA5MDYxMGJhNzA0YSAoIng4Ni9jcHUvdG9wb2xvZ3k6
IFVzZSB0b3BvbG9neQ0KYml0bWFwcyBmb3Igc2l6aW5nIiksIHdoaWNoIGlzIGp1c3QgbWVyZ2Vk
IGluIHRoaXMgbWVyZ2Ugd2luZG93Lg0KDQp0aGFua3MsDQpydWkNCg==

