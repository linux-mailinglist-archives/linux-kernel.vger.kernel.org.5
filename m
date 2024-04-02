Return-Path: <linux-kernel+bounces-127430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8C7894B37
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A731F227E0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D3F1C686;
	Tue,  2 Apr 2024 06:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RAm8KklI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D9B17588;
	Tue,  2 Apr 2024 06:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712038747; cv=fail; b=bEx22FIinUJguU058rmSxL/wKiJer+7HUzpxwJlS+3fa8aNhg8lZD7Y2VAz3ek4avT1pmHJs9anyGUHiv8xTdNjYakGz8Skj14v0zVSnFWHOUO64HF5DNlLycaCXMR3b9FigLI+i3duawwlX1x+SnPcrZfa50hQ27DDacKEXQlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712038747; c=relaxed/simple;
	bh=XKvZCecyMlP1dgSMzQwqxZ1Xy4cSsWEFF41EQXcT8Hw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rb2QrCZJmqWW9jZymANBCN5EFYKXlmN/QQu0xDDwG0h8dvLDl7C9C7Rl6PYfIV1Df5s6kKkNY+bblWahpcyoQsQLfL3NMAJm4+XeyAtxsbm1kFfgSWY56zmcAmIQZzel+Uw4x+OIBZ1N6/8ZqgtwJ8T/vmAMpWEpNJS8iTDkE5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RAm8KklI; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712038744; x=1743574744;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XKvZCecyMlP1dgSMzQwqxZ1Xy4cSsWEFF41EQXcT8Hw=;
  b=RAm8KklIMr3xbYMJ6jaB3BwXrsaBmwHTx2RFl3zkDN1lgZP3aPNLo9S8
   +hRLdQ5aO+LTr/3EgcrgJQ6nJ9leyHIjIYm4CGFBv0c+fDTFYQdCjQEKX
   YuAMaNi4N9Q7L9iX50crGUJedZ7xeu1yKy0fUoCih2A7mT9F5kB6Y5PnE
   2M0nq+JvgTUX8HHMvR2KfLDsxRHoWMsXSWPnuIXubbmhAIlPKjtPJKRfE
   30w4+hbp3FQ+tj0YmEGZvZkbsaNPCw+En8bgY3AiayHRYF9mQUymJiPl8
   FDyRORfP5wb/T6dxHjAqnwEmIQXD9KINDZbfkzD3gGq7ZfJ74iZvf7AZN
   A==;
