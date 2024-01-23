Return-Path: <linux-kernel+bounces-34667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304A88385E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1831F25A0B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2640217FE;
	Tue, 23 Jan 2024 03:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="izcxOmOu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46AA7F4;
	Tue, 23 Jan 2024 03:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705979156; cv=fail; b=NKvUTBiGl9oHQt8MA7kF/MHMm9KAGjge2110aFobPKcogNWg3Fpvf73WHCY3TycEiZMMuLr/BV7Q7uLGVQfkg2mbKCEJvPvnfJepXt2jWQ1rKO7t8IyMAdsqvN64fGPlaZbQLrbHESL1rOnG91kumwZHEJVWKr3FlkccFgKI1AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705979156; c=relaxed/simple;
	bh=J5At8hmIYzc9FSushAInhXQ2u1PIbwEAnIeHw+VdVEI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OrGZYrEQ8pkzK8l45Z3PfCFQFQbumahpg5c0F+wowWiAgQloiAtZ07hFetkv2qYOcmY8j9DvHGUGO1PZPkCvL4QlVjw9LCtyff2Vs5V7yUWs+QDZmhNSli4T+rhmF1tVJXlUu+ry/d0uEBb0HVmfGKN4X1qH3xCx/bNfZUnp1FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=izcxOmOu; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705979155; x=1737515155;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J5At8hmIYzc9FSushAInhXQ2u1PIbwEAnIeHw+VdVEI=;
  b=izcxOmOuH78scpWNZ9gUVCEft914p2bMiUbrEFIpmyl/L5hpCVE/PgTb
   ypBn3rA4HgkaZxjJ3zrCliOhIGVIz2Yn0P1Yfu13Fxz615SVAHWW4dxfw
   kK2tHlb+BLRGV5VZ0fhe0W8jbn3xPXXEv910gbhNjZuQyTmrgp6kyvY2O
   qReMPiA0HX98Birr39qKM/gi05dPEdPQaBzzUxqUHJsAADC7ANACuk5si
   rDxyAk3jy1Ex4tm0201Iqf0i7OWpyEYvXo2mQ4gcLWLnUQ8kRmfIToSqJ
   O7+9LSQkTJ1HSYEKNYLxawXFNFr3tMVrH/dObomQbRRIDyUVM/kVFU/+m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8793469"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="8793469"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 19:05:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="876190683"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="876190683"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 19:05:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 19:05:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 19:05:52 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 19:05:52 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 19:05:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6FOV1lGeUj8kK2vihtcUyMXwu5lCtFWUPFiRqUJwt9Hi5h4CghnzMLCnfTAwJVubhD+ege08bzxvfvEuenGqOSvO5u/qv9lbmmUxD0pLbADK+Ubg7mZNB1PbpuJJFlcwBEeCRLwcPIJBlJBZS2RkKG/0PDXLiifH+gAzETOLIx3FH8VlKEc48lx+65QkcOOoBIiKfosykBsO8DK0svfy/Hf61Xrp2WnNDRhMav4mKupIYycMyfVSezWyBWR1QnEEvEO6RAJ3NVW2Yadv/Sa7GS7qfjtuz/30Nluu/sKcwlpoaXOutN/B0DThLFK/Wc+u4/nMeDuiG3qkxiiBRvhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5At8hmIYzc9FSushAInhXQ2u1PIbwEAnIeHw+VdVEI=;
 b=Nr6pVr/QIdrVVIoxj1Ot7CAt88g5Fk/7uZ13krlEGGte8Al3KoWlo773wjIdxD51eqKssHOO5m7FLR+ND6Y3OX+3khkPRYaUHCD906BulNSJcF/EAsLjRMmwftBKInIZ+sC8Aa/aYmMEw7deatJYs/aDCPR0IKTXH1DX0GWf5rmurym2fl8GJqlLlpr/HCJXpChNzj1Ki1xi8sfnHpdKlP3snagYexVtpN9zwdHGeD+wqEMI0fSH9pE31mLCK9MzafVAuuUKNSQBXtNBAk13EbyMLLzGBfCGZvIKBd+VNOumqHrCoqO6P5Kv0poOyvFaz2DHJ6rmyo5cVM1YA74EYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5370.namprd11.prod.outlook.com (2603:10b6:408:11b::8)
 by SJ0PR11MB5664.namprd11.prod.outlook.com (2603:10b6:a03:37f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 03:05:50 +0000
Received: from BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::3d32:2de7:4924:4f2f]) by BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::3d32:2de7:4924:4f2f%5]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 03:05:50 +0000
From: "Chang, Junxiao" <junxiao.chang@intel.com>
To: John Ogness <john.ogness@linutronix.de>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Hao3" <hao3.li@intel.com>, "Li, Lili"
	<lili.li@intel.com>, "Gao, Jianfeng" <jianfeng.gao@intel.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: RE: [PATCH] printk: nbcon: check uart port is nbcon or not in
 nbcon_release
