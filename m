Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500A47EC742
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjKOP3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjKOP3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:29:17 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362A51AE;
        Wed, 15 Nov 2023 07:29:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSCB16/7LS1LfMETlChZ0N3bee2R3sGVPf+d9AsTK+nCgkz0kHWxpFRQtHbPwlrE0fZIH95EMJpCSKXoSWy78PNRgXLMM8BEl+kN6pUhj2H/OGtscXFzWteCSlagkTlutEuLLT7JUXvYZvCaKVM/0u1/Fej+cKSEcGEnryaZFAgQIoXzB5iYG3V9haVpvupqLahZONoNywKvDyP1U+arTxw+PCUZyaA+nyFnnYqLsyhcTX0tRFrMN3V4kkNgKZwkv/OIsGoiSKKylewtJo2Rd1iThnclDYm4n/29MxWMDNyCgrndBdah8JUbxTKMXRxqdIPnugoc36SCfF85+MjmVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8Rt5yAU7/6upj6fUvNU9Dy5Iq5yS4hhLCvDxIwSmAg=;
 b=U/91KHVtJ1W0NTfs4uIklG4vAjxUF6SfdMcmJRUFsF0p68zuhkDmBk7Brj2FJNHFXVEnVx0CSZWCGg6ozRuOzeCxH1FqBLwIl+KuoT+v4r1Fl034nKhcGzaEKx/4CHSuzqcpCOjRFH8M8IYwe/ee1bIZmSVBZdyK+2es729Cy/b9X1Xb2ys+RwvZpyL2v0AR/ckqyJ+5JxzR9G0kfbyoIeMeoS7z2OQsDJ+0AihcTgg9ftvB1NP/u7D+nHvb6ragKIQfAYqP3gyO6od9veV8snRYZaCsHMhUBSwranl8lgav8hbvT9C9+fTVvu2hceCJD744MfIr5jZCipklUoyx7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 151.1.184.193) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=asem.it;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=asem.it;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8Rt5yAU7/6upj6fUvNU9Dy5Iq5yS4hhLCvDxIwSmAg=;
 b=hZHouSycTQTJSPRkGYsWbLR6WT6OcMxSw/5vwKbHeAz/Z20vvEflQc0quqS4BvT+68ZIkn/SYIbIN9mesdxRYFBJg31jayYQ+Z36O+x8SHF+n2Eb1We8r5J6gVvG0YG9oUW64eQHGHVdTxJeoPCx+41sYX65rzqHjf6LG+9Nj9o=
Received: from AM6P193CA0102.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::43)
 by DB9PR01MB9200.eurprd01.prod.exchangelabs.com (2603:10a6:10:364::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Wed, 15 Nov
 2023 15:29:08 +0000
Received: from AMS0EPF000001A6.eurprd05.prod.outlook.com
 (2603:10a6:209:88:cafe::27) by AM6P193CA0102.outlook.office365.com
 (2603:10a6:209:88::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29 via Frontend
 Transport; Wed, 15 Nov 2023 15:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 151.1.184.193) smtp.mailfrom=asem.it; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=asem.it;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 asem.it discourages use of 151.1.184.193 as permitted sender)
Received: from asas054.asem.intra (151.1.184.193) by
 AMS0EPF000001A6.mail.protection.outlook.com (10.167.16.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 15:29:08 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
         Wed, 15 Nov 2023 16:29:06 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v6 1/2] dt-bindings: backlight: mp3309c: remove two required properties
