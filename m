Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E21F7AB8BC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjIVR6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjIVR61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:58:27 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2BB19A9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:54:39 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68fe2470d81so2277881b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405279; x=1696010079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IjeaV73hiIttYIrl5ELxFpexeQoEM56r8iWVxqTuQ5U=;
        b=W363ixgVa4J2Y9YiTdE4wYMnIywCofcwQFgW/2Fg4MvZzMzQW+vJnedJW+BlAKI6fn
         bvCD+WO086rAd1cag2bjbXyPGUpYZeSpYtLWkT1Z39pt59ZxRhz3G2GdAzhk6iXtVrIG
         ecU1VO2Rdfr8k2ugjRkCUq+WEWJAtE8MMO/30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405279; x=1696010079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IjeaV73hiIttYIrl5ELxFpexeQoEM56r8iWVxqTuQ5U=;
        b=sUGF7puDyre2wrrnD+4G/oP5tIV5jh3afFVQ+QdDkTIuQQSdXqz7pWx1HQx+DLkk4u
         uHOFimZrESyC9aZZaQ2gd2Tv5+8AhepYjxTMPw6v5pQHW/w9KKmxHEx59B1baAtgRRpw
         bgfC2KhokvAFX4M7o105zju8DXeE1+Id6vUJRVgP+KKt88AfogBsCODhhDvdWfNvM6Js
         fON03r/gEs8gw7bp0rseB+j8SHjNZcrYKlDdA7vuVYHfYmkK/KdGIPAENMMQfU1yvzpk
         5C+plZNqAP2u2dfYfHcyl1gvUgL04tQ3y9z3IoIH0O8keJ1oZy8J19XYDyIY9AZXziCV
         8xvg==
X-Gm-Message-State: AOJu0Yy/JGTsnM55gyARTNMXAxFxXojOgQxf+Lvbu+3+rOw/eQUmVp90
        bHt0d2Km7ygcij7/VPkTgbV9YA==
X-Google-Smtp-Source: AGHT+IHR5DLHlAeeoZk+sHs9Kb4LlO3DRZvk0xSprFEwkdqeU0Cx16wif7KblQwQ5V62iXm93hIcYw==
X-Received: by 2002:a05:6a00:2e8b:b0:68f:f741:57a1 with SMTP id fd11-20020a056a002e8b00b0068ff74157a1mr213789pfb.7.1695405278835;
        Fri, 22 Sep 2023 10:54:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b0068fece2c190sm3458942pfd.70.2023.09.22.10.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:54:38 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        platform-driver-x86@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] platform/surface: aggregator: Annotate struct ssam_event with __counted_by
Date:   Fri, 22 Sep 2023 10:54:37 -0700
Message-Id: <20230922175436.work.031-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=keescook@chromium.org;
 h=from:subject:message-id; bh=T+Zr3XTl8UeXAf4xTZbY2EHoO0SlibCfAP1NuiNTWSw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdTdfq2Mz6uuhqmtzfnfg1vj97+JF1Hg/qqop
 +JwlT8D5B6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3U3QAKCRCJcvTf3G3A
 JpoyEACg+ayR4fFaWv6vAB3d2B+WBwdtg4B8DiP1WncRmwCPqBiztrC21miRe7lLEDE2UklgyOx
 PduUHkVhaYeFRLawXsRDLwgFqNXykv5uD28potGGRWp+CJI+jxz7cbwO9d9P4EKNkqZiyIVe1T7
 0uBJI+D/u69nR22ukFy36hxV5tXpLQvE+fU1RL+aspMbseJ60vj/jcDZ0GSYxMWT0UUPgsSUTLw
 Z6q9BwnLJDgFOpu3iUjPIlfWebKYQSBgSu6UUiyxsqas20/R8nxbHf8eB3QWvLF1YU4AMb5wJX4
 P/1RH2ZzTqV/biVWdGCMqcosrw/dnGRiPL/2jkn7ilNfe4hS265oaBsBi7Ufgsia/5eMRkRILL5
 YClvrIczbBrRyVxhEVjGEyRvtU5tXctwHR4ttx33tlk757l0m5kWBwrffVRwXlJP47Vuj13Lfk2
 3PCS9WmNPjvSPqd8u/91V+0+QJifuf+8KGd8zW40biiTd3HPHhcXL5ZBBmQqxs6aUq1HayKEu9j
 52zVqoAm0XHA1s/2cB1xNQoUlF/d910cvrK9gZTAUclWMUdI2JQ6j7b0QlJWDPUhtHU/LaOhbda
 lEi6F8d1IWD/7NGwOStb2so96w7SstbIDfpJiBhm3VuI9qJuOrXoBpG3vKUxPXfSJ4bKZVdHgxX
 tW/IFkU LyR9VPRg==
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

As found with Coccinelle[1], add __counted_by for struct ssam_event.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Maximilian Luz <luzmaximilian@gmail.com>
Cc: platform-driver-x86@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/surface_aggregator/controller.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/surface_aggregator/controller.h b/include/linux/surface_aggregator/controller.h
index cb7980805920..5b67f0f47d80 100644
--- a/include/linux/surface_aggregator/controller.h
+++ b/include/linux/surface_aggregator/controller.h
@@ -44,7 +44,7 @@ struct ssam_event {
 	u8 command_id;
 	u8 instance_id;
 	u16 length;
-	u8 data[];
+	u8 data[] __counted_by(length);
 };
 
 /**
-- 
2.34.1

