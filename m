Return-Path: <linux-kernel+bounces-158290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0DC8B1DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B5BBB21D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21221127B64;
	Thu, 25 Apr 2024 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hm5W8xtC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C52E12C463;
	Thu, 25 Apr 2024 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036930; cv=fail; b=j6vUlbWxrqztufHuZjY5a6UpT9LTY2+Uen+ZMLLmmakaurfBLx3nb2X8gp4Tdg3aaGz3Y0ZpfVSKjusIhTzG+r27VYG1batHtvgYcDXrfsIY1DXmW2EaW/LNQBi/n0fqmD1VMmeQXqXawCRxRQwcZYnT/OdO6OA7BQC/p71lzEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036930; c=relaxed/simple;
	bh=SJSD3UlMPxIRvNqk9O0MoXm+iRGKTpbkKwctW63d830=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kTHrXlo01pL771YOJ1MO3HxGIXFcmT7jAs+16nPZH+5Y723/UsZFv8paNOME9IVLxJveaPiq2P72Ts3dlYfitdKS4882bedPesoIUPO098zjr/UFeXqdlsSy/seLzro1SFC5INmUNX/A6mp7fXUisNcbXoF/8Bo3oVgWZs8PvM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hm5W8xtC; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714036927; x=1745572927;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SJSD3UlMPxIRvNqk9O0MoXm+iRGKTpbkKwctW63d830=;
  b=hm5W8xtCzruGuRsUoN2Z9dBelCqjkWYMdkBjJEM6IAE7UaJV8Xg+yYvX
   cIdh4IKjcrN8Y7Ozta5ASHMxpdqgsbb6mTcBv3IIldsbtsZLg5kZKgnXd
   84R0GfVj5NlHduF0UJHEeZPVUS1TpfhkzpCgqqY0bpGMLM9H793WO891Q
   1mFbSBBGewZG/1d5WKFbnMAGjDNy2ELefdTL6q9749DZ09dZN/enHv2jX
   zZh0K6zFcD3vQ6soawqWTArO+E40AEg3R9p230WTHP4d/i6TzBQZUY6NL
   r/Jy9FpNNEKaL1Ah8oFwyg+HLub02mDuFPTxAPmSrqEEHz1A3SfjkR0Hd
   Q==;
