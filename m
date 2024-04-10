Return-Path: <linux-kernel+bounces-139214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B8889FFF3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04402B2274A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF15159574;
	Wed, 10 Apr 2024 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="jB8+wCc5"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2034.outbound.protection.outlook.com [40.92.22.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724DB38C;
	Wed, 10 Apr 2024 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712774524; cv=fail; b=PnEc5ZCljlYNazSvTBfZVlLZ/F29UJ/xbS/HR+l31PcyUq1h6eOaGv5mGbgKg89hn+aZ3K1f+4zTbYIbJFbn9wweXI5yGYnHFWsMSpRgRP190qYV38i6LHGdVsaBhrTy7AGf4qThBaOHtbK4kYAieaef3vBjNjTIW8OjO4wViQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712774524; c=relaxed/simple;
	bh=HAbeLXMkX3+4HWx72imWBtkMMrXsz5QGFsmD2dbdem4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EDACnTKcl30tDmJ0zQT0YINDtuDoTtndVV9E+Mb0aenyAHz+62vcpMbAIN3N8+vnThjvg2RevRyijP7vXnCb5mEaBNf0nr9TYrQrvUqGo23T21XSaOXR5/wJyfq7bodbHBacmdqU/Rn50o7jJR7J9VnjY6wKn4jDpOG8J6o8t40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=jB8+wCc5; arc=fail smtp.client-ip=40.92.22.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGCR/NrGrHo5k3HDrsdRmjWq2m3FrNbsKdC8F8T5DhMnUzdbrhbPHIb/XCGU0Wx5n6OiE+zg5L6gPCbyWla0fd5TEl/efh5fpvEpGvKy43dhHPqD7RVVAUlZf6ugilNMGJaRAUBBmlrkH7PUNWgdP1xmoBopsuuEsD/Vr27uTE9Zsi/9iXbPm1vClEV8FMBRN9yfGjOy8/bf3r1m440LmdfQ8Fc8CwFrohYPaBSa3jSJWFuz/NQ2oxfPW3E39XyIOJstnmgCJeM/ODQeD1P/YDFOVqpwHvu50yri4QevX8pCt+4nnwyrb6HiK4B0uU7LLag5A+Dn5X05nLZLBKGMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EM3KnVoF9WUB5POV8hQrO/3X5SbXhx5IYhJGcSM+hTE=;
 b=naceJRUH18h/eZNLG6XN5zirdiXy8U9hFT0aRolg0/Dh7ZVtUX6NjSdMViRBMFOLuPJsCHBYb5tZuR+HrHBvvVjuBcydh2GfV5fbfw6fyTZO7NxEZob4lmZ8Wy4LAeMk7akZrXwi8ISzt0vWkB7jMlYbwwydmOrfwtTh/VOT51QhXLD6lO8yA6mkm69hTFlef0Ku9D1elsyCdZKnZGTCDtD/fy2ZwLn9gSova2wKEx9cFXO7r/a+3x2WiyfL56taN4wTHtFaP0ibX0pGT0QpnBCw/Sywlq5uwEe8LStywPTz50Gtc+tJcRHF5dmMLzeKyERGbM7IY7c/wOp8q3obVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EM3KnVoF9WUB5POV8hQrO/3X5SbXhx5IYhJGcSM+hTE=;
 b=jB8+wCc5MWgyA19NtI6DGIejkBTbnHqdCh0/npA0uizsMRrFmPlBTHh+oHoZYu5UyXKmAk+DxuRdq7lSn3TcWdi51fE3XhgYCUFkGbaCVcIbhI4L2y8gOgO4qd0Hy6WzPVF4S8V6RuL7URINUqdV9txuJi9nv8xKGT3kxkCrAL3sRM6F3ImErtRgmTKTYT/w0h5i7BNBcJM7agTirgEebPJx4U14dPc7YjBtgtoFJvpsZU+j4nN/gnpWBSzYBpNAX/lOIW/JjIPk7X7woWymOE/dLIeOciVYQdiQz+MEzdf2u5ZyxLZwEaY7URmuhAU4qVjrVHeBJzwuqIqiqCSamA==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by SJ2P220MB1885.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:58f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 18:42:00 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05%7]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 18:42:00 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next 1/1] dt-bindings: ptp: Add device tree binding for IDT FemtoClock
Date: Wed, 10 Apr 2024 14:41:47 -0400
Message-ID:
 <LV3P220MB1202BACF71E85F949FC09A29A0062@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [9LZ6inDMdX0qLuTgKpk317BetMqb755g]
