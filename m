Return-Path: <linux-kernel+bounces-44850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2F9842821
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121BF284CAE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B2A823CF;
	Tue, 30 Jan 2024 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BPwOfUFn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D671085C5C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628869; cv=fail; b=r1rgNmHXOke/BW9ArCX9tTNPhlWJ1umVT+pDfJsYo3PJGBgxKkNE3+xllfsBnfFKmIKugicPonATGJ2YElcxcaueT4gkyLAgKz4QY4ZX3gBAaYGvDqMDh8UyyF6DXMIc3QpNW5mpXIMjnQFn/RRAVr1fYFFraMbnhzMDWDOtWvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628869; c=relaxed/simple;
	bh=fAKLyJ4M5ESwBNhKjb1/w1RvupaQsIdaFujb9Cv9UIg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KZV+c6+YJYD8987UFx2uk5gpeqzSS9euOpCfjRE0U+IfjIs10ZRXdDVmbO/aWNgpwayy25GnInKauuorATQnklFmXDKexRCYbObSZqzwoavZ0PD934GcGGfwJ8eJJMVWtwSVxv68FU1MEnBOr7l05nmrtu9ib4/2w9srAtyCI7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BPwOfUFn; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706628868; x=1738164868;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fAKLyJ4M5ESwBNhKjb1/w1RvupaQsIdaFujb9Cv9UIg=;
  b=BPwOfUFnkaiIzhkONRN93nt24O6j3JJqDTcB41umqVx0bJQCuLV1zw7p
   8+zULlXlGbTc5OjlGw41SotC69LvelAY3YRXQTb6W/MXPTPQR1eFZNMrx
   7vkNKkNOM6jZtj7DyEFb4E/eYJ3qP6UQ5bgcV7LtfBJbnY7WivQ35nWEg
   C347voZ1FYePCcFlXqS5JAHYUfQwSXxuVXKdkEbslGHA7dRmapUDRw6/k
   JEVm7DgrvC9/bZTkczs/+bfgys0ox2CDiWyP8F6/9SWbyOLrFyFpqYtNz
   4OPpzFsKNOXjjmsHUfCtBsseiwlcXc3Spk0FKWd1MS6oxEFBLdJ0ndJ2I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="10059781"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="10059781"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 07:34:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="737806870"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="737806870"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 07:34:26 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 07:34:25 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 07:34:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 07:34:25 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 07:34:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtXorzdVEirVJmaYFOZ1kIeOOjrZ4IcHls8TWylmrHp/hOsUJpAyrgEKsee8w/5VHf3JFw6JNXgOmxC+T4Qvl7JFbomNoO1STXSWfbsUyCo+BaAy6Rx6C9T+cwqubCXBzXuWWMZh9JhKkNBo6mgwCIMCYqyGQLmzaHbpYOAtrSPBeRhcJ3Xb1Z7EyyhwUSlzZ85OYwjA05P/A63JN/WKN019EJ6xxAsfDv3NNfeGG8u+1XQBa0tj5AaR9iOnXTMBYtO8z2fmOR4KaCGEetn1q/SRcUTr6zIzxYXzrZpRxJYZBMZIqzVD9ElYqGdR9zWXoSN3sedKjD2V7SM8UDNmrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0ya7ZAJ0mY7t95nxwJMmpnvW+5el7MuvBO9kKGBZL8=;
 b=Advi++SmiwLgUgvrfZhKvMHD35Ls1t1t2ZGj3YHphknU4f6ty2D3z97jFXdyYPg8Rh/fzmE91zKQNe9QBsln/psVu7uZ/lhusaVIIpBhTmx5Gifd5h9UHvuuAnwzfctndEXpqWM7Cm24BiOjmuwnC8lYtu//aCcE+uGEStcF6EbT6azsWHKyu5uciJtXxICXcl2EZxkRtnvQVXf+W43Lxjvx3UN1y4MXmlBHy26tevbP5cq86DGpCk4Bt7IU1mAx/iUwvQNd7E9YmnWfD3CPOqyYjyypPa2O5ImnTtJk1fKsM6E/TZCZB7LHg6uMcvfKcU4Na9QTtoIeTSywC2Dqgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by CH3PR11MB7273.namprd11.prod.outlook.com (2603:10b6:610:141::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 15:34:22 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::a7f1:384c:5d93:1d1d]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::a7f1:384c:5d93:1d1d%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:34:22 +0000
