Return-Path: <linux-kernel+bounces-51464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F6C848B8F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9923F1F228F2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 06:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C35579DE;
	Sun,  4 Feb 2024 06:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kqyPk5SS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA6A79C2;
	Sun,  4 Feb 2024 06:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707028766; cv=fail; b=pGsGqQZeZ6702XQuztUWc7B+aUHL5rO2w7eipdgVrqfN+ZX5VvGuVLzVifOVtcl0HjZf6vxrVR1RFMF6/2BVAN6zX/vHz8yVopInB7V6JmwuJbAA+B+ebDY0kllqmiA8fJvV4RxBp4tpQ2g6GdgF1B28nol5hMmCatRJKdVmYL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707028766; c=relaxed/simple;
	bh=I+yeeGJT/XHYAKDWqMQs9B/vvy686WvPX4HYvCi6UW4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fw0SapTVPw9EGnkkGNPFtNMyxSYA/twTifgZqPJeXpQJVLRxuqfaWaKnzwAIJ0ek3qwCqNAHGIfLVw3UEzotTVFYD9H/Hi+iXRXb6zUVxLfxDuCpsvBWU3pSVeZ7PnZNkZ+MT4XJa9B1hvqnxh/I97IEhz2rogVTZT8ff9HIQ80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kqyPk5SS; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707028764; x=1738564764;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I+yeeGJT/XHYAKDWqMQs9B/vvy686WvPX4HYvCi6UW4=;
  b=kqyPk5SSoHlRBsixU29Lmx9EMF5yaVuir8ZZICdig9PeMoyJ620kNCnX
   i7hoi4Q2BhKlO0+O4bGrsdiH9XRGGgel8NVSNglYnZpYjsezR+OpdTTLW
   G2GdvT5pypOyP3i7mXT/rsroYGxedDf8QodOCdbEQjLP09NTADhT6LMjG
   HA426A0zQSCGxT27B+vUlv8gBD70QFJeHj6dYDVmH8mxqJ3Ntqh42F5sJ
   yCNzxtRG2eOsB2nsaDGsHciyrtWiG9i3TQzU4P7Bi8OSmxMLIoY80igNk
   ovFKgMC2AzqeECcksaNnWQiGDFJOTFhgMw6JJninebQiML3v6/xr4WmCp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="17889808"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="17889808"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 22:39:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="442984"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Feb 2024 22:39:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 3 Feb 2024 22:39:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 3 Feb 2024 22:39:21 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 3 Feb 2024 22:39:21 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 3 Feb 2024 22:39:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9rNpfS+Q+GyAkznyy/LJWW6LhxENTLTjeY5NshHerajZt9tdCeeeYWf7hsq7gDFVjIIu6Gt74miKNWTtqoqemkWSvkWAmuLHYdllfOySbhaUwSp9pbJlK//Z4vbKzLuAx0o4pBAo6OsIaGAu6htvurZl5o6dBY5dkO0IX4mc5tbcIYbrNgNaRTv8P1wRs/XetjY8UmFnSMaAk2q/yl9LO7pg7OA0rN4uDlC3kkT4/i6eBj/mr6VTB0ha1vv18gQX3W1xZ9JlULEofj2+6g9PJE6mXNkpqt1PJgLNuHUjUbHRiJ1wwSQWcBazSA58GzQ1aXWFUBlV/kp8cj0ZYY9pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+yeeGJT/XHYAKDWqMQs9B/vvy686WvPX4HYvCi6UW4=;
 b=W6UEs8oBlQCKygYUn95L/rfsIwyIgeEfhTaBB76R1vMnhGFDBtTZbekwdC0hWda+CgKn2XSarC2LKHBMThHkXKa4zpWLwpvAFISDJulUUt11TrFJaJ6Af09R+qCFO3TkQCszIr1YHBieTwxy/3VGJTHQ9ReHGcNRki9cP31m/psZgNJFkRbacbnpSTlqDx4G68ZnKI5iPKANbxJOC+NyZBztbXrZjhHI0HL+2nrGVAevK9qHqAXbJR8wd+78ZAkLjolWpUweizztGH/GV2NUz9PT9UWbBSTaTP8Q5VEejGKVjz0AJFcv8GGRNyw/eAe01ciQIvRdDOMITitTBfnnMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by DM4PR11MB8092.namprd11.prod.outlook.com (2603:10b6:8:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33; Sun, 4 Feb
 2024 06:39:19 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda%3]) with mapi id 15.20.7249.032; Sun, 4 Feb 2024
 06:39:19 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: Kunwu Chan <chentao@kylinos.cn>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: Kunwu Chan <kunwu.chan@hotmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v3] igb: Fix string truncation warnings
 in igb_set_fw_version
