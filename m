Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD9C7CFD63
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345895AbjJSO4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjJSO42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:56:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E279B115
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697727385; x=1729263385;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=eTCrP5mQb2TU1w91syqaLbsiXT6hVfPaWKQ0/pUp3UM=;
  b=WD1rNqu/IOtv+tfHMSIyJ3eFfDBCB5KXiPDCtabJs7pDhsMTWHwFs69m
   e0qsbn/J0ITTOeM6psDVX3AfyZuKf7A845JybsuLzZ8G4unV9pi2tkIt/
   LZoe+5VJHZgkBQWQqdrRYDu1YUBRO4BIGy5Uxcq02wX6XwEbkRHfVZSNS
   jDFCpCE7VkUNPCf8Ue7MR2nz8dpNMHVnrakJxSaDQXIiwNngitXC+Dmw1
   AAaoHrEejDpzzspbAHkmx+Bk0W/I39nTm2Yosba4jSrCTP0KBns9WPzq2
   gRxiTkfpC04wBIc2VBHFxcAXVNfBJFFMhnFMt1RLoWEa/Vrc/HUl7sV+V
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450493468"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="450493468"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 07:56:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="4776276"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 07:55:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 07:56:23 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 07:56:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 07:56:22 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 07:56:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4OIMtuLYBNxYlmbq6oy866SyfGBT9u2yciqAbyEDqbiZc05Cp32stoKn8Y6DDomoSDzhdiocmv7tzfW9tsm/IigoU4F3ZqRtM1QLn36uyulJM+d1ZfkbJbeSKErTwAc5l6rYBHwj2x/LqxkrKza6pr+BeTO8MZ763akJcuR4Nl/dzeHQ4nrpefzIlNG6r5IQ7ixE+NGfLeIoaCZtdC2Y6pnETYmq1D46TurslbZxDXAV7+41aerYJuCg9a8qL54h+qQEowRrwLLGDn+hSPmH3XsQt7joYHKomC9LCoFXoYaOMSOKY9njEmStUDq1dqYXbARtfToCJg8QQ1t69/MKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7H/hyV/taCOMAsM+B2SXgOfj9X3WpDyEbhBLry3yjk=;
 b=T7PPB8MNXezt+Gh9VJteAgZsSQ/x1NpxRQNaQPmd9x2jRAuJ6a+eYpQ5cO455rP/xfCl4E68XjEpDRAby+pN1xKVN4Hhh5Pu8hmsevMWJS7u3vN75HnWcIDKXwG9n8kjGQIfyo6Ke12Gxs2OzY1zd0TLzzTBb7Pks0Hm1x9AOxwbKkgp7pa7lrtosfxnqvO3dY/ji3cGfWoGoz/ZXN9nMubenyMTwvonVM+9qCW2M4ncziaxmItxWMV0RE31V0h36Pi/4WL+MUdQDIJl6iEdUNKQglVMw/TYI5oG5KpEA2AR+Nl9jv5A3nh2B3BQVZLQlgTldQUlc5c1oyDJ+J32zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SN7PR11MB6557.namprd11.prod.outlook.com (2603:10b6:806:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Thu, 19 Oct
 2023 14:56:20 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17%5]) with mapi id 15.20.6863.046; Thu, 19 Oct 2023
 14:56:20 +0000
Date:   Thu, 19 Oct 2023 22:56:08 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Hsin Yi <hsinyi@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>, <aubrey.li@linux.intel.com>,
        <yu.c.chen@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vineeth Pillai <vineethrp@google.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH RFC] sched/fair: Avoid unnecessary IPIs for ILB
