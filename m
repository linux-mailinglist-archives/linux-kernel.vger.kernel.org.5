Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAD57925F3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbjIEQTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245644AbjIECSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 22:18:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B45CC9;
        Mon,  4 Sep 2023 19:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693880321; x=1725416321;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DaVgztMyjBPpoY5eDBYrQi/H8y9Mvu34r2E/PnUV828=;
  b=kAWzr7n/LLmvTbXJSjBP35L6yEQBHeT1EPJ8tPOs4FACbnPGsikloCri
   EPXVPUsVEE61q1/18WIZ76qfaGwk7/2UuAIQgj0Jj/wWekoTb4/Da+rmx
   lA1lPUm2HIF/OkujiKI80zExdO8mQM3u83kE8tIE/rSMkZ4uYckt2H6gh
   j+h3DXmc3vm1MDwykhtdUHRjUFW6lO1DKdbEyusO40pIpjbETJtLyEEUU
   xXx7VnyUcOVep0t4IYE6PKbW8lJqKLopjOHL68lv30s0uTXzLgKHcNZLX
   Qh84aTxZajN2/UXwcf3AYSKiOI5KFvS1g8lm20o/vqIAXH1a4CWf4Ll5X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="375575325"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; 
   d="scan'208";a="375575325"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 19:18:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="734468018"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; 
   d="scan'208";a="734468018"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 19:18:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 19:18:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 19:18:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 19:18:39 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 19:18:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7vZ+FpmLjNlo4/YxQH+jBfhAHOZX48wwcIDlZ6p7fRiGfOY4jYtlJ/MfHor2c9rcQUtIXu7CNhOSi4CEJbUrAvjEamG9BH+/7FC05CyqTnKnrZhpbTifUN7JiqZSNtHXU6YiSB2xE1NULiXV64ZG26QwamunuTh6G65pl9kALdwPCbb5o0ltjpSKYNy0GwssMHoNxA83qmuJvxpK+/elAokAx4a7hnoDn+JcwOj1EnWOwUSOax9tJzH5UgJ+ujiEvqh8UBFYD9C1h0ZP5S55NwlVmtnoDtV4sYgB1ir7auFC/V0txCURGBWVQeDY8kBKNFBCf4L6g3zCi6unyMS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOcDupFawGPfdQqmbWNFRoGxY/okttdAUGlJW49TcCo=;
 b=mfEY5gWeO8KujaBKy83ztDRIXXXWKOIiEbMQlvtBckD+5Lluzdt3PCLjZd0mK45LO26o1Qai/c5BFSs9LTAGF/AeU+nvdSlRl1TR/C+H6M4AuxQTtuGtJAMLlPGR6TCKyTbB7AYFvNXJ5RMueFdOPHyvXW+JUMYTdhdxfNntp/irv6zzrg2Zmg1FlLojGp/l3PyBn6dZ+EYKgLCODZ8ApvMwbr8dca0an/kWZGIGZR3Bg4FM/PknqXtAfI8CO9K0hgUM80HTHLhTQw2HQLF7zmmqeBp6UJ3LE4GzuNEP/6y/pX/GAoODf0Dj/YM1bxodn8L86dcIYXFVFoOZLQC60g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SJ2PR11MB8449.namprd11.prod.outlook.com (2603:10b6:a03:56f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Tue, 5 Sep
 2023 02:18:31 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 02:18:31 +0000
Date:   Tue, 5 Sep 2023 10:18:21 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Ajay Kaher <akaher@vmware.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        <linux-trace-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [eventfs]  ba37ff75e0:
 WARNING:at_mm/slab.h:#cache_from_obj
Message-ID: <202309050916.58201dc6-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SJ2PR11MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: e913d8e8-9b0b-4a92-f8a8-08dbadb665c3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJglPz5vkQ1mvZKHwpjvmj36hGjkr0eojMP8Hj6j4NIEHF//Seg0d1r+nmi2ZtPTHR8Nu35eV7PYBWrmEwRE83Mc9hAvFL0rCb8spLO9QlSkKFdtyR1//9AH/t4obCgXahIFWKA8X2o5QYChsDGV+LVlqmMxvQwx9VQpZWdZ62Xzg3zuK0MY+/IM5cTohdnZePgHhba76hgckFELLR7Iza5hmh804gevAAVp3MvBHfksIqSn2No2H1rhMiRxEPXYTUnPE8Uc55gIroTIxHTzLrPcvAxIZMnr9pFoSyyjDWNEIIEPL8ayVIJIxegb7h7l37434sqYyTLyXUI+zPpmhcAtIqn8jh2iB4x+xyHIvb1sDHu3Np2nXrB8awD9z5ViJh+ge/3aenZHbQIVfSoladFKLF2CezN8q0lq4AqGmEcXkrDZR0z/RN1Mu/ce8B+nG7MRQCbVZIpx1bYzUaOU7S+DtsLmIvo/8nl3pB7lCCUvG2zFety0ITexLfxXySTnKpTIRjWKxf1k4Riok+zvMZqDOpRVh9oB4vhu2SSJ1dJ/jGwyqg/FVx59QD1u0uJSQV9HnTlPM6Tn5tcXe9VrRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(396003)(376002)(186009)(1800799009)(451199024)(478600001)(2616005)(6666004)(966005)(45080400002)(66556008)(66946007)(26005)(1076003)(66476007)(107886003)(54906003)(6486002)(6506007)(6916009)(2906002)(6512007)(8936002)(4326008)(8676002)(316002)(41300700001)(86362001)(83380400001)(36756003)(5660300002)(82960400001)(38100700002)(66574015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6jCFji/NydlK8/WQ+hCN9GsYHZLCJ7zRouMxoRwIdB7xCMFdSXB43JF2q4ZW?=
 =?us-ascii?Q?VrQLlvV0RGaBMeHZPTJgO9BWzUp/wE58esOweBy1EZ/e8iN39upaJNBg9r5o?=
 =?us-ascii?Q?EsJ/dNCCETeGB3TwLzVjC/fvAhcjad5agr5OIG5x9LEpsUdOLR8oMwWKv7jn?=
 =?us-ascii?Q?Pq2qlbUlRFur479+9XkZD6176J4FrpLUjFJfQ6+YsJM+IyTpMlXFuqZUhBEv?=
 =?us-ascii?Q?gMGN2gbd/sDZ2iGgX1SktN1nlRx3Ffpz2r2v9qTazITIvt2sbOsgi/EK4i05?=
 =?us-ascii?Q?RsWU8F0htsY8scP/fSruyLmL5h6mw7Zr4NVgNBB0AI9a5GWsG7TD1EfEKxSi?=
 =?us-ascii?Q?3SAqmh7+tMU5lkbC6RadFgs9kZyPdYZlbLtNBmPtOQinPqcibz1tbEqqavyh?=
 =?us-ascii?Q?LVBTjqX7pjUUCihISY4qiAQ2SHiZBZW4pJwc01erQev7eZn4SBphHXwUmZG8?=
 =?us-ascii?Q?ZUMhi6BIctnWEEviBXFTAPttFjGndE4KhVamFH74xka4d86xEICL1oh2hmMD?=
 =?us-ascii?Q?QbFrPBe6EgiAkOPEt7c1of48/B4L6Zof+eQvufUi1aG++iNaFUOFoaaDrxQw?=
 =?us-ascii?Q?YWNoDxoBl0e44G8YHvmk6EO53RhSmEqAkx/AK208mdnLbuLqeb85phZojPBx?=
 =?us-ascii?Q?7U6lLiKqrzeQuTmQwNgXxVKNPtj+OFXR+SWRwuJOoUikRg2pzd/mbTAmMLr0?=
 =?us-ascii?Q?D0QnbBwMIEQbLSK7OfC47jrMot1WrgWGqQkePzB26mqTKZSUtgpTAiVKcIXa?=
 =?us-ascii?Q?RMbG/ZwWyNd+keINv95TBWjvnzfH4XpmGd3TYr3kRmZE6HOwekm09K/l63iv?=
 =?us-ascii?Q?qVu0q4rk/fDIokItTfMiYJFK1pfmyHQ5J0OaZa6MLgTp7QmwJVKZkWLrSUK6?=
 =?us-ascii?Q?H8pD6V3/U+nqumHZ4EqPBw1WSjyGNqIJtayncR33ddMMvmbmat5+0l0HFqq1?=
 =?us-ascii?Q?vZPuLsam9u+85E3q9F74+gjcQIQJ4DF65CqdLW/9LlOq25jSZhiuCqQB0BF4?=
 =?us-ascii?Q?o55V74WNGeYrylsG7qreK0P2Zt7SHTjqKm6cI9Oe7JiWKgYsf/sp3DlQbXey?=
 =?us-ascii?Q?VpuVik+pz3Qrw65xjQTmjwUW2Q+hmJ9jTGryjs3cdZfKE60kb6O8+OPKrWAO?=
 =?us-ascii?Q?Q/wjVBsqjjr36KzqG9tF3s8tm7dGnjXWcO1/JutR1X545cNp/3ZJe+oaSKz3?=
 =?us-ascii?Q?nP2RrVpNrLdebWIAfp2OU8vQQam3dtqtt7BWnX+QdxvZQ+2VNWhXfBQLgspD?=
 =?us-ascii?Q?n14ac3h1FnEeM+xbPGB0ktBafSwsO48hxzraEa4HihXNXDti5c9ftQcDaXvP?=
 =?us-ascii?Q?V9ZesA5G+5gx/n1BsB9grFejz1xepAEZ9jQINoOCW/KYtzCYdU3ehi7j8XRB?=
 =?us-ascii?Q?RXv4QJZ7Db9ITZmX/1TMy2+z16up9krgX1EKbyrwR2DB6hbV4au5/QaAXmvD?=
 =?us-ascii?Q?SEcShAwm+qZB+99vNzAzzIi6FgJHqYxfPHYh6l9tXu5siBpW9XFEdmF6uEX1?=
 =?us-ascii?Q?WBQUylDbdkkYIz2cT0ZH9EDtesYotKEaGobSQuFp8CohslRo0CRfkwDWCxP9?=
 =?us-ascii?Q?lOhXU+Adz+nmhlSESVqXo4eCYOmUHQs2zaa/GmvLNIf7PbwBs0/ygqCFUWN/?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e913d8e8-9b0b-4a92-f8a8-08dbadb665c3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 02:18:30.8814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: caoLLyPyeezzyBAuewK8em1J6D5ZFLjlt62Ggwc0XQ1zTECPgXI4GkSpbaDUzSv6Ikwb6gfbB2JIpkqe1MuVDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8449
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:at_mm/slab.h:#cache_from_obj" on:

commit: ba37ff75e04be7df5fa19dcd86f81c984294a37b ("eventfs: Implement tracefs_inode_cache")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master a47fc304d2b678db1a5d760a7d644dac9b067752]

