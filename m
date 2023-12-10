Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B19980B8C9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 05:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjLJEIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 23:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjLJEHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 23:07:44 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8893AB8
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 20:05:33 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5c6f9d1ba9cso1351126a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 20:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702181132; x=1702785932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxTgIk35cBEBjNHmGIeLkGBa/rmxEyN1bVKNuPulPrw=;
        b=iFKa0bXmMxzdLHkwo4WmQZwFMgNHAgkSnKB9i0qIOc1Gy5bOAYvlMd535zdM9V3W10
         ffzskIYy4aTPApo7PzcdNnXv0Trs4ciXFgZLEc3DBPsr+E61BTgyjM2zvG6O0it9IsoR
         a/9+rFzo/Q7TUaRV9XcCqo/BeZCSHQLmxawtmOumTzusEmyVZt53nwlAVzy3eZzqOtpw
         gFjBeg+xzB8Or+STbgGOi9xe0PyrZZsjQA2hiZdcTyg0lS4VujQ+GOhxvUjKCYWxTUJ1
         ymsOH6UWPd9/fegsFuJG9yRcFx3H69kBedZjrmZcGm3AbB7jtru2onfZLo0nDY4DB3jK
         AcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702181132; x=1702785932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxTgIk35cBEBjNHmGIeLkGBa/rmxEyN1bVKNuPulPrw=;
        b=G2MCk/wJ+0gNyip9s88FT6tQ9F0R1pemgFI8Aet7QtT89bxJgXSAkUEWzupxS21EC+
         lRq6S91+ISBQWexDL7MevdD1qd2QXmy1ceFCXagjbNNTjVrlHSZ2i9ZFCrmeoDjZ62vn
         bFUQ+j6LN15jZTMKfjeZeymnrBXyjIgltNxEByLy0NHpguc2uzlIguHtskxUgMLZezQu
         jll+oNOovyN61ujMn/XEcEHcCWYyVzKtHthIYhzdCnlm17YLH04aVRwcOFbIRpR1rrti
         gqm6fwA2T1X8mV0FQhUJ/lmCr1kLiFEpAHiiakw7LshXkcI8/3PlJPhW7kR6Hso8+Rd6
         FxGg==
X-Gm-Message-State: AOJu0YyOaADvgmYG6Y/XrreSH2aeLoVa9jPlphmX6Ip5FgJdQ4kymB61
        i9TTd3EDzs1OZTRSKPf2u64=
X-Google-Smtp-Source: AGHT+IH0NUo/39sXHfVIC4mD3yLbQPWnO3hPMB22iKCPdmsCkTVV89PNHgoc96UnMjHFEPuey+GWtA==
X-Received: by 2002:a05:6a20:d386:b0:190:1e0c:d29 with SMTP id iq6-20020a056a20d38600b001901e0c0d29mr4155604pzb.4.1702181132480;
        Sat, 09 Dec 2023 20:05:32 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902c3c600b001d1c96a0c66sm4112497plj.130.2023.12.09.20.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 20:05:32 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     akpm@linux-foundation.org
Cc:     bhe@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, thunder.leizhen@huawei.com,
        vgoyal@redhat.com, ytcoode@gmail.com
Subject: [PATCH v2] crash_core: Fix the check for whether crashkernel is from high memory
Date:   Sun, 10 Dec 2023 12:05:09 +0800
Message-ID: <20231210040509.106292-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231209143418.92f02de6b6c6db2b7b3b1815@linux-foundation.org>
References: <20231209143418.92f02de6b6c6db2b7b3b1815@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of the reserve_crashkernel_generic() function is to allocate a
block of memory for crash kernel, and if the block of memory is allocated
from high memory, it will allocate an additional block from low memory.

The method to determine if a block of memory is from high memory is to
check if crash_base is greater than or equal to CRASH_ADDR_LOW_MAX.
However, the current code only considers the case where crash_base is
greater than CRASH_ADDR_LOW_MAX.

This means that if the memory is allocated from high memory and its
starting address is CRASH_ADDR_LOW_MAX, reserve_crashkernel_generic()
will no longer allocate the additional memory from low memory for crash
kernel, even if it is necessary.

In fact, we can also take a look at the code before it was modified in
these commits:

  9c08a2a139fe ("x86: kdump: use generic interface to simplify crashkernel reservation code")
  fdc268232dbb ("arm64: kdump: use generic interface to simplify crashkernel reservation")
  39365395046f ("riscv: kdump: use generic interface to simplify crashkernel reservation")

They all checked for the case where crash_base is equal to
CRASH_ADDR_LOW_MAX.

This patch also includes some minor cleanups.

Fixes: 0ab97169aa05 ("crash_core: add generic function to do reservation")
Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
v1->v2: Provide a more detailed description.

 kernel/crash_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index efe87d501c8c..d4313b53837e 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -199,7 +199,7 @@ static __initdata char *suffix_tbl[] = {
  * It returns 0 on success and -EINVAL on failure.
  */
 static int __init parse_crashkernel_suffix(char *cmdline,
-					   unsigned long long	*crash_size,
+					   unsigned long long *crash_size,
 					   const char *suffix)
 {
 	char *cur = cmdline;
@@ -268,9 +268,9 @@ static int __init __parse_crashkernel(char *cmdline,
 			     unsigned long long *crash_base,
 			     const char *suffix)
 {
-	char	*first_colon, *first_space;
-	char	*ck_cmdline;
-	char	*name = "crashkernel=";
+	char *first_colon, *first_space;
+	char *ck_cmdline;
+	char *name = "crashkernel=";
 
 	BUG_ON(!crash_size || !crash_base);
 	*crash_size = 0;
@@ -440,7 +440,7 @@ void __init reserve_crashkernel_generic(char *cmdline,
 		return;
 	}
 
-	if ((crash_base > CRASH_ADDR_LOW_MAX) &&
+	if ((crash_base >= CRASH_ADDR_LOW_MAX) &&
 	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
 		memblock_phys_free(crash_base, crash_size);
 		return;
-- 
2.43.0

