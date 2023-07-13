Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903CE751E08
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbjGMJ7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjGMJ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:59:16 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F1C2715
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:58:56 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1qnN3y78zBJZPd
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 17:58:48 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689242328; x=1691834329; bh=kMG6L6aTz3HXslWmgs2PL+TRvoT
        bhhiW08h5RxD8hbo=; b=j5xec6r0oMNLr83q2ky5L/K9sgvL1AnCVCdOpMMsKR2
        UhjRUtCw4/zKDi4m/fPx6UMmNSX6rvAyEdqkmRqaIsBtkb24aYWLSJXi2pdiBo67
        TwBVKqupI8r1YnesSHCi9BrpsaBUpljdq9maH6TlVgkYzF/lpuJombRbKWtDc4cH
        gLmfN6mRaaKvQq4/pLRnQ4onyRtl1sOSnJdMYwhp4zTnOYbe9o1yb22ZSomTCAYX
        GF45+EmRdMjucJLrKlimgy+VY0ddo87QKTBJTg7nqEX32SgxOZgozpaDuGla/yfX
        z53hKx5WDwH+g80qnNslrZjOtvIf0+bk7MofDRtcK1Q==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BdpFNueddxXW for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 17:58:48 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1qnN2cvhzBJ96K;
        Thu, 13 Jul 2023 17:58:48 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 17:58:48 +0800
From:   hanyu001@208suo.com
To:     stuyoder@gmail.com, laurentiu.tudor@nxp.com
Cc:     linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] bus: fsl-mc: replace snprintf in show functions with
 sysfs_emit
In-Reply-To: <tencent_FA44C0B483B542E72F0227D54F9516E3EA08@qq.com>
References: <tencent_FA44C0B483B542E72F0227D54F9516E3EA08@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <dcf60154f976e9457a937e20626d0a6a@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

show() should not use snprintf() when formatting the value to be
returned to user space.

Fix the following coccicheck warning:
drivers/media/i2c/ccs/ccs-core.c:3761: WARNING: use scnprintf or 
sprintf.

./drivers/bus/fsl-mc/fsl-mc-bus.c:204:8-16: WARNING: use scnprintf or 
sprintf

Signed-off-by: ztt <1549089851@qq.com>
---
  drivers/bus/fsl-mc/fsl-mc-bus.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c 
b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 4352745a923c..c28bde570cb1 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -201,7 +201,7 @@ static ssize_t driver_override_show(struct device 
*dev,
  {
      struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);

-    return snprintf(buf, PAGE_SIZE, "%s\n", mc_dev->driver_override);
+    return scnprintf(buf, PAGE_SIZE, "%s\n", mc_dev->driver_override);
  }
  static DEVICE_ATTR_RW(driver_override);
