Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C18277F258
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349049AbjHQImp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349095AbjHQIm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:42:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B402D54
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:42:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTluzbTje5TTw9t9t7NuNttJ/E6ZAmGqtMwOjLpEvvWyU8Y0rCDcFocuF/ODn0zpzGa2OZ/3SUksuDC2aMyr4melKPjo5wneFPkglqUibcZVSzmShCO/f7OkXXHvVDLyT43OPrdraSe6M+PtdYMADLf8XZEa8gfr87mXN7vw9mxSfZg0JlaAJ+M75OVSptcS30QldeOzkJ5n3YjV3JWJWyCG9yO+vZYID3Ouzsgxg7mqd5Yccufgghz5ZbW4p6/KO4Qwm0V/PQPtPSoj6CHmbIkBLw+mZSgIAzkncMlENzju4fV8iiPmKQQYzerOkuWRGtnSGpkNU80QF8Yg5zZCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOVKobvpjmE/XTG09hg6cTTy9hCdAqQL+llSju7uThE=;
 b=Nuzt6i3XVgYne2j8GWuZOZbtjCjN56304d15Y9jNgvuTstTTWZLtlsVQ+ATkdyE+pRRZUfoRHHvqtnsQmVK2URDARJmvBMAuUU6GTf1O9kpp/0QjnLepx+rPfslH+ty6o1onOgEvDINsWf6rkUoeBcyxNWRVFatcHTtbcpw6se7XFz6SIIev6zdIEDOF4nt+thHVkN+4M9XKWd18aknBDd0gMwkXyC5RSzj/Eo/4FYGxWqhUpuDr7DiKHWxFdGgV8Fvzgwg3uEhbIlyyDRtanrMNaImsmk8ssiwQ95bG1X/5BNW3DIuG4Inix4ecpuOOY05Pvx+Asvtzfoz7RTRhDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOVKobvpjmE/XTG09hg6cTTy9hCdAqQL+llSju7uThE=;
 b=J0CcOFLy9NzsERb4Ka9ACs2IaKQBhSzmdfWTxrIsoynT8sxwrn9kjcKnwoglR+/vnYP8bzQgFB7V3H3nr9nrxZu3hOjw5xMj1Ze6xxDbBgyntMoK9b07NkfxgjYheBcYFd1tlV9DBmAHRPpxZ3kyTc3FmlXHBY412L/IZ1muss4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SJ2PR12MB7846.namprd12.prod.outlook.com (2603:10b6:a03:4c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 08:42:20 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::6769:d6da:514c:90ab]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::6769:d6da:514c:90ab%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 08:42:19 +0000
Date:   Thu, 17 Aug 2023 14:12:03 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, kprateek.nayak@amd.com,
        aaron.lu@intel.com, wuyun.abel@bytedance.com, kernel-team@meta.com
