Return-Path: <linux-kernel+bounces-44728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AC6842698
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956631C2533C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716EF6D1D8;
	Tue, 30 Jan 2024 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oBfToaa5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56EE6D1BC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706623506; cv=fail; b=qnqmkzYVUbzi5r9id17qAUdMOl1ySmN58F9hckQV0njjqAzcCmqrKTJv0SR5m6lHa6j5XgDhfVNNstftlVFlC/5pJbFWsVUSAUwGJv93nrTv/ixkeLdfoJk759I++AcYFAiXTiqLbjlNUrZT56ELn9iaHC2jGi/JQggcAihY3FM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706623506; c=relaxed/simple;
	bh=wbf/EVlYx6uJCpRfce8BoIRgZwleDFFUpM+vyoBqUXM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P0WCR+kBLr52AhPOi4ybRGGbv8brA6gLKVkQzdMXs6DlhtX9nFrAwCoaEBRS1wOT+5lsglVKuctqgokvGyERrECqT6SWTZY6HZFGIiq3LP8xFYMvZgC2u9hSaVTddAYr2x6Xd15pvwVxpusmYPYGYEsYydR3BG9gAHnb6oBS2N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oBfToaa5; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706623505; x=1738159505;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wbf/EVlYx6uJCpRfce8BoIRgZwleDFFUpM+vyoBqUXM=;
  b=oBfToaa5j8LLs76pG7PHLZhhCwVGRhgMaWBqCmvAl+cF0Z+xThNw2iEM
   8m+EQ5eCqc/5Jf30xx3ahmsuf77SI5RWJ6SDS3VkbtmLiSd1TJkM1J7Nm
   9hJ5vnfcJw+bR5Cv78sixULJ8NMw1bdciIcouTIV/A1+FGMQCkHdGqW4x
   xyA3GmoMmR5izEZjARH0KNnLIaXTGRuRHVmDWecJTxHLxxx47INcepkVh
   1SpxpTo7/VXnyhr5m9YlufHkinlWorAanHyKlsfFakO+mafwtXWygEUeq
   GMftpu0wxETUZ0qCF91iKOW9xsDhn6RCCz6Skzum7R+eDhVWMY1ZmfXC6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2223230"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="2223230"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 06:05:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="858499415"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="858499415"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 06:05:03 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 06:05:02 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 06:05:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 06:05:02 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 06:05:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8aRHwFTCjUm3Pe+UGmLf/OuVs3qpYea7bxK2fPMquuiRJ3xFBKzxiTl0NDQX4gwHAgH/1Geu01D106L/U3+bQO7MrnqjQ2GS+lFz2e3DLi8Z/kk5ZDGyYnKpOKFw2ySRZsBZjPk/m2XxiF9x65j1lKRy7SybRtuIwf2vb5BmHcJfJ/wsagTCJ3ArtNJsVKGbtkqfyH3KdfISrocYD6270U1/wAobkTm1axk9KZ+SwmunHLgUuoaIarleZ1dhZ59n6utzFujjZ6M/mj3qAavetDobwXgzyA4ZG4oiM/WtePaeXvq3/E6c8yQ6cEZ53lmtllkCg2wHqrOwD6VK/cCGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbf/EVlYx6uJCpRfce8BoIRgZwleDFFUpM+vyoBqUXM=;
 b=DlHYzlbjFu4cHf2Z8T7S8UDc8dj1l5IfADXhhCaXjGk8xb1O+BpFH9jaUiGI9DCIDokoKjIH2JQH2JlxCN9S/VMK/WJd7JL0CHOV9pV2fxSttzl+9ml7ioiUUWC7UTGFr+107WIxWJUyaPXqfXkVLRSHp23M6/s/o+XnS9flstUP227HHqjIRA9fFzaSq8ArJUeGyuMXs/tPPJBSwEztS3UTk05EKbtVHRZiaJWGWnxl4idDaLrvhi6DDbPMg3H0ZmsBYsLGgfiZ6LmIsDkdAKYiz9IaxhYWo2WtW1A7ISCFioX1jU8we+6ixbAMiTgGdiyNF1BkL5mIhwmPOCizeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW3PR11MB4666.namprd11.prod.outlook.com (2603:10b6:303:56::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 14:04:59 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::124d:fbd5:113b:16ec]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::124d:fbd5:113b:16ec%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 14:04:58 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	"Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>, "Nakajima, Jun"
	<jun.nakajima@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
	<ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, Baoquan He
	<bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv6 00/16] x86/tdx: Add kexec support
