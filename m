Return-Path: <linux-kernel+bounces-103985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8C987C774
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4D31C20D37
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D9F7475;
	Fri, 15 Mar 2024 02:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C0SGwNRq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460E16FB8;
	Fri, 15 Mar 2024 02:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710469480; cv=fail; b=EbhIbne3cbXdIQlfzXBav+dq61NfLSaC5iaIKfNAcg+xrbMG013hK1sXRWWpBNiCai5213iHvRbYaAGBEgXwzbHf9qw2KVnyM6zMWLHiKw620FH9uqd73VPo0WuHP93AwaO2tXHnE0KZfvMcSWHb+qKo4vZ2phyiMLKbYWP6tT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710469480; c=relaxed/simple;
	bh=ckJpDsZkgxwCWgMZ1a4Q8nTjkaO0bCX1EwnxB1TIVLI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oK81tIvHxc0Hm+0l/+oGiX7sFWvO6g1/rAcd1Up6xIOt32/GWIzlTnV4kQnFoasnKa3PrL6jbmKEAjzCvP/fRFHHOStl/ostjW/IBAhAQn0HZKOxvTatRbYUzCJhuUJ34WxxhajiowHDf2kx0jsMfzigh83LnpaJChPMzrBnywg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C0SGwNRq; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710469478; x=1742005478;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ckJpDsZkgxwCWgMZ1a4Q8nTjkaO0bCX1EwnxB1TIVLI=;
  b=C0SGwNRqXxCD3ao6p4nRWGm9vpu/Dy1sJuCVKbcSjlURQRLz8mLV6Lv8
   hpc9VhfNeDl4V5yrr+dFSvhZjhdQ91nNr9JN4ivHeGpiEpOoZNBXtoILm
   w4aPUy37Npulfl13bz5HTkVqvGYtK0eHTx/lukeZH2ihHAjQmqHYAPjCO
   yOPdoVxA9x2ZCUJWwvKXPvNCcnd2o0o/j1Q3JpPMER0HG03YclkMkeCDV
   XA/O6njbostrpNmnx8U76+5NLgYfAzeLVh6fjAcdBL85vcjvh4CCqq6PZ
   mXuGPp6zKO1w30UV1d/zkkn4RoCu58YT4ow8fufTjYaJydttybmnK9eS6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="16723336"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="16723336"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 19:24:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="43408558"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 19:24:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 19:24:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 19:24:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 19:24:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 19:24:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3kUN6q30OUXpvKGNkmYs0Po4vNozp7npfposK/Cjry8I9lHOYx4KrCq5eD8XfUMwDSnBY4lmXUvGc34Jicq1a6sMQqhKzJudOvygrofCASQjQDaxm7kX7ktakjCVFA+HKQfz/eumFaxcHjSpbEaF5wmosKHBD7zCgu8nrE55LHiZrQxa9cmVIsBap9UYjOt3rpbee77GK1AqNPIjyWNfF1SMD4ZZ6mwEx27+dtCRFPaB8M9OC09JkL/4ulB/1bEbE28Qh5PtjoXiBcBTQrvl+VhHUdUOd8g1FqvHBe225WxZQikjBTKedb4MagembOhi+8zlYZLTGrXjUEnog5iUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CGEBevFo6WPSAdvVNHy9VE9e7Lzd30U+XKxFYUUMsU=;
 b=IHhhgu87FuviqSJl2GupDAXoLTAEE32l9hlz5kehQrIQNRqPAAFl4Y6TVHkOXNFdZAcZAklR10SYUogrfY2wwe2T1vy0W7rNHOCv6NtQM8zR3ZrzGUt6WzptgB06e08r7tEnUof3S2ygyeQF274guMPQGI2oNLf2mpznOq0Cl/xju1QP0eZby6LPQ4ZvYvy59t7RSWejwcml2O41fnMPYJP8wFFiB1bDdM04QwknN40//qJ0rzUlDBX07+DNvP8ihkN0a4nU53TogxCEbmeyaIL4mS2BUlSQMhgMqjn9/ysWfn91mgywKj3vrn8sAAbYz6gdqoBzMpq9BtjBmufTYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB5961.namprd11.prod.outlook.com (2603:10b6:208:381::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Fri, 15 Mar
 2024 02:24:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7386.015; Fri, 15 Mar 2024
 02:24:27 +0000