Subject: Re: [PATCH v3 0/7] sched: Implement shared runqueue in CFS
Message-ID: <ZN3dW5Gvcb0LFWjs@BLR-5CG11610CF.amd.com>
References: <20230809221218.163894-1-void@manifault.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230809221218.163894-1-void@manifault.com>
X-ClientProxiedBy: PN3PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::17) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SJ2PR12MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d53fd87-2c9a-461f-371a-08db9efdde08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AceuZ47tn2wEKT3yJ+2/0WJtin+Ze7wSDtcHpO6PFUlbAxKXM5lOk88SSxDUealEpliMPuIIrGOtJ9wJwGL079irkZgd+LmdsDhNzWoBR15AKcvXQmKVNJ10c1QFEqHleHqvfP7UPT8IMJuofmSZfTODWXqlVY9BCPMPW78GkYiX2mTVJdAcv/Pt9BOJ7pil8SGLd5o7rpCyVZDMGJK/gs2Uz0o2OXD2quUITc8zq5Ixv/iLuy0FnB7UtzPY0Pzb4d4Bs106OQwxk+5qZNhgThcdYtCY+NhPdN0FgeoesbeYRk4bsKASTXxPsQ+w2ur8orjOsaLl9kvM1YxxnkMwp0RsPmGpLMlGXj5ud92lb5bRRDpYS3QeT2e4MKtcaJszChe9SRekjMrIdtO31TMw6d6nAXBL/XAjE4/RJS1no4lF5Y4dUz3AAKAhyi4flIyYj3Wqu2b6y3k8EkaYDfcUlWBqr8R2JbDSO981uBXDeGaUbtR77uj6Xzr1DUUvdotrAFyk9HbMdcZtEibJHKUeWM7AG/5ijXZEPiVDs7MJt7FGnm67D4CaImJrvbWFcrdbZYRP6dSHKhZNqvyOkbajWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(1800799009)(186009)(451199024)(7416002)(83380400001)(30864003)(2906002)(66946007)(478600001)(66556008)(66476007)(6666004)(6506007)(6486002)(6916009)(316002)(5660300002)(26005)(6512007)(4326008)(8936002)(8676002)(41300700001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXFONC8reVZaZisyUjlLcnBJWm1MZSt4a21uM1piWi9sVWIzQlpNd3hVMG1z?=
 =?utf-8?B?b0pGeG9Qem1aYnhlbWc2a2R2eU9mcko1M3VTc3ZyRzNKanJMUngrWFlVekVh?=
 =?utf-8?B?NDd0ZTVhblJneFNFVVM4b1RUV01DaTF6elFLV3d5VWhJckF4cTNtTXNPazR0?=
 =?utf-8?B?RDBSa3RMRW93NGcxMnB0RE1PSFdHRnpTWWxMeVN2anVyWFZpY1M4MUI0ZXVE?=
 =?utf-8?B?MFZFdzhYNTFHT3QxODRDWHhtbGR3MnBWUzRMTE1lY3F5S040cTlmNGVkVTZv?=
 =?utf-8?B?OTlvT0lPbU5SWVJHT3puTVlCem5SRVI5T0ozL3dPOURUaDIwWTdUbWpFMmZ6?=
 =?utf-8?B?Sk5hdHl3dU4vTU1RWmY1TXdadTQ5bUJTaFdKU29rV1NYRys1Y1U0d2RNQWFp?=
 =?utf-8?B?cmJkUEdZYzlkQmpScllITVhtMW9GUnFyZDdIS0tMYmVkZHFxWk53Z3IzQUNK?=
 =?utf-8?B?VmxaOEQ4VWFEZTk1dUlNeHlWQUlBUFBpOGpSVEZrT3J0bzZVRVRlZ08xSTFw?=
 =?utf-8?B?SVJQR0s4UkdESm1VRmF5cThrSGZnMXE0eFU0cUw5L2h2dzBRTTYwSVZ6QjV1?=
 =?utf-8?B?bUg3Qjg0T2plU3gyQXVsSnBRZmZ3TU9GVnFTeWxsWkhFdDZDS1NuRUZwZ3d3?=
 =?utf-8?B?cHFxdHkzcEVHUFY5aCszbFlJN3ZNYnBkQXltaTA0c0hzVTFUcEVaWTBKcXM3?=
 =?utf-8?B?bytITENiK0ozZjNmalVjV2JDS2J5N1k0bC9TREpFZDdXcEtYcDdrRlZLYnVp?=
 =?utf-8?B?d01pY0NhRHBVTXB0cURYUFc4VUlCbkdHdUZBTldRUWs0SUs5VURZdExrU3JX?=
 =?utf-8?B?RWZXaUplelByeVlZcGtVNjRqR2lxY0p6RkRlbU9KUERZT1ljNTkxUEZqV2tU?=
 =?utf-8?B?TjVneFRkd3dFUm41QzFybEpNWm9KSjlsK3JXTFFxMlBLQktXYXZHU2NpbjIr?=
 =?utf-8?B?azhicjAzNTNqb2VQVGRUMkFOUXVCOWxWNGtBVWdwRnhpbkV3MU1XYmxQd05w?=
 =?utf-8?B?WFJsc2VKK3pRdnhxc3JtcVhXVEF1SUtDN0tZM2F1WmxCc294S2V6OFY5blRT?=
 =?utf-8?B?dUtVckJhSUNiT1QrcUNFQkVrNmdpVGcwUGo2Qm9Sb05hOW4xUlYzSkp0bnla?=
 =?utf-8?B?QnFjQ055VXArWU5hM0JkUktuZGRVWHZBcTFNZ0w4amVyYnFtWHZMbHc2MVE0?=
 =?utf-8?B?STd4RVRKeUFBVDRxSVVWZkVKUmd2MXBPbGo4UFlCNThjRlNBcDY3eTZ6b1U4?=
 =?utf-8?B?MmdVeElqQmpsaXJqYlFhdmVSd2ZJZU5KN2xqeXdGT3dLOE1TT0hOclBZL0lp?=
 =?utf-8?B?SFdzN210aXN3Zkl2VytJMVpSRk5HRVBwUDY3aUxhZVQwdFVpZVJzajVrVC8v?=
 =?utf-8?B?VUJxRUZ6U2RZVDI2Nnk0ODc4ejZrWEtWVjVCVUhpeHRSbnpKMkd1ZmlMdnFU?=
 =?utf-8?B?V29raUlwcWZ3cS9mZmpTTjlObkQ5a3Rkdk5uK29QSGEwZnh1SEd6eVl3U3dk?=
 =?utf-8?B?UlVNQ0ZZejIwQzFhSE5hYVJEM3dYRVd1ZDRPeHkzRkNzSWFZZWFGd0NGcGts?=
 =?utf-8?B?YTR4SksvWXJOV2cvYUJnQVZMUmxPLzJzMWtKNTBKb0Q1UEI4TDBLdENlTjha?=
 =?utf-8?B?bytsdWRVaVdXVkVUVVl2elFBdDBjSVZrNnIzRnh6cUJjbUJHOWhzeDd0K3Fy?=
 =?utf-8?B?d1Z0dXNVa1UweTBNejZzNWRadW1wTUg1M2pLMS9NVVBGY2FhK2xSZE5MZVJE?=
 =?utf-8?B?cVN0RXpSMUxDek1adVREZGZXUjczV0xJMzdtSjVUSU1pZWxlS1VlZm5Ec1da?=
 =?utf-8?B?NytvcEU3UWdZcmxweFNNOHJCNGVCdURueEVMQlRLRG5Jd2t3Q3ZOQWIvTmph?=
 =?utf-8?B?YVU0QUtnaElrYmswN2MvbDB4MDBGUFZXRWdaWFRwQ3ZKUkVOakE5YU9Wb2th?=
 =?utf-8?B?NjR1SGE1QmxQalhwWndYMFRHYlBtampGTCtmY1p4V2JNWnlvQlp0RktMaGpl?=
 =?utf-8?B?b1p6S0NzN3dCV2F5cm11OUlNTVVRWFlFMk1tMFFLNHFjM2cxSzhqa3djMkVJ?=
 =?utf-8?B?TE9USnhBZTAvNjhnV0RNT2FRZlV1Yi9wQ29qaEFLMVhGakVoT0xDSU9ndHRV?=
 =?utf-8?Q?qQ+IUckp9H6jhgLa95zQiIAZZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d53fd87-2c9a-461f-371a-08db9efdde08
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 08:42:19.6825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QK0iqzNDda4inzaHGKLT8NAQmy1WBuhWmZ2E8U2zT1D392HMRwgPfWFPPyZWLXH5mdQr6PdcRiCCa2AIpkgT+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7846
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On Wed, Aug 09, 2023 at 05:12:11PM -0500, David Vernet wrote:
> Changes
> -------
> 
> This is v3 of the shared runqueue patchset. This patch set is based off
> of commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop when cfs
> bandwidth in use") on the sched/core branch of tip.git.


I tested the patches on Zen3 and Zen4 EPYC Servers like last time. I
notice that apart from hackbench, every other bechmark is showing
regressions with this patch series. Quick summary of my observations:

* With shared-runqueue enabled, tbench and netperf both stop scaling
  when we go beyond 32 clients and the scaling issue persists until
  the system is overutilized. When the system is overutilized,
  shared-runqueue is able to recover quite splendidly and outperform
  tip.

* stream doesn't show any significant difference with the
  shared-runqueue as expected.

* schbench shows no major regressions for the requests-per-second and
  the request-latency until the system is completely saturated at
  which point, I do see some improvements with the shared
  runqueue. However, the wakeup-latency is bad when the system is
  moderately utilized.

* mongodb shows 3.5% regression with shared runqueue enabled.

Please find the detailed results at the end of this mail.

Scalability for tbench and netperf
==================================
I want to call out the reason for the scaling issues observed with
tbench and netperf when the number of clients are between 32 to 256. I
will use tbench here to illustrate the analysis.

As I had mentioned, in my response to Aaron's RFC,
(https://lore.kernel.org/lkml/20230816024831.682107-2-aaron.lu@intel.com/#t)
in the aforementioned cases, I could observe a bottleneck with
update_cfs_group() and update_load_avg() which is due to the fact that
we do a lot more task migrations when the shared runqueue is enabled.

  Overhead  Command  Shared Object     Symbol
+   20.54%  tbench   [kernel.vmlinux]  [k] update_cfs_group
+   15.78%  tbench   [kernel.vmlinux]  [k] update_load_avg

Applying Aaron's ratelimiting patch helps improve the
scalability. Previously the throughput values for 32 clients, 64
clients, 128 clients and 256 clients were very close to each other but
with Aaron's patch, that improved. However, the regression still
persisted.

==================================================================
Test          : tbench 
Units         : Normalized throughput 
Interpretation: Higher is better 
Statistic     : AMean 
==================================================================
Clients:  tip[pct imp](CV)       sh_rq_v3[pct imp](CV)    sh_rq_v3_tgload_fix[pct imp](CV)
   32     1.00 [  0.00]( 2.90)     0.44 [-55.53]( 1.44)     0.98 [ -2.23]( 1.72)
   64     1.00 [  0.00]( 1.02)     0.27 [-72.58]( 0.35)     0.74 [-25.64]( 2.43)
  128     1.00 [  0.00]( 0.88)     0.19 [-81.29]( 0.51)     0.52 [-48.47]( 3.92)
  256     1.00 [  0.00]( 0.28)     0.17 [-82.80]( 0.29)     0.88 [-12.23]( 1.76)


With Aaron's fix, perf showed that there were a lot of samples for
update_sd_lb_stats().

Samples: 8M of event 'ibs_op//', Event count (approx.): 28860989545448
  Overhead  Command  Shared Object         Symbol
-   13.00%  tbench   [kernel.vmlinux]      [k] update_sd_lb_stats.constprop.0
   - 7.21% update_sd_lb_stats.constprop.0                                    
      - 7.21% find_busiest_group                                                
           load_balance                                                         
         - newidle_balance                                                      
            + 5.90% pick_next_task_fair                                         
            + 1.31% balance_fair                                                
   - 3.05% cpu_util                                                             
      - 2.63% update_sd_lb_stats.constprop.0                                    
           find_busiest_group                                                   
           load_balance                                                         
         + newidle_balance                                                      
   - 1.67% idle_cpu                                                             
      - 1.36% update_sd_lb_stats.constprop.0                                    
           find_busiest_group                                                   
           load_balance                                                         
         - newidle_balance                                                      
            + 1.11% pick_next_task_fair   

perf annotate shows the hotspot to be a harmless looking "add"
instruction update_sg_lb_stats() which adds a value obtained from
cfs_rq->avg.load_avg to sg->group_load.

       │     cfs_rq_load_avg():
       │     return cfs_rq->avg.load_avg;
  0.31 │       mov    0x220(%r8),%rax
       │     update_sg_lb_stats():
       │     sgs->group_load += load;
 15.90 │       add    %rax,0x8(%r13)
       │     cfs_rq_load_avg():
       │     return cfs_rq->avg.load_avg;

So, I counted the number of times the CPUs call find_busiest_group()
without and with shared_rq and the distribution is quite stark.

=====================================================
per-cpu             :          Number of CPUs       :
find_busiest_group  :----------------:--------------:
count               :  without-sh.rq :  with-sh.rq  :
=====================================:===============
[      0 -  200000) :     77
[ 200000 -  400000) :     41
[ 400000 -  600000) :     64
[ 600000 -  800000) :     63
[ 800000 - 1000000) :     66
[1000000 - 1200000) :     69
[1200000 - 1400000) :     52
[1400000 - 1600000) :     34              5
[1600000 - 1800000) :     17		 31
[1800000 - 2000000) :      6		 59
[2000000 - 2200000) :     13		109
[2200000 - 2400000) :      4		120
[2400000 - 2600000) :      3		157
[2600000 - 2800000) :      1		 29
[2800000 - 3000000) :      1		  2
[9200000 - 9400000) :      1

As you can notice, the number of calls to find_busiest_group() without
the shared.rq is greater at the lower end of distribution, which
implies fewer calls in total. With shared-rq enabled, the distribution
is normal, but shifted to the right, which implies a lot more calls to
find_busiest_group().

To investigate further, where this is coming from, I reran tbench with
sched-scoreboard (https://github.com/AMDESE/sched-scoreboard), and the
schedstats shows the the total wait-time of the tasks on the runqueue
*increases* by a significant amount when shared-rq is enabled.

Further, if you notice the newidle load_balance() attempts at the DIE
and the NUMA domains, they are significantly higher when shared-rq is
enabled. So it appears that a lot more time is being spent trying to
do load-balancing when shared runqueue is enabled, which is counter
intutitive.

----------------------------------------------------------------------------------------------------
Time elapsed (in jiffies)                                  :         39133,        39132           
----------------------------------------------------------------------------------------------------
cpu:  all_cpus (avg) vs cpu:  all_cpus (avg)
----------------------------------------------------------------------------------------------------
sched_yield count                                          :             0,            0           
Legacy counter can be ignored                              :             0,            0           
schedule called                                            :       9112673,      5014567  | -44.97|
schedule left the processor idle                           :       4554145,      2460379  | -45.97|
try_to_wake_up was called                                  :       4556347,      2552974  | -43.97|
try_to_wake_up was called to wake up the local cpu         :          2227,         1350  | -39.38| 
total runtime by tasks on this processor (in ns)           :   41093465125,  33816591424  | -17.71|
total waittime by tasks on this processor (in ns)          :      21832848,   3382037232  |15390.59| <======
total timeslices run on this cpu                           :       4558524,      2554181  | -43.97|

----------------------------------------------------------------------------------------------------
domain:  SMT (NO_SHARED_RUNQ vs SHARED_RUNQ)
----------------------------------------------------------------------------------------------------
< ----------------------------------------  Category:  newidle ---------------------------------------- >
load_balance count on cpu newly idle                       :        964585,       619463  | -35.78|
load_balance found balanced on cpu newly idle              :        964573,       619303  | -35.80|
  ->load_balance failed to find bsy q on cpu newly idle    :             0,            0           
  ->load_balance failed to find bsy grp on cpu newly idle  :        964423,       617603  | -35.96|
load_balance move task failed on cpu newly idle            :             5,          110  |2100.00|
*load_balance success cnt on cpu newidle                   :             7,           50  | 614.29|
pull_task count on cpu newly idle                          :             6,           48  | 700.00|
*avg task pulled per successfull lb attempt (cpu newidle)  :       0.85714,      0.96000  |  12.00|
  ->pull_task whn target task was cache-hot on cpu newidle :             0,            0           

----------------------------------------------------------------------------------------------------
domain:  MC (NO_SHARED_RUNQ vs SHARED_RUNQ)
----------------------------------------------------------------------------------------------------
< ----------------------------------------  Category:  newidle ---------------------------------------- >
load_balance count on cpu newly idle                       :        803080,       615613  | -23.34|
load_balance found balanced on cpu newly idle              :        641630,       568818  | -11.35|
  ->load_balance failed to find bsy q on cpu newly idle    :           178,          616  | 246.07|
  ->load_balance failed to find bsy grp on cpu newly idle  :        641446,       568082  | -11.44|
load_balance move task failed on cpu newly idle            :        161448,        46296  | -71.32|
*load_balance success cnt on cpu newidle                   :             2,          499  |24850.00|
pull_task count on cpu newly idle                          :             1,          498  |49700.00|
*avg task pulled per successfull lb attempt (cpu newidle)  :       0.50000,      0.99800  |  99.60|
  ->pull_task whn target task was cache-hot on cpu newidle :             0,            0           

----------------------------------------------------------------------------------------------------
domain:  DIE cpus = all_cpus (avg) vs domain:  DIE cpus = all_cpus (avg)
----------------------------------------------------------------------------------------------------
< ----------------------------------------  Category:  newidle ---------------------------------------- >
load_balance count on cpu newly idle                       :          2761,       566824  |20429.66| <======
load_balance found balanced on cpu newly idle              :          1737,       284232  |16263.39|
  ->load_balance failed to find bsy q on cpu newly idle    :             0,          537            
  ->load_balance failed to find bsy grp on cpu newly idle  :          1736,       283427  |16226.44|
load_balance move task failed on cpu newly idle            :          1023,       282021  |27468.04|
*load_balance success cnt on cpu newidle                   :             1,          571  |57000.00|
pull_task count on cpu newly idle                          :             0,          571           
*avg task pulled per successfull lb attempt (cpu newidle)  :             0,            1           
  ->pull_task whn target task was cache-hot on cpu newidle :             0,            0           

----------------------------------------------------------------------------------------------------
domain:  NUMA cpus = all_cpus (avg) vs domain:  NUMA cpus = all_cpus (avg)
----------------------------------------------------------------------------------------------------
< ----------------------------------------  Category:  newidle ---------------------------------------- >
load_balance count on cpu newly idle                       :            38,        47936  |126047.37| <======
load_balance found balanced on cpu newly idle              :            20,        26628  |133040.00|
  ->load_balance failed to find bsy q on cpu newly idle    :             0,            0             
  ->load_balance failed to find bsy grp on cpu newly idle  :            20,        26531  |132555.00|
load_balance move task failed on cpu newly idle            :            18,        21167  |117494.44|
*load_balance success cnt on cpu newidle                   :             0,          141             
pull_task count on cpu newly idle                          :             0,          140           
*avg task pulled per successfull lb attempt (cpu newidle)  :             0,      0.99291           
  ->pull_task whn target task was cache-hot on cpu newidle :             0,            0           

< ----------------------------------------  Wakeup info:  ---------------------------------------- >
Wakeups on same                          CPU (avg)      :          2227,         1350  | -39.38|
Wakeups on same         SMT cpus = all_cpus (avg)       :         85553,        30942  | -63.83|
Wakeups on same         MC cpus = all_cpus (avg)        :       4468548,      2520585  | -43.59|
Wakeups on same         DIE cpus = all_cpus (avg)       :             9,           60  | 566.67|
Wakeups on same         NUMA cpus = all_cpus (avg)      :             8,           35  | 337.50|

Affine wakeups on same  SMT cpus = all_cpus (avg)       :         85484,        18848  | -77.95|
Affine wakeups on same  MC cpus = all_cpus (avg)        :       4465108,      1511225  | -66.15| <======
Affine wakeups on same  DIE cpus = all_cpus (avg)       :             1,          569  |56800.00:
Affine wakeups on same  NUMA cpus = all_cpus (avg)      :             0,          140           



Detailed Results are as follows:
=============================================================
Test Machine : 2 Socket Zen4 with 128 cores per socket, SMT enabled.

tip                 : commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop when cfs
                      bandwidth in use")
sh_rq_v3            : This patchset with SHARED_RUNQ feature enabled.

sh_rq_v3_tgload_fix : This patchset along with Aaron's patch
                      (https://lore.kernel.org/lkml/20230816024831.682107-2-aaron.lu@intel.com/)

The trend is similar on a 2 Socket Zen3 with 64 cores per socket, SMT
enabled. So, I am ommitting it.

==================================================================
Test          : hackbench 
Units         : Normalized time in seconds 
Interpretation: Lower is better 
Statistic     : AMean 
==================================================================
Case:        tip[pct imp](CV)        sh_rq_v3[pct imp](CV)    sh_rq_v3_tgload_fix[pct imp](CV)
 1-groups     1.00 [  0.00]( 8.41)     0.96 [  3.63]( 6.04)     0.94 [  6.48]( 9.16)
 2-groups     1.00 [  0.00](12.96)     0.96 [  4.46]( 9.76)     0.89 [ 11.02]( 8.28)
 4-groups     1.00 [  0.00]( 2.90)     0.85 [ 14.77]( 9.18)     0.86 [ 14.35](13.26)
 8-groups     1.00 [  0.00]( 1.06)     0.91 [  8.96]( 2.83)     0.94 [  6.34]( 2.02)
16-groups     1.00 [  0.00]( 0.57)     1.19 [-18.91]( 2.82)     0.74 [ 26.02]( 1.33)


==================================================================
Test          : tbench 
Units         : Normalized throughput 
Interpretation: Higher is better 
Statistic     : AMean 
==================================================================
Clients:   tip[pct imp](CV)      sh_rq_v3[pct imp](CV)    sh_rq_v3_tgload_fix[pct imp](CV)
    1     1.00 [  0.00]( 0.26)     0.99 [ -1.25]( 0.13)     0.98 [ -2.15]( 0.49)
    2     1.00 [  0.00]( 0.37)     0.98 [ -2.33]( 0.88)     0.98 [ -2.21]( 0.53)
    4     1.00 [  0.00]( 0.66)     0.99 [ -1.32]( 0.91)     0.98 [ -2.12]( 0.79)
    8     1.00 [  0.00]( 2.14)     0.99 [ -0.53]( 2.45)     1.00 [ -0.23]( 2.18)
   16     1.00 [  0.00]( 1.08)     0.97 [ -3.37]( 2.12)     0.95 [ -5.28]( 1.92)
   32     1.00 [  0.00]( 2.90)     0.44 [-55.53]( 1.44)     0.98 [ -2.23]( 1.72)
   64     1.00 [  0.00]( 1.02)     0.27 [-72.58]( 0.35)     0.74 [-25.64]( 2.43)
  128     1.00 [  0.00]( 0.88)     0.19 [-81.29]( 0.51)     0.52 [-48.47]( 3.92)
  256     1.00 [  0.00]( 0.28)     0.17 [-82.80]( 0.29)     0.88 [-12.23]( 1.76)
  512     1.00 [  0.00]( 2.78)     1.33 [ 33.50]( 4.12)     1.22 [ 22.33]( 2.59)
 1024     1.00 [  0.00]( 0.46)     1.34 [ 34.27]( 0.37)     1.31 [ 31.36]( 1.65)
 2048     1.00 [  0.00]( 0.75)     1.40 [ 40.42]( 0.05)     1.20 [ 20.09]( 1.98)


==================================================================
Test          : stream (10 Runs)
Units         : Normalized Bandwidth, MB/s 
Interpretation: Higher is better 
Statistic     : HMean 
==================================================================
Test:     tip[pct imp](CV)      sh_rq_v3[pct imp](CV)    sh_rq_v3_tgload_fix[pct imp](CV)
 Copy     1.00 [  0.00]( 0.84)     1.00 [ -0.22]( 0.59)     1.00 [  0.08]( 0.90)
Scale     1.00 [  0.00]( 0.42)     1.00 [ -0.33]( 0.39)     1.00 [ -0.15]( 0.42)
  Add     1.00 [  0.00]( 0.58)     1.00 [ -0.48]( 0.28)     1.00 [ -0.22]( 0.34)
Triad     1.00 [  0.00]( 0.41)     0.99 [ -0.65]( 0.38)     1.00 [ -0.29]( 0.34)


==================================================================
Test          : stream (100 runs)
Units         : Normalized Bandwidth, MB/s 
Interpretation: Higher is better 
Statistic     : HMean 
==================================================================
Test:     tip[pct imp](CV)       sh_rq_v3[pct imp](CV)    sh_rq_v3_tgload_fix[pct imp](CV)
 Copy     1.00 [  0.00]( 0.52)     1.00 [ -0.16]( 0.45)     1.00 [  0.35]( 0.73)
Scale     1.00 [  0.00]( 0.35)     1.00 [ -0.20]( 0.38)     1.00 [  0.07]( 0.34)
  Add     1.00 [  0.00]( 0.37)     1.00 [ -0.07]( 0.42)     1.00 [  0.07]( 0.46)
Triad     1.00 [  0.00]( 0.57)     1.00 [ -0.22]( 0.45)     1.00 [ -0.04]( 0.49)


==================================================================
Test          : netperf 
Units         : Normalized Througput 
Interpretation: Higher is better 
Statistic     : AMean 
==================================================================
Clients:      tip[pct imp](CV)        sh_rq_v3[pct imp](CV)    sh_rq_v3_tgload_fix[pct imp](CV)
 1-clients     1.00 [  0.00]( 0.87)     1.00 [  0.08]( 0.17)     0.98 [ -1.64]( 0.34)
 2-clients     1.00 [  0.00]( 1.42)     0.99 [ -0.93]( 0.75)     0.98 [ -2.18]( 0.68)
 4-clients     1.00 [  0.00]( 1.16)     0.97 [ -3.05]( 1.18)     0.96 [ -4.29]( 1.11)
 8-clients     1.00 [  0.00]( 1.41)     0.97 [ -3.18]( 1.04)     0.96 [ -4.04]( 0.98)
16-clients     1.00 [  0.00]( 1.85)     0.95 [ -4.87]( 1.00)     0.96 [ -4.22]( 0.98)
32-clients     1.00 [  0.00]( 2.17)     0.33 [-66.78]( 1.11)     0.95 [ -4.95]( 1.74)
64-clients     1.00 [  0.00]( 2.70)     0.20 [-79.62]( 1.45)     0.45 [-54.66]( 1.79)
128-clients     1.00 [  0.00]( 2.80)     0.13 [-86.68]( 3.15)     0.37 [-62.60]( 1.60)
256-clients     1.00 [  0.00]( 9.14)     0.13 [-86.89]( 8.53)     0.92 [ -8.12]( 1.91)
512-clients     1.00 [  0.00](11.46)     1.18 [ 18.05]( 4.73)     1.12 [ 12.32]( 5.50)


==================================================================
Test          : schbench: requests-per-second 
Units         : Normalized Requests per second 
Interpretation: Higher is better 
Statistic     : Median 
==================================================================
#workers: tip[pct imp](CV)      sh_rq_v3[pct imp](CV)    sh_rq_v3_tgload_fix[pct imp](CV)
  1     1.00 [  0.00]( 0.00)     1.02 [  1.67]( 0.45)     1.01 [  1.34]( 0.45)
  2     1.00 [  0.00]( 0.17)     1.01 [  1.00]( 0.17)     1.01 [  1.33]( 0.17)
  4     1.00 [  0.00]( 0.30)     1.01 [  1.34]( 0.17)     1.01 [  1.34]( 0.00)
  8     1.00 [  0.00]( 0.30)     1.01 [  1.34]( 0.00)     1.01 [  1.34]( 0.00)
 16     1.00 [  0.00]( 0.17)     1.01 [  1.00]( 0.17)     1.01 [  1.00]( 0.00)
 32     1.00 [  0.00]( 0.00)     1.01 [  0.66]( 0.00)     1.01 [  0.66]( 0.17)
 64     1.00 [  0.00]( 0.00)     1.01 [  0.66]( 0.17)     1.01 [  0.66]( 0.17)
128     1.00 [  0.00]( 5.70)     0.96 [ -4.06]( 0.32)     0.95 [ -5.08]( 0.18)
256     1.00 [  0.00]( 0.29)     1.04 [  4.23]( 0.00)     1.04 [  4.23]( 0.00)
512     1.00 [  0.00]( 0.39)     1.00 [  0.00]( 0.19)     1.00 [  0.00]( 0.00)


==================================================================
Test          : schbench: wakeup-latency 
Units         : Normalized 99th percentile latency in us 
Interpretation: Lower is better 
Statistic     : Median 
==================================================================
#workers:  tip[pct imp](CV)    sh_rq_v3[pct imp](CV)    sh_rq_v3_tgload_fix[pct imp](CV)
  1     1.00 [  0.00](12.39)     1.00 [  0.00]( 0.00)     1.11 [-11.11]( 0.00)
  2     1.00 [  0.00]( 5.53)     1.00 [  0.00]( 0.00)     1.11 [-11.11]( 0.00)
  4     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.00)     1.11 [-11.11]( 5.00)
  8     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.00)     1.22 [-22.22]( 4.84)
 16     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.00)     1.22 [-22.22]( 4.84)
 32     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.00)     1.12 [-12.50]( 0.00)
 64     1.00 [  0.00]( 7.04)     1.29 [-28.57]( 5.96)     1.29 [-28.57]( 0.00)
