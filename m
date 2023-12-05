Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3422180571D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345853AbjLEOVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345907AbjLEOVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:21:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA282B9;
        Tue,  5 Dec 2023 06:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701786100; x=1733322100;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=21CnpQH8ZqQvqYNciagRKHspbstb9zPPuTGged6UKL0=;
  b=EIkDiUFs8zwaDXylWwQpVIPlP5vXxzB1DWxivrY1oyzsFyUjrJ7Mvpvt
   fHld/s/tUBoGTL5iBrJbaWo5D+nNgGMhnkgnJyAsIL9GfyqncrU+mAEiJ
   jCgtFK4/ZpiSbQPK3Ic1RMd1/tbtflz+66V7IUJuCxrTZ+II+K2Md2fz9
   fRwoPqHzPvjjXxzgap7fxco5/4ANY3RQPMeDwWcFzr3Ivt9C3nJbNHdSr
   E5ULcTjbIXEfO216YvWQcCPoq32HIhFzn/ZuiR7JQ21rHFwaTQKqrd865
   YF5oGoyuOQsF9PFImYwo6CJNihEaGgZfzTUH2ZJV3iPqyAZq26XWzoj53
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="983181"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="983181"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 06:21:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="805283321"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="805283321"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 06:21:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 06:21:39 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 06:21:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 06:21:39 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 06:21:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIs24ROa2Q4vWxvs+FP/aB29v3m3ZAkxHrhNN0xwh7CHUuB05nk9boyNbWZPkhfjJk12ICCNap58a1UHLkrxEmYH09dN9jg+axu+0+uoNexQ9leO+M3c7svxsYMEb4eJevCQUMwSGJXd48frY21Lnq8V8geFUKkt/DCSNK4TuQZssvTIEHnOxpqWFyVKkQSoN62ljovd+L2fV43LqJXKzJvZLfGe3TbaJsOfamSMLFumNJLlcMGkmOSer7iKhNqjhj0dzCFp3A/L4ZQuqfXFOLqHATy9Xk6HrJITU8TCRP+IhRax5u6w86r4RxOK8uuZ/g2GKiHecOXi6uj/4LJ5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWrZLMklh1JSh1uC6LCKkcaOcHdAjxdLgKhhk5nFi08=;
 b=DJ2jdaWGv6KDQkaNS5xgdevAmhydKj8MFtokx+SrRT++7fBpECVLHBhFfdkklIvg+EIHr00wN/IIYysp0yJl5T9oqO2tzUV9YaJoAmbXrDxriwmhJXPlCrFmJhG/YCDUlbVXuBDd4Ygzzk5q/ExeRycjlhxxkM7qqZHGAICc/No8EuqXbD/SHToI2NWnezWR3YC0ZF5h5JynuoRWXz3Zn4lMIgRT9pZP+1tSfxu1/lLordgwJ1qrDxv/FtBgQ4kDu5FzH2mVpigp/jRez66H9pG/ygeR4AWaCzDIQ5MduPk5m0kGgNvFvc7QheySJOdxo+0GWyc4+segf0ghSpfBxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8495.namprd11.prod.outlook.com (2603:10b6:610:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 14:21:37 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 14:21:37 +0000
Date:   Tue, 5 Dec 2023 22:21:28 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Budimir Markovic <markovicbudimir@gmail.com>,
        <linux-perf-users@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [tip:perf/urgent] [perf]  382c27f4ed:
 WARNING:at_kernel/events/core.c:#__do_sys_perf_event_open
Message-ID: <202312052248.1270bdba-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: a77998be-934b-4711-106f-08dbf59d7d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZPcjKPS9N5JkcF5KJh9fjnVnKYt+8zJf1EKuqYCvd4jjtJTEmCVT5PrLg83ogp+R8tXl0nBEC7mlSo+NlvN93figQBZQWJdBLUeHD3qPWXAbQZXiWUqgMcHlgHDacVO8lAE23duNgdwDpQUhrJymcZgzlrMSu9fYVzvlE+VZyCMS0u8bwA/LlT1RFEmWNB9PPGYv+EDpyibO42oP0+iuYQ+vKj3E7HHQ8r36BHvXMBaXj49n/RupIRyWDogyTAoeQkJ0ehQgQxoFKHS7+CeMVaTRHsDvzY9VA2CevVvEFSbIK1oIhY45OV3j4cNqewl8qKkccQoXBUVBlHRhLT62puyY/47NglsTf0P2aTX/+wehvhL99PIZ857xCMy1/6wMmSp1RmP20WoTVIxl10fTete3Wjx9h8oM1c+OufGhpqm4VW0CXrabnGR8eAxKROf6Sl5bSkBJfOfhidZL4mKZLpxRcDTcEXijqkSyHK1AZwUThsMajKSoK8T6ALAtkC45DGxOxG3KAIkCk/Zs3rNnbOseJ3qKKTmibxgdal83SbudYXdjUrDQFPRVLEVYNLEhWg+hsplohEV3f8GJx+fvm7spDiTnHqyp9miA54VjBh/NRje9qeoSzZZ21KH6JNFuKsMf2YyQajKkKr/yE2zu1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(366004)(346002)(230173577357003)(230273577357003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2906002)(316002)(66556008)(6916009)(66476007)(86362001)(66946007)(8676002)(41300700001)(36756003)(4326008)(8936002)(5660300002)(38100700002)(82960400001)(966005)(6486002)(83380400001)(478600001)(45080400002)(26005)(1076003)(107886003)(6666004)(2616005)(6512007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qpm8GksHLOAYRL+UhCBh+ddaibyCZMB3f1NJANr0HFYOiNbjdqujKGKGp9VE?=
 =?us-ascii?Q?7aKsNUrnI8ylsi8nW3aA1REL8T2nj9GhTuRG9+U0MPM40rUGZ7ngAGbGEdAE?=
 =?us-ascii?Q?RIiR3im2wTDoxJZysuBV+z784vNlv0U4B6YpmPRWSIw3CO8fVeGL3b9YBTZ7?=
 =?us-ascii?Q?VdOAzzplGubtQokKkgMTzc8wGS8TPLaITKBofnkqCc2G+ZheS0PPJBc85rNq?=
 =?us-ascii?Q?MrktTrsPTr8R/tpa2mAAUhzVuUQ4snzPwM8yDGDw1K/qdDPmwdXRAGyEOJfW?=
 =?us-ascii?Q?MQzRrHc4DKtDAhhZsAG0GMt4j/kPynHtX80MII7g1E7l2pDI8AuIpuKzP/si?=
 =?us-ascii?Q?kW8d20meYn6UQOVzj/fyV3mK+4wjre5UyrGMkeHwjBEdLsn+QHDn/b7tli3g?=
 =?us-ascii?Q?Fdo1aq5+GF/53Li5Ufua8ryNqKZdOvwUYydF5Fw7VkozUFgQQBdnd4XW5GV5?=
 =?us-ascii?Q?Qgk6oiuH+MUzbI9aIvXhB+15ZpZfc0v62R6PQ+rdlddSD3dZSKHGtidJ296L?=
 =?us-ascii?Q?BQpvSH08z6CZAkzjhvY5eLkvPaXghtMRYwqx4Di+HAqk256pHcd+tN92cwqg?=
 =?us-ascii?Q?BuEULuYOV66p4TlCR6ahhDz0QOB9QoyXqnPnU4wQXhM4aswrRImNRj79KF5S?=
 =?us-ascii?Q?T1sdE2Mo/K1mAqwETloW7c7Vw9MKB567PCg/LVjcYr8pny42nnzpRI3Ov0qu?=
 =?us-ascii?Q?7zSN7CaEbOGV+jjxm+TvJeO8/QGMfE+qoBA4UFEqD7v1do0dCESm0ura9B1E?=
 =?us-ascii?Q?H7N0ZSMqqhTw69L5a+gv1305RvtrV7Jgc9F1EOygwhVZXexzD5ZFqC8kDcwP?=
 =?us-ascii?Q?HoILkWyNlBEYjes3yjK1qU+hDr1Z0Woh1xGqLzf6fl8Ly2YbTcE1upX+tdqq?=
 =?us-ascii?Q?ZzCJmpTJ53RikDlIMdn59VchnneV1J9aozdqPZ7f4fmB6Xu4P9h636eu3o6/?=
 =?us-ascii?Q?s6wNXyHla6Xrf/2OkrWv2fRFLDWWp1YsGRyQNCSHdOdQ3FRks/dpHPywdwYn?=
 =?us-ascii?Q?PZtoRBIb4/QdouWxexg1AFzvh7lzq9sP7nLpi3z7Mj2E/fO5vmStTC5v8jPE?=
 =?us-ascii?Q?QHm50FPRPD2R/b7ujusggPj/2jtSGE2m3neHpDf/qEjGCNKdhQjbg8HyO6gB?=
 =?us-ascii?Q?S4T0rxPM5DyQbO+QkpR864cJ1kco+B2Hb45xGDI/QcF3vkWUFULVBL7bJOwW?=
 =?us-ascii?Q?RdMvSq2g1NzyCbptyMKrDaKj4CFQzSn2iX4j/bzmDFZOPbOBdUWogeIb+d+w?=
 =?us-ascii?Q?B5+hRuFWnJPJELFAUd5hcg6jTMS0AHabWY4pMu6cYWkRQoXvpxnPs9S8cOkL?=
 =?us-ascii?Q?2FLmc7XW8fAlQp8rjDo3gwgbj6qUODq4I9u8PLM7kKcACacSsRBv92qvB8om?=
 =?us-ascii?Q?wzxqZISq+s2E0RZAJB6Hck/Sl6fjdt0RH+/ubnvynSpBKrarKGraRpy4wh3g?=
 =?us-ascii?Q?7PbjMjARZ6bFNKL+3T4BTcAzBe15+EN4Ym1m7qQ32UqVWpqRUjrYh1IXrEtR?=
 =?us-ascii?Q?a/BXNPlUHiqoIomZo+CvWo2peNUTcR5aS7e2tBxfLFuaGrxFZCjd9qX4Ol1f?=
 =?us-ascii?Q?X43WlfFxuWDDBd1neeZXR38LkTLRy7yKDtfpSTyJjYqz6UlnPJ9u+N7fPiSd?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a77998be-934b-4711-106f-08dbf59d7d89
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 14:21:36.9382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7i+Gd8Wgfwua67HF7WWv9SNb8lZT+1sRtb7xgsrPvn+5hBizMOYS5l+48fsu8YlrUWzN6UqBVrRSNDdcS6OltQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8495
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:at_kernel/events/core.c:#__do_sys_perf_event_open" on:

commit: 382c27f4ed28f803b1f1473ac2d8db0afc795a1b ("perf: Fix perf_event_validate_size()")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git perf/urgent

[test failed on linux-next/master 5eda217cee887e595ba2265435862d585d399769]

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-03
	nr_groups: 5

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202312052248.1270bdba-oliver.sang@intel.com


[   78.338247][ T3537] ------------[ cut here ]------------
[ 78.338606][ T3537] WARNING: CPU: 0 PID: 3537 at kernel/events/core.c:1950 __do_sys_perf_event_open (kernel/events/core.c:1950 kernel/events/core.c:12655) 
[   78.339187][ T3537] Modules linked in: input_leds(E) crc32_pclmul(E) led_class(E) uio_pdrv_genirq(E) uio(E) serio_raw(E) pcspkr(E) qemu_fw_cfg(E) drm(E) drm_panel_orientation_quirks(E) backlight(E) fuse(E) i2c_core(E) configfs(E)
[   78.340357][ T3537] CPU: 0 PID: 3537 Comm: trinity-main Tainted: G        W   E    N 6.7.0-rc3-00001-g382c27f4ed28 #1
[ 78.340938][ T3537] EIP: __do_sys_perf_event_open (kernel/events/core.c:1950 kernel/events/core.c:12655) 
[ 78.341261][ T3537] Code: ff e9 8c fb ff ff 8b 85 48 ff ff ff 83 ca ff 8b 80 c0 01 00 00 89 85 40 ff ff ff 83 c0 68 e8 c6 bd a2 00 48 0f 84 59 fb ff ff <0f> 0b e9 52 fb ff ff 0f 0b 8d b4 26 00 00 00 00 8d 76 00 e9 8a fb
All code
========
   0:	ff                   	(bad)
   1:	e9 8c fb ff ff       	jmp    0xfffffffffffffb92
   6:	8b 85 48 ff ff ff    	mov    -0xb8(%rbp),%eax
   c:	83 ca ff             	or     $0xffffffff,%edx
   f:	8b 80 c0 01 00 00    	mov    0x1c0(%rax),%eax
  15:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%rbp)
  1b:	83 c0 68             	add    $0x68,%eax
  1e:	e8 c6 bd a2 00       	call   0xa2bde9
  23:	48 0f 84 59 fb ff ff 	rex.W je 0xfffffffffffffb83
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 52 fb ff ff       	jmp    0xfffffffffffffb83
  31:	0f 0b                	ud2
  33:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  3a:	8d 76 00             	lea    0x0(%rsi),%esi
  3d:	e9                   	.byte 0xe9
  3e:	8a fb                	mov    %bl,%bh

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 52 fb ff ff       	jmp    0xfffffffffffffb59
   7:	0f 0b                	ud2
   9:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  10:	8d 76 00             	lea    0x0(%rsi),%esi
  13:	e9                   	.byte 0xe9
  14:	8a fb                	mov    %bl,%bh
[   78.342311][ T3537] EAX: ffffffff EBX: edfce4c0 ECX: 00000000 EDX: 00000000
[   78.342694][ T3537] ESI: 00000000 EDI: ec542a00 EBP: ec003f80 ESP: ec003ea8
[   78.343083][ T3537] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010296
[   78.343496][ T3537] CR0: 80050033 CR2: 00fd103c CR3: 2c684000 CR4: 00040690
[   78.343918][ T3537] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   78.344304][ T3537] DR6: fffe0ff0 DR7: 00000400
[   78.344560][ T3537] Call Trace:
[ 78.344744][ T3537] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 78.344979][ T3537] ? __do_sys_perf_event_open (kernel/events/core.c:1950 kernel/events/core.c:12655) 
[ 78.345292][ T3537] ? __warn (kernel/panic.c:677) 
[ 78.345521][ T3537] ? __do_sys_perf_event_open (kernel/events/core.c:1950 kernel/events/core.c:12655) 
[ 78.345833][ T3537] ? __do_sys_perf_event_open (kernel/events/core.c:1950 kernel/events/core.c:12655) 
[ 78.346146][ T3537] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 78.346390][ T3537] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 78.346640][ T3537] ? handle_bug (arch/x86/kernel/traps.c:237) 
[ 78.346884][ T3537] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 78.347142][ T3537] ? mark_held_locks (kernel/locking/lockdep.c:4274) 
[ 78.347408][ T3537] ? handle_exception (arch/x86/entry/entry_32.S:1049) 
[ 78.347690][ T3537] ? trace_options_core_write (kernel/trace/trace.c:9100) 
[ 78.348023][ T3537] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 78.348273][ T3537] ? __do_sys_perf_event_open (kernel/events/core.c:1950 kernel/events/core.c:12655) 
[ 78.348588][ T3537] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 78.348837][ T3537] ? __do_sys_perf_event_open (kernel/events/core.c:1950 kernel/events/core.c:12655) 
[ 78.349151][ T3537] ? perf_prepare_sample (kernel/events/core.c:7875) 
[ 78.349470][ T3537] __ia32_sys_perf_event_open (kernel/events/core.c:12388) 
[ 78.349776][ T3537] do_int80_syscall_32 (arch/x86/entry/common.c:164 arch/x86/entry/common.c:184) 
[ 78.350048][ T3537] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[   78.350307][ T3537] EIP: 0xb7f29092
[ 78.350510][ T3537] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   78.351567][ T3537] EAX: ffffffda EBX: 00fd14c0 ECX: 00000000 EDX: ffffffff
[   78.351983][ T3537] ESI: ffffffff EDI: 00000008 EBP: b7d54525 ESP: bfe50d08
[   78.352368][ T3537] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000282
[   78.352794][ T3537] irq event stamp: 2142597
[ 78.353037][ T3537] hardirqs last enabled at (2142605): console_unlock (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 kernel/printk/printk.c:341 kernel/printk/printk.c:2706 kernel/printk/printk.c:3038) 
[ 78.353522][ T3537] hardirqs last disabled at (2142612): console_unlock (kernel/printk/printk.c:339 kernel/printk/printk.c:2706 kernel/printk/printk.c:3038) 
[ 78.354001][ T3537] softirqs last enabled at (2110116): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:400 kernel/softirq.c:582) 
[ 78.354477][ T3537] softirqs last disabled at (2108059): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
[   78.354983][ T3537] ---[ end trace 0000000000000000 ]---
[   78.532811][ T3537] UDPLite: UDP-Lite is deprecated and scheduled to be removed in 2025, please contact the netdev mailing list
[   78.628053][ T3537] can: request_module (can-proto-1) failed.
[   78.632336][ T3537] can: request_module (can-proto-2) failed.
[   78.676101][ T3537] can: request_module (can-proto-2) failed.


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231205/202312052248.1270bdba-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