X-ClientProxiedBy: YQBP288CA0013.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::9) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240410184147.13754-1-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|SJ2P220MB1885:EE_
X-MS-Office365-Filtering-Correlation-Id: 321bd6e6-f8cf-4623-b819-08dc598de7ea
X-MS-Exchange-SLBlob-MailProps:
	Om8TgR6f4EDVTZ10Twz0uhXXzrVM1yK2/ToeeANZlvpx2MsF6MwSb9IJ+O8bjDnp7/fN5jOSRY8dDKiBm1Vb1uzNaLrpOiqXywSa/EFrxlBjlXBQRNcEmv/+SMbJHUqJ5K1e9BZKCPE1Du8sw2CDMnL15scTwtvTcZue9Xc/SiEdmrhjJQyW4lTVh5kvm4vwsKj3HGnLdOE5STpB/Zvf98rBHvyP/Zn93MlWAF0w73jzLOGiUtoO8LIYZo2CgyY9mtNQ9DFBsnUr0PpRK1mvk5N5zPUsf8R4zLepXTRnQBBbaHyfJQwlm/bMqUvCbf2Wd5UXCniLi+gZUbfqhxB4mnuiA/2Uqk0ohekGBkev9F7F6KXvlAjHcgB4kflN/ix0eOOunil32/8R0bN8LneOAKlEq9xToS5OkMkWJDnc6c9X5YZslw3ks7KAzDrJNL2T1+CqSZAYsNMNHeh/s5rXpl/AGkyoyw8JSra7dhnYyMczAhvsZ7MBxovZZoaziwaEjFDbW1Y3Ve1lKj5Fk3tRQlom9YmZ6Fa7BIK1sOR2VHj3W3tv6J3saTUrYkuomCDJwFhqVuiLuQon0Ly/JaGPyGRaOemK047Dhme1eavOvXZe12c/24sa5qeufp/0Qv8j22jQB6QqrpJ/yFoGDMyvKvcMseRh36b8/Hk08rgAK16yPgUiTsrccH8ju7764dYSItFjiwqxfLM3JJNuXoFeCXEYjKUqayG4qGuTxjgGOI2BrJVdoyaHBcIuTi5ORzMjRv53Y9nE3vyEPJaTMQwZGxMmLMgZMLAKUe0kt0dw7hw6XfaTXEz3Yx5ukxK6m8fLB13UgOzBPFwS2AqMFu+I+Xeyw6rB+XMw
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TLBntaTEcgbIVqTez2kge8rCeq9UGw/Km6IR9rQZtRzw9NRUvTgSaYr0cR7tdx1qiNygog9hWXHiCmypUncXsZm2jKDz6zkm2rtOheoZMO7PRkW/stJ1rQbhKllePpSKUQLEUlmlaUOkdJnm+VJFIQSDGtfOMvyq2IiVIYt7/1riaA+vHgC8Ri3ILMwr8SEXlN6FqrA5Qk8TUKF30qmrlErSwKwYWD2Na1dxX15yATWbO5quh5Oje4nrkDVD8NKvL1HbfKgwh5ghDHVZ3SvWopxCAXfKXf6z6yuw3bl7N7jKUhn8tsPKZmCoIJaPgolxybvwbX0Ibpz1B8UChJUVhud5kF1BCg5zjanW8BSAb4vFUWE5DuSWE9CQFNpe/t6tQSRB7pDcypiFrEGInCbofR3eDHAKUOZO41RhXABfdh3QfxaZ1X70d+XgeMQ9IVIRyNUC35JIyEHwvkvGyx0rKCbhLbHsvkS8dMOh4qR6A8KBU50SRwniegJKUGVE2PsFzq5jKop+PtNPrTiLCQ90athSJVnrzAnhk+dwgOU++HbIi0EnS/NDZa7myiypfwQBiOmEiG9LOJbW4x/jwC3PCsxGtKFarSMWrRf73ZQTzx5j3B2EX8tacMgNJT6WM/om1HrzWyaFNjTQrXuNhCSLxMsjpC9cohFadpevQGAk6fU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g0PMpqG5klsnQBMJGk4zTyrEuM/S4zLdIfAvMyORPjSzHZ2MGLwj17aMLSf0?=
 =?us-ascii?Q?TdV1OprZiM1knUFJKj0DXAP/UcvYR79GJNFAgTNWZtsrVdbHalHVeY4cUgGJ?=
 =?us-ascii?Q?otJG/yH8f41ifWFU9yMPQYLKKQW9904m0H1jno8tAPZBqq0oeRi7nTjvFuJx?=
 =?us-ascii?Q?K2LIhk3rG1+B2yMfB4wqSnZMXiqwG9gHFmtlUTujatSmeAKTB2uV0VptX4QB?=
 =?us-ascii?Q?oMIQlC9WIp8RjFQDsdG4VBucV+Vxxc84AwIfJ+NOs4LrzT0IfqVcuwSrbufJ?=
 =?us-ascii?Q?DA1N5Uui2sd3ooG9HyrN4T3QWF0WX79rBWttwN51WBPp6LMiHSHkfW4SHJyW?=
 =?us-ascii?Q?0dkVKJD/MeFhAmS6tIZXULCBH4hMeCD4mwjJx9X3qyRW9tJ7efODhWfu5udB?=
 =?us-ascii?Q?WLztyFMNxx/q9hfjEWVpXkuhgo98nX+y3dNteoz3fjzELwLUn4tZT22XJ8Li?=
 =?us-ascii?Q?OP1CjQmAaLaFXHDOHr2vJqKRkwzvRO4I8ReI0o2cBUjp6XNgAWBp+7cnJBHt?=
 =?us-ascii?Q?mWxHC0aw2TLDj+sE/S0LSPQu9VC1iJG/MIg9291ZYLznp6QPMrmXiZqC18+G?=
 =?us-ascii?Q?dbAEQuE9MMTHj7zQeh2kTwl41VJILgjgE+2HdzZqTZxdzv4R0dpWKI1JpA8B?=
 =?us-ascii?Q?hY2kr4NkQv5mRE1np67X0lxbrqUSsuqJcLqjs17eEWEn12Lxrijts0uZyQvg?=
 =?us-ascii?Q?HJMiiOOSkZeApUoNlZmGXgB69jE3RDIfZivRN4TNUlW23TL2ayFwW6UmAGAw?=
 =?us-ascii?Q?6LoolJtNCIvrIOFJ/8dx4MGM0A7qYuhPFrx8o0FsafoNRj9GglP96YPkaKID?=
 =?us-ascii?Q?+Cslr3NFu4UgEAYcxsHm0+Y2zS4jSZjlz2itpScG1CrIYyb3a1s3IDryq5o0?=
 =?us-ascii?Q?IDdHkeI+FoVdWH1xyAkNNE4KbzaI2AziMZ8DF5etJTh97Y9KqTz3sD8H9vrR?=
 =?us-ascii?Q?j9wYL0RohcrGVKwZ6m3zZcX9CUQoL5Ijm2HhpN6DHJajFxr/m8Y9N4Sfjugj?=
 =?us-ascii?Q?Uwo7a5w0bBDsV4x6q1ACOlbbbQdDyj/ghjZYsYtU5M4OO3V9VT7aqfNXuPyY?=
 =?us-ascii?Q?5vQtaUSq50fsaSEKrpHweGhfHlXbz2ngfuUimP0FNRk6H3wUe4e8KlPVmBQu?=
 =?us-ascii?Q?EKC02acZ1NSlqnDW7DOWaiu6/bwuiXJEKcVZUs9gEkpNJWDhvClVsqlCbEnf?=
 =?us-ascii?Q?nu/p8OdZiWVRGQFjpGnzaLXTMyujTRkt4uCy0Rg9uJrPD9TgxlrCmrunfK4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 321bd6e6-f8cf-4623-b819-08dc598de7ea
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 18:42:00.0331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2P220MB1885

