Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773B27AB8CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjIVSFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjIVSFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:05:09 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A48835AE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:54:16 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690f9c787baso2171357b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405255; x=1696010055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jdTn/0muvJtiHpvCIE7e0tTaPM/Ce4Zkoiyha7khL+I=;
        b=UlQxktioAjNkad4gZJKZ3WbYGMg5yIs0Yh9m2iDqQVXAgOoriuE0tSLDN+lA/IqKwH
         6hLhMgdAD89E9W4jXDkH/19Z3TaevNbAGRJTytxTFylNUFODC1jNz8u+GU7/s+/XJiQG
         PffFp1jOr+e8wQ79XoK7wGRyfeh0I0jVYzQ9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405255; x=1696010055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdTn/0muvJtiHpvCIE7e0tTaPM/Ce4Zkoiyha7khL+I=;
        b=Ha3yKAcoEHnf+j0Fo4w+d7zRzm2e0+RtMap5xd8RCYqPBLoSfa9b846NCf1jZd53M0
         P84SOO75Dd9xH+3hj/Jim1ufxLXlZ+ZOSvSnriR8b1ai5qwaIbSqJff761kbG4HuByPm
         6h5qPIyqfuRsqnQl490I0ICjrGdVkdUJOCHRjjXYIEzRLhIMOL3otad3veWnG0g6S6FK
         xzkIaCcuw2Gahh2bf8f6LA1+3ziq1oUTPqI+l8b8Ox6F8bQmP5IfSKBCVbZlotYSS2W8
         YNaSRN/5c2vd3Zu7E9MBnAubU63jGW8EHt5cSffroYp/A91sHqN4S2dJnbfAVHVuegNQ
         tC4w==
X-Gm-Message-State: AOJu0YxC5nvJUrO4z2qYgJNLv4LFzxS9Dq3WhNFZGdVQofCc5Jtlaflj
        nYBxQNoyu3Pbo3iP6PxNd1r+yA==
X-Google-Smtp-Source: AGHT+IHmKpHNU9aBKp4VBNBpbcxaBgcglJ1q+b7TgjvNi2g+nYDvvPPG+ayO9ELWEcqaEMGWJzYGIg==
X-Received: by 2002:a05:6a00:a1b:b0:691:1eb:7dda with SMTP id p27-20020a056a000a1b00b0069101eb7ddamr125247pfh.7.1695405255436;
        Fri, 22 Sep 2023 10:54:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k15-20020aa792cf000000b0068a3f861b24sm3462729pfa.195.2023.09.22.10.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:54:15 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andy Gross <agross@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-arm-msm@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] soc: qcom: smem: Annotate struct qcom_smem with __counted_by
Date:   Fri, 22 Sep 2023 10:54:14 -0700
Message-Id: <20230922175413.work.929-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341; i=keescook@chromium.org;
 h=from:subject:message-id; bh=QPRDelWAkTRqn7WkklPCzYdZBpFhCd5JrP57gKSvApU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdTF73/unAW40zqEdxsHteb4OckB4oasGzAI8
 NOpnPkmZimJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UxQAKCRCJcvTf3G3A
 JkzBD/4tqXg1cj8rIGdfiTLxyn+Fxw2EOGzdNwoaHT+gnQ4/WAFF+cBiQDT2pw5MErwxaFPvgTp
 nxLcMPJidI5ovUXQBW/ZmmX7O90D2J3ZEYdglHZa+igB3Y5IoFPr1ZKfMFYNBM0dcQmqFhKrWpW
 efiU/f2+Be+SS4g0eKcXI9WNlEXYuXkJ+GdH67IVoy0Pic9i/ng49XRXo25WO2jClcXKUQPK5zf
 NEg2VxWNLH92GFejJSP/yNWH6s1cPSezw17mzWthPUDQMo+N5asZtkgbOuHjVRt0nala2sjQqAo
 6TLnQLCQj7RIr818kuvGwDF3j45J2ec/0w7e8KIz/rIpLqu0MEwHLqbWvxrk3aH7vwhitPQ3E73
 UbuwnVKSaKsZ8r5p1OgT/QcV0wdx/51pXGa8ffvUGGwmrEdhH4lKxsNKxDzRy/dZcAQ2QRkcGPx
 rTiKQDfoLTwp+kXkd6vF6597phWgvNm6ePlS7/3tIPIz69azGs1Enezefya5sAYYbiTneBFOMLG
 Y6lqKInf5HKwR3R8S/3m4EzZsvN0M5jg4xhXSIfH5kRBJ9VDNWL0baQuXQqDeiYfi2DFhA32zK5
 AfrO6Wej/d4qssRVsFyEjZS0f4YAmRFbPNrwn2zeXDGHm0oKKPsBFXyazqjf6GT40wWfxuIB+Yf
 MxEssqC L+wdL2PA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

As found with Coccinelle[1], add __counted_by for struct qcom_smem.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Tom Rix <trix@redhat.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/soc/qcom/smem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index d4a89d2bb43b..4ce9cf1477ac 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -285,7 +285,7 @@ struct qcom_smem {
 	struct smem_partition partitions[SMEM_HOST_COUNT];
 
 	unsigned num_regions;
-	struct smem_region regions[];
+	struct smem_region regions[] __counted_by(num_regions);
 };
 
 static void *
-- 
2.34.1

