Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B043075376B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbjGNKEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbjGNKEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:04:33 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7082700;
        Fri, 14 Jul 2023 03:04:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9891c73e0fbso343694566b.1;
        Fri, 14 Jul 2023 03:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689329071; x=1691921071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ+dgEJhccslLRCe6E0bHpIqKrs+yHP/rIwnEJNcN7Q=;
        b=T9I9KnWi3qLdDOlHb7Jrn9WJ/cfF34/BvKrRNhOuYySN+NvoaQYaKNiNw15fxvMIKx
         4rkdXMIRlj0Snw8hFbPUz/dPiradwsYCkyD7m8ttPiRFaLDTCAO8gk52x8WqxVnB8d2b
         BCCvE0tbn1sY53i4VRNNfR8efDTmTIiSYwrO4N4jjpD8cgAkGZGVai5dQu3/WVspAMuu
         vrEMRv2JE3XhTT6RefdI9yi8sGjyDW1p9XI2SlwIUM6YUIh/1s5Q25wkFGViVKL2/CaG
         M0Vtdk9i5AwfBBTXXNH/myTYjspWBNifKomjHNt+OxZJtMQOYk0q7Qd0fH8LWJ+X8QV9
         pQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689329071; x=1691921071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQ+dgEJhccslLRCe6E0bHpIqKrs+yHP/rIwnEJNcN7Q=;
        b=aTld50N9X4dysfIz0ijmx+o2BimFDpqxSgkQUKa8zd+8pLe/p56sQmtaW5jZqlWKUw
         U1RAGvnvLiwKhM9XrUN4AvuVaiYQPbes/HqeWQOnfw+aTqkoABkRf/lv8E5m/C0dn3YY
         vfuvGlv25JXcGU5oseSMzwGTO7jWjO6YqZ9z5hucC3SaWCVugTq4Hhqf9W0m5ASYRsdO
         FActQBVpqlJfS8edohWpBoT9VYKQ49tI0VP8xDnq+N9n/Hl21Gqcx1WX67bOW0cWP9eT
         91q/9ca0BdXb1z5ETNT58fI4cyTNe7FgWw8ZwSgRtZsG+GTY8whMTkGXfOk+uTbyj0Dk
         E0qQ==
X-Gm-Message-State: ABy/qLYl+iw/rHXh3q4O/pn2vZn6RYvs9S2y+2Dt3lA/gezbsAcan51a
        i11BuEp5lN5YTf0i7kP7cek=
X-Google-Smtp-Source: APBJJlFHhrUe0pfc2JsSzCMECoxN/OjIsGUG7NqHCYGUtn0LATvLcQz4kukQHQkCfyJshVWK00jcWg==
X-Received: by 2002:a17:906:225c:b0:994:5407:9ac9 with SMTP id 28-20020a170906225c00b0099454079ac9mr649852ejr.5.1689329070634;
        Fri, 14 Jul 2023 03:04:30 -0700 (PDT)
Received: from tablet.my.domain (ip-37-248-157-105.multi.internet.cyfrowypolsat.pl. [37.248.157.105])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709063c0700b0098e42bef736sm5215415ejg.176.2023.07.14.03.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 03:04:30 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [RESEND PATCH 1/2] dt-bindings: mms114: Add linux,keycodes property for touch keys
Date:   Fri, 14 Jul 2023 12:04:23 +0200
Message-ID: <20230714100424.29798-2-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714100424.29798-1-aweber.kernel@gmail.com>
References: <20230714100424.29798-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MELFAS MMS114 and similar touchscreens have support for touch keys.
Add the linux,keycodes property which can be used to set up the
keycodes for the touch keys.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 .../devicetree/bindings/input/touchscreen/melfas,mms114.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/melfas,mms114.yaml b/Documentation/devicetree/bindings/input/touchscreen/melfas,mms114.yaml
index fdd02898e249..07f9dd6b1c9c 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/melfas,mms114.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/melfas,mms114.yaml
@@ -52,6 +52,11 @@ properties:
   touchscreen-swapped-x-y: true
   touchscreen-max-pressure: true
 
+  linux,keycodes:
+    description: Keycodes for the touch keys
+    minItems: 1
+    maxItems: 15
+
 additionalProperties: false
 
 required:
-- 
2.41.0