in testcase: boot

compiler: gcc-11
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309050916.58201dc6-oliver.sang@intel.com


[   45.215521][    C1] ------------[ cut here ]------------
[   45.216692][    C1] cache_from_obj: Wrong slab cache. tracefs_inode_cache but object is from inode_cache
[ 45.218391][ C1] WARNING: CPU: 1 PID: 21 at mm/slab.h:661 cache_from_obj (mm/slab.h:661 (discriminator 1)) 
[   45.219836][    C1] Modules linked in:
[   45.220610][    C1] CPU: 1 PID: 21 Comm: ksoftirqd/1 Not tainted 6.5.0-rc4-00007-gba37ff75e04b #1
[   45.220941][    T1] DLM installed
[   45.221672][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 45.224683][ C1] RIP: 0010:cache_from_obj (mm/slab.h:661 (discriminator 1)) 
[   45.225440][    T1] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[ 45.225468][ C1] Code: 8d 72 ff 83 e2 01 48 0f 45 c6 eb b5 4d 8b 45 58 48 8b 51 58 48 c7 c6 f0 b1 56 87 48 c7 c7 40 88 be 88 4c 89 c1 e8 8c 82 80 ff <0f> 0b 4c 89 e6 4c 89 ef e8 0f c4 ff ff 4c 89 e8 41 5c 41 5d 5d c3
All code
========
   0:	8d 72 ff             	lea    -0x1(%rdx),%esi
   3:	83 e2 01             	and    $0x1,%edx
   6:	48 0f 45 c6          	cmovne %rsi,%rax
   a:	eb b5                	jmp    0xffffffffffffffc1
   c:	4d 8b 45 58          	mov    0x58(%r13),%r8
  10:	48 8b 51 58          	mov    0x58(%rcx),%rdx
  14:	48 c7 c6 f0 b1 56 87 	mov    $0xffffffff8756b1f0,%rsi
  1b:	48 c7 c7 40 88 be 88 	mov    $0xffffffff88be8840,%rdi
  22:	4c 89 c1             	mov    %r8,%rcx
  25:	e8 8c 82 80 ff       	call   0xffffffffff8082b6
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	4c 89 e6             	mov    %r12,%rsi
  2f:	4c 89 ef             	mov    %r13,%rdi
  32:	e8 0f c4 ff ff       	call   0xffffffffffffc446
  37:	4c 89 e8             	mov    %r13,%rax
  3a:	41 5c                	pop    %r12
  3c:	41 5d                	pop    %r13
  3e:	5d                   	pop    %rbp
  3f:	c3                   	ret

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	4c 89 e6             	mov    %r12,%rsi
   5:	4c 89 ef             	mov    %r13,%rdi
   8:	e8 0f c4 ff ff       	call   0xffffffffffffc41c
   d:	4c 89 e8             	mov    %r13,%rax
  10:	41 5c                	pop    %r12
  12:	41 5d                	pop    %r13
  14:	5d                   	pop    %rbp
  15:	c3                   	ret
