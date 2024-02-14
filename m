Return-Path: <linux-kernel+bounces-64785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053EE8542CF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3F81F27112
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D346811183;
	Wed, 14 Feb 2024 06:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="T2zHxicE"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2023.outbound.protection.outlook.com [40.92.46.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D99CC2FE;
	Wed, 14 Feb 2024 06:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892402; cv=fail; b=LLx+a+B2KZRfQcPx3XXEo9jFQMLsKFlrd+8TcdkYpX/nT6HD4yKheipaPBxtIy34hIrlMfiFMW/7TN6IDb/scRqRv8YkOexbI87eI7ATkAueaXQuIZbt5uyJZW8AykhOeMb3P0omVk2bi8QxB2qwN35ELpeRYAujm4dO54Irocg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892402; c=relaxed/simple;
	bh=7gByLar4nozAEupzI/HdxtiEX3j8GtUE1JYKV8NluAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TzsBuxqm/Kp1BairEz1dcEjXCOflfr1JW3m3Au/aoCG80GRQqqTV+DelLdso/7JSuZYOylvSHhUlzdccJv79+MnGaIrVUzA2ZuglRJv476+CX06FU1xly/4JEvIx9pslC0OvBQG7/uO+Xd+Ix2QAUA2W4BMnqbukskePhfU/PhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=T2zHxicE; arc=fail smtp.client-ip=40.92.46.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4IG1Px7SH1ICLdADVGq8H2xMuIi974hyv6BdsSvLeJyazCWihUC0/vmSfwhi/J8VgdB7p7XFjawIn9ky+JjD0kBT5WaRHSP09shfX76rNoD21y07csol1XBX89RLTV9S35RwBk2y1ATvOUoNgzJT0y4S8x6Dld/giNaOHEYE2Jm1v29gZY7Yy7RqJFHwdZXqhsyyoNYDDEUpWyTgM/03ImowGSFwqrntdStjF6bTdNmvRO3KMERlPz0xk6PtOa576dAfj73+oAMdsCu29/I7VLgw+6Bm8kAwUKQyfLyvN3dZE1NmK+VlisbSCAE6nrQwyuHT8H3WrJ4Uwta/XyXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFKGkLHmQsQ36AYIhbDW0HsveA4Tcr9QY54Mgck8DnU=;
 b=dNj0hmdfw3EU3CanHDdoGRVNpWmYMSYHwW1YkgxEgGDksdgnHfNejfoouM1RrUyOU5k1EYirXVZsYhHKqUVMeaBU5x3EM+Wy6HFNNcnp85zp5YkDXE4Vm4320jGHQBM299Axky40voG75NrdPRJ7haW28PtPxwqVKZxn6TBQa8ZPzdE/Vtnv03X3k7Za5xfKn23CEQmtwtY8e5jyJWB2xt0MmhPk87f7OYEZVCUXRH+oe+edjXVdSjBJa1VxrHSjN8/ZmfCg+Ml56URZqCc9wGfpI/XIokMrx9l/FkO9NGh1q06ipn2G4Qhf6VQ5cwCZneNx50sZE35+Q5h1EjdkNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFKGkLHmQsQ36AYIhbDW0HsveA4Tcr9QY54Mgck8DnU=;
 b=T2zHxicECUZX7AZ7QeA8OrbqYujjv22YFt7Ogd27wm6Mc4kEep4IZ0sDf/tiB7rBkfM/Rx8ksEOFtQIGpA5hKTIF5mr/l1ozJDRHz5X6zQNdEg9ojux8hQbl81L3zB72MNsDHoZ+Zrlp2GFkEof+u//0Fvvrcd7gTiMusXQG2DBzzIsRxLYWRQ2/IxfduHaPgWTgl7oHMn5P3+IWvf6NMEClKTVcQFyEiuqRsjzUD3isugGWmP2kvnEe54LwR2yEIqDXx3z8BSiHX55JX+xGtchBQElKlw/WdXl4hOXhFzyaWwti8Z/aN5QfQEbhYYs0bj6o+A+ypoiQyJKJk9cdPg==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by DM4PR20MB5063.namprd20.prod.outlook.com (2603:10b6:8:8c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 06:33:18 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff%6]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 06:33:18 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v3 1/2] dt-bindings: clock: sophgo: Add top misc controller of CV18XX/SG200X series SoC
Date: Wed, 14 Feb 2024 14:33:14 +0800
Message-ID:
 <PH7PR20MB4962FFFB586489154B1403D6BB4E2@PH7PR20MB4962.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <PH7PR20MB4962F822A64CB127911978AABB4E2@PH7PR20MB4962.namprd20.prod.outlook.com>
References: <PH7PR20MB4962F822A64CB127911978AABB4E2@PH7PR20MB4962.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [8qV+7nW4eUMheqWvmiuFgpPqdzNff9G/VBA3Znb5vq8ts9zKBeSpADPFh2s22jQt]
X-ClientProxiedBy: TYCP286CA0063.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::12) To PH7PR20MB4962.namprd20.prod.outlook.com
 (2603:10b6:510:1fa::6)