Date: Thu, 14 Mar 2024 19:24:24 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Li Ming <ming4.li@intel.com>, <dan.j.williams@intel.com>,
	<rrichter@amd.com>, <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Li Ming
	<ming4.li@intel.com>
Subject: Re: [RFC PATCH 5/6] cxl: Use __free() for cxl_pci/mem_find_port() to
 drop put_device()
Message-ID: <65f3b158b9674_aa222947@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240313083602.239201-1-ming4.li@intel.com>
 <20240313083602.239201-6-ming4.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240313083602.239201-6-ming4.li@intel.com>
X-ClientProxiedBy: MW4PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:303:6b::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bfa34dc-887b-4967-ef59-08dc4497095e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RV9v7SROYjKe0fQTMOJh7ViGgSS5zbBK9BG4RM5NttBvAjg9RmDe1tQzTQCxsihTBUfEwZmPJkSVI2VrIBudlxhPry1q3fFcB56gHZTJQLwrpHqEalO9eUjJ3dZ+rVxG11F5CCpXxvSMp4rRvUYg2B2gDhG23SvfIQHggllvLDWHJ788oG/Ii3D0O7A6QC7jmRUP+A0OIAmf0h25YFOsstlCFucrwjW++1tRF6juPajsy5Rsd+dlPXjiBkQ5WMHIjXbLjbZe30KmAzxSJInekutr/wPKBQgfa0+X1RhgY1bW+/ydRlEjiaPNJV3dJQBoT9DGOW1WmyxRc0nsH2fYuu5QnyBbuhGYZBBjOYBR4xKVy1Up372B6TX8KpYbpiHmC/89ucrOL523bWdaZVW0jmIoeOsE5/M9TBClIHQ4+GWxAlkxcptqmrAqh0JPAQYEuGWH52WuKPeqybMNrzmSP102nRb1CQ8piCGUEm1GVOFKXRSYd8+JvlHDuUEaILXoBcG1at1L2PDeWPUjlnlxGbTKXu7EzxDPgLKjF9bXqJQO9dCFhJ/bCEEPfiT5KIju6sDgLLyxTI20bL1ZwtAbOOuxa/zqi6bCrt3N54yLEr306zQi2L87A54VFdEnEI/cYEWSuG26SOAITNsVaWF3kRAdOEle/4rSGiWp1ZEVXcE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vKO3FZEJNVCj4qM1Cnt32ieV/rIdK4cFEYdJw4QJd6T0c1anozWDtokIjUkr?=
 =?us-ascii?Q?8n/lYYUfxVeIBHFN4U4MA5I40oaEX7YiGdyiXxaI/cZ7NrrAxIAJDQvY4JzN?=
 =?us-ascii?Q?yx6ZpIirMXZX+OdAvjg9aHJ7J+Yqtwm+XOP7Xb9va81nVSfkTle4TDGmymni?=
 =?us-ascii?Q?qT3vXFudOzSd2WWjG6YbqekS1lfWyuqycWkU9TRyyhmQ/5IEcdCnRPpHXjSY?=
 =?us-ascii?Q?qN5O1dkQWC4fScUnzRYQeMLMFr32qYldItmOe9kusAvZeYwXni9TlKhCnpVG?=
 =?us-ascii?Q?7bzwV4hGEqhqIuuNtHSMZP425BNPyKT4Zs9Y0emnrPDySHr4t0F+pLHZF/21?=
 =?us-ascii?Q?8K8UlOag8/3tTbjAhXdYoEeCwUrdoMMnyP7yodQm+j8CLE2e2YbvtDmeFeS7?=
 =?us-ascii?Q?MqQy4cDSMUVBGY+YE8xZy8DZoa7jvSE73TF28oJoRknjZzG/U6ITAWTb5Rey?=
 =?us-ascii?Q?pM+94M6ac0u6RXaiDweg7zQTSLMZSwYOLogjLTG581iNIP9St5sizRr7lUCj?=
 =?us-ascii?Q?Wbg7sdh/g1Kw2RnObYyLqdazErF/gCTrKyQ445hd/9LdS1GTpaU1t7wMPKF9?=
 =?us-ascii?Q?Lyvk7ZXRcQQv/3F+NUiVQlTGkE8ne9aNuIvRHaL2czo5CnVBc8cUKan4+d4Z?=
 =?us-ascii?Q?L2vDHW8GCvFjPkySWK8iAh08acsDwlJY2CcguIbOY6MtZ9NLmTDlx17j3DWe?=
 =?us-ascii?Q?8cmEEQdet3bBDc268hCci3rdaW9X3IkkTHCgiTYmV9k+rQlBQhOcKZl7vcFd?=
 =?us-ascii?Q?71bXgccTMAHMP/X8GOxJl+RBoJxPUfC3rt32z6JPGQZFDHPJC/q6vrYq0VSE?=
 =?us-ascii?Q?xHsUjfOg297Qmf70XzYgwBGNOq06SfqxtRS9ALVmpIY2kwKQdYsLwl86w+qK?=
 =?us-ascii?Q?Yibd+qrxnP6d0zDydoPpFq52hW31UQvi+cnAYpcm3sDoOgRYQuinDpr8WyGk?=
 =?us-ascii?Q?srpS76Ybe7/2qJC/NcF4n7rJstGQnnXCiITZQjGE2jdPD7NXGmcS68SphFJ8?=
 =?us-ascii?Q?pK2+Tt/IO2mrn8IkQelCoRICb9PIoZjaMit5Oqk4U/6chC6gkWqmyf5ejZSp?=
 =?us-ascii?Q?SnG2f5U+4B8EJHewi85UBe0b4TKYiktALaxf7Upmw0rZaiKnnN2TzbPtmyjl?=
 =?us-ascii?Q?0M5vj08PhIFBSxGXIXQa4GVIdiuaf2veJ8laeywt3uE1Mqls56no48d9ofVE?=
 =?us-ascii?Q?oltrBrvFCe3TCJD1wYSJ6ylypX1TAJf7fuvDynwgwLJyRssybEhuMpSeK+DD?=
 =?us-ascii?Q?HfwPycHvfrEmA/9+ncnkIgIOwQnBlg+RQ+8Jd7n6XqFg68PFc03utXYhnD55?=
 =?us-ascii?Q?ctYZ67IAT6tsNUuiDO/8xVZJMAd6kgBdPRlLCkt4pb37uL54G36gOSYOY18i?=
 =?us-ascii?Q?OReM7DzBG5GllAX15ieayBglbVVDIyBElboWanPxLoacd/jCWJR1PBu5qWYA?=
 =?us-ascii?Q?i6qrBC2gRfipXCIDjB8oRzITA5mZZJekDgPZaYvDJhf1Ln33yDbD/DFWM/VE?=
 =?us-ascii?Q?e8V5H3MrB/c7o8+MnZROdntM8kmMj514Up+JJgTpyDGEr0XlMwNF0xU7zSu4?=
 =?us-ascii?Q?01RZuh/zKy6ZRadHUIloFu89ycOATl5vlYWO4epBWvvnVezqiDX8jUDNK+uR?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfa34dc-887b-4967-ef59-08dc4497095e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 02:24:27.0331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qixCBEc6pJSmBze55yuZSiiIuqaZmTFufh2MwUnpmsEL5Yg25Rjw2BvHnc7vbbJQrMC1pj8GuGtpMWL/2eqnWwPUR4ENedOaivjRfJcZk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5961
