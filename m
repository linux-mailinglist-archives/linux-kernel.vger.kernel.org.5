Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9602A752E65
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbjGNBCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjGNBCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:02:15 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2099.outbound.protection.outlook.com [40.107.220.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18521FEA;
        Thu, 13 Jul 2023 18:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOIJ2yJRoq6vd8QYQG9/NpWlkH6f6SkhGuqRS5USiR++pTC5X4Mb9ub7D3jvtqxWhQY0BbRBl4KB+CpkVjJPgkNFpxf1mhAWlIirgnQpyDUZkAbqmiFAk/5N2S5RYrRjiEAx6DXoZ/GjFCdjJYbKePRPgVfw0a+CRROMYXLXA0yIgMEB2JGbBz+th2fTtYLMsMOE7nuLybqiGGKP1AMdO0YlJoqmtItS3Pw5RpdZzeGDMqcvc3Mb9iC7e8pywDscSYF5d2URmdbheThzy6h2Mnmj/STCsiJSgGnHPrH0uw4YTAyrHm+lDu+bKU4l3WLAFE00ZwVM5/IWRR5oVXJKaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7xHvM/kA4l9rUNrVhBg9XsMqEcNUDOakWs0wrg+nPg=;
 b=gYMrqJhtWx7vjIXKc2n09XwMmLS3dNOTfdC+SJv9rrHbSL5cn6cs5fwGe2TLRTnTBzEFit6mmDaDgXXob2/x/dNeFYGzaH1daCm3vnrfMk1sKn0Zvb461iY4UMrt+SSy6Z1p6jgJEYhJh6ZqCv9nq+j+A1K4456Vj1bPQnNCByXXEunKv4LxzRnK4LAjUdg4VFctCDvKOv4/EQNmNdO0MgZSvkCoBxrNo36n5brB0A8e2EvFonpQZOcRWnbR6OCwNd0bws3ipIwSu1mCLlUYXZlogI6xcyT7oNj3YA/JmC89eXmSd+Qsm9r46jSt6uhy+udiC4ys2Z/ztyInAUiiJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7xHvM/kA4l9rUNrVhBg9XsMqEcNUDOakWs0wrg+nPg=;
 b=CTeQ1aG9I8IRH2APo/vfiiOG8zG7SJBAI10ZcF7S3neQ/b/j7QUf2lkJ1LIfNTx6kPV4/hV9HateOSMH7+/Aw+CHXpnaWRU7Yw6btkl4cqkicOg4NLYe1/XHkqrZkhfFDIR9kczMUvrCF8b9WVus+hdSxaTqOmSgFiNJ2ynypQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BY3PR01MB6611.prod.exchangelabs.com (2603:10b6:a03:36a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.27; Fri, 14 Jul 2023 01:02:08 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::235a:622:9239:3963]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::235a:622:9239:3963%7]) with mapi id 15.20.6588.017; Fri, 14 Jul 2023
 01:02:08 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v5 0/4] perf: ampere: Add support for Ampere SoC PMUs
