Return-Path: <linux-kernel+bounces-97814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57986876FDE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898C81C20D47
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65DF3EA9B;
	Sat,  9 Mar 2024 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mKnmZiCw"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA2539AFA;
	Sat,  9 Mar 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709973907; cv=fail; b=D9nJObcnoensR1eA9DUY5Licj9UjodT1RONlZA9S/36wCLO4779FVtu/nU+c3t2Fab03cLpq1eIkNXmXqbhEccoDs6OvV419ERJUyxVSg8Ipmk91yq73wYs9DVrQ68rKGnmHfR8lmVTl+PnC7CTQ2IVaVq6Lpw/4P8mJruljyhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709973907; c=relaxed/simple;
	bh=dN7L214BHKIN2vsw9rUU5smGx6bsG0dlxyQaFVdsgpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s4io0hG3HIuTXv6auGYoNxFhbKcSmjXI439oQPGiOHgeLT2qLdnBMGw/UEmdA3z3BFesOAA7jk8n5j6tveTIUrHAqb6CWPOLt/6LdxdcYfSpvhZP++rFuxeD4RPzlYO6CJXEHRmUiiTS09KDLcnjS80JW68v91IPogxGP0DGsN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mKnmZiCw; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnXj9NQGKpKi7JEigSj/JeXALCXAll0TJKtlaQAg5GsWlxSmfQ3xCAHhCt8ng3Hcd0GTK7FlfPcCUltAiZjEmqd7TlqDsrXUFq3IY6r2hxhCS20ec13NiiipX6Nx87o08zJ8GK0BmBROo3zzEG0djPDWmNezfY3A2/zzeMY1u8mYa2ySutrKnU36eLbmSnFmdlNG3g+JhXPboMKeZB1RukvLwfCWmL0/dkAVu8q//t3mUvfODv0Gcv/elAvosZfqUO65YwyPlPVBbII/ldEJfDfqFYFl/So9R+kn5Vp+kpYItspNM1MdHo/1r6+uXJ/cV9JjuvytgYEFUPpMiV5Myg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbQRyhr40BMu2hpzbzg904a3AKx8411K4Ou5gTxN+aU=;
 b=TQZWfJj69GOCrr+7Reu6kxYEjRpkn0RGmJH4PDP8Lg2cS9TDmCmQ+x9ipKy6CwyMTnDIC5Qi9vRdWGpCEWSosnhcJzvYozU+uDsTPL6lhzTyBhIA6lrpdSPe0EbsgEXvGlyc1U3WT57CoYofGcF31muaQj3YB9OmMegu6w2Tt1K6IDOzDImcgzOq0lfeFlA1twQuyMlEA2b4/ljHo3UxIraRyyWDtOcs8ROLCzgHNBc8n+YL0VQUJqmrozx+btZwbi7Z743gV/3SzjDCNLB+Y6TnIEPgXlMLupUwc0jYv/DTXkwJVoFFz5aqUiA1WL4U+3wAr/PwictF6KFAcB7Mpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbQRyhr40BMu2hpzbzg904a3AKx8411K4Ou5gTxN+aU=;
 b=mKnmZiCw07LHKy5ifiLy3QQcJpMRu5qNhbGHucPFbQqEoJ0nYSDRjDcsXvg1eZBRlY3cLQE/8dHb/vlN1SOAnPgyD4flV2ot/zywrBKdUJ2ijJgqirHnRNqmUjQI9VkW+SXFNNS8usH/U7Mpfz5qMLZa4ocyDX0vD5P9u9tHPK+7GMf9lsAni0tUUnKGBK2vs9xPHXv5beV4+B2fze7DKtF2+8xfe3AtlFkn/XvloBQ1wiozyZ2MF3PATA4BgXUFt8vQ75NgZ8OiwkCix7aOBa5GNzjNE9p/eiJ8b6+0Qcd7EqL7bdmoJ7oauiXtt9XZBSey/Yl8f6XApH5hol9dQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Sat, 9 Mar
 2024 08:44:59 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7362.024; Sat, 9 Mar 2024
 08:44:59 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: rrameshbabu@nvidia.com
