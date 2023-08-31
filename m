Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF1378E605
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 07:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243363AbjHaFyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 01:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242371AbjHaFyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 01:54:38 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D3E1B1;
        Wed, 30 Aug 2023 22:54:35 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68bec3a9bdbso282589b3a.3;
        Wed, 30 Aug 2023 22:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693461274; x=1694066074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7qrHrxv+tQmHkxgkfHoWgymD/z9+utSjFBhVwcl5B4=;
        b=hRdI8iffwiWQxfo4ctOllowSmRAFLYXsYUXkLQRGItr472fY1PVDbrzWS+joytxey+
         3zmx4uSf1NY7FN3bZAmDtMIzHYal4HPtbnowjTkq0y77EBHU8IekqXcbXC8QRa7BYxgq
         7ZMwmhIZhWdFPqEFlF1ydt1x89ZZWM7pWIYRcjMpJBNijTcEkB/86p4+44wWrZAoRlu2
         d0N8pU3yZAmhJ2shRrSSDEQVt4t0IlNfjDB+2BV3tdsKi0vPV+2fwP4xSGFEG2KSnPno
         4Z2HCqazF/M1Z718D38UciC8KPNzJ4MMun3CYDj721RPe8GDCUuKnh3ECRA5f/znV01G
         /i5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693461274; x=1694066074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7qrHrxv+tQmHkxgkfHoWgymD/z9+utSjFBhVwcl5B4=;
        b=TapG8pGiZXv9EldO+bJz5MFA6AuH65EEObMQlh07JIrBgU/0KjrmnpZ8/QLuW7M2O4
         rSxhIhj3swHRbWF1HgKiXnphXaKEBhnoZ1WzMU/onffXgA91Y/w96xqOPdJLxa9AEj3B
         ZqwfSGPt7OqIZQTO0xxcgZW5GKWcozJ0WB3mMobBoX8m35jdPdmvCsFZNBaHrqNpYa57
         YgmslNxnoGnXxhCzlfO+GoRrMfx4uia8cWGbGyHiPE6qKizG+WtlOVGn/rril4YNnmqG
         IYaQ+d66jtxLZp4mVtdA10wwoaRZae4mGGhjwNzV8ioB44C11muW+MCDPRV3PiIFtbLm
         3BdQ==
X-Gm-Message-State: AOJu0Yyj5jKWwhNLs6tJzZC00d2vhioJwv1UcF1OtGoWpK7ii3VEHRid
        pBoWfKB/WMkfoE19aomfsVA=
X-Google-Smtp-Source: AGHT+IFUGw1M1uBQkEgMOfIGdbWWIHSByC6slXUncszykg8B6jLlpF0bDlkZIpaxT4SYXakGVB8QaQ==
X-Received: by 2002:a05:6a00:218d:b0:68b:daa9:7bf2 with SMTP id h13-20020a056a00218d00b0068bdaa97bf2mr4727872pfi.7.1693461274468;
        Wed, 30 Aug 2023 22:54:34 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id e22-20020aa78256000000b0068c97a4eb0fsm506731pfn.210.2023.08.30.22.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 22:54:34 -0700 (PDT)
From:   Peter Yin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     cosmo.chou@quantatw.com, potin.lai@quantatw.com,
        daniel-hsu@quantatw.com, Peter Yin <peteryin.openbmc@gmail.com>
Subject: [PATCH v5 2/2] dt-bindings: arm: aspeed: add Meta Minerva board
Date:   Thu, 31 Aug 2023 13:50:29 +0800
Message-Id: <20230831055030.3958798-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831055030.3958798-1-peteryin.openbmc@gmail.com>
References: <20230831055030.3958798-1-peteryin.openbmc@gmail.com>
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

