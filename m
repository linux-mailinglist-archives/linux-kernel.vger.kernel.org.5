Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434B87AB820
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjIVRuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjIVRuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:50:32 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B69CCF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:50:21 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c43b4b02c1so20321915ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405021; x=1696009821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fnSUWF58ojeWw3KcW4a/aInndGgQ4B+bmfIwHKF+S5o=;
        b=gfpr3HVETdCpSPj68Jn7btta2NHRIIz1qe/Tb8lWORX+eUdi38/gWBqpO7/kIFfRS3
         Xeu3s7t+KKL3kCUFOmGwr0EWHtRZ75iG61zxX791oo1Smyd5EcHLPl6NA/6Byg+gADRT
         8ekqVfqxgNdsExdR7lifPZ8H7iQ+6teSgDV84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405021; x=1696009821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnSUWF58ojeWw3KcW4a/aInndGgQ4B+bmfIwHKF+S5o=;
        b=NswsMh6j+hc2+d0WoPZN9OLEF1tqKl4YcrqXunTuwPlKFs0A9NxT8cHI8rdSQK6MlK
         6XzhdAQLBNSXP+cK0yuy6vn3rALCcJTLTguZf5Rkjj7//1MegozwzpMZnVd6xoQNcVM+
         kTRSTtTRSSSQXP8x0e2RLxDmZKhVxFXucZ5HWC32JMTs5xfKlOCZsmYfnaGmF1g7q41p
         6gXTe3qIJKtGmzeh185cdFExuhxGDjfJjgcT39knkTGnXChv17ikg24oRYSXCgiEtrAy
         uvkyh1YmxDG5I3I/iJeS8O5wk4tSEc/AlXGkStnBOfK26EZAPakZBNpI9dTBz+HSYo9n
         LFnQ==
X-Gm-Message-State: AOJu0YymdTHqGF0dOYECIckE108PtAoQYvLVpYHkxCGDI+21ZJei+D4e
        /ehff4taJoueYVTdy/M1vaymsw==
X-Google-Smtp-Source: AGHT+IEpwE+lbw9N8VqTU6cLI1njnvdhNqJvkC4T2WCQ+CtSy2geBYXLs4Lb8xITWNjg+VuykJZz8g==
X-Received: by 2002:a17:903:2348:b0:1c4:13cd:b85f with SMTP id c8-20020a170903234800b001c413cdb85fmr154761plh.5.1695405021369;
        Fri, 22 Sep 2023 10:50:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090276c700b001c0bf60ba5csm3750500plt.272.2023.09.22.10.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:50:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        Len Baker <len.baker@gmx.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-i3c@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] i3c/master/mipi-i3c-hci: Annotate struct hci_rings_data with __counted_by
Date:   Fri, 22 Sep 2023 10:50:19 -0700
Message-Id: <20230922175019.work.129-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1308; i=keescook@chromium.org;
 h=from:subject:message-id; bh=VnYZTZQDzvs6FPCd796RbHEvmVY4nxS6fY7pQ/TUq58=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdPb7evFPyNbPT0FdckJpxJpxqM4N1hl+rZT8
 PBWQWPuA6SJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3T2wAKCRCJcvTf3G3A
 JknqD/4/xs4n4EK36LHG01DepzXWVJmm7fPp0/czFh0mjmYFE+bK4F26rpn6lgsBQhf7ZjQ0Oj9
 nKVj0QLvgCFAtpBT32huepq+fL5RwuTNOtJ2/XlgSeNhVNO5huuxSsL7qveP4T2OJRJUWgxsG5S
 QKEU1ED/1P4CSCOEVITabzeBZjqANlqDE8aZVqz48j+C7Su+O2MeQZ8+tgA7ApE0UIynp599kxT
 hirXsgBk1UnxTKiCT/8YogzSWpIJP/kCfQBluYyuNgjXU6ByV771+6OFIHXuW1E5us27fhmapqS
 AgHC5MfhZAvS50WOCpsVNDXSCe0dM9hnEPgA6yscEl3Y5z6OE6D7GZBsj0C8T5ksP4j/kIZHQ3S
 eTPF69qS8MYYgPaCYKJi727lFoCd8EVEZhT5njFT2SWBdE83dALCTI5SisWRPjcAHSTJk/5TSpf
 wsaA+sMNRgxMRlF10ZSBfoDRlDd6HDPFL/leLCXvJMyCXNuNgs+EBtVHvlrte+K44NEq3qlVb5F
 ZXGWXTLNs6/9I4s5DWl3JrRbuvoTOUGWi9Pdc+RmUPx0sU3LAJgltK/3gAwmfpJEZHJVRuDmxuX
 Nu+VZAWXphQB9Gs3lc6M9eEGG+ijJjygN/yin4pvq+fQY13ztOFq8RKo7MKTBrH8D/1AfABwnBH
 0WbbyJb xBwZlDsA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

As found with Coccinelle[1], add __counted_by for struct hci_rings_data.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Nicolas Pitre <npitre@baylibre.com>
Cc: Len Baker <len.baker@gmx.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-i3c@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/i3c/master/mipi-i3c-hci/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
index 2990ac9eaade..a1ecdfc35641 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -139,7 +139,7 @@ struct hci_rh_data {
 
 struct hci_rings_data {
 	unsigned int total;
-	struct hci_rh_data headers[];
+	struct hci_rh_data headers[] __counted_by(total);
 };
 
 struct hci_dma_dev_ibi_data {
-- 
2.34.1

