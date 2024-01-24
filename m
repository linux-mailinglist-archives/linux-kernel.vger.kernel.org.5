Return-Path: <linux-kernel+bounces-37186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B47583AC62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501C01C23153
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE0185C67;
	Wed, 24 Jan 2024 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TBTpgH6g"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFB482D8B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106731; cv=fail; b=pd6EAMOk1Wj61lBdhz+pwRkjfAKGEvnfrgUKUCIZmiVBy2zV8ykK8Aw/HxrCAzFelQuXfD5onkz/qgURzGcUts/sLVuRZu+BY6qwp9zVRp/7OcB4pR9+8ce2m6ueoietZQ1PPwjHzPHHAZkBySFI7ElGjO/e/c5YVmv5pR4okts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106731; c=relaxed/simple;
	bh=bJbrY3WGQRf3Ghk79r3v2unG6kBqj3/ck3aXAB2Kcps=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ts151FIrZzdTiaEUqpiOeCemLYFmWle34YTwXKeucSgZfI5spQkKsbZOLyuVL0leHcOrXvp7VZXnB65EX0RIgJYL2E13zTZXQ8UuFK01KCihAbw1nM/546akYR003WmlKcADmlJjwoswvjXatGhC2iOxYKrdWSBrCHtXmeNi3yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TBTpgH6g; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706106730; x=1737642730;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bJbrY3WGQRf3Ghk79r3v2unG6kBqj3/ck3aXAB2Kcps=;
  b=TBTpgH6gUY9QmvaAxbOHbnFNaQ8jUs3rOWF/l9PZS0WeFGdqpTgXdkRg
   pXGRqZc6Ba145oMZrTAltBjhFi+mu4u7QiDLkujDrP3cDOu+EPTE+T6Dp
   Q5+BZ8NUFc4i/VaT45/lI6MFvwaRdaBleY23+pIHd+tEEr9njHRS9Aw2a
   Q7UD8H8aLTnmB7k+V6xjOq7i/4PL/2KuQSle1yaF0nhGHMTWctN/rMveE
   CitmTJW4e/gw7QaONmeFSWNAaJNzjPaJzks3XNFAUo380dxhi0UF/3y5t
   8UCvPhPS1giEZ8TdPwrDy+YteGmRqP6h6Rkmu60ifO54CvZ5+eppWZKG7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="15379795"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15379795"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 06:32:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="28409503"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 06:32:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 06:32:08 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 06:32:08 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 06:31:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEfiB+eWW5l2LtCltshYY92CkllO2JV4+tnDDn0cyDwwNqMIaR9k9dBCnwh9Yut3SjUcMKkN+bdRUBkG9Ot3+4DpAqq91oU4OeL3PyPGqOWzH2kFRLtCfAWcue7Ww7luwRXygiAgYJUPueIgChH0AXE12PxFWYk8GSOiwCc5ZYydbj5qHo66NcC4c146+OHU6XGjtZpQJk5J9rZH6SzjBglNS2uKrFuopw/miGEieYLvos1NhRbbQVXySUekBBkg5Wb2a5G+CyrnKvJLXRBnriGvJ9QEh5xolBqNGjyfhf6YfYWp0gGwWZMoDutvteruqR58ICNEIxCpJd/sL/zfXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJbrY3WGQRf3Ghk79r3v2unG6kBqj3/ck3aXAB2Kcps=;
 b=erezfUeXWCSl7DkAw8mt3ZUp3yRYYoc8vTArQLkWF/YlCZFGBr1m2yLyo3ToZin+QyuShyGbK6iR2MRAgR5RpYsd5CWNrM7izVl3rPeOSJDFYcVRsCiXjEfcNFpU9CAljnhbRh4rtrKMNufKuo/x3cEgih6UcAfUMf5UROXVY0FvGll/4AskGeMOk0gF68qiscJY36EAAx3s/z6cVwhrqthuLTd1GWZfbgOfBrbQiUDciNqBKm4UBAeVUnzyHPHiNHKGqvZTxVhSRVI0bEsQj/siBKuWO4XUKYPDcFRQBB2mT5u9+I12Ly4q8J889SoDFQHl/EFatbyIt+QwqMTOPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MW3PR11MB4603.namprd11.prod.outlook.com (2603:10b6:303:5e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 14:31:22 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102%4]) with mapi id 15.20.7202.034; Wed, 24 Jan 2024
 14:31:22 +0000
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
Subject: Re: [patch v2 00/30] x86/apic: Rework APIC registration
Thread-Topic: [patch v2 00/30] x86/apic: Rework APIC registration
Thread-Index: AQHaTf2eQ9x9pzT5z0K6RUEL6PVyBbDpCAMA
Date: Wed, 24 Jan 2024 14:31:22 +0000
Message-ID: <c755de1c9927f75aee2b8ee37e0aa340c55719aa.camel@intel.com>
References: <20240118123127.055361964@linutronix.de>
In-Reply-To: <20240118123127.055361964@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MW3PR11MB4603:EE_
x-ms-office365-filtering-correlation-id: fe0a22f6-1021-4c0b-74ce-08dc1ce9235d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K2xVtYWxBpIssJE5Hy+No6jCTTi+ATxFuRp6238cZKwOCB4m9RUF3rvrKbhXIAOsWhyvcAlrLkcsEmTVsWXNy+e4YPXj9vX36MopPHi60AL2wrSGBCC1dkXr+3d9/1NzCAEYJRD/I4XzUgBGfwzwF/aSLXY3B30ZiorfrYnAro+HTdxjCvU4nf49LR0mL9REv+G8lRJyxZAwCYSbjfk4/BlkUq6d3e268UZ5RJEySfeUh7cgsNMrP6x84z5x3lnEyuaElFLxBaT5ellw8xxKxyH3NUjh2TmwU6SnMDNhwZxmJuX+DZEYXbpQomXm0RZ2EZvLJVWZffLie+7Zl4iMk/OHEOot/IMJ4O6lyN6Q+L7urCBVlGf4JuKMyCEjzoM+Dnppm81p2dhjZ1SOluY4kHKttKZYtBDv31487wBI2PkFtXuFzURhdaN/BAhuzt9eGxvg80mpZsdGnL+ZHPTIlTlqN1ZM6nugeNzdG/HjIDq57v56973xlWFMEAYYg1uP/bJ+kNaW57m5jcqCk/0zlWHEVECx2hTSUSkg3OmwKIWZ3Z0ZNcoef+0UXW+vdzUaUHiN/Ql5KXVNJJoWtn3GQ3U2tS+u/WgMFoE+k68m5tm4PCnmZjdJboKFgCmbJoZd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(39860400002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(91956017)(6486002)(2616005)(6512007)(4326008)(122000001)(38100700002)(6506007)(26005)(8936002)(2906002)(5660300002)(8676002)(7416002)(478600001)(54906003)(66476007)(4744005)(71200400001)(110136005)(64756008)(66446008)(66946007)(76116006)(316002)(66556008)(38070700009)(36756003)(41300700001)(82960400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHBMQnlKeTE2TXk0OTBRT0pnRVh6bmNVNDk5bng5L3pRWjByL1dydlNiZ28x?=
 =?utf-8?B?UXVhcHFZTjErTEhZSW1Vekt5Y3Foc2tNNnhyRjFic3pVaEJBdnBQTHY2WGxI?=
 =?utf-8?B?RFVXQUR1VENUYjlvUGFIZDROL3FJL2VqR2Fha25sZGFQV1dnd09aNkFXdnN2?=
 =?utf-8?B?bmFVcEI1TmNkZHF5S2tDQ1Q5V0ZnWjlGYUhGT0l2TzFkWksyU1FFdDZ3MGFa?=
 =?utf-8?B?YUE2TlVBQkdWcFpzZnIvVG9xNVA2RSs3Ylcxb1ZINnV2Q2xFaTlWVHMvL1Fz?=
 =?utf-8?B?UXR4Z25yaTRhMko0UkkyNzRmaHU4Z0dPNmVxay9hZCtMd3FqRm1wMUtTRTZO?=
 =?utf-8?B?a2Jzc3ByMitTSFJkR0VDM0ZHR3lHSVVBRzR5b0V1aTB5aGd5MjRtZWZOY3N5?=
 =?utf-8?B?TDBkNjIzdzUyNTU3YVNKeWZXU1ZqQkgwL0tmbTFFVVNGY3ZpVHM1UWJhZHFu?=
 =?utf-8?B?Z0R3QmZMUGNhYXViSUtVZGNtQVRJQWc4Ti9yNVNka0lLdVVOU0thYjFFNFR6?=
 =?utf-8?B?TEZsdkx2cEJFc2pqMlZxeU1ab1JjcGJBcHN0YkNqckIrTklablUrem5NT0xG?=
 =?utf-8?B?WjE0Z0hvdlVjMS9rWU9WZnAxZ3o4MDQrNGxVcS9hNlhETGY1UXA3cEVFOHFR?=
 =?utf-8?B?alVYbWJLMVlQR3prSkp1Nnd6Y3I5YVo0WTI2RnF1NmY2S3hQMzJ0aVVwK29N?=
 =?utf-8?B?MTUrVGQ4TDlBTUloZW4zQS91ZkJUaWpLWWlrenV1a1JCT2dSTXkvMnRVVk1m?=
 =?utf-8?B?TjR4Z1JMQ3dXcVB2UHNKZmVWeGJFeUV4THVpSGs0c1l1Y0VXeS9TWjlYbDEw?=
 =?utf-8?B?QjZLK3NhaDdQR3hVYTg4cWFJVFhiRHI1Nk92OHZjazhVV3dxaEtDQ2o5QXBz?=
 =?utf-8?B?Wm9GdUNIdm02WW9mSTFpcEJ2Wk1zajRSR2FCYmJ2ME9Uemg3cGcyU3R2UzNi?=
 =?utf-8?B?L3NOQ0lINENUSUlQUFJqL3hrTkdHMFRuZmYxZjNyOTY4cmJNMnJIalQ5QUtv?=
 =?utf-8?B?RGJYZzYreTBkM3ZkeGdkYmdwdXdJK2M5MGhpdmhxVnlRVWlXTlpER3l6N25W?=
 =?utf-8?B?bjRoRi8zK3hOUUJiZEZ3em9yVGl0OTQ4aTRlVGxGWjFiWUVoUmhBK0RhQkpJ?=
 =?utf-8?B?WU1SVnpxWjVmTisyMHEvZEN2RFBWQlJ4aVo3d2tkUk5QZEp3dFkyL2hPdE51?=
 =?utf-8?B?RGp5SjV1T0tCcU1xRGtRd3ZJZ2ZmTG9KYWRmZ3dxZ08wYlp4MXBDWUJtSUI3?=
 =?utf-8?B?b1FFbWM5SUlMVE5Da0pNM0RpTXZMQ2NZV3VLRTNBNkhMNGZpTEhzdGhIRjNC?=
 =?utf-8?B?L2tPRU1CUmorQ0xRR1JNQkUydU9SeW8zWUY1UG5HT1VnOEIzWmpEVHQ5K0hr?=
 =?utf-8?B?NVR2TzJpTXRyUWZRY0FZWnJaanpieHQ4Y2t4bnR3aGVuelJyck5QRkdEMWhW?=
 =?utf-8?B?L3JMRFFMeUR6ZkZPM0NhQSt5T3IvL0VDTVdyYWcrdzJvd0FGNldWQ2NxbmtR?=
 =?utf-8?B?RCtua3NZMU5saHZMTXVlejI2eFJhNFhMa1lJZnZ5ZW5nV1FhK1o0RE12bEVE?=
 =?utf-8?B?Qk5PYnhHQitzZ1I0RnVDM0FqSWxDR2RtelBrMHdnOXg2MkU4TytrRVZXYTZ1?=
 =?utf-8?B?dVZhWXFFUUZjZVFDYlo5K2l0bWN1T3lXSEFXRndMK0xXWGRHUnQ3RkgzVFBu?=
 =?utf-8?B?bkl0K3N6Z0VoZ0FpYVR3ajlMVWdQY2tKemM0dENUKzFyQkJkS0lRYTZ4UHU3?=
 =?utf-8?B?YTdlVFovNlpoVXBGd1RpSytLKzNxbXVzcEluRjJCMlJ0MS9NR3VLbjdWa05T?=
 =?utf-8?B?VlhZVFI3dU44eFlZeUR6cnhjMjJvdTZGRm5VNjc2ejNsYTJKcGVpZ1g1cHl5?=
 =?utf-8?B?VDZCbTBPTFdhYXJyWXJOSzBRdjdxYmczOVRlSjlyVWlZQ2hWVEJtMVNMTk1O?=
 =?utf-8?B?YXIzSFM1VUZ0RWRqcnRSanRPazBMOFFJYVdETGMrV002WHIvcDJQK3M0dXZo?=
 =?utf-8?B?aVY2TVk2djNNTC9hVjFQWjFxQjIzMkM3dFNaRms0b3E4ZzBhWk1Gank0c2pS?=
 =?utf-8?B?LzE4a2F0bjhaVnZvUVI0M1dxeVlaZm9lMldhTTFEdlVrNlVmY3FNMDYxVWN3?=
 =?utf-8?B?TlBreVRIYnZML2RIb2F3NDdGSE1NVzJWSGlRU1RRa3NUbFdnOWlKM1VKTm5w?=
 =?utf-8?B?L3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EEB9D6149B84B43A187F5CEE61F3371@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0a22f6-1021-4c0b-74ce-08dc1ce9235d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 14:31:22.5905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: omt6YYZEmrsvtJs+77ZLf0mCB9Z4Hj23+0JwkhvznMLvzssvkleOiA0rEGG60/9oUGQMtgRBM3Xc/HU011axRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4603
X-OriginatorOrg: intel.com

PiANCj4gVGhlIGN1cnJlbnQgc2VyaWVzIGFwcGxpZXMgb24gdG9wIG9mIA0KPiANCj4gwqDCoCBn
aXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGdseC9kZXZlbC5n
aXQgdG9wby0NCj4gY2xlYW51cC12Mg0KPiANCj4gYW5kIGlzIGF2YWlsYWJsZSBmcm9tIGdpdCBo
ZXJlOg0KPiANCj4gwqDCoCBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvdGdseC9kZXZlbC5naXQgdG9wby0NCj4gZnVsbC12Mg0KPiANCg0KSGksIFRob21hcywN
Cg0KR3JlYXQgdG8gc2VlIHRoZSB1cGRhdGUuIFdlIGRvIGhhdmUgYSBjb3VwbGUgb2YgQ1BVIHRv
cG9sb2d5IGJ1Z3MgdGhhdA0KcmVseSBvbiB0aGlzIHJld29yay4NCg0KV2VuZHkgYW5kIEkgd2ls
bCB0ZXN0IGFsbCB0aGUgMyBwYXRjaCBzZXRzIG9uIGEgc2VyaWVzIG9mIG1hY2hpbmVzLCBidXQN
CnRoaXMgbWF5IHRha2Ugc29tZSB0aW1lLg0KDQp0aGFua3MsDQpydWkNCg==

