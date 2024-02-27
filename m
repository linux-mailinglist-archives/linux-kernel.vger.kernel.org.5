Return-Path: <linux-kernel+bounces-83452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D3886998F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726541F2C244
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40DA145B1D;
	Tue, 27 Feb 2024 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJt4vnRu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2C054FB1
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045782; cv=fail; b=H9S/xnVMZKgE2NfxNOABLqnGF7hoBK2ho6RvI/X1YI2bkwiA9YiYiFWYr/UNOi/S1XoHxon6/Ij7oyajqkm2JM/rLKrA117zLrHCuK2/NZDSIQRHoCK4ILZreM+7P8QKztEIhHbvaNUjhBcww/S8ReTNkYhAPrQ5/0jixrjOGQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045782; c=relaxed/simple;
	bh=n5orQ9FVPda5Pf9nLRV83UMPwU1Z1XmWf4lK2+TPG7U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IOitYbERrAo3AsOClmbcn4fLf4RT/qTDu12oLHRsWM2/XaBZmYr04jdtqVwnbWxFjnWWfZAPDRRrXWVM8TPThT0wFPhqoAMDGVmNFrsMgcVzXNrvH/KOVOWFXHwzTfNmGiqC9LCLtxfs+XHnYZCzJ6+ULwpoDeJp51XffhxMauY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJt4vnRu; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709045781; x=1740581781;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n5orQ9FVPda5Pf9nLRV83UMPwU1Z1XmWf4lK2+TPG7U=;
  b=EJt4vnRu7thbs+y+R3Q6z5kpM7FptCSih9szrSiKFaThT5h725Xe2ejY
   TEWMYPkQUxLV0X76hSKTfFzk8sVft4Ps/9KQazO19OyNkp83+WD11NHB1
   cMYDRU9sPWY8x6WeYuzXhnIBvaF7p91kZ9OIadwCnhjreXI51eD3pBIzw
   Y3tFBK8KY2uDQtdqitEcQSAqVGHSxLo10m7vTD1QFJXtJK4smYpSrrQl8
   +8NRKF2EJr36Hv1bZdBO0W7p2mWHSZzj1ol5u6y+qTnPsTSMYBzB8l0vK
   Nn/yFtWykAYGsGlQgZHIwDNyvf0xMEbxG96FG7Nac8mncZ+hgELS+kfKZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="6337398"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="6337398"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 06:56:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="11822468"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 06:56:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 06:56:18 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 06:56:18 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 06:56:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDBVdMmOPara8AU2j3kcakdWfwTwR8u8Qq6BXbPadmoB0gse2UaksXWs45ZWRN4m12a2bUqmiBepLcHgTudQ2uJ/yfQ25AXTwly9XxZsxFc9an24WLXLldn68XGyJoaHZHXM6gNVTnArwrqj6o4aAhokvM3jyT60RA7sO3Z7Z6PmM99oJ2hDRE5G/EgBgtRjPuiTrwrjzn3Yshe9gEytOsTZqTCqGFKtKnuqk8h/8lV7rdM/mgKdpmK+5H3FU3ILUm6BnA1q0THkkVvcmrp2uBLwmIdGaJ/nH0g9VQjGqLfyx9uYyuT9zwvymOjehHOERysWjkGeGCgMgTLRMwHOdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5orQ9FVPda5Pf9nLRV83UMPwU1Z1XmWf4lK2+TPG7U=;
 b=USZ53J5eiu8ehHYTGSc9NVvBN+8gOG4ZsLuanRlD6qgQlb6q7QCWLiin/RvsrF6J8Ionj3t7ZrBh/cbHdk4X8aQ6iT1IqFfjVm/TmuFo4U61zEdY2/ttS7IVqW1FRK7sHn5rJhwJxYgcwnkotXDX4/MOZ/DigPbh72AghXYqBJzUPakZk51NlV4ZjcdpfSwQmloJIYGA7magvmLAJFin34/uWL/Rb/XLXG0ctfej1dUKbiihBuVCyo0AHMatzFn6xscSza/NIyGC+1Gt3DlvoxywvuWjfLc64HQZR9ZO/iG+CEsDVDGfKcWE0uzJFi/rrTs73noc2Y1DMxPu4GQJPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 PH0PR11MB4997.namprd11.prod.outlook.com (2603:10b6:510:31::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.26; Tue, 27 Feb 2024 14:56:14 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::4fbf:799a:f045:c981]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::4fbf:799a:f045:c981%7]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 14:56:14 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Williams, Dan J"
	<dan.j.williams@intel.com>, Michael Roth <michael.roth@amd.com>, Ashish Kalra
	<ashish.kalra@amd.com>, "Shutemov, Kirill" <kirill.shutemov@intel.com>,
	"Dong, Eddie" <eddie.dong@intel.com>, Jeremi Piotrowski
	<jpiotrowski@linux.microsoft.com>
