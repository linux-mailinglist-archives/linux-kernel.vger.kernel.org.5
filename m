Return-Path: <linux-kernel+bounces-126783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0654893CA9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36191C21878
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88EF45974;
	Mon,  1 Apr 2024 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fXZwSbxC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B527B45C04
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984295; cv=fail; b=pbTZ68563nUXNRwCt+pMuNvaIqVynHghR766Q7gNwvnOwv/Fe5ysX7TrkoKKgGefFxOanAitgeXtj2UJLR1jcG7kMWm55A4Q0YspxLc1Yg3SpYiU/3HvMr7F98gvHpFXLa4JA/QcytYqc1QQaStkn02LHi7StoIdDp5SXIuX0g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984295; c=relaxed/simple;
	bh=G501xDC6Qxh0FI+BNDlFlPPifpDwoU3Xtjpp8bDt7/o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z+gvvzwfabQTezSx6DATCaI+HfvSVMeJd+kC10y5eRR67B8VGQlDAu8B5lKKOIJYZd3TM5IYjDcrvhHO63yPFlCYAUE4i6ees1jXjgpjyM638Zi2fJP/akcr+vi6swYAKRramqYzvFw0Z6sUe/Oyq3VcALoSb2SpYm0hNHYYXgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fXZwSbxC; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711984292; x=1743520292;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G501xDC6Qxh0FI+BNDlFlPPifpDwoU3Xtjpp8bDt7/o=;
  b=fXZwSbxCmwEAg6b34fMTv+s+CT6komLDHxSSEkXIJSx4CFM/hqtdqybh
   Q4u4wy/RdxQTa7lB7o5+IwX/tx7YEJLsaZPsqomf7aZlWv28LAa7usRin
   jgrpDeGtQtbMI8NfWvi+MjUJMU+KVwXs7okOzjYvZH/LAfk7ZLK3NFBtf
   k0WP8n6AteofHgROqjYIs+XFF7SdIr5TS2gLKn21Tm/VvqeLcKmAT6D7J
   0ekKseDDSZ9AIfaT1LtSIQ3kTlF33grcKRxXRn2V+v93lwoWeL6MYOhqp
   H6nADROwYbWeYormVl56R9a+wKc+uE1JBMsFcZAWs/GmRkLj90A/uUbWO
   Q==;
X-CSE-ConnectionGUID: cUEuAi/LScqwA8IVOX6a1A==
X-CSE-MsgGUID: RF93tpDKTUmmEhScwU70pg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7010525"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="7010525"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 08:11:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="22418381"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 08:11:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 08:11:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 08:11:30 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 08:11:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsdHFE2H42+bMOT3DErS6bc9BrABia3znWBh5yG229x1p3rChS4pg94szSR/oM9HAtt+5dyVXMv7RIe4pQ0DJlCttfTSXiMGxHJSz/Xy+w6XIiGpH4/2ohISKZCtShLMPVHAobEtK1T8SVGp3JbRu8aNIn1zdpVG7tPBfvruUGtbfDKAqKsxUPVUA94hFMremAA6934wCqdUm82rOF0FdiAk9WlyReSsgOvI9nC1PMmCxNMDMRiIdoTZqdXWARlfizGr64MnyQPqN1opUIuJ6CYYnzKMBRVwIzA87IW8MykHG2VOIE+xCOPAiL/FfTuIf6NtUTUy7/S3C8HYffXeIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G501xDC6Qxh0FI+BNDlFlPPifpDwoU3Xtjpp8bDt7/o=;
 b=FG7g6s1+wg6iHHc4twiaqceWndzGyy7LxlRRFB6Ct0QGvUD+USnDmmsMD7k97+yM9uu5OEzu1Kxbbpo5/QDmYhdT6H3FQNocRCSmEjhtRgM5raUO7+0n8AvDjQGeHk+kokvxtdHpltIo5J4QQPkUUjczVJ9B/u/D4amnQ5galnyF1rqT19Gax5ATZUeHLdmg7efH17s98KDfaRouM1JRaHIb2WBZyGEXQl22V2/1sao8fUqRrNNvjt4OCIOgPpPBXgvXmRBd6rpzyEbHbB+NWew7JsmUXFeBFE/p0MRTjm5piMWe5wdCmv6DM+DSYQ4SfqWkspbjYNdsZbYSdzes5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SA1PR11MB6871.namprd11.prod.outlook.com (2603:10b6:806:2b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Mon, 1 Apr
 2024 15:11:26 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::90e5:7578:2fbf:b7c4]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::90e5:7578:2fbf:b7c4%4]) with mapi id 15.20.7452.019; Mon, 1 Apr 2024
 15:11:26 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, "Winkler, Tomas"
	<tomas.winkler@intel.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: RE: Linux logs error: `mei_me 0000:00:16.0: cl:host=04 me=00 is not
 connected`
