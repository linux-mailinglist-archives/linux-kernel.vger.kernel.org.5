Return-Path: <linux-kernel+bounces-158899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 883638B2676
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F132F1F225D6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4185B14D433;
	Thu, 25 Apr 2024 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PD7onuUw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDF914D428
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062587; cv=fail; b=KmgTlz5FJACZEwD3n9OOKBwPCbh7scbjNaEg7LS6apBNs88Ou5KfgVoSQkJhhu74QB8WM039iKZuyfmD1E7BcG2AQK2EX7YZmnnUkv3vf07xUuihxZaRXY404gPh6iVsSEbDqymLTvmj4SiWXyn1beiwt9iTifjPUN8iXyOFqqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062587; c=relaxed/simple;
	bh=c7oHx7NT6Bkdg7IUOqQpZmmQP2erzZVV+MLPmDNanSI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SFOM0kDnmiq1xmiPPkRujjAGSUaNIPrXzxqxMiGXq3UeV/zGDj4rEPUdq5rDLncbByrowVwxpVrIWWnatnlv3iq5HM7znsLVfRe3xajrymolY26iiK/5eSsB9cFt2nk77wL3U4Dud0XasLhex1SKLgmswYBYdqG7szLaXmRXQBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PD7onuUw; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714062586; x=1745598586;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c7oHx7NT6Bkdg7IUOqQpZmmQP2erzZVV+MLPmDNanSI=;
  b=PD7onuUwzLfS/vO/h2ocmztfjCYZ5pvIVXEhEX1MNRML9RyV+D4rLFLW
   gFFirW7NU6x76SA7DaSlbisAMzy62zcOHXZHVpEOfZbmNucemH/2MME2g
   R/pwxSJIvEalQu22orJdpDm2BsTmyu4+uYEduCdJc7CGEPVXJjpFplYMK
   t8+3Pf2bzEmkLcqlhRUWJgeQJuANLOZAxmzaUlgteNUzFamG7unu6jsw5
   4lFZvHVLbJAz2BeDMsPvIFNPLT3m5DrF4hPySCXyNsAwDO6ReEOmiYTz5
   GtSMecUKDjvn1HYFENqn3Ky746RrEKrZQ4QHryjtsspPLWDO6zcjgHBsM
   A==;
X-CSE-ConnectionGUID: 1YbuE3ivT6W4/QCoC3ccug==
X-CSE-MsgGUID: BYt3TxesRQmB9E43dBWzWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="13546787"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="13546787"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 09:29:45 -0700
X-CSE-ConnectionGUID: PyP82e1BSZKHzf5/LIlRYw==
X-CSE-MsgGUID: QwL79lMiSjKc/sGoeC4cfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="29924555"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Apr 2024 09:29:46 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 09:29:44 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 09:29:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 09:29:44 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 09:29:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaqZEpgT1VgWEsFCxzfhcUydzWujciRE+2htHkDirnvptxlrOc4SElbPQS5E7ZC9iMEPixQBEjXFBWwj+wsXtNo7rIyIf/gESu8TXx3AS/0hABqFRzIrCkNChBRl8fqldX0RROE0/82cnBvH4Ft63+GPuoWvYyhHLJh4yuv5H+ZYIDVSkdo84l3e1J35KdJdCOa3WpBOIssPO5okEXcPmnoLTm1TVOiUlHQGqSmqV3/FksRR8h5c/tEr2DglPkXB6fFh5wM6jNLAjvGd2R7jEtfyiMmVVQxS9yCdpkjjdoxkAaV1hdDB0HQ3M2LhAVZvLdbqatAUzwal3/wIdcxQxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7oHx7NT6Bkdg7IUOqQpZmmQP2erzZVV+MLPmDNanSI=;
 b=TsWEsHEaSpYyrHwuh4g0xaJzyXgrPL7RL7ViA+iQqe+KQzoYE2wlp1WNfx42EtT+mh/GLq9DF27IRYmLaEcmhhjIZxd71RgYMzIfbXatwzqmqg1zX+mOCQvRYBrpVHQ7g5GlQbkICOxFMTedUKiCDJVTcvi8Jf6L7KJV+9TnLQXT7MPE3ReMOTUcYThwD2kdt7O0NpQhumsvjVi3+6L4OQrKc3xL1vn3JT9Z5V7Ek6v11Y+j3tyRlwAHQ+N174mcAA2Y3mtpcwV3kmnGqdBR6J8F1/sJxUxE6Pc5+VK9tD2INIqb6uTiweKBOm2y3sEieHvu8vGgt+MKB6+V8xPCJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB8026.namprd11.prod.outlook.com (2603:10b6:806:2dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Thu, 25 Apr
 2024 16:29:38 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7519.015; Thu, 25 Apr 2024
 16:29:38 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Luis Chamberlain
	<mcgrof@kernel.org>, "Paolo Bonzini" <pbonzini@redhat.com>, "Raj, Ashok"
	<ashok.raj@intel.com>, "Si, Bingsong" <sibs@chinatelecom.cn>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v4 29/71] x86/cpu/intel: Switch to new Intel CPU model
 defines