[   45.230147][    C1] RSP: 0000:ffffc9000016fc20 EFLAGS: 00010286
[   45.231208][    C1] RAX: dffffc0000000000 RBX: ffff8881286e3150 RCX: 0000000000000100
[   45.232570][    C1] RDX: ffff8881003c9a00 RSI: ffffffff8126acd8 RDI: 0000000000000003
[   45.234058][    C1] RBP: ffffc9000016fc30 R08: 0000000000000000 R09: 0000000000000000
[   45.235160][    T1] utf8_selftest: All 154 tests passed
[   45.235410][    C1] R10: 0000000000000001 R11: 0000000000000001 R12: ffff8881286e3150
[   45.237775][    T1] ksmbd: The ksmbd server is experimental
[   45.238094][    C1] R13: ffff8881000de640 R14: ffffc9000016fd50 R15: 0000000000000001
[   45.238861][    T1] ntfs: driver 2.1.32 [Flags: R/O DEBUG].
[   45.239349][    T1] efs: 1.0a - http://aeschi.ch.eu.org/efs/
[   45.239964][    C1] FS:  0000000000000000(0000) GS:ffff8883ae700000(0000) knlGS:0000000000000000
[   45.240951][    T1] qnx6: QNX6 filesystem 1.0.0 registered.
[   45.241460][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   45.243778][    T1] JFS: nTxBlock = 8192, nTxLock = 65536
[   45.244480][    C1] CR2: 0000000000000000 CR3: 00000000090fa000 CR4: 00000000000406e0
[   45.249527][    C1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   45.251125][    C1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   45.252621][    C1] Call Trace:
[   45.253384][    C1]  <TASK>
[ 45.254011][ C1] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 45.254861][ C1] ? __warn (kernel/panic.c:673) 
[ 45.255707][ C1] ? write_comp_data (kernel/kcov.c:236) 
[ 45.256710][ C1] ? cache_from_obj (mm/slab.h:661 (discriminator 1)) 
[ 45.257982][ C1] ? report_bug (include/linux/context_tracking.h:153 lib/bug.c:220) 
[ 45.258865][ C1] ? handle_bug (arch/x86/kernel/traps.c:324) 
[ 45.259756][ C1] ? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator 1)) 
[ 45.260670][ C1] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 45.262016][ C1] ? __warn_printk (kernel/panic.c:712) 
[ 45.262982][ C1] ? cache_from_obj (mm/slab.h:661 (discriminator 1)) 
[ 45.263914][ C1] kmem_cache_free (mm/slub.c:3820) 
[   45.264756][    T1] NILFS version 2 loaded
[ 45.264827][ C1] ? inode_free_by_rcu (security/security.c:1495) 
[   45.265394][    T1] befs: version: 0.9.3
[ 45.266034][ C1] ? kmem_cache_free (mm/slub.c:3801 mm/slub.c:3823) 
[   45.267414][    T1] ocfs2: Registered cluster interface o2cb
[ 45.267526][ C1] tracefs_free_inode (fs/tracefs/inode.c:49) 
[   45.268980][    T1] ocfs2: Registered cluster interface user
[ 45.269267][ C1] ? tracefs_show_options (fs/tracefs/inode.c:47) 
[ 45.269316][ C1] i_callback (fs/inode.c:252) 
[ 45.269347][ C1] rcu_do_batch (include/linux/rcupdate.h:308 kernel/rcu/tree.c:2137) 
[ 45.269394][ C1] ? cond_synchronize_rcu_expedited_full (kernel/rcu/tree.c:2066) 
[ 45.269473][ C1] ? rcu_report_qs_rdp (kernel/rcu/tree.c:2008) 
[ 45.269509][ C1] rcu_core (kernel/rcu/tree.c:2401) 
[ 45.269543][ C1] rcu_core_si (kernel/rcu/tree.c:2417) 
[ 45.269567][ C1] __do_softirq (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/irq.h:142 kernel/softirq.c:554) 
[ 45.269597][ C1] ? __probestub_softirq_exit (kernel/softirq.c:914) 
[ 45.269627][ C1] run_ksoftirqd (kernel/softirq.c:410 kernel/softirq.c:922 kernel/softirq.c:913) 
[ 45.269650][ C1] smpboot_thread_fn (kernel/smpboot.c:164 (discriminator 3)) 
[ 45.269691][ C1] kthread (kernel/kthread.c:389) 
[ 45.269716][ C1] ? sort_range (kernel/smpboot.c:107) 
[ 45.269742][ C1] ? kthread_complete_and_exit (kernel/kthread.c:342) 
[ 45.269774][ C1] ret_from_fork (arch/x86/kernel/process.c:151) 
[ 45.269805][ C1] ? kthread_complete_and_exit (kernel/kthread.c:342) 
[ 45.269833][ C1] ret_from_fork_asm (arch/x86/entry/entry_64.S:312) 
[   45.269885][    C1]  </TASK>
[   45.269894][    C1] irq event stamp: 318254
[ 45.269903][ C1] hardirqs last enabled at (318260): console_trylock_spinning (arch/x86/include/asm/irqflags.h:42 (discriminator 1) arch/x86/include/asm/irqflags.h:77 (discriminator 1) arch/x86/include/asm/irqflags.h:135 (discriminator 1) kernel/printk/printk.c:1961 (discriminator 1)) 
[ 45.270030][ C1] hardirqs last disabled at (318265): console_trylock_spinning (kernel/printk/printk.c:1940 (discriminator 1)) 
[ 45.270071][ C1] softirqs last enabled at (317598): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:400 kernel/softirq.c:582) 
[ 45.270100][ C1] softirqs last disabled at (317603): run_ksoftirqd (kernel/softirq.c:410 kernel/softirq.c:922 kernel/softirq.c:913) 
[   45.270132][    C1] ---[ end trace 0000000000000000 ]---
[   45.271786][    T1] OCFS2 User DLM kernel interface loaded
[   45.271905][    C1] ==================================================================
[   45.277835][    T1] gfs2: GFS2 installed


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230905/202309050916.58201dc6-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

