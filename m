Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE52E78E821
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244205AbjHaIbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242308AbjHaIaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:30:52 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6F2E4C;
        Thu, 31 Aug 2023 01:30:38 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso461920a12.3;
        Thu, 31 Aug 2023 01:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693470638; x=1694075438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7qrHrxv+tQmHkxgkfHoWgymD/z9+utSjFBhVwcl5B4=;
        b=O516OsnrH5WeXCmDlWnIyZ3m2iyaHZVK0wqUMrC+0W83PQyp+jyZBWRdm6Ii0hySC5
         g341C+XIolwRkZz0Qd50S3h3gb3P3HogBgJpM/pG53oEQRMBBqxpMbDnmzi5z3rKoBEi
         lthDIJLYF35IanQ49bXz89zAmkNpHMfxCTG7JspaNhRJBPfQfwYdPbMpOtrqhYJUsZlJ
         Qx/aOGLhyPSJ+PZBQjkQBHuoo1dVLGohoVS6qwMcesfOa1OcOQC0s4sEPZtqLZeuzHqN
         BH8qWPwYXYTyyHn+swWEK0Xkoe5qugGzlWTr6CoxFJohZ2uHVGvswJHysNc61cA7cO29
         KGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693470638; x=1694075438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7qrHrxv+tQmHkxgkfHoWgymD/z9+utSjFBhVwcl5B4=;
        b=j8UfT0RjtomqMo6k3n72G/T5mydGmdu8I7XvqBv0JD7sKukX8qjiYsoucbHGcdNfUn
         lUR5HWjScYir0NIaUus6rCaOt1x+J8ShdvbH7Pb4M6tTHhSHLimDBdsTIJl9Fnl5RALt
         QWw8x4NPXWkoBJVtqkTN4KW6XWfikYTxMkMRVu5BxW7bMRJCr7CmAyZzMx99d3qMZEdN
         ZnHU5OJvAQbiDtUAjsaBQmWJgrjx8wEcSmrPQFxNzaYIfho6KIDfpswCEG4JG+svxlt9
         4iwhuSvj2JYoYsJLpbyxrE4kHN/OO2KG+GUu9iemZaJgb9yB5m+UAP1bDR/F57au8624
         3cog==
X-Gm-Message-State: AOJu0Yw2JugcESX90TOpK7tvtNUdkFGdDdgniRx1PR6zzOaHChPxeqFj
        cT+c7hG3ec6h+rBpR1GwW/M=
X-Google-Smtp-Source: AGHT+IGJ0sJH/K/tzzupjuyRlTkxXV5KC1GX2bDuoSlnYE5+YMUZE9wWtazb3sOipXp4chWI3AmNYA==
X-Received: by 2002:a05:6a21:3d83:b0:14c:d5e9:211e with SMTP id bj3-20020a056a213d8300b0014cd5e9211emr4640510pzc.35.1693470637972;
        Thu, 31 Aug 2023 01:30:37 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id a17-20020a62e211000000b0068a46cd4120sm812253pfi.199.2023.08.31.01.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 01:30:37 -0700 (PDT)
From:   Peter Yin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Peter Yin <peteryin.openbmc@gmail.com>
Subject: [PATCH v7 2/2] dt-bindings: arm: aspeed: add Meta Minerva board
Date:   Thu, 31 Aug 2023 16:28:18 +0800
Message-Id: <20230831082819.4000425-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831082819.4000425-1-peteryin.openbmc@gmail.com>
References: <20230831082819.4000425-1-peteryin.openbmc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new compatibles used on Meta Minerva.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 6b0a6683ccae..3b93bae4f43a 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -79,6 +79,7 @@ properties:
               - facebook,elbert-bmc
               - facebook,fuji-bmc
               - facebook,greatlakes-bmc
+              - facebook,minerva-bmc
               - facebook,yosemite4-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
-- 
2.25.1