X-CSE-ConnectionGUID: 4+Of1KeqSvexofsEpLqVzw==
X-CSE-MsgGUID: a1rG6GqvSMWm/msXU1XpiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7056569"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="7056569"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 23:19:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="22647391"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 23:19:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 23:19:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 23:19:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 23:19:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8BSAE3BOOpAbCJ84Wm7tF4ATv8FbXRSD/cQp5AtLysx7+iTad1Q8UB8IFrQtVGddFEuZrJwb/MIfkEpoFzyCly34codByNQcu2/WO96jxRKq+zhL6QygksVRL0+MogSail9ZXaaBmkcgBi+YLXr9bV6pU2+XD48rIw8E8Iw3LvmwWiqZPMxwzDYnShpWABfI2YIbZQm92+LENy2cEPupFX4zwodPeDlCBPtI2V7eQ/s+Lgt5uio7dD3gi//uXwc2juyX/Edmfp9yMDuOtyXouhw8LBJxV4fG6aAkt8GyuxhOOfzmnTSqE5mzURcv+xebkkiqLqyMK8pKh2P6bF44w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqkkGmJ+YZQ7w2OEyBreMA76g5Jf9nNRpyqY2VTcWl8=;
 b=iJV3F7Z3hDJFw6SWd/9KMN+JG3wDGkwtu+4iYuDZTbxZD1E3OhgFg9EgOCDsQKGPPr5w4SkGzyCwV4oCzlY77fcOTclJnniJPQS25JUqp1qbnwvRHl5gZtsuO9Iiskgw2N5SyIGiVyywHURN5C1ksfXnq5AxbPgKHOUuIsTtqU7pUF94KWtLq9e1cvFSTq976kfCgt7WAWwAUNdqj9CC11g39Dg1rpTNcCKONlQDqM4DLeAAfGYwbMVXDnriyVyVFvGO8Z/cGjPAXtalDjCtSABfAM0v1ZQrpjnBJ23LO9d5exrlIr4H71DEpWwbot568E1NLWhhs1WM9ueZtyLYKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB8347.namprd11.prod.outlook.com (2603:10b6:a03:544::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Tue, 2 Apr
 2024 06:18:59 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 06:18:59 +0000
Date: Tue, 2 Apr 2024 14:18:51 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Ilan Peer <ilan.peer@intel.com>, Miriam Rachel Korenblit
	<miriam.rachel.korenblit@intel.com>, <linux-wireless@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [linus:master] [wifi]  310c8387c6: hwsim.autogo_chan_switch.fail
Message-ID: <ZgujSwzFcEwXAeFO@xsang-OptiPlex-9020>
References: <202403291042.d9211733-oliver.sang@intel.com>
 <21c0ba406df6bc4cbd54810b3ff343ced5462615.camel@sipsolutions.net>
Content-Type: multipart/mixed; boundary="N59uyj9E2OLxwQK7"
Content-Disposition: inline
In-Reply-To: <21c0ba406df6bc4cbd54810b3ff343ced5462615.camel@sipsolutions.net>
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB8347:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fqce3Nk/Yf+cEjhqqk9uCBlIR3OgAGDkp5pXyy9nV2I391oUxCTHydoq1+kV8fz3234FuJv0e7SVP/CL8Nnrctzaq+COGS20lmGreqtnN892p49zwoq7L7DYrUQhub3ugwSvMsStpAE7KBsUjeG0URbl3LsB1DFQjf3e0tWFOGPFljFJ86Enb47nOBrOhclp5eRwkWZp0SxX0/qsTK+HJEoCna835y+ObqY9kQvnJXJqgfg4VmSSgU9Ol7XjvoGiwDl8UmwxrvBc8RVII1GCafrNldfTKX6G5XTANB/mnijiJ3kPCx4I+LHfYPH909bCK3MRTj0/4DR2IKPfUdWlsdQbaEGNzHI66Zenh2YHUzhvLD9QLhIZrB/3BMcv5RtSm/mPOMwfAOD1obwtfYbof9RMcrWLOeqKJPzjPoV7jS+OPMcBnnEJKn6BYiwMffBqFkolgpthRh9kAWxxZ4zIxJY7HWJf+SgPysCMPkWU3JDOj+qtoAIRKcC2+9nUPaxb6C1H9y6fjhqxsOK06V29abw5Ynt8Ns0N8ogQPcC6MPvoSX9meJ4fLmi4WQedsMgXvF+yaVHF5MhE6sVj4Ks/XPkwY0p5fb1PQ4nahR4T0bUSo92Ph3jArzeRgB1blQtf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3jDmWYUmarIAw7vHg2/AV7IolcaO0ieG+SXKUj4P/lxfcBdErfIDTM5dp4YL?=
 =?us-ascii?Q?fvzeA1XVIQd20oxO+aocISbagIKBHxB7W5z9BqB5S4uvN9Xtvr8HO/SiVS8U?=
 =?us-ascii?Q?6VTI/0yBnnvYQzh2Ps1QJezuzFU7EgzU4erO/vRF8FSpsrJlit/ZoSZQ/3AG?=
 =?us-ascii?Q?VZg0BKZgVv1hjJphd14xEftSvDDpl7q2dRzurva3O++iYNaCH41YdMfNdrZK?=
 =?us-ascii?Q?hO1TBw46wagWN9vENQDHOguB/B0SbDZzaHIAKplwLbrD4FYi+ssEd404wRkh?=
 =?us-ascii?Q?T+F5l33OqkBgkAgOBvZxZn84caD11zQSDFFm/j/NJmTPL5H1Zygl88BOOeua?=
 =?us-ascii?Q?B5MDWf0HVEObn/QzEiqomGvHeDJFl1Gb3ArglBFCUoNTBB+GM+hm7g4cVjuW?=
 =?us-ascii?Q?OD3mQswqzJ9KHKwHG8xblppp3vGuBR1jwCWwZfCT02GRVWrAB5b+y2kKB0ne?=
 =?us-ascii?Q?csFcF52CJpDuTnzEJnAi/Y0Yw+Xn6zKhbqZkSfJtTySpmWyuEarK/HK1P/xl?=
 =?us-ascii?Q?t+jCI3l9C2MIvtKcDn+8yfGEKZDg5iH73PseiFKV8XcmnAxSoEP9ueKs5Kmu?=
 =?us-ascii?Q?eDw8loxLIjma2yzae/6mlAVGNhKXlIvH9IA//GyiUbGVy9futP0Qtge41V3p?=
 =?us-ascii?Q?PCG+k51aqt123u8ORPUIxly5U3RwBvnQ4j6jENYBb+RVweJ53pVMX57GxqQu?=
 =?us-ascii?Q?dpvC0wsDfZDVqFiUyTkPSrzpzu30eH9WeEGHEy4QK0UNuf2YfXiTxjPq5D5H?=
 =?us-ascii?Q?FPbYY6TDiB5iygxHkkQI2xk20NGs+WZQm82raYlZq5LvmToB/R/QLtcfKQLl?=
 =?us-ascii?Q?hEYQgOG6ra9VlTbPez2RGB7UbdjxIO8bBDBwUFxuRBRssd/8sbPRBawcL+er?=
 =?us-ascii?Q?H1CWKBSzRZEt0770o5AME6Yup7jq1GpPQKNAV7jocV+1i3+9bBd8D3gTuItK?=
 =?us-ascii?Q?+CPAMTCnFPY1LPAfLcP+nagJQOzAUBqfn0pKsZoVhSyGld/CCg5/4J3ITKgi?=
 =?us-ascii?Q?s3OZq3JU8BJSyUUdKEcKpx0/6Bo/pHOq8bZWvKWvMFDt0Vn12i/P7qcnlccc?=
 =?us-ascii?Q?M1uN3hSqWYVyvXB2YHoIN6ZO7FcUnxxYqVbs/IOtJPLKdhafn4xTFmyr6m7H?=
 =?us-ascii?Q?RWQ5ogrOJcUo44PvxB+Qdv3HRGPYAU5UbiYn2LsNJYM/dS7TlAS/eZ7r6arp?=
 =?us-ascii?Q?2C1h3d6SwSn1PBQ84IbjNeStYcW7Dsu6uN8wwHsjkH+GEeNvjqm3roYjhZej?=
 =?us-ascii?Q?wwBobeEHcjqWgxsQheLFPqttFj1AdzVSHm7GJQl9SZEdJDovLS+M4lK/f4N/?=
 =?us-ascii?Q?svuy5gqyJKgfBQAECkcAD6snRLEgzuDXSDFt+7utPXTXOcH1cPDUP0Agl14O?=
 =?us-ascii?Q?a6cUPci5dYiy1yOGVT79dAg6E6L0xzEjpbbnVUqvdDJ8zrzcmi6asQ3qH052?=
 =?us-ascii?Q?IguPmy+q19VtxDFEA78ug2PyJVsro5p3L/+FS61sDFXFFxz0yvhUL8i2ioD8?=
 =?us-ascii?Q?m/FQE7Nkympx0gVZwiTYqT7ynaGhXBbMfAuavze9MINYcZtUdv4qZYBkFqEW?=
 =?us-ascii?Q?m1pdpQNudQeMH+2+UVbtgDzVTbT94U3RaJBg6Dxf1o4kR7ng0b2UoutUTMOm?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9da658-5a48-46d8-4691-08dc52dcc8d8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 06:18:59.7217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTn1hMimfAXSMvWQmaM8A9NsNoza4Oziylb4Z83IsZmBAdiPRLEj1nI1krCLaa9MJbB1Adi1+bEz95S57Tf5aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8347
X-OriginatorOrg: intel.com

--N59uyj9E2OLxwQK7
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

hi, johannes,

On Fri, Mar 29, 2024 at 11:08:51AM +0100, Johannes Berg wrote:
> On Fri, 2024-03-29 at 10:24 +0800, kernel test robot wrote:
> > 
> > Hello,
> > 
> > kernel test robot noticed "hwsim.autogo_chan_switch.fail" on:
> > 
> > commit: 310c8387c63830bc375827242e0f9fa689f82e21 ("wifi: mac80211: clean up connection process")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > [test failed on linus/master 7033999ecd7b8cf9ea59265035a0150961e023ee]
> > [test failed on linux-next/master 26074e1be23143b2388cacb36166766c235feb7c]
> > 
> > in testcase: hwsim
> > version: hwsim-x86_64-717e5d7-1_20240320
> > with following parameters:
> > 
> > 	test: autogo_chan_switch
> 
> Does any of that tell you which version of the tests it's using? It
> doesn't tell me, and "717e5d7" doesn't seem to be a hostap sha1. I also
> didn't find it in the CI archive.

sorry for confusing, due to some history reason, we improperly captured sha1
from https://github.com/bcopeland/wmediumd.git in the version label.

now we fixed it and it will show such like hwsim-x86_64-07c9f183e-1_20240402
in the future. the 07c9f183e is from http://w1.fi/hostap.git

07c9f183e (HEAD -> main, origin/pending, origin/main, origin/HEAD) tests: Avoid control interface throttling in various test cases


by just this version, we tested 310c8387c6 and its parent again, confirmed
the issue is still persistent

61f0261131c8dc2b 310c8387c63830bc375827242e0
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :10          80%          10:10    hwsim.autogo_chan_switch.fail
           :10          80%          10:10    hwsim.autogo_chan_switch_group_iface.fail

I attached one hwsim output from parent (hwsim.61f0261131) and one from
310c8387c6 (hwsim.310c8387c6) for details.


> 
> That said, there were test issues raised with recent commits (and
> particularly this one), even upstream one of them (eht puncturing 1) is
> still failing as far as I know.

thanks for information! if you have any patch want us to test, just let us
know. Thanks!

> 
> johannes
> 

--N59uyj9E2OLxwQK7
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="hwsim.61f0261131"

group: group-20, test: autogo_chan_switch
2024-04-02 02:33:29 export USER=root
2024-04-02 02:33:29 ./build.sh
Building TNC testing tools
Building wlantest
Building hs20-osu-client
Building hostapd
Building wpa_supplicant
2024-04-02 02:34:30 ./start.sh
2024-04-02 02:34:32 ./run-tests.py autogo_chan_switch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START autogo_chan_switch 1/1
Test: P2P autonomous GO switching channels
Start autonomous GO wlan0
Try to connect the client to the GO
wlan1: Trying to discover peer 02:00:00:00:00:00
Client connected
PASS autogo_chan_switch 16.361446 2024-04-02 02:35:03.458893
passed all 1 test case(s)
2024-04-02 02:35:03 ./run-tests.py autogo_chan_switch_group_iface
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START autogo_chan_switch_group_iface 1/1
Test: P2P autonomous GO switching channels (separate group interface)
Start autonomous GO wlan0
Try to connect the client to the GO
wlan1: Trying to discover peer 02:00:00:00:00:00
Client connected
PASS autogo_chan_switch_group_iface 17.332407 2024-04-02 02:35:32.180969
passed all 1 test case(s)
2024-04-02 02:35:32 ./run-tests.py p2p_device_autogo_chan_switch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START p2p_device_autogo_chan_switch 1/1
Test: P2P autonomous GO switching channels with cfg80211 P2P Device
Start autonomous GO wlan7
Try to connect the client to the GO
wlan1: Trying to discover peer 42:00:00:00:07:00
Client connected
PASS p2p_device_autogo_chan_switch 24.354487 2024-04-02 02:36:07.851656
passed all 1 test case(s)
2024-04-02 02:36:07 ./stop.sh

--N59uyj9E2OLxwQK7
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="hwsim.310c8387c6"

group: group-20, test: autogo_chan_switch
2024-04-02 02:29:04 export USER=root
2024-04-02 02:29:04 ./build.sh
Building TNC testing tools
Building wlantest
Building hs20-osu-client
Building hostapd
Building wpa_supplicant
2024-04-02 02:30:06 ./start.sh
2024-04-02 02:30:07 ./run-tests.py autogo_chan_switch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START autogo_chan_switch 1/1
Test: P2P autonomous GO switching channels
Start autonomous GO wlan0
Try to connect the client to the GO
wlan1: Trying to discover peer 02:00:00:00:00:00
Client connected
sending data without carrier won't work
Traceback (most recent call last):
  File "/lkp/benchmarks/hwsim/tests/hwsim/./run-tests.py", line 593, in main
    t(dev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_p2p_autogo.py", line 357, in test_autogo_chan_switch
    run_autogo_chan_switch(dev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_p2p_autogo.py", line 375, in run_autogo_chan_switch
    hwsim_utils.test_connectivity_p2p(dev[0], dev[1])
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 227, in test_connectivity_p2p
    test_connectivity(dev1, dev2, dscp, tos, dev1group=True, dev2group=True)
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 217, in test_connectivity
    raise Exception(last_err)
Exception: sending data without carrier won't work
FAIL autogo_chan_switch 16.286132 2024-04-02 02:30:39.168596
passed 0 test case(s)
skipped 0 test case(s)
failed tests: autogo_chan_switch
2024-04-02 02:30:39 ./run-tests.py autogo_chan_switch_group_iface
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START autogo_chan_switch_group_iface 1/1
Test: P2P autonomous GO switching channels (separate group interface)
Start autonomous GO wlan0
Try to connect the client to the GO
wlan1: Trying to discover peer 02:00:00:00:00:00
Client connected
sending data without carrier won't work
Traceback (most recent call last):
  File "/lkp/benchmarks/hwsim/tests/hwsim/./run-tests.py", line 593, in main
    t(dev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_p2p_autogo.py", line 383, in test_autogo_chan_switch_group_iface
    run_autogo_chan_switch(dev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_p2p_autogo.py", line 375, in run_autogo_chan_switch
    hwsim_utils.test_connectivity_p2p(dev[0], dev[1])
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 227, in test_connectivity_p2p
    test_connectivity(dev1, dev2, dscp, tos, dev1group=True, dev2group=True)
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 217, in test_connectivity
    raise Exception(last_err)
Exception: sending data without carrier won't work
FAIL autogo_chan_switch_group_iface 17.390208 2024-04-02 02:31:07.869510
passed 0 test case(s)
skipped 0 test case(s)
failed tests: autogo_chan_switch_group_iface
2024-04-02 02:31:07 ./run-tests.py p2p_device_autogo_chan_switch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START p2p_device_autogo_chan_switch 1/1
Test: P2P autonomous GO switching channels with cfg80211 P2P Device
Start autonomous GO wlan7
Try to connect the client to the GO
wlan1: Trying to discover peer 42:00:00:00:07:00
Client connected
PASS p2p_device_autogo_chan_switch 24.104111 2024-04-02 02:31:43.303405
passed all 1 test case(s)
2024-04-02 02:31:43 ./stop.sh

--N59uyj9E2OLxwQK7--

