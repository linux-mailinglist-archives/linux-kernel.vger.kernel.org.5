Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E49F7DC52E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 05:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbjJaEJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 00:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJaEJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 00:09:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E48C0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 21:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Cm7wzuH90vimQPyA1MAWxOBXUh0ZmX/mfwrQf/vnoaI=; b=hg4aZ7bZ+P68XcDNuMA+W83Ix7
        IuAPauuIV22ASzDqQeJNucLIVfmEKamSiz7L+lqLsvl7oL4Y0PMkNyngSNGwMF2L6BXXhdDFTnjOY
        Nz3b5/gMioSnLmG45qgOrZ115mb0JeUIYaFfc07OLvm7KfVQqtG7knyGCT4rgRb5gMs/c5kZaSg27
        8VL1hM4gBP/9HIUQBjy6ZqIbomrebipEg6UtZYWVI5BD6tPOlYvJTQmB70c4L3XC6BUyN9o45CLg6
        pB3ir1X7UqaURtJfHB+8PBExDOMaIebnDif1/dpt18R8s/C0K/SIi6NOa2536a7Scwg8YPVF8+HiU
        /9Aw8Igg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qxg3x-004VG8-2x;
        Tue, 31 Oct 2023 04:09:09 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ayush Singh <ayushdevel1325@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org
Subject: [PATCH] greybus: BeaglePlay driver needs CRC_CCITT
Date:   Mon, 30 Oct 2023 21:09:09 -0700
Message-ID: <20231031040909.21201-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gb-beagleplay driver uses crc_ccitt(), so it should select
CRC_CCITT to make sure that the function is available.

Fixes these build errors:

s390-linux-ld: drivers/greybus/gb-beagleplay.o: in function `hdlc_append_tx_u8':
gb-beagleplay.c:(.text+0x2c0): undefined reference to `crc_ccitt'
s390-linux-ld: drivers/greybus/gb-beagleplay.o: in function `hdlc_rx_frame':
gb-beagleplay.c:(.text+0x6a0): undefined reference to `crc_ccitt'

Fixes: ec558bbfea67 ("greybus: Add BeaglePlay Linux Driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ayush Singh <ayushdevel1325@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: greybus-dev@lists.linaro.org
---
 drivers/greybus/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/greybus/Kconfig b/drivers/greybus/Kconfig
--- a/drivers/greybus/Kconfig
+++ b/drivers/greybus/Kconfig
@@ -20,6 +20,7 @@ if GREYBUS
 config GREYBUS_BEAGLEPLAY
 	tristate "Greybus BeaglePlay driver"
 	depends on SERIAL_DEV_BUS
+	select CRC_CCITT
 	help
 	  Select this option if you have a BeaglePlay where CC1352
 	  co-processor acts as Greybus SVC.