Date:   Wed, 15 Nov 2023 16:29:01 +0100
Message-Id: <20231115152902.851715-2-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115152902.851715-1-f.suligoi@asem.it>
References: <20231115152902.851715-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Nov 2023 15:29:06.0647 (UTC) FILETIME=[78B6C670:01DA17D8]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A6:EE_|DB9PR01MB9200:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7d90c9a2-af9d-4b80-0aeb-08dbe5ef9c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PK6YThdi3bHsaxUaPDufalgQW4tXSF+AMUhhGLggeQ2rf5iB6G4TXpeGoorLYZ19JAHqlRFBZ0yBwJuMUymwTIbsVobamNBQpdUilbiqG8ekwJ66pXNndafBUomaSNtsFwhSqe6wK0ZQK+hJ1xr2lfL1zg4OAzidhy6gH9on8XPPX1RZMJ+E960NYxaIjPWneIrHzUnaQq+gFtLrZ7yi9+DsS//uQDHH1Uw2c9ZSD0VwWdZQCNiEq6h52LdLDfSHQWcgHEZo5T9vFtTmMNp5EmWfQ5r4fEw0oz49hQjbnn4zK2VwuMqk1JMKrjlttZIO3EMTu4h4vjSxyI2y4P8dWryKUm2iqfrr+3heF0B+EWTE1GBwA4L59or6HQy6N58C7RIxJ3U11KOztoQA8L0Yt1eo73BKBcjrJB0e7nAn8/XSjE6qp5VtAM2MfmRINu0wcoFvBh1M3QW0MFsQaBb1/TuVb3lCA4+03rKDGqg3PytUhYClG76TieQTEVj1EVAFFV3vnNHepr1FkSnJeJQEtnzAIJjt7OBZXSULOs46UoUDVoj9pz1eFujS8ikdgUkoP37Ca6Kl1lPfUWW7KZMhQj0umQLZ/sWIcWDPZc/v0V56a2mgYx/xjwFYUsXFThlBePv7GtLK0Ey2bPu/CpTGCiSiPtPhGHbiruO/1jm3//NA8mNaz8ZXY5Czxnnbd4q9vkpNfAfdCUKmRxKmKH+OJKz0BP65QO6d+jfD48LldA=
X-Forefront-Antispam-Report: CIP:151.1.184.193;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:asas054.asem.intra;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39850400004)(230922051799003)(82310400011)(64100799003)(1800799009)(186009)(451199024)(46966006)(36840700001)(107886003)(1076003)(40480700001)(2616005)(450100002)(81166007)(8936002)(8676002)(47076005)(356005)(26005)(336012)(36860700001)(82740400003)(83380400001)(4326008)(478600001)(6666004)(966005)(110136005)(316002)(70586007)(70206006)(41300700001)(36756003)(2906002)(86362001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 15:29:08.2478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d90c9a2-af9d-4b80-0aeb-08dbe5ef9c41
X-MS-Exchange-CrossTenant-Id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d0a766c6-7992-4344-a4a2-a467a7bb1ed2;Ip=[151.1.184.193];Helo=[asas054.asem.intra]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR01MB9200
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two properties:

- max-brightness
- default brightness

are not really required, so they can be removed from the "required"
section.
The "max-brightness" is no longer used in the current version
of the driver (it was used only in the first version).
The "default-brightness", if omitted in the DT, is managed by the
device driver, using a default value. This value depends on the dimming
mode used:

- for the "analog mode", via I2C commands, this value is fixed by
  hardware (=31)
- while in case of pwm mode the default used is the last value of the
  brightness-levels array.

Also the brightness-levels array is not required:

- in "analog mode", via I2C commands, the brightness-level array is
  fixed by hardware (0..31).;
- in pwm dimming mode, the driver uses a default array of 0..255 and
  the "default-brightness" is the last one, which is "255"

NOTE: there are no compatibility problems with the previous version,
      since the device driver has not yet been included in any kernel.
      Only this dt-binding yaml file is already included in the kernel
      repository.
      No developer may have used it.

Other changes:

- improve the backlight working mode description, in the "description"
  section
- update the example, removing the "max-brightness" and introducing the
  "brightess-levels" property

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 .../bindings/leds/backlight/mps,mp3309c.yaml           | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml b/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
index 4191e33626f5..527a37368ed7 100644
--- a/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
@@ -14,8 +14,8 @@ description: |
   programmable switching frequency to optimize efficiency.
   It supports two different dimming modes:
 
-  - analog mode, via I2C commands (default)
-  - PWM controlled mode.
+  - analog mode, via I2C commands, as default mode (32 dimming levels)
+  - PWM controlled mode (optional)
 
   The datasheet is available at:
   https://www.monolithicpower.com/en/mp3309c.html
@@ -50,8 +50,6 @@ properties:
 required:
   - compatible
   - reg
-  - max-brightness
-  - default-brightness
 
 unevaluatedProperties: false
 
@@ -66,8 +64,8 @@ examples:
             compatible = "mps,mp3309c";
             reg = <0x17>;
             pwms = <&pwm1 0 3333333 0>; /* 300 Hz --> (1/f) * 1*10^9 */
-            max-brightness = <100>;
-            default-brightness = <80>;
+            brightness-levels = <0 4 8 16 32 64 128 255>;
+            default-brightness = <6>;
             mps,overvoltage-protection-microvolt = <24000000>;
         };
     };
-- 
2.34.1

