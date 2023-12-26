Return-Path: <linux-kernel+bounces-11387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BDC81E57D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 07:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731FE1F22433
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909A14C3C2;
	Tue, 26 Dec 2023 06:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUcpsi58"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF6A4C3A0;
	Tue, 26 Dec 2023 06:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703571858; x=1735107858;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=2nmY0fHbXWLh/8g2gRsTBJ0rdsA6MqAjgsGtLXOduRA=;
  b=lUcpsi58bjjuSCXWAB69sRXNX22+48/x6Vk0145aBt9s67B3VbRgfge9
   46RoTeJXGMQk2Yv3eqHfjISS/6Y0KvAveE/o9EFcjCzei2V+4fVKgkQU/
   mZC05/ZKScNbTXDtOmu75GykmAKMxaVTG2/I76RhSnEdKSvOBQTDcQLSh
   5t+A3En4WfUDkfNayPSMgRif5ou8inoWu1pQtLtjz++755wLCrg/Cfqo6
   +1krojESIBSyKYxez3gu0jryf3yMJJaYqzsOyiZm3Tw+0W+DA+dk1JNOi
   xVWF2Xm0Al8Yg5qxMbsiqZ49CM2n40lB0b/vpQWDLV57jLXBp7ZBnmtv2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="427492109"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="427492109"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 22:24:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="771097282"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="771097282"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Dec 2023 22:24:16 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 22:24:16 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 22:24:15 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Dec 2023 22:24:15 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Dec 2023 22:24:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbc4HMqxACeCe0iKGv6mbrSc6MuCPKcb7nb1rxu9FbJVVfjuR+Dx8kOwdwGZ3jiOukfb2YypR6eSKgUA6tlytDIyNbwjcorbe/Buyu8CBRmx+h9cMhMuI89AIEk5no94iVgy7djtZSZXS/BaIIJqXT82wUF9zMRnjJJpEEF8/tdziWtzGAxGw26H1oePfRLBH1S77UJWURgJ848BCX5LvzYwRF56v8TaD3O6+rdkmuOg56cnZ8S8LXxVVompYQvktVWc5s1RZef6obQrlgBTmEsvyUq8SQu/mzJhO41yfT/ihRna0gOFhTxcGyafVR+tWoCokKhNEi3BlFpQhxT+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEXS9G2CzEBnKk87YtebZBEclmyDCnoLvpFix2zWKao=;
 b=ATHKaXQoklDwD5QaOFWOheFa9j1P8LYCN6teCmSlCYeySUR95oX/9kEAyCSfvVFJCz7f+YuTySGmZZ040+wp97fsAAA96FjAgQWkMWRa29kv62RqSfr56R5X0eaqkyezOPITY7RrVCLw8VJqSdjH/9o9b+XcSag4PCPgf0Lzv2KbM5LiOeItt8ZZTHQsOudU6qHpFUR9KWtS8kRiXUw2G4BFUgZaMOwZVD1Yk2TIlnmcFQUU91FAU8H76rce09EODaaEPSIN+tUJdK+hXe8/fNoHEOAGRXzTt7sbtL9r/xpjHBLl4m0aiCQrbP9L8T8fhXYwPptfpJ5pfaFphU4h1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB7667.namprd11.prod.outlook.com (2603:10b6:806:32a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Tue, 26 Dec
 2023 06:24:13 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 06:24:13 +0000
Date: Tue, 26 Dec 2023 14:24:02 +0800
From: kernel test robot <oliver.sang@intel.com>
To: <linan666@huaweicloud.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-raid@vger.kernel.org>,
	<song@kernel.org>, <zlliu@suse.com>, <neilb@suse.com>, <shli@fb.com>,
	<linux-kernel@vger.kernel.org>, <linan666@huaweicloud.com>,
	<yukuai3@huawei.com>, <yi.zhang@huawei.com>, <houtao1@huawei.com>,
	<yangerkun@huawei.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH] md: Don't clear MD_CLOSING when the raid is about to stop
