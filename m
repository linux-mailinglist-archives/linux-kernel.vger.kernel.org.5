Return-Path: <linux-kernel+bounces-46946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD648446B3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD5E1C218C7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9696512CDB8;
	Wed, 31 Jan 2024 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOESrvp3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D750912CDAC
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724179; cv=fail; b=ric+qzwzLqgTSLXFeIf0A39pI412lGfBQ+OYYXZyqflUAjPZx28+L0ZzXidmEJYhuGMrc1F3UapnXv/NlCBnzkuW8C6ThzU9DY9tKxBDfwNYGQQ9gfsmpVVvkMzlRz0ezsiQy7Z2g+RUIaw1o52sPfhXCUWxAI5uzLdCvfVIrAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724179; c=relaxed/simple;
	bh=X2QMtoZnKdsDcuNsTKMpRg8QKLBoKCEQ714ZkPDXTF8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cPIlE5+DcDpLGTLgZqN1t+pnu82fgSnHBGSYjBXMCvzzwBw1pSv4rdtTxAs40HbjZRXqiQGHuRUnlhc/zgfjgXLOixTRvR7eMTzHBudT1Cv8cZG+WR+PxxfyIUTJHn/M70AGlTuWd35HGXYyAiMBETYwLfSPa1o3Gl5Z3P6CcAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EOESrvp3; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706724178; x=1738260178;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X2QMtoZnKdsDcuNsTKMpRg8QKLBoKCEQ714ZkPDXTF8=;
  b=EOESrvp3/KT/lG50XEEx/dRfDhbXsGXkUya2mY8rlRxTnHoDzPbUuibY
   ImeViCm7dVmD43Ssuryk1TOCrcZh3iZ0VWjQQ4AnmLNpL8sb3bhDLEEmV
   mXOw53OJEoDVcnydfYmE5yhurupEWAIAeFve/x6JTKKy6KM2iqmjcrdU4
   RqT2nLepsnPL3JuulOZnfDzeBSpeY72jz+CUNTYym9b//5KhaGj5/8rI2
   D5Hc9SFR86XP86lHj9mb9qI4f3tbpiD/jEBQgVTTyIl25moWooAwwnxUI
   f6X74F24iqQt5inudxvUktko79mSfP1uK2HNkOKyiRCrTscfs1xc0W+cf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3519210"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3519210"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 10:02:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="22862301"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 10:02:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 10:02:56 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 10:02:56 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 10:02:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agZD+wM7x6M3LIpk6icb2DgCkGRHZriW5FbqzXrenNTLg0Mc0sLpZp8jBeFomQ93x+7cWrZGe2Ft4SEbapdNOHWxgQl5tLiaBMoT2701+T/wMqpPGMB73jNb509y+SuEs2V4OMCljmeZB/GPSRhurZXAltus4nZGMwaaEVBlOH4Ecsd5QCLpzt7zIaR5bfntj82vFkZq7BXA7C1qQRryKwiRSR5rrqN4nrzhQBHGXb2PUMLmw/TSUtuvt/OQznojRWG2BJNTPhjeFIDUp1Ax+TRpFHNoSgnMQCltHc/EAeK5k0QusO57KCsvS3r/V4+F8/di6iWFaYm32ynIQ/mGgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2QMtoZnKdsDcuNsTKMpRg8QKLBoKCEQ714ZkPDXTF8=;
 b=M08scimUPSEDslClnrg/nGUZ11SuoQtP8WgAlmVv05x12PYkxgDoZUdbwKBpJEWyuaSBCkqlkDi6UpKqRygBWKygJsWugtwA7NqRbSmf6eoVESyvoQwW2C0lEyB5lm/fM6HqoZop/aPsp1IcGKPuS2dgWfosz37PDIoibOhGd1asjWs2Vz+KN41D3bv9Nj5yfiX3qMMtHJs2L/Uw7TNcTAyV+0fT7nXB4kFGReje1i1KORAEK6aJIgjGqaiBhaJ0r3huYM2pnaOLerQRXjzRbKIN1Q5qzF8yS2Yt9+T7BnZ8UuebPZyunhgzXK0BnJ9yejPOm2kbja1//jpYjWz7XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 DS0PR11MB7804.namprd11.prod.outlook.com (2603:10b6:8:f3::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.24; Wed, 31 Jan 2024 18:02:53 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190%3]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 18:02:53 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, Theodore Ts'o <tytso@mit.edu>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>, Sean Christopherson
	<seanjc@google.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