Message-ID: <202310192232.750e5c5b-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231005161727.1855004-1-joel@joelfernandes.org>
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SN7PR11MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c212cb-3151-4152-d3c3-08dbd0b38dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tgXNL9G29yxBcS3uK13pCLfez/UmXBW+XMaInD3LKJGp0CFmlHjFIyIpWBHUio/Ce7ko9XtUTnkpsdIdDAmKNuaUfw6tznHfXXvfY1jwOgniN98fe+0bymp25EcGlGUxFThi/2thQp2xNpSBBrqcYxCwAtQDzUY7l5tALGy4ncC+Sef4xkWcBvq1TcoAsLSuwbk14ywqQoB1GRQ5mWmcjaXak/2Vi1uohXvTGhU56Y790jlASFIgbvqgmcftgm9O5VFwlcU2BY4y85cBvnXcqTblH/iFmz+ndGaQS/afJR4KB8iyg4WsJifNE7NCAV/W8a7HNw2PS3fKVMTs8Ioe6gT4y7EG/MfH+L3k6Pri3RxEHYYSSWtzFn1m6raY6JqE3yjhJY6hA3IQiM73Kuyq5T68r5+EpGrcaNf6DaQr6pJfPqTkIG/P/wl/RGMsv6aPJm9BgUFxIsCzvCB25IAI/HieeGwt90y2glvp065I+VoViVceDVZslb6Az6bLmyBWvxSmlasJsC48C4B+ZvaFsvh8eWjTiQO02v/QzoePTgwAVyvC/RPNX558BqKWM1E2B9SH3bictqRvK975Q067FA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(41300700001)(8676002)(4326008)(5660300002)(2906002)(30864003)(36756003)(86362001)(8936002)(2616005)(38100700002)(7416002)(82960400001)(26005)(45080400002)(1076003)(83380400001)(6506007)(6512007)(6486002)(966005)(6666004)(316002)(66556008)(478600001)(66476007)(66946007)(54906003)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ARAdZ8TGJIVn1UJc3mLYTWwcHTOYfjEgkj2lL4A1zjAyZJN6vW9jDWkxFc8Y?=
 =?us-ascii?Q?FSfkUpcBhQuNG5i8yq8fE5wCx7MCWu7WNSgWgOy9pRBrfP7y4DSYDMtq+gti?=
 =?us-ascii?Q?bwTMvpm9RMvPIn9Y/AtA36Op0+xD0B6zLWe4nIwjDycRjL9vIyhQJySmUtAe?=
 =?us-ascii?Q?NZ20noLgcDnDE8fw0FKYHnQsF82NJwVZQeZJTQAB/ebs/SqE6gYVMhVmG1AF?=
 =?us-ascii?Q?eGHkEeq0O3xqtqkLMure/QFrplDLAFdcTBM9jjsfNg0Sq2qWRYml2reDVmvC?=
 =?us-ascii?Q?NKQtD6VmUvCwBOVrZPmbztSnaIK3TkDGGX4nMBoEi5NJiWOLqbM+gMgPViWL?=
 =?us-ascii?Q?oWpYsa/4eDE2922k78J4AxQtgMoZCGTX3G2wXcgB5Qu1k2fUdmsXPnleTPrV?=
 =?us-ascii?Q?XXfqGl7g9jvj7Y0oOsM8OFKRgeIUjpKohxkBQ7VU5eJ3pQJnubMZaHCYI43G?=
 =?us-ascii?Q?i6ZR46mLQrU5f2N98ZLT0pGfKknB6ZBn4U9rw0ncGYjLAbT8YaMJpmIs/x8V?=
 =?us-ascii?Q?CHEpjVsva6J2MCPfOlYbX+DSNdOJWjQhp6/flXvja2IkncCxFU8kdzXATN2d?=
 =?us-ascii?Q?QAW6OjUqTlJGNsKPc7CZqrHo1KwDq6cSkCJGAdLw+kKwyoomboqMJk0fXYJN?=
 =?us-ascii?Q?4NHTMm9IzsCFUvnYGYsXp4R0R7YX+iuV88A9gzvGEEZo1Z6f+su7RGBhiVJH?=
 =?us-ascii?Q?JG/N8lHPaAzKOowopJ7w1vrgy+kcgCKuscWTWT2O2RuPLkl0nfNLRTMtq7vu?=
 =?us-ascii?Q?1Y4T9NNlRPRytdKwUM4diL/ZwYhDlUt/oBJM55jqDvViJ9mK0YgMquTah/ru?=
 =?us-ascii?Q?WNTAglNAOKQ+Bfi/+oa/UfmiTgQqjRor2QLdSDtkWIvGBYpi7eDxc1YT4Pdo?=
 =?us-ascii?Q?jWHa3PNXlgKiScaNMuokh5LtcsH2kA9NNJ4i8Ca5SPCCvPbWXugojO45Dx2x?=
 =?us-ascii?Q?2kh87ilDLG3VjI+KB7I+eP0wyavKeRC3rWfabsSOa0Cw/leIdfbzxfQbSVNT?=
 =?us-ascii?Q?PB800lCmAm5qNjgX+kZSlWWHR2gEgN4uMNkRsqP0ZE/vXxj10wYXBLtXEVGg?=
 =?us-ascii?Q?VBzRpCZjI61cNgLEnTr4fZuz9jlDX5LaZZdqNfhKpNku/zLybivkNFdVRqja?=
 =?us-ascii?Q?nFqnAedLSxHGJNFs21kxlYqYvReUkezR0o2VG1ZG3oc8Jw7L9CaQJ9YuzqGx?=
 =?us-ascii?Q?CGRXHacYGBSTa33zrec2qUh5oxj2NMygcMG4TpFHxZun/JjZx8ORMmsbdJCw?=
 =?us-ascii?Q?f7icmvLaak8CAOO7IxEw3FCcZR3oWTAdKN3m900dmCbB2aUEz+r1jDKZVf7Z?=
 =?us-ascii?Q?PKKcNFbi8eL8uflxgxM8KyOSl8BF47nyXy9kMGd/HPNHg1AzssvyxlU35dMM?=
 =?us-ascii?Q?+0OUnJgBtQ1L0DemL28J3v1f89jWe4vlA7FJU+dWl/3WCWUgt1yFTuQyQU8C?=
 =?us-ascii?Q?XnUHWSeycCweL6U1XoxYHOBzdldtG3jOonT76jd/SxSIVm4Jkon+W9cKEf9m?=
 =?us-ascii?Q?oQ/3ET5ebOKfDZHMFyzhb7NsRbEVVeM98tFoIq6OLMDiN2kjy54B95QK2ctW?=
 =?us-ascii?Q?c5faX3DqUov3DzAw6BPALXIW6kcefe+Q21Ir9Lws+Niq1o27/pU4BAM5Y5j4?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c212cb-3151-4152-d3c3-08dbd0b38dbf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 14:56:20.2193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzsNAku/9bdW3PyTIpHaYW2dnzr42wd4mUSsxxKNIe4fNK9lxWlAM2yiroLvxK7cP4cPW4f+gIBaCUXKaS2qkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6557
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:at_kernel/sched/core.c:#nohz_csd_func" on:

