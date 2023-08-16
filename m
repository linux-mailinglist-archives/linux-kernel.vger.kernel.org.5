Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C1477D97B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 06:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241660AbjHPEnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 00:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241643AbjHPEnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 00:43:18 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7D0BF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 21:43:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K54VTkgZ2t6TOptIPMkUtyLnRmdIAcRQrPyZNXKKSpIWLcAPSe3/+Jlgp2QLcFR56dpjm39N8nJvSivS6suiHqrLQN5fVWz4QmqD+bQyG1KpynWcG/5Rq/UsDqN0my0S1PqOGyVwzK7+y7DmkBoQihFLzCJwWi8MPz0Ssybmwsf1qc9PI2P7hX9XtxKtgkaaSaplove8BsSQqUwNgHkrvQmk5SYT91oXUndb50AZgPDQxMHd2zoDCzoWlbRZkOCSk4FkSegDE0gH5+9sH0AEMX4B3AePbWIqwFjjUX27Os/E23BwGLZHdXDTy00VE/9sakw7io/9ih0sxnBa9l+tLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aepubm9ZtY4FsiQty2jt6Urt359RQ4uzhQU1xyAQfuE=;
 b=aDI4nsow+NT+p7QwR8HbohnFxSnYOFz3hiiFoPkoonVMEJLZt9qD3IIrJbP5w//m0gj4PYjtLr4LFUkJvpkbNUz9B5T3IiTGcKMhtuoXln+gGFGSB92N2LQtL+6OkKfm1FPwR5FIYHz2fDKkjCbGmXEZfFLyEoOdpN+NLl5N/xF9e8mawxIkNA643a3j9Git84Q1En1Sx5kcdptVeBhnX4yW4qtSSsuoqDS/sxRo/OQabTnsvkZjNFhOh6t6/LPdp6RiSKwqqX2sifxZ5RU9toD69v+yqQxFyFC7/nk+3wJVM5gz/Tyv23oK/63TaSsaCfOwnPaQ2k/j2O3MklrgEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aepubm9ZtY4FsiQty2jt6Urt359RQ4uzhQU1xyAQfuE=;
 b=W62KBSY3Lx7kWjLNRq13y1vYenqjCYgsAXpxCCr1iM3332mazWMSFP0nLfgRCNYcbFMIu1fmMyGdcuw9DT4gjWD+m2mGkeSHj4PFsS0Mc2ExtuyixVBGBpN68PiQCYp1GWqkmctHsgvUWWF0m1HRIVCi2HXsdto/ykV11ul+ZjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.29; Wed, 16 Aug 2023 04:43:13 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::6769:d6da:514c:90ab]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::6769:d6da:514c:90ab%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 04:43:13 +0000
Date:   Wed, 16 Aug 2023 10:12:52 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>,
        Deng Pan <pan.deng@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>
Subject: Re: [RFC PATCH 1/1] sched/fair: ratelimit update to tg->load_avg
Message-ID: <ZNxTzGQifArbj4UJ@BLR-5CG11610CF.amd.com>
References: <20230816024831.682107-1-aaron.lu@intel.com>
 <20230816024831.682107-2-aaron.lu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816024831.682107-2-aaron.lu@intel.com>
