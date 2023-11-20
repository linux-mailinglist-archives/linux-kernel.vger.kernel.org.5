Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8936D7F150B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjKTOCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjKTOB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:01:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C6C11A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:01:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFE4C433C7;
        Mon, 20 Nov 2023 14:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700488914;
        bh=cGs0HyLCS5owCtkNE0emwtvUGyUvuxU5P+zsEgYBDI0=;
        h=From:To:Cc:Subject:Date:From;
        b=USJOSq4FNNxuYHQWs39YPg8R6ZZT+dXf9CCSEbSmnoZvEJmpZgraC6D4FuvVk2qzX
         I4sVkWxGntrax3KKEZ9NvCg0v7pRImkteJhx0vQzmjKPdPrc6TqRoE1H4dvMUWt21E
         BBNI1BwEywTl9qxYpp6OoSre8bZmmtcyd/+m/AKqSuibfx8L9kYQjwI+9xd1LR5S4u
         tGUWMladzPHaO1ROHdN6OAOul3oHBYHnwNEopltcawyNc9P8dJGcAp1Yc1lrNCDvqZ
         K6kXn3t2qKkbOjMvEdf/SsYp/qRnadeHWHvbaDgYeP2HRjsfyiji6P4wbCvmKPIdWx
         fhFTMVM3jLN9A==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     vladimir.oltean@nxp.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v6 net-next 0/7] net: ethernet: am65-cpsw: Add mqprio, frame pre-emption & coalescing
Date:   Mon, 20 Nov 2023 16:01:40 +0200
Message-Id: <20231120140147.78726-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds mqprio qdisc offload in channel mode,
Frame Pre-emption MAC merge support and RX/TX coalesing
for AM65 CPSW driver.

Changelog information in each patch file.

cheers,
-roger

Grygorii Strashko (2):
  net: ethernet: ti: am65-cpsw: add mqprio qdisc offload in channel mode
  net: ethernet: ti: am65-cpsw: add sw tx/rx irq coalescing based on
    hrtimers

Roger Quadros (5):
  net: ethernet: am65-cpsw: Build am65-cpsw-qos only if required
  net: ethernet: am65-cpsw: cleanup TAPRIO handling
  net: ethernet: ti: am65-cpsw: Move code to avoid forward declaration
  net: ethernet: am65-cpsw: Move register definitions to header file
  net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge
    support

 drivers/net/ethernet/ti/Makefile            |   3 +-
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 234 +++++++
 drivers/net/ethernet/ti/am65-cpsw-nuss.c    |  64 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.h    |   9 +
 drivers/net/ethernet/ti/am65-cpsw-qos.c     | 730 +++++++++++++++-----
 drivers/net/ethernet/ti/am65-cpsw-qos.h     | 184 +++++
 6 files changed, 1046 insertions(+), 178 deletions(-)


base-commit: 94c81c62668954269ec852ab0284256db20ed9b4
-- 
2.34.1