Thread-Topic: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED
 fails
Thread-Index: AQHaU1aXalf71JpekEOiHH1k7Csdk7DyS4oAgAAJSVCAAEjrgIAABNyAgAAErYCAAOk00IAAVWCAgABP0LA=
Date: Wed, 31 Jan 2024 18:02:53 +0000
Message-ID: <DM8PR11MB57503F8ACA76B744E1A61DDCE77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <20240130083007.1876787-2-kirill.shutemov@linux.intel.com>
 <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com>
 <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com>
 <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com>
 <Zbk6h0ogqeInLa_1@redhat.com>
 <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9ps6W5snQrYeNVMFgfhMKFKciky=-UxxGFbAx_RrxSHoA@mail.gmail.com>
In-Reply-To: <CAHmME9ps6W5snQrYeNVMFgfhMKFKciky=-UxxGFbAx_RrxSHoA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|DS0PR11MB7804:EE_
x-ms-office365-filtering-correlation-id: 7164da2f-72d3-4ab4-3795-08dc2286d8d8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gVlN3iN4CQtRRoHQWiNL1Q04zvIQDQUxoBYRSuy1TfC+KEJRRdxxZDEpzeia0WYZbmrUPk830c62Uct1ChZoarWDQZrLVB/e572bhzXeEemZ2IsFF8kd/bVpC4dXTakDn4TTivMvfTWclymUBcd9F7sgVKgvBleeguDghVtV/A+jhzBnZ1z3d7LYrvjzHswdV6E8ltQWxWvm0fHqdDTea2GeVUBUEqkopT7u0k9Ml4ouqRkASiXQy/D/TQb9CGJR4vqR8ra3XPhrDPg2Mz27srBzgsjKfMS56noUE8ycZbFfUJ2CTz/KORsryhZ6Ao5Yo+n0WK5pwU6ldfP8jkgeOeJFKr9opmdD0BcPCFFw2by6b7E8/s+eDPaG2yDyqhpbOJFBdxrzqlz7JZ3c80bAG6ORP/9cjxvI0dTDS0JFrF3UzjdePCTYQ4sl/QF3TOAFm/DPjr3b18Qx4yAV2YEMvmhwjA7jnc0wyZCO65ARAvwDK1h7/1haM3GyA2ccETM9oHxQa17fk8SZeW7izuPjLjG2f4HaroH+Ildtg0fNt1GaivPfQUXjS5W28FuF1edm2oVPGn+s2ZLVvG6dSbi2QB5kLWFIaecTNOuUdZf65xLWO3Igau300l/5daXuB3KTrx2G91P2JgSlJvB9c0UZ8topzC8UvDvxLeFBHyaA4n4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(230173577357003)(230922051799003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(41300700001)(38100700002)(26005)(9686003)(122000001)(8676002)(52536014)(5660300002)(4326008)(7416002)(8936002)(2906002)(478600001)(53546011)(6506007)(66946007)(71200400001)(54906003)(64756008)(66446008)(66476007)(66556008)(7696005)(6916009)(316002)(76116006)(38070700009)(86362001)(82960400001)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVk1VEJGb3JsTW5DQSt6SFJkejBaM21oNlBZQVhYNko0bzVBaUhKckVuVTVO?=
 =?utf-8?B?cVlpWFpweWVoUWxqaGlsZDNyM1FhTTZLcWRZL1A1c0VuMUdSWGFENVZyM2Rh?=
 =?utf-8?B?WG02bkt4Sm55Z0lRQ2lyU2VPVHV0bU55V2s2Z24vcWJydStMeThxNnc1K3pD?=
 =?utf-8?B?YnlrbFFGRUZoNjRBdXp6RGg3aUNtSEJPczBTTk91TzJHK04reVpLWnlVUG5i?=
 =?utf-8?B?dlVHalFvSDEzeDNhOFlCZnVmcUV2aElOVDhtRzJoWjVJV0pQQ1VQUGNWOVpY?=
 =?utf-8?B?SlJMRzFVc3RYUktiV3hlR2ZlY2VqTnFBbmJnNktXOGJabmdEK01WSzExVnV4?=
 =?utf-8?B?Q3VzeFpnMHlTbUZnVzVkejB0ZEQ2S0Z6c3VXRDBqUmI0MnV6MkdVbjIwQ3kw?=
 =?utf-8?B?RXBzV0ZJTHFsY3hkQ2xGb25IdFhVWCs0bGYrZ3JrZlpEVStPUnI0Ujk3dmtL?=
 =?utf-8?B?eXlCQ3NYTHc3OEF4WjFuWGVLMkF3QldsT0RIUi9iY1BvOGp2clpLYzFxaXBF?=
 =?utf-8?B?ajJiVXpBV2ZTeWF2Ynp5czlaYU5DVU1YR0gxVVBZcWlKSVRNcjFzWEdoaE13?=
 =?utf-8?B?a2x6Q2Q2OFY3Z0NYa2h5cnBvM3lpa1pBWS9tVVBvOVJxNEk5eFc0QWtiYXVs?=
 =?utf-8?B?YlNkMFExcUlzR2QrQ01yeDllNVRtUDRzcGNQR3NFc2pLVm9VbTlGWWxXQ3Ro?=
 =?utf-8?B?eXcxN1NHMUQxVjJSSXRTR3lXWHR2dG96VDR6L0tHaUQ0eGZCRm5qTDUxdEFO?=
 =?utf-8?B?djRTUXE4NU96WEF4OEZVMXVrZ3VndEp6a2lIMDA0UWN0Nzgya1FhUisyd0Jo?=
 =?utf-8?B?cFo4NkZpOWFjcWFuZkswNHM2NFEzZEV5MUNhZXU0NVBlaFVtZ2M5ZEJUelUr?=
 =?utf-8?B?QVNsazNIanJVOEVDOUVRUHNmSkpNaVdZTkZnd1N0bHNYK29uMEl1bjNzcS9F?=
 =?utf-8?B?MFFaZXBMRGV3NXYvZ1E3U0lqb0MybENhbjNicE14ZkJ6NUdmYlJyQ3JlZWRR?=
 =?utf-8?B?QlF1MWJJeWFNSTZ6cDJxVy9wTlk1YmMzQjVhWWJPNzU5S1dpSjY5ZG1qeGlw?=
 =?utf-8?B?bWp6RGROR2pHc3JKVXlyeGh4eFpxNDdiQnZyb0IxbHdJRkx2VlJNejlKcTRU?=
 =?utf-8?B?YmZWSkYreEJONlJZaEMwQ0JTYi9ZN0Jqc200TkRYVjBMMGRqTHEvaGVYSzhX?=
 =?utf-8?B?VzBKUDEwdkFyZmxGSk92akpza0NVZyt2VVNxSXdhR0ZSZjNBTXN1bWoxTk1q?=
 =?utf-8?B?UzJQMkRuN054VGExWVFoRHIzZzdFSFY0TlhEWkVmNFRoVDcxbEkvelpNV2xH?=
 =?utf-8?B?VjQ0S2t1OXhsb3UvaUJtekhSWi95Z2ZGRHFLV29hUkVnNmZiWTBpTVl5MGR3?=
 =?utf-8?B?SlBpc2hENXMyT2NieTl4NjNoOGtjU3doc3lGeHZobTdSaUxKMDdlYkpnTEZZ?=
 =?utf-8?B?aUl3dGRRVHlCSzhpTVZpbnVLMVFlZVBPaWZKaHRSSFYzWkFRQzFRWG1XMFc1?=
 =?utf-8?B?MjZjYXdDd3hYK0hyVHhZVXZZeG9UbDBqc1N5V1ozUVFSazdzelArUlpzNldU?=
 =?utf-8?B?WmJsdTFwMDhtckVVNlJhZkt0Y2Z6angxbW44eWlNd21mL0NZK3F2SitHTXU1?=
 =?utf-8?B?WENGaWJ4MXFkcnR5ZDUxS1lLK3JrdGNtdk5yNUJ0Y3RxTWovR2xtdmJydHdM?=
 =?utf-8?B?STFRRWhFSWNqWUxlVktTbC9SYVJkbkVjVmp2QTJyaGxsZk9HOFprUkVXSmls?=
 =?utf-8?B?RGNvNER1azZNcGVzWmtBZlcxaXRaUmsvZXJBVW9mUWxkWDdLdUZBYWUzMDVw?=
 =?utf-8?B?U1J0SnhpWWFwOG1UbWxVdHVVQmZ1WmEzb291RWl0T1BNNWpCcno4YUF1c1JG?=
 =?utf-8?B?a1BKaDdZcTY4N1JIZVVUbFNwN2RnSzlUbE5tUmdxVXNxekJJWC9pYnphbi9Z?=
 =?utf-8?B?U3VVNGhuL2YwNnQvME1CMDJpalVXRGxyWHhYUElJeXEvU1k3enJNT3pkZVVB?=
 =?utf-8?B?MlhydG56SVJEUlJQTGl4enhVd29TRUhOZWQybEc0U09oRU1FY1puaThUT1Uy?=
 =?utf-8?B?Q01JWXg0cFJWUTBTQzBaa2dVN1pQVlpmU3JOZlVUWWdtTndNeXF1b3lXdUxO?=
 =?utf-8?Q?zT+lUzeTmYqxe/C7ItA4jJzam?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7164da2f-72d3-4ab4-3795-08dc2286d8d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 18:02:53.8476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bn2Hin0x5tCjXkbE7O+8vbY5dByIMrZJVRtEcCxbR7QjZcXprLkNGnix2LRkB/PobHwzYZ9J77zOTAhwBbR1Qf3aqdgtFWV+crtpnayDX2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7804
X-OriginatorOrg: intel.com

PiBPbiBXZWQsIEphbiAzMSwgMjAyNCBhdCA5OjE34oCvQU0gUmVzaGV0b3ZhLCBFbGVuYQ0KPiA8
ZWxlbmEucmVzaGV0b3ZhQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gVGhpcyBtYXRjaGVzIGJvdGgg
bXkgdW5kZXJzdGFuZGluZyAoSSBkbyBoYXZlIGNyeXB0b2dyYXBoeSBiYWNrZ3JvdW5kDQo+ID4g
YW5kIHVuZGVyc3RhbmRpbmcgaG93IGNyeXB0b2dyYXBoaWMgUk5HcyB3b3JrKQ0KPiA+IGFuZCBv
ZmZpY2lhbCBwdWJsaWMgZG9jcyB0aGF0IEludGVsIHB1Ymxpc2hlZCBvbiB0aGlzIG1hdHRlci4N
Cj4gPiBHaXZlbiB0aGF0IHRoZSBwaHlzaWNhbCBlbnRyb3B5IHNvdXJjZSBpcyBsaW1pdGVkIGFu
eWhvdywgYW5kIGJ5IGdpdmluZw0KPiA+IGVub3VnaCBwcmVzc3VyZSBvbiB0aGUgd2hvbGUgY29u
c3RydWN0aW9uIHlvdSBzaG91bGQgYmUgYWJsZSB0bw0KPiA+IG1ha2UgUkRSQU5EIGZhaWwgYmVj
YXVzZSBpZiB0aGUgaW50ZXJtZWRpYXRlIEFFUy1DQkMgTUFDIGV4dHJhY3Rvci8NCj4gPiBjb25k
aXRpb25lciBpcyBub3QgZ2V0dGluZyBpdHMgbWluIGVudHJvcHkgaW5wdXQgcmF0ZSwgaXQgd29u
dA0KPiA+IHByb2R1Y2UgYSBwcm9wZXIgc2VlZCBmb3IgQUVTIENUUiBEUkJHLg0KPiA+IE9mIGNv
dXJzZSBleGFjdCBkZXRhaWxzL251bWJlcnMgY2FuIHdhcnkgYmV0d2VlbiBkaWZmZXJlbnQgZ2Vu
ZXJhdGlvbnMgb2YNCj4gPiBJbnRlbCBEUk5HIGltcGxlbWVudGF0aW9uLCBhbmQgdGhlIHBsYXRm
b3JtcyB3aGVyZSBpdCBpcyBydW5uaW5nIG9uLA0KPiA+IHNvIGJlIGNhcmVmdWwgdG8gc3RpY2tp
bmcgdG8gY29uY3JldGUgbnVtYmVycy4NCj4gDQo+IEFscmlnaHQsIHNvIFJEUkFORCBpcyBub3Qg
cmVsaWFibGUuIA0KDQpDb3JyZWN0aW9uIGhlcmU6ICIuLi4gbm90IHJlbGlhYmxlICppbiB0aGVv
cnkqIi4gQmVjYXVzZSBpbiBwcmFjdGljZSBpdA0KYWxsIGRlcGVuZHMgb24gYW1vdW50IG9mIHBy
ZXNzdXJlIHlvdSBhcmUgYWJsZSB0byBwdXQgb24gdGhlIG92ZXJhbGwgDQpjb25zdHJ1Y3Rpb24s
IHdoaWNoIGdvZXMgaW50byBjb25jcmV0ZSBudW1iZXJzIEkgd2FybmVkIGFib3V0Lg0KVGhhdCB3
b3VsZCBkZXBlbmQgb24gdGhlIG51bWJlciBvZiBhdmFpbGFibGUgY29yZXMsIGFuZCBzb21lIG90
aGVyDQpwbGF0Zm9ybSBzcGVjaWZpYyBmYWN0b3JzLiBJIHdpbGwgd29yayBvbiBnZXR0aW5nIHRo
aXMgY2xhcmlmaWVkIGV4dGVybmFsbHkNCnNvIHRoYXQgdGhlcmUgaXMgbm8gY29uZnVzaW9uLiAN
Cg0KDQpUaGUgcXVlc3Rpb24gZm9yIHVzIG5vdyBpczogZG8gd2UNCj4gd2FudCBSRFJBTkQgdW5y
ZWxpYWJpbGl0eSB0byB0cmFuc2xhdGUgdG8gYW5vdGhlciBmb3JtIG9mDQo+IHVucmVsaWFiaWxp
dHkgZWxzZXdoZXJlLCBlLmcuIERvUy9pbmZpbml0ZWxvb3AvbGF0ZW5jeS9XQVJOX09OKCk/IE9y
DQo+IHdvdWxkIGl0IGJlIGJldHRlciB0byBkZWNsYXJlIHRoZSBoYXJkd2FyZSBzaW1wbHkgYnJv
a2VuIGFuZCBhc2sgSW50ZWwNCj4gdG8gZml4IGl0PyAoSSBkb24ndCBrbm93IHRoZSBhbnN3ZXIg
dG8gdGhhdCBxdWVzdGlvbi4pDQo+IA0KPiA+IFRoYXQgc2FpZCwgSSBoYXZlIHRha2VuIGFuIEFS
IHRvIGZvbGxvdyB1cCBpbnRlcm5hbGx5IG9uIHdoYXQgY2FuIGJlIGRvbmUNCj4gPiB0byBpbXBy
b3ZlIG91ciBzaXR1YXRpb24gd2l0aCBSRFJBTkQvUkRTRUVELg0KPiANCj4gU3BlY2lmeWluZyB0
aGlzIGlzIGFuIGludGVyZXN0aW5nIHF1ZXN0aW9uLiBXaGF0IGV4YWN0bHkgbWlnaHQgb3VyDQo+
IHJlcXVpcmVtZW50cyBiZSBmb3IgYSAibm9uLWJyb2tlbiIgUkRSQU5EPyBJdCBzZWVtcyBsaWtl
IHdlIGhhdmUgdHdvDQo+IGJhc2ljIG9uZXM6DQo+IA0KPiAtIE9uZSBWTVggKG9yIGhvc3QpIGNv
bnRleHQgY2FuJ3QgRG9TIGFub3RoZXIgb25lLg0KPiAtIFJpbmcgMyBjYW4ndCBEb1MgcmluZyAw
Lg0KPiANCj4gSSBkb24ndCBrbm93IHdoZXRoZXIgdGhhdCdkIGJlIGltcGxlbWVudGVkIHdpdGgg
Y29udGV4dC10aWVkIHJhdGUNCj4gbGltaXRpbmcgb3IgbW9yZSBzdGF0ZSBvciB3aGF0LiBCdXQg
SSB0aGluaywgc2hvcnQgb2YganVzdCBtYWtpbmcNCj4gUkRSQU5EIG5ldmVyIGZhaWwsIHRoYXQn
cyBiYXNpY2FsbHkgd2hhdCdzIG5lZWRlZC4NCg0KSSBhZ3JlZS4NCg0KQmVzdCBSZWdhcmRzLA0K
RWxlbmEuDQoNCj4gDQo+IEphc29uDQo=

