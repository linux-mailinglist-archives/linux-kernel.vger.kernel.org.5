Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E065E777166
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjHJHdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHJHdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:33:53 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2133.outbound.protection.outlook.com [40.107.92.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3E910E6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:33:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qe/XZj0cUnrz88Ahkx/LgFMIBfpXIlGOZCDJ2YUrhsNmWwI/qYB5D/LpDFh4bUuzJ+HHS8jcrMxNzMroyZ+NjIf3j4UdFYKQol38oDmPDi/LXiraj0emFO+nxDchtwrDYcoZYHbt0WKuNuBK9lftQq+Jz4cYlNAi6JEEtRIqlKvgGk38nciE8RkJNsQMjqvRw5K3UECfBtxdZwCskYrrNgVadh/QAadWPWL5WNoGpI2nd9keLCvFWAp4rYFYn+HfoMRXPImzdxNiufQngi0cpp4g6Rwts3Uju6BTaNisWmWR3bqfMBPq42K65zTmDuDFt+PJu4s4CHpTipq0aan2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNw7ZTEIocFoEz1W8mKWD53lYWloBxmGmGHJHRQx1G0=;
 b=hwACAqElGf+Zqd5UhSp8zQJUJemgxspedxAqCiuLajHN2Io7/5rEhgkRJuooSwfS/2fgPu2nVIiUu/+FwDU8qw683RRkPQg2TpOlMGt/NS6rg/HcVHImPk6ErekDfqW0MSnVtvA4kNRiYiEjUoaIAJP6wEndrfGiM2rvW7ZjKQzmr5QZLtE17QSX7tGOxgCOXY2zyjSmAvLo5t4chHcWjfEJnFUwfrnfS0FBAZMVl/Ll/hJKF+m1ZO2WSc5F6LePLIVDbmscUWJV467714zdE+nKyxcvEpL5OfggAKZPEAhGhK97Ge2RXRPjqtpYZjtS7H6vfzdboIhTYhxc2cn1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNw7ZTEIocFoEz1W8mKWD53lYWloBxmGmGHJHRQx1G0=;
 b=C/e5jHDbH/2PBICWV+hQOyOGZ830dt6+csZPgVOlaxCCfW3NFWROr1Atw2FA8MKPITqI0kM/2+Z6v/IPP+H8P/zCGCz6wcvQVr1c5ya4XtrGM4JYZ1T7R0qBDOTqWqanXVRHwpkHl48XUeIC97ztGMT87WjvG/makstxsEcvqIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 PH0PR01MB6780.prod.exchangelabs.com (2603:10b6:510:76::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Thu, 10 Aug 2023 07:33:46 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d62f:d774:15b0:4a40]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d62f:d774:15b0:4a40%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 07:33:45 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     maz@kernel.org
Cc:     oliver.upton@linux.dev, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        zwang@amperecomputing.com,
        Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH v2] KVM/arm64: reconfigurate the event filters for guest context
