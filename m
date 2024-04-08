Return-Path: <linux-kernel+bounces-135948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D69B289CDB7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082751C21CAD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8EF148832;
	Mon,  8 Apr 2024 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="U9mvbKBm"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2137.outbound.protection.outlook.com [40.107.237.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881A211725;
	Mon,  8 Apr 2024 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712612448; cv=fail; b=j69YqL0vCii0/uBW9h2FVG/xgW9aMfBlGDTbvvCPWtSiT1rLP7+6+gs7fRKdute+dzU2fb9uTua9XYC2Bz7PtR/jg7J4k3csHFfpl6QtTAffL0I8t3DOMBn78U3Ia6eJbXwgsMB1g6vab7qaEyFDLXr5g5A/QcUWXm2MqQwlVsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712612448; c=relaxed/simple;
	bh=/lb+SF/SWYXIhQyAt/QJWs91TBc7Tw23Ml2iA8rJEdY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NsL97EWXfwyIe44X5X3ulwi8MyXYdMJdMYqKZBaOQXn4tUIr6vecUlZNUxCjTZzzbEU1LkGyveCM2lwp0leLxGlBOQrlCfzBTt0M/6j0ZfBcpoDzxGbBpEtEXz+ynMRGqAT+38779UwVfY4ofRfWIjUU9x9qCjI4hGhZhcz585I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=U9mvbKBm; arc=fail smtp.client-ip=40.107.237.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQHWUJiZ2Wnn8T0ziT4hjw8AI5r0aHmUVYvHJNoFL28tl+Unv+aTEHVNOPHzpntnCnAaZ1echiK/58cYbb441bBbaR+uWPhWggRfCNhPYoLLj/3F06h6DyI4neDvjQSKNkjObGHgf5yBc4V9EbcFUF9DiUaRdpDt4vmWGQAr8K9ZQtxTkoG+9QtPsQdzkQLA/wai3H4gy7uqnSGos7NhzjX+iT5tkyh3QFU8HcEdOlVDpxMfFgk/MIrrLjzR/cFshx/wR6zZvAI/tASQLILw9rP4M2i/Q6zCbz+vlLreOXucPgJatIW/2tJxMeQnf9UkNFBUAo+nLZJFMgaVATuOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueHDIs8PWJLHNcf/MlzNBDRh+eUXrzKkfFCFEE5fK/c=;
 b=Tp8bSYNQJGhEHLqoefHONPjqTs237YfixOQ2LKupTBCGlVRV5O3g2WVCwfUqdHHgHB7hNGPOZOWbEBThUhXF1vHfM9QjLet20lJtoO6nemaSM9xHkfugmAXRdhjHan7xuLkPA0QX+gchYuiQzTJn1Fv79Lahm93OSXW1gqPG9HODeOHfafJX5WdvyvEepFGsfNy7P6TuQ0dbzPLEt5kFiyaX6lKCd5Jnsln4mLjfTvUGi1gllsTUkqACtBzjqmj1OnIO45dQ9yFtwwasLYicZw7yCzKGCzRZNaYQ53fuGo9nV5tcvGBquTLliYjw2VpL22POQdc391sAJFiwzj9a7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueHDIs8PWJLHNcf/MlzNBDRh+eUXrzKkfFCFEE5fK/c=;
 b=U9mvbKBmyinGKE2MMNzDOG5d8dLhSAkA6qDfOmGTvPYmonq4hYTdeZ0VeVkl1VwO55baPa2HSqLlibq0KxQfKRvcnSWpKgjoQi2UCR3UUTGSW/ak6s7D2+uJc4fZHVpWtqftezwZBAdG+wOugMMpHU6RgWDd57TOXyN7/mTMum8=
Received: from BL0PR01MB4226.prod.exchangelabs.com (2603:10b6:208:49::30) by
 BL1PR01MB7627.prod.exchangelabs.com (2603:10b6:208:393::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Mon, 8 Apr 2024 21:40:43 +0000
Received: from BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26]) by BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26%7]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 21:40:43 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Will Deacon <will@kernel.org>,
	James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf vendor events arm64: AmpereOne/AmpereOneX: Mark L1D_CACHE_INVAL impacted by errata