Subject: RE: [PATCH 00/11] Provide SEV-SNP support for running under an SVSM
Thread-Topic: [PATCH 00/11] Provide SEV-SNP support for running under an SVSM
Thread-Index: AQHaUKVsbYupSzmAu0q3a+y4/e0Gj7EGmfkggAbmdYCABJIhIIAGeHuAgAXtkfA=
Date: Tue, 27 Feb 2024 14:56:14 +0000
Message-ID: <DM8PR11MB5750732DCF06F31E7A903E56E7592@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
 <DM8PR11MB575087DCCB069C723BBE1B47E7482@DM8PR11MB5750.namprd11.prod.outlook.com>
 <447b491f-ae1a-85db-a862-0a2b999cd0d4@amd.com>
 <DM8PR11MB575046453648C384A3D29020E7512@DM8PR11MB5750.namprd11.prod.outlook.com>
 <38fc0e0a-536c-3074-9c81-47362762ef59@amd.com>
In-Reply-To: <38fc0e0a-536c-3074-9c81-47362762ef59@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|PH0PR11MB4997:EE_
x-ms-office365-filtering-correlation-id: 0c542659-13b0-4bc5-6baf-08dc37a43eb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kcnh5quiyukxJn+6tKyvl63b9IFLcr6Z2kB15ZuJJhns/aZnlckPETY7r+am6swOtD3wxu4fxdfefvWnSlVAVMJrQ/8Aktq9euPK6hSBewwnrcjhwpPFjhvv/cNaCU0QDOBCSH9QXgq63iWY6oiz8JK+Iad+1KQ94i248tAxw0PqW+RR80ijcqf4WjZFCmCytlGY4tniQb13sVQ6ZJ5Gi2xR3paSjWnw9pipjrvBVr5KdDEps2u5/AJ4cQanR06XfMBg+6PiIsKVo8AQO85GtM2gDYDFOuqL0ro30mzyL9XFLf3iAD/he4KV5pkeQv+2Kher6LkD5/SKfZjC2oco/bb7EyHHofPJohWdNlCpFuAL1CmShPCXWAlITDokIgvU7GX+Zj5ro4BOnC3bqOzGYLeZXhlvU5Fyt9WDsRR1gASI/DnXmwWzdoE15fI+6/iaN5yjku63L/7uOd+wCbaL90SJdAAn7LkumYK+3rQ6d8d1CF9kAS7q6vSExU4IXvfSCCNcMGlI6X4abw0g0/J2eDCOfUjEr8WYxXNK2pqSIdbL1E8//VLdXCf3iPPs7Ryqv264s8fzj3WLMYPm2/pJX2SI6AwbhWCH4oLRWr2Uc07lRqyDWqS/+FN9dY3lFaToBtCwlejQCAmQLtEtmuNtxN98qfdjFFP8A+E9mSYH4ovDdGNRKahHZgN1LY/F6L+THkaCoV4gE9JEy/pJsBxt5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0l5amxKT0Y4aHpWc3hGQXEwcFhNUURPNjRQMlk3WStxQ0t4S1ZiMnlOVWE2?=
 =?utf-8?B?VjNRMC9lNDNQUHpVWk95dnFPaERDRGpqdW90WktvVENVRDNOZkU3ZXloYmxs?=
 =?utf-8?B?ODVwb21JNEpNREVYT2g3TmZSN2pEanEzVmJhbnVPUTViNGdmdjQzalhoekE4?=
 =?utf-8?B?K3NkMC9YQVdDOExsRS9HN3lpWFVqOGJIVnNvSUtDZFVtM0tLZmhMSTZSQm9T?=
 =?utf-8?B?MVVLWFNsaStacmpjTTh4SEgyeldpTHdlZnY0RDUvK0hYTlZDVXlpREsxQTVl?=
 =?utf-8?B?OVptRWoyQ0R5WWN4SDBzcHU3YnVzL1RvblIrU1M4b3dST1kzVWVCSUlMbXFk?=
 =?utf-8?B?R3lqaXkrcnN0bmJJZVN0K0txNkl6Um4za0xLRWFkNHF6b1FvTlNmbWgxRXV1?=
 =?utf-8?B?YXEzTHNmUythSDFqN2YyanFLSXFnSHVsMnhhNVFzVmRuTmk3R1VlQ25TdVE0?=
 =?utf-8?B?Q2luSHBCdnpKZEVUQytDcEZPSG90RDlzSmFGa2diS1VhMVQvWWVUT1FLeGhT?=
 =?utf-8?B?aktTbnVaY2NPRENGLzNVMGxZTXpxUTFBM1l0eG9wYVVDWFoyaWhza0lmWE9J?=
 =?utf-8?B?S29pYi9LODBjTFRnajR4SFZrT3Y1dDBiWmVaZXR4OE95dlc0UWFMRUhRSytI?=
 =?utf-8?B?UVNRNHJIRGNpUDRwQkdRQkZvY0FCOENUY1hlL0NnWS8zY1FBR0YzNEZWY2Vk?=
 =?utf-8?B?RDJoNjdTY1N0SW9OL050R29WMUFadnJNVld3MCswT2hUZ2kzMCtJZHF3SEFH?=
 =?utf-8?B?T0xubk11NFJNOTBieTludC9rcGMydzFwamE1bmZiR2FtaHBZT1RtVllOYnl3?=
 =?utf-8?B?K1Z3N2ZPOEZRLzRJZjdvd3RtQ2dWRUFrMENzSGdNZlJ1R09SUHZZaHdVVXUv?=
 =?utf-8?B?QzJ0MmFEc1JPR00vUno0OXlhYlNtbmVkcmNtTnhYR04wY0tqTnprZnQ4N05l?=
 =?utf-8?B?VnBLL0lGSFpUQWtkaFI1bElyVHVxamlVdFZpMjRTanYrNkdDRE1NS2NiREtr?=
 =?utf-8?B?V3R1NUpvbzB1eWZRdWZZdUs5dERYTnp3dGtNazNjczBsVS9VRmRDL1pYVDhq?=
 =?utf-8?B?WVZoUitHQkJCalI5QVJybTQvYjN3NlBLeVJ0NjJjNVV6YzJVUzZ3Mm8zRFdi?=
 =?utf-8?B?M3ptTkFNZnIxZnh2eUQwa20vR2J6Z1dQbUVBU3cxUkRZcVpXaVdsVlU5U2NK?=
 =?utf-8?B?cFhRK0h0TVh2NnREZmRnK04zSnRHV3pWdmVuazljdFZhVFhzUi9ORFYrVUEv?=
 =?utf-8?B?bWZtMzRza2NER0tYdjkzNThTeWtVSVNUeXRTM2dqckNWS3pnUlFYNUdBN1Jo?=
 =?utf-8?B?RUZwWWZkYURQUWR5VnJyWU0vZ2Vla2ZtZnp3YlEwaGJkK0JwS3d6cTVRTllI?=
 =?utf-8?B?c2pCWUlUeGF5dmVXbDlZZEdEUXFMcTRXOGxLY2VzcnUzWlNrQ0ZtRTB0NkJt?=
 =?utf-8?B?Z0liUTY4bkU2aFEwd1VXOTNId0Q1RmdmT1VmaW9rQ3NyTmk4UzgvWEh5SHBz?=
 =?utf-8?B?U2pRWnRGYWdyZFBNVTllcFAxdWwzdzBGVUhQQlFGSk1NcFEwUHluMGdZa2Vu?=
 =?utf-8?B?U1p1a1YwYktUR3R6L1J0ZDRVS2hXOXBoZWl5YzNhc1cwT1h6VlFTeFJMRFRm?=
 =?utf-8?B?Z3ltamYxZGN4emc1TkVEakRVWHFGTXRERjdCUWIrSGtMSmE1M2crbHRPd1kw?=
 =?utf-8?B?c0xOT09HMFNldzM4WkNBNkQ1dS9LU0twVTJjaHJwQWlhajZUQWxRQzcyc1p4?=
 =?utf-8?B?U3VqVisydXY5bUpHc092MklVNllGRmIrckRRYlc0dExYbEJCWWJIbExlRTFU?=
 =?utf-8?B?VzNSWWd2cUZpUEc0dE9PcnlncnIvSkd5a29QTWkwNXppYXJUakNQRDREbXFq?=
 =?utf-8?B?WUJVem9HR2p4TDd6S0tEeFBYSFBJS3JWRHlVZGxFb3J0dU1zSWVUMEcxbFlj?=
 =?utf-8?B?czRnSk1mNlYzeUVmTUsrSWZ6T25scmhkeWxuQzZpUzNyNDUwNy82U1J2UGJC?=
 =?utf-8?B?bGg1OEhpRFNTcVU3UDZocTRDMTdmR3NwQlJZTmlvOG1GLzRPNzJ2VWkrNE1t?=
 =?utf-8?B?NE4yZ3ZsbG1qUzNQTmg2Zm9kRWFHRU1Obnp5VXozVXhKQ0RGNXI4bkxGck5O?=
 =?utf-8?Q?Ga3mnOj60u3L0XnkNfCDnp7On?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c542659-13b0-4bc5-6baf-08dc37a43eb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 14:56:14.6166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JSleJpybIq19scRerm3VgNyU3NdJb8T+D0cJnpBW5k2h+iU1+BTDtDhvnQmzriWGpg0L+qlLwoRjJP2X1VQuLNhR81ycFCHC/Ln0BCr7WB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4997