Date:   Thu, 13 Jul 2023 18:01:37 -0700
Message-Id: <20230714010141.824226-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::30) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|BY3PR01MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: e513d80a-87d7-4697-510c-08db8405f284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kOdoI20KWQbLL/ZZQf08H/fTIeR1Zpyz0mi9K9HnOfob4qowXaEo3PwarwIRI0VLAAgu6/SxxOzv4atJrzNTXebBdagp34cNIekQMEobKzT22fviOYevFTtj/BgekzO7xKAfSXtWcx622KUHtDFQG9UjAK8MFwjdCt6KEKJGj3O8JelRKvutyx10OmHbsF3iQ0dY9iBpoXSfOEn/5MOgkPjhIObvkbjJujrHvms9tEzF0CeRhbeysgZsP+sLqby12azXWp6FczTVxDu0ZvusQs35qa95gAVEJHoKYhPET7zfwB8WBLGmDQfrcoib9L4cQfYgJh1E48NCKCfg7/rlYfNeutmp2nC1DhjpVtQD+b4uOskefkueQ5NsPzmIvOkw6nc507LxAeiK3sk6CUedAKy6t9r5Zge3++yOl6XzM2JX9mUPpBtgBkQYEXVdE6RkgpRNMUGyWCRkrEXSADmtg5ZsEMw+YIqH1cO7XyJAuxHE+0DmOIIk/F/souguSXF7eiB/RfcKBFVtYFLEKzXd+Ft7Y/eQV7ISUuRYjlS9GCMxWdYWLBr4yemRq7V9MhhYSZImkEGhFJumPzpOXMGBmimltkeGeDyAbtZngTgPgdGCjWt6FMmxkHbnMM44eNvW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39850400004)(376002)(451199021)(2906002)(38100700002)(38350700002)(6512007)(83380400001)(186003)(2616005)(26005)(1076003)(86362001)(6506007)(5660300002)(8676002)(8936002)(7416002)(110136005)(478600001)(6486002)(52116002)(6666004)(41300700001)(66946007)(66556008)(66476007)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jnw15+n75xoLosSPJdD+yHVvDIQTO8rfOc3bqn/eNlxJC3zGlYg0FNChb6iU?=
 =?us-ascii?Q?tpAz61R5sU/yFnZrUydKx8KL6YTmdJp8wHEjp0i4fsfmgo1pBSFovwi8rN7F?=
 =?us-ascii?Q?Fd9/uoKAht3iwfhAMrwez6G6MUaFec0ZG7hVTv353e9I5F0BqExj2AG6IY/3?=
 =?us-ascii?Q?zLuYBqN0MEaHuizuLl3zBWxUIxBV9OrZ9ES04VWklhR2V6KPyQkXa+YzQm0v?=
 =?us-ascii?Q?T5GITaDr0m5VjFAiulWMKlM9/mgQZR/77VlyQSwGr/6JPA/5uHyUYNap0R1G?=
 =?us-ascii?Q?g1y98+XhqcqTlQs3tnHr6Isb96BPvfU2d/jtXPaoPZQbPfIlZLOFBM1slStK?=
 =?us-ascii?Q?a4TXOKwiEMYIIyQOVMd0C6PMvoYnDw654zNmqtasYCgX9CK5lok9pcgbDK59?=
 =?us-ascii?Q?YKXY6tuMkhBHufHSo7ql33hy6cdgJl/pCs77oCpkJ0MxgzL3eC0wxyMcYANA?=
 =?us-ascii?Q?AjkUFc8GwmuKOeReVCVk0mFiXsqJSJ/myPLiIe58OUv7/5aHObDjIl7NJxCN?=
 =?us-ascii?Q?AZKc94f/U60z/3cdm6M9kQcRKO0SPLF7IcOzgM6mJpRcm+4EqhP7I83WUrsn?=
 =?us-ascii?Q?7KRZY9mA1vmzrbNyQ2oy1Bwb3UIc+KLZSuErHsR8iePEYgwsaUPla73HLfVG?=
 =?us-ascii?Q?6rHDuXB/Fdf3+ikMqJmlp8JdmOgYn0fuwFIh1alQWclJyzAX7AcUOmdniynk?=
 =?us-ascii?Q?p4OQXBJSV1pUwt1wlcytgiv9XTiFwZYL34kQlvWITsiXYcEIzEVAJSORVDTt?=
 =?us-ascii?Q?Tm/v4zUwX0WYwpUqOCZJC+KEHKV/vBe2Qrwmtous7m41UkyUK1qY0ZJ2pzdx?=
 =?us-ascii?Q?aZTFfl+eZXRwyf8CHlTtV7xEcrgRNuWg/Rz58m9BP0DFN6rSxyC8daDIU7cI?=
 =?us-ascii?Q?uJ4OJ7PXAcM8g46oQSgbUXFv6F8w5Q33gEa+58qHLpD6QeKyD6RYf/l8YFEI?=
 =?us-ascii?Q?Z310FyTZllXTtCnl2TR3vrAr4pzVlkToRRWGNvGH0rpsL2ESiz78041x4sdg?=
 =?us-ascii?Q?x1BJL2ReSZ78hF0RAJS7lUW7xL/ylJShdpV+5k3SpkqmU5ej85+rnfKCUIc4?=
 =?us-ascii?Q?ujkhi/6UkESrda93K3BdTm0J4scv5jSClM/jt8eVYH9ssSGZ+WdZ7STp69my?=
 =?us-ascii?Q?0C4PkBc2HYTHIKiNgrBq9pkAHOVufnj+XQ3QiIaNEGeSD8p1bP/zNMsb17hi?=
 =?us-ascii?Q?MBuxXGjrRaCXAjIf5VdyahN1+FR8RY8WG4ytRZp7FSBTAR1ROY583n6+lutN?=
 =?us-ascii?Q?ckS4bpORSywzQMikwXZ4qmCcsmb4liQbgde7lhQaaQO4JF8y1b+JvhK8lPSM?=
 =?us-ascii?Q?QSj31eAOcH5D4iKKBT5hgGc73HqIjmhB1XsyN5KmAYLgI93vaiTc20tS5f7c?=
 =?us-ascii?Q?KPTALvOBXKdqTx8NZ0HE1IVdt2f6cRyZ1D/oCIo3JvugvypqUbdOu89CmXsS?=
 =?us-ascii?Q?FR0tpnfWF3iPWw0jdhmchW/vNX3XoOthcbBJesAPU0yZWjbP9/ovfk8TEn3L?=
 =?us-ascii?Q?yR5H/CNrbMRdudlsVKEPrzg2pTEYigHoqh40BY8Qij7l2tUUd3GXRqrsOaUh?=
 =?us-ascii?Q?vpTxu31wysZoLMbH2Xb5qIiby65/zy9A/Qm+tQEfcCtLcaOeVkgYdsG4CJfN?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e513d80a-87d7-4697-510c-08db8405f284
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 01:02:08.4384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VvL3LwkUaI9lwSnrkLRPtupK6ENLV7Z3/cCEFB0+b1LslIpsAeDbxPGN+DGRJHZDQd2914bc7V0c+74ayJmPKM+9kXKUu0aselbsIuzT774G9NsL2IEUHFc8u3SWS14R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6611
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

 .../admin-guide/perf/ampere_cspmu.rst         |  29 +++
 drivers/perf/arm_cspmu/Makefile               |   2 +-
 drivers/perf/arm_cspmu/ampere_cspmu.c         | 243 ++++++++++++++++++
 drivers/perf/arm_cspmu/ampere_cspmu.h         |  17 ++
 drivers/perf/arm_cspmu/arm_cspmu.c            |  29 ++-
 drivers/perf/arm_cspmu/arm_cspmu.h            |   6 +
 6 files changed, 321 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/ampere_cspmu.rst
 create mode 100644 drivers/perf/arm_cspmu/ampere_cspmu.c
 create mode 100644 drivers/perf/arm_cspmu/ampere_cspmu.h

-- 
2.40.1

