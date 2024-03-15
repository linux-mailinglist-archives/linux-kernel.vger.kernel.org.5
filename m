Return-Path: <linux-kernel+bounces-103953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AED87C6FC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA79281FF3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005744C6E;
	Fri, 15 Mar 2024 01:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XyNsjPRN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE35B17C8;
	Fri, 15 Mar 2024 01:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710465271; cv=fail; b=Lz4w6LmoSQpzeq+D5s+BQHODiq+wTh58DiA4IAgFhZWyzcC9uh6X4e4Gb5UI8L6AzJS6VMhMAWiW1xfD4ummcUfYn2kL7tkaf0WnC+eeKLs9Wvrw0AkgiSBLIQw+Bhs/lmZcymxxBrJl0e8vC5lmxMBVg9g1nk5vHn8WFQ+4+ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710465271; c=relaxed/simple;
	bh=ZLpSh6jwMO+uzzk1Xhun/ZXH/jeqRU/dtPPv9jkJJQk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bQWo1JLnKkloYSUw5J6vj5cg710x3wzaFaC0Hx0G/DER7mtLeegHyxDK8epeQhAASVnfbx5ZpJRO0lOHiNKVI6LxKEM+a2G4uQxYJ6XpLMv6pDFmRALZ18QYsXDayPMqCeGGf/4YG7hYj65ZW2ioMSwMS4FJzv9FImlrY1jKcFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XyNsjPRN; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710465269; x=1742001269;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZLpSh6jwMO+uzzk1Xhun/ZXH/jeqRU/dtPPv9jkJJQk=;
  b=XyNsjPRNXgQJvjKiY7ioeZbgnxd9yKpUBykxmxjVzC2qzRTe3JxZVhwQ
   lwhrbpqQMWoT1nk7jkKbJhPlMLGwhp7/eFYHD42GipCmzVM8mBKahxFj1
   LPfIDG1g7ubjZRqQjkwZbluoz4ppWhtAT3IfRLg2RnlIg17b6/qRAWjgw
   QUe91A6sELxCxg3hqbEnHtwhrq5ve0ydL9R0Nd5jYEKfAX/PShFMrAWDH
   ka7uhj9Q/3ZRzjsNyqup7XhrTK7WE9ttmZhln+Ao616XR0cBXl/iUgLo/
   8SPWrBJsIfO7msOmkDylpTeTPZedCzebhLd2pp6jHA7B/xze71wpmGVPk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5185927"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="5185927"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 18:14:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="12946215"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 18:14:27 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 18:14:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 18:14:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 18:14:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdsDzO0W5lovlpxz0YDs/GmTFdlorwQjeIL0lcBtepMBYWJbTlxOT2R3ChvkBpteAAnrB+fhS3SVqIj5adC3Dw7K7y3+HNaEwoMnDsTc39hywICkQ6jLQfQ011SD4QcK6iFxbxiUBit82ZJW2hfp/jNTTR4PUFqC1S6guKm9xDv22RySSwv3OGfaCfTShCcxQ4OBaulPjOZXWfLCMNOl87iWbE958J99awu2QannnM4WqRNC8CgpZy9oqD2zDknsRX7aSHvPxSS3h4eRHhk5f39RjfFAo3X3Q6X4SLNbR+1K88elWjPNM5TxRxlWSCtaJEGFwkveYhuAmHv666/v8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0N9dIHEmMKA+lAxCe93N08vQDuyimZsSzp2N7BlQbq0=;
 b=JGe/JhaI5pz1gKRcy+gCRvioxyP2QbNQZJ9Xo49KIB/1t49gN7phm6Sm3W4pSpal5GhcZSpr0CV4ShX+vhE5rdAKYOLAkZl9Oa1w6H0+y912KlKMRq4tGtFLns7+Ju81EGUOHgptAFXLRNCII+HLjNWNsDxElBKximoklaN/WxKSZ2UDHW2gn6qg6IQyL3U4hTcd/HScZtsm01rHo3tl50kPBmCmvwi4neSGIw2AvmJq/8AMV2ffolocRbsVdsjPvnaa1jOEGeECo+k2+pk41fiaJ1X1LecCRzCrMt+LRThfl8eZDStEZvdLQV7elnLTm8EGMZrsaMMUrLXcK8Dw2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5205.namprd11.prod.outlook.com (2603:10b6:510:3d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Fri, 15 Mar
 2024 01:14:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7386.015; Fri, 15 Mar 2024
 01:14:24 +0000
Date: Thu, 14 Mar 2024 18:14:14 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Dan Williams
	<dan.j.williams@intel.com>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Linux Next Mailing List
	<linux-next@vger.kernel.org>, <corbet@lwn.net>
Subject: RE: linux-next: build warning after merge of the cxl tree
Message-ID: <65f3a0e6567a4_7702a294e5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240314141313.7ba04aff@canb.auug.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240314141313.7ba04aff@canb.auug.org.au>
X-ClientProxiedBy: MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eb67934-9819-46dc-d984-08dc448d4082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24ujb/JH1Q1xVhtq49Yh5RBK6ERcsXlWcObkw6w+qLYniRzb3eQ05A9rMDkEn9oqjlnHvpRg9kKQUwgSgsLkn022/foiNdYzCozKLJco1uVcOA+uQUDx9qorN0KLsrs/1DsE1PO5HpCPGBgu71YiMLboMjWSCSXtaXODqqRu+/If+CEl55P8IgDSO/GOl5gCkUwHN5CAMkLmdz0/k51AgAOWIGX7gV5+5ZIU+cCbfy5rphtIAGtYqyVPGA1BEYz5Sdu9OOUje67EO4/FZuTR1vTNRZ/7rBsRWDooohkdUpr8xheaEc8eqKYlPvOg2LjMynlg7j0ZwwYO8z/udbcakjf8Y2ykdDi6khKJ2651T/evCq60EtgDzgT0bP7gc9YFgrdnZcU0ucxYGGT3G+hEzVde32PdKgFxi7BosY+Wu2hJ6JU1PLtW3l7SongZXnmriKFU6+dsJLKJUquW2oYD1YybPbcndaBok6SNVZIi4ubNLEyTdiJZLxCfmuVrhyIkAaK1QXOxvMv9LkmvRPVCSN8hg7XkIC1FMnIgv6ROoXsRRZDgVzi8mhlg6NNFcRdNzVpbzmHIeN2fV/nthNrAs3dPxNi3SMg1TLkc2JdIINc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CcaVZnc0SqmcnjyejZapE130A/4h13/IN2mM3lwxd/p4/IGLOha87Clx6dH3?=
 =?us-ascii?Q?rsJoQOvCq0QWcwSgspC6yfLynp5HmxNkdmWb+O/Dw4oSyr/7gk9imY/M6WG3?=
 =?us-ascii?Q?9JtbFRGsAE3haEDt4GXe2CffxqC4Hx5ErApT1XxZV/eUAWc/Ot6IZGH/33o8?=
 =?us-ascii?Q?jRKEdhhwpnUQ1F9k/CcuDWPoKtxg9gIKmIlB8bZ1W1iPcyYnz7KNgkuMVHLy?=
 =?us-ascii?Q?SyN8jWsJ7bOQEKYI0iQZgOPfo13uhD9UfbU9O4zsMhTU1IbIrnqd2sCMvb5X?=
 =?us-ascii?Q?rNqlGibEgK0JgOLwZ61HSEsJQKkEKJzBjDy64crw8muNv/d0UzOOLTo7zD61?=
 =?us-ascii?Q?bzxSPxw4YEwrD+A5887F7XJMxL2pCkB+3FBdWIG75v09DNOHK6metmpQjwXi?=
 =?us-ascii?Q?D26uhlG8XsYA4eirQRUUcexO3XdOVY5oridN4ly0n6D5J/G5hXBawR70UsH8?=
 =?us-ascii?Q?UmdZO9jTKrcKYdZePQ9+ZGi9ariF3Im1Nqm35YJPf0fSrLId0fR4couEZY17?=
 =?us-ascii?Q?O3Juxs3/m940vKdRQ+umjy3EVz0W5aqe0T9Ov+Xn6ZrkuB1WcEp3WF2HRa5B?=
 =?us-ascii?Q?ASnY3EpR5rjmyvrNSNehq/XPA0m60SNt4jWrPI/bTi4TvqfRvrCYEF92l9gv?=
 =?us-ascii?Q?QfR/lYpMrmtbIY4AzidFDuXWqSwiOLDB67RWY7PQ8Pt877qUVOYZAN3RUdg1?=
 =?us-ascii?Q?WLLcxwHKJlJB4BhW7AHSEUMVsKENut3nCvqwlst2XrjXjEiJZ5gSt8+9uZEI?=
 =?us-ascii?Q?nZ7CY4qIukNE9Q3rrSJlRTKKOib72SgAU2JH9QoXqMn4MVuwklnGmzg49Fco?=
 =?us-ascii?Q?TteZGrTgxFPEUJxqgiSoWVuJjlUSHIXvvvizDUPB/h0HHbpl4TLZOjsAqmt6?=
 =?us-ascii?Q?nl2FLEAfsbGiM/aKmSZQfkZXZIrhuvRbwdZ8btwLzUQKrD8V0Jo54I/AxjHN?=
 =?us-ascii?Q?ty+hDt7XHoovxEYIc3RBzdUtQpLzis+xHsCmQfeH/z3cjBFIT3FiRp7uijCe?=
 =?us-ascii?Q?Y5eCo69GFNkfGobHwvtfonudEdqXvnUx4GgMNgKL0G6Ogp5olaTZmE1khecl?=
 =?us-ascii?Q?gAaNRDo9eroVUqny9qGTt91z3usBp2ayq6dVqs+g5O7c5/RFwU4I7DZtvd77?=
 =?us-ascii?Q?pR0rW6xmQGXh0Pw4FTELOJuMpHsHC28NQFxbbaJsQDuEwuOLQEHnMjB4WX+K?=
 =?us-ascii?Q?HQPcT4y7gUqw0cQK/jzt7xfW2N858kskFpjKU0VV7GfdHzKnJijCb2CEs5kC?=
 =?us-ascii?Q?UfTAGp84MZWwuygTb8hxBhgoUsOEVd/7QmYzvhQZNtzTWZIb0qjUPDOmZ74F?=
 =?us-ascii?Q?kwaAvz5FVt8asF4upNZ0qdNwhbMcQE9PfEnjC0zaNdfphbEh3NNyMuZiSZ9h?=
 =?us-ascii?Q?CZIuIQsn7mKMGwS52D6nBTIXPXeTkWccE3QNJhOcun4tCDWcSqtCxLD/YDwn?=
 =?us-ascii?Q?OyCnrt2XcUMleVYgIcZvp8f3nvQhOaOBzD0Yt/FBl01Y9nSedeSl9jmZuCpK?=
 =?us-ascii?Q?uxE2XDGKgXxUcjV4sNxEx8o1hbDCh5tVuZhDrd/qBX5kYdKPbPwtBAdZxfBE?=
 =?us-ascii?Q?TFJmVE0FIsRYpy4baG4f9+aTmDRmSpSJlY+BmRrq6T1t3c6pG3GYX3tdDU2f?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb67934-9819-46dc-d984-08dc448d4082
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 01:14:24.5186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pchj9I0wHkFIMpxqedb23sDWgj4NVhT/SCYvcPRAMYM5sow80R1SiiWt6Vg0m4MV8R9jOT4meVLm2ffL3Xpn/c71vjXuiCNu+PDImHscldY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5205
X-OriginatorOrg: intel.com

Stephen Rothwell wrote:
> Hi all,
> 
> After merging the cxl tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> Documentation/ABI/testing/debugfs-cxl:38: ERROR: Unexpected indentation.
> 
> Introduced by commit
> 
>   8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")

Thanks for this report. So, Sphinx errors are not fun to debug. I took a lot of
fiddling to figure out that Sphinx really had the problem several lines down,
but was considering everything after the "What:" line as a single block staring
at line 38.

By trial and error this change made it happy:

-- 8< --
From edc1243437e75ea019ba264d38b2cd793ae83ed0 Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 14 Mar 2024 17:34:26 -0700
Subject: [PATCH] Documentation/ABI/testing/debugfs-cxl: Fix "Unexpected
 indentation"

Stephen reported that an htmldocs build hit:

   Documentation/ABI/testing/debugfs-cxl:38: ERROR: Unexpected indentation.

It turns out that line was fine but the tool was unhappy about some line
breaks in the table of values to error types.

It turns out that:

   make V=1 SPHINXDIRS="admin-guide" htmldocs

..can not be used to get more info about what is behind a documentation
build error. It was only pure luck that reflowing the text resulted in
an error message that seemed a imply a problem later on with line breaks
around the table.

Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
Cc: Jonathan Corbet <corbet@lwn.net>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: http://lore.kernel.org/r/20240314141313.7ba04aff@canb.auug.org.au
Cc: Ben Cheatham <Benjamin.Cheatham@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/debugfs-cxl | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
index 4c0f62f881ca..c61f9b813973 100644
--- a/Documentation/ABI/testing/debugfs-cxl
+++ b/Documentation/ABI/testing/debugfs-cxl
@@ -40,8 +40,12 @@ KernelVersion:	v6.9
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RO) Prints the CXL protocol error types made available by
-		the platform in the format "0x<error number>	<error type>".
+		the platform in the format:
+
+			0x<error number> <error type>
+
 		The possible error types are (as of ACPI v6.5):
+
 			0x1000	CXL.cache Protocol Correctable
 			0x2000	CXL.cache Protocol Uncorrectable non-fatal
 			0x4000	CXL.cache Protocol Uncorrectable fatal
-- 
2.44.0