Thread-Topic: [PATCH v4 29/71] x86/cpu/intel: Switch to new Intel CPU model
 defines
Thread-Index: AQHalnNgMtjgU4RXN06JKuKHgcFddrF4zrsAgABcLrA=
Date: Thu, 25 Apr 2024 16:29:37 +0000
Message-ID: <SJ1PR11MB6083654145DEDC921F7E39BAFC172@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
 <20240424181508.41713-1-tony.luck@intel.com>
 <20240425104624.GCZio0gDJABGjzoan1@fat_crate.local>
In-Reply-To: <20240425104624.GCZio0gDJABGjzoan1@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB8026:EE_
x-ms-office365-filtering-correlation-id: 529baa84-ca94-410a-76e5-08dc6544e688
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?VzhKZVdBL0lmeTllUmN0d0NWKy9QVWNtOGY3OEdaU3pybEQxM0d3K1ZFSVlk?=
 =?utf-8?B?NDFTenBRY3dSMEwvY0VpQklTbHFFVVJHS2JMMWMramEzUGk0a3J3TWdKZHk0?=
 =?utf-8?B?RnorMUZ3VzR3dUlKM3B4K1NEaGhadkdLQmpwSE9QRytOOVkzVG5vcVZxc3E5?=
 =?utf-8?B?SS8xWjlicEgxUlNVWWZSc3d6bndrMDhOdGRHNklISHhRWXVTcG5GRnNpemZk?=
 =?utf-8?B?a3JZakd6cEJhTkk3K01MdXNIMStDaE9VVWNhOUNXVWtlMUkrQXY0Y0pwdnpU?=
 =?utf-8?B?cnRzcFhYZHFSc1lOc2kzU2xTVkxDMjR0R1dpOTlyZ2YyMG1KZlBaVk9rZHA0?=
 =?utf-8?B?algyemt5b2VTbndBdzZDSVJ6b2lIUVlMNWMxRkZoWWV2NzZmK3daT3ovZXFy?=
 =?utf-8?B?WW5wVmtoZXRCWHlJYTZjNVNuV016SkVKWDArb2VUUVFyME45aU1FZlR5bE9n?=
 =?utf-8?B?RThrUXhLWVdyQnVMQXdlS0RiYjRxclNPb1EySFNhR0trZXJndlpwVUI4YVVQ?=
 =?utf-8?B?eU9mRytKK3JSVUkrb1E5Ulo1T3B6cjhnOWJxQ2xCaUZrUkl5NUpwdHcwVGlW?=
 =?utf-8?B?UURmZ096TEJncVBMUUp5R2ZDdTRpcm1yZ1hUL3MzWldSZTlIV21POGEwQ3ds?=
 =?utf-8?B?bmdWREE0SE5tbUdKL1RMZ0NIS2dUb3dQZVNFbk02T3Q4eUJ1NFNVM0JjQWU0?=
 =?utf-8?B?b0hoMzdHa1RhNWFnekh1djlxOHVwWmQ1ZXlMMmRMcGhnem5qZ2xHTFFLVWZl?=
 =?utf-8?B?TnAvZUdMcVE3dFd3eWs1OE1MK2lCZUM2bGpxNEs1aWkybHR5bU44YzFlRVBX?=
 =?utf-8?B?aFFCTm5nODlnZWozZUZ3cEFubkZrOFZ4QUxCdmtwU292aWNsUHpmNjBCbC90?=
 =?utf-8?B?OTFZZnBVZTRIN1R4NFlUVkwwY3UxSG9wcmVrWXJMdHRwM0lDRWZMbzEvK1V3?=
 =?utf-8?B?TmZSblBTQi9WdVZ5eUsxNEV4Y0NlTy9zNGR2cm16UkEycllPaGt5dEgwUFdU?=
 =?utf-8?B?ZE8xNHhwdTA5bmNIWVpoUDloSlFPRGxLd2d4TVQ1MXZBM0k4dTh4SkhiV2tx?=
 =?utf-8?B?U1ArNnhWMnBMcDB4Q1hLcjRydXIxZ28yV3FPbEprZ2lqOE9CWWRDMk9ubUhn?=
 =?utf-8?B?cm40dnhBYjNUQWp6dGpzUFl6ZWhIS3lteXp6Z1labTd0Yzk3R0Zha3d0UEg0?=
 =?utf-8?B?UmdhVERIY0lMNC9wU2creHFqdjRsL3BRcHNzQ3oyQWZ3UXl3QWJsMTluTHBH?=
 =?utf-8?B?c0o4YWZWTlRFeEJBcG5kdDJ1YzYyNHZFU1cwR2xMcXUzcm5LNUU2cy9vcXdv?=
 =?utf-8?B?VSs4clBrSUU4NnpjRng1WHU5eUlQK0s5RStaOUF6ZUk2cHBQQ3pJaWpEK1Rx?=
 =?utf-8?B?a25kQ0U1b1ZjTFNFeE94MHFlM1FDeHdDN0dzWjZKcVlwT1hGRys2WTl2MjR5?=
 =?utf-8?B?Y0tYeGp6LzQyVEMxKytMSXUxcXlIZnByUkhBQjYxVUU4MWJSQWNhK1BIdkZo?=
 =?utf-8?B?MmVpYUNKMHFmNU5oaTdyQ3B2OHVPNFRLMkwzaXowcjBZSU4zY09oNnJxTGZh?=
 =?utf-8?B?ZXIyOFN2R0NsVmtsUmordCtERUNDQ1E4WTNVaWtnTDlpN0tYK2NZVHpIaC8r?=
 =?utf-8?B?eHZISklteU53Y2JuWURPK1BvTHZJaFZFRWduZEoveCs3Z1VLQ0VkUDV6R1Jw?=
 =?utf-8?B?RVZKTHRlSlVLb0VPSDFkbVBSVmFqSzdRcGFxeTBhUkZuY1RwRklWQk5WLzlE?=
 =?utf-8?B?WUZqTGdYam1VTG5OZkNBNjZqS1RhbUI3WXQ4VFZVYlhRakJmaWVLMVNqVlhV?=
 =?utf-8?B?dlVLeXYvbGE1bVNRVm1Vdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVF5cXZUL0tzeklXRHdtNjFSK2hxT1lEM0swbWlXa3o3VlJHLythVGYxREZu?=
 =?utf-8?B?UU1zK3pxUmREbUFjSjUwalVtU3JzbGYzQ3RCdlhDMDU4T2IydDFpR3liSEFz?=
 =?utf-8?B?S2xubjViSEJmR3V5Y2dZejdaL1NhQ2FuTnBxSHk5bldTazY5dDlqaGxUc09i?=
 =?utf-8?B?QnRKLzQ0VXB1TEk5MkNDTDFwci9zNUI3ekhvSjI1eUN1VjZhd1J3eUlpUzk5?=
 =?utf-8?B?bklwTUI4QS8rNk1EZVZkUHVuUjlJRCtBc0FNWlNkNTdraWVNNmo5NmRXRnhp?=
 =?utf-8?B?eWVnVkEvU0NsejF0UGtTYmhuMVZBbVMwSUE3Q3pZQjQ2VFpnOFRjcjhtVUhh?=
 =?utf-8?B?WTJuT01Yc01tL0pkbU50UTFYcUgwdlpDVVdwUTZDS0tGb2ZkRFZwMWt1ZU45?=
 =?utf-8?B?UVRKTHQ1bzhTc0hiWjJIUXJ3NEhocWtKa2x3ZU5BRlFla0s4QWEzQi9JZEIz?=
 =?utf-8?B?dXhKSzFPamxwUkJBako3Q1g0bGRjYlA2RmN1MTJ3Q2gvWE4relZBS0dNSWc4?=
 =?utf-8?B?Q08zME04WXlPUCthNmFPQkFCcVJpSXBsb2s2bTN1RVYyMmpqdFBPTXlJdm5L?=
 =?utf-8?B?MUZkNVlMNmpoWEF2ZE04RGZQZWxWOWp1d2JKQXVINjNKVEtkWlFnbDkzeE1Z?=
 =?utf-8?B?ZTh2ZXF0eEVVbTk2aWZvNjVHMTNPbjBQNVl2ck5qN0wyMW5zOGQrbUt2QWc0?=
 =?utf-8?B?VlJldk5lZzU2bE1lbE9TbmN6N2hRUWRlRmZDQ21TdlJFR2lSZ2phb0lBcklE?=
 =?utf-8?B?TUI3bWZkQUpGY1NkQTczTjRnNVAxWU1tZWhaeHBHbkhlSldheFlUeHgrR0FG?=
 =?utf-8?B?WCt1djlLQXNTZFlVTER5R2xlYktWMTg2bkkrM1lab2l3RWFjQ0sxQ2tjWUVO?=
 =?utf-8?B?UlBjL3lHMEtDREVOR0FmbzM0YmxhWGVNYlBHQ0tlalI1TFp2L241YkE2K2Nm?=
 =?utf-8?B?YTZuTHNRY2dCRnpYamwvUVVvbzRkcjJYUndPZkQ0NDl6VmZOZFBFb1RFV2d5?=
 =?utf-8?B?Z1pyOWNWd3Z3UTVhR2g0U1g5aFZZS1ppK3RIS3BGL0xDVXB0Zkg0NjJsaFBt?=
 =?utf-8?B?bUVhYUJtYnBoZ1RkbXVTSWhyOEZIamFqelF2ZFo4czBDejBqUjg4d0ZTb0VC?=
 =?utf-8?B?WEtQZ1hGcnNRL3kyN1RkcDJjL0tNU2ZzL1Y3ZlRTZnlYcEwvRTFUNnR5d0lv?=
 =?utf-8?B?Q1R1QWJlQWZjR0hqMTdXWFdhZGpyQWwvN0hEeVVwUUgydjZiYXUvbTdsMVF2?=
 =?utf-8?B?N3YyTzNPSlN2ZHhya2tmb0NjU3BTdnBBNVArdDZhcWhKQ2xaMkhaZ3FuTmJ1?=
 =?utf-8?B?UEwzSHBzdnVzWVFpOFF1bFZYRmpsUG9KR2xOUG0wVlc1VlJZU2h6Y0VLMEMz?=
 =?utf-8?B?M211dTQ5bVNIeWRIN1NJTzZFdkE3UDRZL2RoS2lpOTlCQXJBQTJFM1ZON2Z0?=
 =?utf-8?B?ZDhPL3FRaUdnR3p2MGhidFlQRE5CRE5tNFY4RW1IRXBRcU9XdUswTTBaNmlL?=
 =?utf-8?B?cjdFcDR5SHBTWnV5a3UxbWxoaHhqNHJzdDJHVGVPYS85V2VIeGQ2OWppYUVE?=
 =?utf-8?B?Q3E2SGxJWXJ5K3QwdHQ3Q2Vab1IzdUgyVGVveG9Ud0k4Y3d2b2w4T1laYnJh?=
 =?utf-8?B?d2lHR2lxTlpidnBUMy9NcklCemFkeTNqbVhUQXl1MVJyRml4cFF4UTJtZnlo?=
 =?utf-8?B?YXRDc1AybzdSY0RlV3dFWEZJazVybmVMc2FOMm5qRUY3bWwrQ1RvZUZ3S3RO?=
 =?utf-8?B?ZGorZUdsOWFFVTREU1NCZjZ0T3FSNTFRcSt1c25uaWRKeXJVVWd5Z2Y4T29L?=
 =?utf-8?B?d21uVGJCYytRcHZ1SWhJdm01emhmNVl2S3U0QlVCdUV1Z3B1ZzBHaVlOUW5Q?=
 =?utf-8?B?eG1MbDZqNzM4S20vMFNEbmxTRUpFVHM2T2NYdlZOSi8zUTZrZE44dElKSHpM?=
 =?utf-8?B?RVVxN245R0hEV2RkVkJYK1dTMVBNa1hNbHVsbWxMdGwwbUhObk84YWpyMFhu?=
 =?utf-8?B?Q2lUbFhIUDVuSDFadnRsaTNyRHpsNXFFY2dhWjZ0ZHFLWXlRcDZ2OFlrT2ow?=
 =?utf-8?B?Y2VuRnhwdHlYZ3VpRUZ4dnB3UGRtdkpNWnpoQkxiSW9TdjR4U2hpa216akF3?=
 =?utf-8?Q?LWlCDCZAnv6DZIYmzBqB6yKwN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529baa84-ca94-410a-76e5-08dc6544e688
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 16:29:37.9031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MEglyx92w8Dwn7Hi7g8parYuQzAkfni8gqWjsiAQw+yHICzVtTcFashFjsv1xu0r40TE8qPNCsTx37NmKzqqPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8026
X-OriginatorOrg: intel.com

