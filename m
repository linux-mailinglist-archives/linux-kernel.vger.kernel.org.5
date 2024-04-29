Return-Path: <linux-kernel+bounces-162650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05F78B5E94
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9250AB22AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6079B84A58;
	Mon, 29 Apr 2024 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kv8LZXal"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A208283CC7;
	Mon, 29 Apr 2024 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406758; cv=fail; b=TgqkkPxdOyXqAwZS7ESqcT+ygkgs56Y6Ohi2D9GdiB0sf0IKntBhH04Zne1q13QnuAkZpRncDvIPpI3SnlPWpIzjz2I4M3vydaDsdp0NYTjH+H2iHECND8DgWEOb8bdnWRvrxK8qUc8qDF/bzhNlXQndiM4CnAQwHS+96c47elw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406758; c=relaxed/simple;
	bh=86Z544Lui1nCwFqA7ekw+BsXL0gxd/6LlSRmZMivA+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dmcSdvxS02Id2mlTTkiwb50u86hWeisTS/Aqj6dS1roJJn1GAiXXeVqJdTH5ivW+4KK2XfrZ+Jdsk1rz3/FV+5dEg0AZ24G+SQ3o00ceZQo1VvRD3gK1brJ/yeGzXVznbz8ZMX+0aB1hdgukqrJ1G9L5F9uX8pkt89ClhBAL4QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kv8LZXal; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714406757; x=1745942757;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=86Z544Lui1nCwFqA7ekw+BsXL0gxd/6LlSRmZMivA+Q=;
  b=Kv8LZXalbhJeQ2Tcxbj4OL+/orBxgcPYNZf84RD9tnVWnDi5CcZhwexh
   cNR1ziK6n1i+wrID6S1JsdC7yc9wv4anc7Ffx26SA/nOcyPSDTP7FSURJ
   Ih9iDaouOML0Ns1HCRur6oHoT9hzTufDv5p5dNdutKiqmllwyznPTOMI+
   KJdznBrLnjydvnPFoEXSRWLUdmiZDmX5muMXEm0t2VelzTtAAmc7IwbB/
   lOrrJYvwEqnGjWJzvNHBlUgK/p4bCpjloVk3QEVrGgnI0rx8Mdj1uOGWk
   DlcYYZyGTZ1ye876Q0f3/QRSHlcHwJfOwnxUkrv0kLSXB3Yc8toEz+jBR
   A==;
X-CSE-ConnectionGUID: /pJSXMuuQIanzghH2XSTBg==
X-CSE-MsgGUID: VUVA6Yq9R3K/laJ2/XxGbQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10242374"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="10242374"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 09:05:56 -0700
X-CSE-ConnectionGUID: srBJtQ8YSS2Y8ucPf1/yIA==
X-CSE-MsgGUID: pfuqO7ILTBa9mgaOPcgVew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="26145197"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 09:05:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 09:05:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 09:05:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 09:05:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 09:05:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCLMPxep5MiZ8ONN8DpI6SxgHVK2Tn7m16mWMAbnY9r8aMgn5DBcoG4sn24LoJEunEyox3+6JG9U7TFh/T7HLnkp/dx6OF6f7/SMNd44Bek+8nr0tNeQ34vA55wNz0u7pnS423RVMTZyOtWikwmT0XlkEtmgTIvZEqf/zhioSDom1bpPa+8puJshIimQPs2h9vCqzf7jpY94qqSZL6v/x2O23li6UFE7ySew3cL6INEMUOf+P/vc0YR7jnAk/X3VJcy7ZQckuf/TqPaQ7DOEBV1a9PhQEd2ANrxmcwXP+p5dp3siZtEgT7DUStWrRwBg69Z/7jMBwJT42/CAVklxRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86Z544Lui1nCwFqA7ekw+BsXL0gxd/6LlSRmZMivA+Q=;
 b=gNN1DuxPD1JWzKeEPuRCnz7F0FzO5ZC7QOsYEHrr5SZam3HG9s8jly234vKvMKn/wEgsG6DcqBho54QbZSlY2ee/k8SIzUr5ftka/5lJcoBuTK7hhuyQFaRQPNx/rmaA301wsj9PBTfB0ilFTIl23q1+/Nnz/qCWuMGIEgPFaI2hvX7affuLj1qCRrg1FLAbeoSgf/QK5P+Vjay2siEF9n5URqGjil5QZKc5KpifOR8g0Gz43i3qdyT4AfVC5FEGrfbHeiIe1WNH4CiH0MZUjNt3fIt8Ebcn70EnW8K+W+arriiKMd0jnttc7Fc3pwOcO31l07mP7WBqTIecUOWeng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY8PR11MB7034.namprd11.prod.outlook.com (2603:10b6:930:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 16:05:29 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 16:05:29 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] x86/cpu: Fix thinko comparing x86_vfm with x86_model
