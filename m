Return-Path: <linux-kernel+bounces-24617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 669BC82BF37
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FFFA286417
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9485767E8D;
	Fri, 12 Jan 2024 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bEA39xps"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2626067E7A;
	Fri, 12 Jan 2024 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705058909; x=1736594909;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=54Ud1rr1tNZHgbBSQOj1HHWyW/J/UW1q9DBd/TxcU3A=;
  b=bEA39xpsftt5QMsxW1lEPM4JISyZo4ynrLjqWP0qRaqwbBk55TbRvdzl
   2MrLxYnyh7op+3Ps7NyL2OPs8psz0x0N6xZfWI0HVeTq05RnyQ41a/frS
   SnDjzmECMvyJMtLNlCu7OFFcH8olzZrMWSFvCC6gzmMlvctif68nd4l9L
   TNzGpQlqyFjjzVz7LhaqbVVQM8gDyIVAmBYZAr1jM9HQiAaxHLsPU/Us9
   DOHqQuh4VC+B9/xT+JC0LFXi9YLE1teupS4fcZIopC6WhqfIo5xvlAbgA
   gvgUvtUC3DIHnYtwOKlBYOpQ6AukGvn7oeiV9HPDXG+w6qbANKxqa3JpN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="463434656"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="463434656"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 03:28:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="1029897369"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="1029897369"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jan 2024 03:28:27 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 03:28:27 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Jan 2024 03:28:27 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jan 2024 03:28:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOd8/qrP5l9t1MsWNGkgI31fewb5oS0ysTjFgAMb9T8DDeA6/IVqKzRQz4Kk4qEUsfaaD5H2IcYfGCZcdaJQzCpVi9Q+HNWniW66gBEU2es2gY/L1ofXCl0+hPexvuY/HET6Z5cAI/++HyxBvPyUZGRz9r+LIJLcLYtkcqmeT21jXchnAyNxv7eJgQfHno7TmpUYXlUvmY5zxjkpm4JfLICkjD5ZXvTAjnFm0w7p1GQgAnoW7bgtNLKoY2iw+7sOQgpy2YShOcmt8tT9/VIBR941wyQTvBmq8g0Klh35y9jIPDSL79c8s66rioqghkRJlV54KJHREBij+dsCr1s15Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88fYawkHGnQ2SsKqVQX61o+BrMHbl0gr/LQkYWHtGKg=;
 b=D2eMmy/rif6g3XrIes0bQw9uTW6Y+Bxpn1ku/9VsiY82yyNrswPamA5ywaWobKbbwYNB2leeqRaxgWHUREgpVw3Hn43/R0D4JgVrb7tSQlL8UuiOncexr6ZIlnNo53vhbt4ANgzgDWNF9NqVGXuqavGkzs+2g5PGg6BIeaRSbNKFPHeeVRRo46qispz5h0abTHGOSHmX8R29QC4Lm+/zMOzmkYoVvaOcHuFCtiiDqQPsP9jgd7BnbZ4g6RILNz8kG9XIxyQDy6+EauIEu9RdULf1ptqPdyg0z4ExibzAliefpGLYqFo6QAJPKkda5/fDF2fLHPseLWmKhqooHvNkxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Fri, 12 Jan
 2024 11:28:25 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7181.015; Fri, 12 Jan 2024
 11:28:25 +0000
Message-ID: <5838205f-41ba-4666-9786-11181552a738@intel.com>
Date: Fri, 12 Jan 2024 19:28:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [connector] c46bfba133:
 stress-ng.netlink-proc.ops_per_sec -97.2% regression
Content-Language: en-US
To: kernel test robot <oliver.sang@intel.com>, wangkeqi
	<wangkeqiwang@didiglobal.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>
