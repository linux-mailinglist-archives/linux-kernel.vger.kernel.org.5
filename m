Return-Path: <linux-kernel+bounces-42275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DC483FEEE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D9428550D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF874E1BA;
	Mon, 29 Jan 2024 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BhHyln8n"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B834D595
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706512512; cv=fail; b=k23Z5jihbEfRzVnB8j3jJ80v9QdlaLMuqgv+3Y06BC71aGkazRr/utB8utrpbvFNPvIcKUMB7UadbI4Lt2NcGDRNBolmkKwrHnQhGmUBlg2W+wuzok7HVsLpLgC+DEOKIyHUS6ZjLWBFlGE+cIGhmAiHLzYWVZoTShPF/sxqwvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706512512; c=relaxed/simple;
	bh=aJDiVvypKapbfzKy3tShOUPYYd4OzQYO+g1MVpKEQzA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k9QXIOHmyDzxHU/lO4QAxgSyEXOAR35TrWvV04nKpH3axIo5GbQLJawasiJmNE+jp6R7a7iyR1ZRPDA68JScGJwn8coKREWuDYFSvdiEW0FX5uBqdDTETUB8MrVAlVfl92Xo7V11SUHZTAyFWYsewXKnpXPZ7CPPMOcWCnCitOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BhHyln8n; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706512511; x=1738048511;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aJDiVvypKapbfzKy3tShOUPYYd4OzQYO+g1MVpKEQzA=;
  b=BhHyln8nISgErAO8TO+BcDUqOjUvMFA7oEF75/iTgFHtC8uJekv6Lrtx
   NwFSI0xDqWxIiYsTIasJ1h2spi8juyYWiGlsatOsm79J92SR6oAEinPro
   WV7gwsHZY1QYmGs8Ep6ezTF9GpLOfl5aixQlWHarC19U1kncDOqthNPBX
   BzBxo2o56HLUqbU1s3VO3vIGaoEitWHzfmqXnfItrj8xscbf3FH5zsQgr
   pnBg4gDDlgjWO0fOXuYWALw17hwrblNFe2IoGD9yQXVHnBSzkgqDZ9RZd
   f9+Gz5vhLc+LRnvfrALqHvd5BsDHfhjFUHuXBFiHyVVpju6Tob0oYlGRr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="16396001"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="16396001"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 23:15:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="737302253"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="737302253"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jan 2024 23:15:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jan 2024 23:15:08 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jan 2024 23:15:07 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Jan 2024 23:15:07 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 28 Jan 2024 23:15:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1drzkJoqgtR2dnJTFBPORtoX4oPewrCDtWaYrZMD2WitTpR0yx5gayBV/yB7Rad0AWfDZEkWUnHmI2nBz8byTfZweW0RR+IpM2vsks+I/8fozIZDYe5Cfc/We/sUiVIdmT+cxPto6RaCIi32VCQtUGo7iMJwNltH56Hxf1LOVP+TDcAxVVRrK97qgkHg1xyKfRaVLlCH8nktUh+a32Nb3wZ31zpXCNAwzRp/KkL7fCDQrfUg1Rk948Nxhef6RYSET9M6XT7LYOTfJvbfbe2606NAKYirh6d6huSAukpEzquKkOtMl5blIrEUsHBnRrNo6jllA6rhO0TZA76x9xLbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJDiVvypKapbfzKy3tShOUPYYd4OzQYO+g1MVpKEQzA=;
 b=TcIb9/XSoSUrgSAVAX/G8F4J+/BFDd+oX7H2PQjVsm0YnuruMMhmd5tZkU0lqC10ukik72QC2UHjCnAoho6QkXRHFG/bvc2WSK+1gQtZ6hXvqrgaXvY2yiMwuJ9/jX4adoPPFocnmwUafSL5iVfxSAyoutIAhCrbRsEJ8njpj/KU0pN1fpG5eAuuW7C/3fJO6yzKnFl97fuBMEFQjaw9h6E1vlHGlkqaImYCDKiqE+0OqYbZZAsCSu8N5J8bSKtk5m3gShuGYDeu83AKh+UmR524sEYViHsCjyMYHQTflogbiVpCyHr3PV8pcrFu5xUuZRT9JM1lLi//pDG5w4gSXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 PH0PR11MB7544.namprd11.prod.outlook.com (2603:10b6:510:28d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.32; Mon, 29 Jan 2024 07:15:05 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 07:15:05 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>,
	=?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, Theodore Ts'o
	<tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>, Sean Christopherson
	<seanjc@google.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC] Randomness on confidential computing platforms
