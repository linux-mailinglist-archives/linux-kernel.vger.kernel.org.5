Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F3175E84A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjGXBjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjGXBjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:39:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4024C2D;
        Sun, 23 Jul 2023 18:34:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0C5B60F72;
        Mon, 24 Jul 2023 01:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756BFC433CA;
        Mon, 24 Jul 2023 01:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162326;
        bh=gk/VE39/NSplkE3FDt7MO81fwPrNrErMqW1aWZef9kc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E3dM2oymqyPfpzTz4v+Zll+czY+oqeym3wDdV0o0sp8gQfPyWm/ELhf60fBgfhpPD
         Q78crqJW7b3f8MlLBPSQ/QuTM4Ll9olWCrloLiU2WcNUue2Nm2GvCYQZwSSFLVCbz8
         mAE+q4fK/mPBe3FyLJV3n0ojW57wY8rhjqxtmDDAlsDpi9/hYmM2aCgQUr+PKrDp+f
         js2Vs1i2eWBtvYvoiwRYHYcZS4qtLuFiykktrPbQpNfZnV8c7bhUF8K8baCreyQxxX
         a5Mr+LK2kuFA+lE12jY+9y6HiAzK3D8W9k6R9f5VosDgu2Ov+0zML5L6OrPykYKhgY
         NOwTcr4xl2upg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gil Fine <gil.fine@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, andreas.noever@gmail.com,
        michael.jamet@intel.com, yehezkel.bernat@intel.com
Subject: [PATCH AUTOSEL 6.4 18/40] thunderbolt: Limit Intel Barlow Ridge USB3 bandwidth
Date:   Sun, 23 Jul 2023 21:31:18 -0400
Message-Id: <20230724013140.2327815-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013140.2327815-1-sashal@kernel.org>
References: <20230724013140.2327815-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit f2bfa944080dcbb8eb56259dfd2c07204cbee17e ]

Intel Barlow Ridge discrete USB4 host router has the same limitation as
the previous generations so make sure the USB3 bandwidth limitation
quirk is applied to Barlow Ridge too.

Signed-off-by: Gil Fine <gil.fine@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/nhi.h    | 2 ++
 drivers/thunderbolt/quirks.c | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/thunderbolt/nhi.h b/drivers/thunderbolt/nhi.h
index c15a0c46c9cff..0f029ce758825 100644
--- a/drivers/thunderbolt/nhi.h
+++ b/drivers/thunderbolt/nhi.h
@@ -77,6 +77,8 @@ extern const struct tb_nhi_ops icl_nhi_ops;
 #define PCI_DEVICE_ID_INTEL_ADL_NHI1			0x466d
 #define PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_80G_NHI	0x5781
 #define PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_40G_NHI	0x5784
+#define PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HUB_80G_BRIDGE 0x5786
+#define PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HUB_40G_BRIDGE 0x57a4
 #define PCI_DEVICE_ID_INTEL_MTL_M_NHI0			0x7eb2
 #define PCI_DEVICE_ID_INTEL_MTL_P_NHI0			0x7ec2
 #define PCI_DEVICE_ID_INTEL_MTL_P_NHI1			0x7ec3
diff --git a/drivers/thunderbolt/quirks.c b/drivers/thunderbolt/quirks.c
index 1157b8869bcca..8c2ee431fcde8 100644
--- a/drivers/thunderbolt/quirks.c
+++ b/drivers/thunderbolt/quirks.c
@@ -74,6 +74,14 @@ static const struct tb_quirk tb_quirks[] = {
 		  quirk_usb3_maximum_bandwidth },
 	{ 0x8087, PCI_DEVICE_ID_INTEL_MTL_P_NHI1, 0x0000, 0x0000,
 		  quirk_usb3_maximum_bandwidth },
+	{ 0x8087, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_80G_NHI, 0x0000, 0x0000,
+		  quirk_usb3_maximum_bandwidth },
+	{ 0x8087, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_40G_NHI, 0x0000, 0x0000,
+		  quirk_usb3_maximum_bandwidth },
+	{ 0x8087, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HUB_80G_BRIDGE, 0x0000, 0x0000,
+		  quirk_usb3_maximum_bandwidth },
+	{ 0x8087, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HUB_40G_BRIDGE, 0x0000, 0x0000,
+		  quirk_usb3_maximum_bandwidth },
 	/*
 	 * CLx is not supported on AMD USB4 Yellow Carp and Pink Sardine platforms.
 	 */
-- 
2.39.2