Cc: ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	alexandre.torgue@foss.st.com,
	andrew@lunn.ch,
	corbet@lwn.net,
	davem@davemloft.net,
	dtatulea@nvidia.com,
	edumazet@google.com,
	gal@nvidia.com,
	hkallweit1@gmail.com,
	jacob.e.keller@intel.com,
	jiri@resnulli.us,
	joabreu@synopsys.com,
	justinstitt@google.com,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	leon@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuhangbin@gmail.com,
	maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	paul.greenwalt@intel.com,
	przemyslaw.kitszel@intel.com,
	rdunlap@infradead.org,
	richardcochran@gmail.com,
	saeed@kernel.org,
	tariqt@nvidia.com,
	vadim.fedorenko@linux.dev,
	vladimir.oltean@nxp.com,
	wojciech.drewek@intel.com
Subject: [PATCH RFC v2 5/6] tools: ynl: ethtool.py: Make tool invokable from any CWD
Date: Sat,  9 Mar 2024 00:44:39 -0800
Message-ID: <20240309084440.299358-6-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240309084440.299358-1-rrameshbabu@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:a03:331::18) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 418ae04c-a1da-45ee-22e2-08dc4015340e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F+3Lu5VrUQvY3ywaxv9AfqjxBc/FMhwqeBV5k8NQjl58WfNHAhCpKkdm2Y3QCmgOM+lN4JyfG6MAsk1gpmkEqlNseQ/50m529dbhvmWJPotxjFEThoWXWUwW7mzcAYVtwSkTxcG9YkIeNM5PkvoWaxPm/GgGgtLtOvPE+AYT7o2l7jJXlGmTNqih3uE+cnYpOChT3jFMksX05mPJ58R1szfu4KaoKoo86mEXa19bB06oxj4wG8jyTZeWqN2QBc30YwqdSfwVo01TlfttXyYK3QKcIb3Hx3h/bCBCpmzVR1+OrcqQiDTNh48wL0LE284s3Od9gKpY5xms7tcWsYq62W5ZEtuWqsiZq4OqobtdyM+plUsx4f6gASBKwNE/incWCN9LrzaDBVe4DDtQxHZBJfbdVADUawwQ0IxlsJh5pn1nbVKX2BOez6yset9ciVUaK7BUseJEprc5+kwlFg+UVruEgN9Uw4gWwHQWJUeXZWZdyDKll0jwj7oZRoirN7g0lhSHxSmjEJS+vsk6FZvzuRY4jnZ5Bv+LYoRoCDMntf8KNqqnoSQ4eYZB9XHET0ZfCGLO16ipEX9qvO4EsmY1MIt/8Pb3oY/qPMO+PKM1lebjKyWolGyjbpM5XtE9d7SXxXVrcrOD3OUAjCec1BaMcptcKqtby6svGy4vXKOPS4g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ic5A4c7KJ/9SOQYAcxhkVe6QdmjM+BJo1p3ylRToa9bT0yRqKBUdzSmqpOLn?=
 =?us-ascii?Q?IR5dVvXyWiwSwcZ/z8pT9Bs6krLx8ThWsD8T8KLHesqsPi5W3MohqyIvCM3m?=
 =?us-ascii?Q?r9xhd96PeUZcWzKhZcNe2gbqSUVTtv1XKVH06kONdjMQ6EqIsEhMeyEHxXj0?=
 =?us-ascii?Q?CimxDS0YX/30UDzEa2wqAOgRN0FcXDgLEhdL4x15nQkFfqrwbAGu7RSRPsNT?=
 =?us-ascii?Q?SLlugjW7gbHHACV8NORY6f3l7deehNWT6jwmcQD5eQw33kJIOMrJWD62ljvd?=
 =?us-ascii?Q?qnY9B1vsP21oKBhJ0c5HxA0pAin9mwXSegOxVopKC6OPJI1pR1Hm6nLBQcM3?=
 =?us-ascii?Q?LCFacfFwz2ugycGwD4Da3HNk4v2GXuUedX+oG5iAnkzqSKe8PO5fc78dVGdd?=
 =?us-ascii?Q?DioQruQt7ZYKOsAbb4UgFoW93lOmus57i0TuegptDFwfFB/USjp76rBicZb4?=
 =?us-ascii?Q?dtaTDZTjs5mu8ZEIIk0m1WaBeVk/Yp3F63A9uWzo30siLmA34xbXpPNDw46K?=
 =?us-ascii?Q?dGh8zR3eougEFtjTL0FkqNqXhcHXwU8I0nhQ3qimGiyOWSCq8Ax/fCsxXnwA?=
 =?us-ascii?Q?8vR2h0piRojViNh1aqXojxgsjPTBhDdgzSwGaVwgc6tjV69DvVToAqFLC4XJ?=
 =?us-ascii?Q?GDhDE5b2PevJWO35dDW9wwmGbP2RFgH9j7V40s0RkHIpK16Sm+GCvepmBivB?=
 =?us-ascii?Q?E+ULrhgymlTY03h50mg+w6DhO82Eb7pp4SzD5dcicuXKeBtxwZRqExlIO3Y9?=
 =?us-ascii?Q?eryBrWG1PImwDFUTOkXFDkTQyJkGyO7CQ/FdLfXdH8GVC0tTSJRF84tcNv9F?=
 =?us-ascii?Q?pHSrbrZRl2b2cBC0MD032dJKLhQyGRBt6uq+vWaJaCRzFZ5SmaSB7OgGnKej?=
 =?us-ascii?Q?yxDMeYf28JuGpc3NlEeo7mjAn5uDhwCt7Ecm5skVUgXWEEiPA00JPAzhQurT?=
 =?us-ascii?Q?lZrgSSbxoS6CG117YGG2eMU3zHjOCVMJVduLRHaDZaVyikAZjCbzaQOjsG2h?=
 =?us-ascii?Q?QgKfbymXQLhHrEmDfa/WBM+xRyNNCzgyB98qCinSG9JMwCm8y1LTvIse7NCv?=
 =?us-ascii?Q?adp8x4kAoTCwLfKI4G8XXpl+9FkJPFpyCc99hZcv1L7senj8j/xGSFEv+lWe?=
 =?us-ascii?Q?1kVnpqzClc2Ir5v+VrSFsTS+8oe1W0lc2c0i/lI/pn/O/thjB/XbIFkqmJGX?=
 =?us-ascii?Q?tg1oqtPbwKCi1n5pdjXVUgYeo5nARochMbfWzGUNKwnk7uf8o+eJyOvtiNeY?=
 =?us-ascii?Q?J275ZMbj2UunMQVs13TQvyDfrIhFPzawgRNvC8F4dwoVwi39+D62wD9w2cQL?=
 =?us-ascii?Q?vwXQpUyOQU0j70/zOoOw86ndkafd08LY8BZC1Te7My7adFi0LKjFRdTAUe7U?=
 =?us-ascii?Q?StUXN49kzKMssTrVqCRaG50bsZyDuoVypA7nPmuX04RuxEreDtqq4DJgDmZV?=
 =?us-ascii?Q?mQD4aFvcrZj2wPn1WYrQhS2TpTuQVlDWMTP+HE/FV2ctAnPx7rjOmdZfAkBT?=
 =?us-ascii?Q?QwF8+14HRMPThuWICXwd4WEgnckYqq3FUVF3BsqcIy952VpUh8KzTE65sS8A?=
 =?us-ascii?Q?zPl3Dns3g7dhrTrkGsUzTrQ2XlqngNrXJbUmozozV/FPWKyt24unwg8PaB3m?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 418ae04c-a1da-45ee-22e2-08dc4015340e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 08:44:59.2838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AO+96ynP3gjggfz3cvbPq7wT9mFEdRHLaFoDAkMdxMGoA/TfSeNU5hHc+5S/RVyhhvZ050rxYLdtmfeboNpKvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394

ethtool.py depends on yml files in a specific location of the linux kernel
tree. Using relative lookup for those files means that ethtool.py would
need to be run under tools/net/ynl/. Lookup needed yml files without
depending on the current working directory that ethtool.py is invoked from.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---
 tools/net/ynl/ethtool.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/ethtool.py b/tools/net/ynl/ethtool.py
index 6c9f7e31250c..44ba3ba58ed9 100755
--- a/tools/net/ynl/ethtool.py
+++ b/tools/net/ynl/ethtool.py
@@ -6,6 +6,7 @@ import json
 import pprint
 import sys
 import re
+import os
 
 from lib import YnlFamily
 
@@ -152,8 +153,11 @@ def main():
     global args
     args = parser.parse_args()
 
-    spec = '../../../Documentation/netlink/specs/ethtool.yaml'
-    schema = '../../../Documentation/netlink/genetlink-legacy.yaml'
+    script_abs_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
+    spec = os.path.join(script_abs_dir,
+                        '../../../Documentation/netlink/specs/ethtool.yaml')
+    schema = os.path.join(script_abs_dir,
+                          '../../../Documentation/netlink/genetlink-legacy.yaml')
 
     ynl = YnlFamily(spec, schema)
 
-- 
2.42.0


