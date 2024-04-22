Return-Path: <linux-kernel+bounces-154205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8A28AD943
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7317B284793
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F10945BFD;
	Mon, 22 Apr 2024 23:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IvF+gtnY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65C244C7E;
	Mon, 22 Apr 2024 23:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829441; cv=fail; b=LOAHDKp85Fyg0FIrkmQaGmlLiFR/MQzycE/NBVpmtLCXnmhlGLbeVBKAiE1g8K/9DBlbAAkQbnJri2FDUUXqNKySTc8Fxbxx5RBiWW+/Fvh4WksIO4SQd6pL0oPCt3UUEVGZHeTnKofIZrvX8FflYwN2L+G2ee75m3UeSm8yYjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829441; c=relaxed/simple;
	bh=NnRiMCldtUh7uvC73LWZxr1rRV8+eaNrhJtg+mbJRMc=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fq9Pu234OKg1BiTXDs4X+Qqw3HUK/sa4xmAb6hEEiYu5T88ZcGjuYkYObPUWidWEzZVu1VndrBer8IPT9YvRpm8zV0gAHA3/FksK6ET7Gk/ixGSe68ZRd8cHjPTrd59pjYwaymq6hQS2mc27O/ky8n7Y6Ontk2n0joXOP/CQ+eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IvF+gtnY; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713829440; x=1745365440;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NnRiMCldtUh7uvC73LWZxr1rRV8+eaNrhJtg+mbJRMc=;
  b=IvF+gtnYOhACRvzEaB4zaWZ5YxMDlSVIMFYFEHV2ZuIA2KgY90lGmktB
   qOkRdpEuDjfkFnWVfoCX57fL7QmidZs5gNU8UkzKWpONoIirr4k5Jjxhc
   pC+/mb9+URM7u3LZd3cNbJUf5iWnA274K+HGfkwMZJokH5mFO82lYAWxx
   HDBFPHkJm3Y+YZzhq1R/EzbvSjpyfuBqLO23YUE6Qn3SK3mOcEqOTPOFK
   LP2GIXNuab+COVoTlx4bm2M3BfRn5KH765AiF+ZvlWVxF2ci3RXztcCkH
   pr4kNxf0LZztBnQaAGk5R6JCvFY3NmZ/jVRvD1yUUUWzsp3WfV3Sm3ljg
   A==;
X-CSE-ConnectionGUID: HTQ15sQ4Si2L9Lp3BmWyZg==
X-CSE-MsgGUID: +5K0vSMiSEubi61QEKnJoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="13181306"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="13181306"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 16:44:00 -0700
X-CSE-ConnectionGUID: 3uxhA6XzSo6xo5h0oURVnA==
X-CSE-MsgGUID: sCuY3fSVTYaNHVf7PuoNfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="28967834"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 16:44:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 16:43:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 16:43:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 16:43:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHo9uDdFWgZXPGD77y4T3LEStTMY4Bo1L8JQXCkA9Gj8aivfKxPhGvZulMKgkzRMdc8gpq6bnWksG3QWzpF0NFvhpF4xDUdGH7yREciPw/BIl78qqEjeVA+CTdNGHV0mxMWimUTmawudlijbSuXHRr/eiwysN/W2mmNZ/KjdFasq7xglWrbpoBl0o3iAFMIRL46QPYPZJQju0uKjRvWP4nqu/RbO/oNVkKYo6WP1w28SnQRFLkUTlKCueRGAMseJzsuBDucxfrfvcmZ/D2o9BlukH40tEKQCMl7u1lsv/Vm1Zh+56tWgDac3Ju+ifP5qBDzckAC9SBn5mlGgrN9CFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMIyC/kxEXL7BOedeakgPDoVY0QYajxX2AmRdO+W5Po=;
 b=CCr44iermAK8ZjxBi+6fFdVA3T3eqgC9E0J+/69YzP/TNYOdHhI085edIWuXBWe4/D7OtZYnMYGlbME2soMqDcvNOBvWgZEwMhYzTckxEqZYwDxIDm2nS7Sq/FhH1RI/nSz9IR8/FnMpAacY1Ti8GDZh2kLyRC8akrjnEargD/fPsnRhv0S+JGsesoLJmQ56OzLDS3pH7eslXZGEJnDyVcs8leTpaPA59IS7B7AXtQO5T3bqWY8yT2DmkyJfZNFO2aS3l/6KKmEzJnYjXLyPdkvWCBlhh3XQXyiW0/jxrUt+YVWypcE58mhz6ssYHpupuowPI1IhNefVedyHuY0dOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB6150.namprd11.prod.outlook.com (2603:10b6:8:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Mon, 22 Apr
 2024 23:43:57 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7519.020; Mon, 22 Apr 2024
 23:43:56 +0000
Message-ID: <dd7a713a-1c16-47dc-83f1-967e2b1054c6@intel.com>
Date: Mon, 22 Apr 2024 16:43:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] octeontx2-pf: flower: check for unsupported
 control flags
