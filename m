Return-Path: <linux-kernel+bounces-82868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD243868ACF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C9B28274F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49409130AD3;
	Tue, 27 Feb 2024 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7ixFMo3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E3056470
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022832; cv=fail; b=Ce2rZVW0XmomNgNasYwctEPBhORzDNquBOOYU8WrW0nCZ0Cmay+npe5mYJevlM5/KKgxfh40V9YWapjOcn4Y96dYLXvna2QOlICC5xOm9wuIH+pTgYn3qOh98+3L7guz2HF3IPyv0r9uFD9N2Cq0n42tccqVtLfTijGsFvHXm0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022832; c=relaxed/simple;
	bh=Hs8cfyDloYJje84/RHGAz6QPjeNZU/JWkkD0JX+FCsY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nNWQEMgfTmE3d5dieERDKyDsIvIDuBrdjVWml2xonwckZxBdPcngVDMIatPBbtPy3l384QrwTkjSEYC4uCr0Hw48HP8FiLfXMj2+YT0t+6tEHSZOJlin75ESgYjI0VRXUxPPQf+9JPKiC+PG5Odwah8HPZnSGZ31r04Q8d4ZFeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7ixFMo3; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709022830; x=1740558830;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hs8cfyDloYJje84/RHGAz6QPjeNZU/JWkkD0JX+FCsY=;
  b=k7ixFMo3fk+2pYk0L/33aU1QvGefLRvUcF/XapuMjYoQO/uRtil8DnIe
   QAVteGX3F+bzPGF3vndBO1BiafqXMnr4/hXMu/r2LhhJBLB7e8HIcgMZu
   +40S04vLDfXOxcBPZhWfCCcBpdOMEeGJQsnEXb73MWSxFW+iJek0ptZLu
   nO7Svkm1fE58tOVYlpA1EXSw1isk+lFTr/M0GFAJbVDOIqR+kN1E5SGws
   qjn1J1RdjXh3oyNRONsKciP29HFZlRZPLbS0yxmwaqQ2r7DN9WuGeUiIS
   d2sCAmmPzLCvcXKspLvFwVypoSN/oJlWTN1UI5wuaWpptMkrsqWuEU2b/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3514879"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3514879"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 00:33:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6900883"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 00:33:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 00:33:43 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 00:33:43 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 00:33:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBZqvC/h1bg48NJ3Oo+qHuQ+yTRGyuC8n+iQfglVbyuR3DNYfLCAV/vd1qHgKR/yjgGpm+NmAN5HfyPzMPHBPzm7SDN3oDupRpqfWBEmEKdfyGrtooZmgUBh0X0/0cPZW7awOq46l1f/b676OEiie0FY1K+ZC2rT0tASenTkEHZO426BiFeo0jPzUTjVztRGs4DHeIkLSnQtlKQlBjU7xcjQAfT0sNpTLOC/vdyg/DJYnR0hx+YMDstFcoAmKnISqCaiH908GTTv+LuyEnnNf4otsGitvV/2fn6ULFQvcj6EUt16L5kWv+q/gfR4CeTcXcUCDYXWqNvrA3svyoy1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oi0glK20awEU3yRj2jwXghH02cLtY3jsNFNA98RZgB8=;
 b=DJLyrtBklnUaUM4xcLKOpdIVxToKgdN85vYFDRSIVJILAbhktTE0yJm1hNvNKRN8ppcvdMUgCXgYD38ch2NXjgZiCu2+HqeqDjfOBuN4pQ0F33DNb/O7Y3gI22AgKPAWxMnNREslqbH8obY9pDRfyhUZmPsVN9YBzzSpK77E7/S0lr5XAZjcjVTl1/eAU60LzBlGa7aMWr4oS3pME4qeFY3Tc0GDipWNBN6kvHnh5iNM+BL2C6u7Q7VuO313AfLrv76mQeEGSYrJ5f4cOGdY7bj4+u1MDJI/qFvhfhlKaZzTc80wvWQsQJ/5oKGKmVVx1swrdqQ3pmz+qsMBqtQ7jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY5PR11MB6283.namprd11.prod.outlook.com (2603:10b6:930:21::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Tue, 27 Feb
 2024 08:33:40 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b%7]) with mapi id 15.20.7339.022; Tue, 27 Feb 2024
 08:33:40 +0000