Thread-Topic: [RFC] Randomness on confidential computing platforms
Thread-Index: AQHaUF3eVzWxkihyOEqZjVbKjj5n1LDsLEEAgAAOodCAAAU/AIAACp+AgAQYXuA=
Date: Mon, 29 Jan 2024 07:15:05 +0000
Message-ID: <DM8PR11MB5750DB565D2CEBBA0833EC12E77E2@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20240126134230.1166943-1-kirill.shutemov@linux.intel.com>
 <6afe76be-90a7-4cf7-8c6c-23e6a14f8116@suse.com>
 <DM8PR11MB5750C6641F0951928E95439BE7792@DM8PR11MB5750.namprd11.prod.outlook.com>
 <ZbPWht37uWZGhp4m@redhat.com> <4f717166-863e-4145-8b8b-37e09415e855@suse.com>
In-Reply-To: <4f717166-863e-4145-8b8b-37e09415e855@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|PH0PR11MB7544:EE_
x-ms-office365-filtering-correlation-id: c77ca137-ff6c-44c0-37ce-08dc209a0471
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BOMtVAX6YcqRl1k/zNRwBtdPWff8Qw4Gi9Aol6kA8W7d00HhnqN+v/g2Q1snEOP7Kjrg0SNEJSYroa4njcjPLIT7v09aJi3eCN24wnStVCfgQEUpP7FhVKt37ND7nLH1ykrQSsTl3RZR2GrS+DQQZ5+1smctuF5TY5MPTs82OuOBAZOIHbXmCuuCbcwxvxmbAf0974xipaoUDPltb26vbSta380UnpA/9RWOLmuWRJt5sWR0O0mqwKZ9Xo5bCWCaaWvf9aRcMMTkpTHvh6InSjoiJxaj22fYLtNIMG4rU0DOX9rbJOn85Pwfd2whpafzotb9rh5r1qdNET4G5OZzremwbWRG85fx1Vts/ldxO6JxBSaHOacXxztXv1M9NCyvxvEqjK9pWGSuSsOWzsGFy8jZRRNaN+VhJ3f1Gk+4Pc7/PLaZN2pR5NKTBSMxTT7pgdQQ/7qBgFkus85v36s3ryHqfSofM5WkJGtB98novoy+9RmNio6FemVTAyEOK3b69vZM42Mia++Xo8HbxfiUPgcgksnGeX6xsd4sKq6ZONtGc8Wu/XWXozbOn4z7XGbzcqw//B2Oanmh+veqjOGFbfwKBSlLeYMKt9cKctVPuMcCcaAAa4mApXO7vTzSRhdS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(83380400001)(6506007)(7696005)(9686003)(38100700002)(122000001)(71200400001)(5660300002)(7416002)(4326008)(8676002)(8936002)(52536014)(41300700001)(2906002)(478600001)(316002)(110136005)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(33656002)(86362001)(82960400001)(38070700009)(55016003)(66899024);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUxoZ1RYSlA1RDJwc0ZWamJpQXZOMjRvT3hBUEFXNkJzZkZMT283OHo5SitX?=
 =?utf-8?B?WWNFbThZUmgxYjRMS1ZVc0NRelFjNCt6OE1EbTFTK0hYNmNVVC9BZUR1bHV2?=
 =?utf-8?B?SmFjT0lsWDh3NGFFOGxKVmNMdEo0TzRxYkw3WUg1TDl6OGRtdHp2SHkza3Ju?=
 =?utf-8?B?Sk5odnc2cHpUQ3BkZk9qTXMxRnNoaThhTng1RE82U2hldUszMHB6Rm4zclhE?=
 =?utf-8?B?elBWdW9XSzNiNERadGZuMGJ6OUNHZUhydmNYTXJMNzcxVHRJK253Y21VOVFM?=
 =?utf-8?B?N2orRFB6NFFENSs0cjNiZHNyd3lTT1oxY28vUHJHQzd4bW1MWVZjQjFhNEJC?=
 =?utf-8?B?bGJzTlk0UzFQb1J4NDc3UXZMa1JObVVUK1Rkc0N0KzRCamVRN2YzK2hXRzdW?=
 =?utf-8?B?cjd1WTZ3ODUrdlJxdlZGay9SYmR1alVaNjlqSyt4Q21kYi9YcU1DTlowTjBR?=
 =?utf-8?B?eDVUZUVuTGNSbUhHNlZtZmlWeW0vYkhqSTUyMlJDZHMxbDVKMHNxZG1JR2NK?=
 =?utf-8?B?RGw0V3YyWHhnTWErZ3NBUXhLdkJwOCtGeXIxbElDcUNxSU5RNmlXZmQvTjk1?=
 =?utf-8?B?WTZ0QlhCeG9abjBRQ29QWTIralZFbUk3YmEwU2FQVGw1cnZqTENIWTZGVnE4?=
 =?utf-8?B?VUhXMHNaTzVHUW9Ia256ZzV3b2RWa3orcGIybTNsUjd0SGhWaDNMVExhWFli?=
 =?utf-8?B?cnYzazJvNUhiYU0vd0ZWcnQrcE1ObEF6N3poOGNmMzV2Qm5jdDBiTktzbWMx?=
 =?utf-8?B?N0c4VDhGOTF3LzBGU0g4QnZYbFRIQU40VkE0NVROREhSYzE1T0ZkTFI2bjI0?=
 =?utf-8?B?Ymg0OXgwVGh3VDluTVFHT2VWN1BtMkttUDZ0UVN5WmdXeG16UVRUc3dYTVZQ?=
 =?utf-8?B?SjF2cHQzaG4rU3pKTlI5YWF1ZjMvaVloazlXc3EzU0FOUjZxallJSUFxbVBy?=
 =?utf-8?B?Qmt3anFnVHlFR2c5amFIYi95TVZ2TmhBaDF1MDZ5cWZ2K01INlphUXNJZlI5?=
 =?utf-8?B?bE1jWkNPWkRya1NkN3J3dTVTb1Q2NVVMOWFOczlOMkVZZEdEeUpYU01JeHo5?=
 =?utf-8?B?Yi9uK3ZTeklEeXVQKzVWRmRQT0xSTEtvcGZycm5uMGt3RFRIZjZQOExaUWx4?=
 =?utf-8?B?SmtSMlFXeVo3MmwzSXgrZDV4S3pPcldoaVZ1aVJIRFM5MHl2TzJuWGRyRnpS?=
 =?utf-8?B?VGsxcEF4YTNQT2I5ZTIyaVYybVNWLzRIajJkWE8xM0lQVlVRK0o1Yk1UOHcy?=
 =?utf-8?B?OXFreTNWZVpZT1VseEU2aG4rUzI1OEg3ZGNVYkxkOGxSY2lEbGlRbTRTSW4v?=
 =?utf-8?B?NWVvTmZaRnFCQ3FpRFV5eVFtUFdTYmp0TngycTdQZVlScHkyZGZ0WU1UbTlL?=
 =?utf-8?B?eXgyZlF5b2xvQkRpZ2hGeGcyVFdtdWgyL2I4ci9VTFUzaXd1K3VabTN6ckgy?=
 =?utf-8?B?eDlzUzBoVHU0Q2JNeFBIdlV1R1NleXQ3MC94RVpzcE1MeUxWZkx4RTlkVG11?=
 =?utf-8?B?OUViald1WkJxOWtxQ1NjelJPaXp6ekYxRE93aU50MkYyVWJXRC93dG1qemRJ?=
 =?utf-8?B?eElHTzhabGhoYWIvMDZzL0hLc2J1WUNNdjZFVWY1UkdvbGcxaTk5aGxNZVhO?=
 =?utf-8?B?ZisxbHkvaTFHcTJnVmpRZ1U3dFJEd2ZuTXZvRERuZnN4TGxSbWdSeHM1bnJh?=
 =?utf-8?B?ejdONEd3TkY3dkVkU1ZUdytiYUxIMEFYTm41eXQralF2Wm13MGxmL2E4ZXhM?=
 =?utf-8?B?UXd1RUN0cVF2eTFNcGxLTm9ZK1FsSTdLSkRBeUIvUVF3VXVwRVFxa0Q2enda?=
 =?utf-8?B?ZHpYZFI4TUhGMnNPZ3BUcC9tSHNTTm5qS2dKdFI4VVZPbUVSWTV4Y2tqWUpB?=
 =?utf-8?B?Umt4c01wdUFZV0dKWGhCbjJORXpNSGNaeDlLYWFSS250UWVseUhId0dCU3F2?=
 =?utf-8?B?MGsyUksxck1HeTBNMHhaeGJRUGFwU3R0Y2hpVzQ0YS9kYVBnWHRObUNVKzVa?=
 =?utf-8?B?NEY3TVduK2pEVWVycWlmM3BKR0dZaU9vT3FPOWEyaFIwVEs3clNRSlJlRUZy?=
 =?utf-8?B?NUUwcTNPL0J1aUFhVUs1cFMyTXdyWDJsZUJxQzRYMFhoaCticm5sZ09ocWRT?=
 =?utf-8?Q?+4/9HVz6yc8EPGlH0b7UMu458?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c77ca137-ff6c-44c0-37ce-08dc209a0471
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 07:15:05.0754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2sDgVtawxXCHnVKzMh9nWcPorYA2w0WRsW0SG8ks/GuFMbi2kbN0dI0vUV040B3ZyGw9yuMsuNRnsEC9jrJULtxjDtG64aBFyykk0cUsif4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7544
X-OriginatorOrg: intel.com

