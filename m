Return-Path: <linux-kernel+bounces-79027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DCF861C84
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A9C28744A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C09D12D758;
	Fri, 23 Feb 2024 19:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jnOuPH3u"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F36014533C;
	Fri, 23 Feb 2024 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716473; cv=fail; b=KiOfDhM0D5a/XmI68rRd/2YIzHHc9Mw2kxjn3wN5UjcwY0oH72HTxQ/ndAos2piR+ZEWadP42Dz3rf4UtEJHd6z3xa1Nurytnh4hp1pQJz1ZNxqmDL+oVdNaVQvjBLWiUliTxa8nIBbVAAyOXgmqvgo1TY5Rv8iiLvsetlIrw1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716473; c=relaxed/simple;
	bh=CNAzUr4GyhhisfblkF/c2qTSaiAj6DN7DqMBTN+YdJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lmhvP1bh3uWTrE2tFvBS/+A6mIJGDsK78dAnxbYVIa0KNJKndbIC59u0j2tkL86v2NBwjsxwuESHkiLQGTJgok2j1IZxflW5o7sZ5ikoqhfo1aN6tN/bad0FuMVVRQszoSCREzuiiNoW4iEOBqfMaP1kMLZK+Us3c02qSF6D6+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jnOuPH3u; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/P/xtqDxQSNEEOJ4+kzbifOoBKTx1CCZyL0FXVLZcELtAKhVYKbjrsyI/f7F54qLmSTEwDhy6TZh2hA9O/WMatIi3v+/RZaVhSMY9Ffw6VFEg4K70O3xI93njGlmA8zd8oexeSzK37oZW4dJUCimqVcuqOFUUkl158KDHA/+3RbuGgmdcaLiFiUNmPRCXPEPIaPtv+JzKRPXS8WzK6rdEf7FaSEAUB1dDwoThpDjtv9rWGeO2k8rHRaJF9B1Ntgvndssq4dncNY4fq5cWLtZByALzuW3HgvRQRXgBM0lo1A8qDE59J57iLhpQwxLDkfycQRpWZADBzuV0b+Fr761Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXZtvN1TXjwbqsyoBsYP95PkqT7reIHbTJbL59LhaDE=;
 b=ibxz5FiN3B/X16df6rxR0ScUX/kSRx1pVfPsdHbPCZb6N/VwRp/GRU1DS1eNyFF9nr7FUp/seE84SwfJUwpkifuUefuAuBjU9agWW4nPMLonerg/zBYZ7YeVAH0DUuceg1N2FzWllerwAbyAR/9eZh84VhHcR5tAf5Y7U5wAeaUxLA+ugLJryoCxFc0e1Ea4f8sxairO/NHFEpEtPzcyCHTDONpC9YgaHge9gt+6x+spUhirw1hGidibPCE0aSaSPQr5GYodGGRMLrbcgvXM3CJrzejPAcbBAWfntADHXRHvyNT650QfWZnAezPmGQgpvPWzbTfU2Mqy3jefgT8+5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXZtvN1TXjwbqsyoBsYP95PkqT7reIHbTJbL59LhaDE=;
 b=jnOuPH3ujxaxMxCPoPu3ezNHNCvDa8ljPBW5PtKM+zyQCMk9unacFmdSSCdPLFLXczv6JFJMO1kJyuuKdVBBZvebzI6bBWa+NMoHzUVsqkuhK+N5WMk5X/n9blEYPTfNtUCT2SkBYOsUS2HzBBEW2ecXCJW+Ij42/F5cB7TqNbaYo4wCI+EaJ+lXkuYKcti/M237s8KexrLaLJ+kklm6KKbw/T4wGZORRdK8bZFMhpfoB93XCWmjnAK+J3rAMf/WXoJXIsgS9duQsx8mbsVprznlZHnylk96QTqmWJyZRQ1QxRqUZiHJfhznTMkQ3LKcpI7Bam0X0aeEetmVV2XYEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SJ0PR12MB6831.namprd12.prod.outlook.com (2603:10b6:a03:47d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Fri, 23 Feb
 2024 19:27:23 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 19:27:23 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Saeed Mahameed <saeed@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Justin Stitt <justinstitt@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH RFC net-next v1 5/6] tools: ynl: ethtool.py: Make tool invokable from any CWD
