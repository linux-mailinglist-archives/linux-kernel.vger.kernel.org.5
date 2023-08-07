Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CEE771B36
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 09:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjHGHLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 03:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjHGHLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 03:11:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F2D95
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 00:11:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8559C615B1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4605BC433C7;
        Mon,  7 Aug 2023 07:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691392274;
        bh=zl1lIS7wrqrt5R7NPHOQdoixijqtEVsXNT3GmfceZds=;
        h=From:To:Cc:Subject:Date:From;
        b=FAzwmGF3Fl5om7Cufnv8iNzCShuR/28WqOE/6cBsHCviSzl6slrZNG0Sl4PDMTs18
         bztD6Gm7niwIBN+uX+jGhBtgj99RHSM7Kd8s76WIJVx8wceZaK7eKXGV7vW7QMO8IZ
         QpPynKaLxbiBmPDSBJhxie0hrVJJOkSFK+Q73lpled4eKRvzriKXAoE3x1lQXVVhAo
         ymQJ5fp6BA4iEptmD1DLImMoOpF1Kr0kNebcsUuADiNDs1OqLcarMPT9ygHMtkeAwX
         dOi4Xc7fos5sNH0Ck6r4v6ZFGsXIEgczYDXKJb2pr+UCB8r6BylJCUcPkCyPf8f4Bl
         Ihja/M7X0mERQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] nmi_backtrace: fix trigger_allbutcpu_cpu_backtrace() stub definition
Date:   Mon,  7 Aug 2023 09:10:51 +0200
Message-Id: <20230807071109.3386799-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

The prototype for the extern declaration was changed, but the one for
the empty stub is now missing an unused argument:

kernel/watchdog.c: In function 'watchdog_timer_fn':
kernel/watchdog.c:521:4: error: too many arguments to function 'trigger_allbutcpu_cpu_backtrace'
  521 |    trigger_allbutcpu_cpu_backtrace(smp_processor_id());
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from kernel/watchdog.c:17:
include/linux/nmi.h:193:20: note: declared here
  193 | static inline bool trigger_allbutcpu_cpu_backtrace(void)
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 0ca1d340a231e ("nmi_backtrace: allow excluding an arbitrary CPU")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/nmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 7cf7801856a1b..e92e378df000f 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -190,7 +190,7 @@ static inline bool trigger_all_cpu_backtrace(void)
 {
 	return false;
 }
-static inline bool trigger_allbutcpu_cpu_backtrace(void)
+static inline bool trigger_allbutcpu_cpu_backtrace(int exclude_cpu)
 {
 	return false;
 }
-- 
2.39.2