PiA+ICtzdGF0aWMgYm9vbCB2Zm1fbWF0Y2goc3RydWN0IGNwdWluZm9feDg2ICpjLCB1MzIgdmZt
KQ0KPiA+ICt7DQo+ID4gKyAgIHJldHVybiBjLT54ODZfdmVuZG9yID09IFZGTV9WRU5ET1IodmZt
KSAmJg0KPiA+ICsgICAgICAgICAgYy0+eDg2ID09IFZGTV9GQU1JTFkodmZtKSAmJg0KPiA+ICsg
ICAgICAgICAgYy0+eDg2X21vZGVsID09IFZGTV9NT0RFTCh2Zm0pOw0KPiA+ICt9DQo+DQo+IFdo
eSBpcyB0aGF0IG9uZSBoZXJlPw0KPg0KPiBJdCBsb29rcyBnZW5lcmljIGVub3VnaCB0byBwdXQg
aXQgaW4gYXNtL3Byb2Nlc3Nvci5oIHNvIHRoYXQgaXQgY2FuIGdldA0KPiB1c2VkIGVsc2V3aGVy
ZSB0b28gaW5zdGVhZCBvZiBob21lZ3Jvd2luZyB0aGluZ3MgYWdhaW4uLi4NCg0KTG9va2luZyBh
dCBpdCBub3cgaW4gdGhlIGNvbnRleHQgb2Ygd2hlcmUgdGhpcyBwYXRjaCBzZXJpZXMgZW5kZWQs
IGl0IGxvb2tzDQp0byBiZSBzdXBlcmZsdW91cy4gSXQganVzdCByZWR1Y2VzIHRvOg0KDQpzdGF0
aWMgYm9vbCB2Zm1fbWF0Y2goc3RydWN0IGNwdWluZm9feDg2ICpjLCB1MzIgdmZtKQ0Kew0KCXJl
dHVybiBjLT54ODZfdmZtID09IHZmbTsNCn0NCg0KQnV0IHNpbmNlIGl0IGlzIG9ubHkgdXNlZCBp
biBvbmUgcGxhY2UsIEkgc2hvdWxkIGp1c3QgZG8gdGhhdCB0ZXN0IGlubGluZSB3aXRob3V0DQph
IGhlbHBlcjoNCg0KCWlmIChjLT54ODZfdmZtID09IHNwZWN0cmVfYmFkX21pY3JvY29kZXNbaV0u
dmZtICYmDQoJICAgIGMtPng4Nl9zdGVwcGluZyA9PSBzcGVjdHJlX2JhZF9taWNyb2NvZGVzW2ld
LnN0ZXBwaW5nKQ0KCQlyZXR1cm4gKGMtPm1pY3JvY29kZSA8PSBzcGVjdHJlX2JhZF9taWNyb2Nv
ZGVzW2ldLm1pY3JvY29kZSk7DQoNCi1Ub255DQoNCg0K

