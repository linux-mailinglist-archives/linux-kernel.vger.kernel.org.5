Return-Path: <linux-kernel+bounces-34584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4B88381BD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5E51F2574C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736FB6775C;
	Tue, 23 Jan 2024 01:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNUGTM+z"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C975A0F0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972939; cv=fail; b=NVkM/QUQX8aG4t+Iv+KXtn6wTLEjoM0S3b0fqO06XOmMOTMqu4pPKZjl1EAeOhwETnlqyzJiWyizRu+L+Ochfld9Z5S3Fypn58XY6C1KKEm8Cc1Qxs86pjjbxQdSMKZQswKB263jdDyCw8LRvViBJvQHXT8uVWho6eSkAEnPcsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972939; c=relaxed/simple;
	bh=3Lo31HynNVtNpsOA4ROKpJlP1q9jx3Xs0nRh90mAiDc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rg/BVm5GwrBnjSyy2ae+85ED6LQ3QjnNRMMvlEXwfpWSO0tpGUdRIorgr2AHglbEgullDcTH+31xO10VCGGElU+gimDI/vDmveqHLyhh/TGqZQCh0xScvtpCGNfFCumdl5h+0Gi/Xwkpw7oCba1kafTUKqt4XnEqOiKCUUWlzSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNUGTM+z; arc=fail smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705972937; x=1737508937;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3Lo31HynNVtNpsOA4ROKpJlP1q9jx3Xs0nRh90mAiDc=;
  b=dNUGTM+zoC9rn4TD+t2twApli3+KIgkjFCl6bya2JBOH2tcY2VT8g6wR
   qk7G6f3a3LiEUt8BuEz8JoLHEcbPm5y8SROJmqj8C2eNrExPoj1fWychj
   vc00v5yzO6f0q65dU4mCyxNI/Xe/x9+m3liiRu5cHwutU372Zt+tCjrsY
   /waGkkKeX1kdSE0kv4ViacMLPhMVb2yVt2u03hZBOfeMOSpIbiCZXAY+a
   xUOBcAPgADjgvPIEZc4ec04gEdiMzzHUoTeS17bw1N5VKFVxqBEGvsLIy
   tpdnNZOL0hsnbezwMbiCUmbe2H3rtGstBPk9CNQgAIFDlXVzqB0HpLh6V
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="398528068"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="398528068"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 17:22:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="856139994"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="856139994"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 17:22:16 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 17:22:15 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 17:22:15 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 17:22:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bI3U7JwPxwVD4/51FpxESoJ82g70+EVi7s5f/8/+nJNh4s0oltcqE0sBEVgAJHfD2O+xoB8zRJAQK2AcObTxcOklrBIxfc4ZtrYztky/k9eMHlpvk8LpJbdcJlJzq5JgGihuwGBIA74vaL202Tab5Y5AP0X4LTjMZ+yAlse1xZ++6dJWKaP7XZ6R28OBNtly2jEd/tOf3nOLV6JlG8hJV/rULSGcUpKA8F3AiRqq2q9No6kjR9FbjOOMf1I5LFdYz6039k6WDZ2abXrD3TcOddbCQnZiBGXc6o6hKQllzX/QWN4p8SCqhpb6b+IlwQtFDk+kSOGWBxLClnlSBJtSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Lo31HynNVtNpsOA4ROKpJlP1q9jx3Xs0nRh90mAiDc=;
 b=bGyRTVMHwpc7RozXUjMYGA1911WlskxgmIUTNAg9uc1swEQfZ42j4nfA2TBU5OA3tBSEmJEk7kWqcFvEPp5AZ2geWicyMeAfQc76zsRA6Zl2VfCv96axjdayMJg2qEHg+6rU4PGiYrH28bYxnWD99zpKswZv7EcZxgz4JIXpW4AKqVuFnDSmtVphvSnzvM7iP1JSJqUBGRvB7H7mbZy8BC9hWa/U4uIROfSUULPrjjt2ztqc9+vZh7ENEWPH87F8CphCCUqsOrF4zAJFV2YuGcgCdsXYl/nHa7n/7NVy/eVP7+6Co7LW25SDhiTYQvw8h16kT9EIs2liliywIYV/cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14)
 by PH7PR11MB7552.namprd11.prod.outlook.com (2603:10b6:510:26a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Tue, 23 Jan
 2024 01:22:07 +0000
Received: from MW4PR11MB5872.namprd11.prod.outlook.com
 ([fe80::92a7:f6a2:9262:d150]) by MW4PR11MB5872.namprd11.prod.outlook.com
 ([fe80::92a7:f6a2:9262:d150%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 01:22:07 +0000
From: "Yao, Jiewen" <jiewen.yao@intel.com>
To: "Xing, Cedric" <cedric.xing@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, Qinkun Bao <qinkun@google.com>, Samuel Ortiz
	<sameo@rivosinc.com>, "Lu, Ken" <ken.lu@intel.com>
CC: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yao, Jiewen"
	<jiewen.yao@intel.com>
Subject: RE: [RFC PATCH v1 3/4] tsm: Allow for mapping RTMRs to TCG TPM PCRs
Thread-Topic: [RFC PATCH v1 3/4] tsm: Allow for mapping RTMRs to TCG TPM PCRs
Thread-Index: AQHaTNiWmK5wNKvZgEmrjpBk25Oo5LDlF8EAgAEsrQCAAB40AIAANpUg
Date: Tue, 23 Jan 2024 01:22:07 +0000
Message-ID: <MW4PR11MB587206CAE997B3FD894A43A58C742@MW4PR11MB5872.namprd11.prod.outlook.com>
References: <20240114223532.290550-1-sameo@rivosinc.com>
 <20240114223532.290550-4-sameo@rivosinc.com>
 <1bbf8d3e-aa94-48c7-a1e4-76f9eefc4af7@linux.intel.com>
 <65a72c305291f_3b8e29484@dwillia2-xfh.jf.intel.com.notmuch>
 <5539c533-37b2-4b12-a5c5-056881cf8e3c@linux.intel.com>
 <Za1G9I+tYuIL9ser@vermeer> <CF3D8DE1-AD47-4A77-B8BD-8A12A6F7E9DB@google.com>
 <MW4PR11MB5872F46A2089C8C2D8EF7A008C752@MW4PR11MB5872.namprd11.prod.outlook.com>
 <65aecbbce09dd_107423294b7@dwillia2-xfh.jf.intel.com.notmuch>
 <c3b99264-233b-4997-9e20-c4c2693b8cdc@intel.com>
In-Reply-To: <c3b99264-233b-4997-9e20-c4c2693b8cdc@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5872:EE_|PH7PR11MB7552:EE_
x-ms-office365-filtering-correlation-id: 4651645c-216a-4658-dd28-08dc1bb1b6f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ywrmXN8e0D+A6xjKrEkkL1GAoGO9z0ZlPRbiLGSq86IbH+uWoClPn+/VOv91w1XdXLNqvP8/VfpN5WAm6IdsxBGwToh/STiG1IR8YtaDYG8URVmV2EPok3HE4rHO3goHUj6iAnqu+0DgJ/3rMWiDKuadSAdhdcAkNUzmst2+QPtKz7+YbRJYExJeb6Y5WzmGzmmGR0PYEVpWN55r3OErh/VRAi0//Dk4ZE8E/tWzwjHspQHXly6P3L26D2B2GYtq0M+ruY+KoVbO9iiAPLRQ3RyjSuq+WGSb8cKEk81LOky5zwAkJDYF/k13oVZgbOqu7GpgHhuFHL5A94fLz8ru5bNwxsURACn39X4c9GWFUE17pTwjuJVQnISCmNgh5Q8EH8W2A+2vUzYCus/Sl03xGGQMcZxArZ3ohEisQnFg7iJKoMHwdFTXUeNYScojoB26Z44RrO51N47UDCncjhBbSla8iREvPZCVoj+b7ZErmkl6zUOZ6YtdEIISWPmUtsnfV9TTj4Ru0V7IoAoyfq2xTrH0X8tsmWF1LeV2ER0OJX0/aCwQ312JRmDoaflhQWFkTHmVQkZxpMfJmBOfSz1cd+5eJD8oLGuwrW83FLeb+PhO1Wpg016vWTm8zvE8DQBB8B5Zy89DC/Sfgq9qW0gdGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5872.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6506007)(54906003)(8676002)(122000001)(83380400001)(41300700001)(33656002)(86362001)(38100700002)(82960400001)(6636002)(7696005)(4326008)(316002)(8936002)(2906002)(76116006)(52536014)(66946007)(53546011)(66476007)(966005)(64756008)(26005)(9686003)(110136005)(66446008)(71200400001)(478600001)(66556008)(5660300002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckFhV2x5cXNmUklXZ3BBOVV5N28wOE9NdG5VUjlaV0YzajJ6aVkraGQ2bTdS?=
 =?utf-8?B?VzI3MlFzTWF2NTYyNVg3b1NKTVlNbzJyRUxFWmpBcHZzMnArdE9NM2hXZDl4?=
 =?utf-8?B?ZGZSR0JXRTNoNEx3Q24rRGMxM3c1b01KQm1UdmdjNzJHSmZueld5RkFCRWU5?=
 =?utf-8?B?Vks2Zy92WUZQR0tLRCtacXlyTEtPeUprcnVPVk56UlJXWHYyTU9zNFN6b3Bs?=
 =?utf-8?B?N2FVY2h5andkM0M0ZkFNR3F6Q1BqWUVieWJZVDFQeWo1VDBMMFpLMG1YUlZm?=
 =?utf-8?B?eG5ETVNCSG45c1M1akFqSlJXQk5MaTduOXRqYkxjbCt5NVVOTHl3dnh2bEVQ?=
 =?utf-8?B?L1hNRy9GRkRJWHdWYWVpRnZOeFJOSVAzSlZHSjQzRStKOWZ1L0JEOStGTE1v?=
 =?utf-8?B?OG9ubUVyNEtMRkZiVTZ6WDNjTXdYN2JiKzNWdGVCbFdxVlBuSEU3d3c2T256?=
 =?utf-8?B?NDhxUjcyaG9RQm1SSXE3MlFyMGRZUTl5VE5lRElpLzU2TU9wSmVWL2FsWnla?=
 =?utf-8?B?UU4rSjBDakoyZlF4RzRiWnlsM2drY3lwWmk0RG94L29xVzQ0N3VCelc1WUdt?=
 =?utf-8?B?Vnp2Rmt6KzFFb05UcWV0RjM3NjBZNEdCV2diNUtnVUV4UzRXcTFkNFQvaklD?=
 =?utf-8?B?R0c5cHByUWZJSEZXSGFZWktkNlh4V0lpTHc1bWhyZW5VWHNYOC9UU0hzc2h2?=
 =?utf-8?B?dFJEOEZVQ1NLMmxkM2t4blVOMHZvVVpLeDRDTm1SRzk5VlhveGNvV3BqdTRx?=
 =?utf-8?B?cjdqN3VweHVVenlJbVFGVGZGVG90WWFwN2RzcHVoNGJTNTJReGRvbWIrOGpn?=
 =?utf-8?B?VWZjZi9wUG5OLytSUmpIMm9VTnlaOWE5TDBwOXMvSlFxUGNHSXVYTGI3N1NE?=
 =?utf-8?B?VkJhWE9UVWlYZysrL01UU1Evdk9vaVJPa0llMEFvenZSamZJTmF4clZlK3o1?=
 =?utf-8?B?YnlodXZtT2U1MExUSjh1NG85dE4zbWhaZ0djd3hPNW5HejRpaHFPSE96b2hU?=
 =?utf-8?B?dXBPNDhoVTB3UFBBTWw2eFBidUNQem8yOWYwNzREejFkdlo2dzMyVzZ2TkpM?=
 =?utf-8?B?UVJKWkFCR2N4Vm9mdHhseFFKUloya2dMSnBRR1huMm5yM01tN0M3eDBZbk5I?=
 =?utf-8?B?bS9nQi9sdVphdnViTnpWNytpMjJDUldCZHM2YnVrb1dXMnJ0U2E1SlpNMC9h?=
 =?utf-8?B?bWpTZE1oL1NrNmFWdjl5QlNDTXpxRXNySHpYYWtWbGlFQ0ZES3ZIOHpUK3JP?=
 =?utf-8?B?clBEQ2dXRmt0KzZTMjJiMkFqN3VDMUtKcFUvVnhvaFBzNkM0M2tJbHpCTzVS?=
 =?utf-8?B?czhsMzliOXN0ZXQwb3g5cWRoc2VoRnlUUHpFeDhvS1pEQUxoZkJFVEdmdVV1?=
 =?utf-8?B?cGcrc1Z6WXZ5Sy8vWXB0UUJ1enpwUEc5WDJHQU5OSFAvMXBzWCs4UVhRcTRG?=
 =?utf-8?B?MWsyVWljS1VuY3N3T1dHSmV1SWh6aVB4TkR1bHF3ckFQWVR6dnhYVmhjaWtF?=
 =?utf-8?B?ajZBUmhLcUw1VStGampIVFZyK0U2QVIyREtobk94bUdydHZyc0lLakd6cTRw?=
 =?utf-8?B?TGJuL3JKSmU5MjFlMkFHSlBrWUU0dmN1K2wvNDBpNHdQMDdnUFliYi95d0NG?=
 =?utf-8?B?MGMzZ2lHTXVCRXUrM0lLN2d6c0IrQVIyOWFnSlR6dTRWUVBFOFRTU3NHNmVD?=
 =?utf-8?B?alBjWXUwbThWVnN2TWxldmxKaGlpT1lkajc0YmdhK0E4cW1rQXNtaWhlNDVz?=
 =?utf-8?B?YVdjYUUvNERTZmdITFFQUm4rYm1Gc293bFpsQjRzRUd4RnRIbGFLYUU1bUdi?=
 =?utf-8?B?MS9BOUs2b2VMZDF2VHZNR0N2T0FGOEljdVZPMS9hQWhNbGpVNU5RWEtIT0Uz?=
 =?utf-8?B?YWtXOTNXL3FQdHdKYmcxSDRJdTZRRGMyN0hMaGdLYzJXS3VuTXhNZmQ0QW9p?=
 =?utf-8?B?ZG96ZHFNMFRCSUtFZkYrS0UrY0srRG81UXVFVlFBT1dtMkkzYjRDa1JaRmY2?=
 =?utf-8?B?a0x4VlJrODVzWUlLNkhUZVgvUDYybVRnamZvRG1rSURsVk5xZW10Y0pTWHp3?=
 =?utf-8?B?TFQ4TE1kK1ZwQmVMNk12SzI3QjlLT1M5eTcxN28rendUVDhUa0RjcVlkcHhJ?=
 =?utf-8?Q?k2YlExmnM02bzv1I0M8AiqmxG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5872.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4651645c-216a-4658-dd28-08dc1bb1b6f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 01:22:07.1946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hOCTcR/aO7iOExzHOKCTyncXf7LCCr21A/D5Xmk+lbZeGkT8WFilRF0E4or8bn2bf91YYBvWze/mCpUZSmXFeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7552
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWGluZywgQ2VkcmljIDxj
ZWRyaWMueGluZ0BpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMjMsIDIwMjQg
NTo1OSBBTQ0KPiBUbzogV2lsbGlhbXMsIERhbiBKIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+
OyBZYW8sIEppZXdlbg0KPiA8amlld2VuLnlhb0BpbnRlbC5jb20+OyBRaW5rdW4gQmFvIDxxaW5r
dW5AZ29vZ2xlLmNvbT47IFNhbXVlbCBPcnRpeg0KPiA8c2FtZW9Acml2b3NpbmMuY29tPjsgTHUs
IEtlbiA8a2VuLmx1QGludGVsLmNvbT4NCj4gQ2M6IEt1cHB1c3dhbXkgU2F0aHlhbmFyYXlhbmFu
DQo+IDxzYXRoeWFuYXJheWFuYW4ua3VwcHVzd2FteUBsaW51eC5pbnRlbC5jb20+OyBsaW51eC1j
b2NvQGxpc3RzLmxpbnV4LmRldjsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MSAzLzRdIHRzbTogQWxsb3cgZm9yIG1hcHBpbmcgUlRN
UnMgdG8gVENHIFRQTSBQQ1JzDQo+IA0KPiANCj4gDQo+IE9uIDEvMjIvMjAyNCAxMjoxMCBQTSwg
RGFuIFdpbGxpYW1zIHdyb3RlOg0KPiA+IFlhbywgSmlld2VuIHdyb3RlOg0KPiA+PiBDb21tZW50
IGJlbG93Og0KPiA+Pg0KPiA+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+IEZy
b206IFFpbmt1biBCYW8gPHFpbmt1bkBnb29nbGUuY29tPg0KPiA+Pj4gU2VudDogTW9uZGF5LCBK
YW51YXJ5IDIyLCAyMDI0IDEwOjEzIEFNDQo+ID4+PiBUbzogU2FtdWVsIE9ydGl6IDxzYW1lb0By
aXZvc2luYy5jb20+OyBZYW8sIEppZXdlbg0KPiA8amlld2VuLnlhb0BpbnRlbC5jb20+Ow0KPiA+
Pj4gTHUsIEtlbiA8a2VuLmx1QGludGVsLmNvbT4NCj4gPj4+IENjOiBLdXBwdXN3YW15IFNhdGh5
YW5hcmF5YW5hbg0KPiA+Pj4gPHNhdGh5YW5hcmF5YW5hbi5rdXBwdXN3YW15QGxpbnV4LmludGVs
LmNvbT47IFdpbGxpYW1zLCBEYW4gSg0KPiA+Pj4gPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT47
IGxpbnV4LWNvY29AbGlzdHMubGludXguZGV2OyBsaW51eC0NCj4gPj4+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gPj4+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYxIDMvNF0gdHNtOiBBbGxv
dyBmb3IgbWFwcGluZyBSVE1ScyB0byBUQ0cgVFBNDQo+IFBDUnMNCj4gPj4+DQo+ID4+Pg0KPiA+
Pj4NCj4gPj4+PiBPbiBKYW4gMjEsIDIwMjQsIGF0IDg6MzHigK9BTSwgU2FtdWVsIE9ydGl6IDxz
YW1lb0ByaXZvc2luYy5jb20+IHdyb3RlOg0KPiA+Pj4+DQo+ID4+Pj4gT24gVHVlLCBKYW4gMTYs
IDIwMjQgYXQgMDc6MzU6MzBQTSAtMDgwMCwgS3VwcHVzd2FteSBTYXRoeWFuYXJheWFuYW4NCj4g
Pj4+IHdyb3RlOg0KPiA+Pj4+Pg0KPiA+Pj4+PiBPbiAxLzE2LzI0IDU6MjQgUE0sIERhbiBXaWxs
aWFtcyB3cm90ZToNCj4gPj4+Pj4+IEt1cHB1c3dhbXkgU2F0aHlhbmFyYXlhbmFuIHdyb3RlOg0K
PiA+Pj4+Pj4+IE9uIDEvMTQvMjQgMjozNSBQTSwgU2FtdWVsIE9ydGl6IHdyb3RlOg0KPiA+Pj4+
Pj4+PiBNYW55IHVzZXIgc3BhY2UgYW5kIGludGVybmFsIGtlcm5lbCBzdWJzeXN0ZW1zIChlLmcu
IHRoZSBMaW51eCBJTUEpDQo+ID4+Pj4+Pj4+IGV4cGVjdCBhIFJvb3Qgb2YgVHJ1c3QgZm9yIFN0
b3JhZ2UgKFJUUykgdGhhdCBhbGxvd3MgZm9yIGV4dGVuZGluZw0KPiA+Pj4+Pj4+PiBhbmQgcmVh
ZGluZyBtZWFzdXJlbWVudCByZWdpc3RlcnMgdGhhdCBhcmUgY29tcGF0aWJsZSB3aXRoIHRoZSBU
Q0cNCj4gVFBNDQo+ID4+Pj4+Pj4+IFBDUnMgbGF5b3V0LCBlLmcuIGEgVFBNLiBJbiBvcmRlciB0
byBhbGxvdyB0aG9zZSBjb21wb25lbnRzIHRvDQo+ID4+Pj4+Pj4+IGFsdGVybmF0aXZlbHkgdXNl
IGEgcGxhdGZvcm0gVFNNIGFzIHRoZWlyIFJUUywgYSBUVk0gY291bGQgbWFwIHRoZQ0KPiA+Pj4+
Pj4+PiBhdmFpbGFibGUgUlRNUnMgdG8gb25lIG9yIG1vcmUgVENHIFRQTSBQQ1JzLiBPbmNlIGNv
bmZpZ3VyZWQsDQo+IHRob3NlDQo+ID4+PiBQQ1INCj4gPj4+Pj4+Pj4gdG8gUlRNUiBtYXBwaW5n
cyBnaXZlIHRoZSBrZXJuZWwgVFNNIGxheWVyIGFsbCB0aGUgbmVjZXNzYXJ5DQo+IGluZm9ybWF0
aW9uDQo+ID4+Pj4+Pj4+IHRvIGJlIGEgUlRTIGZvciBlLmcuIHRoZSBMaW51eCBJTUEgb3IgYW55
IG90aGVyIGNvbXBvbmVudHMgdGhhdA0KPiBleHBlY3RzDQo+ID4+Pj4+Pj4+IGEgVENHIGNvbXBs
aWFudCBUUE0gUENScyBsYXlvdXQuDQo+ID4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+IFRQTSBQQ1IgbWFw
cGluZ3MgYXJlIGNvbmZpZ3VyZWQgdGhyb3VnaCBjb25maWdmczoNCj4gPj4+Pj4+Pj4NCj4gPj4+
Pj4+Pj4gLy8gQ3JlYXRlIGFuZCBjb25maWd1cmUgMiBSVE1Scw0KPiA+Pj4+Pj4+PiBta2RpciAv
c3lzL2tlcm5lbC9jb25maWcvdHNtL3J0bXJzL3J0bXIwDQo+ID4+Pj4+Pj4+IG1rZGlyIC9zeXMv
a2VybmVsL2NvbmZpZy90c20vcnRtcnMvcnRtcjENCj4gPj4+Pj4+Pj4gZWNobyAwID4gL3N5cy9r
ZXJuZWwvY29uZmlnL3RzbS9ydG1ycy9ydG1yMC9pbmRleA0KPiA+Pj4+Pj4+PiBlY2hvIDEgPiAv
c3lzL2tlcm5lbC9jb25maWcvdHNtL3J0bXJzL3J0bXIxL2luZGV4DQo+ID4+Pj4+Pj4+DQo+ID4+
Pj4+Pj4+IC8vIE1hcCBSVE1SIDAgdG8gUENScyA0LCA1LCA2LCA3IGFuZCA4DQo+ID4+Pj4+Pj4+
IGVjaG8gNC04ID4gL3N5cy9rZXJuZWwvY29uZmlnL3RzbS9ydG1ycy9ydG1yMC90Y2dfbWFwDQo+
ID4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+IC8vIE1hcCBSVE1SIDEgdG8gUENScyAxNiwgMTcgYW5kIDE4
DQo+ID4+Pj4+Pj4+IGVjaG8gMTYtMTggPiAvc3lzL2tlcm5lbC9jb25maWcvdHNtL3J0bXJzL3J0
bXIxL3RjZ19tYXANCj4gPj4+Pj4+PiBBbnkgaW5mb3JtYXRpb24gb24gaG93IHRoaXMgbWFwcGlu
ZyB3aWxsIGJlIHVzZWQgYnkgVFBNIG9yIElNQSA/DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBSVE1S
IHRvIFBDUiBtYXBwaW5nIGlzIGZpeGVkIGJ5IGRlc2lnbiwgcmlnaHQ/IElmIHllcywgd2h5IGFs
bG93DQo+ID4+Pj4+Pj4gdXNlciB0byBjb25maWd1cmUgaXQuIFdlIGNhbiBsZXQgdmVuZG9yIGRy
aXZlcnMgdG8gY29uZmlndXJlIGl0LCByaWdodD8NCj4gPj4+Pj4+IEkgYXNzdW1lIHRoZSAidmVu
ZG9yIGRyaXZlciIsIHRoYXQgcHVibGlzaGVzIHRoZSBSVE1SIHRvIHRoZSB0c20tY29yZSwNCj4g
Pj4+Pj4+IGhhcyBubyBpZGVhIHdoZXRoZXIgdGhleSB3aWxsIGJlIHVzZWQgZm9yIFBDUiBlbXVs
YXRpb24sIG9yIG5vdC4gVGhlIFRQTQ0KPiA+Pj4+Pj4gcHJveHkgbGF5ZXIgc2l0dGluZyBvbiB0
b3Agb2YgdGhpcyB3b3VsZCBrbm93IHRoZSBtYXBwaW5nIG9mIHdoaWNoIFJUTVJzDQo+ID4+Pj4+
PiBhcmUgcmVjb3JkaW5nIGEgdHJhbnNjcmlwdCBvZiB3aGljaCBQQ1IgZXh0ZW5kIGV2ZW50cy4N
Cj4gPj4+Pj4NCj4gPj4+Pj4gTXkgdGhpbmtpbmcgaXMsIHNpbmNlIHRoaXMgbWFwcGluZyBpcyBB
UkNILXNwZWNpZmljIGluZm9ybWF0aW9uDQo+ID4+Pj4+IGFuZCBmaXhlZCBieSBkZXNpZ24sIGl0
IG1ha2VzIG1vcmUgc2Vuc2UgdG8gaGlkZSB0aGlzIGRldGFpbCBpbiB0aGUNCj4gPj4+Pj4gdmVu
ZG9yIGRyaXZlciB0aGFuIGxldHRpbmcgdXNlcnNwYWNlIGNvbmZpZ3VyZSBpdC4gSWYgd2UgYWxs
b3cgdXNlcnMgdG8NCj4gPj4+Pj4gY29uZmlndXJlIGl0LCB0aGVyZSBpcyBhIGNoYW5jZSBmb3Ig
aW5jb3JyZWN0IG1hcHBpbmcuDQo+ID4+Pj4NCj4gPj4+PiBJIHRoaW5rIEkgYWdyZWUgd2l0aCB0
aGUgZmFjdCB0aGF0IGxldHRpbmcgdXNlcnMgY29uZmlndXJlIHRoYXQgbWFwcGluZw0KPiA+Pj4+
IG1heSBiZSBlcnJvciBwcm9uZS4gQnV0IEknbSBub3Qgc3VyZSB0aGlzIGlzIGFuIGFyY2hpdGVj
dHVyZSBzcGVjaWZpYw0KPiA+Pj4+IG1hcHBpbmcsIGJ1dCByYXRoZXIgYSBwbGF0Zm9ybSBzcGVj
aWZpYyBvbmUuIEknZCBleHBlY3QgdGhlIGd1ZXN0IGZpcm13YXJlDQo+ID4+Pj4gdG8gcHJvdmlk
ZSBpdCB0aHJvdWdoIGUuZy4gdGhlIE1hcFBjclRvTXJJbmRleCBFRkkgQ0MgcHJvdG9jb2wuDQo+
ID4+Pj4NCj4gPj4+PiBTbyBJIGFncmVlIEkgc2hvdWxkIHJlbW92ZSB0aGUgdXNlciBpbnRlcmZh
Y2UgZm9yIHNldHRpbmcgdGhhdCBtYXBwaW5nLA0KPiA+Pj4+IGFuZCBwYXNzIGl0IGZyb20gdGhl
IHByb3ZpZGVyIGNhcGFiaWxpdGllcyBpbnN0ZWFkLiBJdCBpcyB0aGVuIHVwIHRvIHRoZQ0KPiA+
Pj4+IHByb3ZpZGVyIHRvIGNob29zZSBob3cgaXQnZCBidWlsZCB0aGF0IGluZm9ybWF0aW9uICho
YXJkIGNvZGVkLCBmcm9tDQo+ID4+Pj4gRUZJLCBldGMpLg0KPiA+Pj4NCj4gPj4+IFRoZSBVRUZJ
IHNwZWNpZmljYXRpb24gaGFzIGRlZmluZWQgdGhlIG1hcHBpbmcgcmVsYXRpb25zaGlwIGJldHdl
ZW4gdGhlDQo+ID4+PiBURFggUlRNUiBhbmQgVFBNIFBDUnMgKFNlZQ0KPiA+Pj4gaHR0cHM6Ly91
ZWZpLm9yZy9zcGVjcy9VRUZJLzIuMTAvMzhfQ29uZmlkZW50aWFsX0NvbXB1dGluZy5odG1sI2lu
dGVsLQ0KPiB0cnVzdC0NCj4gPj4+IGRvbWFpbi1leHRlbnNpb24pLiBUaGUgY3VycmVudCBSVE1S
IGltcGxlbWVudGF0aW9uIGluIHRoZSBib290IGxvYWRlcg0KPiA+Pj4gaXMg4oCcaG9va2Vk4oCd
IGluIHRoZSBpbXBsZW1lbnRhdGlvbiBmb3IgdGhlIFRQTS4NCj4gPj4+DQo+ID4+PiBXaGVuIHRo
ZSBib290bG9hZGVyIG5lZWRzIHRvIGV4dGVuZCB0aGUgUENSIHZhbHVlLCBpdCBjYWxscw0KPiA+
Pj4gYG1hcF9wY3JfdG9fbXJfaW5kZXhgICB0byByZXRyaWV2ZSB0aGUgY29ycmVzcG9uZGluZyBS
VE1SIGluZGV4IGFuZA0KPiA+Pj4gdGhlbiBleHRlbmRzIHRoZSBSVE1SLiBDb25zaWRlcmluZyB0
aGlzIGJlaGF2aW9yLCBJIGRvbuKAmXQgdGhpbmsgd2Ugc2hvdWxkDQo+ID4+PiBhbGxvdyB1c2Vy
cyB0byBjb25maWd1cmUgdGhlIG1hcHBpbmdzIGJldHdlZW4gdGhlIFBDUiBhbmQgUlRNUi4gKFNl
ZQ0KPiA+Pj4gaHR0cHM6Ly9naXRodWIuY29tL3JoYm9vdC9zaGltL3B1bGwvNDg1L2ZpbGVzKS4N
Cj4gPj4+DQo+ID4+PiBBZGQgSmlld2VuIChvd25lciBvZiB0aGUgUlRNUiBjaGFuZ2VzIGluIHRo
ZSBmaXJtd2FyZSkgYW5kIEtlbiAoDQo+ID4+PiBvd25lciBvZiB0aGUgUlRNUiBjaGFuZ2VzIGlu
IHRoZSBib290IGxvYWRlcikgZm9yIHRoZSB2aXNpYmlsaXR5Lg0KPiA+Pg0KPiA+PiBJIHRoaW5r
IHRoZSBtYXBwaW5nIHNob3VsZCBiZSBzdGF0aWMgYW5kIGRldGVybWluZWQgYnkgdGhlIGhhcmR3
YXJlDQo+IGFyY2hpdGVjdHVyZS4NCj4gPj4NCj4gPj4gQWxsb3dpbmcgdXNlciB0byBjb25maWd1
cmUgdGhlIG1hcHBpbmcganVzdCBhZGRzIGNvbXBsZXhpdHkgYW5kDQo+ID4+IGNvbmZ1c2luZy4g
Rm9yIGV4YW1wbGUsIHRoZSB1c2VyIG11c3QgdW5kZXJzdGFuZCBjbGVhcmx5IG9uIHdoYXQgaXMN
Cj4gPj4gSW50ZWwtVERYL0FNRC1TRVYvQVJNLUNDQS9SSVNDVi1Db1ZFLCBob3cgbWFueSByZWdp
c3RlcnMgdGhleSBoYXZlLA0KPiA+PiB3aGF0IGlzIHRoZSBiZXN0IHdheSB0byBtYXAgaXQuDQo+
ID4+DQo+ID4+IEl0IGFsc28gYWRkcyBjb21wbGV4aXR5IHRvIHRoZSB2ZXJpZmllci4gRm9yIGV4
YW1wbGUsIHRoZSB2ZXJpZmllcg0KPiA+PiBtdXN0IHVuZGVyc3RhbmQgaG93IGEgdXNlciBjb25m
aWd1cmUgdGhlIG1hcHBpbmcsIHRoZW4gZ2V0IHRoZQ0KPiA+PiBleHBlY3RlZCBtZWFzdXJlbWVu
dCByZWdpc3RlciB2YWx1ZS4NCj4gPg0KPiA+IEkgYWdyZWUgd2l0aCB0aGlzLCB3aGF0IEkgaGF2
ZSBhIHByb2JsZW0gd2l0aCBpcyB0aGF0IHRoaXM6DQo+ID4NCj4gPiBodHRwczovL3VlZmkub3Jn
L3NwZWNzL1VFRkkvMi4xMC8zOF9Db25maWRlbnRpYWxfQ29tcHV0aW5nLmh0bWwjaW50ZWwtdHJ1
c3QtDQo+IGRvbWFpbi1leHRlbnNpb24NCj4gPg0KPiA+IC4uLmlzIHZlbmRvciBzcGVjaWZpYywg
ZXNwZWNpYWxseSB3aGVuIHRoZSBrZXJuZWwgZW5hYmxpbmcgaXMgYmVpbmcNCj4gPiB0YXJnZXRl
ZCBhcyBjcm9zcy12ZW5kb3IuDQo+ID4NCj4gDQo+IEkgaGF2ZSB0aGUgc2FtZSBjb25jZXJuLg0K
DQpNYXkgSSBrbm93IHdoYXQgdGhlIGRlZmluaXRpb24gb2YgInRhcmdldGVkIGFzIGNyb3NzLXZl
bmRvciI/DQpBbmQgd2hhdCBleGFjdGx5IHRoZSBjb25jZXJuIG9yIHByb2JsZW0gaXM/DQpQbGVh
c2UgZW5saWdodGVuIG1lIG9uIHRoYXQuDQoNCj4gDQo+ID4gU28sIHllcywgdGhlIG1hcHBpbmcg
c2hvdWxkIGJlIGFsbG93ZWQgdG8gc3BlY2lmaWVkIGJ5IHRoZSBsb3ctbGV2ZWwNCj4gPiBkcml2
ZXIsIGJ1dCBhdCB0aGUgc2FtZSB0aW1lIGV2ZXJ5IHZlbmRvciBzaG91bGQgbm90IHJlaW52ZW50
IHRoZWlyIG93bg0KPiA+IGVudW1lcmF0aW9uIG1ldGhvZCB3aGVuIHdlIGhhdmUgRUZJIGZvciB0
aGF0Lg0KPiA+DQo+IA0KPiBHaXZlbiBQQ1ItPlJUTVIgbWFwcGluZyBpcyBzdGF0aWMsIEkganVz
dCB3b25kZXIgd2h5IGl0IG5lZWRzIHRvIGJlIGtlcHQNCj4gaW4ga2VybmVsLiBHaXZlbiB0aGF0
IFBDUnMgY2FuIG5ldmVyIGJlIDE6MSBtYXBwZWQgdG8gUlRNUnMsIGFuZCB0aGF0DQo+IFREWCBx
dW90ZXMgYXJlIG5ldmVyIFRQTSBxdW90ZXMsIGFwcGxpY2F0aW9ucyB1c2VkIHRvIGV4dGVuZCBQ
Q1JzIHdvdWxkDQo+IGhhdmUgdG8gYmUgY2hhbmdlZC9yZWNvbXBpbGVkLiBUaGVuIHdvdWxkbid0
IGl0IHN1ZmZpY2UgdG8gZGVmaW5lIHRoZQ0KPiBtYXBwaW5ncyBhcyBtYWNyb3MgaW4gYW4gYXJj
aGl0ZWN0dXJlIHNwZWNpZmljIGhlYWRlciBmaWxlPw0KDQpNeSBjb21tZW50IGlzICJQbGVhc2Ug
ZG9u4oCZdCBsZXQgdXNlciBhcHBsaWNhdGlvbiAocmluZyAzKSBpbmRpY2F0ZSB0aGUgbWFwcGlu
ZyIuIEl0IHdpbGwgY2F1c2UgYmlnIHByb2JsZW0gaWYgZGlmZmVyZW50IHVzZXIgYXBwbGljYXRp
b25zIHVzZSBkaWZmZXJlbnQgbWFwcGluZy4gSSBzZWUgbm8gYmVuZWZpdCBidXQgY29uZnVzaW9u
Lg0KSSBoYXZlIG5vIGNvbW1lbnQgb24gaG93IGtlcm5lbCBtb2R1bGUgKHJpbmcgMCkgaW5kaWNh
dGVzIHRoZSBtYXBwaW5nLiBJdCBjYW4gYmUgc3RhdGljIGluIGtlcm5lbCBvciBieSBhIGRyaXZl
ci4gSSBkb27igJl0IGhhdmUgc3Ryb25nIG9waW5pb24gaGVyZS4NCg0KDQoNCg0K

