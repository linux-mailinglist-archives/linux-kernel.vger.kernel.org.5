Return-Path: <linux-kernel+bounces-10150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E95881D0CB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526331C2180D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 00:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8F2A5A;
	Sat, 23 Dec 2023 00:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eTtYzaD4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E152D7EF;
	Sat, 23 Dec 2023 00:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703291063; x=1734827063;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=830twJ3E1N9j+kWpqdJVqfQw4cnjbZ1ZTefiz7Dt5MQ=;
  b=eTtYzaD4u73bbVIASDZ6er1tGSmPraYEdQ4GpNwZ7TvaOvQJcKb7Ddsr
   SMIU1ywj/W/KdeCfU0oYiL+zjK2zxjdPcprKD6w1hLsCuCIhf0dxCB7sQ
   clA90Bg5uD77Cqy1CyeJgrXrimwO1ATUnr14IPLlnqFVWbxAvH064uGyr
   vz20JUnZ0uLzjCl3z5sj6dyDdXoYoLFh7yCAsqmxA4wmV8J0Pr2B+UZDm
   +RfR/1gcvZCQLL35ovcydGAe+iPr5pk8cFtKEKPq/ItWAfy3gFgdRvC9l
   eJCzT2/fdzn/MlU6Z7wROTPudk7iSRj7grUEgfHRWjmai012152Oelvwy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="9657667"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="9657667"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 16:24:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="25509152"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Dec 2023 16:24:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 16:24:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Dec 2023 16:24:21 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Dec 2023 16:24:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDZsyECMNLH4yUJRW/9x3yhxzOqAAlGUuqM+BiNxrowOa44cxuteFCdVbRfWtbZ1DEP9OZzwEo30gVDA9Pz4kEpxJx38oC/VcS9jgpE8650XDwshiQEvn4pKV82goe4FmNbMxndT+ksWo+3Ec2rvfUnDEzCjayYghXgCBtik4kR4lElTNrC3zCx0jhWszcwQzr2jFmyVYkZZV1EImlzvPDv7MsM9L8pc70597V3K5R0mQq1v43shLE+65m5q0ZbdGdFM7bnXA6dESD1NHOXUeZi9YN7vdSyBnhqVUlIJl84idWpmFSNIVJvTdWY4z+kz79G8JdajiocDuGbT+mMvvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99/gXyjskidpZbIfNpZVsE9iZTde5VT5TXuAOj9TjAA=;
 b=L9TnDubi+dLdxuRxPilPcnmbYUCH477/+Lkh4kzYslw+kmnzX5yqhZR+ZUNf6YBeyFa+p+S+bqubgylpRkfc+ACEN0vHTI5M+OLrn9sI97S3xHPDm5RKEqd2cVlMROquEXRVtJf0Ems/1hZ1ccnarmSCbhSe2CFQ3VWOZWURZ2k5LgpYV66MBoVWsQdwWEFzHtO5tR8Pgle+1RGoHB8vNoMfYTJhQzDRl1SrojMfzFahl+PBFq7yvvRUYDpy1dz4za4acMfvFEjiGR4yvUkCpiPSpwam8Q5hr6VEzG73V3i8X6OinuXduQxnDfdzo43Mo/ZXgTnglP1vunh9Ii5tQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB6761.namprd11.prod.outlook.com (2603:10b6:303:20d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.22; Sat, 23 Dec
 2023 00:24:19 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7113.016; Sat, 23 Dec 2023
 00:24:19 +0000
Date: Fri, 22 Dec 2023 16:24:16 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Coly Li <colyli@suse.de>
CC: Dan Williams <dan.j.williams@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Xiao Ni <xni@redhat.com>, Geliang Tang <geliang.tang@suse.com>, "Hannes
 Reinecke" <hare@suse.de>, NeilBrown <neilb@suse.de>, Vishal L Verma
	<vishal.l.verma@intel.com>, <linux-block@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: Bug in commit aa511ff8218b ("badblocks: switch to the improved
 badblock handling
Message-ID: <658628b098aeb_b31b42945b@iweiny-mobl.notmuch>
References: <6585d5fda5183_9f731294b9@iweiny-mobl.notmuch>
 <6585dc32bebce_ab80829462@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6585dc32bebce_ab80829462@iweiny-mobl.notmuch>
X-ClientProxiedBy: SJ0PR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:a03:332::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a6f887b-435b-4e69-34ec-08dc034d814a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zwFqwaTIvRIdzf1iopUs6bm+zI1AHNPKmqyniLTnCTBbE5OdIXOQsYCDn4xEBZUdG45MtnmTn80mBGhM6B21YYtOsXwmxbReTIIVpnho5qguoF5XQ33sTxbb4CsNK0YDvMxqYYKuv91CiMamPeU/EfuzJpKFKSJDhfMSx8MFCvSUa21I23oHjDpoBfLhW+AjcSxzvHm6dEosh2HS9YOLz+HMInZeq5CoejdPIupkkYBf4Vy7GO7cVF7pzpJJua6lSwwnduYyJQBleA9+tYCCj9kPU4tPFwP1GK59RJbqNcsazOnihJBlfYrgrf+8K7CCBhuouwqB03bcLF8ZBAaEYkryR/6gsRCf4DSY5vx5cd/8+1Zx53PqeTo469PzagKrUcwecwy0XvuNmIfxZgHKi3MS2YS4cPOH/KWSkpzNhD0IWpgwQi/mGn/JY3AjhkOWe394jzjTfbvwEk0y/aWoUE81F1DMykgeRibGceGwP1jsqaJVE4VkThRFsuZxwXnThjHIG+SQ1Swje1x1IrpwOxlAbO8J/1y+aT5SkD6SeGXzSVVsDxCDDOAGRP6lUKLj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6486002)(6666004)(478600001)(316002)(54906003)(110136005)(8936002)(8676002)(66946007)(66476007)(66556008)(83380400001)(9686003)(6512007)(6506007)(26005)(5660300002)(2906002)(44832011)(4326008)(41300700001)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6j7/cO2qYyEEBTnmT4BJ+Y3/Gi2eWflzs9WJr+YAyVwE3Oo8xwULQGxX6ood?=
 =?us-ascii?Q?dQUnZxRn5huvbWT5nhdAqjUwS1S7w5fqZ+gTRTNy9h26d9nTgj1OprJ3ys5l?=
 =?us-ascii?Q?c9mOomGAEDyOvcRAF8lK2FMhmCFIayHddRLhRWwAmSYKRjunzJdSYc5WOrKS?=
 =?us-ascii?Q?7cBRvl8T97zWKf7cztgA0k3RAUcFfdL0y1T3dSQJ2HLWJG3HXVZdWnVzdFlp?=
 =?us-ascii?Q?Am4vbyrgQ/MeivwHCQdVsnvRLmwmRkwUZz62EJgg/kyJ4SPyLKZ//SJE8zpU?=
 =?us-ascii?Q?6ivuYxz2+PRK9PdaklAmTIBOLjrWUjrcPTKok7FcTjA2H26PkMC0gYC4MbiF?=
 =?us-ascii?Q?NTgb7ohfZI9WuTITVp+7bDJQJ9NC8CBOsjrI4cFTOJy3vkOiUwVtAbuw/n1P?=
 =?us-ascii?Q?tygxz1Btif90xDlue2i5iLMN+IM/jUIGrbWkoYeDpuH0w+eA6u1SYU9mHato?=
 =?us-ascii?Q?KON3cZIgxmMmPvBjpnx4cX3rkcKk0Xg5wsq/p1dG4rKxWGbc3rkrsSlmFBmp?=
 =?us-ascii?Q?gewFfIVO6I+WwQRQFyyxibZMtHst1haEDf33RTfROH0lDIIByoB9McUHqbZ6?=
 =?us-ascii?Q?zS8Bg+d9EGdAEdpzpg5CcrUj+YgpNQk5Sg+pFieajfCT4RDOBsU94XFrHMiF?=
 =?us-ascii?Q?Vz0wzB3pEqa8H5QF9jN1ODDIKwAnjO/oKp6dPfBnxe5C/jfyeg3tLGYysb0D?=
 =?us-ascii?Q?HON5P6pSdYTmIcUd9i2dKjD6K9egFxI9VyR6HmAXiq3Czw23wPsG9u8agch1?=
 =?us-ascii?Q?57DdOSojOK8xxjz7e3a8pMkHyIiSe6D9p0i+h7ZH/HkB2SopmBpZsnCuv+JQ?=
 =?us-ascii?Q?F7sXtpbrPrNWtUCvSJ+OFt+kQPJ6jrry6O4JVm6C212awDERJPkiFZoeM1hW?=
 =?us-ascii?Q?Ym0d8lGCvP1migB7G6FDCAj+VDGIoxvXVtqdAPAanZSlVdIghLxY240Slr7i?=
 =?us-ascii?Q?h+mvBvND6TL4urU3gZflq1zxH4GvZs+rIJRC8NEvk99XeqFi5QUaWR9njvPe?=
 =?us-ascii?Q?tVfwSBLbpMxJftrTBmZQu/KOpCuieYAujYt4Wqu6d/5Cxyq2aZRGjVZWQijt?=
 =?us-ascii?Q?OSKzCTjbw8irOAYoJL9klG0XYDqwBYSgqQRVVKqhfL0/itdewnZ0LWkMsGDc?=
 =?us-ascii?Q?lSvZgC1XOw2vYGsE4kTeKBe1g6BZ76iadXFUInSc0BL0oUZ5M9/wY9tgLEDr?=
 =?us-ascii?Q?fN3Wb6rkZEKVxC7M/+UynuhoyUNu9Z+4CDxrSeWIxDfsdw+R71LT3GJeOJyE?=
 =?us-ascii?Q?JStbUa/oC/067+/yC35vdHsgVU3IArF3i/D6lQX9rYgD7HyEthjAVrkSfvbS?=
 =?us-ascii?Q?vy8QWuofiZ/Qp1Lfarh7xVQqdhbbxBS6/i3LRq9d2vV7njS8rdPbCXXSchvd?=
 =?us-ascii?Q?ProOEohJiWFN3EBLMm/7hELFMcjSr6OXgBQeKkIhi8LdWZ8ynxtw031aCBlw?=
 =?us-ascii?Q?rU6Zj/Ku4xgyZkMbpkoHtxKrGFf/hVXMhq5H+iBnxq+tXW9FUAFLmsE9uVEC?=
 =?us-ascii?Q?HbfNYJZaxDvSYZjeZxv0KmBumSkDxDmT5muWUjfeKD2gj1y39e4rdUnKB7Lj?=
 =?us-ascii?Q?SsqvnXnJ34VuncTXBYX406LbcqLe8QXLsqxBmj11?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6f887b-435b-4e69-34ec-08dc034d814a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2023 00:24:19.7768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1umtiVxbfu8QWcf0bXNqByALUF629UAxK3zFwz6eY2Diq6z9fWNPOLlLDz3lZVeLwozUIJU+zV7aC0eHD7NIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6761
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Ira Weiny wrote:
> > Coly,
> > 
> > Yesterday I noticed that a few of our nvdimm tests were failing.  I bisected
> > the problem to the following commit.
> > 
> > aa511ff8218b ("badblocks: switch to the improved badblock handling code") 
> > 
> > Reverting this patch fixed our tests.
> > 

[snip]

I added some prints[1] to try and see what is happening.  Perhaps this will
help you.

...
[   99.919237] IKW set_badblock 00000000aa44c55d 8000 1
[   99.921448] IKW set_badblock 00000000aa44c55d 8001 1
[   99.924051] IKW set_badblock 00000000aa44c55d 8002 1
[   99.926135] IKW set_badblock 00000000aa44c55d 8003 1
[   99.928516] IKW set_badblock 00000000aa44c55d 8004 1
[   99.930491] IKW set_badblock 00000000aa44c55d 8005 1
[   99.932894] IKW set_badblock 00000000aa44c55d 8006 1
[   99.936638] IKW set_badblock 00000000aa44c55d 8007 1
[  100.999297] IKW _badblocks_check() 00000000aa44c55d s 8000 num 1
[  101.000027]    IKW table count 1 shift 0
[  101.000644]    IKW 0: off 8000 end 8008
[  101.001271]    IKW prev 0, cnt 1
[  101.002481]    IKW start 8000, len 1
[  101.003464]    IKW front overlap 0
[  101.004256] IKW rv 1

...            ^^^^^^^^^
<This is a valid failure as part of the test>
...

[  101.148783] IKW set_badblock 00000000721b4f3d 8000 1
[  101.150629] IKW set_badblock 00000000721b4f3d 8001 1
[  101.152315] IKW set_badblock 00000000721b4f3d 8002 1
[  101.154544] IKW set_badblock 00000000721b4f3d 8003 1
[  101.156238] IKW set_badblock 00000000721b4f3d 8004 1
[  101.158310] IKW set_badblock 00000000721b4f3d 8005 1
[  101.160196] IKW set_badblock 00000000721b4f3d 8006 1
[  101.162158] IKW set_badblock 00000000721b4f3d 8007 1
[  101.163543] IKW _badblocks_check() 00000000721b4f3d s 0 num 8
[  101.164427]    IKW table count 1 shift 0
[  101.165310]    IKW 0: off 8000 end 8008
[  101.166398]    IKW prev -1, cnt 1
[  101.167178]    IKW start 0, len 8
[  101.168107] IKW rv 0
[  101.168858] IKW _badblocks_check() 00000000721b4f3d s 8 num 8
[  101.169814]    IKW table count 1 shift 0
[  101.170547]    IKW 0: off 8000 end 8008
[  101.171238]    IKW prev -1, cnt 1
[  101.171985]    IKW start 8, len 8
[  101.173007]    IKW front overlap -1  <== this is prev which is used to index bb->pages
[  101.174157]    IKW prev -1, cnt 1
[  101.175268]    IKW start 9, len 7
[  101.176557] IKW rv -1

...            ^^^^^^^^^
This is where the failure occurs.
...

I think overlap_front() is not working correctly in this case.  And from
my reading of the code I don't know how it would.  But overlap_front() is
used elsewhere and I'm not confident in making the change.

Hope this helps,
Ira


[1]
diff --git a/block/badblocks.c b/block/badblocks.c
index fc92d4e18aa3..21e22ee576e5 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -1280,6 +1280,16 @@ static int _badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 	unsigned int seq;
 	int len, rv;
 	u64 *p;
+	int i;
+
+	printk(KERN_CRIT "IKW %s() %p s %llx num %d\n", __func__,
+		bb, s, sectors);
+
+	printk(KERN_CRIT "   IKW table count %d shift %d\n", bb->count, bb->shift);
+	for (i = 0; i < bb->count; i++) {
+		printk(KERN_CRIT "   IKW %d: off %llx end %llx\n", i,
+			BB_OFFSET(bb->page[i]), BB_END(bb->page[i]));
+	}
 
 	WARN_ON(bb->shift < 0 || sectors == 0);
 
@@ -1311,6 +1321,9 @@ static int _badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 
 	prev = prev_badblocks(bb, &bad, hint);
 
+	printk(KERN_CRIT "   IKW prev %d, cnt %d\n", prev, bb->count);
+	printk(KERN_CRIT "   IKW start %llx, len %llx\n", bad.start, bad.len);
+
 	/* start after all badblocks */
 	if ((prev + 1) >= bb->count && !overlap_front(bb, prev, &bad)) {
 		len = sectors;
@@ -1318,6 +1331,7 @@ static int _badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 	}
 
 	if (overlap_front(bb, prev, &bad)) {
+		printk(KERN_CRIT "   IKW front overlap %d\n", prev);
 		if (BB_ACK(p[prev]))
 			acked_badblocks++;
 		else
@@ -1365,6 +1379,7 @@ static int _badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 	if (read_seqretry(&bb->lock, seq))
 		goto retry;
 
+	printk(KERN_CRIT "IKW rv %d\n", rv);
 	return rv;
 }
 
diff --git a/drivers/nvdimm/badrange.c b/drivers/nvdimm/badrange.c
index a002ea6fdd84..93ffd189bc75 100644
--- a/drivers/nvdimm/badrange.c
+++ b/drivers/nvdimm/badrange.c
@@ -167,6 +167,7 @@ static void set_badblock(struct badblocks *bb, sector_t s, int num)
 	dev_dbg(bb->dev, "Found a bad range (0x%llx, 0x%llx)\n",
 			(u64) s * 512, (u64) num * 512);
 	/* this isn't an error as the hardware will still throw an exception */
+	printk(KERN_CRIT "IKW %s %p %llx %x\n", __func__, bb, s, num);
 	if (badblocks_set(bb, s, num, 1))
 		dev_info_once(bb->dev, "%s: failed for sector %llx\n",
 				__func__, (u64) s);