From: Min Li <min.li.xe@renesas.com>

Add device tree binding doc for the IDT FemtoClock Frequency
Clock Synthesizers.

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 .../devicetree/bindings/ptp/ptp-idtfc3.yaml   | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ptp/ptp-idtfc3.yaml

diff --git a/Documentation/devicetree/bindings/ptp/ptp-idtfc3.yaml b/Documentation/devicetree/bindings/ptp/ptp-idtfc3.yaml
new file mode 100644
index 000000000000..3e1c3135df5a
--- /dev/null
+++ b/Documentation/devicetree/bindings/ptp/ptp-idtfc3.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ptp/ptp-idtfc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RENESAS FemtoClock (TM) Frequency Clock Synthesizers
+
+maintainers:
+  - Min Li <min.li.xe@renesas.com>
+
+properties:
+  compatible:
+    enum:
+      # For System Synchronizer
+      - idt,rc38xxx0
+      - idt,rc38xxx1
+      - idt,rc38xxx2
+      - idt,rc38xxx3
+      - idt,rc38xxx4
+      - idt,rc38xxx5
+      - idt,rc38xxx6
+      - idt,rc38xxx7
+      - idt,rc38xxx8
+      - idt,rc38xxx9
+
+  reg:
+    maxItems: 1
+    description:
+      I2C slave address of the device.
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
+        #address-cells = <1>;
+        #size-cells = <0>;
+	phc@9 { /* FemtoClock3 */
+		compatible = "idt,rc38xxx0";
+		reg = <0x9>;
+	};
+    };
-- 
2.39.2


