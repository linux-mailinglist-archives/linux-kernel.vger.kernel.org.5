Return-Path: <linux-kernel+bounces-161101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 734EF8B4720
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 18:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37571F21CE1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 16:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC37C13D244;
	Sat, 27 Apr 2024 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cf+zGAhB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF7E13C8EA
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714235530; cv=fail; b=gcfrQbzQUOL00oYYwG/+mLTOXC2qB6eUi5HN/j6pp3BKAvsaWrfjYJVA7Dhy6Z5LOpvd2qgVvcG5oE4QaIwsexgtJPHL5Nagp/47Q1Zw/HzgH/b6tew/EgOV4MXDxF5FLkipcud9tudLaMgtNI7hm9iR07bBzBnX/Cz2Kfmweps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714235530; c=relaxed/simple;
	bh=dPxX+7So4MC2hgFlO+ffOAoas4zQrE1hWDKRYykcnLY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EEDfYqKTw3G4GltNusdrNLsSJiY4g6ue6EvBgJBiagM1wpcg6GIUVgzCuxycxCiguQxF88968j3eqowi6Zjwb65CiqFjA3kY4krLrIKmH+zaVAsfhIJNW/jGC058pKX/YJEanFevOy39Huh6+BA7ooi5019vX4wsfIuOLl3cXXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cf+zGAhB; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714235529; x=1745771529;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dPxX+7So4MC2hgFlO+ffOAoas4zQrE1hWDKRYykcnLY=;
  b=Cf+zGAhBbrxsLhqW2JbIJ6Ellp4eHnKJZSt96cc3RPx9re/PMOiOxvf1
   p3qMF8PucfY2uiA3FY1KbCN7iv4xe0XdD+saXO8LPO33wFFdMuhkhbkC4
   PGyCp5295okQd25Qkqcma7Y0ihF2AB4NTvwsJNBSGNdeSyKUK6fQi2gHv
   uVS7Etb0f6xVOk48SmXsAZz8Dmej2Ek17G/1tVrrV3oY9ck+41+xvtJ3b
   2lyx02KtpHhGEnNUR01caUzfnqLW1zObXILe7dqexKhjmJwEaSPqyV5Sr
   lC0IAMt3dmt8OttO5b9nNKUa1PP+M4QRkCeOsugTTQwls3JfQhIrQkcX1
   g==;
X-CSE-ConnectionGUID: dIi9Fis+T7uo6ZLGDK+nxA==
X-CSE-MsgGUID: dB6kQd1MQomRSYejtnGHpg==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="21366698"
X-IronPort-AV: E=Sophos;i="6.07,235,1708416000"; 
   d="scan'208";a="21366698"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2024 09:32:09 -0700
X-CSE-ConnectionGUID: DffN4UVtR8iBQuKQxjuroA==
X-CSE-MsgGUID: o5+KWtffQQWtxmGY+6Y/BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,235,1708416000"; 
   d="scan'208";a="30507649"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Apr 2024 09:32:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Apr 2024 09:32:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 27 Apr 2024 09:32:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 27 Apr 2024 09:32:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1E31zy5BEgxwv6H5ZmiSrO5Q92PEYkOXxSrAA7SAJFKAk4LO4HxpfcuGa1Zsv9jbMska/Oypk9rmdLdQHtBWs/jXBbUHzesK5hOrTcIxe+yiE+Fe3viu4ewzrCjXROfnzibPKguPIveYXs3dcyDJMxpj2B+XY5P0R99wc5Obov7vZk2peFszWpjddKOkhloRXFKKSXPIZmxQ+Wegxu/F8XA3ev9k2+dc1/2NpuB5nx+4xL3NR2ldou7irmIbQh5jFrH517/dgdoblzpGqu6AS/kexVpNIKwLae7QEWsWZWQpogz4msJPwO/w8XERQNq0v9++qDiWCj0KOXaSL3/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z29IbtT6kZUSN30pWh9gV7BwUSGQRaHo5pqqxJ3/lOo=;
 b=bgiLWWEULJkC1Rx8gVi4FQvYciE3DGMETA46siT0gnuOmdIFtdsBE+QFj8Oh3y+4a/Ks5RHG9YDigVAEbOLy+aBJkYb7I9BqSsdGgJ0wG4l/A/XCsyfrYfgzaulD6KNhPLPHZxhu1LISJyGyaHFURUooz75IyFnnxzhpYFG2naCYTnSbO2QtYWvI8UmlAFqZ9fdWyJ8r3SWVDb9FmtI/Y/SRrvpBZsxhUSiVhVXcAAHDKYlvFXNAgnhDYs3ypJyT1pO1j/QxVTgjMSvSOSD2xku5PAfcn5uH4q73h3TYm1l2Kq18BVc4Gc4gMw53ULrb8hXTWXb19ltR6PsflVHVWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB6790.namprd11.prod.outlook.com (2603:10b6:a03:483::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sat, 27 Apr
 2024 16:32:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Sat, 27 Apr 2024
 16:32:04 +0000
Date: Sat, 27 Apr 2024 09:32:02 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Lukas Wunner <lukas@wunner.de>, Dan Williams <dan.j.williams@intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, <linux-kernel@vger.kernel.org>, Alan Stern
	<stern@rowland.harvard.edu>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] sysfs: Allow bin_attributes to be added to groups
