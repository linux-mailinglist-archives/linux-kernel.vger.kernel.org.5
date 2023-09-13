Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BCC79F59C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 01:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjIMXlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 19:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjIMXlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 19:41:06 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2109.outbound.protection.outlook.com [40.107.220.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E99EE41;
        Wed, 13 Sep 2023 16:41:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3y6RXxUNrkttE46Nuc8gqyYV9rEoCduPyOe1FJniHheP6iiLrhMag3tpnlbNfAAsTqnYiUVnhcsl4s+WmQVz3ORRkXarGEDXTXYztyT7LBaR1ML422A9WQ/FKPADST5ecvCQHS4mLqmJPJc/HXiOiVQeY8ovqlffSbpVe29YQC3/+Yy7t5pA6OpO/wFIeVbM6UwxiSMBbnUhYnZbMoQHbFq6ZVRW1U4BOGrtW+7oycCG5Sl3q/Nzm1e9FKitWk3kG68dQYGyY0jvZGFurH20/dScXis4eWQtDuApQnI7v6yvAI3Br/H3lUvtPbfM5fT2CPQJccxG0IkAt0AQFQfyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09JiRRwv/0acnwS02oV3bCOft3kocAIAHJSLyFi38zw=;
 b=H9Uz7fvJJuf7jxKc5H8okiDu0p/qh2yRLwKohrPr0COr6U2gXxLDmcV53poabXHKoSiRRYcOakrBIoiuCi3whJzrXsvI2yvEmfRnKR/DoCMonFK7rUmMzQMIGWw2t4uB+RM+1A6/9pMGynEj7nhgvc5fbzTvE1jCTmNJ1LzJv9qa1BhlvjvqhDImkmHTy+iKZeG9QfjcCGOnoETWw3yZKETWDxxtYBnrIf2723o3F/K7266p2ZtD0ClsWWpdJGPm0RGbiQhQJr7HcyngHHWG7266Hr296AuOS3I7B0o/FJSLfGtNUIUqMKSHrIas9Xz8Bxh1eZb39FgKDtcHpAQQlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09JiRRwv/0acnwS02oV3bCOft3kocAIAHJSLyFi38zw=;
 b=k2SGIIFPu0APJLsC2yDN7oaIhB5PQtgzmKSOMw+iva4aQmPhCEWicGOU6Nwi54SrI+QPB01pOsCIqb9drhbmdUDx442TdKMolDSIQgBvFky76K0pG344HNrA/OVtxmVmF02vXgJoMsofzFdG97IY5uAba0UL/nUPR9StCBqHsHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DS7PR01MB7591.prod.exchangelabs.com (2603:10b6:8:73::20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.37; Wed, 13 Sep 2023 23:40:59 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::bfa4:8250:f526:5015]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::bfa4:8250:f526:5015%6]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 23:40:59 +0000
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
Subject: [PATCH v7 1/4] perf: arm_cspmu: Split 64-bit write to 32-bit writes
Date:   Wed, 13 Sep 2023 16:39:38 -0700
Message-Id: <20230913233941.9814-2-ilkka@os.amperecomputing.com>
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
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|DS7PR01MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f90142-997a-403a-02ee-08dbb4b2e23e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CJG47hUNDHGX2XT6VaHkRVByogM42a6OP0lY2+93rwwqJNGiJg/J2qjiWW4R9D1UbjR62ZeuD+cveiV9u+iboqFtmiB84i3K7ELwtk3jSLBt1HuHZ2UzQ0ZpMr8LpniVY/kZzaxjp79HjOEX9O5PLA/KSDD4P6a2aQ3CgIKLrLkv+5J3fHuEUE+TwXjMmxOHKX4/5r96ihorzwcarXqQYUxo7ymRX7fLVP2I3KunJ8lzmhaaflKeRzU+2XqHWczYiBBqt9mViB+9HLMFMwayaFq1shDdZmXCX7pumGYlNbl3h9T2XhCboM7m0lwdxevASF06L25fThPJBYBmTQV7cVWOMfefrf2J+ifa1UYJv1gnB3I5TV0gLbS6Ug6k7WjOUYhPS2hTPAiHQTkgBe7qj61Ks8AUnA4C3v9T2jDl3Tx0iaJPQUEeVy9IBM0pOoNZvs2hn9W7hnqICfg8vTw6KrPH0Te2itXyJH/6POrRuUNPpNiMCC2gCMJrf/XRq2R3EhKn54RSyHHj0yvbTp4A9FNqIfjUfehr0FWvES1vlSUazI6WKlSLEWzXNj3e9CEEV5iojmtl6e1C3A23DurjdITgyXMtA15bcIRLUiSnfsTvDcjWIDGBtqS34ZVhrwMe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39850400004)(376002)(346002)(396003)(186009)(1800799009)(451199024)(6486002)(52116002)(6506007)(6512007)(7049001)(6666004)(83380400001)(38350700002)(86362001)(38100700002)(2616005)(1076003)(4744005)(26005)(66946007)(110136005)(66476007)(316002)(7416002)(66556008)(41300700001)(2906002)(5660300002)(8676002)(4326008)(8936002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2OGTHQ/XYc3oHW0hTii3j9yaJGH0NaG/5bw+9Oy9DCHs2fY8LDkCnYcPrCtN?=
 =?us-ascii?Q?aaXKbPARTofjKahvbEnmBLO4EPkCgjitN/vdLYPyURKD3q/mZc2Er2ksheOe?=
 =?us-ascii?Q?bUNkLNrpJz4RzH8OKwxh71eacwbGx6Kne+NHTg6swyHWRfqTQIaShDWZNF6l?=
 =?us-ascii?Q?AaHcKIBWzWslQKJIyUQqr+J44AZ6Ha+i+k0i5wrcPHYta09JD1MVAX541cUg?=
 =?us-ascii?Q?gpGUPAKuhhYCxj+qVGFIZGwIgjfqZbdJRjm15brtcPmBQ9C/GCqfER7zUeFk?=
 =?us-ascii?Q?NG//eeBo+0DNy7TNnFqThJ7QlexcGhCUSigUI22h2/rRd7aNB2vow+uS/eaA?=
 =?us-ascii?Q?tIvo8P5biGLD05TBr5TRRrliMdDj+uxoPBjo1UbdTm0iKY1QjVWztBkBiyga?=
 =?us-ascii?Q?wBuG8cgmWL9nPDBLtWp+YDCcatRGxGdkAo+Os9EeE12ilMvH3THUcS7ZJafT?=
 =?us-ascii?Q?NFVpbs3pMgIMCFjdcLN9Eoqd8NgqqwYsPUfumVZVlYmTz0Qynr1Gi1hMHDp/?=
 =?us-ascii?Q?KZRyRr+e59uJMVjTOUrWSzlmn4FRGexAvtD47ZwhsQkWbuxZOrXw0FqTztKo?=
 =?us-ascii?Q?ZwHJ3iZ1m8IVu3g1DnUd7TrB6K2r/qHzk7hgXx1lMx87YCxJqOd2KB7Qo2lS?=
 =?us-ascii?Q?mV96gmIbrRTDIz7NBOP5R15jT/EPXG8K2bFiIvB/qsOiRmzMSH+wwYc5Trxl?=
 =?us-ascii?Q?qeLrbQzKECkkr8MRszp+4vRsAg200ja8p6sKcFp+GIr4IFGNQsBXF437MwyF?=
 =?us-ascii?Q?NWUDZyGYPm2XJN//+5cJMCUAjLw8OWSjZL8lcnBpciw3WPGZFPuof2YdlPlv?=
 =?us-ascii?Q?l2RKA7DNE1ht82ZtKE9A+wrqfw07ROpI6lCVxihg5i7SW1RRXapV33vVm4MN?=
 =?us-ascii?Q?ZU+RIIoaXHXX6GfuPqb0YQV8FqstEu0fnIhhkfHlzOZrhcQ64Zq9MSqRRs+s?=
 =?us-ascii?Q?+aJai9yk/Vw2CyKkLiYCsFeCoaQkF5d53/MmR5QejYML8nDL0shbD08QLX9S?=
 =?us-ascii?Q?zSGsPGHwENYbU30qrl24gszVDj+xEsN2ae1xqBGyv+uq7sa9SHAkMQzGMRFC?=
 =?us-ascii?Q?ToPzOLVM+ktTxjD+EB3OOgsx+KAEmSsr/7tTcZjDBXUbGbF38UC2Xc+YIQyx?=
 =?us-ascii?Q?g21FmLPUqWcSFzFe5blGm7N4Ndbl1l2wZ+UG3wyDASfEUShQMRVnARwI3dXQ?=
 =?us-ascii?Q?qmob4GNouAPKJtS3phVc2d1R5fzWOs7oj8EasMKf3t5x845abG1a1rAHfDxv?=
 =?us-ascii?Q?ve7RfOShdd7GjG4tQ0KdPxUJwcVOPouAM+gBAMG6rP29capJxIkwLtpn+CBH?=
 =?us-ascii?Q?saJK2eU0P/VaaqHqeZHtCLfZ7O5HzSHd6sfv1ULZ//Vo47rFHl4eQHBFRrbD?=
 =?us-ascii?Q?fnIDQ5h/a7w68LMPFtrO6zdayon5y15kChuIyhi2yXtlWmzVXHQHa+OGqk6B?=
 =?us-ascii?Q?B0D//hsToNSGPjDyXdwmmnXewMxkmG76EHHMelra++VTelhE/t2ebItlD083?=
 =?us-ascii?Q?9hLmoYtgphlzG+HVAk/LuxHTnDJez0ZWYnQvZ+KrzE48WVDJiXwoX9w1uS81?=
 =?us-ascii?Q?pL2dWNbDIPRzL4ni9baAIHG8AR6nBpA9Hwbom89IhjoqbyPengxIAMWxp2O2?=
 =?us-ascii?Q?75RouV34+cz7bNdDGANwlEk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f90142-997a-403a-02ee-08dbb4b2e23e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 23:40:59.7130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKR9ml0z/BR8dDtIDcloj+9bQcG5fVc1SizkndnbNLVDD8MC+KFnaX9XCNuQe1UNnvUT2Bhgot7akF9yS8292JpOTFHKn8WpBHOol3wItc30STqqXkJjZAJXNoEFKf++
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7591
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the 64-bit register accesses if 64-bit access is not supported
by the PMU.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Reviewed-by: Besar Wicaksono <bwicaksono@nvidia.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index c59f1e5a35a3..5f4f04135a22 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -719,7 +719,10 @@ static void arm_cspmu_write_counter(struct perf_event *event, u64 val)
 	if (use_64b_counter_reg(cspmu)) {
 		offset = counter_offset(sizeof(u64), event->hw.idx);
 
-		writeq(val, cspmu->base1 + offset);
+		if (cspmu->has_atomic_dword)
+			writeq(val, cspmu->base1 + offset);
+		else
+			lo_hi_writeq(val, cspmu->base1 + offset);
 	} else {
 		offset = counter_offset(sizeof(u32), event->hw.idx);
 
-- 
2.40.1

