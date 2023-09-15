Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B461D7A27A3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbjIOUHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237200AbjIOUGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:06:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1F92D7D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:06:04 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bf57366ccdso26343515ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808364; x=1695413164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N9rr5rnW7M+QUqwMbLAuv1BBxkDU6tl2Rwzxc3wI9BE=;
        b=LedC/eU8aBnEKCXL40n4MZa23JNqwWounjhGXkTp/9JMcyMwjwJbXPWgpPMRGAJq0+
         Qv2tHZ8t8PberHFnIrpZwY3JoR/Y2dQq1Wu8Tde8tS5i0lE6knFQ7eaSA4lUYikB9zU1
         ofWWkg/9sekkQVYIxJPPpP4MPvUMnAiCB+HzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808364; x=1695413164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9rr5rnW7M+QUqwMbLAuv1BBxkDU6tl2Rwzxc3wI9BE=;
        b=U8w+HqB3r7sii/YPmOy6Mm6IHG5PB5N4Q6IuMtaFX9qVjgP6KVePpjz02vgKqDm+E+
         55oYsmBEA5yTLUrLv9HGYRpjmGAy5n0/C5HmPOzUJOuWZOGKa8gi2dZaNzXsrJZLwtw2
         H+uhn+RqYtmDuGa5yiV4j1tz84bSCS2irglddX6OWrsaTIA+GRvBYRqYHly0BMoGQjW8
         z3y99e2WQJwP6NRcdFNR7rP1Jv1lQIIiTlxdddxozHNADRKMzQWQJuv9iyiOcsAGXd2f
         kuqyeEjV267Bt0f9SJAMoRWwjCoaE4ad/Zv8UAqG2XksV3gMjW/Y5S94DNxPg6HsbYP5
         ICNg==
X-Gm-Message-State: AOJu0YzSGBwve0Q9SMI7PbWS7wUEeM7vWfbH3/dsSL9lJbMDB3rOSZRi
        09d0AwOWl/X99SDC1QlmeGztXw==
X-Google-Smtp-Source: AGHT+IEiUYZWao46jwTFzhsUbeYezJCmc2TSqm8iXwKyxyDvyoYxgzAwYzd01BNN18e7bnVHGxj2Cw==
X-Received: by 2002:a17:902:ecd2:b0:1c3:432f:9f69 with SMTP id a18-20020a170902ecd200b001c3432f9f69mr4055618plh.23.1694808364318;
        Fri, 15 Sep 2023 13:06:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jj5-20020a170903048500b001bc6e6069a6sm3859003plb.122.2023.09.15.13.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:06:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Stanislav Yakovlev <stas.yakovlev@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: ipw2x00: Annotate struct libipw_txb with __counted_by
Date:   Fri, 15 Sep 2023 13:06:02 -0700
Message-Id: <20230915200602.never.582-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242; i=keescook@chromium.org;
 h=from:subject:message-id; bh=BlOg0b9ZP7IAoB9aNoGJyqHBOVbbSASk03slNCtWlu4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLkq4Ro4W904lHrxUL3/kwPhhkgKuLe2GbG7t
 DEv5Jwszm2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS5KgAKCRCJcvTf3G3A
 Ji1mEACadOX9sHVXOG4zLVbOByyO4CQvA/S6emh8SHQqv8P236h61PQpwNjAp+YCykCxo/oMWpQ
 wvFnDeoW5ZOd4fzlmTq1c2OKEEaVY4TAfe/Web/oGcd8qrqwDcRXDAEPjijHK29TxrdZ2OTHOW3
 WhRNpd39v3kEvO52sP+1xpoX2rEiAqwWVp+qKtCfHijSyArHeBX+RFE91rgzj5Vnz19kh3kuA9E
 uQ36jNbZRHOiQjUnKLFpQCGQdPrVJffRuiGFEu5NbpSbuKTE2iZ+y+p0OLuiacoAzFAlMFwdhBz
 7xSZUuL3CWj2F0geKj8pKBk9EGFcox+0o0gC8Us+eUuxmBgmeArutvx+vK8jCENgzoTYWo7KOyK
 /lUMR3ECzsCLBSIQRXhWD5VKElcSJT/SF+mx5RwvYPttp606ReOiXZCiwLOMX3UAhAVMmouDuJs
 0UXIM2r6mISWZJ3aROg4AT4wzX3ZataTiXEEeaQLIKuuPtXZYR7zIxHhPEeENoP8o2Mj4LgcRj8
 c0fVMadTmpfl7NXjHNz9gQyAfofRQLDlzykJ8NnonnulKgCgSpk9CHPCiIus1kkTeaiPLbWj6dT
 8RKftCdw5KgK1+J+k0FY9b+P/CMzimX/SBcBnoQYUCf2cbFI9KDwcJb6SuAmm913O/QqB3NJQrP
 jfKAnik fC112vtQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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

As found with Coccinelle[1], add __counted_by for struct libipw_txb.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Stanislav Yakovlev <stas.yakovlev@gmail.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/intel/ipw2x00/libipw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/libipw.h b/drivers/net/wireless/intel/ipw2x00/libipw.h
index bec7bc273748..9065ca5b0208 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw.h
+++ b/drivers/net/wireless/intel/ipw2x00/libipw.h
@@ -488,7 +488,7 @@ struct libipw_txb {
 	u8 reserved;
 	u16 frag_size;
 	u16 payload_size;
-	struct sk_buff *fragments[];
+	struct sk_buff *fragments[] __counted_by(nr_frags);
 };
 
 /* SWEEP TABLE ENTRIES NUMBER */
-- 
2.34.1

