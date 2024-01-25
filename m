Return-Path: <linux-kernel+bounces-37846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1315083B661
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0B31F23FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0AA1877;
	Thu, 25 Jan 2024 01:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQ7sXe0h"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71BD7E1;
	Thu, 25 Jan 2024 01:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706144911; cv=fail; b=HDGx55j1Ma8cm8jP9OA5IlHUrhSSdT01OB5ChieGSctrnvR7K18yI+xoO0KOEnYfCgYc9jOYQnaW083ScYZdMiYq9FDHzDfdu8PoF+cj9Aa7ix8SYuLiYf+CyWyYi5PBmdRFGwpmC5nvunGVvP66LjdF+jVzHaEkG4I4isUR3Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706144911; c=relaxed/simple;
	bh=MRMsbAwiS+5JOMsQelvCi1YTekbLjS3cwlEfzYYKUps=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lBLLqYwFuntGJ9VWruIfcJDoR2MT+Uhqmn8gqhg/snIyUZsMXfaHrmhG3VIJDeYcEr42za/hebuZ6d8H04QtuCSzH0Xv2hyehEIGlw6SlHHLAl6h6wIrjp6jfuneU93yW2KssIWBTYX6uQC0pgc3FxybQzLnAPyIsZJS+QgcExg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQ7sXe0h; arc=fail smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706144909; x=1737680909;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MRMsbAwiS+5JOMsQelvCi1YTekbLjS3cwlEfzYYKUps=;
  b=NQ7sXe0hw8Vi7mz8bCD2/hpNCoazDCUtMYORvpkVDrApzG0QQykaUjgS
   bcwfIgEpgIbueAcxc4jrXn+djc6D5IERFeThlyWjf6DAKf3eTgtIt7Zah
   CH+DcU+jM5CylrxnfBqae1CwhhHegmPjRLhBJQgHjzLYNTi4Ysvz2g4K9
   +cUw/VS+xqgH65h6W280ZwqP7+j4zG7fUr/5Dqbu3Xl4n4gtr+qFpE8nN
   KynXb8q17aP84Vbb/XJxA/iqJc3HcB48Jz7EQvvyOG+u60USGkqaOqiWl
   SC9wI4iKU+eIzHPEyn1O9Kv+33QhBLIua341lbXHwsUvH4w+CAHzyVTnk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400880203"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="400880203"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 17:08:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2168068"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 17:08:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 17:08:27 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 17:08:27 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 17:08:27 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 17:08:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiXuh1gYRTFOFw6/8Yx9HkLmEz/sxOpIqjSBq0rniLMMPXTyiX4PI/wUMv8Q0zQy6BcDKEFfTxkPPQA8gGrWoMEc06534S5WG1mRTOhqFPkxPRnW8Fhgi403/o6Z7jLI7zTVb47GPZf3G2wSIk21MoYfcEFj2R/ZZ2zuie37nWgvUWd2ceqinrq/ZMySgKqPR7SGg3LX1bJMriwkYLw+pzZQ5wavDTa8dXzqu75aKwWGxzKJ+xeIs4TKAX/fxaWtVsCFEox8wL0cogNyOXsM7Wt6Q8yk2xAEnymbXrh6+eSQfix1hPxc6m1LDzagWLV7i6rsSeg16+AY7kIHzkbayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRMsbAwiS+5JOMsQelvCi1YTekbLjS3cwlEfzYYKUps=;
 b=AfunrDnrzpVs+lMTYTYAVqYr2hVQcwue2JXf+OJ4am5canNP6cM5H8RtBimc9LI4dvzKvPP08GuZZ2SwxiGBgbn/J0hdSEcOuHU+Tmk3v7ZhLrJu1+vpUzjd6/nvBn4Xab1/YURG1JUrEoJhlte89/5RzOCT5XRwk7kURZMVjWTQ/T7T+jitaB3FZHk7GqcN6YN8giDhLB/RCIDqtvgs5YxoD7VHD5up+miP4IY8mB7l8yrwChG0E3FCnFdHxzfoE1JKeJmcSUzkO5X4lxL27okuNY/CHM5DVqkQLeY+wS2laxWXnnpKhk5udaa7pQbg2e8Cj39hcT/xieT0rcY6/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5370.namprd11.prod.outlook.com (2603:10b6:408:11b::8)
 by CH3PR11MB8364.namprd11.prod.outlook.com (2603:10b6:610:174::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 01:08:24 +0000
Received: from BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::3d32:2de7:4924:4f2f]) by BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::3d32:2de7:4924:4f2f%5]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 01:08:24 +0000
From: "Chang, Junxiao" <junxiao.chang@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness
	<john.ogness@linutronix.de>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Hao3" <hao3.li@intel.com>, "Li, Lili"
	<lili.li@intel.com>, "Gao, Jianfeng" <jianfeng.gao@intel.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: RE: [PATCH 1/2] printk: nbcon: move locked_port flag to struct
 uart_port
