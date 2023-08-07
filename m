Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A7E771C37
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjHGIY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjHGIY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:24:27 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A5A10EF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:24:25 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A4D8E0006;
        Mon,  7 Aug 2023 08:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691396664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bS+vOtPyOkEkdV/nhm5MLbH36mndj+2cFLrBIoA8aFE=;
        b=h9ITThFrDAL4gw+CgsF85+DiojEI16eg8zukQy7IymB5qM5FbBKLO6ipVnaRE6SacEkjhR
        7L5nvgEVIMngiuqj/R8yhL2FvmRtjUJnhhYZfLNxW+991cKBuKouJdVzRP1qABsEAgC+56
        kfcX22kxvOX2XfiHYyEi5tHD4QzMsbGm9szl+2N/eau5vaDcv9xD/th32j7JuWEfzJrZ1J
        ZvXqBfnkzJczCDU6Qc8zrnVeaDDvmugqDscjpfUUQGKESVtse+EkpWp+noLVd8woI39s8b
        K2kZLQh7PjdPV9Uw98gWvYnAGFsQmefUbD6gnompMMStJg+FTKDL7WpoD3SrGg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>,
        <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v8 2/8] nvmem: core: Return NULL when no nvmem layout is found
Date:   Mon,  7 Aug 2023 10:24:13 +0200
Message-Id: <20230807082419.38780-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807082419.38780-1-miquel.raynal@bootlin.com>
References: <20230807082419.38780-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, of_nvmem_layout_get_container() returns NULL on error, or an
error pointer if either CONFIG_NVMEM or CONFIG_OF is turned off. We
should likely avoid this kind of mix for two reasons: to clarify the
intend and anyway fix the !CONFIG_OF which will likely always if we use
this helper somewhere else. Let's just return NULL when no layout is
found, we don't need an error value here.

Link: https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/
Fixes: 266570f496b9 ("nvmem: core: introduce NVMEM layouts")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202308030002.DnSFOrMB-lkp@intel.com/
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

---

Backports to stable kernels is likely not needed as I believe the error
pointer will be discarded "magically" by the of/ code.
---
 include/linux/nvmem-consumer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index fa030d93b768..27373024856d 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -256,7 +256,7 @@ static inline struct nvmem_device *of_nvmem_device_get(struct device_node *np,
 static inline struct device_node *
 of_nvmem_layout_get_container(struct nvmem_device *nvmem)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return NULL;
 }
 #endif /* CONFIG_NVMEM && CONFIG_OF */
 
-- 
2.34.1