Message-ID: <05f2d04c-333d-4298-8c7a-d5adeac5df82@intel.com>
Date: Tue, 27 Feb 2024 16:33:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in
 madvise_free
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>
CC: Ryan Roberts <ryan.roberts@arm.com>, Lance Yang <ioworker0@gmail.com>,
	David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <mhocko@suse.com>,
	<minchan@kernel.org>, <peterx@redhat.com>, <shy828301@gmail.com>,
	<songmuchun@bytedance.com>, <wangkefeng.wang@huawei.com>,
	<zokeefe@google.com>
References: <CAGsJ_4zera4+bWuXHKjdU3QdiR3sqcUQB3gF08DPD49OCT4S9w@mail.gmail.com>
 <20240226083714.26187-1-ioworker0@gmail.com>
 <9bcf5141-7376-441e-bbe3-779956ef28b9@redhat.com>
 <CAK1f24mdwjz2J5VmeYSDwb4jMbrXUVCSF_0pOcWSVt1cfa0FhQ@mail.gmail.com>
 <318be511-06de-423e-8216-af869f27f849@arm.com>
 <CAGsJ_4z+0yXUDYwxKNAqYwxAAYpfKpKd2u_dVTDP3b-KPOQT1g@mail.gmail.com>
 <19758162-be5f-4dc4-b316-77b0115d12ce@intel.com>
 <CAGsJ_4wx72KOazANBvnGcjdZse8W9+PW5_fspP9=QuX3X_7msg@mail.gmail.com>
 <3c56d7b8-b76d-4210-b431-ee6431775ba7@intel.com>
 <CAGsJ_4xu1kz5VD-CcNFvP0A1nPKDojV8Gy1HPvNKuQ_RAw=26g@mail.gmail.com>
 <6ea0020a-8f4b-44d1-a3b2-7c2905d32772@intel.com>
 <CAGsJ_4x6Otb9LUvnxAaPLnQ2MPPng0xpG-vJmFL7pNm10FDhZA@mail.gmail.com>
 <CAGsJ_4xndYM8=7v+EV_aWX+_qgA1UPmm38n+ujbQXJLzCPKfog@mail.gmail.com>
 <009e5633-decb-4c21-b5fc-58984fbade96@intel.com>
 <CAGsJ_4yftgfD7MsNd5iej8_wTrYeTsAFfW7xmqrj-Q_w8-oqMg@mail.gmail.com>