X-CSE-ConnectionGUID: wlAo/ZEkQ7+nZ1hhL3DhPQ==
X-CSE-MsgGUID: 3pMLpPCEQGqji/Hgwqmuow==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9557959"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="9557959"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 02:22:06 -0700
X-CSE-ConnectionGUID: tzNrTW2FQBa2xaAaTAAcEQ==
X-CSE-MsgGUID: er0+fKxBQ4+Cz1vHUjm+mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="25001215"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Apr 2024 02:22:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 02:22:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 02:22:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 02:22:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpVhkwD1emtSxuCLxDzFhXwm/mk1uwUzcJ7yGFTG8tgt+snSYQWsuas51mRbXhOzc3PLAF42ZqejNgJC0yeL0GKdI9Pvwmgc8MDKMuxlEZko9PlJHPX2ny0V5mR/6CdBcbn9zOezPRYABybh6XhTiUhHvGrwR6LX+bOfsd9v6Oco1AJNKYanT0lajCQIVIZgyAAXkentuU9UNT7IM5psOuEs6D70V/ZZprc9S6zp/5e/K7F4NQQzu+fhdx8vRP2A9RkEtI9M7xiGBkYhnM+dknFyC4Xsz0r4fJKto5LLQFxocChUlEKWYNqh4QsHkRfjkBHNgjEBxFbAyM+giPJExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvyjwpvJ6FJrTwrjbh4EaVWL2XCid88dx2dJZWaTfrc=;
 b=oZ2N58QoYGhw9KhccaHnunFz0p9r6Ko3+OBI3Cs2wo14UZhB1hlnYmrpOlwLUGgF54PJoE9CXHWqco9DBzqQ1XwISuAg8w8aIedXAqUwypdOkoJrVyoHjzdtQW3qiee9Pc4ePynVewiZJltSsWUvm381g4y5KaAwSprA0RlB8RsyTdLmIPs0cVHnbpqohD0SQh2FciR7STv7uo00wMIZCcz/kRbblESkXb6nonAlmvBUnYkDEtqovm4HYaf9QtOJtvpt1RP+VBRYW4lZf8A6T6OljiVU2hghUMqToraei2d0CYlwfbFmciWw5wfIM8LwYyl5MWQzlpTcS4nbCcOj7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM3PR11MB8714.namprd11.prod.outlook.com (2603:10b6:0:b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.22; Thu, 25 Apr 2024 09:22:03 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 09:22:03 +0000
Message-ID: <fa7f3c1b-7693-465c-9f24-e6176074a818@intel.com>
Date: Thu, 25 Apr 2024 11:21:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To: "liuyuntao (F)" <liuyuntao12@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <masahiroy@kernel.org>,
	<nathan@kernel.org>, <nicolas@fjasle.eu>, <peterz@infradead.org>,
	<jpoimboe@kernel.org>, <leitao@debian.org>, <petr.pavlu@suse.com>,
	<richard.weiyang@gmail.com>, <ruanjinjie@huawei.com>,
	<ndesaulniers@google.com>, <jgross@suse.com>
References: <20240422060556.1226848-1-liuyuntao12@huawei.com>
 <8cb7f43e-0ee9-423d-ad27-93b3c69809f5@intel.com>
 <d129733e-6c53-41b9-ae23-4a97c4eb5a30@huawei.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <d129733e-6c53-41b9-ae23-4a97c4eb5a30@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0044.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM3PR11MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: f59fbac0-9336-4d97-1769-08dc65092b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVZoQTVOK292S01kaDE1akhUdWJ0N3U4OEVmS0c2b2MvK2JKbDg1TytzZ3BK?=
 =?utf-8?B?Rk91Z3RoczFpUG9vdTlybTY2d0Z2Kzd1MXluRUZwL0p0TkZKQ0NENlQ4NmlF?=
 =?utf-8?B?MGUzN0loRXVaek1zanBEWVpVSW1CakZCUUoycDJaWW5DemVCNzJETzRVNGh6?=
 =?utf-8?B?V0wxN0kyV2kzOWsyK3MwNVdtWW1WRk1BQWxwMzBDaWNVM1FUMlR2dmVRNlF5?=
 =?utf-8?B?NFU3ZDhYaFpWRDRmdFdsWmJla0hQQ0o0LzRFL0xZcVBmRUJEcmtiQ2hiNFg1?=
 =?utf-8?B?RkVlQy9vc2YycjJEWUx0enNac3l2Z24zMzMrVEZRRW1hTXdrVFdQZFpwbm5K?=
 =?utf-8?B?OVIvZnU0YmxFSTJ1WkoreWM4Z2dQajNzYTVwS2RJSGhkSDNHQ28xcmp5b1Zk?=
 =?utf-8?B?dTVBTWFIazBSMVlYVjhFRjVVNWtLK1ROSVlQV0RGOThvS0dBUE9xa3VKdE9o?=
 =?utf-8?B?andKNVJhQWFCU1doWWhHWERmSzdGcklrb2UzcmNDbVY1Q0hPVDgyc3AvdHcw?=
 =?utf-8?B?Unh4am1ESkdWazRxUkVQOXlyKzJ0OEkzS25YVzRBdXNhR2hjTDhpejlMUXB6?=
 =?utf-8?B?VTZuMzVQMjdNUFZ3dnh4d0k3aU5yUUpLVDdZS1hLcFEvTTRUNVd4MDJRdm9S?=
 =?utf-8?B?bitYL0FzNTZDNWJHb0FobDlLZHlJWlloQXdIYVNoMVFhbzJVNUJEWlJYdk5N?=
 =?utf-8?B?RExROWFSdFczMkhzRk14Y2RvRnVhSWR4ZXhIcWZHUnk0aHkwY091bDMxZ0Jh?=
 =?utf-8?B?dVZlTHRlRU54c1MvbnlaTUgzQXFRZDV6WEd4NkxMdTVjcm1KaVh5eDhSbHZR?=
 =?utf-8?B?VjNiMGdjY240b01XUGh1YWQ4UkNOM2lzWXRqUHNWNzc3dW5TZ2xTdTFtK05k?=
 =?utf-8?B?cm5RMHVYZkI2TXdwcEZyZVdpanJPQkkyYSs0ZXhoWVNGTlRzZ2JzOERrMFU3?=
 =?utf-8?B?T2xEZU1YNHBCOEs1SHpUVDJaVzZYTW9YakNBajlzbjU0SVlNRHRJR1IxdkJm?=
 =?utf-8?B?Yzg2ZWlyMFRuc205bHhTT2ROK1FFMFkwTUpuV3BlYkg1MVZVOTlhbHVjZG1G?=
 =?utf-8?B?WFR0MG1EdEgybnFucWpGYmlQZ3YxcHBDNTMvNmp5SnFZYnNlTGdpS0ZMdDJv?=
 =?utf-8?B?MUJ4NWwyci9pd2phY09qYmhNUlFZOHdyaVhvUGRXRGg4SDJUczRjaHQrYlNK?=
 =?utf-8?B?VVcyTC9hNEdvR01PdVBEeXM1dVF5ZlBNeDdRNjh3dytYT2poNy9oSEg0c3c2?=
 =?utf-8?B?b3gxdndxbGxYSURqcW5pTCtpZ3d3UE9QQ3pDb2NLZlVxckY2VEgvZHFQdVVJ?=
 =?utf-8?B?cVhLMnRUd3hGb2JCcWhrU2ZValJra1JvTWFodGJ6UGVqRXZQSmZibzRpdlJW?=
 =?utf-8?B?bk8rbmhWSktVRTdyN2R2cXU0d1Y4MkhRTkJQZE5qS0xNdGRRM1pPblJpMEE4?=
 =?utf-8?B?MldkaUpXZnlFU3ZaeU1maTc2b1o0UTIvMUcySk1qNTVmY1ZvNkJZMXgwNnYv?=
 =?utf-8?B?dDUrMU1lWmo0K2Z1UTU4NThneVFVZnM5K1F0bEdUZGtPK0dpODJrOGsvY09i?=
 =?utf-8?B?bEVoaW9XM2tmeXBpa0ZpNmowZmZDTkZtY0JqbnZrM2JkTVNCZHN5OU1MTHlU?=
 =?utf-8?B?ZXJibjlBaDBNM1I1YWIwMUYwOEljcnlYSTM2Z2lDWmJPRzFPejduRHRpRUFm?=
 =?utf-8?B?T2JoVXlTaldKMHppeTV2c1VqMkZTTExhNVE3bGFzZzlVdDFSWFJocWVBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0RhVjQ4T2MyZVplSUl2WE1FSi80U0ZGVDJlckVNb3hwOTIxdi82UDJTajNP?=
 =?utf-8?B?WGMvRm90dlFBQ2t4KzZkcWIvYlByMkxPcE9Jd3psOFR2YVBaUE1jOXhiampm?=
 =?utf-8?B?U3dSSnhSNGx5OUlRZHNRZTJ6MzIyRkxmeEdWOWFUUllZc00rYkZDWjlhYzIw?=
 =?utf-8?B?U1N4anpDakFab1BLclNRbjZ6UU93c0Vib3JHeDBPeGx4djlSY2Z4Q25VdGRo?=
 =?utf-8?B?VjY1clNyOWdpUEhsUUdLYURkdUFSMTQvaG04cDV4QVpoZHJOTVBURjFwS0lr?=
 =?utf-8?B?UEFra3Q4Vlp2ZTJrWHFlVGpYYmYwcEJSTWNRUjlYNk5HaWduM2grRG1JRDJ3?=
 =?utf-8?B?elE1dDE1TVN6WlVLWVVtT1A4Um5BSHlKSk5lZjNqTmM4MUNqZTBUeDRLdFZl?=
 =?utf-8?B?aU9JL01LdmhaUEdsSWpGQlFhb2lTU2JzWjJTRmh3SHd2dFM0RWgwazFBd2RQ?=
 =?utf-8?B?Mnl3dDFDbURTcXowem9EdWx5M3pEVmpxYXhHRmc3cTFHRGpjQkYwb0hrbGtu?=
 =?utf-8?B?bXRISURHM29lSVJmUERhSFRIdDR0a1Jvc0R0b3M4MkNHODJKM0NBb0RRVHRX?=
 =?utf-8?B?MTZtSk13MnhkNGVYRktoTCt3b01vWk1zN3BBOGd2N1RCaEtuZTJsbCtPMmVD?=
 =?utf-8?B?TSs4RTllK3J4ZEpKWFdCdFhCWW1wZEZkdndHZVBsSDlRS2NrZDd0RUFoRUZ2?=
 =?utf-8?B?U09CWlhJWVpCZEtZZ3R1Q2RaYi9DY3pEZlVTeERaK0xQUGF0N0VhTHFCckhD?=
 =?utf-8?B?N1ZhNzhJTFRvWldmWlBzeXJiN0ZKcG4zRjhXekp4RVJiSFRhd3dqYVE0NEQ5?=
 =?utf-8?B?bGl5cHpvdTdoeVJiTGFaeTZaYk01cXAyTEFGd1puQWF1NWJSRDUzdWhocThM?=
 =?utf-8?B?QXl6WTFyRDA0eTZVcG83SUtsTTg1dFR1Zy8xeFdZYTdqd3hzWUVFbUZENjl0?=
 =?utf-8?B?bEh5RitLVnBkZGU3TWc2SC8xNkg0WWE2M3l6c2FkbTNFRlg2a2MvOUJzZVEy?=
 =?utf-8?B?WEF1VEF3ZWMyUFZObDYwTW1PdG1yTldnOHFNMUhPME5PSE03dEdzbStmVmVE?=
 =?utf-8?B?UEdpUkJvUTA4N2RnODZhU2ZoemUrSmxwRU8rM3Z6ZWtSNTY2WHgrbGxiSXJp?=
 =?utf-8?B?ZFVXaXBTUzJLa3ZRbHhFMUJzQ3EycFZPeWx0UC9tWUlVczlyUHN4ZFlxU0ZF?=
 =?utf-8?B?SklTS1BSNHUyd25JQTViTkRWODI3L0p4S25WbEZBckFsMGpKSFZHSmV2anZp?=
 =?utf-8?B?bVJpVStsNkQ5aVQxVDVlVXMrTkliWSsrZXJUUk9xYktDaldlc2JaQkxhemtk?=
 =?utf-8?B?bUZiNFFucktabVNFZWhmRDZJK0dyNjI2eWsxZ3RJTGNGQXFjNEhKRzE0VXlE?=
 =?utf-8?B?aGEwR0dyUzlURmdGWVhqTGRuazBZc2h0U0pSL2diQXhXYTZFaCt3NUE5dFdO?=
 =?utf-8?B?MDEwbEE5eWF1VDhNRHY1emdzbTFsQ1ZLdmQ1THpzaVlNVmF4WU9HTzFEUjVS?=
 =?utf-8?B?MmhqVlZvTjJDYXR3bmI0ZSs0RnFUbmJidkpSR0FLZVZQOXZ0VGFDWWl5OGU0?=
 =?utf-8?B?QmZPOXFIRkVQdG9lbnJiZEhUSUtnTEc5WWYwVjBoU2xGVmVMRWhvbTg2dHNT?=
 =?utf-8?B?NXprQm5USnQ1dUplMWNOaXFOTVB2SmhwM3JVbFBKRFFoK0FmRVNVZk0yZTRu?=
 =?utf-8?B?MThORlZvZ2lNN2J3RlZlM2NEeksxV3NMK3ZoZ0lpa1FmdG1kM3c4ZlZjZDNF?=
 =?utf-8?B?aEtDRGNNRldDaUpCQnRIOFhmNGxCcm03TElSYWJ2bmVYNnUyTFNGWk82ZjVN?=
 =?utf-8?B?M0wxSEZwNlRIMlRpcHJvRzZRa09RdTd2QzZMK1lUdEZTUWQzMHp2R2hmeHlE?=
 =?utf-8?B?aEF4RWhSMGdLUkZtQ2dLTnN3U1ZVTXI0WHVOeWw5dHlKdnFxaHF6cjBWbXNp?=
 =?utf-8?B?cnF5NWRJRjVjMitoZzljb0FxMnBNM1FqaEdybmZiOFRnblpBVFRHanJyaFd4?=
 =?utf-8?B?K21EaU5XZlZDZHFJNDlKSmtOempycll0TllLWmxsQXdUYWw2YzhSL1hHOU4r?=
 =?utf-8?B?aUdYakVPUHd3YlFBOTh0bU1FN1owajFIUUd0VnVud3FMejBFWUlzUVhZakdt?=
 =?utf-8?B?WTRqNWZJZWd1MXg1a1prWU9GRUg4dEhlWUNIdE52MDZHUWFhVURvT2N2NFRS?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f59fbac0-9336-4d97-1769-08dc65092b2f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 09:22:03.5500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgyAeyKBPuSrS/o2yC3nkNBy7Z+Q6SZEabtCad2p/kfNZndNLl+Ql9mPl/GXPfniHUC+9q1B5jLczDNwrj3mVgh8BiinbeUF0xmHPK5Id0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8714
X-OriginatorOrg: intel.com

From: Liuyuntao (F) <liuyuntao12@huawei.com>
Date: Thu, 25 Apr 2024 14:37:19 +0800

> 
> 
> On 2024/4/24 19:06, Alexander Lobakin wrote:
>> From: Yuntao Liu <liuyuntao12@huawei.com>
>> Date: Mon, 22 Apr 2024 06:05:56 +0000
>>
>>> The current x86 architecture does not yet support the
>>> HAVE_LD_DEAD_CODE_DATA_ELIMINATION feature. x86 is widely used in
>>> embedded scenarios, and enabling this feature would be beneficial for
>>> reducing the size of the kernel image.
>>>
>>> In order to make this work, we keep the necessary tables by annotating
>>> them with KEEP, also it requires further changes to linker script to
>>> KEEP
>>> some tables and wildcard compiler generated sections into the right
>>> place.
>>>
>>> Enabling CONFIG_UNWINDER_ORC or CONFIG_MITIGATION_RETPOLINE will enable
>>> the objtool's --orc and --retpoline parameters, which will alter the
>>> layout of the binary file, thereby preventing gc-sections from
>>> functioning
>>> properly. Therefore, HAVE_LD_DEAD_CODE_DATA_ELIMINATION should only be
>>> selected when they are not enabled.
>>
>> Dunno, I have DCE enabled for years on my home kernel, see commit [0]
>> with both ORC and retpolines enabled, and I didn't have any issues.
>> vmlinux still shrinks well, even with Clang LTO.
>>
>>>
>>> Enabling CONFIG_LTO_CLANG or CONFIG_X86_KERNEL_IBT will use vmlinux.o
>>> instead of performing the slow LTO link again. This can also prevent
>>> gc-sections from functioning properly. Therefore, using this
>>> optimization
>>> when CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is not enabled.
>>>
>>> The size comparison of zImage is as follows:
>>> x86_def_defconfig  i386_defconfig    tinyconfig
>>> 10892288           10826240          607232          no dce
>>> 10748928           10719744          529408          dce
>>> 1.3%               0.98%             12.8%           shrink
>>>
>>> When using smaller config file, there is a significant reduction in the
>>> size of the zImage.
>>
>> [0] https://github.com/solbjorn/linux/commit/25c4953ea73d
>>
>> Thanks,
>> Olek
> 
> I apply your patch, and use LLVM toolchain to compile the kernel, it not
> boot on QEMU.
> I use the following command.
>> qemu-system-x86_64  -smp 2 -m 1024M -nographic -kernel
>> mainline_linux/arch/x86/boot/bzImage -hda rootfs.img -append
>> "root=/dev/sda console=ttyS0 rootfstype=ext4 init=/linuxrc rw"
> Have you tested your patch on the latest mainline version?

Nope, it was a year ago and I haven't touched it since then. Did the
low-level code change a lot?

> Thanks.
> Yuntao.

Thanks,
Olek

