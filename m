Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F4179D539
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbjILPoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjILPoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:44:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6AF1B6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:44:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3537C433C8;
        Tue, 12 Sep 2023 15:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694533456;
        bh=FB9faDmLpcSa0JecXQWjp3jxJw6ncd3tBo9iq0W/ndk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G3ROnSZ0wldgPfor7Djjw53oxMtHdaFvn9SBrus+adjnAdBAFGBOpfxb5Rl+VrtIW
         B3BuxPEu6PLfJnxKQ7YMXisyNJrWv5lC4qkt+z52hz7NttDRVUZRY+wIHyCEnzoBvJ
         zH4N4joww1KzPgmaCmn6HsMdK3+GION+mDc/c9ReY7FEU+ztI9GZyWSWYeLnFjrbTH
         McgU/GZmTHoBg4kilFgs3NcZ9kh7qe+Ti3z+O0WRCCrRIaiX3iT20kDdAK3nYE5Hc1
         ebqJ693maBXKn+Z6TWZrRquStWZYPjxC/uvn4fpuY32gb8JKdN2fLyk5/OE9a7Sfbq
         ZBZyH2z0c4oaA==
Date:   Tue, 12 Sep 2023 08:44:11 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Felix Yan <felixonmars@archlinux.org>
Cc:     highenthalpyh@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, xuwd1@hotmail.com, hch@lst.de
Subject: Re: [PATCH] nvme-pci: ignore bogus CRTO according to NVME 2.0 spec
Message-ID: <ZQCHS2L59vRNmZbV@kbusch-mbp.dhcp.thefacebook.com>
References: <20230908155442.31423-1-felixonmars@archlinux.org>
 <ZP-cGgPzIX7WkNRb@kbusch-mbp.dhcp.thefacebook.com>
 <0f6ce98c-8f03-4ce1-badd-ae1346456a3e@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f6ce98c-8f03-4ce1-badd-ae1346456a3e@archlinux.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:26:19AM +0300, Felix Yan wrote:
> 
> Should we also apply the same max() on the NVME_CRTO_CRIMT branch though?
> The spec actually says the same thing (Timeout should be FFh) for that too.

The spec is weird here: the CAP.TO value depends on the CC setting, but
we read and cache CAP.TO before setting CC, so TO is always associated
to CRWMT. We'll need to refresh the CAP value after the initial CC
write, but before final CC.EN.

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 37b6fa7466620..4adc0b2f12f1e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2245,25 +2245,8 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	else
 		ctrl->ctrl_config = NVME_CC_CSS_NVM;
 
-	if (ctrl->cap & NVME_CAP_CRMS_CRWMS) {
-		u32 crto;
-
-		ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CRTO, &crto);
-		if (ret) {
-			dev_err(ctrl->device, "Reading CRTO failed (%d)\n",
-				ret);
-			return ret;
-		}
-
-		if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
-			ctrl->ctrl_config |= NVME_CC_CRIME;
-			timeout = NVME_CRTO_CRIMT(crto);
-		} else {
-			timeout = NVME_CRTO_CRWMT(crto);
-		}
-	} else {
-		timeout = NVME_CAP_TIMEOUT(ctrl->cap);
-	}
+	if (ctrl->cap & NVME_CAP_CRMS_CRWMS && ctrl->cap & NVME_CAP_CRMS_CRIMS)
+		ctrl->ctrl_config |= NVME_CC_CRIME;
 
 	ctrl->ctrl_config |= (NVME_CTRL_PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
 	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
@@ -2277,6 +2260,33 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	if (ret)
 		return ret;
 
+	/* CAP value may change after initial CC write */
+	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
+	if (ret)
+		return ret;
+
+	timeout = NVME_CAP_TIMEOUT(ctrl->cap);
+	if (ctrl->cap & NVME_CAP_CRMS_CRWMS) {
+		u32 crto;
+
+		ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CRTO, &crto);
+		if (ret) {
+			dev_err(ctrl->device, "Reading CRTO failed (%d)\n",
+				ret);
+			return ret;
+		}
+
+		/*
+		 * CRTO should always be greater or equal to CAP.TO, but some
+		 * devices are known to get this wrong. Use the larger of the
+		 * two values.
+		 */
+		if (ctrl->ctrl_config & NVME_CC_CRIME)
+			timeout = max(timeout, NVME_CRTO_CRIMT(crto));
+		else
+			timeout = max(timeout, NVME_CRTO_CRWMT(crto));
+	}
+
 	ctrl->ctrl_config |= NVME_CC_ENABLE;
 	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
--
