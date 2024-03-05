Return-Path: <linux-kernel+bounces-92400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0815871FB0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46251C21C87
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA10C8593D;
	Tue,  5 Mar 2024 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CSdHSzHt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B3758AB6;
	Tue,  5 Mar 2024 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709643357; cv=fail; b=eJ9ZtAE4RIhv1c0Y6N726MiTsKFOwVJa6Gc0YFfYYtfcel/OSv59ONmJDcXMB6ZF6Qz+UsSAaN03L2X+/euyKjnUBnlzLwLAY98C2WJSbzhRHh5VhCSuBPxvyrgpYLmXq27RwSjiY16S8ewfjp74osTecXeAmbqesjj941vtjkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709643357; c=relaxed/simple;
	bh=+Xp7CPuIZWvbiz9VO1Y+9sMCzkPK7wSarq9ZAEHBiGQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ivYS32kEFUoSFA6TaL5WkAR9z0NBAhQHoo2Fn+2EQZWBP9B8rzOy8+732Qeb7JCKMG+GmdQDUfgMU3nVjq54CkjYUPVyDI/sbCLv79hv+iAuiJ8fVbxvewoqA1s8Eis4nYYFuPRvf3ub5V3GkOJR7LzNNEsluiMDZliNpkftQ44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CSdHSzHt; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709643355; x=1741179355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+Xp7CPuIZWvbiz9VO1Y+9sMCzkPK7wSarq9ZAEHBiGQ=;
  b=CSdHSzHtejKnGayGNxh6vC0XzZcGuPoLdLrj1IUzikWGKOEyr3ZSPadv
   BlEPQgIRkza4P65KgdjA/UVgITPNQylHIdDTyXTeopLGvcanlATq4m6/z
   dUkQvpc1pIBtFWX01hh7cTJNBpjFyeLPzumXrNmLoeUYQzM3b/rAhVv/0
   4TM7kuj9l7oWMVgvFtKb9EgYWT/YJgfOs0zwYy/Wz0L4Nf5Z5ujwxTDQM
   AgEUiQGg6iHY2HzHXE3u6VSPWx98ux2gG/zUMJYLf/AUARj1PiZ0wXU5/
   zdhQtPNo7I4KpraB6pYJHSpqy+l+boRcvNPb0b5IS5UBbb9dWchmAMKfQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="8001432"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="8001432"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 04:55:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9306252"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 04:55:55 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 04:55:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 04:55:53 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 04:55:53 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 04:55:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiBLPNWYcLOZlUMoCMxWmR57D6XwyaSQu3E/MuIHqyO9lrx9DHG6s0R02sDAsqUflhLRx9j3XlOOX3rWSNtRldPSQs8gAnQP4/P6J4AKFelgKDT4M5tjBBQ3T9woEYtWDHQYC/H89sCgcpGBN11798doxDqSWAQ2V52hp3/RG6MC6rXqbrPzGP336xZyWd98sCiVrusdUrbDwZLjGDCnVHDLt0UVT4pyY0Qt7TXBi9MZk70BUAPyq3WJeFevGkkoOJiFR63NwgRCmO+CnhspzsZgOXc1neIGdH0Aun+Mzr2FhsfT06JPkQErfbNf0D6p3Qve2BACjs2GZqB1i+t9uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Xp7CPuIZWvbiz9VO1Y+9sMCzkPK7wSarq9ZAEHBiGQ=;
 b=atPNF18z666EYXSKuCzJWbD6CnpLplhNUXFX6481nQpZK4ut2IpTXPIPun/AJ2tim9lZ0wD0flMtDQl5nHhuzCp8iJnI2FKUizm1KiGE2W5RctvFq9bGBFP87xtOtEp1AV9djxlCCT86gA9qWsYV5aseYU63XMjw34XjOb27L5ERx0leptqOJlmSD+SXUbC+9+YtH3eQg20NA+tyj6+rjus/sDlJVfIqYtPDlSbwZkypxyMKSsvQpLUWnQolsyEccp96qQYslJQG3CMVxuIFP36TaaRG2ILmCW0I1t2fGW3iZBL1AEQJlCTNG8P+szx+nI7q0UysgcIpdannk2gAHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by IA0PR11MB7329.namprd11.prod.outlook.com (2603:10b6:208:437::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Tue, 5 Mar
 2024 12:55:17 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::5144:aca9:5cd9:42bf]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::5144:aca9:5cd9:42bf%3]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 12:55:17 +0000
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>, Jens Wiklander
	<jens.wiklander@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, "Shyam
 Saini" <shyamsaini@linux.microsoft.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Subject: RE: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Thread-Topic: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Thread-Index: AQHaaZI6hlE8ndSfV0SK+qyaZjIC67EpHN4AgAAIdAA=
