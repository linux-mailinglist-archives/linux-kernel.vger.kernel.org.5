Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F63079814C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 06:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbjIHEls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 00:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjIHElp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 00:41:45 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058C21BD2;
        Thu,  7 Sep 2023 21:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZRviynFOnSvyO/u01XcAMtnSxk9sS9HTXZZIow+zr85L24D8kVmF559TS9EhtlBcyTpAF75yS7wSCa4awb0sZEkES1dJ5R0hDqQuoC2hRz3ghnOmf6lLmEq+4UjUwce0jxtXQXi5fmnvY+KdpfA6QmmFX5KLLiVYlN8DdUOlwa+EeEDXb4S0+mBOyO77NBNvFAY8tf+T57kYfcnenxxDDXnliX8V89mLF9kbxu7uUwG5NJhUnpGgNdRfuwogxhnrMdG2XP2ZKv+uHdgg3NbwDdIGmgmuML3xPW2SbkohQx7wNQCCKq9ooGqvzkYwMGkFxlCxEQmlLHWCp/syN+szQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVUUZUBk0mn2jR4PSxiuGbL+IRpdjofzDqfHTWLSyxo=;
 b=O/n0d9IwbM6DhJJXGR66Y97pXbSiw0voGqWHq6e35BZvsICb3CeWoiX2uX/rYanoWU1k0Vr/XhiAoMKcCq27gkebI52lcuGvX62Yh/3cClt2wF24i3FnD/ehwiQKcXdixDxTA730YkPk7b+GlbeN+yIotpHrnY0o/Xnz2Jjko17PC9PuieN5XsRsQJ3z1WdPiPxu+7vHezH90QsGqznrP9Pe3umI7CtuNQDk1rbRAjIOiTJ1+B4RYX/U2q15DnR2ZNdBExjC0HLm2kgT1e2yVBvc9Ps1eJBidJOUBLwpcTXsfmqWwyJREMEyz7+Bs7t1GR9zzQoG676lm8HgdLMuHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVUUZUBk0mn2jR4PSxiuGbL+IRpdjofzDqfHTWLSyxo=;
 b=g8tCXFEFOGhHPEQ6BTDdM7NpqKdebNlih601qvaugA89gkhemt+U3kQ/9lEmFxij7EHpqYN6RI5p1pMpvDNuVgOXaB7wAbAehj/yOvzS3XkxkK3K8UOJohc2i34kh1q6ktmv9/n9TWE40QxlWJILwTZMl+kgosT8vn8KeC+y33o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by DM4PR12MB5795.namprd12.prod.outlook.com (2603:10b6:8:62::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.34; Fri, 8 Sep 2023 04:41:38 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40%4]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 04:41:38 +0000
