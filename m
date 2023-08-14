Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5721F77B42F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbjHNIbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbjHNIa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:30:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC6993;
        Mon, 14 Aug 2023 01:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692001858; x=1723537858;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tpqYfyrY/WBvNKI0SwV8RB0h2/WDuoMKmHozsdq3XPE=;
  b=YBt+U2bLFGLEgLZx1bJGDedORQPpWS2t7B31nITDamOojN8GC2HdXlYm
   iUPub4hGGGykhU9/g+Fa0OcFlD2Sr1VM4XZqz/HvN4Ib34HF8szlRJnc4
   Jf8iLdrAQxnfE9wgVqJ5/Cca6+zF+2U9+IgGYE2XdeEt4ryUklcKt4OXT
   NWdFo4AOROf3V+umfTBBDjBgTuR6duzje3kkK1amL193Nc2AMG4WXO2bU
   t89VLRMv9frNFK3Qq/sNpJILw1zMfPY23W/zYFEeYyQZy87zu6UFrHaxO
   DCnfacu1whQDiws3mIWnKLCER/iedJs48vqC1hiWze8ymLjEN2odo0Okf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="402976627"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="402976627"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 01:30:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="710246846"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="710246846"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 14 Aug 2023 01:30:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 01:30:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 01:30:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 01:30:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 01:30:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkR+e00UBdQh/GU2uf3TsTLHxswTIaLoSa1OlHBcUqE3R28PDtIHv+mUIMkU2yY+3Z/21rfFTZ5voKDS+cdxoqSqhjSSiDuvmeDco1neIhhrHMtyl3AarGWLv7TeF25eo9t/Hy4Vfc9p1ZU9GvDFUADMCsE1DwPyVd2sPHMX0PdYQs9iJIk3IkCOFhcq9LGzaIjjPM05Bmev8Ap78g6amc7br0PMeMrE2kD0pCstZKzh1QWrFvo7duXnR3bo0AY7CM8BzjnuwwjjdgvEFHOCo+5/uRa/MwFwohIJVf1OP4oT/gxOTseoyEu7YKC6eGTY1GE4NK2oJcSJc2UgG7H7Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98uKPgPAHZjODDdsH/r1+oKzdy7nwGS2l0xFna8ccwY=;
 b=Tt25My8AkI9twABJymuVns/hXHk0e/UGwURNpv/g1Q4g00jXKsjhop147V1aADLfO+3AmzP10I2yIF163VP4l+ZK6ypSVz50Nrbxe6Bdpw+zEmh2nPKxqOVKazE+cv1swzx2Xe6dQpZ2BUle1D3yrHTEoPzxqid1L+CPk1PBaOkY4uV39GwkfOKu49v8k9L5U+VZnNT3KE7lg1Ou2G31B4oD6p852dpIf/4d/IrkTVLY4NRgxet16Tw+a9bHp2xS2vtRPZeSXFe5cEJXumdvQCZUJYLXhdWsBDMiBGHtApHAI+mIoLzx0LdxN6WeT1li86vS+EC1FLmHixSQM1ZEQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by BN9PR11MB5290.namprd11.prod.outlook.com (2603:10b6:408:137::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 08:30:55 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 08:30:55 +0000
Date:   Mon, 14 Aug 2023 16:30:45 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <oliver.sang@intel.com>
Subject: [linus:master] [x86/srso]  fb3bd914b3:
 WARNING:at_arch/x86/kernel/alternative.c:#apply_returns
Message-ID: <202308141043.79d160a1-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|BN9PR11MB5290:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ddb301-6875-4bb8-c0f9-08db9ca0c6db
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aiT7gAQpsJzprBViL7CYT5LRbeGNKpuTgikxSa8V/0Y8Btdb2F1uS8MqFdNFB+/II7uri1Iju4AQuGiQ5lIggBPMtFPGYrulgzxu/MiQEHibxffDhSO4cLMi7uNHXfBRFpeIUFrsWxfiTj9R4WFBV1xJ7JSu7BeAY1KVQDMJYOGTeBakHL1xQ96P4LvmzOjrmKuSNOzYo50JRsUROWKtkVrwck44bQmkAvlbnDPjERi9SvVbLDofF5Z23RvGI/kXqWi62/env0YmVu+7WXteoUXk07+pAn4RQQwnHBNDHxU0m6XPH//oekpnetudMqhVln5wUWmrAYkJcwhl+UHvmZahFFyCk+JLHc3guj3QXJsntOKVmK6LuRH4h5TvSjfup7FenTADc+F7kYoUp2xnpU4EvRJcrLsSbLhQEZjGTvNdrzs/LFsTjNo+OnMcyzzGHL39wia7lQnjTaO4Uziww50xymErN1E0QvPqWjdrcMTt1T87M2vQAjVRjKTsicq7FHXvWn2+B2DMojPBq19ii8fhVesVQlp1+U4rXsJ9/+S3G6bDmM/tmW8EcmTiJAUTV26TNtH0C6fRqlmP1byBAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(1800799006)(186006)(38100700002)(6486002)(6666004)(478600001)(45080400002)(82960400001)(5660300002)(2906002)(36756003)(86362001)(6916009)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(107886003)(1076003)(6506007)(26005)(83380400001)(2616005)(6512007)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U54nCDWFAKUp5pazgP6/sedHM9TBbjZ7Ixz4vEM2aynuX5xK5uqfQyFXhcV5?=
 =?us-ascii?Q?pTXF92B7mJc6o82owu0RlE1BGPxHaqCmHorKCsc65kGbWW8HJfjvGVZMuEKy?=
 =?us-ascii?Q?QekOxj2gY3Q0wLJUqtKszB8WajpAbEqemSXFUpwisWKMMJsUmjIBC1iEGtkv?=
 =?us-ascii?Q?a8nnNzYefTcegcfTokeEMD1t6EyKeXH6Y4Dkuw/8mvdYdMZJj9ViJPPLx7xj?=
 =?us-ascii?Q?akRpPIthc+QqTYkVTD8jn4zCos5GU0uRsvMRcd3jjLnRb3SxtWyV/sXdQpmF?=
 =?us-ascii?Q?SCwGi45yfn0eibbGwaF33ALhTtfCniqW5+x7TlBY0ryiyMrJJZ1fgWQ26u7c?=
 =?us-ascii?Q?WiaOomkVsqB5H4oS7Nn6sH2U0U52bDhx1JSS0QmKrivQc5eSj2iwkcnf1f+p?=
 =?us-ascii?Q?ZT8GkOQraQEObxmPoAzGHUUE+EZhwsbPpGsOqhCc2DPaYcLvKKYjYYMYleLF?=
 =?us-ascii?Q?dQz1Oy2qEkyU93l7jjZg/8WCaROWkbV9ulffGHM+kF24tRl02uZJStLt6fWs?=
 =?us-ascii?Q?LJ1cNC9FMXMsAjBUSgjY10AIDgSAI2Km4EFAIEir2DyC7DFWtBIjEhXf3l8+?=
 =?us-ascii?Q?EH+OxzQva14IrlVqrvcPfJ+WZtfCJy+qrwn2BzuMQoNAOXV68rT2pw41OEbK?=
 =?us-ascii?Q?MdHaxnQEpeOHGNB3knGkzZDz2Q8hrKZTZj3afYdGMQpu5NEOs7VlzMUyEHQf?=
 =?us-ascii?Q?HoOCfE0xin+FsmG48TT12AatvKbia06WVFnKF2jSygk3TaTmpRfUImh8NpBD?=
 =?us-ascii?Q?v5uqb0Rpo6i9RHy67pDKdOfn8tr5Lxec4nDzK9BNsoxoT26ijsZwIRRNBW35?=
 =?us-ascii?Q?zsCdcMdo0M6ooPSIhTo9a4YIkFXdRyNfMyxoZOMMnIo4AJ4gN+oA2LvuldGP?=
 =?us-ascii?Q?aczchWNVOTGrxDHTNOJfaLpCirqB2sehikPt0XC9M3b1aylGoTZmLH5rFX3D?=
 =?us-ascii?Q?8B9N4BKDwYumbStuGwzBB8fiumBNbXq5cyO9m3SDdLYyulCTgf19SiviVC13?=
 =?us-ascii?Q?KWYaroOcWZ0MkxwS5OHOL+/smZp/ENMcTYRQKNJbe2fOJ+qL0zgnx9iMGhtc?=
 =?us-ascii?Q?HNVVKg/SSLcttqfejvQsDab35mKZPt4mRCZekTRqIJc9VJnpS+XWaOQ26FcV?=
 =?us-ascii?Q?DR/xEFpzsMSqrFVq3OyGmP5cp/HUhekzcZHgD4VDt6ovrq3IYejt1eiPhJbP?=
 =?us-ascii?Q?5VWqbHBKWOxgt4y16/S9LuLb4RjbFvtwAMkbhe/B3W96WRBfO1/s3DzkWJkr?=
 =?us-ascii?Q?v2g2soM1uqydTOG8aZIsnSA1wC0cGdUAyvVH8NAT2Z6dKrG7l1DjfzAjhgmE?=
 =?us-ascii?Q?oPgy5eZu0H/n/kd23sVrnubitIumyle/FnfxUhblTk92JP9vHUIv5h8oiN58?=
 =?us-ascii?Q?5QKYyNG35eMX1ea8INuZEwPbLluLyiidiJsSaFInYO3UTpS+NOIwy5DMCpWU?=
 =?us-ascii?Q?9pWGoYyCAMjxNKU9FQjJ7qlJ2WrgX5m5LTvZ9SEoAx8Z3b9GXrEQmtyPuyyq?=
 =?us-ascii?Q?BQkgMXYop4iPq5a2z3J7jJ1GwaqszGJPkJoXumpcyXRhspAjFny74QqbTLKe?=
 =?us-ascii?Q?T/DHQqk/bDC6YOp/sTE2Z9MOjTYNKofnqQOnWqkxk7VOK+/zRmN+q/zVPOvo?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ddb301-6875-4bb8-c0f9-08db9ca0c6db
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 08:30:55.1087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQQDiKsWUFpwEWOQeVgRoO37MD6Uy/IRJfT8SZ7P33fmDMspFzPW2Zh0IAWCsZ9/v/2Ts7vilYaxRAMs0MyXNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5290
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:at_arch/x86/kernel/alternative.c:#apply_returns" on:

commit: fb3bd914b3ec28f5fb697ac55c4846ac2d542855 ("x86/srso: Add a Speculative RAS Overflow mitigation")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master v6.5-rc6]
[test failed on linux-next/master 21ef7b1e17d039053edaeaf41142423810572741]

