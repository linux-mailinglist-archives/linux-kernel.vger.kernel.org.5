Return-Path: <linux-kernel+bounces-46463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E83844012
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1DC0B2BEBE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7313D7BAEB;
	Wed, 31 Jan 2024 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIGQ2x1O"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5267AE78
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706456; cv=fail; b=YUxwrWJbhVDQLf+9dKbmqEmLpXJzccP0xmSt6iiJBFfiRaz4dD/4XfKWsbrQaRkoY5KyogdDqnGkLsySzMSXOnnrbC8j/qj/uLp7QODsKFapxJsp2VxxskhbAlXaUbLwpMBy2WPDdVMxvS5gPtYTJLrF51D4zw4RBr5Zq50Jwmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706456; c=relaxed/simple;
	bh=kMxGEXSr3c+FcHEKFigR1pJ0y3XDrbF9poqn++jaeGg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IX55ItnOIihplCOC29y1gmLzBu4y0oAc0ZLL0yRx19f9vTE9TGP8Jxbmgxg30Ti9o96CMlPMGgS9ars7V1TdbBYHdDcWhv9mfDbwYOgVGzRwW8cxnPmRk5JVWxw1iwcHBEliD5NMeblpZ8n9z4yCwYA66sJz5KNgdIn9zV96itA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIGQ2x1O; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706706455; x=1738242455;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kMxGEXSr3c+FcHEKFigR1pJ0y3XDrbF9poqn++jaeGg=;
  b=SIGQ2x1OAfiGE2LycmcDQCnaHGk3Av8F6yHnUQR1Rsw3367UBKqT5+8l
   Hg+z6JItXPfhn27Ba6dPFPsMh1y2WdK1OoT10felR5O5cXFgD6cKCOUoT
   5rrgO0ktyEPnFQ3jmCOxmdz9HAlMYutRnpkA/Leh4Xl/FPtvJRuNuWeXg
   VsmUFGCrBi6Yh1X3epXWpLbdzQnpCyJkECwQ18BS1IDyBzAbBXZh/4bDC
   58rGJ6AgA+Db+Z0AHlAWKanuan3VceT55Lex1eHpuIN3LCtcv7JqL+j8z
   wm5FyzwoqHl637/nagGxOZjXDXwMzKtjX2upfs2Ec/k4qn36kSm15LLcG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2533511"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="2533511"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 05:07:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4088465"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 05:07:33 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 05:07:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 05:07:32 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 05:07:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQ8ydbWL0gqnlhe/OIauik2M07r8yhHd9/WZWWoJIdqzgRn0bp0YB+FED8PnnDUcXauqrrGL7dA3FrLuPpuqglILklHWKIADtjPHJsGr3jfkwtoMsP6gr8XDY9Rz6VFaR1aQE0wJZd568oB59zbgG5UQsw8mTcb58UUhM3nXX69MDvXdVVolVMS6bYpwaA/KIiGdA29iMQWv7NXM8HE5LCPqNK3e1pP7BjsfdYRZJReiynekvU38gVUrQIg51wQEX1VgwqEx/zfy+tgAhLoosuWPR8pIZU57wKyiybEtGEkCWa8B0nQBUpNiThN90ZAfvi1AFg8OenGQQWZSb1RvDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMxGEXSr3c+FcHEKFigR1pJ0y3XDrbF9poqn++jaeGg=;
 b=HD3Ax+HYGkYbF/S7WgWG4v/KAYnxNkRwtIeB8Lo5Pu3C1nDmwakZeyLRYH5EcW/8TRO+P8OAc0TvfeFTrUXWGkG01L4RV2suSSCMko3jqn0cwz9nlm9y7zsMVBGDBMdopM1BX6srGg8xiHHwqWa2g4dzDrxdTISY9xhtVjctVckRYXvNn+I8lXya5OYTpH2TjlKGRMhAl1q5tBVy0LwJCClLMqFMYz21fvZi9fk81R9KYzBnSSDpV6IUHJrmzxC3YWeGNBxqb0MmO074aHbHglkc4/iiXoZ1forxfjQ6UjF8v+SV+30QTVXfs7XaWFFkLOLFBa3/RD3fukvYAoRkrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA0PR11MB4701.namprd11.prod.outlook.com (2603:10b6:806:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 13:07:29 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab%6]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 13:07:29 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>, Baoquan He <bhe@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, "Sean
 Christopherson" <seanjc@google.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv6 00/16] x86/tdx: Add kexec support
