Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29BA7A27AA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237318AbjIOUHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237263AbjIOUHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:07:02 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B1E273D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:06:29 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c3f97f2239so22146965ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808389; x=1695413189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dB1pwLSw3TfsJDfFAPemy9b5TtNPX4UXkiSYwc3PxLw=;
        b=j6TqJJdlR2DW/SYrp7PPvx3W7j1C+SV0WzE/ji76VnUlPlwTCuzFeRDvtlzOB24Vgl
         XwdTT24f6aK2+sby0LpgXYyYVxWaXIH5o7gCqBgK4hKit/wKZtufvy9dI0SFdrEgX2pa
         kVIA00KXA9JvJnIbKd+bAlVGlzTI0E+UMpJEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808389; x=1695413189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dB1pwLSw3TfsJDfFAPemy9b5TtNPX4UXkiSYwc3PxLw=;
        b=pK/XBL6K7PDiXAJ1PQSba63YLWCaSI8jKjVQh3tam/ImTuB45tqnfSWoK9whwy88yb
         7rIYNVcmEDwi8tyuGaDHbDk4CAm/ha4Ou51kELUcdpjaH2rM7JL53MznrQi5jafuut/o
         WMcZumN/bGrarceuOLVGET51FTOhUqPQ4jjSqDfNcaZLJB4cmmMhsWPSSSHfQqzPF5ed
         +mxgMGKcDw9GxLOYfXx6jLHBcqPowM2GpFYGnL6vvUEJs46mINMZ9DKEHkWT730vAEkN
         8psrRvmz0UIbs41DKLqfTQwVcP2QkN7smSY593QeWhNXIGMI1jysjvlkcY+iNiWe/FMz
         6Q2w==
X-Gm-Message-State: AOJu0Yyg+26ajhuaHQSmhwNEQC17a1M8K4S4HH2448nwYXugPGt7q4Og
        vkoztnToIETJwMbtmXGrgZb9KA==
X-Google-Smtp-Source: AGHT+IFSEywbcZOC5XShL0oLvSifwuso6NQoEWHYLsrVN3EG8OWtaO4bmtwSMFub6Nj8jMAXdfGJXA==
X-Received: by 2002:a17:902:c94c:b0:1c3:cee1:cc8e with SMTP id i12-20020a170902c94c00b001c3cee1cc8emr2842576pla.68.1694808389168;
        Fri, 15 Sep 2023 13:06:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902d50700b001a80ad9c599sm3857764plg.294.2023.09.15.13.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:06:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>, Kalle Valo <kvalo@kernel.org>,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: wcn36xx: Annotate struct wcn36xx_hal_ind_msg with __counted_by
Date:   Fri, 15 Sep 2023 13:06:27 -0700
Message-Id: <20230915200622.never.820-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1231; i=keescook@chromium.org;
 h=from:subject:message-id; bh=Tx0rD4QGaivxM7sy4gGEy8kvfFVy4mGnM/BvvbkoZzI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLlD6p2BXFHtSwKtnpPyeTLWDyraFgZ0S036T
 HLIIfFDiyOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS5QwAKCRCJcvTf3G3A
 JjD6D/93UiQLOjttIT0EbU7ldsmyJjtmhfaLaIneAYcFlDcgnsftgejYn1pA9AYok+xUnAnpfkp
 9bViv791IaDIYWP4k7xICVG5IYyfS7++UJmcABftzpgHlbVMGImJjEYazHI67tLbGcbQBXYWc5e
 Ym8BsbfK9qPbjraHzs2LjoOO8CZdHH3Z7qhqffj8zZTZKVqCg8gM6YHRbOu6lgrYuhljGdvKfgC
 o4TcAE7B6pIhNsxLKFjTxXX/EtlJcjU1u3qaxXTsygt0vg5e75SLyTRlTJoAFpC3ZPoMMKV+QXd
 HwxRtLb42r+4RdH113rVtXOVQvJPUMZ/7bUzRZj1WmQpbBaFAvGX8jLI2bfRfOzlHu3oe9KTsNP
 3UJlPIOac29tVYOWVc3GyU7CbYrfzr7/FV9O2uK2yUJUvQVeEk6JdHh6yadyhRzeNTD1LySHwzo
 Y98YLn7hXO3WHcUw7IiF4gVyRuAHC8Zjb2a92QpqBQtCCnJ4s6aNi5wEnzycdmdpdi/epGSvsBS
 xj5tHVSwsuKT1ul56Q2o7/B/c9m+1DbhxZG7Wv9C+qJeHHb9ZHz6mWI55QkZMz/yPk1gIq27ZZ+
 HaaAk8OznFr0MKtZtid95deMwVBswNBl95zDNuIdr+z8YaicpZBr4ol4fxLSmGuiQZ+zIBRI3B7
 QNnIVu0 Rm0JoYKQ==
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

As found with Coccinelle[1], add __counted_by for struct wcn36xx_hal_ind_msg.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Loic Poulain <loic.poulain@linaro.org>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: wcn36xx@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
index cf15cde2a364..2c1ed9e570bf 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.h
+++ b/drivers/net/wireless/ath/wcn36xx/smd.h
@@ -47,7 +47,7 @@ struct wcn36xx_fw_msg_status_rsp {
 struct wcn36xx_hal_ind_msg {
 	struct list_head list;
 	size_t msg_len;
-	u8 msg[];
+	u8 msg[] __counted_by(msg_len);
 };
 
 struct wcn36xx;
-- 
2.34.1

