Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFBB7ADB01
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjIYPKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjIYPKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:10:01 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A46103
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:09:55 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9b0168a9e05so578748366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695654594; x=1696259394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eC20xI+X56Gh8DNv6Zud5IHxjD2gnnvulA3kJH1zjMo=;
        b=V7um3RNHEMlI2ENEsAM54gm8G28JaVKxoFXWP6yCulk6LnB4NycUE+5/qnn6ySKLgo
         Uo0tuBTgMX3Tc4U9TIt0RKHeSJgG8drrpq96DeKS52GNqZgx21u5xULvz7bzgZ99xNYt
         a1GKpuhasaMXQwwlLw8IoNe+Dd28rojetOlUID14Jk0TbWNabA3Wl9kmFmdadQG6jnm2
         Xri7LihKtPh3hpvy5TkvyQzpLsFlqCpXqGx3XzSZdyWI5wNefS3kdYbqbLqEFy/ARkpi
         Fn97pN83ikW3j2Yrjx+sD8Jk9i9ZNfv/B/vNxslCrDrkTWrJI5ycmssPcipvGlYvyR5J
         KgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695654594; x=1696259394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eC20xI+X56Gh8DNv6Zud5IHxjD2gnnvulA3kJH1zjMo=;
        b=I/MjlfyiMIwMYQcCrDG/E55g4HnxC9FRxp+9jegFaWJ1eac/YlGd43ecd51rYt4kQD
         If4GkdszALM4TLYgLit2NJtnEhLuguocjukXCCtdzQI2VJ3FBkOkW6lFYE/wCf1Wg0my
         T9WkYct25epaBbbGzlXd9IhAxu9nWkdB7/2YLTG6gHeyfK4NzETA2wyPhMNXh3mv/Gws
         5SCx/+KG1mzN8qnGw1Bx4WS4bSCR1kGQfZGrXvx7HvF78NY5vuzViJvU1/xIFBHpzvyL
         ie0kRfvNVX64rDYcwbvKZ0+lQEJG1+6JOurGca4Csp1FSYFaD2jByfMUikowWxs3w5Dn
         Yh2w==
X-Gm-Message-State: AOJu0YxOl08DKwqVuzhhArH38O80YaeS/PGmINtVTCaXxPBF1hd/bj4H
        B2Htgl9GzyG0E2bdm53YXKL+dHbV0Fb4FA==
X-Google-Smtp-Source: AGHT+IGFWeaotCAhz9Xjbbcp2IWjzMJpFu60qvFPlN+y2YfqFLnFW7OTz+bN7V8dbaLe5I/3E2I1YQ==
X-Received: by 2002:a17:906:9a:b0:9ae:56b5:619d with SMTP id 26-20020a170906009a00b009ae56b5619dmr6161137ejc.16.1695654593710;
        Mon, 25 Sep 2023 08:09:53 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id i13-20020a1709061ccd00b00989828a42e8sm6442191ejh.154.2023.09.25.08.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:09:53 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [RESEND PATCH 2/2] locking/x86: Wire up sync_try_cmpxchg
Date:   Mon, 25 Sep 2023 17:08:24 +0200
Message-ID: <20230925150905.54842-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925150905.54842-1-ubizjak@gmail.com>
References: <20230925150905.54842-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement target specific support for sync_try_cmpxchg.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/cmpxchg.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index d53636506134..5612648b0202 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -221,12 +221,18 @@ extern void __add_wrong_size(void)
 #define __try_cmpxchg(ptr, pold, new, size)				\
 	__raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
 
+#define __sync_try_cmpxchg(ptr, pold, new, size)			\
+	__raw_try_cmpxchg((ptr), (pold), (new), (size), "lock; ")
+
 #define __try_cmpxchg_local(ptr, pold, new, size)			\
 	__raw_try_cmpxchg((ptr), (pold), (new), (size), "")
 
 #define arch_try_cmpxchg(ptr, pold, new) 				\
 	__try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
 
+#define arch_sync_try_cmpxchg(ptr, pold, new) 				\
+	__sync_try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
+
 #define arch_try_cmpxchg_local(ptr, pold, new)				\
 	__try_cmpxchg_local((ptr), (pold), (new), sizeof(*(ptr)))
 
-- 
2.41.0

