Return-Path: <linux-kernel+bounces-69112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A7C8584C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E042846AC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A600134CCE;
	Fri, 16 Feb 2024 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1/VMbVE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8DF134758;
	Fri, 16 Feb 2024 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106590; cv=fail; b=ltIfa7GxNwFC0CP1nv/A2ylKFIuJ9e5OokAB33IfH8ys6KI6iPjcRyPQeFogdKr2I9ZGadpAF7Sl4cBQjeSRfIa5q2ZdqjmEB5Sz2KDiz/nfRXu1ba+079gAIhu6dUNIoFMhyR15CORY5v9qwOyFx6j6M2VdazDGsFSVFEnYVSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106590; c=relaxed/simple;
	bh=KcMi2+DbNUggq2nuXIgFmbulGOWMs1DwiBqPaKUvaxw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TyzpUTs3jzIYUPZF+2461ECT1Y5yDiD2A5y9/A1r8v6WvlXMdgtkJxdQYM2rmjwGlJu/qKAGWI3d+rZzymU3+2KUc+Epvt567bqpGOx6dn9cB0ZHnXadPDOShPiOBuCdDLYzO1KKt9HC6WWF+RqmJL9WV7Q8C6dvJv5hOSAU774=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1/VMbVE; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708106588; x=1739642588;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KcMi2+DbNUggq2nuXIgFmbulGOWMs1DwiBqPaKUvaxw=;
  b=k1/VMbVEQwIYRjwAEtKW6OaLyN3dvqgt2/FKPgc06zO4Aeb0bWhAIsuo
   A4BykO53+5kornG5FVTU5uVDkjJML9S15t0WTw6DHAt1mbJTwc4sGyIP0
   BVSIXX5vryMEXHyI8oDl6X9Zp9POi2EsRj7ohDn2uJca+8+X+ZYbpuhvs
   DMpGtShnFljqkjy5eXAjUsur84ItSJi71xAhrYi/ZnlbEfoiVX3TllrK7
   m9LpsfDOSdNOrMnVIJRfO3+BwG2YzAGSfHXlrd49EC0muTh8dDuonipBy
   QMOnN9ZlIJni6JjgUvSVohPZNFQWJIopQ6/fevYhGr2iS4i4SfBp+1ayr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2396088"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2396088"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 10:03:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="8531501"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 10:03:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 10:03:04 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 10:03:04 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 10:03:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPkqEN27MOXP2nfyKA2I1k74r1w0U/nLUxKwCdNjNRR1EGSQseZpQtDDNkJF84KSsELwZkIaPtCgjL5Og4sQYsyNOXICPs4D0oG0bZQPRQZ9O4h+dE+woTNptAPngu3blXn5p9OA/QWqhifDT+WnY/R82Oyzd20QmqD/76Ompf5ymXq0qnTunGIzBz5sPcWywBkwxVtOoue+j1vskSfLYcRUADIRsQbPwLyIehu0eZs1nVwoEGI+vln0gOuL+4BzElPahLfeMv0oU/d+GwSCOvWAag+cAP1lvI4jfXtJbEP5M7YJJVpKIxtbnzN14KL1ffXXKBFv05uHQBGqpPR9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPLClx77s5yZBHsCx+gi0xpC1myMimMhYgKcWIMeVZk=;
 b=fJgG/jxOlDRKdDLjdtWElHJ/8a271mfmZCrfrk6FegHspNoWf783wSLZqMCN0yhX4got8WNSeHokmZ0drg5yEYNO006WW162jz/gUAjWgfaGtiqEIbzNF+6p2NsQ2Gp/WlYDyuxTJaL0EiG5pARp3lpvHb8/cEas7i6vzgAtGCKXlbugH6B0imSn3L7uLUitu/6zGlw3GF9XGGVVhrF9Qj50ShknllGkqoRtfJvJo+F0nPuLa7VBEPzBIMNG7U7d+LiBeXrK+1d9Vdbz2rlEOyH98/qUdNmCPNwFu4smIKG6DpxMtv9eG5MVNaFmoAmzFVpg8vghLQQKobiGjH33/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5647.namprd11.prod.outlook.com (2603:10b6:a03:3af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 18:02:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 18:02:54 +0000
Date: Fri, 16 Feb 2024 10:02:51 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>
CC: Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/pci: Fix disabling memory if DVSEC CXL Range does
 not match a CFMWS window
Message-ID: <65cfa34b741ea_5c762946@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240216160113.407141-1-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240216160113.407141-1-rrichter@amd.com>
X-ClientProxiedBy: MW4PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:303:b4::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: b4690caa-b14c-4159-28f0-08dc2f197f7e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aEZGoWf0dDvhTujjzUPpwugmX84GIZLMIBGAbhZBz29TPyqsXpvj0sRPZTJxe9wYJ+8s220NiZ+g5z1nJR+bm33HchKUiJJvsAfPRdX+3FQpEoQVnCbmVFgWzrA6m3Uloawuap95ao7odlsTW/iwvQZ20r32wRxLhUzzNzS3UH0wDrPFCShwp+HVqn5HKBy0Yf3LKBmWgCHEOQBMiJDgk/yEU8s69j0WwtgbLLnJ8KWafWC992FmYDDn6YAjSOK6DD1Rp9KRFn78NfBYhpsUQ7OymoY7PCQGKiHI1CwI5dU36pHPgN3CyP0bfD1ZNbQu4feVq9qYDPVBcjI5b04cuq0p1e3Ar4+8A/8IkZjJQ3RwkU+nXQq/oq2ZnMxs2lw3ZX1FKEawXk9m7nyrrcHcLk6oiROk3v90k8Bni8+f7lWf45Wt67+cG4gkN4GjKBEzRLKki/QpWEhX/we6AQsUtNwPiObesq+FhoLthqvKpwSmFItrvGEq1Rn2TcPRDuARNyIR2noneLJ/06f75nO5Fo4hWCiK8HHp6zLo6K1YQUZYOXabKwV6VXcBslmXtXvJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(66476007)(86362001)(82960400001)(66556008)(66946007)(83380400001)(316002)(2906002)(8676002)(26005)(8936002)(4326008)(41300700001)(478600001)(110136005)(6666004)(5660300002)(6506007)(9686003)(6512007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SVR9tCwt9Bo53VeWciH1EIr80WRsLxdHZBE2lvnTLrjKmea0c3E4qJ8x6+Ha?=
 =?us-ascii?Q?Dsv35Ndj+ArkHMB0aBGFI0X3djU+pQKzh4SqYGowrmaSAbU67bhXU8BIFcBb?=
 =?us-ascii?Q?lGhl0s7e+JcDjwnBdtrsEpaoAhh2B5iZWDKCpSqRW1eJyBMN8nxgMpcwD8VB?=
 =?us-ascii?Q?q+NMjwlyKz3y6gXM8DgoFENq+hkQhYUKONR0PlT+2mBXU+TSpBq1gmaLMmMz?=
 =?us-ascii?Q?vtGIUsLHKHbHcG/gd+IedQlz5uLv8XNjd4quxfB5i7Hv5h05EwtN/GhhooiP?=
 =?us-ascii?Q?V893Fz43ya4n7/ukP+TUj+Fy5F2XdQvjOWsO6+lReueb4xAoIgCAxlmqvqb0?=
 =?us-ascii?Q?h/SP5m8EcynPi25e1T/HY2aTIp4zYlGaTY3+V9uVZUH13zOKXCLiH+5U2ZAO?=
 =?us-ascii?Q?oJDg19SGtfBf9YptymFjB2r30oQMGRMiVYkCCXdfNJW+G+Scc5ADF23Axka6?=
 =?us-ascii?Q?POlbgtRv18VfOegF5v40O6p+O7e+tNV/FNQTBA1IjTnW8CJoA895fo68ics/?=
 =?us-ascii?Q?vKUvZc0/eDne6Chlrn27f3BoxEEa2EUMgNkrqpSSJUHCcYVLziBzXGikGPYq?=
 =?us-ascii?Q?cPjSepVGaT0opg9k461SFLzm40jTfjRUhbCSKxuTkrL9fhdqCXbVsOH5Es2t?=
 =?us-ascii?Q?gJun6pQ2Bo3AZEEF73sJN75eTQl3dnWjaZSC3KXAGFvBJTW/1aoEuRJYkehF?=
 =?us-ascii?Q?anRpTSZ7+Kz2m8Kj13BnWwcNfKQqoz9ne4Kh98uzATLmxWy1p+JsEB9wLnNl?=
 =?us-ascii?Q?nuE9ikkgOGye/i27HxOMTEXDZm1Gag1D6lqeiWFfvA8qSsiGMkQR8zJp+d5C?=
 =?us-ascii?Q?8d7wGe/hfOIzVxyF47BQafNwBlFOS8jYXkolruC/3uiCnjW3uOYwMEDzXPkx?=
 =?us-ascii?Q?LvT3zmku1W9b4DDW3Jq6piyxW5/8fCXyxGrSktOQVl/Vu5mE0+xcFKY5ic0V?=
 =?us-ascii?Q?J1ACfFjxPcUJnQKSRIFfnFa3mRj3Hckyj2e5Rk9sU9lNd+Pa3+7ubRUI53iz?=
 =?us-ascii?Q?0j05MYZjYc/PNiOhqe0XC9H/3m7HouCsX1vt/En3VDfUFS4aec15KquUrvGt?=
 =?us-ascii?Q?fG3NGZEjR5VRyI2edZfXdnb9fBenuGSac67ZuLoGzPvtcSRzdVQPChrl5PxM?=
 =?us-ascii?Q?9iZhWAZYrYrfTmXT5kBeRHDDw2W6mozoaHpQ+Oddtq+IDYUmoKZYJjaHmW8n?=
 =?us-ascii?Q?dhbECSbF7vVOOE0jNqiB1/EnxPV5fNl17m423whfaZpgtt1fIRvKcs9f4jAN?=
 =?us-ascii?Q?em8R1b9K1Vx0fjIbp0C3hDrZRtxal/TlzBvfIQpi1QrLraR8KcI7G9PdF98g?=
 =?us-ascii?Q?aXwGwGefJqkkp13AYD3JGg1KZNvsP8HezS9kbvE2xLp9aWo+we4NI+X1g10f?=
 =?us-ascii?Q?lJc4URZHJNMvWSZnpwF0WqbHMpWLa3+3HORQf3Z+0czCG/NFPGjEWzWZ8H57?=
 =?us-ascii?Q?ARu9R4nhA71boi7f8Ijpd/aP+7cIo1eaK+OWD/Sh2Y/k8B2ivLMy5KRUkhmD?=
 =?us-ascii?Q?gIzW5lxDvQtIJrS88Hu2DVTGwTnYljQLykWwB2G67B0cxeeLPsZOupGPbA2g?=
 =?us-ascii?Q?tlkrTpEiPgBDkiOQsOFVbgiWhLU36q7cPTjvkxllj3UPEx64jv5PJMaFP9Ev?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4690caa-b14c-4159-28f0-08dc2f197f7e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 18:02:54.1473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8GdcUJvhAbcSNArxR9m933Ke36RF4yx6DV/e20YWCBpn5lzwuD42tghQbR+46pdZe5oGFPXt1peX9YZvfcucCXkKv8ixlzD3hZ6QFWQc9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5647
X-OriginatorOrg: intel.com

Robert Richter wrote:
> The Linux CXL subsystem is built on the assumption that HPA == SPA.
> That is, the host physical address (HPA) the HDM decoder registers are
> programmed with are system physical addresses (SPA).
> 
> During HDM decoder setup, the DVSEC CXL range registers (cxl-3.1,
> 8.1.3.8) are checked if the memory is enabled and the CXL range is in
> a HPA window that is described in a CFMWS structure of the CXL host
> bridge (cxl-3.1, 9.18.1.3).
> 
> Now, if the HPA is not an SPA, the CXL range does not match a CFMWS
> window and the CXL memory range will be disabled then. The HDM decoder
> stops working which causes system memory being disabled and further a
> system hang during HDM decoder initialization, typically when a CXL
> enabled kernel boots.
> 
> Prevent a system hang and do not disable the HDM decoder if the
> decoder's CXL range is not found in a CFMWS window.
> 
> Note the change only fixes a hardware hang, but does not implement
> HPA/SPA translation. Support for this can be added in a follow on
> patch series.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a0e7ed5ae25f..18616ca873e5 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -478,8 +478,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  	}
>  
>  	if (!allowed) {
> -		cxl_set_mem_enable(cxlds, 0);
> -		info->mem_enabled = 0;
> +		dev_err(dev, "Range register decodes outside platform defined CXL ranges.\n");
> +		return -ENXIO;
>  	}

This looks good to me.

