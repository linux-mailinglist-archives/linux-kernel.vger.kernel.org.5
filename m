Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDB278B779
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjH1Sod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbjH1SoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:44:13 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3906B0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:44:10 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a9b41ffe11so2266637b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693248250; x=1693853050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnoQbut+iRr5Ecn/zMIRssht6/ZOy4Q1oQlXOYB7XO0=;
        b=dQ+F8L5Rowmceo7LsbHVTb1oJP/Tcjc7KTaEEoFCaFgoc8fNS1O9exo3p9506uaM3h
         8iqqaQT2hQRk6B9OaAXV/0KnTzEGO34BcW88F8DjKIPLtI82SH2IhJzDn7gcgnHdh8GF
         Xe29FEO5Sf+n6ZVRUn05y8Ts26LvoTcsM3XK6hmpSwHuwrO4KREhL2gskb7UYY4A30Fo
         KKqX06GNYHXKV60eAHzq0C8X/9oWV5ReBQmMfF9OBZrWnLI3tmftoLlNIxn29Yk88/pz
         FYbKcHBp65RCR/GYhG9ThVNvfwZEb9iIs0l3c34SnxYSrOR+BIGCz86w7oyTv9yLLlDn
         a97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693248250; x=1693853050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnoQbut+iRr5Ecn/zMIRssht6/ZOy4Q1oQlXOYB7XO0=;
        b=BhA8AURh7qa36mrNYrtQXg24kr30RJB86cNbJw2FNQURrgQrGdaltG6PF/zsIlS5Ec
         RkEJx8YtWhkaceYTC07JPqtWKchkuy8522PWPe6abNpa7Tk5AuqzE4VdXBTB2YWjA4Ms
         Yf5L8KdlgplrFWKlZcvO6cPVbIJkUXUhF65MZ7MOSuvpNgxVb0AD6Av7j/Y8EOaeqPdZ
         8BCmzvYGn1UaC95i6N0OD3xLds/LRh0UytMvxK/E8rFGVc/8qZxX5NXgxnIsqL0rNHuG
         S/sHqnqag39NWIVmwbGvcesImdYeUOYDbz0v1Q/StjUr7NZww8lEg/CghRlyww3Z4RNJ
         CQnA==
X-Gm-Message-State: AOJu0YwekmhoSgiUJ6EGuJ00TQjP7zpkqpKK05YjuXBWWsel4SrV6oXJ
        2sMDOLbo1YNkGRLhZr79AbW0aSrRzE8=
X-Google-Smtp-Source: AGHT+IEF1lqE8sJJyME9qTNmswVJZye5gOfZFtFNcdfaHcv2c1AqnINQLRPIwWcNvJogG8wmZTHd6A==
X-Received: by 2002:a54:4e8e:0:b0:3a8:80ea:f0c6 with SMTP id c14-20020a544e8e000000b003a880eaf0c6mr11563399oiy.29.1693248249960;
        Mon, 28 Aug 2023 11:44:09 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:e348:56d4:5da8:636d])
        by smtp.gmail.com with ESMTPSA id k24-20020a544698000000b003a9a2362f66sm2178336oic.16.2023.08.28.11.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 11:44:09 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 09/12] bitmap: optimize bitmap_remap() when 'new' is empty map
Date:   Mon, 28 Aug 2023 11:43:49 -0700
Message-Id: <20230828184353.5145-10-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828184353.5145-1-yury.norov@gmail.com>
References: <20230828184353.5145-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When 'new' map is empty, we can skip remapping entirely and replace it
with bitmap_copy().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 2e8deeb8bf99..50385d61e6ea 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1003,6 +1003,11 @@ void __bitmap_remap(unsigned long *dst, const unsigned long *src,
 	bitmap_zero(dst, nbits);
 
 	w = bitmap_weight(new, nbits);
+	if (w == 0) {
+		bitmap_copy(dst, src, nbits);
+		return;
+	}
+
 	for_each_set_bit(oldbit, src, nbits) {
 		int n = bitmap_pos_to_ord(old, oldbit, nbits);
 
-- 
2.39.2

