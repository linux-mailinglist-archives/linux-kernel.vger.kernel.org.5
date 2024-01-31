Return-Path: <linux-kernel+bounces-45959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E86843861
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F941B22E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB3455E57;
	Wed, 31 Jan 2024 07:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bMFkOIB0"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD09155C08
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706687817; cv=fail; b=gubxyDM+2q1DBAb7tzyqKygT6ioDHHyUDIxQMjySpZUwBEkYPmAqzCDcvITDlAv+8dW7Fiy7UQYTowGTAW+sSAh9sT+I/Ns+SbDWPIXUwa5Ac1JMMxVRzShXCnAPZEjCKA9jJ5KASQVI0Y25/kCcUxYVrV9fnIQydIU2wfkk5Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706687817; c=relaxed/simple;
	bh=rIZFRX5PZYfvtxVipYj7E4npaH142ZabG4NFjrEP7QA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FeVs4H46dfW5XVbUqX2k+YwXJ5o0qCVsQVlkEMf9gshycaLrBS1YpAIFKV6IeoqJsLOBgqn1nakm0HJzcQZ8Tap+F3Lg+z22W3Vw8fvq4qjOGqVH1O/ilPSw7c+3o8Qp494qWTT1wILK32RHNjWsf3wZHBRnxYkIkZO3vboIzbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bMFkOIB0; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706687815; x=1738223815;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rIZFRX5PZYfvtxVipYj7E4npaH142ZabG4NFjrEP7QA=;
  b=bMFkOIB0ljPjBLOZjl7RrjLUNoMYiG8UG2QxPS+Oj2YriRO6D60VDaXS
   QniULtvaa37M6JfmGTvFQpiv0ELZDg9Zv20v/J4ZBlFw3XuxYfGf7SNe2
   CElK1vAj9sdSgSXZZDFaOHqkB0+u1v2VcI2clSljKdjKSepGLxB4fg/4M
   rI9f6+hvJjxI8yRyOcUY2G8k6e+/Dp7hQkS/B4XVx+6Bel/d9hJX2Aek+
   jC4wZXPmt0h3rGEnu6SlEk0DTT/bGZRG5SWsNO+IiAt+p7tk6gs7E9gWJ
   DHeN5tqbqsMgA+a8sdgMn/HXZdwrja+rwxH7hMSJ4O1fAkHBsmCyxnxc1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="434697075"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="434697075"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 23:56:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="961539188"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="961539188"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 23:56:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 23:56:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 23:56:52 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 23:56:51 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 23:56:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d78+A2suZeUIiXuVmbZe9qX3PukGErczbuPcGnSukAdXm9VTwt1WLFThcFjKiGgyGvZcMty0P3z9XzSBL/QjKU4bf0RVB+vA+wEyi8K3qIhjsKHieVH6DkLp2m8OTlnChoeH5BLovMx7nBKM1W/yxm5JXgyTBjGiAhGFtpXcse98byW4H0Y2pXo2MSrptZ7PWQ8+M/e2ylBKpFUtOKvVQG8jLxnksUmJCfiRqPnA8TxL3i6mMuFUi00g7Nz7oO5biSJUNfzFSSpLwWmw8W8h167ZJOrpZMiADIChGPbM56AahLQfIwvEjVywi9WPs945W7RXXwyIV70uw5zTk5smDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIZFRX5PZYfvtxVipYj7E4npaH142ZabG4NFjrEP7QA=;
 b=mCHomINbTAfk/XCxpjXfxi4syDwXSkogni8Vq95MLnQWgauZ2noZceiZFPyiIJSeAw6t0K+oRDxa3nhYxtDc3bmF0EqQC7UuYUl/+BI9LMsugfrkpqHSCtaso82XsVApE/GMcMOtzFQXZg1K0g2WK+BbseZj5h7N9v83DAC/hmn/dHq907KXNG/GWSzYTy4t0RZM/YfGXH6pscCaTeyxeVhU3c+s6Yp7vKvorL2ow2SYiueb+KbaUAB9P1Qr46BnFCa5kfg4IieL6g2Oz7XQ/+2OnYArwAz1cmLlEfsgp6wmu65PJLApsQltRiz7EnFvM7fZPnsnvr7zDsV+O07CeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 CH0PR11MB5473.namprd11.prod.outlook.com (2603:10b6:610:d4::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.22; Wed, 31 Jan 2024 07:56:49 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190%3]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 07:56:49 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, Theodore Ts'o
	<tytso@mit.edu>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Nakajima, Jun"
	<jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Kalra,
 Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] x86/random: Retry on RDSEED failure
