Return-Path: <linux-kernel+bounces-162186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAF08B575B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39E82833A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C0238396;
	Mon, 29 Apr 2024 12:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gqv37RT5"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2075.outbound.protection.outlook.com [40.92.41.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DDB52F9A;
	Mon, 29 Apr 2024 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392181; cv=fail; b=hOHrWt4/YTSM4X9724DTymJWKLiSwsW/bX/U2pd7Rcna8S4XIgfISP3m8oAM3Z68IKbaScP5Wnf0faehd53XFpQvOQXnJ4mSkvja2IDIJnyR7wtpPrN34FMM0B8UbjkU2BKQ155c94RUUgLwvGZTccx0+1/2VZjyruK0QM/vgGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392181; c=relaxed/simple;
	bh=uC4YX4zRqmDrhc1mnb+SrL7/8EF0ITuGxaNr+mG8hv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U0gdC8yMP7R/bsBwMLc9FVP8JWfP9TUd/sCr05JpdGFUykVZnXhzDSRivn7akVUFSpA7jxyUldI6a6w+r3enq/dlp1SpByxiQbhZmQyBOwvMcmwvu95wfg2W8bGZIaRKeDHbH8TvBb60rjaAJVlpUWqudkOf/RsziydPLGBgDiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gqv37RT5; arc=fail smtp.client-ip=40.92.41.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ta6Nc+WGgTHiMfgcmWyt+jFh/gAejnsAidYEHKrQklR7m8YL9phrkuH1kqI/6yn4i/8YEL+LYM0/6FbRjQ1GvUi+4ZQIdSJN609UDSNmqmDGnnsOSFisr4/oiYIRfRbRcDGhSVXZV6t/x49rPEx+AvbvJ+I1GuS9/S4zuD7JCik0zrbCW3Fs5ZbL2UBffoXUUU/LX+xucbET1Wd2GJZz6dSR2XSOhqT8g6UZ2X80Reu5qgdo6FGdzgYsI6lfQLRyw8206TpBvjjuZMVw6GXiMX5ZnR1dmiUuCiHqoPpZk8jhcjYfW2stbR9ZmO1PKIgNZ5BNrLmnUs5e0sKzEJFBcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AJR09LijUvUETEouDVcTeBTTX166sP/0i9SmQ0HjcE=;
 b=I2t9vkUTXYAqnD+LUhwXA0MVvb+QmXUF3TiariJDgzoNhbIdaiK4TsUrJF5euqqneBYiVGO3OJxaw3q20G2uTJioBLYjR3W7qZSrGCCjvys5r9/Z365AEL6C1qDo7lRGaBvSqfF4YMNgC34g9hyn0950WIMbcO2Fh9Ufy4lX5bCs8dy5sDx2lL4PYcG2tSXQ8x9bu45gEds826VudM7aUR91MVcZKbZFKdOIB7tVONjhFkkwo0XZACYMWvSUSW7OsxMb6+EQE1g7dsUeOVA0OgseBpitdAcpbFhID9d2RQxSGbZWu4sMj+agCCwPT69ysg5DAa8fWx6ksrUTlhFiiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AJR09LijUvUETEouDVcTeBTTX166sP/0i9SmQ0HjcE=;
 b=gqv37RT5TcQYJDgdS0I8uBDr+19s/osTJ9mYo2L5qAPeSXu6K7bdIUn1ppc24sJz692dQDEj68IjYT5LGzGtNi70TpjtzMkXJLxy6/0IHTIk071jfeIoAO9+SJiuRe9DZw821Lo/6UVTlk2DbmB3BImwHfUPHhzGF4oP9JSaEgMvOiPEH+W1UewN7NRUHFlIGIvi5yTaor1Cw2y9kqzPhk6nQmT64QZDuo2kX8cB7Mx/d/56/YiGoCQ90fpyh6nIv37uRRTmYQQTT18pCnjIs1h4XO36Ei8TQA00ncmblb/dr9HsWT/07BBzPq3B7Bdi2D1U8zm0+ekXBXU0+2Bvng==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by BL3PR20MB4970.namprd20.prod.outlook.com (2603:10b6:208:3b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 12:02:56 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 12:02:55 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v3 1/2] dt-bindings: hwmon: Add Sophgo SG2042 external hardware monitor support
Date: Mon, 29 Apr 2024 20:03:24 +0800
Message-ID:
 <IA1PR20MB4953EF54DBF6D5681C27014BBB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB4953D1C509CC7F23620CCA01BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953D1C509CC7F23620CCA01BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [9V44dS7utp4xySV2uYKXctrM812D24fIM6xrmhsduDc=]
