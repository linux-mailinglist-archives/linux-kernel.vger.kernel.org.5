Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAB8752A81
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjGMSwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjGMSwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:52:34 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6186106;
        Thu, 13 Jul 2023 11:52:32 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-992b27e1c55so147024566b.2;
        Thu, 13 Jul 2023 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689274351; x=1691866351;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sl0k0wYjl3hwJsFNeGh8bb0d9ZjKonMo+8kUL+KQzvg=;
        b=UBpllUJ3BxDsNMj+bBPaYGhpjiOyMrQmX1paFEo4geKQVFKE5LvI/M/hYhSCoX1e4I
         PBP+/zQfzlPEhDcskeChtfb3yImCw0FiomXFN0+2DsuoSkwKC5dTZmt9QohTq9UHsmYr
         i0WzOAeG+x6UCBD1Y4kNnAOKrQ3SVCxI+GTmFMm5vGWAIYYrTrivn+S7WaLAZU27kKba
         2WhqmLMn0wJAz/8OdDJWspOA6bmkYDuMR8qvAKNVmJ9Ox+WjoP3IJJkDBKFjug2RZLjL
         Za515Ipvu39QLXVtFCxAteTrEG46CcL/HzgsbpH8kbAUT8JGb1uYOb9YDPzaL8p0cGEL
         GM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689274351; x=1691866351;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sl0k0wYjl3hwJsFNeGh8bb0d9ZjKonMo+8kUL+KQzvg=;
        b=Qee10YmIGGmgh8xRjJBNu94s5FaWg0mFKft9/SfsyCyEqIbZJNGtWpckV229wFRR8m
         lvWe5g3gULzmbPFim57Whjhb+QVAIKeVc1768+Q4uwKCSfJ94tVptGeE2GwrFo2gYQfk
         LAFlMGmu8wKIdYVRDERzeeyoKugMzKVi6ne9X/X38Ui8jkyOhQ6AOH0MA13dM6uEl+Ec
         nzivVgKADjGUAnvJyiVsuK2hPYFYid7/yAOnAKhJfWvG93wmxn3eVcQN2wkEDnwx8BzX
         c3qQRyHOUOUh7JfjFHGFqiUfoKnWiZO7uvpwzPe0/nJ7tb5vARN6MoAm5ah3aIiZd4rq
         AwQw==
X-Gm-Message-State: ABy/qLbsKaMlVwHz1jKvDQxikmmEjTdiwgGounzvUmc1RfhVdoZNG3wA
        2g2oX1b7Oh9vR6BWrHPL5AzSI0AkvA==
X-Google-Smtp-Source: APBJJlHQxgOEKJ5YQIngpD9uNx7NfD+JRH9Y1qEVbmYZf6w6i6XfkdyT2z0IQ96vgH1UQzkg9Qr2vA==
X-Received: by 2002:a17:906:d965:b0:992:b020:ce4 with SMTP id rp5-20020a170906d96500b00992b0200ce4mr1974119ejb.51.1689274350804;
        Thu, 13 Jul 2023 11:52:30 -0700 (PDT)
Received: from p183 ([46.53.251.182])
        by smtp.gmail.com with ESMTPSA id x8-20020a170906298800b0098df7d0e096sm4336800eje.54.2023.07.13.11.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 11:52:30 -0700 (PDT)
Date:   Thu, 13 Jul 2023 21:52:28 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org, masahiroy@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH] kbuild: flatten KBUILD_CFLAGS
Message-ID: <4f414a87-0c54-44bd-b218-f6f0b22c57ef@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it slightly easier to see which compiler options are added and
removed (and not worry about column limit too!).

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Makefile |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -555,11 +555,23 @@ LINUXINCLUDE    := \
 		$(USERINCLUDE)
 
 KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
-KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
-		   -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
-		   -Werror=implicit-function-declaration -Werror=implicit-int \
-		   -Werror=return-type -Wno-format-security -funsigned-char \
-		   -std=gnu11
+
+KBUILD_CFLAGS :=
+KBUILD_CFLAGS += -std=gnu11
+KBUILD_CFLAGS += -fshort-wchar
+KBUILD_CFLAGS += -funsigned-char
+KBUILD_CFLAGS += -fno-common
+KBUILD_CFLAGS += -fno-PIE
+KBUILD_CFLAGS += -fno-strict-aliasing
+KBUILD_CFLAGS += -Wall
+KBUILD_CFLAGS += -Wundef
+KBUILD_CFLAGS += -Werror=implicit-function-declaration
+KBUILD_CFLAGS += -Werror=implicit-int
+KBUILD_CFLAGS += -Werror=return-type
+KBUILD_CFLAGS += -Werror=strict-prototypes
+KBUILD_CFLAGS += -Wno-format-security
+KBUILD_CFLAGS += -Wno-trigraphs
+
 KBUILD_CPPFLAGS := -D__KERNEL__
 KBUILD_RUSTFLAGS := $(rust_common_flags) \
 		    --target=$(objtree)/scripts/target.json \
