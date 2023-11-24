Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713A07F78A0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345550AbjKXQKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjKXQK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:10:28 -0500
X-Greylist: delayed 324 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Nov 2023 08:10:32 PST
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2DD19A6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:10:32 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700841906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NktJjNztL6a9VBLs/6z7OLOrm+oRflq1cbNxypOGnd4=;
        b=i+W8szTlF1ZX//o0zn3QXAeuBOk3WNLnWrfX5T3uvLsnI36AB7e/JcQq1ZVfElXuFUCQXz
        qpCWKdhKVria4lWjdzd3wZ9V2f5GIGFYJH3nIjNlrv9obtGy0dGn2kphhkIOrUMcO7FLV5
        mNDt4JzjkDsY9M8Yk0SE0GLdTzj/1WE=
From:   Sergei Shtepa <sergei.shtepa@linux.dev>
To:     axboe@kernel.dk, hch@infradead.org, corbet@lwn.net,
        snitzer@kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de,
        christian.koenig@amd.com, yi.l.liu@intel.com, jirislaby@kernel.org,
        stfrench@microsoft.com, jpanis@baylibre.com, jgg@ziepe.ca,
        contact@emersion.fr, dchinner@redhat.com, jack@suse.cz,
        linux@weissschuh.net, min15.li@samsung.com, dlemoal@kernel.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH v6 01/11] documentation: Block Device Filtering Mechanism
Date:   Fri, 24 Nov 2023 17:04:49 +0100
Message-Id: <20231124160459.26227-2-sergei.shtepa@linux.dev>
In-Reply-To: <20231124160459.26227-1-sergei.shtepa@linux.dev>
References: <20231124160459.26227-1-sergei.shtepa@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Shtepa <sergei.shtepa@veeam.com>

The document contains:
* Describes the purpose of the mechanism
* A little historical background on the capabilities of handling I/O
  units of the Linux kernel
* Brief description of the design
* Reference to interface description

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 Documentation/block/blkfilter.rst | 66 +++++++++++++++++++++++++++++++
 Documentation/block/index.rst     |  1 +
 MAINTAINERS                       |  6 +++
 3 files changed, 73 insertions(+)
 create mode 100644 Documentation/block/blkfilter.rst

diff --git a/Documentation/block/blkfilter.rst b/Documentation/block/blkfilter.rst
new file mode 100644
index 000000000000..4e148e78f3d4
--- /dev/null
+++ b/Documentation/block/blkfilter.rst
@@ -0,0 +1,66 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================================
+Block Device Filtering Mechanism
+================================
+
+The block device filtering mechanism provides the ability to attach block
+device filters. Block device filters allow performing additional processing
+for I/O units.
+
+Introduction
+============
+
+The idea of handling I/O units on block devices is not new. Back in the
+2.6 kernel, there was an undocumented possibility of handling I/O units
+by substituting the make_request_fn() function, which belonged to the
+request_queue structure. But none of the in-tree kernel modules used this
+feature, and it was eliminated in the 5.10 kernel.
+
+The block device filtering mechanism returns the ability to handle I/O units.
+It is possible to safely attach a filter to a block device "on the fly" without
+changing the structure of the block device's stack.
+
+It supports attaching one filter to one block device, because there is only
+one filter implementation in the kernel yet.
+See Documentation/block/blksnap.rst.
+
+Design
+======
+
+The block device filtering mechanism provides registration and unregistration
+for filter operations. The struct blkfilter_operations contains a pointer to
+the callback functions for the filter. After registering the filter operations,
+the filter can be managed using block device ioctls BLKFILTER_ATTACH,
+BLKFILTER_DETACH and BLKFILTER_CTL.
+
+When the filter is attached, the callback function is called for each I/O unit
+for a block device, providing I/O unit filtering. Depending on the result of
+filtering the I/O unit, it can either be passed for subsequent processing by
+the block layer, or skipped.
+
+The filter can be implemented as a loadable module. In this case, the filter
+module cannot be unloaded while the filter is attached to at least one of the
+block devices.
+
+Interface description
+=====================
+
+The ioctl BLKFILTER_ATTACH allows user-space programs to attach a block device
+filter to a block device. The ioctl BLKFILTER_DETACH allows user-space programs
+to detach it. Both ioctls use &struct blkfilter_name. The ioctl BLKFILTER_CTL
+allows user-space programs to send a filter-specific command. It use &struct
+blkfilter_ctl.
+
+.. kernel-doc:: include/uapi/linux/blk-filter.h
+
+To register in the system, the filter uses the &struct blkfilter_operations,
+which contains callback functions, unique filter name and module owner. When
+attaching a filter to a block device, the filter creates a &struct blkfilter.
+The pointer to the &struct blkfilter allows the filter to determine for which
+block device the callback functions are being called.
+
+.. kernel-doc:: include/linux/blk-filter.h
+
+.. kernel-doc:: block/blk-filter.c
+   :export:
diff --git a/Documentation/block/index.rst b/Documentation/block/index.rst
index 9fea696f9daa..e9712f72cd6d 100644
--- a/Documentation/block/index.rst
+++ b/Documentation/block/index.rst
@@ -10,6 +10,7 @@ Block
    bfq-iosched
    biovecs
    blk-mq
+   blkfilter
    cmdline-partition
    data-integrity
    deadline-iosched
diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cf..c20cbec81b58 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3584,6 +3584,12 @@ M:	Jan-Simon Moeller <jansimon.moeller@gmx.de>
 S:	Maintained
 F:	drivers/leds/leds-blinkm.c
 
+BLOCK DEVICE FILTERING MECHANISM
+M:	Sergei Shtepa <sergei.shtepa@veeam.com>
+L:	linux-block@vger.kernel.org
+S:	Supported
+F:	Documentation/block/blkfilter.rst
+
 BLOCK LAYER
 M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-block@vger.kernel.org
-- 
2.20.1