Thread-Topic: [PATCH 1/2] x86/random: Retry on RDSEED failure
Thread-Index: AQHaU1aX7QKpTpzPXU+lq+SGmZ3MRrDySSwAgAAHtwCAABNoAIAAS0IAgAAD1CCAAAeOAIAAyKKA
Date: Wed, 31 Jan 2024 07:56:49 +0000
Message-ID: <DM8PR11MB5750B861F7A105886AA5FCE4E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <CAHmME9pOt=uEmuBzBpgUHw9DqAD2FZTZ3v53AOZbQ3Cd2p97xQ@mail.gmail.com>
 <DM8PR11MB5750E38A8B2BCE66AF7F9812E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9qMO7=RDR60bKJvpDTRokcKed_i0+7BbFD53_7o2OJ6-g@mail.gmail.com>
 <CAHmME9rum4uwSNFd_GkD9p_+vN4DBxA=feZX7k9RvugFZsZNJg@mail.gmail.com>
 <DM8PR11MB5750797D0B9B8EB32740F55DE77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9oC=GE-7QS2m9FA5cs_ss+tQgB9Pj3tKnTtMMFpQmUshg@mail.gmail.com>
In-Reply-To: <CAHmME9oC=GE-7QS2m9FA5cs_ss+tQgB9Pj3tKnTtMMFpQmUshg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|CH0PR11MB5473:EE_
x-ms-office365-filtering-correlation-id: fa1b84c5-dfc4-49e6-558d-08dc22322dd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VtM9RNJn0v0zYq9mGFtjSfQtg7uiLeaDKk8Al3eBe3olMECwiSKpQA0Pu8KmsCu5xwp45cw6/h1QegUUgExbhRT7Uo+sSDMDgnSKYWWSvbcnOKnP9uZsIxfiq2GKjNKMCosA+abIkf8vQ0XVaV5iqVs+0wXMX5BNLeh9RzFJz7y0fB9H3BoBU2s6geeA9/gg5fZH7q86REPqHMfhacgbszuJLCqycITC2aAi1DlplimrVNIvaRqbPmSrThRbCM5VErTvv+4ryOGawCLwgH/vjp2DlZL2zt2f6RRyhBr57JuEzpdn7gY15ZPRT94bh6PBkmi3CGZElbXb0oQWnAuQ4RHccmh9kyJaZEWWgdw3ZkrfWIMJq1p2lwccD8toznjR4MlQKVnEZmrlHx0KYnmJU21HA67DGOjkcHuD1TLsQMIJTRFgGzWhJdWZPT5E9/j8+Yqo44UG/Y1YUZiiHsBCUo3xOHc3OB8uWjgMb0zmRQXN1xq68U8QnoD3PWSUGpvCPMQ42IL2lHvC2X1o/f/qhtHFAeMYMtDxGncmBtzNqW2Dwu/rdqssN5RkAUdkOLOLxqkqT/KQkxsB5iwMJ/2rJvziVGvvdo9740OmCXz5EtxrOOpnwf5dOCmvmtHtc+luckCowaSKKfrs6H+v8w9P+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(55016003)(83380400001)(26005)(52536014)(82960400001)(6506007)(53546011)(9686003)(7696005)(71200400001)(38100700002)(122000001)(966005)(478600001)(66556008)(64756008)(66446008)(66476007)(54906003)(6916009)(316002)(4326008)(8676002)(38070700009)(8936002)(76116006)(66946007)(41300700001)(2906002)(7416002)(5660300002)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?byt4dGZGY1g0cHIwUFNOVDY3NUw2blRaL2hKSlJoMmxCdDUrdmVXd3BVdWlS?=
 =?utf-8?B?Z2s0R2N6angxcmRaQkwybWp3VjF2Nk1uQ0JnRE9pUkFSMXBkTWVrNTF5TG5m?=
 =?utf-8?B?Q0c3KzJ6bXppK3d2a0s2OXNKbWRkZ09rSDk2NHdEQzZRaFNkSG9PdmhFMUsz?=
 =?utf-8?B?U3o0NXRwbU02N0ExMHFkRDJRYmJ3ZWtEdmpubTU4WkJRV1g3RlprYTI2TGFN?=
 =?utf-8?B?OWxUdjBlKytyeEl5QTF4V2VodE5wWE9ndFYrYTVFMXM3ZWpxS2MzbFZYMEhn?=
 =?utf-8?B?NWJNb3RxS1duN1h5TnVUc3k5N0hsZGd0b09rcEhJVDhrTGJaNG5yZzVGOFBC?=
 =?utf-8?B?dnNibWoxbUg0aXMrZmhOZ080ZGhmSlR1MVdHTW5QQm0zeVlHRTdYM1B4OWFL?=
 =?utf-8?B?Ung2cGtpOTFQRU5Canh1MDMvZkRvU3BpblZGQ05wenh1d2IvUlYzUVRKU1JG?=
 =?utf-8?B?b2RORkZpM3h3Sm80Qzk3a3VNLzBUb2ZnejkvN3RzczJvTVZidURGMUpqTi9C?=
 =?utf-8?B?VVl2Rzl0K29EYW5ZSCs1SHVIcnd5V1Y2ZG1qcmowOHBVaWkxTXk3OW1DNGVU?=
 =?utf-8?B?aEgvQjhTNTU4clBMSTROSlhmRXVHblVMWk91dkVmM3BCaG5kdzZMakMzaTRp?=
 =?utf-8?B?MXM5bUpMV3h2b0thb0xKZWhKMEx3UGViSzBBcS9FbHprbG4xNzN4NDRuemtU?=
 =?utf-8?B?eHB6V0s0T0J2NEUydDRVY0Vld1pmY3BhdHdTTlQ1VzNwaTVGbC9VUEFCMGRQ?=
 =?utf-8?B?UndyQ3VWL1JXT2lwQ0hRaDl5ZEE1K29CZ3E0TWdmaWV3TmZ2UjNrcndBcFNH?=
 =?utf-8?B?Mjk4eUlZYSt5dnR3M084U0s5d2FPRnJqbGRMUCsvaVZUU05RNUx2YVZUd2Ja?=
 =?utf-8?B?czZRdGYyZTVjNGd3WTR5b3hvV3ZXTS9DTHlPdUdNdVgxSTFjeUtrQ1RzeDA0?=
 =?utf-8?B?WFFYVW1KRkhWUC8zZm1KeUNuZE1ZUHFBbkZhSitwbjludVRHUitQRkNxd3dX?=
 =?utf-8?B?eThCYjRjNnF4OEV2WVhjNWdzTS9aRmw2Wndub3BoZnY1Wk12NzhCUXdYL3Nl?=
 =?utf-8?B?aGZCYVo3SlVJSkJoSitGUWQ1aXhERWViSTJsM2VTelRGWkZXVWlDQWNHWmNK?=
 =?utf-8?B?aWNtT1h3ZUFDcnhkZEVoSDgrZDhMaElFSm1qZDJ6VytmUktJNktVeml1U1dN?=
 =?utf-8?B?d1hSUlAwZFlONnBQRkplRG5QN0VUWDNXZkltNkFwck5sMlZrZ3dYMEg3ZHVh?=
 =?utf-8?B?cmcySGl2Y2J3a01HUytldkgrVUU0TXJsTGxsaUFkZm1HRVU2N3h1bnhuZGFv?=
 =?utf-8?B?RUZuSXBESHpyekdnSVpIbHkrcFoxYTJzTk1kSEVPMXBIaG5VTjRSV0Y0NHNQ?=
 =?utf-8?B?UUQ4NnNHWGJzNjloWWI3YmpHL1h4RjI2TUJ4alBSWEJvWUZYeHNJbi9BWnRh?=
 =?utf-8?B?R3c5R1kzQ0xIQzBSRDBEWTNBNE8vQVB1eUVrcmZndXpUd3RxL25yaTVXQ3BL?=
 =?utf-8?B?WCtOd2RDMGNmZDlXeDRscktWd3JKMHA3SkRpYXNmZWFHNW1BeGNYcTBjNzEz?=
 =?utf-8?B?OXh0SEQ5Y25Jd2twSkhpTmJQaHBoSHVnVDFpVzN1ZkpLcmxvQWFtMG1OR2Zw?=
 =?utf-8?B?bG5XTUZLUGY3NmpnTXVXbXkvZTRxcjhiZHJKQTYwVVRGbWVldDJiZFFTQmVo?=
 =?utf-8?B?TkZJTjlzMnpDMWljZ3VqbDgwWlhOT0M3RStPNVJoWUM5Z2d3WUhZWmFwQnEr?=
 =?utf-8?B?VmRVZUZKZVNmcExKRDR4SlJkMDRXM3ovYmVhTWRpZzgrTVl4bGJ1djZmc2hT?=
 =?utf-8?B?WnFCS21HeUpwelNldHhJdkxUU2JmbVd1ZEFpbWViTjY1RDdZcjlmVUZPdHMx?=
 =?utf-8?B?TzJldFRxMkhYUk1VYTlURkZ3b1pXRnB5SjJTME8yNURkVk5xSHp5VDZIdFlC?=
 =?utf-8?B?NUlNSFBiM2tTc2F5V3UvcVpHdVNWY09uSFlHUWNsSzJQN3JZMC9SVW80TnZ6?=
 =?utf-8?B?d1p2TnF2aGNlRG1KUFFXNGpOS04rTkUzRUhUaXRMNS9vdjYvNitVL1NSdXY1?=
 =?utf-8?B?MUtBc0lYVkJDNzZId2o5OXNpenU4U0FIWFZTbkpiTmh4aWIxSE95SFlZcDhL?=
 =?utf-8?Q?5LZf2jVq8Mg1A8bALfOauzc4X?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1b84c5-dfc4-49e6-558d-08dc22322dd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 07:56:49.2270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nzG7ynO+4Xk5d/sdGwD+1cgKM28Ng6DKtVMf5r9z0OKQf/9efZ24F5Govlhjd9/VkKi8Rgip0XoiFJBj+ms1GtksR2lN8MBScg+3lT4/wRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5473
