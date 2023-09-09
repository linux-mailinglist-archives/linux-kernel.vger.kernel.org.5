Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801B7799503
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344473AbjIIAom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjIIAoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:44:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92AF44AB;
        Fri,  8 Sep 2023 17:41:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FCCC4166B;
        Sat,  9 Sep 2023 00:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694220028;
        bh=NZMo8a28i7U4O7fPr6vcTgkZHB8n3jjzm1LpvEa3zVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AL+pOfQqLajuqM5catImuKndrbIbJ1FPT2+aym/dK7Kc58SHu0k1QqC92EtouoNTo
         vGSTkiYVdBtSaRIpeSerHvk/Eq8LcLqjiwbjAgDDZu0tNmvpXwptKsaO1JXzeQrFVP
         d8Sm7CxM8OH3sb/z9SzDtNtxLQ9/s26AAwBWh3J2RM4a6Q8iCELznsHcL3EPNW+Wg9
         /XSqWjx6LAf/YMZYjbzjkNjiHW2mmzJxBHBl+1rsJ/8mzuwJYbtA/7z1v5ggpzLeIM
         pA2IdYFXFffgtG4StCYZqc2EQrAuPpYkcEjo1YGl87wDQEDINv1+IzX13oHyI8+HA/
         fZmAXX9h4uVEw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 06/14] iio: core: Use min() instead of min_t() to make code more robust
Date:   Fri,  8 Sep 2023 20:40:06 -0400
Message-Id: <20230909004015.3580832-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909004015.3580832-1-sashal@kernel.org>
References: <20230909004015.3580832-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.256
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
index 485b2e6748c59..52e10df70c079 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -328,7 +328,7 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
 	char buf[80];
 	int ret;
 
-	count = min_t(size_t, count, (sizeof(buf)-1));
+	count = min(count, sizeof(buf) - 1);
 	if (copy_from_user(buf, userbuf, count))
 		return -EFAULT;
 
-- 
2.40.1

