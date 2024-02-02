Return-Path: <linux-kernel+bounces-49174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 696E58466CA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2009428BCFC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4DCF4FA;
	Fri,  2 Feb 2024 04:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHJHKUDD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA33FF4E3;
	Fri,  2 Feb 2024 04:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706846966; cv=fail; b=IJL/EB8pjsuGtoqKMGkTgW0HWSVdCmNfhTqltWpTAjx8yCzaeiZybuGhmj2ktpvYS1aqVGSEJ/Y2BiymUSjw0C0VoSp2bsHKr1gpJ5gyeB8aZtgbZRCxf00jdUUW/tDVXG2HXxEOblhlCz4+2zrFlR/xy4VaVU/WcZleBMkyfoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706846966; c=relaxed/simple;
	bh=RReHuFU1c23Tw6MsQTsmKFAn79vZxIfrTc1kzNsTDE0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nNM53kouHtXZAfViyAoSG5BZBiuddhjQ77IBlSJciDkR9Twx3jppQ1+Kfg8LTGmp2aIrEsdAorJ/WdIimHpMeU3yZRDUHafxQUyxgNftngXvt1jWtv8gJfvJDlZOTJFAVa/fheGVD08myAURu7yiqbENNgJ0dCp+RH0bFAYa29Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHJHKUDD; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706846965; x=1738382965;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RReHuFU1c23Tw6MsQTsmKFAn79vZxIfrTc1kzNsTDE0=;
  b=nHJHKUDDcgYBg0a0UPuENYb6vOAfISKsIut1l5udxp7mRFNlsbholrtq
   TBY1NZF+xfj69v/oeumZIAYI0ldBYMLa6G/VInCVX47w3UZNdyw1myNlg
   bhBwL1NDRbHjL/UjSPpmbMJi74w/WkB1sMVuKJoxZcE5lPkG+Ia4WvZzS
   D129SGMqWtjgLaqw1AuRGvXG/QXXbOidC+lwNUxd5wT59VSzBn723TfOo
   b7iGMpQUGQya27N5ON5jeDq3cMspvw4h7xYrLPvDgu9ZupjE3fMA4xbbH
   oZpA9GKW/tOSYLMMGigiVJXcEVTLoVCph2h5rzxF+lNGbzQllmb7vcd7a
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="252022"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="252022"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 20:09:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="962110840"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="962110840"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 20:09:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 20:09:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 20:09:22 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 20:09:22 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 20:09:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzxtTA7iLZCz2Go7A20kMkkustu3nvQxsfvStYyZyVuHp12jdJktUa5yRCM8dxRx5dN4CuFgRyDZFQBwQsBqYTOttnshiIKoBTc0rC3Z68Yx0RBQ8B8lS0DQZx7tmdA3wd2lGwl44dc3lqbsPevBsbwECmmjVcMoAd40Ds9gmkNjoihifMgJFzG84OprCqXDrTzaZ0sWtPc84NHm4xQj3P6b05yW5Mx2PyLiXbkxHHPaur1zH85vW91Pn09djWAykI2p0Go2i8ZL1anZh5S9BIlI9OAdOqj7qHR0ILT80gsS/kRG8i2pA94dxazMJVSxqOghhp21UhYn90oyItvE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjTymdDL7X6S04dlVH+fBjM/PYI9lDqX21F5C/9yfgQ=;
 b=OJxtFHpPqv2DeiaDUd9nstAglzhMDkVtXj3Z/CKO724FkdUhiv/OSqa5oS+vqg6Rhf8H33+ZzLD2ykGNHlyWKB+0RdzbhLVVsfdHhzcYjOMYX+jGprRE5WNgTM/Zx1XQAgls9vyRXQ9l+1lcIvjezmLVFYwOeTW05Xz9/nhEpW9nIXLSZegxRaJbkoFyjY6CWQzaRL+QXjgUiI0MOHlDb5KB0hHoaYNhV5ArFX/brjJ060iywJP4Uu94AebM04xYjRDONxGPkSQ0xqlnJva5rE9pCQlVXUYIq8OXivr1dpekFw1lE2wmPiDmOByznF0LmZXVxqZMnwRQOz/gQfxNWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6389.namprd11.prod.outlook.com (2603:10b6:930:3a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Fri, 2 Feb
 2024 04:09:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7228.029; Fri, 2 Feb 2024
 04:09:19 +0000
Message-ID: <7c26af23-fa1e-4e01-8088-8fbd9be3d6f3@intel.com>
Date: Thu, 1 Feb 2024 20:09:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <cover.1705688538.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:303:2b::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 461ecda7-03bb-42f7-2a09-08dc23a4ba79
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AFiqcTnTjU0iRnItPGbKVjzT1jkdtSCCSztD+NEVU17q8cSKryWXnVmBZL4XW4jetgX2CW9umYCno4AyT5xeTcVOJnb+mlNKtQqqJjB5hhJ+/k5QdVGrkPLMBdJUedzZpb/US4h82nv+f9cGDfUEAFWxcQJMWpzafcd6jOeJJ1uqAe8MjGz7n8mQPwAnNs87KbqQrcybSoeEHx1qGpom4buszmDHWjm3sDkUt09D5MCc5xpcnHHJ6xVgqCPMGn+c+G2YRmNfznxAcDZLUQHxFtgYMsqq6QU/WRvSmW1GFPKei+ckcGIOUhHzkPKFVzseZaMJ2jlRvcEv2pQyj2c/S7icfYIuCe8sp5jarGfg9FdSbeHPZjUIAuK/3k7oiGqm/+iUIyQ3J2Nq6dvO/awY+VprsQkwyCXTPbFueNmmZxtVsReC+Ig/njDiLjPYSMOJngoa/thKnlycWGPEmfLzXMziFQuAjwjcckpfZ0VFAcFxdq1lHOChh4UQVYjcc9qZ2nvIZjvt8B9kKmuRH3ijTXS9dQwVK9dBiC23Clt3OTZpb2KRisRXvmia+JNeVmpn757Mmn4hYlEHfsBdwiFEojni6FTjnLL5DGw7Gs97AQ4x41n/KhUdAEwfMXeZguAuHGbEaTxr3JU6UjbSBW4DrdoekDxLTPWvpDS7FxTOlk14jWgQgyAIDAb8k+V3fFHE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(38100700002)(2616005)(26005)(966005)(8676002)(6512007)(6506007)(8936002)(44832011)(478600001)(7416002)(4326008)(2906002)(66946007)(6486002)(5660300002)(6666004)(53546011)(316002)(66476007)(66556008)(41300700001)(82960400001)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2JORnpFSTBDaENjcXhaMmxXdzlxbzVBTzNVVHJkczdaTzdIMlcyZ2w5SXhP?=
 =?utf-8?B?eFMzR1liSVFMaGpjQTBiaTdnM0ZZQU9IM0RGamdKL29CanJHS0tyNzNMK3R6?=
 =?utf-8?B?bFE4TDBUQlVSb1VyNFB4RjFGMVF0cDhMbHZUMjJIWFRpSURObjJDRXgvejlV?=
 =?utf-8?B?VFBnMmZ0S0phWE5tNXZDUEhKSGc2MklFQ3VzcU4ybFlKS29MdlVRYnRBNXFs?=
 =?utf-8?B?RVUwZnRSdlEwZXlZT09SRVNqcEFNRU1Nc25TRWhxbHN5OG4ydEprNm9zbjly?=
 =?utf-8?B?MW52S1E1Wlozb2luYzRGOWhMcDg0dC9LZzFBdHJrMW8zWXdEcWNiVi9JM0V3?=
 =?utf-8?B?UFNmcmxQSXlkUWFJRDQ0VmNkNnR2N2FiVTlyRVVvOS9iYUpRd25hbGU5MldD?=
 =?utf-8?B?V3dDck12bWJnQXpZblJaeGUraDB1ZWhGbmVlKy90OEFoU2RLQTFYaEI5b0JF?=
 =?utf-8?B?Nkg0WHpnUFVXeVVQbzZ5bVJaRDNKTVZVanNNZDZjTkpoWmJDSTliQ3d2aTFN?=
 =?utf-8?B?TUZ2Mlowc1V3VnNyYWRiZURxQmNNTUdFQVNhbXFVYTlDSDZzM3gxZHBZTGIw?=
 =?utf-8?B?UXRmRGJZQmZnTUFuSkVyMGl3bDluNmo5Uy8xRzV3RmVsYmg2dVhjU0xqekRm?=
 =?utf-8?B?TE9Md0FZd2tQbStlTTZJemc2WFpiWUcwWjBDUFZad09xTm1pZHZhQUJ5T2Qr?=
 =?utf-8?B?V0dzL1BZb0RpWXBkVnpPeVpxRk11Wi8xV29kdUE3U2pHV0I2MjlmelJWUTlL?=
 =?utf-8?B?WEZPdzJkNTdjWlE3MERwejNkd0U5OWRiN2xhSGR0bytIdVFES3dqZ0pFR2hz?=
 =?utf-8?B?dWk0QjQ4L0UrWU5IaThpaUtMMW1TUDQ4L2JUTjBidUxWMzF0a2ovWW16eEh6?=
 =?utf-8?B?OW5uYkZtcFpqRXhvWjBOVk5na0w5SE4vdm42bEN0MWFKb0hZcE1wRVI1NzFx?=
 =?utf-8?B?MUJLa0l3M0ErU2JuT2RVaGlXbUlUOS9rSTZZUHJkOFowWWNkT3Z4UUtnMFpt?=
 =?utf-8?B?SjZvbXJUczFuWEFDTUZrTGdEYkVJSzlmb1Y2WEl2S1JyeTFEVWZxMVJ2UDN4?=
 =?utf-8?B?Um9KWE5zZHNkVWVpRDJKZTQxRmlzc29HWTdaQU5VVlpHSmRKMkRiZk4yWnBQ?=
 =?utf-8?B?U2V5N2kvZHRNdjF0cCtRVERZVExEUVZPaGZORjJsTjdXR216QWhTUUpsUjlt?=
 =?utf-8?B?SzQ0dUF4SEVocjUzQnBJSkhSR3pTcHZrZWZ3RWxjUTJSbzJtRmY5UWhCWmd4?=
 =?utf-8?B?c0hZalZ3cVppdm52NnN1NXJacTlMcXFIQU4rKzdqZytvRkFMVGFiTGRwR0hC?=
 =?utf-8?B?MkV5dDR1WDlPK0lydmw1dzBXdU1KajhQdmJiU21RNkFyekROc3E3NUx3Ukxi?=
 =?utf-8?B?UGpNaU5uZGRFbkxsL3pBM2grdnRJSWt2UXJ2eDdLWlI4NitwVHU5d21rRUhJ?=
 =?utf-8?B?K0tGeWdJUHlpSXJHbzZ3UG11Zlh4b3JFbEdGWmJuckNaNHhOMlUzVDVxaVdW?=
 =?utf-8?B?SWFySzhpME5HWVozMUhpM2dYS1BJbTRyM3ZKTGZ5U094dHozTHFNelZtWVRu?=
 =?utf-8?B?akp2dVluM3VwVXBNUVFPSWRGS3JIbUNrNkpTb2pJQVJ5SWMyOGx5cjJGaHBB?=
 =?utf-8?B?ZmVRSGRMRkwxbGNsc3ROT0pTZDVJcTVtSzJJM1dmMTExR2RXcFl1VkYwMDZD?=
 =?utf-8?B?a2RFMXR1SnhYYVA2Q1hHbG9ka2drblpDa0NBREwxMURXYlBrZVIwQTZFb2Nu?=
 =?utf-8?B?NjQ5NkVhSzFldVBnbE5nOU5tSE5LYVJuYjNpZHBWdm1pbVZza1I2dzJLMDVy?=
 =?utf-8?B?bnlaSHd3T1d1dmhZT2w4aThBbGNpcDIyOGh6L1p0aERjSjA2U29CNmJOZWdU?=
 =?utf-8?B?czJmNGFCOWNiNkZ2NjFFczlEcGhHRXpQODJlTzY1OUdWMER3UE1PN1cxNEpo?=
 =?utf-8?B?U0lwOTlLSGxmekE5YXlnN0hyb2VRaFlqc1RwZmhobld5Q3R3Szlha1Y2YUZE?=
 =?utf-8?B?c0gwTnlqTitpdHF2Qm9uUjRXTnhUdEZXS2U3ZUZzcmlLaldjQnB1OEtRTUQw?=
 =?utf-8?B?bmhQT1B5dXhMU3V4VWFwYW1pU1VTR0RmcnlQZDY3SFF2TjZ5VGsvWGpqSWg2?=
 =?utf-8?B?bW9SdGl4ZDhyK2l5blkzdDlyU1NJYU5Bb21WS1ZKUFB2bTVweDE2bTZxVkhn?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 461ecda7-03bb-42f7-2a09-08dc23a4ba79
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 04:09:19.1149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLkzPJKryzcLpwBui9LSrJJndCERpRQZ43hFIOcfyeSD2cLd+McMu+qNGddA0d/z7WGOusmoJBPVkbam1axd8wUFhc/AzGcXSz9f3r5W/oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6389
X-OriginatorOrg: intel.com

Hi Babu,

On 1/19/2024 10:22 AM, Babu Moger wrote:
> 
> These series adds the support for Assignable Bandwidth Monitoring Counters

Not a good start ([1]).

> (ABMC). It is also called QoS RMID Pinning feature
> 
> The feature details are documented in the  APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC). The documentation is available at
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> 
> The patches are based on top of commit
> 1ac6b49423e83af2abed9be7fbdf2e491686c66b (tip/master)
> 
> # Introduction
> 
> AMD hardware can support 256 or more RMIDs. However, bandwidth monitoring
> feature only guarantees that RMIDs currently assigned to a processor will
> be tracked by hardware. The counters of any other RMIDs which are no longer
> being tracked will be reset to zero. The MBM event counters return
> "Unavailable" for the RMIDs that are not active.
>     
> Users can create 256 or more monitor groups. But there can be only limited
> number of groups that can be give guaranteed monitoring numbers.  With ever

