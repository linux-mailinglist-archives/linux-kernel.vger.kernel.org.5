Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B097C673F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378045AbjJLHm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378064AbjJLHly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:41:54 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2101.outbound.protection.outlook.com [40.107.243.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA6E10F;
        Thu, 12 Oct 2023 00:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EU4AkHv0xF78+SBAw9sp6K2otb/qzBclZ8hOwSfbVx4ygek6Rusu8ksGHBZ+DSC+Z4+Xcbtwbic61GI2c/ISQmV6TRRW+UXLgRW/MPgJre3a6zHGXKdJvDX4/okKRb59rXVH0g7eJxf1W9k2Fu8v56a341tl3UDo8sLUIbuWF/RV2QoKu7pClcIvKaZTn8N3KA3VzGtEhuppipvRf2eXYUuu0rC00s+iJcUh2gfduC7Fmz3n6AHIuvn8r2e3ZraFLAWLk6nP8ys+cOvILtzm07po3IJAgKM9Y+0XeFuSkuL/w3ULeQ3wVQxQDBpbQde2gzeQnuTkJVNmiNUahEJcBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eLj5/a/ih5iHyekZDrq1kwDJf5pl0lIKMYQ2wK7MVE=;
 b=EkZ5ZoEsDwMKb1awO+UFhzCZMt7ecEWPOnb8KAvfHypqX2ie0GsWqeDBvyIQsC7gyirzBFirwhLK3Tu1544Tm8MfZds91yefSp/Q7PLTVpU9AwxzErQ76TgMK84KvV69X4FwPm1eoYEuwDrgO4ZMLZSH+QxtTe6QDbc8SHKUPb7jP2FJCQX91i5+KYKaVHk06fYUeAA8MQ4V+s64s8y1IuICLMep53GsXIsck56nm3dFOlJ7AUyQ3Irq/BSM2sxwKJTtf9LCjUNlexDcjfYZT0O8uSyl2CstyKXTFUcpZuxyLipi6oJHawlXQSJpg+mnS5CC8HGABN3of8FRjJn3nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eLj5/a/ih5iHyekZDrq1kwDJf5pl0lIKMYQ2wK7MVE=;
 b=BVBvTxnwBs4hP0d46siK9neCPxjG1VcrBH9VogL+ERf3bRtEUcl1VQdFV8MAZEPj4PmOFX8fWzWREa0MmyFmbUgPXhIyFx1XHlV3PPfNfYwWoQtYHwsRnxoFOH4VMCl89ANBg1yrb2klbw3UiWqP/fGiGeVjjbafrRDAyqnLybs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM8PR01MB6902.prod.exchangelabs.com (2603:10b6:8:13::10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.44; Thu, 12 Oct 2023 07:41:28 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f%4]) with mapi id 15.20.6863.040; Thu, 12 Oct 2023
 07:41:28 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs/perf: Add ampere_cspmu to toctree to fix a build warning
