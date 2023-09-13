Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D67379F5A0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 01:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjIMXlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 19:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjIMXlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 19:41:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2133.outbound.protection.outlook.com [40.107.223.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DFF1738;
        Wed, 13 Sep 2023 16:41:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coumVvkFB/SEa6SQ6GG5PxC0ToURn8wKYZuExQF0vq3P+PfpSMMarM2hsS5PRAqc43oNe5TbX1Iu5b4HWhxVskaTJ6mYlVzs1oHGsS6fAzzTswyGpow4CV0zpF6exT4KuQOpfqt3GWfgPSCq7JW0DuCiJo5cDAonZMJIVY0vNiUgqKp20Pj2M7MpMIvcwGT3yVOcaHslaPcpov12Dp7qY3HtKbASVXjgPNCzDm23sjlZfLeiIImm2QPPYPSCS2+1JWrW0iykPTyueswLuRiq+RvYpzlH80HAjn0HUSCMWIni1a2G/Bk49LulqAJkILua9Jv1WBt4ACwgh3qt1mNluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3/J/RcVZVEcbTEF3idazog43gf9tPcFmeS+D1eu1VA=;
 b=I9UT0CrefpUePnFteNGZggDFH17AeTXFEQkcbsSNozdievC/1eOfHhXwokQWb8is/mx6ng9PlOz0DxdB0JAqzYs5x4r+yf+JvNkfTHKQCfl8xHyJbonp1rHHVKFgTFTKE45SBOTDtx2PjWqm0Fayrzg2fz02lWs4K3depXULyONtrFMVEhWQWTshJl47brLmz3C2ec4JjnC/gX+WIbMSpPv1ubkPhs11cO56zpKQtBVPolOa8NVvWvxp79LgJtSRqOJOZW/kdGZrC2mDkmklgowEQ3nxxGHe71+x3kC94Sy3V9mmEhFyhUJUHY5o8sF9X54PMAVS3Ix1qKyM8wMGmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3/J/RcVZVEcbTEF3idazog43gf9tPcFmeS+D1eu1VA=;
 b=CYU+VKlnNMGxUtqeNJMvqdVbp18EYJcrwoAzaECW/sfsDZEBvUdhCDP+pszbThKKwxaDn4dPbjEV8sTwB1gaMSPWoCbAPD1yD0tWPTA2WmTICXTrvBOPvMQwxDeu/kNw5jdXcP9keOVRlLDZsmgVej0JMdukMdSiHykuRABpT4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 MW4PR01MB6241.prod.exchangelabs.com (2603:10b6:303:64::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19; Wed, 13 Sep 2023 23:41:08 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::bfa4:8250:f526:5015]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::bfa4:8250:f526:5015%6]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 23:41:08 +0000
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
Subject: [PATCH v7 3/4] perf: arm_cspmu: Support implementation specific validation
Date:   Wed, 13 Sep 2023 16:39:40 -0700
Message-Id: <20230913233941.9814-4-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913233941.9814-1-ilkka@os.amperecomputing.com>
References: <20230913233941.9814-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR18CA0040.namprd18.prod.outlook.com
 (2603:10b6:610:55::20) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|MW4PR01MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: cd72b84a-bd02-4238-6049-08dbb4b2e783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UHen+zY4EH0FmrHTZJgzdv4kZ7Qtyj8sBbrpCcpTw9XWFwVccfQZ8mjE5OIrLwYpWAjbngjqO55xvFqN6QxLWku0xv/S/JI4ABpAz00XZeHOmTXNHAXKrL+3ADhcYhDibU8z3zsYjtFerjAwjGz0s9yJaXPco4YJvJGW7ZRyNuVMGvgl8uKumH7YZW4WS/TjAw1CBQHIDzIOcCXemx9UvMRZGrpU3u3evwBFMPfUB0tbQXKRKjQULeyedh6Fb1oy6grOjcf3IRrlAIbMpiXilDFKpRqbJmaMlSQ+7wKNyj1pkua4Og2nbC8mnj2z/kKg+mRU8tnXfKDt4xdDMrLy9dwt/46jVtYuarhmb0gE5yiudUWU/Yb/bV2Cyz3t/QbwHArK0NCdnVhzjCLYSLAqn4YkyIYlMNdVyFb52QfiVSu43h7ksD+uRrsyaA7bS+DfioF65Kw8wFCr5GVsP5sKkAkMJrNuOb/eBlrUGqjdmt2xDD6kexxi0K5UouXiSX7tNHtsWVj+uTPamzo1aY3NvLTONGhUgTivyVTHD92YuP1HpF2I1D8FNxSRwmfLACcIJ8MLKli0+NAUCPDDOaFUnQxb3R4g+rgM2K9D9EmyJrufuYgE7s6CVjm/nWGq6YzN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39850400004)(136003)(376002)(1800799009)(451199024)(186009)(7049001)(52116002)(6486002)(6512007)(6506007)(6666004)(478600001)(38100700002)(38350700002)(2906002)(2616005)(1076003)(7416002)(316002)(83380400001)(26005)(86362001)(66946007)(66476007)(66556008)(110136005)(41300700001)(8936002)(4326008)(5660300002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FwZL8D/88+d2pU64tOe06sTXGNt/nDackjroEwhlf6P21Nh0Hb6RO5M61HpS?=
 =?us-ascii?Q?4i9TmxH/3jkd0el6pgG70lsg0kE1O+FC7mVqakIux0iXU+kDVeVaowoNnjRx?=
 =?us-ascii?Q?mvMebrpWQpFctGIOQFpRMX7nCISlPYyBnlGJrmJ04u7BdTOHts7s9/9xQyUH?=
 =?us-ascii?Q?l2/NRgoLTwILoLm2R331QbC01oOCkB8zTgZSGtKJLU5h96Ky4C3NDIuX6Q07?=
 =?us-ascii?Q?xPGAAaZlgqMt6tyIBkeGrHbDzvuXJw1cwe8W4RpRioJSNtUNVQqYD0UkQF/X?=
 =?us-ascii?Q?KftB4KvFNO3TV6YIcICldxheCzLQ5YjhP7Gzs0Iia1eYv+3Hn0S5/j2Puh9+?=
 =?us-ascii?Q?4cBlabosqL/NCgVjFNRC5N7hl2uxZJsAvxU78Rg9RXEkURhIxpZkiATEC6Cd?=
 =?us-ascii?Q?TMxWUPmuuWyw0fx8B3cviWYqHZo60dQIK3Lss+1AH75oeK+NXuQvE5MkS1ez?=
 =?us-ascii?Q?RsRr6UPsZioqZe6i9HA8KOaXTIR7P/1joUwH3hhGhJGMH+9LZ58li9kFTNNu?=
 =?us-ascii?Q?E289YRrV2RVIwP/f/aXbtRn7YulFfE94lsTlenWQETPeE+IJtpyAvSWwdUGE?=
 =?us-ascii?Q?GJfZBVto0rZSSHSdBbWxEP3Ble7OT8yhGTSUix16eXG7gnO++dXZ9RUNhNPZ?=
 =?us-ascii?Q?G4woR4LTsG6hJX36rRiB/2Rc42qV6IbKeB+SfzHTur2LMRx2+A6la5EXcEYQ?=
 =?us-ascii?Q?JSlSancmxFLHdj1lX7MlZDkE9P04G3L8/+6sUkBXizkx7XxscHSEEucLmwXg?=
 =?us-ascii?Q?yoeLi+a7pFRoZK60lzSSXgyBToqc5ux/0AL76z1m8PVRQ+reZ4O4bI1IeFHP?=
 =?us-ascii?Q?Vzww7uZ62dTwdOqWtsZpqAaGe4HhSaOFI8GNJYqCKq0ELDAfRhJsba3F6Hu1?=
 =?us-ascii?Q?q8cKvQpJzrMCfp+HmyJim/B6LqH0t26NG/cvk8uJmHTNKcHP9HKOEgt4is2I?=
 =?us-ascii?Q?pLHSfY/deWJKf0UhZYeBoW0uDvC5s8r0xdsMGZAkkQapyf9wwSnDj4ypjzT6?=
 =?us-ascii?Q?Pn7EBdL9Z8CK8Cgmj8A0AdPc6BIKpdBGEiS6Zxv8MEkoDZtJNrlPJL+folQ1?=
 =?us-ascii?Q?XKfVazgxObrJh0F/4/NjiLB/H5E4diDq/CXTGa0zfaWijeSuwKSmVpsImrUf?=
 =?us-ascii?Q?ekksJAIZIwRO6C4jH+SXaRwiHnk0487vH2YzCT9eo65u5D89aVcvZEi7mBAD?=
 =?us-ascii?Q?EY7Z5rRa7kGZZ75dODVtlyK18/HzGyGgYFrheCJxITX2Uwt5QcReVnOgwJsJ?=
 =?us-ascii?Q?paUlnagAVGfw+n/2VF/9+zyJwUyI8ocZO68b8za2gzXAWs/HQiSJa8Ay62bD?=
 =?us-ascii?Q?2ZvcA6N8j51TgNKLwAy4IeWZfI2z4zS/oq6vtSr8q0VZnQhYvzGlKdKiV6S3?=
 =?us-ascii?Q?EjXlsv8vywAFL+WZ7ogGf4omYY6r2pligzuUc8kr9/GbO+0PTLj3RsTpuyUp?=
 =?us-ascii?Q?HcHjVO6OELLITOJl3rXxKGRCfnQ4cwtmgQgZu0TuszHxnABY33VPIGolIs3F?=
 =?us-ascii?Q?S9dAiDKzGNMgG77otIiPOQuY+R9JNANqQXpmhD8zwgFTRlx5iXJ9ZkWBa/86?=
 =?us-ascii?Q?/aNC+wgrx8WQ+pMfmzoZ6EwlSSd0jIpexXJ1aqNVYh2/2BihtnjVIffRP8OC?=
 =?us-ascii?Q?enYpJNZTmuqkWRcRp9ftywU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd72b84a-bd02-4238-6049-08dbb4b2e783
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 23:41:08.5293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QaCvjXbD3Cl//tBOkPA1h0voDF42/F3nHO4+IXn2xKW8sEb6VE826keAKmB29YBfcuru50We4ugxIgRWNFGpJ2HeS/7cTWAoexzF8FaM+yDi31HeOwkTSMj/oufazCin
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6241
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms may use e.g. different filtering mechanism and, thus,
may need different way to validate the events and group.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 8 +++++++-
 drivers/perf/arm_cspmu/arm_cspmu.h | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 2ecbf8d7714b..1ba00d640352 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -576,7 +576,7 @@ static void arm_cspmu_disable(struct pmu *pmu)
 static int arm_cspmu_get_event_idx(struct arm_cspmu_hw_events *hw_events,
 				struct perf_event *event)
 {
-	int idx;
+	int idx, ret;
 	struct arm_cspmu *cspmu = to_arm_cspmu(event->pmu);
 
 	if (supports_cycle_counter(cspmu)) {
@@ -610,6 +610,12 @@ static int arm_cspmu_get_event_idx(struct arm_cspmu_hw_events *hw_events,
 	if (idx >= cspmu->num_logical_ctrs)
 		return -EAGAIN;
 
+	if (cspmu->impl.ops.validate_event) {
+		ret = cspmu->impl.ops.validate_event(cspmu, event);
+		if (ret)
+			return ret;
+	}
+
 	set_bit(idx, hw_events->used_ctrs);
 
 	return idx;
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index e0cca5b4aab9..a30c8372214c 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -107,6 +107,9 @@ struct arm_cspmu_impl_ops {
 	/* Set event filter */
 	void (*set_ev_filter)(struct arm_cspmu *cspmu,
 			      struct hw_perf_event *hwc, u32 filter);
+	/* Implementation specific event validation */
+	int (*validate_event)(struct arm_cspmu *cspmu,
+			      struct perf_event *event);
 	/* Hide/show unsupported events */
 	umode_t (*event_attr_is_visible)(struct kobject *kobj,
 					 struct attribute *attr, int unused);
-- 
2.40.1

