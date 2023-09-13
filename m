Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231D379F59A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 01:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjIMXlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 19:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjIMXk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 19:40:58 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2092.outbound.protection.outlook.com [40.107.243.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62591CA;
        Wed, 13 Sep 2023 16:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEE/5oxMBUf513pBS7SXqYJCoUovmZCo75g66U5h2Z7MBg84vqDQ/fJxQ+qMvhvEe65o4RmijFXRd27Q01gOwmchY2Zi1uaLZmlCSi/Bey/XlFTnFmW3AD5+64ETAA9YkcxlSuTUcYIVKuN4t+jBQT6+/hsMFN4Rq8+8FfMWEMR+g2fd4x26S9EZ6zin8diQ1actY0BIFdhfN4VFfL6uCKlABd+b+GKb5hFx5/Kg/Q44XZbjZsmyQg62rznL89kc6I1SdEkdu+vSpcM58i5G758jBS+flnkk+YaOZ+58YFwCAQDKohD6jBKJAs23L7UwhZazc+fUTluXnZ8hrw7HIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDFIFck4UWrz+RGf11qmLKfLxBYiP9tsmvdwPpcKwN4=;
 b=hL5jV7rQTVfvWwCLzjjCXSyzccWdHk5ABq8+C3rvsiacVNkzox0moqf9lpzgdQv2W+ajS0bxXjU2OMaOy4GW28QJEVWHU5CVbugb8ZUiPPNcotIR+/og9oFoHwuKiawVWAa5RJHDvv5jur8RAX0Y0XPe5dvbh6EXe0lGiHiH1GGSq3Ei8Vbwzo3gzn+RjkjZ6oRfuh+4fvZuD09JnhShxytXdlT4M+3Fqge61V4VWBMmQFN/r2wNtHJSTkFj4wkusxVCsrr3OJyk9l+OD5yQ//4/j1BKKUB1NCAulO+MS385zEDIxnWnGB3oI2MZNqEd8XQz+DbVcnUXaSW4eWZ2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDFIFck4UWrz+RGf11qmLKfLxBYiP9tsmvdwPpcKwN4=;
 b=BtD/pTGLBkPdXKmVKfhOHMcnXn+HXNsFN+H48e0g9RzCvEBNlZrGDOFcZ7vdPQoKew4w0oO7kGzY/SSb6PI57rEBe02G5WQCBvvcUN2xcCHjkQsFZVngsA4wk7LGefe6jzCQaivtTWhqCtKeQmOKVGhx3CQrkcamnOSPCqamDAo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 CO1PR01MB7258.prod.exchangelabs.com (2603:10b6:303:151::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19; Wed, 13 Sep 2023 23:40:50 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::bfa4:8250:f526:5015]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::bfa4:8250:f526:5015%6]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 23:40:50 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v7 0/4] perf: arm_cspmu: ampere: Add support for Ampere SoC PMUs
