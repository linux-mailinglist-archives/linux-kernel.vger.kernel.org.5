Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B357AB8D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjIVSGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbjIVSFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:05:38 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C390D1F2B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:53:17 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68c576d35feso2263950b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405197; x=1696009997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VcpELJ6V4gzjq4olnmy80BvH10zkQAPgPKh3TzKHvh0=;
        b=LbbO0vAmasDHpCq/Xn4bin2MV97b+TsooKMyPxpB4qaWuEhipj8jE8kZ7cUvnKD+gW
         I2Fp30nUBbTSCpG9gGiBNsLpHlP05LXOSSZUGpSVLBYBcJCZTi14tVw3YcJbwFQWBump
         jgnE3fp4wfXuyB7i6dtstsnKOXqgdX5pwHIAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405197; x=1696009997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VcpELJ6V4gzjq4olnmy80BvH10zkQAPgPKh3TzKHvh0=;
        b=VdKMgTXeF+OnhllfRg8Z4YU+ApkiM7/Ytt6Og9iiwO60p3rCN6NoXMliwfzhKUErs0
         5cwIFoOxLcwmyWCWJtH//Z7MwueO+XA35mG7yO+fFTLIe3/1jiYVSDiZqoJ2PydYN8Kv
         KnjrfWW11DNLQtPRslRBUxLsZ3CpN6/BFkz0xvOcXdhjGNPy/HEdegqwoSr/XUlNRQaL
         9Pa1pQ3Ri04rDDaKhIPBTexrxfGnM0Fo1DIkJrHZvHgBYI9XwkWdiuLmkE760orKCzx+
         1VbDzz8bwhkTu7hm2dzys5GFYbO6aecZtrfOdxjzi1rtADtsfP3Q+P5fsrDwVovwGcRN
         EIiw==
X-Gm-Message-State: AOJu0YwpsFHxz4FxfV23aJjgHS7u0BbOP1j4RDsR8AtNTeV+wDX9zz2q
        KvKAIwZosIoW1zJfRK3NYG/MIw==
X-Google-Smtp-Source: AGHT+IFVTmxlRYKWN+wwokRfxFr+8HhULrMeZ9/GnCZdsqlYKzOrL05eKg41orjRO2IX+YFvbyW4rA==
X-Received: by 2002:a05:6a00:1a91:b0:68f:c078:b0b6 with SMTP id e17-20020a056a001a9100b0068fc078b0b6mr145564pfv.10.1695405197151;
        Fri, 22 Sep 2023 10:53:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x22-20020aa79196000000b0068842ebfd10sm3464677pfa.160.2023.09.22.10.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:53:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] ACPI: PRM: Annotate struct prm_module_info with __counted_by
Date:   Fri, 22 Sep 2023 10:53:15 -0700
Message-Id: <20230922175315.work.877-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=keescook@chromium.org;
 h=from:subject:message-id; bh=4xy8hh2710nXi/x0gtI622DpqaNgXiLZ0l6ncbr16B8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdSLMgKD0QiDVZgL6y9jKTQlJU/qmTzhAycS2
 CXqRf8eZcmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UiwAKCRCJcvTf3G3A
 Jv0yD/wMjoy6/sOr84h0xOw027syYiDYBNxQYJXRgeNq6pyUAb+CGO4TxgUm+9Dv9d9mCnhnKUC
 DpykKBQVPOPdvKCSfPDozBfQ+blTyrqhnHvpasy/qgBC1fLy+141QegfPqrxT+lXJiKMHrWDCEQ
 5v7B0cmKNFaCTcughRb2/odgzuA8p5b6cdZIInVetgDvroCqyOIw1qqGOJn/lQnmt+NapjFzzBw
 zWLUiUSZOMuMwa46HNlhXJmtg0N/zn9wUSm5U4O6WhitjGPMiJJ+0XKk+RHP4hGFFvs81iGkATN
 cc4iHAJwf3hfhD5FjxvMRRr4VFQIZ2nd2pBhp4icvLDzdtX3ckojAohlPKZRWLlgxZ5eAxvM6Yc
 OlqBwoWG9WtFP6gcvpd/v9jBdX59+KIPbRTIfIJC1A7mgwJGQyu+/w1Ropu8rKBmPVK/Mhp1XOR
 mY57DmUYN0tbmxiex9xY2IZN4wlgBV8MZ+sAB+gXU4l88bO6EusW5f3/hiiyDSQbO3n+FKUC2pE
 T4zKnz4ixMzPIOvkZ8w78JZfp4py1F6WM4EcmZ0wjopqxsl05/Wo/EJWs0eaQrz9tkefilKp40u
 ag8fUhMO4G2mHw6XsNzjs3t76z/LKhHrL6L4o7KBOT3pc1WMpEdxoRxJyFyFahBFmkB4gwPj8lm
 wK+Uws8 mmOV0DRg==
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

As found with Coccinelle[1], add __counted_by for struct prm_module_info.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/acpi/prmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 7020584096bf..c78453c74ef5 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -69,7 +69,7 @@ struct prm_module_info {
 	bool updatable;
 
 	struct list_head module_list;
-	struct prm_handler_info handlers[];
+	struct prm_handler_info handlers[] __counted_by(handler_count);
 };
 
 static u64 efi_pa_va_lookup(u64 pa)
-- 
2.34.1

