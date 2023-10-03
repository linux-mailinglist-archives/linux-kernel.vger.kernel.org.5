Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7787B6D21
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239261AbjJCP3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjJCP3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:29:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F41A9;
        Tue,  3 Oct 2023 08:29:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED710C433C7;
        Tue,  3 Oct 2023 15:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696346975;
        bh=tbdzRhwZFSqvsJIFtunVh/DHqwi88SOjLub9TshtNR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ox3Ejze1ovNPXtV7c7sI+2L1MJYiNnoXZ6s/fRB6CCWoFMy97C01RMVSwC2q7TyyG
         Rt14gyTXxXyZFzdS3Q/r/bdV3RDPr2JvuJW5TBpbXqeYvYIFne+C0ILvLvxgwk3AfR
         6r0H7jN+ndgQXsFZJ1akCEg0NNMko7BvNGDmrsLCyGg5RjQoE1jEtV2u2Q0dp0HeGA
         +2WlAGSc/A94u0HNQchG8Mw4AKpmYMlBJOaV6eOOTnShc+GfyD6nguVjteXYo1k7gH
         doIHu5gCOnDDe1od5Wxy/S8begbXwL30aXMYeeRnUSTz+RpZ6/OVpl/wlnxrnCwQnk
         MdMsYM4gglw+w==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qnhLG-0003uT-0E;
        Tue, 03 Oct 2023 17:29:46 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 5/5] spmi: rename spmi device lookup helper
Date:   Tue,  3 Oct 2023 17:29:27 +0200
Message-ID: <20231003152927.15000-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003152927.15000-1-johan+linaro@kernel.org>
References: <20231003152927.15000-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the SPMI device helper which is used to lookup a device from its
OF node as spmi_find_device_by_of_node() so that it reflects the
implementation and matches how other helpers like this are named.

This will specifically make it more clear that this is a lookup function
which returns a reference counted structure.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/mfd/qcom-spmi-pmic.c | 2 +-
 drivers/spmi/spmi.c          | 6 +++---
 include/linux/spmi.h         | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
index ee55f09da3ba..1c17adeb7a6d 100644
--- a/drivers/mfd/qcom-spmi-pmic.c
+++ b/drivers/mfd/qcom-spmi-pmic.c
@@ -114,7 +114,7 @@ static struct spmi_device *qcom_pmic_get_base_usid(struct spmi_device *sdev, str
 		}
 
 		if (pmic_addr == function_parent_usid - (ctx->num_usids - 1)) {
-			sdev = spmi_device_from_of(child);
+			sdev = spmi_find_device_by_of_node(child);
 			if (!sdev) {
 				/*
 				 * If the base USID for this PMIC hasn't been
diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index ca2fd4d72fa6..93cd4a34debc 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -388,7 +388,7 @@ static struct bus_type spmi_bus_type = {
 };
 
 /**
- * spmi_device_from_of() - get the associated SPMI device from a device node
+ * spmi_find_device_by_of_node() - look up an SPMI device from a device node
  *
  * @np:		device node
  *
@@ -397,7 +397,7 @@ static struct bus_type spmi_bus_type = {
  *
  * Returns the struct spmi_device associated with a device node or NULL.
  */
-struct spmi_device *spmi_device_from_of(struct device_node *np)
+struct spmi_device *spmi_find_device_by_of_node(struct device_node *np)
 {
 	struct device *dev = bus_find_device_by_of_node(&spmi_bus_type, np);
 
@@ -405,7 +405,7 @@ struct spmi_device *spmi_device_from_of(struct device_node *np)
 		return to_spmi_device(dev);
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(spmi_device_from_of);
+EXPORT_SYMBOL_GPL(spmi_find_device_by_of_node);
 
 /**
  * spmi_device_alloc() - Allocate a new SPMI device
diff --git a/include/linux/spmi.h b/include/linux/spmi.h
index eac1956a8727..2a4ce4144f9f 100644
--- a/include/linux/spmi.h
+++ b/include/linux/spmi.h
@@ -166,7 +166,7 @@ static inline void spmi_driver_unregister(struct spmi_driver *sdrv)
 
 struct device_node;
 
-struct spmi_device *spmi_device_from_of(struct device_node *np);
+struct spmi_device *spmi_find_device_by_of_node(struct device_node *np);
 int spmi_register_read(struct spmi_device *sdev, u8 addr, u8 *buf);
 int spmi_ext_register_read(struct spmi_device *sdev, u8 addr, u8 *buf,
 			   size_t len);
-- 
2.41.0