Thread-Topic: [PATCH] x86/cpu: Fix thinko comparing x86_vfm with x86_model
Thread-Index: AQHamdvm41QbPN7kwE6OH6A4+BbNL7F+6RcAgACAoBA=
Date: Mon, 29 Apr 2024 16:05:29 +0000
Message-ID: <SJ1PR11MB6083B53C58D36ADB74C08AABFC1B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240428183142.GHZi6WDu5nbmJJ_BcH@fat_crate.local>
 <20240429022051.63360-1-tony.luck@intel.com>
 <20240429082242.GAZi9Y0uK-e2KGWxmX@fat_crate.local>
In-Reply-To: <20240429082242.GAZi9Y0uK-e2KGWxmX@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY8PR11MB7034:EE_
x-ms-office365-filtering-correlation-id: 0601c588-d416-4657-931c-08dc686630eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UjBmLzdoaWpzbVREcGEveW5nc09renBwaGdqMFRyY21KQnFkN1h1SVNTa2FS?=
 =?utf-8?B?MEo3UmpzMWxybTdNVzlqTnJTcm1yOUFUd3ZTSnRvTmUzeGJOSS9zODM5VWZT?=
 =?utf-8?B?QzhYekdiOUkyOVFHVks4b0MzWjVHRnZyTDBuMndZVXg2NFBPdVdsTVVXaWZk?=
 =?utf-8?B?MCszWmNGVkJpbkRCM1RiMzh1c0ZFQWJMQVFsLy8rL3orTG84RjU2cXkwcmla?=
 =?utf-8?B?a1BJU2E4dkZZb1BEbllZM2xubi9WYk5TanIvY3hTT1hveTE1UDNhY29KSlJD?=
 =?utf-8?B?YXhWaWUydXBzTTcyWGpoUVVkT05tWUJ2YW9BOFZ5ekZ5OUt3c3FVN1FERXBD?=
 =?utf-8?B?YkVtUkJHWkY5clRkTHExYnlweGx4Qmx0bjU3RHhnYW9GRWtOKzhwSkMvYzRX?=
 =?utf-8?B?MlNFTHhzNHFUOXJ2VE1BZFdBWDJmei9kOUdEenJCMEJSRktwL25RYnNXTkQy?=
 =?utf-8?B?dUlpNkdSckVZeWdiZkNyTGJySyt5MlFTa0dWWWd6cm5IejdHMGk0bHdvVG4z?=
 =?utf-8?B?Q01rQkxrelRUcko2Qk5nY055Z3VsUy9zOXcvUUdtWUc5YWM5YnhGSmV2RjBJ?=
 =?utf-8?B?NU9ZZlAxZk1adkNKRmprajhCZzBsemM5QzhJMjd3YS9wek9CTDU2Z1IzZWlI?=
 =?utf-8?B?UzUyN0kyTFNYWmJ6Sk1BcWNxZHVrbEJCbGgwOWxzVEpzaWRYNzl0QWRhYTMx?=
 =?utf-8?B?NlMxZGN5MDJmTE4rSWl5RGJuTENvemxReDdTOTNXYUhBK3FnbTh1aVpWZ1dh?=
 =?utf-8?B?ZE40UzNNRDJicXkxckZyM2VNTkIzMmRURVcvVkhKdnZMSmlBaWV2SnVoM3lX?=
 =?utf-8?B?ZW5YOVQ4ZHlueVlpUUNLNVM0SWR2aHQrNEgvcGxRSGYzaHh1T3I1OUVTV3lJ?=
 =?utf-8?B?QTBJQXVSK3U4YUZ4ZEpPa1hOT1hYZzBTaG1hSHNtVSttNVpFLytPdXB0SUx6?=
 =?utf-8?B?RTB4ZWpGQlZ2TnF2cHB4ZUVMR0VFNUdicXd0YWpBZDNBQUZoc2dlbUdobDZp?=
 =?utf-8?B?QjhYUktBd2xjeGhGTGxSR1pyQ2E5ZncxdXlSRDRRa2toaU5iZUJDdnNhcG1u?=
 =?utf-8?B?T3htck1mYkFTOE92N0V1ajJObU5ZTWY0SU9xVkZNOHpmeWQrcy9aMFNYM3E4?=
 =?utf-8?B?K0d5QW9PKzl3ZDhNWmZEOTBDVlVSeFd0c25sQjkyclBYckswaHA1YTUvRFA5?=
 =?utf-8?B?SW1TQmVMKzN2Y1BmSjBUUXZtd0VtdktoSFppVE9iakRKWmdOL1R4UFJndzI3?=
 =?utf-8?B?c2RjMzRWUlQzbGg2MVlKa3ZHWUNyRVJOQ0R3bTdDcENBQUQ5amJvbEFDRkIv?=
 =?utf-8?B?U0RGeU9pcnFxR0FCSStrek91WUkwcnA3VnF5TlJCN1RRa1lKMG13VlF2SGVw?=
 =?utf-8?B?bktsa2g0aFpId25FUERLOWwzYWZJVSswMDYyeGhRVXJ3ZXdHNnVSRXdxWTlZ?=
 =?utf-8?B?MHFTT2dwVFFKbU5PMlVKSHVnN0RHU212VHZRa1JwYzlOY1YwUmtKVzNzMVFN?=
 =?utf-8?B?SjNiYUorMy9oRkdvZWFrOVNHKzlrTHhnM09CNS8vSXkrb3Y3b3MzTzBjWWxm?=
 =?utf-8?B?eGJxK0djMDdPVW9FQUtNQWV5WERuRlRiWEpiZ3BNdzNsclE3Y0NKSnB2QVR5?=
 =?utf-8?B?Y0lLdERwUjdCWWl4VlROTHdReVdCc3NXbUplZVBBL2tZRVFvUTdhZlFXOHNu?=
 =?utf-8?B?bjNKSTcrdjMyTGpkOXVGZGNGREtaOGpLQi96UzhlT0FaMEo5RDRJVjFDQlhi?=
 =?utf-8?B?YUZXa0daTVlFK3dyUUZ1U3FLbjR4djJTVmNZK1gzTHFsQnlVZGxuNUh2dXFi?=
 =?utf-8?B?bTNRVGZlNkNBVUNOcUYxdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFlYd0pRWllJbTgrSU4va1M4a2FwZ2RNSFlIdXNnS3E1dVhYWlFuOXlIUWVl?=
 =?utf-8?B?YlcvNmNxZk1HV2xhT3lsTllGVzloelBoeWtYd3NQNkdOZnpSVG5BMHVxajNT?=
 =?utf-8?B?WTYrc0NNSThGWjZ2QUZ3TVZJU1dCTzRVTFVkL2wzMUF0NDAwcjRSQ3EzZ2hp?=
 =?utf-8?B?MkdNeDRxdkx1OTR1aUtiYkQrdGlORjduRWI4cEpENjdYOGVtVTRpRDVtcmc0?=
 =?utf-8?B?eWJOc3RaUFRWNWJQQU1nalluc25ONndhQVRIK2ZwQTZ4NWtCTXdtRGd4ZVpo?=
 =?utf-8?B?b2tvbms3WHpPNTk1VSsreUs5S1J1TGJuZkMxMHpOZm1BMVhqTDNxV3c5WWlu?=
 =?utf-8?B?SWxqbU5kMHBmeDNpcUJzenEralRWQ256UDFpamZ1NS9lTEFOM0NONmo2RGlM?=
 =?utf-8?B?VU42MittZG1hbVorbm1GZDFEL2JlV2N1Z1E4K0NpZGJKTWIrYllIRzd1cWs1?=
 =?utf-8?B?NjN0MTdkYWgzREdtZExyRWt1dFBBSVZuMExWU2lPRnhiT1dqd2s1cUk1dno5?=
 =?utf-8?B?UzZ4VkFQSmExMzJxMjkyVEp3U2k5N0Yydnh1YXAxYmNlbXZyalpyZk1NaWtu?=
 =?utf-8?B?UDhQZ2FqNWZpTjBKK2k5U3pvKzRCeUtDSnRJZmUrTTl5V2kyRHBaZEk1UmxR?=
 =?utf-8?B?MXZxaWhKK2Q5VzhpZWgyZWNRZU9iakQwN3lmMXc4eEpiM0hvdWlXcE5KRUlN?=
 =?utf-8?B?UFVPVUkydlhlYlo1eDl5NW5nSWZaR2dGYXAvRm9ybnFkdkNrYXJiREFQVkRB?=
 =?utf-8?B?U3FBSE5sSjVoOFZtYm5wcThTN1l1ZThwQ2FkSjhRc3AxVVVxanh5WTcwT3JM?=
 =?utf-8?B?SXNYbHk4RG5rcDBZVytva3gxd0NMbEI1ZGJLeWZuUUI1dDJnYWpTZVN0eC8x?=
 =?utf-8?B?WVFmazVOOS9FbmEzLzFhZkpjN1FQTmNZUy93dmhyeElMdERteVlPbmxqU09C?=
 =?utf-8?B?UHNPOGpBNHlQdCtXVnhoZE5Yd2J2dEljTExkVGxSN1hINnZicnRaeFM3VVc0?=
 =?utf-8?B?REdpUU56TXVOQWtwYnNkRjlJR1JBUmYxRWh6SUErQ2V6Tk96ZVg5K1dZUVlm?=
 =?utf-8?B?eVZUbzM3Smp6Ui9GYWFXRmQyQnhiNHl4NEg0QkdyNkkxZEJTQUE2Vm1aeWJz?=
 =?utf-8?B?ME9nN2xqcysrSHI2VlhCb3lYYlV4S0EzT3k5YmN4UEVzRXJTQ3VvZWhmM21Y?=
 =?utf-8?B?MktHdysyUVA2SCt2bVlyM1VCc29oT24xY3BkQ0Y3UStyRVhJbzg5M2I2dUpO?=
 =?utf-8?B?VmplOVZQcXc2enZ0R25yZFArbHIvSUhuK0lQNmtSWWs0cVo2TDErYnVvWmNY?=
 =?utf-8?B?em9JUXZmQWhuVG5PUmVZVDBPWW40QSt2YzdmZmNuNFN5VTdGZzNhZ3RPcnVa?=
 =?utf-8?B?b0xHOEtVNVBuWjZDSDEwMVJrS0NUczZrWCszdHdoRUpqaTkwbm1JcU5sTWd3?=
 =?utf-8?B?UWEvbTNRVWxXWU1td3I4L2RWVDJpYnBsNUVjTTdNRjc2anh6UUFVc2VTUkhz?=
 =?utf-8?B?RlUxbkVKR0RQN0ZLOWJ2dkpDNDdDSFVnWG9uNFROQkVoeExxb3FaeTZxRjQz?=
 =?utf-8?B?S3l1TFlOcVZNTVJlTG1xRERBMThUdWU4VFZxYVdKU3ZjT3lUUkRvbWtrOEpn?=
 =?utf-8?B?dkhoZndXZ1lLWkZlSUdnY3RqU0xyYnI3b1QvT1YxRzlBZURVTEdzK1lVMXdC?=
 =?utf-8?B?cXB3YXJDTSt0N2hkWlZJKzJ5VWVwdDZhSXpkdXpBdGVuczh1aTlubUppOWpC?=
 =?utf-8?B?dEcrall0QmU0RTByTDIwdWhXdDMxZWN3bldaamJtZ3pkcncrVW9lclNSV1VU?=
 =?utf-8?B?RkkrV2k4bTZyNDU2Q0w4bTRrYW5Rc2Vvei9HbnY3ajJvczd3OC9Udzcra1Rj?=
 =?utf-8?B?dTZBSWt1UkZYWFhzamREb2syYk02VlE4MW95N3NrUkNoNDFoREcrRC9RR0Qr?=
 =?utf-8?B?ZkJnU3RNTVI0eDFNa0hsM1BjcXpCNmluOUVTd2ZNazJVQ3prY3p2VXR3WjAr?=
 =?utf-8?B?WHBYSU5Ub0JSMDJobjUrcHVNRzJIc1A2TGszdXc5T3RWNkZQZi92ZWJ3djRu?=
 =?utf-8?B?bjAwckNLaXV2ZkQwTHZIdG52YjJ3NmZjSDRrbTV6a2Ixd1hhWVAzVXJuUEtr?=
 =?utf-8?Q?lot67mA0Asha4DzHzb3/OYwSn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0601c588-d416-4657-931c-08dc686630eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 16:05:29.6007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uYkuJGiVcKs4FQxe5+sUE4xc9jGNVxsSoxXUds+8vcZQo65I2aG6gu3PUEMU4SuYKvqSfbUQiu1Ff0hOuyBx3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7034