Thread-Topic: [PATCH 1/2] printk: nbcon: move locked_port flag to struct
 uart_port
Thread-Index: AQHaTb7WI2Skm3nhUEimTu1KM9GNnrDouRsAgAAFGACAAPeVkA==
Date: Thu, 25 Jan 2024 01:08:24 +0000
Message-ID: <BN9PR11MB53701E5CF2737908FA9EB532EC7A2@BN9PR11MB5370.namprd11.prod.outlook.com>
References: <BN9PR11MB5370AED9C562F9DA75093557EC742@BN9PR11MB5370.namprd11.prod.outlook.com>
 <20240123054033.183114-1-junxiao.chang@intel.com>
 <20240123054033.183114-2-junxiao.chang@intel.com>
 <87le8f9i75.fsf@jogness.linutronix.de>
 <20240124100524.ZyAPfPU5@linutronix.de>
In-Reply-To: <20240124100524.ZyAPfPU5@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5370:EE_|CH3PR11MB8364:EE_
x-ms-office365-filtering-correlation-id: 244968ca-53d7-4303-d3e7-08dc1d422185
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xyp7uNJGFZ3WWzb2KEUvNTwyLL9L1X6/4/BG/1G7/2JkwhjoO89EvbEu2/kyNi1tj1OaIkkpDLA4G8W7Av5xBsAmAJXKR6VfD2F+ZBNKI6GFsP63rpvEaUhPNq1mmpAnQFHkoF7MxPrtq4HM/kWpCkRfQcI8wydiRNuw8ggiWhCqckZYnKKpk9/32xTw1Xw/esrjC5Yh1ze+Y0sO1oldfX9/NxagasmJN2sxjrjkKxr7etfB2rEbN4G4V4j9XPe1t5iED2ZRTJQ6vTNkJchFdGGfU+xIezunuIGbTdDpmJsRWWi9tQdbUGAlgZY2JzIZsIU5rIprBsZ0RZa4ROkC/aYxL3RKczNVbek5XYEb/PJ/AGejC7KyWrVuflOAdNESfmptubzBvT2ZeY9YTD3mwbozkGM35OjP/Ov+CzFUgQq3TOKxhDDWmPCKbDcp99uK1BJ8tGJYZXfql1tUcNAmwUgg8UY1dyitEyHBIsRwd5s3lOTEkuI9BMKZh0F5PVX0cMNrUmsKKcBdG2sgqe/uy5qHWx9+wSICNOdowIsMsQx+8i+UNlCCj8bcMFO0ftcUHtZ7V0jBT7x4OP7Df/GO81mb3hsRH13O2DvBFNT/Em/Cj2/Zrl/+5gYWqCVshWy3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(55016003)(86362001)(82960400001)(33656002)(38070700009)(38100700002)(122000001)(9686003)(26005)(66556008)(41300700001)(66476007)(7696005)(2906002)(76116006)(110136005)(6506007)(71200400001)(64756008)(316002)(52536014)(66446008)(54906003)(4326008)(478600001)(66946007)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUFoN1lZLzhUaVFZemcvSFFhcHZXWUFJSWQ5Rk5qekRRUW12Q1hJWEsyMTJK?=
 =?utf-8?B?Qmc0WTdJVVVVWUlMU0NMUkdZSnQ4T3hpM09XTXFHaVh0Yk9VTTBLTy9pcThG?=
 =?utf-8?B?cS9TMnNEWElGc05XdWhJMGFrcXVoOWE4ZHcxUGFNdDYyZXU4NzBvU2Fqdi93?=
 =?utf-8?B?eDJVUVdsZWdOOElQUlhORFErOE9nVlhUWjNjL2RYNVNzTnR1c0lEYWlBcUZr?=
 =?utf-8?B?TnQwbUFnTlB1VnRaZTNKNjJsRllxcTNxVDFsYTVxUm8wYkw0L0pUTENjTzFR?=
 =?utf-8?B?bGlKMTQzNjBxSTVkcFQvNXpzemp0a1oyQk9ZOTJIYUhhQm9zVGsyYVpGVXpt?=
 =?utf-8?B?Q2NvUE1nOGlKQWp5K3Y1czg0bzgrUVN6eXJLQndBS0lUbUxoQkFndFM3UXVp?=
 =?utf-8?B?OHZOTzVyd3NUNTN0RThIVU5WWU1UdE02YmtGYmFjRldLaUY3di9LcG91L3FN?=
 =?utf-8?B?cnN0Y1FFWkU5b2pqem03emVHTFR4elBybWdlU1RFR1U1NngzNjRLTTlVREtl?=
 =?utf-8?B?Qy9mZjJQZWpiR2NmUmpLTC9JRmNYb3BlNkk1Nm4zVDl2NitLOHNXbU1IelJT?=
 =?utf-8?B?eFVDTlJkZ1pkeTRXY0IrcWxJREFxWklpRHpBRE1ldTY3RlVZM3BkVldZNmls?=
 =?utf-8?B?aWxIcWJkZUJsbGY1SVY1TXJROEdvbEMxbFhHZjBLcUZmQXBzSUdob0dLUy9X?=
 =?utf-8?B?aGdBMmlqUXZZVTB4K3hKeDRrTUpJRkZuWE5PS0lFUUl4dkkraG5WaDBSNTFz?=
 =?utf-8?B?NE9wMldmbERHRkVWanVrZTFUTHRPNnJIRVVtWXhUd1VVS20xV3hjWFBqckxS?=
 =?utf-8?B?N3RtdUlWL2o2a2FCb0pJWE9Xb3MxUkxPcUprczhoUktUb3hTL3ZYZTAwMDlo?=
 =?utf-8?B?QjFScloxc3l1SjU3aUJoVVBIWkVLTGVvZmdibDRkREZaMVArUWZvMG5iL0xJ?=
 =?utf-8?B?MHlUOVNEeCtoeXFDTXlrNUlURU5xekVaeTh3cm9odVdoNWVQa01nTVVHWkhC?=
 =?utf-8?B?M2dEeFZJUWY4cjNLVndmV0FiSXQ0ZGFJNjFSY0ZzZkVqOHNKT091QXZUNVpL?=
 =?utf-8?B?OG50Q3dyb0xRYTNFSjZGMUF1K1N3REVMNEFDTjZzeHZNWmlOU3BLbkZsZTgv?=
 =?utf-8?B?QWFkM1R5Q3loWUZWb0IydElFNk8vbTRBamowV1lvL2VlTEpVVE4xYllxMFhK?=
 =?utf-8?B?dUE5NklDMExVbExyQkdQa2tKTnZYZTc3dVhJRnVORmozZEhKQjZjTHBxanhD?=
 =?utf-8?B?SWVjZlpOMFIvOTgxeDhCTjcxbkxPbjE0VFVHNEVuL3RHYzBKbDMycDdBTmNX?=
 =?utf-8?B?Q0FVNk5oSmpZZU5EaGx0dFNhQmduSG82SFpIRmtTNmJqYlNlRVhzL1FzaU42?=
 =?utf-8?B?NjNxSkw5MlhrbG1HVzBMcm9iaEVwNnZQRUhXMmlyTHgwWXp5MVNYcjB1S0l2?=
 =?utf-8?B?cVVLeWNuQkdjSTcyUE9BaGYzL3hmbXM2VnMzR1k5K2V1SzNLelNaSFpjdU1R?=
 =?utf-8?B?S2NRL3Nka3ZCZTd4UnZ0OEFyR0h1T1BmUFJvV2xPYngxN1N6cTU5SVVpMldM?=
 =?utf-8?B?YkY0SkRIYWxEUEh2K2Nzd0xJaVFCVkNjU2NZNU1UR0hwU0dZVXU2RklwcFpM?=
 =?utf-8?B?ZnN2MEhJQ2ZrMHJNVU01cTBYMVhjSStZNStqek9KVFFicVJGKzV6dUk1TlE5?=
 =?utf-8?B?V245UHBsaWZiMFMvbHdGY2hDNXpzaVVWdno1Q01EVHhXRUUreStqYjN0QWJm?=
 =?utf-8?B?VnhOMzZEUGVtanVXcDR1YjRGZ0VFZ3E1WWJsN0d2WG5qQmMvMGZsZ3R3NjIy?=
 =?utf-8?B?L1dOWmdJYnhhN2YvUEg4bkhHdlJZYWNMWkNucTFYVzZFR3IyMFV5QlQ3aFU1?=
 =?utf-8?B?WlFuc1VQdllqa0daUi9uLzZzUk10VnZKU2g4dk5KTHRSN1cxMldUeWc3S2ZX?=
 =?utf-8?B?clNTejhQYnhMeDhycGx2L3B5cENMYnl3NUxVUXpVaHNoRWdEdVlwc3U1WWIw?=
 =?utf-8?B?RW5FQVd5Y0xHdWdpWE9yd05TbmtqL3BUbEpxRERRK2YxenhkNUNOVWV5WVpJ?=
 =?utf-8?B?Z0lqWW5iYkVPaW5RRHZ0VTd5WkVYOEl0bzZ4NGZTZ3JlSFhHSEJFSUwyRVh3?=
 =?utf-8?Q?kPQd1ouBl4B3NeUneqhY/6nUM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244968ca-53d7-4303-d3e7-08dc1d422185
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 01:08:24.6734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bfu9YapkJ02CEFDB7To0ieMJmGXm6mcHTRDmVVMJ+Oj6kvrC1okYCtplczuFYxxMhit9eYbdy1Ck/ZJ1kO1EpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8364
X-OriginatorOrg: intel.com

