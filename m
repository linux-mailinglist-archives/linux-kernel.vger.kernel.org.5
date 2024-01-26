Return-Path: <linux-kernel+bounces-40730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C1683E4E6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1701F22C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EFF288D9;
	Fri, 26 Jan 2024 22:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="QcvVor11"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2099.outbound.protection.outlook.com [40.107.220.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504F325575
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307186; cv=fail; b=JcsJejif/JiTAVHgtW0Fi5W5hwFxmgf42m6yybyaG00wNnqEjTSwSTCeQ9rwHUeWzhYXUWkjne/i5FfIKGRBwbTTW4ZD+OEAXmIH01ns9TKcsJLQQ3iFbGWw0wNJzzwR1ETuE2RbZ7b32x2joETRZagO5CzQF4oLEq1iJ0aROuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307186; c=relaxed/simple;
	bh=HzApiIbNd/xZnQH8Jh0OEjhS1jXFO714qS3X41VcfMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mW9UK/dJp+mQuVV1u5OJdCooWHhvxy/o7xfI1e9XB9gJDC0DfJdT169Rq2fLJmU7xVw/Jjc1oOePZFW3CVnixDJa1m6oLeTQmMPn/M2pMa2q/7SniexfIlz2bPZK7lZl14P5XMv3Bs9LGBp+3UidftZLL5USGjBr9avWH8G0M30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=QcvVor11; arc=fail smtp.client-ip=40.107.220.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0DLb3jOjLydm4zy21uVhSkixyt6E84z/PEvO5fqJiHkoAOA32ylHNbJjUj03YCjUhqCmXHxkzLdpwpxnNHS3y6QFvuQhGwUS9gZwSNDB+EeX0IIrMptqfKHLFJ0JRoVZ6AZNXl0zIapZ9HHA15j3BrGH7HsKrMJfD4X/K9G+aW+upSRY+B2Bm1LL8qhN1lrPY1zklv0Jyoa2rvYO3d9lKPxGWgN33x1EiVqA8YDidKK2csYcBu1jKgu0YHR4JW8npfOCEfMJ27yetBofFFyzS+2W3Lcv+ek8/P5+7yH7aiphsVf0s2LJK1zmDkG7WpWhG9U9vdonU7t/IIEZxZjWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zDC/u8CMJGsmbvWDpSeINoJwI9J/TAsOGncMzUpRD4=;
 b=az57GsAlO0nurKtieeJG8lc6MjOcGzt/CVBUaKtiZmQp0FlRESM4v6LM7jNn85xp1PnFPLd/sfoStK3beGcA7K9f3Ez4B1lhtvifqYm+xldbkdkZEpuO3mwFdzRDwPlEZ1ytAuRVJvQ4JCpIYW0ZnN5qOLxH2jN/O8GkXQ2SRyJx8vC1qbcz60heObjEg9OMbv1xaJO43oCZFoYRfS22PzxnOOtoiDs8j/Dr3dCFfPXYCZRKRZV9/YSo0DB1SiVE/7pDqSVJc2Vg8xmAdqYTbTOTmKADPaE/NCK/dRmf3Q5/xAIE0aW75WGYpXv3WVEKloY6+TAEXKYYhtWAbzpHqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zDC/u8CMJGsmbvWDpSeINoJwI9J/TAsOGncMzUpRD4=;
 b=QcvVor11cUKMwlMNZk3TQEy0hDo8OirDm3KWKU1YRoXmir9q3BLU5IMPTgO0TmwrcKsNw55UZETZBKyNk2UzFxH3waGab0nVKlFIewDEHMe7qwipU9uivWBc0abaM7Uhm0F7b3q3gf5Pm09RxYKSC+7lCd+YnMGqRuiHkNwwVDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB8166.prod.exchangelabs.com (2603:10b6:510:293::17) by
 PH0PR01MB7491.prod.exchangelabs.com (2603:10b6:510:f2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.24; Fri, 26 Jan 2024 22:13:03 +0000
Received: from PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::67b9:4671:4fdb:2dbf]) by PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::67b9:4671:4fdb:2dbf%5]) with mapi id 15.20.7228.023; Fri, 26 Jan 2024
 22:13:03 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] perf/arm-cmn: Decouple wp_config registers from filter group number