X-OriginatorOrg: intel.com

Li Ming wrote:
> Introduce a new helper function called put_cxl_port() to instead of the
> put_device() in order to release the device reference of struct cxl_port
> got via get_device() in cxl_pci/mem_find_port().
> 
> Besides, use scope-based resource management __free() to drop the open
> coded put_device() for each cxl_pci/mem_find_port().
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Li Ming <ming4.li@intel.com>
> ---
>  drivers/cxl/core/pci.c  |  6 ++----
>  drivers/cxl/core/port.c |  9 +++++++++
>  drivers/cxl/cxl.h       |  2 ++
>  drivers/cxl/mem.c       |  5 ++---
>  drivers/cxl/pci.c       | 12 +++++-------
>  5 files changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 6c9c8d92f8f7..7254484330d2 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -902,15 +902,13 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>  	struct aer_capability_regs aer_regs;
>  	struct cxl_dport *dport;
> -	struct cxl_port *port;
>  	int severity;
> +	struct cxl_port *port __free(put_cxl_port) =
> +		cxl_pci_find_port(pdev, &dport);
>  
> -	port = cxl_pci_find_port(pdev, &dport);
>  	if (!port)

Keep the declaration separated from the rest of the variable
declarations like this:

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 0df09bd79408..2d1ef35fe99c 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -916,12 +916,11 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
        struct cxl_port *port;
        int severity;
 
