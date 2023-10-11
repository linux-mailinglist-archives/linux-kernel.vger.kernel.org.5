Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DE27C550B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346724AbjJKNOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjJKNOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:14:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F348F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:14:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898F2C433C8;
        Wed, 11 Oct 2023 13:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697030078;
        bh=m+J9DmKi3n5quBZyx0x3cvUP5ckHR1xIj1RRXPRYTE8=;
        h=From:To:Cc:Subject:Date:From;
        b=KF2a7+Uq4w19aHKrFHCd3Ql1I8MzBUEtTHR/2tv74lgaV5FP3yJBr2a/hoSldL0sD
         RG8i6nr+OzNBBepCkEQzo6FtjkD1UbnTVREOPDCuyly0d0VzwO7tdOW9MVTL4tgM62
         pQGdVs4kRU7pgFUyCc6oQk6mwf2KLQTUEbXmYOOFVEtggzR4+h0Snogcp2wuzqMA7z
         dPVsVKNktPiiAV1jxasczvr+oIUcBAcW2WY8YpCyPVuh9gw5JT/Kai4QjpKT9XOc5U
         ixJQWgpKVaKWZeevXf9EfBtsCs0CzInGLRfwymTXJKY/N2f9RS+rDS4pj0yeX2GRKK
         qrsDY9yzWfn9g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yang Yang <yang.yang29@zte.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sebastian Reichel <sre@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] of: rexport of_find_next_cache_node()
Date:   Wed, 11 Oct 2023 15:14:08 +0200
Message-Id: <20231011131431.2559029-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

This function is now called from a cpufreq driver, but that breaks the
build when the caller is in a loadable module, because of a missing
export:

ERROR: modpost: "of_find_next_cache_node" [drivers/cpufreq/qcom-cpufreq-nvmem.ko] undefined!

Export this as a GPL-only symbol, like the other related functions in
this file.

Fixes: 7683a63c08ff5 ("cpufreq: qcom-nvmem: create L2 cache device")
Fixes: a3e31b4588443 ("of: Move definition of of_find_next_cache_node into common code.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/of/base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 8d93cb6ea9cde..c4cf558e60d92 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1905,6 +1905,7 @@ struct device_node *of_find_next_cache_node(const struct device_node *np)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(of_find_next_cache_node);
 
 /**
  * of_find_last_cache_level - Find the level at which the last cache is
-- 
2.39.2

