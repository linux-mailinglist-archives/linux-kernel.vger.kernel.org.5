Return-Path: <linux-kernel+bounces-40731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5804C83E4E7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D5CFB2615E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888C838388;
	Fri, 26 Jan 2024 22:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="kywbhpak"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2099.outbound.protection.outlook.com [40.107.220.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA162563B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307188; cv=fail; b=HewFovkA91zoA0I2KuZQw+uGLLny0JKc6LhV8/bn5yF45AQbPL8uomtAEwchCH9sXSdGARI9x9IXWb6C/8ghW/pyWr9/Ey8TYat+ZYzS4jRMMO6Mv0TJlAXj794TuQ2XavvrwlzTx8JyZW6249tgW8PPm9J7PKPHIJ4GbF6CBlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307188; c=relaxed/simple;
	bh=xWzz1XShLCdIT6E941d4OnFMXmT41Qvqy3ILpw5Ng6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CLAxYLb5vhRdhlNYF857Fkz8PStQnb6/01BuHqO9g7OXhtV8YmMjWaAsEFDS8MLztiNWj642d0zrQTty0/I+uastHFGqjjWMWATbK6SgwdoKUDp5txpQSZ9rJCxpk4Hp9fN2lJiK9j4baQeEL2HzuoyTFdwG9UDD369Xz9vN0Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=kywbhpak; arc=fail smtp.client-ip=40.107.220.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIO3PtgSwwXWCVrgcK7s5IYh0QWhQNNEmEEWAqsqgzqPI4t3bHA5hjj6ETVDhOYj45QqH/h/VSIWiXDrcAHjXuODSfu7h/H9tKMkNbUvgjMRL7a62y7aW7jyLoHpTeVZv4ikPzusZ4t8K0OIRfd2C+3lS3c2iUPvKAYHORdfZH4E2buuEv6B7f1ikiCbF1MFMKa2xJhK849MqRULBaDWBh029jBdn/GbUzGvswMO3EFZ4yseeSP1WPb5HUF+3qoAcA3pW5wCtaK32Pc6ZZWom/vZqhvpeC1nofjSESKTZemykGGQi5ID2NeuCYSQ8zodJDXprBvOosVW8DYcCA1r4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SyuaePltjpI1YeJZX+fVap44lXG1cZP+l26fxKRQn0=;
 b=KpE8u631j2wDgCJpKVpRT6C7hI4Bnd7ImArAfLE7djRE77xPyk+HY7XjsoDbd0al90Aqz8vyEO85H/hiHt6KrSe2On//048JJhRrd2/rhI5WNAkDpxXVssOcLlqAQxgfCqZ9zUEa/sRekqJPtm/v8f6LEDELD5PUP1Ch7ddwPINzyq1kd/DKY1WOtmUER2PGS7vu1uK6vz32sAz+zBYYHV8wictZunYeq/q7FHAjg7Gg6jBMdJXU9q5cEj2lcdH5FmHuzE14caIeLSuuTtnRzpJL4xuRxLHa6tnFqe6+j3Htv6OQB48VHHaHX2+CWhVN9B+BE1SHQfBkPL2ZPn3CLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SyuaePltjpI1YeJZX+fVap44lXG1cZP+l26fxKRQn0=;
 b=kywbhpak0oaB3IOsP1il2stRtO1ehJpdelNZ6vwIHijHX7mrE22xSq7rggbZn0W7LNliNSymu5a70pRG+loRzclStBIprQWOLDE2EBPXb283U90hLY0rVZVnsySDvIY9s5U4Z5vhegkfVFvZ8U4GeSZAx2sXj3sGAHvHanFud/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB8166.prod.exchangelabs.com (2603:10b6:510:293::17) by
 PH0PR01MB7491.prod.exchangelabs.com (2603:10b6:510:f2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.24; Fri, 26 Jan 2024 22:13:04 +0000
Received: from PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::67b9:4671:4fdb:2dbf]) by PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::67b9:4671:4fdb:2dbf%5]) with mapi id 15.20.7228.023; Fri, 26 Jan 2024
 22:13:04 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] perf/arm-cmn: Add support for model specific parameters