Thread-Topic: [PATCHv6 00/16] x86/tdx: Add kexec support
Thread-Index: AQHaTsTUrJt5Lc/78EGyyMMPX3aqzLDyZwKAgAAEK1A=
Date: Tue, 30 Jan 2024 14:04:58 +0000
Message-ID: <BL1PR11MB597817CB5F0C8E3D7B51FE81F77D2@BL1PR11MB5978.namprd11.prod.outlook.com>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <3f44458f-2b4a-4464-a3df-cb791298dafc@redhat.com>
In-Reply-To: <3f44458f-2b4a-4464-a3df-cb791298dafc@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MW3PR11MB4666:EE_
x-ms-office365-filtering-correlation-id: fad5fbb9-aa31-4ea9-15fc-08dc219c7194
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DRKImR3OZc3hJ6cXixOqBssrwyXRuvdoMvdt5OeTVLP2DkQE1g+Yus/Al5JV33ULVQACgfnubEHKGgP/DN+7o4tWilmCrBbtsk5giXw69eCnlBSK7XN5Pr4VS20Ir/sE6alGDYYjflV2kTx1u+yDpmZtOxQ77eKAQQuhzMUBEQNhm5HHCnZA1D0fqloIoJKNthfqmiHEfr1JtLa83UQWbO4UxdSPlnoDutKnYcy0eTLEZX2ZrI88wHdXgLKTffMvVipzmUdQNegYKs7EC1Xxe4N2WpGc0KVu7mfzfHVXMKVAnizZWoWGa27qhls1dfk4X8+OSEKwYud1l1/s/EfByNjEWC4R6UM1AZQIm2j7R+6sNzIpjs1XAtSNaVY+u+uTKRXsZVGOq6XK1a33cpT698x98M9kd3sPw317vX8WQgXegZerGYSvoELLiX/MxrvpxHqQkPbkXOipH+R/Cc8DtIDadsbGDAc3euNA3rYCYgHT/ynhCO0/1NDh7AcDzMDZE0212WQSVsWQicZdbhPYCh/cfbTr4D03LB84DsxRM9bUVB6CV8ukEompjFl7N6OVdwxgIMTQN6QZWqV2hGd8OOXK4fGe35DQmPrNWkhGw6dAlR4zKn9V0tsRtcrZuGoG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(8936002)(8676002)(52536014)(4326008)(38100700002)(110136005)(66446008)(66556008)(122000001)(66476007)(54906003)(64756008)(316002)(76116006)(66946007)(38070700009)(33656002)(41300700001)(4744005)(2906002)(86362001)(82960400001)(7416002)(5660300002)(83380400001)(7696005)(45080400002)(9686003)(71200400001)(26005)(478600001)(6506007)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkRVTVoxU0x5TEQydFdxVFA3SERrK3VqRWt1dmxSa01OdmlzSTR6MHNBUkVL?=
 =?utf-8?B?L3BsNlpVVU9FN0dJNk9zaWdDb055RlROcElrTXNHKzVlVWhuSnNyeDFEMll0?=
 =?utf-8?B?MG5jMFZKb1BlT2hNY0dSemZwQlV4WW95blEvcW81NkVqWEcvTDFsTmZ1bVFi?=
 =?utf-8?B?ck1ORytJZXVrQjNtK0dyRHVzUmZseXZVbnJpUDdwZXA2QXlvYzU1N1Uwa0ly?=
 =?utf-8?B?LzRUL2pKKzQwNFMvYkF4REZxSFFCZ0pJS1h0K01mNlBlMlo2RGlRK0trSGFm?=
 =?utf-8?B?QUpXWnYybkhER3dHaStOb3BLTWUxeFhGK09Sb29mbENFcXpIS1dXNDVRc21t?=
 =?utf-8?B?UlVZYkczMGdJNGo3THZiYytlMHh5NVhmSlV0NGh1WVRPVUhFaFpMdXRMUDZv?=
 =?utf-8?B?UFJ1YU9IVWV5amgzTFA2L3RQalZ6TUtwTnIxbTJ1L251Ym85cnVHNjljS2hE?=
 =?utf-8?B?TWZzNEoxMlQ4a0Z1dWdRdjZlUkc2RDRQRmNJYXJkUGorY3hHKzRaZnRtOXd6?=
 =?utf-8?B?K1FKcGY4ejJuMG1UN3JYRGdVeXhtUjYrREtUWkRKbWUra0hUY25QYWp4S1BM?=
 =?utf-8?B?c0RSVUc5WVpGamhGdkJ1RERDUU05R2ZnbzlFMVVBY3lLNFBLUGZGOCthTGZ0?=
 =?utf-8?B?eFZ3bmNwb2Fxd2JHL01VZXhkR29BdW9QNGVpcUN4bHJpdEZheVFRUkVBLytn?=
 =?utf-8?B?SUQ5VXUvOVROM1R5STF0djVYTXVUbWRZdFVrdDZFUmNSV1QxeUpxY1habkNw?=
 =?utf-8?B?eVphMUNTRmlFWlZVR1VWVThYMGtZdnNRajB3dDBuakFqNWh6YzUrSnpiUXhv?=
 =?utf-8?B?SVpVb0dRTzNtc1F1bDVUeDBwaTRoUUx3OU55OHpBUEQ0RWFuRnN2ekFFWHBu?=
 =?utf-8?B?MHpqa2QycHlOTGpOYnFmOTlYSHFQRTBVVXlqbWRaMGVNZ3BGUG1XdjRHZ1Y1?=
 =?utf-8?B?aFkxSGcza1BsZXR5UmllcjFmQnJvNDA0d3NRSGlmZW9TVGpmVFNodHl2QXBP?=
 =?utf-8?B?dkFaNWF2bVRTRHM0Slk3ZFVqWVJPc2JRallhcGM1RmNoQnlSMHdhSnRFWVJB?=
 =?utf-8?B?em1IV1kwVTYvc3N5Z2FEUHBtZ0JvQ1EzdlJzb09mc2NlR0xCTE1rKzVRVFYy?=
 =?utf-8?B?RzFQNjRETjJmY29jaE9uc25MaHZZVGpkMjJVQzhmZllsSE40dUlmQ0tSd0VS?=
 =?utf-8?B?dCtGRWRDaGNtVXZmeXc2MzNCSzRFMTZoVHNGR1BWU1lCQnZra2tUZy9uRDlX?=
 =?utf-8?B?ZFdqeDBudDJqd3NaZStIR2xjL2M2clBZYTZ5Y1h6bTgwSzZJWUkrWjZ2ZFg0?=
 =?utf-8?B?bGV0bVlJaUpKRUp6MWhjWWoxa0plbDBjbGlIUTRtaHdXdjAzc3Jhck50T281?=
 =?utf-8?B?dkhpVUluMkhxQWJDOWVmOWQwTElWM0R5eWJ6Y3EwZGQzQWIrMW1vQ3F5bktY?=
 =?utf-8?B?ei9CS0drUTN6c2dHNUhMMlhGQk1hRzA0c0JITVBLS3orK0x0ZHNodGlobkZB?=
 =?utf-8?B?OFUwVXM5TTRET1ArVTlCYUdoMzNpT0xkVk5nQURCYlRDSkFNdnJCWW90dHFF?=
 =?utf-8?B?MUMxTUdFRkNrU0x1bERPeWVNNUxpdzhBMmJOUjNlNFJ1Q2JOR0RROEViZ1Jo?=
 =?utf-8?B?ZHJoRGRqaE5TMFNXaEFrYkluS2lubC9YcU5RdEYxc1JTTzYxV3dSd0tMaUVP?=
 =?utf-8?B?c2NCa0FjRytnUDUrU3h2V3RmdzBNL2R6bjF4d29GbGZ4am1oQkpmVU1uM2VC?=
 =?utf-8?B?OTB4dUlyMG84ZXdCU1pkZG84Rm9DZWJ4UWYzL3l0dFloWjdqbll6WHBUaTZz?=
 =?utf-8?B?L1pRaU5BK2ptd1U5RDc0ZTZhaWpNUTdrSnIvczkzKzVkOEdKVW9WTTVZR1ly?=
 =?utf-8?B?TG9KbS9UNHM5bzBudzRGaE5qT1Z2Q0d2MVlLbWpoOHFlV2Y0dGc5ajZnRDYw?=
 =?utf-8?B?aW4yZm1HQnZLRTQ2Um03SGVITWNsdkhyRXpKazNLeUp6VGpzTE9ZeDZqZEtx?=
 =?utf-8?B?NFAvWGdjV21aSTZ6WWMxaVdkMEk5M3VBbDIyMXdSY1FWNlBaTzM2OG4zcjdH?=
 =?utf-8?B?UWVGWVBBbkpIbGV1OUViMkhBNXNENlBxVDJseVVWNG54K0J1QldNdW9sSGZy?=
 =?utf-8?Q?1FkiaHHDTGU6hPa+w37jkSZ0e?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad5fbb9-aa31-4ea9-15fc-08dc219c7194
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 14:04:58.3599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LHcIykk2qkWGCNDeg9KtD3hnuAvQ/tHcb6fVsupr2MIj737hGcMEFdezsdGJ1yVsnbeSOFmBw/+Lnkkjpeog/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4666
X-OriginatorOrg: intel.com

