Return-Path: <linux-kernel+bounces-45480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BFF843145
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32577B22D5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F204B79950;
	Tue, 30 Jan 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="INPu691A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D9D7EEFD;
	Tue, 30 Jan 2024 23:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706657449; cv=fail; b=XIDWhIsPXqYD9iga4wh0xcZVLFis5472R7bkPCMAvcm8N0hSqCjhxISkwYzm7fvaaviK4GM96TUlhPKVOmlCthviZXMGhxA2CBlNnRh1Wp5HxWoVY/Mtm79DHL3RKWGpayeTHpgdY0wsvtq6FX4sADUvHlg+eSGWDUY2/QeteFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706657449; c=relaxed/simple;
	bh=gZSmjnhj1cKidIcN0tr3F52VAZUFTwNtRcBhvHLCFHQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=frc8wuqQFYjrtu8NnPGneFisVXLijti2VxJV9BIoCPKINY22qrokVoTI6CSHqQZL5GaASNDMq0bUvdbchW33uK6bb8G6rWQzBwj36J2JM4S6zkUBhcFrnJbC0bgBP5QMWJHhmQNRMHUi4zJ/S/D0csksvbIbovk2tepMKTXglYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=INPu691A; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706657446; x=1738193446;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=gZSmjnhj1cKidIcN0tr3F52VAZUFTwNtRcBhvHLCFHQ=;
  b=INPu691AIVimGupOrvVcKC6djVzQSs9Makfmoxb925DwchI18usHy8GK
   WQVqOWuc31XaExC5+VQKeHyNwOtdew3G9ZN/DqxfgO59bsBdPnpASV6XS
   l3h/QZu9RR6oZDc3dWX5WUwtW35L2fQL3cfmgjJLjBsqPcBNmHdLf/vWh
   81tiNF691nNQxa7rzIwSyO2w3swkFnGoly9usPhg2nuWXsiSBh0HfuFzq
   WifwaZxRLgXA/hFW/A/7V1aY8mQ8dmeyG0AO4bJWrUt2beRYmVDN2KpcX
   tibA5HIWLINwproUABPo79pl9DqVFAzz5GWetjFfAaA1Rc1mtrArIYY2m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10100742"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="10100742"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 15:30:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="36670166"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 15:30:44 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 15:30:42 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 15:30:42 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 15:30:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KN8dX0x+fYjv5+GtUYcddUgRJl6k9eOADA12FIl7QuSXBz5g+wjvuwL8lYkOGykZtJ2qO8/vDSSJ+Buhq6HEpwrd5za/C2BrR/MorlWJXX94ZEHVeMS5+xeC0lr6DQse26cNT0ulDkfjSI9v75T1CLIaI5fzYvu3TqyVEiDE10pi8SlR2Nr2pMY+VekN7fDjGRJoRQQnVxFYdYgMRahJwMLzUuN5VtsxMq1wMbW4mbFovX1evNqGzQ6cfltqb5sxdcaO1Ng0NMyRQmK7q3wYUWw+46WK3/TgY7H1nCWoM7F7rls/RZPietdsBFqBmEA0WLJwHmPvkndo+MHQ6LdgCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYJpYq7rYgy2OSQn16cPR/u196rYFqEAOOjUvnXmCvI=;
 b=iqUUuCNkcG1O0gJjQpQpw6wbZasBP47kJr5LK+Mi+8mde3F4ZsJwyzE9vC1pktMhKryLs9g4Dc9rOmL6NKg/tyMCXyVpQIuXe6FM+DNmqCqZ0x4di2wYxTCKkZxg5Xt1A15C3v1AG579t6DpiabyexeMH+X13/WjGYujncWUOOX5ekR2z1UhZSuzl6bJjljf77pCkNPGZWl2ljIWf3CSVSZ5LrHvRmhjS/qHpm6PoAYX3UPVzFOeXuwRb9env/ZFKo9vuEh4t7GQYudmzxn5VCUyQOHkCpJt0wAcxqWu8ujuHkH3Zc8P17JUy7xmK9juOCcW50wv4SzrMdzDGWAY3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV8PR11MB8463.namprd11.prod.outlook.com (2603:10b6:408:1ed::6)
 by DM6PR11MB4689.namprd11.prod.outlook.com (2603:10b6:5:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 30 Jan
 2024 23:30:31 +0000
Received: from LV8PR11MB8463.namprd11.prod.outlook.com
 ([fe80::5262:6eb1:2787:8cb9]) by LV8PR11MB8463.namprd11.prod.outlook.com
 ([fe80::5262:6eb1:2787:8cb9%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 23:30:31 +0000
From: "Corona, Ernesto" <ernesto.corona@intel.com>
To: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
CC: "Corona, Ernesto" <ernesto.corona@intel.com>, "'oleksandrs@mellanox.com'"
	<oleksandrs@mellanox.com>, "'jiri@nvidia.com'" <jiri@nvidia.com>, "Castro,
 Omar Eduardo" <omar.eduardo.castro@intel.com>,
	"'omar.eduardo.castro@linux.intel.com'"
	<omar.eduardo.castro@linux.intel.com>, "'arnd@arndb.de'" <arnd@arndb.de>,
	"'pombredanne@nexb.com'" <pombredanne@nexb.com>, "'joel@jms.id.au'"
	<joel@jms.id.au>, "'joel@jms.id.au'" <joel@jms.id.au>, "'andrew@aj.id.au'"
	<andrew@aj.id.au>, "'p.zabel@pengutronix.de'" <p.zabel@pengutronix.de>,
	"Filary, Steven A" <steven.a.filary@intel.com>, "'vadimp@mellanox.com'"
	<vadimp@mellanox.com>, "'amithash@fb.com'" <amithash@fb.com>,
	"'patrickw3@fb.com'" <patrickw3@fb.com>, "Chen, Luke"
	<luke_chen@aspeedtech.com>, "'billy_tsai@aspeedtech.com'"
	<billy_tsai@aspeedtech.com>, "'rgrs@protonmail.com'" <rgrs@protonmail.com>
Subject: [PATCH 30 3/7] Add Aspeed SOC 24xx, 25xx and 26xx JTAG support
Thread-Topic: [PATCH 30 3/7] Add Aspeed SOC 24xx, 25xx and 26xx JTAG support
Thread-Index: AdpTxJb+u3okvsebTzmSUh9xTAF4Cw==
Date: Tue, 30 Jan 2024 23:30:31 +0000
Message-ID: <LV8PR11MB846379E82775EFA1C9062D1C8B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8463:EE_|DM6PR11MB4689:EE_
x-ms-office365-filtering-correlation-id: 6ae39b73-2c1b-435d-3fdb-08dc21eb731e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GOyk2OMGqRZhK4mz0Fcm+dwfMN1MOPtUvaQ9vNs+NOcIcvJjpyHgcKY/72eoVHqY6cPaPbvBti8n3cJ9HO5H8o/bmEnZifDa94k+9HO0ggbaVbrcPwK/uoA4mUyTAcHv4/llKwgNaOjn/dfGLWIXueYv5TNXKbcdbWtFnsFxrIFTCJzI+444zVDe9Vb6TrI9bZu3zt31wzy2zbUqvh5DOnhA6Wqsr6jSsLHVYSJFEu0vBh+dp5hYjgGf9lNPEEzZqO/CbE7m8QlS0CX6EoPst7eT0O++Bj3eqm9o15vDIovO65kypRxJ8+zsd45cC3VOA3V0M/cvOPVBM2GM1DwBhSiaXiYWrWC3njk0DBpArho4mB3RM1sPj7apsui/vsdWbaySlluTSgSGVVNr+i77OFFHInzQtynv9tZGc9+06ZoYfZ6tvV5wckpUd9D2cJ7Z7jEKR1ksIq+1cCBKnkRa06qyLKF3qRgt4yQb8fnEGnw8O6GyjkLjDGsoKxXyrESXRBiQOpLGV6UFRHnSpu8zU/af9SNK+xe1kevlBtUn9xH1bDxrd8kkiZzt2Q7Jr8Fyi1+v1vNvkJtneW5JW9BfK1VO8hTUQA5qkXB5pw9dElWGjUBH5z2Zijlm22InwBWn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8463.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(9686003)(38100700002)(26005)(30864003)(122000001)(8676002)(52536014)(8936002)(4326008)(7416002)(478600001)(76116006)(7696005)(64756008)(54906003)(6506007)(2906002)(5660300002)(66556008)(66476007)(71200400001)(66946007)(66446008)(110136005)(41300700001)(316002)(38070700009)(82960400001)(86362001)(33656002)(55016003)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rCz/0E8eQxSG0tRWDEC4Pr4Tz1yDsDlfC1kw9fGcbMMrTqUK7llw8w6ssCbX?=
 =?us-ascii?Q?pWHdv1+XhPa77hDQrmsBEVV9RXJCWZRsy488V7JgVc6q8YKjAqqVeCIhlTdx?=
 =?us-ascii?Q?YxUuB4gv4TVaZA7A0Rn279GgHtMLqoUxo7dWcqxrHP1kBvIIofG258tm7tMr?=
 =?us-ascii?Q?5GFiWv5ECBHKGNaJeFcLPaCUvTNadoUx5nsAK/Dzgz9WvQpLHrYpIyAIQR2u?=
 =?us-ascii?Q?KJNW/ZLlFMPmeoiFrrkHAq7io6laslE8dchB1ARGT+3r0+Y6pgQi9/OvOa1E?=
 =?us-ascii?Q?rmYo6rwLWjKQL4hYCy/9IuOrLdO8DxJvlPtxNLQ4v0XKhFjb6b/mNQZErWCc?=
 =?us-ascii?Q?k99mVkZ4sSQ0Yj20XBVY/geUyzjDS7fqsiPIjC/pxeXjgP3MdjmLLnyV0tJd?=
 =?us-ascii?Q?ORIIMkaNVaXLdvE1HMQ63CA7M/z1LwU7kMQjdoeIveALdCZ14OvvHHrvzmhV?=
 =?us-ascii?Q?baNt5UHMtjx9S2e0a6qmDtaNv8dhcG8oqNQHI8Hk7dan4VypKDegK01yt2Vm?=
 =?us-ascii?Q?lc9Uf1Xy/Wp/+FLAzke+kE2WK7LguJSXOUN2cNUKux6EK3QhGF/Tv7bx36Y4?=
 =?us-ascii?Q?bwg7aQr9ebZzCFbRI+mmQnh6zkODNJ4WwPfOiZkiIhv3PQZBEOjydT1iDMig?=
 =?us-ascii?Q?40F8Crz4O+Oy0bX+XwUN/h1iUFeqyBZoge9lMkJVv4Z0b1JO1Xl3gWG88MtR?=
 =?us-ascii?Q?30fqNa/oepGAbEqvP0MwWJMJv5RJchxrYaj60IUmt6YGtQsUgr3mkOJlwYdQ?=
 =?us-ascii?Q?Lh/7KH/EdsAA6du7Ynkua/jogsPm1GXoMPTXw7xI73O/ajl6CeKVeCVdn+UZ?=
 =?us-ascii?Q?p5P4YHW8lDtsSpeQfljPKxNgb4Y+7bt3VTnwpeUOHMqFPI9tA3h3XzzXAQU8?=
 =?us-ascii?Q?mq37OB2ORc8cCMcWHEc4wCaj0TE0jVb30hvgeYc2auJxkCcQBKmqF3WcdZTU?=
 =?us-ascii?Q?74cnqKmKW0COfSPyOVu+VCrc90h/CjHPYuc2xBAynV9c3/o/HjiILw4Oehyg?=
 =?us-ascii?Q?9wjxrjBwownUffaAsEmvrNsyXSu0G91TF4vdM8LBvZGfkJI9YMIdK58m+lBC?=
 =?us-ascii?Q?4CJX1Hyrt5ZVRq8QPztrZu/bSTJWwRDH6JJ9zqUom+yCjPEEDbb4DFm7ZujP?=
 =?us-ascii?Q?rUdW5/yW9trdu9qtg/pDbVyjj8zqgnTxVzgxaWGkr6ji+Oq7XwZ3Ke4ZNAaW?=
 =?us-ascii?Q?mPwwMxLbgvGuW4836A7VlDa0Gsru7ZY90Ud/TZ8pT2QZABbSCsMIsoDtr1ez?=
 =?us-ascii?Q?Vt19oRoS53gifXH4dK5RmoJZ46EfFWQXAaKwrSZY3p7F4W4hnHHp61aKNr6k?=
 =?us-ascii?Q?BY4OLm0aiSt6YcEBM1jSxwKf1iDU0+MTzFxaWIRIRjGsFXmNGWAXw1kSyz8z?=
 =?us-ascii?Q?BNWgSkDzcGQxybEx8nGtnfIDNgvqzoD7fX5gn1IGW6v7yzgHZVsXlByTkiVY?=
 =?us-ascii?Q?DV2x1haZtXaCytUUrQIh97aZ4GAFAPZAn3yNsmjRmAXV3uY2T5dViLeffijN?=
 =?us-ascii?Q?TScgnf44jFiwTIywJ/fMewGBpqrq96KZS83iODbiQaaYcYMaIpBcjQr/NhNv?=
 =?us-ascii?Q?didXY7Uy7xJgefG2LZeP65YEIHQJpPhcNcg0xxsQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8463.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae39b73-2c1b-435d-3fdb-08dc21eb731e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 23:30:31.2037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2B0XqnAa+JoDjYxwN97FNJhhq5F8VuTonx5bYDp64RnQMBOQJgicrCYvAV/OkVHPcGJKyUFQQyCnfLDbTOHjQdxh5ThwM5O0R8+YDUOeRKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4689
X-OriginatorOrg: intel.com

Driver adds support of Aspeed 2400-2600 series SOC JTAG controller.

Driver implements the following jtag ops:
- freq_get;
- freq_set;
- status_get;
- status_set
- xfer;
- mode_set;
- bitbang;
- enable;
- disable;

It has been tested on Mellanox system with BMC equipped with
Aspeed 2520 SoC for programming CPLD devices.

It has also been tested on Intel system using Aspeed 25xx SoC
for JTAG communication.

Tested on Intel system using Aspeed 26xx SoC for JTAG communication.

Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Ernesto Corona <ernesto.corona@intel.com>
Signed-off-by: Omar Castro <omar.eduardo.castro@linux.intel.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
Acked-by: Joel Stanley <joel@jms.id.au>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Steven Filary <steven.a.filary@intel.com>
Cc: Vadim Pasternak <vadimp@mellanox.com>
Cc: Amithash Prasad <amithash@fb.com>
Cc: Patrick Williams <patrickw3@fb.com>
Cc: Luke Chen <luke_chen@aspeedtech.com>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Rgrs <rgrs@protonmail.com>
---
v29->v30
Comments pointed by Steven Filary <steven.a.filary@intel.com>
- Add Suport for 26xx series
  Software mode
  Hardware mode 1 (disabled by default)
  Hardware mode 2 (enabled by default) up to 512 bit lenght transfers
- clang jtag-aspeed.c
- Add pre and post padding support for JTAG transfers.
- For 26xx series add TRST_N pin transition from low to high during TLR
  jtag state transition in HW and SW modes.
Comments pointed by Moritz Fischer
- Moved tms_cycle_loopup to jtag.hardware
Comments pointed by Paul Fertser
- Removed scu_base from aspeed_jtag structure.
- Fixed Frequency calculation based on Aspeed 2600,2500 specs.
- Removed tck as it is ignored.

v28->v29
Comments pointed by Steven Filary <steven.a.filary@intel.com>
- Expand bitbang function to accept multiples bitbang operations within
  a single JTAG_IOCBITBANG call. It will receive a buffer with TDI and
  TMS values and it is expected that driver fills TDO fields with its
  corresponding output value for every transaction.
- Always setup JTAG controller to host mode but disable JTAG output
  when the driver is not in use to allow other HW to own the JTAG bus.
  Remove SCU register accesses. This register controls the JTAG controller
  mode (host controller/target).
- Encansulate dev_dgb message into DEBUG_JTAG macros to improve driver's
  JTAG performace.
- Add support for multichain. Set tap state and xfer operations now
  include two tap state arguments: current state and end state.

v27->v28
Comments pointed by Steven Filary <steven.a.filary@intel.com>
- Replace JTAG_IOCRUNTEST with JTAG_SIOCSTATE adding support for all
  TAPC end states in SW mode using a lookup table to navigate across
  states.
- Add support for simultaneous READ/WRITE transfers
  (JTAG_READ_WRITE_XFER).
- Support for switching JTAG controller mode between target and
  controller mode.
- Setup JTAG controller mode to host only when the driver is opened,
  letting other HW to own the JTAG bus when it isn't in use.
- Include JTAG bit bang IOCTL for low level JTAG control usage
  (JTAG_IOCBITBANG).
- Add debug traces.
- Add support for register polling (default) due it is 3 times faster
  than interrupt mode. Define USE_INTERRUPTS macro to enable interrupt
  usage.
- Remove unnecessary delays for aspeed_jtag_status_set function. It
  makes SW mode 4 times faster.
- Clean data buffer on aspeed_jtag_xfer_sw before tdo writes to avoid
  data output corruption for read operations in SW mode.
- Correct register settings for HW mode transfer operations.
- Propagate ret codes all the way from low level functions up to
  JTAG_IOCXFER call.
- Support for partitioned transfers. Single JTAG transfer through
  multiples JTAG_IOCXFER calls. Now end transmission(scan_end) also
  evaluates transfer end state.

v26->v27
Changes made by Oleksandr Shamray <oleksandrs@mellamnox.com>
- change aspeed_jtag_sw_delay to udelay function in bit-bang operation

v25->v26
v24->v25
Comments pointed by Greg KH <gregkh@linuxfoundation.org>
- reduced debug printouts

v23->v24
v22->v23
v21->v22
Comments pointed by Andy Shevchenko <andy.shevchenko@gmail.com>
- rearrange ASPEED register defines
- simplified JTAG divider calculation formula
- change delay function in bit-bang operation
- add helper functions for TAP states switching
- remove unnecessary comments
- remove redundant debug messages
- make dines for repetative register bit sets
- fixed indentation
- change checks from negative to positive
- add error check for clk_prepare_enable
- rework driver alloc/register to devm_ variant
- Increasing line length up to 85 in order to improve readability

v20->v21
v19->v20
Notifications from kbuild test robot <lkp@intel.com>
- add static declaration to 'aspeed_jtag_init' and
  'aspeed_jtag_deinit' functions

v18->v19
v17->v18
v16->v17
v15->v16
Comments pointed by Joel Stanley <joel.stan@gmail.com>
- Add reset_control on Jtag init/deinit

v14->v15
Comments pointed by Joel Stanley <joel.stan@gmail.com>
- Add ARCH_ASPEED || COMPILE_TEST to Kconfig
- remove unused offset variable
- remove "aspeed_jtag" from dev_err and dev_dbg messages
- change clk_prepare_enable initialisation order

v13->v14
Comments pointed by Philippe Ombredanne <pombredanne@nexb.com>
- Change style of head block comment from /**/ to //

v12->v13
Comments pointed by Philippe Ombredanne <pombredanne@nexb.com>
- Change jtag-aspeed.c licence type to
  SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
  and reorder line with license- add reset descriptions in bndings file
 in description
Comments pointed by Kun Yi <kunyi@google.com>
- Changed capability check for aspeed,ast2400-jtag/ast200-jtag

v11->v12
Comments pointed by Chip Bilbrey <chip@bilbrey.org>
- Remove access mode from xfer and idle transactions
- Add new ioctl JTAG_SIOCMODE for set hw mode

v10->v11
v9->v10
V8->v9
Comments pointed by Arnd Bergmann <arnd@arndb.de>
- add *data parameter to xfer function prototype

v7->v8
Comments pointed by Joel Stanley <joel.stan@gmail.com>
- aspeed_jtag_init replace goto to return;
- change input variables type from __u32 to u32
  in functios freq_get, freq_set, status_get
- change sm_ variables type from char to u8
- in jatg_init add disable clocks on error case
- remove release_mem_region on error case
- remove devm_free_irq on jtag_deinit
- Fix misspelling Disabe/Disable
- Change compatible string to ast2400 and ast2000

v6->v7
Notifications from kbuild test robot <lkp@intel.com>
- Add include <linux/types.h> to jtag-asapeed.c

v5->v6
v4->v5
Comments pointed by Arnd Bergmann <arnd@arndb.de>
- Added HAS_IOMEM dependence in Kconfig to avoid
  "undefined reference to `devm_ioremap_resource'" error,
  because in some arch this not supported

v3->v4
Comments pointed by Arnd Bergmann <arnd@arndb.de>
- change transaction pointer tdio type  to __u64
- change internal status type from enum to __u32

v2->v3

v1->v2
Comments pointed by Greg KH <gregkh@linuxfoundation.org>
- change license type from GPLv2/BSD to GPLv2

Comments pointed by Neil Armstrong <narmstrong@baylibre.com>
- Add clk_prepare_enable/clk_disable_unprepare in clock init/deinit
- Change .compatible to soc-specific compatible names
  aspeed,aspeed4000-jtag/aspeed5000-jtag
- Added dt-bindings

Comments pointed by Arnd Bergmann <arnd@arndb.de>
- Reorder functions and removed the forward declarations
- Add static const qualifier to state machine states transitions
- Change .compatible to soc-specific compatible names
  aspeed,aspeed4000-jtag/aspeed5000-jtag
- Add dt-bindings

Comments pointed by Randy Dunlap <rdunlap@infradead.org>
- Change module name jtag-aspeed in description in Kconfig

Comments pointed by kbuild test robot <lkp@intel.com>
- Remove invalid include <asm/mach-types.h>
- add resource_size instead of calculation
---
 drivers/jtag/Kconfig       |   29 +
 drivers/jtag/Makefile      |    1 +
 drivers/jtag/jtag-aspeed.c | 1666 ++++++++++++++++++++++++++++++++++++
 3 files changed, 1696 insertions(+)
 create mode 100644 drivers/jtag/jtag-aspeed.c

diff --git a/drivers/jtag/Kconfig b/drivers/jtag/Kconfig
index 47771fcd3c5b..d66b60448da0 100644
--- a/drivers/jtag/Kconfig
+++ b/drivers/jtag/Kconfig
@@ -15,3 +15,32 @@ menuconfig JTAG
=20
 	  To compile this driver as a module, choose M here: the module will
 	  be called jtag.
+
+menuconfig JTAG_ASPEED
+	tristate "Aspeed SoC JTAG controller support"
+	depends on JTAG && HAS_IOMEM
+	depends on ARCH_ASPEED || COMPILE_TEST
+	help
+	  This provides support for Aspeed JTAG devices equipped on Aspeed
+	  SoC 24xx, 25xx and 26xx families. Driver allows programming of
+	  hardware devices, connected to SoC through the JTAG interface.
+
+	  If you want this support, you should say Y here.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called jtag-aspeed.
+
+config USE_INTERRUPTS
+	bool "Use interrupts as event wait mechanism"
+	depends on JTAG_ASPEED
+	default n
+	help
+	  Aspeed SoC 24xx, 25xx and 26xx driver monitors the JTAG shift
+	  operation completion by either polling or waiting for an interrupt.
+
+	  This flag is used by Aspeed driver to select from either interrupt or
+	  polling as wait mechanism for JTAG controller completion events.
+
+	  If you want interrupt support, you should say Y here.
+
+	  If you want polling support, you should say N here.
diff --git a/drivers/jtag/Makefile b/drivers/jtag/Makefile
index af374939a9e6..04a855e2df28 100644
--- a/drivers/jtag/Makefile
+++ b/drivers/jtag/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_JTAG)		+=3D jtag.o
+obj-$(CONFIG_JTAG_ASPEED)	+=3D jtag-aspeed.o
diff --git a/drivers/jtag/jtag-aspeed.c b/drivers/jtag/jtag-aspeed.c
new file mode 100644
index 000000000000..f2e8c20beab4
--- /dev/null
+++ b/drivers/jtag/jtag-aspeed.c
@@ -0,0 +1,1666 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Mellanox Technologies. All rights reserved.
+// Copyright (c) 2018 Oleksandr Shamray <oleksandrs@mellanox.com>
+// Copyright (c) 2019 Intel Corporation
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/jtag.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <uapi/linux/jtag.h>
+
+#define ASPEED_JTAG_DATA		0x00
+#define ASPEED_JTAG_INST		0x04
+#define ASPEED_JTAG_CTRL		0x08
+#define ASPEED_JTAG_ISR		0x0C
+#define ASPEED_JTAG_SW			0x10
+#define ASPEED_JTAG_TCK		0x14
+#define ASPEED_JTAG_EC			0x18
+
+#define ASPEED_JTAG_DATA_MSB			0x01
+#define ASPEED_JTAG_DATA_CHUNK_SIZE		0x20
+#define ASPEED_JTAG_HW2_DATA_CHUNK_SIZE	512
+
+/* ASPEED_JTAG_CTRL: Engine Control 24xx and 25xx series*/
+#define ASPEED_JTAG_CTL_ENG_EN		BIT(31)
+#define ASPEED_JTAG_CTL_ENG_OUT_EN	BIT(30)
+#define ASPEED_JTAG_CTL_FORCE_TMS	BIT(29)
+#define ASPEED_JTAG_CTL_IR_UPDATE	BIT(26)
+#define ASPEED_JTAG_CTL_INST_LEN(x)	((x) << 20)
+#define ASPEED_JTAG_CTL_LASPEED_INST	BIT(17)
+#define ASPEED_JTAG_CTL_INST_EN	BIT(16)
+#define ASPEED_JTAG_CTL_DR_UPDATE	BIT(10)
+#define ASPEED_JTAG_CTL_DATA_LEN(x)	((x) << 4)
+#define ASPEED_JTAG_CTL_LASPEED_DATA	BIT(1)
+#define ASPEED_JTAG_CTL_DATA_EN	BIT(0)
+
+/* ASPEED_JTAG_CTRL: Engine Control 26xx series*/
+#define ASPEED_JTAG_CTL_26XX_RESET_FIFO	BIT(21)
+#define ASPEED_JTAG_CTL_26XX_FIFO_MODE_CTRL	BIT(20)
+#define ASPEED_JTAG_CTL_26XX_TRANS_LEN(x)	((x) << 8)
+#define ASPEED_JTAG_CTL_26XX_TRANS_MASK	GENMASK(17, 8)
+#define ASPEED_JTAG_CTL_26XX_MSB_FIRST		BIT(6)
+#define ASPEED_JTAG_CTL_26XX_TERM_TRANS	BIT(5)
+#define ASPEED_JTAG_CTL_26XX_LASPEED_TRANS	BIT(4)
+#define ASPEED_JTAG_CTL_26XX_INST_EN		BIT(1)
+
+/* ASPEED_JTAG_ISR : Interrupt status and enable */
+#define ASPEED_JTAG_ISR_INST_PAUSE		BIT(19)
+#define ASPEED_JTAG_ISR_INST_COMPLETE		BIT(18)
+#define ASPEED_JTAG_ISR_DATA_PAUSE		BIT(17)
+#define ASPEED_JTAG_ISR_DATA_COMPLETE		BIT(16)
+#define ASPEED_JTAG_ISR_INST_PAUSE_EN		BIT(3)
+#define ASPEED_JTAG_ISR_INST_COMPLETE_EN	BIT(2)
+#define ASPEED_JTAG_ISR_DATA_PAUSE_EN		BIT(1)
+#define ASPEED_JTAG_ISR_DATA_COMPLETE_EN	BIT(0)
+#define ASPEED_JTAG_ISR_INT_EN_MASK		GENMASK(3, 0)
+#define ASPEED_JTAG_ISR_INT_MASK		GENMASK(19, 16)
+
+/* ASPEED_JTAG_SW : Software Mode and Status */
+#define ASPEED_JTAG_SW_MODE_EN			BIT(19)
+#define ASPEED_JTAG_SW_MODE_TCK		BIT(18)
+#define ASPEED_JTAG_SW_MODE_TMS		BIT(17)
+#define ASPEED_JTAG_SW_MODE_TDIO		BIT(16)
+
+/* ASPEED_JTAG_TCK : TCK Control */
+#define ASPEED_JTAG_TCK_DIVISOR_MASK	GENMASK(10, 0)
+#define ASPEED_JTAG_TCK_GET_DIV(x)	((x) & ASPEED_JTAG_TCK_DIVISOR_MASK)
+
+/* ASPEED_JTAG_EC : Controller set for go to IDLE */
+#define ASPEED_JTAG_EC_TRST		BIT(31)
+#define ASPEED_JTAG_EC_GO_IDLE		BIT(0)
+
+#define ASPEED_JTAG_IOUT_LEN(len) \
+	(ASPEED_JTAG_CTL_ENG_EN | \
+	 ASPEED_JTAG_CTL_ENG_OUT_EN | \
+	 ASPEED_JTAG_CTL_INST_LEN(len))
+
+#define ASPEED_JTAG_DOUT_LEN(len) \
+	(ASPEED_JTAG_CTL_ENG_EN | \
+	 ASPEED_JTAG_CTL_ENG_OUT_EN | \
+	 ASPEED_JTAG_CTL_DATA_LEN(len))
+
+#define ASPEED_JTAG_TRANS_LEN(len) \
+	(ASPEED_JTAG_CTL_ENG_EN | \
+	 ASPEED_JTAG_CTL_ENG_OUT_EN | \
+	 ASPEED_JTAG_CTL_26XX_TRANS_LEN(len))
+
+#define ASPEED_JTAG_SW_TDIO (ASPEED_JTAG_SW_MODE_EN | ASPEED_JTAG_SW_MODE_=
TDIO)
+
+#define ASPEED_JTAG_GET_TDI(direction, byte) \
+	(((direction) & JTAG_WRITE_XFER) ? byte : UINT_MAX)
+
+#define ASPEED_JTAG_TCK_WAIT		10
+#define ASPEED_JTAG_RESET_CNTR		10
+#define WAIT_ITERATIONS		300
+
+/* Use this macro to switch between HW mode 1(comment out) and 2(defined) =
 */
+#define ASPEED_JTAG_HW_MODE_2_ENABLE	1
+
+/* ASPEED JTAG HW MODE 2 (Only supported in AST26xx series) */
+#define ASPEED_JTAG_SHDATA		0x20
+#define ASPEED_JTAG_SHINST		0x24
+#define ASPEED_JTAG_PADCTRL0		0x28
+#define ASPEED_JTAG_PADCTRL1		0x2C
+#define ASPEED_JTAG_SHCTRL		0x30
+#define ASPEED_JTAG_GBLCTRL		0x34
+#define ASPEED_JTAG_INTCTRL		0x38
+#define ASPEED_JTAG_STAT		0x3C
+
+/* ASPEED_JTAG_PADCTRLx : Padding control 0 and 1 */
+#define ASPEED_JTAG_PADCTRL_PAD_DATA	BIT(24)
+#define ASPEED_JTAG_PADCTRL_POSTPAD(x)	(((x) & GENMASK(8, 0)) << 12)
+#define ASPEED_JTAG_PADCTRL_PREPAD(x)	(((x) & GENMASK(8, 0)) << 0)
+
+/* ASPEED_JTAG_SHCTRL: Shift Control */
+#define ASPEED_JTAG_SHCTRL_FRUN_TCK_EN	BIT(31)
+#define ASPEED_JTAG_SHCTRL_STSHIFT_EN	BIT(30)
+#define ASPEED_JTAG_SHCTRL_TMS(x)	(((x) & GENMASK(13, 0)) << 16)
+#define ASPEED_JTAG_SHCTRL_POST_TMS(x)	(((x) & GENMASK(2, 0)) << 13)
+#define ASPEED_JTAG_SHCTRL_PRE_TMS(x)	(((x) & GENMASK(2, 0)) << 10)
+#define ASPEED_JTAG_SHCTRL_PAD_SEL0	(0)
+#define ASPEED_JTAG_SHCTRL_PAD_SEL1	BIT(9)
+#define ASPEED_JTAG_SHCTRL_END_SHIFT	BIT(8)
+#define ASPEED_JTAG_SHCTRL_START_SHIFT	BIT(7)
+#define ASPEED_JTAG_SHCTRL_LWRDT_SHIFT(x) ((x) & GENMASK(6, 0))
+
+#define ASPEED_JTAG_END_SHIFT_DISABLED	0
+
+/* ASPEED_JTAG_GBLCTRL : Global Control */
+#define ASPEED_JTAG_GBLCTRL_ENG_MODE_EN	BIT(31)
+#define ASPEED_JTAG_GBLCTRL_ENG_OUT_EN	BIT(30)
+#define ASPEED_JTAG_GBLCTRL_FORCE_TMS	BIT(29)
+#define ASPEED_JTAG_GBLCTRL_SHIFT_COMPLETE  BIT(28)
+#define ASPEED_JTAG_GBLCTRL_RESET_FIFO	BIT(25)
+#define ASPEED_JTAG_GBLCTRL_FIFO_CTRL_MODE	BIT(24)
+#define ASPEED_JTAG_GBLCTRL_UPDT_SHIFT(x)	(((x) & GENMASK(9, 7)) << 13)
+#define ASPEED_JTAG_GBLCTRL_STSHIFT(x)	(((x) & GENMASK(0, 0)) << 16)
+#define ASPEED_JTAG_GBLCTRL_TRST	BIT(15)
+#define ASPEED_JTAG_CLK_DIVISOR_MASK	GENMASK(11, 0)
+#define ASPEED_JTAG_CLK_GET_DIV(x)	((x) & ASPEED_JTAG_CLK_DIVISOR_MASK)
+
+/* ASPEED_JTAG_INTCTRL: Interrupt Control */
+#define ASPEED_JTAG_INTCTRL_SHCPL_IRQ_EN BIT(16)
+#define ASPEED_JTAG_INTCTRL_SHCPL_IRQ_STAT BIT(0)
+
+/* ASPEED_JTAG_STAT: JTAG HW mode 2 status */
+#define ASPEED_JTAG_STAT_ENG_IDLE	BIT(0)
+
+#define ASPEED_JTAG_MAX_PAD_SIZE	512
+
+/* Use this macro to set us delay to WA the intensive R/W FIFO usage issue=
 */
+#define AST26XX_FIFO_UDELAY		2
+
+/* Use this macro to set us delay for JTAG Controller to be programmed */
+#define AST26XX_JTAG_CTRL_UDELAY	2
+
+/*#define CONFIG_USE_INTERRUPTS*/
+#define DEBUG_JTAG
+
+static const char * const regnames[] =3D {
+	[ASPEED_JTAG_DATA] =3D "ASPEED_JTAG_DATA",
+	[ASPEED_JTAG_INST] =3D "ASPEED_JTAG_INST",
+	[ASPEED_JTAG_CTRL] =3D "ASPEED_JTAG_CTRL",
+	[ASPEED_JTAG_ISR]  =3D "ASPEED_JTAG_ISR",
+	[ASPEED_JTAG_SW]   =3D "ASPEED_JTAG_SW",
+	[ASPEED_JTAG_TCK]  =3D "ASPEED_JTAG_TCK",
+	[ASPEED_JTAG_EC]   =3D "ASPEED_JTAG_EC",
+	[ASPEED_JTAG_SHDATA]  =3D "ASPEED_JTAG_SHDATA",
+	[ASPEED_JTAG_SHINST]  =3D "ASPEED_JTAG_SHINST",
+	[ASPEED_JTAG_PADCTRL0] =3D "ASPEED_JTAG_PADCTRL0",
+	[ASPEED_JTAG_PADCTRL1] =3D "ASPEED_JTAG_PADCTRL1",
+	[ASPEED_JTAG_SHCTRL]   =3D "ASPEED_JTAG_SHCTRL",
+	[ASPEED_JTAG_GBLCTRL]  =3D "ASPEED_JTAG_GBLCTRL",
+	[ASPEED_JTAG_INTCTRL]  =3D "ASPEED_JTAG_INTCTRL",
+	[ASPEED_JTAG_STAT]     =3D "ASPEED_JTAG_STAT",
+};
+
+#define ASPEED_JTAG_NAME		"jtag-aspeed"
+
+struct aspeed_jtag {
+	void __iomem			*reg_base;
+	struct device			*dev;
+	struct clk			*pclk;
+	enum jtag_tapstate		status;
+	int				irq;
+	struct reset_control		*rst;
+	u32				flag;
+	wait_queue_head_t		jtag_wq;
+	u32				mode;
+	enum jtag_tapstate		current_state;
+	u32				tck_period;
+	u32				tck_cycle_delay_count;
+	const struct jtag_low_level_functions *llops;
+	u32 pad_data_one[ASPEED_JTAG_MAX_PAD_SIZE / 32];
+	u32 pad_data_zero[ASPEED_JTAG_MAX_PAD_SIZE / 32];
+};
+
+/*
+ * Multi generation support is enabled by fops and low level assped functi=
on
+ * mapping using asped_jtag_functions struct as config mechanism.
+ */
+
+struct jtag_low_level_functions {
+	void (*output_disable)(struct aspeed_jtag *aspeed_jtag);
+	void (*controller_enable)(struct aspeed_jtag *aspeed_jtag);
+	int (*xfer_push_data)(struct aspeed_jtag *aspeed_jtag,
+			      enum jtag_xfer_type type, u32 bits_len);
+	int (*xfer_push_data_last)(struct aspeed_jtag *aspeed_jtag,
+				   enum jtag_xfer_type type, u32 bits_len);
+	void (*xfer_sw)(struct aspeed_jtag *aspeed_jtag, struct jtag_xfer *xfer,
+			u32 *data);
+	int (*xfer_hw)(struct aspeed_jtag *aspeed_jtag, struct jtag_xfer *xfer,
+		       u32 *data);
+	void (*xfer_hw_fifo_delay)(void);
+	void (*xfer_sw_delay)(struct aspeed_jtag *aspeed_jtag);
+	void (*xfer_tck_cycle_delay)(struct aspeed_jtag *aspeed_jtag);
+	irqreturn_t (*jtag_interrupt)(s32 this_irq, void *dev_id);
+};
+
+struct aspeed_jtag_functions {
+	const struct jtag_ops *aspeed_jtag_ops;
+	const struct jtag_low_level_functions *aspeed_jtag_llops;
+};
+
+#ifdef DEBUG_JTAG
+static char *end_status_str[] =3D { "tlr",   "idle",  "selDR", "capDR",
+				  "sDR",   "ex1DR", "pDR",   "ex2DR",
+				  "updDR", "selIR", "capIR", "sIR",
+				  "ex1IR", "pIR",   "ex2IR", "updIR",
+				  "current"};
+#endif
+
+static u32 aspeed_jtag_read(struct aspeed_jtag *aspeed_jtag, u32 reg)
+{
+	u32 val =3D readl(aspeed_jtag->reg_base + reg);
+
+#ifdef DEBUG_JTAG
+	dev_dbg(aspeed_jtag->dev, "read:%s val =3D 0x%08x\n", regnames[reg], val)=
;
+#endif
+	return val;
+}
+
+static void aspeed_jtag_write(struct aspeed_jtag *aspeed_jtag, u32 val, u3=
2 reg)
+{
+#ifdef DEBUG_JTAG
+	dev_dbg(aspeed_jtag->dev, "write:%s val =3D 0x%08x\n", regnames[reg],
+		val);
+#endif
+	writel(val, aspeed_jtag->reg_base + reg);
+}
+
+static int aspeed_jtag_freq_set(struct jtag *jtag, u32 freq)
+{
+	struct aspeed_jtag *aspeed_jtag =3D jtag_priv(jtag);
+	unsigned long apb_frq;
+	u32 tck_val;
+	u16 div;
+
+	if (!freq)
+		return -EINVAL;
+
+	apb_frq =3D clk_get_rate(aspeed_jtag->pclk);
+	if (!apb_frq)
+		return -EOPNOTSUPP;
+
+	div =3D (apb_frq - 1) / freq;
+	tck_val =3D aspeed_jtag_read(aspeed_jtag, ASPEED_JTAG_TCK);
+	aspeed_jtag_write(aspeed_jtag,
+			  (tck_val & ~ASPEED_JTAG_TCK_DIVISOR_MASK) | div,
+			  ASPEED_JTAG_TCK);
+	aspeed_jtag->tck_period =3D
+		DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * (div + 1), apb_frq);
+	return 0;
+}
+
+static int aspeed_jtag_freq_set_26xx(struct jtag *jtag, u32 freq)
+{
+	struct aspeed_jtag *aspeed_jtag =3D jtag_priv(jtag);
+	unsigned long apb_frq;
+	u32 tck_val;
+	u16 div;
+
+	if (!freq)
+		return -EINVAL;
+
+	apb_frq =3D clk_get_rate(aspeed_jtag->pclk);
+	if (!apb_frq)
+		return -EOPNOTSUPP;
+
+	div =3D (apb_frq - 1) / freq;
+	tck_val =3D aspeed_jtag_read(aspeed_jtag, ASPEED_JTAG_GBLCTRL);
+	aspeed_jtag_write(aspeed_jtag,
+			  (tck_val & ~ASPEED_JTAG_CLK_DIVISOR_MASK) | div,
+			  ASPEED_JTAG_GBLCTRL);
+	return 0;
+}
+
+static int aspeed_jtag_freq_get(struct jtag *jtag, u32 *frq)
+{
+	struct aspeed_jtag *aspeed_jtag =3D jtag_priv(jtag);
+	u32 pclk;
+	u32 tck;
+
+	pclk =3D clk_get_rate(aspeed_jtag->pclk);
+	tck =3D aspeed_jtag_read(aspeed_jtag, ASPEED_JTAG_TCK);
+	*frq =3D pclk / (ASPEED_JTAG_TCK_GET_DIV(tck) + 1);
+
+	return 0;
+}
+
+static int aspeed_jtag_freq_get_26xx(struct jtag *jtag, u32 *frq)
+{
+	struct aspeed_jtag *aspeed_jtag =3D jtag_priv(jtag);
+	u32 pclk;
+	u32 tck;
+
+	pclk =3D clk_get_rate(aspeed_jtag->pclk);
+	tck =3D aspeed_jtag_read(aspeed_jtag, ASPEED_JTAG_GBLCTRL);
+	*frq =3D pclk / (ASPEED_JTAG_CLK_GET_DIV(tck) + 1);
+
+	return 0;
+}
+
+static inline void aspeed_jtag_output_disable(struct aspeed_jtag *aspeed_j=
tag)
+{
+	aspeed_jtag_write(aspeed_jtag, 0, ASPEED_JTAG_CTRL);
+}
+
+static inline void
+aspeed_jtag_output_disable_26xx(struct aspeed_jtag *aspeed_jtag)
+{
+	u32 reg_val;
+
+	reg_val =3D aspeed_jtag_read(aspeed_jtag, ASPEED_JTAG_GBLCTRL) &
+		  ASPEED_JTAG_CLK_DIVISOR_MASK;
+	aspeed_jtag_write(aspeed_jtag, 0, ASPEED_JTAG_CTRL);
+	aspeed_jtag_write(aspeed_jtag, reg_val, ASPEED_JTAG_GBLCTRL);
+}
+
+static inline void aspeed_jtag_controller(struct aspeed_jtag *aspeed_jtag)
+{
+	aspeed_jtag_write(aspeed_jtag,
+			  (ASPEED_JTAG_CTL_ENG_EN | ASPEED_JTAG_CTL_ENG_OUT_EN),
+			  ASPEED_JTAG_CTRL);
+
+	aspeed_jtag_write(aspeed_jtag,
+			  ASPEED_JTAG_SW_MODE_EN | ASPEED_JTAG_SW_MODE_TDIO,
+			  ASPEED_JTAG_SW);
+	aspeed_jtag_write(aspeed_jtag,
+			  ASPEED_JTAG_ISR_INST_PAUSE |
+				  ASPEED_JTAG_ISR_INST_COMPLETE |
+				  ASPEED_JTAG_ISR_DATA_PAUSE |
+				  ASPEED_JTAG_ISR_DATA_COMPLETE |
+				  ASPEED_JTAG_ISR_INST_PAUSE_EN |
+				  ASPEED_JTAG_ISR_INST_COMPLETE_EN |
+				  ASPEED_JTAG_ISR_DATA_PAUSE_EN |
+				  ASPEED_JTAG_ISR_DATA_COMPLETE_EN,
+			  ASPEED_JTAG_ISR); /* Enable Interrupt */
+}
+
+static inline void aspeed_jtag_controller_26xx(struct aspeed_jtag *aspeed_=
jtag)
+{
+	u32 reg_val;
+
+	reg_val =3D aspeed_jtag_read(aspeed_jtag, ASPEED_JTAG_GBLCTRL) &
+		ASPEED_JTAG_CLK_DIVISOR_MASK;
+	if (aspeed_jtag->mode & JTAG_XFER_HW_MODE) {
+		aspeed_jtag_write(aspeed_jtag, 0, ASPEED_JTAG_CTRL);
+		aspeed_jtag_write(aspeed_jtag, 0, ASPEED_JTAG_SW);
+	} else {
+		aspeed_jtag_write(aspeed_jtag,
+				  ASPEED_JTAG_SW_MODE_EN |
+					  ASPEED_JTAG_SW_MODE_TDIO,
+				  ASPEED_JTAG_SW);
+	}
+	/*
+	 * For the software mode, it's still necessary to enable out_en and
+	 * select the out_en in the hw2 register to maintain control of the
+	 * TRST bit same as hw2.
+	 */
+	aspeed_jtag_write(aspeed_jtag,
+			  reg_val | ASPEED_JTAG_GBLCTRL_ENG_MODE_EN |
+				  ASPEED_JTAG_GBLCTRL_ENG_OUT_EN |
+				  ASPEED_JTAG_GBLCTRL_TRST,
+			  ASPEED_JTAG_GBLCTRL);
+	reg_val =3D aspeed_jtag_read(aspeed_jtag, ASPEED_JTAG_GBLCTRL);
+	dev_dbg(aspeed_jtag->dev, "ASPEED_JTAG_GBLCTRL:val =3D 0x%08x\n", reg_val=
);
+	aspeed_jtag_write(aspeed_jtag,
+			  ASPEED_JTAG_INTCTRL_SHCPL_IRQ_EN |
+				  ASPEED_JTAG_INTCTRL_SHCPL_IRQ_STAT,
+			  ASPEED_JTAG_INTCTRL); /* Enable HW2 IRQ */
+
+	aspeed_jtag_write(aspeed_jtag,
+			  ASPEED_JTAG_ISR_INST_PAUSE |
+				  ASPEED_JTAG_ISR_INST_COMPLETE |
+				  ASPEED_JTAG_ISR_DATA_PAUSE |
+				  ASPEED_JTAG_ISR_DATA_COMPLETE |
+				  ASPEED_JTAG_ISR_INST_PAUSE_EN |
+				  ASPEED_JTAG_ISR_INST_COMPLETE_EN |
+				  ASPEED_JTAG_ISR_DATA_PAUSE_EN |
+				  ASPEED_JTAG_ISR_DATA_COMPLETE_EN,
+			  ASPEED_JTAG_ISR); /* Enable HW1 Interrupts */
+}
+
+static void aspeed_jtag_tck_cycle_delay(struct aspeed_jtag *aspeed_jtag)
+{
+	int i =3D 0;
+
+	for (i =3D 0; i < aspeed_jtag->tck_cycle_delay_count; i++)
+		ndelay(aspeed_jtag->tck_period >> 1);
+}
+
+static int aspeed_jtag_mode_set(struct jtag *jtag, struct jtag_mode *jtag_=
mode)
+{
+	struct aspeed_jtag *aspeed_jtag =3D jtag_priv(jtag);
+
+	switch (jtag_mode->feature) {
+	case JTAG_XFER_MODE:
+		aspeed_jtag->mode =3D jtag_mode->mode;
+		aspeed_jtag->llops->controller_enable(aspeed_jtag);
+		break;
+	case JTAG_CONTROL_MODE:
+		if (jtag_mode->mode =3D=3D JTAG_CONTROLLER_OUTPUT_DISABLE)
+			aspeed_jtag->llops->output_disable(aspeed_jtag);
+		else if (jtag_mode->mode =3D=3D JTAG_CONTROLLER_MODE)
+			aspeed_jtag->llops->controller_enable(aspeed_jtag);
+		break;
+	case JTAG_TCK_CYCLE_DELAY_COUNT:
+		aspeed_jtag->tck_cycle_delay_count =3D jtag_mode->mode;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/*
+ * We read and write from an unused JTAG controller register in SW mode to
+ * create a delay in xfers.
+ * We found this mechanism better than any udelay or usleep option.
+ */
+static inline void aspeed_jtag_sw_delay_26xx(struct aspeed_jtag *aspeed_jt=
ag)
+{
+	u32 read_reg =3D aspeed_jtag_read(aspeed_jtag, ASPEED_JTAG_PADCTRL1);
+
+	aspeed_jtag_write(aspeed_jtag, read_reg, ASPEED_JTAG_PADCTRL1);
+}
+
+static char aspeed_jtag_tck_cycle(struct aspeed_jtag *aspeed_jtag, u8 tms,
+				  u8 tdi)
+{
+	char tdo =3D 0;
+
+	/* TCK =3D 0 */
+	aspeed_jtag_write(aspeed_jtag,
+			  ASPEED_JTAG_SW_MODE_EN |
+				  (tms * ASPEED_JTAG_SW_MODE_TMS) |
+				  (tdi * ASPEED_JTAG_SW_MODE_TDIO),
+			  ASPEED_JTAG_SW);
+
+	/* Wait until JTAG controller finishes the operation */
+	if (aspeed_jtag->llops->xfer_sw_delay)
+		aspeed_jtag->llops->xfer_sw_delay(aspeed_jtag);
+	else
+		aspeed_jtag_read(aspeed_jtag, ASPEED_JTAG_SW);
+
+	if (aspeed_jtag->llops->xfer_tck_cycle_delay &&
+	    aspeed_jtag->tck_cycle_delay_count)
+		aspeed_jtag->llops->xfer_tck_cycle_delay(aspeed_jtag);
+
+	/* TCK =3D 1 */
+	aspeed_jtag_write(aspeed_jtag,
+			  ASPEED_JTAG_SW_MODE_EN | ASPEED_JTAG_SW_MODE_TCK |
+				  (tms * ASPEED_JTAG_SW_MODE_TMS) |
+				  (tdi * ASPEED_JTAG_SW_MODE_TDIO),
+			  ASPEED_JTAG_SW);
+
+	/* Wait until JTAG controller finishes the operation */
+	if (aspeed_jtag->llops->xfer_sw_delay)
+		aspeed_jtag->llops->xfer_sw_delay(aspeed_jtag);
+
+	if (aspeed_jtag->llops->xfer_tck_cycle_delay &&
+	    aspeed_jtag->tck_cycle_delay_count)
+		aspeed_jtag->llops->xfer_tck_cycle_delay(aspeed_jtag);
+
+	if (aspeed_jtag_read(aspeed_jtag, ASPEED_JTAG_SW) &
+	    ASPEED_JTAG_SW_MODE_TDIO)
+		tdo =3D 1;
+
+	return tdo;
+}
+
+static int aspeed_jtag_bitbang(struct jtag *jtag,
+			       struct bitbang_packet *bitbang,
+			       struct tck_bitbang *bitbang_data)
+{
+	struct aspeed_jtag *aspeed_jtag =3D jtag_priv(jtag);
+	int i =3D 0;
+
+	for (i =3D 0; i < bitbang->length; i++) {
+		bitbang_data[i].tdo =3D
+			aspeed_jtag_tck_cycle(aspeed_jtag, bitbang_data[i].tms,
+					      bitbang_data[i].tdi);
+	}
+	return 0;
+}
+
+static inline void aspeed_jtag_xfer_hw_fifo_delay_26xx(void)
+{
+	udelay(AST26XX_FIFO_UDELAY);
+}
+
+static int aspeed_jtag_isr_wait(struct aspeed_jtag *aspeed_jtag, u32 bit)
+{
+	int res =3D 0;
+#ifdef CONFIG_USE_INTERRUPTS
+	res =3D wait_event_interruptible(aspeed_jtag->jtag_wq,
+				       aspeed_jtag->flag & bit);
+	aspeed_jtag->flag &=3D ~bit;
+#else
+	u32 status =3D 0;
+	u32 iterations =3D 0;
+
+	while ((status & bit) =3D=3D 0) {
+		status =3D aspeed_jtag_read(aspeed_jtag, ASPEED_JTAG_ISR);
+#ifdef DEBUG_JTAG
+		dev_dbg(aspeed_jtag->dev, "%s  =3D 0x%08x\n", __func__, status);
+#endif
+		iterations++;
+		if (iterations > WAIT_ITERATIONS) {
+			dev_err(aspeed_jtag->dev, "%s %d in ASPEED_JTAG_ISR\n",
+				"aspeed_jtag driver timed out waiting for bit",
+				bit);
+			res =3D -EFAULT;
+			break;
+		}
+		if ((status & ASPEED_JTAG_ISR_DATA_COMPLETE) =3D=3D 0) {
+			if (iterations % 25 =3D=3D 0)
+				usleep_range(1, 5);
+			else
+				udelay(1);
+		}
+	}
+	aspeed_jtag_write(aspeed_jtag, bit | (status & 0xf), ASPEED_JTAG_ISR);
+#endif
+	return res;
+}
+
+static int aspeed_jtag_wait_shift_complete(struct aspeed_jtag *aspeed_jtag=
)
+{
+	int res =3D 0;
+#ifdef CONFIG_USE_INTERRUPTS
+	res =3D wait_event_interruptible(aspeed_jtag->jtag_wq,
+				       aspeed_jtag->flag &
+				       ASPEED_JTAG_INTCTRL_SHCPL_IRQ_STAT);
+	aspeed_jtag->flag &=3D ~ASPEED_JTAG_INTCTRL_SHCPL_IRQ_STAT;
+#else
+	u32 status =3D 0;
+	u32 iterations =3D 0;
+
+	while ((status & ASPEED_JTAG_INTCTRL_SHCPL_IRQ_STAT) =3D=3D 0) {
+		status =3D aspeed_jtag_read(aspeed_jtag, ASPEED_JTAG_INTCTRL);
+#ifdef DEBUG_JTAG
+		dev_dbg(aspeed_jtag->dev, "%s  =3D 0x%08x\n", __func__, status);
+#endif
+		iterations++;
+		if (iterations > WAIT_ITERATIONS) {
+			dev_err(aspeed_jtag->dev,
+				"aspeed_jtag driver timed out waiting for shift completed\n");
+			res =3D -EFAULT;
+			break;
+		}
+		if (iterations % 25 =3D=3D 0)
+			usleep_range(1, 5);
+		else
+			udelay(1);
+	}
+	aspeed_jtag_write(aspeed_jtag,
+			  ASPEED_JTAG_INTCTRL_SHCPL_IRQ_STAT |
+				  ASPEED_JTAG_INTCTRL_SHCPL_IRQ_EN,
+			  ASPEED_JTAG_INTCTRL);
+#endif
+	return res;
+}
+
+static void aspeed_jtag_set_tap_state(struct aspeed_jtag *aspeed_jtag,
+				      enum jtag_tapstate from_state,
+				      enum jtag_tapstate end_state)
+{
+	int i =3D 0;
+	enum jtag_tapstate from, to;
+
+	from =3D from_state;
+	to =3D end_state;
+
+	if (from =3D=3D JTAG_STATE_CURRENT)
+		from =3D aspeed_jtag->current_state;
+
+	for (i =3D 0; i < _tms_cycle_lookup[from][to].count; i++)
+		aspeed_jtag_tck_cycle(aspeed_jtag,
+				      ((_tms_cycle_lookup[from][to].tmsbits
+				      >> i) & 0x1), 0);
+	aspeed_jtag->current_state =3D end_state;
+}
+
+static void aspeed_jtag_set_tap_state_sw(struct aspeed_jtag *aspeed_jtag,
+					 struct jtag_tap_state *tapstate)
+{
+	int i;
+
+	/* SW mode from curent tap state -> to end_state */
+	if (tapstate->reset || tapstate->endstate =3D=3D JTAG_STATE_TLRESET) {
+		for (i =3D 0; i < ASPEED_JTAG_RESET_CNTR; i++)
+			aspeed_jtag_tck_cycle(aspeed_jtag, 1, 0);
+		aspeed_jtag->current_state =3D JTAG_STATE_TLRESET;
+	}
+
+	aspeed_jtag_set_tap_state(aspeed_jtag, tapstate->from,
+				  tapstate->endstate);
+	if (tapstate->endstate =3D=3D JTAG_STATE_TLRESET ||
+	    tapstate->endstate =3D=3D JTAG_STATE_IDLE ||
+	    tapstate->endstate =3D=3D JTAG_STATE_PAUSEDR ||
+	    tapstate->endstate =3D=3D JTAG_STATE_PAUSEIR)
+		for (i =3D 0; i < tapstate->tck; i++)
+			aspeed_jtag_tck_cycle(aspeed_jtag, 0, 0);
+}
+
+static int aspeed_jtag_status_set(struct jtag *jtag,
+				  struct jtag_tap_state *tapstate)
+{
+	struct aspeed_jtag *aspeed_jtag =3D jtag_priv(jtag);
+	int i;
+
+#ifdef DEBUG_JTAG
+	dev_dbg(aspeed_jtag->dev, "Set TAP state: %s\n",
+		end_status_str[tapstate->endstate]);
+#endif
+
+	if (!(aspeed_jtag->mode & JTAG_XFER_HW_MODE)) {
+		aspeed_jtag_set_tap_state_sw(aspeed_jtag, tapstate);
+		return 0;
+	}
+
+	/* x TMS high + 1 TMS low */
+	if (tapstate->reset) {
+		/* Disable sw mode */
+		aspeed_jtag_write(aspeed_jtag, 0, ASPEED_JTAG_SW);
+		mdelay(1);
+		aspeed_jtag_write(aspeed_jtag,
+				  ASPEED_JTAG_CTL_ENG_EN |
+					  ASPEED_JTAG_CTL_ENG_OUT_EN |
+					  ASPEED_JTAG_CTL_FORCE_TMS,
+				  ASPEED_JTAG_CTRL);
+		mdelay(1);
+		aspeed_jtag_write(aspeed_jtag, ASPEED_JTAG_SW_TDIO,
+				  ASPEED_JTAG_SW);
+		aspeed_jtag->current_state =3D JTAG_STATE_TLRESET;
+	}
+	for (i =3D 0; i < tapstate->tck; i++)
+		ndelay(aspeed_jtag->tck_period);
+
+	return 0;
+}
+
+static int aspeed_jtag_shctrl_tms_mask(enum jtag_tapstate from,
+				       enum jtag_tapstate to,
+				       enum jtag_tapstate there,
+				       enum jtag_tapstate endstate,
+				       u32 start_shift, u32 end_shift,
+				       u32 *tms_mask)
+{
+	u32 pre_tms =3D start_shift ? _tms_cycle_lookup[from][to].count : 0;
+	u32 post_tms =3D end_shift ? _tms_cycle_lookup[there][endstate].count : 0=
;
+	u32 tms_value =3D start_shift ? _tms_cycle_lookup[from][to].tmsbits : 0;
+
+	tms_value |=3D end_shift ? _tms_cycle_lookup[there][endstate].tmsbits
+					 << pre_tms :
+				 0;
+	if (pre_tms > GENMASK(2, 0) || post_tms > GENMASK(2, 0)) {
+		pr_err("pre/port tms count is greater than hw limit");
+		return -EINVAL;
+	}
+	*tms_mask =3D start_shift | ASPEED_JTAG_SHCTRL_PRE_TMS(pre_tms) |
+		    end_shift | ASPEED_JTAG_SHCTRL_POST_TMS(post_tms) |
+		    ASPEED_JTAG_SHCTRL_TMS(tms_value);
+	return 0;
+}
+
+static void aspeed_jtag_set_tap_state_hw2(struct aspeed_jtag *aspeed_jtag,
+					  struct jtag_tap_state *tapstate)
+{
+	u32 reg_val;
+
+	/* x TMS high + 1 TMS low */
+	if (tapstate->reset || tapstate->endstate =3D=3D JTAG_STATE_TLRESET) {
+		/* Disable sw mode */
+		aspeed_jtag_write(aspeed_jtag, 0, ASPEED_JTAG_SW);
+		udelay(AST26XX_JTAG_CTRL_UDELAY);
+		reg_val =3D aspeed_jtag_read(aspeed_jtag, ASPEED_JTAG_GBLCTRL);
+		aspeed_jtag_write(aspeed_jtag,
+				  reg_val | ASPEED_JTAG_GBLCTRL_ENG_MODE_EN |
+					  ASPEED_JTAG_GBLCTRL_ENG_OUT_EN |
+					  ASPEED_JTAG_GBLCTRL_RESET_FIFO |
+					  ASPEED_JTAG_GBLCTRL_FORCE_TMS,
+				  ASPEED_JTAG_GBLCTRL);
+		udelay(AST26XX_JTAG_CTRL_UDELAY);
+		while (aspeed_jtag_read(aspeed_jtag, ASPEED_JTAG_GBLCTRL) &
+		       ASPEED_JTAG_GBLCTRL_FORCE_TMS)
+			;
+		aspeed_jtag->current_state =3D JTAG_STATE_TLRESET;
+	} else if (tapstate->endstate =3D=3D JTAG_STATE_IDLE &&
+		   aspeed_jtag->current_state !=3D JTAG_STATE_IDLE) {
+		/* Always go to RTI, do not wait for shift operation */
+		aspeed_jtag_set_tap_state(aspeed_jtag,
+					  aspeed_jtag->current_state,
+					  JTAG_STATE_IDLE);
+		aspeed_jtag->current_state =3D JTAG_STATE_IDLE;
+	}
+	/* Run TCK */
+	if (tapstate->tck) {
+		/* Disable sw mode */
+		aspeed_jtag_write(aspeed_jtag, 0, ASPEED_JTAG_SW);
+		aspeed_jtag_write(aspeed_jtag, 0, ASPEED_JTAG_PADCTRL0);
+		reg_val =3D aspeed_jtag_read(aspeed_jtag, ASPEED_JTAG_GBLCTRL);
+		reg_val =3D reg_val & ~(GENMASK(22, 20));
+		aspeed_jtag_write(aspeed_jtag,
+				  reg_val | ASPEED_JTAG_GBLCTRL_FIFO_CTRL_MODE |
+					  ASPEED_JTAG_GBLCTRL_STSHIFT(0) |
+					  ASPEED_JTAG_GBLCTRL_UPDT_SHIFT(tapstate->tck),
+				  ASPEED_JTAG_GBLCTRL);
+
+		aspeed_jtag_write(aspeed_jtag,
+				  ASPEED_JTAG_SHCTRL_STSHIFT_EN |
+					  ASPEED_JTAG_SHCTRL_LWRDT_SHIFT(tapstate->tck),
+				  ASPEED_JTAG_SHCTRL);
+		aspeed_jtag_wait_shift_complete(aspeed_jtag);
+	}
+}
+
+static int aspeed_jtag_status_set_26xx(struct jtag *jtag,
+				       struct jtag_tap_state *tapstate)
+{
+	struct aspeed_jtag *aspeed_jtag =3D jtag_priv(jtag);
+
+#ifdef DEBUG_JTAG
+	dev_dbg(aspeed_jtag->dev, "Set TAP state: status %s from %s to %s\n",
+		end_status_str[aspeed_jtag->current_state],
+		end_status_str[tapstate->from],
+		end_status_str[tapstate->endstate]);
+#endif
+
+	if (!(aspeed_jtag->mode & JTAG_XFER_HW_MODE)) {
+		aspeed_jtag_set_tap_state_sw(aspeed_jtag, tapstate);
+		return 0;
+	}
+
+	aspeed_jtag_set_tap_state_hw2(aspeed_jtag, tapstate);
+	return 0;
+}
+
+static void aspeed_jtag_xfer_sw(struct aspeed_jtag *aspeed_jtag,
+				struct jtag_xfer *xfer, u32 *data)
+{
+	unsigned long remain_xfer =3D xfer->length;
+	unsigned long shift_bits =3D 0;
+	unsigned long index =3D 0;
+	unsigned long tdi;
+	char tdo;
+
+#ifdef DEBUG_JTAG
+	dev_dbg(aspeed_jtag->dev, "SW JTAG SHIFT %s, length =3D %d\n",
+		(xfer->type =3D=3D JTAG_SIR_XFER) ? "IR" : "DR", xfer->length);
+#endif
+
+	if (xfer->type =3D=3D JTAG_SIR_XFER)
+		aspeed_jtag_set_tap_state(aspeed_jtag, xfer->from,
+					  JTAG_STATE_SHIFTIR);
+	else
+		aspeed_jtag_set_tap_state(aspeed_jtag, xfer->from,
+					  JTAG_STATE_SHIFTDR);
+
+	tdi =3D ASPEED_JTAG_GET_TDI(xfer->direction, data[index]);
+	data[index] =3D 0;
+	while (remain_xfer > 1) {
+		tdo =3D aspeed_jtag_tck_cycle(aspeed_jtag, 0,
+					    tdi & ASPEED_JTAG_DATA_MSB);
+		data[index] |=3D tdo
+			       << (shift_bits % ASPEED_JTAG_DATA_CHUNK_SIZE);
+		tdi >>=3D 1;
+		shift_bits++;
+		remain_xfer--;
+
+		if (shift_bits % ASPEED_JTAG_DATA_CHUNK_SIZE =3D=3D 0) {
+			tdo =3D 0;
+			index++;
+			tdi =3D ASPEED_JTAG_GET_TDI(xfer->direction, data[index]);
+			data[index] =3D 0;
+		}
+	}
+
+	if ((xfer->endstate =3D=3D (xfer->type =3D=3D JTAG_SIR_XFER ?
+					JTAG_STATE_SHIFTIR :
+					JTAG_STATE_SHIFTDR))) {
+		/* Stay in Shift IR/DR*/
+		tdo =3D aspeed_jtag_tck_cycle(aspeed_jtag, 0,
+					    tdi & ASPEED_JTAG_DATA_MSB);
+		data[index] |=3D tdo
+			       << (shift_bits % ASPEED_JTAG_DATA_CHUNK_SIZE);
+	} else {
+		/* Goto end state */
+		tdo =3D aspeed_jtag_tck_cycle(aspeed_jtag, 1,
+					    tdi & ASPEED_JTAG_DATA_MSB);
+		data[index] |=3D tdo
+			       << (shift_bits % ASPEED_JTAG_DATA_CHUNK_SIZE);
+		aspeed_jtag->status =3D (xfer->type =3D=3D JTAG_SIR_XFER) ?
+					      JTAG_STATE_EXIT1IR :
+					      JTAG_STATE_EXIT1DR;
+		aspeed_jtag_set_tap_state(aspeed_jtag, aspeed_jtag->status,
+					  xfer->endstate);
+	}
+}
+
+static int aspeed_jtag_xfer_push_data_26xx(struct aspeed_jtag *aspeed_jtag=
,
+					   enum jtag_xfer_type type,
+					   u32 bits_len)
+{
+	int res =3D 0;
+
+	aspeed_jtag_write(aspeed_jtag, ASPEED_JTAG_TRANS_LEN(bits_len),
+			  ASPEED_JTAG_CTRL);
+	if (type =3D=3D JTAG_SIR_XFER) {
+		aspeed_jtag_write(aspeed_jtag,
+				  ASPEED_JTAG_TRANS_LEN(bits_len) |
+					  ASPEED_JTAG_CTL_26XX_INST_EN,
+				  ASPEED_JTAG_CTRL);
+		res =3D aspeed_jtag_isr_wait(aspeed_jtag,
+					   ASPEED_JTAG_ISR_INST_PAUSE);
+	} else {
+		aspeed_jtag_write(aspeed_jtag,
+				  ASPEED_JTAG_TRANS_LEN(bits_len) |
+					  ASPEED_JTAG_CTL_DATA_EN,
+				  ASPEED_JTAG_CTRL);
+		res =3D aspeed_jtag_isr_wait(aspeed_jtag,
+					   ASPEED_JTAG_ISR_DATA_PAUSE);
+	}
+	return res;
+}
+
+static int aspeed_jtag_xfer_push_data(struct aspeed_jtag *aspeed_jtag,
+				      enum jtag_xfer_type type, u32 bits_len)
+{
+	int res =3D 0;
+
+	if (type =3D=3D JTAG_SIR_XFER) {
+		aspeed_jtag_write(aspeed_jtag, ASPEED_JTAG_IOUT_LEN(bits_len),
+				  ASPEED_JTAG_CTRL);
+		aspeed_jtag_write(aspeed_jtag,
+				  ASPEED_JTAG_IOUT_LEN(bits_len) |
+					  ASPEED_JTAG_CTL_INST_EN,
+				  ASPEED_JTAG_CTRL);
+		res =3D aspeed_jtag_isr_wait(aspeed_jtag,
+					   ASPEED_JTAG_ISR_INST_PAUSE);
+	} else {
+		aspeed_jtag_write(aspeed_jtag, ASPEED_JTAG_DOUT_LEN(bits_len),
+				  ASPEED_JTAG_CTRL);
+		aspeed_jtag_write(aspeed_jtag,
+				  ASPEED_JTAG_DOUT_LEN(bits_len) |
+					  ASPEED_JTAG_CTL_DATA_EN,
+				  ASPEED_JTAG_CTRL);
+		res =3D aspeed_jtag_isr_wait(aspeed_jtag,
+					   ASPEED_JTAG_ISR_DATA_PAUSE);
+	}
+	return res;
+}
+
+static int aspeed_jtag_xfer_push_data_last_26xx(struct aspeed_jtag *aspeed=
_jtag,
+						enum jtag_xfer_type type,
+						u32 shift_bits)
+{
+	int res =3D 0;
+
+	aspeed_jtag_write(aspeed_jtag,
+			  ASPEED_JTAG_TRANS_LEN(shift_bits) |
+				  ASPEED_JTAG_CTL_26XX_LASPEED_TRANS,
+			  ASPEED_JTAG_CTRL);
+	if (type =3D=3D JTAG_SIR_XFER) {
+		aspeed_jtag_write(aspeed_jtag,
+				  ASPEED_JTAG_TRANS_LEN(shift_bits) |
+					  ASPEED_JTAG_CTL_26XX_LASPEED_TRANS |
+					  ASPEED_JTAG_CTL_26XX_INST_EN,
+				  ASPEED_JTAG_CTRL);
+		res =3D aspeed_jtag_isr_wait(aspeed_jtag,
+					   ASPEED_JTAG_ISR_INST_COMPLETE);
+	} else {
+		aspeed_jtag_write(aspeed_jtag,
+				  ASPEED_JTAG_TRANS_LEN(shift_bits) |
+					  ASPEED_JTAG_CTL_26XX_LASPEED_TRANS |
+					  ASPEED_JTAG_CTL_DATA_EN,
+				  ASPEED_JTAG_CTRL);
+		res =3D aspeed_jtag_isr_wait(aspeed_jtag,
+					   ASPEED_JTAG_ISR_DATA_COMPLETE);
+	}
+	return res;
+}
+
+static int aspeed_jtag_xfer_push_data_last(struct aspeed_jtag *aspeed_jtag=
,
+					   enum jtag_xfer_type type,
+					   u32 shift_bits)
+{
+	int res =3D 0;
+
+	if (type =3D=3D JTAG_SIR_XFER) {
+		aspeed_jtag_write(aspeed_jtag,
+				  ASPEED_JTAG_IOUT_LEN(shift_bits) |
+					  ASPEED_JTAG_CTL_LASPEED_INST,
+				  ASPEED_JTAG_CTRL);
+		aspeed_jtag_write(aspeed_jtag,
+				  ASPEED_JTAG_IOUT_LEN(shift_bits) |
+					  ASPEED_JTAG_CTL_LASPEED_INST |
+					  ASPEED_JTAG_CTL_INST_EN,
+				  ASPEED_JTAG_CTRL);
+		res =3D aspeed_jtag_isr_wait(aspeed_jtag,
+					   ASPEED_JTAG_ISR_INST_COMPLETE);
+	} else {
+		aspeed_jtag_write(aspeed_jtag,
+				  ASPEED_JTAG_DOUT_LEN(shift_bits) |
+					  ASPEED_JTAG_CTL_LASPEED_DATA,
+				  ASPEED_JTAG_CTRL);
+		aspeed_jtag_write(aspeed_jtag,
+				  ASPEED_JTAG_DOUT_LEN(shift_bits) |
+					  ASPEED_JTAG_CTL_LASPEED_DATA |
+					  ASPEED_JTAG_CTL_DATA_EN,
+				  ASPEED_JTAG_CTRL);
+		res =3D aspeed_jtag_isr_wait(aspeed_jtag,
+					   ASPEED_JTAG_ISR_DATA_COMPLETE);
+	}
+	return res;
+}
+
+static int aspeed_jtag_xfer_hw(struct aspeed_jtag *aspeed_jtag,
+			       struct jtag_xfer *xfer, u32 *data)
+{
+	unsigned long remain_xfer =3D xfer->length;
+	unsigned long index =3D 0;
+	char shift_bits;
+	u32 data_reg;
+	u32 scan_end;
+	union pad_config padding;
+	int retval =3D 0;
+
+	padding.int_value =3D xfer->padding;
+
+#ifdef DEBUG_JTAG
+	dev_dbg(aspeed_jtag->dev, "HW JTAG SHIFT %s, length =3D %d pad =3D 0x%x\n=
",
+		(xfer->type =3D=3D JTAG_SIR_XFER) ? "IR" : "DR", xfer->length,
+		xfer->padding);
+#endif
+	data_reg =3D xfer->type =3D=3D JTAG_SIR_XFER ? ASPEED_JTAG_INST :
+						 ASPEED_JTAG_DATA;
+	if (xfer->endstate =3D=3D JTAG_STATE_SHIFTIR ||
+	    xfer->endstate =3D=3D JTAG_STATE_SHIFTDR ||
+	    xfer->endstate =3D=3D JTAG_STATE_PAUSEIR ||
+	    xfer->endstate =3D=3D JTAG_STATE_PAUSEDR) {
+		scan_end =3D 0;
+	} else {
+		if (padding.post_pad_number)
+			scan_end =3D 0;
+		else
+			scan_end =3D 1;
+	}
+
+	/* Perform pre padding */
+	if (padding.pre_pad_number) {
+		struct jtag_xfer pre_xfer =3D {
+			.type =3D xfer->type,
+			.direction =3D JTAG_WRITE_XFER,
+			.from =3D xfer->from,
+			.endstate =3D xfer->type =3D=3D JTAG_SIR_XFER ?
+				    JTAG_STATE_SHIFTIR : JTAG_STATE_SHIFTDR,
+			.padding =3D 0,
+			.length =3D padding.pre_pad_number,
+		};
+		if (padding.pre_pad_number > ASPEED_JTAG_MAX_PAD_SIZE)
+			return -EINVAL;
+		retval =3D aspeed_jtag_xfer_hw(aspeed_jtag, &pre_xfer,
+					     padding.pad_data ?
+					     aspeed_jtag->pad_data_one :
+					     aspeed_jtag->pad_data_zero);
+		if (retval)
+			return retval;
+	}
+
+	while (remain_xfer) {
+		if (xfer->direction & JTAG_WRITE_XFER)
+			aspeed_jtag_write(aspeed_jtag, data[index], data_reg);
+		else
+			aspeed_jtag_write(aspeed_jtag, 0, data_reg);
+		if (aspeed_jtag->llops->xfer_hw_fifo_delay)
+			aspeed_jtag->llops->xfer_hw_fifo_delay();
+
+		if (remain_xfer > ASPEED_JTAG_DATA_CHUNK_SIZE) {
+#ifdef DEBUG_JTAG
+			dev_dbg(aspeed_jtag->dev,
+				"Chunk len=3D%d chunk_size=3D%d remain_xfer=3D%lu\n",
+				xfer->length, ASPEED_JTAG_DATA_CHUNK_SIZE,
+				remain_xfer);
+#endif
+			shift_bits =3D ASPEED_JTAG_DATA_CHUNK_SIZE;
+
+			/*
+			 * Transmit bytes that were not equals to column length
+			 * and after the transfer go to Pause IR/DR.
+			 */
+			if (aspeed_jtag->llops->xfer_push_data(aspeed_jtag,
+							       xfer->type,
+							       shift_bits)
+							       !=3D 0) {
+				return -EFAULT;
+			}
+		} else {
+			/*
+			 * Read bytes equals to column length
+			 */
+			shift_bits =3D remain_xfer;
+			if (scan_end) {
+				/*
+				 * If this data is the end of the transmission
+				 * send remaining bits and go to endstate
+				 */
+#ifdef DEBUG_JTAG
+				dev_dbg(aspeed_jtag->dev,
+					"Last len=3D%d chunk_size=3D%d remain_xfer=3D%lu\n",
+					xfer->length,
+					ASPEED_JTAG_DATA_CHUNK_SIZE,
+					remain_xfer);
+#endif
+				if (aspeed_jtag->llops->xfer_push_data_last(
+					    aspeed_jtag, xfer->type,
+					    shift_bits) !=3D 0) {
+					return -EFAULT;
+				}
+			} else {
+				/*
+				 * If transmission is waiting for additional
+				 * data send remaining bits and then go to
+				 * Pause IR/DR.
+				 */
+#ifdef DEBUG_JTAG
+				dev_dbg(aspeed_jtag->dev,
+					"Tail len=3D%d chunk_size=3D%d remain_xfer=3D%lu\n",
+					xfer->length,
+					ASPEED_JTAG_DATA_CHUNK_SIZE,
+					remain_xfer);
+#endif
+				if (aspeed_jtag->llops->xfer_push_data(
+					    aspeed_jtag, xfer->type,
+					    shift_bits) !=3D 0) {
+					return -EFAULT;
+				}
+			}
+		}
+
+		if (xfer->direction & JTAG_READ_XFER) {
+			if (shift_bits < ASPEED_JTAG_DATA_CHUNK_SIZE) {
+				data[index] =3D
+					aspeed_jtag_read(aspeed_jtag, data_reg);
+
+				data[index] >>=3D ASPEED_JTAG_DATA_CHUNK_SIZE -
+						shift_bits;
+			} else {
+				data[index] =3D
+					aspeed_jtag_read(aspeed_jtag, data_reg);
+			}
+			if (aspeed_jtag->llops->xfer_hw_fifo_delay)
+				aspeed_jtag->llops->xfer_hw_fifo_delay();
+		}
+
+		remain_xfer =3D remain_xfer - shift_bits;
+		index++;
+	}
+
+	/* Perform post padding */
+	if (padding.post_pad_number) {
+		struct jtag_xfer post_xfer =3D {
+			.type =3D xfer->type,
+			.direction =3D JTAG_WRITE_XFER,
+			.from =3D xfer->from,
+			.endstate =3D xfer->endstate,
+			.padding =3D 0,
+			.length =3D padding.post_pad_number,
+		};
+		if (padding.post_pad_number > ASPEED_JTAG_MAX_PAD_SIZE)
+			return -EINVAL;
+		retval =3D aspeed_jtag_xfer_hw(aspeed_jtag, &post_xfer,
+					     padding.pad_data ?
+					     aspeed_jtag->pad_data_one :
+					     aspeed_jtag->pad_data_zero);
+		if (retval)
+			return retval;
+	}
+	return 0;
+}
+
+static int aspeed_jtag_xfer(struct jtag *jtag, struct jtag_xfer *xfer,
+			    u8 *xfer_data)
+{
+	struct aspeed_jtag *aspeed_jtag =3D jtag_priv(jtag);
+
+	if (!(aspeed_jtag->mode & JTAG_XFER_HW_MODE)) {
+		/* SW mode */
+		aspeed_jtag_write(aspeed_jtag, ASPEED_JTAG_SW_TDIO,
+				  ASPEED_JTAG_SW);
+
+		aspeed_jtag->llops->xfer_sw(aspeed_jtag, xfer,
+					    (u32 *)xfer_data);
+	} else {
+		/* HW mode */
+		aspeed_jtag_write(aspeed_jtag, 0, ASPEED_JTAG_SW);
+		if (aspeed_jtag->llops->xfer_hw(aspeed_jtag, xfer,
+						(u32 *)xfer_data) !=3D 0)
+			return -EFAULT;
+	}
+
+	aspeed_jtag->status =3D xfer->endstate;
+	return 0;
+}
+
+static int aspeed_jtag_xfer_hw2(struct aspeed_jtag *aspeed_jtag,
+				struct jtag_xfer *xfer, u32 *data)
+{
+	unsigned long remain_xfer =3D xfer->length;
+	unsigned long partial_xfer_size =3D 0;
+	unsigned long index =3D 0;
+	u32 shift_bits;
+	u32 data_reg;
+	u32 reg_val;
+	enum jtag_tapstate shift;
+	enum jtag_tapstate exit;
+	enum jtag_tapstate exitx;
+	enum jtag_tapstate pause;
+	enum jtag_tapstate endstate;
+	u32 start_shift;
+	u32 end_shift;
+	u32 tms_mask;
+	int ret;
+
+	if (xfer->type =3D=3D JTAG_SIR_XFER) {
+		data_reg =3D ASPEED_JTAG_SHDATA;
+		shift =3D JTAG_STATE_SHIFTIR;
+		pause =3D JTAG_STATE_PAUSEIR;
+		exit =3D JTAG_STATE_EXIT1IR;
+		exitx =3D JTAG_STATE_EXIT1DR;
+	} else {
+		data_reg =3D ASPEED_JTAG_SHDATA;
+		shift =3D JTAG_STATE_SHIFTDR;
+		pause =3D JTAG_STATE_PAUSEDR;
+		exit =3D JTAG_STATE_EXIT1DR;
+		exitx =3D JTAG_STATE_EXIT1IR;
+	}
+#ifdef DEBUG_JTAG
+	dev_dbg(aspeed_jtag->dev,
+		"HW2 JTAG SHIFT %s, length %d status %s from %s to %s then %s pad 0x%x\n=
",
+		(xfer->type =3D=3D JTAG_SIR_XFER) ? "IR" : "DR", xfer->length,
+		end_status_str[aspeed_jtag->current_state],
+		end_status_str[xfer->from],
+		end_status_str[shift],
+		end_status_str[xfer->endstate], xfer->padding);
+#endif
+
+	if (aspeed_jtag->current_state =3D=3D shift)
+		start_shift =3D 0;
+	else
+		start_shift =3D ASPEED_JTAG_SHCTRL_START_SHIFT;
+
+	if (xfer->endstate =3D=3D shift) {
+		/*
+		 * In the case of shifting 1 bit of data and attempting to stay
+		 * in the SHIFT state, the AST2600 JTAG Controller in Hardware
+		 * mode 2 has been observed to go to EXIT1 IR/DR instead of
+		 * staying in the SHIFT IR/DR state. The following code special
+		 * cases this one bit shift and directs the state machine to go
+		 * to the PAUSE IR/DR state instead.
+		 * Alternatively, the application making driver calls can avoid
+		 * this situation as follows:
+		 *   1.) Bundle all of the shift bits  together into one call
+		 *       AND/OR
+		 *   2.) Direct all partial shifts to move to the PAUSE-IR/DR
+		 *       state.
+		 */
+		if (xfer->length =3D=3D 1) {
+#ifdef DEBUG_JTAG
+			dev_warn(aspeed_jtag->dev, "JTAG Silicon WA: going to pause instead of =
shift");
+#endif
+			end_shift =3D ASPEED_JTAG_SHCTRL_END_SHIFT;
+			endstate =3D pause;
+		} else {
+			end_shift =3D 0;
+			endstate =3D shift;
+		}
+	} else {
+		endstate =3D xfer->endstate;
+		end_shift =3D ASPEED_JTAG_SHCTRL_END_SHIFT;
+	}
+
+	aspeed_jtag_write(aspeed_jtag, xfer->padding, ASPEED_JTAG_PADCTRL0);
+
+	while (remain_xfer) {
+		unsigned long partial_xfer;
+		unsigned long partial_index;
+
+		if (remain_xfer > ASPEED_JTAG_HW2_DATA_CHUNK_SIZE)
+			partial_xfer_size =3D ASPEED_JTAG_HW2_DATA_CHUNK_SIZE;
+		else
+			partial_xfer_size =3D remain_xfer;
+
+		partial_index =3D index;
+		partial_xfer =3D partial_xfer_size;
+
+		reg_val =3D aspeed_jtag_read(aspeed_jtag, ASPEED_JTAG_GBLCTRL);
+		aspeed_jtag_write(aspeed_jtag, reg_val |
+				  ASPEED_JTAG_GBLCTRL_RESET_FIFO,
+				  ASPEED_JTAG_GBLCTRL);
+
+		/* Switch internal FIFO into CPU mode */
+		reg_val =3D reg_val & ~BIT(24);
+		aspeed_jtag_write(aspeed_jtag, reg_val,
+				  ASPEED_JTAG_GBLCTRL);
+
+		while (partial_xfer) {
+			if (partial_xfer > ASPEED_JTAG_DATA_CHUNK_SIZE)
+				shift_bits =3D ASPEED_JTAG_DATA_CHUNK_SIZE;
+			else
+				shift_bits =3D partial_xfer;
+
+			if (xfer->direction & JTAG_WRITE_XFER)
+				aspeed_jtag_write(aspeed_jtag,
+						  data[partial_index++],
+						  data_reg);
+			else
+				aspeed_jtag_write(aspeed_jtag, 0, data_reg);
+			if (aspeed_jtag->llops->xfer_hw_fifo_delay)
+				aspeed_jtag->llops->xfer_hw_fifo_delay();
+			partial_xfer =3D partial_xfer - shift_bits;
+		}
+		if (remain_xfer > ASPEED_JTAG_HW2_DATA_CHUNK_SIZE) {
+			shift_bits =3D ASPEED_JTAG_HW2_DATA_CHUNK_SIZE;
+
+			/*
+			 * Transmit bytes that were not equals to column length
+			 * and after the transfer go to Pause IR/DR.
+			 */
+
+			ret =3D aspeed_jtag_shctrl_tms_mask(aspeed_jtag->current_state, shift, =
exit,
+							  endstate, start_shift, 0, &tms_mask);
+			if (ret)
+				return ret;
+
+			reg_val =3D aspeed_jtag_read(aspeed_jtag,
+						   ASPEED_JTAG_GBLCTRL);
+			reg_val =3D reg_val & ~(GENMASK(22, 20));
+			aspeed_jtag_write(aspeed_jtag, reg_val |
+					  ASPEED_JTAG_GBLCTRL_FIFO_CTRL_MODE |
+					  ASPEED_JTAG_GBLCTRL_UPDT_SHIFT(
+						shift_bits),
+					  ASPEED_JTAG_GBLCTRL);
+
+			aspeed_jtag_write(aspeed_jtag, tms_mask |
+				ASPEED_JTAG_SHCTRL_LWRDT_SHIFT(shift_bits),
+				ASPEED_JTAG_SHCTRL);
+			aspeed_jtag_wait_shift_complete(aspeed_jtag);
+		} else {
+			/*
+			 * Read bytes equals to column length
+			 */
+			shift_bits =3D remain_xfer;
+			ret =3D aspeed_jtag_shctrl_tms_mask(aspeed_jtag->current_state, shift, =
exit,
+							  endstate, start_shift, end_shift,
+							  &tms_mask);
+			if (ret)
+				return ret;
+
+			reg_val =3D aspeed_jtag_read(aspeed_jtag,
+						   ASPEED_JTAG_GBLCTRL);
+			reg_val =3D reg_val & ~(GENMASK(22, 20));
+			aspeed_jtag_write(aspeed_jtag, reg_val |
+					  ASPEED_JTAG_GBLCTRL_FIFO_CTRL_MODE |
+					  ASPEED_JTAG_GBLCTRL_UPDT_SHIFT(
+						shift_bits),
+					  ASPEED_JTAG_GBLCTRL);
+
+			aspeed_jtag_write(aspeed_jtag, tms_mask |
+					  ASPEED_JTAG_SHCTRL_LWRDT_SHIFT(
+						  shift_bits),
+					  ASPEED_JTAG_SHCTRL);
+
+			aspeed_jtag_wait_shift_complete(aspeed_jtag);
+		}
+
+		partial_index =3D index;
+		partial_xfer =3D partial_xfer_size;
+		while (partial_xfer) {
+			if (partial_xfer >
+			    ASPEED_JTAG_DATA_CHUNK_SIZE) {
+				shift_bits =3D
+					ASPEED_JTAG_DATA_CHUNK_SIZE;
+				data[partial_index++] =3D
+					aspeed_jtag_read(aspeed_jtag,
+							 data_reg);
+
+			} else {
+				shift_bits =3D partial_xfer;
+				data[partial_index++] =3D
+					aspeed_jtag_read(aspeed_jtag,
+							 data_reg);
+			}
+			if (aspeed_jtag->llops->xfer_hw_fifo_delay)
+				aspeed_jtag->llops->xfer_hw_fifo_delay();
+			partial_xfer =3D partial_xfer - shift_bits;
+		}
+
+		remain_xfer =3D remain_xfer - partial_xfer_size;
+		index =3D partial_index;
+		start_shift =3D 0;
+	}
+	aspeed_jtag->current_state =3D endstate;
+	return 0;
+}
+
+static int aspeed_jtag_status_get(struct jtag *jtag, u32 *status)
+{
+	struct aspeed_jtag *aspeed_jtag =3D jtag_priv(jtag);
+
+	*status =3D aspeed_jtag->current_state;
+	return 0;
+}
+
+static irqreturn_t aspeed_jtag_interrupt(s32 this_irq, void *dev_id)
+{
+	struct aspeed_jtag *aspeed_jtag =3D dev_id;
+	irqreturn_t ret;
+	u32 status;
+
+	status =3D aspeed_jtag_read(aspeed_jtag, ASPEED_JTAG_ISR);
+
+	if (status & ASPEED_JTAG_ISR_INT_MASK) {
+		aspeed_jtag_write(aspeed_jtag,
+				  (status & ASPEED_JTAG_ISR_INT_MASK) |
+					  (status &
+					   ASPEED_JTAG_ISR_INT_EN_MASK),
+				  ASPEED_JTAG_ISR);
+		aspeed_jtag->flag |=3D status & ASPEED_JTAG_ISR_INT_MASK;
+	}
+
+	if (aspeed_jtag->flag) {
+		wake_up_interruptible(&aspeed_jtag->jtag_wq);
+		ret =3D IRQ_HANDLED;
+	} else {
+		dev_err(aspeed_jtag->dev, "irq status:%x\n", status);
+		ret =3D IRQ_NONE;
+	}
+	return ret;
+}
+
+static irqreturn_t aspeed_jtag_interrupt_hw2(s32 this_irq, void *dev_id)
+{
+	struct aspeed_jtag *aspeed_jtag =3D dev_id;
+	irqreturn_t ret;
+	u32 status;
+
+	status =3D aspeed_jtag_read(aspeed_jtag, ASPEED_JTAG_INTCTRL);
+
+	if (status & ASPEED_JTAG_INTCTRL_SHCPL_IRQ_STAT) {
+		aspeed_jtag_write(aspeed_jtag,
+				  status | ASPEED_JTAG_INTCTRL_SHCPL_IRQ_STAT,
+				  ASPEED_JTAG_INTCTRL);
+		aspeed_jtag->flag |=3D status & ASPEED_JTAG_INTCTRL_SHCPL_IRQ_STAT;
+	}
+
+	if (aspeed_jtag->flag) {
+		wake_up_interruptible(&aspeed_jtag->jtag_wq);
+		ret =3D IRQ_HANDLED;
+	} else {
+		dev_err(aspeed_jtag->dev, "irq status:%x\n", status);
+		ret =3D IRQ_NONE;
+	}
+	return ret;
+}
+
+static int aspeed_jtag_enable(struct jtag *jtag)
+{
+	struct aspeed_jtag *aspeed_jtag =3D jtag_priv(jtag);
+
+	aspeed_jtag->llops->controller_enable(aspeed_jtag);
+	return 0;
+}
+
+static int aspeed_jtag_disable(struct jtag *jtag)
+{
+	struct aspeed_jtag *aspeed_jtag =3D jtag_priv(jtag);
+
+	aspeed_jtag->llops->output_disable(aspeed_jtag);
+	return 0;
+}
+
+static int aspeed_jtag_init(struct platform_device *pdev,
+			    struct aspeed_jtag *aspeed_jtag)
+{
+	struct resource *res;
+#ifdef CONFIG_USE_INTERRUPTS
+	int err;
+#endif
+	memset(aspeed_jtag->pad_data_one, ~0,
+	       sizeof(aspeed_jtag->pad_data_one));
+	memset(aspeed_jtag->pad_data_zero, 0,
+	       sizeof(aspeed_jtag->pad_data_zero));
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	aspeed_jtag->reg_base =3D devm_ioremap_resource(aspeed_jtag->dev, res);
+	if (IS_ERR(aspeed_jtag->reg_base))
+		return -ENOMEM;
+
+	aspeed_jtag->pclk =3D devm_clk_get(aspeed_jtag->dev, NULL);
+	if (IS_ERR(aspeed_jtag->pclk)) {
+		dev_err(aspeed_jtag->dev, "devm_clk_get failed\n");
+		return PTR_ERR(aspeed_jtag->pclk);
+	}
+
+#ifdef CONFIG_USE_INTERRUPTS
+	aspeed_jtag->irq =3D platform_get_irq(pdev, 0);
+	if (aspeed_jtag->irq < 0) {
+		dev_err(aspeed_jtag->dev, "no irq specified\n");
+		return -ENOENT;
+	}
+#endif
+
+	if (clk_prepare_enable(aspeed_jtag->pclk)) {
+		dev_err(aspeed_jtag->dev, "no irq specified\n");
+		return -ENOENT;
+	}
+
+	aspeed_jtag->rst =3D devm_reset_control_get_shared(&pdev->dev, NULL);
+	if (IS_ERR(aspeed_jtag->rst)) {
+		dev_err(aspeed_jtag->dev,
+			"missing or invalid reset controller device tree entry");
+		return PTR_ERR(aspeed_jtag->rst);
+	}
+	reset_control_deassert(aspeed_jtag->rst);
+
+#ifdef CONFIG_USE_INTERRUPTS
+	err =3D devm_request_irq(aspeed_jtag->dev, aspeed_jtag->irq,
+			       aspeed_jtag->llops->jtag_interrupt, 0,
+			       "aspeed-jtag", aspeed_jtag);
+	if (err) {
+		dev_err(aspeed_jtag->dev, "unable to get IRQ");
+		clk_disable_unprepare(aspeed_jtag->pclk);
+		return err;
+	}
+#endif
+
+	aspeed_jtag->llops->output_disable(aspeed_jtag);
+
+	aspeed_jtag->flag =3D 0;
+	aspeed_jtag->mode =3D 0;
+	aspeed_jtag->tck_cycle_delay_count =3D 0;
+	init_waitqueue_head(&aspeed_jtag->jtag_wq);
+	return 0;
+}
+
+static int aspeed_jtag_deinit(struct platform_device *pdev,
+			      struct aspeed_jtag *aspeed_jtag)
+{
+	aspeed_jtag_write(aspeed_jtag, 0, ASPEED_JTAG_ISR);
+	/* Disable clock */
+	aspeed_jtag_write(aspeed_jtag, 0, ASPEED_JTAG_CTRL);
+	reset_control_assert(aspeed_jtag->rst);
+	clk_disable_unprepare(aspeed_jtag->pclk);
+	return 0;
+}
+
+static int aspeed_jtag_trst_set_hw1(struct jtag *jtag, u32 active)
+{
+	struct aspeed_jtag *aspeed_jtag =3D jtag_priv(jtag);
+
+	aspeed_jtag_write(aspeed_jtag, active ? 0 : ASPEED_JTAG_EC_TRST,
+			  ASPEED_JTAG_EC);
+	return 0;
+}
+
+static int aspeed_jtag_trst_set_hw2(struct jtag *jtag, u32 active)
+{
+	u32 reg_val;
+	struct aspeed_jtag *aspeed_jtag =3D jtag_priv(jtag);
+
+	reg_val =3D aspeed_jtag_read(aspeed_jtag, ASPEED_JTAG_GBLCTRL);
+	if (active)
+		reg_val |=3D ASPEED_JTAG_GBLCTRL_TRST;
+	else
+		reg_val &=3D ~ASPEED_JTAG_GBLCTRL_TRST;
+	aspeed_jtag_write(aspeed_jtag, reg_val, ASPEED_JTAG_GBLCTRL);
+	return 0;
+}
+
+static const struct jtag_ops aspeed_jtag_ops =3D {
+	.freq_get =3D aspeed_jtag_freq_get,
+	.freq_set =3D aspeed_jtag_freq_set,
+	.status_get =3D aspeed_jtag_status_get,
+	.status_set =3D aspeed_jtag_status_set,
+	.xfer =3D aspeed_jtag_xfer,
+	.mode_set =3D aspeed_jtag_mode_set,
+	.trst_set =3D aspeed_jtag_trst_set_hw1,
+	.bitbang =3D aspeed_jtag_bitbang,
+	.enable =3D aspeed_jtag_enable,
+	.disable =3D aspeed_jtag_disable
+};
+
+static const struct jtag_ops aspeed_jtag_ops_26xx =3D {
+#ifdef ASPEED_JTAG_HW_MODE_2_ENABLE
+	.freq_get =3D aspeed_jtag_freq_get_26xx,
+	.freq_set =3D aspeed_jtag_freq_set_26xx,
+	.status_get =3D aspeed_jtag_status_get,
+	.status_set =3D aspeed_jtag_status_set_26xx,
+	.trst_set =3D aspeed_jtag_trst_set_hw2,
+#else
+	.freq_get =3D aspeed_jtag_freq_get,
+	.freq_set =3D aspeed_jtag_freq_set,
+	.status_get =3D aspeed_jtag_status_get,
+	.status_set =3D aspeed_jtag_status_set,
+	.trst_set =3D aspeed_jtag_trst_set_hw1,
+#endif
+	.xfer =3D aspeed_jtag_xfer,
+	.mode_set =3D aspeed_jtag_mode_set,
+	.bitbang =3D aspeed_jtag_bitbang,
+	.enable =3D aspeed_jtag_enable,
+	.disable =3D aspeed_jtag_disable
+};
+
+static const struct jtag_low_level_functions ast25xx_llops =3D {
+	.controller_enable =3D aspeed_jtag_controller,
+	.output_disable =3D aspeed_jtag_output_disable,
+	.xfer_push_data =3D aspeed_jtag_xfer_push_data,
+	.xfer_push_data_last =3D aspeed_jtag_xfer_push_data_last,
+	.xfer_sw =3D aspeed_jtag_xfer_sw,
+	.xfer_hw =3D aspeed_jtag_xfer_hw,
+	.xfer_hw_fifo_delay =3D NULL,
+	.xfer_sw_delay =3D NULL,
+	.xfer_tck_cycle_delay =3D aspeed_jtag_tck_cycle_delay,
+	.jtag_interrupt =3D aspeed_jtag_interrupt
+};
+
+static const struct aspeed_jtag_functions ast25xx_functions =3D {
+	.aspeed_jtag_ops =3D &aspeed_jtag_ops,
+	.aspeed_jtag_llops =3D &ast25xx_llops
+};
+
+static const struct jtag_low_level_functions ast26xx_llops =3D {
+#ifdef ASPEED_JTAG_HW_MODE_2_ENABLE
+	.controller_enable =3D aspeed_jtag_controller_26xx,
+	.output_disable =3D aspeed_jtag_output_disable_26xx,
+	.xfer_push_data =3D aspeed_jtag_xfer_push_data_26xx,
+	.xfer_push_data_last =3D aspeed_jtag_xfer_push_data_last_26xx,
+	.xfer_sw =3D aspeed_jtag_xfer_sw,
+	.xfer_hw =3D aspeed_jtag_xfer_hw2,
+	.xfer_hw_fifo_delay =3D aspeed_jtag_xfer_hw_fifo_delay_26xx,
+	.xfer_sw_delay =3D aspeed_jtag_sw_delay_26xx,
+	.xfer_tck_cycle_delay =3D aspeed_jtag_tck_cycle_delay,
+	.jtag_interrupt =3D aspeed_jtag_interrupt_hw2
+#else
+	.controller_enable =3D aspeed_jtag_controller,
+	.output_disable =3D aspeed_jtag_output_disable,
+	.xfer_push_data =3D aspeed_jtag_xfer_push_data_26xx,
+	.xfer_push_data_last =3D aspeed_jtag_xfer_push_data_last_26xx,
+	.xfer_sw =3D aspeed_jtag_xfer_sw,
+	.xfer_hw =3D aspeed_jtag_xfer_hw,
+	.xfer_hw_fifo_delay =3D aspeed_jtag_xfer_hw_fifo_delay_26xx,
+	.xfer_sw_delay =3D aspeed_jtag_sw_delay_26xx,
+	.xfer_tck_cycle_delay =3D aspeed_jtag_tck_cycle_delay,
+	.jtag_interrupt =3D aspeed_jtag_interrupt
+#endif
+};
+
+static const struct aspeed_jtag_functions ast26xx_functions =3D {
+	.aspeed_jtag_ops =3D &aspeed_jtag_ops_26xx,
+	.aspeed_jtag_llops =3D &ast26xx_llops
+};
+
+static const struct of_device_id aspeed_jtag_of_match[] =3D {
+	{ .compatible =3D "aspeed,ast2400-jtag", .data =3D &ast25xx_functions },
+	{ .compatible =3D "aspeed,ast2500-jtag", .data =3D &ast25xx_functions },
+	{ .compatible =3D "aspeed,ast2600-jtag", .data =3D &ast26xx_functions },
+	{}
+};
+
+static int aspeed_jtag_probe(struct platform_device *pdev)
+{
+	struct aspeed_jtag *aspeed_jtag;
+	struct jtag *jtag;
+	const struct of_device_id *match;
+	const struct aspeed_jtag_functions *jtag_functions;
+	int err;
+
+	match =3D of_match_node(aspeed_jtag_of_match, pdev->dev.of_node);
+	if (!match)
+		return -ENODEV;
+	jtag_functions =3D match->data;
+
+	jtag =3D jtag_alloc(&pdev->dev, sizeof(*aspeed_jtag),
+			  jtag_functions->aspeed_jtag_ops);
+	if (!jtag)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, jtag);
+	aspeed_jtag =3D jtag_priv(jtag);
+	aspeed_jtag->dev =3D &pdev->dev;
+
+	aspeed_jtag->llops =3D jtag_functions->aspeed_jtag_llops;
+
+	/* Initialize device*/
+	err =3D aspeed_jtag_init(pdev, aspeed_jtag);
+	if (err)
+		goto err_jtag_init;
+
+	/* Initialize JTAG core structure*/
+	err =3D devm_jtag_register(aspeed_jtag->dev, jtag);
+	if (err)
+		goto err_jtag_register;
+
+	jtag_functions->aspeed_jtag_ops->freq_set(jtag, 1000000);
+
+	return 0;
+
+err_jtag_register:
+	aspeed_jtag_deinit(pdev, aspeed_jtag);
+err_jtag_init:
+	jtag_free(jtag);
+	return err;
+}
+
+static int aspeed_jtag_remove(struct platform_device *pdev)
+{
+	struct jtag *jtag =3D platform_get_drvdata(pdev);
+
+	aspeed_jtag_deinit(pdev, jtag_priv(jtag));
+	return 0;
+}
+
+static struct platform_driver aspeed_jtag_driver =3D {
+	.probe =3D aspeed_jtag_probe,
+	.remove =3D aspeed_jtag_remove,
+	.driver =3D {
+		.name =3D ASPEED_JTAG_NAME,
+		.of_match_table =3D aspeed_jtag_of_match,
+	},
+};
+module_platform_driver(aspeed_jtag_driver);
+
+MODULE_AUTHOR("Oleksandr Shamray <oleksandrs@mellanox.com>");
+MODULE_DESCRIPTION("ASPEED JTAG driver");
+MODULE_LICENSE("GPL v2");
--=20
2.25.1