"can be given"?

> changing configurations there is no way to definitely know which of these
> groups will be active for certain point of time. Users do not have the
> option to monitor a group or set of groups for certain period of time
> without worrying about RMID being reset in between.
>     
> The ABMC feature provides an option to the user to assign an RMID to the
> hardware counter and monitor the bandwidth for a longer duration.
> The assigned RMID will be active until the user unassigns it manually.
> There is no need to worry about counters being reset during this period.
> Additionally, the user can specify a bitmask identifying the specific
> bandwidth types from the given source to track with the counter.
> 
> Without ABMC enabled, monitoring will work in current mode without
> assignment option.
> 
> # Linux Implementation
> 
> Linux resctrl subsystem provides the interface to count maximum of two
> memory bandwidth events per group, from a combination of available total
> and local events. Keeping the current interface, users can assign a maximum
> of 2 ABMC counters per group. User will also have the option to assign only
> one counter to the group. If the system runs out of assignable ABMC
> counters, kernel will display an error. Users need to unassign an already
> assigned counter to make space for new assignments.
> 
> 
> # Examples
> 
> a. Check if ABMC support is available
> 	#mount -t resctrl resctrl /sys/fs/resctrl/
> 
> 	#cat /sys/fs/resctrl/info/L3_MON/mon_features 
> 	llc_occupancy
> 	mbm_total_bytes
> 	mbm_total_bytes_config
> 	mbm_local_bytes
> 	mbm_local_bytes_config
> 	mbm_assign_capable ←  Linux kernel detected ABMC feature
> 
> b. Check if ABMC is enabled. By default, ABMC feature is disabled.
>    Monitoring works in legacy monitor mode when ABMC is not enabled.
> 
> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
> 	0
> 

