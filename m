Return-Path: <linux-kernel+bounces-90259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC5E86FC8D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A9E2812F2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB7B208D1;
	Mon,  4 Mar 2024 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ECXVwXR5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04591B7F1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709542784; cv=fail; b=DOF3YlNOo2wT+O1bctSgyWKHuataTGaHuGf7Vjqa/rb8rxl5fkN+w00MHVYgoIKRqslaqIHm5NCHpKKhO1L47dy6BBEkTRfsFCzm1U1aibR+jFzrPQ0faEWx6TUoFmIPKOJjuk1/JeHD/efm9L51neDYWlVzuNGHFMeGtl1K3gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709542784; c=relaxed/simple;
	bh=cVuZbqbf8wGbupOS3CiD9Bt5x6L9msjoADdgZE42oNk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rFPLajjsu20kokHtsYPSK8xl7MLbcOZ5D+dgBlLKQVROFCR5F+zfvs/LQ2BAwobMOdVmHOV7H8ADe+47VEOm8yiMYf9Bw/IWly9aC0DUS8oBIuP7xbrpwS0+3quO1i7XCR/jdt2ZiVa5wnOey5spPefC+VNZ8GkIO+fiOUwCRQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ECXVwXR5; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709542782; x=1741078782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cVuZbqbf8wGbupOS3CiD9Bt5x6L9msjoADdgZE42oNk=;
  b=ECXVwXR566F3ldViEB/Z/g21OmqohHUPB+xKfpywvFLKV1JB+wVrMX+6
   MOldTe/hPouFwbZVuhDaaTSAvwPYigIHDF6kHDZ5BID7SSzyzyg3zpoT9
   TW5LN4HaYKZ838wueT/5ndylVQezOWuCZhfSeyBp7K06/l8rTNAWVT+cb
   MRydXtaxnhd9jnfNxy8i/fBqBz6j5StHsebym3QHsgWUTtfDhys+ZW2vB
   1V7J3LVIPRJYJj0tGih/ps9bQgx7yJfwjKmRJONc1Dszmui6JK2sbtZDm
   nS41i3pETVRRJrj6+EM65fcHVsqW+Woy049SD1DZ5Pz8UyWS6ATqQjs1+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="21479464"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="21479464"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 00:59:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="13429106"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 00:59:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 00:59:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 00:59:39 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 00:59:39 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 00:59:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ofoca3G9GvTi4bcuk0O/pweXRp5n8jiSIzI9rBBXwnYM9ApJ1dTqGLwBNAkXi+yhGMnx4gLfccicCu10W18KVKD124CSNCyUB5PEGLmnYdoFc+AxB6FZWPclAtJJcGSl8CrSsUN3omplnNGUS4BHRBE9SBhMmmL3zL76NbRL0dWsJczWHTDmYo2GHcjZFyPk97GLa5chJyBsVZB23hG2QZxipNmkUh2tk3TyKb3dyez9MVfKTtCiTv7r1I4KEl3LiDwDh0kOlVMEgTqMUZkQu/8eCjCX/x6OfiSySC1H4hRRXIy2fh22WEdgTSudF5saSOof/hqs1dffFEkc9/jB9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVuZbqbf8wGbupOS3CiD9Bt5x6L9msjoADdgZE42oNk=;
 b=njB6h/b74M4DIuQepyvDR3Y1pKHZJ4G12HtOgjiRDNi0M67axd6My5ooyfOha2aRAvH/sxRDaXK59f55q/6HeWzqaGHAtR0I4vbbNya72OrTwF9LMg9ruzYwRpLD5f76wcS9w1fxzI3yZAHWoreXXF7oRDS4CITg4bgSJcyvaNruSilnu22ZuwGHnQEv6p/bJOIpMg/ahV9MF3LkdsAmqYDn7lcGOc3z5Qho/73B5i/fDgJbZsmDczQyXVztb9Daj6+CmnIBKtoRbJqdt0Npl4QZIWjXCpcObvwx9AtigFIzUQfmRTJU4nbcTbMeEV94KtZ9WvzDQEo7MKNlVGjRQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SN7PR11MB7115.namprd11.prod.outlook.com (2603:10b6:806:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 4 Mar
 2024 08:59:37 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::ca67:e14d:c39b:5c01]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::ca67:e14d:c39b:5c01%4]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 08:59:37 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Badger, Eric" <ebadger@purestorage.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] iommu/vt-d: Fix NULL domain on device release
