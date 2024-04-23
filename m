Return-Path: <linux-kernel+bounces-155813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7AD8AF77B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7701C22081
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C011420A8;
	Tue, 23 Apr 2024 19:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOP1qxi4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED06D28DC9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713901515; cv=fail; b=smVzio8rDj/bs+ZGXJH0R6XGwrImL+0PqbQJO2VGHYDaQUPt6ek4FZyA7YenqGUQI9lD15XnZ5J6ggGeCg3u9RzohuF98MbChMJaU9cf7du4dPZVQW2XhLXAWC/gM/tWE6igfQ2/srQtzoAiNt/ZbIJ10X1yHi/0iV7S+PMnvQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713901515; c=relaxed/simple;
	bh=AFnrsIpUCGWZH1aewOrd6EfwtajIyakQO0Km+0CMDic=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jQQUfYWdDyR/qlKrikGrpznZ89n2VIJnXFMOM6FUqTkHkpfcwbtRznVTUFxJizGWMKgIu7qVhYWcXT3twJKKWHvj7ew2cAtncy2TQcK6GiNzuxDSbVfXujdFU7dLk8D46vzsJ2VNVHr1MO3eNgPyTgrSMiSwf6/RudqNEhhpBTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOP1qxi4; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713901513; x=1745437513;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AFnrsIpUCGWZH1aewOrd6EfwtajIyakQO0Km+0CMDic=;
  b=WOP1qxi4KQjTUKUy6TtT/Qru/QXDgCZWX1F60HKx/pBv8TiCS86RAIs3
   8NnY8dRavGeAqLASaeSXe/qLAUQrWx6Ex2uANd9/QjMBSQIYAHvGOqxo4
   G85CAVSKI8owf3Vgb+9QOvyZjAMgKFLRIZTDy6p6vfo+bvL+2Nm2OSdXK
   sSCrZmGY8XA+PYPAamW1cenhCWmDq4nDaaj3pu/8Z29fXsOfl6ctdaVPe
   gtSd7qrfgFehigmrxuTOFYNM1LP0wXoyIIlhBX5s9AFieGFvLlXUKKy+U
   sIEYNY0CuEA8uGPFTHuO2EM/iBeJGjvrktOBz/cktquQPTSZ1gSwCCC6U
   g==;
