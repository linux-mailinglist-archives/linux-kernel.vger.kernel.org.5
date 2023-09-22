Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2627AB828
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjIVRvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjIVRun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:50:43 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0EDE47
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:50:34 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6907e44665bso2248969b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405034; x=1696009834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TWSYGSx3FRdbqkNwZMkwsIlHC9m+xNwPdqt/ACrT43w=;
        b=YYLnSq+lEMDl2fkai1YHDUHRB0EbjnrR5BDek7ndRwBJ9POxkRB/Cd5l3fCQLErYaE
         DTz1VdtHLJ25bz1Ba39toltJ/UCQo8QX+1IcKUr9wdvzu0RL0nVvGod6n1unFgrYZsaZ
         B1OHociFSpwUyLcyhzbPX5Rlq/6lcjgo+EdI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405034; x=1696009834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWSYGSx3FRdbqkNwZMkwsIlHC9m+xNwPdqt/ACrT43w=;
        b=T9E7ArSwPh3kgnB8A8IObfH747CWJm/bqaiVGXkAgBvdgon76qatvhTiBPetqsnOlU
         0htkBEOGe4l3DZJkQVmCaO1iXXI3TSS7/59CZuXNdAFNuF74zpPdqRAwpioE7h7JI4sH
         hh+oeRC4RsH6vtzk4c70eGErp8ucc4w0M14HfG0dkgTfPLEAFMOUGLuCuViwpmthsbN8
         s7LqFgi/tU4hOpne7FtS1PRhB67d9YVGE1ke0T0HXdcRRZLxGcPWNBysNYRoySsYrTK8
         sB5QuNVwKC5bCGAjkyM7pJutEHst9c3GLDBCBmnnb7G0CQUk6ZV5lfh5QpZmfcH2ZB1E
         /3dQ==
X-Gm-Message-State: AOJu0YwMIDFQJUIw0jEIkZL0kZH+UF5nqNIbIO47J9Kw7TjnCG52NyIU
        NI8gTAqnVHWXoHzxIRSs/nyTYA==
X-Google-Smtp-Source: AGHT+IGiJ+qLGDyGaX64SuGCS5NQM2cGrL6mKf0nm7gz/uETj9zTg0LbChgWnGv76RhBzBcNYhup6Q==
X-Received: by 2002:a05:6a20:1593:b0:153:73ec:fe67 with SMTP id h19-20020a056a20159300b0015373ecfe67mr283929pzj.19.1695405034029;
        Fri, 22 Sep 2023 10:50:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i14-20020aa787ce000000b006900cb919b8sm3471285pfo.53.2023.09.22.10.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:50:33 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-input@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] Input: Annotate struct input_leds with __counted_by
Date:   Fri, 22 Sep 2023 10:50:32 -0700
Message-Id: <20230922175031.work.467-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1178; i=keescook@chromium.org;
 h=from:subject:message-id; bh=fuFMe5RJqctw9YaNRo3c17jp48a8pQ11kmGxtHC6eHQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdPnbq9HMyzXg1GM/G+0YODp6B8YDnTmKbwLT
 IA+uTuHW2WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3T5wAKCRCJcvTf3G3A
 Jk8tD/9IP0MlS1aUzonY8JdLcDTAkEZzDGSLrIzCT1/R9A885x3lCdurlSZ6lY3uO+qOuGO5wyR
 CbBFdXNDiCJIilfilYLMXRW+1rKnCF7mL/o3RzTjb9/5r0SQnz7MMH7m93L7KdrAhf/q5haoFyl
 8B64XR4QrJfzsYJvfzo7dcc2Wz6KMqlvcA8IlUOr8hEz52rsf4BVwBxXFNyolwrV71JGLB3F4vJ
 rdavWISvvNKE4WTf2lZsVw0A7zpfba1OB/QHEaoFAjtZvXwfyvwTMrP9nfvaUlzqcVqYa9eRPUR
 DDNsjb6NSGgHm+Tr8HV5qMOkIUinLcNe6D0aQVOc8mBjpe31oeAqLU39NhHdPsk1gJluYML/DYu
 LoMiRoW0F9Pgfd7aUvQEk6AoUKw9PIE3ajSXKmDRiGXVLXSk1AXct9jIqXkEJj6deT70tRCMZW9
 QiBMYv8IAGZnf9+PE+aeD10dUAKVIsUt9fU4zu0dPfGf5qgumVscQsLnxLR0NF5WP8mlfgBGyOU
 2KnpDfX91Hgl3jPHZiEBJbvqg2lFwW683NbrivfaARiT3r/7DTjtDOPHmQ4J8JBr9bLnkIjk2wQ
 qgHLyg5gUE5ae4SG8RDF++QAMkLnF/nqOz5fPsubL5gdGDlNsZ9wUA9lsegSS2eTcIGU2O1Asj8
 dKwVbEr Aum05Q7g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct input_leds.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/input/input-leds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/input-leds.c b/drivers/input/input-leds.c
index 0b11990ade46..0e935914bc3a 100644
--- a/drivers/input/input-leds.c
+++ b/drivers/input/input-leds.c
@@ -44,7 +44,7 @@ struct input_led {
 struct input_leds {
 	struct input_handle handle;
 	unsigned int num_leds;
-	struct input_led leds[];
+	struct input_led leds[] __counted_by(num_leds);
 };
 
 static enum led_brightness input_leds_brightness_get(struct led_classdev *cdev)
-- 
2.34.1

