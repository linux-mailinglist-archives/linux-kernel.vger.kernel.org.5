Return-Path: <linux-kernel+bounces-10506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4147481D537
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 18:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FC57B21ECB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 17:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28DA125C7;
	Sat, 23 Dec 2023 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1Ju2Up8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F1C10962;
	Sat, 23 Dec 2023 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703351604; x=1734887604;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CDoCJeIf9jCufTpnAxR9zyScj030J78uDwGHMHIwaG4=;
  b=h1Ju2Up8jVhevdPN64Lyrxt/E1DmwTeFQ12wzIsyNVN+EFk4twj0RIXo
   Q246n78flj7XtFn7mdhhZjf0lcLsTHyYjJFglF/gx6rqHKZX1Bjt5gl9r
   8QpnGIDbhqpUuvzT1Lo3ke4BNKA2P3e6n6fj0Fmn2NCBUj7wg0D2WxIae
   kBovbFFK2JmiKaE4yoHji5gUHdxiTq8ndPGvuNF3UoGpYkdWOyE608s8H
   ZgrZePBh3AUTL/s8PENKvZyF3BeXQfyMzlIooTZ4uqlBK4DxmoMQ1YN3U
   MsWhiNjnBazd42RTAZHgNUuXLF7lIXw7dM7QvHhUgfdOP1XpXFuwUauYk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="460532752"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="460532752"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 09:13:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="843300277"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="843300277"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Dec 2023 09:13:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 23 Dec 2023 09:13:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 23 Dec 2023 09:13:23 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 23 Dec 2023 09:13:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zei/nlGcpZ9cAzxyHmylYgUpRMJ3aBwz9LqCULU80kaeLczR0axkc1Zz7chFBaAOXFyY9ib075ABogIkXGNCuz/NwezGhENnLinaKkjlqA2Rbu5BIXzGdPbOqcv8LSGeFYc0+bE7HMAg7VOvtv6J5qnVpHsBLYzLhL41HY99vOfihsu77KmtBq9IQh3d/aACoO21MrKWBuCsV3r5E7M1oIWGaa5IdK09tDdseErk6x6SUc2E/syaJeDnJGi/a9zbXDikwHjCnirTnlsY5eJ3I4lJTXDV+v9JUFIpLYrCnu2bNDwHtK9TOeH0/1+q7RvKNVZgqoeLV100GdKsBgj5kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h82NQOsqRO1cXfGofPu74sSIylroYtGL+c9TygsUu/s=;
 b=iJjD8ZJKyIZhJcJZeQI7QaQv/hX3nXWDOs/ZprEQcFEJBecDCSa1FC0TK4qqzr1OoZ6dJTpaCRfHxMkaqJXv1qcz4t1abBa2XWQ8dgUpOizSBNys4eREVXy08eQozvCHPsMW4WoG5OberQ4szwwXCaKp7scUijVHSOB9PZwBXylHXs0oGbiqHQCIjDsW0nMJiefZv+O3tJgQkWyszh/3Z8wCo6OK06GRZ7Q/GFkj3dYUNesHR9BgwaJLkqJowok91oB1gzqBT+nEZ/n0HKul4wrgYHYnUDlLsnVwpA5zDXt5VZddz6+VRH0keuHyRyUXw+WF8MK/AD9o1PMcgh8N/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN0PR11MB6253.namprd11.prod.outlook.com (2603:10b6:208:3c6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24; Sat, 23 Dec
 2023 17:13:19 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7113.023; Sat, 23 Dec 2023
 17:13:19 +0000
Date: Sat, 23 Dec 2023 09:13:15 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Coly Li <colyli@suse.de>, Ira Weiny <ira.weiny@intel.com>,
	<linan666@huaweicloud.com>
CC: Dan Williams <dan.j.williams@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Xiao Ni <xni@redhat.com>, Geliang Tang <geliang.tang@suse.com>, "Hannes
 Reinecke" <hare@suse.de>, NeilBrown <neilb@suse.de>, Vishal L Verma
	<vishal.l.verma@intel.com>, <linux-block@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: Bug in commit aa511ff8218b ("badblocks: switch to the improved
 badblock handling
Message-ID: <6587152b64d9f_c579e29437@iweiny-mobl.notmuch>
References: <6585d5fda5183_9f731294b9@iweiny-mobl.notmuch>
 <6585dc32bebce_ab80829462@iweiny-mobl.notmuch>
 <658628b098aeb_b31b42945b@iweiny-mobl.notmuch>
 <nhza4xsnbmcmka7463jxgmdvb27pqvbvcuzs7xp4vzpqlo262d@dp7laevqtaka>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <nhza4xsnbmcmka7463jxgmdvb27pqvbvcuzs7xp4vzpqlo262d@dp7laevqtaka>
X-ClientProxiedBy: BYAPR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN0PR11MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: b8d10511-7954-4f30-4198-08dc03da754a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WzWMJsdhDfFqfNiqsHQTVEoVTpLAwKIzJsKWnZSjh3I1kyyaew9qRtOEGMCx5ZuOJHHLNsYiRjqE2XQgUQdsw0nqMoPpB9fML2USv5QpBzt4YA2CIZQY7HwSID3NraeNwJVCFiG6p9i+Gb0BNKUAL3ZQFBOwXYArrj6PWA95ExA69Z9h5ByyepnAPGh+reIcTlZ3kngA+suXp8EDN/9lPMIOdwInW86zhWOLm0o0pZJJnxtYL7TyixVR89IFAjM55nUOZSQBpzncXsaKgKAdJK+kgydkWKZRxsZT5SMUbA5VaZC6q4iTEPzZUxhjeagwlusFsfEZy05MP2AE/jGN/lzg4YDTBC/zagjMyonoNTHafzF+OUKMpqvWl4S/xOyejItcIEW08X4+lPndBFrUYIHufziOLv91+vfbGtJvpam8AxCxEWwXd0dW3bibJ60L/xfMJOKQtiBeuUHxng/ap3+yqc48EGXqzPSKacvh1ZFywMPpky0P4bKfC96ouRMNeNoff37fI/bae02e+/zr3ZSTlXl4j72uy602YTh2Ro8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82960400001)(38100700002)(41300700001)(83380400001)(86362001)(66946007)(66556008)(66476007)(110136005)(316002)(54906003)(4326008)(8936002)(8676002)(44832011)(6486002)(7416002)(5660300002)(9686003)(6512007)(26005)(6666004)(6506007)(966005)(2906002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u66zOj1n85vwnGMy0dko2blN9YWhG+S3tU5MjOs2+gle76+uotI5fKvuE8RT?=
 =?us-ascii?Q?JeRGTuK9wlYTT6LGvtfWS34lEFqWv7X2WlTrCvGdWgGAQFOIrs5wCb5Wg8Z+?=
 =?us-ascii?Q?Riwdp0oTUodCyKKEI+2hnmHZXaljEJ5VDJI9FCAFyGDvbZ4pztIEn96zxLfP?=
 =?us-ascii?Q?xM4pIOqBLb+kNypdFf/GDIZVfc5y+6SgAIJM1z2OF1iMbwdD5I6p7wv972aP?=
 =?us-ascii?Q?MDD/ZNWvwbR/qMY17arjxaGRjKRwrAw5tUqNwu3OnpzFwThS4ucZ5EdLc5aS?=
 =?us-ascii?Q?16346PQ2NP82s0Pp7z1MsJ0lcvu0zPkvF6zcI4ObR5DgmtwwjIr5mt6IoQkt?=
 =?us-ascii?Q?rwkejXunXfMBuv6mbJSpWLdnkWxj5iB9FkF37zUyYItYgLxJF2djQ0mBTBvn?=
 =?us-ascii?Q?k7UzTGg/i0GRkiuMtzGeRxjFZbxoH1E+yMM+3CL6xNcCmT7IFv2jCpL+Nvk4?=
 =?us-ascii?Q?PXcwYumY3MET1ABICBh9Dl9aRfd4nZV+yB5bRDM8OFjQED9EVmhO7609X/rm?=
 =?us-ascii?Q?oiCRrYuO3GL8glqjQC/eF4aB2sgbkUqGHz8REqqjFhXcHd8/01EJ3sanFFCa?=
 =?us-ascii?Q?biGeQyivoIhYjFw6PSIzZMhJrHFtrxgFHjOMFNrB6vmOoR1RnC+/gW6aQkLC?=
 =?us-ascii?Q?cdhJmQdVlWevQsrtSmMgOhK78KfW5/lD5MQizIt2GIxBsDtTshcVtUjPfvmq?=
 =?us-ascii?Q?Zm9lOiPRiDbccyu53C7/Ea22FsC7xYQtPuvOyRJqlmFyfUT2ZLBabVV4nB4m?=
 =?us-ascii?Q?aPeAgAdmDJD+6e2MqiBfHK6laMoq9ByArcsk579AnVvOfWWUB/k9yVK8Z9SR?=
 =?us-ascii?Q?Nr/jqcArn1Jp+h2kcCzC6MeBORCB1VZYT9RgdneluaC0NM3l1OHyRuxMZpId?=
 =?us-ascii?Q?Kej8i+vdMEdV35htZ6ozYPb2oNeR3quF+QFKip37GeFUMJ3s2T5EFwg2ULUJ?=
 =?us-ascii?Q?D2/cQXIG5RXaeVMKgsoDFnANyGf2f/MXpFd4LU34T7XDx1bwyT65Sk48D2ri?=
 =?us-ascii?Q?npFt4+e4F9i16gKEozXTfBY/99A+b54fmHAMhI4L76KHrfopQottGauW3sIB?=
 =?us-ascii?Q?8keKjjtdS2pZU7aO0dhqFSr+4F0w9PBs8P8cUAj75E8HjbE0o2iGEPRgCjHy?=
 =?us-ascii?Q?yEI529qyDZQpfZdMdkZ/4x4ViXZM2a2qt8CKmF+TNarxlKuMsq3ftcdmDjDB?=
 =?us-ascii?Q?GE/PDQFP+GP/BuaKw69mwcaGoSI7DBdmWmiCV1vZqsU/LcFyranUT8xKz/j5?=
 =?us-ascii?Q?bCji+1gs3s/X1lpxzKJtXWPjz2I0n59ulYBetaFOL9ZC8Q68cabiXpEzcFC4?=
 =?us-ascii?Q?0VCZ9nhttGNfuk21Mu2SV3EjZns/R1m1mgp7z4G2Gwum8US2rTB1fdDDuZED?=
 =?us-ascii?Q?OlEpdtGKeCG5/eOCsmOP1KVdYb6yyN5NGROJSPSLAV+nZrCqU8UBMKBDua7X?=
 =?us-ascii?Q?a0KKSUWNwh1iW9p9YEDH58tav4Zf46l3OCsQZPa7kdU6almLnrrJXKi0KYy/?=
 =?us-ascii?Q?ox08yCe3iVS7rzTsZmlOwea4z/YJYU4bPTNPjhZLRMpqHaheCl/78N2T5zMO?=
 =?us-ascii?Q?ydUgUnR0xaB8FW6HDhyVKd+KwMT8v0ChyxZDdzty?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d10511-7954-4f30-4198-08dc03da754a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2023 17:13:18.7794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGU4MnM+bflgwnoqJiG9hkgZQ0TvedFne7XgjZfJZH38H5+iLcb3NB8ndYEuQxnqp/Xj+PIIsPl1Mec1Zq/8Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6253
X-OriginatorOrg: intel.com

Coly Li wrote:

[snip]

> 
> Hi Ira,
> 
> The above information is accurate and very helpful, thank you!
> 
> From __badblocks_check(), the problematic code block is,
> 1303 re_check:
> 1304         bad.start = s;
> 1305         bad.len = sectors;
> 1306
> 1307         if (badblocks_empty(bb)) {
> 1308                 len = sectors;
> 1309                 goto update_sectors;
> 1310         }
> 1311
> 1312         prev = prev_badblocks(bb, &bad, hint);
> 1313
> 1314         /* start after all badblocks */
> 1315         if ((prev + 1) >= bb->count && !overlap_front(bb, prev, &bad)) {
> 1316                 len = sectors;
> 1317                 goto update_sectors;
> 1318         }
> 1319
> 1320         if (overlap_front(bb, prev, &bad)) {
> 1321                 if (BB_ACK(p[prev]))
> 1322                         acked_badblocks++;
> 1323                 else
> 1324                         unacked_badblocks++;
> 1325
> 1326                 if (BB_END(p[prev]) >= (s + sectors))
> 1327                         len = sectors;
> 1328                 else
> 1329                         len = BB_END(p[prev]) - s;
> 1330
> 1331                 if (set == 0) {
> 1332                         *first_bad = BB_OFFSET(p[prev]);
> 1333                         *bad_sectors = BB_LEN(p[prev]);
> 1334                         set = 1;
> 1335                 }
> 1336                 goto update_sectors;
> 1337         }
> 1338
> 1339         /* Not front overlap, but behind overlap */
> 1340         if ((prev + 1) < bb->count && overlap_behind(bb, &bad, prev + 1)) {
> 1341                 len = BB_OFFSET(p[prev + 1]) - bad.start;
> 1342                 hint = prev + 1;
> 1343                 goto update_sectors;
> 1344         }
> 1345
> 1346         /* not cover any badblocks range in the table */
> 1347         len = sectors;
> 1348
> 1349 update_sectors:
> 
> If the checking range is before all badblocks records in the badblocks table,
> value -1 is returned from prev_badblock(). Code blocks between line 1314 and
> line 1337 doesn't hanle the implicit '-1' value properly. Then counter
> unacked_badblocks is increased at line 1324 mistakenly.
> 
> So the value prev should be checked and make sure '>= 0' before comparing
> the checking range with a badblock record returned by prev_badblocks(). Other
> wise it dones't make sense.
> 
> For badblocks_set() and badblocks_clear(), 'prev < 0' is explicitly checked,
> value '-1' doesn't go though into following code.
> 
> Could you please apply and try the attached patch? Hope it may help a bit.
> 
> And now it is weekend time, you may be out of office and not able to access
> the testing hardware. I will do more testing from myside and update more info
> if necessary.
> 
> Thanks for the report and debug!
> 
> Coly Li
> 
> [debug patch snipped]

This debug patch does fix our tests.  Thanks!

But Nan has submitted a series to fix this as well.[1]

I'm going to test his series as well.

Thanks!
Ira

[1] https://lore.kernel.org/linux-block/20231223063728.3229446-1-linan666@huaweicloud.com/

