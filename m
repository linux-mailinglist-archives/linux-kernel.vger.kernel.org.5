Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6B6785721
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbjHWLvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjHWLvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:51:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC32CCF;
        Wed, 23 Aug 2023 04:50:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C44561B0B;
        Wed, 23 Aug 2023 11:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E939C433CB;
        Wed, 23 Aug 2023 11:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692791457;
        bh=KumweqIbBGlQu/QW8/T6YUQUSRrF4UR/0XH8qL+VBn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJK7LN11MkN21EN+wnv0xeHHquHZoCJ5HNP9a77L2swSRzM+PsNSB5zTSAP2Tr9RE
         3YCqblj4Ko78zSmsMU67ZLl08u3SJmPIbcaEwG/sPQicTyQOvFr+HTs5RnyOSyf3Vx
         QPtGYRoJtjv3gfMreOa5AkKd7D9WR55Go2HPI1DvzFiG5gA7+kO9d291nTt2vGDJk7
         zmO0/K0iF1OewUVu4NXOK25skKPuwo8yeZ7czpNStx9kF7IgU7KvOJa7U7cEuvCRen
         c1UcHuB7OBBgi8xCT4jHrMy54Yrqac4m16U7kHnzfqJHH2Di9itS5YeLLu//0L83Ww
         oRKjY8U7U17zA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 2/8] kbuild: add modules_sign to no-{compiler,sync-config}-targets
Date:   Wed, 23 Aug 2023 20:50:42 +0900
Message-Id: <20230823115048.823011-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230823115048.823011-1-masahiroy@kernel.org>
References: <20230823115048.823011-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like modules_install, modules_sign should avoid the syncconfig.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 7d54a0700c6e..e2dfa3b994f7 100644
--- a/Makefile
+++ b/Makefile
@@ -280,8 +280,8 @@ no-dot-config-targets := $(clean-targets) \
 # Installation targets should not require compiler. Unfortunately, vdso_install
 # is an exception where build artifacts may be updated. This must be fixed.
 no-compiler-targets := $(no-dot-config-targets) install dtbs_install \
-			headers_install modules_install kernelrelease image_name
-no-sync-config-targets := $(no-dot-config-targets) %install kernelrelease \
+			headers_install modules_install modules_sign kernelrelease image_name
+no-sync-config-targets := $(no-dot-config-targets) %install modules_sign kernelrelease \
 			  image_name
 single-targets := %.a %.i %.ko %.lds %.ll %.lst %.mod %.o %.rsi %.s %.symtypes %/
 
-- 
2.39.2