Date: Fri, 26 Jan 2024 14:12:14 -0800
Message-Id: <20240126221215.1537377-3-ilkka@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: c3e8295d-2dee-4007-8b7c-08dc1ebbf7f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GQu1H+QLKjaePYiLXy/JiLMngyQSg3j8V/2kBheXWBgrFFie1bB/TNWDXWuhTFHcQyb6lUdwqwWeVcXbu6vCQCqEOV2ZDCpMAWVOYMvOPkfbTpg67HFX5jeRmSmq+8rh3GLSNOLniJMluhqCfu4Nx5C09uQyfUbnzzGn+8aggiSnTb5yS6/7xUONSQW595/9gBG/yu0MMEY8dKoVab/Qdx4+FfUljUj6BaB80mbwMHV2/l8Uud7hmrAdEZTxRs55BRPy3IAKbif1JV/um6DidoAto17pp8wbHN0Qw61X7+0rvNk/o7TO65S+CrjKFEUSx5Elb2DCpAuy4u/bcwQJ2+0a0Zo4u2BenGpiRNElEJKmQcDbGis9JPXMnPyH92itWxVIbfAs0g29mMW4+37bg0CWJ6xgFNfICaKMTU77Eq7WdW4CUJ7GxkPcLAvWLpTsLimfE0eL2XMtLevmWECrBzjP+D7gwBBowaqilfTaaLpa1ewd2ZIDpcUjR0n4J4rwdhY2ps2ci065F1YbZeKbCP+4RNA6cc9aMj9glHk/FNlb6UST8elu242MpmSzBc7MfKb13kZYMunhSfwKwa36eOkeQuySKeos3EDk7xhu746w8It5cTApxUApLZFvrHyW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB8166.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(136003)(366004)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(5660300002)(66476007)(8936002)(2906002)(66946007)(8676002)(316002)(4326008)(66556008)(86362001)(110136005)(41300700001)(478600001)(6486002)(1076003)(83380400001)(6512007)(52116002)(38100700002)(38350700005)(6666004)(2616005)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?73KY32I00eutJRMNLFgCyJfD7DrzICzOnkKsXnkMzklt5RNY8o9ke5WFuC+4?=
 =?us-ascii?Q?jWsxVq07rtcxWNW6fXfD+Tu6JQZ7wkGaYGbo2yVxtx997sTrw2QAUi599451?=
 =?us-ascii?Q?2tMCSgg7rm1vhNFOCPzXSjvHQa0djKiUrkYj2k+tFUd4Tt68LPujIO2OaGSo?=
 =?us-ascii?Q?fOYjQDWLE89oOC+lwHPX8rSxdh84goO1woRvV+lAOsbzfGCwDd8rtBqlW/JM?=
 =?us-ascii?Q?sKnXwtPVjNkypgf6GqaoDSQ1w8UskJpyitVqq2Hq8/Cfdx4o9HdD3EmHqzbH?=
 =?us-ascii?Q?j0bS6yU1y65gF7KpDGO4jkNophI9ZUqk0EewV3SsxKiZrNxkvYvOLsp5UV5y?=
 =?us-ascii?Q?FTWAAVlpzye5KZD9ourCRwHctIL4ujHe9t+qn5N9tTrG5p/BdMpOlKzzTjaG?=
 =?us-ascii?Q?axqBb2CtRdGk8b9kqyQgv45PVNbYGCywsrEdHQdHcReM+aOnCHoGsiAUbyki?=
 =?us-ascii?Q?d7GIlBGE2uioEVy9LFzIOZGwk1/Ny84gxKJsS9QkY80JCNnEr6+2GY5hO2G9?=
 =?us-ascii?Q?mOEy0GgK5eS853sDwXRLMoOz226FDQZDEnd/eJufaN2P3U34XSkWH+vsmIa1?=
 =?us-ascii?Q?3Racf8gc+zJMcU8WcsfyS43WFTWT/3qoZ1REvjcv7aSySja26lo9aec8dS3/?=
 =?us-ascii?Q?tprM3KrH2OEbsn46hAMH+VcTp0ysCJeW8WPgcgPBR9+qaoU506tdl2t99Auj?=
 =?us-ascii?Q?H6VcYrJDSVi+C3k5o+Y+MoiAMEajI14BHn8odRNcKIj+1IFg96jAVtdIi7B3?=
 =?us-ascii?Q?DdGNp4elwcXo5Dug7ERtS6XAyTlM6f4t+IcJVhIjP4IizyKwU0sJOIdoBOlg?=
 =?us-ascii?Q?43Pq3O93RUyflKx0N3ReDwuHobPc8T4lwUgfU1daowtHyfq8eB8F7pLFCRk/?=
 =?us-ascii?Q?qzZXKPD7tXQpnZ5JOV/XKHZ2A3K82rBZmmbwqZyKlzp0OrCwxTKtdIWOGnqk?=
 =?us-ascii?Q?4Ji1XKC7ODcgA6tN51wiX+CN2aJIAy5Qy24X+bqd8AxJYM8QMXNzhQo8JdgZ?=
 =?us-ascii?Q?ExdOFKdHwF39VzyvdXk/xvrCAUEE2A4DZJdsLV7yVOQGs3PZU4EpiexBD7L7?=
 =?us-ascii?Q?tpinPlMH7L/llJZdOkDZke3a6Exb/84Z9lXYLUaSV8Rr/SsNFG+t7YkoO51l?=
 =?us-ascii?Q?mjZ1eqNgQFaus/T0E+S8+zn3tvA2/iyMw+04tCroF1N1O87IYjZ35pEFZ5aW?=
 =?us-ascii?Q?PhmQwzyOkM0X8tzaW9LAxExhpUaDBk3MybzJ9fv6I1tAlXt1Y2X2hEL2gNe2?=
 =?us-ascii?Q?mdUUF3ahibibTN8XSstvS8BkjFludz4x8SSyub5u2X1pcz1P/McPjqFEb5gO?=
 =?us-ascii?Q?zM3oy9TPlrlCqz5BP1HxJDfTuQjmv3qZEhsncIAifIPb2ZEwogVKfKt9Det7?=
 =?us-ascii?Q?xjO+IOK4fzZmBsStGzyAity7EJZYiMbvAJ0XDxA+Ly31U75kB1CruMWjN7OQ?=
 =?us-ascii?Q?duxJqOE1hoONfbsVIxbeSThfSzJcqThOKcXJgAs6rN5jP0W7EjgjNj09kjJf?=
 =?us-ascii?Q?X1ZINMwFk/ZPRCT5hs2KDUPbN7b2tPlBuHo5f1/eQCuw+p6S0JLxX0NcyNi8?=
 =?us-ascii?Q?k/Th9p7/18Quf8EbtqybFaOQssQPCiR8XnRtv/oKr81SwI7ujfGXnGroXv/3?=
 =?us-ascii?Q?yvCA1RIovXznLQ9ijaTSEJ4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e8295d-2dee-4007-8b7c-08dc1ebbf7f5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB8166.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 22:13:04.8755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmNH0vP+KJ2mU4oGUtuiUAGVIu8EUwAsiH8v+jDhJZtCIObQgrRhuoN+83gx1b45+CUTwEeOJxS0/QFa2pcUFH6cN1MyGOQT/9QRLb824d0iIsUxZ9q4iPVno4YRoy6+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7491

