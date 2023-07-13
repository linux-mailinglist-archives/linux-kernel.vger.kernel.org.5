Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0EF7519E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbjGMH0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbjGMHZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:25:52 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE182D79
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:25:29 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1mMV4h02zBS5q3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 15:24:38 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689233078; x=1691825079; bh=wYJldeuL08DmlYf8zZlrQMIdz9B
        pS1/I/O4xkGnJ224=; b=r7d/c3byIBFbruhDj7IP9juV7pXkCSjVht/NPG9iutZ
        V1s7JS4QGQ0DrMgI3+el4b82skG90autuEZjYpEEUbnHaD3aJPkf3Scy0Yd1HoNi
        3L6tjATLq/PRX79yKP1mkLX1szkiVTZlo3gFihquUVVrx8pmDzkHVImGUwwKmLGs
        vv635Yss7QEzu29rUzbKaRhShh4cXWgQXWjmVVnTmD9a5sqMhg5FnCrK4Kd3aUIy
        yylwbbA1VOVtmsNNGHFgouwWkYNiAr4rS3DtogjGtkXNnlPp7cyZ5/BIhkAKziIV
        n1CiJGvvKtGNV4KQwJKYCkrupwiBMrKsaGL2N7O2Skg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VpaubIqQiBMU for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 15:24:38 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1mMV2hZ2zBRRM0;
        Thu, 13 Jul 2023 15:24:38 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 15:24:38 +0800
From:   hanyu001@208suo.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] scsi: convert sysfs snprintf to sysfs_emit
In-Reply-To: <tencent_C381A3EA994A82F105A2085A965AA4736E07@qq.com>
References: <tencent_C381A3EA994A82F105A2085A965AA4736E07@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <30394ceb9ab9d12b14919234f8bbe67f@208suo.com>
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

Fix the following coccincheck warning:
drivers/usb/misc/usbsevseg.c:170:8-16:
WARNING: use scnprintf or sprintf

WARNING: use scnprintf or sprintf
WARNING: use scnprintf or sprintf

Signed-off-by: ztt <1549089851@qq.com>
---
  drivers/scsi/hptiop.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hptiop.c b/drivers/scsi/hptiop.c
index f5334ccbf2ca..26282aceac75 100644
--- a/drivers/scsi/hptiop.c
+++ b/drivers/scsi/hptiop.c
@@ -1111,7 +1111,7 @@ static int hptiop_adjust_disk_queue_depth(struct 
scsi_device *sdev,
  static ssize_t hptiop_show_version(struct device *dev,
                     struct device_attribute *attr, char *buf)
  {
-    return snprintf(buf, PAGE_SIZE, "%s\n", driver_ver);
+    return scnprintf(buf, PAGE_SIZE, "%s\n", driver_ver);
  }

  static ssize_t hptiop_show_fw_version(struct device *dev,
@@ -1120,7 +1120,7 @@ static ssize_t hptiop_show_fw_version(struct 
device *dev,
      struct Scsi_Host *host = class_to_shost(dev);
      struct hptiop_hba *hba = (struct hptiop_hba *)host->hostdata;

-    return snprintf(buf, PAGE_SIZE, "%d.%d.%d.%d\n",
+    return scnprintf(buf, PAGE_SIZE, "%d.%d.%d.%d\n",
                  hba->firmware_version >> 24,
                  (hba->firmware_version >> 16) & 0xff,
                  (hba->firmware_version >> 8) & 0xff,
