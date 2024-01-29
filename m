Return-Path: <linux-kernel+bounces-43036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C991A840A91
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56DAB1F23792
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23B81552EF;
	Mon, 29 Jan 2024 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDEoydQo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EE6153BE2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543463; cv=fail; b=djPePr6uCX4AV5Z/Q1dDGZWSSMCbzAjnh4ijtq/yysGKGAW2Mdm0fRPPw5Q9Z+/VKgj0TYlfrIEZQ2IEFw7MVVqkLr6bv88GzZHlPn1zl9V2GNDNkguFYWGUX1mdX/8BcjHqx/4y3k6S79c7rWSGPuFCbt7Z/wZ7Gs3MT9iloyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543463; c=relaxed/simple;
	bh=s6Y4vPUGUxiv9kQRbIP4e2a03gd/OAuFueUTiZRUmCk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pOeQuE1FRP+dYA+B7AvuVKWfRfV9EdYdPisIMi6ybNHUJYslL0BNeKfFOPG77cgQ6AVly+OS7KFnI0E540IO0VU/iKh5tpkROsWMuzhm2JmfKuROojHFP5pSG0mlVz4QQyu0DUluuxhD8y6uj7F6BhKRUEFo+xLGotU2IA4Ng+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDEoydQo; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706543462; x=1738079462;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s6Y4vPUGUxiv9kQRbIP4e2a03gd/OAuFueUTiZRUmCk=;
  b=ZDEoydQoEEvEmHPAhQdiyXaXwWFe1ILBQ4Q+cOEyO/3H9rbyZPDnTJgN
   BrQDwhb4CbsWIc/1o6yPvekxq3O09X5rbElVuzpQN9H5b0e0ok4pcG7gW
   E3mb8Loh8xYhdldRS3MqRcs87c9GbY57fcvZIGcRdnbXRkh3cNwPODSQv
   5U4WAvv1VHx/FEjBftSyDhFzYimU7ItSCYwFB9QRqDutmxtkIelLJeG9G
   11ShWu+6xUZpTzxPK5mSSnifTs1xXMKzdA8W4mGFbp0RxhxExfDfUPXkv
   2wZ3erdJC4OPe9qy2bJQi/smurj6m42W3MalORxmdNf/oTkBvZOXxcodk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="1916017"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="1916017"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 07:51:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="29820943"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 07:51:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 07:50:59 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 07:50:59 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 07:50:59 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 07:50:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWgKyTuj5k5z8rej53TYSp5K+lFdXaJ20RnrwMz+E2oBzrEZ0+npHmgJdwC6McUsiVWQ6q5objvNeE/PJfpWHST2dljCwTt+eoGgKZrHa8SbQw1BK5HFAilKIYGfdSMRTTub7OhLUOmsaBsEjkGeKNgvD7S/JjVBspWzk9EagaAI/sFvwHMk5dHys8mu+i+CEdRqCYEt0OWyakGpYYCrarE4Pjcvtm5qJZZRoXCOWZZxrTXCNn8beBLi1GibpkL5Y8fwEAmbTZDvZ8Fv/MBH87sw/jgvnesve4dDbEIAYo0U8GbHPIQdFdRnkxCNG5unblZcdWaLU4VWDxaOwRZeeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6Y4vPUGUxiv9kQRbIP4e2a03gd/OAuFueUTiZRUmCk=;
 b=h0Fp/yFPwUFGba3rLF6DpPLa7bzOpQ3s/AHTUtnE1REoHkqcCC6xIyzn5/VywWvxmNGsG9oN4/SZPJkBMtpWTHqpE4SdbiIgsY30erHW6A75lnQyHJFu40TpKvddU96F0Csu14mMTt8ZKX2LvsRxlIRngBuHByXEhiDpskY0h17+zaHELOnf/uQXEJjiOGDbo3MBnUsUPF6r9HEL01nfIDJ2F0yGESJHdtB6I5L4Fc95XkZhPcIiNzMGkohqNi0QgIeU/4iOHu4uIT+FVSbbEeUnawqEhPX5Uj63IVsE3vq68cl+P1WoWPxRkhJiFalzVb8KuSv0ZafYCaOF+boIAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by DM4PR11MB7350.namprd11.prod.outlook.com (2603:10b6:8:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 15:50:56 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::98c3:e090:252e:7967]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::98c3:e090:252e:7967%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 15:50:56 +0000
