Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611457AB88A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbjIVRy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjIVRxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:53:53 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D208CCC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:52:32 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-690d8c05784so2024644b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405152; x=1696009952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pl35WLgGJCM37J4d+X10Oeina5d9DkaQtxX58zLwSlM=;
        b=EXY7HNbgd/I83aRTxiEzojpDZ8gH+L8V6h9re4yNRVcoWaS6p59GnOOXihNY3qS9+2
         wOPGPLHiwU1ncmrWiTA55WICiRmidITiZATzPV0JnjNOtSNrnU1kFCLTCgfW+H4VG9dW
         /0CA87Rc6pMnhxU83CtWwlQePrKVdqzu5oFbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405152; x=1696009952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pl35WLgGJCM37J4d+X10Oeina5d9DkaQtxX58zLwSlM=;
        b=kCRAKYpHvfb0PF5xPxGFIgatYWz9fZzbANOm1lVXTwNPnLhDYBd3rzL3VOqx0w2Vm/
         WFTisjwnQm1NZ74fUkC/OLPxQ0sz9iK1/Xj+9Gq+QPg6nb+29fg28+9cuhYD6nZNL0dx
         rgBdPTCAgj53pGIi477YIJ4gY+bbVxCxi1baW32HLObHH9XWv9PYMZXmO6j3oWI1x48G
         7wHufhJ4HlRojhPzW3AcqIKrJ+LvLJSVm2jJhFMOUJfNPvKKtHlQaakocpP4ql1fzeui
         TLREw73GFJ76hqnIoKcy/d6ABe0F62OUy54dru5r6IJ6KheT5azdUVG7g2BTAuvJw8r9
         7Hag==
X-Gm-Message-State: AOJu0YwlTp1okXO5c0EGXWSOPwpeVa7rPW/wupVZNcvWOP000YXJKqK2
        vM1NllmpgAnO/jwK2JRFgzH1pg==
X-Google-Smtp-Source: AGHT+IH/BDsjyOwNnnB/vf6GkI+p/S/HBCalaSB8F8C8ics2Sk/hCAm4LC82tljGOQEyC/JYDiPGYA==
X-Received: by 2002:a05:6a20:d41b:b0:14b:f9e2:e16c with SMTP id il27-20020a056a20d41b00b0014bf9e2e16cmr173591pzb.62.1695405152277;
        Fri, 22 Sep 2023 10:52:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e14-20020a62ee0e000000b00690d9901ce5sm3463268pfi.102.2023.09.22.10.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:52:31 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] reset: Annotate struct reset_control_array with __counted_by
Date:   Fri, 22 Sep 2023 10:52:29 -0700
Message-Id: <20230922175229.work.838-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1858; i=keescook@chromium.org;
 h=from:subject:message-id; bh=zVFGOtqG+KacYumKbB4wtYyfvREXmMdZtLrfDhG/4qk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdRdFctFcnxvk85JokSXmLjz7++yZhNkrwiyb
 dphp4EydX+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UXQAKCRCJcvTf3G3A
 JuJMEACXeQkr31kziRM725dFIKq9wmwrmq6V5N4omADvfekK5/8iU9lpaMiZf8iOy9qf/Bg7PK2
 mWIxyUbqQ/S9r5JGIeolWgqkORbkYkeSP9+HwFAEJLBYin7MutM591cCTTXPcOVEFg5hGbI2EbP
 fI/7TKde7BDVAT2cnicNgpiW56Qkh+8yj3i+5WKqiprSzM/Hp21l0VaufBiaZH9AEr3qIXBaMHN
 Md49gWgF1Ettd/WSDi0O17J2JAmIHJrw25BgVYqVlQn/VyT70U62+pnBy38cKmomHdESuaQlDXB
 4djLkKZ+6i4XbV5nFGFXkdfEYAQoRntXxhgUJh2fD6bLXE7wPMZnpeaYLS5BLZ+D/2qZDdv48MS
 Uevp63fIw8z2l+7rig5+LHK+LY2HOEjBC0VI/asXjuGTj9+Ilg+Gz63bW3UsoqLRSAL58LGohJZ
 aephoxoMcu2IEWKGggFxb+YL+64Fz4zRpIwLXplONOgxKxw+MnIFCEBslxDrTbhsCtvT4y/pu78
 oRHU2ogHvbU2khR/zEmsS4O0a65Tc7yXsccydS/J14CzdnebtFJY2ZpKjVY+dq/24V55R9BaNwU
 lkpWsIPIoWjyZnsjF7AQhdEMkmkZto+l4x3SxayKSRKFsg0VK3ZrMSUH0+Ag/jzss1hqhq4710o
 UDDEkJ7 4SwPXvhw==
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

As found with Coccinelle[1], add __counted_by for struct reset_control_array.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/reset/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index f0a076e94118..7ece6a8e9858 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -60,7 +60,7 @@ struct reset_control {
 struct reset_control_array {
 	struct reset_control base;
 	unsigned int num_rstcs;
-	struct reset_control *rstc[];
+	struct reset_control *rstc[] __counted_by(num_rstcs);
 };
 
 static const char *rcdev_name(struct reset_controller_dev *rcdev)
@@ -1185,6 +1185,7 @@ of_reset_control_array_get(struct device_node *np, bool shared, bool optional,
 	resets = kzalloc(struct_size(resets, rstc, num), GFP_KERNEL);
 	if (!resets)
 		return ERR_PTR(-ENOMEM);
+	resets->num_rstcs = num;
 
 	for (i = 0; i < num; i++) {
 		rstc = __of_reset_control_get(np, NULL, i, shared, optional,
@@ -1193,7 +1194,6 @@ of_reset_control_array_get(struct device_node *np, bool shared, bool optional,
 			goto err_rst;
 		resets->rstc[i] = rstc;
 	}
-	resets->num_rstcs = num;
 	resets->base.array = true;
 
 	return &resets->base;
-- 
2.34.1