X-ClientProxiedBy: BMXP287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::32) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CY8PR12MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: c6be9ccf-673a-40ce-7d97-08db9e134c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ChDrC2dFwRaJAz4AOPYXdkFY+z7SxSKdnsVrpuUAdcUzvDrfV6HVWix+5ftekeFYLI369+Re8OkRgi7JgIozxBFzCCaIZE767Z7rx/jCJbx8ETyzDDaudstgKQWBnvPDzRQdWL3Id6aCluh4tr/jJQM/FbqEfXoRSh2fMCQqGdgj2DuHrPMfSCEJ2gAg1bo92oEMIKZWYdezQMcA4jOsf9C3v1gaZIaWtbmzj/i0x35uuYtFF7Z/B+9YVvVdn4SgfjdImc9q2XT2XOXQOZL5PY7DkODV8WwamZV0kk/mA2sbfWMMXXWAIL6cfj1i+r//lQzHu0hNcOb3zEaSh0XqHsrbnxKipWiVGoe4oMMQrgJZxWSGr0vQ8oXYCswYdDCyoz3it4Fu6JqCZEk/OtHRpAy4I0Ld7IfCGRNYOhm6TtsmLMTqpdtK/t/08ik0X/mryn14RTCVxNjsM49i6yyyVyoKbWKh8jdpRWReK5z/IS5YfZoxWjoCUJlLpq62bpXFg7PBz+Y0x6ALMKA+xr3iTLsb+hrSy0Uqayrp68+QcmbQ1f+XeQ949TK8TCeAP14P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(1800799009)(186009)(451199024)(66476007)(66556008)(66946007)(316002)(6916009)(54906003)(38100700002)(478600001)(7416002)(2906002)(86362001)(15650500001)(41300700001)(5660300002)(8676002)(8936002)(4326008)(26005)(83380400001)(6512007)(6666004)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MJDWNUHt5SPwqSvJIcahcUk3G6vTd7scNnTI8EBFXJerQ/ZX/0diy2hwBRh/?=
 =?us-ascii?Q?Dq85sg5DPk2xCOnP2zgCARLnpf/6T9Z8VWgqOOvFL80Ssp3tPY17gwIpZu5v?=
 =?us-ascii?Q?x1IgZok6ytSrusVAAGpGrF3ffRUbljHJZyIj7/mr/OB/7KPVwsvkAZKNN5VY?=
 =?us-ascii?Q?8U7VXXFLbDF1S0uKIkyulm/K663FwNm6TjYyHfMwvKmMTT25IlH8gioQrSC2?=
 =?us-ascii?Q?8KsQOZycSoWL/39otP7kTE8AxxBmKv0lWJuIpjSQM8Ep6lu8QrjX/iUEBt30?=
 =?us-ascii?Q?0ee98NSGMRzyTg+FpPS6Mnlp3oIMXXbR0v4vIAgsOnf7DJKSmGJ8LQVbaH1V?=
 =?us-ascii?Q?i+t/R8WaLn3r2qEwpCK/R8In+LkkTaprnUPOFI6ARBfE/JChOZA8obxE1sPR?=
 =?us-ascii?Q?msj4AlC41Sz/owrrU6vOBExhJ8K4N06U1stRXauEFhmzlei1otboaSWd/fhR?=
 =?us-ascii?Q?Swdkv9VA5z4nZQJNsmopXqu5tBUrANipYoT0d0ypPutayuxaRbB9MVjEkJdI?=
 =?us-ascii?Q?KNQ5Lena7H9HlQEEG2TzH1sH6meODdzDcb5dVlvBzDdhLKKI2NzKx2BNFHBg?=
 =?us-ascii?Q?+zHKUiPfVgvJZXTCezVDd2AMu9p6GJSSH7pIdZj09BYX8E4kgUGFKVWZZZDD?=
 =?us-ascii?Q?jsiQDA0+6h3qooGxyTKyITaodInIs3bnZxkblMDk0FfTkugqbQDUsalp0oTd?=
 =?us-ascii?Q?R8FkY6IaK2u00Ub0bjSOYyMNuYGxawaidy35mO0vxpZneA504rWI4frHmmce?=
 =?us-ascii?Q?+5PGwc8ewHo5SnoOmkgROoyDsiESsFDZTKfcmeXqsA5NsXFJmrHzJrxVccVW?=
 =?us-ascii?Q?59fffIWJy7ye/fqPkAChonLUc/5Uy34+eYTvgs8yD2P2RsgNkCTNu3klG6fm?=
 =?us-ascii?Q?Ooji+pFwLDlEDtQ/g/iUt4I3jsQV6ncmT8DXfQXFEEW4IzI8ruR/Zt6+2KYK?=
 =?us-ascii?Q?djezym9aLrSHS484GmeLRg7jhy+4Ai1yrTaU7ml740AoYNreSKdy3AEJvRw6?=
 =?us-ascii?Q?Qjouwjar5J1iuQQdOuDKovJDN/BgSPMwR5t8qCaOPbgPRt6pYFtILfKeh/D8?=
 =?us-ascii?Q?kPxkf1rWWaO60kjix+SeubjZQ0Nxp380vTYjmuuEo0ji4RjfWMpcWZGzQvbq?=
 =?us-ascii?Q?beZQ8j66Otji9O+qdOeQm8bcF/AxFyFRzGL315faNYu8PFDC4XNEPT2lWHHe?=
 =?us-ascii?Q?YWXe4XBecsk1anpOMr6I4O4lsoEL0ZoIwETUZFWSRuVVcjnc1ICJnoZzofuF?=
 =?us-ascii?Q?mBUcaLCzjBuyosJiqCN+XxcxJ/vzeK7lDv4BjM1eCWHPciUJ6Y6I1ECpOR1Y?=
 =?us-ascii?Q?aMIIx2OhWuC2ZAzvL8krxw/2Y+g8zxJ+I/64dIJqoG8Qnfn7US1azC0qRvI6?=
 =?us-ascii?Q?RpAs75QvMu4D7b7PCTRRCsB3AeV7fzwCXugZoyAt4FOzqeEAUiHfhgNkW0Np?=
 =?us-ascii?Q?+BY5fSpQUlinZdf9Prp+n56Kt2el1Ezx5E1gCLMTf/7OL7W+l+Cdlx6VRwgk?=
 =?us-ascii?Q?QIq11dhdUkSJ3Q5kJfA59Xx3aOM/pAI3yeUxyPHMDGKSRUU7NvXCeGJIjC/S?=
 =?us-ascii?Q?luMmNkVBCA3VI5qdAAR2r60uYHmODtmV8h/LhrAf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6be9ccf-673a-40ce-7d97-08db9e134c6b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 04:43:13.1460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHsZ9OW8KjRWYq03tIGmkBA+2kKch39HUmM2hlo8b1IDb9CorwJh5powFF3wxUqCy5RcEIi8UBhAWSeHKnHjfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Aaron,