With the introduction of "mbm_assign_enable" the entry in mon_features seems
to provide duplicate information.

> c. There will be new file "monitor_state" for each monitor group when ABMC
>    feature is supported. However, monitor_state is not available if ABMC is
>    disabled.
> 	
> 	#cat /sys/fs/resctrl/monitor_state 
> 	Unsupported

This sounds potentially confusing since users will still be able to monitor
the groups ...

> 	
> d. Read the event mbm_total_bytes and mbm_local_bytes. Without ABMC
>    enabled, monitoring will work in current mode without assignment option.
> 	
> 	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> 	779247936
> 	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes 
> 	765207488
> 	
> e. Enable ABMC mode.
> 
> 	#echo 1 > /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>         #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>         1
> 
> f. Read the monitor states. By default, both total and local MBM
> 	events are in "unassign" state.
> 	
> 	#cat /sys/fs/resctrl/monitor_state
> 	total=unassign;local=unassign

This interface does not seem to take into account that hardware
can support assignment per domain. I understand that this is
not something you want to implement at this time but the user interface
has to accommodate such an enhancement. This was already mentioned, and
you did acknowledge the point [3] to this new version that does not
reflect this is unexpected.

My previous suggestions do seem to still stand and and I also am not able to
see how Peter's requests [2] were considered. This same interface needs to
accommodate usages apart from ABMC. For example, how to use this interface
to address the same counter issue on AMD hardware without ABMC, and MPAM
(pending James's feedback). 

I understand that until we hear from Arm we do not know all the requirements
that this interface needs to support, but I do expect this interface to
at least consider requirements and usage scenarios that are already known.
 
> g. Read the event mbm_total_bytes and mbm_local_bytes. In ABMC mode,
>    the MBA events are not available until the user assigns the events
>    explicitly.
> 	
> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> 	Unsupported
> 	
> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes 
> 	Unsupported
> 

This needs some more thought to accommodate Peter's scenario where the counter
can be expected to return the final count after the counter is disabled.

> h. The event llc_occupancy is not affected by ABMC mode. Users can still
>    read the llc_occupancy.
> 
> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/llc_occupancy 
> 	557056
> 
> i. Now assign the total event and read the monitor_state.
> 	
> 	#echo total=assign > /sys/fs/resctrl/monitor_state
> 	#cat /sys/fs/resctrl/monitor_state 
> 	total=assign;local=unassign
> 	

I do not see the "global assign/unassign" scenario addressed.

This version seems to ignore (without discussion) a lot of earlier
feedback.

Reinette

[1] https://lore.kernel.org/lkml/5ce67d8f-e207-4029-8fb3-0bc7deab1e9f@amd.com/
[2] https://lore.kernel.org/lkml/CALPaoCiRD6j_Rp7ffew+PtGTF4rWDORwbuRQqH2i-cY5SvWQBg@mail.gmail.com/
[3] https://lore.kernel.org/lkml/38421428-84cb-b67e-f3ce-b7a0233e016b@amd.com/

