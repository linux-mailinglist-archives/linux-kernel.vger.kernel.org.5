Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B2E76E96B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbjHCNGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbjHCNF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:05:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2821F49FC;
        Thu,  3 Aug 2023 06:04:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D76A61DA6;
        Thu,  3 Aug 2023 13:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A3BC433C8;
        Thu,  3 Aug 2023 13:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691067865;
        bh=vkgMhk5pL7GGu6vV+78air3bWNRQYu/zusD/HonXuBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bRPHo3VgDSS/bT/p2AQhBMN6bcmPe1VYeVSXSSRVpYdXCESWo53G22Q8CY3+vDidS
         yu6Zgw+7z84fxEImhVxfDn2m6G29QK91bYKoB2/rvBFRgR0D2DJg8uR0bFFY3FWBFo
         qLAxr3uxCtTmYrGet9Z3MH8cmq3fdcH0XiGzMGVJRC5hd7mKpC915WLluDitVJFMSc
         8K3gVQ5mZy5xW7Mp3FxLX2uDquv27xE7s0Jonxv+eSeYgDaLqiKmqxnDMtxj/XVe8r
         MUt1iJex/AJ1h1VCwwWHNctp3lZSUsSLp9CJjde/3giumXNOz8zEdTHEQDy0XztgX7
         JhqjkqRw5lN9g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Benjamin Gray <bgray@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.4 2/4] powerpc/kasan: Disable KCOV in KASAN code
Date:   Thu,  3 Aug 2023 09:04:16 -0400
Message-Id: <20230803130419.641865-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803130419.641865-1-sashal@kernel.org>
References: <20230803130419.641865-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.7
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Gray <bgray@linux.ibm.com>

[ Upstream commit ccb381e1af1ace292153c88eb1fffa5683d16a20 ]

As per the generic KASAN code in mm/kasan, disable KCOV with
KCOV_INSTRUMENT := n in the makefile.

This fixes a ppc64 boot hang when KCOV and KASAN are enabled.
kasan_early_init() gets called before a PACA is initialised, but the
KCOV hook expects a valid PACA.

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230710044143.146840-1-bgray@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/kasan/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
index 699eeffd9f551..f9522fd70b2f3 100644
--- a/arch/powerpc/mm/kasan/Makefile
+++ b/arch/powerpc/mm/kasan/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 KASAN_SANITIZE := n
+KCOV_INSTRUMENT := n
 
 obj-$(CONFIG_PPC32)		+= init_32.o
 obj-$(CONFIG_PPC_8xx)		+= 8xx.o
-- 
2.40.1