Newer models have slightly different parameter fields or may introduce
completely new ones. Thus, prepare for it by making also the parameters
model specific.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm-cmn.c | 45 +++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 93eb47ea7e25..dc6370396ad0 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -628,6 +628,7 @@ struct arm_cmn_event_attr {
 
 struct arm_cmn_format_attr {
 	struct device_attribute attr;
+	enum cmn_model model;
 	u64 field;
 	int config;
 };
@@ -1265,29 +1266,44 @@ static ssize_t arm_cmn_format_show(struct device *dev,
 	return sysfs_emit(buf, "config%d:%d-%d\n", fmt->config, lo, hi);
 }
 
-#define _CMN_FORMAT_ATTR(_name, _cfg, _fld)				\
+static umode_t arm_cmn_format_attr_is_visible(struct kobject *kobj,
+					      struct attribute *attr,
+					      int unused)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
+	struct arm_cmn_format_attr *fmt = container_of(attr, typeof(*fmt), attr.attr);
+
+	if (!(fmt->model & arm_cmn_model(cmn)))
+		return 0;
+
+	return attr->mode;
+}
+
+#define _CMN_FORMAT_ATTR(_model, _name, _cfg, _fld)			\
 	(&((struct arm_cmn_format_attr[]) {{				\
 		.attr = __ATTR(_name, 0444, arm_cmn_format_show, NULL),	\
+		.model = _model,					\
 		.config = _cfg,						\
 		.field = _fld,						\
 	}})[0].attr.attr)