Date: Tue, 30 Jan 2024 10:34:18 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Mukesh Ojha <quic_mojha@quicinc.com>
CC: <linux-kernel@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Jose Souza <jose.souza@intel.com>
Subject: Re: [PATCH 2/2] devcoredump: Remove the mutex serialization
Message-ID: <ZbkW-kJ8DTgCZphm@intel.com>
References: <20240126151121.1076079-1-rodrigo.vivi@intel.com>
 <20240126151121.1076079-2-rodrigo.vivi@intel.com>
 <e356adc5-937f-08ba-68bc-975ef96d6332@quicinc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e356adc5-937f-08ba-68bc-975ef96d6332@quicinc.com>
X-ClientProxiedBy: SJ0PR13CA0181.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::6) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|CH3PR11MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a45117a-6470-4e90-0f44-08dc21a8ee8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7N+CE6pzVtrVt24M4YZCUHwj9JYrFuLAQKmpkIhjcqCZaS0ZPeNMZEydFCcFqxfYuTTfKdx+30mtAz0puDAxJQjwyVAK1sybKogfEbmcVtsWTHdhuNjVnEWJnwIbRiIHr3TRI+NTLoROgj8ASzkvuKBdLstDYEMRDR8UKe87UT/p84M0C6+kkZ9gZMeBF28YoOiI2Ce9+FuJY4OGyBEO9l0w3sTDz1SdOxU5BnGCy/D7TsuSTdzKtcUwo4FFRPwDdbIY5h9xZ7YYDYwn1qsWEz0DqTrBVPhNfqrQHuflnQVrLSY2cBvk0m4ykeWNkbBcmUoluYgmFz0UMPv9h9WTseWMbk0C3vsmWonFCCURE2gUd+9ZY6MnFjuoZV3Mq+nnc9VQtWweuq88hGSmLvevcUjEoYr6hWoqYi9tLYgJGqZ4XgNlmhQL/DZepVT+fkGUL5TRDWQjhR8z2ed6neIBhvBfQVpcnFIQHK4CwDdggd5kHFMczjw1Gbr2JXv/nhXhccF6elUyBtuYQXEBbQSbvzILkGHIb4G6TcBS5RCz5m2lsVj1+cTtGxCElJxv6anVZK1qxB+slgCXLeAPlU5IncNihPYFxCjr7xnwwwW5V8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(36756003)(38100700002)(83380400001)(41300700001)(2906002)(107886003)(6512007)(82960400001)(2616005)(26005)(6666004)(478600001)(53546011)(6506007)(66946007)(8936002)(6486002)(54906003)(316002)(966005)(66556008)(66476007)(4326008)(6916009)(8676002)(86362001)(5660300002)(44832011)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hk4gwRdRzxtOvyt7Fs3ye5s7JHqAQQsYhADGj3C1tAown89ek463PgwgeSRG?=
 =?us-ascii?Q?ATb+x5zPx1ccHWnZkvFsW5GUJYcVfTLNoHDODOmjbJjgNqpkH2SYm70lG5Ux?=
 =?us-ascii?Q?t2RcUOL4xAsgnGZa+mUphD9Xfv4Pt/u3dIToNMRVH4LGmMrKZNa55BBZ7H7v?=
 =?us-ascii?Q?faa/yKPQGHRU6f2hVOwOAF2y2nLK1kcetxxPU94HmzbRhke7izn4LjkFaR/C?=
 =?us-ascii?Q?M3U8kXpurNyl0k6NItqELuo8/Qga6A1+4qvU7FlQXYRf7ZeCOmqLJe1kHTD1?=
 =?us-ascii?Q?9Cezkm+WBrEkWlY3QzpmAVzHoeQCAYBRdcdM5cUX1ic4Gk6VwPsz9rfjOzps?=
 =?us-ascii?Q?eaw9sQFgBgOvy+2pmddlEOQRFLiu7ObOxmby5Yma+zyXpqepZQI4bQ43++Fu?=
 =?us-ascii?Q?sFD9wY31i2zKvR99KIePcx20BLGnKPaq+Ck2jROWcfZVoBcaJj30QgmQsdhk?=
 =?us-ascii?Q?By7WQ9vKDyNGsTpgjjPJPOY6TrPBD0KVgrqtmrolYCSgclXfJtVX08Zi8ow3?=
 =?us-ascii?Q?rhFrObm02pOS4GlObALL+DMI8OD6yDCEUqSr5z0bZGr0kW0i/b1ad4+XAcwu?=
 =?us-ascii?Q?bloMOiE8js2E/EnvYbAeYeSBZOhObz56+jHDgl2BUQ1LOVRrUPHxthr3T1MC?=
 =?us-ascii?Q?fx5YQCd0b2VZ14sJ2/jlQRcAGihcl8yCSb9UrVGFCm5jbj1OBqjXuaXimnAk?=
 =?us-ascii?Q?ealjZ9IOlebVQB6f/R6x0dNcD1LOv6g5q4GxfAJ/fD1nzCoGoAzvBx5JPzym?=
 =?us-ascii?Q?gQ5Y9SghbVgl25jb4i9QOBKzJMIvAnehzn3G7fmlS6EtGH9BoIXToYkZwKCe?=
 =?us-ascii?Q?9K86hBSaaIisPRxaOVRy9LK7yWus7WD6VMq6Dj0aQKCwqB/sF3JamU6ZlCsQ?=
 =?us-ascii?Q?cwG+NNef06Js2s2HYDtCaWeIyIzXIabHIdJra3+5ievsiZz86m/yx+OHCVC5?=
 =?us-ascii?Q?IDBThLdmlWiz0qm7rVhOMeTS6os5lOR/jwDPnKa65s01jmih70IE1HHmix5b?=
 =?us-ascii?Q?TjAdUyVErz8aQBcvNWKx/U+mkGjeSQLjk71Y7eMUHr4RaEF0kkGtBnut05BJ?=
 =?us-ascii?Q?FaEV8IFxDbhBqkHHDIYffur9xx82vaMFzWE/rHnowQP6gbLOx78RbRsEdfxe?=
 =?us-ascii?Q?UYhafBLK9xfc389JVpmJtzOBQclx+zL2w+FU6xLJAeeYynaw5JpJtvqiR/Bj?=
 =?us-ascii?Q?QzHsvcIKZq/kSzhGSaaIgdgp9mnyjFBK8NK2lF8usqsDH2/jTurmI4uF0Wvg?=
 =?us-ascii?Q?IfOKdFeu50qG7EEswPT/TldnX5hssdKSQopDGC6eQM9nkzoeHCeiv7FjD4cO?=
 =?us-ascii?Q?qrelCYGsMgrEg31Ni97JwxPAnjfEv8CN1Qnonb2L4auW96phgvOn2sPGHRw8?=
 =?us-ascii?Q?4PKX2MIGirk3b83RV4TaEDrnb5j4LETvGyYn5nNPlFfODBQK/HwXaKChzaMS?=
 =?us-ascii?Q?KhaD0nT5wczBcXP0itLfPpu2dzVRVamVxKHDVp3Wy6ae++jBJKuoJC1OqXji?=
 =?us-ascii?Q?3r81pyC5zu/rTYm5QS/s+Jp3YhiLryPGWhBSHRdYB5p6n5FRkWlQQF0AydZg?=
 =?us-ascii?Q?fWVLGaS6RR4R+rdWbs2lnZ6z5xdoDV+99nT6CNyx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a45117a-6470-4e90-0f44-08dc21a8ee8c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 15:34:22.3148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/gQEzOuAcvwmuws5+6ibJzzbmKss1Egp/pAHdgxgZKbIkq5Z9tWsBgcdbVLCOFnh5Ulw7LFBK/rN8MVbgWG7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7273