From: Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAGsJ_4yftgfD7MsNd5iej8_wTrYeTsAFfW7xmqrj-Q_w8-oqMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY5PR11MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: 2832f4c7-41aa-4cc4-7396-08dc376ecccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yHr4xNzg4cbAImEBpnuyD+6XxMxE5h/GgxCZBTGJzPxJD8987v45K4wNSbC1UXHxK8GH0sb+893x4LgY5Z6Dhzn8pzOTqn6phgiTUMMCrocOiHVLSaRYXyLF+Sej3OKOOVxjGm8R08W7IceTgx0kV2HJw8Yl2u2pEbuerGFuZU/nvUmDt2HfZ3zA7AAY6qM6UOkWeFq02SE+bBjhTtIO55w5iE5y/ZiLj0kZBtr7I1ZRKVEwez47fwuk3To3bg5JitxodQUHJlQtu1g6aVWvmMPpQHxYW8LmAw+hPBkT3fDOd+7HBfnBa8ErkZijCWhhA71fyHMYV+BgtwlbsecvWGYoCYHays+NVu0Qz9p+1XmMMmWOAx3ifUAAIDzoSyXu5HJluowh6Pr6UJRrdIPFz78TUTXnJATkspkj2oTyCPjOJPk5dyQxkfLkYnD+NazEbfOBsaR/frsO2cuGPDHkj1eGDf9zSuaE5239RgeVKga4yHwUBVS/SSHOr50hGIGj9LMAdnK4Fcb2HJ5bKr32koub2SXqd2S33/8yP1pyTgQme+KyRDKaaw9dhGOZ6Gayi2D0mF2Ktx904aNphCnuSim63l1YGZYGuOoJyBo+sS6lXSz5R5rXMwvs8wRwdroM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3JjTGpDMU1WanIrUG42Y1dkQ05DdTFzNm1XSk55WTFibWlmc3VQYWdMTEQx?=
 =?utf-8?B?d3lOZDVNVUhOcGtEOW1vdlk0NmdQYVo5QVFrdkZoNUJENHYwQ0xWb3Y5d0dE?=
 =?utf-8?B?LzF2TjJuS3F4TytOTlpZQmtDSUlzYUIydTBCWVJyUEZFVXNTb0FNd21aWWlt?=
 =?utf-8?B?RjVoNjY1anJRb3R3M2RjRHVwcXBaSVc3UzZ4cXR5bGZYdlVrdHFmZnBDQkhF?=
 =?utf-8?B?OXdYNndTZ2cxMEJtOGt4M2dZSWpYY0dITWZZZCthWWVjNm5ha0thUGErc2Uv?=
 =?utf-8?B?UnZZVTRKZkRPbmxtK0pvdHhCOUt3NnZLL0lDa1F0dGwrWHZEalRoM3dOUGw3?=
 =?utf-8?B?V1NEV0JFUzd5NUVFK0lmeCtJTkJtK2FsV0JmL1I3T3V4ZTNnR3p6TU5KbjBV?=
 =?utf-8?B?T2hLbkJyc2hjNzUrcHhOWENRUC9oSVZacWhxcDdzZ1IwZzdMa1MvUGJhT3Y2?=
 =?utf-8?B?U2gxd1JteFZkQVNlUDEyZDV1M0NjM1dEV0pGWDdXdVFYTlhnZjNDeFV1bWc1?=
 =?utf-8?B?YXZEWDV2ejJPMkVSTFY1R0JMcjVkTXlyeHNZZ0NqZytmT0ZGZzRvSW11M2I4?=
 =?utf-8?B?cmR0MkZldTR4ajhJeWI0NjZoMFN4bnUraGs4Z01WMnhDQldiY1ZoS3QwTzNX?=
 =?utf-8?B?MGorc3hZODU5aE0vdXBmaHQyelRJSmNIYmd2Nk5GY0o3c2VSR25OdUgrYWJP?=
 =?utf-8?B?MFVxdExzdlpQU0RmOWU3OEdMWWd6dTdHNUtkQTNaSlZtTXkxc0Vwa2N4bWYz?=
 =?utf-8?B?MDZqN1g2QWVDSmlvMXFIR2ZNWFBOdDdqYjlqVXoxM1BxUnRwZys5TGdseUt0?=
 =?utf-8?B?ak5xSlVyWmtkUlMvWWoyMEhYNk10eEc1VUVNeUZFTjNialN4d1dPdFF6Sjgz?=
 =?utf-8?B?ZURTRUhYZTFHaTVWT0hScGhDeUhRTHlsVThWcjZ5ZFozcHNMS2tFZStpNnJV?=
 =?utf-8?B?azVQWUxsWWd0SUpqb1prY3dhNVhJbGlvdENjTzZMYnd0dXd4MHRHVGZoZDRO?=
 =?utf-8?B?Vk5jcWt4V0JtV3B3cWpGQWlld21KaUtmb1NZT3czZUpSTmJ1VXRRdTFTZDZ0?=
 =?utf-8?B?TytkckRxYzljbHAyWGczZ3ZhVWdCbWE0T3BxRnp0Y0FURmpNcXpoUEg2OEN5?=
 =?utf-8?B?SHNrTFFGUmF1NW9KS1MraW5FOUdHMUM5dlc5R2lzSnRnclRuMFl4YWVSalNT?=
 =?utf-8?B?bEtCNkhQNHdqOCtlR2d0eWsxWld0TVZxbk5mSVN3UUxJSUp1TXZNWE90dDVz?=
 =?utf-8?B?VXpxdDFWaXJPalBTUTF5YjFxSGNCWExrcHFnUlloVldyZFh1QU44eGpSK1lm?=
 =?utf-8?B?ZzJwNWhXQWFWaENvNmEvdGg4ZFljTUJZdC9qNFlMVk44OTdXTnZjRlY3REZ4?=
 =?utf-8?B?ajJZVWxpRU5ONVN5V1BLT2Y0ZE5BcUZKSGxvNTM4U0RHRVRMQWJJeTZPbVNG?=
 =?utf-8?B?UEcwWDVsTmsvUEc4bDJzcE1Oam1xMC9MR2xhK280VFZaSU01VzNyMVFzc2kr?=
 =?utf-8?B?ZldOVXNVVStLSVpsWDg3aVV5NTRUSjJuQnBhUkhTMWRMcWZ3UFdwTW5pOXVk?=
 =?utf-8?B?NVdlOTRkNzllQy9tNjR3bTZxMnIwbWJ0T3VhY0tDSFNhNUhFVE5mS2FtVnNr?=
 =?utf-8?B?UEZ2b1krTUdXMXU1NkJWdzZwQWoyU2NmdEhjSEViZ3hqTEhXNEhHaDhKOGl1?=
 =?utf-8?B?UkMwbEVyZGxadUlmaFJPbldIVmVpTkcrNVVrWTNPSCtlczUzM3lLT2Npdjhu?=
 =?utf-8?B?RlNxZThUM2NkZWliRGVDY0xFVjR6V3RKZkw2NHk0NHhTdzJtNXNVYjFEVDlS?=
 =?utf-8?B?SHl1OWJwKzUxaUVUbTByWFJDcUkzYk90Z2ZscEFFY2x2MVJIOHhqUW9XWVBT?=
 =?utf-8?B?andLd1JUcHkwZ0N0emlodkFtdVlTbFhqRDVtbzFpNWRUZUZLS0NsMENOU0VN?=
 =?utf-8?B?bG40OW9GYUtHakRGMlhhYWdKaDRPZkdMSUVKdUdWZEY4UHZnSlhMcmJaSHVX?=
 =?utf-8?B?cWw5bVp1Q1BPaVJlcFVLWjRlRkhsS1prOHV0SkNBNnRPRDBlSTVrQzk5cDVn?=
 =?utf-8?B?TVJia3NuMDNrTW50eVc1VSszZnlsS0U4QzhObmcvWWJpa3ljVnYzK0JrSUJv?=
 =?utf-8?B?Y1VNU2M0TWVZaVowVDBzQzFnTzg1MGIzeUh1UDN2ZWoyM1lxelJUZWlhWWFX?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2832f4c7-41aa-4cc4-7396-08dc376ecccc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 08:33:40.4087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbe0mINgjwx8C98rxoaHgreY6p9CW7V8xcMXVLrf8z5GRb5PRNF1bIxldCPAR6ym7Z++FDdZmq2T3lQEjMKwlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6283