X-OriginatorOrg: intel.com

PiA+IEtpcmlsbCBhbHJlYWR5IGNvbW1lbnRlZCBvbiB0aGlzLCBhbmQgdGhlIGFuc3dlciBpcyBv
ZiBjb3Vyc2Ugd2UgY2FuLCBidXQgaW1vDQo+IHdlDQo+ID4gbmVlZCB0byBzZWUgYSBiaWdnZXIg
cGljdHVyZSBmaXJzdC4gSWYgd2UgZ28gd2l0aCBvcHRpb24gMiBhYm92ZSwgdGhlbiBjb21pbmcN
Cj4gd2l0aCBhDQo+ID4gam9pbnQgcHJvdG9jb2wgaXMgb25seSBsaW1pdGVkbHkgdXNlZnVsIGJl
Y2F1c2UgbGlrZWx5IHdlIHdvbnQgYmUgYWJsZSB0byBzaGFyZQ0KPiB0aGUNCj4gPiBjb2RlIGlu
IHRoZSBndWVzdCBrZXJuZWwuIElkZWFsbHkgSSB0aGluayB3ZSB3YW50IGEgY29tbW9uIGNvbmNl
cHQgYW5kIGENCj4gY29tbW9uDQo+ID4gcHJvdG9jb2wgdGhhdCB3ZSBjYW4gc2hhcmUgaW4gYm90
aCBndWVzdCBrZXJuZWwgYW5kIGNvY29udXQtc3ZzbS4NCj4gPg0KPiA+IEJ0dywgaXMgY29udGlu
dWluZyBkaXNjdXNzaW9uIGhlcmUgdGhlIGJlc3QvcHJlZmVycmVkL2VmZmljaWVudCB3YXkgZm9y
d2FyZD8NCj4gT3Igc2hvdWxkIHdlDQo+ID4gc2V0dXAgYSBjYWxsIHdpdGggYW55b25lIHdobyBp
cyBpbnRlcmVzdGVkIGluIHRoZSB0b3BpYyB0byBmb3JtIGEgam9pbnQNCj4gdW5kZXJzdGFuZGlu
Zw0KPiA+IG9uIHdoYXQgY2FuIGJlIGRvbmUgaGVyZT8NCj4gDQo+IEknbSBub3Qgc3VyZSB3aGF0
IHRoZSBiZXN0IHdheSBmb3J3YXJkIGlzIHNpbmNlIEknbSBub3Qgc3VyZSB3aGF0IGEgY29tbW9u
DQo+IGNvbmNlcHQgLyBjb21tb24gcHJvdG9jb2wgd291bGQgbG9vayBsaWtlLiBJZiB5b3UgZmVl
bCB3ZSBjYW4gZWZmZWN0aXZlbHkNCj4gZGVzY3JpYmUgaXQgdmlhIGVtYWlsLCB0aGVuIHdlIHNo
b3VsZCBjb250aW51ZSB0aGF0LCBtYXliZSBvbiBhIG5ldyB0aHJlYWQNCj4gdW5kZXIgbGludXgt
Y29jby4gSWYgbm90LCB0aGVuIGEgY2FsbCBtaWdodCBiZSBiZXN0Lg0KDQpPSywgbGV0IHVzIGZp
cnN0IHB1dCBzb21lIHByb3Bvc2FsIGZyb20gb3VyIHNpZGUgb24gaG93IHRoaXMgcG90ZW50aWFs
bHkgY291bGQgDQpsb29rIGxpa2UuIEl0IG1pZ2h0IGJlIGVhc2llciB0byBoYXZlIGEgZGlzY3Vz
c2lvbiBhZ2FpbnN0IHNtdGggbW9yZSBjb25jcmV0ZS4gDQoNCkJlc3QgUmVnYXJkcywNCkVsZW5h
LiANCg0KPiANCj4gVGhhbmtzLA0KPiBUb20NCj4gDQo+ID4NCj4gPiBCZXN0IFJlZ2FyZHMsDQo+
ID4gRWxlbmEuDQo+ID4NCj4gPg0KPiA+Pg0KPiA+PiBUaGFua3MsDQo+ID4+IFRvbQ0KPiA+Pg0K
PiA+Pj4NCj4gPj4+IDUuIEFueXRoaW5nIGVsc2UgaXMgbWlzc2luZz8NCj4gPj4+DQo+ID4+PiBS
ZWZlcmVuY2VzOg0KPiA+Pj4NCj4gPj4+IFsxXSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMy8x
MS8yMi8xMDg5DQo+ID4+Pg0KPiA+Pj4gWzJdIE1TRlQgaHlwZXItdiBpbXBsZW1lbnRhdGlvbiBv
ZiBBTUQgU0VWLVNOUCAhVk1QTDAgZ3Vlc3QgYW5kIFREWCBMMg0KPiA+Pj4gcGFydGl0aW9uaW5n
IGd1ZXN0Og0KPiA+Pj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3Nv
dXJjZS9hcmNoL3g4Ni9oeXBlcnYvaXZtLmMjTDU3NQ0KPiA+Pj4NCj4gPj4+IFszXSBodHRwczov
L2dpdGh1Yi5jb20vY29jb251dC1zdnNtL3N2c20NCj4gPj4+DQo+ID4+PiBbNF0gaHR0cHM6Ly93
d3cuYW1kLmNvbS9jb250ZW50L2RhbS9hbWQvZW4vZG9jdW1lbnRzL2VweWMtDQo+IHRlY2huaWNh
bC0NCj4gPj4gZG9jcy9zcGVjaWZpY2F0aW9ucy81ODAxOS5wZGYNCj4gPj4+DQo+ID4+Pg0K

