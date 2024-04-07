Return-Path: <linux-kernel+bounces-134625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F7D89B3CC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 21:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06605B211A5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3758A3D549;
	Sun,  7 Apr 2024 19:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ihArqXVb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CF639FF3
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 19:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712517691; cv=fail; b=U7TTnJ6PRu6HWCQyRzGmEGLyYVYotSwby+3BkLu5GDO9ngvXnnvLmAT2okGQxDibgbAJC6oipITpvJSrN45weWx7rwwm78/5+W+i50zD2UOOqTcHwnHWFWJ54tLn7X6xNgxp+DMex5xKdrycPLCMcPuN1Expbgs71SaVZPyneCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712517691; c=relaxed/simple;
	bh=9//U4G35v6e561UW5ZerFOFUS7ecnea+OMQjnbS4e2k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jg2vnKBmeX3r3gJDkq0RNDzSUOiXQcxSWAYzEc4+rEpOYUb3LM25+YTdzVkX2dT+yjqdA7PToTeqL0kocQabwgs2qKgg+eUnPpp9uZ7ueBqK2BG3BCYfFaTi7qiAstziRtXQPEQq88B2CM71WTOGynw7XEhQ0EFVGgsqcRVL8Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ihArqXVb; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712517689; x=1744053689;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9//U4G35v6e561UW5ZerFOFUS7ecnea+OMQjnbS4e2k=;
  b=ihArqXVbEvpfE4SeUddQXWKyBC4bXU7MCf/YbS7V7ARo/3FoXBGQSSGv
   hx/vTdubODOIyKEvYRMUXsNRWehSPjQgNc6X9yMU81INnWmIqnINd2ckZ
   TH41EFMkiwpR+9+angLz7iPULMxf0mxNNNV2RD2JV+ysqZ/MNnYp89IsG
   XwwqeoH3YDlBJ90zma96CGl2NP8LTOqSkMTL5vObcB3Wv/vnZehX7sWXc
   Z4KNg+UKr5XujMMUC3nfodeqVCWSO3PzDcttLDTuXgN/RMyZ+mPm5zKAj
   laf95scix+DujcUDS4R4iDcOMQclLC3pT9hwC6wgB0mwHDcuSnyKDioXN
   A==;