Message-ID: <202312261217.c5597bdf-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231211081714.1923567-1-linan666@huaweicloud.com>
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: fee76204-498a-4168-845a-08dc05db4761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Bn1vlz7ajLQpfqahc2UWU0BmdRK7G9ow2kMa0kIRxAytuRdO3jZsJKCJ+Q1F5ZQkqKkrDG20Alskb8gvbsYOOQlFQ91pO3mZABvgqH4tixoHPR1J2hr9cgEqMYy4OOm7yUC964BUf6Xs7HhvU+WVnVnZ4JPD0cJvPtgPtLqoeZDIFMLLSppSPF0SbIGk9Fdj0E/6bKA0iDGDNrVHmzbYL0xpX5fJ/05GcAeHm+xefhiK6hRSIl2YRBPtXyrvdpvQbJLafsKQmsG/teQVbcsq6IvI8mXeXHLSj8WnCYaUmYMCqLsmVQss6GIfPfapuL9V19pW9Pk77WHAkLZDlFVWCH+6KUw2M3fl5uFrzEqKOihA3MwV4BMLb3T0r2gII3fnXx5qlkESweRzZk9j7CqmghFU0bR8XFeMwroAeAG0zqDjuReUhh03KpBW+3mPrmkFXv9lUXKpCsqlNv3llF7vD2IdlPU0MbuL7IJ8YaCJNvpCMDw1ogYShzwxeVnKQcrL/OBB3CSfdi9fDGb0KAuVNB9y1o2pKgwByHg+Ncw0YokrqiK6V0UQFlsn81kC/fRoVzC5MJnwDXnjz/iwrNYtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(1076003)(2616005)(107886003)(86362001)(6506007)(6512007)(478600001)(83380400001)(4326008)(8936002)(8676002)(7416002)(5660300002)(6486002)(6666004)(6916009)(66556008)(316002)(66946007)(38100700002)(82960400001)(966005)(66476007)(41300700001)(36756003)(4001150100001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d0WsrARLdafETkvjuZgF4+7gAWAGQZMhwZV2TRJTNO+Hc7Uqmab1AHOIhMhI?=
 =?us-ascii?Q?J1j5haYb+OG+i5SjUZ+4iB8b16+B7D4VL0k9T+YWjfsUhDgRWAItLESkMSUR?=
 =?us-ascii?Q?GqkBxAdLTFEMIhWPpNnmbEUNg5m7NDtmBL7ktKSQE/57wTWaDDoAwtHFhpD9?=
 =?us-ascii?Q?b/MSRD4YmRMVKDjB3CQn2zMbZv6HZr5Cs92X8Es+KEt5ZZV/XyAbMX9RdOKB?=
 =?us-ascii?Q?PkCBDbWmupwGSebidvdsz3bRUjcwjOIlLOJ0QSJAkDtySvwGurx44VWog1cf?=
 =?us-ascii?Q?Liaa7dbG+NaT0U3xX7HSFaSoTztJmVHVjeBrMvD/HXl5wjKhrfBTJs9whkAo?=
 =?us-ascii?Q?vrKMz/j3NfhxrxzoxRODyMzT025W7BELOgQkZnI/raEGKMlHeHctOp7xKDtb?=
 =?us-ascii?Q?NBPmhhorkAVyQ56qrDwgp5J2av/TrbnJ/gdKdaZT54zWGwTqaewWcntxVlXZ?=
 =?us-ascii?Q?Xxq70hQz02XRZSHIQt8zV7FLY2IDPAgcgv+TFLL9BNLlrayTKXv9tnJ+LY3D?=
 =?us-ascii?Q?Be/PLUHCzJ4v7V/dC/7Q1KvVGTUcqMwufP/Iaga8D6O5p/kSBFTvfMqOfklU?=
 =?us-ascii?Q?dPnw/w68wltiFcQ7XUt81EdsHs4pmZE+jwE7SuNKmL30+wzqJZciFnc61lr/?=
 =?us-ascii?Q?gesJ+5s0XO739fVsfPeXqGCMMPXSyZH7CvEflDotB4mzR6SOtueJz2Lp8LLN?=
 =?us-ascii?Q?nv2Hh5RON8z1t5shEDuY91oZRgTCs1UqnBU4YVRCjAYn0Jjcn+aEZKpLBcgo?=
 =?us-ascii?Q?0/9MA/xPNChQER8Kb4dpyzLAfNZS2cwC08JTK3/Z/GNRhhZQ7ZqtLDJHPCUG?=
 =?us-ascii?Q?Wbb0bkw/kvGeNyOVGEvGdUnOo2BHJQ2cnPN2hk9Cub7ubW7SgbPBkdFk6t6d?=
 =?us-ascii?Q?wWjqxDrWdM3ebZgRgJxYfZ56vOX0a2ghI51rJ4chOVr9C3JEXr8Ok4H0TPA/?=
 =?us-ascii?Q?WmBFScqxhnGeLwM2SQbit1MgwrgIqbvovHmvx+eC+LmY+Z54US9r8y2mTMx9?=
 =?us-ascii?Q?41olwayrtW+ZJJeg7mR+Ul6iAe1YoGSlNqHcU+MrSvIQ8l0mwvX113iR2r7D?=
 =?us-ascii?Q?P+UT9T6jwjz7fv5+2ZfRPs/fU1bhRxaTmmHUFqPUe6mXeJkFWbcjxgw3Ewcn?=
 =?us-ascii?Q?2qM9qS3BlpPul5PCDRURtS/1p2CG7ne7uX/0jWxr9q9oB2wHJ1Q/SsRXqQnW?=
 =?us-ascii?Q?qxsrKUX5Tsxplyl9d5RhyB9aYKGOArc284IjWCUWIOt3UbWQ3ZNTexXksLb4?=
 =?us-ascii?Q?X1CLQJSLWF6ssLpLnjMEqgB5aP1A4qMPhTIuE+kBTnXEbkyjWrYfi39Ihw7F?=
 =?us-ascii?Q?qUmxFTH2OufPeEHlUjGM42Ku8jLemhb/WhAKtx8lgtCpiSPMUWUDHNua+tlo?=
 =?us-ascii?Q?p7rFWBjaGDB0KmzM2GTgg7A6mB7VXRoBqTqJuDdnG1/bnA/f0++gmB8wO8Ov?=
 =?us-ascii?Q?CQzX8gtJbVw38HmpjmR0JP0OJjzBacZMBtQ/0ctfTT9zKVL8gFmQvMwj4l5U?=
 =?us-ascii?Q?QSSuYfhDAX2BAEJvpJEfczhUrqr9g8aC8O3GrtYcpdxxVcoSGhdIf4jGvh4R?=
 =?us-ascii?Q?PsL8cnWksAk3j1fvs06Yv2/SnyGKQJayeiQek6KT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fee76204-498a-4168-845a-08dc05db4761
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 06:24:13.4152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQUqJMd/kP2L2UzvxjqLSey1F0R2iX+tVIEu96fD6P82M7o40e25Gh6JSoKQvh2z6tVSeJDmrR7hZc1sudfO+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7667
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "mdadm-selftests.06name.fail" on:

commit: 4d060913335fad6f1d1f0816859c20aae823851c ("[PATCH] md: Don't clear MD_CLOSING when the raid is about to stop")
url: https://github.com/intel-lab-lkp/linux/commits/linan666-huaweicloud-com/md-Don-t-clear-MD_CLOSING-when-the-raid-is-about-to-stop/20231211-162010
base: git://git.kernel.org/cgit/linux/kernel/git/song/md.git md-next
patch link: https://lore.kernel.org/all/20231211081714.1923567-1-linan666@huaweicloud.com/
patch subject: [PATCH] md: Don't clear MD_CLOSING when the raid is about to stop

in testcase: mdadm-selftests
version: mdadm-selftests-x86_64-5f41845-1_20220826
with following parameters:

	disk: 1HDD
	test_prefix: 06name



compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790T CPU @ 2.70GHz (Haswell) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202312261217.c5597bdf-oliver.sang@intel.com

2023-12-24 10:19:28 mkdir -p /var/tmp
2023-12-24 10:19:28 mke2fs -t ext3 -b 4096 -J size=4 -q /dev/sdb1
2023-12-24 10:19:59 mount -t ext3 /dev/sdb1 /var/tmp
sed -e 's/{DEFAULT_METADATA}/1.2/g' \
-e 's,{MAP_PATH},/run/mdadm/map,g'  mdadm.8.in > mdadm.8
/usr/bin/install -D -m 644 mdadm.8 /usr/share/man/man8/mdadm.8
/usr/bin/install -D -m 644 mdmon.8 /usr/share/man/man8/mdmon.8
/usr/bin/install -D -m 644 md.4 /usr/share/man/man4/md.4
/usr/bin/install -D -m 644 mdadm.conf.5 /usr/share/man/man5/mdadm.conf.5
/usr/bin/install -D -m 644 udev-md-raid-creating.rules /lib/udev/rules.d/01-md-raid-creating.rules
/usr/bin/install -D -m 644 udev-md-raid-arrays.rules /lib/udev/rules.d/63-md-raid-arrays.rules
/usr/bin/install -D -m 644 udev-md-raid-assembly.rules /lib/udev/rules.d/64-md-raid-assembly.rules
/usr/bin/install -D -m 644 udev-md-clustered-confirm-device.rules /lib/udev/rules.d/69-md-clustered-confirm-device.rules
/usr/bin/install -D  -m 755 mdadm /sbin/mdadm
/usr/bin/install -D  -m 755 mdmon /sbin/mdmon
Testing on linux-6.7.0-rc3-00014-g4d060913335f kernel
/lkp/benchmarks/mdadm-selftests/tests/06name... FAILED - see /var/tmp/06name.log and /var/tmp/fail06name.log for details



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231226/202312261217.c5597bdf-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