Date: Mon,  8 Apr 2024 14:40:22 -0700
Message-ID: <20240408214022.541839-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:610:53::14) To BL0PR01MB4226.prod.exchangelabs.com
 (2603:10b6:208:49::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4226:EE_|BL1PR01MB7627:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UiVjhHaq41x+eGv4tSqTATu6dcxjtOyquxztN8xUsJKSVitwWIlfWk++0lBOKmsKEL8Ym2yBjG90tRiPuCMhM1vZIGNV+ZPbtO7x98pfnkHHd+lkFiiVRXPb6nyX0X7k3eMEZztOJ7OxzdFA1pTNs5ztBs0Pz94ZsXc2nb0dvbOZxdYwdyqhalCH5SGdgAgS0zHMFu3XSV04YMnmanjPNF1dR/RAr06P3Igl6fGMuQhBTkXReKrThigRN61JwF1HZDKgHKpxUg7evCz1gM8WB0953C0xijxXFkYK4Z49ZNcKBc8d4jGnD2c3C+WLxGJeA0X8+E+tB+z2PwNBST38ZFU3P5s5+TNkmBOlQKqjFMj/31aLuI3WGvUNwFcfrYTg11sSEh/9x8QS4ZbTXG/NBssNXEKtn3X9qb1oA/WjK/EZW5eYs7n7nchoe+5uvezN7f8ZIaV9gxH5IZoGwiBaIxx5ydqss31yTaFu7g27eFXZzO40+3ZsnAGavJj80O9I781jQhTgPYdK8AVvlGZ+Aah5s9zexkuh2BtOGeUH58kdyf6ex2aa+TYkSEc/OV3+T+6tMMAu6G3PMOkURCCZRyFoFbgEDQYbtMIiD9PbesP09OWuXFmobg3bV8I6GMtoge8S8jEx90xJSTXDgJD9ko196ppOAsgAUOVSZ8W9SlGDCV2gyuSOOyteAfc1U5mwNHSGx3aaU/YsKCsqm5v7le+fpI/9cD5+wvBqu1stZig=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4226.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3yqoWHZPa8QwlWmA07wWix1QGMQvfsBH7mjrFqiP/j+QaCXR2+GK4xNFyNgO?=
 =?us-ascii?Q?yvJKCPKd4nOBy1XggTeUoApK9kLx6dkk/9vxBLdMUPsOQMTTxBss5qGCsoKg?=
 =?us-ascii?Q?tGZVK+Or4lETzbzaanOGBeXlqXJLPAskhS0bipvZAQbTuC3jMNXww3+MyJvm?=
 =?us-ascii?Q?ZAjh/lP2hbaVrUN1/2/2krVO4b/ItW9J6GmhEjawweOQ7LsAWA1nKh2q2FOi?=
 =?us-ascii?Q?nNgLpfeIDCtjs0Askl8pv5SYPH3a6bbYmbDUQAktpN0JQ4fcCTE/JKUvQYCg?=
 =?us-ascii?Q?U4cOPMeEkGTsSCL4NHTxhXhvApFSgIzuTPcLur18rHme1EgaeJc8/0vbiP7W?=
 =?us-ascii?Q?Z5l/AJtPm6/KgiK9c7eAlpCjizdG1WZuDjPcJrn87tGEtXY8BxUsa6uAO8RM?=
 =?us-ascii?Q?7kgn1Cngm4g56BWZKA/mGknz7mWWEz4n5ggtykh3thsKhwQD/cxhMhD8VzxA?=
 =?us-ascii?Q?XEFlpKeChj8MwiIkoUzOGgnbvFHu2MCvbkfr1cDOX1v9/VTqND3uzVvAHYVV?=
 =?us-ascii?Q?LXnI/GNEeXVJ3ejrw2Mw+L6nClxuvC1k6SKwxaln57sj1/wcNw6rvWYYAQQd?=
 =?us-ascii?Q?ozw8cLHQyCLEaDC+TdR8okT33ObDg16vFKeLG5husOEvfdgKKaGLcwa+R0uE?=
 =?us-ascii?Q?UaETxIRAwIYoxPWiK8hI7IDjNIVgadd2or4uX6+z7h6KyEnXxMr3uEFaLnJI?=
 =?us-ascii?Q?irE3aI7ALYaBRMZRSm1Z0pnNxl0pJ8A3WkrIBly5z4W7CRERWpgwMiDvZcuP?=
 =?us-ascii?Q?+kYIihDNuvYvUF6XMVyzui9ZK59Fn25Oz2SD38k6exeuFgfNMZGLCcRB5GWt?=
 =?us-ascii?Q?2GEAgIlTkbiepperETmFRqZltdJcyAEEH6Ie2lsYfj6fYFNO7iCwYAM9EHiW?=
 =?us-ascii?Q?LVjX/SzI+DiYW+u2GghsjhbxoXMc6XaE7cH0bpYWJIH6JTuG2z5of9MJLCWV?=
 =?us-ascii?Q?RgC3X24pF0Q8dlU+NiQJphorA1rmRkPggF21xifqZuCggkjEPNycNo5aYlfn?=
 =?us-ascii?Q?76ViFtAN3J4F7SfKJkhu2mwKYfB7RiOiBeDQpBy6LIv5E6rAhWO2IF7wAzgN?=
 =?us-ascii?Q?5exbqcAi7QjTlXuz4Zvun/Wte6/ZHWnHsUYURPXVs2+j6FInHkc42Ie7c4q/?=
 =?us-ascii?Q?AAKYBbcWlMSNGFolhDm467if+ew2noXsXqwnHicy5h895LqJm7O9l6PHmPLz?=
 =?us-ascii?Q?FP1HjGUWNUPk77arfywZx90jpX1klw71IIYEKQU1L1tQF1Fqqi1bFRzPmwcS?=
 =?us-ascii?Q?1GUut83CvLgxLZEuB916GGNqPPxU+lnvo1AjL14n04M2phZ8pBMFaxXdm/81?=
 =?us-ascii?Q?HQy7ltFGz06OK39DuYzJmkyEq92oMJePUrWMEQtsawLKhE7xDrFjXZ7cQxML?=
 =?us-ascii?Q?Z3bzosW/h/fPlSAb3BGww5jhJDu8lpBXzR5QkMWTawqHdDz8TYSv2+b0vAq7?=
 =?us-ascii?Q?WmP+pFxHq/vB3RDSZnLYG3yhEiBPO4thQYdKW16fYuryR5AxmLVbnc13w122?=
 =?us-ascii?Q?mpXpJ0kPVsEjSl5MgdyhC7Mibuqcjw7lO4L/Q5QxiBiT3BX2nhtDu5OiAoT6?=
 =?us-ascii?Q?yflg2/KsYb9C68Aq4Kx2xYi97MfSrqxMB1vfMQE20rT/FvjJ7ickArp9FrrJ?=
 =?us-ascii?Q?yLOnEsEk1848JWglY9/6ZoM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d600b97c-8fed-4c8a-d098-08dc58148b01
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4226.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 21:40:43.6069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5IKM39Yf182Li85Z0XRLTxM8v/qhS8UUisQXJiqHdB6RpRwqSQhhCKOyU9MTPzKJz2hiu4LRocz7qxKLD35/uHHEMKN2WpOUvhKeUlYEo+f9AR2w2qGsxKF9x/3GDrzw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7627

L1D_CACHE_INVAL overcounts in certain situations. See AC03_CPU_41 and
AC04_CPU_1 for more details. Mark the event impacted by the errata.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json  | 4 +++-
 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/cache.json | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
index 7a2b7b200f14..ac75f12e27bf 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
@@ -9,7 +9,9 @@
         "ArchStdEvent": "L1D_CACHE_REFILL_RD"
     },
     {
-        "ArchStdEvent": "L1D_CACHE_INVAL"
+        "ArchStdEvent": "L1D_CACHE_INVAL",
+        "Errata": "Errata AC03_CPU_41",
+        "BriefDescription": "L1D cache invalidate. Impacted by errata -"
     },
     {
         "ArchStdEvent": "L1D_TLB_REFILL_RD"
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/cache.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/cache.json
index c50d8e930b05..f4bfe7083a6b 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/cache.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/cache.json
@@ -9,7 +9,9 @@
         "ArchStdEvent": "L1D_CACHE_REFILL_RD"
     },
     {
-        "ArchStdEvent": "L1D_CACHE_INVAL"
+        "ArchStdEvent": "L1D_CACHE_INVAL",
+        "Errata": "Errata AC04_CPU_1",
+        "BriefDescription": "L1D cache invalidate. Impacted by errata -"
     },
     {
         "ArchStdEvent": "L1D_TLB_REFILL_RD"
-- 
2.43.0


