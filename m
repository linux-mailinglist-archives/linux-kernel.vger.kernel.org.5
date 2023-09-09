Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD127994CA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345942AbjIIAk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345934AbjIIAjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:39:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2484E2712;
        Fri,  8 Sep 2023 17:38:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E3BC43140;
        Sat,  9 Sep 2023 00:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219914;
        bh=k0w5Ey5Ue52pB+mKY7nXANMkK2lIfk94w3cPbdapbvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXqI8w6vzd+MBK+xeqXyaB+92vnxiP/lTq7itwGTnQvfLnPPumkD/Jp61Yo6I90Ul
         O8yK8iL/zd3Uyhgz9NywsoKVDI89fNN9J+mmNC1usj/fYaO8Jb0jICyVJekdk1qQFF
         oQIlJWFnrFsgZiRoz+7K5Tpo87eX8FsDylbXkccmfq2HkonAWAgKrsQjoWKYbiVZg2
         tQ6s+VNewG7w9aauQURpwUik2QiiK04gM0xaWbWCkEjS8Qo4r50QfZkD20czf6IzRl
         r6Rqe6+ekr7mfz81TBHW80+cUhhgQvVusazL3sxcTVfPwLn43FgvYz5EXXler/H60q
         kP3EClB9/yQIA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 08/24] iio: core: Use min() instead of min_t() to make code more robust
Date:   Fri,  8 Sep 2023 20:38:00 -0400
Message-Id: <20230909003818.3580081-8-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003818.3580081-1-sashal@kernel.org>
References: <20230909003818.3580081-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit cb1d17535061ca295903f97f5cb0af9db719c02c ]

min() has strict type checking and preferred over min_t() for
unsigned types to avoid overflow. Here it's unclear why min_t()
was chosen since both variables are of the same type. In any
case update to use min().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20230721170022.3461-5-andriy.shevchenko@linux.intel.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/industrialio-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f3f8392623a46..354e7ee0c51c3 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -417,7 +417,7 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
 	char buf[80];
 	int ret;
 
-	count = min_t(size_t, count, (sizeof(buf)-1));
+	count = min(count, sizeof(buf) - 1);
 	if (copy_from_user(buf, userbuf, count))
 		return -EFAULT;
 
-- 
2.40.1

