Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4813E751F46
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbjGMKsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbjGMKr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:47:56 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F54F2683;
        Thu, 13 Jul 2023 03:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1689245273;
  x=1720781273;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=xM/3mEoxCUQ/wZ0ZwtpBg5cBzRBduFqs5j7ewLkHOEQ=;
  b=Cfj+QTPAjczSEviwfNA4ssljkdrCY9ySj0BN9JpLHCm5NbSC72xjKTmk
   2vQwwUeJjp10+ehYzHLl89aSVjCUFKH1Bsd/9vF4rhhkb9XV828rZ2L+H
   RCnNB0eylM6PJMwMGn9ccmsqQSIbapAwWq1sSx6Ui9ReZGcyinRvXUenn
   BFQ+IQMeXaZ983gr+l8hluUWLhO9544/RzbJbV1lfISigJfMF7wM9HfVx
   PjUZz/NSTc4ITH5Bx7s1DX+UBUfRWTXpAqiDZaNAjv8D5f86CTkBEnpCJ
   mMaOY2njX6tOzAhDw+xUeDQahmKuRA7XvgG+F6UmSaQTLJEiSqb0nURs/
   w==;
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <kernel@axis.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: Fix return value check for set_trigger_state()
Date:   Thu, 13 Jul 2023 12:47:31 +0200
Message-ID: <pndv8eojdey.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In `iio_trigger_detach_poll_func()` the return value from
`trig->ops->set_trigger_state(trig, false)` is checked with `if (ret)`.
However, in `iio_trigger_attach_poll_func()` it is checked with
`if (ret < 0)`. Fix this mismatch by only checking for `if (ret)` in
both places.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/iio/industrialio-trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index f207e36b12cc..18f83158f637 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -313,7 +313,7 @@ int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 	/* Enable trigger in driver */
 	if (trig->ops && trig->ops->set_trigger_state && notinuse) {
 		ret = trig->ops->set_trigger_state(trig, true);
-		if (ret < 0)
+		if (ret)
 			goto out_free_irq;
 	}
 
-- 
2.30.2