Date:   Fri, 8 Sep 2023 12:41:14 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, Meng Li <li.meng@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michele Della Guardia <micheledellaguardia@yahoo.it>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: Fwd: Abnormal battery drain with kernel 6.5 (Ryzen 5500u)
Message-ID: <ZPql6tqBCnXJh64J@amd.com>
References: <bede02c1-ef90-8e30-aa8b-e6fae49a8ccf@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bede02c1-ef90-8e30-aa8b-e6fae49a8ccf@gmail.com>
X-ClientProxiedBy: SG2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:3:17::13) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|DM4PR12MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d648b4d-6ee3-40d6-0239-08dbb025e344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fHob19sj/7cO56365udB/hsfDbaVVB4sh3vY1FqvLAL2YeWOOVE5aXxHOdaBdGdpWgimApNjvg/l3B1FjLHM1ZduUwEZxF0lmxO4t+20BCQ3dgUukHgfPrCpD5SIA5P1FtSCtYjeuJAUQu6X7Aha7L2xirD7N5Mip8UUA/AmSUUqrVDahlaFvYNW362/J/Hpq5dP7D6yKkirGFNN2Hg6TN4uZiPFfcBDpNiY58o4trzyVvBIPFmdM58yw/Tkvvt4gaqU5Tjh6ezMF2RpQ5cfSIe9GjZQQJ7JjlX2dTZx///ZzcLbC0JgsNMN1Kb6xgiotli1Roq9oaTmtv0ouy9i2GibTk01eLklEwrf+lji+aewixMnaTi9Nlx7zgSa4baB5p/Nm3O1gtesQZwoEzb7Q/68uwySpCPcKXXgC9OCO0X5SJ2KgeIuPtCwNNDi0/pzSQyEtMkhwDXd0x5btriwlFEB2reTvVd6OShtTQIWaiLC4lfW4IWlaDwFFtiPa+qLMUcPbdasvaKiysEd+bBA4EsMFWUe3NQ1B6xBil1j85s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(396003)(376002)(186009)(1800799009)(451199024)(2616005)(26005)(38100700002)(6486002)(6512007)(6506007)(36756003)(83380400001)(8676002)(478600001)(66476007)(4326008)(966005)(8936002)(66946007)(110136005)(66556008)(5660300002)(86362001)(54906003)(6636002)(316002)(2906002)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nMa9MDpsU09YtUvy/yZHUSguExt5OjKph4bBRBXLazQyxnxEesojtxsypd5S?=
 =?us-ascii?Q?Gr/TBx2uVlBMiG3B+GY8t93qTfBHhqCs7M28L4Ya3I94k3JXnw1Y4JlFkbAn?=
 =?us-ascii?Q?QIHShEhLKdq9aiwT+a8mtEU1wEiUf47ANUjQS4FMba+UqFolZf2n3rYQ/jwt?=
 =?us-ascii?Q?QhQ879K2yoOQE2ik/rpoZEN3KyTjlJMc43ZOb32ilLs5dxGX0xjHk+3Xjk5/?=
 =?us-ascii?Q?o7INM4558bTB+lKzYXHsZuczMPodhl2IbJRQKXyjbyp0aEPs69TLYQbguBs1?=
 =?us-ascii?Q?aU6dpR57qaUeqCshhBsJoYcXKOaIfhGYlKyZfrKPzlXr78k1DfmbN+AE2erg?=
 =?us-ascii?Q?qETOstogujVziDPaWx/dfSRIqSFgwpGqOW2f/CUH8ZpvNLk9MHFx1OTpwUPx?=
 =?us-ascii?Q?02LVrkrlYXBOQCCWURQnm+Met2ZKSiVLRX66lYg+wHGz625J+xB3xnpBN95Q?=
 =?us-ascii?Q?9HQoddB0crkds/lWS+MOA4gCO359jwzWHbSaO2swDFwrx6inveKu0BreNT7L?=
 =?us-ascii?Q?R+4cisfQ2bn8/rPVtWSqrjKcdS60FL0nPJ3Fl1pXHMLSzmCTQ11op0mdQLcV?=
 =?us-ascii?Q?fJlF8praBv7Ocv9eDvh+PfEfmkpdPVzow9fgQiGJaRhZXoHDEeRljEFaeRm8?=
 =?us-ascii?Q?EIfgYYHayKru1H0yS6Rd1SdCicZQ1t6MKOTq1rW15IeYB7PaMxntvoA+jiDN?=
 =?us-ascii?Q?IocSfRHG4v2AJmSrfRacViFHHWkNrGuFwDoVXp/ckr9KzOBFR4nZwP+BIkTG?=
 =?us-ascii?Q?+OT9kVfoslTKfEyFtdZez3RPvnVMp4QoftXVLP22e7BSOYXANcypMl+6z431?=
 =?us-ascii?Q?7vh2ubOh59YCVuEEhIchC/6+6vUkB0Zxj3SZ2KOUVQXf/mAdr24xr5Cw3b4q?=
 =?us-ascii?Q?HamTgFiQ+sl1PSY2oioiwfWb0SoGXfMc9wKOS+WbzHpFAS1nkuI0MGnPUpze?=
 =?us-ascii?Q?Yh5f6QUw+b9BE9KCq7k5kkZi4fx6IjPc9p6FSuKr6nY9/JcOl4/Cmmx4700y?=
 =?us-ascii?Q?Ftc92+Uj9YcLUJQz2fsWTtzRDb7gmm7VRegTQFV0lWsfP/kDENxo6HxKtwMm?=
 =?us-ascii?Q?U3KlQ2W0k8Phh7b617fpyid7mLllu76LDOZpogwNwiOIL2BPYSOmh/jNMJ6H?=
 =?us-ascii?Q?zqOB03FvOYi4tUaqfPeZ3ac6RnnLOIDV+QG0qtrJ6/k35n0sQVBw3TuVW0PJ?=
 =?us-ascii?Q?pfY8uM88Q43zLodJPMRMPr4+hZ8IMS+FECEEenikudFVLRGNnTHEAIUHUV0M?=
 =?us-ascii?Q?HsLX5qW+icfT9Z2KKEeZT+BAZduQBj2Hlvevm6rRURyhR1xj+EhsC79wszOa?=
 =?us-ascii?Q?WJ4uO3WtEP60mFvN1xu/FcOQV54JiuqOV0XbbneP8ZqXPASkPSwJqo9PBFtB?=
 =?us-ascii?Q?fRtUtf31yRrlV+Cr8X8Tc/PE1I6JY7I8gnz8lvK88Df0wiHcJFvKSbIU8mcT?=
 =?us-ascii?Q?YzSSxesfAK45mKt3dfhkWtZ8vFzrl4RoMke6lY2hKEvPiRHXxLyG6wKBdI65?=
 =?us-ascii?Q?RHXjIGtnPnBZRmNodU7IL+bkhBctM4NCW4BuEkJ7DwmA2y0uVSKPC+tp+0RL?=
 =?us-ascii?Q?A+3tJuD6yDbJ86oUdkiT/JIdYMtrTLOUfMBQDmMb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d648b4d-6ee3-40d6-0239-08dbb025e344
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 04:41:38.0992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGqT18U6SGFvCA9IGXq+raub9mY+eJ5LjUG1GBj70J9jy7fQpk2+69xv5wH5Wg4AvUJRAIdYmVLgD2YKCSFcYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5795
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 05:42:22PM +0800, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a regression report on Bugzilla [1] that have been already handled
> there. Quoting from it:
> 
> > After switching from 6.4.x kernel to 6.5 I experienced an abnormal battery drain since my laptop is actually never idle.
> > I accepted default CPUfreq to schedutil and AMD Processor P-State mode is 3 (active). 
> > 
> > I expected a different behaviour, but am I missing something?
> > In my boot configuration I had "amd_pstate.shared_mem=1" and tried to remove this switch, but did not affect my power consuption.
> > 
> > Is there something changed from 6.4.x to 6.5 that requires a different configuration to get an optimal power consumption?
> > 
> > Thanks a lot for your attention
> 
> See Bugzilla for the full thread.
> 
> Anyway, I'm adding it to regzbot:
> 
> #regzbot introduced: v6.4..v6.5 https://bugzilla.kernel.org/show_bug.cgi?id=217853
> 

+ Meng Li/Perry,

May we know which CPU type are you using? Try "lscpu"?

Thanks,
Ray