X-CSE-ConnectionGUID: UdfUv2G2S9eZBhVVNg/K+w==
X-CSE-MsgGUID: Cx3QHk54S3WRZZ0Egny8RQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7971883"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="7971883"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 12:21:29 -0700
X-CSE-ConnectionGUID: qmboIkFcQZ6928/dN3J9Rg==
X-CSE-MsgGUID: DpyaF2rcTDyzeu4BzzFE4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="19795370"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2024 12:21:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 12:21:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 12:21:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Apr 2024 12:21:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 12:21:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0/Y4LOtt4nj9/IoWMbV8ECZjZTP1wEVg92gGosv+Ta8+Qy4BVcNIedX1VCfbIIBLxn3cqDaGNl9pHXoE1zTjU6FX2GmtLwiAHJaItDkSAUH+/v83KC0Hftl8lvZoT/3DCpS7CLduxyguLlnTCyU7605er92xaorZ/zMk9f6yAilkOs42BYNGefnzLuHB9GOEb594COO5fWnlqvJotN/diIHA4XOjWUXe5B/AXjA4NEMp7xH9vTzcwV5ddeD7yvXAlU/c2Xirfqi5NIR+hyJGzo04emCVVBG+5sdMbW+G7sZJQ0Abj5oTtFlx8bBDd6vNo/bdojtMNfSjy06kEwoCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qm6BtAe7EZvYvEy69sBID/oukxko9O4aIkrpeP/PxUU=;
 b=e0AdZXLeaoRDsDspfu5NcLZ9adWLMzXldC2m/zCvD1smGbD7b6/S+zbAV18uk9AQYvmofL0AQNX9CeNTdpmwefMaXJFp78Eezvo7hBfTmq3scFahG67Dv44oJyzOXgmKen2DqB0MnCgAa902xk5qsaDcrrFaYUVwmDbrkhoOO6zn/CIdjiXr4kpxy3yNZLtHMtwbP4SxmRbfKMpaK0SgMdNepiwsb/c44Y8T9MikCV6Fps51sFwBr7qnlraeTdCjhDeK+VQ74LsLXjLOIRiGrB78sd3NuWkHdwAmZk67dSSAln2evYzGDPmBVsVPKkySX7rqWdKDzI1kpPSHGSewlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN2PR11MB4743.namprd11.prod.outlook.com (2603:10b6:208:260::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Sun, 7 Apr
 2024 19:21:23 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Sun, 7 Apr 2024
 19:21:21 +0000
Message-ID: <d3ef1a5a-a7ee-477c-8697-d64b91726d91@intel.com>
Date: Sun, 7 Apr 2024 12:21:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] x86/resctrl: Move __resctrl_sched_in() out-of-line
To: Peter Newman <peternewman@google.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>,
	Stephane Eranian <eranian@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, Uros Bizjak <ubizjak@gmail.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>, Babu Moger
	<babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, "Maciej
 Wieczor-Retman" <maciej.wieczor-retman@intel.com>, Jens Axboe
	<axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, Oleg Nesterov
	<oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen
	<tandersen@netflix.com>, Nicholas Piggin <npiggin@gmail.com>, Beau Belgrave
	<beaub@linux.microsoft.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240325172707.73966-1-peternewman@google.com>
 <20240325172707.73966-2-peternewman@google.com>
 <e2c479b6-43f0-4e2c-9ccd-2e5f322d1974@intel.com>
 <CALPaoCjWDKM9VYXexDt2+zh2srTotuaErFHXkWzH1w0c_KWDjw@mail.gmail.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCjWDKM9VYXexDt2+zh2srTotuaErFHXkWzH1w0c_KWDjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN2PR11MB4743:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dPZPeLM1dSh/d6ekXwZf2s2JHco/IV5q3/I46WZPIpQSlDkYV+DJT2nxPcVDhK9hMoDJc8R0EJ+BQqobo7rUljrtK1fW/wItlpifAj8dxEH9Pba+DhxJ5hmpSk7A9pU3moXPInbVLDb6yHmydsj8Vx7VT8m3I9/BCDDMXgOgb7KNN0dxv4PEnDMRenzoEBzSfNjpfzsQLd3LVOSth/AxANzgjuuPW6/F8Yb4SRgDlVvPkAzAAZ9YAJmqhrUQO5ghkXTvtnz0ugwlHL0mdYvr6mmCztLekiJOIxjGXeIeqqz+/mnxhAJgCjupTkAAGD9agRZFIVwLzLaeeOfwVst/c56B/bAXwln1tBHL8IhY7KjWVEddhxgIzPVvF9nafPe481+XqoaTPigVQeY3CYuDvrdC/2ofbwSQTowbfiKZ3BZKO2A4cB9l8iXps8RZP5L6me9mOiGbtWhxe4khKi2z16wBOyV7y6Ok1LPoNvkaNRM8IrYjB7ED52v4oeLEh8NghwJf9lg4hZ2cjml5nzP+imo76Z7Ns+odWnHqcpvRbBLhMDS97tjr7ac+2QEAvZjMP2JrDFw4GzR0E4RqzqsjFcbm643RzTXqVMwWV4HVqRESSiCtbAY6IVv1GTRXOF0upEyse3MzfOvcAh7fq6jIRkK748dfB5pkyGCjC8tbRps=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUlOSVNMM3pvbTA1WFBickpVU2hUTTVUQWFpNHUyT3hiMys3RWFObEFmcWl6?=
 =?utf-8?B?UDlEYmNJa0htQXVnMlhjNVQ2OWt4TUNyRmcxbC9jeWxKL2FBaWV1a0VaOCtX?=
 =?utf-8?B?b3ZXZHhlcGs3TC82dlJmbk5rNHFRUloyREJvRlBKYlkzbExUK2REVjhVLzY2?=
 =?utf-8?B?ajVRNFpYMEZRZ0ExdmZlYkxYSVpSYlVGRmVYcGV4SW1paStHNncvYi9lSi9Q?=
 =?utf-8?B?UDFNRmM3VjM2d2g2TmxZOFUrNk5FL3dvanQwRTkwbnAxSzVZK0VmT1Z5Sm9J?=
 =?utf-8?B?enlINDRQQXdBazZiWXNXdHBQZUNOa0hmUmdiN29BUnZUMkNrQTlHbmdpR2NC?=
 =?utf-8?B?enVCTmFIUVladFVUTG9ZVEpWZXdaaEJxK29KbEJhaHlldGc2TXFsRTRMa3RB?=
 =?utf-8?B?VUc0LzlqeERZb0Q5MHUzWit0OXM0N3BsQXVhdDg1eGJVTkphdmtFRzRnc28v?=
 =?utf-8?B?K0ZlRkhpWkpaN1BjNWxRUkp5c08ydzdranBjUzF4OHQ4QUF4MHN2cnJya0ZM?=
 =?utf-8?B?b29SWXMzcUlVV0ZmWVhyQ3BSL3JjT1ZuSnpPOUEwMkhuV3NnSjV6L3hnY205?=
 =?utf-8?B?L2YzNEg0Mm5TcXJVSjZ0TGpEb1IzdUpRVWdydElrTUJEcG9MRnRkOTllREhR?=
 =?utf-8?B?b2FrM3dHV25jWnAwU085YjdGdlA2cWtkdmhyRVpKaTZKRU9rYzJhSCt5MkJE?=
 =?utf-8?B?NnJrUHhFeGlNOGw0VEpDNUJpOSt4N1ZQMVRVZFQxTzR6eTJTM24remMxWVJJ?=
 =?utf-8?B?OTU4c1JzOW1CTFdDOWVlc3RKZUoxRU5XMzZLeGVJU3dWdU5ZdU5GNG5KUXJT?=
 =?utf-8?B?NUxtM051dERoNXg0WS96Nmc3NzVrS2VCamVLeUl1eXhVT0xGcHZWYVI2cjhK?=
 =?utf-8?B?Y29mdlBWMDA3QzNxQjJqQW9MUjMzWklyK1A2aWRHOHRJbTNIZERlVm9SUW1y?=
 =?utf-8?B?TFphaGR4V3ZVRmtURFBtQS92Y01JWEs0VlVUSi9KR0J0RjdPQ3JjaG5kQ0ZZ?=
 =?utf-8?B?SWhqUjUyNzZ1cVVXR0F2RnhqaFlnOFBZYzBDNWYxcStDWWJWVm9ZL2ZnSXVS?=
 =?utf-8?B?azRJWTRJUzNoOXJ0VUxhRE9UMTVLakR0dGdoUjEvcjdSNW1OV2lmSjE4bFFE?=
 =?utf-8?B?VlFwRVgxeDI2TkpFMDd5eGZ4UjZHTy9RdEpqcnRRVVFCUTZPNFFQVFNaeEFT?=
 =?utf-8?B?cFlNS1VEYTZvSXdxT0pyZGp3RGVjTzNxTXlnZlhWMXBJVGlwR3B3SFVVRjhJ?=
 =?utf-8?B?cXQ0TWtIMXhtV29VYUtlSmhic0J1V3pRc0Z6TjBlWGE1ek9nOGNEZ2YyOXB0?=
 =?utf-8?B?TG10Zlp5V3ZOK2MwcWNvUE9YdkVlVHozeklPaWl0UGFsVzhjMkdPZTllVWlN?=
 =?utf-8?B?OFNqMHNMWGd0VDM3aXY2RFNscjZFblVSVVNkZWFLdGd5Wnp4SzVLRk9XNWg5?=
 =?utf-8?B?ZGw4VE1tMFd4bGdFZGdqL0hhUTU5ZVM0TWtkMWc0UTJBRm83TjFGYkdqbmlX?=
 =?utf-8?B?MldXSXFFKzVMUi9LYXk4d0p1N013M1NHbmRvMEFoSXZMOFA4NG9KUWU5R2Iv?=
 =?utf-8?B?UGsvMEk1bitlaHp1SUtrWCtUZzd2OTAvS28yMVlOL3FPRm1CcTN2N2FpcHdo?=
 =?utf-8?B?emlTSHhXNm1ON3lkSmxQdU1KOXpSc0Z2TVhEdmhKTWdZM1FSYTAzQlEzZ0ox?=
 =?utf-8?B?ZnZmV3ZuWHhtb3YybDNyZkpHWm1YSFBjeGxoc3F0SW5XNVk2eURLdUZMNDBy?=
 =?utf-8?B?a0hDTjFkUlM1d2psb0VvUjUrcWgvRUxYbzhrWFk3U0pTbkFoYm9hSzBLVTdO?=
 =?utf-8?B?SU1XTTNZWEZpQ21nMklsWjBaS3hiQmFxUEFXenVRUy9jRTF4WTlUUFV3WUYz?=
 =?utf-8?B?MjJWTzVjR0t6R3RLa0ZvQkhUZjVrWXJQUFhmTGVRNVlSb1pyMVNBOUI4bEJP?=
 =?utf-8?B?SUFWTmtqMzQ1ekFCVEhKKzJqOVg2OEdFdVhsSkFWaWs5eHpTaTRva3lySXdQ?=
 =?utf-8?B?Z0szalRXNVlIakJ0SXJRWHpzOVdMVGh2U3dIRUJIY3U1VDZIeWNIVHdUMG92?=
 =?utf-8?B?V3RYMEkzaVMvYXRWVzBNQUdIMXRtckF3cVlKbUpKTmE3bzlPdUs0bnhBYTBn?=
 =?utf-8?B?Nm0rdmE2a0cwbzNZR1J4M1pjTm5tczBmeXNoNjRjTWJuOW5KYys2M2RZeDgy?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c160191-9acc-4dfd-b09f-08dc5737e83c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 19:21:21.2381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MA75pkX5NaHmalENePxzBKWE7+2o//UnzGeXczdkigxKuxE5z8PDDUk/h9hQb92gsHUblfOUMHm97s8WCuCOz2cXdKSmtctfK/DkNPsnwv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4743
