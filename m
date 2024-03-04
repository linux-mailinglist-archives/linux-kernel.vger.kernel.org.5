Return-Path: <linux-kernel+bounces-91429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E298687115E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DCC283D5C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7517D3EF;
	Mon,  4 Mar 2024 23:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUheSemD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C4A7D3E7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 23:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709596617; cv=fail; b=m3g/NT7MxemQs4DZEVodFMJUF4dvD03yHfX+ezvh3WHMSVjijUx2hAQB6J18gtpoIavKrfBEm3SVjroXTKh4FkavngN5hQIvH5ITpapZr/K4JMpnWiEx4gmVANaewPWzCdgNEbYsgIu42FwKEvC7pISXD+h1VvrHM+AsBbLuiAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709596617; c=relaxed/simple;
	bh=MycWV3jqTyJEfEpKQjktZfD9Lv+XlpcqMjazvv4IOtU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uM+0HiKHmCbbcpagx2RsZY+7gD5QUiPWTBes0M8UXdqDYisA6nGkvmLTOmmMjPmoiv50ZfwOnCp8Jxug5Bfr6kw97rkstfAmqbOPwGfMlohV7x7OhX7RoxipK7cbaeOaKRv0xBS/XcEzKYbHd//1rIUkDv3+yah51CRBcb9Il6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUheSemD; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709596615; x=1741132615;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MycWV3jqTyJEfEpKQjktZfD9Lv+XlpcqMjazvv4IOtU=;
  b=QUheSemD5R2vdr7WRtBveFc975y6uTY4kNr0XAyUY85iAahofc2kOhXP
   0fk41XiaVcf36TJoCL8OSKF4Gap0S4jfVSV23j75dNspdaQNG52V9wTi9
   WvJbA+bLeZtl8wLkebjD8Csfh5Ckcoiva86odfoL1k3LuYoB0JaojJKwe
   EtnVPuFwP7v9etBpSJSwMY/RZwN8ywFFfVU7royXLqPMIoXD0cikF+fWn
   84Y5pwqcvdrcFvq4uhoYMq09uRPO9nVjNefJKATrjy1m5pnSv9QDl1yo4
   sGvwGrNFAarZ9vfBfg2/4pmbMvyqvLu/t3y8npBNz7qIU1FXhrBjNGPzy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7066188"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="7066188"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 15:56:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="13850027"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 15:56:55 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 15:56:53 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 15:56:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 15:56:53 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 15:56:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5/2buNMZH0nUovYwS2HzSPGSZ5RZIzuK1w1rCRCkTaSHf0DIQsZNE75X72xnPvIbOKAjXTIeHADWXZPn3QYIUcINsXtdvMkPPlCH7awStHT+0kAjh3XUGHAJghSrwZKwp+n/XykRbgnJLro//Ixcyvlp+Ubai6UHCJjf6w2c9JzMGLMFTidrkflbC4/MzMJcioBaFoNL1GXR4q5yyAefwMdOkPVSnn59ql7kF1rGu777bG0D+Xl/Ggtv4ZdyHi50pytdOflOwTE/V3NJPVvjmMig04ao37V0wZ72bnVoaJ6nVf/r3MnJA0NhmKxHBMA6J78O1cM153WyPuZFA/2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MycWV3jqTyJEfEpKQjktZfD9Lv+XlpcqMjazvv4IOtU=;
 b=j2nPer0ypDwgpJaImLM4DiPjdZ2FfB256KB4FRcTMykJT38ltjZuRyVCWna/bdZal9hj0Eq0FlZFjUQ4ZCJ8A+1k5n/BPy2P15Hw3m7AjaEiIwy3F7R7ui7gVJ4k8DCFmZxtBVbfsHt+kP3iT5MMhle52HZP+BqTSGZzwP3ZuqjaOX/NttbxLmxsr0qf30NJkb6Fn5z44OpdC0efW7NgBBxANNHf566jSJDfkGOGYH3PlfKEc3oWswp+YQ57xAIfzrKbJMD2K3QWyzaNN6RQ8N+Ifag6QbbQUL8HvtZ7kVqZDsr3LjzGVuGhb3rb8M0dMmhKh+AgCQGCCQfrMV33hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by LV3PR11MB8507.namprd11.prod.outlook.com (2603:10b6:408:1b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 4 Mar
 2024 23:56:50 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257%4]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 23:56:50 +0000