(Adding David Vernet)

On Wed, Aug 16, 2023 at 10:48:31AM +0800, Aaron Lu wrote:
> When using sysbench to benchmark Postgres in a single docker instance
> with sysbench's nr_threads set to nr_cpu, it is observed there are times
> update_cfs_group() and update_load_avg() shows noticeable overhead on
> a 2sockets/112core/224cpu Intel Sapphire Rapids(SPR):
> 
>     13.75%    13.74%  [kernel.vmlinux]           [k] update_cfs_group
>     10.63%    10.04%  [kernel.vmlinux]           [k] update_load_avg
> 
> Annotate shows the cycles are mostly spent on accessing tg->load_avg
> with update_load_avg() being the write side and update_cfs_group() being
> the read side. tg->load_avg is per task group and when different tasks
> of the same taskgroup running on different CPUs frequently access
> tg->load_avg, it can be heavily contended.


Interestingly I observed this contention on 2 socket EPYC servers
(Zen3 and Zen4) while running tbench and netperf with David Vernet's
shared-runqueue v3 patches. This contention was observed only when
running with the shared-runqueue enabled but not otherwise.

  Overhead  Command  Shared Object     Symbol
+   20.54%  tbench   [kernel.vmlinux]  [k] update_cfs_group
+   15.78%  tbench   [kernel.vmlinux]  [k] update_load_avg

This was causing the tbench (and netperf) to not scale beyond 32
clients when shared-runqueue was enabled.

> 
> The frequent access to tg->load_avg is due to task migration on wakeup
> path, e.g. when running postgres_sysbench on a 2sockets/112cores/224cpus
> Intel Sappire Rapids, during a 5s window, the wakeup number is 14millions
> and migration number is 11millions and with each migration, the task's
> load will transfer from src cfs_rq to target cfs_rq and each change
> involves an update to tg->load_avg.

With the shared-runqueue patches, we see a lot more task migrations
since the newidle_balance() path would pull tasks from the
shared-runqueue. While the read of tg->load_avg is via READ_ONCE on
x86, the write is atomic.

> Since the workload can trigger as many
> wakeups and migrations, the access(both read and write) to tg->load_avg
> can be unbound. As a result, the two mentioned functions showed noticeable
> overhead. With netperf/nr_client=nr_cpu/UDP_RR, the problem is worse:
> during a 5s window, wakeup number is 21millions and migration number is
> 14millions; update_cfs_group() costs ~25% and update_load_avg() costs ~16%.
> 
> Reduce the overhead by limiting updates to tg->load_avg to at most once
> per ms. After this change, the cost of accessing tg->load_avg is greatly
> reduced and performance improved. Detailed test results below.

I will try this patch on with David's series today.

--
Thanks and Regards
gautham.
