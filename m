Return-Path: <linux-kernel+bounces-168412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8518BB849
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515FB1C20D84
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A29C84A52;
	Fri,  3 May 2024 23:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HhU1DHPD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2F283CCA;
	Fri,  3 May 2024 23:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714779094; cv=fail; b=kPo5yLpCjY/OWMiY+BfjC/fi0kh70WDr9Vgz5mY5KC7fZbtZmEOMyUKkJjmhU2sQsyCUoGIYZZ965AVOVtPFDbsMQfbQxDtSRDdumWRP1WmLvx+/9Xd3WXD3lcb/uP0nXJcfrBt7d4OYAzlfMKvel4l0Mo6wtvmjgD7qpjJYS94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714779094; c=relaxed/simple;
	bh=pnYeESie8o9AA9uKWhpmaKP/NcuBHhChnM68v+BMBDA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PHvJ3NtkQLbmh7hgDMAYfNKoF03VkG5ficre0scxJGWqKFo3VY4OMfUrv998rEwuFSIc8j2yC7EPtrOILOs11TFkhTEFhSC2jetdKEK6R/qr0b6Vszh3xLawexp3sRXRmp7w+YAB4RdpIYWzn2tq+4CBcn/CrY94uFRzIQq0bJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HhU1DHPD; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714779093; x=1746315093;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pnYeESie8o9AA9uKWhpmaKP/NcuBHhChnM68v+BMBDA=;
  b=HhU1DHPD3LB0DnOMMCo2QWP1z+40WQIlOI2Px8YuYya/rp6Re/GxuUCM
   zLMonMJHpChtXtMa2xHZxaaCcSBMIn8j7Y/q6ixofG88MUmzuItiJuwfN
   LDMCToNtO2U6DUBkQ6HyJhHzool4meEhgUBtBnFSYgycBEQI8p3QtBkAD
   ERU22SaiUrjkjpVXWwMa0dhttHpmaJY46CUL53sUOja17DnIsQ6qap9jb
   aH0rnCDxgkpEXpKCKlYX+pWpQ4XkaTy4fJ3YwKcS0InefwwEDJXgxiaN/
   LHa7XHHlettsA9SMXL+nYptmMNO2xOzvq9/tT/5Q//Q/SrPayf8voBIvT
   A==;
