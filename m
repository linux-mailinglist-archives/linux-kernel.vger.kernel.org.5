Return-Path: <linux-kernel+bounces-4472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE0D817DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2EDE1C21829
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE21760AD;
	Mon, 18 Dec 2023 23:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XpVLkkfx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEE87608B;
	Mon, 18 Dec 2023 23:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702941299; x=1734477299;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nitylwdwuz3SeI4B0slr62znbH/1Az1MkO8OkTJjJYs=;
  b=XpVLkkfxv4iz2+dqrt4v6KPwjpmfLknznzdUhwmNtqRtC6oIS+ll8lSs
   GVplVgltCYfgQyxhp+rlYyrE/veKIUo7QswWvLsN7EhGs6SqdxIbTf2qQ
   tv2s35jSftOljfvTdEN6Un/99ga5jHpdBWtjN0M1ieJZRyjQQ3bXSlZYP
   K+qfdStd3KbONnsIw8L+sXLRrjutkSrfqrXLmQhD/fcE+BRlsQBy/VT0S
   KXbBe10BxvblZh8sKCq4oif9Wl+ZChDjbEvDeT5k4hEiHgyGbpfHIUmNK
   ieFxGNY2kle4GKOsFUFLbBHHHLuEH+PB6bhWPt2SWJsKYpVCJTxpdA98h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="17135017"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="17135017"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 15:14:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="804685593"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="804685593"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 15:14:57 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 15:14:56 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 15:14:56 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 15:14:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFVIAuPCDCtImtpVKMvkSPNF503fnri7ZRdHP76Kz+fPfl+IypvY7W3YXJC17CAbg1nYXgmLwyxhn6l0rshci7KUqPKOrIp1z8T+dw0cYI8jyOHDwnkZz4fBbCVMssEVHDA2UJKeOzPdIzM49nx2+m5X2QLDoU0u0D431XvQXzj0rZnSDMVOxehf+AZ0TNdz55DAr46ZtksU/GEh9wJV2yhO/Be/+mHYNpYu+X5HxzcuRcUVeqVto9kIIDniZMinucN9KcdVHPDaGDaMJdVR2nSppoY/fiEl6V6akSJcKc71HrOp8imFopVaWKmYDZGLobv/+dj2TdX+9o/PkSxQ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYAd/Del/yiAJfHb7C3E1f6Fgw4MoUh0zomXd8TJ+9Y=;
 b=EEjB+KmDJeZfGPYaXwecoVvUtThNSLsZaRlJdwU79BBTXm4Iw7yg5q8eWUhTagQ+OxY72xd7QdHBNim0Oj0bISxz9UoNUiwMVet/7fP9L3/ZGqQo0TjkVdIzyVHZfKQD5lEImxerjWVwQu1+vIMpMQnY07ExexJL/ztuKxF4uPS7BBHUpBgyWUch0QFB1FWMUDZ/woA9i4jeVPKXSJfb3oqtnMYKgewNZWg72NFhaN+soS8+kV8XIozLE3NNKXxWt5r6ynn0Cx0YKtTOBdSMVsQbPp/JtEWCDxtKT0CLmxzf6eZap4tPPjxL5rSDgPFeGShkW+2+uUsUuiybDaLG4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BN9PR11MB5356.namprd11.prod.outlook.com (2603:10b6:408:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 23:14:54 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 23:14:54 +0000
Date: Mon, 18 Dec 2023 15:14:50 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Fan Ni <nifan.cxl@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huai-Cheng Kuo
	<hchkuo@avery-design.com.tw>
Subject: Re: [PATCH v2 2/2] cxl/cdat: Fix header sum value in CDAT checksum
Message-ID: <6580d26a74294_1bbb129489@iweiny-mobl.notmuch>
References: <20231117-fix-cdat-cs-v2-0-715399976d4d@intel.com>
 <20231117-fix-cdat-cs-v2-2-715399976d4d@intel.com>
 <20231218123339.000024fc@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231218123339.000024fc@Huawei.com>
X-ClientProxiedBy: BY3PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:217::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BN9PR11MB5356:EE_
X-MS-Office365-Filtering-Correlation-Id: a89b2daa-3033-4d8b-235c-08dc001f24ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TS1XHQM8c7W91/fl3+YWn0FGUXJ6TwSeUTYULOMlKE6AIu8XkTQUXp5qmNaHg+3J2mNCevBum6EnKV5F8RuwCqvkhLt6DU2Jd1N0y/oAqAOrVdQnwW7QVO1NKl7Jo1ZGwyl45vAqn3VyvnbWxM0d7soHKyhr0eGTXG0kJS7/NQHso/xc8shcl2L3ntjKCnPFtqN1BiV94e2Ks8B/z9AgW9z6YaWDtIz2omXW/Bu7L2GJVPc63X432/v6AoxS3KdH+maODkdNc9k93FNXECO5G1YuDIeVPBOPnty4qbd+FZy/CXoywTN64j+qVpBepwp933rLwMyToyCUxnfY3N2O1ziPmwJiUTMhFfS8W3iO+N66xISCkXcw0azdyoGBtNiyYLZA3jJfBQf6gx0FklVHJV7JsCpJzZAxnWu/qDcvb1GKTBuoT0Uno1qifcWl43mj+GHsmk3bfcYgsM+RGnjluY2OMlFyhedUqeb4VQN1eBB9LHkrrqnMFzInE08DOavg4aUjv8KXUAswgG22nBu5+v8GK3S9WZD9dLAbIx4EGPM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6666004)(26005)(82960400001)(86362001)(38100700002)(44832011)(5660300002)(9686003)(6512007)(6506007)(8936002)(8676002)(4326008)(66946007)(316002)(66556008)(54906003)(6486002)(110136005)(66476007)(41300700001)(2906002)(478600001)(4744005)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8A1oCCCjO59gTrUYwDlZplaZWhpnA+TRr4Tqw+igaiz+vlRiqaZ06f2ncW6f?=
 =?us-ascii?Q?hLUVTRPRYeBfi0nZlRafwldEgtTIvDl0xNIiQy1j34YlWyH9a6T53Z1fzJC0?=
 =?us-ascii?Q?4n+LLDba0mI/Xjt7stkiOtr5TgahakE6UzDQlLsc4X+EYk3sSeocUJli3T6h?=
 =?us-ascii?Q?1H6gvQ8tAvR3NY9/fpbdfl+0HImbX+uxUtSuSbAjuNRjTYmtiIad2bPIM/vk?=
 =?us-ascii?Q?YTFWYmBk7GD20s3+GcCEwQGNmY/CGAFz1UdZEVq3PSFiK/2t7ukiM2b5TfIB?=
 =?us-ascii?Q?6MQWc1w6xGOoGNdmYRtuMVTT/WsZOA2SacteyZv04jNhYzj2EHFpdQluE4by?=
 =?us-ascii?Q?0OrjIvssqRrkLkXWoWcsjYzpn7vz+meBPDjeTLa1V+UK/RPYEQBDe/JzIK5j?=
 =?us-ascii?Q?H5pL6KeLifxGsK8zEX8q5t6dufhzEJIWiA/XhKd0ziD6wutj27C/3s6TxMzp?=
 =?us-ascii?Q?MwNeD8QQjsOlVOKnT/sLE8CoPn/UC4pBgoI2Ln4v5gWwnXD3vp91mZbCwcsg?=
 =?us-ascii?Q?UxqeYxvemOz8LggufOejfh1jzbe1rMra+dt+nbG5IW8AVJ8eAisssytZJ/6O?=
 =?us-ascii?Q?kRLogi0ZUO1sLfybPDRlMXqh9afEJyTXCxOe8k3gR5nDiBupo92+FDt/xHn1?=
 =?us-ascii?Q?S/m2yx2sZV77QoHfdOeqM6zO99zUY8UeESyqv84g08RuRo3+qqPAU936MpU5?=
 =?us-ascii?Q?DPn3XJhS6deytLZXj21Zcw36XRAjAHNbWKWbc0IU9RQN1GEkykJG8zHv1MnH?=
 =?us-ascii?Q?T+xVBhyhLjpt0nT8XBrluPqi09Hfy0neJxIf8sur0erEqAL+c6wclbHncxd1?=
 =?us-ascii?Q?jxvVL51RQ8DPCifU6O+gImVljaukuOMGbwFe+kXQorVgp1pYlHm87DTr0KL2?=
 =?us-ascii?Q?hR8zPWpBFWmKamrCOpuTQIpYu0Pz2ae35IzIvwZM8X3+ty3a1gHLn0zfJZf8?=
 =?us-ascii?Q?gcio/F18wCufRAwUb2M0Btk8dYnt9giO1jAo5uGTchFbAukhpyMVWLnF7aAF?=
 =?us-ascii?Q?IY+lw/Xe1SHOVq88p3g0agkyJTdvCZ/uao2QeDCgiljvYsDIwE02bEhfHa8P?=
 =?us-ascii?Q?QRbuPOGpHao/4+cpaqjeXWLcWVcwWeyfAPKqh1sGP/I8KidHovUgxeYNVBGr?=
 =?us-ascii?Q?yoDsDNeZN+nlCuP0vFAepNx96JYaenEIOkaT00iUvRIO9TSw3O0UQhYGBSDH?=
 =?us-ascii?Q?kwqQ2UBjmdUhSWbOeK9l9jH/k6MniHi/evKIs2hlbTMNkp4GUaIBiAFa9IGR?=
 =?us-ascii?Q?NSQ7HT04T6rUODATgVVHhha3WP9QSFZzTl0LJ3Y6xKr2Irhe0HOlBC/Cl+jX?=
 =?us-ascii?Q?hF1uYC8v97vzgQtWHwuQseHArDz6Bq6iyyWuLHSs8coXc3Qg1mPQGBhvDamu?=
 =?us-ascii?Q?C6uQdjrJhYechojxLr6mUqj8pmNzUEdsHaOcz1hg9eDDTvOqLPNnoRi20Nv4?=
 =?us-ascii?Q?yn7a3yJ44aRA4riRmR8ojcG8WgWHynm2lzQRRak7VIzUPLUhqiWwQzqIrDJq?=
 =?us-ascii?Q?kwOvu9/Ykx9r7t1EeXkmc9RDTsZ8ZI3goxmzQ4Vgl0tlV48U4OBlwHi/qYJa?=
 =?us-ascii?Q?mOjV0IppsnMiMee9JMfboPSJ3vj6a47MznxAP9DI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a89b2daa-3033-4d8b-235c-08dc001f24ec
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 23:14:54.5169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XmbiQ3x5fEDGKc/jUFEsemNK1HkrIR3aq/HumThJj5Jru2IvJJGgEVLHENWJ187WWdbb/VO4QDOzJs8aNEQOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5356
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 29 Nov 2023 17:33:04 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 

[snip]

> > [1] https://lore.kernel.org/all/20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com/
> > 
> > Fixes: aba578bdace5 ("hw/cxl/cdat: CXL CDAT Data Object Exchange implementation")
> > Cc: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> This only becomes a problem with the addition of DCDs so I'm not going to rush it in.

That makes sense.

> Btw cc qemu-devel on qemu patches!
> 

Ah...  yea my bad.

> 
> I'll add it to my tree for now.

Thanks!
Ira

