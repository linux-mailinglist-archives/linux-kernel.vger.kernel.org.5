Return-Path: <linux-kernel+bounces-98746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DC1877EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE8F282814
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F163C466;
	Mon, 11 Mar 2024 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="OvwtgE/M"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2100.outbound.protection.outlook.com [40.107.243.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350333BBC6;
	Mon, 11 Mar 2024 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710155670; cv=fail; b=hqTmWHw9U4EeuiwAuad9PV9IPMblOJn/Co0dszaOJKM7L+lIiU8YPT6fiWM/PDD8G7+YHfVwhsU64v7dJ2+0TmdNDHq1jaZAi0YJ1ZJ+EOiMvPNkSXNnW0fOEj9rgYUoT3z1wubmxw3kZPAN8GOyckRMNooNLhH+zhdWOHx4auA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710155670; c=relaxed/simple;
	bh=faaavqscr1fgG5mFidAvXhWsAJWxAtFoya+ykLN7Wzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X59bNQ0XJNr1wy6YN+RjImxXUovHWrB2P+DhvjFNdlFLTYRLDLXdrvrnLkauwwlXYgapJU1/CCqaiRONH7snorJtF05GX2Rx8FPlFs8Jrl8GFuUjmcL8yzVuzFYXnC+WntxrGYaphXaQpxBhVzIWI7v+mIUDO4m/dkWK1yYL93c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=OvwtgE/M; arc=fail smtp.client-ip=40.107.243.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BneLm+wef8vK74nG51chf2E+OKdWDnWDE76cbwXtc5MzFBzMHb3XNaerN4KrK3FKGIMqguOwC0ejKpmzPwPW6E6tbkuei70Ay9kIqM/dSobRmQP0ZO0T7UEWQsfeUWE5I9lJae8jfrDTfvybNr4cBcSlhCkfeY9znMfdrtB6khPfq9qRdlWERmrMVPipTrhubbc22g5K6XTayWUSK7U09glzat1q+5ssMGDiY8s/dz3qjtDyLHacJ1d3PBWb1xXAus+TXgkgqcSixvJRMHJL8+p2jQ1zhypwK+0ZcBSlgqN6rotDG12k+ZJG/Id4dG8eniMTTcf3laYCXjJrv6rneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FirjTn8dY8PjxAROg4A9v8RInwdhTHfi2xbUjP6DnJY=;
 b=e39rCKqigtLBcwo4ECoa0a2hzEI+oU7B+wReGHXHpRGngYHxY1SGiHu5BY6BgUBt7nSlzAJUcuCrwgAempbIBfUDrDycUqk/3/CbT2Lt1p8hOfU5J0y80xJkauskNWH2whiszwAzCmXAprQW/jK90ww7QAGMhxt0Hxx4F/zlPVqVSp9B83CyYzjVWTIKDXXpd5/GVAxwVJ5C5EoV44jNkrdJ4KdDOxXjwxbfRVvPU+rfYXp9Z1DXiduwf490L7D08W8DgaRS1cPvxJvggMf0y/DI1zeIebzW5qpAkucfS+CQ78LfclXAq4td0fQ9Wx/sQ3zsxnKEEw0awo/u431Lpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FirjTn8dY8PjxAROg4A9v8RInwdhTHfi2xbUjP6DnJY=;
 b=OvwtgE/Mb6xDimIoe7ddNwOMP2I2jCsQBSYV2Y5PaqDBxoNYC6Yxp8MIJffZ0LG6moWWnkQ+HjrR5fh4/Z6F9TmlZ9FG594PEmIIO4lG/s4MxyLRuFBVoddMCzS4hW4Bxasl/bLcYq7IwExb5d8OoVFH1G0je82Z7pvVoGMxX40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB5947.prod.exchangelabs.com (2603:10b6:5:1dd::12) by
 CO1PR01MB6741.prod.exchangelabs.com (2603:10b6:303:f2::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.35; Mon, 11 Mar 2024 11:14:26 +0000
Received: from DM6PR01MB5947.prod.exchangelabs.com
 ([fe80::b557:13cd:8a29:ae08]) by DM6PR01MB5947.prod.exchangelabs.com
 ([fe80::b557:13cd:8a29:ae08%4]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 11:14:26 +0000
From: Chanh Nguyen <chanh@os.amperecomputing.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Justin Ledford <justinledford@google.com>,
	devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Open Source Submission <patches@amperecomputing.com>
Cc: Phong Vo <phong@os.amperecomputing.com>,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Chanh Nguyen <chanh@os.amperecomputing.com>
Subject: [PATCH 1/3] dt-bindings: hwmon: Add maxim max31790 driver bindings
Date: Mon, 11 Mar 2024 18:13:45 +0700
Message-Id: <20240311111347.23067-2-chanh@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240311111347.23067-1-chanh@os.amperecomputing.com>
References: <20240311111347.23067-1-chanh@os.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0088.apcprd02.prod.outlook.com
 (2603:1096:4:90::28) To DM6PR01MB5947.prod.exchangelabs.com
 (2603:10b6:5:1dd::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5947:EE_|CO1PR01MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c041234-c797-45d5-96fa-08dc41bc692e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8Y/N164mImCWHocFWR/QBQpZgCRvH8DaJAy3ZxmVEZ8k+XwjXVTBHpZVlkQ6/v3TDuQLvpu3q/ZHGGFVXXa1/2aEbu91jQHhA5viAIpDP/d58w90TNgILR6KqKN0g2ikxD2Zfb9koGOe2ln+h2iNh2DYtC2kidKRlX3pCy7Eb6zWrNjqKlQT9Zl5K1WJ52X10ODr3f+6j+aH/gzA5Cx9/wliCd82klF6WfW0tyv2AVdq+Qu210/OFUvK3UZvozlqHv8+/8qdrNvRutHl2EoA/u8l6ED6H0gXvdEyhLvWoAwl47m+MsFTnq0jhGc5vhy0afDtycgoJ4FiFGQpUhqK41qDs91eiypuvNGSXMuk895GtC4Y9SC6+Is7LMbxIkVBYTY3SvRbF6nhRsOsK8bs+04VISI6soE97xRRVp+XHFkwmNH9ysOz50LZiRScVBq015hYdzlse/z5SHQ5XiYbXZazsoCl7BO9ZW7SITfiz1XVZkRXCPcDuH7eSV0v3TqcaL1s91KgX3+ciOqn0RYUanf5F3YVVoZbPfEsvCXVYkrqlR0a/dKeWTHBT+xBKiMrUEePtM9XWEx/DBUhl/UAifOzgHuxGw7/Ho0iayD76iXq49/eZgawDwW+AhzokMBAFfRNM9odE5y7nno1bmM5uANqwZZmNdhrMwaf4sFfqqso8u1XzdkidFr/7Dny57d/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5947.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C0FX+aaCqNGVfjDJd/tq7Tw/hR+EOpcIPZE0cAk4m4H5yPdOAJG4qpNOBzC2?=
 =?us-ascii?Q?VakL5xvyaqXQMcC4E3lmcSnsUwE2SxOrh55jVHVePXGzpvr7SiVUonJHFq2d?=
 =?us-ascii?Q?TLyd74ao8ruZaJExi63E3sqEUzpvgKi626Cp80H3JKHp1BpgYAIo43LxOeZt?=
 =?us-ascii?Q?ef7X/z2dn18S2PTltoEDnWbs0BMYk3aC/WSnhLd5vIgR3v18jszgT8YRDs6P?=
 =?us-ascii?Q?lCss7Z7Ftcqz8SMJ1mjC8HZcRgNaxl+qu/8THWrcmZPC0KKkEEXMqZGx2ABC?=
 =?us-ascii?Q?AX3+y/4XjxVBO7ixMhjZ/EYwvFAVSTGtTSTSP5PHVYf+n+NBUsBJbgGtZ41Z?=
 =?us-ascii?Q?1Ksdb6c/MkMbplYORICG6rJvMv3UASGz0TiVvlgGcDIutol5ckOZbOGkmW2P?=
 =?us-ascii?Q?OX/qujuXYNI3J1vovaChkla8hWCZxNhBi0fs/3WxhbMVHyAHLjJWM3yGra9B?=
 =?us-ascii?Q?SibulL5UP2/z5K1sVWFfE5vWqwi236djRD9zCzRRpgLLv8NZstZx0dXOnST5?=
 =?us-ascii?Q?3NeZDvFI0v9hnsjoCUM11HVmQpxF00CL23/MgS3hDesVrHCq9G3VLGE+C1eJ?=
 =?us-ascii?Q?sqWoUW2TY4xMK8WLTcxSjfn17qTppwjsCPTnglan8H0a2xaBl5572qJ8DLEN?=
 =?us-ascii?Q?ygsYI3+uZZyPkyHmWI3yUFHBsZfkJkTpsf0kaCRpSXu5C2w90wSv3ffzImyf?=
 =?us-ascii?Q?H5ejtrwT9wdZw+oHdGhiSwWzEyxiw2gsK0L9eECFQ1rtRnavERrvhRIvOcA7?=
 =?us-ascii?Q?zG83JwOnbLjH9zfhEJVXeUnsOjy9T4hWw9qJUhOMj7mrrBAXqbKpNgv0kEp5?=
 =?us-ascii?Q?RwwhOJWsIL2z0eJwLdknU7M6cDnM5ty8vZET+ZIj2y4Vuele1lFYDiAOem7F?=
 =?us-ascii?Q?liwYKRoKfm01TbfUx9mPCfFN2QmbHvBm3oYzG+ZOGjx9gbp7YxSd/vnCgKLv?=
 =?us-ascii?Q?8Nd6z3a3nZKczJJe9cqZuyBmtIHABN6XMmRXkfeF5N7towPzMzOeJ+Xv5muW?=
 =?us-ascii?Q?0hQFCutqOLh0/L44Wm1Y2FFRyYfk54b7XwyR6s6rvxLuHxJc9wSNX+CWHFy2?=
 =?us-ascii?Q?QDAwHlO6yJ7IQJdEx1SRBO0uBThbjUZXkV/sprXb5uYn4DEcxjbZl28EnLce?=
 =?us-ascii?Q?mvrgyDGTWA77c2C/kA3ukAgmWighUS5665l3YeGbBPVLfGJVFOg51HHWW6vg?=
 =?us-ascii?Q?E2dL4Y44Yq4xWF7gkCpTvyiW0ed16OGcZDA6LXJlIq/Vt1CVXKEkQ81Nskdh?=
 =?us-ascii?Q?1CaxsAeY+lNwsZRR6H+lCRsrwoQ07f8BQzl+3yEQI1nkSmAV8W+XKZA8mkYs?=
 =?us-ascii?Q?V0qJ3H/m/yiAOIezdDmILSlG52QOg4NwwEWWdV/l1SoBnM/4tgvPudj5zOIl?=
 =?us-ascii?Q?TK4a58S6VMtv0fLuMXan2ZZs7sX/NVdfcN9X7bUt2w0+EM45W5k+Q7eIxTXt?=
 =?us-ascii?Q?7mCoaujGQ0J51AOFWA5HovAPGsfaKzGwjQuNJ0t+GB0uAs1HvLjzS98sjQSL?=
 =?us-ascii?Q?SQLq1F0X1Zj4/3WQtkcvxVwk0tZOO6disFeNRY/7egW66in2dg3E8ckPnd24?=
 =?us-ascii?Q?wsk7p6bE+snGoUP2lvh0iBZpBnAHoNJt5jSqHmLXNs3L8uc/wPdUh2nqLzsu?=
 =?us-ascii?Q?36CWRSQlk1VCP+jMnFopb34=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c041234-c797-45d5-96fa-08dc41bc692e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5947.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 11:14:25.9225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KdKuFf14c3H6rUGmnr5P3KbCAWVUUL9B2PczPF7VqpR4UWN0BzkJrl7PoDTTIqrcuL3p/Gq/PKUAB7ZgZIryk6ECUbpdGKBDNebsywxTsTkGBjm9jZ8t/PRoBQFu/Pc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6741

Add a device tree bindings for max31790 device.

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
 .../devicetree/bindings/hwmon/max31790.yaml   | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/max31790.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/max31790.yaml b/Documentation/devicetree/bindings/hwmon/max31790.yaml
new file mode 100644
index 000000000000..5a93e6bdebda
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/max31790.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/max31790.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: The Maxim MAX31790 Fan Controller
+
+maintainers:
+  - Jean Delvare <jdelvare@suse.com>
+  - Guenter Roeck <linux@roeck-us.net>
+
+description: >
+  The MAX31790 controls the speeds of up to six fans using six
+  independent PWM outputs. The desired fan speeds (or PWM duty cycles)
+  are written through the I2C interface.
+
+  Datasheets:
+    https://datasheets.maximintegrated.com/en/ds/MAX31790.pdf
+
+properties:
+  compatible:
+    const: maxim,max31790
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      max31790@20 {
+        compatible = "maxim,max31790";
+        reg = <0x20>;
+      };
+    };
-- 
2.17.1


