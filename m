Return-Path: <linux-kernel+bounces-6099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 390F281949D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6CC1C24B1C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE003DB8C;
	Tue, 19 Dec 2023 23:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MljGedt2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1712D3D0D0;
	Tue, 19 Dec 2023 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703028746; x=1734564746;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AOr9IQ2924wZKheffmQj7z7QJxPXtqwP0FU7YFDu5vk=;
  b=MljGedt2uO0/sFTT3q6iP1MOdZSJCtr6Zje2FOTmHwoXeJnuR9YnhDCf
   Dn12QVDuuJrhsWJuUwLph9HFjwh3ssz8LNE8MP4gv3MM5L3kjKA8+BFoQ
   2Sqqw5xkgLFMlJZGlgtMR7N4YuHkdTLXvEfKbfXfb0N8Mwi4PiNeaM9gE
   rXW5orWzcdHS9TfDT4zJXGDTi83GPBXqpY6ilF1msdkl2eHEX6lljXLF7
   eKlXG0bYrHich5gLuOgzxXsY68q/BlISMPti3ZYybBzTQzixrddfLVj7Q
   3hv7wzs0vS85cEUDgywiRUhZziN5fod+pwDX/OQihcw/1O8I9LYgudHnL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="375886430"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="375886430"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 15:32:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="769392610"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="769392610"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 15:32:24 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 15:32:24 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 15:32:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 15:32:24 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 15:32:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpc01XX7eIyCcCULdIpib/iZtQJZIca5in7FUAwEGiEV0yamOoPw86eJj6RyrMcYXat6ZBq+qkH78Go5/AkTKKnDWYdMVPVw1UT98r2fQlSIHgXsE9dE02x+M6eIYbZpfL50uIATaBd8OAvxRjutwjxJXbvlhhTy0FYmEZyvs0QoQl86r+wpkk5+IhN1bvkKIJTn9xRgh3Oq/ntjE54rX4DhgJaM2+H/1JhBdNUoqjsHGCnvZ8pI8EOvkMQcHZd4VyjM2V/goNc7o2gR4BPfswOvziqp0tCbDiEEDLEzBgi51HQ50zKWtW3lK9jQyxR9txMa1I0aI96JL9mpbl7nkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTkdHLUZogmfIBPqiJmPReEb7I6H6WTWt46/UO6CEXc=;
 b=dwbcc9y5HqRCPIo6fI+YwqV4Mw6OIOAyvufDBO/UF7qhgYns5dsfaiqQDjQEHxUBLw3vDVVJs8Lxea/oIhuJfdKuewY3xBlvNVcNu3IW3hU/5RWNy+Nu3QLYP+RcU4SkYbwNsFdHPlnJ2SDMEMygRf2eWTsyHHFPQtBlcYBBhvQTcQtl5z632QhXf7ynGAV/Q7DKxlfYD+79mAS26fU9Dqg3amPJir+ZaOtHPfDq13ARUyK3OEdzet+be11oTWmocBwYfR7YkXJKvHuHZMCsqvvPOpSSA11tJz7XrvTmtj+xw3W3HWj0ropBxZlgK/IOsA3l9X2zXZl75QtrwwbQQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ2PR11MB8372.namprd11.prod.outlook.com (2603:10b6:a03:539::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 23:32:22 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7113.016; Tue, 19 Dec 2023
 23:32:22 +0000
Date: Tue, 19 Dec 2023 15:32:18 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Fan Ni <nifan.cxl@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huai-Cheng Kuo
	<hchkuo@avery-design.com.tw>
Subject: Re: [PATCH v2 2/2] cxl/cdat: Fix header sum value in CDAT checksum
Message-ID: <658228023732d_277bd294ae@iweiny-mobl.notmuch>
References: <20231117-fix-cdat-cs-v2-0-715399976d4d@intel.com>
 <20231117-fix-cdat-cs-v2-2-715399976d4d@intel.com>
 <20231218132837.00001424@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231218132837.00001424@Huawei.com>
X-ClientProxiedBy: BYAPR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ2PR11MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: da0cfc56-c656-43fd-0d40-08dc00eabfda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g1sSEd3Ts27Kt9QV/w+DJHiSLQft+RDBsQQds5NCB6PYswo/8/p7CwjGu8+VS4U8IbbAbJP1EbtJXAxkJGu0cr5tbzxAA1gXwo+/4x6FPlPY7csgvXo2GJEVh2jNHwiAR4PpNlYxaq8GE0rinBoTcDhliUEmm4A1raIeO3ahlQPg7ghCW0ZSJ8oWjcPZ+iJnkPdmVBvHIRbOxaAqaEn4+iPr2ccEvAhl4ccAeeuoSFxTyjoOWP3gFn7uGWBIYfDLc4RCM4CqqmsSJHpqzk9fE4dry+ArpXSRFUxQoa0xheRITMpkVF3KSdYqG+ebXss1DBjL1XJ2yTwcvUcPoylu24oBS6Zv1zLwNbEGNqSC3wvBlRb8c9t2tr+Y4lTGOcAFihY1f19lHW0clmlk4ThnQb39mNrgSedOj/ClttXVaMwJwRkavW19MmV/Oa+8UMVyCLTr3eKHmseE4OSyCYMMkL5G+bBalwVyuT6JobOJF19G5Hhanr7SIqM7Pz+1IPX53O6glF6zKatlnZqPmuI8ka8gX+g259U5c0yod9YWnek3grnGJC0g9oHj5FtyfgrpJumr8QKp4OZSbFkG5p2g+OePAzab+0LFdA0jN9OmEHv/MOFIjN8AVKg/0iWJS/gR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(4326008)(8936002)(8676002)(2906002)(5660300002)(6666004)(6506007)(478600001)(6512007)(44832011)(66476007)(54906003)(316002)(966005)(110136005)(66556008)(66946007)(6486002)(41300700001)(38100700002)(86362001)(9686003)(82960400001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2IFGkqTQVgheX0A1oHNOBZ3gNPyqd6wy4549e4fmnEE7sip48l/hodD7Rec/?=
 =?us-ascii?Q?TkKybRx45NHEQd1W8Hv4G1Uv6XnFZabp5dQ0dd3nbtNgfir2qHUnCrvU5asc?=
 =?us-ascii?Q?jSDCGaqg+UcRxFDRgFA5clC66OcX501xRJjHucXZa0QW0BUk+1T6V5WYiwsG?=
 =?us-ascii?Q?gY67EFItp1KQz0ppWgYyfakczK9GI0ypNHVlIsI/Cmgaf9yF0oAD/zxfEfdy?=
 =?us-ascii?Q?ijADt9VEY9O6qspPxHOcIJyYfbTrUfb615FPXWlyZ9MIjWXAdj6D/62LNTFd?=
 =?us-ascii?Q?m6auUKrwnCSNW0AQr/R7SSB3/J3zSt/DC0CTfoJ2IB7UyGOdjPAebGmZ//0H?=
 =?us-ascii?Q?+3+liThVsTXqsWOPzJtsc7yqxuDDd3n1bCeOuJ62NYhhS4+Sv6y3qN5SVK4d?=
 =?us-ascii?Q?TSAWrizMr47PRZfZMfeGPpioCsR0taR1YIPWUIWWwBaRTqKzwETT71/S8ip1?=
 =?us-ascii?Q?0UlZro84muT7YC0bDeeL87bMacKtF0kqDQcct4ueZOX4/pkkOeuiqt8Wk0ZT?=
 =?us-ascii?Q?/0akLWsxEVQuBacq5jZAalZVgCvz+q8sSR4JuZqCCnqwB5Ix9BExWoq1W6hZ?=
 =?us-ascii?Q?e1qeFVHHIJrVClJ8oNlc5guFa+xXsFIg6KZs03/ZZCGlrxuMkTWvl1gGiIZi?=
 =?us-ascii?Q?/ClXwkGDZ3FFgSxl/axbqCSQbj1goun+62cR6gXpbBUFe4lxuHqciRvW/yB3?=
 =?us-ascii?Q?5LYASRVagaUiFWbksQPuYR/woeFzONf3VCig0TG29WXs1NZ2rCYmG0r0atiQ?=
 =?us-ascii?Q?BDM3mcp7EtutZbQM3E/a7mTebXNo6jcRMYS9t6YXqMm9jLd8A32MhI5BNAbO?=
 =?us-ascii?Q?TyJcMtrsa9miQ5F/eh7wWyBNPeks4Vb4ja/nZzSBysUdMwJKFGezSzWFg0pe?=
 =?us-ascii?Q?vv+4IvVomC0fbLKiY5LLrHS0qVZ/PTovgrUDiWht66gFEaBWzFsTkOQ3HYOL?=
 =?us-ascii?Q?QWThBFv17EWwWYIaXatQV9VOgAwzsXzTbwXF2n5G7hxUpsC3BkWjzas56rnH?=
 =?us-ascii?Q?gNB1aYAPNavExOWM+b40lsKjjpZjwiB4RY3x40Ysawm/FnLj9Q4cTp8LYUGV?=
 =?us-ascii?Q?KyPkuN4cufzkvS+39fvOuNSiO8GPRwbkc14E20LrdzU6ZPRjCsJKLGN48v4P?=
 =?us-ascii?Q?1Ohewet+/QZJkhssYnXWtKt4bsxXyv+sCrb5CF3UGve/43J6JJ/2ASHbxiHP?=
 =?us-ascii?Q?y/1Bt3lREkHUItuBmym6YZkLlkhc7/aSZr6vb9A7JiZsQVaIVsEpVXTyIrmL?=
 =?us-ascii?Q?d+tkIYlaLgjJGb3IpVsnu+IA0hFWF4bouWZ8wQRtPitQMvorTGIJku8ZFxfL?=
 =?us-ascii?Q?Z77N5cMM/QLwuGiQuoQYF6+cWq7tEuvY0lj1cmH1Te5wph+lUiy5NfzUGiQV?=
 =?us-ascii?Q?jlhwLbPRh9Pgl9M8cqrqdOQfZy7ycw5hPr73hipDHVXCSx2blxITvfNIqsA2?=
 =?us-ascii?Q?fTdsCidPagBmly+/CoIniMYnvTrm0RMDRiLyjGXX5LKBFmfzVQSKImL98FO2?=
 =?us-ascii?Q?IC+biokYiBYfzBAZEh5pp60nksxYWPaQIi0U+hzLpm4wQa66vN4mia1hKeVN?=
 =?us-ascii?Q?usPkWxNQ9jJ+E5JNj0AeEraCEaN0EAMsrYdek4reKJGTNvsivv9TLcC8Ddz1?=
 =?us-ascii?Q?ZGmA9SHg43Lv9sSP2qvVylTRbsAjS1t0RXu5wNIjhcJB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da0cfc56-c656-43fd-0d40-08dc00eabfda
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 23:32:22.1837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlOrTERJSQIARBbKaroTushKdbHHaCuXPUco36NetWJxC05YSgIP4FYMOJ5T32K1reBIuFqrUjww8IW/5YeZ9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8372
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 29 Nov 2023 17:33:04 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > The addition of the DCD support for CXL type-3 devices extended the CDAT
> > table large enough that the checksum being returned was incorrect.[1]
> > 
> > This was because the checksum value was using the header length field
> > rather than each of the 4 bytes of the length field.  This was
> > previously not seen because the length of the CDAT data was less than
> > 256 thus resulting in an equivalent checksum value.
> > 
> > Properly calculate the checksum for the CDAT header.
> > 
> > [1] https://lore.kernel.org/all/20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com/
> > 
> > Fixes: aba578bdace5 ("hw/cxl/cdat: CXL CDAT Data Object Exchange implementation")
> > Cc: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from V1:
> > [djiang: Remove do {} while (0);]
> > ---
> >  hw/cxl/cxl-cdat.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
> > index 24829cf2428d..67e44a4f992a 100644
> > --- a/hw/cxl/cxl-cdat.c
> > +++ b/hw/cxl/cxl-cdat.c
> > @@ -49,6 +49,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
> >      g_autofree CDATTableHeader *cdat_header = NULL;
> >      g_autofree CDATEntry *cdat_st = NULL;
> >      uint8_t sum = 0;
> > +    uint8_t *buf;
> This results in a shadowing variable warning. I'll rename it to hdr_buf or something
> like that.

<sigh>  sorry again...

With all the discussion did you want me to re-roll the set?

AFAICS this is the only actual issue.  So if you want to do it that would
be great.

Thanks,
Ira