128     1.00 [  0.00]( 5.53)     1.44 [-44.44]( 0.00)     1.56 [-55.56]( 3.78)
256     1.00 [  0.00](17.11)     7.96 [-696.25]( 4.54)     8.14 [-713.75]( 3.99)
512     1.00 [  0.00]( 2.39)     0.82 [ 17.70]( 7.19)     0.96 [  4.43](10.52)


==================================================================
Test          : schbench: request-latency 
Units         : Normalized 99th percentile latency in us 
Interpretation: Lower is better 
Statistic     : Median 
==================================================================
#workers: tip[pct imp](CV)    sh_rq_v3[pct imp](CV)    sh_rq_v3_tgload_fix[pct imp](CV)
  1     1.00 [  0.00]( 0.21)     0.98 [  1.63]( 0.92)     1.00 [  0.23]( 0.79)
  2     1.00 [  0.00]( 0.12)     1.00 [  0.23]( 0.00)     1.00 [  0.23]( 0.32)
  4     1.00 [  0.00]( 0.12)     1.00 [  0.00]( 0.24)     1.00 [  0.23]( 0.00)
  8     1.00 [  0.00]( 0.00)     1.00 [  0.23]( 0.12)     1.00 [  0.23]( 0.12)
 16     1.00 [  0.00]( 0.12)     1.00 [  0.00]( 0.00)     1.00 [  0.23]( 0.12)
 32     1.00 [  0.00]( 0.00)     1.00 [  0.23]( 0.00)     1.00 [  0.23]( 0.12)
 64     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.12)     1.00 [  0.00]( 0.12)
128     1.00 [  0.00]( 2.80)     0.99 [  1.50]( 0.35)     0.99 [  1.25]( 0.00)
256     1.00 [  0.00]( 0.11)     0.97 [  3.44]( 0.23)     0.97 [  2.80]( 0.34)
512     1.00 [  0.00]( 1.28)     1.01 [ -0.77]( 9.09)     1.19 [-19.31](14.03)


--
Thanks and Regards
gautham.
