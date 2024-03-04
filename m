Return-Path: <linux-kernel+bounces-91393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D148E8710E7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5A01F22EB8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204BB7D088;
	Mon,  4 Mar 2024 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eN41Ycvh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969AC7D062;
	Mon,  4 Mar 2024 23:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709593665; cv=fail; b=ShSx+yFCZ4OLcsaFTp1V7VupMHXcLBHyItASLu+2hE/YKl6WyzRNrICit27Y5Zp/vKtzPG9O/KAE/GiPcvUbWAmDvC5NsqySDwu5akFr1RpkQvXycQnpY74OELVVYFXEVJa8mWX16wgxliZooPGDs96Q8oUvt9wV7miHsb+H8wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709593665; c=relaxed/simple;
	bh=osj7Y+jtccifW4Ns9dV8Ap4u+Z/Dkm8ZmkMsf+5NU8I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WRYwVaq2nHjxo8YIwDagSNb1zCY/JIMXq/LuEJdiWdypO/0ZQLECwkb1xIsOX7wr9fTxNzFK4AuNiidLR8xPxfKKqDunJW9kyuxzdo5fdQHUoRgNqLeibtUFClvR9HquK2vJP0vP9YoYHRXvJ518MRXGi40s8j8KwLJ1+TxmuRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eN41Ycvh; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709593664; x=1741129664;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=osj7Y+jtccifW4Ns9dV8Ap4u+Z/Dkm8ZmkMsf+5NU8I=;
  b=eN41YcvhiDRA2fOFTg2PjoFuFAZKsgR2YBTqYV04l0UkWhaNIEbV1Gog
   YPpZwWg5jnqHtOlgWwLPDHPzf+YwU51DtQ/p6vxf0Dp6Bbq9RtAuv3Bkv
   vB+xJN6Ty3apk2UNIQYOxECi/K6mooP9UWFAFcppaDR7vfkim6m2hgM0b
   806f5puRSP4eKtYw4kdEOXErrFCk3SfXfrosp6PSR3helnWtt2k1u6+NS
   C7lcWeMRwiwhNCMnGIIGdhM1hXZx5Pi3UGxegvE9C+jvgtgGPJxfd5Y9A
   3PY2T9G/zavGZdlGAGqcsTfjJh5WnRswPIUecnr/KVl5JMcd1T6K7W910
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7060198"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="7060198"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 15:07:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="13831484"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 15:07:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 15:07:42 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 15:07:42 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 15:07:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS3iG0awX9ukLF006blTncmtc5SYtA3IjDdUt9U3UGqHktqQmCZ8i8sx7vwgCxEjTp/dD8DxkUdKUhYvfCZlrAc/ASOblkwGZlWeUsYXBWMYrpTpU6AKjj9Fv+tvdTnEPMLnJ/UIizkl3jslMrIUcuUj+H+Sk1CqdYyaMYpZChJqQsg7Gk7NAauG3Pd7WSoqEEsaUXemYlrQZf2JQ+8WXVjzDlGsagtJ/cokHvVFgrRpmPcCQCFXVIKz3rjJzI6CTlG5n5TT6VfP89Ybv0CmdP0RwOLjHbGjHyAWzOjxDBj2AEC+oKH47xUNlDBc06AneFxs4CF6C3P0ep8VsfRgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osj7Y+jtccifW4Ns9dV8Ap4u+Z/Dkm8ZmkMsf+5NU8I=;
 b=fy70rNi1n6yJyfOJGPVlxAMBf3QD7d5a4bjxIxczxEhVfGg5nqxOBidjufclLJHqMZiZmg9zx9wpFTPfUe9mXH9laGVFZokEMC1mfyGC6zl3H1JgLDwJeHH2ogPSHDrsGwBZi3uHnGroiVVan5tAjUTdjVj6VVaS10mFuAFum677dcxzEze9WPNOr18+RcS61kKxX2Ff3z1iu0mNuGDzAS5gipWVcZ36FTCgQ7P82XyHUUDQ6kuUrdExPax2mdm7VMxvXGXdoxPqXfbt1jbW2cfu/ZW85ISW6srxQDl5EdChGfbuW7anL4EqVYSP2kgEIh0UTnmz5ELKlUqp4fyH4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6074.namprd11.prod.outlook.com (2603:10b6:208:3d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 4 Mar
 2024 23:07:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 23:07:39 +0000
Message-ID: <b11c545a-7bf4-403e-99cb-38db777fd8ab@intel.com>
Date: Mon, 4 Mar 2024 15:07:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: Cover-cover letter for two resctrl patch sets
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "Peter
 Newman" <peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, <x86@kernel.org>
CC: Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
	<james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, Babu Moger
	<babu.moger@amd.com>, Randy Dunlap <rdunlap@infradead.org>, Drew Fustini
	<dfustini@baylibre.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <patches@lists.linux.dev>
References: <20240228112215.8044-tony.luck@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240228112215.8044-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0250.namprd04.prod.outlook.com
 (2603:10b6:303:88::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: aed69825-74b5-49ff-9304-08dc3c9fe356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LvGg/6Ryrp7P12/qG4vdmpllJe6UEoCh2yWgzUDMSGoqSl8/o/O3vo7j1dT5pT3REaBcXDQcZ8sq510aEaa80OYAIMlSlj4PldsXstCez/ml7g5nDJNSfjCmgsgoAHDtkQTY+Hs2yBkYskhfhtQimJLo/2wyjG2BigTcQ62wxZtSog8PvtfxrQnklD0HQAoLOTDXj/rMNoN1ZTwEtgy9RSjsNcZ280Xvv9RyALA+UrBYar3Lcm7DhRVx1PsPdS6MZTJGLdPXMrSnvKflrxdzBAZ94/N39CFN3jvEw72cK3hPJI5XUPq12FQUGQgYGewlV2TH/NFF8eBD2JfVayam8KC0mW51aPiUt1fcEccUJsGGBstCQvz/FZXMaz+oCtq9qv+fHOZwA+czpG+3ut9FHroaDlYXEhah/fTAa86IunhuHt/YCXBqIWwiFJ7b+S+eWygUg7MML50OFQJAK1cMgq8Ava+ebNslcZRh8UxlD4sMu+17n5F3OiGpICAqGdIQiVWPUczP3IMDhO9ENWDsfW1JDE8bQGRvdTA2bJYPofk3EbBLUmi/jbRVYWcU/IYweXwPYezqh4skoOd0DonBHrM6uasL+lo0I0iXW+MjLCUGueZXud0m2ktE2HG0Krkme9N4oNYTBFqW/nM0+fM3j1sTWQppP5uzJBXt3nGjIWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0d5MTlsOHd4T3R3U3lXckNFOWlDWDFHVkhkNzQ5S09WNXpnZFRXeGhRZkRY?=
 =?utf-8?B?SXhpZVU3WXliSU5uYTZyc2RTUUhLVjJHMG56dkhwSFE1c1cxdWJON2RzVkFj?=
 =?utf-8?B?L3hoR2J2SU5oNFVQeThFZkxDY3diKytiWEZ5MXd0ckdhdXd3cGRNTFZqZCs3?=
 =?utf-8?B?OEoxTGFPbUtsaHp5MUNER05oYndtaEI1aGJwSHduOXY3b0paR1Z2VXRSbEEr?=
 =?utf-8?B?RFB3cUhyMk1KUFphbjVHTUR5dUJITzZucFJnZHVNNHhWSklkVll2Tyt5RWR5?=
 =?utf-8?B?NER2M3FIczJtUzZ1NGo3TG41SExIeGl5L2UzTHEwMlg1MHJ1VUxFcVlNUGtP?=
 =?utf-8?B?NE5YYzFQSU1IMHEwVnlQK0xtMVdUQ3IwSUVuT0tVdXpmSUtLdFRETG45b0Fn?=
 =?utf-8?B?TlFLTGxBOTc1TDlhZDFYaEo4Umo5amZPSUx1RG8wbTF4UTQ0YTljWHRnTjBH?=
 =?utf-8?B?U1JmTmlhTGp3NjJhZ3J0VWlpQms1Wi9UYWZHcmJIU05leE85SUhqaDZDcjhw?=
 =?utf-8?B?MDFyUStJdk4rTzlwUFJBekF4eVltc0Q0dVpYUE5TU2Nyby9JK1dMaVI3RGFN?=
 =?utf-8?B?OWZQRThSQU1NR1QzR1ZtV2VCd0JTUndkZ2k4NkJ4WGg1amx4VWpUdHBGc3Zr?=
 =?utf-8?B?Mjdib2RPcEVYQUtaOG5Ud2hYTHBMYjFEeU1OdHk1L1BrTnhrNG9ST0Ywc2F1?=
 =?utf-8?B?UHBlbWM3ZzVUOVA0dHJ0ZWxDVzdMaVdMRkVuTVhnTTlZR2ZCVVAyaTZyUUhY?=
 =?utf-8?B?UnRzeTh1QVpYM3plR2tVSDNWS2hBR0tySDZUTy9RSWxveDlVQjRBeTErYlBv?=
 =?utf-8?B?dTNxNW1BMzIvclhuc2xJTmFnRVpOMVZ1amo5cGQ4T3BiQ1hyOFBzdnpTa1B2?=
 =?utf-8?B?TTlHTVdUZXg1ZUtXM0dBTE5HRHJoVHJKS3V0UXdtWThoeUZraGxoTm1qdmR2?=
 =?utf-8?B?UGswYmpvTnZianJpT09GNWVFVmNEbjdkN3hSbUg2L1dUL1FGNjZhTEl2TnRM?=
 =?utf-8?B?TVBuMlhSSFFUcVB6ZGV0UWxWRGUyZkp0NWhWR2JDTTdjZG5oRkxBeGhsSGcx?=
 =?utf-8?B?OC9WMmNWS0syMm9tZkxMU0gyN05pblFIV056SXB6TFFtNVpRWnVpTUVDOG1k?=
 =?utf-8?B?c1YweTZlYzQzaml0TjQzaEZhZVdCQjZET090M0dMSkVQSjBydFhlWWZzbmhU?=
 =?utf-8?B?Z0RaUjJpVFNTL0VSU3pVY202bHBPS3NLL3hFYnlVb3hmbDRKOWQ5d1U4MHhQ?=
 =?utf-8?B?dGxJNTBMZVl1dGVON1o2UnFnRkxFNFJhaHlIN0k1K2F0aUxzYk9nblAyb0tG?=
 =?utf-8?B?ejJOTURyNFhmNVJhVVM0L2Via3EzZlk3Y0thWkVNOTJ2cXNRSUNRMVcvU1d2?=
 =?utf-8?B?bytuM0lJWFFUTld3Mlpoa0g4L29Lc3gzTWNQbmN5c3c5cThiODVzaGwySTdp?=
 =?utf-8?B?UE1MMk5LYWl2ZDVLaWxPUy9GQk5NaGdPRG1NWjBqQXZDaHp6SEpCbE4xT29x?=
 =?utf-8?B?ai96YVRaMzR2cW1LSkgzK0c5cTh1eTNNOURFa1NMRElBMHBVN2VSTWVGbTZw?=
 =?utf-8?B?ZFVaY2I4K3B4T0RkbWVDOHR3b2c4MHg3NXo3ZzJDZEZmUUxlbDhTM0NvRmdB?=
 =?utf-8?B?KzVZZlEwYU1HTkt1QlhjbzJ3NmxBdWlqblhYRS9JN1Z4cFE1bGlvM3l1WEFJ?=
 =?utf-8?B?MDlGczV0bWhDQ0N3K1FWaDU0Z2RBazVXMWdRSWM4a2FNbnpvTFNhbVJkVHlk?=
 =?utf-8?B?T0M0cW1ZTnF2ZitXUCtpN1ZWSjg5Y0dQM0l2VFBpUU5IaEdLV29aeDA2TzZS?=
 =?utf-8?B?UHVHT3dFRm12dmgzQjV5d0tOYkxNSFVFTWM1V0Q1VDlDeDhBM28xVHAxTEg3?=
 =?utf-8?B?Z2YrQlJ2dCtNS3JXYmQ1bU40bTdScGVEY0QwRGpzOXlzZ3hlT2c0QVFudmZG?=
 =?utf-8?B?YVFVUGFDWlhka1Jlcm80VFhkRUhuUzBvNHgxY3N2eGtXdzA1VmxaL3NzTW9S?=
 =?utf-8?B?Z1BJenh0QkgvVTFUWkF1dnRwV2g1THJYQnpKc1RLRXQ3azlvZ1FaUEZ6dUJF?=
 =?utf-8?B?eDdyUE1NQUxwcG1yZVdHNGIzL0podEY5QUhnU1J0Y3UwUWVySC94ZkRjNTVz?=
 =?utf-8?B?SkJzOTBWTXBhaGdVZ1R6cGQzZkJ5SFh4TjFDSkJ4eEVvaXBGZGl3Zm8rd29s?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aed69825-74b5-49ff-9304-08dc3c9fe356
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 23:07:39.3269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3w7hp/gGSYz/fVTFoqZu7yGOVuKmOk7Oaxi60vD/6yySLJDfihnXXoc8Alx/0JEwKOBG5hZd3VJxx4EQGc81UGC1No6FNf+KU1KrFaD7Ty8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6074
X-OriginatorOrg: intel.com

Hi Tony,

On 2/28/2024 11:36 AM, Tony Luck wrote:
> Hook these two series together in threaded mail clients
> since the SNC series is based on top of the two patch
> cleanup.

Could you please instead send the two series separately
and note the dependency in the cover letter?

Thank you very much

Reinette

