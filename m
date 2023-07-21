Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C0675C1DD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjGUImH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGUImF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:42:05 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E48B273A;
        Fri, 21 Jul 2023 01:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=45nbv
        SIDFTeptEDezMNw4kfndw/BNytulwYrUeJEA1g=; b=PiPx8QPjzY3W+RXyCqQoC
        fiTXqkngyWpZGcbFJovC4PUtX+guIckxPEcaDWL45Sy2MGzTGuq1eOIBXzdoUSnz
        Vv7JnaxoUHhz6WGLHaayCkqagub99TGH1MXh6J01KnFA1WtWmKtyYUzjazf58vwy
        olPinapVIxN+WfZ+cVgyGM=
Received: from sc9-mailhost2.vmware.com (unknown [114.253.21.2])
        by zwqz-smtp-mta-g1-4 (Coremail) with SMTP id _____wCXHEKcRLpk9jqAAw--.11481S2;
        Fri, 21 Jul 2023 16:41:01 +0800 (CST)
From:   Dingyan Li <18500469033@163.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        sebastian.reichel@collabora.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: add usbfs ioctl to get specific superspeedplus rates
Date:   Fri, 21 Jul 2023 16:40:39 +0800
Message-Id: <20230721084039.9728-1-18500469033@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCXHEKcRLpk9jqAAw--.11481S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr47Cr15JrWUZr4DtF18Zrb_yoW8WFyxpF
        4kAFy8JFWkWF4S9r18Cay8u3W5WwsxKay5K3429wn09FW3t34ruF1rAry5Cr95Ar4jyr17
        tasxZ34Yg3yxCrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jhrcfUUUUU=
X-Originating-IP: [114.253.21.2]
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/xtbBUR6zy1aEE9sfTwAAs9
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usbfs interface does not provide any way to get specific
superspeedplus rate, like Gen2x1, Gen1x2 or Gen2x2. Current
API include an USBDEVFS_GET_SPEED ioctl, but it can only return
general superspeedplus speed instead of any specific rates.
Therefore we can't tell whether it's a Gen2x2(20Gbps) device.

This patch introduce a new ioctl USBDEVFS_GET_SSP_RATE to fix
it. Similar information is already available via sysfs, it's
good to add it for usbfs too.

Signed-off-by: Dingyan Li <18500469033@163.com>
---
 drivers/usb/core/devio.c          | 3 +++
 include/uapi/linux/usbdevice_fs.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 1a16a8bdea60..2f57eb163360 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -2783,6 +2783,9 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 	case USBDEVFS_GET_SPEED:
 		ret = ps->dev->speed;
 		break;
+	case USBDEVFS_GET_SSP_RATE:
+		ret = ps->dev->ssp_rate;
+		break;
 	case USBDEVFS_FORBID_SUSPEND:
 		ret = proc_forbid_suspend(ps);
 		break;
diff --git a/include/uapi/linux/usbdevice_fs.h b/include/uapi/linux/usbdevice_fs.h
index 74a84e02422a..f5522e910329 100644
--- a/include/uapi/linux/usbdevice_fs.h
+++ b/include/uapi/linux/usbdevice_fs.h
@@ -227,5 +227,6 @@ struct usbdevfs_streams {
 #define USBDEVFS_FORBID_SUSPEND    _IO('U', 33)
 #define USBDEVFS_ALLOW_SUSPEND     _IO('U', 34)
 #define USBDEVFS_WAIT_FOR_RESUME   _IO('U', 35)
+#define USBDEVFS_GET_SSP_RATE      _IO('U', 36)
 
 #endif /* _UAPI_LINUX_USBDEVICE_FS_H */
-- 
2.25.1