Date:   Thu, 10 Aug 2023 15:29:06 +0800
Message-Id: <20230810072906.4007-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:610:4c::13) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|PH0PR01MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d1d45d-6c8b-4b32-616e-08db99742081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUoSa6h2zNi1vVbTURTX7lNzmnBaYK3eLvqilyE5ZCcp2yi/OAUBamtBWcbmARjGqOogxJSTSYH/vFokfzaVCj57+WkXhgAek+XegPX45nyO8fGkMfTBm0u2UuVxgCzS8VVmaAP0Lch2yWytaHX8UxcMLHz21xTS5Yd2Ue8JCPFFx/tJ7hcLqVtUnc/2ViKkEZ4NJrYJt/L50djFrfIZGWmvFTyYpM8w4fm7pLsj6+XNktL39tz0AhN1G0obwd+gVcBIIj2vINd4iA+ctNnlZOta5tLpQ9ZtOwlYOGMhkbEEq6XF41A9roS4skTzsIDB0JXsc7V11Gs22A23fcssRkMEA80JXCrNLdvtZ1MwLOyR294nN1loB6gKXRtn+uxcr9bU2cP6VgIrLShZ1nnI8EDMpwpyCB9YZ0VH7pXjJpkbnYKkTtVDPWRdj4UE009P9VMhs/qdglmtg2hsUJpppL9+xAi24BrxY8Ui41NE9YP2guSpNIq9Am3oc3DZf8hsa2nl8G9ZTc2lVaQP4viUMfjpqqnzw9r1ZVjY9aP2MtouZ3ixpn3k1JTtQZ5OF4ZeZZGXC2RG8j4IwJBXbkgEUjq8PRWDGHWMBiEVlwX+zuA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(376002)(366004)(346002)(396003)(136003)(186006)(1800799006)(451199021)(66556008)(6916009)(66476007)(6506007)(66946007)(1076003)(26005)(107886003)(478600001)(6666004)(83380400001)(2616005)(52116002)(7416002)(41300700001)(316002)(4326008)(6512007)(6486002)(2906002)(966005)(38100700002)(8676002)(5660300002)(8936002)(38350700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uHmxR/qS5mIovXvH5AbSbED1EmCyPMjDwaJoRHFN/O5/CJmivBEcdRJiyzxA?=
 =?us-ascii?Q?m2jaFY1+7WscpmWiYiWf+AfrxW1DMV/mTYqGUiZ+O8tVcEG7OUN9DLjgMJMX?=
 =?us-ascii?Q?dFpWFE4IbM1JYGLVq2U/xAKrHEJI3Sizcd60g1KN2NDpmxI36tJDeqK7+QF5?=
 =?us-ascii?Q?Q+HzvJGbIcy+EWVqyYuM55/QDYrivBEO8/p5OgQ3plzwG9zApZ0YKsbeu9sQ?=
 =?us-ascii?Q?EGG1eqAPSOF6D9P85VU6zG/mtr1S5sqjm84KpVMk/8BMqLLPkIO0Jg4mmKcp?=
 =?us-ascii?Q?R233hh11IEm6OaCxOozO7QbviWiim8k/8YDbzrSih/XeG/H2eTmjtH4UdONy?=
 =?us-ascii?Q?CuFhMXmE5oHYNevmKEc4uRtAL7lvaMdrlNr6TQ7PKMvtEodx8IVj/D9FLstV?=
 =?us-ascii?Q?324ZjkNHmxutRC2keBw1NF75SJ8VJ9/KY+K8ysL7jJrq6AdyMM6QVCha8AMu?=
 =?us-ascii?Q?lxGrMI0MjFtP+FbtEeijBJzdehInwpefyZJ5k7jiJAemc/YAAr3UP+TrDKWZ?=
 =?us-ascii?Q?zVn0XzelILjz4yMmaimRnpSQ4rVOgX/DbAiJi3fuZ/SOECIcBrK8/rNufp2v?=
 =?us-ascii?Q?+fE5ipJyVMDf4pY2EYp8L0QUeum2cBgsbqsHzpTvpQadWElSAP9v1BUs/7h6?=
 =?us-ascii?Q?4xnaQrrJVKRRtY/i00L2hgzRkVuUKd9+alhJ4lI+KXiAq8YtIZo+B/Nuoikj?=
 =?us-ascii?Q?iesFNhnij1UG6mppMBzFGSRaOXn4Ycu79xm4fo8laPUau6lgqKrAEfJHr5uT?=
 =?us-ascii?Q?+Me/sGtzQD8ri3iuluG/qcfvVZSWhD/YtQjI8GhUOX3LoMaY6vSO4Uayygoh?=
 =?us-ascii?Q?JuvLVQgwZX3hetTLRtrSroZeOP+WG8TIPStc472x5Po9MKgkU2uVv7dsegtx?=
 =?us-ascii?Q?riv8tzwcldkXPkS7/3yMuKN+Tfh6Vp5ejbont3s4Q56MPsMqvtBuKquseXKZ?=
 =?us-ascii?Q?ZsVuWj9UE44bI+ZT9J5TlkPE1gF1/7OF+eoehyjB6jB/MZfG2JU/phqCyPvx?=
 =?us-ascii?Q?3dfr/bGu+E+qAopToAAJiKBt+bF2Piqq1lNSdVdqO0TVg5sbSVH2W1k8/nT3?=
 =?us-ascii?Q?Atq5Wu5ijU/w7kQXWZNlDI84Xa+1DEcuN+lg4OEpIL6n60JlQiS8/0DxXDnr?=
 =?us-ascii?Q?SwzW4sqZWJgIwL8T9LKTxJLuW5npGR3c/sjJ8bsY3oySLXvsYlg7/HAiy4m6?=
 =?us-ascii?Q?aLuE5196UGZ6ucBzN8njCroChMX8d1/xOHyJo8IKMVDwXu9dLkypFP9zNc8N?=
 =?us-ascii?Q?d4fZZoqB0kxq3tPSafkJQjq1cZ7a3zLdbvTPOZsepjAffrZrElBlNLu9cG3y?=
 =?us-ascii?Q?fu3j/KteAZhaeveF7Q81uazjPTRKo0Cl7Qb9Z23khEM4bTS8mUwK9R1bZgaB?=
 =?us-ascii?Q?+JWAdZW74a+01hQQRi12QlseDq4oP4Sqai+MsETVP6iIDZ2wPS+Z7B0v8OfT?=
 =?us-ascii?Q?ldoUrh1/F49vYJ44g3mDI9GgnUqbZBLcvNwQhrJT9w/mvyq/nRyXPrO4HLPK?=
 =?us-ascii?Q?ijeKsK4BNgvZsS12HqMQavsPaYEECMvp343uJl0vmNru7ueMCJJTKObCSTSM?=
 =?us-ascii?Q?61FheghoRyVsnNG24otG0zjkPQuRj2hqzG/wmH24fDAGXbmrodAf2GERL/8S?=
 =?us-ascii?Q?NdH9ORoZOSRhkBAqYr/nGmg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d1d45d-6c8b-4b32-616e-08db99742081
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 07:33:45.2980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0r3+COfroINorBHKKn8vcYwvb0kZsgPMoJZU8alDITGaWlkAYMOhFmvc4XcNrSCcMWUrfrI7YiULlt1/DljKceJwrNuDrUDQOr9GijmxoH+D9KoFyDiyUPpJxGQS2xf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6780
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.) Background.
   1.1) In arm64, start a guest with Qemu which is running as a VMM of KVM,
        and bind the guest to core 33 and run program "a" in guest.
        The code of "a" shows below:
   	----------------------------------------------------------
		#include <stdio.h>

		int main()
		{
			unsigned long i = 0;

			for (;;) {
				i++;
			}

			printf("i:%ld\n", i);
			return 0;
		}
   	----------------------------------------------------------

   1.2) Use the following perf command in host:
      #perf stat -e cycles:G,cycles:H -C 33 -I 1000 sleep 1
          #           time             counts unit events
               1.000817400      3,299,471,572      cycles:G
               1.000817400          3,240,586      cycles:H

       This result is correct, my cpu's frequency is 3.3G.

   1.3) Use the following perf command in host:
      #perf stat -e cycles:G,cycles:H -C 33 -d -d  -I 1000 sleep 1
            time             counts unit events
     1.000831480        153,634,097      cycles:G                                                                (70.03%)
     1.000831480      3,147,940,599      cycles:H                                                                (70.03%)
     1.000831480      1,143,598,527      L1-dcache-loads                                                         (70.03%)
     1.000831480              9,986      L1-dcache-load-misses            #    0.00% of all L1-dcache accesses   (70.03%)
     1.000831480    <not supported>      LLC-loads
     1.000831480    <not supported>      LLC-load-misses
     1.000831480        580,887,696      L1-icache-loads                                                         (70.03%)
     1.000831480             77,855      L1-icache-load-misses            #    0.01% of all L1-icache accesses   (70.03%)
     1.000831480      6,112,224,612      dTLB-loads                                                              (70.03%)
     1.000831480             16,222      dTLB-load-misses                 #    0.00% of all dTLB cache accesses  (69.94%)
     1.000831480        590,015,996      iTLB-loads                                                              (59.95%)
     1.000831480                505      iTLB-load-misses                 #    0.00% of all iTLB cache accesses  (59.95%)

       This result is wrong. The "cycle:G" should be nearly 3.3G.

