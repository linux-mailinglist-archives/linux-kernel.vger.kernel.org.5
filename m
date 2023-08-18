Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD1C780DC2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377727AbjHROPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377772AbjHROOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:14:23 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20718.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::718])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB43468A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXFtuJ+JaTbRyq2OARZ8bUFX8tlJybO8wt0D2JRIq/rczIf42yC/3L4XIRgTzvOuMGtKcAyDs9XzOmSBCYuqxBZiq4+uduMTIgrsn5LtB7z3Z+S0fbcgRG2D6sC7clJFIV8yN52No1/mEiG0qlqHAmnFVq+az0aPtPsjLwL6Dm92ZSgdfiH9itfBBh7VpPnRVs42Hp9hN7MZr8i6Q2xr7I3lqOaeOjNVWt3jNXCXjBAujhsfU3sn/e12MHZKPjHX1lbog5gpeZW7GIOPSGmIV9e0rNecsLtrgOtsswD1TY9HPGtPxLPPCxo45V/Sz4XpygWhWyh0qBxse6pTE3ljog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+x7NMZe3jpPWg4ccp0E40XCj6RK/IVuZ+jCytBOU2Dg=;
 b=JeB1tkx++jkGRfPj06PduXWKTdYhMP/64inf1y5TchyC8dLvctkQqFuuSFcuT1Ki9Hr17lm6T3G2FDuYCMXQuveWhwFgTEIAjVNRrdjbxNfGKaOwydcFWyylEFg5N+ahPjkld+16j+1bViyYHZcqY/HpzarjvWL/YdGYTkpRISgPitM16p0FophmqnE6ANSLaj046myD+gum8t8AHiIvZGWlQ4ozXUIw4LVcucICCQCMUkP9Rfz0OxSPnVwYC61nNrM1rtrUjGEAL+rPzFk02/V8W2ZEc2KDzVlQ17VyjaNNAEj+rUle0+8691pjPYspwMJlje7S8uUfNPUU/KguOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+x7NMZe3jpPWg4ccp0E40XCj6RK/IVuZ+jCytBOU2Dg=;
 b=fx99227yKSmGMKOOCwLAvksbvGrHqT/qWqLdbm/WxVU2gEDg2k3phTtun6oDCxq10oQ7RmZXvMAq1HKZvztXoqDiWIMfIZXhnvclgYhqQ6NzAocuxu/zPRcTygQK+kfYhYTu7MiwYNPrS5V9sYQacsAxHkx3K6nWYUqI/YwgjJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB4780.prod.exchangelabs.com (2603:10b6:5:6b::16) by
 LV2PR01MB7647.prod.exchangelabs.com (2603:10b6:408:178::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Fri, 18 Aug 2023 14:13:56 +0000
Received: from DM6PR01MB4780.prod.exchangelabs.com
 ([fe80::1f9:1d97:19f9:40b7]) by DM6PR01MB4780.prod.exchangelabs.com
 ([fe80::1f9:1d97:19f9:40b7%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 14:13:55 +0000
From:   Carl Worth <carl@os.amperecomputing.com>
To:     linux-kernel@vger.kernel.org
Cc:     James Morse <james.morse@arm.com>,
        "D. Scott Phillips" <scott@os.amperecomputing.com>,
        Darren Hart <darren@os.amperecomputing.com>,
        Amit Singh Tomar <amitsinght@marvell.com>
Subject: Initial testing of MPAM patches
Date:   Fri, 18 Aug 2023 07:13:52 -0700
Message-ID: <87lee8l9pb.fsf@rasp.mail-host-address-is-not-set>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:610:4e::13) To DM6PR01MB4780.prod.exchangelabs.com
 (2603:10b6:5:6b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB4780:EE_|LV2PR01MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 69991793-be02-4265-a3ae-08db9ff55bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kikn/EzdUQAdB0coK7Jd4XRFtDaamz71VySqq/tYP5zH4yCz0JNFEsWHHRaBWZt5Cia8ICsS5dgih9BXeeD+uyB4R0LJel/go212n6pVoKGiO1eHblR1vZYEQlr4rhj4rcR/zSoTb8VXRQE/yWZY8t99C97XL7gFouxbFWhQp+KXwNkSFpn1knci3ZYp25pyUQjodHl/CYJDsH+vNQ7kdvAVbGcib8qH/zQvUbzyiL9qA5bOEc6FmtRgAjTCfXsY6S09E43v9pNUS24MSvX8EWQPQRoOacQ3kSydgeqI+6oHHIEgWHWyY+DhK1cHUWZq57Dgq/Y6IJtN0Z9cr8IVbwQQpfhK/4pZIHVX9oYzzhmUT8+w43DQbiVT51FamA0DtUzx7msPAc1ysaSzk66F0EnooWMAp9HFWhRp6ksz2emLax939+pSHZqwda0ywKErEP9nyLIMm5saIND0TjqSOP2nrFuJAQKcwjM+2Nl3iYs3NxJ/v4lu7KTTbJOU3E9+tHGCnt7hOhsQ+VJu13QeWyahApdBUKpif759vnuZmnrG81Ab6QuGMCwd69AgknYGSyhVjcsJkcY1LPy9z829ZSVfg9cxviPAQNlJtcmWQvUe1+CmDhtU4djI/r6uiMRbP4tBTvpeU1vw7272P4O+zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB4780.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(39850400004)(396003)(451199024)(1800799009)(186009)(86362001)(38350700002)(38100700002)(966005)(5660300002)(66556008)(478600001)(6506007)(66946007)(66476007)(6666004)(6486002)(54906003)(316002)(6916009)(52116002)(26005)(9686003)(6512007)(4326008)(8676002)(8936002)(41300700001)(83380400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IvhPZ2wH79BiBoWnZtbfGm7CjkEK32CpEpVvmskTeBeUtu0G3R7YVn7r8mx7?=
 =?us-ascii?Q?uvks2xHcbtdMlzpuogCh6dSEYocAUFm5kHta7I2Dp926NCMQHc88jUJMYLs0?=
 =?us-ascii?Q?uBN+AsndAg8gLSynxY8rUOv83am/7/abiKtvyatGg1e76U8xjRebf5C6R21J?=
 =?us-ascii?Q?ChPjgledoB9sMLEXlFcwNarSYyMDHSfKJ10jYZ8lGWtvwo1dwB7gVvEqYGre?=
 =?us-ascii?Q?Y1449rqrl8lHnR0HJFp+CCrzSO9elsYi51c2A9DWLSCUCndXWinvOv/OaQ5w?=
 =?us-ascii?Q?3ECjwJDtJ6mvVoYBoNUYF7zoXb9xJfpVcYUni2boRXxET4Pvf0QtND5NFlhf?=
 =?us-ascii?Q?i/02kO7j6GdXpgxi+U0AYUQtN5L58nrttWApkmEfz0+qC3Nr1+0bxzjTwGmK?=
 =?us-ascii?Q?6ju3ndSrM4oUBwYtyuB9oza9dB5yrkyM99Qojp0KRgZjsG8LdoIRWxxGJw7O?=
 =?us-ascii?Q?aFMj/SoIeCe0fZESSUficzVmZC4I1mwPLQ+l+YQL8ohGjhhvttovUwKxqhRk?=
 =?us-ascii?Q?ZhGLff5Ez6ko548jIfD0RKUUWlKFeYBkcyVBI3jpAuTshlzgo1cBrdrkHqUH?=
 =?us-ascii?Q?hMwfA6ryfuWe/cAIMP2PuLKrz54gulxLuORm7fxJ0n0/DX7v0AJWl7QmxaIF?=
 =?us-ascii?Q?wr911qi9yU/mghalWYKa5Ls5Ajuii/nfG0SKV6vq/1u/dzp6ffQnUybgHMH/?=
 =?us-ascii?Q?qmSOwJriAbTtv6bz3uhh0xL+U+RvOUcURULUW7/zmOBEMbJBWYDidpItWCKg?=
 =?us-ascii?Q?Irgv09NIuxD58GM5CGM04k2SzFaUvsrBYn8GMfgjlkLYh3xRdMEwY5R/uik3?=
 =?us-ascii?Q?RUtlJQXm0GKrau8W6Dbw3H2labl6J/BkYBklgXe6cQO0zbjxFVGnHZFQgffy?=
 =?us-ascii?Q?HZuSFT2iCMGxCFriXXHrjhwzJ8mlr3UC7x0nt7Ovgge2ynxFgGEX29BJAIlL?=
 =?us-ascii?Q?DZp6YSNiY6MMNJOViPlAjeyj3BMOJq4A5xR8w+R9sKkN6UJQosTPtuAr4y4V?=
 =?us-ascii?Q?pp0uxO7kOxFrOizS5FjcmGHSnWkTAR0RJu+Q3fnnAgUum/Yv+j9uGCKeDX1/?=
 =?us-ascii?Q?+wOSDWrVMsO3dnFQjSDqrw7ViiXwfnZyt5vRcCUSHN5/gWULnYh4IznWSBgZ?=
 =?us-ascii?Q?HLMvDgjHqrR/5m6I1RqTednjo+nvyAvvfNKz0z0Npb9uLLF/dbpgZM0LCqKe?=
 =?us-ascii?Q?NMcGnf6v6E/nyzVGIc0w6eKMmwmy4bMUgK6vX3sRlAGnAaVRwyGZRUocGY8P?=
 =?us-ascii?Q?LdS5ze/uyGAv4K7Hcl/uMJ56ANR454WryqFH4irK6pyThdkkgbew4n8UbYg3?=
 =?us-ascii?Q?p5bPpSBcGWLoNsSlnf7d1GbSaiFHtRtY1HWJW/8DakhKR3pkWE0M706/8j6W?=
 =?us-ascii?Q?AgZ6IziGHJWL8ugAUNZzgFRnMVHhuXX/4cW5LuW9P6yDVqgf87chlpMZW5z+?=
 =?us-ascii?Q?a/BXkC7Ft3u3Fv9nzLg0NwkTBVTSqjbYcsp3h5KhNW7RcOFksHQnp3dYUKsx?=
 =?us-ascii?Q?Ds8wgHlKsUQ5GP0uxDSRHAGETbdT35TWP46RzsafVQTvNYFotnfeo845K3k0?=
 =?us-ascii?Q?QjH/1wycPFJeCnmetFsLJNi5apvFbllUI+UCSYVOJVJyF4WEMs+4AfwT8Pni?=
 =?us-ascii?Q?50fxmiLbS1RNv4vDl+Vy6N4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69991793-be02-4265-a3ae-08db9ff55bb5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB4780.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 14:13:55.8934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WItFJ+2EJKIqz/Is+6siBWSEJ1HDBzDskKIJ6j0Y4nrGpG28ALZEyTjLECpSAFOGr7Gz9gA+5097TrFZIZGqHvwdSA8tAOj1l1uJGkfnd+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7647
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

I'm just getting the chance to start testing your MPAM patches on an
Ampere implementation. Specifically, I was working with your
mpam/snapshot/v6.3 branch [1], an earlier version of which you posted to
the list [2].

I have a few initial comments/questions. These are mostly from a
black-box point of view, (without yet having looked at the code
much). Later on, when I do dig into the code, I can follow up on some
of these issues within the context of the relevant patches.

1. Is there a way to query the MPAM PARTID for a particular resctrl group?

   I see a file named "id" in the directory for each resource group,
   but I get "Operation not supported" if I try to cat it. Meanwhile,
   in the code it looks like PARTIDs are being XORed with some random
   number. Is there a deliberate attempt to obscure the PARTID?

   I don't know how much an end user will care about PARTID values,
   (so it's nice that the driver manages these implicitly), but for
   me, while debugging this stuff, it would be nice to be able to
   query them.

2. Top-level resctrl resource group is not being made to take effect

   When I poke at the schemata of the top-level resource group, I can
   see that it is associated with PARTID 1. That is, if I do something like:

	echo L3:1=face > /sys/fs/resctrl/schemata

   I can see the value 0xface showing up in the cache portion bitmap
   registers associated with PARTID 1. So far, so good.

   But meanwhile, I am not seeing the MPAM0_EL1 system register being
   modified to associate the various cores in this resource group with
   PARTID 1.

   In contrast, for any lower-level resource group I create, I do see
   MPAM0_EL1 being set with PARTID values for the cores that I put
   into the 'cpus' node.

   So it appears that PARTID 1 and its top-level resource group will
   have no effect currently. Am I seeing that correctly?

3. Is there special treatment of cpu 0?

   When I put cpu 0 into a resource group I see both MPAM2_EL2 as well
   as MPAM0_EL1 for cpu 0 being set to the group's corresponding
   PARTID. But when I set any cpu other than 0, only MPAM0_EL1 is
   being set for that cpu. Is this the desired behavior?

   I know that PARTID 0 is treated as reserved by the code, but is cpu
   0 given any special treatment?

4. The current schemata allows for cache portion, but not cache capacity

   The schemata file allows me to specify a bitmask to control
   cache-portion partitioning. But I don't see any mechanism (nor
   backing code) to control cache capacity partitioning.

   Is this due to a limitation in mapping MPAM to the current resctrl
   interface? Or would it be easy to extend the schemata to include a
   cache capacity field as well?

   I see that Amit has proposed patches recentl for extending the
   schemata to add priority partitioning control. So I'd like to do
   something similar for capacity partitioning control as well.

5. Linked-list corruption with missing cache entries in PPTT

   At one point, I tried booting with the MPAM ACPI table populated
   for my L3 cache, but without the necessary entries in the PPTT ACPI
   table. The driver fell over with linked-list corruption, halting
   Linux boot. I'll follow up this report with more details.

6. No support for memory-side caches

   MPAM allows for controlling memory-side caches, and the ACPI
   specification allows them to be described. But the current code
   appears to ignore any such caches, and won't expose them via
   resctrl. I'm very interested to know what work would need to be
   done to allow a memory-side cache to be supported.

7. Cache portion configuration for incorrect PARTID is applied

   I've seen a case where, when trying to use a PARTID other than 1,
   (that is, a resource group other than the top-level), the
   configuration I've set in that resource group does not take
   effect. Instead, the configuration for PARTID 1 takes effect.

   Querying the controlling MPAM registers does not obviously explain
   the buggy behavior. Things look correct. I'll be examining this
   case more closely to see what's happening.

So, that's what I've encountered on an initial look. I didn't call out
all the things that are obviously working well, but there's a lot
there. So that hasn't gone unnoticed.

Thanks again for this series, and I'm looking forward to engaging on
it more going forward.

-Carl

[1] https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/snapshot/v6.3
[2] https://lore.kernel.org/lkml/20210728170637.25610-1-james.morse@arm.com/
