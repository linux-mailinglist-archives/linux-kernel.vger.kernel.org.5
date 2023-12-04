Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD1F802CCE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 09:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjLDIMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDIM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:12:29 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88983CB;
        Mon,  4 Dec 2023 00:12:36 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5c66418decaso221335a12.3;
        Mon, 04 Dec 2023 00:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701677556; x=1702282356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQ7Lr5hFVMmxrz8Ra1Xc41SVOA7nLYF8fZCEE+nN5AE=;
        b=Sz7Wh5a0lgkRtUJTjGV+8L0Y/vzRden/PLPKJ+CU/+v+sb74BtGpTT+S32CVnelMX2
         +lW1+Wnf1QG7LpUr3NliXuDeTJ5p0iuUIdvs4h4sRrrCeNDJSeTM3Se4B0hBBqp+Gum/
         +ig180mXncxXnKRMaebYs7/DIyOUEwY/pFEDZ19CvdI5gCANpudmK0jTEIGVhNDMtclr
         rLX6PK1XoZ/DpoYawPLFDjHGJXhvLYC8LgX5k+VT14gKWenl2/oKvyaFkS//3UkTpRLX
         6MhYAYv3+5EUIA2sNLc9rw6ZWfq4bhzzghoJK4RJwE9M57lLCoPCcdG5K9YKhs7g/9rm
         EdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701677556; x=1702282356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQ7Lr5hFVMmxrz8Ra1Xc41SVOA7nLYF8fZCEE+nN5AE=;
        b=p70OZhzZcS/uxwJehmGiF79e3fU36t0EiofLTrhDfiD0XJw+vRmpdJd9Jd6MdEh9Xb
         PCZICrrBlFyl/hXe0IDXKiPyqUgoOQSPFueRjwRPAH4FG6+Rg03SXXKBSnO/KUuS8IFf
         prz1S11jly84X476PdEkMRRTXgJPRmh/K8hRZHjHSMqbcvj6lF3/bxeq+kUX3hQc1eDz
         PDEh2m6B5V/5BpLVIjnOq1/yubLq3MdCfNos0j5rXiD1NwNpCo8vBv7prg96v6aSHWIb
         rjMqiutwLM3g8vNI1AmrfXxq2M9zXCRitRk4WS/tVfgmi75E4QuaulxiRdfgewj0Frun
         A+QA==
X-Gm-Message-State: AOJu0Yz1x0O/TFl3ZSftKpSAs4MNh7xO6pb1uRdl8ksoGwCye1B4P2DC
        xWCQdYOEVg/6iIZq8jJ6q6Y=
X-Google-Smtp-Source: AGHT+IFRUnSZwaxc53KnhmuBatNNSPyRv7A+yWcSJcX91roeL2WcbWsgLXxs/nA/Y/aspjNTCXxJEg==
X-Received: by 2002:a05:6a21:1a8:b0:18b:30d1:fcab with SMTP id le40-20020a056a2101a800b0018b30d1fcabmr1063266pzb.59.1701677555940;
        Mon, 04 Dec 2023 00:12:35 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id u30-20020a056a00099e00b006cba5c61a01sm7059864pfg.159.2023.12.04.00.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 00:12:35 -0800 (PST)
From:   Peter Yin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: arm: aspeed: add Meta Harma board
Date:   Mon,  4 Dec 2023 16:10:28 +0800
Message-Id: <20231204081029.2272626-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204081029.2272626-1-peteryin.openbmc@gmail.com>
References: <20231204081029.2272626-1-peteryin.openbmc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new compatibles used on Meta Harma.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index e17b3d66d6e55..fac3cda3f4870 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -79,6 +79,7 @@ properties:
               - facebook,elbert-bmc
               - facebook,fuji-bmc
               - facebook,greatlakes-bmc
+              - facebook,harma-bmc
               - facebook,yosemite4-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
-- 
2.25.1