X-CSE-ConnectionGUID: D6ESqW5gTwKZa8HGGtAHuA==
X-CSE-MsgGUID: dNu6wj+WSbSJzfI1qkEyRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9373663"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9373663"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 12:45:12 -0700
X-CSE-ConnectionGUID: 6j+7xoyjSiK5rNG9Iw4uIQ==
X-CSE-MsgGUID: fFc3n07xTPiX+P0BFcJlKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24917780"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 12:45:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 12:45:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 12:45:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 12:45:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 12:45:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVR9DH09IxzL9k5usZlA0MZJHq2lPTJ154ap+4Py3es9MJA/Bc/W7QoPO+LVVvIV7WvU+P2qvzp79aethLjsATqhLPBuPI//z5Xak/knYXVa3pB252nEFQtKdaA9MtKTBt0lEFFdqbKtT3LytNhj+kck9yb261iDsTAyczzy7D4sttvfbAfAnnYvLDRqNx8DhRrHuirMba6tnlzLg9S6UHkHfviWHE7mZiaRTaIdEUl+wvT0ujcgUcPwNc9qRS8ApZcJAR8DgrcFzZBA+Dw7yiCRC/32XKIfFV4KZPx5uyxB3y128Hw4etd/YYWEw2ExxlNk8FcCz65tz9OJIlP02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1adb0ZIOk1qFjVOboxSql/NjTJh7fZt96R2+9UmfnA=;
 b=Qrz+1LTpVEJ94VBBou0cBNZm1kCYzaW2mTAm2se2wTaU2J9q82Yh3HLftkwZeMinco1o7iCKZWmB1fvvfkTX+vbGJSUSNvtXQETO9I1Uk3gyv5wiH11MBLxKPJHyWS739Ge3dpYBsizlGzamLIHKmi5+MUNg++A1ckHQJx6HreC/niiQaTejxlJU0f5Mv+lRmllcyt4TUk6wII4Pjct1QNVVjr9MtUvcYfi4GYAbfF7+NFUy0ltrHYkkD+1JfvQ6BTkdY+zzaoOdhBHo1TMoi4xW3+I9XEWz/yiLuCq8XKgM6iSkpfG7T4nJS/Y2a0g/hOeuaJA9HDFoeox42CJM1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by SN7PR11MB7591.namprd11.prod.outlook.com (2603:10b6:806:32b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Tue, 23 Apr
 2024 19:45:08 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50%7]) with mapi id 15.20.7519.021; Tue, 23 Apr 2024
 19:45:08 +0000
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Kunwu Chan <chentao@kylinos.cn>, "arnd@arndb.de" <arnd@arndb.de>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"kunwu.chan@hotmail.com" <kunwu.chan@hotmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mei: bus: constify the struct mei_cl_bus_type usage
Thread-Topic: [PATCH] mei: bus: constify the struct mei_cl_bus_type usage
Thread-Index: AQHalSiMY12PPI1KcEW/2xbBxOJ0FbF2QxYA
Date: Tue, 23 Apr 2024 19:45:08 +0000
Message-ID: <PH7PR11MB76051D97AC76E8FCDE464F2FE5112@PH7PR11MB7605.namprd11.prod.outlook.com>
References: <20240423024133.1890455-1-chentao@kylinos.cn>
In-Reply-To: <20240423024133.1890455-1-chentao@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7605:EE_|SN7PR11MB7591:EE_
x-ms-office365-filtering-correlation-id: ad5d238e-2b02-43aa-cecc-08dc63cde1a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?YqRJfYl8JWmdF5hpiz52kR2gxDuxIfYHIFNmD/S986UL9Tcv1v+4OghDk9eM?=
 =?us-ascii?Q?sqEglybibVEKdPSKyEe1etBSknRCuFo2b0KogeLah0eRbTAqwSU89iNPDc4T?=
 =?us-ascii?Q?ISiFgA1w6G7qXP+OUOZ2ELUi70tUcIheNoYEFPvE0GVX+68xfopbEqlPDI9K?=
 =?us-ascii?Q?PshZRAOo1VLKm7g5lctgHFBowol2e9Co20HTFf4ytSeETRvu9weP7uuB4VxM?=
 =?us-ascii?Q?Y0V49i5grmXT96ucBGKS++T6MBlU5qT09PbZIlFjkRZ9R+L5fpCFZFUFoPVz?=
 =?us-ascii?Q?gFLdXfPWmsZq0aY/xGyJz8n2q1Z3yEVYHiMxN471ImHOsRGjvvg8d9xY+XCw?=
 =?us-ascii?Q?gchTkmF06OrVgYq+TbivV1k08kbUSHNvqQXuJK2+pjum0AAKgndWViFIRVSE?=
 =?us-ascii?Q?GDH09zzIFBSZeheH8BIpWxBDl8xY/hqjX2eWx5qAgKN43TsmMLRR4u38irC5?=
 =?us-ascii?Q?GlLlU02ERRqEIS5AhznhnMM8hJr68imRd9UJwwF0oNq2KedW005AyZok5mE0?=
 =?us-ascii?Q?zMCHk4eaztHJeNpZ5QD11CWHbwW3ZQBL5MirU+P8d2T/TGEJAD3i9rB/zb9o?=
 =?us-ascii?Q?0otdxQDYIeIgtd1lFTqw2ywDTK0C7QpHLRGmaMA/CwwzTkm1S2+wQBaXaS3s?=
 =?us-ascii?Q?C7d9cwB+9K41iL/XDGAqSxrGX2qx+Az7c/doc21ikpOQUwt85hmBK15kZwJJ?=
 =?us-ascii?Q?Q5WRaF0Ou9Quswm94oZSEeCtkdJ4r5vo+zk3tIc+zSjTyZgXAOsGSwtueaEX?=
 =?us-ascii?Q?ntzdy9AJ76vBB0m9h/1e9tteZFe8yiGcbDIz96g65oadIleDkWX1MVkNR9EP?=
 =?us-ascii?Q?A3JbHnr6a7nxX5ESak2b4NnGXgALyTMWCr/NUW1+yXi1TBeSpws54VTfbZM3?=
 =?us-ascii?Q?mutNBcxCqi/S7h9H67QWQxczga3iFw3MuokieWQbUijOGB9im+Y5fr2LVCA/?=
 =?us-ascii?Q?zKE+GhCkGUT2QDpUa2+Xmn+RO+j9X0jqkcv+zJy5oBo8b/KrOW3QNUK+e2IJ?=
 =?us-ascii?Q?bV66S2vzRq7Fd1sChTfVsVACaNBczxbXrf+w4xvrA1izwZx5YoTKnxOE1Xhf?=
 =?us-ascii?Q?8ZxFKo8lDvXlxTT3WJ7vrD4UZzNbZsnHjVUyxTmft3zZAlcEPO9bjjn72c3A?=
 =?us-ascii?Q?cTO8IIsYnW8uiosLwRvo/BqFTo/JXD9pxK6HUg3rTOhx3+4dYzc52hoM07Z+?=
 =?us-ascii?Q?5G+bjm0EpFIE/Bce+m2b7lRfXWNR7bb0G3OsrISY9ryyHjoYdL6tIlzbqSMc?=
 =?us-ascii?Q?iRZf1zXtnkE57nH9l9JawbL1gEXprp/tHY7C7b5gbaXwurcgXDPyOI+1v/eY?=
 =?us-ascii?Q?EdTDmlyeFajSxcMAGw0btPJMqa0hU9vbzCW0pyHzbI6cXA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+u4yyJlJAr/mio2vfSTkp3LrTnxClvJzc9bxHLdKtdQhT8AKu4Mt+2Xzmi0d?=
 =?us-ascii?Q?FDrKVVoFPcKwvbEuAEGyPNs9IAhR41aohG15cfbZadyjW9rjRs5Wn2iwiXN9?=
 =?us-ascii?Q?556QgWzWQ2b3GNFDKLU2HTV0cxWcpcU6Gti9fASBZxSGzn/nyTyQh9dV/xJx?=
 =?us-ascii?Q?hMSgrHju+du1CuqOCMlLcugg4Sr/H48FgbqKK70W8P/17w7wJQKalRRxQiZ6?=
 =?us-ascii?Q?J8FdK/fuBjga0MG6zLQO9qflH181gsdRzou6cxzhdHyj5WYXp4lfnCskHMCS?=
 =?us-ascii?Q?O6HzAEkmGdMTIIP5UqqBWDhg7k0meaapJ9CqKB0pICmFq5DCfc/iCKV3Z94N?=
 =?us-ascii?Q?kuMFqLKoV5ZOvC3EtuMJO6/dc3e/E9eZvf36cLwEE0G2zFGWJwKse4gCQHjx?=
 =?us-ascii?Q?AgQXnIVA086qkmBl+8ZVqhhHtTJ/+B+NmrjeCUL+Eq+OwpmW5TfBwk/Z0Lav?=
 =?us-ascii?Q?fY2uwARdtkopIwHXltGELUXlkmDq+AuVYyPxZGJ9E/HK0lEt7Yx0FrqfTF0c?=
 =?us-ascii?Q?p07bxe2TKGh0QmWk05LxxZFkR8nc0vqXQL/DKkgGe4L3fazxkAF9pkyyXu+X?=
 =?us-ascii?Q?lz6BsTyenIBerjEmLerlGjOaRVPOvN51H6s5ddzXLaex5frIp5l4QRAQ1UGe?=
 =?us-ascii?Q?7I2ZOrRa77J7OPYR1J0VghQ3pVdXey1RQvjxS4KrGtrv9JHwxnZ0kDo7vwwM?=
 =?us-ascii?Q?kNyn/6hc8wHTaYk6xQM2BFF4cM65ypiQqF/BquSQUCvElgOmSadheiDD1RHr?=
 =?us-ascii?Q?i1rugH4UCCXpMaY3EeRAi+9/M/ZMTDiAZEaw8rD9+bt4KmwlmjjeJYjOR5DI?=
 =?us-ascii?Q?TH6YDZrALWGTsyV9XX2eb4u6BFBuyXVdQqeW3nWCSYjGsN6248WmJNeMLjzQ?=
 =?us-ascii?Q?6I7/z/Mav1xuczNjR9uuoCOCeAd96mc4ZqtEKAFR+OqoHfzvpDT7O5W/9pYa?=
 =?us-ascii?Q?6hUCXRYWkRwhsPQuoU8UC67TTVWl9/gFoT2C4yjEjcZ/YAT97lJhn58qq4tw?=
 =?us-ascii?Q?uuz7dyYBmnULgRpWQAQagsyUCPDH7JF2UZ79R+UTGJVJhGbmE2mMUW6sA7CV?=
 =?us-ascii?Q?CB97Hzp315bUsj90FFZhvIMBQuFV/SU3KLEiBUya1lbshWu+D10LciOASmVy?=
 =?us-ascii?Q?zeZ9uqo9Mt8I7L9H0qT9bf92cA+zdy4zJvKR34KO+JRZ/76qL/4oH3WLgPUo?=
 =?us-ascii?Q?naEy0KwoYIJFpVP2SMzIo5FDovzt0tzWPTzbyqNPJcnffJmcYlV2wnZ+VNN9?=
 =?us-ascii?Q?beEt6Y5pVL7n7h7MF2+ynho17pARLFu9bC/nWHnM7dmyCWHg+xNCIXwk1hu7?=
 =?us-ascii?Q?tYYwkyWYB2+PpL10rtlnOl7VKkoEH8kLU3n4uI4AcxFMXsrA0n9BqrNmHN3F?=
 =?us-ascii?Q?xV/uM1VHGM5pB3EO9IsiM7nXLJkYgERGJr3fCP9tTqAHaEbrO6BxST7oGc5P?=
 =?us-ascii?Q?S4ZZ9M39wTva96JHoWldeqnE36X5oK8nnivOVsvUXhbVQSsXOTGgkv2l7cn/?=
 =?us-ascii?Q?s8KmnkSwYk7fs7pTYWq0Zbdrnq877QUzCt4/P3t9Y9QDB8DB7IvSqkFqkf1Z?=
 =?us-ascii?Q?EIPkutKZqz9jVkfVGe8dds7KrcrSOSDqhChMjPxS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5d238e-2b02-43aa-cecc-08dc63cde1a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 19:45:08.4757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqMHB2eZUWg3I+kCWEQuMneQcwvaJqZOFXVIvizhpxmGq3LyEMpSAg7oCxzhl74Rb+hK1hl6b0/chL86c3sX7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7591
X-OriginatorOrg: intel.com


>=20
> Now that the driver core can properly handle constant struct bus_type,
> move the mei_cl_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>=20
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
LGTM=20
> ---
>  drivers/misc/mei/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c index
> f9bcff197615..99393f610cdf 100644
> --- a/drivers/misc/mei/bus.c
> +++ b/drivers/misc/mei/bus.c
> @@ -1327,7 +1327,7 @@ static int mei_cl_device_uevent(const struct device
> *dev, struct kobj_uevent_env
>  	return 0;
>  }
>=20
> -static struct bus_type mei_cl_bus_type =3D {
> +static const struct bus_type mei_cl_bus_type =3D {
>  	.name		=3D "mei",
>  	.dev_groups	=3D mei_cldev_groups,
>  	.match		=3D mei_cl_device_match,
> --
> 2.40.1


