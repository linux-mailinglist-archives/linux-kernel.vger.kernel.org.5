Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152B477B770
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjHNLTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbjHNLTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:19:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B91EE61;
        Mon, 14 Aug 2023 04:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692011955; x=1723547955;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZhSEjoUXC35XUl0gMa0VRDhMcqAcBMwzp6bvDUO45qQ=;
  b=MfXzdbDQhHQ9Ye5pbL5rhlIEH1uOK8q2eH5BN2pFNmfqUJJc51IYemVW
   eECFiHjzGM49czWpwTpjQ+NuCxvPWVUkDpPU1MaYhFn6R44eVQsRIdDfJ
   2gjlUQ8YsYWr7eonxBWdEkd/dOgJ+CN238jzYUpI/moNHlNbCG+HfvXYm
   5jn+ODTzyb4tFsdRIvihtqmfIKNwjv/C1BCCVB8ZbeguqpNHoMGbRP0gE
   4KZs3i+PGwqVYHtC52Iy3z8Ap78qi1OWobsXB+0v94RRf6enpTo2XHOf/
   IEn/EDxs69AV5vYu0oAY8/YysTGqsAdUxrErTndN63BvZ7zPjv9bFdCWK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="370913965"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="370913965"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 04:18:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="857049356"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="857049356"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 14 Aug 2023 04:18:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 38412374; Mon, 14 Aug 2023 14:26:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v1 1/1] gpiolib: sysfs: Do unexport GPIO when user asks for it
Date:   Mon, 14 Aug 2023 14:26:15 +0300
Message-Id: <20230814112615.42448-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that sysfs interface implicitly relied on the gpiod_free()
to unexport the line. This is not good and prone to regressions.
Fix it by explicitly calling gpiod_unexport().

Fixes: b0ce9ce408b6 ("gpiolib: Do not unexport GPIO on freeing")
Reported-by: Marek Behún <kabel@kernel.org>
Closes: https://lore.kernel.org/r/20230808102828.4a9eac09@dellmb
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Marek Behún <kabel@kernel.org>
---
 drivers/gpio/gpiolib-sysfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 530dfd19d7b5..50503a4525eb 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -515,8 +515,9 @@ static ssize_t unexport_store(const struct class *class,
 	 * they may be undone on its behalf too.
 	 */
 	if (test_and_clear_bit(FLAG_SYSFS, &desc->flags)) {
+		gpiod_unexport(desc);
+		gpiod_free(desc);
 		status = 0;
-		gpiod_free(desc);
 	}
 done:
 	if (status)
@@ -781,8 +782,10 @@ void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 	mutex_unlock(&sysfs_lock);
 
 	/* unregister gpiod class devices owned by sysfs */
-	for_each_gpio_desc_with_flag(chip, desc, FLAG_SYSFS)
+	for_each_gpio_desc_with_flag(chip, desc, FLAG_SYSFS) {
+		gpiod_unexport(desc);
 		gpiod_free(desc);
+	}
 }
 
 static int __init gpiolib_sysfs_init(void)
-- 
2.40.0.1.gaa8946217a0b