Thread-Topic: [PATCH] printk: nbcon: check uart port is nbcon or not in
 nbcon_release
Thread-Index: AQHaSUsQPOEPGbcL0EW3fk+6PubLv7Dmvu2A
Date: Tue, 23 Jan 2024 03:05:49 +0000
Message-ID: <BN9PR11MB5370AED9C562F9DA75093557EC742@BN9PR11MB5370.namprd11.prod.outlook.com>
References: <20240117065226.4166127-1-junxiao.chang@intel.com>
 <871qagtlk2.fsf@jogness.linutronix.de>
 <BN9PR11MB5370065F4E7443FEA156347EEC722@BN9PR11MB5370.namprd11.prod.outlook.com>
 <87y1cos2dv.fsf@jogness.linutronix.de>
 <20240117102446.itexUYMc@linutronix.de>
 <BN9PR11MB53709FD2BC70878B49059107EC722@BN9PR11MB5370.namprd11.prod.outlook.com>
 <87r0igrs8r.fsf@jogness.linutronix.de>
In-Reply-To: <87r0igrs8r.fsf@jogness.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5370:EE_|SJ0PR11MB5664:EE_
x-ms-office365-filtering-correlation-id: d91b41e0-94af-46c6-6842-08dc1bc033ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kH/kxfzMy1stV65hdTl2xx2JvBPMNnvAIQQ1v1ZpAfUSWAUGWci1nKPLTZJRPo8YKVQixK0MX/nruUHoo5BkPvzRjIpfKjTY5PurMhHrhxiqmZDuUquGiOjSvIH3qj+d8glL8nE9wSCwO2RqHg/8Jn6IgxWNvH/qGwZnk+9n3i+EbH7SUTSoQizDeXEaV9fz68GH9ZKzBGJrZq1vmHmMtAM0ViFNfsRjRNlJwehclZ8hKxQ05OJjmcih3iP8yJV/HL8MF0BRMDN9Xm+gUKtKfyjflQOH1x0kgtJWFPCue8ol2IlofJ1lo3SESzJ3kcQP0sSKd/363wECXzYyV5voIsLhE9mLnZVEEckyQ80TNbKUCC6dlr98jn3bJa0zbvHXTUkHEX1k65oSSuwmfWqOMHm2hGMUlXf5+SE8KdTnaEI7pt7USZmRcbLWID6lUWNjXp9Kw+siWYFPf3VPshdkc5ucnc+yUev3exRxoADBvdTpOnNkxBJ/jzuMy3ypoUD2eTAGVjYEjchdLdUDoVcdbd/CTsYP/M9LcM4VCDOJMV6BVobGm1+Q4hiUQAHbkvQ1LH00hykviHvMMR7pB+GhAhdn5Kqn4j1jxWuA2S2H82w8CyIKXatTk2LW0p/V3Qte
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(8676002)(8936002)(4326008)(52536014)(33656002)(4744005)(2906002)(5660300002)(38070700009)(41300700001)(26005)(9686003)(83380400001)(55016003)(478600001)(6506007)(7696005)(71200400001)(122000001)(82960400001)(38100700002)(66946007)(76116006)(66556008)(110136005)(86362001)(66476007)(316002)(54906003)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnZFZzJ3WGhvbmZHd1RwanhrYWUyQlRMTWJZRUwrVEFQdGRuMFpBK1E2ZVU4?=
 =?utf-8?B?RytwZCtXbHFOdjFHYlJXclRxN0NUZUpWOVdTVnBHRVBjaTQxZlRUWm11UjhC?=
 =?utf-8?B?OGpDT3ZVbzNnY2ZndVpoOGdEK0ZrNWY2N0FVbXZyVGpEMUFSSU5EZDhEOHNy?=
 =?utf-8?B?WFgvMldyRkZwMkpFeURteFlpYTRLTDZJNzNWY2VGUmhhTktFM283S3FOQUhG?=
 =?utf-8?B?cjBJVUlhdGVGWFNqcEZqdHlCQlhHRkZvazhIL2RNblAvczkrYmpyMThXME9w?=
 =?utf-8?B?MHRMUDVZSVpiMUdJd2creUEzVjAzeDYzL1Fldy9Za0k5dkhFL21UbmVxcTdC?=
 =?utf-8?B?MWk0a3cwTkZBZ040TmVya05YNFl5WVZJclkyUjBQTE42VTVObVFWenB4bkc5?=
 =?utf-8?B?cERCaDg0NE05ZWRRNFRNVUxKNUQ4VzJaWGxENzFFV1QrQWNMV3B0WEJlSG8r?=
 =?utf-8?B?ZU8vUWFIeHB4WkNsZHI3ZlR4eXg2QWU3RlVoRG5rN243bGVBRU1KUTUvQTdT?=
 =?utf-8?B?NWg0MDhqWjZNOFBCNForTVEvQkthL2s4dEJpNm9ldm1MYkZiRDJLM3RBK01Y?=
 =?utf-8?B?MEx6cENaMUlHRHdiZS9tSUFZVDd3UUoyQkZsZG5icllwTVN0V2M5T2JHQVh2?=
 =?utf-8?B?TE9qTUVONXU5cHMzZUhYRDd1UlZPR1FVb29Od09iZEUydjNZMEgrb05HT21G?=
 =?utf-8?B?WnM1aUdFVTduWTJPOE1uaDhYeCtlc1hSNlNMclVwQlp2STVmbS9BY2dpdlJ1?=
 =?utf-8?B?VENrWlBkdFhhN1RFWDNJTEZ3M210NUdvRkY2L3NjRlM0a2dGU0czb2ozVmJ5?=
 =?utf-8?B?NENscWdqVm14MFFjNEVQYUJPZERCcU50Z3NqL3EyT0VBa3lPLzNUMVZ2T3NQ?=
 =?utf-8?B?ZUtNZnJMazhBTmlXMmd6ZUhLRkFMYzQ2QjFkSnAvOHQyUzlqZE1hckFvMGdx?=
 =?utf-8?B?ajluUnNub0xoUW9RWlJCZ1Rwc1Y4YkNaOW9iakJpUFV3cXBBeUd0azE5OTFO?=
 =?utf-8?B?OHFyb1FXL0lyWmM4VjB6b3pLOTNyTWJMRnNKd2NaYlQxeXlYcXN4NjBWeTVN?=
 =?utf-8?B?ZHpoNVRWdHdHRXhncjJ1STBlV0pQRDc5d1hxU1FDTnFBWXY1WDZDS2gwSzBv?=
 =?utf-8?B?c1VGV3k3cDNIdjRJaHdUNlpIZHpEeWVMMi9mWlBJb1VZVXlrWUlNUzAxc1Nj?=
 =?utf-8?B?UEQ4UHZIMUp5ZEpVSzdVcFJicVEraFFWUFhnZitaelh4WWVTRmcwYmUvN3lp?=
 =?utf-8?B?KzlXZC9YTkIrckNNVnRkZ0dyclRzM2JyWXArb2REaWl0U2RhM3dIbWJjNElD?=
 =?utf-8?B?eUJlRWwrcXRaQngvaFp4R25QVnR6MEcyL2lKQWFSdDR6L2JOem9xTk84ZUI4?=
 =?utf-8?B?YUE5c1NpalJERUEvYmIvVmkwUDBlWVE2TFRmRVZreUNLZXcrUGtmaGZsbytp?=
 =?utf-8?B?QlZQaG5ZWkFhUG5SaUFwRFVGLzEzQjdmc3hDb2ZVSlNyT3R0M25WQkRPWFBG?=
 =?utf-8?B?SEY4QzQrcERlNlpzZHlmRFBpcTBzN0tLR2FoTzIrRWR4UWhtQ1NkVWgzdW92?=
 =?utf-8?B?OTNNZUI0MTQwTG9wME9PSUVxTDFWT3JreEJmOXpXUUszZ1FQb3ZiT1JYNXZa?=
 =?utf-8?B?aitxOHZnMjRHUzRnWENrODNHM2R4S1dQL0xJWlp2bm42cDF1clVScko0Q2Ju?=
 =?utf-8?B?VFI1Vmp4elIzbFFsZlNRZU1mMkNRRkhMMXNEMWREaTEvNFY3RWdaNzYrT3ZE?=
 =?utf-8?B?aHhmd0g4R0dTdVpYSEFCWkdMNGZtamNGS0trdlA5eU0yTk5YaUtpTFNNaUhW?=
 =?utf-8?B?ZUplZ0JZWHB0ZjdQejV5YVRjQVFwdWFldDZkMjFrcnFINjRXQVV5U0tlb3Fk?=
 =?utf-8?B?NkNKR0xvclpTSENZZWx5Q2h5M1QxNFdTQ0hwRTVpYlNBdnQ1WDFZN044c2k1?=
 =?utf-8?B?L0tPc2s4cFpYeHVmTDZINWxHcENuT3hrTVFXMEJQWDRJM1lqMGhmcGhNUlEx?=
 =?utf-8?B?aHVOR1Y0ejNIbjhmNzdBaTJhWVhqR3Q4Mlo5QUZUMXlyNTlxZlh4eEVWQld6?=
 =?utf-8?B?QkEvdHNlOTFvTGhJM3FuZ3hJMjBJWHI3M2ZsRW9HYjUyTmRPZ2xubk5jZVV1?=
 =?utf-8?Q?75RhqjTlq734VuY4fN0xYN6cR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d91b41e0-94af-46c6-6842-08dc1bc033ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 03:05:49.9289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 62dpOxJXPbq21Q0r05xBOgWfYLzY+S80giOODMn4xQIjiDR9ABNJzAjHNWw3+UxEjrliLJS7MEv2LjodhH85Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5664