Date: Fri, 26 Jan 2024 14:12:13 -0800
Message-Id: <20240126221215.1537377-2-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240126221215.1537377-1-ilkka@os.amperecomputing.com>
References: <20240126221215.1537377-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::27) To PH0PR01MB8166.prod.exchangelabs.com
 (2603:10b6:510:293::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB8166:EE_|PH0PR01MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: 978a23c7-5f72-402e-448b-08dc1ebbf6d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w4GTRHwgd/oZoh+Mk1A0VY0CAk+3f4ZfGOT3VSOymleo+AufyrY8I2vtnfuYd8akIpui/5AfkxBgiRc1rrmdpr/WlABx9nI4TyKXScSALxvFYADh1XAdSy8UwJOEfIcaQD/ytqHQac5J2vA/jdNq+AiDQBUIBCwu45NRw6cRmfYTc3Jm887je150luRW71/kBkiHamGABbkBug+1Ls8t2cJUVJAzdShAU+dy5IRApCbo2hCTaoJCvg4xQ6rT0dDOf78bbycNxiROT+ZmyQCaT8algkPDq31yUxhuj9VFFvX14a3RGeoSllXtx/A1PqtYbhv53LUl8zdCZGco4hM8RQZhcBfRQYR8ePp2/pfY4ZVv3PpwldK5WF/XJf+NVfKVvPHbhzj//fHWORo7CVTw31QZbVarsO55mushfIXrxQob+wfLWlcPvi+W2C6gNmF8Cu1oX5+pH4J84nR+ZqeP8MPBHeZdrSY1VjxIyIvsxfviTorK2xx0snM1shKr5bwRGHrL/sGSBb03pLdD42kwD9YfM+wOiKfXr/UbDpOlwXwXW9ANXyoTkOSqC1p/fKSr2Cp2GeQqlJWeYAnjb2ouNtQk/bxocmCTq9XjkDVGH9sV4MOoEV7OhZTyrX40/vgc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB8166.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(136003)(366004)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(5660300002)(66476007)(8936002)(2906002)(66946007)(8676002)(316002)(4326008)(66556008)(86362001)(110136005)(41300700001)(478600001)(6486002)(1076003)(83380400001)(6512007)(52116002)(38100700002)(38350700005)(6666004)(2616005)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DG74oNWfn+PRhQTfE02m52ZVqoubhx2/eKDYDJZ1AQ3/43zaK/YCMWMUYz8n?=
 =?us-ascii?Q?U/bSYcLEk4T6/+BiCcQN9geX41cNCZUH3IKuYSdAuQXWj0NnVH3c0GCiYGB8?=
 =?us-ascii?Q?eoDraiZbNuY+ddnK70tgBETMn3bdCg5xmgN5oZINQlS+grAa12dCrVNEDaXp?=
 =?us-ascii?Q?grIqrmPALIxkxnouCZqY8XRK/qYYb3zgLKWUqNa9ZIRfiDaXY+cDXimZA6wT?=
 =?us-ascii?Q?++oW/e9SRAFbFvtCyn8L9oa1UKpPHS0Ez+500EpZtCiZbQgXjQm0lCfi2Fnh?=
 =?us-ascii?Q?YBGyN9Et7jTD18gOTLBm0feFnXl/Mmc4M+6d96f/q32kI0uqXol+1wTQ7ZFH?=
 =?us-ascii?Q?SFCGquZwjJBo1z8GeyDCztB1HdO65aIUavqFpQ7fMJScJGpYH2AzSAgT3fMO?=
 =?us-ascii?Q?qhTA++Z2VcDPlGcfNPNaGnJLMAwCKOaX1+fIEuO58Tjrx/Au/WauZwBDyRqQ?=
 =?us-ascii?Q?jsZYBCSqH2QPpqKqWepZinsixfSYm6K0Sgm64wSYVyJ4f+x/nVDVraeMo3pR?=
 =?us-ascii?Q?AM2UBrcUQGXMVmGLlUBJqTrn9YxeB1LFa1yKlHHRbw1PalKTi7ujfg4YuAz7?=
 =?us-ascii?Q?DCkyHfHtc8PX7KZvNmQ/6dv8B1p43LqxAiHKnewWFJloBoMGhqbVx50EXtKp?=
 =?us-ascii?Q?IlW0dVR5/x/kCU1nAdWmTqg/vHB0szoeyXTIQgNg9A9PUBuXKipYNOXvOaqh?=
 =?us-ascii?Q?YZA5QRdAHSP5LfZ0T2DW7YIlWhkyHe6aTnJpgb1n+VmWmraS0cHOLi7szmNi?=
 =?us-ascii?Q?xwCSrMuYwJXZVvf0ZN1kFG4JSSirUa0tndmt+IUGY9mkxo4IRtYhl/7z0Qjb?=
 =?us-ascii?Q?Jd7o5bw42xMyDsp8gGKaokqGKqfEfgVWpCo9YC17Qxb41R3TVBfLZwYe4d20?=
 =?us-ascii?Q?DwofAE0r8cob1FwT1hO5AvbBJcbKdMKcxLuL889APXZrBscL2oFioTxfqxe2?=
 =?us-ascii?Q?hYvVMCkcC8T51z92CnBfjWxA4y9EKmyVgDJ5/L9M9gc0OJuB2D6hbTBwIWOg?=
 =?us-ascii?Q?UY4sntOKUYqO4aQ0R7i9snEEVHE7hFrUSvkEk5dQiTSGXjd/BAv2BDqgRXij?=
 =?us-ascii?Q?L5VBjIBmHQfq4JGHuf8rTKis1umekSfH072MdPDaCuetFTo6/vCSS6Yr6C6I?=
 =?us-ascii?Q?YL8HG79gn0bzmbRBIbf9fa2gwtvOun+s+dTlI7vPoZIMmlvoF9FEEwyiEa6F?=
 =?us-ascii?Q?W6qeA4MNMAFBGCpflb8zJJaxZYg4h04+hLOUmHvIk9PwVYNfA0cqEX4B0xt5?=
 =?us-ascii?Q?lXf5v9k6LcFwrjeLUbwwGOgcSAeuCFje9KNnWKctSWP8xi928QApyeIFZwWA?=
 =?us-ascii?Q?/2/i++OMYkvcgmojJg9J9Il9BR3NgES4drxGi6UTzO/TU2Xn9Xku6wf+t7ZJ?=
 =?us-ascii?Q?TlZPriIKoNBmaGOf96+3NS4oBioCnUrbKvr06jYGJnTwHMstIEp/houxtA2f?=
 =?us-ascii?Q?rvsLJrjqql3UkfzVKNB44isDr+n9T/Va8zYLzq3By35oqtblHEv+HanWVgl+?=
 =?us-ascii?Q?hh89400i0vNGSWpwQh0kE0jPIlga8SjoVpqlwWcoRTetPHhQ7hhvog+x/5CL?=
 =?us-ascii?Q?xDSpBfY6CIRlx3ozSqlRuCpfztFN/p5NXPkF/LT5HLbBZvoBe2Y7EfrMs9bt?=
 =?us-ascii?Q?W7pNOBiR/ZIgqlsQcWg5Yj4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 978a23c7-5f72-402e-448b-08dc1ebbf6d7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB8166.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 22:13:02.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fI5C5xTy76JAIt35OMzFt7DBWewg7DeaRyp8zb3LJe35Ltg0lsSRXs9F4EkYrb/Cxi5Fc3XmTaAQ2+2P0tonfMvK4P9rHaknrxPdzmTJKQ3pSVmWjeul29wNZWGr7QZC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7491

Previously, wp_config0/2 registers were used for primary match group and
wp_config1/3 registers for secondary match group. In order to support
tertiary match group, this patch decouples the registers and the groups.

Allocation is changed to dynamic but it's still per mesh instance rather
than per node.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm-cmn.c | 52 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index c584165b13ba..93eb47ea7e25 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -591,6 +591,7 @@ struct arm_cmn_hw_event {
 	u8 dtm_offset;
 	bool wide_sel;
 	enum cmn_filter_select filter_sel;
+	int wp_idx;
 };
 
 #define for_each_hw_dn(hw, dn, i) \
@@ -1337,7 +1338,35 @@ static const struct attribute_group *arm_cmn_attr_groups[] = {
 
 static int arm_cmn_wp_idx(struct perf_event *event)
 {
-	return CMN_EVENT_EVENTID(event) + CMN_EVENT_WP_GRP(event);
+	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
+
+	return hw->wp_idx;
+}
+
+static int arm_cmn_wp_idx_unused(struct perf_event *event, struct arm_cmn_dtm *dtm,
+	struct arm_cmn_dtc *dtc)
+{
+	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
+	int idx, tmp, direction = CMN_EVENT_EVENTID(event);
+
+	/*
+	 * Examine wp 0 & 1 for the up direction,
+	 * examine wp 2 & 3 for the down direction
+	 */
+	for (idx = direction; idx < direction + 2; idx++)
+		if (dtm->wp_event[idx] < 0)
+			break;
+
+	if (idx == direction + 2)
+		return -ENOSPC;
+
+	tmp = dtm->wp_event[idx ^ 1];
+	if (tmp >= 0 && CMN_EVENT_WP_COMBINE(event) !=
+	    CMN_EVENT_WP_COMBINE(dtc->counters[tmp]))
+		return -ENOSPC;
+
+	hw->wp_idx = idx;
+	return hw->wp_idx;
 }
 
 static u32 arm_cmn_wp_config(struct perf_event *event)
@@ -1785,6 +1814,8 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
 
 	for_each_hw_dtc_idx(hw, j, idx)
 		cmn->dtc[j].counters[idx] = NULL;
+
+	hw->wp_idx = -1;
 }
 
 static int arm_cmn_event_add(struct perf_event *event, int flags)
@@ -1794,6 +1825,7 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 	struct arm_cmn_node *dn;
 	enum cmn_node_type type = CMN_EVENT_TYPE(event);
 	unsigned int input_sel, i = 0;
+	int wp_idx;
 
 	if (type == CMN_TYPE_DTC) {
 		while (cmn->dtc[i].cycles)
@@ -1822,6 +1854,7 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 	}
 
 	/* ...then the local counters to feed them */
+	wp_idx = -1;
 	for_each_hw_dn(hw, dn, i) {
 		struct arm_cmn_dtm *dtm = &cmn->dtms[dn->dtm] + hw->dtm_offset;
 		unsigned int dtm_idx, shift, d = max_t(int, dn->dtc, 0);
@@ -1835,16 +1868,17 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 		if (type == CMN_TYPE_XP) {
 			input_sel = CMN__PMEVCNT0_INPUT_SEL_XP + dtm_idx;
 		} else if (type == CMN_TYPE_WP) {
-			int tmp, wp_idx = arm_cmn_wp_idx(event);
 			u32 cfg = arm_cmn_wp_config(event);
 
-			if (dtm->wp_event[wp_idx] >= 0)
-				goto free_dtms;
-
-			tmp = dtm->wp_event[wp_idx ^ 1];
-			if (tmp >= 0 && CMN_EVENT_WP_COMBINE(event) !=
-					CMN_EVENT_WP_COMBINE(cmn->dtc[d].counters[tmp]))
-				goto free_dtms;
+			/*
+			 * wp_config register index is currently allocated per
+			 * mesh instance rather than per node.
+			 */
+			if (wp_idx < 0) {
+				wp_idx = arm_cmn_wp_idx_unused(event, dtm, &cmn->dtc[d]);
+				if (wp_idx < 0)
+					goto free_dtms;
+			}
 
 			input_sel = CMN__PMEVCNT0_INPUT_SEL_WP + wp_idx;
 			dtm->wp_event[wp_idx] = hw->dtc_idx[d];
-- 
2.40.1