Date: Fri, 23 Feb 2024 11:24:49 -0800
Message-ID: <20240223192658.45893-6-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223192658.45893-1-rrameshbabu@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0050.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::25) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SJ0PR12MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: c4945d52-3b49-48fa-3a85-08dc34a575aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vLLYZBJCaf0Hz5LXtJPQNNER5lNS3x5XvG8k2nDbgik85POITuDOT08MkfQAXlo5ctBOTlVSWNX6oop6ekpoEsbFaDfXZub8r2RFTiStP76td+uGP/+hwtSfv6gF7vnZiU6gKw+OHFyudRNRs7JrMRVnZw7OQ0P0QgEvfd9wmwuUXhw3WhrQtfK90jWGvujxlqGH3Af3sRiO9lptCjrHqddO3F2bfToKTGJtY1EdE2RR4fZD/HUUKeXmiHtFBUyJ+BuAsbEmH3MTvwVDGbka3xIAeOwWnFDNg9Khqgu0hlBZd+VdTfQ+nhIL/Fqgyp7EA7drFkKSN2TvTp4mPa1rCGMER5tjx3plJ4R4trGbTiOTzWOk5cI+JjH/vgHRWoecf5Tg8wM0xN1kJjzszo+akspYwZdpj6/QCQibYSB0tYp29KoFPakuSGLwh+vWVhneWeFg3mDZkz5TXgdGI+2V8RFbK+ksGQ/n5p961K/+XE7Ym8H319YESPiTGTAsmItL3xwB0XOayeu04MxCGFfYrjhSR9VPfVvwr5rb2TNdmJpBAdAY/+oZDFyjwFjRxmlahPOc2W1fvUUkm+wAeXfaHwRt+PiwhypwxA9CZ5cV4Xk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pQ/Rpc6ALawX3sCLXjmlK9TXMBdh1C7Y3HhvXW55BECzH/JpuXfoWZmv2yXD?=
 =?us-ascii?Q?BnlWMmBM1YOw5wXvisIN/CZAJyo3A/niXBjQ/ZKTCLw9HnZ3WzTtOrCY8lc5?=
 =?us-ascii?Q?aOnFkPAmc9+MR0wkeaOBrc4MKHcR61H4zYL2NKHXrem9oVflFZ0vApwhWiuu?=
 =?us-ascii?Q?Onq6yqpYSGUOyIuOpcp1IH2A9t7UfhLoqcmIRPzRB7ZAK9tFMxbd7BfXXtXM?=
 =?us-ascii?Q?4sazXsfC6nHOSD6vUx27IbWq/01xC+kiBbSRG8M1dUM5QgsVa00yqp8DjHpR?=
 =?us-ascii?Q?2LuQOn5KMba2iJ6dSwwLF7r9FzntrSj4pIEpHyDgix+swXDRTA04IVJbD2R9?=
 =?us-ascii?Q?MBrbzNHopbwHAA8vW1i3X5qcBGr04XCv3BO32mvXluSWQMRWPxz/mFXmWwrD?=
 =?us-ascii?Q?oCzH4HpAIAB+8Qn1PzQ7zra1DZYiJXD/ijvmQ3UbkiCiVnNX7PQRIUcRwD6R?=
 =?us-ascii?Q?lQLrPAAM3f8/hc/0h9FkwlB+3ftY4q8T1tRiGUcFcHxWgxTupWqWVUp3jVbD?=
 =?us-ascii?Q?mTEZo8Xkw/3JiAJSGdFimKEYLGBNNUEPRuZxwh7Sk3/yZeTKV260PkHvG78i?=
 =?us-ascii?Q?a3khKMLbMZR2qxGvoo/LK7W/K0xPaOk0fxOxn4wncZ5vLw47LwNq6jG1mu4V?=
 =?us-ascii?Q?7rsgvcmCkjB8QFQXyYrR0Q8MMBy+rh+6TFyqXJXb7Oe7oLxCqnFklIEddog+?=
 =?us-ascii?Q?Z+8A7iVqs68qw7Biqh4dDj5RLrsN8vdBtNr9/7KZENLt2KkQrtI6T3Cj0EIa?=
 =?us-ascii?Q?mJ2x4URzaJ2HTjc2xjZEu69444hy/7O+Ai/LrD2UI+IxlZV/yIcnZBBjL9TK?=
 =?us-ascii?Q?t9kcwBJPz3MRqKqSDwV1cZ9QH2A53fPgtgicc5Hrq2nVwgNTeFdWqzuYnVIc?=
 =?us-ascii?Q?Nzzf+rOr3HIFVQP4ZrpRT8a4zYY92JV5h5YMmbE6WirZb7xXWtqfAnVcQMzm?=
 =?us-ascii?Q?PjXXI2bFReXjjLls+/KYjKISMq81Bg0zxTgz/jr+mYiUOjskGqRsIKpUxfN/?=
 =?us-ascii?Q?YNncneaW3OjPaEf77qqEL57TdVXB/XG8fJ2IeO1KTG8+zYLv6Ndy+cFrA2E6?=
 =?us-ascii?Q?gkv0PNdQwmwtx6kk89VtWyDkMt9p3MM3eRVTW3hALMnrc5n/ENsA4stlG4Kb?=
 =?us-ascii?Q?MQjf97/xM33QaAhZaGLc+JBtNQ2GHzeEakMp+RtftZqpB1Lje13t4AN7EwLC?=
 =?us-ascii?Q?RmCklRg0VBx23Y+Zf31onHFMwixsBDj9xyBKOzyd1xsjXcZx0zieTI07Remk?=
 =?us-ascii?Q?LQTDgqpKZfmTu7TgAPLpNdP6Yvj5Ra1yP5oEch4H/bcj1YfVDo0vJzgbLcze?=
 =?us-ascii?Q?lYZB7JerLelZ77xTHpBM4ifGWpQVlKVq/e/rRi07aOlHwQ0ek1EHSMQvGDc3?=
 =?us-ascii?Q?k/EuYpOyp/fSMJWAO9RVn6Ucz1p6qCbP0YW6ZOsTCGFGqp+YOCURHMQcgkkE?=
 =?us-ascii?Q?WpCm3LUbMHNhD8H/c4v7Ni1qY8wNTTJ/TyoYZmoOy45Mux3fXQXxo8KbfTXq?=
 =?us-ascii?Q?L0akTIkQPtshqHTm3DQjTGy52XdVWod+x+Gn8nybzEZ4cHN+J/xLvQ58B5JH?=
 =?us-ascii?Q?woJ3xxkS7lrcbGvHb3uJdLSHyqOucjZ0f6w7DBX2a612uDLgTEJxAIOTVdNo?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4945d52-3b49-48fa-3a85-08dc34a575aa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 19:27:22.9743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tEeavq0ocEnyhQcvYDECXfrUax80HQX5z7KopjkhAFp5LL1iq9S6wJT4Hcl/U7Eyr/xaSv4H0tET0jxlEhLaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6831

ethtool.py depends on yml files in a specific location of the linux kernel
tree. Using relative lookup for those files means that ethtool.py would
need to be run under tools/net/ynl/. Lookup needed yml files without
depending on the current working directory that ethtool.py is invoked from.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
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