X-OriginatorOrg: intel.com

WW91ciBpZGVhIG1ha2VzIHNlbnNlLiBXZSB0cmllZCB0byBpbXBsZW1lbnQgYSBuZXcgcGF0Y2gg
YWNjb3JkaW5nIHRvIHlvdXIgaWRlYSwgaXQgY291bGQgZml4IG91ciBib290aW5nIGhhbmcgcHJv
YmxlbS4gV2Ugd2lsbCBwdXNoIHBhdGNoIGZvciByZXZpZXcgc29vbi4gQlRXLCBpdCBpcyBiZXR0
ZXIgdG8gaGF2ZSAiIHVhcnRfaXNfbmJjb24gIiBjaGVja2luZyBpbiBuYmNvbl9yZWxlYXNlIGFz
IHdlbGwgYXMgaXQgaW4gbmJjb25fYWNxdWlyZS4g8J+YiiBUd28gcGF0Y2hlcyB3aWxsIGJlIHB1
c2hlZCB0b2dldGhlciBmb3IgcmV2aWV3Lg0KDQo+IFdlIGNvdWxkIG1vdmUgdGhlIEBsb2NrZWRf
cG9ydCBmbGFnIHRvIHRoZSBzdHJ1Y3QgdWFydF9wb3J0LiAoUHJvYmFibHkgcmVuYW1pbmcgaXQg
dG8gQG5iY29uX2xvY2tlZF9wb3J0LikgSSB0aGluayB0aGF0IHdvdWxkIGJlIHRoZSBhcHByb3By
aWF0ZSBmaXguDQoNCj4gSm9obg0K

