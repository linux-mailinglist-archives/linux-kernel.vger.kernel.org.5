Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7518E783ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjHVLbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbjHVLbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:31:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D4EE4C;
        Tue, 22 Aug 2023 04:31:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 072F86361C;
        Tue, 22 Aug 2023 11:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81B1C433C8;
        Tue, 22 Aug 2023 11:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692703872;
        bh=BrBQtiNIqOrM7b9cP7Tksks7Q1e/7X1t5PRWBq99mHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vg4gXAVQ56Yc+BCCqHC55kN7kJ0yPEDJuHIMcy4MtAzm/EmYNOn2dCDJwjjKE0Ezq
         dWlwfgKGmQH0xGohzJvMGXjhmmu5I6am8I2jYKGovUS0P33qEJrnP9vM17peSNXW/T
         tJ6ImLTn4s4IG3vYJDxQg4WyZn38Eipt8JHzg+2LmqOpUo6+f8TprM3X7S+BguyKdl
         LenPkwnvGlrh37M/0BqW8O8DFlWVJJ40AVrw4Vw4kl1owqqvxZQXchHtP2loi05oQG
         RhRNebMswloJlGjqAqUOK8LPjaNalPzUqFsxaOnGkvT14mzAed04CtHCDfq85j9hb7
         zMEf2gV4ZYPmg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 04/10] Revert "wifi: ath6k: silence false positive -Wno-dangling-pointer warning on GCC 12"
Date:   Tue, 22 Aug 2023 07:30:54 -0400
Message-Id: <20230822113101.3549915-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822113101.3549915-1-sashal@kernel.org>
References: <20230822113101.3549915-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.11
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

From: Kalle Valo <kvalo@kernel.org>

[ Upstream commit a1ce186db7f0e449f35d12fb55ae0da2a1b400e2 ]

This reverts commit bd1d129daa3ede265a880e2c6a7f91eab0f4dc62.

The dangling-pointer warnings were disabled kernel-wide by commit 49beadbd47c2
("gcc-12: disable '-Wdangling-pointer' warning for now") for v5.19. So this
hack in ath6kl is not needed anymore.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230724100823.2948804-1-kvalo@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath6kl/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/Makefile b/drivers/net/wireless/ath/ath6kl/Makefile
index a75bfa9fd1cfd..dc2b3b46781e1 100644
--- a/drivers/net/wireless/ath/ath6kl/Makefile
+++ b/drivers/net/wireless/ath/ath6kl/Makefile
@@ -36,11 +36,6 @@ ath6kl_core-y += wmi.o
 ath6kl_core-y += core.o
 ath6kl_core-y += recovery.o
 
-# FIXME: temporarily silence -Wdangling-pointer on non W=1+ builds
-ifndef KBUILD_EXTRA_WARN
-CFLAGS_htc_mbox.o += $(call cc-disable-warning, dangling-pointer)
-endif
-
 ath6kl_core-$(CONFIG_NL80211_TESTMODE) += testmode.o
 ath6kl_core-$(CONFIG_ATH6KL_TRACING) += trace.o
 
-- 
2.40.1