PiBIaSBLaXJpbGwsDQo+IA0KPiBJIGhhdmUgYSB2ZXJ5IGJhc2ljIHF1ZXN0aW9uOiBpcyB0aGVy
ZSBhIHJlYXNvbiB3aHkgdGhpcyBzZXJpZXMgZG9lcyBub3QgcmV2ZXJ0DQo+IGNvbW1pdCBjYjhl
YjA2ZDUwZmMsICJ4ODYvdmlydC90ZHg6IERpc2FibGUgVERYIGhvc3Qgc3VwcG9ydCB3aGVuIGtl
eGVjIGlzDQo+IGVuYWJsZWQiPw0KPiANCg0KSGkgUGFvbG8sDQoNCihTb3JyeSBJIGFtIHJlcGx5
aW5nIHVzaW5nIE91dGxvb2spDQoNClRoaXMgc2VyaWVzIGlzIGZvciBURFggZ3Vlc3QsIGJ1dCBu
b3QgVERYIGhvc3QuDQoNCkZvciBURFggaG9zdCBrZXhlYyBzdXBwb3J0IEkgYW0gd29ya2luZyBv
biBhIHNlcmllcyB0byBhZGRyZXNzLiAgSXQncyBpbiBJbnRlbCBpbnRlcm5hbCByZXZpZXcgYnV0
IEkgcGxhbiB0byBzZW5kIGl0IG91dCBzb29uLg0KDQpUaGluZ3MgZ290IGEgbGl0dGxlIGJpdCBs
YXRlIGJlaGluZCBvcmlnaW5hbCBzY2hlZHVsZSBiZWNhdXNlIGN1cnJlbnRseSBJIGFtIGluIHRy
YXZlbCBmb3IgQ2hpbmVzZSBOZXcgWWVhciBhbmQgc29tZXRpbWVzIG5vdCBjb252ZW5pZW50IHRv
IGdldCBhY2Nlc3MgdG8gTGludXggbWFjaGluZSBvciBldmVuIG5ldHdvcmsuDQo=

