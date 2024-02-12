Return-Path: <linux-kernel+bounces-62099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2526851B69
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680A21F22EC9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FB53E49B;
	Mon, 12 Feb 2024 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WprGpEqC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFEE3F9C3;
	Mon, 12 Feb 2024 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759002; cv=fail; b=CdaXotWaMJ3i1EQd8Xd40H4ynKTNeb5VirdecG0+5Oyt/P0kprH5Ggcy+E93aj2b4hD2HL6oCDuDM2N8POsdB8LHhd/o4S0BUI0bJU9B1M4bPy7a2C4H8Cqo7/TzUNQVjA00kzSBd4/MFNGTW4mFS5wBMeMadKA3A2U9bqBRszE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759002; c=relaxed/simple;
	bh=gu7mLUNO07t6yBpe1z+Rmw9FHnGjizp4egq946s+/us=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jy5sQJ9glS5mbYCcfbIImEYBq3DqMstnoHzff50N8/+2r4r+djruGbHV4nBt9SAa46BoDnKdzJH7ucP2T+FeDALt7ht+5VlY0Cw8jXLaPzlEsPByrxh5zcQUL1WgTrwHmG64vdLDRI/9GDb/tJP4UIyqbkMkU4zCnda+ErvQH4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WprGpEqC; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707759001; x=1739295001;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gu7mLUNO07t6yBpe1z+Rmw9FHnGjizp4egq946s+/us=;
  b=WprGpEqC6xOraOC39A3uMrbEIcPqemo+LUbrGXaDaCc7V+gF+5zRDD6f
   INWfWtXIRv2gX9t7ttduGETGPSxkZY2bva9LgKtOZPENrWLr+gouxcVNC
   w55pTMRU4fF6gcwhcCjBmOrkp+Ayy8844w071/ZwgvTOin8E1FiPzQ2Zw
   vYX1lOtE2eRklzVJBohMTVVZD9fCs/SvCWdpG5rq78lNH4Qg4PgqEAk/x
   O9wov4mEkDQVtYRQW3qio45xndhra5I7ma0dbGuM5r7ZU/ffkzUiViZIS
   OuolgA1uoh36ScNOH8JrxLWIcQCyYJUCKtG/gGemNKEqpuX80zGBDTLGE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1883044"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="1883044"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 09:30:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="3026427"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 09:29:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 09:29:58 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 09:29:58 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 09:29:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYhztYkh8JcvrmYYaMJw9OyA2sxLScEuXzSoAnSRyiOeXgo7eK51LtfRVTXxW0iKOlUyiMvJ4G+Zk5qYemwSTmfWUBNzpbGnXzXyaWUM08vKg5v3coVW6fHoJ3TcTcWmSpAv9CSlJQuwpLPrO585+P9fD1ej7UE+UMEcV1W4BEIrVEFm81DwNjtStFXwZcf0JSfDmBlcWvg/jLAvObqqzMSS1z9iMB5eEHtwHrq6cE0mHWxLFEipRDgOj4Qgn0/eUIpUre5VK9LhqZrUOhoY835s9QrMyT52n9e7aeUjQ105hW3mBLqMn1iW9e7poAN4RXzS0TKC/1fYGgILuy/V1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gu7mLUNO07t6yBpe1z+Rmw9FHnGjizp4egq946s+/us=;
 b=moNTNX0hQvTmSnWoSP8/V47KB0ZKq7+UVf4KU5jklaoCdU8efUpdTYyaLnX+fjD72lb55WC/0Aw6V7u7UPdCkIdEOsuvKTZSUWc15LsV+MzewFP8wWlFw7cEY8WaMbm+dZPzfNM7lC3oSyf1Ywm8OCO56H2dkv/KpLZq7KJaXJe3QNLC+H29exrk+29aFi6ylrMdcIyxnQhqgVIqoSHhsKdijllDe/neZJ99vJR13KUbCQdMi/GUrjV+cITP0zOttHmDdDsZ9Ys5jcirazElgZwKT6YrBdK9SuQ3nx04EqfYZD28dbw6LAlXKO2c7vcBmajB8kbScI7vAphFw+tOog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB7662.namprd11.prod.outlook.com (2603:10b6:510:27d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Mon, 12 Feb
 2024 17:29:31 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802%3]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 17:29:31 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>, "Naik, Avadhut" <avadnaik@amd.com>