Message-ID: <662d288263cd5_b6e0294b5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <e140f6bf8dc99c24cc387f7ac3c7908c8830587f.1714030457.git.lukas@wunner.de>
 <662be72549aaf_db82d294c7@dwillia2-xfh.jf.intel.com.notmuch>
 <Ziv5p3SMEIw3XZkK@wunner.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ziv5p3SMEIw3XZkK@wunner.de>
X-ClientProxiedBy: MW4PR04CA0315.namprd04.prod.outlook.com
 (2603:10b6:303:82::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: f289ed44-09f8-4462-ace1-08dc66d792c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?1+/NkuE2mJ18VzCG+/l6jydG0m11WyGFTDise/Rq7jq3UyLDRTGOMPnkGA?=
 =?iso-8859-1?Q?IQwkXvvRUqU5vAvnfU2LbhwWzKBg6b3I9Wco3LlDkQOjxxztqnPYDBH0Sr?=
 =?iso-8859-1?Q?VSuZyoQoFSicAx9S3perjeAl3buIrRutPksju4ktTyGOFX/o9AWKG2EoKp?=
 =?iso-8859-1?Q?w81dZMIX2zRAOSWZu9QFcxs3IIue8/rXXNK7G5ZgCNqXv1IpgfDrV35Y9P?=
 =?iso-8859-1?Q?fixHytfoi3Y1RJrvnptd/mIzW+ka65x+i3WOEfRQreuu3pCpHtWIEEqFBR?=
 =?iso-8859-1?Q?bI4W2Vi1jskg0wqN4WxiQ9NA0uXDC9u4Y3qhTfCU7tPfW36vOWkVWqQl5V?=
 =?iso-8859-1?Q?gJNrzKvWO8MtU/PPYEx2D7AhvRRwscFYnYX+dpNRE9xSoxmAmHLc/8yS+m?=
 =?iso-8859-1?Q?HhwBnpupuEQmKl1hkWcDuH2F+fSLoCacgcny7DtiRtk+mrdE2EbPVj2ma/?=
 =?iso-8859-1?Q?fvxZWvLYm1hvk1p1w1z18/0gcZoVoynTstKbDvtfigU7Qa5/pUA6DrsDOn?=
 =?iso-8859-1?Q?NWsqBXrE8m90DEGvx3bc/j6wwdOjOd6JZYaRWcCY+a2ALk1NL2EhInkYGD?=
 =?iso-8859-1?Q?NI3MfmLDlUW+7kknHCRMyuVamSOMrFcKJX7fzcIHXUW/eSpQ4dTZTUWYwN?=
 =?iso-8859-1?Q?HIFxOlveUnNDJStFcQm9sR6kQk6u4EO72NJ60if+cc9RBWNo4ApfTG1kF+?=
 =?iso-8859-1?Q?luL3mjNbC2yS+PmIphG54s70AyjO0qQnfAQ3W321JVt6o1Jv3t4yFQHsf+?=
 =?iso-8859-1?Q?tVwz1hwBoYpD1m0ALxeY/PhGjD47Ualw562/NntbR7KH1mFSreus9X58sU?=
 =?iso-8859-1?Q?Pi649sESBVM1jk/s3ym6Lg4HuTvCRkF5oU8Qs8EJPXt+e0nEItUe+M9/xU?=
 =?iso-8859-1?Q?w7J78A1PhGB2YQMgrEaGGJaWaIgkILmA9qFbqzqMsmR2AzeRGg4wNVtcdE?=
 =?iso-8859-1?Q?aeB000/ZZP1Hc91N8WG9ZsLHnp91HTyKmbVt97faKZMvwl5Or18rioUh3i?=
 =?iso-8859-1?Q?bNTSBw2eN94thEqqAQKBfdUKmxSjxyHZC/Cqmm+bJ1OZyDNnjsr4JPzgFT?=
 =?iso-8859-1?Q?NPS1TtGQByWfopLNVe9VTk6McuGXB/C+k3HlXTYZ1qc103LC04MLeCIq5u?=
 =?iso-8859-1?Q?J2Myj3WZNrfYk1PC1a4Y1exjwNHhFUD/b5J6pRULPmMXXfi9eFGyVzqHpT?=
 =?iso-8859-1?Q?Xn2ZN4/F8bqzW9bMU5B4s+5dP5jAvSwWAqbacsv7EfuSO7+BJDvgAWnm58?=
 =?iso-8859-1?Q?adwWER2R5oRl+i9cKYjDXZMxWL/T3TB4F0KNn+6z1rMpotxXnIufVkD4Vg?=
 =?iso-8859-1?Q?qZffrsY1o9t6tvBocuPNpycppA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yaNwrP6Xn9bRdaKSPw4qGE4JFFSakeeqMiKBtXBGb2blwmza30BmRIm44j?=
 =?iso-8859-1?Q?vM/f+1snh+pqUiwFeGuJCC3eBszh2FamfGHDMzjX02K4BToC3z3rG47+Fe?=
 =?iso-8859-1?Q?O0PtVEQ4ogznsUcj7j9lPyP7rJVR9qYjW46E1vghbza7NRA1bQra1IFDTo?=
 =?iso-8859-1?Q?gKp21PWlZRIvV4gq2YDhBVOny9g2nEXPImjWuak2bYotyMoEpJEYlV7BDK?=
 =?iso-8859-1?Q?4WKZ8IEUflmrAKhqX7vnvujA/k+zogzpq9VWNlVAvhpL7/gnWautlHppLX?=
 =?iso-8859-1?Q?XHB7JVdQ2cPOlmNKY2Irtji76xiSzWWRb/VJB9dcGyCxwgoysTVgLa7e5C?=
 =?iso-8859-1?Q?zP+/LHSA0GYCLCCKXYM1OKHbL7kZz75U+KFT2A8Ve1Vlb+g7rwDmioxDtY?=
 =?iso-8859-1?Q?9ddwK9A1GoBl3NMkAU08sx7Hq2Xq+uJ4Y+4JvD4Ic/JmQEF/7AnNGx7CbP?=
 =?iso-8859-1?Q?CKZgNWlYLjGPByMyED5V9iz1BttPikiFOCj0h6+BAS0zxXMqy+gEnppu4j?=
 =?iso-8859-1?Q?w85XOTextuqKHJpIdYaAdRvjEG0Ok58PrjnDSWK6/nPaEnBLYppBYkmD+g?=
 =?iso-8859-1?Q?fQGryrl8toxaRCH2jIVyVJyJa+VKatCyAdKsspQuGSn80vn/cySNuwi7NQ?=
 =?iso-8859-1?Q?99E2JGxcWpUAaPAcONL4sN9nW0nOzUUPH7mJ5DhiiNYrrjydmgUY1xhgeN?=
 =?iso-8859-1?Q?2KQW2S19jncpmoiSbEeBXo6WgwUznWe3CHfZGSNRsy85tqbDhnp1LrghJL?=
 =?iso-8859-1?Q?41HxfArY1zQ3G8kABTIyMuslV5vK4h9Qx2BJR2/MNxQz0HAWWykjbZhb+W?=
 =?iso-8859-1?Q?UAN2NzOkI1eQeGx/VsE+LSyqQ6FYD5G/HavpxRHe1CJwYBDY+awcGVmIdx?=
 =?iso-8859-1?Q?OSQq6BYiEAqoJ1tdPS5uIbPDhclaMfgDQYLmho4BpzJ0KMrVn0YUFQXQ+U?=
 =?iso-8859-1?Q?nR86f7BWu0zX8KDK0JwkxJSmLNOP9rVXY5NxVVsn7zX6mLn7kUBrUMaaq5?=
 =?iso-8859-1?Q?Pb8R45K5VF60rMwNG3ORX7+FSlSwaNmUJKPVC1t+nbaQPZbt+15R6eywEB?=
 =?iso-8859-1?Q?YoBWL6yaymn7TDIdK6ebLcfsovCJflIgdja1KBbpDFl1OA69z7hAyv3YuY?=
 =?iso-8859-1?Q?eJdE1dW55ARuGGQiKDN9ehZ/CSfH2+621aPuwT72lkE/GTdnaFSr+VYtNx?=
 =?iso-8859-1?Q?/nQjquX1RP49tAwXtJmfTodoMw/IISMDcFNRqVcRKlqEdnBm1P0mP6aswB?=
 =?iso-8859-1?Q?m0f+3wZrEtTrtsWP7/UYWNfpx7elddy4El2e7oOkF1K9iHmJfk5nyGsNyY?=
 =?iso-8859-1?Q?9dFgkgIrJYk/ENZWe3zF8F3S2aZc/LcPgUWcRbLL5IkFXr41gwivGklL6G?=
 =?iso-8859-1?Q?QHboK3tol/i3NaaSGv6yCWLWflMuYG+AwNdNdCzYXe5NzOF+lQctevubHr?=
 =?iso-8859-1?Q?vSnJGaYg+H8hxlx+cQx15Z8DYtpvcZL78RJhshHO58REeKfZwP1BgbwYtt?=
 =?iso-8859-1?Q?e+32ivQaFQSUbyRoPCFs392hswynD2dNuxcdgO04O9hRwEaNzjBA+EVLfF?=
 =?iso-8859-1?Q?wSzRIzf7MMiavHPQpyYIwIgTNSMvnbX2g5N97PWANAGATFjF+qF16nbQaT?=
 =?iso-8859-1?Q?qozuRNrTwwUvYZas8n2eLwrxnJX1ussUI7jOq/jtJ4S/bTrZbMb+aFsQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f289ed44-09f8-4462-ace1-08dc66d792c7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 16:32:04.7718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9kJ8v8Ttaxx6ZOmu1TKOANXpryDQivxvTV8K1XaUayJo/phgY/uKvQk3XJWCfiH3/osj6t+WmkZo3e6yEk53s0Hj17V/xMNNxIV/j1TPFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6790
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> On Fri, Apr 26, 2024 at 10:40:53AM -0700, Dan Williams wrote:
> > Lukas Wunner wrote:
> > > Commit dfa87c824a9a ("sysfs: allow attributes to be added to groups")
> > > introduced dynamic addition of sysfs attributes to groups.
> > > 
> > > Allow the same for bin_attributes, in support of a forthcoming commit
> > > which adds various bin_attributes every time a PCI device is
> > > authenticated.
> > > 
> > > Addition of bin_attributes to groups differs from regular attributes in
> > > that different kernfs_ops are selected by sysfs_add_bin_file_mode_ns()
> > > vis-à-vis sysfs_add_file_mode_ns().
> > > 
> > > So call either of those two functions from sysfs_add_file_to_group()
> > > based on an additional boolean parameter and add two wrapper functions,
> > > one for bin_attributes and another for regular attributes.
> > > 
> > > Removal of bin_attributes from groups does not require a differentiation
> > > for bin_attributes and can use the same code path as regular attributes.
> > > 
> > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > > Cc: Alan Stern <stern@rowland.harvard.edu>
> > > ---
> > > Submitting this ahead of my PCI device authentication v2 patches.
> > > Not sure if the patch is acceptable without an accompanying user,
> > > but even if it's not, perhaps someone has early review feedback
> > > or wants to provide an Acked-by?  Thank you!
> > 
> > On the one hand it makes sense from a symmetry perspective, on the other
> > hand the expectation and the infrastructure for dynamic sysfs visibilty
> > has increased since 2007.
> > 
> > That is why I would like to see the use case to understand why a
> > dynamically added a bin_attribute is needed compared with a statically
> > defined attribute with dynamic visibility.
> 
> I assume "would like to see" means "on the mailing list", which would
> (or will) be as part of the PCI device authentication v2 patches.

That works, yeah.

[..]
> Each signature needs a unique filename and the number of signatures
> that can be generated is essentially unlimited.  (Though older ones
> are likely uninteresting and can be culled.)  If you want to expose,
> say, up to 1000 signatures per device, you'd have to allocate an array
> of 1000 signatures (for each device!), even though the actual number
> of signatures received might be much lower.  It would be a waste of
> memory.  It is much more economical to add signature attributes
> dynamically on demand.

Ah, yeah. If it was a double-digit number of files then a static array
would be ok, but once it gets to 1000 potential files, then dynamic
makes complete sense.

> It has the additional benefit that it allows user space to dynamically
> adjust the maximum number of signatures retained in the log.
> That's more difficult to implement with static attributes, as you'd
> have to reallocate the attributes array and adjust all the pointers
> pointing to it.

To be clear, and for example, dynamic adjusting an array of attributes
based on userspace input is what cxl_region_target_group does, but again
with 1000 potential files the static array would be silly.

Thanks for the details!