From: "Souza, Jose" <jose.souza@intel.com>
To: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "quic_mojha@quicinc.com" <quic_mojha@quicinc.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>, "rafael@kernel.org"
	<rafael@kernel.org>
Subject: Re: [PATCH 2/2] devcoredump: Remove the mutex serialization
Thread-Topic: [PATCH 2/2] devcoredump: Remove the mutex serialization
Thread-Index: AQHaUGnxFUhcpw8V/kqDCPrHHy8FALDw9QyA
Date: Mon, 29 Jan 2024 15:50:56 +0000
Message-ID: <c021635fa54a3e67128a8be0b2ff83774308ee3b.camel@intel.com>
References: <20240126151121.1076079-1-rodrigo.vivi@intel.com>
	 <20240126151121.1076079-2-rodrigo.vivi@intel.com>
In-Reply-To: <20240126151121.1076079-2-rodrigo.vivi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|DM4PR11MB7350:EE_
x-ms-office365-filtering-correlation-id: 492ef1d1-095b-4c0b-c777-08dc20e214c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fD/icbcxoZIKIbTGAGPZ7we7MxjF6ggw2aMTe9LPlpnouV/SMQZS1lsrkSuTtTNvuHxak8FnDxgQRlr+llwc7EX1P0PSUdIg4GhmRX4ZG5T3cXg44kJyc1aAjisVSE1IdN34UkZnFs9kxZxhtCetmKREX7blCuYNAS734hf4qv2CV2D8iI4Ht/qVTipS1VPvMNBpNI4ovY3uk7kNv9yq71hXx1rCasuwx6LAbz/qcUJJLMMmDzq3hUghshiUJHTzTBTFwVgm0KNJiadGI5UeAwpIjcZgopPHL91CxDmLomFT2hGcvRvSotVOGwtUj9tXIuV4+2Y4ukZ7TPJ+hHmq4ir5vzpNKAN/PiafSEsWRBkzurrIydKK9CqdpyvtNmP77SADE7yHPDSLCcylAazAue1VjWV6s6wFqfUv/SMT2MKAgrCFszphN6VVnO6OHe6iC+uzHnsMCoisPyNW+N1gn006J1BQXQqf1WVzdL9L4xUGAosZoDgsvMeg0WN6wjvxMexGBpjk7YUnopQm6vVvXkKgE9vy+6Liw35BSvKqaW0kXxpwVQpvxhmH6WQ9P5AFLgXhZs5aXZ3ROVu6mPBp5uEg5GyoEPcxmTKOMrI1K7hvVNhD7GtghWUYovFSbOw9eI+IVQKQYUdloVW0bH7+gA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(83380400001)(86362001)(82960400001)(36756003)(38070700009)(122000001)(38100700002)(26005)(6512007)(2616005)(66446008)(66556008)(6506007)(6486002)(2906002)(8676002)(478600001)(110136005)(76116006)(316002)(71200400001)(54906003)(64756008)(66946007)(66476007)(41300700001)(8936002)(4326008)(5660300002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHluMnY5ZXk1cEFHMUdqMGlWdkUvdVUrMXlwcjVMSU5sckNPelBrL1lsMFg4?=
 =?utf-8?B?UXVwcEpQQzVVWlBEMmNyWGpQSU9HU3p1SWw1YnhBZlR2TEJkS1NsdEN2ak1Z?=
 =?utf-8?B?ck0yaVdXQVo3b1dSZXhCMGNwOVI2OW4vaGZJSXNDNWFyQWtMMjBKQzVvQk53?=
 =?utf-8?B?OVBCajVkTkpla0JxZWtkR255YmZidm9lL0kzdzA2eEhoTEYxK2Z4VG0xQU9Q?=
 =?utf-8?B?U1lwU1I3ZXdHRTIrMWF6OU5pZ2lHU24zdlU2RjBqa004SW9abUVWYzBxR253?=
 =?utf-8?B?UEhFQjZFS3kwOUVRY2JTTjc2alhlWXpPMU1RNUw4K1hPSXM5ZThFWmtybHZB?=
 =?utf-8?B?Ni9xR3h6U0FPdzgvNmVRbE9rRkV6cW56L3llK3JsazZSeG1RWUs5YmhhMmo0?=
 =?utf-8?B?aUpyc05qanpHTzFNLzAyYzgvNWR4WWNKUU9LNFVnZ1Zwa2Y2M3g3SmNVMExG?=
 =?utf-8?B?WlArR2tmeFNpalY4VFdqWWw3SnFROHFFMzh0ZktXTnNtVkNwMFJ5WHduZ25v?=
 =?utf-8?B?MGQ2V0hMaVlQSHhxR2tKdUN0ZlNZMGYrdkNiVldTRFNZNjQ5ZlRCTE5WVDZX?=
 =?utf-8?B?ZkhuWmVhZzhnYlpjcFZyWmpQNTAzRDg3N2RSTHp4N2xhTmFkTEZPNEo0eWVT?=
 =?utf-8?B?RWxIczNRVURBK0JVd3ByRktrT1dsNTFnV09UWXFvRjlWd3hzZ0k0QzZWaGtq?=
 =?utf-8?B?dGFVSy9mYi96M1lubzNveExQZC9jT1hZVXlpeE1zSHp1TE4wTGVEcW1oRFlp?=
 =?utf-8?B?T1JPa2N3TjUxdkdJYW1FV0dFYlQxeXZ2WDNSSENLdnlwRmRDMkN2WU5jUllU?=
 =?utf-8?B?UmVkZGtBRHdsc1F6djUydWR0bm1qZ0JwRmVSZldFTHM0WXZZZFc2Q212aFB6?=
 =?utf-8?B?di91VVZYYkVqTjl3VGFsZzZ5NDJIN21DcE9MRXFNL2E1blYxMHJEYXV0T29R?=
 =?utf-8?B?ODFybStuRG5yKytZQmVBaEhGWnROSm9lNjZsalNJbWZqN0FkdUVjSWlXWmVD?=
 =?utf-8?B?eWI5dnNHOHk0ZlEwMVZ1STgvaFVCRzEzUkp1NE5GRExnMTV0RXhjZW1Xdk5a?=
 =?utf-8?B?dEJGOTI2SDJIeTJYME5PRzcwR2MyWTRUYmJXMkloamNZQThCN01rUTE3eVY1?=
 =?utf-8?B?d1B4d3BZM0tMYTFHVDk1ZFlNVGtDVDZXNnluYitJYkR6ckpiZFlXZXJNY1hn?=
 =?utf-8?B?UC9ZWGJrTTBoVEhhN0oxSUJTaFQxamVnSGNEV0dXK0NVMHF1SVkzUys2MnA5?=
 =?utf-8?B?RC9MUUFIUlZRK2tPUytBTFVxZ1NtVmpJWTMwODFxSitjaVNGOUlKejZROXZR?=
 =?utf-8?B?WFFmTWpKOS9Na2FMY0NtRTFYMUNTTjdwT0FDSnA2YWZwOFM4UWt3YnFZR3FT?=
 =?utf-8?B?OTdWQWp2SmNDWU1rS0VxUVRsejdaYTNnZ2ppMDNvaUhuaFM1YjBQMktacDI0?=
 =?utf-8?B?ZkVreFluWS94dDYwMWVZb01qRWhMUkxWdGpJYTRtWGhHak05L2lraFB2bTlS?=
 =?utf-8?B?WCtrUlhEQ2c0UXRhRFoxMkc5aXg5WnVTd2RCcm9MWjBieWRoZnlnSXUycjd2?=
 =?utf-8?B?Nm5aaFNTcmJuUmZZVGMvaTEvQVBNQ0RMbE5LTk1wMFcwZjRFMjYxaHpTZjdI?=
 =?utf-8?B?ZTh3TnhGSFAvR1dXbXNUcktGZURHK0ZTTUxFZklya2pFeGNOeWNWOU50dXBt?=
 =?utf-8?B?K0RDSUpIOUN3TDhPNFo1clZWNGlZaFBCakVobFl4MVVOVmozNkc1SjZMWTdG?=
 =?utf-8?B?dDVsU2hKa2Q2K29kb01yUW1oR1k1dWRkZXFNa2ZuRkhTdzRYVG9xc1NPRG5u?=
 =?utf-8?B?b3FZZ3VSNkFHT2JGTzRBWHpEY0lOd09xQnpWdHMwbmU0OWcrN2JPenk2VzZG?=
 =?utf-8?B?VmVDU1doK3Y3SzlrOUVlUkQxaEs3Q1kvdGRmOGdGTTg4cEtWaU9hNDd5Z1Vy?=
 =?utf-8?B?N3AzdDlYd3FOb05wT0lsUWNJcW9EZTBWUUJyNURpQ3Q2amJINVBhcVJWajI2?=
 =?utf-8?B?YnRrZjk4ZVVINW0zR0FxMlVJVlpCVnJoZFVZdjFkLy9haUVYTTVWcXF4Rlpt?=
 =?utf-8?B?dFBRRmlTbHBYWm1SRVhuRG4vWktrMWVFRUo3MHp2TTZocG1wN25RNElqdjBm?=
 =?utf-8?B?MzUyMDNoKzdtWVNhTFA1T1pmQ1EwZkZ1dkJnVWwvaWdZYjRNOFl0c2U1Ymc4?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CF595AD1C652548A6646C759F99DC66@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492ef1d1-095b-4c0b-c777-08dc20e214c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 15:50:56.2325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oYMVE/FSus56WJ9hM6xwkd/Ceuv2YMYJ6qNCpKd2rAtwzv/HVlSIzZwY2tybUH8d/6DEyl6axiRaLDKXksDnjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7350
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAxLTI2IGF0IDEwOjExIC0wNTAwLCBSb2RyaWdvIFZpdmkgd3JvdGU6DQo+
IFRoZSBjb21taXQgMDFkYWNjZjc0ODMyICgiZGV2Y29yZWR1bXAgOiBTZXJpYWxpemUgZGV2Y2Rf
ZGVsIHdvcmsiKQ0KPiBpbnRyb2R1Y2VkIHRoZSBtdXRleCB0byBwcm90ZWN0IHRoZSBjYXNlIHdo
ZXJlIG1vZF9kZWxheWVkX3dvcmsNCj4gY291bGQgYmUgY2FsbGVkIGJlZm9yZSB0aGUgZGVsYXll
ZCB3b3JrIGV2ZW4gZXhpc3RlZC4NCj4gDQo+IEluc3RlYWQsIHdlIGNhbiBzaW1wbHkgaW5pdGlh
bGl6ZSB0aGUgZGVsYXllZCB3b3JrIGJlZm9yZSB0aGUgZGV2aWNlDQo+IGlzIGFkZGVkLCBzbyB0
aGUgcmFjZSBjb25kaXRpb24gZG9lc24ndCBleGlzdCBhdCBmaXJzdCBwbGFjZS4NCj4gDQo+IFRo
ZSBtdXRleF91bmxvY2sgaXMgdmVyeSBwcm9ibGVtYXRpYyBoZXJlLiBBbHRob3VnaCBtb2RfZGVs
YXllZF93b3JrDQo+IGlzIGFzeW5jLCB3ZSBoYXZlIG5vIHdhcnJhbnR5IHRoYXQgdGhlIHdvcmsg
aXMgbm90IGZpbmlzaGVkIGJlZm9yZQ0KPiB0aGUgbXV0ZXhfdW5sb2NrKGRldmNkLT5tdXRleCks
IGFuZCBpZiB0aGF0IGhhcHBlbiAnZGV2Y2QnIGlzIHVzZWQNCj4gYWZ0ZXIgZnJlZWQuDQo+IA0K
DQpSZXZpZXdlZC1ieTogSm9zw6kgUm9iZXJ0byBkZSBTb3V6YSA8am9zZS5zb3V6YUBpbnRlbC5j
b20+DQoNCj4gQ2M6IE11a2VzaCBPamhhIDxxdWljX21vamhhQHF1aWNpbmMuY29tPg0KPiBDYzog
Sm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4NCj4gQ2M6IEdyZWcgS3Jv
YWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IENjOiBSYWZhZWwgSi4g
V3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+IENjOiBKb3NlIFNvdXphIDxqb3NlLnNvdXph
QGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUm9kcmlnbyBWaXZpIDxyb2RyaWdvLnZpdmlA
aW50ZWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvYmFzZS9kZXZjb3JlZHVtcC5jIHwgOTcgKysr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKyksIDkxIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYmFzZS9kZXZjb3JlZHVtcC5jIGIvZHJpdmVycy9iYXNlL2RldmNvcmVkdW1wLmMNCj4gaW5k
ZXggNjc4ZWNjMmZhMjQyLi4wZTI2YjEyNzM5MjAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYmFz
ZS9kZXZjb3JlZHVtcC5jDQo+ICsrKyBiL2RyaXZlcnMvYmFzZS9kZXZjb3JlZHVtcC5jDQo+IEBA
IC0yNSw0NyArMjUsNiBAQCBzdHJ1Y3QgZGV2Y2RfZW50cnkgew0KPiAgCXN0cnVjdCBkZXZpY2Ug
ZGV2Y2RfZGV2Ow0KPiAgCXZvaWQgKmRhdGE7DQo+ICAJc2l6ZV90IGRhdGFsZW47DQo+IC0JLyoN
Cj4gLQkgKiBIZXJlLCBtdXRleCBpcyByZXF1aXJlZCB0byBzZXJpYWxpemUgdGhlIGNhbGxzIHRv
IGRlbF93ayB3b3JrIGJldHdlZW4NCj4gLQkgKiB1c2VyL2tlcm5lbCBzcGFjZSB3aGljaCBoYXBw
ZW5zIHdoZW4gZGV2Y2QgaXMgYWRkZWQgd2l0aCBkZXZpY2VfYWRkKCkNCj4gLQkgKiBhbmQgdGhh
dCBzZW5kcyB1ZXZlbnQgdG8gdXNlciBzcGFjZS4gVXNlciBzcGFjZSByZWFkcyB0aGUgdWV2ZW50
cywNCj4gLQkgKiBhbmQgY2FsbHMgdG8gZGV2Y2RfZGF0YV93cml0ZSgpIHdoaWNoIHRyeSB0byBt
b2RpZnkgdGhlIHdvcmsgd2hpY2ggaXMNCj4gLQkgKiBub3QgZXZlbiBpbml0aWFsaXplZC9xdWV1
ZWQgZnJvbSBkZXZjb3JlZHVtcC4NCj4gLQkgKg0KPiAtCSAqDQo+IC0JICoNCj4gLQkgKiAgICAg
ICAgY3B1MChYKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNwdTEoWSkNCj4gLQkg
Kg0KPiAtCSAqICAgICAgICBkZXZfY29yZWR1bXAoKSB1ZXZlbnQgc2VudCB0byB1c2VyIHNwYWNl
DQo+IC0JICogICAgICAgIGRldmljZV9hZGQoKSAgPT09PT09PT09PT09PT09PT09PT09PT4gdXNl
ciBzcGFjZSBwcm9jZXNzIFkgcmVhZHMgdGhlDQo+IC0JICogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdWV2ZW50cyB3cml0ZXMgdG8gZGV2Y2QgZmQNCj4gLQkg
KiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB3aGljaCByZXN1
bHRzIGludG8gd3JpdGVzIHRvDQo+IC0JICoNCj4gLQkgKiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGRldmNkX2RhdGFfd3JpdGUoKQ0KPiAtCSAqICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtb2RfZGVsYXllZF93b3JrKCkN
Cj4gLQkgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0
cnlfdG9fZ3JhYl9wZW5kaW5nKCkNCj4gLQkgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGRlbF90aW1lcigpDQo+IC0JICogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlYnVnX2Fzc2VydF9pbml0KCkN
Cj4gLQkgKiAgICAgICBJTklUX0RFTEFZRURfV09SSygpDQo+IC0JICogICAgICAgc2NoZWR1bGVf
ZGVsYXllZF93b3JrKCkNCj4gLQkgKg0KPiAtCSAqDQo+IC0JICogQWxzbywgbXV0ZXggYWxvbmUg
d291bGQgbm90IGJlIGVub3VnaCB0byBhdm9pZCBzY2hlZHVsaW5nIG9mDQo+IC0JICogZGVsX3dr
IHdvcmsgYWZ0ZXIgaXQgZ2V0IGZsdXNoIGZyb20gYSBjYWxsIHRvIGRldmNkX2ZyZWUoKQ0KPiAt
CSAqIG1lbnRpb25lZCBhcyBiZWxvdy4NCj4gLQkgKg0KPiAtCSAqCWRpc2FibGVkX3N0b3JlKCkN
Cj4gLQkgKiAgICAgICAgZGV2Y2RfZnJlZSgpDQo+IC0JICogICAgICAgICAgbXV0ZXhfbG9jaygp
ICAgICAgICAgICAgIGRldmNkX2RhdGFfd3JpdGUoKQ0KPiAtCSAqICAgICAgICAgIGZsdXNoX2Rl
bGF5ZWRfd29yaygpDQo+IC0JICogICAgICAgICAgbXV0ZXhfdW5sb2NrKCkNCj4gLQkgKiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXV0ZXhfbG9jaygpDQo+IC0JICogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1vZF9kZWxheWVkX3dvcmsoKQ0KPiAtCSAqICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtdXRleF91bmxvY2soKQ0KPiAtCSAqIFNv
LCBkZWxldGVfd29yayBmbGFnIGlzIHJlcXVpcmVkLg0KPiAtCSAqLw0KPiAtCXN0cnVjdCBtdXRl
eCBtdXRleDsNCj4gLQlib29sIGRlbGV0ZV93b3JrOw0KPiAgCXN0cnVjdCBtb2R1bGUgKm93bmVy
Ow0KPiAgCXNzaXplX3QgKCpyZWFkKShjaGFyICpidWZmZXIsIGxvZmZfdCBvZmZzZXQsIHNpemVf
dCBjb3VudCwNCj4gIAkJCXZvaWQgKmRhdGEsIHNpemVfdCBkYXRhbGVuKTsNCj4gQEAgLTEyNSwx
MyArODQsOCBAQCBzdGF0aWMgc3NpemVfdCBkZXZjZF9kYXRhX3dyaXRlKHN0cnVjdCBmaWxlICpm
aWxwLCBzdHJ1Y3Qga29iamVjdCAqa29iaiwNCj4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBrb2Jq
X3RvX2Rldihrb2JqKTsNCj4gIAlzdHJ1Y3QgZGV2Y2RfZW50cnkgKmRldmNkID0gZGV2X3RvX2Rl
dmNkKGRldik7DQo+ICANCj4gLQltdXRleF9sb2NrKCZkZXZjZC0+bXV0ZXgpOw0KPiAtCWlmICgh
ZGV2Y2QtPmRlbGV0ZV93b3JrKSB7DQo+IC0JCWRldmNkLT5kZWxldGVfd29yayA9IHRydWU7DQo+
IC0JCW1vZF9kZWxheWVkX3dvcmsoc3lzdGVtX3dxLCAmZGV2Y2QtPmRlbF93aywgMCk7DQo+IC0J
fQ0KPiAtCW11dGV4X3VubG9jaygmZGV2Y2QtPm11dGV4KTsNCj4gLQ0KPiArCS8qIFRoaXMgZmls
ZSBuZWVkcyB0byBiZSBjbG9zZWQgYmVmb3JlIGRldmNkIGNhbiBiZSBkZWxldGVkICovDQo+ICsJ
bW9kX2RlbGF5ZWRfd29yayhzeXN0ZW1fd3EsICZkZXZjZC0+ZGVsX3drLCAwKTsNCj4gIAlyZXR1
cm4gY291bnQ7DQo+ICB9DQo+ICANCj4gQEAgLTE1OCwxMiArMTEyLDcgQEAgc3RhdGljIGludCBk
ZXZjZF9mcmVlKHN0cnVjdCBkZXZpY2UgKmRldiwgdm9pZCAqZGF0YSkNCj4gIHsNCj4gIAlzdHJ1
Y3QgZGV2Y2RfZW50cnkgKmRldmNkID0gZGV2X3RvX2RldmNkKGRldik7DQo+ICANCj4gLQltdXRl
eF9sb2NrKCZkZXZjZC0+bXV0ZXgpOw0KPiAtCWlmICghZGV2Y2QtPmRlbGV0ZV93b3JrKQ0KPiAt
CQlkZXZjZC0+ZGVsZXRlX3dvcmsgPSB0cnVlOw0KPiAtDQo+ICAJZmx1c2hfZGVsYXllZF93b3Jr
KCZkZXZjZC0+ZGVsX3drKTsNCj4gLQltdXRleF91bmxvY2soJmRldmNkLT5tdXRleCk7DQo+ICAJ
cmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gQEAgLTE3MywzMCArMTIyLDYgQEAgc3RhdGljIHNzaXpl
X3QgZGlzYWJsZWRfc2hvdyhjb25zdCBzdHJ1Y3QgY2xhc3MgKmNsYXNzLCBjb25zdCBzdHJ1Y3Qg
Y2xhc3NfYXR0cmkNCj4gIAlyZXR1cm4gc3lzZnNfZW1pdChidWYsICIlZFxuIiwgZGV2Y2RfZGlz
YWJsZWQpOw0KPiAgfQ0KPiAgDQo+IC0vKg0KPiAtICoNCj4gLSAqCWRpc2FibGVkX3N0b3JlKCkg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAl3b3JrZXIoKQ0KPiAtICoJIGNsYXNzX2Zv
cl9lYWNoX2RldmljZSgmZGV2Y2RfY2xhc3MsDQo+IC0gKgkJTlVMTCwgTlVMTCwgZGV2Y2RfZnJl
ZSkNCj4gLSAqICAgICAgICAgLi4uDQo+IC0gKiAgICAgICAgIC4uLg0KPiAtICoJICAgd2hpbGUg
KChkZXYgPSBjbGFzc19kZXZfaXRlcl9uZXh0KCZpdGVyKSkNCj4gLSAqICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldmNkX2RlbCgp
DQo+IC0gKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGRldmljZV9kZWwoKQ0KPiAtICogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHB1dF9kZXZpY2UoKSA8LSBs
YXN0IHJlZmVyZW5jZQ0KPiAtICogICAgICAgICAgICAgZXJyb3IgPSBmbihkZXYsIGRhdGEpICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZGV2Y2RfZGV2X3JlbGVhc2UoKQ0KPiAtICogICAgICAg
ICAgICAgZGV2Y2RfZnJlZShkZXYsIGRhdGEpICAgICAgICAgICAgICAgICAgICAgICAgICAga2Zy
ZWUoZGV2Y2QpDQo+IC0gKiAgICAgICAgICAgICBtdXRleF9sb2NrKCZkZXZjZC0+bXV0ZXgpOw0K
PiAtICoNCj4gLSAqDQo+IC0gKiBJbiB0aGUgYWJvdmUgZGlhZ3JhbSwgSXQgbG9va3MgbGlrZSBk
aXNhYmxlZF9zdG9yZSgpIHdvdWxkIGJlIHJhY2luZyB3aXRoIHBhcmFsbGVseQ0KPiAtICogcnVu
bmluZyBkZXZjZF9kZWwoKSBhbmQgcmVzdWx0IGluIG1lbW9yeSBhYm9ydCB3aGlsZSBhY3F1aXJp
bmcgZGV2Y2QtPm11dGV4IHdoaWNoDQo+IC0gKiBpcyBjYWxsZWQgYWZ0ZXIga2ZyZWUgb2YgZGV2
Y2QgbWVtb3J5ICBhZnRlciBkcm9wcGluZyBpdHMgbGFzdCByZWZlcmVuY2Ugd2l0aA0KPiAtICog
cHV0X2RldmljZSgpLiBIb3dldmVyLCB0aGlzIHdpbGwgbm90IGhhcHBlbnMgYXMgZm4oZGV2LCBk
YXRhKSBydW5zDQo+IC0gKiB3aXRoIGl0cyBvd24gcmVmZXJlbmNlIHRvIGRldmljZSB2aWEga2xp
c3Rfbm9kZSBzbyBpdCBpcyBub3QgaXRzIGxhc3QgcmVmZXJlbmNlLg0KPiAtICogc28sIGFib3Zl
IHNpdHVhdGlvbiB3b3VsZCBub3Qgb2NjdXIuDQo+IC0gKi8NCj4gLQ0KPiAgc3RhdGljIHNzaXpl
X3QgZGlzYWJsZWRfc3RvcmUoY29uc3Qgc3RydWN0IGNsYXNzICpjbGFzcywgY29uc3Qgc3RydWN0
IGNsYXNzX2F0dHJpYnV0ZSAqYXR0ciwNCj4gIAkJCSAgICAgIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6
ZV90IGNvdW50KQ0KPiAgew0KPiBAQCAtMzA4LDEzICsyMzMsNyBAQCBzdGF0aWMgdm9pZCBkZXZj
ZF9yZW1vdmUodm9pZCAqZGF0YSkNCj4gIHsNCj4gIAlzdHJ1Y3QgZGV2Y2RfZW50cnkgKmRldmNk
ID0gZGF0YTsNCj4gIA0KPiAtCW11dGV4X2xvY2soJmRldmNkLT5tdXRleCk7DQo+IC0JaWYgKCFk
ZXZjZC0+ZGVsZXRlX3dvcmspIHsNCj4gLQkJZGV2Y2QtPmRlbGV0ZV93b3JrID0gdHJ1ZTsNCj4g
LQkJLyogWFhYOiBDYW5ub3QgZmx1c2ggb3RoZXJ3aXNlIHRoZSBtdXRleCBiZWxvdyB3aWxsIGhp
dCBhIFVBRiAqLw0KPiAtCQltb2RfZGVsYXllZF93b3JrKHN5c3RlbV93cSwgJmRldmNkLT5kZWxf
d2ssIDApOw0KPiAtCX0NCj4gLQltdXRleF91bmxvY2soJmRldmNkLT5tdXRleCk7DQo+ICsJZmx1
c2hfZGVsYXllZF93b3JrKCZkZXZjZC0+ZGVsX3drKTsNCj4gIH0NCj4gIA0KPiAgLyoqDQo+IEBA
IC0zNjUsMTYgKzI4NCwxNSBAQCB2b2lkIGRldl9jb3JlZHVtcG0oc3RydWN0IGRldmljZSAqZGV2
LCBzdHJ1Y3QgbW9kdWxlICpvd25lciwNCj4gIAlkZXZjZC0+cmVhZCA9IHJlYWQ7DQo+ICAJZGV2
Y2QtPmZyZWUgPSBmcmVlOw0KPiAgCWRldmNkLT5mYWlsaW5nX2RldiA9IGdldF9kZXZpY2UoZGV2
KTsNCj4gLQlkZXZjZC0+ZGVsZXRlX3dvcmsgPSBmYWxzZTsNCj4gIA0KPiAtCW11dGV4X2luaXQo
JmRldmNkLT5tdXRleCk7DQo+ICAJZGV2aWNlX2luaXRpYWxpemUoJmRldmNkLT5kZXZjZF9kZXYp
Ow0KPiAgDQo+ICAJZGV2X3NldF9uYW1lKCZkZXZjZC0+ZGV2Y2RfZGV2LCAiZGV2Y2QlZCIsDQo+
ICAJCSAgICAgYXRvbWljX2luY19yZXR1cm4oJmRldmNkX2NvdW50KSk7DQo+ICAJZGV2Y2QtPmRl
dmNkX2Rldi5jbGFzcyA9ICZkZXZjZF9jbGFzczsNCj4gIA0KPiAtCW11dGV4X2xvY2soJmRldmNk
LT5tdXRleCk7DQo+ICsJSU5JVF9ERUxBWUVEX1dPUksoJmRldmNkLT5kZWxfd2ssIGRldmNkX2Rl
bCk7DQo+ICsJc2NoZWR1bGVfZGVsYXllZF93b3JrKCZkZXZjZC0+ZGVsX3drLCBERVZDRF9USU1F
T1VUKTsNCj4gIAlkZXZfc2V0X3VldmVudF9zdXBwcmVzcygmZGV2Y2QtPmRldmNkX2RldiwgdHJ1
ZSk7DQo+ICAJaWYgKGRldmljZV9hZGQoJmRldmNkLT5kZXZjZF9kZXYpKQ0KPiAgCQlnb3RvIHB1
dF9kZXZpY2U7DQo+IEBAIC0zOTIsMTUgKzMxMCwxMiBAQCB2b2lkIGRldl9jb3JlZHVtcG0oc3Ry
dWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbW9kdWxlICpvd25lciwNCj4gIA0KPiAgCWRldl9zZXRf
dWV2ZW50X3N1cHByZXNzKCZkZXZjZC0+ZGV2Y2RfZGV2LCBmYWxzZSk7DQo+ICAJa29iamVjdF91
ZXZlbnQoJmRldmNkLT5kZXZjZF9kZXYua29iaiwgS09CSl9BREQpOw0KPiAtCUlOSVRfREVMQVlF
RF9XT1JLKCZkZXZjZC0+ZGVsX3drLCBkZXZjZF9kZWwpOw0KPiAtCXNjaGVkdWxlX2RlbGF5ZWRf
d29yaygmZGV2Y2QtPmRlbF93aywgREVWQ0RfVElNRU9VVCk7DQo+ICAJaWYgKGRldm1fYWRkX2Fj
dGlvbihkZXYsIGRldmNkX3JlbW92ZSwgZGV2Y2QpKQ0KPiAgCQlkZXZfd2FybihkZXYsICJkZXZj
b3JlZHVtcCBtYW5hZ2VkIGF1dG8tcmVtb3ZhbCByZWdpc3RyYXRpb24gZmFpbGVkXG4iKTsNCj4g
LQltdXRleF91bmxvY2soJmRldmNkLT5tdXRleCk7DQo+ICAJcmV0dXJuOw0KPiAgIHB1dF9kZXZp
Y2U6DQo+ICsJY2FuY2VsX2RlbGF5ZWRfd29yaygmZGV2Y2QtPmRlbF93ayk7DQo+ICAJcHV0X2Rl
dmljZSgmZGV2Y2QtPmRldmNkX2Rldik7DQo+IC0JbXV0ZXhfdW5sb2NrKCZkZXZjZC0+bXV0ZXgp
Ow0KPiAgIHB1dF9tb2R1bGU6DQo+ICAJbW9kdWxlX3B1dChvd25lcik7DQo+ICAgZnJlZToNCg0K