X-OriginatorOrg: intel.com

PiBhbmQgd2h5IGluIHRoZSBoZWxsIGFyZSB0aGVyZSAyIG9yIDMgcGF0Y2hlcyBvZiB0aGUgc2Ft
ZSBuYW1lIHRvdWNoaW5nDQo+IHRoZSBzYW1lIHRoaW5nPyBXaHkgY2FuJ3QgdGhleSBiZSBhIHNp
bmdsZSBwYXRjaD8NCg0KSSBtYWRlIG9uZSBwYXRjaCBwZXIgZmlsZSB0b3VjaGVkICh3aGVyZXZl
ciBwb3NzaWJsZSAuLi4gdGhlcmUgYXJlIGEgZmV3IHBhdGNoZXMNCndoZXJlICIuaCIgYW5kICIu
YyIgZmlsZXMgbmVlZGVkIHRvIGJlIGJ1bmRsZWQgdG9nZXRoZXIpLg0KDQo+IExlbW1lIHJlYmFz
ZSB0aGUgbG90Lg0KDQpUaGFua3MuIEkganVzdCBkaWQgYSAiZ2l0IGZldGNoIiB0aGUgeDg2L2Nw
dSBicmFuY2guIEl0IGFsbCBsb29rcyBnb29kLg0KDQotVG9ueQ0K

