Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066CD7C50BF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346718AbjJKLCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346674AbjJKLCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:02:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9491A9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697022137; x=1728558137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AX4VHlWO9XCZX/4XDdhwVkemO2KD/0VLOBZhVIMd1zE=;
  b=lbA/JU3IXl+cjgVq7KSe/6BdZDn6+f3dcX114HkGocuz4L1kTxF/uQtx
   gh4F2EUR8gYomae20U+gLrtt5tOcyxAtoO/gJlGTvteRMmI/F8HkGfPC4
   NRJK1ypImF6uiCOgxvXjsGNu6xYqrQQphVo/YnVY3mDovBkwSgQMPL5Eg
   BUAlalEZrIc94WHkMmnwveZNdf7nbiGKW5v6X98zGkoHNy9yYJ/9KpUVK
   PIPuVrWr41BcPjk+huA9Q/4vWVzqw/rkukKtFvJr8SEPKPmJYFjRqDJrr
   bmXeYR88DiIwSUHGxAUVDPPgOv8yry1wZtTUvDFi7fQFb10OaDmTUVIoi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="369696917"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="369696917"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:02:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="788960311"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="788960311"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:02:15 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 4/4] mei: update mei-pxp's component interface with timeouts
Date:   Wed, 11 Oct 2023 14:01:57 +0300
Message-ID: <20231011110157.247552-5-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011110157.247552-1-tomas.winkler@intel.com>
References: <20231011110157.247552-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Previn <alan.previn.teres.alexis@intel.com>

In debugging platform or firmware related MEI-PXP connection
issues, having a timeout when clients (such as i915) calling
into mei-pxp's send/receive functions have proven useful as opposed to
blocking forever until the kernel triggers a watchdog panic (when
platform issues are experienced).

Update the mei-pxp component interface send and receive functions
to take in timeouts.

Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/gpu/drm/i915/pxp/intel_pxp_tee.c |  8 ++++--
 drivers/misc/mei/pxp/mei_pxp.c           | 33 +++++++++++++++++++-----
 include/drm/i915_pxp_tee_interface.h     |  6 +++--
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/pxp/intel_pxp_tee.c b/drivers/gpu/drm/i915/pxp/intel_pxp_tee.c
index 80bb0018986525f16d410e56..dfc2878426fc2226ccb55270 100644
--- a/drivers/gpu/drm/i915/pxp/intel_pxp_tee.c
+++ b/drivers/gpu/drm/i915/pxp/intel_pxp_tee.c
@@ -20,6 +20,8 @@
 #include "intel_pxp_tee.h"
 #include "intel_pxp_types.h"
 
