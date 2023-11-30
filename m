Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353007FEAC3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344927AbjK3Idp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbjK3Idk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:33:40 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6908E10E4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:33:43 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6d81faeefc4so399242a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701333222; x=1701938022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EyouFVwGEYxssEwFR57NReaaTx4QlR2tWMXVmiHfDAk=;
        b=Kha8WSqGjKJU5KXb9t+F6TJf2pd/u3Bty0vSpBwtYQMjv+2A6JgmJId5XhTk3on/hw
         5Wy8d/UAWSYg+dx/qPcXCFxjWo27CLwaf1KE6FpOJ+N4gM/idXWV4yBlm/TpqYsshFau
         abKsIdQdRmnuvJ+DJyRgjtc5gaoAX1bencGCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701333222; x=1701938022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EyouFVwGEYxssEwFR57NReaaTx4QlR2tWMXVmiHfDAk=;
        b=JVAy3NC73b5iQPsfQIHTomqSJCzqi0xnENqMOt7Pkar9V1upV/LpS7GiUXPdAhP3ND
         qWgKlPWtpA1IsP7FLeYTb7RJjF8OxR+5gJ0VnJHd0oHSA6fXWF4O365IdCyCfzZlNt0H
         +/zr1NZdcl2RcR43emPx3VkGYYEXRWrtkLoOMbZhIZCMcNuZ/NriKrO41sPROVfqs3RJ
         vdx3Bd1ztr4KnlRCBMSbShn2JJz0GWYwX4SptD8bi0CqxJ3hbUSSfh634crq8Wcz4qIv
         oIH8s9mwf5tYaDOJrYGxV24XNF3k3pMiIJid6Py37hIIuW6gks62iIl5v5BWyXJ04uW7
         sRSw==
X-Gm-Message-State: AOJu0Yy5Fxe9lSUEV7QiM8iPIrmjWPGLbZN5cBXkSAxvzcso6dqq9TcU
        L43SkyoMv/D+79HpVSAuRsiBSQ==
X-Google-Smtp-Source: AGHT+IGWCAAHmgXLrSSPxognNtvv4rTt1aiPoIZHEqHwPAu/XCpwkjPbK21OntZ4MLW1NQrPkMEvbA==
X-Received: by 2002:a9d:7f0c:0:b0:6ce:37a2:a93e with SMTP id j12-20020a9d7f0c000000b006ce37a2a93emr25823140otq.3.1701333222791;
        Thu, 30 Nov 2023 00:33:42 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:7c8f:dafd:65c3:2bcf])
        by smtp.gmail.com with ESMTPSA id b8-20020a63cf48000000b005c2967852c5sm712015pgj.30.2023.11.30.00.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 00:33:42 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: cros-ec: Allow interrupts-extended property
Date:   Thu, 30 Nov 2023 16:33:31 +0800
Message-ID: <20231130083333.932862-1-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"interrupts-extended" provides a more concise way of describing external
GPIO interrupts.

Allow using this instead of "interrupts" plus "interrupt-parent" for
cros-ec.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../devicetree/bindings/mfd/google,cros-ec.yaml          | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index e1ca4f297c6d..e514eac9f4fc 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -75,6 +75,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  interrupts-extended:
+    maxItems: 1
+
   reset-gpios:
     maxItems: 1
 
@@ -199,9 +202,13 @@ allOf:
                 - google,cros-ec-rpmsg
                 - google,cros-ec-uart
     then:
+      oneOf:
+        - required:
+            - interrupts
+        - required:
+            - interrupts-extended
       required:
         - reg
-        - interrupts
 
   - if:
       properties:
-- 
2.43.0.rc2.451.g8631bc7472-goog

