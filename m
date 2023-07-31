Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AFF7690FC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjGaJAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbjGaJAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2666012A;
        Mon, 31 Jul 2023 02:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A005A60E15;
        Mon, 31 Jul 2023 09:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF83C433BC;
        Mon, 31 Jul 2023 09:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690794016;
        bh=UKla50+Uu6d8/OdvxC4FOiwYL61SGfFkX9ZDiS9YrP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VsDhmvWgW4QZM9grPr7Cmj5HuYUV+q6S0yZcCcletfKskOV1KilnuWr9R2f5hYlmB
         RpGt8f9Nj4QJD8RIuvywgYrvF/mJT9MpkJkz4UcPSnea0Ipi/huU1GvTXwdjhUOMpo
         h711XjUFkyGMXpaCo3G1+ZWoBy2/uBOz+V452i9gnLgZayHVFT+BQts6CB9YNz/SUv
         IR+isv6ZrYVCe4OFwG6xWmUEDRAF40ILue5U+rVCtWS/V5sCG7fVtX54D0YXlhbXqE
         +5Yn7gC40Kh8LbDPzWkIuLKM1bXwLLWzz0uLdOYP86wLCNhzueN1fo4ENb7L3zeHbn
         /9P9s7OCX3UzQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH 7/7] tty: synclink_gt: mark as BROKEN
Date:   Mon, 31 Jul 2023 11:00:02 +0200
Message-ID: <20230731090002.15680-8-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731090002.15680-1-jirislaby@kernel.org>
References: <20230731090002.15680-1-jirislaby@kernel.org>
MIME-Version: 1.0
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

After walking and trying to clean up the worst in the driver, I came
across the pci_driver::remove() _empty_ implementation. That would crash
the system at least during hot-unplug (or write to remove in sysfs).

There are many other problems:
* Initialization + deinitialization apparently comes from no-hotplug
  support age. It needs a rewrite.
* Hairy debug macros. Drop them.
* Use of self-baked lists. Replace by list.
* The order of the functions should be inverted and fwd decls dropped.
* Coding style from the stone age. Fix.
* I assume there are many bugs, but the code is unreadable at times, so
  hard to judge. There is one example posted [1].

I was able to find only one user back in 2016. So mark the driver as
BROKEN for some time. Either someone will notice and we can bring the
driver to this century. Or we will drop it completely if noone cares.

[1] https://lore.kernel.org/all/20230728123901.64225-1-dg573847474@gmail.com/

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/tty/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 341abaed4ce2..907a7cb1d186 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -236,6 +236,7 @@ config MOXA_SMARTIO
 config SYNCLINK_GT
 	tristate "SyncLink GT/AC support"
 	depends on SERIAL_NONSTANDARD && PCI
+	depends on BROKEN
 	help
 	  Support for SyncLink GT and SyncLink AC families of
 	  synchronous and asynchronous serial adapters
-- 
2.41.0

