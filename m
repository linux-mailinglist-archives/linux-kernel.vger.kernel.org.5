Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B7A7AB872
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbjIVRxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjIVRxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:53:21 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEC710C7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:52:13 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c3bd829b86so21835025ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405133; x=1696009933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P4lFdFSF/WMtJZ1n0IFqHz6mtLvevkit742tpw5OZis=;
        b=TUltBHeCRYJUzVo8fVnGboc37KWD2XGgCL6pMasy80W4bhqo4tBxLiHWPwkomfGOnn
         p2S3UeiOUOaoK14y2ATMxh1h/eRsSjtcpz4zOEGZTi58msCxUxAQ38qVJB19e7bHofgx
         HKvV/9RB7HLpB+ilyMejoIoCHrdxcIllBq1ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405133; x=1696009933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4lFdFSF/WMtJZ1n0IFqHz6mtLvevkit742tpw5OZis=;
        b=hG+EVquNp3EVhZbzR3VH7AF9T4cB33BBoMfATAyvY48CcBzbsqy3hcVs5Me3UFhk06
         qG/0CczMGhIkl/4ynzCSIByDmbJeV1eWw+e2M2HG70T083kzpUK13yJffnvRENGe14rK
         hLEZEZGNZ15MdFPt2vuQDRKZiFuxjRAhLaWycb+6IrNRDAtA/Fpq+P30dWx1hc3wIiv6
         qG4gL0bfIthY7L5ybRYdPajfKTv7a5i67AvQ0+gbZynuexZLwPH2SELwj98l3lHon7iA
         fZ+ysTgiEFGF/De4GaqJR+Yknk3xbNYbYDONHcYlBrsSmtXADNFuyQttF1PQq2PS5vMq
         z5Zg==
X-Gm-Message-State: AOJu0YyBnlav0Y1/Qj3+IhrLkv5jPlnSNSLKrRp22iYMFD2UM4R9qWBI
        ms69dW3W+ENlEC9TDo9UAIhfWg==
X-Google-Smtp-Source: AGHT+IFNUyiAriBD2um7pITTD+eP5MvtFjnaKTM4jvzlaWc7m2Pz8Xlfs5hzadPTiz+e5UX0XZawsg==
X-Received: by 2002:a17:902:a407:b0:1c0:aa07:1792 with SMTP id p7-20020a170902a40700b001c0aa071792mr169699plq.36.1695405132793;
        Fri, 22 Sep 2023 10:52:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902e88c00b001c5b8087fe5sm3784878plg.94.2023.09.22.10.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:52:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-ide@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] libata: Annotate struct ata_cpr_log with __counted_by
Date:   Fri, 22 Sep 2023 10:52:11 -0700
Message-Id: <20230922175210.work.239-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1046; i=keescook@chromium.org;
 h=from:subject:message-id; bh=ei96zfUMfrVFB3I3JdJNLz4izHCeTaYCT55cR6z67TQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdRLFoAwT1mCQLgtm1SMCJS/1dZx+seXgkUyx
 yYvrZTRLmuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3USwAKCRCJcvTf3G3A
 Jm/NEACCMtnhoEgknOC6Ec69yaNMsjXyzdjGfPY/uDjWB8+n6l4ZY/abY54yTq6xlFNSbERWzy8
 tTgTWRYZDHWLWFGja0Ov7FyVjLOC4LQcdhbsOu31k8bck/BANRCs2UHtkK5AVLxBnVqZ1zDWQNa
 W2CdnFimXRaOo8wIg4eyi2gKj4pA95HuBP8w4WIzCkuucorP7rfyu5lPvE1/SmwfIf6j89Q2W82
 suLkFQycstU6zebJDhPSs+V0gswuVmna0ifYiKJ+CnBVqQE4Vct/HJKGFxycica7769JXfk3DCX
 /c/MwvwlYinM8lTmzRUjbZVCfPx/mMO4MmSmmIUpl5+BELtQqZ+2TaP8tbJ8gmbLoy4uqx44huH
 +ks/vzrsMA2RdTm4+mZ+qekAIBc7wlp8EG+heSZ7BqKhgulEnhWg0wuKGID2fo5MlQw8+Ax4Vu7
 uxlfbml1ExdKOuuFoD5Iwi8jbQEJYM8fpdArxCmQPCa8MMJ3J9HuCmmX6dtQqQQMS4J9kvDaiTx
 VQVH4SdBkWJTgt96MILMcCvQNVZLXqimqbWvXGQQ1C7QX+CtwPZiOSI/wteKNiWnSUwc2iMLKFB
 p45aN0buN27a4uTP2QaKsutqZT1vM/vbj7jSDTlcmLITJjEBl1uMh8SVnPLEYHnfOJvkWs4kjiZ
 0d4Giey 7//WndUQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

As found with Coccinelle[1], add __counted_by for struct ata_cpr_log.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/libata.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3c17a5053f00..f91e8e7f1c00 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -656,7 +656,7 @@ struct ata_cpr {
 
 struct ata_cpr_log {
 	u8			nr_cpr;
-	struct ata_cpr		cpr[];
+	struct ata_cpr		cpr[] __counted_by(nr_cpr);
 };
 
 struct ata_device {
-- 
2.34.1

