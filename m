Return-Path: <linux-kernel+bounces-45777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11229843621
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E5CCB2389C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971603D995;
	Wed, 31 Jan 2024 05:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EezwnE/F"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797923D964
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706679596; cv=fail; b=svzc37vOgUdeUOOvgxCszzARmJmy2anTM7mQko73o8MC1HifYLcCUiPgo0cqNcpCmrywmTbFse9UIC2E9j9nWZ+3rx49UmpS4lA5dWVT25fjtw5fpl+ZEA2mU/RcQWzvy899+ZgURb0wuBQOMz1d3lXDmgwLgnFKyKdztScI10Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706679596; c=relaxed/simple;
	bh=tDNvStFRsgGwrhNGTvjftastO3YvrJQIZtpaiPh1HkI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iJjuf7RV6W+cUUsvcnuka9NpsIePJLHN1Crgmwk8G12M5egvXjF2d/qgG+qHUCCs2Tph3OlgdalppQQcNmyx252MeLa7jEt2ekMS4psju1p1NAe9F9NX4yJe8ej8D5vRLQn1unwWXkNrWVaUYOTT3fUV2c4K9cKRWALnnR5o1UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EezwnE/F; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706679594; x=1738215594;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tDNvStFRsgGwrhNGTvjftastO3YvrJQIZtpaiPh1HkI=;
  b=EezwnE/FxhDquKHXcraZ5Mu334V4+8psSfWRNR277PGlpgDKfojdFQFe
   46hQ6P71vV7Cq4+mMAdmW+EJYnUvE5F1dNPv3vV/SZrHyp0ifF6488UGJ
   FDeyvSFva48ecii67aIGylA08gkZtk1wy/NBx2+nuZQszSsSs+Q+5FmxC
   esruD2fx3rAKgakaBa42KKosB49E5u1GZF5p5p79/BhpW19d7a+/OWaVt
   hbUXJLU/vCNZFiIvHEh8qZ4z/EReSxNqXIy0nRStoxr/fGq4Uc7mybSkc
   i66ctJyvPEC5rikimpu/2/zNMnsp4jHL+lj7DZfLu6FPDYsZipfO58UDS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407214222"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="407214222"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 21:39:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="858700745"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="858700745"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 21:39:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 21:39:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 21:39:52 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 21:39:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpAASZeOG9Qn8Olgd2xCU3VXtC9UqU+SnK5QzI06CP6W+MPKOGEWrGKLvEqsNy8Oh/xDyEb0svgwqIgJH5KSomV+EA8TcgpN1tscEqf66PoYW24+7XoLnYOABqNsg66y0Ph7UmE5C7roFGD9FVBPmnd67wAJB3jFOlzC5ywxlw/b1BBOxLzMjx+0dGDSGLy8ePBRexJ+k02rc8hvKA2NynNno3HvmJBbZ8ona/hPp+PftHPqq5JbThpfATeI0p1ODdwOt1QEuGUMsiuzUBcmQaUpIYgikn+qEL+UPD/5pz+1JYCtOJWdAWwOvdEXUKG1sC8eapvpwe5OTbXXnhCyCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkOXcwpvB60iTIaoBAxQS+Vndv8zjCD3SRRdmKG5Heo=;
 b=UQDYfwZjmwvtjH5x8yrfvbbO3dD1PX8QK0e66f7dycbByswdkcrvRscEQIXPaQQlZNrNCaYxZqC8rS1ZfKW/mT67i2veAknwwMlP+jN2v/XOwt7geHj9IJL/kn2Zq+gTY5zns2mA2bNOuXfL5l1MRaAgM7jz3TGujonvWOoLEOa2IRTeCOAM6BD7bntRcLP6pwtGdyqBFU0Cm96nwcfhSiZBD00mQxob8x1c9Qk1vkt2yYeRyZChUxaYdv6yCMoF+syU6nyaEg1CYc+d0TVGCjAHO2UWUHCz174vJSULMj9TdjbUeqP0aYp4sEdU9Spy5Zux3QDX6Sp5O4CAh45r9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5358.namprd11.prod.outlook.com (2603:10b6:5:395::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 05:39:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 05:39:45 +0000
Date: Tue, 30 Jan 2024 21:39:43 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<alsa-devel@alsa-project.org>
CC: <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, "Vinod
 Koul" <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale
	<sanyog.r.kale@intel.com>
Subject: Re: [PATCH 5/6] soundwire: sysfs: remove sdw_slave_sysfs_init()
Message-ID: <65b9dd1f64d0d_5a9dd2946e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <2024013025-spoiling-exact-ad20@gregkh>
 <2024013030-denatured-swaddling-b047@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024013030-denatured-swaddling-b047@gregkh>
X-ClientProxiedBy: MW4PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:303:8e::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5358:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e489e2-e909-4ac4-8aaf-08dc221f0803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /haw3s6T//tH5vqA1OozvJx4rLhqZzlj0eockxmPmDsaSHidS6CAU9tf7gTEGkIlxvjY9TZ5aeDqWr0bG6LIldtL6MZtuNzuWxqxqLXzP3HhBcwm2NlLwBANBvwr66EUVXxP2l3PUeC52CklfqxIhtd6+SBtQoNjL/u4AMKq/alSJeQ9Jnt+uUngNqm9fyH2giSRNLosEkVBafxPCQTVxkBseFefRaoIpeyfEODTGawwXCGbKNjNTEwnov2/NNsH3oj9nujBrzuJXZ62u2Ky/wf1Xr5M/KQvsH0hLqdK6g93HkT8nghwU2JA6Wc5XvpzsUTBkz4hlwlvVx/s3gxeUHLC9jCbAHXbBathFdMrn4I7B62ldqwscAkBD73env08m1xy/f4XWWgmPUpnlQEqIc5PfuR6EJ3/Ld82bvUwFB5P4t9YUoLIVsLe8WE+mreD17W3+edvbBz3SexkWescpSmqOymvsU8+lBIiVrTitFhhfpWRq1xN34pc7u3i1bQILs/NUcS/m9ct3Jn1dZByL+OPIMrMZjgZH5ZKP8+4f5qAo5Xwu+JVtaEencz6uRIH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(6512007)(9686003)(26005)(38100700002)(4326008)(8676002)(8936002)(5660300002)(2906002)(4744005)(478600001)(6486002)(6506007)(54906003)(66476007)(66556008)(66946007)(316002)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n9rCU3ipdgnoqgOI4CbrSTLAkn0xh9hhFdf0M34SioUzIjt7nDH5l8Se8uYf?=
 =?us-ascii?Q?XyjYt1hqEngSWN4k8YK4QfeqSjAf/IoNtUv4gXzMF6z17cNzXqd4fHcvFC5Y?=
 =?us-ascii?Q?6+YG3YKaD70Lo9tMZ6k0KUYEup0QyaKnIMtSwpn+WUVaXu1+6/r3SPaZn8Zv?=
 =?us-ascii?Q?nEOkyTb2thB12qvkZYrHZCMEYTsE30D/aystDFdhlP6KBTCQFkLWWT6WMUhV?=
 =?us-ascii?Q?dt8XqZ2nPzOHgzEwSA8/TFbS4iKYL8/V3uF/b1RoAN5b8ugAxm1PT1Zav7Ed?=
 =?us-ascii?Q?uLoxZLzfLJL4oKxyIt1OXRzoAX9a7LEFQGo/6VyU1fln+0kaZm9PVlYsjEEa?=
 =?us-ascii?Q?Oc7BJknvxMbaz7U2xLgJ6GfFvdZ3PjtLf4EZ4w6QHgMrgM2BqXgGmGgBSULv?=
 =?us-ascii?Q?IcOk6yNfUkc8dfC4CU1ml6236KcCirt2dgssmn3bkUalfSCxRqsa+bZDl29g?=
 =?us-ascii?Q?NuZhMwTvOzkaPIWrvx6kWAYQInYznF7/vAE8i/da9axPxtxIVdPXR2y5sm99?=
 =?us-ascii?Q?cBjhuP2hMXRI0mQ5Dw0ebiBN0XEqkV0S0aY0alZWp9Z3icQwXuYlRXv1HG4S?=
 =?us-ascii?Q?VMXpbzWX3fWUAcWWYZWc+CpDmqgYAbN5K8/EBex98HfOzGCIE8z6PNp6w/pH?=
 =?us-ascii?Q?QNyUdIVRZ3sEGQwP7Hhsi8v3XgAWedVQz0YspdOdVT/dAf+LLU2hbhtShHTx?=
 =?us-ascii?Q?Y/ZvPy8P+0T8+cFLSDIo0F7qDI3lzLG0towJ0ZFphBfSrVQUNtPTvMeInRla?=
 =?us-ascii?Q?7L2XWnjbk1gBRq1X8Xp/F6TpBcMRyuehFJfEk1/bqzR0dBcxOEd4o2TtnKgW?=
 =?us-ascii?Q?iH85fOYseDp8AaU+WFXbhgjeENSqKwpaJiKvMb/tLRjiLj3qlVTM7jLafS2s?=
 =?us-ascii?Q?5q35YAa4JIggQCEkRFaCQkPj1APRg4JnNNo2tq9rwWHXqlnpEWxHD80zdODP?=
 =?us-ascii?Q?jHpqRJlZSXkQ7aKtEr8ye8ASFJoOU/Dm92fdKl8g5YINYb/HXOX5hjHg3eQI?=
 =?us-ascii?Q?tiztR/DPWSMIjAgRIS+OHr6btnMfV9sjkOS53FmcTcF7CGx4le2qgnrrF5Wf?=
 =?us-ascii?Q?4QT5WvHY3N5lFZYxZib7z+aR+la+HohPtO9aYanmyrWh/iBpTRKzSUVzDMlP?=
 =?us-ascii?Q?HsIFHkPBbAkPSOXolTAfg3u+07bgkVI9Pj1lFhqJgLaiDFtlXyS95rEouPH3?=
 =?us-ascii?Q?zyjJ8zuPZSXXk/XcciCrLXR2OvI22PYfltKnxAGyhi5G31logxuO8jKOSIFb?=
 =?us-ascii?Q?6oIkXK0oLaB3moElaIkWIZ24L0srEHbgS8xpF+L5gdrUf71OLkXKL7CdTkiQ?=
 =?us-ascii?Q?LgYFjJJU6WXQfXEBMI57kRqO/YKEHJCerw5adxiTmeWX89QIkvHUQskFGWQb?=
 =?us-ascii?Q?3Hatkx2O60F1+60gX946K8ft34j0kjazIFhXDWlNmUZ1UkbO5cGA7ysPki6q?=
 =?us-ascii?Q?cD0USP39LWC5z32YImltVPNk6vws/u6PV75XUdFkoRtzvQL3Cnf8W9I+Iiwz?=
 =?us-ascii?Q?HDBmuaIP4kkaBO220GTjwkhlizxBS4N6zqRgO2TKZlfUOOI0A8ld0+Bh0xhb?=
 =?us-ascii?Q?RKWg7Afc3v4JM04BZMYbz3DZrIQPlr5XnMsiIoufQrin0Gu7ufT/CdQKVk7T?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e489e2-e909-4ac4-8aaf-08dc221f0803
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 05:39:45.4492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnIQuBrgscTUTTg/G//aUruz5dnOcxxtROJd+WqvGasfP9OsdHarzucMUne/ynmc3e8a1uENAYB8mMFWuruFrV+zXVpgr/gIw6nWeoO0fXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5358
X-OriginatorOrg: intel.com

Greg Kroah-Hartman wrote:
> Now that sdw_slave_sysfs_init() only calls sdw_slave_sysfs_dpn_init(),
> just do that instead and remove sdw_slave_sysfs_init() to get it out of
> the way to save a bit of logic and code size.
> 
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Sanyog Kale <sanyog.r.kale@intel.com>
> Cc: alsa-devel@alsa-project.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Looks correct.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