Thread-Topic: [PATCH v2 2/2] iommu/vt-d: Fix NULL domain on device release
Thread-Index: AQHaavUDCy/i5tLpVk2E42aG3RqhHLEnNNfQgAALNACAAAy/AA==
Date: Mon, 4 Mar 2024 08:59:37 +0000
Message-ID: <BL1PR11MB5271815FE2D13186078BCED58C232@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20240229094613.121575-1-baolu.lu@linux.intel.com>
 <20240229094613.121575-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52764189F754ABF69D24E2AE8C232@BN9PR11MB5276.namprd11.prod.outlook.com>
 <2cc53838-c88f-43a0-b974-c5acb6f27849@linux.intel.com>
In-Reply-To: <2cc53838-c88f-43a0-b974-c5acb6f27849@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|SN7PR11MB7115:EE_
x-ms-office365-filtering-correlation-id: 4cb2b5d5-0397-4caa-fddb-08dc3c296ba2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QnWmzRXAwPikG7jtXwqvycTdPV2RymhS1Oka8VwpbiVI1sXKwZ07O/56nP3hcdR7dPvGrlCONj+BHFf+VA0BRSKTQAe7DRfTuFB+lHljWeMkDn1pOIyuaYHvYtyCyoMq4e1ssizOVzdosjmR2dCIsxe5fQxS49EQweTvD74oy9iHC/FLBoNK3Za4qbnL8nJEGuBEIIfuImWHJNxYv36TSupf7kNxi1CvpjMTZakVg6oQvVLEBtiWji+PuJCUHnvnbPyeUSzIuIOTYLicX6s5A+vVt32VaSuu4gAgGUXAhdySb6aar3dM5MIJBUeHw5C5m1xGrwtNivyQXVWgnWY++lBwg8vtg/Zefq+PPWzSnlETyT+Q/9XmNU0/21Ah0pC+Wu3q/h/GGl13D3BG2akTUsHIMUggKfIGVyb1bOGcCe4cPg4NK03nx+gfGaQKpzC1X9ELOCXTTKO3vm8rBprUMU4uHRgP96NB1nuJEWjVOrAuTYgWAlYowxLB6No8JvarH382zKOf1TfqW4CKRJbHhi/0zJ9KBiZBKgqiduOiw7/vPMR1uayuqucDitqhTVF8vj6YRnMSypaaC6Nk+gRlqvdwgrSkXKWvzu3eNNxyic5YtFKoQK/wmJoqUvkiNr3RzgwTv+sj/3YWmnjJVSH/tPqxTKXkBHYjjuUL6RP6Sk20nQT7mjMp+qi8TbtC8Ws2wNtTbbS2HZANytpMRD5T8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZThyNGFua3EzSXd2eFQ2ci9EeWxGVU42WHcrQUtvZVc1MGtXQ3Q1S0hGd1h4?=
 =?utf-8?B?RThWUXFVSkVyTGVva3BGZGlYaWN2ME5UNWNMSFhJQ2JMeEJDd1NKeDhvUXRK?=
 =?utf-8?B?OVhhVzUzNkMwZXZGc2xuQ255WHc5ZEhQam9FQmpLTkdzb21lK3ZLK3ltbjBI?=
 =?utf-8?B?UUZnaWhMc1N3MDAxby83c2hiYXpFeHY2WG5zcS9ONktzZm9PQUJ1L2dmaUhw?=
 =?utf-8?B?WVlrNVpQK01yVm1yVXc1VW1QalBaaGo0YVB2TzEvYk5GdnYyK1RFbk9wNUxT?=
 =?utf-8?B?ZGk0RDR6ZllQNkpETVExU0NkQ0N6eGJ6WUtpcHVlMmdoRW1OYWd1LzNIeGJv?=
 =?utf-8?B?RHRaRHoxVGt6WmdFZGRMZThDZnFXR1RLSkQ1dlJPMTN1azR4MVUwZGk0dktl?=
 =?utf-8?B?SnZsN00rVHkwdDI0TmttV0s5dWtyazRDeWlRTVpZeXZja1BPWlFYdWwreVN2?=
 =?utf-8?B?dFBSOEtKS0ROVG5hbWxzTVE0bHl6eUdmT2g5NjhMWnBEa0VTWm5QRjlqMlRy?=
 =?utf-8?B?SlpVVzAxT3Z6Yi9ERHRKU2lZUzhwZW9aL1ExeEw5ZXJVcUw3ME9QMll2eTlP?=
 =?utf-8?B?SVI3QXlrS1dpMFY3WDQvWVpwMkhPU0hoVEQ5MklKN0NpcU9EWnpLN2R5QjFa?=
 =?utf-8?B?OHFqTUN3aVMySDN0clB0YlU2eHBZTXRJR3NacDc1d1dHK0MrQi85NXJIWkEr?=
 =?utf-8?B?U0dycVJtbVVLQVFCU3k5Tm1aWEh6S01PVTRJY3pLUVovV1cxTnJtZEhvYnB3?=
 =?utf-8?B?TkZZajRIa1IwMHlhVC9iOFpMaTYrZ0JwQlp3NXQ2cDg2YWx0NnA0eHlyT3BE?=
 =?utf-8?B?eWpiUkNUVWRTV2k4VUFsamJhQWZkdmRuWUEyUWtHUUo0U1RXRHhhTEk1L3A0?=
 =?utf-8?B?WDR3Tkh2RTZYUGdtMmxWMWRCUDhteVRGdTU4cytOTUk4c1RoYk9Hd2hIbmpU?=
 =?utf-8?B?SGlUS01RdW5xVG54dnNxR3JqY0lYaFQ2Q2RBMTAzYXNoOExTVlE5T0wzamtP?=
 =?utf-8?B?aFpENTQxN3Q4NzkxQjhOMkNVQzJQZWZxY2w2VUdJanNNV2pyZDA3U1IraEZF?=
 =?utf-8?B?MVY1NlUvZU5CMGY2dURUcWdPUzcrZHBZQjNTV2RCRVY1em9RdEQ1MHdhVWRh?=
 =?utf-8?B?NkcrekZkNXUrS0hVS0I0T1FFWmhySFRUT3RZVDhDeUVYc3k1NTZmYmJHVGNu?=
 =?utf-8?B?WUlMRTZpZ2VBRGRYL253V3h2UjB0ekRIaTZLZEVaUk9BM0pSUmhBemNPWWR1?=
 =?utf-8?B?L3k5YWU0UzVyQkpYay9rYXdRYzlXa2FjdGtUQ3hvZEVYVTNjaWlqNzVRVjMw?=
 =?utf-8?B?QVN1bFFHNXRQbzZCV1ovUkpNRnZseG40b0tOdTFQc2NWVkpEU3gzcXNpa3RL?=
 =?utf-8?B?WkFoK1I3OHhna21qUWRndkVYVDBJSStkWGJQenJSOXRHS2NiUGpzMHJ1QXBh?=
 =?utf-8?B?RVY4Y1Voa1NWeUJRS05OMThjTktmT1huN0ZkTklpUHNJeWVmTGpaa3BSMlJ4?=
 =?utf-8?B?Uk42Nm51clFLKzFtck45ZlN5WDFQV2xDUG5INVRXcjMrVjdwZ3NwelpuYU9L?=
 =?utf-8?B?VVVXU3ZsVDFlelIyTjh0YUd6NVA3MmhnVTB6bk1iOXlCRUp0c0YwVi85LzVn?=
 =?utf-8?B?cStiZU5CdUxQa3pUVDB6TmNqd1VGTUIzdlNlSDAvSUF4VXRPb2tBU1hrdmcy?=
 =?utf-8?B?Umd0Q2k4TUk1VWprOUxJVmRGZnB5NXV2NGlDV3QyS3g2TGxDWjFXTW5PdFBK?=
 =?utf-8?B?czI5Q09iNDBNZlFDekpBUDBDU3RhbVRIdUlGbU5HRG81U2pDMVNobE5TM0g1?=
 =?utf-8?B?a0VENHFBZ2tweWNjdmtYc0dmc2ljdXBXVlRDbWF4Y0VHVU1zOTBZUzlyNmJB?=
 =?utf-8?B?a1REOWxxTFp1RzNmZTVqdVEyMmRUTVN1SkJTeWFBRUZJSDBEaHdqeHNsbCtX?=
 =?utf-8?B?cXJreGNtblJkcU5DbFNVekxJZVJwbkMyRURwSGpvZ2U1bHBaNXQ4SEFrdzJu?=
 =?utf-8?B?a2VqdStpYVErbktocHdnNmlRZTAvaWlYWjY1aXFoSWVaQ3pHUjdOMkhnQmtV?=
 =?utf-8?B?dks3dUFsZk14YXZ3YVA0TFV2R09kcDJSOUVLeVNVSUFXdFZ4M3I5aWM3SnlG?=
 =?utf-8?Q?Jp6Da8MDE0iHkT3yNfbrw7Ifn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb2b5d5-0397-4caa-fddb-08dc3c296ba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 08:59:37.6569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UI6pG1aO4a6mR3r2Eefy9rLVKcp+NLU6vqgaxU6RC/2F+2nwNaqUtCDJvlvZG9iiyu8Pz8N0m8cPLSJ0ht7a/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7115
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIE1hcmNoIDQsIDIwMjQgNDowNyBQTQ0KPiANCj4gT24gMjAyNC8zLzQgMTU6MzYsIFRpYW4s
IEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwu
Y29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMjksIDIwMjQgNTo0NiBQTQ0KPiA+
Pg0KPiA+PiArDQo+ID4+ICsvKg0KPiA+PiArICogQ2FjaGUgaW52YWxpZGF0aW9uIGZvciBjaGFu
Z2VzIHRvIGEgc2NhbGFibGUtbW9kZSBjb250ZXh0IHRhYmxlDQo+ID4+ICsgKiBlbnRyeS4NCj4g
Pj4gKyAqDQo+ID4+ICsgKiBTZWN0aW9uIDYuNS4zLjMgb2YgdGhlIFZULWQgc3BlYzoNCj4gPj4g
KyAqIC0gRGV2aWNlLXNlbGVjdGl2ZSBjb250ZXh0LWNhY2hlIGludmFsaWRhdGlvbjsNCj4gPj4g
KyAqIC0gRG9tYWluLXNlbGVjdGl2ZSBQQVNJRC1jYWNoZSBpbnZhbGlkYXRpb24gdG8gYWZmZWN0
ZWQgZG9tYWlucw0KPiA+PiArICogICAoY2FuIGJlIHNraXBwZWQgaWYgYWxsIFBBU0lEIGVudHJp
ZXMgd2VyZSBub3QtcHJlc2VudCk7DQo+ID4+ICsgKiAtIERvbWFpbi1zZWxlY3RpdmUgSU9UTEIg
aW52YWxpZGF0aW9uIHRvIGFmZmVjdGVkIGRvbWFpbnM7DQo+ID4NCj4gPiB0aGUgc3BlYyB0YWxr
cyBhYm91dCBkb21haW4tc2VsZWN0aXZlIGJ1dCB0aGUgY29kZSBhY3R1YWxseSBkb2VzDQo+ID4g
Z2xvYmFsIGludmFsaWRhdGlvbi4NCj4gDQo+IEkgc2hvdWxkIGhhdmUgaW5jbHVkZWQgdGhlIGZv
bGxvd2luZyBjb21tZW50cyBiZWxvdzoNCj4gDQo+IC8qIEdpdmVuIHRoYXQgd2UgaGF2ZSBubyBp
ZGVhIGFib3V0IHdoaWNoIGRvbWFpbiBJRHMgYW5kIFBBU0lEcyB3ZXJlDQo+ICAgKiB1c2VkIGlu
IHRoZSBwYXNpZCB0YWJsZSwgdXBncmFkZSB0aGVtIHRvIGdsb2JhbCBQQVNJRCBhbmQgSU9UTEIN
Cj4gICAqIGNhY2hlIGludmFsaWRhdGlvbi4gVGhpcyBkb2Vzbid0IGltcGFjdCB0aGUgcGVyZm9y
bWFuY2Ugc2lnbmlmaWNhbnRseQ0KPiAgICogYXMgdGhlIGNsZWFyaW5nIGNvbnRleHQgZW50cnkg
aXMgbm90IGEgY3JpdGljYWwgcGF0aC4NCj4gICAqLw0KPiANCg0KYnV0IHRoZW4gaXQgYWZmZWN0
cyBhbGwgb3RoZXIgcGVyZi1jcml0aWNhbCBwYXRocyB3aGljaCByZWx5IG9uIHRoZSBjYWNoZQ0K
Zm9yIG90aGVyIGRldmljZXMuLi4NCg0KSXQncyBwcmVmZXJhYmxlIHRvIHJlc3RyaWN0IG92ZXJo
ZWFkIHRvIHRoaXMgcmVsZWFzZSBwYXRoIG9ubHkgZS5nLiB3YWxraW5nIA0KdGhlIFBBU0lEIHRh
YmxlIHRvIGlkZW50aWZ5IGFmZmVjdGVkIERJRHMgYW5kIFBBU0lEcyBpbnN0ZWFkIG9mIGV4cGFu
ZGluZw0KdGhlIGltcGFjdCB0byBzeXN0ZW0gd2lkZS4NCg==