-       port = cxl_pci_find_port(pdev, &dport);
+       struct cxl_port *port __free(put_cxl_port) =
+               cxl_pci_find_port(pdev, &dport);
        if (!port)
                return;
 
-       put_device(&port->dev);
-
        if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
                return;
 
>  		return;
>  
> -	put_device(&port->dev);
> -
>  	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>  		return;
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e59d9d37aa65..6e2fc2fce7c9 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1671,6 +1671,15 @@ struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, CXL);
>  
> +void put_cxl_port(struct cxl_port *port)
> +{
> +	if (!port)
> +		return;
> +
> +	put_device(&port->dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(put_cxl_port, CXL);
> +
>  static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
>  				    struct cxl_port *port, int *target_map)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b6017c0c57b4..476158782e3e 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -743,6 +743,8 @@ struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
>  				   struct cxl_dport **dport);
>  struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
>  				   struct cxl_dport **dport);
> +void put_cxl_port(struct cxl_port *port);
> +DEFINE_FREE(put_cxl_port, struct cxl_port *, if (_T) put_cxl_port(_T))
>  bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
>  
>  struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index c5c9d8e0d88d..5aaa8ee2a46d 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -109,7 +109,6 @@ static int cxl_mem_probe(struct device *dev)
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct device *endpoint_parent;
> -	struct cxl_port *parent_port;
>  	struct cxl_dport *dport;
>  	struct dentry *dentry;
>  	int rc;
> @@ -146,7 +145,8 @@ static int cxl_mem_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> -	parent_port = cxl_mem_find_port(cxlmd, &dport);
> +	struct cxl_port *parent_port __free(put_cxl_port) =
> +		cxl_mem_find_port(cxlmd, &dport);
>  	if (!parent_port) {
>  		dev_err(dev, "CXL port topology not found\n");
>  		return -ENXIO;
> @@ -170,7 +170,6 @@ static int cxl_mem_probe(struct device *dev)
>  	rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
>  unlock:
>  	device_unlock(endpoint_parent);
> -	put_device(&parent_port->dev);
>  	if (rc)
>  		return rc;

When converting a function to use cleanup helpers, it should try to
remove all gotos, something like:

@@ -159,21 +159,18 @@ static int cxl_mem_probe(struct device *dev)
 
        cxl_setup_parent_dport(dev, dport);
 
-       device_lock(endpoint_parent);
-       if (!endpoint_parent->driver) {
-               dev_err(dev, "CXL port topology %s not enabled\n",
-                       dev_name(endpoint_parent));
-               rc = -ENXIO;
-               goto unlock;
+       scoped_guard(device, endpoint_parent) {
+               if (!endpoint_parent->driver) {
+                       dev_err(dev, "CXL port topology %s not enabled\n",
+                               dev_name(endpoint_parent));
+                       return -ENXIO;
+               }
+
+               rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
+               if (rc)
+                       return rc;
        }
 
-       rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
-unlock:
-       device_unlock(endpoint_parent);
-       put_device(&parent_port->dev);
-       if (rc)
-               return rc;
-
        if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
                rc = devm_cxl_add_nvdimm(cxlmd);
                if (rc == -ENODEV)


>  
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 4fd1f207c84e..d0ec8c5b1e99 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -473,23 +473,21 @@ static bool is_cxl_restricted(struct pci_dev *pdev)
>  static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>  				  struct cxl_register_map *map)
>  {
> -	struct cxl_port *port;
>  	struct cxl_dport *dport;
>  	resource_size_t component_reg_phys;
> +	struct cxl_port *port __free(put_cxl_port) =
> +		cxl_pci_find_port(pdev, &dport);
> +
> +	if (!port)
> +		return -EPROBE_DEFER;
>  
>  	*map = (struct cxl_register_map) {
>  		.host = &pdev->dev,
>  		.resource = CXL_RESOURCE_NONE,
>  	};
>  
> -	port = cxl_pci_find_port(pdev, &dport);
> -	if (!port)
> -		return -EPROBE_DEFER;
> -

Here again don't move the cxl_pci_find_port() earlier in the function,
keep it after the assignment of @map.