X-OriginatorOrg: intel.com

Hi Peter,

On 4/5/2024 3:04 PM, Peter Newman wrote:
> Hi Reinette,
> 
> On Thu, Apr 4, 2024 at 4:09 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> Hi Peter,
>>
>> On 3/25/2024 10:27 AM, Peter Newman wrote:
>>> __resctrl_sched_in() is unable to dereference a struct rdtgroup pointer
>>> when defined inline because rdtgroup is a private structure defined in
>>> internal.h.
>>
>> Being inline has nothing to do with whether it can reference a struct rdtgroup
>> pointer, no?
> 
> No, but it has a lot to do with whether it can de-reference a struct
> rdtgroup pointer in order to obtain a CLOSID or RMID, as doing so
> would pull the definitions for struct rdtgroup and struct mongroup
> into an external header. Before doing so, I would want to make sure
> implementing  __resctrl_sched_in() inline is actually adding value.

I expect that each architecture would need architecture specific task
switching code and by pointing to rdtgroup from the task_struct every
architecture would need to know how to reach the CLOSID/RMID within.

Having architectures reach into the private fs data is not ideal
so we should consider to make just a portion of rdtgroup information
required to support switching code accessible to the architectures, not the
entire rdtgroup and mongroup structures.

..

>>> +static inline void resctrl_sched_in(struct task_struct *tsk)
>>> +{
>>> +#ifdef CONFIG_X86_CPU_RESCTRL
>>> +     if (static_branch_likely(&rdt_enable_key))
>>> +             __resctrl_sched_in(tsk);
>>> +#endif
>>> +}
>>> +
>>
>> include/linux/resctrl.h should rather be divided to accommodate code
>> as below:
>>
>> #ifdef CONFIG_X86_CPU_RESCTRL
>>
>> static inline void resctrl_sched_in(struct task_struct *tsk)
>> {
>>         if (static_branch_likely(&rdt_enable_key))
>>                 __resctrl_sched_in(tsk);
>> }
>>
>> #else
>>
>> static inline void resctrl_sched_in(struct task_struct *tsk) {}
>>
>> #endif
>>
>> so that core code does not get anything unnecessary when CONFIG_X86_CPU_RESCTRL
>> is not set.
> 
> Will do.

I think this needs more thought. rdt_enable_key is x86 specific now and should not
be in the fs code. Every architecture will have its own task switch code, with
__resctrl_sched_in() belonging to x86 and thus not something to be directly called
from the fs code.

Reinette