DQo+IE9uIDI2LjAxLjI0INCzLiAxNzo1NyDRhy4sIERhbmllbCBQLiBCZXJyYW5nw6kgd3JvdGU6
DQo+ID4gSWYgdGhlIENQVSBwZXJmb3JtYW5jZSBjb3VudGVycyBjb3VsZCByZXBvcnQgUkRSQU5E
IGV4aGF1c3Rpb24gZGlyZWN0bHksDQo+ID4gdGhlbiB0aGUgaG9zdCBhZG1pbiBjb3VsZCB0cnVz
dCB0aGF0IGluZm9ybWF0aW9uIGFuZCBtb25pdG9yIGl0LCBidXQgdGhlDQo+ID4gaG9zdCBzaG91
bGRuJ3QgcmVseSBvbiB0aGUgKGhvc3RpbGUpIGd1ZXN0IHNvZnR3YXJlIHRvIHRlbGwgaXQgYWJv
dXQNCj4gDQo+IEkgZ3Vlc3MgaXQgcmVhbGx5IGRlcGVuZHMgb24gdGhlIFBPViAtIGZyb20gdGhl
IFBPViBvZiBhbiBlbmNyeXB0ZWQNCj4gZ3Vlc3QgdGhlIFZNTSBpcyBob3N0aWxlIHNvIHdlIGlk
ZWFsbHkgZG9uJ3QgbGlrZSB0byBkaXZ1bGdlIG1vcmUNCj4gaW5mb3JtYXRpb24gdGhhbiBpcyBh
YnNvbHV0ZWx5IG5lY2Vzc2FyeS4NCj4gDQo+IE9UT0gsIGZyb20gdGhlIFBPViBvZiB0aGUgVk1N
IHdlIGNvdWxkIHNheSB0aGF0IHRoZSBndWVzdCBjb3VsZCBiZQ0KPiBydW5uaW5nIGFueXRoaW5n
IGFuZCBzbyBhIGZhY2lsaXR5IGxpa2UgdGhhdCBjb3VsZCBjYXVzZSBzb21lIGNvbmZ1c2lvbg0K
PiBvbiB0aGUgVk1NIHNpdGUuDQo+IA0KPiBJIHRoaW5rIGl0IHdvdWxkIGJlIHZlcnkgaGFyZCB0
byByZWNvbmNpbGUgdGhlIDIgdmlld3MuDQoNCkkgYWdyZWUgdGhhdCBib3RoIHZpZXdzIG5lZWQg
dG8gYmUgdGFrZW4gaW50byBhY2NvdW50LCBhbmQgaW4gdGhlIGNvbmZpZGVudGlhbA0KY29tcHV0
aW5nIHRocmVhdCBtb2RlbCBub2JvZHkgaGFzIHJlbW92ZWQgdGhlIHBvc3NpYmlsaXR5IHRoYXQg
YSBDb0NvIGd1ZXN0DQpjYW4gYmUgbWFsaWNpb3VzLiBTbyBhbnkgYWN0aW9uIFZNTSBpcyBhYm91
dCB0byB0YWtlIGhhcyB0byBiZSBjb25zaWRlcmVkDQpjYXJlZnVsbHkuIFdlIHdlcmUgbm90IHBy
ZXNjcmliaW5nIGFueSBhY3Rpb24gaGVyZSwganVzdCBhc2tpbmcgaWYgVk1NIHdvdWxkDQp3YW50
IHRvIGhhdmUgc3VjaCBhIGNvbnRyb2wvb3B0aW9uLiBCdXQgc2luY2UgU2VhbiBjbGVhcmx5IGRv
ZXNu4oCZdCBmaW5kIHRoaXMNCmFwcHJvYWNoIHZpYWJsZSwgd2Ugd2lsbCBkcm9wIHRoZSBWTU0t
YmFzZWQgb3B0aW9uLiANCg0KQmVzdCBSZWdhcmRzLA0KRWxlbmEuDQo=