+#define PXP_TRANSPORT_TIMEOUT_MS 5000 /* 5 sec */
+
 static bool
 is_fw_err_platform_config(u32 type)
 {
@@ -71,13 +73,15 @@ static int intel_pxp_tee_io_message(struct intel_pxp *pxp,
 		goto unlock;
 	}
 
-	ret = pxp_component->ops->send(pxp_component->tee_dev, msg_in, msg_in_size);
+	ret = pxp_component->ops->send(pxp_component->tee_dev, msg_in, msg_in_size,
+				       PXP_TRANSPORT_TIMEOUT_MS);
 	if (ret) {
 		drm_err(&i915->drm, "Failed to send PXP TEE message\n");
 		goto unlock;
 	}
 
-	ret = pxp_component->ops->recv(pxp_component->tee_dev, msg_out, msg_out_max_size);
+	ret = pxp_component->ops->recv(pxp_component->tee_dev, msg_out, msg_out_max_size,
+				       PXP_TRANSPORT_TIMEOUT_MS);
 	if (ret < 0) {
 		drm_err(&i915->drm, "Failed to receive PXP TEE message\n");
 		goto unlock;
diff --git a/drivers/misc/mei/pxp/mei_pxp.c b/drivers/misc/mei/pxp/mei_pxp.c
index 9875d16445bb03efcfb31cd9..f77d78fa50549e69f0a0873b 100644
--- a/drivers/misc/mei/pxp/mei_pxp.c
+++ b/drivers/misc/mei/pxp/mei_pxp.c
@@ -46,10 +46,20 @@ static inline int mei_pxp_reenable(const struct device *dev, struct mei_cl_devic
  * @dev: device corresponding to the mei_cl_device
  * @message: a message buffer to send
  * @size: size of the message
- * Return: 0 on Success, <0 on Failure
+ * @timeout_ms: timeout in milliseconds, zero means wait indefinitely.
+ *
+ * Returns: 0 on Success, <0 on Failure with the following defined failures.
+ *         -ENODEV: Client was not connected.
+ *                  Caller may attempt to try again immediately.
+ *         -ENOMEM: Internal memory allocation failure experienced.
+ *                  Caller may sleep to allow kernel reclaim before retrying.
+ *         -EINTR : Calling thread received a signal. Caller may choose
+ *                  to abandon with the same thread id.
+ *         -ETIME : Request is timed out.
+ *                  Caller may attempt to try again immediately.
  */
 static int
-mei_pxp_send_message(struct device *dev, const void *message, size_t size)
+mei_pxp_send_message(struct device *dev, const void *message, size_t size, unsigned long timeout_ms)
 {
 	struct mei_cl_device *cldev;
 	ssize_t byte;
@@ -60,7 +70,7 @@ mei_pxp_send_message(struct device *dev, const void *message, size_t size)
 
 	cldev = to_mei_cl_device(dev);
 
-	byte = mei_cldev_send(cldev, message, size);
+	byte = mei_cldev_send_timeout(cldev, message, size, timeout_ms);
 	if (byte < 0) {
 		dev_dbg(dev, "mei_cldev_send failed. %zd\n", byte);
 		switch (byte) {
@@ -84,10 +94,21 @@ mei_pxp_send_message(struct device *dev, const void *message, size_t size)
  * @dev: device corresponding to the mei_cl_device
  * @buffer: a message buffer to contain the received message
  * @size: size of the buffer
- * Return: bytes sent on Success, <0 on Failure
+ * @timeout_ms: timeout in milliseconds, zero means wait indefinitely.
+ *
+ * Returns: number of bytes send on Success, <0 on Failure with the following defined failures.
+ *         -ENODEV: Client was not connected.
+ *                  Caller may attempt to try again from send immediately.
+ *         -ENOMEM: Internal memory allocation failure experienced.
+ *                  Caller may sleep to allow kernel reclaim before retrying.
+ *         -EINTR : Calling thread received a signal. Caller will need to repeat calling
+ *                  (with a different owning thread) to retrieve existing unclaimed response
+ *                  (and may discard it).
+ *         -ETIME : Request is timed out.
+ *                  Caller may attempt to try again from send immediately.
  */
 static int
-mei_pxp_receive_message(struct device *dev, void *buffer, size_t size)
+mei_pxp_receive_message(struct device *dev, void *buffer, size_t size, unsigned long timeout_ms)
 {
 	struct mei_cl_device *cldev;
 	ssize_t byte;
@@ -100,7 +121,7 @@ mei_pxp_receive_message(struct device *dev, void *buffer, size_t size)
 	cldev = to_mei_cl_device(dev);
 
 retry:
-	byte = mei_cldev_recv(cldev, buffer, size);
+	byte = mei_cldev_recv_timeout(cldev, buffer, size, timeout_ms);
 	if (byte < 0) {
 		dev_dbg(dev, "mei_cldev_recv failed. %zd\n", byte);
 		switch (byte) {
diff --git a/include/drm/i915_pxp_tee_interface.h b/include/drm/i915_pxp_tee_interface.h
index a702b6ec17f7ca95eda7d225..7d96985f2d05327151b0dfc1 100644
--- a/include/drm/i915_pxp_tee_interface.h
+++ b/include/drm/i915_pxp_tee_interface.h
@@ -22,8 +22,10 @@ struct i915_pxp_component_ops {
 	 */
 	struct module *owner;
 
-	int (*send)(struct device *dev, const void *message, size_t size);
-	int (*recv)(struct device *dev, void *buffer, size_t size);
+	int (*send)(struct device *dev, const void *message, size_t size,
+		    unsigned long timeout_ms);
+	int (*recv)(struct device *dev, void *buffer, size_t size,
+		    unsigned long timeout_ms);
 	ssize_t (*gsc_command)(struct device *dev, u8 client_id, u32 fence_id,
 			       struct scatterlist *sg_in, size_t total_in_len,
 			       struct scatterlist *sg_out);
-- 
2.41.0

