Return-Path: <linux-kernel+bounces-426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C56FD8140FD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852E7280722
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E66253BA;
	Fri, 15 Dec 2023 04:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GgwZseyJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735B9CA66;
	Fri, 15 Dec 2023 04:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702614859; x=1734150859;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WsrUdfL9vHOyZrKwIhN7vkucSzrN+vhjm2aMfULV3aY=;
  b=GgwZseyJu3t8x8Gyq7AZVsLUs6j8MoXl4s5fbRE0+kdlOR95oRVayyUU
   0fXAzq5OZJydPwJbwmQre25Fk8MnB7kY8KRDh9ZhdicJW6HHX1iQ4BIsh
   nJXsm59Zl16pnXPtbteGzqoTiRynGcl8cQ7avPs14IIRkJy+L4VkKwxgL
   HHFzBDKeeVnfnqXj1UqXHBnezq6U56Px66Us5cV10JV5Fa1gjIl14KwX6
   A+qMZ/HT1WOJyzeKa9iAsyeeQbT1GoWPLwlWIAS7MEsP15NEvqOVNIy+v
   cCQYujw4zoHlV3pFd8BUUtLH4nfO/eGpARLjmHF9k3PnhaVtsoRgeCaPK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="426361539"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="426361539"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 20:34:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="840532503"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="840532503"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 20:34:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 20:34:18 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 20:34:17 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 20:34:17 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 20:34:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7itOnqqGmPKZChQ7eA5QP6s4Atc4o/yzNWHBl9mslc1LJhbfnERclwVNgAGbv0Ql+vRTz2bP9hmIAysVhQZa0RCZzBJR7lO+oWu4VAXqo+4rHHEYFwrt/ZY/sNcLXbPQC6KPnvGoeSKI6q8SKyCmA1L26ueMwBxJTOU8iq1oozph300rr+82wBIMcG4bZcRb0oBYbnztZ4wsTXAMyFSw//nQ+na7I6Fkvf9rcpWJ2YiNwpd2Z28BZKbC/lZd8SgE862REVM80MLNextS4udZuB+b7l1fcGbiHGQJCXCK2JAdZK1JsTRJyfwZTmIBDpTlvg66gk7q4elWLEkzCwwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BN0bwlTRVW5it1PhcUbc6Ci0cOsT2PdCDEtyR0khC/Q=;
 b=gy9vrwJ3XBXWOoXUmY2NMr9UlBfqobooj6VzL45xYK1oP8RL6JLUGFkIODWyxhhpRwcsXOESOnUbIetfyzv3wEHTF4SBs5eX5hT9rR+yFwhENnPQ+UvZK4N+8AgKYOLskajJ84fv9FGyb6KzCWJXjZjcHpHBtirwN5x8TwpeoLQbn+lTBkYFzKSZYf/mzksZVfrbCc+l9Geh7G36B4H1EE+lKXJiNDrh0Bss1+hyopQD25q4RfNNSHn/QeLYZ3o009YubGTm6ibuNQ1iIXXXdL2vqH6e89WsHUDSMROrVdNttmXZFOiA2e313+mZw7mQs/PAx/4lV1hXKd97DXwnjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6763.namprd11.prod.outlook.com (2603:10b6:303:20b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 04:34:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 04:34:13 +0000
Date: Thu, 14 Dec 2023 20:34:09 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>
CC: Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Fan Ni <nifan.cxl@gmail.com>, Lukas Wunner
	<lukas@wunner.de>
Subject: Re: [PATCH] cxl/pci: Get rid of pointer arithmetic reading CDAT table
Message-ID: <657bd741d2961_269bd294d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com>
 <ZVfIaNhiSc-yQZo5@rric.localdomain>
 <ZVfJ6Fxidvw_gz7r@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZVfJ6Fxidvw_gz7r@rric.localdomain>
X-ClientProxiedBy: MW4P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fddf615-e90f-4969-d24d-08dbfd27168a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VyHjYIKBJ5aYMi0dUuSxkZHoxInNR7zPbG+QvbA9Bq+WjuMk7KkW8w7fhxicphK2rxTlhS2iKi7REiwObhnTBljFQZT5TZEyfqh56mtNOssXHWVZljcLdMTZGeuKnqIm+o9V7vUrMslsVeeahTYuBQb0R7HNPsCfEJV0SeCvQR/9UJtcxcW6X6LU7T9Uhlcikbqf6z3ipTvgeSzoLVrj/4du09RD5SL5K4j1U/c1c/LdtegfhVaGRAaqGje1bVFePOsMJmvomR0hi+Z3sEaF974eT3Cpgz6K2F333qR8oQHxNvo4ABIltb+oAEBpKduZ7mDSaYugVcuY1Af0Eo2d19hWccq5W+9bYfxXsvV7omso9OxxvrgFC/RA5PJKDNjwc0rKCUOAt1+SU9VkbOSTIXseDV9gFcrgmosO0lifx23ke7zTpYqjjDBdnngXWkRtbv6OQswFR0SYrk5dnWZOYxsTvle112Te+Id0Hy9OOUzuZZxxuw8T4c80+B0tKkwEdc6YfwYauMqAL1xbLlgDC8ljUWCp5SIPKVxmuaiIxeBYDl9otfunK8ixqDyZf09stt5Gz3U4VnjRXfA4RjrDUw+gfDbW5BXlCYMXUJ2v950=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(6666004)(53546011)(6506007)(6512007)(83380400001)(9686003)(2906002)(5660300002)(41300700001)(8936002)(6486002)(478600001)(8676002)(66556008)(4326008)(316002)(54906003)(110136005)(66946007)(66476007)(86362001)(82960400001)(38100700002)(26583001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ey5O0UwWa/i1F8ppDCwK91Wz4u2mCqtNQH48rVAzjV6yz54AzeM183UzL308?=
 =?us-ascii?Q?HmJ6VmUP1gGD2yL88nMU/uXLM6ZGroOGaeOfbgJ3p3yw7sjcf+qcts0pXJek?=
 =?us-ascii?Q?7/HDMHAt3ZCqO9tyeMqzJr3yFPbTRPAMzrA9rVdOG25C6MhJ37o7nGG0N37u?=
 =?us-ascii?Q?MAJXYt6l7HfRD219/D1tqtwKo0Y4oQrILE6ltpFRn8HJOPBAHV0KUjbtM7p9?=
 =?us-ascii?Q?RH7O7WJvXUJYx7jl6y5InW8HLPqsiB8VHoXO+b+g3S629otITbASSZCoKqbI?=
 =?us-ascii?Q?OjQzI2TjCT1wasJuzJeFJxkC6Ft3VhTsiDJrDfOnjtKjHCf57MoJtmnovpxH?=
 =?us-ascii?Q?kRX7VnHtmSR+sUTNxm4tDLB6VyfGB3kSc6VgpY+IcEFlKm06fgHNGA8tu1Qu?=
 =?us-ascii?Q?x7eGkHFHPN5pYR+uEbS162V6nWzd9p7EYH+AVPQAmRxJ4We3mQ/Cgdh8sVUQ?=
 =?us-ascii?Q?cpI0J9Jo0R1XMlA23w2o1+7Mr42lIu6p/9d7j0Ofoh9nHRp+89KHpi/7luGu?=
 =?us-ascii?Q?b5uqTR8Cdygzs4r7H3Xt+rmHiOvB7Jkexpoko3PUFkwtZEgtzzjnaZ8v4FHu?=
 =?us-ascii?Q?+roFAf68dG5yTf2soWD2QShBEJDO4Rryn9gFKKtp5s31nP1uKWQI2H0NhbPU?=
 =?us-ascii?Q?2R4hrQgq5GxZ3iIyZ3wCKRMUcpUuk4wzLA4BAK+/ybJ1WDkAIjeFhjR2QG8Y?=
 =?us-ascii?Q?NOAZYstFNifZWa0sx9C8Q+NG0B6s4YUaVn0Jclmjh3IpDEtFAQA04+hNOpLU?=
 =?us-ascii?Q?HeVeRIXqwzlmrM1uQWOsG9Ak9rGQqo7aqaBbjSXaBsMpLyWnjTZbHqLgkhxL?=
 =?us-ascii?Q?EkfG3AeXIffx9WNpdjVTghnoP/F/a37f3jNmYc3prnwzjFE1UNyxARMw3Q9Q?=
 =?us-ascii?Q?MyvrwLcLP8ZP3jyFa3zw8jTyBYL6CN0XxKzbK1EW7Ul4TCsXwCWPJ7gz8OXf?=
 =?us-ascii?Q?xGEIlZuO5qCaeWZwt/qoUDw8a1848fylD52w1N1IcBm4utl40G/KUxW/uUFp?=
 =?us-ascii?Q?lvZZUH0SKLrOjii8Lo85GoAAxMFGEoQbC8xkzngDhY2OkveJT9GIhAETopxg?=
 =?us-ascii?Q?+QUOrevPyhbgjRx2g4PCYQR9nEEFZVkP5FXSb/RuEBmpv9u2524Zego4/DSp?=
 =?us-ascii?Q?JQQKOJR4kC900TdrrSEmvgockgzXquAOsDhOoHpJdM1B+AX3lvD7kLVNSNPV?=
 =?us-ascii?Q?UxTx3u1NCYxdOHmX3jshtB9OOJjWV3xcfjSUxT0HXDqcd85GcCOM/1MGLV8y?=
 =?us-ascii?Q?0WELd8U0HLxiZxSCcFj8Z45ltR3nmgwM2cTdAu+ovecNC/d7Z834Er94u4j5?=
 =?us-ascii?Q?1bRlnCi1DouYyePZ1C8WDvTrISkNTZPzzt4r3MWdAZs61MBRZ2q3bD1bzmTU?=
 =?us-ascii?Q?brQK5dX9xLTQ2649w4YhdbLH9MR0wGWib2HJlPungT5cKrOdRwQD9qf3QrTo?=
 =?us-ascii?Q?AgluyftFHufK1KDQcgc/lOSnBSGc78kInL1fzvB0w/Wv7hjmK4/MvK4esQwi?=
 =?us-ascii?Q?kTezIcj6kZDE+J46vc2T1Yc6Hmn6+xydw0/qkMCiDkD3yLoU294C7iKvO1I8?=
 =?us-ascii?Q?Y2kXioHAH4sfjzYpzmNbvQr9hOvuQYKkaRgQt/IicG1hvtfk/QI3HLDUORnm?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fddf615-e90f-4969-d24d-08dbfd27168a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 04:34:12.8686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YS0ifDvWPjAfJCZmPoV0uDkaxKnWzsHOSynBrl83gKt55l0mQbZdz3l1t1YXkBmu8D2pRta+mT4kYdNyPY/kJyC6A+XxW0X1uRB3mZsrhTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6763
X-OriginatorOrg: intel.com

Robert Richter wrote:
> On 17.11.23 21:09:18, Robert Richter wrote:
> > I will send an on-top patch for 6.8 that reworks that code area to
> > remove the pointer arithmetic.
> 
> Here it is:
> 
> From 13787f72c20b8c54754ae86015d982307eae0397 Mon Sep 17 00:00:00 2001
> From: Robert Richter <rrichter@amd.com>
> Subject: [PATCH] cxl/pci: Get rid of pointer arithmetic reading CDAT table
> 
> Reading the CDAT table using DOE requires a Table Access Response
> Header in addition to the CDAT entry. In current implementation this
> has caused offsets with sizeof(__le32) to the actual buffers. This led
> to hardly readable code and even bugs (see fix of devm_kfree() in
> read_cdat_data()).
> 
> Rework code to avoid calculations with sizeof(__le32). Introduce
> struct cdat_doe for this which contains the Table Access Response
> Header and a variable payload size for various data structures
> afterwards to access the CDAT table and its CDAT Data Structures
> without recalculating buffer offsets.

I like reworking the code to introduce an explicit type for the response
buffer, but as Ira points out, lets call it a "response" not a
"cdat_doe".

The feedback on the flex array is accurate, but I see no reason to have
3 flex arrays vs:

struct cdat_response {
       __le32 doe_header;
       union {
               struct cdat_header header;
               struct cdat_entry_header entry;
               u8 table[];
       };
} __packed;

As far as I can see nothing outside of drivers/cxl/core/pci.c needs
'struct cdat_response', so it can stay local to this C file.

While you are working on that I will do another lead-in cleanup to kill
the goto in cxl_cdat_read_table() and let you come back and kill off the
open-coded "+ sizeof(__le32)" that I will leave behind.

