Return-Path: <linux-kernel+bounces-30579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBB38320E7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CC81F256D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E443831747;
	Thu, 18 Jan 2024 21:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jqOKwlhz"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3341231758
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705613491; cv=fail; b=pqMWyoX8XMEVcipTap34utK8tMimLo3+2ka4jmz1liRGSQW6zGiVV3zjWQDnNRXe+y/xemf72tmAOT3eUyIWvV4Fy4fpt1XxAXxyuM6bzTg6KtBHnu9bSf2O3bIK2zTrrU8Ksxo+K/rf6vDwXiNDfUe8+0L9lPptcnrHctdb8Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705613491; c=relaxed/simple;
	bh=fH/DTQhCSu1j5AyRedMppy7Qrz78krrDaTrBNqx9Mk8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FZppSLel5kN5nnEml2H62LJTbUSVcRNIsVr+fDY0Co4+mt9LT12+QkMk42lkpc66HwT8RlND1G/KDsvol9I/iRkpkXLwZsMwJnH5kBzJ2arEz2xBVGdtXrA3pJ1CRSAcZho8EyVkR4yNnFSoscOw71HjcOlvmhgWHpMNvc155Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jqOKwlhz; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705613490; x=1737149490;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fH/DTQhCSu1j5AyRedMppy7Qrz78krrDaTrBNqx9Mk8=;
  b=jqOKwlhz+j7VUGqQUJPM4K7OupKpETUtMug9dG4lJNUM+t3EBX+9cg5J
   63Bz9CmOFJSAwonMEMHNYzl7NcgYQ6WK4S9VPELwQSurBbUmKa3NOPU+v
   zMxRXKBibvMOltjSBmDQMpC5XU2SeuCKH6tor+aupT0L36iE/9zQbKSEY
   vzdGPy6mwp/OnTV2Am1GxVWUj9aS+0g63ga6FkRZuJ55OT+32C9BfOeq0
   olUXpgWgc0xjpH7CWL73kKpZBg3Z/QykwM6sOiO5hYuRPJ1VK8sJQK9D3
   PaNjJvCxftJwRcSKI1hJrrPlakAB9XMUQ8MOME5+NoTWKRNXwtPPUDydp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="391028729"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="391028729"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 13:31:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="784893487"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="784893487"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jan 2024 13:31:29 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 13:31:28 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 13:31:28 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 13:31:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFOrWsrYD/xWQpxDqsTgFwrTrxuxxN9I8/tB4jQklgaZk5DdyehPFkUgYfpJGPxxdpZwbbVGWU8dkiV3GP4ApYIt/0Op61isTkr8/FzntodhXURmHu02BABsj0hFU2MuKSfZsicMbLUmttaxmubfuGf48PSPpd+Z5CQW+9rx+nEVZGYZbkjKPAf8r2XXCUWOCZvVJoqSxDUqFzZiAhG8OYrNfCNvg/b1LBT+EAVOKL4SjPUSCHbXgxA7UVQu9b+cbEDHcNsnyv+vwJDuO7p0Cpz+7UR43TP1IrKn96Sd3jehLJVQ3WV1r5V16xTb4bdW++7GmLsIU+Zv7lIhxHkNPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fH/DTQhCSu1j5AyRedMppy7Qrz78krrDaTrBNqx9Mk8=;
 b=ZVyRIIZKl/js2baMCgd624dJ/Y2vQnbml/2/LuH9/3AHyjAH5Ul5EWjk1BgJnZYhxJ8mfGOKC2XZsHvcAooE2iGNTDPHsqi9qGuVuPJU1q3LFXTgJSI+UsK4p9gYy/lhiKeaxDWwaql4btWpnO4GBa+ax2btVw0gV0MTRAuoLN06QaEZd6f+NNn3091MnmSCgmGVzsCWdygIRQuilMnczJclzxuDefE0PmSX7+sXm4tDzciUisjeNaUjMwnQIH4gRbBKH1pZ8pwHVmgiib3Gd/aYm2Oc1z+dE3UjbykXPvlfYz6QNV5LWqRGH19/LOLlnT7z0YjHIMGXRFfrodnJSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB6836.namprd11.prod.outlook.com (2603:10b6:510:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 21:31:25 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887%5]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 21:31:24 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
