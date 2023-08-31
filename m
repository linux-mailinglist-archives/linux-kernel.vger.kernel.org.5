Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D2478E726
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243753AbjHaHXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241978AbjHaHXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:23:07 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EAE1A3;
        Thu, 31 Aug 2023 00:23:04 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26f9521de4cso373531a91.0;
        Thu, 31 Aug 2023 00:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693466583; x=1694071383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7qrHrxv+tQmHkxgkfHoWgymD/z9+utSjFBhVwcl5B4=;
        b=c+DIluRMCGb53Ix1uJuPbzf6f+GKBuZpMDiSiTTj1QQOQC+fYRMmBrY0q6Q1Aap1cX
         JK9p25BJBuZYs5HUwb8b8R79VKzBpGB8o3+JZmHqSctwbkxr4rlanZSeEKUmjeSwWCGo
         A6Bn2yyiYTPRoQmT99NEfWUW2JbRsJBMdiZ4he+mrFV/J+4xoghGW2Oj0oEYvngYQ8Q9
         AYxzqcLg5grVCMMsJFBRljC9t2sxgpx+iBiR99JQa9adOsw5qffaJp3q0xwj53Z1vqyi
         CynR+e6qQpsJcnz3tkbE0n14MdERhs2W5afutYzlBxZL1tUFQMEH+M6Bd2JH4I+o4c4M
         JkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693466583; x=1694071383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7qrHrxv+tQmHkxgkfHoWgymD/z9+utSjFBhVwcl5B4=;
        b=Ou3I2f/e3DZoiQ2MKsEs6KwftQsuvQqdkeyAhxCTWzK+GndZ7rGJRgOYh7KDSxS8Vr
         ojQ9muUiNF/NFBQ4xufhl8HJv9FuQa86dxlTyi234SdL1bvS1RUCC3lD4wHXn9V734TK
         WcIAY1hzn4dVdziJugmfgQKTADXeBGdG9qrLhudkliHH6mj4EKP1BI6yTYo7imw8NjHP
         Kf3RvTc/TwBRE2yuXAfrXm+7t3CRykOhNP8TBKK3UvXwzDnrRoELhwtadwwb59ovYvOy
         0DUxUwpxEQb9eXaroO7LzDCdkhplOX05qODTv8qBPMw+ml+9si2v81YU6ApYn4um2/dG
         buuQ==
X-Gm-Message-State: AOJu0YwT3nMeMix55X1BFM2JO7oohoBxNbZ0dYOdimx6iRJT+yILMbJs
        HxKLyhrlpHARJP7oI6SCUXo=
X-Google-Smtp-Source: AGHT+IG8RaRmunMe/+M8syUr0us8nmdh+ZK2SxJG9HILQx5j1VfNjThFTYg9e6Gzivnci5tefbRqCg==
X-Received: by 2002:a17:90a:a897:b0:26d:43f9:11dd with SMTP id h23-20020a17090aa89700b0026d43f911ddmr4134463pjq.0.1693466583475;
        Thu, 31 Aug 2023 00:23:03 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id z11-20020a170903018b00b001bf8779e051sm628794plg.289.2023.08.31.00.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 00:23:03 -0700 (PDT)
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
Subject: [PATCH v6 2/2] dt-bindings: arm: aspeed: add Meta Minerva board
Date:   Thu, 31 Aug 2023 15:20:47 +0800
Message-Id: <20230831072048.3966398-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831072048.3966398-1-peteryin.openbmc@gmail.com>
References: <20230831072048.3966398-1-peteryin.openbmc@gmail.com>
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