PiA+ID4gQ29uc29sZSBwb2ludGVyIGluIHVhcnRfcG9ydCBtaWdodCBiZSBzaGFyZWQgYW1vbmcg
bXVsdGlwbGUgdWFydCANCj4gPiA+IHBvcnRzLg0KPiA+IA0KPiA+IEkgc3RpbGwgd2FudCB0byBp
bnZlc3RpZ2F0ZSB3aHkgdGhlIHBvaW50ZXIgaXMgc2hhcmVkLiBUaGlzIHNvdW5kcyANCj4gPiBz
bG9wcHkgb3IgZGFuZ2Vyb3VzLg0KDQo+IEkgaGF2ZSB4ODYgYSBzZXJ2ZXIgYm94IGFuZCBQTlAg
ZW51bWVyYXRlcyB0d28gVUFSVHMgKDgyNTApLiBPbmx5IG9uZSBpcyB3aXJlZCB1cCBidXQgYm90
aCBjYW4gYmUgc3BlY2lmaWVkIGFzIGNvbnNvbGU9Lg0KPiBXaGF0IGRvIEkgbmVlZCB0byBkbyB0
byByZXByb2R1Y2UgdGhpcyBoZXJlPyBVc2luZyBjb25zb2xlPSB0d2ljZSBkb2VzIG5vdCBkbyB0
aGUgdHJpY2suDQoNCklzc3VlIGNvdWxkIGJlIHJlcHJvZHVjZWQgd2l0aCBvdXIgaGFyZHdhcmUg
ZXZlcnkgdGltZS4gTXkgY21kbGluZSBpczogQk9PVF9JTUFHRT0oaGQwLGdwdDIpL2Jvb3QvYnpJ
bWFnZS1saW51eC1pbnRlbC1pb3QtbHRzLXJ0LTYuNi1rZXJuZWwgcm9vdD1QQVJUTEFCRUw9cHJp
bWFyeSByb290d2FpdCBjb25zb2xlPXR0eVMwLDExNTIwMCBjb25zb2xlPXR0eTAgaW5pdD0vc2Jp
bi9wcmVpbml0LWVudiBjb25zb2xlPXR0eVM0LDExNTIwMG44IGNvbnNvbGU9dHR5UzUsMTE1MjAw
bjgNCg0KSWYgeW91IHdvdWxkIGxpa2UgdG8gdHJ5IGFueSBkZWJ1ZyBwYXRjaCB3aXRoIG15IEFE
TCBoYXJkd2FyZSwgcGxlYXNlIGZlZWwgZnJlZSB0byBsZXQgbWUga25vdy4NCg0KRm9yIGNvbnNv
bGUgcG9pbnRlciBzaGFyaW5nIGlzc3VlLCBmcm9tIGNvZGUgbG9naWMgcG9pbnQgb2Ygdmlldywg
dGhlIGNhbGwgY2hhaW4gbG9va3MgbGlrZToNCnNlcmlhbDgyNTBfcmVnaXN0ZXJfODI1MF9wb3J0
IC0+IHVhcnRfYWRkX29uZV9wb3J0IC0+IHNlcmlhbF9jdHJsX3JlZ2lzdGVyX3BvcnQgLT4gc2Vy
aWFsX2NvcmVfcmVnaXN0ZXJfcG9ydCAtPiBzZXJpYWxfY29yZV9hZGRfb25lX3BvcnQNCg0KSW4g
QVBJIHNlcmlhbF9jb3JlX2FkZF9vbmVfcG9ydCwgdWFydF9wb3J0J3MgY29uc29sZSBwb2ludGVy
IGlzIGFzc2lnbmVkIHdpdGggZHJpdmVyJ3MgY29uc29sZSBwb2ludGVyOg0KCXVwb3J0LT5jb25z
ID0gZHJ2LT5jb25zOw0KRHJpdmVyJ3MgY29uc29sZSBwb2ludGVyIHBvaW50cyB0byBzdGF0aWMg
c3RydWN0dXJlICJ1bml2ODI1MF9jb25zb2xlIiB3aGljaCBpcyBkZWZpbmVkIGluIDgyNTBfY29y
ZS5jDQoNClRoYXQgaXMsIGFsbCA4MjUwIHNlcmlhbCBkZXZpY2VzJyBjb25zb2xlIHBvaW50ZXIg
YXJlIHNhbWUsIHRoZXkgcG9pbnQgdG8gdW5pdjgyNTBfY29uc29sZS4NCg0KQmVsb3cgaXMgZGVi
dWcgbG9nIG91dHB1dDoNCnNoLTUuMSMgZG1lc2cgfCBncmVwIEBAQEANClsgICAgMS42ODcxMjFd
IEBAQEAgdW5pdjgyNTBfY29uc29sZV9pbml0IHVuaXY4MjUwX2NvbnNvbGUgYWRkcmVzczpmZmZm
ZmZmZjkzNWRmMWUwDQpbICAgIDMuNDE5ODgwXSBAQEBAIHNlcmlhbDgyNTBfcmVnaXN0ZXJfODI1
MF9wb3J0OiBuYW1lOnR0eVM0LCBjb25zIHBvaW50ZXI6ZmZmZmZmZmY5MzVkZjFlMA0KWyAgICAz
LjUzNDk1NF0gQEBAQCBzZXJpYWw4MjUwX3JlZ2lzdGVyXzgyNTBfcG9ydDogbmFtZTp0dHlTNSwg
Y29ucyBwb2ludGVyOmZmZmZmZmZmOTM1ZGYxZTANClsgICAxMS45NzEzNDVdIEBAQEAgc2VyaWFs
ODI1MF9kb19zaHV0ZG93biwgY3VyciB0aHJlYWQ6KGFnZXR0eSksIG5hbWU6dHR5UzAsIGxpbmUg
MCwgY29ucyBwb2ludGVyOmZmZmZmZmZmOTM1ZGYxZTANClsgICAxMS45NzE1MDZdIEBAQEAgc2Vy
aWFsODI1MF9kb19zaHV0ZG93biwgY3VyciB0aHJlYWQ6KGFnZXR0eSksIG5hbWU6dHR5UzQsIGxp
bmUgNCwgY29ucyBwb2ludGVyOmZmZmZmZmZmOTM1ZGYxZTANClsgICAxMS45NzE4NDldIEBAQEAg
c2VyaWFsODI1MF9kb19zaHV0ZG93biwgY3VyciB0aHJlYWQ6KGFnZXR0eSksIG5hbWU6dHR5UzQs
IGxpbmUgNCwgY29ucyBwb2ludGVyOmZmZmZmZmZmOTM1ZGYxZTANClsgICAxMS45ODMwNzJdIEBA
QEAgc2VyaWFsODI1MF9kb19zaHV0ZG93biwgY3VyciB0aHJlYWQ6YWdldHR5LCBuYW1lOnR0eVM0
LCBsaW5lIDQsIGNvbnMgcG9pbnRlcjpmZmZmZmZmZjkzNWRmMWUwDQpbICAgMTEuOTgzNTk1XSBA
QEBAIHNlcmlhbDgyNTBfZG9fc2h1dGRvd24sIGN1cnIgdGhyZWFkOihhZ2V0dHkpLCBuYW1lOnR0
eVM1LCBsaW5lIDUsIGNvbnMgcG9pbnRlcjpmZmZmZmZmZjkzNWRmMWUwDQpbICAgMTEuOTgzODk1
XSBAQEBAIHNlcmlhbDgyNTBfZG9fc2h1dGRvd24sIGN1cnIgdGhyZWFkOihhZ2V0dHkpLCBuYW1l
OnR0eVM1LCBsaW5lIDUsIGNvbnMgcG9pbnRlcjpmZmZmZmZmZjkzNWRmMWUwDQpbICAgMTIuMDA5
NjMyXSBAQEBAIHNlcmlhbDgyNTBfZG9fc2h1dGRvd24sIGN1cnIgdGhyZWFkOmFnZXR0eSwgbmFt
ZTp0dHlTNSwgbGluZSA1LCBjb25zIHBvaW50ZXI6ZmZmZmZmZmY5MzVkZjFlMA0Kc2gtNS4xIw0K
DQpBbGwgY29ucyBwb2ludGVycyBhZGRyZXNzIGFyZSBzYW1lICJmZmZmZmZmZjkzNWRmMWUwIi4N
Cg0KRGVidWcgcGF0Y2g6DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1
MF9jb3JlLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2NvcmUuYw0KaW5kZXggMzA0
MzQ3MThmYWQ4MC4uNzQwZmQ3ZTEzM2EyOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC84MjUwLzgyNTBfY29yZS5jDQorKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2Nv
cmUuYw0KQEAgLTc1NSw2ICs3NTUsNyBAQCBzdGF0aWMgaW50IF9faW5pdCB1bml2ODI1MF9jb25z
b2xlX2luaXQodm9pZCkNCg0KICAgICAgICBzZXJpYWw4MjUwX2lzYV9pbml0X3BvcnRzKCk7DQog
ICAgICAgIHJlZ2lzdGVyX2NvbnNvbGUoJnVuaXY4MjUwX2NvbnNvbGUpOw0KKyAgICAgICBwcmlu
dGsoIkBAQEAgJXMgdW5pdjgyNTBfY29uc29sZSBhZGRyZXNzOiVseFxuIiwgX19mdW5jX18sICh1
bnNpZ25lZCBsb25nKSgmdW5pdjgyNTBfY29uc29sZSkpOw0KICAgICAgICByZXR1cm4gMDsNCiB9
DQogY29uc29sZV9pbml0Y2FsbCh1bml2ODI1MF9jb25zb2xlX2luaXQpOw0KQEAgLTExODEsNiAr
MTE4Miw3IEBAIGludCBzZXJpYWw4MjUwX3JlZ2lzdGVyXzgyNTBfcG9ydChjb25zdCBzdHJ1Y3Qg
dWFydF84MjUwX3BvcnQgKnVwKQ0KICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJldCkNCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnI7DQoNCisgICAgICAgICAgICAg
ICAgICAgICAgIHByaW50aygiQEBAQCAlczogbmFtZTolcywgY29ucyBwb2ludGVyOiVseFxuIiwg
X19mdW5jX18sIHVhcnQtPnBvcnQubmFtZSwgKHVuc2lnbmVkIGxvbmcpdWFydC0+cG9ydC5jb25z
KTsNCiAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IHVhcnQtPnBvcnQubGluZTsNCiAgICAg
ICAgICAgICAgICB9IGVsc2Ugew0KICAgICAgICAgICAgICAgICAgICAgICAgZGV2X2luZm8odWFy
dC0+cG9ydC5kZXYsDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9w
b3J0LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BvcnQuYw0KaW5kZXggNDM3YTdk
M2QzNGNkZS4uOTNmMWU1NDhkMTMwMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC84
MjUwLzgyNTBfcG9ydC5jDQorKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BvcnQu
Yw0KQEAgLTI1MTAsNiArMjUxMCw3IEBAIHZvaWQgc2VyaWFsODI1MF9kb19zaHV0ZG93bihzdHJ1
Y3QgdWFydF9wb3J0ICpwb3J0KQ0KICAgICAgICBzdHJ1Y3QgdWFydF84MjUwX3BvcnQgKnVwID0g
dXBfdG9fdTgyNTBwKHBvcnQpOw0KICAgICAgICB1bnNpZ25lZCBsb25nIGZsYWdzOw0KDQorICAg
ICAgIHByaW50aygiQEBAQCAlcywgY3VyciB0aHJlYWQ6JXMsIG5hbWU6JXMsIGxpbmUgJWQsIGNv
bnMgcG9pbnRlcjolbHhcbiIsIF9fZnVuY19fLCBjdXJyZW50LT5jb21tLCBwb3J0LT5uYW1lLCBw
b3J0LT5saW5lLCAodW5zaWduZWQgbG9uZylwb3J0LT5jb25zKTsNCiAgICAgICAgc2VyaWFsODI1
MF9ycG1fZ2V0KHVwKTsNCiAgICAgICAgLyoNCiAgICAgICAgICogRGlzYWJsZSBpbnRlcnJ1cHRz
IGZyb20gdGhpcyBwb3J0DQoNClRoYW5rcywNCkp1bnhpYW8NCg==