X-OriginatorOrg: intel.com



On 2/27/24 15:54, Barry Song wrote:
> On Tue, Feb 27, 2024 at 8:42 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>>
>> On 2/27/24 15:21, Barry Song wrote:
>>> On Tue, Feb 27, 2024 at 8:11 PM Barry Song <21cnbao@gmail.com> wrote:
>>>>
>>>> On Tue, Feb 27, 2024 at 8:02 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2/27/24 14:40, Barry Song wrote:
>>>>>> On Tue, Feb 27, 2024 at 7:14 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 2/27/24 10:17, Barry Song wrote:
>>>>>>>>> Like if we hit folio which is partially mapped to the range, don't split it but
>>>>>>>>> just unmap the mapping part from the range. Let page reclaim decide whether
>>>>>>>>> split the large folio or not (If it's not mapped to any other range,it will be
>>>>>>>>> freed as whole large folio. If part of it still mapped to other range,page reclaim
>>>>>>>>> can decide whether to split it or ignore it for current reclaim cycle).
>>>>>>>> Yes, we can. but we still have to play the ptes check game to avoid adding
>>>>>>>> folios multiple times to reclaim the list.
>>>>>>>>
>>>>>>>> I don't see too much difference between splitting in madvise and splitting
>>>>>>>> in vmscan.  as our real purpose is avoiding splitting entirely mapped
>>>>>>>> large folios. for partial mapped large folios, if we split in madvise, then
>>>>>>>> we don't need to play the game of skipping folios while iterating PTEs.
>>>>>>>> if we don't split in madvise, we have to make sure the large folio is only
>>>>>>>> added in reclaimed list one time by checking if PTEs belong to the
>>>>>>>> previous added folio.
>>>>>>>
>>>>>>> If the partial mapped large folio is unmapped from the range, the related PTE
>>>>>>> become none. How could the folio be added to reclaimed list multiple times?
>>>>>>
>>>>>> in case we have 16 PTEs in a large folio.
>>>>>> PTE0 present
>>>>>> PTE1 present
>>>>>> PTE2 present
>>>>>> PTE3  none
>>>>>> PTE4 present
>>>>>> PTE5 none
>>>>>> PTE6 present
>>>>>> ....
>>>>>> the current code is scanning PTE one by one.
>>>>>> while scanning PTE0, we have added the folio. then PTE1, PTE2, PTE4, PTE6...
>>>>> No. Before detect the folio is fully mapped to the range, we can't add folio
>>>>> to reclaim list because the partial mapped folio shouldn't be added. We can
>>>>> only scan PTE15 and know it's fully mapped.
>>>>
>>>> you never know PTE15 is the last one mapping to the large folio, PTE15 can
>>>> be mapping to a completely different folio with PTE0.
>>>>
>>>>>
>>>>> So, when scanning PTE0, we will not add folio. Then when hit PTE3, we know
>>>>> this is a partial mapped large folio. We will unmap it. Then all 16 PTEs
>>>>> become none.
>>>>
>>>> I don't understand why all 16PTEs become none as we set PTEs to none.
>>>> we set PTEs to swap entries till try_to_unmap_one called by vmscan.
>>>>
>>>>>
>>>>> If the large folio is fully mapped, the folio will be added to reclaim list
>>>>> after scan PTE15 and know it's fully mapped.
>>>>
>>>> our approach is calling pte_batch_pte while meeting the first pte, if
>>>> pte_batch_pte = 16,
>>>> then we add this folio to reclaim_list and skip the left 15 PTEs.
>>>
>>> Let's compare two different implementation, for partial mapped large folio
>>> with 8 PTEs as below,
>>>
>>> PTE0 present for large folio1
>>> PTE1 present for large folio1
>>> PTE2 present for another folio2
>>> PTE3 present for another folio3
>>> PTE4 present for large folio1
>>> PTE5 present for large folio1
>>> PTE6 present for another folio4
>>> PTE7 present for another folio5
>>>
>>> If we don't split in madvise(depend on vmscan to split after adding
>>> folio1), we will have
>> Let me clarify something here:
>>
>> I prefer that we don't split large folio here. Instead, we unmap the
>> large folio from this VMA range (I think you missed the unmap operation
>> I mentioned).
> 
> I don't understand why we unmap as this is a MADV_PAGEOUT not
> an unmap. unmapping totally changes the semantics. Would you like
> to show pseudo code?
Oh. Yes. MADV_PAGEOUT is not suitable.

