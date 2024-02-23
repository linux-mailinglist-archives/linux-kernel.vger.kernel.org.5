Return-Path: <linux-kernel+bounces-79080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3FC861D52
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFEC11C234BB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E13146915;
	Fri, 23 Feb 2024 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JdEOnPmc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A8C5D490
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719180; cv=fail; b=jHERuzNEC2cnDP25C7tTxRwpJMvX8yYkZsUe77SuB2LPIViBsMbN9kjS41+wZDf4rwBfE3PDNdiK0D3pHW6BvRxTHo10pxRoDx52YRC0+3ZuU9shZsv1G49QMnpvLALCUfIIVGVOol4t1fzKeOypbsJvh5kS9yzbf9dMLhU7hPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719180; c=relaxed/simple;
	bh=QZ9aB2CAJfQfxEQp06XXDlOzYuARaGKsFKk2Qd8J050=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VbDCftYVBNsqwriRPGzwCIThxJe6n6YJd67w0FJhlNkNdMyKJSEqpQPQRhElbVPfZxdrV1A701Lm4eUjZ1GmbTAZgKvcIlaFF65ukFKXS09QYF+LFGCM2Sq4WvZKZv3hokYvjVUVR1OkidoK1ZbIpDJ0OEV/VFGPKWiJUC+1t4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JdEOnPmc; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708719180; x=1740255180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QZ9aB2CAJfQfxEQp06XXDlOzYuARaGKsFKk2Qd8J050=;
  b=JdEOnPmcf7hFB014SpB6+XTvTSR/q4kHzBAAqjBHPnerjhB29Bk52ka7
   L419HIHthO9ijefezm8i+jtA5xr94BpA0YFg8mesnX2WPhscTrRKTSaQm
   +SJGJuHUv08vME/Y9yD29wUFrlf1NwFkCTkPWU+qPM19ELdMbLLlYSgVa
   cC7Vu1hdriMJPlryKZC7UU0quNYxtAcWURB9Zt/CwNtyW5kmMdCBQ6vEP
   EbUjCJaE3esDL/JNnM8osEKmdT/wu/2M/rSu4UJbO1jHyb5UAOjXQ4RLU
   dQkMp0mlPLMMH7+F8mOUp+b4EPlffE/IP38ciQwF5/U4zEcyj+kmysymc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="25530811"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="25530811"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 12:12:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="36784677"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 12:12:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 12:12:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 12:12:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 12:12:57 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 12:12:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSSESDc09iM1MklU1jP+7GbuF9P+ZTiV5fjM5Tj1xzpptpZIKuIOf6RCO1NaYJxac4VglH1OnYlwmEPeA/UMQPMga9kWEdwS8I86WRkLhQ2ZbPz962ucLtABW9F9vAp8Fk9Kamy++43E0pL5yhDZpDUuqfxRDKkXIcRx8KwtqErPMKOv/JhSXhvOBpfkKDMO8vb6nHUBlw8CtRjgZTHt6DhhvwCDFBP/OlLYxZO6GD6XyTag7opGd5pbfDIJrY25dZZL3uIf+tWb2tmPD74Kutad7VCaLLZUGKaAqGyVsY0pEDVOJ5/jVXkL8kOckdWsITZLQFrALAo+kkBzQP1CiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZ9aB2CAJfQfxEQp06XXDlOzYuARaGKsFKk2Qd8J050=;
 b=bX6R5rjFfkDLzQdlB1n6TY3SSm8mzfdTIsAW7HtL1+fo3VIA+1AsosUN9tzj7b1DPRr8ZdnVhlX4lNCWCizDsQnpMt/3tcuITD0JMeNn6LO5H+VBggy59MTVxrJ1vqx6PuAraTbV6p+1Cso+mpuSxzXClPvPE0Bhu8Ksd9zf6IrPvu/VaSHSfBb9EyNNjn1HqTHzi2GnXBkQT/xd8yWboV5buMFTkgsZ4aj7mdBTnrcayIIbAelN92+O+OL9PCzVwfHyPyx9WEhTAPJ+iSxnRhRITZMYBRJAusBCNOSO8tURydryXUx0MqqoaP+5Ad5aggKh8PTlvIDLSNGub8RYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6424.namprd11.prod.outlook.com (2603:10b6:8:c4::8) by
 DM4PR11MB5455.namprd11.prod.outlook.com (2603:10b6:5:39b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.10; Fri, 23 Feb 2024 20:12:55 +0000
Received: from DS0PR11MB6424.namprd11.prod.outlook.com
 ([fe80::b263:53b3:c993:3021]) by DS0PR11MB6424.namprd11.prod.outlook.com
 ([fe80::b263:53b3:c993:3021%7]) with mapi id 15.20.7339.009; Fri, 23 Feb 2024
 20:12:55 +0000
From: "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To: Russell King <linux@armlinux.org.uk>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] clkdev: Update clkdev id usage to allow for longer
 names
Thread-Topic: [PATCH v2] clkdev: Update clkdev id usage to allow for longer
 names
Thread-Index: AQHaZnZVyb+ntBY6PE6Aidjrz3mClbEYMnAAgAAJ6SCAAAQHgIAAFYuAgAAF91A=
Date: Fri, 23 Feb 2024 20:12:55 +0000
Message-ID: <DS0PR11MB64240F474B2D2A92D0A3BB2EC1552@DS0PR11MB6424.namprd11.prod.outlook.com>
References: <20240223163516.796606-1-michael.j.ruhl@intel.com>
 <ZdjZCrpP52Hfbs6L@smile.fi.intel.com>
 <DS0PR11MB64248E0C15C0B86A1CCF945BC1552@DS0PR11MB6424.namprd11.prod.outlook.com>
 <Zdjku0kxCvMl2HcU@smile.fi.intel.com>
 <Zdj2zaicBvkTOZZe@shell.armlinux.org.uk>
In-Reply-To: <Zdj2zaicBvkTOZZe@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6424:EE_|DM4PR11MB5455:EE_
x-ms-office365-filtering-correlation-id: 938e3b65-133d-4582-f5af-08dc34abd2ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6GuP0shNdmwKOnd5+WT2/8JIOpqgynEPiKAh6l2BI93MoVkgHyDB/rs8Aa2/qR1tauqAHrhOa/EO6LyvJQMHmsX1DaT6J/f9/gLHTgYyPz8M7o1PwxBIPqIOmvZ0064wet2BdPJ/D2Loq7r0/JwvHjuYGRjt1rzBWtZHtnm9E2ePYSOKSPDsz6TaL47Oi0g4CDxyiwfIrDivB2k4nXk9vPcrxBKnIrqu/3OVw3BFDS7BYYRIy1ahoAvatmH9bjgLJGk7f43Fr93nUHOmJAP607oppTF2WE2PJw1Fpr8XDJ3qJHIzR5XNlvdP8gEU/1Q1fHce+6Deyq7rxIzpfJFBIkC6r6K4kzWBEOyk6HzOqp/DGDaPfonTcKtBY1pN/qgj+iodHBoQoxflbX4Sgjyj2H2h6U9LIWROcvRD6n2yJEfhnPyrTHKggqZU6b8ZfEWNms3kQpg1TX++tPLIrOf2Mpt3nfRN3yp12R2cHVJfm71WtxH2x+5dFi/R1zJv27dO6T8ZOUebhDHmU80XWp7l90UmAfE4RPqmXyG6nBLpNmAt1MFiM8zjBsfnrzuCgTI0uiwLeSyK82d8C1cKGIx24iPWzyRehmD0fIdatcAD2co=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2pSYThNV1g2QlpUdUluK0hxQ1ZjclNYR0JKNlorc3JFUlIwbnZxY1hjdGJZ?=
 =?utf-8?B?MFFvNGcxMm5sNlNFWGJNc0ZiVnM1WDRnSjJWckpnUFo1L0IyUDROVi9pVHNN?=
 =?utf-8?B?c1ZsWnVVZkZGaFY5bTR5MjFJUS9FSURJQ0ZqMGNaM0RSdEE1VGduTGI1TWdR?=
 =?utf-8?B?MGEwWFl5SElFbnRjV0RlaWRHeUpaRDF0akdFQVR1MDBnVHgwWHlhNmFCLy9E?=
 =?utf-8?B?WjZVNmk4aFhpajlxYXNJM0dta0hIL3U5WEdXeUVnTXpNdUdrcE04NHRHYXkz?=
 =?utf-8?B?Vk92RkZzMXpNS2ZhczlacjRTNExZYWUzVThnU2RHTnZsNjdVeGRXNDNNdVV0?=
 =?utf-8?B?NUJLRE81Skx1aEVlNy9vbXROcHdUK1NTcU5hTXdkK21McExBb3NvcWRUNUpp?=
 =?utf-8?B?TEFxWUNVdVlLMEVGT2IzdUhtNVh2d2lHM2k5NXNVUE41bW9FR0F1dVNVTG5V?=
 =?utf-8?B?b3ZhYUhVVDBZQkUzdVN6bUUvUVJJYlVEdEt4a2hKRkNXSzBMYmV2MXhKZEhD?=
 =?utf-8?B?WHljaUNXenZUUE9CTDhWWWZVejBnSXhWYVg3aUNTZmJETzZKNWd2M050MjBO?=
 =?utf-8?B?c0YyUUp1S2VkejRlSXZMM3JaRXlwRlhjcjRzVmk1YjI1ZG1mYjJvVjZmQWNY?=
 =?utf-8?B?R3hrUUxTN2lDR3RvN3VyQXNZODRHc3E4Z0J2Zk1pTXp2OWVvUUlFL0Q4cGNX?=
 =?utf-8?B?L0R3WkI4dWpDbURpWHJRYU85Sk9ORUdsWU5ML01CQk9sL1ViMHVST1h4MXRh?=
 =?utf-8?B?aW91VVB4NHVNbG8yTFhSd2FhSktHYTFXRjAzRlVSV2VOQ09DOXZXYzcybVpE?=
 =?utf-8?B?NmZNV3AvcmFQUkpCU2Qza1FGNTF4eFJXWGdTWmJJYkFvYVpDSzluZzhXVUV2?=
 =?utf-8?B?dWxsSVBKeXk3WENrQmJTczk1WHFDREVqSFBtdlFRQ1VMalpDTkJjanhudzZ6?=
 =?utf-8?B?dllyK1FvZkR6OHllSGZOMGM4anNuR2ZrSG9SRjZNVGlvR1ozaXN1ejNndEJP?=
 =?utf-8?B?ejZObnpGR3g4MEsxcjkvMmxNd05PRldVQ0RXckVvbmhVbjI1RnFZTWhCZXcr?=
 =?utf-8?B?LzdUMUdTWk1EQUZ0U0xkeTdyb0NvelVDekwvQjJ5a3ZJT3J2MmdDY3Zhaksw?=
 =?utf-8?B?NXhET1FIN0JnbGNVNGtYcDk1TkEzZEw4b0FRYjJ0Z1B0TGM4dzBTRS9ZcjY0?=
 =?utf-8?B?Y3hMMlV1TlVkOFM2MzV0Y2lqTHRHM2xUeXd2YUtObFI1S1Y5S29TSXlWdkNY?=
 =?utf-8?B?MlZnb056Q0U1L0twYzlCRGY2V1pQV2lSdHVoamZGMUZxWVZHT0FlWEdQdVBD?=
 =?utf-8?B?K2h1STJSWW1LUDdtNkMzSjNKU0xabzdnS2F2RmxWTTNRY1l1RUw2WkRkNkpD?=
 =?utf-8?B?ZEpyUDBMZk9tNVE3ZDQvOUFGaERNM2d5a1NESytLSlc0Tzcwa0RLT0VkMWxy?=
 =?utf-8?B?UVRJTUVHMHk5Q2NQVEo4OG9MeldqUHNPcFFIOXppcWF6Qlc1SGNHUG9vSVJw?=
 =?utf-8?B?Y1g5WXE0UGdRQmE3QXFIcjI4TkVzSy84VjIvdFFyeEU1Q3N0bkMvcWFTTWtw?=
 =?utf-8?B?OEFsNTNpMXc3WmVLOUM5RWtBUW9xY0hyY2hCbmhOcDZWNmFWa2RPR1J5SEdi?=
 =?utf-8?B?dlBVKzlEY0c2UENVL1ZoK0FvWllBWlFxSjVuNGtheEYxSW1hSk1JREtlRXdR?=
 =?utf-8?B?TU53dnl3dUJTK2dlMUZJZDkrcHBBYVNSbSs3aG1OMC8zRHJrdG56bDUyNmFo?=
 =?utf-8?B?S3MrYU9Qdm9heUdkLzV3MGxqd1VBcVdadmx0LzFFN0kySFpObWZLUHJ0T0Fs?=
 =?utf-8?B?NGFTL2owNXJXeitCM3NYSTE0bGw3VXo4cGpMSzVWN0NlUm5VL2pyV2J0MjZI?=
 =?utf-8?B?TjNVRWc4R1ZUdVFzYWUzOFZaS011bmYxb0Y4cTVFRU5IcW1QS3B3Rnd2K3Bi?=
 =?utf-8?B?c0hiamcxZmZJenQyQ0p4UENEdjJMZ25rd2ZzKzdwVE4yVXZJbVZWYzRycG9K?=
 =?utf-8?B?azZkeVRJZ2s3Z0dXcmQ2RG5ReUdnU0RvbytjcGFNaXhqRFVsQTZhUzRXVEhB?=
 =?utf-8?B?azFybFd2b3lGb2tTdlBXVFY5bVBKL1VvemdPdEc1VFVESmJWRHdhM01YU2E3?=
 =?utf-8?Q?O8v6xAUjiA3CUhHJ1ZH1ysLpF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 938e3b65-133d-4582-f5af-08dc34abd2ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 20:12:55.7755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kvN8offY12g/w/yCiMzbkl60G+OPSlMV09J2JHkoCjDB2YeGYTonTmYqRQOBe0UUHbri8jaDgpB7gP6VvOlZHDtC+4aK3vU4xA5FiESDDIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5455
X-OriginatorOrg: intel.com

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogUnVzc2VsbCBLaW5nIDxsaW51eEBh
cm1saW51eC5vcmcudWs+DQo+U2VudDogRnJpZGF5LCBGZWJydWFyeSAyMywgMjAyNCAyOjUwIFBN
DQo+VG86IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29t
PjsgUnVobCwgTWljaGFlbCBKDQo+PG1pY2hhZWwuai5ydWhsQGludGVsLmNvbT4NCj5DYzogbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gY2xrZGV2OiBVcGRhdGUgY2xrZGV2IGlk
IHVzYWdlIHRvIGFsbG93IGZvciBsb25nZXINCj5uYW1lcw0KPg0KPk9uIEZyaSwgRmViIDIzLCAy
MDI0IGF0IDA4OjMyOjI3UE0gKzAyMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4+IE9uIEZy
aSwgRmViIDIzLCAyMDI0IGF0IDA2OjIyOjEzUE0gKzAwMDAsIFJ1aGwsIE1pY2hhZWwgSiB3cm90
ZToNCj4+ID4gPkZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXgu
aW50ZWwuY29tPg0KPj4gPiA+U2VudDogRnJpZGF5LCBGZWJydWFyeSAyMywgMjAyNCAxMjo0MyBQ
TQ0KPj4gPiA+T24gRnJpLCBGZWIgMjMsIDIwMjQgYXQgMTE6MzU6MTZBTSAtMDUwMCwgTWljaGFl
bCBKLiBSdWhsIHdyb3RlOg0KPj4NCj4+IC4uLg0KPj4NCj4+ID4gSSB3aWxsIHJlbW92ZS4NCj4+
DQo+PiBOb3QgcmVtb3ZlLCBidXQgbW92ZSB0byB0aGUgY29tbWVudHMvY2hhbmdlbG9nIChhZnRl
ciAnLS0tJyBsaW5lKQ0KPj4NCj4+ID4gSSBzZWUgeW91ciBzY3JpcHQgYXV0b21hdGljYWxseSBk
b2VzIGEgY292ZXIgcGFnZS4uLndpbGwgdXNlIHRoYXQgZm9ybWF0IGludA0KPj4gPiB0aGUgZnV0
dXJlLg0KPj4NCj4+IE9ubHkgaWYgdGhlcmUgYXJlIG1vcmUgdGhhbiBhIHNpbmdsZSBwYXRjaC4N
Cj4+DQo+PiAuLi4NCj4+DQo+PiA+ID5bMV06IGh0dHBzOi8vZ2l0aHViLmNvbS9hbmR5LXNoZXYv
aG9tZS1iaW4tDQo+PiA+ID50b29scy9ibG9iL21hc3Rlci9nZTJtYWludGFpbmVyLnNoDQo+PiA+
DQo+PiA+IFVzaW5nIHlvdXIgc2NyaXB0IEkgZ290Og0KPj4gPg0KPj4gPiBUbzogIk1pY2hhZWwg
Si4gUnVobCIgPG1pY2hhZWwuai5ydWhsQGludGVsLmNvbT4sDQo+PiA+ICAgICAgICAgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnLA0KPj4gPiAgICAgICAgIGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4+ID4gQ2M6IFJ1c3NlbGwgS2luZyA8bGludXhAYXJtbGludXgu
b3JnLnVrPg0KPj4gPg0KPj4gPiBNeSBsaXN0ICh1c2luZyBnZXRfbWFpbnRhaW5lcnMucGwpIGlz
Og0KPj4gPg0KPj4gPiBsaW51eEBhcm1saW51eC5vcmcudWsNCj4+ID4gbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+PiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4+ID4NCj4+ID4gVGhleSBhcHBlYXIgdG8gYmUgdGhlIHNhbWUuLi4uDQo+Pg0KPj4gQWgsIHRo
ZSBSdXNzZWwncyBlbWFpbCBsb29rZWQgbGlrZSBhIG1haWxpbmcgbGlzdCwgdGhhdCB3aGF0IGNv
bmZ1c2VkIG1lLg0KPg0KPkpvZSwgSSB0aGluayB5b3Uga25vdyB0aGF0IEknbGwgcGljayB1cCBv
biB5b3VyIG1pcy1zcGVsbGluZyBvZiBteQ0KPm5hbWUuLi4gYW5kIEkgdGFrZSB0aGF0IGFzIGFu
IGltcGxpY2l0IHJpZ2h0IHRvIGNhbGwgeW91IHNvbWV0aGluZw0KPm90aGVyIHRoYW4geW91ciBw
cm9wZXIgbmFtZS4gOkQNCj4NCj5TZWNvbmRseSwgYmVjYXVzZSB0aGUgQ2MgY29udGFpbmVkIG15
IG5hbWUsIEkgZmFpbCB0byBzZWUgaG93IHlvdSBjYW4NCj5jb25mdXNlIHRoYXQgd2l0aCBhIG1h
aWxpbmcgbGlzdC4gTWF5YmUgeW91ciBzY3JpcHQgdGhhdCB5b3UgbWVudGlvbmVkDQo+c3RyaXBz
IHRoZSBuYW1lcyBmcm9tIHRoZSBlbWFpbCBhZGRyZXNzZXMsIHRoZXJlYnkgYWRkaW5nIHRvIHlv
dXINCj5jb25mdXNpb24gLSBhbmQgbWF5YmUgdGhhdCBpc24ndCBzdWNoIGEgZ29vZCBpZGVhIGFm
dGVyIGFsbD8gSSdtIG5vdA0KPnRoZSBvbmx5IG9uZSB3aG8gdXNlcyBsaW51eEAuLi4gVGhlcmUg
YXJlIHNpeCBwZW9wbGUgaW4gdG90YWwgbGlzdGVkIGluDQo+TUFJTlRBSU5FUlMgd2hvIGhhdmUg
YSBsaW51eEAuLi4gZW1haWwgYWRkcmVzcyB0aGVyZS4NCg0K8J+Yig0KDQpBbmR5J3Mgc2NyaXB0
IHBpY2tlZCB1cCB5b3VyIG5hbWUgZm9yIHRoZSBDQy4uLiBJIHN0cmlwcGVkIG91dCBhbGwgYnV0
IHRoZSBlbWFpbCB0ZXh0DQpmb3IgbXkgcG9zdGluZy4uLiBzbyB0aGlzIGlzIG15IGZhdWx0Li4u
Lg0KDQo+DQo+PiA+IEkgZG9uJ3QgaGF2ZSB0aGUgcGxhaW4gdGV4dCBwYXJ0IG9uIFJ1c3NlbCdz
IGVtYWlsIChsaW54dUBhcm1saW51eC5vcmcudWspLi4uDQo+SXMgdGhhdCB3aGF0IGlzIG1pc3Np
bmc/DQo+Pg0KPj4gWWVzIDotKQ0KPj4gQnV0IG15IHNjcmlwdCBhbHNvIHVzZXMgYSBoZXVyaXN0
aWNzICh3aGljaCBpcyBub3QgdmlzaWJsZSBoZXJlKSB0byBhZGQgYWN0aXZlDQo+PiBkZXZlbG9w
ZXJzIG9mIHRoZSBjb2RlIGluIHF1ZXN0aW9uIGJhc2VkIG9uIHRoZSBnaXQgaGlzdG9yeS4NCj4N
Cj5UaGUgZGV2ZWxvcGVycyBpbiBxdWVzdGlvbiBmb3IgdGhpcyBwYXJ0IG9mIHRoZSBjb2RlIGlz
IG1lIGFuZCBub3QgdGhlDQo+Q0NGLiBUaGVyZWZvcmUsIHdoYXQgaGFzIGJlZW4gZG9uZSBieSB0
aGUgcGF0Y2ggYXV0aG9yIGlzIHJlYXNvbmFibGUNCj5hbmQgbm8gc3BlY2lhbCBzY3JpcHRzIGFy
ZSBuZWNlc3NhcnkuDQo+DQo+V2hpbGUgbXkgbWFpbiBnaXQgc2VydmVyIGlzIG9mZmxpbmUsIEkn
bSBoYXBweSBmb3IgdGhlIENDRiBmb2xrDQo+dG8gcGljayB0aGlzIHVwLCBzbzoNCj4NCj5SZXZp
ZXdlZC1ieTogUnVzc2VsbCBLaW5nIChPcmFjbGUpIDxybWsra2VybmVsQGFybWxpbnV4Lm9yZy51
az4NCj4NCj5NaWNoYWVsLCBwbGVhc2UgcmVzdWJtaXQgd2l0aCBteSByLWIgbGluZSBhYm92ZSwg
YW5kIGluY2x1ZGUgdGhlIENDRg0KPmZvbGsgaW4gdGhhdCBwb3N0aW5nOg0KDQpJIHdpbGwgZ2V0
IHRoZSBhcHByb3ByaWF0ZSBuYW1lcyBsaXN0ZWQgYW5kIHJlcG9zdC4NCg0KVGhhbmsgeW91IQ0K
DQpNDQoNCj5NaWNoYWVsIFR1cnF1ZXR0ZSA8bXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb20+DQo+U3Rl
cGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPg0KPmxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmcN
Cj4NCj5UaGFua3MhDQo+DQo+LS0NCj5STUsncyBQYXRjaCBzeXN0ZW06IGh0dHBzOi8vd3d3LmFy
bWxpbnV4Lm9yZy51ay9kZXZlbG9wZXIvcGF0Y2hlcy8NCj5GVFRQIGlzIGhlcmUhIDgwTWJwcyBk
b3duIDEwTWJwcyB1cC4gRGVjZW50IGNvbm5lY3Rpdml0eSBhdCBsYXN0IQ0K

