Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214D87BC02C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjJFUSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjJFUR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:17:59 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4547DFA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:17:43 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690f7bf73ddso2058364b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 13:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696623462; x=1697228262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cooY0MAMsYVxpLHsEagLhRsMlrOOzAuT6eHluvswwK8=;
        b=K5CnQ1YA0TzTA+ufdNAmEV7DRuqDKo8OJLMQE5r2FN4sOB3EC3AQp/1+pjDVU4fn7O
         bBmS+YTP8ACMCI2DM3dVHWocphzVWSMPhZ/a3Vyyl+ctYTE+o0+K9g5pbiGHVkCmxxjs
         eh7Q2BAFHw5DMTkRVXJElH/4rQ/mw359e8IRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696623462; x=1697228262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cooY0MAMsYVxpLHsEagLhRsMlrOOzAuT6eHluvswwK8=;
        b=BX1Vhgoj63W1eo9xrdGnCEubCzBUId2Q6vJkCO/wJcodbREKJE1A8ncrch4riFq7u7
         FJFGjZI+mnqZHhZf1cnlYiHnv2Dn1MuSWF1qHtO+MkvwQ00wdDklzatDgzfnob6gd2s+
         Xq+Z4li+oq4defnSHM3VU7K4bxx9PZsjTP1cl+wS/kulQBT1N+wo1/X7P7K60dWQEUT5
         KPpAnvw065IHyM2PS2ODj9/pzkn3D4LymmRn7agNStSi06ke5abckEnKz8hEH56fkVNN
         BThYfqkFpDvw90QmnxoNUVuQEGN7LmgH1s4tQKveMCX+OgQi9VgMapGfz9TZA8QwV6mf
         QaPw==
X-Gm-Message-State: AOJu0Yz7A7lg+/Wi4WoC8e6O9iS/BWyTOef6TVgjs444q5s3TiN5DMI8
        IM2mbM5MSRuCgcVVachNaHWbtQChSeUmCyATJI0=
X-Google-Smtp-Source: AGHT+IHUP6fdhxVw5+bU8sj77QbFDalwCdaztMsMP6E3h8cype5SCNuQP6iLgFtkHlOh+mQyspcpdw==
X-Received: by 2002:a05:6a20:2451:b0:14d:5580:8ff0 with SMTP id t17-20020a056a20245100b0014d55808ff0mr10186119pzc.25.1696623462546;
        Fri, 06 Oct 2023 13:17:42 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s14-20020a056a00178e00b00690d7da743dsm122039pfg.161.2023.10.06.13.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:17:42 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-input@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] Input: Annotate struct ff_device with __counted_by
Date:   Fri,  6 Oct 2023 13:17:39 -0700
Message-Id: <20231006201739.work.350-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=keescook@chromium.org;
 h=from:subject:message-id; bh=92ygPnQr2BZyPQ3qIX2yS3pgGDsopbxEBr/j0bwJ8e8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlIGtjMlnU/pjqbrZ5CQEVQaELCA6A7cLEBqput
 m//g4X/1lmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZSBrYwAKCRCJcvTf3G3A
 JiQMD/9NkmiSLoQomYQqV3clnux5XRRcwkQCUnQAZnkJAHdYIVLMK5g3w1Gc7XWKLgMC4QyP1L7
 qm7X2Q0zgJOqzqHC4/e65i7y3NLIlLMkQitzbAAztC4cri6bE5Np7XWZZpu1EDmK+gvVqf/viMz
 Xl84c2Wv4XvRuO2HwqaTDTwaVyIya28nU1721VSdoUPrfeBEA2zAwVnG4jFMD0JdUEtKfKyCN/t
 GJjwY4uVhB6GeTbSsmOOSUOb22xKpdr4HGSncY2StRh01l00IZ2YPyTgeXqjU6XgSgtN9Y2rbX2
 dkjg3sZsQwrmA1UVgdvxRIvq8TtzUcMQNgJ2fu6y45RuFduGpH/eYAiWEwZsX8iFRD+TFJXUxc2
 0VMqMZVjpQ1pVnjzfx//tJnUb+45Z6xFIVIA4HBt79bUs7uVl6JgjieyisIhDtOPam5hexjlFfb
 /6ZGO/LqrzRVQtHhqWg/I8HB5YSPWM+Q87D7fgJ9wYbgXWywLKmXljVXVACEQqLtrwwDTdiqXwI
 gID029EAX8FW0uWDM+TmLDt71BtNBB7AOGX3GKmx5mJ1HuT4ajqM2JEwxymEOwWGEaH6lhJMtm8
 6F+AXOZf30iAsgKi8sDCgKUl9XSCeZyYVbI8zkK96wUnffwve5N7sNsZyjfAGGUf5teFUvkVOBx
 yymY6Xn lZsWUeLA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
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

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct ff_device.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-input@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/input.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index 49790c1bd2c4..de6503c0edb8 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -562,7 +562,7 @@ struct ff_device {
 
 	int max_effects;
 	struct ff_effect *effects;
-	struct file *effect_owners[];
+	struct file *effect_owners[] __counted_by(max_effects);
 };
 
 int input_ff_create(struct input_dev *dev, unsigned int max_effects);
-- 
2.34.1