X-OriginatorOrg: intel.com

PiBIaSBFbGVuYSwNCj4gDQo+IE9uIFR1ZSwgSmFuIDMwLCAyMDI0IGF0IDg6MDbigK9QTSBSZXNo
ZXRvdmEsIEVsZW5hDQo+IDxlbGVuYS5yZXNoZXRvdmFAaW50ZWwuY29tPiB3cm90ZToNCj4gPiBZ
ZXMsIHNvcnJ5LCBJIGFtIGp1c3QgYmVoaW5kIGFuc3dlcmluZyB0aGlzIHRocmVhZCBhbmQgaXQg
aXMgZ2V0dGluZyBsYXRlIGhlcmUuDQo+ID4gVGhpcyBpcyBleGFjdGx5IHdoYXQgSSB3b3VsZCBs
aWtlIHRvIGhhdmUgYW4gb3BlbiBkaXNjdXNzaW9uIGFib3V0DQo+ID4gd2l0aCBpbnB1dHMgZnJv
bSBldmVyeW9uZS4NCj4gPiBXZSBoYXZlIHRvIHJlbWVtYmVyIHRoYXQgaXQgaXMgbm90IG9ubHkg
YWJvdXQgaG9zdCAncHJvZHVjaW5nJw0KPiA+IGEgZnVsbHkgZGV0ZXJtaW5pc3RpYyBlbnZpcm9u
bWVudCwgYnV0IGFsc28gYWJvdXQgaG9zdCBiZWluZyBhYmxlIHRvDQo+ID4gKm9ic2VydmUqIHRo
ZSBlbnRyb3B5IGlucHV0LiBTbyB0aGUgbW9yZSBwcmVjaXNlIHF1ZXN0aW9uIHRvIGFzayBpcw0K
PiA+IGhvdyBtdWNoIGNhbiBhIGhvc3Qgb2JzZXJ2ZT8NCj4gDQo+IFJpZ2h0LCBvYnNlcnZhdGlv
biBpcyBqdXN0IGFzIHJlbGV2YW50Lg0KPiANCj4gPiBNeSBwZXJzb25hbCB1bmRlcnN0YW5kaW5n
IGlzIHRoYXQgaG9zdCBjYW4NCj4gPiBvYnNlcnZlIGFsbCBndWVzdCBpbnRlcnJ1cHRzIGFuZCB0
aGVpciB0aW1pbmdzLCBpbmNsdWRpbmcgQVBJQyB0aW1lciBpbnRlcnJ1cHRzDQo+ID4gKGFuZCBJ
UElzKSwgc28gd2hhdCBpcyBhY3R1YWxseSBsZWZ0IGZvciB0aGUgZ3Vlc3QgYXMgdW5vYnNlcnZh
YmxlIGVudHJvcHkNCj4gPiBpbnB1dD8NCj4gDQo+IENoZWNrIG91dCB0cnlfdG9fZ2VuZXJhdGVf
ZW50cm9weSgpIGFuZCByYW5kb21fZ2V0X2VudHJvcHkoKSwgZm9yDQo+IGV4YW1wbGUuIEhvdyBv
YnNlcnZhYmxlIGlzIFJEVFNDPyBPdGhlciBIUFRzPw0KDQpPaywgaGVyZSBpbW8gaXQgZ2V0cyBh
cmNoLXNwZWNpZmljIGFuZCBzbyBwbGVhc2UgdHJlYXQgbXkgYW5zd2VycyBvbmx5IA0Kd2l0aCBJ
bnRlbCBURFggYXJjaCBpbiBtaW5kLiBJIGRvIGtub3cgdGhhdCBmb3IgZXhhbXBsZSBBTUQgYmVo
YXZpb3INCmZvciBUU0MgaXMgZGlmZmVyZW50LCBhbGJlaXQgSSBhbSBub3Qgc3VyZSBvZiBkZXRh
aWxzLiBPdGhlciBhcmNocyBtaWdodCBhbHNvDQpoYXZlIGRpZmZlcmVudCBiZWhhdmlvci4NCg0K
Rm9yIEludGVsIFREWCwgd2hlbiBhIGd1ZXN0IGV4ZWN1dGVzIFJEVFNDLCBpdCBnZXRzIGEgdmly
dHVhbCBUU0MgdmFsdWUgdGhhdA0KaXMgY2FsY3VsYXRlZCBkZXRlcm1pbmlzdGljYWxseSBiYXNl
ZCBvbiBhIGJ1bmNoIG9mIGlucHV0cyB0aGF0IGFyZSBlaXRoZXINCnBsYXRmb3JtIEhXIHNwZWNp
ZmljIG9yIFZNTS9ob3N0IGNvbmZpZ3VyZWQuIFRoZSBwaHlzaWNhbCBUU0MgdmFsdWUgaXMgdGFr
ZW4gDQppbnRvIGFjY291bnQgYWxzbyBpbiBjYWxjdWxhdGlvbnMuICBUaGUgZ3Vlc3QgaXRzZWxm
IGlzIG5vdCBhYmxlIHRvDQp1c2UgdXN1YWwgY29udHJvbHMgKHN1Y2ggYXMgSUEzMl9UU0NfQURK
VVNUIGFuZCBzdWNoKS4gRm9yIGRldGFpbHMgKGFsYmVpdCBub3QNCmV4YWN0IGNhbGN1bGF0aW9u
cykgcGxlYXNlIHNlZSBbMV0uIElmIHlvdSBhcmUgaW50ZXJlc3RlZCBpbiBleGFjdCBjYWxjdWxh
dGlvbnMsIA0KdGhlIHB1YmxpYyBzb3VyY2UgY29kZSBvZiBURFggbW9kdWxlIGlzIGEgYmV0dGVy
IHJlZmVyZW5jZSBbMl0sIGNoZWNrDQpjYWxjdWxhdGVfdmlydF90c2MoKSBvciBqdXN0IGdyZXAg
d2l0aCAidHNjIiBpdCB3b3VsZCBzaG93IHlvdSBib3RoIGNvbW1lbnRzDQpleHBsYWluaW5nIHdo
YXQgaXMgaGFwcGVuaW5nIGFuZCBjYWxjdWxhdGlvbnMuDQpTbyBnaXZlbiB0aGlzLCBJIHdvdWxk
IHBlcnNvbmFsbHkgY29uc2lkZXIgdGhlIHZpcnR1YWwgZ3Vlc3QgVFNDIHZhbHVlDQpvYnNlcnZh
YmxlIGJ5IGhvc3QvVk1NLiANCg0KIFsxXSBURFggbW9kdWxlIHNwZWMsIHNlY3Rpb24gMTEuMTMg
VGltZSBTdGFtcCBDb3VudGVyIChUU0MpDQpodHRwczovL2NkcmR2Mi5pbnRlbC5jb20vdjEvZGwv
Z2V0Q29udGVudC83MzM1NzUgDQpbMl0gVERYIG1vZHVsZSBzb3VyY2UgY29kZToNCmh0dHBzOi8v
d3d3LmludGVsLmNvbS9jb250ZW50L3d3dy91cy9lbi9kb3dubG9hZC83Mzg4NzUvNzgyMTUyL2lu
dGVsLXRydXN0LWRvbWFpbi1leHRlbnNpb24taW50ZWwtdGR4LW1vZHVsZS5odG1sDQoNCkZvciB0
aGUgaGlnaCByZXNvbHV0aW9uIHRpbWVycywgaG9zdCBjb250cm9scyBndWVzdCBhcGljIHRpbWVy
cyBhbmQgaW50ZXJydXB0cyBmdWxseS4gDQpTbywgaXQgaGFzIHRoZSBwb3dlciB0byBzZWUgYW5k
IGV2ZW4gYWZmZWN0IHdoZW4gYSBjZXJ0YWluIGludGVycnVwdCBoYXBwZW5zDQpvciBkb2VzbnQg
aGFwcGVuIGluIHRoZSBndWVzdC4gSXQgY2FuIGRlbGF5IGd1ZXN0IHRpbWVycyBhdCBpdHMgd2ls
bCBvbiBwcmV0dHkNCmV4dGVuc2l2ZSB0aW1lIHBlcmlvZHMuIFRoaXMgc2VlbXMgcG93ZXJmdWwg
ZW5vdWdoIGZvciBtZS4gDQpUaGluZ3MgbGlrZSBIUEVUIGFyZSBhbHNvIGZ1bGx5IHVuZGVyIGhv
c3QgY29udHJvbC4gDQoNCj4gPiA+ID4gSSBpbWFnaW5lIHRoZSBhdHRlc3RhdGlvbiBwYXJ0IG9m
IENvQ28gbWVhbnMgdGhlc2UgVk1zIG5lZWQgdG8gcnVuIG9uDQo+ID4gPiA+IHJlYWwgSW50ZWwg
c2lsaWNvbiBhbmQgc28gaXQgY2FuJ3QgYmUgc2luZ2xlIHN0ZXBwZWQgaW4gVENHIG9yDQo+ID4g
PiA+IHNvbWV0aGluZywgcmlnaHQ/DQo+ID4NCj4gPiBZZXMsIHRoZXJlIGlzIGFuIGF0dGVzdGF0
aW9uIG9mIGEgY29uZmlkZW50aWFsIFZNIGFuZCBzb21lIHByb3RlY3Rpb25zIGluIHBsYWNlDQo+
ID4gdGhhdCBoZWxwcyBhZ2FpbnN0IHNpbmdsZS1zdGVwcGluZyBhdHRhY2tzLiBCdXQgSSBhbSBu
b3Qgc3VyZSBob3cgdGhpcyBpcyByZWxldmFudA0KPiA+IGZvciB0aGlzLCBjb3VsZCB5b3UgcGxl
YXNlIGNsYXJpZnk/DQo+IA0KPiBJIHdhcyBqdXN0IHRoaW5raW5nIHRoYXQgaWYgdGhpcyBkaWRu
J3QgcmVxdWlyZSBnZW51aW5lIEludGVsIGhhcmR3YXJlDQo+IHdpdGggcHJlYmFrZWQga2V5cyBp
biBpdCB0aGF0IHlvdSBjb3VsZCBlbXVsYXRlIGEgQ1BVIGFuZCBhbGwgaXRzDQo+IHBlcmlwaGVy
YWxzIGFuZCByYW0gd2l0aCBkZWZpbmVkIGxhdGVuY2llcyBhbmQgc3VjaCwgYW5kIHJ1biB0aGUg
Vk0gaW4NCj4gYSB2ZXJ5IHN0cmFpZ2h0Zm9yd2FyZGx5IGRldGVybWluaXN0aWMgZW52aXJvbm1l
bnQsIGJlY2F1c2Ugbm90aGluZw0KPiB3b3VsZCBiZSByZWFsLiBCdXQgaWYgdGhpcyBkb2VzIGhh
dmUgdG8gaGl0IG1ldGFsIHNvbWV3aGVyZSwgdGhlbg0KPiB0aGVyZSdzIHNvbWUgcG9zc2liaWxp
dHkgeW91IGF0IGxlYXN0IGludGVyYWN0IHdpdGggc29tZSBoYXJkLXRvLW1vZGVsDQo+IHBoeXNp
Y2FsIGhhcmR3YXJlLg0KDQpZZXMsIGluIHByYWN0aWNlIHRoZXJlIHdpbGwgYmUgcGh5c2ljYWwg
aHcgdW5kZXJuZWF0aCwgYnV0IHRoZSBwcm9ibGVtIGltbyBpcw0KdGhhdCB0aGUgaG9zdCBpcyBp
biBiZXR3ZWVuIGFuZCBzdGlsbCB2ZXJ5IHBvd2VyZnVsIHdoZW4gaXQgY29tZXMgdG8gaW50ZXJy
dXB0cyBhbmQNCnRpbWVycyBhdCB0aGUgbW9tZW50LiBTbywgSSB3YW50IHRvIG1ha2Ugc3VyZSBw
ZW9wbGUgdW5kZXJzdGFuZCB0aGUgcG90ZW50aWFsDQppbXBsaWNhdGlvbnMgb3ZlcmFsbCwgYW5k
IGluIHRoaXMgY2FzZSB0aGUgcG90ZW50aWFsIGltcGxpY2F0aW9ucyBvbiBzdWNoIGENCmNyaXRp
Y2FsIHNlY3VyaXR5IGNvbXBvbmVudCBhcyBMaW51eCBSTkcuIA0KDQpCZXN0IFJlZ2FyZHMsDQpF
bGVuYS4NCg==