2.) Root cause.
	There is only 7 counters in my arm64 platform:
	  (one cycle counter) + (6 normal counters)

	In 1.3 above, we will use 10 event counters.
	Since we only have 7 counters, the perf core will trigger
       	multiplexing in hrtimer:
	     perf_mux_hrtimer_restart() --> perf_rotate_context().

       If the hrtimer occurs when the host is running, it's fine.
       If the hrtimer occurs when the guest is running,
       the perf_rotate_context() will program the PMU with filters for
       host context. The KVM does not have a chance to restore
       PMU registers with kvm_vcpu_pmu_restore_guest().
       The PMU does not work correctly, so we got wrong result.

3.) About this patch.
	Make a KVM_REQ_RELOAD_PMU request before reentering the
	guest. The request will call kvm_vcpu_pmu_restore_guest()
	to reconfigurate the filters for guest context.

4.) Test result of this patch:
      #perf stat -e cycles:G,cycles:H -C 33 -d -d  -I 1000 sleep 1
            time             counts unit events
     1.001006400      3,298,348,656      cycles:G                                                                (70.03%)
     1.001006400          3,144,532      cycles:H                                                                (70.03%)
     1.001006400            941,149      L1-dcache-loads                                                         (70.03%)
     1.001006400             17,937      L1-dcache-load-misses            #    1.91% of all L1-dcache accesses   (70.03%)
     1.001006400    <not supported>      LLC-loads
     1.001006400    <not supported>      LLC-load-misses
     1.001006400          1,101,889      L1-icache-loads                                                         (70.03%)
     1.001006400            121,638      L1-icache-load-misses            #   11.04% of all L1-icache accesses   (70.03%)
     1.001006400          1,031,228      dTLB-loads                                                              (70.03%)
     1.001006400             26,952      dTLB-load-misses                 #    2.61% of all dTLB cache accesses  (69.93%)
     1.001006400          1,030,678      iTLB-loads                                                              (59.94%)
     1.001006400                338      iTLB-load-misses                 #    0.03% of all iTLB cache accesses  (59.94%)

    The result is correct. The "cycle:G" is nearly 3.3G now.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
v1 --> v2:
	Do not change perf/core code, only change the ARM64 kvm code.
	v1: https://lkml.org/lkml/2023/8/8/1465

---
 arch/arm64/kvm/arm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index c2c14059f6a8..475a2f0e0e40 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -919,8 +919,17 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		if (!ret)
 			ret = 1;
 
-		if (ret > 0)
+		if (ret > 0) {
+			/*
+			 * The perf_rotate_context() may rotate the events and
+			 * reprogram PMU with filters for host context.
+			 * So make a request before reentering the guest to
+			 * reconfigurate the event filters for guest context.
+			 */
+			kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
+
 			ret = check_vcpu_requests(vcpu);
+		}
 
 		/*
 		 * Preparing the interrupts to be injected also
-- 
2.39.2