commit: 7b0c45f5095f8868fb14cc4e1745befdf58d173c ("[PATCH RFC] sched/fair: Avoid unnecessary IPIs for ILB")
url: https://github.com/intel-lab-lkp/linux/commits/Joel-Fernandes-Google/sched-fair-Avoid-unnecessary-IPIs-for-ILB/20231006-003907
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 3006adf3be79cde4d14b1800b963b82b6e5572e0
patch link: https://lore.kernel.org/all/20231005161727.1855004-1-joel@joelfernandes.org/
patch subject: [PATCH RFC] sched/fair: Avoid unnecessary IPIs for ILB

in testcase: blktests
version: blktests-x86_64-3f75e62-1_20231017
with following parameters:

	disk: 1SSD
	test: nvme-group-00
	nvme_trtype: rdma



compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------+------------+------------+
|                | 3006adf3be | 7b0c45f509 |
+----------------+------------+------------+
| boot_successes | 0          | 3          |
+----------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310192232.750e5c5b-oliver.sang@intel.com


[   55.309389][    C1] ------------[ cut here ]------------
[ 55.315508][ C1] WARNING: CPU: 1 PID: 0 at kernel/sched/core.c:1182 nohz_csd_func (kernel/sched/core.c:1182 (discriminator 1)) 
[   55.325508][    C1] Modules linked in: intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp btrfs blake2b_generic kvm_intel xor kvm raid6_pq zstd_compress irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel libcrc32c sha512_ssse3 crc32c_intel ipmi_ssif rapl nvme intel_cstate nvme_core mei_me ast t10_pi dax_hmem drm_shmem_helper crc64_rocksoft_generic idxd crc64_rocksoft mei drm_kms_helper wmi idxd_bus joydev i2c_ismt crc64 acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad drm fuse ip_tables
[   55.380240][    C1] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.6.0-rc4-00038-g7b0c45f5095f #1
[ 55.390037][ C1] RIP: 0010:nohz_csd_func (kernel/sched/core.c:1182 (discriminator 1)) 
[ 55.396018][ C1] Code: 84 c0 74 06 0f 8e d3 00 00 00 45 88 b4 24 28 0a 00 00 48 83 c4 08 bf 07 00 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d e9 22 b0 f6 ff <0f> 0b e9 1b fe ff ff e8 76 6e 72 00 e9 66 fd ff ff e8 cc 6e 72 00
All code
========
   0:	84 c0                	test   %al,%al
   2:	74 06                	je     0xa
   4:	0f 8e d3 00 00 00    	jle    0xdd
   a:	45 88 b4 24 28 0a 00 	mov    %r14b,0xa28(%r12)
  11:	00 
  12:	48 83 c4 08          	add    $0x8,%rsp
  16:	bf 07 00 00 00       	mov    $0x7,%edi
  1b:	5b                   	pop    %rbx
  1c:	41 5c                	pop    %r12
  1e:	41 5d                	pop    %r13
  20:	41 5e                	pop    %r14
  22:	41 5f                	pop    %r15
  24:	5d                   	pop    %rbp
  25:	e9 22 b0 f6 ff       	jmpq   0xfffffffffff6b04c
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	e9 1b fe ff ff       	jmpq   0xfffffffffffffe4c
  31:	e8 76 6e 72 00       	callq  0x726eac
  36:	e9 66 fd ff ff       	jmpq   0xfffffffffffffda1
  3b:	e8 cc 6e 72 00       	callq  0x726f0c

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	e9 1b fe ff ff       	jmpq   0xfffffffffffffe22
   7:	e8 76 6e 72 00       	callq  0x726e82
   c:	e9 66 fd ff ff       	jmpq   0xfffffffffffffd77
  11:	e8 cc 6e 72 00       	callq  0x726ee2
