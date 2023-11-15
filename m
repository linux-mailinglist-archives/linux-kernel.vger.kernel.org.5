Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F727EBC5D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbjKODnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjKODnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:43:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AED1B8;
        Tue, 14 Nov 2023 19:42:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A29FC433C8;
        Wed, 15 Nov 2023 03:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700019773;
        bh=yN8yC7Ian6+pDeHYcYG2ppXHfWI5M/c+8L5DzjrbU54=;
        h=From:To:Cc:Subject:Date:From;
        b=SXhOHM8g5m3BzFwldYp6UvW9XA0ObzjCnZpPTecPryHnsfvdsK2ar+HYuXc4/EnRO
         wYSpCsyAyn5DQBTVEKdJ2f4xVufaC8Al4Lg29zEDwf8mMvBdbb6r8GveaMRQMrRy9v
         WNiE98ZeiBK5UnU7+VCHpVjtp4tNzP26nDRko2xBXFGvwHdeyWtdDdZskQBakKyRnd
         uAVzTszFEwYsPxrIMiCfv1grs98c41DDgzj4jNC1M6p/o6gG9+I1s0IvOmJowEQyhO
         HTUvM5VjhYdAReq4avJx0WXg/HVWdRo/m3/v2NFA+dZLvFqXwA/fCoRzWgoAEPvhLT
         kueVpJOapt+4A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19] pwm: Fix double shift bug
Date:   Tue, 14 Nov 2023 22:42:28 -0500
Message-ID: <20231115034230.1243196-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.298
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit d27abbfd4888d79dd24baf50e774631046ac4732 ]

These enums are passed to set/test_bit().  The set/test_bit() functions
take a bit number instead of a shifted value.  Passing a shifted value
is a double shift bug like doing BIT(BIT(1)).  The double shift bug
doesn't cause a problem here because we are only checking 0 and 1 but
if the value was 5 or above then it can lead to a buffer overflow.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pwm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index bd7d611d63e91..c6e981035c3fd 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -44,8 +44,8 @@ struct pwm_args {
 };
 
 enum {
-	PWMF_REQUESTED = 1 << 0,
-	PWMF_EXPORTED = 1 << 1,
+	PWMF_REQUESTED = 0,
+	PWMF_EXPORTED = 1,
 };
 
 /*
-- 
2.42.0