Thread-Topic: [PATCHv6 00/16] x86/tdx: Add kexec support
Thread-Index: AQHaTsTUrJt5Lc/78EGyyMMPX3aqzLDyZwKAgAEqbYCAAFhhAIAAAwYAgAAByQA=
Date: Wed, 31 Jan 2024 13:07:29 +0000
Message-ID: <BL1PR11MB5978633DF36A69F8020818E1F77C2@BL1PR11MB5978.namprd11.prod.outlook.com>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <3f44458f-2b4a-4464-a3df-cb791298dafc@redhat.com>
 <efe20a00-9a7c-4c03-8fcc-fce265cdbf0e@suse.com>
 <ZbpBbAkPxQZ6gHoE@MiWiFi-R3L-srv>
 <5d91fc11-0b3b-40f0-872d-abdbb4038f76@suse.com>
In-Reply-To: <5d91fc11-0b3b-40f0-872d-abdbb4038f76@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA0PR11MB4701:EE_
x-ms-office365-filtering-correlation-id: b62b4c33-41c5-4185-eb91-08dc225d9408
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bMpuB1s06iUhlWzlOIzEW5C5tQsGneU59DnNcj7j3Piuv2/GUoyJzwbaQrZ0prw9olVWwuyGZZShRmqF2DxpMYGHYHpUALCLuIoPII/AKTQHNRWp/UKI0/E752Xamp67GCfAzzXar52geQ8vS/Vs2fmEhPPMB2fjpXKaGUJlZAgchEw8SGdiBJL10kSi7gBOUXqfr/DpDtdfNrxuQPoHVELoEaXkB1g9riTnIp+Xgg4wKUzVtH9uzi7/5nE6LAG8v0ADGaOGXns+ZhKNvPzzkbjmUHXTk6yZWji3uZtk8bAyRx2ToxZNhu98U+bQgefUSb3e3FYeYFqeOubBkIpHEjVC0zsE4z0JKqGEaSN8TfwbLjpa1tO3AK5tki4zrBX2DkCU9+OusSulXbDGwGUlCc6xmk+12Gv0UZP4zHSr1KOZ5IePZGHhcarNWTyi/bMa5Z8xyOa0Uskkmyqmq7pz0MNJz5lJuY5KltaPrWgt0tCvWXBK9u4koYH64n/k1igUQXb1xb+mDoIEjrD+SYJZZKpizZfGYJjUL++vFCdzNzszy48gdb3k9gy2BiUfJVPLS5B07reN0qOqfk1R6QMGH4XhKj1kn8PwGftweICNkl/Lh8joc25Bju8csBR7ldRg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(376002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(83380400001)(26005)(9686003)(38100700002)(122000001)(478600001)(52536014)(4326008)(8936002)(8676002)(5660300002)(7416002)(4744005)(2906002)(6506007)(7696005)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(71200400001)(110136005)(316002)(41300700001)(38070700009)(86362001)(33656002)(82960400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0FLMXBWckJyUExSV01jRi9rTmVteGMrcFk0eTNadjN1RTJaMlpsR2FKR1hR?=
 =?utf-8?B?dXY2eTNsRmRZS2RMWllTUE5SWUxIVlVuc3l3RUdjVnFtNVp3RHZFdExTZW1y?=
 =?utf-8?B?V3RPMEpLaEprMTZTNGtYeUJqakd2KzZqVSt6aDJhaGRKWnZDSEVZcG15TEph?=
 =?utf-8?B?L1ExTmd5aEJqS0xZbFZndVdDZHcxdEVpQk4xYXMybDFmUzhqUHZUTlhydGVL?=
 =?utf-8?B?bTB0VnUxS0hxa0xYczlma24vbi9jSGtIM2hvYzZ1Sy9hN3pPbjE1amhyZ2tl?=
 =?utf-8?B?TGNYSlJiaUNPdXpmVEV4V2hGR0ZnWVRLU3U4VWMvMCtzd0VMeHRqem5jb1NL?=
 =?utf-8?B?VnZTM3o2dnR2U1phT2tVZy9sbTJPTFl5T0tTMkFoWmZpVk16RTFWSDMzd1Jt?=
 =?utf-8?B?VWM5YlBXajJROXFMZy96RkFTVXhpeUM3Yk91cHVCTFhVMnlycG04SVhPT1ZX?=
 =?utf-8?B?Ti9ESlUrZm9sOG5RUUZXVERYKzQvRTVwMnQyNjVVSlhnVzROOE8yV2pPME1s?=
 =?utf-8?B?QkV0bUlHRzZyUjR6V0hSMnYrWkpZcmlsenNNOEI5dFNWb0NjMFdLNzA2eHVS?=
 =?utf-8?B?bFJqU2ZZMUVmRjQ3dlVWR0NGTHNKeTZ3TVpHdzJnN1ltNVMrdWRXSWJ6cG1H?=
 =?utf-8?B?M1ZVbDlsV3dqZzgvc1ZLT05KcGpnZ3ozdG92cy95dkJxKy92WGNqWUlZN0xV?=
 =?utf-8?B?V2VTejBjbUtNUkdSaVhMTTlmMDJCdzRwU2Fob2R4RUM0NVJLVmJiZmg5cGxU?=
 =?utf-8?B?d0xZdXlvdkU2dGJaL1pCSE90RFlWMXIvRlhFNjJleENkT3k0ejVDOHI0YUxB?=
 =?utf-8?B?N0VPNCsvcGQ4T05mVE5oZG94QlRnVnFTRTJMSHpVeHRyMVhhYnE2NkZkcmlH?=
 =?utf-8?B?SXFMd1lJOXNiUjRjQ2RYS1BhSFJEdHJQTk9yZW1XaCtNRjJiamtJd1B0dDVK?=
 =?utf-8?B?UkY1T1IyRTBTajYyMzhhays5VW9aYytNNjRHMDhXbGJNUnVCTEV2MFZrZUF0?=
 =?utf-8?B?L2p5dUFGM3JKVURBOVhubW9la0RVdEFSUUgwSngvRzVMMXM2S1ErUHRySGhJ?=
 =?utf-8?B?YkQ2aDhSNjkrWDB5djhoZEE3VktHa1c3Yks4aEQzM2Q2c2hmZjl0eHlUTFd3?=
 =?utf-8?B?c3BqeC82YjJZKzJpOGVoNUVGYjJLT2tla1RRQ2ZrTVhqU1hWYlNzL1F3MW01?=
 =?utf-8?B?dk5PcEFieTFtMUVFaW9aYXZ3bVZGTjlOc0NqS3JGQUtCNkcreEpBWENYVFZo?=
 =?utf-8?B?WW5OOWZpRktNSzM1WFJzZGhhT3RnaWdTY0RmbFA4SzRtc2xiY05jMTlpN3g4?=
 =?utf-8?B?dmRIdnpmU0RqUXdDanphZ25rRktHdE9ZbE5ZZFNCZzB5Y3h4amg1cExtM0h0?=
 =?utf-8?B?b3V1SFgxNTJjME5CZFFUSlQvL0ZSVHA1dGtCM3Z6V1ZBVFN2aWxrSnA0NXRT?=
 =?utf-8?B?Z2Z0b0NLY25DMU95RUxvdU9CWDNjNzZucnRLVFIyU1F2ZUlkU0dWK29XM0VO?=
 =?utf-8?B?ZTlyT1YraFpPc1hhb25iSCtaZUNGWEZNR0N0TEY4QjhZWCtSZi94RFh3Q2pN?=
 =?utf-8?B?azhSOFVaUGFjUlNHTTk2WTIzUUZkT3dBZVpZMDlLTC9LMTdNaFVKOWlJVzdp?=
 =?utf-8?B?WEdrZ2dVeUhCdzcraHkza3BrNmxpQk9kVFVlYU5FN2Y2RW95Y283MXpxQ2NW?=
 =?utf-8?B?bFUwdDgxTDlnRlg3T2NkenA3UGpxMWQ1dDR0T0dDZ3ZsVTNPdThFb2hkUmN3?=
 =?utf-8?B?THUxZVVMZXdqY2JnWVM2bTFPaWlCWkpBUGprMk9za05aVFVUQ0pjRm03cm9X?=
 =?utf-8?B?NmlqNTVnTXdoVnhNRG1mNUg1V2dxeWhxeG9RVnd5WnQveFU1T0ZzZS9YYUZD?=
 =?utf-8?B?Yzd1WG5RWjFqcldRcDhodi9iWXFJbTA1d01Ja3IrTWJMZjhUZlpYSWVnYVpN?=
 =?utf-8?B?TkVDNGt1TDNSa0QwQVBuaWpQN0tuNFN3TjVRVjYyUHZKYzExRFJFQmJuRDZl?=
 =?utf-8?B?cVpWTHRSTms4cnZjT2kwdkdXQ1JMNEsva2czV1JCWXNPVHdvc1Fqem1CZC9M?=
 =?utf-8?B?Nzc2M0wrdndkUU0wR1hwQ2VKNUNHNjdiMWVGN3pUbWVlT3FpRXZoc1Y0YUNK?=
 =?utf-8?Q?VI4nSRxYEKv26atmLyN8Ps0GR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62b4c33-41c5-4185-eb91-08dc225d9408
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 13:07:29.0658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i+HZ8fTxHuy/2+QW2TmPTg4LgOmdt+t8b4w1gVkYgFpjkKDNiDNDp3+Wh1TJ9QfOH7qimOHgag7DfAVQBZ4LEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4701
X-OriginatorOrg: intel.com

PiA+IFJ1bnRpbWUgZGlzYWJsaW5nIGtleGVjIGxvb2tzIGJldHRlciB0aGFuIGF0IGNtcGlsZSB0
aW1lLCBlc3AgZm9yDQo+ID4gZGlzdHJvcy4gV2hpbGUgZnJvbSBhYm92ZSBwYXRjaCwgbWFraW5n
IHVzaW5nIG9mIGtleGVjX2xvYWRfZGlzYWJsZWQNCj4gPiB0byBhY2hpdmUgdGhlIHJ1bnRpbWUg
ZGlzYWJsaW5nIG1heSBub3QgYmUgc28gZ29vZC4gQmVjYXVzZSB3ZSBoYXZlIGENCj4gPiBmcm9u
dCBkb29yIHRvIGVuYWJsZSBpdCB0aHJvdWdoOg0KPiA+DQo+ID4gL3Byb2Mvc3lzL2tlcm5lbC9r
ZXhlY19sb2FkX2Rpc2FibGVkDQo+IA0KPiBBRkFJVSBpdCBjYW4ndCBiZSBlbmFibGVkIHZpYSB0
aGlzIHN5c2N0bCBiZWNhdXNlIHRoZSBoYW5kbGVyIGZvciBpdCBleHBlY3RzDQo+IG9ubHkgMSB0
byBiZSB3cml0dGVuIHRvIGl0Og0KPiANCj4gICAgICAgMiAgICAgICAgICAgICAgICAgLnByb2Nf
aGFuZGxlciAgID0gcHJvY19kb2ludHZlY19taW5tYXgsDQo+IA0KPiAgICAgICAxICAgICAgICAg
ICAgICAgICAuZXh0cmExICAgICAgICAgPSBTWVNDVExfT05FLA0KPiANCj4gICAgOTk0ICAgICAg
ICAgICAgICAgICAgLmV4dHJhMiAgICAgICAgID0gU1lTQ1RMX09ORSwNCj4gDQoNClRoaXMgaXMg
YWxzbyBteSB1bmRlcnN0YW5kaW5nLiAgDQoNClRoZSBkb2N1bWVudGF0aW9uIGFsc28gc2F5cyBv
bmNlIGl0IGlzIHR1cm5lZCB0byBkaXNhYmxlIHdlIGNhbm5vdCB0dXJuIGJhY2sgYWdhaW46DQoN
CmtleGVjX2xvYWRfZGlzYWJsZQ0KPT09PT09PT09PT09PT09PT09PQ0KDQpBIHRvZ2dsZSBpbmRp
Y2F0aW5nIGlmIHRoZSBzeXNjYWxscyBgYGtleGVjX2xvYWRgYCBhbmQNCmBga2V4ZWNfZmlsZV9s
b2FkYGAgaGF2ZSBiZWVuIGRpc2FibGVkLg0KVGhpcyB2YWx1ZSBkZWZhdWx0cyB0byAwIChmYWxz
ZTogYGBrZXhlY18qbG9hZGBgIGVuYWJsZWQpLCBidXQgY2FuIGJlDQpzZXQgdG8gMSAodHJ1ZTog
YGBrZXhlY18qbG9hZGBgIGRpc2FibGVkKS4NCk9uY2UgdHJ1ZSwga2V4ZWMgY2FuIG5vIGxvbmdl
ciBiZSB1c2VkLCBhbmQgdGhlIHRvZ2dsZSBjYW5ub3QgYmUgc2V0DQpiYWNrIHRvIGZhbHNlLg0K
Li4uLi4uDQo=