X-ClientProxiedBy: SG2PR01CA0163.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::19) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240429120326.860160-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|BL3PR20MB4970:EE_
X-MS-Office365-Filtering-Correlation-Id: 197a3882-771e-453e-961b-08dc68444db9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	FG9weq/+WA1B3tedQfz0rN1VUlXjjMQotldDZ+w2VGSWqirTnundibNo5x9rmBNZxkMLA2Ul+FU/FTBMkNQFFn8fwxF7E0Agjcd1u2I9Dj84aIUu/BEL0O/ILR3wJLjutamRKw5ZtCH0T5y+ev14eTFCuxqixHLY+2VY0EPor1JyMQUUafPG7iMSkXpinXrC5wLx58ThPB0Sekl7ML18ThbqSE/iGDq2I8aTvbwgYKu0uPN0zdPjoN1XMAFl5WcSooqPcux/6WHZtORsppaNqYww19W5pzZmGBkbSTVODsatSl6lVaMgEKcBNS7iy1hcLe/HcRTFa9rBpPhB/8EyayT7m+M+4IU03j25+5jZroikDfqrslNnu5IFLqlkFjACilFoCwF4AY8Xvc5MLSsdKr9/aHLECnhOj6hh8uF3FfApxb9trfKm289GNT8Z3lrYBbuV5dGRV47vVPHPdY5HowZSxIVZcok/6vHK+vB1hxVmo5a4niYJGlQ0PMQQURtUNj0NIYOlXYDTiA9tE5Df6OdoqRLyQdlkE5XSaIZCwf2ud2iVJT6GIH7HE2eqQbHH/hdYejqLDKP9iNCBc4RpojUX4UumeJqWkLFNF0ZuWYanajW+VsLoodNIACF0BcOFC51uc1ISmHmWAue/+N61+No1mUlFj4TamlMgQr6j3XsX2CZl3LQsDHi9kz6IM0PQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zFAMh6MPpGzuiQqsPjCG/voaIAmg8I/DuuzrDis6RRYfdz0mRC/nWhMXBuBg?=
 =?us-ascii?Q?XyRDzIsq5X4GAUu+mf95A0khhbCGxU6sqoVtrD0BIzHp/0TJwYU7ys18L+/2?=
 =?us-ascii?Q?fgrTMKkgA/kDLyPGyIP/GG6LBSn5Ol8FeNI8tfgUUVnlMjTvnr+j+4NU8N/I?=
 =?us-ascii?Q?Z8kESQ44zuYyNAhUq4Xd6ju26+ElA58UqLBafozo2BLqgwplPrtU5hvNGdjZ?=
 =?us-ascii?Q?1Xs4Kcb5NUnTuPxaWgczlpr/1PWMDuFGsrLba0MfNtkRJ1d4Bq1wU6tcWHrk?=
 =?us-ascii?Q?Cm8xEmh7dQOC1Fm4DytVrVvQFHwtGLa1H/m8uFOGml/Ef1BSJjXGnBQcmQpg?=
 =?us-ascii?Q?1uoMneQ8KGeYmHsQh5uTs+uGJfseLyX1v4TJN3rGXwmMKnA85wuNvl0oakWG?=
 =?us-ascii?Q?M9Db++AqWLGaf0Ij+TXEyw7PyHAY9bl97oTit59Uk2xo7w6FKpXJUPpZynGm?=
 =?us-ascii?Q?GVaLwbxx+OHV6MkteKZt4IfMopONUrI504UjA75TXwO/gGcRBwz4lUcVTsfV?=
 =?us-ascii?Q?NdZeCSg+A3of/8rs1ddTb4ByTlRWzH7RShSlHzqVLtFVxLhPqV20ZW2bsfyo?=
 =?us-ascii?Q?gdWL/ND4oOF1ZkNuVcp7C7JPku9GgIdHaGQS1Qkf7qZ8TiHA5XUBLY7xV5v5?=
 =?us-ascii?Q?0KVDX3W4xUP1jU6fFMwMZSFzEMEMpefsCfJ0DHDPi6kRrslmAMVpb5Yxk7jG?=
 =?us-ascii?Q?UwUcjaq5ezRVTLJUN3DClqXkF5mfmDPiOsdXbU34MTHNdjI6D4ggEpKYTsEr?=
 =?us-ascii?Q?LWK6K6eeAlgSasoPNUMp4nUhzCp2BnlBMHMM0JPa/OiT7KqkKeGgod8OMEyo?=
 =?us-ascii?Q?YQmafcQV20xUJrwQGuRND0fNCuMLsCbS0z2lDFckv7IF+JDZXve5+QyRBI6O?=
 =?us-ascii?Q?ALNwRyqBXu1cDin/e7yEku/oeM19p/ehZ2SwTjqAuMgB7hCEUd8PwWOMX5yh?=
 =?us-ascii?Q?HGbPpO0AghwRtk248IGk/gjzjdCvlk/2otKx86IRRJYhP5lCT0pcVsN+h3Ro?=
 =?us-ascii?Q?5dOsh7gTgZnVsVnCHhB0vwkQzwkeMwkok54gzJXMxlHJ28AV2qb5Yxoi5Uj1?=
 =?us-ascii?Q?X4ysB/GTvhHXwVwqWFsqrjwcSOIeaQpBhqWHLwo5yhAqWqXxK7K0px+mslJg?=
 =?us-ascii?Q?Ofe67q7LLFXBbVgxFd9of6To8vGC5N+Phve8/F+6l6vJCrbCsSRAg4JfPt0f?=
 =?us-ascii?Q?dcl48zzn7b6LY6oOysYryaR1TGwVSjrG3EFf+C2mNVl2AkxFmJqyA5Mx9a/T?=
 =?us-ascii?Q?Xk8zmc6iLTww6L4Xfj/M?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 197a3882-771e-453e-961b-08dc68444db9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 12:02:55.2719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR20MB4970

Due to the design, Sophgo SG2042 use an external MCU to provide
hardware information, thermal information and reset control.

Add bindings for this monitor device.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 .../hwmon/sophgo,sg2042-hwmon-mcu.yaml        | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml b/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
new file mode 100644
index 000000000000..64a8403aaab8
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/sophgo,sg2042-hwmon-mcu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 onboard MCU support
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+properties:
+  compatible:
+    const: sophgo,sg2042-hwmon-mcu
+
+  reg:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#thermal-sensor-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        syscon@17 {
+            compatible = "sophgo,sg2042-hwmon-mcu";
+            reg = <0x17>;
+            #thermal-sensor-cells = <1>;
+        };
+    };
--
2.44.0