References: <202401112259.b23a1567-oliver.sang@intel.com>
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <202401112259.b23a1567-oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|MW5PR11MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3734bc-603d-4e71-55fb-08dc13619722
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wCekHEZuBGUwD+wetH8jbKjY0+J7K2/UUVMBSUshQjuDualllmbFTDEmbT4TwnlzzEoVVZ+bb6JknZlIicCJZiLFj2vj6Hg0ANnzsEirAfU+nFiUX/WHvOEknvVAOn2fU46fCyWLpEY7lroGC8pKRV4lsZbouyx62XvJ+BNztIRBW7hcsr0uyvjIDmkHNyMJkhr54b0X5k9PWqdCOT75oRvLkDqIMEaqjgdf/SoEID00T0cg2qPHdro/mBJlum3eJvirbFWUtYoVl0snAkwHRTvMl8J92NZhQhHNSLtKOQr+wi4Npqvo0y1z30KyU6kyIGWfjYZZLV8dwsx2BNEDJRodyVYKIEjbHtQThPRlSn9Q5Ggo1F/LHOpMxVoIqY94lTb/2BO24WmC0rBDlG1OugHjn64IpvYQJyD1xcmGp+qZVOGNuJtYHRgBOZWAGwV74SaxrAt5lNcD1krqnAtA4f8ndZAz4h1gg+gGNXmp3fMGiO1kBOgl0w+zeGu8liLk3ppqLUTZ9j1MVkVUz4o1gp7McGC0dwvdQ4Ka4ddv/vg4AM3HT+2B3nXtNb7MQGeqIF7IilwpUsnY0XbCUvvWGDiZDfQA8qSb1xmfrzbQLXwEwvVADNcTYoqU18/wcvWSiJ5AjeQuVYf+yZpBgihL7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(6486002)(6666004)(6506007)(6512007)(2616005)(26005)(107886003)(36756003)(53546011)(38100700002)(31696002)(82960400001)(41300700001)(86362001)(478600001)(8936002)(4326008)(5660300002)(8676002)(66476007)(66556008)(66946007)(110136005)(2906002)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHo1dWJhaU8rakduclMwcEFsb2lRQ2d6d0EvUzAwRGRVMnBIZWxzKzBZeG9U?=
 =?utf-8?B?ak1wMU85aDhLRjZtdWRiaHhJRTZjZ0UwU1VKcDd5Q1Y1Sk80NjZjdno1c3Fq?=
 =?utf-8?B?RE5jT0F4R2o3bmtZVThQYnB3QndVcDZWL1U5bFl5ZGZVOWdkc1RFb013UTNS?=
 =?utf-8?B?RHF1VTFvL1N5T2ZGWDJ6RWR3Q1pjOXp1S2xQWVNvS1ZDSnJWU3g2c0p5RWI0?=
 =?utf-8?B?OUVoRGRtdEllNjljNndCdll3RytHTGZtbGtublN3SjExakdMY3BIdU1iUnht?=
 =?utf-8?B?UDg3QU8yYWNySlIzNzFkMGNMZTFPNGh6YURYT2VMbXZtdFZvRWhxeUF0a01z?=
 =?utf-8?B?QWt6QlV6SnNPanJhZzV3QkhyVkpzM2FHV2ovOHBVRmVMeGdVZnZuYmZXcldK?=
 =?utf-8?B?WXRpQjBqK2owTTBvZHE1R3NLK1gxVlo0MGdqVlQ1Vytlb3dVRTdzdUJ1SE9p?=
 =?utf-8?B?THpZakY5ZmdEYWI1anBKaTdsTzQ3Ti9MOFlNMGxDcTVPSXBmMmdES2YyL0FV?=
 =?utf-8?B?ZUlqUnhUMy9WR0g5eC9TK3VSZDM0eFZpZUxxeWFCdFFwVGVBU0VsRVI5QWVL?=
 =?utf-8?B?c0NxcXVmUCt4TW5jUERTYXdod0FVY2R3d2pmaUNOREpoWXF0Vkozbml5ZThC?=
 =?utf-8?B?N29aM09IQ3czYkJwcjV3TTdQSkRCcE5MYmdhQndSNXk2NFQ4bTJVTVhCWUo4?=
 =?utf-8?B?ZGZCWC9EZGgrV3Y3bVNpMWY2Y1FlWG5OSDVHTjJkbFdiSzNKYk8wNVcwMzFw?=
 =?utf-8?B?a3huQnFSSWNCWlJ6UU45bjJkSS9XYUhaRTNUc2NuMjhqS0ZweG9XQXlRTTVx?=
 =?utf-8?B?TytLckRlQjlnUVJ3R2piVm9IaW55dVdiNWpxckoxVUFlTVFDNWozR0dIRElP?=
 =?utf-8?B?WGQrSUpCNTZXQUxxMk5MelZHT2oyektYK1Z1UlA2UURMdGp1ZGJLTDJiZ1hw?=
 =?utf-8?B?ek9JUkpEa3lBUnl6cHJMbWpsT2kvVkFudDNKRE5hdUM5WXRBak9MV2NkOVcz?=
 =?utf-8?B?L1pUclgrUXNDc2dyMGlad3ZWUjlIb0NMKzRPNFhFMGdWeEdsMnkxWVBjRkV4?=
 =?utf-8?B?TFVyMC94ZGhhWExtSDVrcmZ0aWRyek9PVWhRR3Z3eStabytnTEpMakhtR3VR?=
 =?utf-8?B?dkhTbzVybGJqQ0UySUMvRXFEQlQyYndNYXdCZFJ1UjVPNng4Z0ZlMUxKT3Fo?=
 =?utf-8?B?Vm1WOE5xS2dwUmhlT0xEVnRyb1JFZTU2dWFjNW9Fd1BsZkt1WGVXRFlyRjds?=
 =?utf-8?B?UjZrZUloSzFJRjNyam9TV1dRakp6VWgrdnhib0RSRFo4UU5zZEpDOGY4djhO?=
 =?utf-8?B?QmRyU3ZYcnowUGRoUk1uaFQwdSt3R1B5R0xLVk9yRzNudEl5bU9GQWxLMEt1?=
 =?utf-8?B?dFZXb2ROTDRyc1JHOFQxei91UzNYL3pSazl3ZWkrS0FsWDlYKy85ZXhlOGVB?=
 =?utf-8?B?UHJSR3Z4QldjOGxPWWNvbnlab3FiNWJXeDIrdHh5bHRVdjFCbXpHcGg2UEIy?=
 =?utf-8?B?bS9WOW9LUkZPVndaMjk1b1QyZVdoWDdXVGV0aThVSkpwTURBS05iM1NmZUVO?=
 =?utf-8?B?TWZRejdodXhIT2tEN1hOa3Fva3Ezbi9NakxkKzR5RHAzNGJrOGdKcmhnbWlp?=
 =?utf-8?B?OXppQk1ZeVR6Z2dtbFhablZUZjltTno1QVJLQ1VEc1pjSHVVcnJMN3ZVRDFG?=
 =?utf-8?B?cjVtZnc2V3dWUnBFd0tjcnJYYksxWDhRbVo2TEQzMVdnTWNkU3owS1R0YXo3?=
 =?utf-8?B?OUY3UHBxbDkwZTBqeS9tVFQ0OXFYUlFlcWVWZEdmNVIySmtqc3pUN2RlOWpK?=
 =?utf-8?B?Tm5WNyttWWtuWFFzNURLcittcGdQbkVtQ2xTaCtKRC8vMXZRdkEzUklES28z?=
 =?utf-8?B?ajdDb1pqZTFHeWRFTVNBVk5wa2NpVDg2MkFHVCsrLytsOFNjRnNPUkFtTjlv?=
 =?utf-8?B?cEluSWNBVzNGQmFFVllEbXNsSkFEL3cycjNoMlFhWk8xWjh4YlBwck84YXlD?=
 =?utf-8?B?N2JnUTMrS0tUN0tHVXVtMXEvOXI1SjQ5VnZKQmIvVnJVRDBIdm9HR2RLeWwx?=
 =?utf-8?B?cVFRUTFjb09zckY2dk1HNGdha2Y5Nkk2MWc3VGpRK2Z5ZjJ3NHQ1cVhSWDBN?=
 =?utf-8?B?NmRhLzQzYjdwcElkNjNHcmVheExVc2lncTI1SW5mZVcrdGNrSUJzV0ZvUXMz?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3734bc-603d-4e71-55fb-08dc13619722
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 11:28:25.1091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmmLN0Frw5Q5+nEARPD5z6+ZQP054sRD6P3o0TGVIbJl5AN7EQQshykakBBECy7TxCyeNUmwT6wM1ZJJdaGq1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5810
X-OriginatorOrg: intel.com



