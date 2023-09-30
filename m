Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A597B44AA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 01:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjI3XoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 19:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbjI3XoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 19:44:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F07BC;
        Sat, 30 Sep 2023 16:44:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABD1C433C9;
        Sat, 30 Sep 2023 23:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696117441;
        bh=olNQkj8edqE39Hnx3Oj7nNyzlOiwbJE3qR/nV/hU2lU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=t9+0HeM8h0NMZd6L6BXOILF3oRLLelLqQKbHHtcpRexMa2pwibfuXvVMkz10D9l9g
         zbi/cFZghVEhwQYSEwtYcvfsDs+l9W1sId6iqzVRafxdSvLgnwDfb6FsQA4A4ZZN4D
         CzM9FR3w18Jd5MCQbr/ixGYJJJsYH1LROEhbXR/s8XkhUK53Mcx1/NmmWYMR8NIkcs
         +JyQaD6RPJ/1EjJrvytF3lD5T2OqJRmr8QRn8HvZffwfsHu2EJPAKWIFwmUPxVAcR6
         asRA1uOOAK/JWd4czR0bR2TW09ciZsfvjYDknDFFy0NnmqfeLRUIdiNIGebGmhLNXU
         AB5LqdShpk0Mw==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 01 Oct 2023 01:43:38 +0200
Subject: [PATCH 1/3] Input: cap11xx - Cache hardware ID registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-input-maple-v1-1-ed3716051431@kernel.org>
References: <20231001-input-maple-v1-0-ed3716051431@kernel.org>
In-Reply-To: <20231001-input-maple-v1-0-ed3716051431@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113; i=broonie@kernel.org;
 h=from:subject:message-id; bh=olNQkj8edqE39Hnx3Oj7nNyzlOiwbJE3qR/nV/hU2lU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlGLK7yToUWh2XoyPoMn9R5B56M56wpY2OnXgw+
 uBZKOGIeFCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRiyuwAKCRAk1otyXVSH
 0D2QB/9GAhS5JfxpCk95gMbZGldAqZxfTAvpSdQoEzf9WjBmnX1dK12RB7ZhFt6eW1p+51vcO/o
 8JwRaAYUsa87GdQ/+Xj02p6bDrU9RCwgykpIC5H2EddPswMHXm9NmJ/NRn0kttH1HaiU6p+Up9R
 oMrprnwBHfvCIeCBH9IUgQNymctk3Eq//BcbnCgS6QdzJPzRey9jUGr7byJdrjL7QwrTQzVnS7a
 C6gLXW3V3wXntawN6nkD4gBc2SIuDNA+cWl9jfmxz7vRjWyzTDrPYim5sA5namnQpuKkm2bDzql
 Q2DILJK67X2ZP7TXeOfRbKfddKaMvBVSpj1xT4jV+sIg7AXT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cap11xx devices have three hardware identification registers which are
currently marked as volatile, preventing caching of those registers. This
is not ideal since the registers should never change at runtime, we should
be able to cache the value after the first read. Stop marking the registers
as volatile, we don't have register defaults specified in the driver so
this will result in reading from the hardware on first use.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/input/keyboard/cap11xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 1b4937dce672..39ed3b9ddc65 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -160,9 +160,6 @@ static bool cap11xx_volatile_reg(struct device *dev, unsigned int reg)
 	case CAP11XX_REG_SENOR_DELTA(3):
 	case CAP11XX_REG_SENOR_DELTA(4):
 	case CAP11XX_REG_SENOR_DELTA(5):
-	case CAP11XX_REG_PRODUCT_ID:
-	case CAP11XX_REG_MANUFACTURER_ID:
-	case CAP11XX_REG_REVISION:
 		return true;
 	}
 

-- 
2.39.2

