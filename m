Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D139777C7ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbjHOGgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbjHOGgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:36:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2092.outbound.protection.outlook.com [40.107.223.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B2A1736;
        Mon, 14 Aug 2023 23:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDIC8lEfG7+pnBFYrP6Ro6X7nYIt+dKPbsqQwQjzdrq7Ym6MGG7gmHdLXmkOExbqP0llDtZs81iM4vmlJLmyoLF0qTzbQbd6zdzIheXBFoIvSK5bKO19dfW2ejK0KnuG/AvmW+MeJbSRulo9Xtneg5FuetJftGYOS2DRSz6/qNBy8cgz0Z1a3qce6v7UjU3H6V/KfZkgLfSctrvVv9aGBTHoykBBK6t+ixz89Ua/TeFAarL7jATYSJrsR70wmMX8yGAZ6FwceTTKj8wAbiyhzak5SrFZU/mobc3B9M9Hyc310lXpng+WX0j/p7lLNqIAv6WrJ78sAgOSuQ3Cbn/uhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLaJFEvvqoRih8RpT4aYntQcqBfn65/JjyyaELqnYlQ=;
 b=h5ORennEMtWAYNt3887EqkflMO3MMl/Yr7sKOFrDpJMxYFIroi1AQMYsrlO+6AuSGuj1VK8C/rxzNzogXw3g/bJU/83xUVjpIbf+/snWyV9Fq3VZOuwh8yA6jmUp8JrfcTgG9pkJn9AfL/x+UzC/r0xyPWr7DZX+moaYVZo14d8ik7s98fEWCauB5yozKqWwFXdevuJlOO+nBf55/zcCPe8bzT7dNPzVAMIBxJcOFYCN2gHxjyX933Fy0BgK7EvvYqqvmT2SG9/AzhKXUV1oLBs8xPwzZMniuSAdHWs6XXMCXexhmi1kpDK4NB4B5e9zYkMd4gMtFQYGwBcwmLZ71Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLaJFEvvqoRih8RpT4aYntQcqBfn65/JjyyaELqnYlQ=;
 b=EQqtBkscRdymK8E749RkJcnESPkejImx0kWnmEUhLdlrW//cuhlgGNOaVEdn69X2SaD3FgOJSGXCAKdHwcu/5b7PmPRgpjNMmyN0mMGE96+RGbDN4wetxWJIYkIKzDiTHBn6mum6J03CxhwL72PAZxp0MlnHiy9wzifdz4RPZQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 PH0PR01MB6117.prod.exchangelabs.com (2603:10b6:510:9::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Tue, 15 Aug 2023 06:36:00 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::ed8c:18b8:dac:2331]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::ed8c:18b8:dac:2331%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 06:36:00 +0000
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
Subject: [PATCH v6 0/4] perf: arm_cspmu: ampere: Add support for Ampere SoC PMUs
Date:   Mon, 14 Aug 2023 23:35:22 -0700
Message-ID: <20230815063526.9022-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:610:11a::19) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|PH0PR01MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: f2dd8264-f522-4605-9283-08db9d59e38b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Daowk2sP1YkwWegMHivvSAkinjRq4+SOsnGaE2L+mvtRHjHvG0U6Dd0luuAkEfb9lif7piKSFVG0nIwvHU80/izO4gQ/dnBAw33c282+EucZxghZ3xTf1JspVNgjMBuoeYyNcsUnoCWNKTgrbzT1NHt/LySG4GHJBI4B/hwvXkXVfWM35LSgy9Jl25TVHTDdEOzB7UlWS/e3M5/qwSELnaRLUo4jF7nrGI4vsvIsIp0mDs5EgR7b1StqSuVxh3UO4Y5cY5vGBoB93CLSjGhNfIG5AEixHGjRZVdU0cngviL6R/SF4iT3/FI63Ea5pRYm9piV11P5ZQ2KAL71Jcufic60dRVM3yXqHO42KJPopNgKn3YSYFn9Pr9wHaRKrcVYungBKxYZqX9oLZEFa0WPNaekfPHLpJi2bHAgnsqg1l0P8Dr9adB1apQx3i60Up/DI/viyVh94uAZeLxdNLnw2C1rNd6624dUgpkoOgjE/h/bxpQTPRCbVHcE4gSQnDEk1oJWXsZ7tfSSDwoJuNOsN0vGjZ4CkHr7kN50b1vNEGsgR75nSGcnb6NExVnPZlPQrj8FWSgOdh2qlgvGd9zkzwKvuhLLlYTkopHNykCSaEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(346002)(396003)(39850400004)(451199021)(186006)(1800799006)(110136005)(86362001)(478600001)(966005)(52116002)(6486002)(6512007)(6666004)(41300700001)(5660300002)(4326008)(66556008)(38350700002)(316002)(38100700002)(66946007)(66476007)(2906002)(8676002)(8936002)(7416002)(1076003)(26005)(6506007)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m7l93JwXNqWios5RxUhVz5DVWn+y5XE0rr55F7PzeUtPlj2lkh1llayFJFQ/?=
 =?us-ascii?Q?afmYOUuMNfOpy4IKvQHexQx7bCfUwkQ2iyoDCudHkGawDprOSsrtNwqzo8/R?=
 =?us-ascii?Q?C/5CKcHG96hHACVQoOic0Yvhz84RifpvRZprhzUYLVOBa715CZFkSByx47IW?=
 =?us-ascii?Q?JJAp8TGl5b9YhyNK7C7HRx0CjTNdDWpMAVrbu6H4lJxV/2xiPI7neLDTqmdS?=
 =?us-ascii?Q?SfTc1dZn59uy2DyhakbKv016Hrrx2RQ0PmorLxCuV0E4uiIKgQO7VXeBrTzn?=
 =?us-ascii?Q?iHV8ych2veROHy/WpbInsrcPtLiyCO2jKhUn6Fu7kFs5swGNTFXly/P4xMAj?=
 =?us-ascii?Q?gUKZKMMD40OzcW93cOrQQuKn58RBcc7YcAi4IapsbZqtZ1q1Plf0J5VS3TWV?=
 =?us-ascii?Q?bLJC19WueGw02R3jnK7EoIsGTIWxwLBy00GNE/qXqH1Wx5n7LiV31/HBleUg?=
 =?us-ascii?Q?IYarPjcAyCTxfPUtTG0MdQMR7WuaA1ifAdVexqQzgOkgNySn23LgANmvhZE/?=
 =?us-ascii?Q?hR9sSFT1FWeag8E91tVRak1JWNXYKIHiXs0jsoE7IVngb+YJYUkDL0+cW8ui?=
 =?us-ascii?Q?GBWQS2OmEtSBf1LGFUvBCdSt9A4P3kDuDylPuADPwPVqOW1WR+pAuagbC5Ui?=
 =?us-ascii?Q?V7Z+p0p+knm6cYmI0p1Rf7PU0nL+Ec1VuTix8HzLjMemnWeNYwG34/+UOU75?=
 =?us-ascii?Q?w6rfCEa4VReJ0Ed+Wft9rY7dnYiZOEi1qot6FqCsSu1Je07ASpGuAukacHkD?=
 =?us-ascii?Q?Hmn6g8i+WlxGIArezDckGP2DItWOehCMHwbZIYvwFBKJ93gTP+KlaNr9m8Kg?=
 =?us-ascii?Q?tETAyfV2peT+hkItHctS8nNi3vW7vzq0hX1bjaTIk0qQcv4RR19CbG4lfw+7?=
 =?us-ascii?Q?sImEm1u3MlgQfaemYJ1trd+QuHBTwyxjakxksMfrQ7q9c4FgHnMwJV59r5h1?=
 =?us-ascii?Q?5M+SzX6uyoMnke6tlVyjhYg2j8uxXmcMlpJMombmOeXXJOqf8j6i7mn/swzu?=
 =?us-ascii?Q?idJv7FbSJ8NYTpNqI2CWu82HdPV1jlEkvtEaHQnF0Cqga966uoFA9HyVL0MZ?=
 =?us-ascii?Q?c3g+kXzjYt55k2F3OJngDY7Kg+jccvwuPEkOVRuXc9T4ozL+J36xrZJAHOlN?=
 =?us-ascii?Q?YeFx5mk07F47NVKGnUxn8vBasMNBdCrjyAl/dlZALbt1YYNV9AnIZ8nFycmm?=
 =?us-ascii?Q?obRlM8BBNZEoxyhOUdJ9qo2MWCs2MikS/oc2qDZhdGXtDJ7Bf006Q+3kKhgP?=
 =?us-ascii?Q?BdzE1HLdHbGefFKB8/7O3KqzPFdGjYSllgF9gX4s57CLbqSlrIOCvushobEp?=
 =?us-ascii?Q?MstXyUoPDtLxurBHGFvOiHYWW7ivpf5fV/dYG6Tk8hCqaXJBOHJ6k0HvXaio?=
 =?us-ascii?Q?Pp4ovgAcMARtzQa5y1n+elomswvELI2aqr5VbhgZGEKuFBLy6vXmt0ORDW8f?=
 =?us-ascii?Q?9IE017FRsYhrM9DUW/4WtKpRmqk7eXj/HrCCay4f6Bd9hI8YQEibLba3F483?=
 =?us-ascii?Q?BwM9CgSA3dC/RDNIehSjq6zgyK05vaz/Fpfs+TJhCdFo0DgyIGy6YmMogsxC?=
 =?us-ascii?Q?WIYhkA9s3/k0m5B/eRVswJ1VAqrjx9D/Ugy+g+YjFDGMZsidCjKNimj+nvjw?=
 =?us-ascii?Q?7BLqLUBCoNki1IGs9mNNqCs=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2dd8264-f522-4605-9283-08db9d59e38b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:35:59.9850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLWHJvTjnm2vhiKibK8bkFV+gQd3AQdp3gizvzGg52LKufNWcJoGlGDATK7E9lBSyNl/WUROIBBYPiEjChazMP/j265vfsl42amsEb0YqQHtVzZhCwthK0kkJS5lutuL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6117
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.41.0

