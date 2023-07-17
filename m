Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C6D755A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 05:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjGQDTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 23:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjGQDTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 23:19:46 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7306813E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 20:19:45 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R46l22hvyzBHYMH
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:19:42 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689563982; x=1692155983; bh=d4ObllqL7W+vYI3+pZosV4oHgj9
        n3i99scVDxsj7EKw=; b=lo4FLgloMO/hOgBiiP0ZcjbGEAbecfJYbdzDV6nY0Pu
        iQA2AWpQzUKrxo4Vj0zLvAgH80H1ina5FnUUw0NJOZ+tz1AbiZL3ES7aUdvqa5nn
        7NF+hz7wd60ZHNqv0agBzmPy23X6VRyTfA3ZHFAgtENvISL4RTclxzKjSF7FpYmZ
        cP+3AKdmRKYdsqNdDX79BcYqbsgG5W9nRQcu5ZcijEGAVGxWtS2WoVkbJaEapheb
        YnngarTpFMhIF2WF/4CmBgVhU/Le+vQn4Ff9E2FdTvcGk8Y6rwrROue3R9+rrwS8
        h2FEEdx3KhbFjP1VzPBo57N0aD4on8EalGcuQJ+9sRw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DLoaay7-iTyG for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 11:19:42 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R46l20f1DzBHYMC;
        Mon, 17 Jul 2023 11:19:42 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 11:19:41 +0800
From:   hanyu001@208suo.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: Convert snprintf to scnprintf
In-Reply-To: <tencent_BEB5DAE7D9027BD58E958AE34A443CB4CB08@qq.com>
References: <tencent_BEB5DAE7D9027BD58E958AE34A443CB4CB08@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <f713637fea0c666f0940be6066cba2ea@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/scsi/myrb.c:2143:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/myrb.c:2153:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/myrb.c:2163:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/myrb.c:1889:10-18: WARNING: use scnprintf or sprintf
./drivers/scsi/myrb.c:1770:9-17: WARNING: use scnprintf or sprintf
./drivers/scsi/myrb.c:1906:9-17: WARNING: use scnprintf or sprintf

Signed-off-by: ztt <1549089851@qq.com>
---
  drivers/scsi/myrb.c | 12 ++++++------
  1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index ca2e932dd9b7..7e3712c6e08f 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -1767,7 +1767,7 @@ static ssize_t raid_state_show(struct device *dev,
      int ret;

      if (!sdev->hostdata)
-        return snprintf(buf, 16, "Unknown\n");
+        return scnprintf(buf, 16, "Unknown\n");

      if (sdev->channel == myrb_logical_channel(sdev->host)) {
          struct myrb_ldev_info *ldev_info = sdev->hostdata;
@@ -1886,7 +1886,7 @@ static ssize_t raid_level_show(struct device *dev,

          name = myrb_raidlevel_name(ldev_info->raid_level);
          if (!name)
-            return snprintf(buf, 32, "Invalid (%02X)\n",
+            return scnprintf(buf, 32, "Invalid (%02X)\n",
                      ldev_info->state);
          return snprintf(buf, 32, "%s\n", name);
      }
@@ -1903,7 +1903,7 @@ static ssize_t rebuild_show(struct device *dev,
      unsigned char status;

      if (sdev->channel < myrb_logical_channel(sdev->host))
-        return snprintf(buf, 32, "physical device - not rebuilding\n");
+        return scnprintf(buf, 32, "physical device - not 
rebuilding\n");

      status = myrb_get_rbld_progress(cb, &rbld_buf);

@@ -2140,7 +2140,7 @@ static ssize_t ctlr_num_show(struct device *dev,
      struct Scsi_Host *shost = class_to_shost(dev);
      struct myrb_hba *cb = shost_priv(shost);

-    return snprintf(buf, 20, "%u\n", cb->ctlr_num);
+    return scnprintf(buf, 20, "%u\n", cb->ctlr_num);
  }
  static DEVICE_ATTR_RO(ctlr_num);

@@ -2150,7 +2150,7 @@ static ssize_t firmware_show(struct device *dev,
      struct Scsi_Host *shost = class_to_shost(dev);
      struct myrb_hba *cb = shost_priv(shost);

-    return snprintf(buf, 16, "%s\n", cb->fw_version);
+    return scnprintf(buf, 16, "%s\n", cb->fw_version);
  }
  static DEVICE_ATTR_RO(firmware);

@@ -2160,7 +2160,7 @@ static ssize_t model_show(struct device *dev,
      struct Scsi_Host *shost = class_to_shost(dev);
      struct myrb_hba *cb = shost_priv(shost);

-    return snprintf(buf, 16, "%s\n", cb->model_name);
+    return scnprintf(buf, 16, "%s\n", cb->model_name);
  }
  static DEVICE_ATTR_RO(model);
