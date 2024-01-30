Return-Path: <linux-kernel+bounces-44773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C8F842736
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80BF11F29FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB7D7E766;
	Tue, 30 Jan 2024 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFncZZ5B"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234FA7CF29;
	Tue, 30 Jan 2024 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626394; cv=fail; b=qDVqTMfzaz2LRsMgchyW82aLjzxQXJCzC/+QDIN+wGHAgJ/ps72N5ultTEyT283JkRtNwm1KFWW8bZJ92Ow+Ipg8jgQhx13Xm65QSqLN5EBPK7Xo9iCjzqJhNnw8Q/WDNFqARVNtEuNmeHOdzKHtZishm7oeJacjPpwesNG6Ad0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626394; c=relaxed/simple;
	bh=a/SkKPMAuKnLrx206ip9UCIg38FGr/4ThGNixPInpgc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ke7V+u2/RTHT43quYspI98DTbnTxacRV46qYkQuK2bckKMd0hqpKfK785XfewyG7QiJmlPfSkem3rmSh3cj9JEc6GYXoothVEhk/A6eYSzSmpG2M67JpHyWs2pSWQPBpcDYdRccWe0dfzcFQQHV4JEInz7rZ71S+0pxkZNMv9SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFncZZ5B; arc=fail smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706626393; x=1738162393;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a/SkKPMAuKnLrx206ip9UCIg38FGr/4ThGNixPInpgc=;
  b=mFncZZ5BmSNwX68BtUzHSV4XHDlVPJ2WSXmLBw20iExfNzMP5FXVN3Qa
   /HsiAe8LVH6yPbDxpHituvooLPUzYyr01DgjA2zrEz3ViRMnI2quIFcC4
   LsiuP8lzRl/Ib/luS7T8AihsM4frO7QOI8Pn4/ie5NwIgK0wqurUx9f7u
   G+xu/R2cf/i8+FqMcvYF7MHTKxJNvmOsNjvLvoPsBtuSSPco39E+qQlKk
   J1S0xxryP9wwCnmwyjvnFIbGapVIYxILY6j8hV9QVuswi5PJpzohLe/X0
   CRoTvipFPF0nwxfZG5jlgI5UgDOmLPZpRJS/COQ7T2WuCjF8Hw5a0et2p
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="400438175"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="400438175"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 06:53:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="22454521"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 06:53:10 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 06:53:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 06:53:09 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 06:53:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcF/Lu6jJomzE7bV1rmpXyiHtxWVbKT8cik78wyNxzSUPmZ/bLX7jYBJ7NlpGWZcDuK2cqkUeYLXm0Wj95pw19g7UXsGbBJk11S4Ohdr2dsNdodNG+BqyCiEN5w3Jt1pWJXz70H77iXPhEzF+mCD0CmEjYeBhSJmFXMTIRemxD/vKQUytaraRvICf0YjMDGuOwFkQ28KdUYZ7wgHn0R0IcBbINMSBuLa4NN19odIpGkRLAml6+MMEettLaFS+WmesMq2CX09tyYOArsEiYnvPC+fo/bKeME/DFy+555oJNwDY0i6wGPJbI6lQGJBBp9xIwZI2E1fGsMe98xXlziPUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRpd6PXD+b/IZt5TDdUEHYzWJMn/knt+56O3YroH5ts=;
 b=TFnZNSLL+dwhS9akVE9z+SrwEbrolRlaGulcA9FOrCw/4+hQk1wb9cNenfpOKEwvUOIfiHqFj2MCz60HBL6bnscloVX4hM/kQY3af/Et66/NOpzeMD0I+pNZHqf3xVrxq0vO8Z/u9VRyguVz4V3qycmixlDuCBhGU1RrntiZeZmS3L8ZFmuskXaIa/Tnzczhk8aTsg7+jbDikHTT5LkgcnyujnDhjtlu4oIveQk8fGPsAnnrB6lulpyTzL0ke6l7rB1wcVn1LIewz5tAnYERaYHzP9HbK+EXu3kuCGavucFkkLo6Gzds42yT+RNwoV+ciO9upUyKCR9d8jctxj3I6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB6690.namprd11.prod.outlook.com (2603:10b6:303:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 14:53:06 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 14:53:06 +0000
Date: Tue, 30 Jan 2024 22:52:56 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kees Cook <keescook@chromium.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Justin Stitt
	<justinstitt@google.com>, Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Marco Elver <elver@google.com>, Hao Luo
	<haoluo@google.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<workflows@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kbuild@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [kees:devel/overflow/sanitizers] [overflow] 660787b56e:
 UBSAN:signed-integer-overflow_in_lib/test_memcat_p.c
Message-ID: <202401302219.db90a6d5-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0112.apcprd02.prod.outlook.com
 (2603:1096:4:92::28) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: e29fd864-8619-46b4-811b-08dc21a32ad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2simmsqNdv0mjKCM4FTT8g/hxl+rI3UrfFusgpfRgAIJlHQXaMGSrwiyg49SAYjS1qSt6jkTqJnXrLId/8svvAU+PPbqv4sPiHbGdQ1EXKhSaBBQfvnc7sw3QOrOTy6LHQK1B7jpQQLWnyF5Vq006JnhqMwTfLCDxkY3og5aN2nLkz3BuCSmN4U8JLHMoe0XIiY2NaDon3sm1Oos8As7Gk12kmq2bw8FYka/8InoVWgbxDxDKe2Tu1F1GJrWHvPPid3ar90q6QDym9O7R/k15xzA2iqvEz4/Hh6JtfWTgpWB5pJc/dFiMtocJVCMuqkxxTcdN95j7WYD1a+JG9mIFQ78/bh8QDSugH/HqrChs7BNWAxIHpMy1j/+q317HrsdCrb9kxaGAqm03lWU8kI4N2ujaR6zJQ7q5h28uT7KKHfvbQpUTHgfDTkVJ7BXBKPyiqlQ9pgmGadjjFRVT89FKaP2lShWh1DB9EA5aBpfWopLKXwSIwDOxLxAe2qbdXYIH71UxyD7kM8PRfqCKRrpB/4+Dl/JvycE/E7NDWvqF3CRKV2msD6yzqNjwkjlX1CMpR5Z9kKNyVrW57V44nrDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(54906003)(4326008)(8936002)(66946007)(86362001)(7416002)(2906002)(5660300002)(8676002)(316002)(36756003)(6512007)(66556008)(66476007)(478600001)(6916009)(82960400001)(38100700002)(6506007)(6666004)(6486002)(83380400001)(966005)(1076003)(26005)(107886003)(41300700001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9U3tyOwb4Nn4k9gphJBipEHG4CfMjgGfpgn0W5peop+94xoWEw/ZJazg2K1L?=
 =?us-ascii?Q?uhbpmdK8FAMTtUs6VoxOGCK4an6X+icASlDpa1z3Y/m5TGUIooMqn1YuKhPw?=
 =?us-ascii?Q?jORetmp9ApRYqhMiW/+ea385Bajnw7TgZnyZWOK3jrvRV7JBs4i8SI7v/KxX?=
 =?us-ascii?Q?NQ3PuQ5M1OeB7Z7v5ltkF8HIXdbuHWbjPcGhSuPmUisebBcZIXHvU2oaXDeS?=
 =?us-ascii?Q?WnYIATVA0yLZstPTOwBIw+y9AZUldqt8YNiGmGej5mf/+iHHLD0rLgHGxVwM?=
 =?us-ascii?Q?1ztEjc3LisqwSrZ/eeKG2PmQVCPzwYXePY8qLMly+BJCx/OvkZZnRhmqEQQM?=
 =?us-ascii?Q?udoC/2DZSxQ4EbEFjG8GfVM+VDdXKHbFqkkBzbmrjbfTO2CmZvlyvbfc+xpv?=
 =?us-ascii?Q?0suwT2/wz1tWuXd3Z/utsqG4uxc7TrllBHlJO5CBdS9omtj+GN2juBZW0CrL?=
 =?us-ascii?Q?fqFK4XJzrJWG97h234iefl3z8vckTgI6+D6Lj/LW0KwnAi2jNl76lIXGD0Qo?=
 =?us-ascii?Q?1vslgchub4oIzW7Dp/k7LXV1yL9tQMc7GjqBtqfT8vWbdT6Mcwe8WrDHWS7x?=
 =?us-ascii?Q?lh6kysqA8N0uV/bDfwzoLhMsiwkYLZgxd1+4UVqZWeUGSEtAD+VrjFxQoG16?=
 =?us-ascii?Q?PPa2Elhlz8/wCu0W03NFhTRDzJCEOXveLrB2Fw+FBbWOt9J/sGxsXIYiDOnH?=
 =?us-ascii?Q?uQTirHEZ0XdROI7yUqRrhlKklOmbImWYsubHRN2fOxC4sXzzdp/0CUnS+Yj4?=
 =?us-ascii?Q?uxs+n+apO7ehhke4cTEI23lPqCgTplM5e/yC0WZ3fhdzFyA1VEMAYWllRIPS?=
 =?us-ascii?Q?F4As37qQGNEnewHymJUyIpNR8VxzdetRNo0z05G43RBSkAP5U8erbq6CxABp?=
 =?us-ascii?Q?QWaHSK6G9bilNXZzHtuRFkCdoR6YOZqEIazyzelDrW/1ok404SUe4C137fs7?=
 =?us-ascii?Q?6lOHzU6yIZJdfZEZsQWLIbO6YSjYNMIAkiVeQs7ZE9akYqW0Koql5baGlEwb?=
 =?us-ascii?Q?ZcrYLfXFNKevXdN6ozrR1nWL/k3I5Cqcocc0u1ac5zWNgXx2hxMimIYSZv1x?=
 =?us-ascii?Q?3oQ9FoH/1+Ew3QNQbCenq0qAmZ1QQwj+Qxw33AipUcCxn/c5/4uF6zBSdjrk?=
 =?us-ascii?Q?1hb687iLoLdjBYL6O7m2x3gs6rSYEtDYkP0cbHtCOJPozgQBigGSQbQCBKND?=
 =?us-ascii?Q?58HarP8SU/nffqB0rgdsk3KRMBE0ouDNytk0UMpr2v/YsVrfRjIUt7lYr373?=
 =?us-ascii?Q?ojB5XxGnB4M7PQWFQhtncu1/v2LYmaes6Wx7ATPGYtu/+nkg6yXmfHVolWze?=
 =?us-ascii?Q?kA2OAvYALPs4r5rmW0ybLfMBiPbFK+wvuUawFom9stTHeBUYG5B4anVI4FHw?=
 =?us-ascii?Q?awsDJvf/wa4dsGftcxSda5EXTjhu5YHijHflsuAkXvRxFWVNp0X8Zz/JvDRl?=
 =?us-ascii?Q?W30YPCD1B7SreF7Sup+0UiJVQLqsUOfReNicnTcD78vM9e5oLk9iXGYmQ65v?=
 =?us-ascii?Q?vWE3crv8J9xhGrJfzk+6FHaoK1FRLToqnxVnVelWEpP2cp98cAoHBgovL9YK?=
 =?us-ascii?Q?hbKEs/qXnRu2st57Q8GuwJBB5GOwx/vyCAEwOVCyyinYd2azkZHIsB957qlD?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e29fd864-8619-46b4-811b-08dc21a32ad0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 14:53:06.5019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vuYNS79P36jjn87r45DgINcfYqdmSmC7GjFtvBQLtE3rhPDdDDC6Ap84OVkPQyw33EVX+WqDK9GnurGatVXNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6690
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "UBSAN:signed-integer-overflow_in_lib/test_memcat_p.c" on:

commit: 660787b56e6e97ddc34c7882cbe1228f4040ef74 ("overflow: Reintroduce signed and unsigned overflow sanitizers")
https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git devel/overflow/sanitizers

in testcase: boot

compiler: gcc-11
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


we noticed this commit is reintroducing "signed and unsigned overflow
sanitizers", there is below config diff between parent and this commit in our
buildings:

--- ea804316c9db5148d2bb0c1f40f70d7a83404638/.config    2024-01-26 22:09:35.046768122 +0800
+++ 660787b56e6e97ddc34c7882cbe1228f4040ef74/.config    2024-01-26 19:53:20.693434428 +0800
@@ -6706,6 +6706,7 @@ CONFIG_UBSAN_BOUNDS_STRICT=y
 CONFIG_UBSAN_SHIFT=y
 # CONFIG_UBSAN_DIV_ZERO is not set
 CONFIG_UBSAN_UNREACHABLE=y
+CONFIG_UBSAN_SIGNED_WRAP=y
 # CONFIG_UBSAN_BOOL is not set
 # CONFIG_UBSAN_ENUM is not set
 # CONFIG_UBSAN_ALIGNMENT is not set

while testing, we observed below different (and same part) between parent and
this commit:

ea804316c9db5148 660787b56e6e97ddc34c7882cbe
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          6:6            0%           6:6     dmesg.UBSAN:shift-out-of-bounds_in_arch/x86/kernel/cpu/intel.c
          6:6            0%           6:6     dmesg.UBSAN:shift-out-of-bounds_in_arch/x86/kernel/cpu/topology.c
          6:6            0%           6:6     dmesg.UBSAN:shift-out-of-bounds_in_fs/namespace.c
          6:6            0%           6:6     dmesg.UBSAN:shift-out-of-bounds_in_fs/read_write.c
          6:6            0%           6:6     dmesg.UBSAN:shift-out-of-bounds_in_include/linux/rhashtable.h
          6:6            0%           6:6     dmesg.UBSAN:shift-out-of-bounds_in_include/net/tcp.h
           :6          100%           6:6     dmesg.UBSAN:signed-integer-overflow_in_lib/test_memcat_p.c


this looks like the commit uncovered issue. but since it's hard for us to back
port this commit to each commit while bisecting, we cannot capture the real
first bad commit. not sure if this report could help somebody to investigate
the real issue?



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401302219.db90a6d5-oliver.sang@intel.com


[   42.894536][    T1] ------------[ cut here ]------------
[   42.895474][    T1] UBSAN: signed-integer-overflow in lib/test_memcat_p.c:47:10
[   42.897128][    T1] 6570 * 725861 cannot be represented in type 'int'
[   42.898391][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc1-00007-g660787b56e6e #1
[   42.899962][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   42.901661][    T1] Call Trace:
[ 42.902009][ T1] dump_stack_lvl (??:?) 
[ 42.902009][ T1] dump_stack (??:?) 
[ 42.902009][ T1] handle_overflow (ubsan.c:?) 
[ 42.902009][ T1] ? kmemleak_alloc (??:?) 
[ 42.902009][ T1] ? kmalloc_trace (??:?) 
[ 42.902009][ T1] ? test_memcat_p_init (test_memcat_p.c:?) 
[ 42.902009][ T1] __ubsan_handle_mul_overflow (??:?) 
[ 42.902009][ T1] test_memcat_p_init (test_memcat_p.c:?) 
[ 42.902009][ T1] ? trace_hardirqs_on (??:?) 
[ 42.902009][ T1] ? _raw_spin_unlock_irqrestore (??:?) 
[ 42.902009][ T1] ? test_string_helpers_init (test_memcat_p.c:?) 
[ 42.902009][ T1] do_one_initcall (??:?) 
[ 42.902009][ T1] ? parameq (??:?) 
[ 42.902009][ T1] ? parse_args (??:?) 
[ 42.902009][ T1] do_initcalls (main.c:?) 
[ 42.902009][ T1] ? rdinit_setup (main.c:?) 
[ 42.902009][ T1] kernel_init_freeable (main.c:?) 
[ 42.902009][ T1] ? rest_init (main.c:?) 
[ 42.902009][ T1] kernel_init (main.c:?) 
[ 42.902009][ T1] ? schedule_tail (??:?) 
[ 42.902009][ T1] ret_from_fork (??:?) 
[ 42.902009][ T1] ? rest_init (main.c:?) 
[ 42.902009][ T1] ret_from_fork_asm (??:?) 
[ 42.902009][ T1] entry_INT80_32 (??:?) 
[   42.924183][    T1] ---[ end trace ]---
[   42.925743][    T1] test_memcat_p: test passed


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240130/202401302219.db90a6d5-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


