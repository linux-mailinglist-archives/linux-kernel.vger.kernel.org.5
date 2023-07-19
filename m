Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F6F75A144
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjGSWDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjGSWDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:03:45 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBB2213D;
        Wed, 19 Jul 2023 15:03:29 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qMFGL-0008Kc-1x;
        Wed, 19 Jul 2023 22:03:13 +0000
Date:   Wed, 19 Jul 2023 23:03:05 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dave Chinner <dchinner@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Jan Kara <jack@suse.cz>, Daniel Golle <daniel@makrotopia.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Min Li <min15.li@samsung.com>,
        Christian Loehle <CLoehle@hyperstone.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Jack Wang <jinpu.wang@ionos.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yeqi Fu <asuk4.q@gmail.com>, Avri Altman <avri.altman@wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ye Bin <yebin10@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [RFC PATCH 3/6] block: add new genhd flag GENHD_FL_NO_NVMEM
Message-ID: <96510d925cb0ca1a3a132f8f8affd4bbdafd8fc9.1689802933.git.daniel@makrotopia.org>
References: <cover.1689802933.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689802933.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new flag to destinguish block devices which should not act as an
NVMEM provider, such as for example an emulated block device on top of
an MTD partition which already acts as an NVMEM provider itself.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 include/linux/blkdev.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2f5371b8482c0..e853d1815be15 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -80,11 +80,14 @@ struct partition_meta_info {
  * ``GENHD_FL_NO_PART``: partition support is disabled.  The kernel will not
  * scan for partitions from add_disk, and users can't add partitions manually.
  *
+ * ``GENHD_FL_NO_NVMEM``: NVMEM emulation is disabled.  The kernel will not
+ * emulate an NVMEM device on top of this disk.
  */
 enum {
 	GENHD_FL_REMOVABLE			= 1 << 0,
 	GENHD_FL_HIDDEN				= 1 << 1,
 	GENHD_FL_NO_PART			= 1 << 2,
+	GENHD_FL_NO_NVMEM			= 1 << 3,
 };
 
 enum {
-- 
2.41.0