CC: "Mehta, Sohil" <sohil.mehta@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>, Avadhut Naik
	<avadhut.naik@amd.com>
Subject: RE: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Thread-Topic: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Thread-Index: AQHaWhj+DLVtkWOA50OiEqZPMnN2ZbEBPHkAgAE1PoCAAAHSAIAABzoAgAAEd4CAALjhgIAA4DsAgADqjICAAQaDgIAAZZKAgAAJtgCAAIJw0A==
Date: Mon, 12 Feb 2024 17:29:31 +0000
Message-ID: <SJ1PR11MB6083B3511D18787BE823AB2CFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <8b4f8ec2-7534-4f77-b44f-6728c699ff64@intel.com>
 <51255499-0b5d-45c6-9c72-f353bae83c0d@amd.com>
 <20240209200920.GFZcaGcOr757W9O3IG@fat_crate.local>
 <7a4945b0-322a-444e-a0ca-860a062a49c3@amd.com>
 <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
 <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
 <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <774e7ca5-154d-4ca4-bc4c-2f945c20b938@amd.com>
 <20240212085801.GAZcndma4UTPtKm33e@fat_crate.local>
 <20240212093246.GBZcnlvkPKDC8C7rv5@fat_crate.local>
In-Reply-To: <20240212093246.GBZcnlvkPKDC8C7rv5@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB7662:EE_
x-ms-office365-filtering-correlation-id: 00b6c98b-0b98-43d8-7b42-08dc2bf02c5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rKgFnfeJROzaad0Ro5QdWU9pVScbgNf2Vtu4ACargUZNeP1gxTcqmr/MqbDF5MzpZxxQHmV6V7duxppbEghWNSqq9VGF3nIbjhPXuJt0emPwu1u79Dhhd5AC6a+7KDxw+6FGjAs3g216nnTtGKiPaZSdgWzi0uVamFTfp1BHjiBZ0H/+C9G+fd5fhTc/XCUYCmrJtZulFVCwXmu02YtF18N8JOj/C4u71WYEwngnk1DoZYZXR3uEj0S8o1DytlL7D2riMimnl+qdwP3P6n+ktcJ5zQ2BoHPuMzDMXg7x+lg6zXW3C4232+bREgoSDz81yutqIWxxq4ZVbggogK7aeEHFvEgBkF0J378qq/KW0NQ+Az76fgomxdxZzSEcuS+O+CX8WIJB0nef0xsRnJgPMHZRrQNUrwh16O4N2q10CKt3sNq3AmfkfewCDlSivviotiE6+7QCbBRVI9hK89Gu+7RXgceR3kfjOD7ijkf+zEPEykijKnMe52eEXKsSDGfymrJ4F7FMN3t9+Wqnyky36BIIso6ztf2PwCD1elR0Y76YEObGyNHoX13xzDPWOXworxdDrBPu6xkOJnXFOu6vANh2WUtcNzoftE98QNEHlA7CZqmQajel+r3pXGuuu4nJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(86362001)(122000001)(38100700002)(82960400001)(26005)(45080400002)(478600001)(316002)(110136005)(66476007)(54906003)(66946007)(76116006)(6506007)(7696005)(71200400001)(9686003)(33656002)(38070700009)(4326008)(66556008)(8676002)(66446008)(64756008)(8936002)(55016003)(41300700001)(2906002)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L240aUdsemVCQ1JEbFNCdkFnd2RaQzRNdktEbXZUdWc1azE0ZFZkM3hXRW5z?=
 =?utf-8?B?UGFBOHJtdC9OMmNxNTc0cXlLNG4vQmRHNllxSDFla1BFNmh0KzhYeVZXRmli?=
 =?utf-8?B?L3AvUlRqZnBOYm04cG1kMndiTUhjQkVEMU5TS3Jpc3lxNm8vL2l3N25MWlcx?=
 =?utf-8?B?cmtqOUp1MW1ObS9ZeXJiVG1ZRGh0c2ZTQlR5ZHJmYXZzdFlveUN5MXRHOXFW?=
 =?utf-8?B?WjFBbFNQRXI1eEpTNFFVelFSVFF0U3VkZEhteFc5SmdzRDNuYTFGdEhiNjZH?=
 =?utf-8?B?L0pSaTVLOEMxRHlLRHNKaWo2WTZLTWJKdVlHMXQ3T0VHZGxZODhoMko0OUpv?=
 =?utf-8?B?NXlQQkt0THVhaExzRlZtL0gzN3plcW45UndoeHFUT3djajRhTW41ZFBaaVp1?=
 =?utf-8?B?dS9hM21KSU9DcnZBcHFBdUlGR1gyemxhZEduNlppZU9HM1RsZ1YvYnQ1ZUtF?=
 =?utf-8?B?YitReE9XNlAvd1daV1pUSVZsWkNPTWhpTDgyQklPMUdmTGNoV3QyWnNXMXdx?=
 =?utf-8?B?ZVVRcXRuVHAzdVc2bHlHQ3ppbUd4dzhmb3ZDVmdoZVVwMUpyZDZ6ZXdLTkln?=
 =?utf-8?B?US96KzArSncxME1qSlpSMGx5VS9uc3U3VXR6K2wyaGdwZzJsbjhqd0hrL29n?=
 =?utf-8?B?aDFod0pmZ0dwc2VLK0YvRGhCWlFxNG0rQU5JWlBCaDNUbHhmOEJlallLT2lr?=
 =?utf-8?B?TDVvNzMrdkp4SmhRU1pjdFg1Z2FjYS9EczFObGp3WG9PbUlsN0VTYnpyOVkr?=
 =?utf-8?B?bE4wa0doUGpQRXlqVnFrd0ViaDdQdGQrZnFtNEFaREYxeHdrNzZ6bXcrNElI?=
 =?utf-8?B?UlBWRVhmbUFhNTZBaWdJK0pjOG5wSzJEeFpzZHduZE5HRkd5bUNMYkMwVEM2?=
 =?utf-8?B?TTFrYmcwRytsUjFMTk4wa3JhN1hRNXd5dC9jUGNXUTlKZFl3anpJT1Uxd2sx?=
 =?utf-8?B?Q3lzQ2VoKzFONzF2M1hrS1F5NU1FN2VobjhlUXJ3QzhrUUZkVkFCRG85RS9i?=
 =?utf-8?B?UktKMTlZM0RLVnZmeFlrMm9VaWh1T2dQWndPZVN5SmluVTBvN05PK01HOC9X?=
 =?utf-8?B?eFZIYkQ1ZFRVVUVmMnAzOGJXRXVpTnpPR2lwM1VHV2tSMG5KZ1R1bWxWdUNG?=
 =?utf-8?B?Skw3WXc4QldUcjh3eEpIdFZ4VVJoNk9KWXJaZVdmT2llUVBRVDVON3I5RU9Y?=
 =?utf-8?B?WHdYR1Rib0ZKdWJNdVoyQ2hZbDVwKzBoTjk2MXdncFdwekVzdzhsYkNqTkV0?=
 =?utf-8?B?aEVKblZPbHk2Ylg0U21KMUYya1NwZ1NVdE9nekpIdWlYdmNIaXFNdXJ2Y3lx?=
 =?utf-8?B?TkF5NjhrNEEvUCtQZVlVZUxjdDVtSUZCZFpEKzhhUGNubFJ2ay9XTWp4cHVK?=
 =?utf-8?B?T2ZGOCswUnhFcVpYNHM5UndzWStqeVNPTFZWb3NWWnJ4bXpnRldXbmJhaHFr?=
 =?utf-8?B?dVV4SUt6Wmwvak5YVVV1K0dPL1ZqU2NBUndVbmtCWmltVlJsakNBMTF0dHIr?=
 =?utf-8?B?UEtpdVptQ2xwVTRjeXl5SWFzU05SMmRNOVJUWWlDd3pMOGZSeWZJSjM2N2Fo?=
 =?utf-8?B?S3gxR2ZOODFMb1JIc3ZJMmlNODE2WTkwRlpyZFZiTG5wbjlTanBTSHZQTGJY?=
 =?utf-8?B?aGxZMVVnT1lhL3N0YmZpUEdGcFYrenRReCtqaXk2cmc0NEF3Qmd2WkFFRits?=
 =?utf-8?B?ZzhiM24wcDAzVC9lSkloYmcxUTJ5ejZDSnZ6Y1lzamZjVnNxNkUxVmV3bW5i?=
 =?utf-8?B?L2ZaZUczMTA3bVBXVDRiVEJBaThyQ2lQZ1U5NEUvV1pVOHhYV3JMT3c0TlZ4?=
 =?utf-8?B?MkJycTdleWxMREVKY1F6SEM2TG84V0dsSUh6S2xZYzQyVWNsMk9DMXc4Y05a?=
 =?utf-8?B?K052QUFBcloyY3laelpISEcrM0ZSWC9XUHBEN2RkeEtvSWg2K1BXUnN1cDE4?=
 =?utf-8?B?V2pMNVBoeVBXKytIcHFPMFlJNE1Lb29SN1VrWVVDZ3RHOU03Q1IvdUZzODZr?=
 =?utf-8?B?T3lLZEZYbytBdHNDSmdBV0JIdVBqSzRwaGhXamJweEZaNVoxUSt3QXFUakJM?=
 =?utf-8?B?VUJ2NnRzK3R5VXVoS3JXYlU2cEJOWFlLbm1YWjlOT255QTdTN0VrTGFZb1Jz?=
 =?utf-8?Q?dLQgKjWQUKDi+DXYxhZ0XM1os?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b6c98b-0b98-43d8-7b42-08dc2bf02c5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 17:29:31.5911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lFUIvub9a6wOiQrawGyUppc5olUVvtpCk4VCVJMMneXpdATUJfHqKVrPB9KBBb9WvS+WOeRI22fAEg4WaytLSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7662