in testcase: boot

compiler: clang-16
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308141043.79d160a1-oliver.sang@intel.com



[   13.866672][    T0] ------------[ cut here ]------------
[   13.867512][    T0] missing return thunk: __ret+0x5/0x7e-__ret+0x0/0x7e: e9 f6 ff ff ff
[   13.868538][    T0] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:755 apply_returns+0x351/0x700
[   13.870993][    T0] Modules linked in:
[   13.871543][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.5.0-rc2-00002-gfb3bd914b3ec #1
[   13.872689][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   13.874057][    T0] RIP: 0010:apply_returns+0x351/0x700
[   13.874615][    T0] Code: e9 4d ff ff ff c6 05 15 cc 49 03 01 48 c7 c7 60 bf 01 83 4c 89 ea b9 05 00 00 00 90 48 8b 74 24 08 49 89 f0 e8 50 97 0e 00 90 <0f> 0b 90
 90 e9 1f ff ff ff 4d 85 ed 0f 84 4c ff ff ff 48 8b 74 24
[   13.877395][    T0] RSP: 0000:ffffffff83a07de0 EFLAGS: 00010246
[   13.878236][    T0] RAX: 0000000000000000 RBX: ffffffff82d32545 RCX: 0000000000000000
[   13.879355][    T0] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   13.880389][    T0] RBP: ffffffff83a07ed0 R08: 0000000000000000 R09: 0000000000000000
[   13.881461][    T0] R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
[   13.882527][    T0] R13: ffffffff82d32540 R14: ffffffff846e9a58 R15: 1ffffffff0740fc9
[   13.883644][    T0] FS:  0000000000000000(0000) GS:ffffffff83ad5000(0000) knlGS:0000000000000000
[   13.884632][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.885529][    T0] CR2: ffff88843ffff000 CR3: 0000000003ab6000 CR4: 00000000000406f0
[   13.886637][    T0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   13.887727][    T0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   13.888814][    T0] Call Trace:
[   13.889281][    T0]  <TASK>
[   13.889711][    T0]  ? show_regs+0x5b/0x70
[   13.890324][    T0]  ? __warn+0xe6/0x1f0
[   13.890942][    T0]  ? apply_returns+0x351/0x700
[   13.891612][    T0]  ? report_bug+0x15f/0x380
[   13.892229][    T0]  ? apply_returns+0x351/0x700
[   13.892920][    T0]  ? handle_bug+0x42/0x70
[   13.893544][    T0]  ? exc_invalid_op+0x1f/0x60
[   13.894618][    T0]  ? asm_exc_invalid_op+0x1f/0x30
[   13.895327][    T0]  ? zen_untrain_ret+0x1/0x1
[   13.895941][    T0]  ? __ret+0x5/0x7e
[   13.896491][    T0]  ? apply_returns+0x351/0x700
[   13.897131][    T0]  ? do_nanosleep+0x2ae/0x380
[   13.897766][    T0]  ? __ret+0x5/0x7e
[   13.898332][    T0]  ? __ret+0x5/0x7e
[   13.898872][    T0]  ? __ret+0x14/0x7e
[   13.899433][    T0]  ? __ret+0xa/0x7e
[   13.899974][    T0]  ? unregister_die_notifier+0x17/0x30
[   13.900751][    T0]  alternative_instructions+0x4b/0xa0
[   13.901514][    T0]  arch_cpu_finalize_init+0x3e/0xb0
[   13.902220][    T0]  start_kernel+0x2ff/0x3c0
[   13.902833][    T0]  x86_64_start_reservations+0x3c/0x40
[   13.903624][    T0]  x86_64_start_kernel+0x63/0x70
[   13.904627][    T0]  secondary_startup_64_no_verify+0x102/0x10b
[   13.905488][    T0]  </TASK>
[   13.905909][    T0] irq event stamp: 110211
[   13.906494][    T0] hardirqs last  enabled at (110219): [<ffffffff8121f433>] __up_console_sem+0xa3/0x100
[   13.907867][    T0] hardirqs last disabled at (110226): [<ffffffff8121f418>] __up_console_sem+0x88/0x100
[   13.909256][    T0] softirqs last  enabled at (110192): [<ffffffff82d31d74>] __do_softirq+0x4d4/0x631
[   13.910544][    T0] softirqs last disabled at (110185): [<ffffffff81148b49>] irq_exit_rcu+0x89/0xc0
[   13.914615][    T0] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230814/202308141043.79d160a1-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