[   55.418037][    C1] RSP: 0018:ffa00000001f8f58 EFLAGS: 00010046
[   55.424802][    C1] RAX: 0000000000000000 RBX: 000000000003a100 RCX: ffffffff8444c928
[   55.433718][    C1] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ff110017fc8ba164
[   55.442631][    C1] RBP: ffa00000001f8f88 R08: 0000000000000001 R09: ffe21c02ff91742c
[   55.451542][    C1] R10: ff110017fc8ba167 R11: ffa00000001f8ff8 R12: ff110017fc8ba100
[   55.460461][    C1] R13: ff110017fc8ba164 R14: 0000000000000000 R15: 0000000000000001
[   55.470959][    C1] FS:  0000000000000000(0000) GS:ff110017fc880000(0000) knlGS:0000000000000000
[   55.482348][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   55.491067][    C1] CR2: 00007fabd7bff699 CR3: 000000407de46006 CR4: 0000000000f71ee0
[   55.501337][    C1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   55.511601][    C1] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[   55.521859][    C1] PKRU: 55555554
[   55.527131][    C1] Call Trace:
[   55.532072][    C1]  <IRQ>
[ 55.536527][ C1] ? __warn (kernel/panic.c:673) 
[ 55.542341][ C1] ? nohz_csd_func (kernel/sched/core.c:1182 (discriminator 1)) 
[ 55.548935][ C1] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 55.555241][ C1] ? handle_bug (arch/x86/kernel/traps.c:237) 
[ 55.561323][ C1] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 55.567792][ C1] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 55.574671][ C1] ? nohz_csd_func (kernel/sched/core.c:1182 (discriminator 1)) 
[ 55.581230][ C1] ? nohz_csd_func (arch/x86/include/asm/atomic.h:23 arch/x86/include/asm/atomic.h:135 include/linux/atomic/atomic-arch-fallback.h:1433 include/linux/atomic/atomic-arch-fallback.h:1565 include/linux/atomic/atomic-instrumented.h:862 kernel/sched/core.c:1181) 
[ 55.587667][ C1] ? task_mm_cid_work (kernel/sched/core.c:1173) 
[ 55.594511][ C1] __flush_smp_call_function_queue (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/csd.h:64 kernel/smp.c:134 kernel/smp.c:531) 
[ 55.602619][ C1] __sysvec_call_function_single (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 arch/x86/include/asm/trace/irq_vectors.h:99 arch/x86/kernel/smp.c:293) 
[ 55.610431][ C1] sysvec_call_function_single (arch/x86/kernel/smp.c:287 (discriminator 14)) 
[   55.617918][    C1]  </IRQ>
[   55.622373][    C1]  <TASK>
[   55.624388][    C2] ------------[ cut here ]------------
[ 55.625607][ C1] asm_sysvec_call_function_single (arch/x86/include/asm/idtentry.h:652) 
[ 55.631669][ C2] WARNING: CPU: 2 PID: 0 at kernel/sched/core.c:1182 nohz_csd_func (kernel/sched/core.c:1182 (discriminator 1)) 
[ 55.638279][ C1] RIP: _nohz_idle_balance+0xd9/0x7f0 
[   55.648220][    C2] Modules linked in:
[ 55.655250][ C1] Code: 48 74 0a c7 05 c0 0f ce 04 00 00 00 00 8b 44 24 2c 83 e0 08 89 44 24 14 74 0a c7 05 ad 0f ce 04 00 00 00 00 f0 83 44 24 fc 00 <49> c7 c5 10 c4 3f 85 41 83 c4 01 48 b8 00 00 00 00 00 fc ff df 4c
All code
========
   0:	48 74 0a             	rex.W je 0xd
   3:	c7 05 c0 0f ce 04 00 	movl   $0x0,0x4ce0fc0(%rip)        # 0x4ce0fcd
   a:	00 00 00 
   d:	8b 44 24 2c          	mov    0x2c(%rsp),%eax
  11:	83 e0 08             	and    $0x8,%eax
  14:	89 44 24 14          	mov    %eax,0x14(%rsp)
  18:	74 0a                	je     0x24
  1a:	c7 05 ad 0f ce 04 00 	movl   $0x0,0x4ce0fad(%rip)        # 0x4ce0fd1
  21:	00 00 00 
  24:	f0 83 44 24 fc 00    	lock addl $0x0,-0x4(%rsp)
  2a:*	49 c7 c5 10 c4 3f 85 	mov    $0xffffffff853fc410,%r13		<-- trapping instruction
  31:	41 83 c4 01          	add    $0x1,%r12d
  35:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  3c:	fc ff df 
  3f:	4c                   	rex.WR