What about MADV_FREE?

> 
> for MADV_PAGEOUT on swap-out, the last step is writing swap entries
> to replace PTEs which are present. I don't understand how an unmap
> can be involved in this process.
> 
>>
>> The intention is trying best to avoid splitting the large folio. If
>> the folio is only partially mapped to this VMA range, it's likely it
>> will be reclaimed as whole large folio. Which brings benefit for lru
>> and zone lock contention comparing to splitting large folio.
> 
> which also brings negative side effects such as redundant I/O.
> For example, if you have only one subpage left in a large folio,
> pageout will still write nr_pages subpages into swap, then immediately
> free them in swap.
> 
>>
>> The thing I am not sure is unmapping from specific VMA range is not
>> available and whether it's worthy to add it.
> 
> I think we might have the possibility to have some complex code to
> add folio1, folio2, folio3, folio4 and folio5 in the above example into
> reclaim_list while avoiding splitting folio1. but i really don't understand
> how unmap will work.
> 
>>
>>> to make sure folio1, folio2, folio3, folio4, folio5 are added to
>>> reclaim_list by doing a complex
>>> game while scanning these 8 PTEs.
>>>
>>> if we split in madvise, they become:
>>>
>>> PTE0 present for large folioA  - splitted from folio 1
>>> PTE1 present for large folioB - splitted from folio 1
>>> PTE2 present for another folio2
>>> PTE3 present for another folio3
>>> PTE4 present for large folioC - splitted from folio 1
>>> PTE5 present for large folioD - splitted from folio 1
>>> PTE6 present for another folio4
>>> PTE7 present for another folio5
>>>
>>> we simply add the above 8 folios into reclaim_list one by one.
>>>
>>> I would vote for splitting for partial mapped large folio in madvise.
>>>
> 
> Thanks
> Barry

