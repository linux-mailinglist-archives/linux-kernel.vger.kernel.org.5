Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7217751DC4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbjGMJwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjGMJwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:52:01 -0400
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CA9E77
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:51:51 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202307130951480dce4904efdbf28889
        for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 11:51:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=FmUGUn49WETz1Fw3mb6/eNP9ivK6zo0mmq3YHUWYtzA=;
 b=NKojwrGakjk/94cLrq3SsM9YQMLnobsnR9QuFWb7dq4VRHt71ndg7EMaq8m5aJBF64oSIC
 lZS1FOOkGnbU+JMgcPh7oaJ2OuTT8yu7lzYMWRTv//gj7lV7lOTMi37ypn9o0Ecy47L9JOyb
 29kTUgaDi/dQE6+odkIHk0RaMeXdc=;
From:   huaqian.li@siemens.com
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     huaqianlee@gmail.com, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jan.kiszka@siemens.com,
        baocheng.su@siemens.com, Li Hua Qian <huaqian.li@siemens.com>
Subject: [PATCH v3 0/3] Add support for WDIOF_CARDRESET on TI AM65x
Date:   Thu, 13 Jul 2023 17:51:24 +0800
Message-Id: <20230713095127.1230109-1-huaqian.li@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Hua Qian <huaqian.li@siemens.com>

The watchdog hardware of TI AM65X platform does not support
WDIOF_CARDRESET feature, add a reserved memory to save the watchdog
reset cause, to know if the board reboot is due to a watchdog reset.

Changes in v3:
- Add memory-region back for the reserved memory, and remove reserved
  memory from the watchdog IO address space.
- Add changelog.
- Link to v2:
  https://lore.kernel.org/linux-watchdog/20230711091713.1113010-1-huaqian.li@siemens.com

Changes in v2:
- Remove memory-region and memory-size properties, and bind the reserved
  memory to watchdog IO address space.
- Remove the unnecessary rti_wdt_ioctl.
- Fix the mail list
- Link to v1:
  https://lore.kernel.org/all/3137d87e56ef75ba0b8a923d407b2fecace6ccbd.camel@siemens.com/
  v1 had a wrong mail list at the beginning, and the mail thread was
  messed up.

Li Hua Qian (3):
  dt-bindings: watchdog: ti,rti-wdt: Add support for WDIOF_CARDRESET
  arm64: dts: ti: Add reserved memory for watchdog
  watchdog:rit_wdt: Add support for WDIOF_CARDRESET

 .../bindings/watchdog/ti,rti-wdt.yaml         | 12 +++++
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 10 ++++
 drivers/watchdog/rti_wdt.c                    | 51 +++++++++++++++++++
 3 files changed, 73 insertions(+)

-- 
2.34.1

