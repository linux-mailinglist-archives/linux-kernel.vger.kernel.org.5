Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63ED7F2053
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjKTW2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjKTW2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:28:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CCD97
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:28:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402C8C433CA;
        Mon, 20 Nov 2023 22:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700519320;
        bh=lm7/gVjjO8J4rGGfH0O5RParZfMnIY0MkOc5Mwd5oTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJEQgwWOw+C7D8EhdvrVMZGCGeW51hRnSqEgzzkovWfmgQZMVejOyWW90TicHb9cR
         gSuTbi++TH6DeMRHW/0c5TzfwIwNeGFQI1O05cgt+tppgBXm5jGFvRdjVgl7CEQPSG
         j34REcfh1n/ag9wx3CAbciOYaMpeSuTe626Yp/Sb2pNWrJWSJBYXuFiwTDY4NGDxjh
         I/i0WB+FRhUzRsrM2jO4NFPJpU4YMC2hdETD5U/ddBm1Ld6E0JV0RSvHSttknPFIbs
         /rxAFZzE2O7NnLymcPwM08tbl4uXprn6CswuwexRlXliDejuQl35/tfySjABuERuhH
         KRpgUP7nAUk3A==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/2] pinctrl: pinconf-generic: remove the special handling for no config case
Date:   Tue, 21 Nov 2023 07:28:32 +0900
Message-Id: <20231120222832.4063882-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231120222832.4063882-1-masahiroy@kernel.org>
References: <20231120222832.4063882-1-masahiroy@kernel.org>
MIME-Version: 1.0
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

To further simplify pinconf_generic_parse_dt_config(), eliminate the
handling of the case where no configuration is found.

When ncfg is zero, krealloc_array() will set ZERO_SIZE_PTR to *configs,
which is a natural approach for managing a zero-size buffer.

This should have no impact because none of the callers accesses 'configs'
when ncfg is zero. Also, it is safe to pass ZERO_SIZE_PTR to kfree().

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/pinctrl/pinconf-generic.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index ba4fe2466e78..252d69ee2b68 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -265,14 +265,6 @@ int pinconf_generic_parse_dt_config(struct device_node *np,
 		parse_dt_cfg(np, pctldev->desc->custom_params,
 			     pctldev->desc->num_custom_params, cfg, &ncfg);
 
-	/* no configs found at all */
-	if (ncfg == 0) {
-		kfree(cfg);
-		*configs = NULL;
-		*nconfigs = 0;
-		return 0;
-	}
-
 	/* Now resize the array to store the real number of found properties. */
 	*configs = krealloc_array(cfg, ncfg, sizeof(unsigned long), GFP_KERNEL);
 	if (!*configs)
-- 
2.40.1

