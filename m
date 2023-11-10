Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4167E80BB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjKJSSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345288AbjKJSPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:15:45 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840F327046;
        Fri, 10 Nov 2023 02:07:51 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AAA7Whb112094;
        Fri, 10 Nov 2023 04:07:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699610852;
        bh=rWsMuyyA1mzltuc9cgUJ5mkGrkzCAmzBHKxXjp2Fk9A=;
        h=From:To:CC:Subject:Date;
        b=e1pmU8muM8Sy8Cj4x6ejlIArt2UmtR9sIHlvTKKnSaMhWZlG2QKVK0n8XUK0fVHBy
         cSEXc/uf9fmhwDHk/2RMAcBGgWzZubfLCUrYbhW0bJKTT5P8yKvOii/46Kk0tE8iQj
         xNjgtD5NNNio7Vd6D8SzItLptD87MZM8qA5HSSow=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AAA7Vv5003057
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Nov 2023 04:07:32 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 Nov 2023 04:07:31 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 Nov 2023 04:07:31 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AAA7S4p051776;
        Fri, 10 Nov 2023 04:07:29 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Tero Kristo <t-kristo@kernel.org>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH 0/2] watchdog: rti_wdt: Disable module when unused
Date:   Fri, 10 Nov 2023 15:37:24 +0530
Message-ID: <20231110100726.2930218-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds couple of fixes to rti_wdt driver so that module is
disabled when unused. First patch is cleanup to use devm_* API and
second patch drops RPM count when unused.

On K3 SoCs, each RTI is paired to a CPU/GPU core. So disabling such
cores (CPU hotplug) would require corresponding RTIs to be off. This
series enables hotplug of the core, if the corresponding watchdog was
unused.


Vignesh Raghavendra (2):
  watchdog: rti_wdt: Use managed APIs to handle runtime PM
  watchdog: rti_wdt: Drop RPM watchdog when unused

 drivers/watchdog/rti_wdt.c | 39 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

-- 
2.42.0