From: Jacob Keller <jacob.e.keller@intel.com>
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
	<netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Sunil Goutham <sgoutham@marvell.com>, "Geetha
 sowjanya" <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>, Suman Ghosh <sumang@marvell.com>
References: <20240422152735.175693-1-ast@fiberby.net>
 <a12ac71c-5621-4014-9b01-e74ce7429120@intel.com>
Content-Language: en-US
In-Reply-To: <a12ac71c-5621-4014-9b01-e74ce7429120@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0012.namprd21.prod.outlook.com
 (2603:10b6:a03:114::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS7PR11MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: e4981e24-e4dc-4756-c148-08dc63261386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXRDRW1xNUlKekFzRzZQSGF5cHlVcEJ2UlhmYXJXb1JhbDQ1VE5aQmc2bGxF?=
 =?utf-8?B?ZWdaQ0graUdjNFBGeGJpUUhaUVNoZTIvS1lFRnRVTmttR1MwS25VbitoakE3?=
 =?utf-8?B?UTJVZWZGTTVPNEJ5RmlsQUZVWkc0S05vZE9oSUpaU0RTcDZ5cDJUSXl5c1Nx?=
 =?utf-8?B?WlRDTEVjQUswVTF6Wm5mM2gyaEdTbE5ZR3VjN1RhVGpXK2ZKZW03bWFicmpU?=
 =?utf-8?B?elFid0dTSG5oVW9JL24xTTFYQm82UVRqUklrdWlBTVFWSm9kTjR0dEJUdXla?=
 =?utf-8?B?THJEbFFNTWFvc3B5aE4rY05kdVVSWXY3empjZDdHZDB1QWtmVDM4L2VwUVJS?=
 =?utf-8?B?VWJGM1l5UkZ1aXBDZTBjRU1JWXVBY3Y1aXZQNUNNKzlFUmYvUjQreEl5RDJI?=
 =?utf-8?B?eGgxUXJEdWQzQVM5b21Bd0h3OVVLdlVNNmFjb1dqQ0UvZEFQZis2QVpiNlFV?=
 =?utf-8?B?eGMyOFI5YkJBNnpGaWtCbDE0QmxzUzFJdi9GUjJNc1ZzZGpZdTRNQWU1Qlg5?=
 =?utf-8?B?U1lmK01icDEyMnpubXE3QVhxSTVDeDBuL2JmMHkxdmhJVlYzWFYyb3JibGly?=
 =?utf-8?B?QmRmOUxWaElZajMxQ2dTWm9MS040eFRQT2FQR0hINlI0alZHZTdacnZQa3pR?=
 =?utf-8?B?dzlKZlNDUmhEVHoyczlDSDJ5YmtOdEpRS1UxV09lVkFpVzdqalgzM3RNcTZj?=
 =?utf-8?B?QlRRY3RqK2ZVNFNVTHBvMGgxY0hDZk1SMFlDT1dhaXQ1NTRsQ2M4RkZyREow?=
 =?utf-8?B?TTg0SFk2NkNjaUowd0w2NWpCZzVsdlhyUlIwTFBrK0xqWkNJeDZtcHdaMGRz?=
 =?utf-8?B?c3FzTkdRSU4vOG1ISmgvVGgrT1c4UjJ0VTFOSDR3UzVQbVlvZ29wV2pBKzd5?=
 =?utf-8?B?RXlGSDIxM2ZuRVFMVEtqY3lJQ1dpakNla3paZmtoaDBNdUYzL0xmUW9VeU53?=
 =?utf-8?B?SDJSRXBFSlNnWWhxV0VIdS9UcHk4OXlRQlY2NlRVN21FM3VZNEVIcXowMG1R?=
 =?utf-8?B?S20rU2xBTzhSbHk2SHVFQjY1TStQd25rWXAwZHF3YlRqMnZRa2svU0VGcW85?=
 =?utf-8?B?QU96KzBoOHpLVUppbGFISElkQjR3eVh2b2ovT2dxT3ZKcm84RVNmZC8rUmJW?=
 =?utf-8?B?cFlqSytOT0tkZzZITVNkcitKaEg0b3N5M29pazduejBmM3J3ZThOb29VMU8z?=
 =?utf-8?B?RjJjYUlYNjV2RnVlK0hXNGNMVmtsQjA3bzdVOWR5bC9kMjFhSWc5SW1JdEhQ?=
 =?utf-8?B?dzVaMkdLcmxsNHdpazJ5bVpodkRiaVZZTk9aMlBPYXhXVkxLOGwvTDQzSElz?=
 =?utf-8?B?ZjlHMmNDVE1YMVlETEMvamxMcjZkNHRKaFIxZkIxaG0wV3Bia29kWTJIeGRj?=
 =?utf-8?B?SDhGZkNnalNwUVNTaVRoQmQ0alJ4WHFrSjk5VEpHQzZUeml3NlR0aVliTWhY?=
 =?utf-8?B?eUhHbW45dXFlWWJBTGVxQytmNlB1d3VIZWFUS1dJdVhvOUlscG1PV0JPV2Rk?=
 =?utf-8?B?RWpndldTdy8rS3Jwa2hlSnBoK0pVK3hLd3JxSVNpcjB2dmxiZjJJUDRSZXlE?=
 =?utf-8?B?R21ZT0sralhPazlGWkFvdzJrS3FLQUt0OWRobDdNMGU4OS84MEdrL2tSbC8r?=
 =?utf-8?B?eE9rTCtEUSt0RDREVlZPMnJ6YUtQaWNJR3Irc2xZUnp0WVJUOFFGdXV4R2Yw?=
 =?utf-8?B?VnFwVXhIdmNQcVlsYUI3N3RzQ3V1RkRrdzV1OXpVa3p1M045N0xxZkxnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWZuNEtIcXlEM0RjaXg1Qm9NcXJjdXp0U2I5WEZXc3h0MWZVcXBRTE9MOUh5?=
 =?utf-8?B?MG1WTnpKTUdLdWpNSkF4NU1ON092WGo5YjNEN01NQk15VUhLbG9xYlNhVm85?=
 =?utf-8?B?THU5bTFvMHVXNEN0aFBiQUVORU9SdUJyaXZZWGJueGJpaXNtdi9wdzV1Y2Qz?=
 =?utf-8?B?N1diSndPNjB3REx1VFcrNjM2YVJYSWo1eXdGam9hSFhxY1ZmK250VzMrWlQ2?=
 =?utf-8?B?U3phRmoyNjNLaUxualdhbUNtZUM1Yy9Ua2lybGVYQmhpTG1LTnkxRWcxVW9u?=
 =?utf-8?B?cUhmYjV3NHN5QWJCRXRiMzVXQ0ROb3Q5T1lkQ1ErYXoyaGdJbmUxZ1hkKzlS?=
 =?utf-8?B?NFZPb1pMZ0NpYUhvR083V3BjblpOa25vc2dTenlaRVFTZUxKWllKU3laT2lE?=
 =?utf-8?B?d1pOczJJNkh3eEZkQVd4a3FoRTU5aVNaSVpGVjVpQVBpYlVvSFZuakEwTDhV?=
 =?utf-8?B?V3U3SWllSnNqR3NOcERoNFdycm92Z3Y5bWI1eGtheVYva1ZWS3FpYTgwMFly?=
 =?utf-8?B?RkkvSmRVcCtEaHNpYWYya0F1d2IvOG1iRnJVdnZkWENNc2dMRHVRcmh0c0pt?=
 =?utf-8?B?a0FkcGRBUGxnUklFZHRqYjFrWEx5cm1pZ00ybEVEUEh1dGtkSmRKUnkzN3Z2?=
 =?utf-8?B?QnJrbDYwMDBPMUJkNEFxcGpTYUZVWkxPMkNQMGprYVVDL21VekUzSW9QNWZP?=
 =?utf-8?B?KzEzejJudHRPQWd6bmZVNU53bE5tMDlLMzl3eTRwVmJ1RWROWCs0YWRHQ2lm?=
 =?utf-8?B?anE3OEdTbkJYTU5hR2hYVjZRZ3FQNHZmd1JYVWJ5SlRjQ2RFQTRKY3FybWVZ?=
 =?utf-8?B?ZVBHaktGaEQvaDZJUUNmRkxudzE3V3I1T2lyTDdlcDd5c0xiS3dMMTVXVCtO?=
 =?utf-8?B?dG1KZVFRK2JiR0RMNlNUUDdic005Lzg5elJ5N3A0T05qZ3lLMXZZZm9ZKzJw?=
 =?utf-8?B?bVZGTHdKNDBhMkhObEFtUHhUR3Z2WHNCSDdHaGVya0hsbDZQcFhSMElIb2dw?=
 =?utf-8?B?NDB6WEdldFJpeHhIZnROUnRmdkNLeW9kZG96S2FSK3Q5OHRPcWJmY2JkRHkv?=
 =?utf-8?B?cWhqWW5hZ29BcE50VVpmMlViOWE2QXk0YzVZRDl2bTU4WnQwZXZtcGpHbnBY?=
 =?utf-8?B?b0xVUHRmTGo1c2JrZENMS2tINnhDcGU1c2dWMjRUMzBPOVMweGZ6VUs1bGVV?=
 =?utf-8?B?Vm45T3hlcVdWNU16OUlhVmZGRGlVOEdPUmZGYXZKUzhGTVRTOVA4Y2VNNUFD?=
 =?utf-8?B?UFZidkJ3RFJNL3FpeHRCTFFHL0VMbnNIdVdxc1BnamIxZURwT1ZzRlNvN1NC?=
 =?utf-8?B?WVh4MTBCa0M0WWhQVXVocUZEQlA1dlhjQWVWN3NxeTVEMTM4QUoweEcyMmI0?=
 =?utf-8?B?SzlVeFBPWjBmVXRMelZUaWxSeEZUN0sxSERxNVI2SXVDYVNsMjZ2MFdTc082?=
 =?utf-8?B?MExkQ1F0S3o3MjJrNDJudHl2UWJMWFRFRjM2bWlYR2VkM2NBTTZxa0xlelZB?=
 =?utf-8?B?NUF5QWJ5OHhtbHQ1QzlXME5YUUducUJLNXRjdWVzRXBrclBsR2NQRFVEc0JN?=
 =?utf-8?B?eDZGcGtxOGhCeU1Ea3AveU9LbWdKaWFGdjNMUE9tWnZ0QkdjVDF1UHFEbmJv?=
 =?utf-8?B?aWNzRExNaFZIVTdiOVA2UC8xQnMwQXljd2U4QzViczVVNldUNFYydjhkQ3lD?=
 =?utf-8?B?V2oxUmFCNHB1ZWk1bTMrRWl2Ti9pdmloUjFrOW5uaEVzbEtkeHV3V0Zob1o5?=
 =?utf-8?B?MXNSSHNjTk82K2ZYTEE5aEZDVVFHeHhYcDdsdEVkb3hOMlZJQmxFdjFhMWx6?=
 =?utf-8?B?WGNsd3k3VDdyTTREQkEzZzB6NVpFY2YwTTlENWZ6dWhjc3gyK3V0c1E3ZThr?=
 =?utf-8?B?OFQ1K1RHQ0M2VGt6eDFaeXdPYk1uVUFLQ1VGVU9qb1l4TlZJYUNEMjkwSElI?=
 =?utf-8?B?dkNGVjN4RU5NK0Njb0YwanpSNlRyVHNwUG5DWGRlRlZJWElSTlVuRWtJV2RQ?=
 =?utf-8?B?OWVxSDkzMXdjNUJ1cGhSRXVKQmhJZVBEam9jWXV6clZqZGdMQXBOMVFpY2VB?=
 =?utf-8?B?TERNVUJydzVRRHJ3eHdHMVErcUlDSWlmQ29xcTZkZ3NXMkF0ait1MHZ6Skty?=
 =?utf-8?B?QzBhRlVob2IzZ0lEMDBZOE4rcG0waGQyZmtoaHdOalFWVi9ON2FhWEZzblht?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4981e24-e4dc-4756-c148-08dc63261386
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 23:43:56.8083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8J029rlLiYQ1F5S/u05cw+A5Q9EKAOGCVn5qh5O3pGrJ9OAikaCkDUY+7IEMuoJulaWnH45JtDTELaj8L8hbQe6GDznIG+JMVynfzVOeR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6150
X-OriginatorOrg: intel.com



On 4/22/2024 4:41 PM, Jacob Keller wrote:
> 
> 
> On 4/22/2024 8:27 AM, Asbjørn Sloth Tønnesen wrote:
>> Use flow_rule_is_supp_control_flags() to reject filters with
>> unsupported control flags.
>>
>> In case any unsupported control flags are masked,
>> flow_rule_is_supp_control_flags() sets a NL extended
>> error message, and we return -EOPNOTSUPP.
>>
>> Remove FLOW_DIS_FIRST_FRAG specific error message,
>> and treat it as any other unsupported control flag.
>>
>> Only compile-tested.
>>
>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>> ---
>>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
>> index 6d4ce2ece8d0..e63cc1eb6d89 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
>> @@ -700,10 +700,6 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
>>  		u32 val;
>>  
>>  		flow_rule_match_control(rule, &match);
>> -		if (match.mask->flags & FLOW_DIS_FIRST_FRAG) {
>> -			NL_SET_ERR_MSG_MOD(extack, "HW doesn't support frag first/later");
>> -			return -EOPNOTSUPP;
>> -		}
>>  
>>  		if (match.mask->flags & FLOW_DIS_IS_FRAGMENT) {
>>  			val = match.key->flags & FLOW_DIS_IS_FRAGMENT;
>> @@ -721,6 +717,10 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
>>  				return -EOPNOTSUPP;
>>  			}
>>  		}
>> +
>> +		if (!flow_rule_is_supp_control_flags(FLOW_DIS_IS_FRAGMENT,
>> +						     match.mask->flags, extack))
>> +			return -EOPNOTSUPP;
> 
> This confuses me since you pass FLOW_DIS_IS_FRAGMENT here, but you
> removed the check for FLOW_DIS_FIRST_FRAG??
> 
> Am I misunderstanding how flow_rule_is_supp_control_flags works?
> 
> The code just above this appears to support FLOW_DIS_IS_FRAGMENT.
> 
> Here is the implementation of flow_rule_is_supp_control_flags for reference:
> 
>> /**
>>  * flow_rule_is_supp_control_flags() - check for supported control flags
>>  * @supp_flags: control flags supported by driver
>>  * @ctrl_flags: control flags present in rule
>>  * @extack: The netlink extended ACK for reporting errors.
>>  *
>>  * Return: true if only supported control flags are set, false otherwise.
>>  */
>> static inline bool flow_rule_is_supp_control_flags(const u32 supp_flags,
>>                                                    const u32 ctrl_flags,
>>                                                    struct netlink_ext_ack *extack)
>> {
>>         if (likely((ctrl_flags & ~supp_flags) == 0))
>>                 return true;
>>
>>         NL_SET_ERR_MSG_FMT_MOD(extack,
>>                                "Unsupported match on control.flags %#x",
>>                                ctrl_flags);
>>
>>         return false;
>> }
>>
> 
> This seems to me that it you accidentally passed FLOW_DIS_IS_FRAGMENT
> when you meant FLOW_DIS_FIRST_FRAG??
> 
> I also think its a bit strange that you moved the placement of the check
> instead of replacing in the same location as where the previous check was.
> 
> 

Ah, I see what I missed. This takes the list of supported flags and
inverts it, and checks if any other flags were passed.

This is better since it guarantees future flags or other unknown flags
are rejected.

Ok. Sorry for the confusion.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

