Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E61752E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbjGNBCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbjGNBCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:02:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72802D69;
        Thu, 13 Jul 2023 18:02:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmEY7TvI9bnz0cTMlwVyy2i9GRMvm/h7xNthtzeSHl9sFtCoaUgZukrLv0mx3DTtMuYpU/QqsciWG4iEs+cCPAgRfbo5Y3IqKwfGWlf65bNon+8W2h6dFOc3THu7sA3Mb+8IKHHfUQY5BaevdvqX37+Rf+pfOSi+cbIk5UxG2JwJprTLYcREDL6uIDUWJfhN1fiF4dnbLG5Mgu7FqFCvhngXeZiyFTjaALO7SIDHZPfP6EYzsPSOLrWQeOo400ygpNUtmoU4iiR7zYy0J6BFVVFYuuolEVKd5W/llH69Unvan0VQ7wh7UcljTmpRpLY52Cn1zS+ecpomBkt6wyyPUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9tazuVe05QCK17nT3MvqQqUmm72WRzCSQgnqL1GZGM=;
 b=QZURTLfi6MOeCPNrtrAlEeFdhQn+UgZC3d9/zWKOu38Vm9w+oJziN/Zz+F9bzcDuOQ9cqWXZvP6cll0yBga7gSwsZjGBUo6Vo/fXtCsmnhq6NOrsJSPdTkvVbYkz+S7UYJw6vmYIIOFb9lQYlq9KZcaEDAb/gcijNmK37qx40xdWBeBeJDCuUR3Nxk+0JFRkYt8GJv4ZOkEcEj+OCc1Ipe8Au6Quw5QLE6XsHRsxd7r1S+ybBxkFwpNVoecaXAiURZ3BAhoPzLgZT2hPWF6GTMjpDk1WIf1V6u2/dMgpzQGxi7c3jBeSZY6B7ikNgAKhSeWEQW/+eTxUgFVf0vMg5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9tazuVe05QCK17nT3MvqQqUmm72WRzCSQgnqL1GZGM=;
 b=afUr4LR8ytU7YvSkWMALrkgsykVssMNCu60GY3wme04hMlOoIFvXuZetjaaMDrTsLTr5zA+tBlFSfsnkR8I0g+nHcjMKeWuiZ+WOWEfRGQBgDZ7TvRB2xaZPMSHlGYTku+Ot1ITGl5GrxwI+XBCXlCW2OW6s4v0LdfRq1Gn38cU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BY3PR01MB6611.prod.exchangelabs.com (2603:10b6:a03:36a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.27; Fri, 14 Jul 2023 01:02:31 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::235a:622:9239:3963]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::235a:622:9239:3963%7]) with mapi id 15.20.6588.017; Fri, 14 Jul 2023
 01:02:31 +0000
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
Subject: [PATCH v5 3/4] perf: arm_cspmu: Support implementation specific validation
Date:   Thu, 13 Jul 2023 18:01:40 -0700
Message-Id: <20230714010141.824226-4-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230714010141.824226-1-ilkka@os.amperecomputing.com>
References: <20230714010141.824226-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::30) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|BY3PR01MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: dccc69be-d871-44f6-b83f-08db8406002d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kx4b5ouMq/YFSKJVYW96DTkOe9jF6CldRekkQKm52kNqaO++H9O2fRzB6urOBOGnt0KrE+L7vag3PcWwIVm3trG7makW8z0lydx6kB+eHTJssEypr83C+dRdPyImmVVl0ZGBjzNGYI120X5d4t1RBP6vka2T728BODh8XvjijQZ8xNkn3xtBEWTNUaRyg5WLkevBmf57nAtv5+BAzBjapbjho/uy0ssNeQkFJLKcXy+1PQBvwZAxSQ2lUMNl3V+1CYnawn0FDmHe0UPdBWwi0Cz/qdEXLXi1NA1hWkglSfGiJzgiF5qgSLfSCXzsaFptlcb/6DX2LBAgOQCJVpqwcLoKMg4DqU8EnTWwnbQRfoyBGzlpi6qNUX37iC2Jgt75Hb3BcpNLj9ZHBFSD00ZeycpmpRSAa1Coq5yYvTEwTufqrYXhwl1pM+Pn/9EIx2QAE5YRwTAHERO7AY3ttwyxrFu+YXYgY504IbpymbAbDJgFmP1TtHDAKj+ajs70SnX3Io3Ev1Ac1dV5Jo3SX2igYImce11/2FYE+SaiWwJcxqgskdf5Fw2iCGDXFc4Jiv19b+4SgmxESjH2JTb3m5AqKrLO+eTWjVsqC7sJymfu/3Za3048ijLLssiQl45rNLMO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39850400004)(376002)(451199021)(2906002)(38100700002)(38350700002)(6512007)(83380400001)(186003)(2616005)(26005)(1076003)(86362001)(6506007)(5660300002)(8676002)(8936002)(7416002)(110136005)(478600001)(6486002)(52116002)(6666004)(41300700001)(66946007)(66556008)(66476007)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0c7sVpTBWFN2ChyTz119wBvWNXTXcmHh8Gw2ZD8NNrUH7E8USNnzjOAu99Gy?=
 =?us-ascii?Q?MfGESYnIFIxERTe9C+M8CZoA5/i5fPqSH0arszcb4w7BWcjy2+xaGvkZP5vw?=
 =?us-ascii?Q?ELziwTV9jHsCSDe44PRXAyac/GDjEqAL5fzMiG1tBKRTNhdCbBVgxvLlFZbK?=
 =?us-ascii?Q?4+bDlOSZCacyQ9/krUjDXMY950epQPqJD9ACkagAd2jsiijK023FV2ej18vx?=
 =?us-ascii?Q?zqSdADDHUgzOY24iRtROIE0oCqe7LKYivCx3BdB1Rcrx7T0kop6KsapquVNk?=
 =?us-ascii?Q?2VJb+KyxsJzkhr8foW6ZvjHOYzI1gOQGWe3uc0JsUggLl/9nuMjsmUANgvSp?=
 =?us-ascii?Q?jaKtIk4Vgg19utKjjNehUiwtaQwgzqkdSHHUl7tkMHy61NCgvyvH4b4Kgvpk?=
 =?us-ascii?Q?ehImvwklsZf4UnF7FnnX5o8Hg/7JmuzNegzrOlClHlVvdpZZ8R56B2uBfKNy?=
 =?us-ascii?Q?aPyulaj52CUZ3cmHJELtHPh8T/o35WTusqD49y9/Y9as6NULvy8BhTpSgH+7?=
 =?us-ascii?Q?Uz78IxLbLBgGKcTqbxXZQGUxRnVeLtpSeqxeenb4oWma3HxVGLunl8TwBhrN?=
 =?us-ascii?Q?umaizXHmJBohbUNQ2f2dvd4xFtMqizfSC4P2KZoN8ZyrdI3kHGrdXM/neBJz?=
 =?us-ascii?Q?CgDvm7OSxJTMkj5+uIY0Mt1mht/KDQOTlj+QCFqukqgMr120avqsDwfxVDAy?=
 =?us-ascii?Q?42zQB5inxqtzSTt/xUWpW4qEcaWl5JY/rF8CgxxyHEFO69bk2eJmhcl1zPvk?=
 =?us-ascii?Q?TQnseE6OEFlQw4e7Z9U0AZGOZAeSUyMJHcJmmSRsCsdcfIfzGpVx9u5ugOvG?=
 =?us-ascii?Q?HgyurAoU+7MwXYZv5nmWSWeAcTArjAhwYxgmI5dPNz3HctuaA1+4OeqZeH/T?=
 =?us-ascii?Q?cLMNTlXdc+M7IbUuD2rzL78WoR4HNc8F49G58wrzqZ+NpoeTtj42nAAEzWFM?=
 =?us-ascii?Q?fvmdHN0xILz+WZshcXx+ZCPdhncc6db8fn9GkXWgiIBq9z0fQdUMMTbobNvE?=
 =?us-ascii?Q?uRkBTfwD/YpDD1Vb/dN/gq+DiXlgyHbShuj379daB3//FQZy2wQ/zC9vTX/x?=
 =?us-ascii?Q?rd1sYQNjdRKB6gvCwSw/msGOHWcD4q4ZIKTLtxt0lwmst5076fJumoGoFSOT?=
 =?us-ascii?Q?/nbM4pP36h6RtxRdj0JzjDUksct7JdfWY6AVoJj/zpnDx5JTdKE+3zaqv6S0?=
 =?us-ascii?Q?OUEuHhNQEapkEfLc6LZa5HBS0/yAxRNniaPhDXv58J8llYL1Aj9Sh7eOTIup?=
 =?us-ascii?Q?QAX+HZhGHqhQprE+oIljFCHzVH6/6E9461WmSZGs+NhLIGSJtLOQYYPMAIpa?=
 =?us-ascii?Q?6nOGKOzA48A/mv750RQL7TofpylPu2qMrAFDihgvetzNBrjIHOPlBJf8C6wq?=
 =?us-ascii?Q?efnio1niSmR+SLgIXcquBv/H9AfByEhslsxTvDggunW/KJsQOH4F2y+7KYJC?=
 =?us-ascii?Q?txmjTOZsBa8PHNX44AfSAB3MEZlDIjiIkEORO+VrcGKq/4n5jfPeQItGWMeM?=
 =?us-ascii?Q?08YU3+YAv72BuCJu6Sb7E6U9IVSRFod5XG12p2vTDLabWn9+9AD82ZxuDEyZ?=
 =?us-ascii?Q?IMOsmrRqjc+dNRDaysUr0xU7+ofFdnE9inBc08hdVN/StZuPqW7UjL0XvDip?=
 =?us-ascii?Q?kHr63EWi5Fe2j634bNpAhVw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dccc69be-d871-44f6-b83f-08db8406002d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 01:02:31.2553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFNDnIvJ1DniGw68Z/UZMvSgbAKGw6z7nUAgguYeH8XR2Mq4SjFR6Xccx9dD/LD3tRWUMUB/MryvID/Ov3RDG0dpMMh7Gw3rkqAM41z4R1Sj5wbFDX/7dn4OImT5rT5Z
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

Some platforms may use e.g. different filtering mechanism and, thus,
may need different way to validate the events and group.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 8 +++++++-
 drivers/perf/arm_cspmu/arm_cspmu.h | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index fafd734c3218..471d6d7ac81a 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -553,7 +553,7 @@ static void arm_cspmu_disable(struct pmu *pmu)
 static int arm_cspmu_get_event_idx(struct arm_cspmu_hw_events *hw_events,
 				struct perf_event *event)
 {
-	int idx;
+	int idx, ret;
 	struct arm_cspmu *cspmu = to_arm_cspmu(event->pmu);
 
 	if (supports_cycle_counter(cspmu)) {
@@ -587,6 +587,12 @@ static int arm_cspmu_get_event_idx(struct arm_cspmu_hw_events *hw_events,
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
index d6d88c246a23..5070d34c2285 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -104,6 +104,9 @@ struct arm_cspmu_impl_ops {
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