Date:   Wed, 13 Sep 2023 16:39:37 -0700
Message-Id: <20230913233941.9814-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR18CA0040.namprd18.prod.outlook.com
 (2603:10b6:610:55::20) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|CO1PR01MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: e498b74c-d84b-4b41-8465-08dbb4b2dc94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZStJyY3nNlxKA2yqcqeRq5xoowrNBeOJNXAn3mmMM3Y2ZB5LG6tWVxvAesaWX4zrl/E24588eYtI1hHodhZBEEOh3O4UzLcQx+kGiu3185LyxRUi64Cs1zZzcPau3VJs2CNR0ib7CR51RswiXae0n8OtlMT7pEMZXqHmIaNNwnWUkeEJHvvuX8qEsYTSsHnPgIdYSgWHZoFy7u3Lfjw8tXaxuTOZXl150WimJttcMJVwF74paB0H6nbPGl1R2s4yXWawJXOq6xVviezOxRUElYyXmAOBTJ5lthcW3StzeApx65OdPSGMXmC4azWbKExSq4Zmz1IlfTRwzwdJR1kw66xyDMz4nwBbvN6Lw+CVd6SziX5Qm+0BIuk773ppPBV+KfhBK7QmZZ6A+g4Tf9u8mo6YLDvT9zRHpPDcL9cUTWd2p5ADlwvQeUDK5HxcAHXJE9Cv+zy8mGMF7L4tmG8Md4gYfEsWEw32tVNjWugRT1dBZdobJ7fjlbEsNisLLrBVq37+hyoQi3dGSWI2Es1LyW02BbyEkNCl1NhTN3Kx/hL7C6rNihCs/NfGM+w2fdGaR0/n4qk1UmAACTmDfyCuDYQ/58r/eVsInM+i3ywMT0STeOA/IGm+YtdjrPVLoiZhjtUiL4wH9auuuNVig430w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(346002)(136003)(376002)(396003)(451199024)(1800799009)(186009)(7049001)(26005)(1076003)(2616005)(478600001)(6486002)(6506007)(6512007)(52116002)(6666004)(83380400001)(966005)(5660300002)(7416002)(316002)(2906002)(110136005)(8676002)(4326008)(8936002)(66556008)(66476007)(66946007)(41300700001)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xlyBmmdW42WN68fTtuQRSNaGRSW9SMbiXhlwZYP8J1efOZ3m0xrkFuwLDATQ?=
 =?us-ascii?Q?wZFnz4OeXwEG8xgPnqXyc/SmIAAEwoU2UpDpslCSzwhC2uAFJZfo4X4EigVe?=
 =?us-ascii?Q?JbW98SSAZDduSKNwlavV1HAAKnbWx/IQn3cbaR9Rr4dvQkQ05F/cqd1qTo05?=
 =?us-ascii?Q?V5YwqUt0r54LHgMBRa77mXuEGDAHjV2Qbd3Lm0wcxBGx53efus7hWBPDJKD1?=
 =?us-ascii?Q?BAqcRFCN1L14PR/HHLg7AJ70tYpFqqJDpyI45qTQHu/xAjh8Jj8msKGHo/i0?=
 =?us-ascii?Q?UhsrgQ7KRRAGPjTNpGco6xtwQqSbUnO/9anvFPdTrbNPFk2Rw7lBcuCzXr7V?=
 =?us-ascii?Q?tqu9RxQK6TASPwIrXAROL8Ugbv5bsG9u6CNkwqgmucmprLuEFFiyVWsR3iSG?=
 =?us-ascii?Q?Hn/0g/9iUUANxn9nZ1yNba6RoVmwgqsDdP+cqf8w2g9r3KPR+e2ABQQQojnj?=
 =?us-ascii?Q?ZF4+7n2uqNxN9LkB2UcXIyuL0ABKX0R2794Pa9AO0CdkbxG+sbur4Mi57Vl6?=
 =?us-ascii?Q?g7ZElLmMpghuxl28IwMeyjWP0x+SVkqEgmAP+AMz4tTBZ9CzSsWWd3CLqGSg?=
 =?us-ascii?Q?1cuKJNfxredZ9c83zuEea4rILjLktW9RXeHJpK1KXaSJJNiA9oNiearqRQFR?=
 =?us-ascii?Q?RBrOTeJcWd4/8KZtMrrQAC7DY4obNKdJaUrIjMwIE7AU/bt1GpDV4yPaOff5?=
 =?us-ascii?Q?EbxtfI9hCvN+/71TV913NqIgorwgj8BFQJ4TAwYiGzpqedeyz90XuwhEwK9F?=
 =?us-ascii?Q?fuBlzHBEJxHDYhUAlOJi47pOXBDNMb62P3DXoIlCKAQybjvUE3t5uGFsfiMk?=
 =?us-ascii?Q?mOwAbEfft6HyN6m1YFp6XyfUNx55zQD4xjHcsGjG92T0KdSv93OyDtvdeKlY?=
 =?us-ascii?Q?M8cOzg+C/+ycUqueAsXei9qInqsxESArJN6DdqZ96+llt47DhkKOMyZoBMwK?=
 =?us-ascii?Q?unVsvme0+j1QzEzyk370JTLHpyYkpXmT934BT+1T9Wcia6cfjXQ71DFt+uA0?=
 =?us-ascii?Q?7KuSNMa47XMQOo8FHGktRbpxB/HaFlnZUSuN1MAO1vkuQDBJc3I+ifCbRM1n?=
 =?us-ascii?Q?SMbrXPaeC/Hz5JoqTZo7DD6yeiB6i++zrJeDvqRZPqlZkUGOwW+/jRB+J44L?=
 =?us-ascii?Q?e7VUfljXJtfOfa7DvCdgJmMpCgGeIaaTr0vYN8AsjjPBH/vaIj3aj337bcX6?=
 =?us-ascii?Q?vB8HGRj/ifzCTSAewJwOrA5ZKrQ8yxyrDz20IHjSP1tk0+4U2ddYI+YXocWw?=
 =?us-ascii?Q?39kYQkq/uNjQFDupFstM0WtgQdY4h8wCQxVsbMhLaWjCDk8BXqfTzs9ZmLdZ?=
 =?us-ascii?Q?Hoc9wC0VmqHPI9+CuvAhs3ibRMNU3qchIDQz+Jex60wuxbFwb17jXaLbfp5X?=
 =?us-ascii?Q?DlNe8C5MV3L1StkzS49Ut1dP64xWgFskl8TEfg8RLDQy5KtGaruEDLMesaUe?=
 =?us-ascii?Q?ap0LUK1D4nrxLMtUiTXa/L8yqcnWjCbkwxyl/+gf54zHnsfaAUJ4w6IohtYE?=
 =?us-ascii?Q?QsWSz5wuxBaal0ut17SSnN0hys/zz7A8XMOY6rpP6z3LEUyc32CFu265OTEz?=
 =?us-ascii?Q?qrDa8PyF67Kut0hUMX7DcV/zJL8VkNwiAXLQeE25uqDIBskinJ2agQqCMEz/?=
 =?us-ascii?Q?/TL7nHdBUbCAyj2hUMTnc6E=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e498b74c-d84b-4b41-8465-08dbb4b2dc94
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 23:40:50.2184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQzkktqRU5b8TWUOocEqIm5NN9++PaBLrCuTuLzEDGBbotG2tnSt2tFmX8ThWdJZckCbR5PZjWb2OK2WJKI+6ucyKrkeUsueATI9K/qxUdO9f4Sagi4K3l2/J2L5mOiw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB7258
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v6:
    * Rebased on top of Besar's updated patch

      [PATCH v6] perf: arm_cspmu: Separate Arm and vendor module
      https://lore.kernel.org/all/20230821231608.50911-1-bwicaksono@nvidia.com/

    * Changed Ampere specific module to use ida/ida_alloc() instead of idr/idr_alloc()