Date: Tue, 5 Mar 2024 12:55:17 +0000
Message-ID: <PH7PR11MB7605979F0DC103BFCC617FF2E5222@PH7PR11MB7605.namprd11.prod.outlook.com>
References: <20240227153132.2611499-1-jens.wiklander@linaro.org>
 <20240227153132.2611499-2-jens.wiklander@linaro.org>
 <CACRpkdZBWBio8kvKuVzj2CknCb4eS=VB2EqUsAK-vf4e328icg@mail.gmail.com>
In-Reply-To: <CACRpkdZBWBio8kvKuVzj2CknCb4eS=VB2EqUsAK-vf4e328icg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7605:EE_|IA0PR11MB7329:EE_
x-ms-office365-filtering-correlation-id: 980fca09-da14-4ef6-65ea-08dc3d138206
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z2EKAH1SySi5WOKfdvbn8fxq9LHvjGWR86MrHO4RZlS2ALVia/kftZnVkRS72LwR49iLkozOZLFuMMxJW2h0QFMPhhB93/fD0YyibvQZDjgCK/DhaGI2pxXC7nXrSTdciU09oRab+FDgITqWici0pa9meFv1c6+FTLKBP69UtRMmtd9dNZ5HK4DS4gtJDX0tLRYaeRICRWLnKYI0htPnS32/SOz/vLkIdxrlExK1UCalhImk2TwAY9q1hjtwHt16r7Eg4Bh8WTvwhX+E95Ma5suGyLVp9wEOaySznCXfn4WGhLJeNvhLA8OQPHFPpVCOpbbaJl7FMebknI5w5zuRDCGD1ek5rbsalk4y9S1NzzSFMC5UmPqP+RCpe7mMK/b2uk7NfgiDNq/eX1OKV08AV5q2vyPyC2mM/YE5MSpZ1AYgy9zWosOhqtzyk2OpepcnzrnIHzC+y4PH8G4AorYA4I71bwMuEbrwYJd7o+1ntt+I2NeUCdg6JwmUfICpvCCKpgc2HhkdGj8hBSurDc9cN1ClzWG63xS/wIH8T9NM20BHqG0GDtqTlTK3PdFWZPyiV1epHrAipXoyO3RlH8ethnLUDgF0HNjDhXbcqZaNVCUPkyH1ZH0/vp5xrnY22JOT0Wn5StOhojXRJyT3WeIHltLLbacxUevLWF+XNzfVuMaeqInJQCW4q7l30HeSEtXAE5oYXcf64o/fhsIhzlNURg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1JKbDA0aW43ZGE2RHVoZ3ZwbWkvaDBBUHRPKy80U0pRODlkRjh0dnRST3p5?=
 =?utf-8?B?MmFRT2x0ME1HUUQvQ2IwdHovV0YwbUhPeGJuK3dyZENOTlhWa2hjWVdpR2Vo?=
 =?utf-8?B?VzV3a09JQWduYjg0OVIzZC8xUGVaTSsxSVplaUR2dFkrMnlOaEZBU0hrZTcv?=
 =?utf-8?B?TE96VnpvTmwvNWNOWjRMQ3kwNkpNVEUyTmZMODdxSnIzMkpNbUFrWXM1UzhF?=
 =?utf-8?B?QzB0Vmd1eWJLdWc0LzNXYnc4Mjk2eHN1TmJFb0Z4SERRTU0rSWhmTW91ak5J?=
 =?utf-8?B?WXRtSE9JdlUrL1Z0Z0tHWGZ6SC8rQzlHUzFlVTNjNkFQdmJ1RlJ0Z1laa3hi?=
 =?utf-8?B?b2FFWTFFRXRnaENkM25DdDNSN2VWRmk5L0RlNHpoN1JiOWpzalVSdlpHbVJS?=
 =?utf-8?B?VVZjQVFOYXVPNXV1NkJIS0kvZ2xTek9PNTdQZGZTM2M3a2FWaS9MV21MOHRS?=
 =?utf-8?B?RmFRSnFwanpSMGZDYWUvR2xWZWVKbmVzK205WGJ0cTB0OE9WWVVkeWlobDRy?=
 =?utf-8?B?dng1dkhFaXUzR3dEbm9NZkhvNGtVZUJwYW1KYi8vM1dDQnZXSC9zbjduZm9p?=
 =?utf-8?B?dEZwSU1jV0gzc0FUWkp5ZkRHRE5zSWVTbE1TY2dkT3l0S3c3eWFGeFFEOEdl?=
 =?utf-8?B?MUg5Y21tZ3llRVBVRlNqcEpLQThLbitCNEloNWRuemNRejlDRk8vdWZQdElk?=
 =?utf-8?B?UmVZeTFpRUhYV0VFbnQwckVGajlXdTNXV3BKY2QxU3JEM2hnNnlBQnh3N2xP?=
 =?utf-8?B?NUxDR1hMY2F3QTBJTFlPaFZ4SjNJWjc3YXYzbXk3U3d2YUFKaVRvMDFqQVdz?=
 =?utf-8?B?b1VqdTNTWGxpanIyNW5WbG8zeHhST1lDZlk0U2Jrc2Z3Tm1razhtdXF5eWFn?=
 =?utf-8?B?V0NLcUE5VzVvbTlXUlh3MVdwVjZ6TzNtcVF4L2ZGc0NzMDdreVdXYVloWG9z?=
 =?utf-8?B?dlpyUlNqUldkc0Rod0F0WjZGRGVtT0xRVllrbXI3Y0FxYjlyd2M4Z3B3NHBE?=
 =?utf-8?B?N1RiVnR4MXprd05ONDVCUVdFWS9JampINHloMC9Oazc4UENaWnd5a0JYV1pj?=
 =?utf-8?B?REdPWkFvS0FqbVRqYndpUnFJcEllWmxjb3pqSFJFSGlyRUtWSmVPdUpwdTdI?=
 =?utf-8?B?RWFoRUY4Z2JmRlVscFZzNXZjNXlwUk1rL0FtTG9LODFndFlPMnpMM1h1VXJw?=
 =?utf-8?B?aDVMS2o1ZnZSU0pCY2ovcXZzSHpDRzlJRUpnTXdBemIwaStCMzRHNTZYTFY1?=
 =?utf-8?B?UXh6NE5OY2lQNWJqdjFTWkdpMEplY1N6cThZZXNhSGowWmJzZjcwbVhzNTJP?=
 =?utf-8?B?Y1puT1VCdSt1M1pobndSb0ZZS2VENlAycHBwRTl6ZHUrcE9WdnAyV2dwKysw?=
 =?utf-8?B?bUpKVWczZ09vWHZxVGZSM0NMTmVNSnBmS1VheUh5ZzlEVEMwM3p6ZHlORFRV?=
 =?utf-8?B?YnNxNi80UHJDWXl0RGVpN2xUWEpsckE0bkp0MXAyM3RUQXE0MFZBMm96WGVt?=
 =?utf-8?B?SWM3ejhUWUpMK1drVVk4SGFlbU1xSVRKTUpNWTA0bTJ1K29ac1RuQVNjeEdt?=
 =?utf-8?B?aWp0SzJmaUlaTDNhU3ZxYkZUSGpCMk5zcCs3bG1vVWtSa3BnZWFzMkNwSTFi?=
 =?utf-8?B?dkJ1SUhBVHFsQWNVQU5EaHg2amZKWkkxSkZCUVJlSWVMay91Wmo4UTlrRXVv?=
 =?utf-8?B?dW4xalZnUitOR3g1S2RURXg4UmduZ3JvTzVvT2xGVThRamhSTDY2RDg1bjJo?=
 =?utf-8?B?QWJsSFRkNGFobXVHSVRRTXY0aDFRdXhOVmsrbExqU1JtZHlEU3UwSCtZdC9t?=
 =?utf-8?B?UFcydWkrOWFnZDdEaFpFWGgyMkNFSzY3ek4zT2dyWFhROE4xNGxMaGhPalZY?=
 =?utf-8?B?OVFpQUloWkVNODB2ZUQ0R1hEN01XWlM4anlJQjZ2MHNPMUxseFJJd29sanZt?=
 =?utf-8?B?M1RLWE1sdjFrK1JjN0QwN2piRGRJSkJMRGZSMEVBajA3akZnTEoyaG85c2lL?=
 =?utf-8?B?Z0hSVWZZeHpBd2xkMjVwVUYrS1hRQW1qTHh0U2FvRGU5SHBvUnkwOVRCSXpq?=
 =?utf-8?B?cWEyRkJRZHJob3lJRm9UaStJTVpiRVZ6QmYydWR4UXJxUXo2WUV6T0k3ajV3?=
 =?utf-8?Q?nTd0AvKoTzkWvK+W0WlRErzfI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980fca09-da14-4ef6-65ea-08dc3d138206
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 12:55:17.4341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sF7V6b6wzpjuLobXd1XbTDxQlGtcZrQth2gdqV4T1VqTne+WS7VM78584Z26EO1iGfjtICjxwMqdmLOzqVccpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7329
X-OriginatorOrg: intel.com