Code starting with the faulting instruction
===========================================
   0:	49 c7 c5 10 c4 3f 85 	mov    $0xffffffff853fc410,%r13
   7:	41 83 c4 01          	add    $0x1,%r12d
   b:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  12:	fc ff df 
  15:	4c                   	rex.WR
[   55.656534][    C2]  intel_rapl_msr
[   55.660852][    C1] RSP: 0018:ffa000000865fdb0 EFLAGS: 00000246
[   55.682783][    C2]  intel_rapl_common
[   55.686779][    C1] RAX: 0000000000000008 RBX: 0000000000000001 RCX: ffffffff812b76c7
[   55.693493][    C2]  x86_pkg_temp_thermal
[   55.697774][    C1] RDX: dffffc0000000000 RSI: 0000000000000008 RDI: 0000000000000001
[   55.706653][    C2]  intel_powerclamp
[   55.711232][    C1] RBP: ffa000000865fe90 R08: 0000000000000001 R09: ffe21c02ff91742c
[   55.720120][    C2]  coretemp btrfs
[   55.724298][    C1] R10: ff110017fc8ba167 R11: 0000000000000014 R12: 0000000000000001
[   55.733156][    C2]  blake2b_generic
[   55.737157][    C1] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   55.746019][    C2]  kvm_intel xor
[ 55.750115][ C1] ? nohz_run_idle_balance (arch/x86/include/asm/atomic.h:23 arch/x86/include/asm/atomic.h:135 include/linux/atomic/atomic-arch-fallback.h:1433 include/linux/atomic/atomic-arch-fallback.h:1565 include/linux/atomic/atomic-instrumented.h:862 kernel/sched/fair.c:11954) 
[   55.758991][    C2]  kvm
[ 55.762902][ C1] ? clockevents_program_event (kernel/time/clockevents.c:336 (discriminator 3)) 
[   55.768839][    C2]  raid6_pq zstd_compress
[ 55.771772][ C1] ? rebalance_domains (kernel/sched/fair.c:11826) 
[   55.778197][    C2]  irqbypass
[ 55.782972][ C1] ? __flush_smp_call_function_queue (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/csd.h:64 kernel/smp.c:134 kernel/smp.c:531) 
[   55.788612][    C2]  crct10dif_pclmul crc32_pclmul
[ 55.792132][ C1] do_idle (arch/x86/include/asm/current.h:41 include/linux/sched/idle.h:31 kernel/sched/idle.c:255) 
[   55.799153][    C2]  ghash_clmulni_intel
[ 55.804630][ C1] cpu_startup_entry (kernel/sched/idle.c:379 (discriminator 1)) 
[   55.809028][    C2]  libcrc32c sha512_ssse3
[ 55.813499][ C1] start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86/kernel/smpboot.c:294) 
[   55.818765][    C2]  crc32c_intel
[ 55.823547][ C1] ? set_cpu_sibling_map (arch/x86/kernel/smpboot.c:240) 
[   55.828795][    C2]  ipmi_ssif
[ 55.832605][ C1] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:433) 
[   55.838652][    C2]  rapl
[   55.842150][    C1]  </TASK>
[   55.848889][    C2]  nvme
[   55.851904][    C1] ---[ end trace 0000000000000000 ]---
[   55.855226][    C2]  intel_cstate
[   55.856376][    T1] systemd[1]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[   55.929716][    C2]  nvme_core mei_me ast t10_pi dax_hmem drm_shmem_helper crc64_rocksoft_generic idxd crc64_rocksoft mei drm_kms_helper wmi idxd_bus joydev i2c_ismt crc64 acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad drm fuse ip_tables
[   55.958456][    C2] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G        W          6.6.0-rc4-00038-g7b0c45f5095f #1
[ 55.971146][ C2] RIP: 0010:nohz_csd_func (kernel/sched/core.c:1182 (discriminator 1)) 
[ 55.978359][ C2] Code: 84 c0 74 06 0f 8e d3 00 00 00 45 88 b4 24 28 0a 00 00 48 83 c4 08 bf 07 00 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d e9 22 b0 f6 ff <0f> 0b e9 1b fe ff ff e8 76 6e 72 00 e9 66 fd ff ff e8 cc 6e 72 00
All code
========
   0:	84 c0                	test   %al,%al
   2:	74 06                	je     0xa
   4:	0f 8e d3 00 00 00    	jle    0xdd
   a:	45 88 b4 24 28 0a 00 	mov    %r14b,0xa28(%r12)
  11:	00 
  12:	48 83 c4 08          	add    $0x8,%rsp
  16:	bf 07 00 00 00       	mov    $0x7,%edi
  1b:	5b                   	pop    %rbx
  1c:	41 5c                	pop    %r12
  1e:	41 5d                	pop    %r13
  20:	41 5e                	pop    %r14
  22:	41 5f                	pop    %r15
  24:	5d                   	pop    %rbp
  25:	e9 22 b0 f6 ff       	jmpq   0xfffffffffff6b04c
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	e9 1b fe ff ff       	jmpq   0xfffffffffffffe4c
  31:	e8 76 6e 72 00       	callq  0x726eac
  36:	e9 66 fd ff ff       	jmpq   0xfffffffffffffda1
  3b:	e8 cc 6e 72 00       	callq  0x726f0c

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	e9 1b fe ff ff       	jmpq   0xfffffffffffffe22
   7:	e8 76 6e 72 00       	callq  0x726e82
   c:	e9 66 fd ff ff       	jmpq   0xfffffffffffffd77
  11:	e8 cc 6e 72 00       	callq  0x726ee2


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231019/202310192232.750e5c5b-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