Changes since v5:
    * Implemented the needed parts for vendor registration API
        * Rebased on top of Besar's patch

      [PATCH v5] perf: arm_cspmu: Separate Arm and vendor module
            https://lore.kernel.org/all/20230705104745.52255-1-bwicaksono@nvidia.com/

    * v5: https://lore.kernel.org/all/20230714010141.824226-1-ilkka@os.amperecomputing.com/

Changes since v4:
    * "Support implementation specific filters" patch:
            - Added comment about filter and impdef registers and reference
	              to the Coresight PMU specification to the commit message

    * "Add support for Ampere SoC PMU" patch:
      - Fixed the documentation and added more comments
              - Changed the incrementing PMU index number to idr_alloc()
	      	  (Needs a impdef release hook patch to release unused index)
		  	 - Fixed style in init_ops() to more reasonable
			   - Moved bank parameter to config1

Changes since v3:
    * use_64b_counter_reg => has_atomic_dword (patch 1/4)
        * Removed the unnecessary hook for group validation (patch 3/4)
	    * Added group config validation to ampere_cspmu_validate_event() (patch 4/4)
	        * Rebased the patchset

Changes since v2:
    * Changed to use supports_64bits_atomics() and replaced the split writes
          with lo_hi_writeq()
	      * Added implementation specific group validation to patch 3
	          * Dropped shared interrupt patch
		      * Removed unnecessary filter_enable parameter from ampere module
		          * Added group validation to ampere module

Changes since v1:
    * Rather than creating a completely new driver, implemented as a submodule
          of Arm CoreSight PMU driver
	        * Fixed shared filter handling

Ilkka Koskinen (4):
  perf: arm_cspmu: Split 64-bit write to 32-bit writes
  perf: arm_cspmu: Support implementation specific filters
  perf: arm_cspmu: Support implementation specific validation
  perf: arm_cspmu: ampere_cspmu: Add support for Ampere SoC PMU

 .../admin-guide/perf/ampere_cspmu.rst         |  29 ++
 drivers/perf/arm_cspmu/Kconfig                |  10 +
 drivers/perf/arm_cspmu/Makefile               |   2 +
 drivers/perf/arm_cspmu/ampere_cspmu.c         | 271 ++++++++++++++++++
 drivers/perf/arm_cspmu/arm_cspmu.c            |  33 ++-
 drivers/perf/arm_cspmu/arm_cspmu.h            |   7 +
 6 files changed, 346 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/ampere_cspmu.rst
 create mode 100644 drivers/perf/arm_cspmu/ampere_cspmu.c

-- 
2.40.1