DQo+IEhpIEplbnMsDQo+IA0KPiB0aGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiBPbiBUdWUs
IEZlYiAyNywgMjAyNCBhdCA0OjMx4oCvUE0gSmVucyBXaWtsYW5kZXIgPGplbnMud2lrbGFuZGVy
QGxpbmFyby5vcmc+DQo+IHdyb3RlOg0KPiANCj4gPiBBIG51bWJlciBvZiBzdG9yYWdlIHRlY2hu
b2xvZ2llcyBzdXBwb3J0IGEgc3BlY2lhbGlzZWQgaGFyZHdhcmUNCj4gPiBwYXJ0aXRpb24gZGVz
aWduZWQgdG8gYmUgcmVzaXN0YW50IHRvIHJlcGxheSBhdHRhY2tzLiBUaGUgdW5kZXJseWluZw0K
PiA+IEhXIHByb3RvY29scyBkaWZmZXIgYnV0IHRoZSBvcGVyYXRpb25zIGFyZSBjb21tb24uIFRo
ZSBSUE1CIHBhcnRpdGlvbg0KPiA+IGNhbm5vdCBiZSBhY2Nlc3NlZCB2aWEgc3RhbmRhcmQgYmxv
Y2sgbGF5ZXIsIGJ1dCBieSBhIHNldCBvZiBzcGVjaWZpYw0KPiA+IFJQTUIgY29tbWFuZHM6IFdS
SVRFLCBSRUFELCBHRVRfV1JJVEVfQ09VTlRFUiwgYW5kDQo+IFBST0dSQU1fS0VZLiBTdWNoIGEN
Cj4gPiBwYXJ0aXRpb24gcHJvdmlkZXMgYXV0aGVudGljYXRlZCBhbmQgcmVwbGF5IHByb3RlY3Rl
ZCBhY2Nlc3MsIGhlbmNlDQo+ID4gc3VpdGFibGUgYXMgYSBzZWN1cmUgc3RvcmFnZS4NCj4gPg0K
PiA+IFRoZSBpbml0aWFsIGFpbSBvZiB0aGlzIHBhdGNoIGlzIHRvIHByb3ZpZGUgYSBzaW1wbGUg
UlBNQiBkcml2ZXINCj4gPiBpbnRlcmZhY2Ugd2hpY2ggY2FuIGJlIGFjY2Vzc2VkIGJ5IHRoZSBv
cHRlZSBkcml2ZXIgdG8gZmFjaWxpdGF0ZQ0KPiA+IGVhcmx5IFJQTUIgYWNjZXNzIHRvIE9QLVRF
RSBPUyAoc2VjdXJlIE9TKSBkdXJpbmcgdGhlIGJvb3QgdGltZS4NCj4gPg0KPiA+IEEgVEVFIGRl
dmljZSBkcml2ZXIgY2FuIGNsYWltIHRoZSBSUE1CIGludGVyZmFjZSwgZm9yIGV4YW1wbGUsIHZp
YQ0KPiA+IHJwbWJfaW50ZXJmYWNlX3JlZ2lzdGVyKCkgb3IgcnBtYl9kZXZfZmluZF9kZXZpY2Uo
KS4gVGhlIFJQTUIgZHJpdmVyDQo+ID4gcHJvdmlkZXMgYSBjYWxsYmFjayB0byByb3V0ZSBSUE1C
IGZyYW1lcyB0byB0aGUgUlBNQiBkZXZpY2UgYWNjZXNzaWJsZQ0KPiA+IHZpYSBycG1iX3JvdXRl
X2ZyYW1lcygpLg0KPiA+DQo+ID4gVGhlIGRldGFpbGVkIG9wZXJhdGlvbiBvZiBpbXBsZW1lbnRp
bmcgdGhlIGFjY2VzcyBpcyBsZWZ0IHRvIHRoZSBURUUNCj4gPiBkZXZpY2UgZHJpdmVyIGl0c2Vs
Zi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRvbWFzIFdpbmtsZXIgPHRvbWFzLndpbmtsZXJA
aW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVA
bGluYXJvLm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaHlhbSBTYWluaSA8c2h5YW1zYWluaUBs
aW51eC5taWNyb3NvZnQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEplbnMgV2lrbGFuZGVyIDxq
ZW5zLndpa2xhbmRlckBsaW5hcm8ub3JnPg0KPiANCj4gSSB3b3VsZCBtZW50aW9uIGluIHRoZSBj
b21taXQgdGhhdCB0aGUgc3Vic3lzdGVtIGlzIGN1cnJlbnRseSBvbmx5IHVzZWQgd2l0aA0KPiBl
TU1DIGJ1dCBpcyBkZXNpZ25lZCB0byBiZSB1c2VkIGFsc28gYnkgVUZTIGFuZCBOVk1FLiBOZXZl
cnRoZWxlc3MsIG5vDQo+IGJpZyBkZWFsIHNvOg0KPiBSZXZpZXdlZC1ieTogTGludXMgV2FsbGVp
aiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0KPiANCj4gPiArY29uZmlnIFJQTUINCj4gPiAr
ICAgICAgIHRyaXN0YXRlICJSUE1CIHBhcnRpdGlvbiBpbnRlcmZhY2UiDQo+ID4gKyAgICAgICBk
ZXBlbmRzIG9uIE1NQw0KPiANCj4gZGVwZW5kcyBvbiBNTUMgfHwgU0NTSV9VRlNIQ0QgfHwgTlZN
RV9DT1JFID8NCj4gDQo+IE9yIGRvIHdlIHdhbnQgdG8gaG9sZCBpdCBvZmYgdW50aWwgd2UgaW1w
bGVtZW50IHRoZSBiYWNrZW5kcz8NCg0KSSBiZWxpZXZlIEkndmUgc2VudCB0aGUgaW1wbGVtZW50
YXRpb24gZm9yIGFsbCB0aGUgYmFja2VuZHMsIG5lZWQgdG8gc2VhcmNoIHRoZSBtYWlsaW5nIGxp
c3QuDQoNCg0K