X-Microsoft-Original-Message-ID:
 <20240214063316.435254-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|DM4PR20MB5063:EE_
X-MS-Office365-Filtering-Correlation-Id: 06cd7927-64f4-46b2-3401-08dc2d26d4d2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pF1CPjZnbekDjiJ2hdc1WQIkUAMU0rXw/sGyitnzVwV2wFNm36cGQ1Aj56gkWha4yk2I0WxaIGmNM5myp07TJnMOLrvz0TVCJbXtzKuQbzheIxfUHOBIiejTUBrbyC+GUU2KURvlse0eJnYwfP659tjA0X6ZPZzxB0825MdwoTSOqQ+ip+Jju04UVYEJpq1KVjbhWlZLziRZi7hlE/rrnpRo+RKxxZSXFoe7u+s1Zphef2d1kIw0K/ENHCEaKOAfbKuo7yHqomfS4yVA+RplTlZ0HrRSfx73mnsLukIPMnUyMph9SZd9xBQjlhRPhYTw+ySjV4o7KGf1L/pAByTS+N/jEhGzkJtkbl2WOnPNSpbhhAUeIH7kGzVKjEYRDj9vXvbkXO9jFokhL7MQPpRrpchKuHIVyPDH802GzPHuPD8GuIzpQZdOkHrwQwtc8O/NV+6SEzQKUkNUS5GqxxLhU6+5pnGEs3VbybHskioX/MEnTF75vLLQHuaJCrtGTpSb/CE18IPjI+SKemcMvItMHKN7aG6y4NlXwi0NGNB16VnL61uWbgeuhc8wG/SvnlNnzgdchRMd0FJ1iH/B+uCqruhFjk60+RmcgS24cmZijTVnI9AokqZ+2Gm3SeBiVyPULzOSWtDHDz7fiFIxiqO4+ymXaZjlzaNhOfM+on4T9cw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v3Uwx7mws1E4s5yzzxtDYqA/lPeRTrgDzRr30dyIc4mDRQ7769/sgiTJ0Z68?=
 =?us-ascii?Q?XFwWDvPBjum7YaeVwhz3xJgiUdRkPgsyVLd82p1m9TGIx9mYHTuhrLf7R4aF?=
 =?us-ascii?Q?/eD1EWWWul0ykpZ282U8wEP6pCyBVNd1r0bP0vD6CbwPXEUnQkvIfl+AoSFe?=
 =?us-ascii?Q?wlZgdbdVcFRJId5MSBlfklZqUWm8w4zrSx6ITXfzG9Ktl4MDSc06dGZx2xeF?=
 =?us-ascii?Q?yk5aiD8lBitG9fy8Ajlfyt1PE7DUtVhZu2kjxAsn5Rq4s5aMlAeiAmX4HQwV?=
 =?us-ascii?Q?iY4EDLp3Zev27uHc58/JkOJDAnqEgSYUY4rYiRU4qkvOJjq4JAejIquZVHRI?=
 =?us-ascii?Q?j6nXoR6AA7DxSfQh+UmKz87U4O7GkwFivopkZAmsNoolIEfXyhh4PvpV9iJa?=
 =?us-ascii?Q?5HPcz1vKU3kUeMTGbgqmUcI0Po05wU1c0NUmJdxPjN4wCJ2D0YWJr0Uo62nm?=
 =?us-ascii?Q?aWiiYotPhrZp0nPNa3ES0uCuLcse+NPmW8QGpe9TIYUk09czNu1Y7o/iOYT5?=
 =?us-ascii?Q?DNaYZHEAtNNHVl2sY4/fuYiaxSj53DvhVBu0/4eM9qCrjqIZYkOHuLtsmOpJ?=
 =?us-ascii?Q?saXot/+rHgik54xWWZNa0kDXTyfZKwC+U3UJWEGepW84RFqZC14W7OYhT4xQ?=
 =?us-ascii?Q?2+uI0ZG5CU+crVlAnN7u42T1xh3sczH9kxcyHD0kmdN4GyyObUC66P5DP/Wl?=
 =?us-ascii?Q?Ae1JPJrUn9eqJwn4PeqpgKbCzybLSwkyKYHeF0M05pXSbcVQgtZKcgx5rUg7?=
 =?us-ascii?Q?joXXIstP+Y3O1ORvQeu7UPA6JiHXiIjKxYX3K1sLzm9MdC0xVscm/nVl/E5V?=
 =?us-ascii?Q?eK4Ks3fAAxC4qMRVyiT+2rPuMUTaCu5PfRYjHD1irjC24ys0C3tAbz44Yv2Q?=
 =?us-ascii?Q?sjMfg8XBF1sQr3I652Y8vtmlM0Ok8tdQK0K/vH6swqy5G6Q5zmyChjGLMF9H?=
 =?us-ascii?Q?SDbqtgt6bv2OzVN0YElplla94+mzbehROOEO4uFzVEiGvo1yiCY1AnJqseD1?=
 =?us-ascii?Q?vivZcFf4EjZyS2cGKFsJQugtWD9vMMksVBj9vkQVVRWNQvGlqBOEGtcwHHN/?=
 =?us-ascii?Q?egRspQStkdHUN/q5CEIRwXDJ/I4Z+fvTCcpjht/twwDKXPvXn3j8itaDISiM?=
 =?us-ascii?Q?UmwU5y4coChpDjHz4uFmll7hdXGQ7ZvrKeDtHQYEL/exG9o5icReJWG7jQUc?=
 =?us-ascii?Q?Vc4G6tfO/SfZusmi8UKIUoD1JJUDSNNl3c2Kwvz/y/vq7KJd+xAZgK2nHWub?=
 =?us-ascii?Q?eDz6HmOcgu9SWnCIs7kg+N3eiD0bXwYsywHf/WDVV7pvMBMDAExhj0ZTDTm9?=
 =?us-ascii?Q?zK8=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cd7927-64f4-46b2-3401-08dc2d26d4d2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB4962.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 06:33:18.4649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR20MB5063

CV18XX/SG200X series SoCs have a special top misc system controller,
which provides register access for several devices. In addition to
register access, this system controller also contains some subdevices
(such as dmamux).

Add bindings for top misc controller of CV18XX/SG200X series SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 .../soc/sophgo/sophgo,cv1800-top-syscon.yaml  | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml

diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
new file mode 100644
index 000000000000..619237532801
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/sophgo/sophgo,cv1800-top-syscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV1800/SG2000 SoC top system controller
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+description:
+  The Sophgo CV1800/SG2000 SoC top misc system controller provides
+  register access to configure related modules.
+
+properties:
+  compatible:
+    items:
+      - const: sophgo,cv1800-top-syscon
+      - const: syscon
+      - const: simple-mfd
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
+    syscon@3000000 {
+      compatible = "sophgo,cv1800-top-syscon",
+             "syscon", "simple-mfd";
+      reg = <0x03000000 0x1000>;
+    };
+
+...
--
2.43.1