Date: Mon, 4 Mar 2024 17:56:48 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: =?utf-8?B?Sm9zw6k=?= Roberto de Souza <jose.souza@intel.com>
CC: <linux-kernel@vger.kernel.org>, <intel-xe@lists.freedesktop.org>, "Rodrigo
 Vivi" <rodrigo.vivi@intel.com>, Mukesh Ojha <quic_mojha@quicinc.com>,
	Johannes Berg <johannes@sipsolutions.net>, Jonathan Cavitt
	<jonathan.cavitt@intel.com>
Subject: Re: [PATCH v3 2/4] devcoredump: Add dev_coredumpm_timeout()
Message-ID: <lp5at2yebh4in7ecddh45gkmaqhys6uyedtf3oh6ow45amgocl@2pw54fui6hos>
References: <20240304143905.52740-1-jose.souza@intel.com>
 <20240304143905.52740-2-jose.souza@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240304143905.52740-2-jose.souza@intel.com>
X-ClientProxiedBy: SJ0PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::15) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|LV3PR11MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 661caa0a-f1f0-4c25-d83b-08dc3ca6c283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GpN2l2XEFJei/cahQY2zkH8Qa46agNZI3pAsF5mtt3PWA0yxxAGPqyUgRGmUUiBJWDTqL8/tz7UKI+gKtEEVY21cOQy2D6frVKhyLCkMcMc7VOWlXNYWGhiTJP1unvWrSS9EgYPceSlYboF/Fg17EQ3GF52hMer/Tfs9hwDUXxM/94P/DHRUDPCgtj18XrlvmxHgwBlZA5tdbnevFLiyfRulFdRHXILwMJG70Lv64BvUJHNlgE0FfoASydwPSjJJUncGBI5cZ76qceNrxaBf36pyU6X1oaUCxyW8LHkiS1MCWKK4PjUTkh9Pqps+YtS0AM1C4PBm8rrDgXAyFmbL11ivZnyT/8OHLmMoM2Uy3yoaixAV90Qdp+FRywbFrPg1tmUWWc4q5J8mu0NtZugLcVTNsQPerLYWuudD+XmqdaS0hcjLxqfg8S47FUKJ35XzmtKQ5oaFoG6/s73p0K2e7fPkVbz5CMTZ2H6lJm/qHR/OvPd/bt9v4QYHYccnIn2Zouf3EA+/PE39v0WSswe7xkhsSXNZQTgiO/QdlbeFpZuSGCQ7CKK+uc1/XWx7H4Lv4VPFR6tXV48G+/O/A59LPu0El7fVmEVoWeBdHUyyx+Azj3pYz69RDO/X+nLmxgh80rJ9L7cNhtuOCwH4OSXB3d1KW03GHk5EIauhQC50/Vs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BNS+sjSV7gHqLGLzb5DHvOlm+g/8STeA6NP3Yjq7NagSOuWKlUk9V+zaIBFz?=
 =?us-ascii?Q?0Us3om7Fu1XTkfcOSdYDjt8JIhl0UKp45kScrpZewmZhuRptyNkG3aCkSx1V?=
 =?us-ascii?Q?7JxYXfmvDYlV2EmkizdSsM1/I650MavJCpKMgF2WoAmpqvlRpPbdrtsfGWRs?=
 =?us-ascii?Q?+86MI82c3777HvWI9nRpQg4TZDtwS3v27bzPsuMGSxvNP+mKorPQeMmDPRUv?=
 =?us-ascii?Q?K+YgANRcS8GLiEnnPtuS96Il18/uOCHT2mLDiLVcNGd+9qPUbkJkSTMlFf/f?=
 =?us-ascii?Q?hPDGdhhHRdXRcH161U8+bN6IdP/8WwtmAzHuUSMyTy3zrkVIks+RK9d9f9To?=
 =?us-ascii?Q?2ewUV9brWVlotCewNyuv5pQ861ky2KCCIhODUsIjvgNIqvKF5ed6jE6T9bwQ?=
 =?us-ascii?Q?fwJml538W2mBcR8WvtalzwuRmCzK1yJSqXH2uzmqXGKQHmweUqUjLPfJnBh8?=
 =?us-ascii?Q?rMHOGoCtGl3skHjDH8w/+Gor+wQ72M45josM6QTjfTUyp1jTD0uHZyf81mvj?=
 =?us-ascii?Q?xQJsLcepiFJkp11yAKK87rFsqkqLmQgryysGIePZSOXx7gENSYwclemgw2GH?=
 =?us-ascii?Q?K55oTfmHy7livFyuaFMurt4xNNAH22LEuaw5UfpsqzC9zCxqBEUSXDk3h78M?=
 =?us-ascii?Q?5UOwZ5ZTTpZHY48Jqj7jfSJK39Zl0W2+RUI6EJ5G76QfrvSRGDSQjvLkoTpl?=
 =?us-ascii?Q?4OYsqQmR+6wimPKRpqaFONdk+WC5ABtIT0yetyn1yVDBTLqVIckxJcJWTaTL?=
 =?us-ascii?Q?1G2tNdCj1UcqAPlnvVU7I4oZEix7tokQEJC7ZWUcBYCSOupcmnUKbM9SLfID?=
 =?us-ascii?Q?mYmIM4GzzSQOMVIgNd9jQSPhRGwz5Bcj5EfphMTKBfnzwQxSlwufcYmy+q+0?=
 =?us-ascii?Q?pvkHNUFBZH2fQVzsbx9Hhd5DxOA8NzKfcxkfVJwB9t9JGlkS9P4Yn9B9ZZkz?=
 =?us-ascii?Q?0QdfPJ4iQ/6FyRtAiJIDKCk4c1FL2xoeDF4kgwNy/Feoauhl3IQ7iuUhr9JF?=
 =?us-ascii?Q?T0/Ws8gg8gS70zF0pf3ekuyhrLvjgq0tkItj/xiFb7t4wmppxKWKsLfOhs0d?=
 =?us-ascii?Q?DYLhdx7B6aHPSVk7Zd60oMhhSuOV7kUUtQ/WfC+ErIfxMWvkXwj16IfWJkLg?=
 =?us-ascii?Q?Fd96qclHgIgc5+0g63XYo8Q9YPTV/xNAh1Ozy/w85k38Co8zjVIrXIAHayBf?=
 =?us-ascii?Q?jwxq5cB1Vtg4opN+/cB7zVZEJQ27VCRs+qsQu5TeqAV/aGyyKsi1H7sR7W55?=
 =?us-ascii?Q?CZH4IzSYedI/0uYqZx4ONDAQlOHzg06dFdr9TIVoLOLEkPijEHTf8BFomMID?=
 =?us-ascii?Q?EUl9eOvHCAXF5TM/rJ2qM1aepkiQNR+g8ZVOd/Eebx82kj+iBTKwsSLvv86H?=
 =?us-ascii?Q?wSaJl1E111+Vj4tJD7JvIgO9tTcP/sgfu6AeuKjP7Xolskj9GFtSFvs9lf0G?=
 =?us-ascii?Q?jAuSuL2A7vYJ9sBOOPYtonjrL/QRwJWgVuguqaF4DbVfxjDYhayjMHC2rrUO?=
 =?us-ascii?Q?VUI8AbENCzF1Im/uqfLOh5Lg8K5orsNV6aR1xXwV3srKKSEwYNa/oDg3OyGv?=
 =?us-ascii?Q?Im2bljyfy9mKJPXczJtDlFZtAMItjIJiDEJATlOPEvm+OLba5KEjGBJxm8Ns?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 661caa0a-f1f0-4c25-d83b-08dc3ca6c283
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 23:56:50.6507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSh/4J51TPdTba/+DZ5P8gBTtrUZoWR+zQSDi0QbKSirHdyX5fLID1Pu8yH8Cnle3F+6KH40sZyskCI1qq12rt4VKB2zPcVzcRe+Xh5bnKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8507
X-OriginatorOrg: intel.com

On Mon, Mar 04, 2024 at 06:39:03AM -0800, Jose Souza wrote:
>Add function to set a custom coredump timeout.
>
>Current 5-minute timeout may be too short for users to search and
>understand what needs to be done to capture coredump to report bugs.
>
>v2:
>- replace dev_coredump_timeout_set() by dev_coredumpm_timeout() (Mukesh)
>
>v3:
>- make dev_coredumpm() static inline (Johannes)


but let's wait the discussion settle on v2.

Lucas De Marchi