X-CSE-ConnectionGUID: kYJgJ/UsSDqnBjz+0ryIzA==
X-CSE-MsgGUID: E9sjxzHGR1+9gTOkHdKy7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="28133556"
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="28133556"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 16:31:31 -0700
X-CSE-ConnectionGUID: Sq7CwR/kSn+g1JxF6jXVbw==
X-CSE-MsgGUID: KP8W49FmScu6WFdeZ8/8yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="32101400"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 16:31:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 16:31:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 16:31:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 16:31:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vz0qviwXFS1RBFzXxh3mE4tzQzEGuYh7Z6eTimMt6zRO7p1PiQIgaMbWq2QMlsHPmdmmdCJLHEp+oykMhCDzUtHMYTiMQ8U0BQH4FPLVXuPeydC6uZw658L2s7kehx6PK6igtibYncBcfER5B7N0tbZrUdVSQ4sKGI6x5FXXGZGmh4KIHp31fJJPj0F2yj98KYKbxIt+9qUszp467+taJXwKAlmFMygLSdUiwmbtbR1dxqHMbb5nacauZqRVRv9PC5blRrBQssUApBlFGq21yHk4ycUWvDYZ70zWEseEAzhmf1IyGUYRRUI4KMYcm2YV2T2OmHVzC9i8Z+PHe96pFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4p5F1xNd0f/AhjLrJfU7x4xGpBbbCDDYpsKm9gA2Jw=;
 b=hTr/vVfjrge1yxgdNwDsIQse/i78puvP6NAp9n1ZxvJgy5KgysVT8wAGef8n3L8/qea6edpvSsD1A0l6Ue+MM168umoFJzGDFl3ab0SMcIDPEzNJLi2jS1dZsa3CHeaeiN/lGMKiRQvs6ADqxMKo57yLw8P3exQXh8JagVyd8atacDS9gP5Q212ukayul6HG59Em8m5SoCtCowOLGvoAB8tcqEoYt5AuT4+omVdYXMwWUR+wCwy/oitDHoKjvEdZc6NflNmhE7yQGe8x1DYyki00P1McVKjz97zyNklYKVT2RVAakVZVUDYX47ZBialwVCqiX96u3ic4FlzXyFfLXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB6618.namprd11.prod.outlook.com (2603:10b6:303:1ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Fri, 3 May
 2024 23:31:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 23:31:27 +0000
Message-ID: <aec3fdfa-ad57-402b-9c21-555b5ddc85f9@intel.com>
Date: Fri, 3 May 2024 16:31:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 08/17] x86/resctrl: Initialize assignable counters
 bitmap
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
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1711674410.git.babu.moger@amd.com>
 <d9fe6638d901791dfdec26caed034179c636e17b.1711674410.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <d9fe6638d901791dfdec26caed034179c636e17b.1711674410.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0ca415-2c9c-4ab8-f232-08dc6bc9275f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1F2QTFaR2dwMUpMVEFUQ2dRUGp3TExOZGFhQ21vcm0xbUl5cHRGOEtXUnNo?=
 =?utf-8?B?WlJZbFVLTG5CdUgzSjZHaFliaVlaLy9FK2lick9vdmlyc2VHc05hTjcxR2Nx?=
 =?utf-8?B?T2M2MXM1c2Z4bUwrSkgzTWZaS0hqL2laemRMRWpDSjhSZmRERDlQU0JuQTdw?=
 =?utf-8?B?Ymp4UCtiRDk4QXRPTWhQTE1IUllFUEFEeXhwbHVxbm5Qcm1uUmVsSVNZN2ZM?=
 =?utf-8?B?N3FYbUtYMjI5QWpoVjBtRmQxZStKc3MzR2JHK0Ywa2c5ZldSLytjaG85WS9E?=
 =?utf-8?B?N2hsWTJuVkszOWYySloyaG1LbEJ0TnRTVW1TZUViSTd4SStyZjdsQTBxbytx?=
 =?utf-8?B?cXZOSVpubldjUFZ0VGIzQUhJaHNEb29hNHFJSFg0VmkzK1VPTVpydHBhYlVJ?=
 =?utf-8?B?cWNrMkd6cEJLRFRweWNya01Eb2tIRU1jdllsUHVnZmFjemw5N29nVFNUTzcy?=
 =?utf-8?B?eHlpZGx2U1hGZE5udnhqcHBiT0J5TnhHNU9rdkJVS2gya3ZHNk9rUUdnVmNj?=
 =?utf-8?B?VVQ3Z0dIRWlCQlZpK2ZVZHUrVHRTVzV1blUvRkVjSng4M25wL3FqRVBxNzUx?=
 =?utf-8?B?VTA3MDhUUnVOWTBrNWMycXpDRjFMeHVzYTJqVkwxdHpVdytEVEdlWmp1K2Jq?=
 =?utf-8?B?SU5sZzVhaWkwZWVzSzU3VFhIREMvTnJYNGEvVStJUUR5NzExdkloWFk4amsz?=
 =?utf-8?B?UHhTejRhTkpUOFh3U09mNXlQaWNSbWZhc1V5aFFhT2hBRDh0eWdxSVVDMzZX?=
 =?utf-8?B?ejh1Y0dBSlRxMVQwTDcwcG5XdUM5cmpXb2NWOWhpcjFZeHN5TzczU05ld1lO?=
 =?utf-8?B?cWd3aDUvNlJiY1RsM1MyVkFwZ282bnF4NUpsMmJieUM5Y2lRTENkckFiOU0w?=
 =?utf-8?B?ckZ2M1o5REVWdUt5U3ZBUmVkaGJ0TXpwa2dsT0VDbnJwZFFDQVJERU9SN2xP?=
 =?utf-8?B?MkZHcnlBMkRoeU9wbnVJZXFIY0E4WTVJMllEUFMrb1ZGdWNUeGtGSU1xQ3Bo?=
 =?utf-8?B?bkZRUUR4aDQvbUllU2JRdE8zbTJwdFJvWmhiOE82UGhOV1EzenFaVjhaS2pp?=
 =?utf-8?B?dG9Selh3cGY1NGxtYnlDb1hSZEVvMWpIU3FGZ3U2SlRXQzVoWHUrYnZ2eUgz?=
 =?utf-8?B?YVdyeldyNS9CTzlqSUZ3bndkdjNBNjdzWjdoWktYanJqam1tRG8yQklmTVI5?=
 =?utf-8?B?c0lhTnRMRmdSN0NHZmhVdk5La3ExYW1SM09qbFVLT0FPQmdJOE12MkJCVUJh?=
 =?utf-8?B?SUdWNTgxa1hSRSs2ZSszZkNGOHpzNTc1VTdKcHNBU3R6UmtUa2I5ZFVZQmhy?=
 =?utf-8?B?R1VIanQ4ZkZ0ZWxENE9nNVltanFLei84MGxWd0l2NjdxN09sdUsrVzJwUGZ5?=
 =?utf-8?B?K09ZanNjb3NxYVhkV2k0VzU4ZjBPN1VpKzlIMDhpOHpyQi9semdsTVh3T1Z1?=
 =?utf-8?B?SUVSOTlYUHI5QUI3SzJGTHpjdGl1Q0piSHYxc2RtSDZJelhWUUwzMVc3Z1Zp?=
 =?utf-8?B?TG1QS3J5bnRoSXdzVFBvNmJneFJEOUIvdS80Z2ZJZjh3TnhUT0FvbDVjU08z?=
 =?utf-8?B?NXBtcDIwamRseGRiVElqQmpMd3JFOHZNcUJvR1ZmbUFkV2FGSDRZU3NheS9o?=
 =?utf-8?B?QmZSVzJDcmd0RFh5aTZsYlQrWE1yOUJJYjlJV1U2QmkrUkVrVlAvMnl5RmM3?=
 =?utf-8?B?VUovTG5nQUJvUEpFY0t1Q3RMNnVQbnkxMTR6azdBSXdJU1lqTkhjT3pnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QndqUjVtb3lVWFFpczdycVpWeUd1U084VTRncUJYTFVkS0RLTksvMFpIUGNu?=
 =?utf-8?B?amt4bjl1NysxUnpaVW4vUllJbGpZT3VmdlZZUXFjTWFodzVFeTREb2ErN0V2?=
 =?utf-8?B?aUU2WmhzampTb3BWVm5nRkE1cHRxRGwxdGppcWZYRHZFYkpLQmZXUFFKYzFy?=
 =?utf-8?B?cjhCcVhjajl4eTB2K2NpRU5kOS9ZVUhUTHd2ZlYvdVlxTEthNVVkNG5ZQnQ3?=
 =?utf-8?B?Q1pHczVFQlpCaXdwYTVjUnl4NE9LNmM0U3hacW1BSk4xUVhDbm42QlBkZjhi?=
 =?utf-8?B?NEtNRHlvVy9PMms4Zmg5a0pHZVkwZmxyUS8rNzh4NzNaa3hQQUhZWm5DR29l?=
 =?utf-8?B?a25EQlVyLzNkYzhRK1RLNkYzUWJySzM2by8zcXlyMnZVdzhUN2h3ZnNQK1Rz?=
 =?utf-8?B?KzZuS29LZHVhMlRTODZFRld5STk2Q25rTnZPNHFyVjRrWHc2NlNYWTNCZk55?=
 =?utf-8?B?TDZqaStNa3FLQzNCWm5tZml5dldoWW5NdERHcnRPajhjOEtiY0N6dWpicjJt?=
 =?utf-8?B?TTNVUHFRT2Q5WWwzZTRPMGpLMHJzVlJmZHdLSXJ6cDVYVHo4cGRhNGNkUzFK?=
 =?utf-8?B?ZWFsTUJoa3pTTjhkTWwzV0J0KzhMOWdTemYrS2oxU1ZYSytFTE5zMFVjZUli?=
 =?utf-8?B?MkxiQlZrTUNaUS9nNHdCZy80RzB6SEljRXB3QUZObFhHQSs5VEhpTUk4NzRi?=
 =?utf-8?B?aFRXRk4rUC9WcG5sTjFyNFhtcjUreHZZaVFzUWFUdzRHZk9yMzIwOFo4UXdE?=
 =?utf-8?B?L01aM0J2dEUvelRGYktlWFIxUVRVUWhLRkxuUEZBYjRsckJEL0I5YlQzT2pH?=
 =?utf-8?B?TmFHLzluS0xFN0VGOEQ1aGp0T1NrNXMvSnNRN2FGOWcyV2VRR0xZVE56Q2ps?=
 =?utf-8?B?TXhiUE9YRmo0c3lCcFBxUWtJenk0d1pZWUhIVjNvUFgxUnhua1puYjlLQm5V?=
 =?utf-8?B?M3J1WSt2a3VIYUZIV0prWVpZUGxiUEZaYk5TL2Zjb0V0UGQ0a3N6U3N4TklX?=
 =?utf-8?B?Mk1JbzZveXBUbHRkM0tJMVUxaVFyUzdxb2R5UG50VmQ3OUpVaDFhSFpnWjFV?=
 =?utf-8?B?akZ2YURxUmdkbTBJZ1pCQzlZc0w1ODNONXdPVkRSSFlFODd6Vk1ZSXhQR0Z0?=
 =?utf-8?B?elVwUk1pT0JpUU1Iak5LaDk3YU1IdmtYVFVyT2JqKzN4WTVOcDlMbm1FNkoz?=
 =?utf-8?B?K3NCZ2V2S2JHM2xld2JzQ203ckFSVHBFc0l0Znd1OHY2aytHOHZ4YlpCVVJL?=
 =?utf-8?B?aGRIb01GdUxZUGh4Vkd0TGttSnNFUTZpRmRwTVAwSzVRN2FMeWwrMFppQyto?=
 =?utf-8?B?OTJZSXdiTEFqSllJamVpb3UyZkEwZ3RJalY0WmhVampTZS9TYkdjeWVLQUdl?=
 =?utf-8?B?Uk94bFIwSzNoRzErRUUyY2NkVFA1bFBwd0dPY0toaTVZVFVBRytpMU44OWRE?=
 =?utf-8?B?SHdNZVQxa1RGaGxBbkVjZlRlV3ZtNERSNXBtaEx0ZmlhY21VS0xMZFBUQ3VS?=
 =?utf-8?B?c1gzeTZyV2ZGQWRuYU1XdWEwL1NlenFMOUhPbWtobDlNcGkxYlFKVmpkL2RV?=
 =?utf-8?B?RjBIMHdPTmNIcDBHaXdZTTMyS1RnOHVXWWdVOWlXRGtYWU91MHlJWW52YWJ2?=
 =?utf-8?B?ZWg4YzRQbUZzL0RvSHQvNThid2pOakZJRVFiVEt4cDRwZlE0Ylh0aFNLaDJH?=
 =?utf-8?B?MWtKT1M0UlRKa3dBWXZVbzJiR1JRS1FtdEdxR2pNbGc0SW5kb2pzNll2aU9I?=
 =?utf-8?B?angrNXY3TnlFSzFaaWo0ckpQc1ppcmFNRkJVc1JhSjJBTWZ0TEowS0NLTndV?=
 =?utf-8?B?Wk1NSmdjQnFUcG84cEtreGJpTG11OGpDMTZ2bzkyeEp6MUNTbDBvcmw2bDAz?=
 =?utf-8?B?bS9kbTBZSDlaYStBektTN2FDNXlsaXhhRjQ5UzBaRldPZzc0T0VVbE51NHdx?=
 =?utf-8?B?WGZpNDhydjFUb0F3RUZ0MUs4c2ttd2MwTDdvM1FuWjFGUVZoQlQ0UGlVZldS?=
 =?utf-8?B?WDAyeTNYUEMyZWlyaDlKZThQQ0hxTnlrSGlxZGpERW5SRUdxZ3I0d3hka0NB?=
 =?utf-8?B?eFNzRDdZZWNxOHlpMkpmM2RBN2xDNGZpZTgzb0VNTkg1QnhONlkzejhiSHdt?=
 =?utf-8?B?dUZ6ZjlLUjhsTEdtNmdrQkhMYlhGbGJTTXJqbjJCMVZuaXJPQVR0NGNCQ0Jn?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0ca415-2c9c-4ab8-f232-08dc6bc9275f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 23:31:27.4096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgDnaFq0/hyjeW89qZbHAZa0TmDZLkWWyFB4sH250CiSd2g53v6oA2PCzAuM19DMojXH2Hi/lDSb9DEDFSOCormGk6QYB/zK1P2Z1VsitT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6618