X-OriginatorOrg: intel.com

On Tue, Jan 30, 2024 at 05:32:24PM +0530, Mukesh Ojha wrote:
> 
> 
> On 1/26/2024 8:41 PM, Rodrigo Vivi wrote:
> > The commit 01daccf74832 ("devcoredump : Serialize devcd_del work")
> > introduced the mutex to protect the case where mod_delayed_work
> > could be called before the delayed work even existed.
> > 
> > Instead, we can simply initialize the delayed work before the device
> > is added, so the race condition doesn't exist at first place.
> > 
> > The mutex_unlock is very problematic here. Although mod_delayed_work
> > is async, we have no warranty that the work is not finished before
> > the mutex_unlock(devcd->mutex), and if that happen 'devcd' is used
> > after freed.
> 
> I agree, Mutex is bad and last time there was only a situation of UAF from
> disable_store() and that can not occur as it keeps its ref, so
> we went ahead with the change.,

my concern was with:

flush_delayed_work(&devcd->del_wk);
mutex_unlock(&devcd->mutex);

at devcd_free().

flush_work always wait for the work to finish it's execution,
which will delete the device.
The with the release, the devcd should be gone soon and
this is at risk of the UAF, no?

maybe I'm missing something.


> 
> > 
> > Cc: Mukesh Ojha <quic_mojha@quicinc.com>
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: Jose Souza <jose.souza@intel.com>
> > Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > ---
> >   drivers/base/devcoredump.c | 97 +++-----------------------------------
> >   1 file changed, 6 insertions(+), 91 deletions(-)
> > 
> > diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> > index 678ecc2fa242..0e26b1273920 100644
> > --- a/drivers/base/devcoredump.c
> > +++ b/drivers/base/devcoredump.c
> > @@ -25,47 +25,6 @@ struct devcd_entry {
> >   	struct device devcd_dev;
> >   	void *data;
> >   	size_t datalen;
> > -	/*
> > -	 * Here, mutex is required to serialize the calls to del_wk work between
> > -	 * user/kernel space which happens when devcd is added with device_add()
> > -	 * and that sends uevent to user space. User space reads the uevents,
> > -	 * and calls to devcd_data_write() which try to modify the work which is
> > -	 * not even initialized/queued from devcoredump.
> > -	 *
> > -	 *
> > -	 *
> > -	 *        cpu0(X)                                 cpu1(Y)
> > -	 *
> > -	 *        dev_coredump() uevent sent to user space
> > -	 *        device_add()  ======================> user space process Y reads the
> > -	 *                                              uevents writes to devcd fd
> > -	 *                                              which results into writes to
> > -	 *
> > -	 *                                             devcd_data_write()
> > -	 *                                               mod_delayed_work()
> > -	 *                                                 try_to_grab_pending()
> > -	 *                                                   del_timer()
> > -	 *                                                     debug_assert_init()
> > -	 *       INIT_DELAYED_WORK()
> > -	 *       schedule_delayed_work()
> > -	 *
> > -	 *
> > -	 * Also, mutex alone would not be enough to avoid scheduling of
> > -	 * del_wk work after it get flush from a call to devcd_free()
> > -	 * mentioned as below.
> > -	 *
> > -	 *	disabled_store()
> > -	 *        devcd_free()
> > -	 *          mutex_lock()             devcd_data_write()
> > -	 *          flush_delayed_work()
> > -	 *          mutex_unlock()
> > -	 *                                   mutex_lock()
> > -	 *                                   mod_delayed_work()
> > -	 *                                   mutex_unlock()
> > -	 * So, delete_work flag is required.
> > -	 */
> > -	struct mutex mutex;
> > -	bool delete_work;
> >   	struct module *owner;
> >   	ssize_t (*read)(char *buffer, loff_t offset, size_t count,
> >   			void *data, size_t datalen);
> > @@ -125,13 +84,8 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
> >   	struct device *dev = kobj_to_dev(kobj);
> >   	struct devcd_entry *devcd = dev_to_devcd(dev);
> > -	mutex_lock(&devcd->mutex);
> > -	if (!devcd->delete_work) {
> > -		devcd->delete_work = true;
> > -		mod_delayed_work(system_wq, &devcd->del_wk, 0);
> > -	}
> > -	mutex_unlock(&devcd->mutex);
> > -
> > +	/* This file needs to be closed before devcd can be deleted */
> > +	mod_delayed_work(system_wq, &devcd->del_wk, 0);
> >   	return count;
> >   }
> > @@ -158,12 +112,7 @@ static int devcd_free(struct device *dev, void *data)
> >   {
> >   	struct devcd_entry *devcd = dev_to_devcd(dev);
> > -	mutex_lock(&devcd->mutex);
> > -	if (!devcd->delete_work)
> > -		devcd->delete_work = true;
> > -
> >   	flush_delayed_work(&devcd->del_wk);
> > -	mutex_unlock(&devcd->mutex);
> >   	return 0;
> >   }
> > @@ -173,30 +122,6 @@ static ssize_t disabled_show(const struct class *class, const struct class_attri
> >   	return sysfs_emit(buf, "%d\n", devcd_disabled);
> >   }
> > -/*
> > - *
> > - *	disabled_store()                                	worker()
> > - *	 class_for_each_device(&devcd_class,
> > - *		NULL, NULL, devcd_free)
> > - *         ...
> > - *         ...
> > - *	   while ((dev = class_dev_iter_next(&iter))
> > - *                                                             devcd_del()
> > - *                                                               device_del()
> > - *                                                                 put_device() <- last reference
> > - *             error = fn(dev, data)                           devcd_dev_release()
> > - *             devcd_free(dev, data)                           kfree(devcd)
> > - *             mutex_lock(&devcd->mutex);
> > - *
> > - *
> > - * In the above diagram, It looks like disabled_store() would be racing with parallely
> > - * running devcd_del() and result in memory abort while acquiring devcd->mutex which
> > - * is called after kfree of devcd memory  after dropping its last reference with
> > - * put_device(). However, this will not happens as fn(dev, data) runs
> > - * with its own reference to device via klist_node so it is not its last reference.
> > - * so, above situation would not occur.
> > - */
> > -
> >   static ssize_t disabled_store(const struct class *class, const struct class_attribute *attr,
> >   			      const char *buf, size_t count)
> >   {
> > @@ -308,13 +233,7 @@ static void devcd_remove(void *data)
> >   {
> >   	struct devcd_entry *devcd = data;
> > -	mutex_lock(&devcd->mutex);
> > -	if (!devcd->delete_work) {
> > -		devcd->delete_work = true;
> > -		/* XXX: Cannot flush otherwise the mutex below will hit a UAF */
> > -		mod_delayed_work(system_wq, &devcd->del_wk, 0);
> > -	}
> > -	mutex_unlock(&devcd->mutex);
> > +	flush_delayed_work(&devcd->del_wk);
> >   }
> >   /**
> > @@ -365,16 +284,15 @@ void dev_coredumpm(struct device *dev, struct module *owner,
> >   	devcd->read = read;
> >   	devcd->free = free;
> >   	devcd->failing_dev = get_device(dev);
> > -	devcd->delete_work = false;
> > -	mutex_init(&devcd->mutex);
> >   	device_initialize(&devcd->devcd_dev);
> >   	dev_set_name(&devcd->devcd_dev, "devcd%d",
> >   		     atomic_inc_return(&devcd_count));
> >   	devcd->devcd_dev.class = &devcd_class;
> > -	mutex_lock(&devcd->mutex);
> > +	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
> > +	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
> 
> Last time, we discussed [1] here, involves a assumption
> about timeout can not happen before device_add() succeeds.
> It is rare but it is there.
> 
> https://lore.kernel.org/all/87ilr15ekx.ffs@tglx/

hmm... I couldn't imagine a case where a device_add could
take longer then 5 minutes, at least not without other bigger
problems...

I'm wondering that multiple subsequent calls of dev_coredumpm()
would fail to find the failing_device with the class_find_device
and all, but maybe I'm overthinking here or missing something else.

> 
> -Mukesh
> 
> >   	dev_set_uevent_suppress(&devcd->devcd_dev, true);
> >   	if (device_add(&devcd->devcd_dev))
> >   		goto put_device;
> > @@ -392,15 +310,12 @@ void dev_coredumpm(struct device *dev, struct module *owner,
> >   	dev_set_uevent_suppress(&devcd->devcd_dev, false);
> >   	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
> > -	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
> > -	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
> >   	if (devm_add_action(dev, devcd_remove, devcd))
> >   		dev_warn(dev, "devcoredump managed auto-removal registration failed\n");
> > -	mutex_unlock(&devcd->mutex);
> >   	return;
> >    put_device:
> > +	cancel_delayed_work(&devcd->del_wk);
> >   	put_device(&devcd->devcd_dev);
> > -	mutex_unlock(&devcd->mutex);
> >    put_module:
> >   	module_put(owner);
> >    free:

