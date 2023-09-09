Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1D57994E0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346244AbjIIAns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346084AbjIIAnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:43:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C71273F;
        Fri,  8 Sep 2023 17:40:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2683DC43395;
        Sat,  9 Sep 2023 00:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219996;
        bh=P4qbOjdR/nYDCmzjET6WTsY2fVqvZ/QQieCnmICiY6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jg9fUYXKl37Glu4MMsj3lq9PYxdOnfuZQsFHodbg9kS0T7QE8d4BPBxd3P5Xfialp
         TGlz+BTDyqjjternbG+QJQsWLIw3u4mprbwBPETvme7FCcSS2gzDfKjH8b6Pb0gYtD
         GjSboT9+9QFAEkLDoeQwCZaUBpDeb1oILg5RBIBB8goXCfC9GaRqIkKCd+Ryqn63Vc
         MSZ98ykfM7bwRIyt4jkhI88zfalI4I7KF53pYQ1esaJp/vowHo0qjp3GevbkviAoip
         xW+uHyBID9T4jTCDHcQ9ZfZF2LtFMPVKUGhmLFACPbedmo+LkRoIu1uAiwisjA7gqE
         6Yt0iUEjWWxyw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 07/16] iio: core: Use min() instead of min_t() to make code more robust
Date:   Fri,  8 Sep 2023 20:39:32 -0400
Message-Id: <20230909003941.3580631-7-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003941.3580631-1-sashal@kernel.org>
References: <20230909003941.3580631-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.194
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
index 261d3b17edc9a..5b24b5bcc18e0 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -361,7 +361,7 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
 	char buf[80];
 	int ret;
 
-	count = min_t(size_t, count, (sizeof(buf)-1));
+	count = min(count, sizeof(buf) - 1);
 	if (copy_from_user(buf, userbuf, count))
 		return -EFAULT;
 
-- 
2.40.1

