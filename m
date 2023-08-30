Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF14878DBA3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239507AbjH3Skd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242107AbjH3HSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:18:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AFD1BB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693379889; x=1724915889;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bEC95kmrRfDnF6sXJ23+UxDi5LeoeDr2vEKA6qVHoYc=;
  b=EJAriUP/0ZXbiyG84eirBCgLLuL4CeOOIdUk9+7tAL/CZVIkFixniaPz
   eiAPUK0wTTXj4V28fI6qdczjBTO30eP0gFaPc4Ic/e3V2krVdl53a/rKE
   4APzwAY/ngs2vETxFW2WtgW5qBBExsftjU1XS8eUW2AS6tJCgMO+iEUwD
   cb+StQ1wG17waNcAu49ZHrf/yyPM/nsSZY+f7UNWpw3vmWW3se00J6fEN
   dgxKqHm88xGTJfJeBnwXL9mFA0HpVKa4ljaBMlAv+hppf6q7Lhl4Pk9ym
   HxodqctBVdkHcHoTQDxT6ZYKRLc41odNUxQlKuWqSEjsGwXQXyG/D67qN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="379323968"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="379323968"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 00:18:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="853621137"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="853621137"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 30 Aug 2023 00:18:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 00:18:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 00:18:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 00:18:08 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 00:18:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaX/taTWGq9huKDLJo19Z57aVdruDL/GQjxiTuYkQlJgIsxYyM+0UueK6OqpYPsA18XSg5OTQLM2V/GU7prHucSRhygpkTa0/uqoL2bW6VZUClpmrKihm5WqdDbiyKf40QIpOleCRfs4GRdFXJMjsQAGLlEbQ5vEWvvxTUOTiAwy3S2R5W5wBuHfE1Nzy4tZxy3NP2TGaphWsist0orXXRZLXGL5Grk2tUt949DCYtUsUpzDPbvA4NoxKHdDewTJLy9FDZyi+U5k2qk3MRjLRWfwbvsmlmRj/8KE//pmNGZEc/K/THH9+Vx0YJLzYzolJdxWVDbwS50Dvfdw4gK7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CppWgAtkkqBa97pTpZnP1dkz12EPwFEIb7zXgJEcJmw=;
 b=Z4cIAgN4TeJf7FCB004jwMCQzZA/RweW+0nUTpfmG6Vjsll4dv/zcEgbpQ9+yY0JTjlm77ST68UDMrwnQconngTXUP17/YzlznemSVE8IPK4naeBfSKTEqE/J8Qb87iKw3/E9hkP8XUTSrhy3tXU3/vV2tbrFEryQDgH3at12OQHumxRfKPYiTFXmEpCtm7ZaW+wJ4g5Kn6kO86IwgxuBito9DAdIpPtDKDqcC1OaPRa5MeAl7pFdPtJ+VijGYtXrTYUvkDkAaBhki4CQuvyHpiFrZrXxDHO0yRptJCdykGWqyv/t2RlJ74qH5fAqVH+s2EFWurG3hO2djNyBzgB4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CO6PR11MB5571.namprd11.prod.outlook.com (2603:10b6:5:35f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 07:18:06 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 07:18:06 +0000
Date:   Wed, 30 Aug 2023 15:17:56 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [objtool]  6342a20efb:
 WARNING:at_arch/x86/kernel/alternative.c:#__apply_fineibt
Message-ID: <202308301532.d7acf63e-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0188.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::10) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CO6PR11MB5571:EE_
X-MS-Office365-Filtering-Correlation-Id: 358be269-5130-4ef4-7f44-08dba929414d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g1fDLuyP5oo2YM5Zl1ePf/VUyGPt7wviB2zIBbBhe5wx11Xd0YKv/s9UUAXmKf1Tai6EzQl30KPamGkDtyCLrwv+z+grym/S37hNkwaPk2aY7fUDMCy4CtNdDQIr9PKucggtyLBOzXc2Dq9k85OUDGck+YcD12a81kVKK9rHQj8hQccQ1lnXZRA+MPgrU6NeERGBCZNYLVE+oXavscUXJnlgNvRPCGzVRAHUYR++LbQbKMxQpbnQnmjRVeI9/E0XT8H+wjpqqfTf35KRcrOcjTRmfv0qQNAaVTQbW3LhiQm2td6eGj+Js91wA9gRlcqxZ/prwKTXY10yL1SXxqScSxbY8t4tW0CBVJkZiSKV0/eVVYuMcg+JF1ZhqihUSFNl5i5cTuXXwX3UVKluTeVYNddMC3VnIQpS8AwSMlo77YszLYEfhiujukv3PW3M72HWgWGhK/pJ508qdWU1I3oefKZB/KGcHIn0bfh7phY1rrESsoQ6xKkWzrvoExM/x+9bRrCmjK0bMuhE+y2f2JsCmR8UBmLm1eBQCeoON9l2U1UQ7wnR1uSXGgUP5E5Vs5VudbOXj593HxVlPms7sj4XAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199024)(1800799009)(186009)(5660300002)(316002)(6916009)(41300700001)(38100700002)(66556008)(66476007)(66946007)(83380400001)(6512007)(82960400001)(478600001)(2906002)(8676002)(4326008)(8936002)(966005)(45080400002)(86362001)(6666004)(6506007)(6486002)(107886003)(2616005)(36756003)(26005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8r57JnQ3ic6z91ZFOBpa3F+cUzbZ6joXvcztUP4iM3qJHfEaNJK9cX9CSktg?=
 =?us-ascii?Q?eod6cJcegEs7yxaIFkkBQvSb8jaINLIfR6yIA2oeETuGpLp4s3f7mWrKTC5i?=
 =?us-ascii?Q?jO0jz7KdW6eQkUREAHlNvHkrDJeue0y4dJtDxzbpYpGqbua9Z133xOH7LoAb?=
 =?us-ascii?Q?NFuNXgVnpugOkjQ6xR/0Ks/CwYm2AjDTtSAODp5g91aUe4yxMu9k5duP5zNQ?=
 =?us-ascii?Q?8U5UmxmI5WWxh2AnwygttiBHiICbEXQK0+nuU7HBb4aGmCOvOU37DDGWjrpA?=
 =?us-ascii?Q?lg6P+P0LAHdJ2oNQGpnUpp609Wc7aN9awip+8LBQV2OFEm5e7Pi2PFjbOguY?=
 =?us-ascii?Q?3RSJkzsNn+JzGWuxXCueHipEXqo7gatiEacvb14HucaFGLUXkMXX0AMXFYPh?=
 =?us-ascii?Q?EJTLuEegXDKiC8aNrxHE9S0ayh6CaEeIWF8+5X1moJN3XKyfvV6XNHxBI0tk?=
 =?us-ascii?Q?jVcF6dmfTAK3yvOun69Fe/7Qh34zWMdqM9G4l7ivNBpLu3++Hj67TBnG0xLZ?=
 =?us-ascii?Q?vt8atuDNNukvKIHD/SmdnFvNOH2JWYQKzKlOcDUMtqic0YRyC/BvNrLQ6Czw?=
 =?us-ascii?Q?3qPp28GhAjd478S3V91HaB+7XNgWS61Ut4b69WdGyWYpBuW8DQ5j9t/8HCFb?=
 =?us-ascii?Q?nReQ9VgVlJrRR4kFZNVNmUw4Bme6g72tkEiaIwPuVJwndN+osuHHz6jaP4T8?=
 =?us-ascii?Q?AGYWaiPAAYDVkbg4v4+T/FTcK4FBhUa2ZbMLsuzCnhOqrM7xbP22PkDf3b8h?=
 =?us-ascii?Q?YW8VoI/huzCAx0xymv7AMxJW6vzdBbgHQm7dErkrbeS7kSWQRfN/z2YxBHI/?=
 =?us-ascii?Q?AN10FnDTqH+A2015eWyZBa0p/bxPPhs6f+fzqEJugcBfVEXPczCXLAZwG76J?=
 =?us-ascii?Q?ajxdbFSBcSlevvxtmxiJl+2/zWe+tERhfzBDSy4NiiqtMEW0ZbsOVWeVs8Co?=
 =?us-ascii?Q?+UZSrsNf06S89GdiGQto5Gmpc4eO+jn2Z1VowaoBQf/2RL3hdormBn6BF0eq?=
 =?us-ascii?Q?eI+OV9UCvWR86WiFBaBZeOkncvtVtXMbJYyerKopz+C6DzZGSkZwIFPDxgXY?=
 =?us-ascii?Q?jZJTeuSAS1FFrXB5EaX+z2l5X3I6D6//1FP9mrV4//+vqmKYHfJ85Qap3oJK?=
 =?us-ascii?Q?DFhXm390lYGvpxL9xZz5zz8cD/qPeNdNHEhnyqdajZ1QIIQ2j4N5kxjqRUn1?=
 =?us-ascii?Q?dim9wuvH9djkI1Q1x5RZrBAK2AavJyZD7NB/3rhfjQJHnNCRlDx9TBB878T3?=
 =?us-ascii?Q?zHoY4YeDU9+VYMBGlr5X8tnzhTqSCAwod3DdqB4UTru0eiOo7zv5TW9ucqTa?=
 =?us-ascii?Q?qfy+HREuqEOpY6qm3Zrs1Mo0IXUzuIVFW/2CCILmDuesW4NLGIqYMVxaojud?=
 =?us-ascii?Q?WDdNmfMC5qLhdfdkR7tWZv19w2hiWKwjSHw3FIEG5fecGHCEFACVw3HcaSlq?=
 =?us-ascii?Q?BzaYREx2BBiHZxwQ/9ifn3f/vo7zABrx/0gYSs0K7nmat3RjczWk1lm26nKT?=
 =?us-ascii?Q?JzUqXskkRPf8ajJBADx96VXefl1YQqJPJshqS3TonRlfrHCg8DxlyJvIAIfw?=
 =?us-ascii?Q?oxQu/50nYY/FCVpadrmK/FcD44gR0pZeDZ7oEk2QY2KM/UZsbT/DVKA2xIRo?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 358be269-5130-4ef4-7f44-08dba929414d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 07:18:05.8806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cf5gn9SDZYOVI+1WqKNVGwASsr70i8PNULBId91eFsIFvvl9RWIO17iTla/vkLQKFoVdLRhBjyhHP6FjXWriIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5571
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

kernel test robot noticed "WARNING:at_arch/x86/kernel/alternative.c:#__apply_fineibt" on:

commit: 6342a20efbd8b70d169c325b2c27a8a8f96388d5 ("objtool: Add elf_create_section_pair()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 7d2f353b2682dcfe5f9bc71e5b61d5b61770d98e]
[test failed on linux-next/master 6269320850097903b30be8f07a5c61d9f7592393]

in testcase: boot

compiler: clang-16
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308301532.d7acf63e-oliver.sang@intel.com



[    1.953072][    T0] ------------[ cut here ]------------
[ 1.953439][ T0] no CFI hash found at: __call_sites+0x2bedc/0x2cbd0 ffffffffb2e29344 00 00 00 00 00 
[ 1.955319][ T0] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:912 __apply_fineibt (arch/x86/kernel/alternative.c:911 arch/x86/kernel/alternative.c:1012) 
[    1.957432][    T0] Modules linked in:
[    1.958156][    T0] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G                T  6.4.0-rc2-00026-g6342a20efbd8 #1
[    1.959951][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 1.961436][ T0] RIP: 0010:__apply_fineibt (arch/x86/kernel/alternative.c:911 arch/x86/kernel/alternative.c:1012) 
[ 1.962557][ T0] Code: 24 3c 00 74 5a 48 c7 c7 40 06 22 b1 eb 4c 90 48 c7 c7 20 07 22 b1 48 89 de 48 89 da b9 05 00 00 00 49 89 d8 e8 9c 31 14 00 90 <0f> 0b 90 90 eb 23 90 4d 01 ec 48 c7 c7 20 07 22 b1 4c 89 e6 4c 89
All code
========
   0:	24 3c                	and    $0x3c,%al
   2:	00 74 5a 48          	add    %dh,0x48(%rdx,%rbx,2)
   6:	c7 c7 40 06 22 b1    	mov    $0xb1220640,%edi
   c:	eb 4c                	jmp    0x5a
   e:	90                   	nop
   f:	48 c7 c7 20 07 22 b1 	mov    $0xffffffffb1220720,%rdi
  16:	48 89 de             	mov    %rbx,%rsi
  19:	48 89 da             	mov    %rbx,%rdx
  1c:	b9 05 00 00 00       	mov    $0x5,%ecx
  21:	49 89 d8             	mov    %rbx,%r8
  24:	e8 9c 31 14 00       	callq  0x1431c5
  29:	90                   	nop
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	eb 23                	jmp    0x53
  30:	90                   	nop
  31:	4d 01 ec             	add    %r13,%r12
  34:	48 c7 c7 20 07 22 b1 	mov    $0xffffffffb1220720,%rdi
  3b:	4c 89 e6             	mov    %r12,%rsi
  3e:	4c                   	rex.WR
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	90                   	nop
   3:	90                   	nop
   4:	eb 23                	jmp    0x29
   6:	90                   	nop
   7:	4d 01 ec             	add    %r13,%r12
   a:	48 c7 c7 20 07 22 b1 	mov    $0xffffffffb1220720,%rdi
  11:	4c 89 e6             	mov    %r12,%rsi
  14:	4c                   	rex.WR
  15:	89                   	.byte 0x89
[    1.965434][    T0] RSP: 0000:ffffffffb1e07e70 EFLAGS: 00010282
[    1.966532][    T0] RAX: 0000000000000052 RBX: ffffffffb2e29344 RCX: ffffffffb1f1c8c0
[    1.969432][    T0] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffffffb1e07c88
[    1.970910][    T0] RBP: 1ffffffff61d554a R08: dffffc0000000000 R09: fffffbfff63c0f92
[    1.973428][    T0] R10: 0000000000000000 R11: dffffc0000000001 R12: ffffffffb2e29344
[    1.974925][    T0] R13: 1ffffffff63c0fce R14: 000000005f1e3d74 R15: ffffffffb0eaaa51
[    1.976476][    T0] FS:  0000000000000000(0000) GS:ffff8883af000000(0000) knlGS:0000000000000000
[    1.977434][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.978660][    T0] CR2: ffff88843ffff000 CR3: 00000001f266d000 CR4: 00000000000406b0
[    1.981432][    T0] Call Trace:
[    1.982066][    T0]  <TASK>
[ 1.982649][ T0] ? alternative_instructions (arch/x86/kernel/alternative.c:1387) 
[ 1.983721][ T0] ? check_bugs (arch/x86/kernel/cpu/bugs.c:209) 
[ 1.984570][ T0] ? start_kernel (init/main.c:1084) 
[ 1.985435][ T0] ? x86_64_start_reservations (??:?) 
[ 1.986463][ T0] ? x86_64_start_kernel (??:?) 
[ 1.987445][ T0] ? secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:370) 
[    1.988620][    T0]  </TASK>
[    1.989432][    T0] irq event stamp: 115689
[ 1.990218][ T0] hardirqs last enabled at (115697): __up_console_sem (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 arch/x86/include/asm/irqflags.h:135 kernel/printk/printk.c:347) 
[ 1.992045][ T0] hardirqs last disabled at (115704): __up_console_sem (kernel/printk/printk.c:345) 
[ 1.993434][ T0] softirqs last enabled at (115720): irq_exit_rcu (kernel/softirq.c:664) 
[ 1.995111][ T0] softirqs last disabled at (115713): irq_exit_rcu (kernel/softirq.c:664) 
[    1.997428][    T0] ---[ end trace 0000000000000000 ]---
[    1.998438][    T0] SMP alternatives: Something went horribly wrong trying to rewrite the CFI implementation.
[    2.005482][    T0] Freeing SMP alternatives memory: 44K
[    2.006670][    T0] Running RCU synchronous self tests
[    2.007663][    T0] Running RCU synchronous self tests
[    2.009408][    T1] smpboot: CPU0: Intel Xeon E312xx (Sandy Bridge) (family: 0x6, model: 0x2a, stepping: 0x1)



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230830/202308301532.d7acf63e-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