On 1/11/2024 11:19 PM, kernel test robot wrote:
> 
> 
> Hello,
> 
> we reviewed this report and Fengwei (Cced) pointed out it could be the patch
> breaks functionality, then causes stress-ng netlink-proc performance drops
> dramatically.
> 
Just FYI. Here is what I observed when running
stress-ng.netlink-proc testing:

Whatever with/without the patch, cn_netlink_send_mult() returns
-ESRCH in most case.

The following is what the cn_netlink_send_mult() returns when
stress-ng.netlink-proc is running:

..
213801  213801  stress-ng-3     cn_netlink_send_mult -3
213801  213801  stress-ng-spawn cn_netlink_send_mult -3
213801  213801  stress-ng-spawn cn_netlink_send_mult -3
213801  213801  stress-ng-wait  cn_netlink_send_mult -3
213802  213802  stress-ng-4     cn_netlink_send_mult -3
213802  213802  stress-ng-spawn cn_netlink_send_mult -3
213802  213802  stress-ng-spawn cn_netlink_send_mult -3
213802  213802  stress-ng-wait  cn_netlink_send_mult -3
213803  213803  stress-ng-5     cn_netlink_send_mult -3
213803  213803  stress-ng-dead  cn_netlink_send_mult -3
213803  213803  stress-ng-dead  cn_netlink_send_mult -3
213802  213802  stress-ng-wait  cn_netlink_send_mult -3
213801  213801  stress-ng-wait  cn_netlink_send_mult -3
213800  213800  stress-ng-wait  cn_netlink_send_mult -3
213799  213799  stress-ng-wait  cn_netlink_send_mult -3
213798  213798  stress-ng-wait  cn_netlink_send_mult -3
154697  154697  stress-ng       cn_netlink_send_mult -3
..


Looks like it's not accurate to reset proc_event_num_listeners
according to cn_netlink_send_mult() return value -3.


Regards
Yin, Fengwei