X-OriginatorOrg: intel.com

PiBBbmQgaGVyZSdzIHRoZSBzaW1wbGVzdCBzY2hlbWU6IHlvdSBkb24ndCBleHRlbmQgdGhlIGJ1
ZmZlci4gT24NCj4gb3ZlcmZsb3csIHlvdSBzYXkgIkJ1ZmZlciBmdWxsLCBoZXJlJ3MgdGhlIE1D
RSIgYW5kIHlvdSBkdW1wIHRoZSBlcnJvcg0KPiBsb25nIGludG8gZG1lc2cuIFByb2JsZW0gc29s
dmVkLg0KPg0KPiBBIHNsaWNrZXIgZGVkdXBsaWNhdGlvbiBzY2hlbWUgd291bGQgYmUgZXZlbiBi
ZXR0ZXIsIHRoby4gTWF5YmUgc3RydWN0DQo+IG1jZS5jb3VudCB3aGljaCBnZXRzIGluY3JlbWVu
dGVkIGluc3RlYWQgb2YgYWRkaW5nIHRoZSBlcnJvciByZWNvcmQgdG8NCj4gdGhlIGJ1ZmZlciBh
Z2Fpbi4gQW5kIHNvIG9uLi4uDQoNCldhbGtpbmcgdGhlIHN0cnVjdHVyZXMgYWxyZWFkeSBhbGxv
Y2F0ZWQgZnJvbSB0aGUgZ2VucG9vbCBpbiB0aGUgI01DDQpoYW5kbGVyIG1heSBiZSBwb3NzaWJs
ZSwgYnV0IHdoYXQgaXMgdGhlIGNyaXRlcmlhIGZvciAiZHVwbGljYXRlcyI/DQpEbyB3ZSBhdm9p
ZCBlbnRlcmluZyBkdXBsaWNhdGVzIGludG8gdGhlIHBvb2wgYWx0b2dldGhlcj8gT3Igd2hlbiB0
aGUgcG9vbA0KaXMgZnVsbCBvdmVyd3JpdGUgYSBkdXBsaWNhdGU/DQoNCkhvdyBhYm91dCBjb21w
aWxlIHRpbWUgYWxsb2NhdGlvbiBvZiBleHRyYSBzcGFjZS4gQWxnb3JpdGhtIGJlbG93IGZvcg0K
aWxsdXN0cmF0aXZlIHB1cnBvc2VzIG9ubHkuIE1heSBuZWVkIHNvbWUgbW9yZSB0aG91Z2h0IGFi
b3V0IGhvdw0KdG8gc2NhbGUgdXAuDQoNCi1Ub255DQoNCltEaWZmIHBhc3RlZCBpbnRvIE91dGxv
b2ssIGNoYW5jZXMgdGhhdCBpdCB3aWxsIGF1dG9tYXRpY2FsbHkgYXBwbHkgPSAwJV0NCg0KZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2dlbnBvb2wuYyBiL2FyY2gveDg2L2tl
cm5lbC9jcHUvbWNlL2dlbnBvb2wuYw0KaW5kZXggZmJlOGI2MWMzNDEzLi4wZmMyOTI1YzA4Mzkg
MTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9nZW5wb29sLmMNCisrKyBiL2Fy
Y2gveDg2L2tlcm5lbC9jcHUvbWNlL2dlbnBvb2wuYw0KQEAgLTE2LDEwICsxNiwxNSBAQA0KICAq
IHVzZWQgdG8gc2F2ZSBlcnJvciBpbmZvcm1hdGlvbiBvcmdhbml6ZWQgaW4gYSBsb2NrLWxlc3Mg
bGlzdC4NCiAgKg0KICAqIFRoaXMgbWVtb3J5IHBvb2wgaXMgb25seSB0byBiZSB1c2VkIHRvIHNh
dmUgTUNFIHJlY29yZHMgaW4gTUNFIGNvbnRleHQuDQotICogTUNFIGV2ZW50cyBhcmUgcmFyZSwg
c28gYSBmaXhlZCBzaXplIG1lbW9yeSBwb29sIHNob3VsZCBiZSBlbm91Z2guIFVzZQ0KLSAqIDIg
cGFnZXMgdG8gc2F2ZSBNQ0UgZXZlbnRzIGZvciBub3cgKH44MCBNQ0UgcmVjb3JkcyBhdCBtb3N0
KS4NCisgKiBNQ0UgZXZlbnRzIGFyZSByYXJlLCBzbyBhIGZpeGVkIHNpemUgbWVtb3J5IHBvb2wg
c2hvdWxkIGJlIGVub3VnaC4NCisgKiBMb3cgQ1BVIGNvdW50IHN5c3RlbXMgYWxsb2NhdGUgMiBw
YWdlcyAoZW5vdWdoIGZvciB+NjQgInN0cnVjdCBtY2UiDQorICogcmVjb3JkcykuIExhcmdlIHN5
c3RlbXMgc2NhbGUgdXAgdGhlIGFsbG9jYXRpb24gYmFzZWQgb24gQ1BVIGNvdW50Lg0KICAqLw0K
KyNpZiBDT05GSUdfTlJfQ1BVUyA8IDEyOA0KICNkZWZpbmUgTUNFX1BPT0xTWiAgICAgKDIgKiBQ
QUdFX1NJWkUpDQorI2Vsc2UNCisjZGVmaW5lIE1DRV9QT09MU1ogICAgIChDT05GSUdfTlJfQ1BV
UyAvIDY0ICogUEFHRV9TSVpFKQ0KKyNlbmRpZg0KDQogc3RhdGljIHN0cnVjdCBnZW5fcG9vbCAq
bWNlX2V2dF9wb29sOw0KIHN0YXRpYyBMTElTVF9IRUFEKG1jZV9ldmVudF9sbGlzdCk7DQpbYWds
dWNrQGFnbHVjay1kZXNrMyBteXdvcmtdJCB2aSBhcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9nZW5w
b29sLmMNClthZ2x1Y2tAYWdsdWNrLWRlc2szIG15d29ya10kIGdpdCBkaWZmDQpkaWZmIC0tZ2l0
IGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvZ2VucG9vbC5jIGIvYXJjaC94ODYva2VybmVsL2Nw
dS9tY2UvZ2VucG9vbC5jDQppbmRleCBmYmU4YjYxYzM0MTMuLjQ3YmY2Nzc1NzhjYSAxMDA2NDQN
Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2dlbnBvb2wuYw0KKysrIGIvYXJjaC94ODYv
a2VybmVsL2NwdS9tY2UvZ2VucG9vbC5jDQpAQCAtMTYsMTAgKzE2LDE1IEBADQogICogdXNlZCB0
byBzYXZlIGVycm9yIGluZm9ybWF0aW9uIG9yZ2FuaXplZCBpbiBhIGxvY2stbGVzcyBsaXN0Lg0K
ICAqDQogICogVGhpcyBtZW1vcnkgcG9vbCBpcyBvbmx5IHRvIGJlIHVzZWQgdG8gc2F2ZSBNQ0Ug
cmVjb3JkcyBpbiBNQ0UgY29udGV4dC4NCi0gKiBNQ0UgZXZlbnRzIGFyZSByYXJlLCBzbyBhIGZp
eGVkIHNpemUgbWVtb3J5IHBvb2wgc2hvdWxkIGJlIGVub3VnaC4gVXNlDQotICogMiBwYWdlcyB0
byBzYXZlIE1DRSBldmVudHMgZm9yIG5vdyAofjgwIE1DRSByZWNvcmRzIGF0IG1vc3QpLg0KKyAq
IE1DRSBldmVudHMgYXJlIHJhcmUsIGJ1dCBzY2FsZSB1cCB3aXRoIENQVSBjb3VudC4gIExvdyBD
UFUgY291bnQNCisgKiBzeXN0ZW1zIGFsbG9jYXRlIDIgcGFnZXMgKGVub3VnaCBmb3IgfjY0ICJz
dHJ1Y3QgbWNlIiByZWNvcmRzKS4gTGFyZ2UNCisgKiBzeXN0ZW1zIHNjYWxlIHVwIHRoZSBhbGxv
Y2F0aW9uIGJhc2VkIG9uIENQVSBjb3VudC4NCiAgKi8NCisjaWYgQ09ORklHX05SX0NQVVMgPCAx
MjgNCiAjZGVmaW5lIE1DRV9QT09MU1ogICAgICgyICogUEFHRV9TSVpFKQ0KKyNlbHNlDQorI2Rl
ZmluZSBNQ0VfUE9PTFNaICAgICAoQ09ORklHX05SX0NQVVMgLyA2NCAqIFBBR0VfU0laRSkNCisj
ZW5kaWYNCg0KIHN0YXRpYyBzdHJ1Y3QgZ2VuX3Bvb2wgKm1jZV9ldnRfcG9vbDsNCiBzdGF0aWMg
TExJU1RfSEVBRChtY2VfZXZlbnRfbGxpc3QpOw0K