Subject: Re: [RFC PATCH] x86/virt/tdx: Disable KEXEC in the presence of TDX
Thread-Topic: [RFC PATCH] x86/virt/tdx: Disable KEXEC in the presence of TDX
Thread-Index: AQHaSifQt9ZVu2pn/UaFVG+BwjuRcLDgFwyA
Date: Thu, 18 Jan 2024 21:31:24 +0000
Message-ID: <e75addd3a8af6ef0243999f933df528e975d5ca3.camel@intel.com>
References: <20240118160118.1899299-1-nik.borisov@suse.com>
In-Reply-To: <20240118160118.1899299-1-nik.borisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB6836:EE_
x-ms-office365-filtering-correlation-id: 3826b920-91b5-4233-5587-08dc186cd2ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8YOpEJMpHSDy887Z0Q8r0idRf+Q1lsn2FTz83HEJe8olLi9tLO7W0Zl2krQb4fefT/IvlueISbU90swazL5ia7bapntBYhLtzQU69sgLPr8oUzRTjsviaBdVpQfS7mSdLAxU7tZEEctdgXLGKwfzaoyLDyavlg8MLK6vwFtuzZ/E/uKfCUAHgqHQBSZFyPn1njB6aBT/YOuUkLCuxmNrIY34zBGDawL48s7XG/SEqTinDhNZWu1WmL52X2VVMGHa84eYpx+hVShyijeXbtRrhmeGwHiKaczMhrZHrJXQX+OUW8h9DQnnOE2ykhu8QhhGC3XLSydp5YuxnU0ocfem+39OVz90TqYYpFKTZ7acMhtuEkdPmOZFZ2DI47t/nQColoZ042SDxlIhXpKLdCYGm7q2hYWgAdwr7pmjUEe5zIjAg/h/zy5cFW+V5hSgslRI65qNKcf7c8VD7FC6cS3T/0PZRqKUxhBTdE4Wlwc/cFvvnoa/gZJ1l16Ups0Bz7TwiHCSun+Oel4X7qLjp0EqMUGGXnRiTQByhCJOK54ZL8Rcw/d4wMawKMexLaU+OBSDLU6f8JbZJoCft26YRgJcEI59RJoEEWD6UrFl95wDsshwZPwX+BrRE6mj0O8qgrTl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6512007)(6506007)(2616005)(26005)(71200400001)(38070700009)(86362001)(36756003)(82960400001)(38100700002)(4326008)(6486002)(2906002)(122000001)(5660300002)(83380400001)(478600001)(316002)(41300700001)(8936002)(91956017)(110136005)(76116006)(66446008)(66556008)(66946007)(64756008)(66476007)(54906003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEErbG54SExSeHJQUVBZMlRPc3N4UHpVMStrdWwxQ0lVeC9DYUtIUkpSSUJU?=
 =?utf-8?B?RzEzd0pvV3RaU1FoRG5SVlZVSzZCejRSNHNSNGxhM2pOeERsdFZENEMzcUpE?=
 =?utf-8?B?KzZyU1dGZFpja3JWTnV1T2t0WDVnZEtDcVFib3BvZk1tNFhqeHRjZTdoMlJ1?=
 =?utf-8?B?OExPSGNNTEhaR3VWOCtGcHVZTnVHZGhtbjJONEJQZ2VYMDVycCt5c1czWnBZ?=
 =?utf-8?B?MVNnZFFoYWFEYjMreGtDd0o0bHprZTZzMnhocnhsVUNUKzNpKzV5RU1BcWpz?=
 =?utf-8?B?aVEzU2JsZzYycytUK0tnTS9nT3pXL01FQVJablFJT3RRbUlEcWZsbGMzVnV3?=
 =?utf-8?B?Rk1kM3lZd3liSWR0MGhHODBGVGdjM1J4YWl3OHVmcmk1YnZaUWU4YWswdmhq?=
 =?utf-8?B?UkNwd1djYzNXRTJYenIyR1B1RTBTUFdnREJ4ZEZiU2hDSStEd2RFSnMvZURj?=
 =?utf-8?B?M0FnU1hLY3Z5K0pJeUt3U2ZUNGJpNDJTWWx2U0haeDdXRFAybnhBM0ZsaURa?=
 =?utf-8?B?K2RiNUtDc1ZWaG5HRG5rT3ZPUE9QajVCRnl2amk1Z3dTYWt2WDRHUmJwSDQ3?=
 =?utf-8?B?a0gvVW5IVXRVcmFmN0NHTUFnUmpYU284Yzk0Q3NpWElKZlVtR3c0aUZoR1A1?=
 =?utf-8?B?ZmVWdVFvMFhXcE1yOHVJdUorRzZ6V3VaYlMvVmV6Uyt4NFJjcUdwWnBXcG1C?=
 =?utf-8?B?aEVvNzBkVzZVZUhuM08zZEZQQkFYMzdUK3JNZkFjR0t0V0tGOVRQQnFvZ1lQ?=
 =?utf-8?B?NWN2OGNoUFNIcGVlcE84QlJKTUdUK0lRcDFDK3FNNlhLWTJZVnJ5ZjJZL2xs?=
 =?utf-8?B?V2x2NzRlOHdHSnpycTBtOCtvUjh3cU85V01UbFpiQS8rOW8vajZQWDNCVktS?=
 =?utf-8?B?dFpsRXZhRWhLK21LZnpCbjBhNTVqRVF3Z0xUam9aZ3ZSVXUvdTJ5VUhOQUFp?=
 =?utf-8?B?U2IvczNKQmM1WHc4Wlc2alBZWlgwVzVwNFNiY0xKTDh6Z3RQd3lrM1NLdTVK?=
 =?utf-8?B?WnllSkgyWkQ3RWFoZ0lNQjY5MmdLQVVYMHhqVk9tZkJPM0haRGJmUFdOWjNO?=
 =?utf-8?B?ZndlUnEwcWNxYW9RcmJlcVUrdFZ6OGNzT3VoRmZTRmJQaDUvSDdzWUhiTExy?=
 =?utf-8?B?a0tVTG5ocUJWc1ZIWjNnOVNTNmdadUhUVGM3ZVZnSytQcjk0dGMySkVodTgz?=
 =?utf-8?B?V3NQMUtndWZJQ0hSa3JRcTR2SUxYN2F1QVJhU1BTYWJVeDlSZmFGdC90VXYy?=
 =?utf-8?B?TWJuYWplL3p4OXg0U05Cc0piUGk1bEQxeVpXd25nWXREQnZRVUJKZmFnSWZY?=
 =?utf-8?B?dzRLdnh3ZmZFUjJaaXdXNG9jSXg1Sjc2bEU1c0hjckxmMTFTUysxM1NMNVBa?=
 =?utf-8?B?dVFWQmQxTGJOc1hzS0NMRXcvM1FkVC9SSE1zUVR1ZnJodCtKV2hsbXU4MU10?=
 =?utf-8?B?LytiM3RQQkdQTm41VmlpaS96eHpBY2ttdGdWcm5xNjZOSG9EdmIwZ2pMbVMz?=
 =?utf-8?B?NDMyQUxwNjZNbUw2WTFvekJBN2g4OEJ4QVlOVHRTM0RkQ2FhV3RtMzBrSVMv?=
 =?utf-8?B?UGtXTlZkNitrby9IOEIyU0pQWnpXdUVGaUdkZlIrMGlHNUU3b3JCVWJCM29P?=
 =?utf-8?B?bU9WNFdaakQvckQvazZOMU1rWHVtTXZuZ1kxRk1ESDdtdGgvWTJpUXU5YU8x?=
 =?utf-8?B?OTJXTXVmS1NBL1BsNlhEdXk5VkpuWUl5TTRZTUFOdHRENjJucm1SUWdIMEdy?=
 =?utf-8?B?SW9NQng4TUR1VG5pVUJJVkR3SVhoZk5pcmtpYWtlWXpISERuY1RRRnBHMFR4?=
 =?utf-8?B?VTRVUWNNMXdGQkpYYkJES2xhdjlvZXh6eHBwSkJvVWh1QXo1VklKY2ZPMHFC?=
 =?utf-8?B?VmVTcHJBUDJEQzd0dmF6SEc3TlJpaWszejg0Q21CbWtVdi9ZVUZsOHJUVFJ6?=
 =?utf-8?B?WHlIUGlhRHBMSkI0ZFBIMkZwY0JLTmlFQ3FCclYwMWhZR0RQeGxVZHVXZGx6?=
 =?utf-8?B?czVtekNGeGJhdnJLczZRT1kzT3pzNVh6SElTWkthbno5Qlk5OUExNlNmaEIr?=
 =?utf-8?B?cmFRY2tKVW8zNHFMK0MrMjJJTlZHN0RteFhjYlVzZE5yVGVwbVdHZjRZMnl0?=
 =?utf-8?B?ZEptS2lrbGF2bGNuRnpOR0x0Rm8wTmp5Z281SjRmU2J0VTFyK1Mzanp2N3lm?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D04380246902CD498529C7BBF8C4D48B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3826b920-91b5-4233-5587-08dc186cd2ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 21:31:24.9440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IwdUxXl435WJli1nGArJoyJld6PAnE5F/gto8r3f7yVS+ehE+NGaq73GSy6NGZXAOS1yLz62Lx7kNXgXsDLXkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6836
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTAxLTE4IGF0IDE4OjAxICswMjAwLCBOaWtvbGF5IEJvcmlzb3Ygd3JvdGU6
DQo+IFREWCBkb2Vzbid0IGN1cnJlbnRseSBzdXBwb3J0IGtleGVjIHNvIGRpc2FibGUgdGhlIGxh
dHRlciB3aGVuIFREWA0KPiBpcyBkZXRlY3RlZCBhdCBib290IHRpbWUuIElmIGtleGVjIG11c3Qg
YWJzb2x1dGVseSBiZSBzdXBwb3J0ZWQgdGhlbg0KPiBURFggY2FuIGJlIGRpc2FibGVkIGZyb20g
dGhlIGJpb3MuDQo+IA0KPiBNYWtpbmcgdGhpcyBkZWNpc2lvbiBhdCBydW4gdGltZSByYXRoZXIg
dGhhbiBhcyBhIGNvbXBpbGUgdGltZSBvcHRpb24NCj4gYWxsb3dzIGRpc3RyaWJ1dGlvbiBrZXJu
ZWxzIHRvIGhhdmUgYm90aCBlbmFibGVkIGFuZCBkZWxlZ2F0ZSB0byB0aGUNCj4gdXNlciB3aGV0
aGVyIHRoZXkgd2FudCB0byB1c2UgVERYL0tleGVjLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTmlr
b2xheSBCb3Jpc292IDxuaWsuYm9yaXNvdkBzdXNlLmNvbT4NCg0KSGkgTmlrb2xheSwNCg0KVGhh
bmtzIGZvciB0aGUgcGF0Y2guDQoNCkkgYW0gd29ya2luZyBpbiBwcm9ncmVzcyBvbiBwYXRjaGVz
IHRvIG1ha2Uga2V4ZWMoKSB3b3JrIHdpdGggVERYLiAgSSBwbGFuIHRvDQpzZW5kIHRoZW0gb3V0
IHNvb24gKGUuZy4sIG5leHQgd2VlayksIGJ1dCBJIHRoaW5rIHBlcmhhcHMgeW91ciBwYXRjaCBp
cw0KcmVhc29uYWJsZSBiZWZvcmUgdGhhdCBpcyBtZXJnZWQuDQoNCkFja2VkLWJ5OiBLYWkgSHVh
bmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQoNCj4gLS0tDQo+IA0KPiBTZW5kaW5nIGFzIFJGQyBh
cyBJIGRvbid0IGtub3cgdGhlIHJlYXNvbiB3aHkgaW5pdGlhbGx5IGl0IHdhcyBkZWNpZGVkIHRv
DQo+IGVuZm9yY2UgdGhlIGluY29tcGFpYmlsaXR5IGJldHdlZW4ga2V4ZWMvdGR4IGF0IGJ1aWxk
IHRpbWUgcmF0aGVyIHRoYW4gcnVudGltZS4NCj4gDQo+ICBhcmNoL3g4Ni9LY29uZmlnICAgICAg
ICAgICAgfCAxIC0NCj4gIGFyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYyB8IDYgKysrKysrDQo+
ICBpbmNsdWRlL2xpbnV4L2tleGVjLmggICAgICAgfCAxICsNCj4gIGtlcm5lbC9rZXhlY19jb3Jl
LmMgICAgICAgICB8IDUgKysrKysNCj4gIDQgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L0tjb25maWcgYi9h
cmNoL3g4Ni9LY29uZmlnDQo+IGluZGV4IDkyYzAzY2I5OWIzZS4uNmMyYjYyMGI0MGQ4IDEwMDY0
NA0KPiAtLS0gYS9hcmNoL3g4Ni9LY29uZmlnDQo+ICsrKyBiL2FyY2gveDg2L0tjb25maWcNCj4g
QEAgLTE5NzMsNyArMTk3Myw2IEBAIGNvbmZpZyBJTlRFTF9URFhfSE9TVA0KPiAgCWRlcGVuZHMg
b24gWDg2X1gyQVBJQw0KPiAgCXNlbGVjdCBBUkNIX0tFRVBfTUVNQkxPQ0sNCj4gIAlkZXBlbmRz
IG9uIENPTlRJR19BTExPQw0KPiAtCWRlcGVuZHMgb24gIUtFWEVDX0NPUkUNCj4gIAlkZXBlbmRz
IG9uIFg4Nl9NQ0UNCj4gIAloZWxwDQo+ICAJICBJbnRlbCBUcnVzdCBEb21haW4gRXh0ZW5zaW9u
cyAoVERYKSBwcm90ZWN0cyBndWVzdCBWTXMgZnJvbSBtYWxpY2lvdXMNCj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYyBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHgu
Yw0KPiBpbmRleCA0ZDY4MjZhNzZmNzguLjI3MDA5MGJkN2I1ZSAxMDA2NDQNCj4gLS0tIGEvYXJj
aC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+ICsrKyBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90
ZHguYw0KPiBAQCAtMjAsNiArMjAsNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L21lbWJsb2NrLmg+
DQo+ICAjaW5jbHVkZSA8bGludXgvbWVtb3J5Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvbWlubWF4
Lmg+DQo+ICsjaW5jbHVkZSA8bGludXgva2V4ZWMuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9zaXpl
cy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3Bmbi5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2FsaWdu
Lmg+DQo+IEBAIC0xNDczLDYgKzE0NzQsMTEgQEAgdm9pZCBfX2luaXQgdGR4X2luaXQodm9pZCkN
Cj4gIAkJcmV0dXJuOw0KPiAgCX0NCj4gDQo+ICsjaWZkZWYgQ09ORklHX0tFWEVDX0NPUkUNCj4g
KwlrZXhlY19kaXNhYmxlKCk7DQo+ICsJcHJfaW5mbygiRGlzYWJsZSBLZXhlYy4gVHVybiBvZmYg
VERYIGluIHRoZSBCSU9TIHRvIHVzZSBLRVhFQy5cbiIpOw0KPiArI2VuZGlmDQo+ICsNCj4gICNp
ZiBkZWZpbmVkKENPTkZJR19BQ1BJKSAmJiBkZWZpbmVkKENPTkZJR19TVVNQRU5EKQ0KPiAgCXBy
X2luZm8oIkRpc2FibGUgQUNQSSBTMy4gVHVybiBvZmYgVERYIGluIHRoZSBCSU9TIHRvIHVzZSBB
Q1BJIFMzLlxuIik7DQo+ICAJYWNwaV9zdXNwZW5kX2xvd2xldmVsID0gTlVMTDsNCj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgva2V4ZWMuaCBiL2luY2x1ZGUvbGludXgva2V4ZWMuaA0KPiBp
bmRleCA4MjI3NDU1MTkyYjcuLmM0MzRjODU2OTI0MiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9s
aW51eC9rZXhlYy5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgva2V4ZWMuaA0KPiBAQCAtNTAwLDYg
KzUwMCw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IGNyYXNoX2hvdHBsdWdfbWVtb3J5X3N1cHBvcnQo
dm9pZCkgeyByZXR1cm4gMDsgfQ0KPiAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgY3Jhc2hf
Z2V0X2VsZmNvcmVoZHJfc2l6ZSh2b2lkKSB7IHJldHVybiAwOyB9DQo+ICAjZW5kaWYNCj4gDQo+
ICtleHRlcm4gdm9pZCBrZXhlY19kaXNhYmxlKHZvaWQpOw0KPiAgI2Vsc2UgLyogIUNPTkZJR19L
RVhFQ19DT1JFICovDQo+ICBzdHJ1Y3QgcHRfcmVnczsNCj4gIHN0cnVjdCB0YXNrX3N0cnVjdDsN
Cj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9rZXhlY19jb3JlLmMgYi9rZXJuZWwva2V4ZWNfY29yZS5j
DQo+IGluZGV4IGJlNTY0MmE0ZWM0OS4uOGQzYTJhMDRmZjRkIDEwMDY0NA0KPiAtLS0gYS9rZXJu
ZWwva2V4ZWNfY29yZS5jDQo+ICsrKyBiL2tlcm5lbC9rZXhlY19jb3JlLmMNCj4gQEAgLTkyNyw2
ICs5MjcsMTEgQEAgc3RydWN0IGtpbWFnZSAqa2V4ZWNfaW1hZ2U7DQo+ICBzdHJ1Y3Qga2ltYWdl
ICprZXhlY19jcmFzaF9pbWFnZTsNCj4gIHN0YXRpYyBpbnQga2V4ZWNfbG9hZF9kaXNhYmxlZDsN
Cj4gDQo+ICt2b2lkIGtleGVjX2Rpc2FibGUodm9pZCkNCj4gK3sNCj4gKwlrZXhlY19sb2FkX2Rp
c2FibGVkID0gMTsNCj4gK30NCj4gKw0KPiAgI2lmZGVmIENPTkZJR19TWVNDVEwNCj4gIHN0YXRp
YyBpbnQga2V4ZWNfbGltaXRfaGFuZGxlcihzdHJ1Y3QgY3RsX3RhYmxlICp0YWJsZSwgaW50IHdy
aXRlLA0KPiAgCQkJICAgICAgIHZvaWQgKmJ1ZmZlciwgc2l6ZV90ICpsZW5wLCBsb2ZmX3QgKnBw
b3MpDQo+IC0tDQo+IDIuMzQuMQ0KPiANCj4gDQoNCg==

