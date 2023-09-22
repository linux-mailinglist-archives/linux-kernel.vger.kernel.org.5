Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CE97AB8B4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjIVR4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjIVR4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:56:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BE11994
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:54:35 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c47309a8ccso28622465ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405275; x=1696010075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yau4BT1EoLV5IJxhaSNLPuA1eve9TNZXYVy+N/HUh40=;
        b=K9qyHnGOKl0cqd40Zt7+2PnbAm56Cq85B16NBf/DE2nkbCT4rG96JZkKoe7Molw3oB
         umFQDru0ttKOWC+QulCRNzBmGiAe82eMpo9ayPT7IE0ONIajhmxMJJb1PXL28K2PvW66
         k16lkNhltyW1ezDsmN8XgLUPlaZYQ2oDz2YSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405275; x=1696010075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yau4BT1EoLV5IJxhaSNLPuA1eve9TNZXYVy+N/HUh40=;
        b=k4c5tTR4Ka34y5veU3at5JyF+vB5c4oRekEAreetzTaZjosPpYl7F9m+GKyK1iHSyR
         9tRNoQTYrTe4jtejjQFZs98zmSYULchVOB74vDjbngR3kmQulCqR9T2aU/6OIJ3aA68w
         hNgq85AHT6wVtCZkNkRbSUywEe9F7WmllpLV2yp7dxsCqYVfkGdG55aJ8R9JGgbqm25s
         Fj2T9I/M/FgfFRYokRRv+IkOBvrIDVf7NikEZE810t6bhGgQHJquQzPl+5GP7DyJliRR
         G0N1CfBWcLkQwPIZCNX3LdZowx21/B/orHzgF4VC+HR7x2ky3nvmGTTdC/ainbLGJy4z
         pO4Q==
X-Gm-Message-State: AOJu0Yzmpw54x4haoL+9fpRfn05rbgrV7YoOoqjNNc3YulWB3w2Qi8HO
        teBL6YvvCD2HtHFLepi6MeHacw==
X-Google-Smtp-Source: AGHT+IH0nPqBG/eAcoGO+3MN6u7Nmf8xgA0JckteDfVErs328BgyzY5lHU7ZCU+XDwo2uiaN1b90Dg==
X-Received: by 2002:a17:902:c793:b0:1bf:8916:8d21 with SMTP id w19-20020a170902c79300b001bf89168d21mr3721398pla.13.1695405274889;
        Fri, 22 Sep 2023 10:54:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c10c00b001bb99ea5d02sm3785718pli.4.2023.09.22.10.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:54:34 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Adam Guerin <adam.guerin@intel.com>,
        Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        qat-linux@intel.com, linux-crypto@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] crypto: qat: Annotate struct adf_fw_counters with __counted_by
Date:   Fri, 22 Sep 2023 10:54:33 -0700
Message-Id: <20230922175432.work.709-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1757; i=keescook@chromium.org;
 h=from:subject:message-id; bh=mO0bdOi2nI6QO7rAk/Bt7GstmFLQozYHxthbt8jGiys=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdTY1zT9E503RR5pv60ffrhtLU8cjnNXS8B8W
 ChPy1l7puyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3U2AAKCRCJcvTf3G3A
 Jr9PEACUNiXvl8pQbdDtreunyBaXA9OzAXifbarZvcgVP0x6lvUxJiXAf3Do8llYxy0p7tyD6NE
 zYYvVfe9nOKX7RYiMUKB3sXFpA4YQAWnPC0Gkx3RZxhbMLeEPbMIwwL8N/uZnecnx9Twc+v9zt+
 HvvTKe1aSlYnRTIVE+4WB3AeOQTo5t1FSy76B5mMV+auhuVd+StmU2nCELW4ykubkUlptjVJATx
 9ndKYhQ6UAEHZuV3r9Sbg5Iad7FiYyQGqRzDDyKTNJkMfqu2Yth7uTTr62H0NcMkVoPH0T8KuRn
 hvk/cZbfPt60gO/Hls9+kyFYJK0Hk819tcgmKxhigK9c+5zyUfx1zO7BSuJilF3BkZ9ve/DJ4Q5
 a+j2XmWigAb/wputzOlYx38i2Rlck9pwKfZ+e/mpG2INPuaByxjaV6JXVpHL8FkOmsEbKoj44sS
 6wFyyX4ifgN3JFS4RFnz6hygM9kCCk98Y82aUHyTbQ/uoTYQf4Fdg114CCPtRFsNXBR5RAOpEdp
 dQUVncIQ+DlVDuBweW975ffkDa2eAuZRXDOkRcG+uwdCDZ3eQTuZs1jiIuXWsHc2E8r0fCCy1V9
 kJZEMQod7a3N+J5510CfP14zcTB46GDAVSuK0tInO7jCXGVO+N6VsSdmYNXWikKxOvnslgGDLaE
 cOYw7LO p/I/SNxQ==
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

As found with Coccinelle[1], add __counted_by for struct adf_fw_counters.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Tom Rix <trix@redhat.com>
Cc: Adam Guerin <adam.guerin@intel.com>
Cc: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: qat-linux@intel.com
Cc: linux-crypto@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/crypto/intel/qat/qat_common/adf_fw_counters.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_fw_counters.c b/drivers/crypto/intel/qat/qat_common/adf_fw_counters.c
index cb6e09ef5c9f..6abe4736eab8 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_fw_counters.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_fw_counters.c
@@ -34,7 +34,7 @@ struct adf_ae_counters {
 
 struct adf_fw_counters {
 	u16 ae_count;
-	struct adf_ae_counters ae_counters[];
+	struct adf_ae_counters ae_counters[] __counted_by(ae_count);
 };
 
 static void adf_fw_counters_parse_ae_values(struct adf_ae_counters *ae_counters, u32 ae,
-- 
2.34.1

