Return-Path: <linux-kernel+bounces-37792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F2583B564
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7218328511D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4569135403;
	Wed, 24 Jan 2024 23:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y0u+tkc4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009F1135A40;
	Wed, 24 Jan 2024 23:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706137409; cv=fail; b=tUHw/wX+zn2hElmzZUn3LKUkH4pcTiV9EwDYwJlW3GCirwNmJck17RM5HxSKu4Sc2HwvhGO41QBrzb8iLjO9yav7lq7or7zXxrVj54PqcUS6hXeK32J0CfU9gj43ZwXy+ag3Jat7ZONz5v6o0B2i8kBf8/Cy2rvmMXatyOmx7Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706137409; c=relaxed/simple;
	bh=TbFnSJoYROVHbOIWu7L8BuzhRrB0CVavwWy4A4XGvrg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EcWd37BDK23it6pU5U3qb0Peqc/g7vOVrn+23rm8kTwAMdryHqEVrkXq+D77B22pUrK7X172KZvqjB52AKYTDmnoUXeub7lodvtgn3U0CVDigQApXNjE3ZlygkVFQ8FznPsV7eu7FOxVHXXUloXHLxcxGSZFPZb6bX3jvaTii+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y0u+tkc4; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706137408; x=1737673408;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TbFnSJoYROVHbOIWu7L8BuzhRrB0CVavwWy4A4XGvrg=;
  b=Y0u+tkc4Xat/mtv9Q4blUjYc4UmzkyZQVpWcINpIlnWhn62QE8LPXcHA
   ricW5QQ52YSUMe4GCX8p0nNuiaDnbfg0SQAKwYf85MYuDgR9lpX1E8yzh
   AjApW0V9CVvFt9Y+tPIWFpQ/O86kvUdkGDOJrlF14hzfdiBpT502mB32H
   ha/BAyK/osUq8npafPTTPHYRSRJ/zLDA0bk3ND/17tjoST6OVxD4aykuT
   YmlbekXfeKbM5YjYADxJl9ZSiaBtvyufaUSCVxwZiqJEXAgbm1j9ekGEh
   CzFeDQNSt2oeHXmoQd09wXK/RxHEtAzdygk7H5JbqcdWpBN6228keAyYr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="20552066"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="20552066"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 15:03:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="856871367"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="856871367"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 15:03:26 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 15:03:25 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 15:03:24 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 15:03:24 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 15:03:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jw+EgUl09B0E7DfmBLUCc4xVrRd4nT+0rBPgDBd2nHP4McodlrGhaBEVBdNtE7QEXE39k+gW/JlTXo7Uel/TmfwD0JOUT4svty9XZO9ZMSFbfGEVWsLNJ5FqP0maUA6PmfNA9IT9NkI6ei5Rk7YH7NEUZtWCD5XSmQ0kQyFsFgqXxLUqI3i+ijzQ7lo4we3GQUb2e9vj6oDXLac5y9ZEou9x4XvQagmGZiJhNVSohhwVGvAD4VASk0SMUOWeenmfcr7oazT35yv/nhaKAtHlyAF9MZnJt5muYnlq4XLagfsB5OmiekjNEEQcQuf0H6p/uuqtKmenRackaZ3gQ9WRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uC0forVM7JtzMMwJqqhAxTq1TGPMLkVXRkxGWiiW88A=;
 b=LODaR25DDdiQTlHHCaOGhUEGy9+OD5lc8l6pINDQ/6FA+qcAYvhTQY8TzBSrmGkdX5UOAbEx++8wq5LP/VqT6ipdyyvvAz5+WiY2DC+jKLRbUH5odEgnpALiVO9iZFpUGkRg/O5LTgASXw7ruJ/RYYqzIFONgsM7fcipOEm+as5aufuviCVg6RIS6d9C/tA8LkoZ65nDweDsKRQ7v67zj5NqjE8TTR37yy8EymULP5cy58T2EFu69QvxaNwhX/IUf5MpP5hkZ0/qPQ49yXYibaR4bl9ZMeBLYxnMGZ3T9eFseDE4uPXVCUKE228I2xGh3KQ7tV3B3z1WUzQCfe3gkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6124.namprd11.prod.outlook.com (2603:10b6:208:3ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 23:03:20 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7202.034; Wed, 24 Jan 2024
 23:03:18 +0000
Message-ID: <abf569d6-9634-424f-97b3-a71716b3cde5@intel.com>
Date: Wed, 24 Jan 2024 15:03:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Fix unneeded variable warning reported by
 kernel test robot
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
CC: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
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
References: <202401241810.jbd8Ipa1-lkp@intel.com>
 <84128a3c83654493f637b8349153af10d69e2752.1706118776.git.babu.moger@amd.com>
 <39c4501e-4937-49de-b12b-742e6201df6f@intel.com>
 <20240124183153.GFZbFXmTKTLEpwZshW@fat_crate.local>
 <e96df7ac-f0b4-4300-8546-7c1df836dea2@intel.com>
 <20240124191429.GGZbFhldYr3K85H9cg@fat_crate.local>
 <6635c607-cab2-45f4-a0fe-ff4f53b36849@intel.com>
 <20240124204525.GIZbF25bekUME2flt0@fat_crate.local>
 <7d6e3d39-ce53-40e4-bba5-242911a1522a@intel.com>
 <20240124224657.GKZbGTYTjN2m8VirbF@fat_crate.local>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240124224657.GKZbGTYTjN2m8VirbF@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0028.namprd16.prod.outlook.com (2603:10b6:907::41)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0095ae-9b5a-4193-29bb-08dc1d30a70f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I+jXjQxN38s9NPpPUG9P1mPKaS5UfgfnjLDg9bhXZe3BFYkKKhDw7+j9waD79axFhDYIrrvf9oZjJWzXd58YFA43ShpnycV5xpADstrC9e3dhFIQ9l7xJ5EQC/pHtvU8X4uKxWv1KCwPEqz0VZSr808mryxCaLnaXhhrtSTKer9PJTAsF3/W805F26GuXNaUrY6E/PwcxY7LASRAA/14XmAy40GawPMeDtUxcaSOLxLkU/tqivt2yWGjWP2WtviZZumWolOCj7bYRAUY/XzfpUNLcM7CVOJ7udlNe6liEP2+rwGnJ4Ttn2jii29WlpZggf1lKW3zQbCW/amGvCD7e6TcfVPGYLkC6VFE1rxYTuru8yZMbLmz0BbOwTRqgqHydiwK6u+Ej4muDut94FzacW6gqnjAEiEpDln0Hv2JoTNwnJD4B2a/i0S6muYr3U1dMhRuXupMvE9g70ZSGjJoFdBoY89ITOJyGzKNU8L5Sz9WGxQp4b+FyT79+6A+yDrIAfxtVZKkDTwBE73POHJrbkAic7FCM8tldogSnixVS9iWv2HbbN9oKC5kZyDDOMY4slsByQOR8A+G7q1FrO2zaU32lBdG0R+QBcOpqLO+2BGGVuMd615Oqd27JqoykhtS3njOFkRlb6vDSrg91V5WFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6666004)(6486002)(478600001)(31686004)(38100700002)(6506007)(6512007)(2616005)(26005)(53546011)(83380400001)(82960400001)(86362001)(36756003)(6916009)(41300700001)(66556008)(66476007)(66946007)(316002)(7416002)(2906002)(4326008)(8936002)(8676002)(31696002)(44832011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWwwWHNnL0JIU0hmK1FoVU5pMy9mbmhBNis0WG12Uzdxdk9XM2NUL3N5Z3hD?=
 =?utf-8?B?dnNON3hVemY1YVFTQ0lpVVMxQmhNYTJiQklWRDBaUzBreWt1Vk1aK05MckhX?=
 =?utf-8?B?ZXBEZ2hBS0N3SU5XaGlpZkR4RU9uQk94N1IrN24xMmk3YU5FVHJYT0VvVU01?=
 =?utf-8?B?UlN6VHVFaHRRZm9IV3lsdTE3cUt5NjJiVkpNZHRvWWdWWTZjZ0VueTlrdlZw?=
 =?utf-8?B?VHV1MzFjeFlpbVR0UEJZYSt3WFBHQ2pXVHhrOEVNMm5lb3FwWjNINkxkRG95?=
 =?utf-8?B?ckovVVN4OWR4RkJLbEtqYXA5bXMwTkF3K3hudzJXQmpjSDMwVGZUcEFRTmZG?=
 =?utf-8?B?dkc1QVBxaThZNXVHSk9KVkJsbzgyNWlvRDF6MkE2dFlpT2ZvWmJmTEFPRlB4?=
 =?utf-8?B?ZnFHSXBXSTc5b1ovUEwvbkdMbnlpeXRlTDgvRVlmNkt3NEhNMnl3aDRLcHhY?=
 =?utf-8?B?cy9NNWNPUlpraFNrVEQweHp1NWRTRDdoaURzVmprcmdJS3RVN0hTanBkMFZm?=
 =?utf-8?B?eWtPV3lUWUMwOVQvTFV6WmNhY0ZFLzlJaGNkZVA1NjhCaFR0VXN1SkRVRnFy?=
 =?utf-8?B?eFREdG1XaTVXY3VyMDFJYnFYZ0hleVpnUEM0eXVsb3dMVUI5b01VQmtkY1VZ?=
 =?utf-8?B?LzE3VlRLSVo0VVJBTUxVZGFZTWNXa3prd1BXQnBVWks1VXBDdnJQR1pLUUI2?=
 =?utf-8?B?ZWdQZGNYQ3lIOTB4UzRMaDBxaW9YcGhuK0djNER4L0NMcmdpaEtUd2g0dUQ2?=
 =?utf-8?B?dHZYUnM2bCtjSkdoVU5pZEpuM3haRENRa2hIUWRuWS8vOW93VHpFQ2FZa0RU?=
 =?utf-8?B?bDZJakthclBLMGZMYTc5S1JTSUVLY09EdnVsNGdaNkk1OVBYWk85Vk5UZWE0?=
 =?utf-8?B?WmNDRWZHTnZkdWUwNWhYOC9FUzV5c25CcldyaEgvZUIzaElPRm9wd2lKbWhv?=
 =?utf-8?B?Nm8xL3RwbTRUL2J1TXFPeFVsMlJpVWJybTJhdHhtRVhZNGxhbVpBN3RnbGJZ?=
 =?utf-8?B?dmQvSTk0Ly9KaDBEeHo3UThNdG5YUlV3MWdDNm1oVndtQWFGTWlIR0pRalZK?=
 =?utf-8?B?OElXN0luazhnb2VZT2NoRHFBdGNlQTdPRUxTYzRDREFxcVdQUEpyMnd0Sy8w?=
 =?utf-8?B?N05wV1RnWSsva2ppZTBBNGlFUE85WFFYRXJrV3BOdzZxUFpkKzN2UDdvazJq?=
 =?utf-8?B?SGxlM1EyWlVvZVUrcmtXNFY2MkExNEZVZ05WTEtFYm9VaDhOaW5pMTlYT0o5?=
 =?utf-8?B?NlJwZnpON3I4aFRXMVYyRGZtYUdmdTUvVmdVbkdCb2xqRVBlNm9GTng1ZzVi?=
 =?utf-8?B?R21yLzg0RUxlTENNY0ZidGNrVGEzTll4T1VoY1lHVXFXeHpkUTBNaTJqQWRF?=
 =?utf-8?B?a1p2dXFYbiszK1htUG90N3R1eTNyaDk5TnNoT1dsdlVrZTBDTitlbGkrZTJ0?=
 =?utf-8?B?R3pXajRzRzhvNVc5RXhmWVlnc2dtbVBjdm95RVBrLy9iYnpYWWlvWmZJNmo3?=
 =?utf-8?B?UnM4MEZEMDhOcVI5RTVGOXk1ditZVVJnRisxVTBGZC9Zc29NdWtTcWJFckgx?=
 =?utf-8?B?QkJnekJnYzdZWEt2QklOSllMMCtuSmFxTnNGVU9TaVV6ZXVuK0JZNFhkY1RO?=
 =?utf-8?B?N25Ea1pJSEtXU2pnb2hSZE51bHJ0RHRMZHdoanIxcU94aU9YUVlhblQ4aW11?=
 =?utf-8?B?b0pOSmxNYnJ6R2prTlNIeERGRi9DbmJwMmkwblFBR01TblcvQzdJSllzTXB4?=
 =?utf-8?B?aHVvLzNMTjZwMG1wc1lsakp1OUYxWUFUTjY3YWt2VmQ5dldnbG0rY2JkZHRx?=
 =?utf-8?B?WkpQT2xwWlEwNXJXOGprTFg4ekVSZi9YeDV3RWZpYjZnc2NzeVVwOGhCWlR1?=
 =?utf-8?B?bTRzZFZRc01jL1k2c2hJaHVKSzZYNWRhZ3V6Y1huT01RdFA3V3hjR09WYnZO?=
 =?utf-8?B?RlgrbktRWm9KOEhMVGV1U1ZwYy93OVNpN1gzeDRhMkZSMTd6b0J2dHk3WE9L?=
 =?utf-8?B?VW5ScU5QQWRUdlh1NEc0L1dTWFlDVXlXWmkxZzVKTGF0cHBkeWFMeDNtVTB6?=
 =?utf-8?B?S3F1ZXVzTk9FZk54NXdCWk5iTnJBSzlva3pUTU95UCt2NVB4UlVGaHJ5MjIw?=
 =?utf-8?B?VVQrdkpiY2l0ZnZwVFJDaTEyR3FwR1pqWDlFZDVpZWd3aUNKaUlhZFRub3Y3?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0095ae-9b5a-4193-29bb-08dc1d30a70f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 23:03:17.9846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1q6WHywadMgOZxuOh/P9PJK2ZPzUHWcEuK/L/rIeWsfl5uU8LN2Em79/yyRD8pTIoh8LZw1c8P1FcT9fZ9EdxQMU7YvPPGnASfNr/SsBVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6124
X-OriginatorOrg: intel.com

Hi Boris,

On 1/24/2024 2:46 PM, Borislav Petkov wrote:
> On Wed, Jan 24, 2024 at 01:31:01PM -0800, Reinette Chatre wrote:
>> I do not know the motivation for that requirement. From what I can tell the
>> change [1] that added that check went in as first version without discussion.
>> [1] starts by saying that the format is "preferred" so I assume there is
>> some history that I am not familiar with.
> 
> My main goal with commit messages, code comments and every other *text*
> you have in the code is to be as succinct and understandable as possible
> for time considerations, clarity, etc.
> 
> If I see a 12-char sha1 followed by a title, to me that is a commit. No
> need to say "commit" too. But as already said, if you prefer to have
> "commit" there, I'll add it - no biggie.

I totally understand your sentiment. I am just the messenger here.

Without the "commit" this patch triggers a loud:

ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 92bd5a139033 ("x86/resctrl: Add interface to write mbm_total_bytes_config")'
#15:
  92bd5a139033 ("x86/resctrl: Add interface to write mbm_total_bytes_config")

I usually (unless, for example, following checkpatch.pl advice causes a change
to fall out of place with surrounding code) try to format my patches to get a
clean slate from checkpatch.pl with the goal to eliminate obstacles to the
patch getting included.
Since you are the one that decides the rules for inclusion you can make this
check to be one where checkpatch.pl can be ignored. No objection from me if
you choose to do so (and I will note the precedent for future patches).

Reinette