X-OriginatorOrg: intel.com

Hi Babu,

On 3/28/2024 6:06 PM, Babu Moger wrote:
> AMD Hardware provides a set of counters when the ABMC feature is supported.
> These counters are used for assigning events to the resctrl group.
> 
> Introduce the bitmap assign_cntrs_free_map to allocate and free the
> counters.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> 
> ---
> v3: Changed the bitmap name to assign_cntrs_free_map. Removed abmc
>     from the name.
> 
> v2: Changed the bitmap name to assignable_counter_free_map from
>     abmc_counter_free_map.
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index f49073c86884..2c7583e7b541 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -186,6 +186,22 @@ bool closid_allocated(unsigned int closid)
>  	return !test_bit(closid, &closid_free_map);
>  }
>  
> +static u64 assign_cntrs_free_map;
> +static u32 assign_cntrs_free_map_len;

Please provide summary in comments about what these globals are and how they
are used.

> +
> +static void assign_cntrs_init(void)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +
> +	if (r->mbm_assign_cntrs > 64) {
> +		r->mbm_assign_cntrs = 64;
> +		WARN(1, "Cannot support more than 64 Assignable counters\n");

I am a bit confused here. The configuration registers are introduced in patch #10
and if I counted right there are 5 bits for the counter id. It thus seems to me
as though there needs to be some checking during enumeration time to ensure
that all counters enumerated can be configured.

> +	}
> +
> +	assign_cntrs_free_map = BIT_MASK(r->mbm_assign_cntrs) - 1;

Please use bitmap API. For example, bitmap_fill()

> +	assign_cntrs_free_map_len = r->mbm_assign_cntrs;
> +}
> +
>  /**
>   * rdtgroup_mode_by_closid - Return mode of resource group with closid
>   * @closid: closid if the resource group
> @@ -2459,6 +2475,9 @@ static int resctrl_abmc_setup(enum resctrl_res_level l, bool enable)
>  	struct rdt_resource *r = &rdt_resources_all[l].r_resctrl;
>  	struct rdt_domain *d;
>  
> +	/* Reset the counters bitmap */
> +	assign_cntrs_init();
> +

(At this point it is unclear when resctrl_abmc_setup() is called to understand
if reset of bitmap may be appropriate. Please do expand all changelogs to help
readers along with how this implementation is intended to work.)

>  	/* Update QOS_CFG MSR on all the CPUs in cpu_mask */
>  	list_for_each_entry(d, &r->domains, list) {
>  		on_each_cpu_mask(&d->cpu_mask, resctrl_abmc_msrwrite, &enable, 1);

Reinette

