Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDD3773D36
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjHHQOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjHHQNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:13:18 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51CEA3C19;
        Tue,  8 Aug 2023 08:47:25 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37865U8t8011396, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37865U8t8011396
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 8 Aug 2023 14:05:31 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 8 Aug 2023 14:05:31 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 8 Aug 2023 14:05:31 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Tue, 8 Aug 2023 14:05:31 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] dt-bindings: usb: dwc3: Add DWC_usb3 TX/RX threshold configurable
Date:   Tue, 8 Aug 2023 14:05:23 +0800
Message-ID: <20230808060530.9727-2-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808060530.9727-1-stanley_chang@realtek.com>
References: <20230808060530.9727-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS05.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Synopsys's dwc3 data book:
To avoid underrun and overrun during the burst, in a high-latency bus
system (like USB), threshold and burst size control is provided through
GTXTHRCFG and GRXTHRCFG registers.
By default, USB TX and RX threshold are not enabled. To enable
TX or RX threshold, both packet threshold count and max burst size
properties must be set to a valid non-zero value.

In Realtek DHC SoC, DWC3 USB 3.0 uses AHB system bus. When dwc3 is
connected with USB 2.5G Ethernet, there will be overrun problem.
Therefore, setting TX/RX thresholds can avoid this issue.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
v1 to v2 change:
    Add the properties for TX/RX threshold setting
---
 .../devicetree/bindings/usb/snps,dwc3.yaml    | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index a696f23730d3..ee5af4b381b1 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -310,6 +310,62 @@ properties:
     maximum: 62
     deprecated: true
 
+  snps,rx-thr-num-pkt:
+    description:
+      USB RX packet threshold count. In host mode, this field specifies
+      the space that must be available in the RX FIFO before the core can
+      start the corresponding USB RX transaction (burst).
+      In device mode, this field specifies the space that must be
+      available in the RX FIFO before the core can send ERDY for a
+      flow-controlled endpoint. It is only used for SuperSpeed.
+      The valid values for this field are from 1 to 15. (DWC3 SuperSpeed
+      USB 3.0 Controller Databook)
+    $ref: /schemas/types.yaml#/definitions/uint8
+    minimum: 1
+    maximum: 15
+
+  snps,rx-max-burst:
+    description:
+      Max USB RX burst size. In host mode, this field specifies the
+      Maximum Bulk IN burst the DWC_usb3 core can perform. When the system
+      bus is slower than the USB, RX FIFO can overrun during a long burst.
+      You can program a smaller value to this field to limit the RX burst
+      size that the core can perform. It only applies to SS Bulk,
+      Isochronous, and Interrupt IN endpoints in the host mode.
+      In device mode, this field specifies the NUMP value that is sent in
+      ERDY for an OUT endpoint.
+      The valid values for this field are from 1 to 16. (DWC3 SuperSpeed
+      USB 3.0 Controller Databook)
+    $ref: /schemas/types.yaml#/definitions/uint8
+    minimum: 1
+    maximum: 16
+
+  snps,tx-thr-num-pkt:
+    description:
+      USB TX packet threshold count. This field specifies the number of
+      packets that must be in the TXFIFO before the core can start
+      transmission for the corresponding USB transaction (burst).
+      This count is valid in both host and device modes. It is only used
+      for SuperSpeed operation.
+      Valid values are from 1 to 15. (DWC3 SuperSpeed USB 3.0 Controller
+      Databook)
+    $ref: /schemas/types.yaml#/definitions/uint8
+    minimum: 1
+    maximum: 15
+
+  snps,tx-max-burst:
+    description:
+      Max USB TX burst size. When the system bus is slower than the USB,
+      TX FIFO can underrun during a long burst. Program a smaller value
+      to this field to limit the TX burst size that the core can execute.
+      In Host mode, it only applies to SS Bulk, Isochronous, and Interrupt
+      OUT endpoints. This value is not used in device mode.
+      Valid values are from 1 to 16. (DWC3 SuperSpeed USB 3.0 Controller
+      Databook)
+    $ref: /schemas/types.yaml#/definitions/uint8
+    minimum: 1
+    maximum: 16
+
   snps,rx-thr-num-pkt-prd:
     description:
       Periodic ESS RX packet threshold count (host mode only). Set this and
-- 
2.34.1