Date:   Thu, 12 Oct 2023 00:41:03 -0700
Message-Id: <20231012074103.3772114-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::9) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|DM8PR01MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: 866580cb-303b-427b-28f8-08dbcaf6a491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1wCK+uauVNmXki9QJg7rAujHVZzRHCIQdcTM8lMO7pV19tmnayKzTooz9TkjEXEdDXaQvDhWjh0krkat6tjEnJX9RW1PCrL+F0UeXnEUoVs7ySNfe8e18GXmpMyByTZjoqOHJ4FpHBSRq7rf9FoBX7rWtOmcdWICrEtYF6yoWf5Cw0gg2yDmFIr2MvISWLAUp6kmjHImCNgHThDMcA/qGU1ifFArkcw3IXLbe5IJcYtuj70L409fvpoFLKRSAnOSXMV0cFwvHj+tjkJpDFXgLT8N3v/jnGk7rYSR8SXT95QME198zId21QzMU3PE02IvvTN7/ZX+2ePtJtI3WdjIypJuodkE2dKUsF8KhaPD47ywY7/ceYgC9ZU2NUmY4zlTT4T9qwX77iWvHatkU0a95nd1CAUnXPJYnufw2ItON3pvy4uEdvpFZErP83G+civrynDYg3DvhL/O88Y/oV+yQ6oiF0lGmIAv7Mr2woDh9oPY69Y499jmgMZCpTiwP53rum3elwrFndKwzlhn6B03Bfz+xyCViHUob6YPBHnHWC7A892Y63OezzU06WriApKS0Oo2oBX482IhGCvE6ETfM6QaKbkMJe84phKfK99sY58OfxHQwY3o/xUKRNS9GBXE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(39850400004)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(110136005)(66556008)(66476007)(66946007)(316002)(8936002)(4326008)(41300700001)(8676002)(38350700002)(5660300002)(38100700002)(921005)(7416002)(6512007)(2906002)(6486002)(966005)(2616005)(26005)(7049001)(478600001)(6666004)(52116002)(83380400001)(86362001)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ij2PZelrZ3yzpQ6XJNXL/dm8wT1+RX/QFjUwkChLByIlvqgssKJ+sLhntssx?=
 =?us-ascii?Q?dXDzwoV6ruHtLj5EIC8gsrxlPfsoJxOapzQderDlqPlK+t5P5RH+lmTDzckN?=
 =?us-ascii?Q?pSduC9IP+kwStFhmklR3LZIunxPVuFNq1UyPv0TvA8VBCWiWChrXWnyaEUDf?=
 =?us-ascii?Q?XVBfT5g4IG36WV8jcgWu/m1uyMoO+nSngLcC+MOmNAiI0RLuucxybfexHs1D?=
 =?us-ascii?Q?rkpoZXaekxlSN4cdgnyM1ZrHUPrKbBxKDJnmyyXGb2IAjpVBVjN2whJu8Tta?=
 =?us-ascii?Q?s1ZmZO+D3KfFKQdXAbJ223/C8lBa4Cvo/bbnBJ45CnTWpPT3F//KyrqRq0wI?=
 =?us-ascii?Q?84E9Yl7SkuEOoKioygVlan0ysTzt76pA9PGlMheY6hqAzUq3Xfwl2OkHx/TG?=
 =?us-ascii?Q?o7KtBpSbnvUcmj+nrPEkwT/cUhciD8MUa+TfHYdFK8Wmin4rL5S+ABYdSrsu?=
 =?us-ascii?Q?9dLMUdzYLPWjWFc7QpG+BpwuT0A09ZBbI54uokj+zg+WYh7kdIqDUxshraR0?=
 =?us-ascii?Q?yWA4RgQwV9o2cWYLMm1xwaePchDr3xKjTaG2hWERN7A7hF9AeBjWbP8jMgjS?=
 =?us-ascii?Q?sv7tUjGNtrMXSIw9WhiG2yPNgGQafMUBkWXrBnEyoV7mDYn73e7Sy+qyUfpB?=
 =?us-ascii?Q?Vfj1awaBO7vchMwrKx2ROz8RbsQj3chmlNErvLsGPJR0kQi+M9fXBF1itJ4i?=
 =?us-ascii?Q?bm5+ubTiaY5oMSPUEXnCWdhO0ezKJGJv0eanS0Tx5R5ZkaumoFE3DoP1jKNc?=
 =?us-ascii?Q?D/sNLoLOIxDlZQNnwuhBuGvqM8AT08KIpZ6BXLnr0UyUhHArZzF0AqvR2eF0?=
 =?us-ascii?Q?OjHmKLcBskzat8cJwJCb9Kt32SK5rHe/4U4JbAjir2DVQv70Tq5VHxJyhqh2?=
 =?us-ascii?Q?0NcKJS2ETmpKEeLgsufimAxLlIIEdldVLy3bMpfFVC4b9J6hRwq9NpPHMuqs?=
 =?us-ascii?Q?EW8nOqH/pKUHv5d9FcFBPDLLojGlem8OIZcmpelS9mRl4HM/Vt7HRND1a/x0?=
 =?us-ascii?Q?cJXIV9H8lcEG63Sn35bRvYqr34tWMTO2oJcYPRnDsngvCmr3swDH0WX40nV4?=
 =?us-ascii?Q?RurBnMAisUDDBiE15ymgEEAn4xwzMtUCl6WZDnFopSZi/RXCzpMsr8Rt0XbR?=
 =?us-ascii?Q?KWF6uIaknvYJZWB6kEXmQAng+L9nhgfAF3k/McWhiXUnZPa5TxDRmewxTS3d?=
 =?us-ascii?Q?rrwRlOkmgpOn3LQZU7vQzMrH6yX0NpD/nbiyfMAKSBGU3gp73egEkTgKwZ9b?=
 =?us-ascii?Q?51rx4RJV4/5lmAfkiJqS5rDJsrbVdGZ0mI4Ty5RbIQ/n43EHERlWs5e7E+sT?=
 =?us-ascii?Q?CkyTo1P7mrKFa10jWSVF5/dRQZNvZIoeiB3nfZ24o+pZtcAA1FBaqbWOuQ9f?=
 =?us-ascii?Q?ZjAywetArKrST5eqOYrnsHw5y5fRGDF0mkeaiCxkwDE0sgUuSN/FcWZmWNjQ?=
 =?us-ascii?Q?wKCSuz6gHU9WejfYTIO/vyx7l6+HZTWRGLMtVdonEVpP8VD67LfJRJsYfPW7?=
 =?us-ascii?Q?SbMaTUGq5Pit3CbOy/uevTrO821hhEfbWB22+cNheYyl0f99RHoT6CVuDh1v?=
 =?us-ascii?Q?qPs0wUBayFousfzlavkv1NNoHII7Uxl0og87jA6ut6lX5KT8XJfsxOQaBKeN?=
 =?us-ascii?Q?ugBkq81PJc6OevDFsMzfgZ4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866580cb-303b-427b-28f8-08dbcaf6a491
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 07:41:27.8982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cex+qJGVQ3Xs7UkR5XcNnQI5rljWVNy98ZaoVUUvZChDTceehsR4+Th6A37YBhD7gWZXMe6oDcPujBiZkgVDuTKuY80Dv4bmHc133VVRcobJtoNgnFNImGg9sdR+nOD8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB6902
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ampere_cspmu to toctree in order to address the following warning
produced when building documents:

	Documentation/admin-guide/perf/ampere_cspmu.rst: WARNING: document isn't included in any toctree

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20231011172250.5a6498e5@canb.auug.org.au/
Fixes: 53a810ad3c5c ("perf: arm_cspmu: ampere_cspmu: Add support for Ampere SoC PMU")
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
This patch fixes a bug in my cspmu patch, which is in Will Deacon's tree
(https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-next/perf).

Tested with 'make SPHINXDIRS="admin-guide" htmldocs'


Documentation/admin-guide/perf/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index f60be04e4e33..a2e6f2c81146 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -22,3 +22,4 @@ Performance monitor support
    nvidia-pmu
    meson-ddr-pmu
    cxl
+   ampere_cspmu
-- 
2.40.1