Thread-Topic: Linux logs error: `mei_me 0000:00:16.0: cl:host=04 me=00 is not
 connected`
Thread-Index: AQHagb5xXYUPlfLHd0KdEFyAoBFj27FQGuoAgAADYICAAt+Y8IAAaZMAgAAf9CA=
Date: Mon, 1 Apr 2024 15:11:26 +0000
Message-ID: <CY5PR11MB6366991764CA4226DCD5DC6BED3F2@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <4c785706-2961-4eac-b5d7-2cf89c195969@molgen.mpg.de>
 <PH7PR11MB76058497570D49516C809BE9E5392@PH7PR11MB7605.namprd11.prod.outlook.com>
 <9a0551c8-d29e-4fb8-a85e-6f7f72e0de69@molgen.mpg.de>
 <CY5PR11MB6366A6163D4029FE505C9A18ED3F2@CY5PR11MB6366.namprd11.prod.outlook.com>
 <e89ad4a6-4de6-4290-a0e8-1686af96e11a@molgen.mpg.de>
In-Reply-To: <e89ad4a6-4de6-4290-a0e8-1686af96e11a@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|SA1PR11MB6871:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q8sFcS7BMe0RYlFhXl69GrcBd9Twz27Op+avJmgr/e7L2kcd/9fk6R+3JGya2WPt1LhEzz3VwhZKW1fQYEzsrU1yFUqNoPSo8y4nRb5xm493IOuDdIr483WmKWFIHfsj8fWsmFLQMeCWnTwZhjc9tcEJkWUpYuQ8baXwyfsP1v5RS2hTF7eV9i0w0uKXp9oAkexnHpR+PbwmuWQaBxyN5cTv17soFthNPClozcSbw34xjUItgX1N3ToyxSAGWhYD3SBu32mYQRV9oVvUtum8Qpw591CGFTsqppm58p/7r3Dn777mc3X/v+6WiSdxbUw4gjVxIk2R8JEZ2myizplrTIymXMOm9xcGmWJLg13ZtD18ToQZjM2STvZYfR99tSI/z5qpKu7HsdGUDRbVnJ31PGQNQYjXs8SpkerPrAPPXq+9YCvkOocNXIv27iiqyPB+Vx4VafeoMg5EfmULHtGQ+ZmV9yoZWAGFqCsK68nwpN/dJ24N5SP85h1Vcv7yptik5oq+x4C4ngiOd+D6X2fbasXt+AxaTc+eYW1mn1jjXCYDUXWJw4yqsv50G7QleZntWgdGBHnAUQNyl4X7uTwNhCRBpd5wgKDF8NVje7czUnc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFVoMUJZWEtNZnN0ZjlLSmczR2hZOUtIVms2elN3R0dFbnR1cGNVVGhvVDRy?=
 =?utf-8?B?Zm5kZzRBZjhpMXkzSFhOb1lmdk1WTS9nTVpkdDBqYXZSV0Zxakorbm1lbHRO?=
 =?utf-8?B?ZTBqTmRDSmIxakpuZVQ2YzVSVmRyVFhsMGcvbURMQ2dsN2FqQlZUYmZGajcr?=
 =?utf-8?B?UklvWW1KYUtOREZXZEs0NTZrS2VrdFpPKzRQbGd1dVIvTFc0cUwwVUFwSVlC?=
 =?utf-8?B?Yi9nMnEyd2U3SVNwY2VONll0NVJpUGc2VUo0cmdJbXRQdUszenRkUFVIVnli?=
 =?utf-8?B?VHp5UGxKQTFITkN6MmhYdWRyWmF6SjZlcWZtc2JtaU05cWtDbXFhRnl0Tk1C?=
 =?utf-8?B?eWU4N01HRTloVGZFODVUYllrU2o2VGNwMm5NWHgweTZGbmN1Q01sVnliUEda?=
 =?utf-8?B?andvdTY1SE5yTHpYeWIwMERWcEJIOHExbkNEMzd5b3JscVl1R3BDRkxpQWFt?=
 =?utf-8?B?TnZCVW8zWFpoSnFBSGRLb1BwSWg5WWtxMlczQ0NzNVFKL0F2Qyt6SkFLejJY?=
 =?utf-8?B?eEFSVTNMaHJYeW5wcnZZR01HdmxldlZFT1lhL2RDTmx3aUZLWnJtL0xoRjVJ?=
 =?utf-8?B?eGtJYm5ocy9xNHNTOGFUc1YwWERIT1dBU1pPVU1qd0g2dU0vSGI4ZWdMODlo?=
 =?utf-8?B?U0F5V2d3YmdRVVRYVS8rSTRyM2NvNXpjWHROb09Fa2Y2MStESk1WeFE3Y3Bi?=
 =?utf-8?B?L3NQOEhGeXd2Sm9WQllZQ3FiNDgyV0VSL280bjAxMW9kUU1xcGVQc09qQzB2?=
 =?utf-8?B?MnBMN3gyQk5ZTXVFMFcyRi9oZXJqRjFMOG91L0wwZk42NHBaaEJsVzJJdDRE?=
 =?utf-8?B?RnY5SThVTkFGMDRCVkxYNm5kUWFCQW5BQjlxanAwdFpxU2R4b09sNDdORVB1?=
 =?utf-8?B?Wk11SFFyc01TQkVxcGg4OTFPTTh0eUd6OThJN2dESXhET01RL3JmSXJNbDBn?=
 =?utf-8?B?WjQ1Um5qZUJtaFdpdjAvYlBaUEcxMnd6bDRoczRWRUlIbXBuQ2VzQWxsNGd2?=
 =?utf-8?B?TmYybHBGK25uTGNHT1FjNXZMTGVRVWl3c2Z0OWFGNWlldkY2RnFJS24rUXlG?=
 =?utf-8?B?bGRHZVZJV3hxeXQzNFBHQ1k1NWJwRWpQOTRQaUE5WExQNWtQUXc2STZ5a2Vt?=
 =?utf-8?B?L1YzY2QvZG5ZOVppeHA3MWdFeFk1L25iYkttdzhaeDhqSUtjS0ZaY2RTRlkr?=
 =?utf-8?B?MlR2bDFaK2JQaDM4SmN2SU9aSHREUXpFamk5MU5VamppZ05Ra1NETGlSbk91?=
 =?utf-8?B?VTQ1RWJiYURFOTdVWFM3dEV4eFlnbVZ5U3Fobm51SXJJNU5mM1lQWjA4b0NB?=
 =?utf-8?B?Z1loaHJBNlhCMWxjTXVpWkxVZnlqK3Nvamt5eERhM2lIbXNrYlpmcmxWQldv?=
 =?utf-8?B?UHJBUXlEbkcrTzRGQ2VKL1J6dWF4Z0xIWklXaHdvUUVja1Y2YlFlekRwRnVC?=
 =?utf-8?B?UnJoRnpOdmRKa2VxaHFOemg0Si9iMGJKdkJ1bUV3S3NkK2c3Z2tNeWVzRGpp?=
 =?utf-8?B?RlNBSDZyNEVZenJ5ak9LM3hSa242M0NhTEVPTXFXY1gyKzhxWTVQQ1lBWnRm?=
 =?utf-8?B?aWJPTDl0Z3NCckJIUzFkclpKbWszQjRqbWhkZm8zNzdscGRaTXJjVXFQSFNO?=
 =?utf-8?B?RTczTHVzbU1xSHgxWE53TFJzNzczeHBhTlVNOVF0SFBpSHVwQmc1cTgzN292?=
 =?utf-8?B?VzRqb0F6YnVLN254SHJleXVkcnA4elQ1T21NdjRGMTFxeTdMUEZFaTRMcVp2?=
 =?utf-8?B?WTNidFp0ZWtHMFpha1lUSWZIRmVZNmI5L3J3cU5KcHZ6R3NlYmR1ZG5UbTZh?=
 =?utf-8?B?Y0J2OHRHZXljVldFM2ptaHd2ckdFcTRTcVYxanVJZEVlaElHMm42VkJ6Ym5F?=
 =?utf-8?B?YmYxWXEwOGVXNko1SnZybzZFa0g0Z2M2VFF0SEtaV2E1RlVPNDlBaEpHSU9D?=
 =?utf-8?B?NEZEeHpsc1dqeG5hcjkvUHJleW9QRXRzSTY1bkRPVkJVYkV0KzZSRnZRVVBW?=
 =?utf-8?B?dDZzcTF3UE96bHN1RDNvNm94dUo4elFwbUpQSXAxWmJhM2tqVWR5OTVvQW5U?=
 =?utf-8?B?ajd0Qk1LbHhZMTdXUVllaS9VM2gvT0w1NGx5VFNOV25MRlltNVpSS3Z0bW40?=
 =?utf-8?B?Q2dLbkMrcnNycGVIaVM1bjVDZU5tTFNuWG8ySGVSSGxscHQrVEc4TlJ2Mi92?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783752f3-88ee-4991-18bc-08dc525e0065
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 15:11:26.6204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yV7pzg3IU41jLFz0TUjfp37J2Ajn4EbBr/k/tQGCAt1sBeQszdzY1AW8VwRrF/ofzyrqNhKumF/b9v7T/tKpTFygwFDWPIo1b7kJPJpFGtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6871
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYXVsIE1lbnplbCA8cG1lbnpl
bEBtb2xnZW4ubXBnLmRlPg0KPiBTZW50OiBNb25kYXksIEFwcmlsIDAxLCAyMDI0IDE2OjA3DQo+
IFRvOiBVc3lza2luLCBBbGV4YW5kZXIgPGFsZXhhbmRlci51c3lza2luQGludGVsLmNvbT47IFdp
bmtsZXIsIFRvbWFzDQo+IDx0b21hcy53aW5rbGVyQGludGVsLmNvbT4NCj4gQ2M6IExLTUwgPGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBMaW51eCBsb2dzIGVy
cm9yOiBgbWVpX21lIDAwMDA6MDA6MTYuMDogY2w6aG9zdD0wNCBtZT0wMCBpcyBub3QNCj4gY29u
bmVjdGVkYA0KPiANCj4gRGVhciBBbGV4YW5kZXIsDQo+IA0KPiANCj4gVGhhbmsgeW91IHZlcnkg
bXVjaCBmb3IgeW91ciByZXBseS4NCj4gDQo+IEFtIDAxLjA0LjI0IHVtIDA4OjU0IHNjaHJpZWIg
VXN5c2tpbiwgQWxleGFuZGVyOg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiAN
Cj4gPj4gU2VudDogU2F0dXJkYXksIE1hcmNoIDMwLCAyMDI0IDEzOjU2DQo+ID4+IEFtIDMwLjAz
LjI0IHVtIDExOjUwIHNjaHJpZWIgV2lua2xlciwgVG9tYXM6DQo+ID4+Pg0KPiA+Pj4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4gRnJvbTogUGF1bCBNZW56ZWwgPHBtZW56ZWxA
bW9sZ2VuLm1wZy5kZT4NCj4gPj4+PiBTZW50OiBGcmlkYXksIE1hcmNoIDI5LCAyMDI0IDEyOjQ5
IFBNDQo+ID4+DQo+ID4+IFvigKZdDQo+ID4+DQo+ID4+Pj4gT24gYSBEZWxsIFhQUyAxMyA5MzYw
LzA1OTZLRiwgQklPUyAyLjIxLjAgMDYvMDIvMjAyMiB3aXRoIERlYmlhbg0KPiA+Pj4+IHNpZC91
bnN0YWJsZSBhbmQgc2VsZi1idWlsdCBMaW51eCA2LjktcmMxKyB3aXRoIG9uZSBwYXRjaCBvbiB0
b3AgWzFdIGFuZA0KPiA+Pj4+IEtBU0FOIGVuYWJsZWQuDQo+ID4+Pj4NCj4gPj4+PiAgICAgICAg
JCBnaXQgbG9nIC0tbm8tZGVjb3JhdGUgLS1vbmVsaW5lIC0yIGEyY2UwMjJhZmNiYg0KPiA+Pj4+
ICAgICAgICBhMmNlMDIyYWZjYmIgW1BBVENIXSBrYnVpbGQ6IERpc2FibGUgS0NTQU4gZm9yIGF1
dG9nZW5lcmF0ZWQgKi5tb2QuYw0KPiBpbnRlcm1lZGlhcmllcw0KPiA+Pj4+ICAgICAgICA4ZDAy
NWUyMDkyZTIgTWVyZ2UgdGFnICdlcm9mcy1mb3ItNi45LXJjMi1maXhlcycgb2YNCj4gZ2l0Oi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3hpYW5nL2Vyb2ZzDQo+ID4+
Pj4NCj4gPj4+PiBBZnRlciBzZXZlcmFsIEFDUEkgUzMgKGRlZXApIHN1c3BlbmQgYW5kIHJlc3Vt
ZSBjeWNsZXMsIHRoaXMgbW9ybmluZyBJDQo+ID4+Pj4gbm90aWNlZCB0aGUgZXJyb3IgYmVsb3c6
DQo+ID4+Pj4NCj4gPj4+PiAgICAgICAgWzI5MzU3LjE3NzYzNV0gbWVpX21lIDAwMDA6MDA6MTYu
MDogY2w6aG9zdD0wNCBtZT0wMCBpcyBub3QNCj4gY29ubmVjdGVkDQo+ID4+Pj4NCj4gPj4+PiBU
aGlzIHNlZW1zIHRvIGJlIGxvZ2dlZCBmcm9tIGBtZWlfd3JpdGUoKWAgaW4gYGRyaXZlcnMvbWlz
Yy9tZWkvbWFpbi5jYC4NCj4gPj4+Pg0KPiA+Pj4+ICAgICAgICBpZiAoIW1laV9jbF9pc19jb25u
ZWN0ZWQoY2wpKSB7DQo+ID4+Pj4gICAgICAgIAljbF9lcnIoZGV2LCBjbCwgImlzIG5vdCBjb25u
ZWN0ZWQiKTsNCj4gPj4+PiAgICAgICAgCXJldHMgPSAtRU5PREVWOw0KPiA+Pj4+ICAgICAgICAJ
Z290byBvdXQ7DQo+ID4+Pj4gICAgICAgIH0NCj4gPj4+Pg0KPiA+Pj4+IHdpdGggYGRyaXZlcnMv
bWlzYy9tZWkvY2xpZW50LmhgIGNvbnRhaW5pbmc6DQo+ID4+Pj4NCj4gPj4+PiAgICAgICAgLyoq
DQo+ID4+Pj4gICAgICAgICAqIG1laV9jbF9pc19jb25uZWN0ZWQgLSBob3N0IGNsaWVudCBpcyBj
b25uZWN0ZWQNCj4gPj4+PiAgICAgICAgICoNCj4gPj4+PiAgICAgICAgICogQGNsOiBob3N0IGNs
aWVudA0KPiA+Pj4+ICAgICAgICAgKg0KPiA+Pj4+ICAgICAgICAgKiBSZXR1cm46IHRydWUgaWYg
dGhlIGhvc3QgY2xpZW50IGlzIGNvbm5lY3RlZA0KPiA+Pj4+ICAgICAgICAgKi8NCj4gPj4+PiAg
ICAgICAgc3RhdGljIGlubGluZSBib29sIG1laV9jbF9pc19jb25uZWN0ZWQoY29uc3Qgc3RydWN0
IG1laV9jbCAqY2wpDQo+ID4+Pj4gICAgICAgIHsNCj4gPj4+PiAgICAgICAgCXJldHVybiAgY2wt
PnN0YXRlID09IE1FSV9GSUxFX0NPTk5FQ1RFRDsNCj4gPj4+PiAgICAgICAgfQ0KPiA+Pj4+DQo+
ID4+Pj4gVW5mb3J0dW5hdGVseSwgSSBkbyBub3Qga25vdyBhdCBhbGwsIHdoeSB0aGUgTUUgbmVl
ZHMgdG8gYmUgd3JpdHRlbiB0bywgYW5kDQo+ID4+Pj4gd2hhdCB3YXMgdHJpZWQgdG8gYmUgd3Jp
dHRlbiwgYW5kIHdoYXQgdGhlIGVmZmVjdCBvZiB0aGlzIGZhaWx1cmUgaXMuDQo+ID4+Pj4NCj4g
Pj4+PiBDb3VsZCB5b3UgcGxlYXNlIHRha2UgYSBsb29rIGF0IGl0Pw0KPiA+Pj4NCj4gPj4+IExv
b2tzIGxpa2UgYSB0aW1pbmcgaXNzdWUgYmV0d2VlbiBzZXR0aW5nIHVwIEhEQ1AgYnkgZ3JhcGhp
Y3MgYW5kDQo+ID4+PiBkZXZpY2UgcG93ZXIgbWFuYWdlbWVudC4gIEkgZG9uJ3QgdGhpbmsgdGhp
cyBpcyBhIHJlYWxseSBhbiBpc3N1ZSBpZg0KPiA+Pj4gdGhpcyBpcyBoYXBwZW5pbmcgZHVyaW5n
IHBvd2VyIGN5Y2xlcyBzdHJlc3MuDQo+ID4+DQo+ID4+IFVuZGVyc3Rvb2QuIENvdWxkIHRoaXMg
YmUgYmVjYXVzZSBvZiB0aGUgQWRkcmVzcyBTYW5pdGl6ZXIgKEtBU0FOKT8NCj4gPj4NCj4gPj4+
IEFueXdheSB3ZSB3aWxsIGxvb2sgYXQgdGhhdCwgd2lsbCB5b3UgYmUgYWJsZSB0byBwcm92aWRl
IG1vcmUgZGVidWcNCj4gPj4+IGluZm9ybWF0aW9uIGlmIHdlIGFzayBmb3IgaXQ/DQo+ID4+DQo+
ID4+IFRoYW5rIHlvdS4gWWVzLCBJIGNhbiB0ZXN0IHBhdGNoZXMuIEJ1dCByaWdodCBub3csIEkg
d2FzIG9ubHkgYWJsZSB0bw0KPiA+PiBzZWUgdGhpcyBvbmNlLCBzbyBJIGFtIG5vdCBzdXJlIGhv
dyB0byByZXByb2R1Y2UgaXQuDQo+ID4NCj4gPiBUaGlzIHByaW50IGlzIGluIHRoZSBjb2RlIHBh
dGggZXhlY3V0ZWQgZnJvbSB1c2VyLXNwYWNlIG9ubHkuIFNlZW0NCj4gPiBsaWtlIHNvbWUgdXNl
ciBzcGFjZSBhcHAgaGF2ZSBoYWQgY29ubmVjdGlvbiBvcGVuZWQgYmVmb3JlIHN1c3BlbmQNCj4g
PiBhbmQgdHJpZWQgdG8gd3JpdGUgYWZ0ZXIgcmVzdW1lLCBidXQgZHJpdmVyIGNsb3NlZCBhbGwg
Y29ubmVjdGlvbnMgb24NCj4gPiBzdXNwZW5kLiBUaGlzIGlzIG5vcm1hbCBmbG93OyB1c2VyIHNw
YWNlIHNob3VsZCByZW9wZW4gaGFuZGxlIGFuZA0KPiA+IHJldHJ5IGluIHRoaXMgY2FzZS4NCj4g
DQo+IEludGVyZXN0aW5nLiBXb3VsZCB1c2VyIHNwYWNlIHByb2dyYW0gY291bGQgdGhpcyBiZT8N
Cj4gDQoNCllvdSBjYW4gdHJ5IHRvIGxvb2sgd2hvIG9wZW5zIC9kZXYvbWVpKiB3aXRoIGxzb2Yg
b3Igc2ltaWxhci4NCg0KPiA+IFRoZSBwcmludCBjYW4gYmUgZGVtb3RlZCB0byBkZWJ1ZywgSSB0
aGluay4NCj4gDQo+IFVuZGVyc3Rvb2QuIFN0aWxsIG1heWJlIGl0IGNvdWxkIGJlIGV4dGVuZGVk
IHRvbywgc28gdGhlIGNhdXNlL3NvbHV0aW9uDQo+IGNvdWxkIGJlIGRlZHVjZWQgZnJvbSB0aGUg
TGludXggbG9ncy4NCj4gDQpUaGlzIGNhbiBiZSBnZW51aW5lIHVzZXItc3BhY2UgZXJyb3Igd2hl
biBhcHAgYnJlYWtzIHRoZSBwcm90b2NvbC4NCkRyaXZlciBoYXMgbm8gZGF0YSB0byBkaXN0aW5n
dWlzaC4NCg0KPiANCj4gS2luZCByZWdhcmRzLA0KPiANCj4gUGF1bA0KPiANCj4gDQo+IFBTOiBP
bmx5IGlmIHlvdSBjYXJlOg0KPiANCj4gPiAtLQ0KPiA+IEFsZXhhbmRlciAoU2FzaGEpIFVzeXNr
aW4NCj4gDQo+IFlvdXIgc2lnbmF0dXJlIGRlbGltaXRlciBtaXNzZXMgYSB0cmFpbGluZyBzcGFj
ZSBhdCB0aGUgZW5kIFsxXS4NCj4gDQo+IA0KPiBbMV06IGh0dHBzOi8vZW4ud2lraXBlZGlhLm9y
Zy93aWtpL1NpZ25hdHVyZV9ibG9jayNTdGFuZGFyZF9kZWxpbWl0ZXINCg0KVGh4LCBmaXhpbmcs
IHRoaXMgc2hvdWxkIGJlIHJpZ2h0Lg0KDQotLSANCkFsZXhhbmRlciAoU2FzaGEpIFVzeXNraW4N
Cg0KQ1NFIEZXIERldiAtIEhvc3QgU1cNCkludGVsIElzcmFlbCAoNzQpIExpbWl0ZWQNCg0KDQo=