-#define CMN_FORMAT_ATTR(_name, _fld)	_CMN_FORMAT_ATTR(_name, 0, _fld)
+#define CMN_FORMAT_ATTR(_model, _name, _fld)	_CMN_FORMAT_ATTR(_model, _name, 0, _fld)
 
 static struct attribute *arm_cmn_format_attrs[] = {
-	CMN_FORMAT_ATTR(type, CMN_CONFIG_TYPE),
-	CMN_FORMAT_ATTR(eventid, CMN_CONFIG_EVENTID),
-	CMN_FORMAT_ATTR(occupid, CMN_CONFIG_OCCUPID),
-	CMN_FORMAT_ATTR(bynodeid, CMN_CONFIG_BYNODEID),
-	CMN_FORMAT_ATTR(nodeid, CMN_CONFIG_NODEID),
+	CMN_FORMAT_ATTR(CMN_ANY, type, CMN_CONFIG_TYPE),
+	CMN_FORMAT_ATTR(CMN_ANY, eventid, CMN_CONFIG_EVENTID),
+	CMN_FORMAT_ATTR(CMN_ANY, occupid, CMN_CONFIG_OCCUPID),
+	CMN_FORMAT_ATTR(CMN_ANY, bynodeid, CMN_CONFIG_BYNODEID),
+	CMN_FORMAT_ATTR(CMN_ANY, nodeid, CMN_CONFIG_NODEID),
 
-	CMN_FORMAT_ATTR(wp_dev_sel, CMN_CONFIG_WP_DEV_SEL),
-	CMN_FORMAT_ATTR(wp_chn_sel, CMN_CONFIG_WP_CHN_SEL),
-	CMN_FORMAT_ATTR(wp_grp, CMN_CONFIG_WP_GRP),
-	CMN_FORMAT_ATTR(wp_exclusive, CMN_CONFIG_WP_EXCLUSIVE),
-	CMN_FORMAT_ATTR(wp_combine, CMN_CONFIG_WP_COMBINE),
+	CMN_FORMAT_ATTR(CMN_ANY, wp_dev_sel, CMN_CONFIG_WP_DEV_SEL),
+	CMN_FORMAT_ATTR(CMN_ANY, wp_chn_sel, CMN_CONFIG_WP_CHN_SEL),
+	CMN_FORMAT_ATTR(CMN_ANY, wp_grp, CMN_CONFIG_WP_GRP),
+	CMN_FORMAT_ATTR(CMN_ANY, wp_exclusive, CMN_CONFIG_WP_EXCLUSIVE),
+	CMN_FORMAT_ATTR(CMN_ANY, wp_combine, CMN_CONFIG_WP_COMBINE),
 
-	_CMN_FORMAT_ATTR(wp_val, 1, CMN_CONFIG1_WP_VAL),
-	_CMN_FORMAT_ATTR(wp_mask, 2, CMN_CONFIG2_WP_MASK),
+	_CMN_FORMAT_ATTR(CMN_ANY, wp_val, 1, CMN_CONFIG1_WP_VAL),
+	_CMN_FORMAT_ATTR(CMN_ANY, wp_mask, 2, CMN_CONFIG2_WP_MASK),
 
 	NULL
 };
@@ -1295,6 +1311,7 @@ static struct attribute *arm_cmn_format_attrs[] = {
 static const struct attribute_group arm_cmn_format_attrs_group = {
 	.name = "format",
 	.attrs = arm_cmn_format_attrs,
+	.is_visible = arm_cmn_format_attr_is_visible,
 };
 
 static ssize_t arm_cmn_cpumask_show(struct device *dev,
-- 
2.40.1


