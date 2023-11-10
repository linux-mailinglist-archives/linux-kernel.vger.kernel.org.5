Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9245F7E8460
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346652AbjKJUmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346477AbjKJUls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:41:48 -0500
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F363B33C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 07:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=PXwXN5tEaR5kdeL10MocxWEaauKlj7fnNpl4PFnuxYM=; b=d1kbIHQgk3i7aNFylGG3Bb2XtI
        AmBsCJCFTGSWWS+JpsukzdbLm80G/eW43IctFGZ3y0SxuGQ8tCPMJRv7eX1YGTX41ouUDPVFXcAu3
        1DFFveqrJUD4hJ3RvcPkZsDrS6AnufUvcRR3IVFkHsEkojSPGtHIaPxT71zkPHGz0BEufb3OTZdic
        avFBnBOGyB0mAucQCN1fyneCryJ0HF7BJCk5L8PMN6OUD69/VkrgFXtc+b9HMddus1BMbRPVCMFy3
        2kJwmjzSf6zPgzzfVlsu1MqH9KtMlTDyVMcxMBSrusmxxHVnDLb2cmgdFVnbKzZPN9ZT46epEcgNY
        PZi+w30g==;
Received: from pool-96-246-156-208.nycmny.fios.verizon.net ([96.246.156.208] helo=X1.myfiosgateway.com)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1r1TrU-001hA7-V0; Fri, 10 Nov 2023 16:56:01 +0100
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, ray.huang@amd.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH] drm/amd: Document device reset methods
Date:   Fri, 10 Nov 2023 10:55:48 -0500
Message-ID: <20231110155548.20599-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document what each amdgpu driver reset method does.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a79d53bdbe13..500f86c79eb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -504,6 +504,26 @@ struct amdgpu_allowed_register_entry {
 	bool grbm_indexed;
 };
 
+/**
+ * enum amd_reset_method - Methods for resetting AMD GPU devices
+ *
+ * @AMD_RESET_METHOD_NONE: The device will not be reset.
+ * @AMD_RESET_LEGACY: Method reserved for SI/CIK asics.
+ * @AMD_RESET_MODE0: High level PCIe reset.
+ * @AMD_RESET_MODE1: Resets each IP block (SDMA, GFX, VCN, etc.) individually.
+ *                   Suitable only for some discrete GPUs.
+ * @AMD_RESET_MODE2: Resets only the GFX block. Useful for APUs, giving that
+ *                   the rest of IP blocks and SMU is shared with the CPU.
+ * @AMD_RESET_BACO: BACO (Bus Alive, Chip Off) method powers off and on the card
+ *                  but without powering off the PCI bus. Suitable only for
+ *                  discrete GPUs.
+ * @AMD_RESET_PCI: Does a full bus reset, including powering on and off the
+ *                 card.
+ *
+ * Methods available for AMD GPU driver for resetting the device. Not all
+ * methods are suitable for every device. User can overwrite the method using
+ * module parameter `reset_method`.
+ */
 enum amd_reset_method {
 	AMD_RESET_METHOD_NONE = -1,
 	AMD_RESET_METHOD_LEGACY = 0,
-- 
2.42.1

