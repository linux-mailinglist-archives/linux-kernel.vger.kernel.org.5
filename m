Return-Path: <linux-kernel+bounces-49040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B4784652B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30BE1F24125
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271FBAD57;
	Fri,  2 Feb 2024 00:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VPX/3nkC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C9FAD3F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 00:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706835266; cv=fail; b=PFw8cxJAEs0duYVN2goZKNynZpooGGsdXmt2BuIkPZxVZw8c4fQN1A4viVDxalcW2hcuM+bHlvx4uWQ8tUZZiSFobQUyBO5BTmHHj2W6ucFqvy855XX1tt/wtZLQt8FEdGcJ1NUpOxxETev8tIgIMs5OleWqCTDb0r2RgpZy6u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706835266; c=relaxed/simple;
	bh=3UxKWGMyP4cN70tcaW18zUfyUzlsiyKMA0uASMTnUQ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CkN6Euupl6KoS1xraA4Dbo9LjqMYrfrCK8UZgOZxkc51vCvaS5yMhfrx5RflbD0Qk+A1aq8hqNPYRsZ+LGe3+M7hqhKiSWOgTEsMI2l+36phCmcCLPUFhuunbxI4LC+n9fARrR8FPgo1sfayl/Q5o8WrN+jUOdzHWDrif6a3OlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VPX/3nkC; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706835265; x=1738371265;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3UxKWGMyP4cN70tcaW18zUfyUzlsiyKMA0uASMTnUQ0=;
  b=VPX/3nkCBrzxCB1iehDjsSExIypTrrubb5ZNCHYtEqhooRJ9lxpCH9+8
   UOO7xRjOUKfNj4xnsyC90WopnHcR1OKt4jypdjUp7BO9e2HYyPYpcVGc5
   eUeTpdZmk9Mc3ZCVVkYyD7WlqeBql9XgJ1Y3Z6vq/EOR2pkaXBtuwN7Y0
   mJA+ZnrQEeW7KBYg3a+IGl8i5TtQaWECmHCiuAdZb+6CoK51FFryoeanS
   pd8sV4kJp6k3hMJSb2SYILwJl8nHFDAS7I+4Uyoq/NNM8oHJt8tZL33/u
   T6o1UtEm6RfMJEauoglKCeZS5pE20wtcxekP92qaHX45X/LSHXzKQ8MuE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="2978900"
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="2978900"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 16:54:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="823082245"
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="823082245"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 16:54:22 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 16:54:22 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 16:54:22 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 16:54:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ln1RWu4rQ5UPtnPPrAnjK7q/1yCfITZCCKwiYwIf/k/2FYwt95Qc4zNQTD5V6NFQSWULSHc9vq08xvcxiFF+GLMpoc62reRi/YKhjNImu791WMl857POC7lxZX91/tVTwWlKccIOg4ot9yXRpXgdPkUYP4E/2l4paM4/2V1aSb+/b0Lwnqj6jg3meK5ULtQWG3kgmALY9zXALqJURuvsoXXp9VMksFIbM6MzKKnR4uoADzCUcCekjOnkHKCxwBP2cvTHDmOY7URfT3BSK948HHsy3rmB+OdAYr0PY37RpcF526eBWZ0PbMIzF0f6mVYCg4DGnrkJwU2uYnVayJhu0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UxKWGMyP4cN70tcaW18zUfyUzlsiyKMA0uASMTnUQ0=;
 b=imdmcQEiDV3CuGyvkM9TYF5W27fAQN1lkFQ1mX481gmGd8PxnbwqjKfDrezFB6PnS0HbrRcQXLT0JQ6iRexgRQR+kdHmSnUJIWS7Odh/Fcx1X5mErTUDLsmNjOmOvwr6ZORS7HVkoxc3jOWmmXQvbUaBrIIe3YJhSDxX3Yz+8y0LnbQj4h7i8fpe8pbWx49u3Fv62U0grwomHnLsok6bTCACYPa8OnC36f5y20v8cF2lX2gauEL8xjguuAhpTnV8bNp2++6st7zxSBG8FVtEzKdab8YykY8obqkO3PRA48puwDxLEzZ0mvhnCJWPQlfvCZSKkiSIiuuMJXzCWYjUMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB7624.namprd11.prod.outlook.com (2603:10b6:8:141::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Fri, 2 Feb
 2024 00:54:19 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7249.017; Fri, 2 Feb 2024
 00:54:19 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Huang,
 Kai" <kai.huang@intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"bhe@redhat.com" <bhe@redhat.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH 3/4] x86/kexec(): Reset TDX private memory on platforms
 with TDX erratum
Thread-Topic: [PATCH 3/4] x86/kexec(): Reset TDX private memory on platforms
 with TDX erratum
Thread-Index: AQHaVXJZ85pv7CwSt0ibBIGnhPydTA==
Date: Fri, 2 Feb 2024 00:54:18 +0000
Message-ID: <b083d901a8be0597e311d29fa6cc01046c37db69.camel@intel.com>
References: <cover.1706698706.git.kai.huang@intel.com>
	 <b52ed259e0d487b3a968b98da91cb4f55a28ae82.1706698706.git.kai.huang@intel.com>
In-Reply-To: <b52ed259e0d487b3a968b98da91cb4f55a28ae82.1706698706.git.kai.huang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB7624:EE_
x-ms-office365-filtering-correlation-id: ce03fc00-beab-4685-499d-08dc23897c87
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TEMInaZ4cd2nXDa26jgyWJL5vO3nW111X3mzOGJRtVRvJuGREtRHYd4mfFcABZ3M2B6f8gkLTSd6EKlpOYZA6DwEZ6nDWTkOaeFVMsL0YYDpj6hNz/5ZpmMbnOrpyb2o+iasgCCucJvrFdNA+lcTffJMnC+tOmTURYDnlSqoL8QgFVmO39VnQYS7EKUOadrfzbB1rXNg3XC/aBbODXMrOAwePsgwnpswlNg4tDLUsaDlPaZ8hFzkfTJx3uts54YDxR8TiJyezo0e5+YzvI3kqB5kJqkiXzWJDjlHBg/KemKfTPJ69DW/rsBEdlkpEtgCgRCZZOEctQd/0XMYh4VTYE/5Tp/0Vvi/txxdHmBuBlNyQpKMHXSogrKk2yGdV+oag38NB5//npbP+D494ko5XrxASt8cC//8qZBfnOyyj204XWx1sM2mFqcECzEN/UuaCtM14B7tKWaDdVVbXfrwjRkkvOx1rEC7H1tr3rEwYFb8YESE3GF5oeMtRP4yNsQNaGSvoQ69IYXxSrcMMQbbz+q/SSN+XXzY2MIA3/mcqzDDpZwJ9alNDCfbaeivD4XeCn0MBmgrdRWLvjwCHXdn16nb/kANO0tfMOBYsjsMLytczKSg3m0w58fskVvf8YGy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(396003)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(26005)(2616005)(82960400001)(41300700001)(38100700002)(122000001)(71200400001)(8676002)(6636002)(66446008)(110136005)(8936002)(76116006)(66946007)(64756008)(7416002)(316002)(54906003)(2906002)(4326008)(66556008)(5660300002)(66476007)(4744005)(6506007)(6512007)(478600001)(6486002)(38070700009)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkFOZGYxUkZSYko1cTVEOXRWVnkrcEprWi8zbFRwcTJPT1hKQStpb2J4bWpN?=
 =?utf-8?B?VUJVNzV1dW9YenpkTWd3ZGR0Y0NFamN1QWxkQ1NkYStWWEUyQVZlcisxbTln?=
 =?utf-8?B?d1Ivc3ZpZDJoYS9IYlNtdXVEdTNsUEhXOThaeFl2V2JTaFpVRzFSODBpN2dr?=
 =?utf-8?B?eWE3enFKenRLUUx6U2dYblI4RVVHMGRNRVpSeHd2OXlTZ2pxL1lwQkJmSURw?=
 =?utf-8?B?QUVibVNmblAydkgrRGZYUmlBOTB5a0I5T01UL01tNVVZVEZmeTZPQkx4QlJO?=
 =?utf-8?B?b21RS25YMnhPdEI0S3dVZ3JvNWhoQ0FyS3IvVUV3V2Y0cmJMMVpqbVo3SFRD?=
 =?utf-8?B?eUlvZllTRjREOGNKOUxXOG5ZYVNmbFNRZzlDQy9DcEQvVkxCSzJtTFBRcWN2?=
 =?utf-8?B?ODA1WFZnbFRSN1dyb2pBalBiOUI0NnpXdWhkcm1oQlAwVXptYW9XMkQvanBn?=
 =?utf-8?B?RUxob3Z1bU9pS2ptQThCcUk1L0cvakpiUlphbmRickxlQ0pHTVZTOXU1dGd6?=
 =?utf-8?B?TGpZSEVXNlVCR1NaUEMvakZsZitHWFBPWmN4REpNTmRCUlVPVUhydGE2em9j?=
 =?utf-8?B?S1I3MWRQWEJMSkVRcmpzWFB2NTQ4TmZ5UW9uUjJ5UkpycWREelQwalFlcHho?=
 =?utf-8?B?QUtPWXBvQ0NQR0hqUzFJakdoUjQ5c2dlaDJYZUVjUDZvSWRuYTE3WE53bEd1?=
 =?utf-8?B?VEltNDYvelRzbUw3N2VUWWY3MnplRUd4cHF5cjNaR2dod3JIUlZ0ME5ER3BG?=
 =?utf-8?B?WklCMmt5bjI2TDNib1dhV0sxajVTV2Jtc2piZ3hEeEx4ZFNHQXJIbW9kNXpH?=
 =?utf-8?B?VEhVUkpWdFJ4MXU1OUZlcFZSK0V3U0tCZ0cyd1JndWl5cmNPbnIyYzBta01r?=
 =?utf-8?B?L09xNnNJeWFDUFMyeXJzbEJESGM4VDFKc2hMR1M5ZURQMlV5MHo3UW5CZU1D?=
 =?utf-8?B?d2YwdXJhN2IvN2pFN201ZEJJdlQ5d2V4anRRRUVlOGVQT3hybFhjRWFrWDF1?=
 =?utf-8?B?WDBIZXZMN2VwTGpHOTR4TFV3OGRycUVUc09pcGJQSGpHVDFDbExISlVDdm51?=
 =?utf-8?B?SzYrWXlublp0VDVDb2pxMjVLalRhSThrZVNVZlRhSDNSdXROWmo2UFBGeU15?=
 =?utf-8?B?bUNPU3VpRW53NTZVR3lqbDdOM1MvN2M5RjBibkMzRDIrVEJKckNEOXdMMzYw?=
 =?utf-8?B?eWlDcms5Qm1HcWtwaE5rQ3YwOFdwY2JibURVSFVXd3NnaTJValhrWlJlbHVO?=
 =?utf-8?B?YU1xbEZxY0hTZmpybXU4cTdmcml6Vnh0TmlvbjFiYUtPcUJwSVdtSHpWaytT?=
 =?utf-8?B?MFdGZDJrM0IwbVliN0xYTk1GdytyMnJPam92dXhhQmFma215eEd1VWgvVEl1?=
 =?utf-8?B?S0N4TXh1aGZzS1FQTG83RlVUOHI5a0RWODJYK0FIWVY2aHRSbmtIZ3QraXlk?=
 =?utf-8?B?TFpCYnl0WEgrYm9UMGtyeXh5dFpSK3Y1YWQwZTdMZllPYVY4dU5tZFd5QStr?=
 =?utf-8?B?TkJUZjlEeEVTQ3o2NTFTMUlVWlhsb3EyV05NK2ZzYlZZcWd5QnNlckI1Vm56?=
 =?utf-8?B?bTRycEUySU10eFg1SWNWMkxIenUydGtoclhVQmNtVUlnVjZoRVZMck5CYWEr?=
 =?utf-8?B?VnVBRzdCVk1CVW5rK3BTVzZoVHZEQ3czaGFTVVBtOHdkaXZ1Qmt1cUFJeWNQ?=
 =?utf-8?B?V0FxR3B2aVRqMys1UzBUU2Vjc2NwSWo3M0xadGh5WjJQc3RGc2hycWM1c3VN?=
 =?utf-8?B?ZkRDUmhrUldLV1hSVWFSM1hTTWNLSjhYQlROd2tRa0xTUU9NRkVDRFZGeng1?=
 =?utf-8?B?ZGJwYlhZM2dDNnZRUVNHVFFnUFNpZVNIY2dzUEVFYTB6VGlvbDQ5WmxoSWxs?=
 =?utf-8?B?QlJPaFFDSmk0L2tOZmtJMjJlNGt4SUZQU3dmb1JDY2lwaFRyMWt6ZFFrOXZW?=
 =?utf-8?B?MndLZTFXWEJhZVB5dmprK0NWV3MwNitQMEFBK1pkTks3aEl4dTZSa3EvUS8y?=
 =?utf-8?B?MHZzZytWSk9KRWJvcEczYXgvRm44Vks0Z0doZXNFY1cralRNcGs2YjB4L2Mz?=
 =?utf-8?B?VDVLMlkrWU1kcVBKZnAyMVpHb2FoT2RSZ3FmWlNYWkVYVFoxSjd6VmZtcjly?=
 =?utf-8?B?VzVlbUZHcUxHQVBYR0JubFNLcXNyUi93QjU3WG9OMC9qd0dzUkpKWGxtVVpl?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F291C7639B85534FB6E2B95649C245FF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce03fc00-beab-4685-499d-08dc23897c87
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 00:54:18.6183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KSbe/SmNRs8InttQpZQVYx3AVh+8mrws+VCx0ChcOdHIkDxHviqVACNJu68k00lBeBFp0sfPC6wi8M4tHvtO7ibu2XPCPAn9o/PQ0zD0lXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7624
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAxLTMxIGF0IDExOjMxICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBO
b3RlIGtleGVjKCkgY2FuIGhhcHBlbiBhdCBhbnl0aW1lLCBpbmNsdWRpbmcgd2hlbiBURFggbW9k
dWxlIGlzDQo+IGJlaW5nDQo+IGluaXRpYWxpemVkLsKgIFJlZ2lzdGVyIFREWCByZWJvb3Qgbm90
aWZpZXIgY2FsbGJhY2sgdG8gc3RvcCBmdXJ0aGVyDQo+IFREWA0KPiBtb2R1bGUgaW5pdGlhbGl6
YXRpb24uwqAgSWYgdGhlcmUncyBhbnkgb25nb2luZyBtb2R1bGUgaW5pdGlhbGl6YXRpb24sDQo+
IHdhaXQgdW50aWwgaXQgZmluaXNoZXMuwqAgVGhpcyBtYWtlcyBzdXJlIHRoZSBURFggbW9kdWxl
IHN0YXR1cyBpcw0KPiBzdGFibGUNCj4gYWZ0ZXIgdGhlIHJlYm9vdCBub3RpZmllciBjYWxsYmFj
aywgYW5kIHRoZSBsYXRlciBrZXhlYygpIGNvZGUgY2FuDQo+IHJlYWQNCj4gbW9kdWxlIHN0YXR1
cyB0byBkZWNpZGUgd2hldGhlciBQQU1UcyBhcmUgc3RhYmxlIGFuZCBhdmFpbGFibGUuDQoNCkkg
ZG9uJ3Qgc2VlIGhvdyB0aGlzIHdvcmtzIHdpdGggdGhlIGNyYXNoIGtlcm5lbCBmbGF2b3Igb2Yg
a2V4ZWMuIERpZA0KeW91IGxvb2sgYXQgdGhhdCBzY2VuYXJpbz8NCg0KDQo=