Thread-Topic: [Intel-wired-lan] [PATCH v3] igb: Fix string truncation warnings
 in igb_set_fw_version
Thread-Index: AQHaR40BtTFSmqu9aUme+0gC8FyxF7D52faw
Date: Sun, 4 Feb 2024 06:39:19 +0000
Message-ID: <CYYPR11MB8429A8C895A5F4F58CFFB5E4BD402@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240115082825.28343-1-chentao@kylinos.cn>
In-Reply-To: <20240115082825.28343-1-chentao@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|DM4PR11MB8092:EE_
x-ms-office365-filtering-correlation-id: c0d5dc0b-ad38-4ca2-d242-08dc254c0402
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uts0HIE98m1HeXSPdmpPy8cEe18klV1SSl1bKkWunzRvQnX8RCc7j43cSasolPVQXbbpoIYgh9feRImomL7/OxDSAa9gEAuz6AOl/ZlO5bR1WFfmGTvgmA1pOjrJQ6XdJ0+9cSLjLWTZp5uQ0hPXGTkPFeNyetpmyocez28pFO7glKRwfgidMZmiZ/Tx/6djaJOmx3SpAGcbX5HAQGWMbTS30w2O0MLIetfqrx0dFPGESfNe0ALCFaLyft7W6h8hacO7PGQu6pRX1ud63ozhnQIn/w79PXyHhBMjbAs9nZXz+cCQT8FRwGt7B6V26LwP/CO3+jKIkLrOKUbWOa3klrUWuQCL6qMW5AjGky2qhReI0VPD5F830F3pOniXRm7e5Nnamy2ZBwUhFSOv6ozSiRb18sx7M7GJ0oaP572Bk8fvjg2/vcr7w+w4jai5OyLehZArfR0Zn3tO6gLPoumre+VPx9L/tHJYK6DJZQqL0olT4wKbQQeG4gVz6aUJlHhMDakuXoN6Tt4KaGxDlTXVwGnnktCGZl3TUWoNOw71yOqIk4UJm9bC+v1+lUvTcwzcwXL8d65LbGgK2kMqpW9Rif0v52TUqxR1rKi2rl+FNCpmHPiwy4rPXBr3EQtEHqwNH9/mOblHsB3j1pPvVx8PMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(230273577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(5660300002)(55016003)(8936002)(8676002)(4326008)(2906002)(76116006)(316002)(110136005)(64756008)(54906003)(66946007)(66446008)(66476007)(66556008)(52536014)(966005)(33656002)(478600001)(71200400001)(9686003)(7696005)(6506007)(53546011)(38070700009)(107886003)(83380400001)(122000001)(86362001)(26005)(38100700002)(82960400001)(41300700001)(67010200005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUhXQXMzek56OHAxbWMyajZwenZrN0dCTndRK3JtN1VUWWZBbFBXeTlRYXZp?=
 =?utf-8?B?UzdWdlVGM1orVHhmRTQ4bzlXRGY0WVBoU29RRjd6SUJXVmJsQ2xNUnRCTnI0?=
 =?utf-8?B?aWJCNTN6c0hBWm1QeWxkQ3h2b29IdEJnTVJsZkZkWEtOVDcrcVRTVzlMWmFh?=
 =?utf-8?B?REc2ODhKL1l5QXlwQll5MnZzWWRsbVllenNZYmhub0VBWndOTVNOUmU5U002?=
 =?utf-8?B?Q3U2R1hEdWpnbTBDTkVoSUQvQUxKeHFmc3RJdm4zSGw4RkNYV3kyVzNndUU3?=
 =?utf-8?B?OEFUaUdISlUxdjF1eFVZWkJsa29XVm54a1BBWUxpV0Z2b2FTQVZrR1NmV3BY?=
 =?utf-8?B?MkhDVDVRMlg0bURueVEyOS9LMW5ISG95cXpPTnErbEN2ejJvU1hXbzAwZGlD?=
 =?utf-8?B?ZnZHODA0S0pqcU83MG5ubTFZajdCTEZ5NTVQQmxRWXAzR3ZMZWZUUkZHSlIv?=
 =?utf-8?B?MHpXREpQS0xkeTZYNUZYSWFHaWgyclZxeGdxYzAvZTJDYXVKWnhTWkk0UFZt?=
 =?utf-8?B?OG9QcHdyYll3d25hZyszeHRsd2pWRHVyOXdXeVBRTFpaMHdySHFXTnpiemR3?=
 =?utf-8?B?bUV5b3drZ2tjYTFpSlBya1NEeWtKV1UvVnhDTkJNdnM4Wm5EWmR4U0RkcmNJ?=
 =?utf-8?B?NnlwN0s0bGk4elRxWEdGOEZXMjFxd0JSaHhBejVRNGNqQjV0eS9sSW9FbTR2?=
 =?utf-8?B?d2ovUzA3WTJNS2l3cU1INnprcEdjNEU1N2p5MXBsZS9vc0JCVzNMVmVoN1ZB?=
 =?utf-8?B?YnQvaHBnaXJVNHU3LzNzcG5yZUVDRVVXNHRsZC9GamkyZ1h3anhYaUh0NFRW?=
 =?utf-8?B?ek9FSUU3bEJWM2oxY1M1eU16WXdnNzhNcU9Zc3dXcHZDTk9zWk50S3hibWI3?=
 =?utf-8?B?d0hHUmpGSXlhZTcrVHdDVmRocHF6UmhoeWJ5WXJGVVU0R3VQeFEwdVlDVmlC?=
 =?utf-8?B?ejJsWGdDR3hsV2M5TlF2UE5odEZBZG5XeUM0Vk9leHdZS1oxSCtIU1pDRlhD?=
 =?utf-8?B?bHFQNjBVazN0NUwxS0FuRDZOQXhERzFtTk5tU2prajZkb1BLYURWbkxXRjQr?=
 =?utf-8?B?eEc4ZlVrRy80UHZTT3NkZUl0Z2wxS0E5amtwUEp6QktoY0xXVS9kdGNMT3RV?=
 =?utf-8?B?empnNExMbnEwRmlhS2p5cHd5b2xDZXFXNFVyT0YvazVuWmVFQ09mQ1ExSi9C?=
 =?utf-8?B?bFBFTHFhMmQ5U054KzJjdFNxZ2RTWmNrZ0FqL3BqNHg1b2J3cm9tdG5lNVRs?=
 =?utf-8?B?R2xabmp3RHNWSG9qZER3aDB5VEdzeHN2ZFl1dXdQVUJ2MVVFUXQrNmdyTXNw?=
 =?utf-8?B?dGVmVWJJR3lneTlieG5FT1pBd0MxYmtjMVhwT1o2TnlQck82My9BeVk2ZStR?=
 =?utf-8?B?WmRDT1l2a283U0dxOHRDL3V4R3EvYitTOWFvejdMUEdOQnd4VUV0ejJBQVdw?=
 =?utf-8?B?Y0JKSDNieEVhZU5ZSDVjY1dPeC95RzhMRGFwWlFkMURZYkhzWmJhWGx4TWw2?=
 =?utf-8?B?T08vRnJNT3BCSWpidmRvMGFTVS82RDcwZklreW9DSEk3RThBdUxRaGNzT3JS?=
 =?utf-8?B?ZXZrUmZpSDlxS3dvUnIrbDFSVFA3a3V6REVaaXJkc0N0WDF6YlZ1dndrb09a?=
 =?utf-8?B?UWpmY2I4cFdQY0VaU09RUGtYNitzVHgzb0lua3d4NTQ3ZUV2MTZaVEtuWjYv?=
 =?utf-8?B?VHYzaWxCbmxsMC9vWngzbHNqbEZ3dG1jem1uOUlXME5oc2M3SlNzSVV5eFJ4?=
 =?utf-8?B?Q1VGQXJReHhMMk0zaWVQSUI2MGtrSk1wUlMrMzJacnJDbytCRkQvS3JtMGdR?=
 =?utf-8?B?L1VIWEtIT3IvWnNmNXdvYXptZmVmQ013eFhSRnJVSjBZQmhDbktOV3dleXBn?=
 =?utf-8?B?SWJmTXJVd0hHN1R1TDllZlJjSXF3Q1h0SG5UNkp0aytDMTZuYUIwMmNpUTJH?=
 =?utf-8?B?dnRXeUFGaERXV3F1ZlppNS9EZEtjRXVzZDdqUkYyeXRUMjlkUU5KVDh1U1Z0?=
 =?utf-8?B?bnA0UnRoeEVQSVZLUS9wMFZRT3ovNEVoVTlxbUJ3NytFcTQ4aldScUJMRExl?=
 =?utf-8?B?Z1lkdzl1VnhtZTlNL0JJTkd6Ymg1SGR5ZmVRKzVRY0hZczUwd2NmTGJqaXo2?=
 =?utf-8?B?ZmpCWEFnSmsyb0dpOWpNaXQreFNpMDRCK2ZlaEZZanNsaXgvK3hNRll5TWVq?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d5dc0b-ad38-4ca2-d242-08dc254c0402
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2024 06:39:19.4451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: daCBA0q1Zia2PzbnVluLsDtqAwdBeQon39ceWEsjmXTKi8gYFOloZPfHnJ7tkxhj1kEkpAzIUpBy+2iMvTr3t595fr+k4diEdG4nssgsyNu+afyDwrEN5EoQONnG27xE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8092
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBLdW53dSBDaGFu
DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAxNSwgMjAyNCAxOjU4IFBNDQo+IFRvOiBCcmFuZGVi
dXJnLCBKZXNzZSA8amVzc2UuYnJhbmRlYnVyZ0BpbnRlbC5jb20+OyBOZ3V5ZW4sIEFudGhvbnkg
TCA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVt
YXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tDQo+IENj
OiBLdW53dSBDaGFuIDxjaGVudGFvQGt5bGlub3MuY24+OyBLdW53dSBDaGFuIDxrdW53dS5jaGFu
QGhvdG1haWwuY29tPjsgS2l0c3plbCwgUHJ6ZW15c2xhdyA8cHJ6ZW15c2xhdy5raXRzemVsQGlu
dGVsLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGludGVsLXdpcmVkLWxhbkBs
aXN0cy5vc3Vvc2wub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBLZWxsZXIsIEphY29iIEUg
PGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gU3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0g
W1BBVENIIHYzXSBpZ2I6IEZpeCBzdHJpbmcgdHJ1bmNhdGlvbiB3YXJuaW5ncyBpbiBpZ2Jfc2V0
X2Z3X3ZlcnNpb24NCj4NCj4gQ29tbWl0IDE5NzhkM2VhZDgyYyAoImludGVsOiBmaXggc3RyaW5n
IHRydW5jYXRpb24gd2FybmluZ3MiKQ0KPiBmaXhlcyAnLVdmb3JtYXQtdHJ1bmNhdGlvbj0nIHdh
cm5pbmdzIGluIGlnYl9tYWluLmMgYnkgdXNpbmcga2FzcHJpbnRmLg0KPg0KPiBkcml2ZXJzL25l
dC9ldGhlcm5ldC9pbnRlbC9pZ2IvaWdiX21haW4uYzozMDkyOjUzOiB3YXJuaW5n77ya4oCYJWTi
gJkgZGlyZWN0aXZlIG91dHB1dCBtYXkgYmUgdHJ1bmNhdGVkIHdyaXRpbmcgYmV0d2VlbiAxIGFu
ZCA1IGJ5dGVzIGludG8gYSByZWdpb24gb2Ygc2l6ZSBiZXR3ZWVuIDEgYW5kIDEzIFstV2Zvcm1h
dC10cnVuY2F0aW9uPV0NCj4gIDMwOTIgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAiJWQuJWQsIDB4JTA4eCwgJWQuJWQuJWQiLA0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefg0KPiBkcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pZ2IvaWdiX21haW4uYzozMDkyOjM0OiBub3Rl77yaZGlyZWN0aXZlIGFyZ3Vt
ZW50IGluIHRoZSByYW5nZSBbMCwgNjU1MzVdDQo+ICAzMDkyIHwgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIiVkLiVkLCAweCUwOHgsICVkLiVkLiVkIiwNCj4gICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+
IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYi9pZ2JfbWFpbi5jOjMwOTI6MzQ6IG5vdGXv
vJpkaXJlY3RpdmUgYXJndW1lbnQgaW4gdGhlIHJhbmdlIFswLCA2NTUzNV0NCj4gZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2lnYl9tYWluLmM6MzA5MDoyNTogbm90Ze+8muKAmHNucHJp
bnRm4oCZIG91dHB1dCBiZXR3ZWVuIDIzIGFuZCA0MyBieXRlcyBpbnRvIGEgZGVzdGluYXRpb24g
b2Ygc2l6ZSAzMg0KPg0KPiBrYXNwcmludGYoKSByZXR1cm5zIGEgcG9pbnRlciB0byBkeW5hbWlj
YWxseSBhbGxvY2F0ZWQgbWVtb3J5DQo+IHdoaWNoIGNhbiBiZSBOVUxMIHVwb24gZmFpbHVyZS4N
Cj4NCj4gRml4IHRoaXMgd2FybmluZyBieSB1c2luZyBhIGxhcmdlciBzcGFjZSBmb3IgYWRhcHRl
ci0+ZndfdmVyc2lvbiwNCj4gYW5kIHRoZW4gZmFsbCBiYWNrIGFuZCBjb250aW51ZSB0byB1c2Ug
c25wcmludGYuDQo+DQo+IEZpeGVzOiAxOTc4ZDNlYWQ4MmMgKCJpbnRlbDogZml4IHN0cmluZyB0
cnVuY2F0aW9uIHdhcm5pbmdzIikNCj4gU2lnbmVkLW9mZi1ieTogS3Vud3UgQ2hhbiA8Y2hlbnRh
b0BreWxpbm9zLmNuPg0KPiBDYzogS3Vud3UgQ2hhbiA8a3Vud3UuY2hhbkBob3RtYWlsLmNvbT4N
Cj4gU3VnZ2VzdGVkLWJ5OiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiAtLS0N
Cj4gdjI6IEZhbGwgYmFjayB0byB1c2Ugc25wcmludGYgYW5kIGEgbGFyZ2VyIHNwYWNlLGFzIHN1
Z2dlc3RlZCBieQ0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzEyMTIxMzI2Mzcu
MWIwZmI4YWFAa2VybmVsLm9yZy8NCj4gdjM6IEFkZCBkZXRhaWxlZCB3YXJuaW5ncyB0byB0aGUg
Y29tbWl0IG1zZyAsbm8gZnVuY3Rpb25hbCBjaGFuZ2UNCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9pZ2IvaWdiLmggICAgICB8ICAyICstDQo+ICBkcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pZ2IvaWdiX21haW4uYyB8IDM1ICsrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+
ICAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KPg0K
DQpUZXN0ZWQtYnk6IFB1Y2hhIEhpbWFzZWtoYXIgUmVkZHkgPGhpbWFzZWtoYXJ4LnJlZGR5LnB1
Y2hhQGludGVsLmNvbT4gKEEgQ29udGluZ2VudCB3b3JrZXIgYXQgSW50ZWwpDQoNCg==

