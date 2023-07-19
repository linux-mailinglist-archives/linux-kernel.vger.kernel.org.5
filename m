Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088197592FC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjGSK3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjGSK2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:28:38 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED1C2727;
        Wed, 19 Jul 2023 03:28:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so9521324a12.1;
        Wed, 19 Jul 2023 03:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689762475; x=1692354475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvwLnHrPPW9mN3eP3ToOVyAY+fURq9KMI1kYnyRrLew=;
        b=IXSAPoPfCUgRMcJhHe431METrVC72aVsO6ZCnjIjoJb9XJLLXsTyQolXnG3BjDBrOH
         jmxYDc2gv6Z/vdbpNnc8X8gD39giatbIcWHfY7q0CQ7EoV1rXdM31UWr4JSNcYwea0bz
         3wrNDsiUudtaGvjYkwNuxRBpFgYN4mHoFMXqB1wpbAmaQKasCNhyYkDdoWyz//4uzkGG
         wE3V1Uq1sP80rO8q42uZ2aQ3EDsPYQOjM8Qw0i1iqRB1QAMNv4s++nNd4kT8HOUbqwfE
         MCVUeV3e71HJ9pKcKznY43VIH3oiK2Mj2nhJZdqcd8hdIjWBJrARjYBVWjZz0i+G31pD
         Dx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689762475; x=1692354475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvwLnHrPPW9mN3eP3ToOVyAY+fURq9KMI1kYnyRrLew=;
        b=AvZuu74+eeCXWiypKFJjCDgKO8H02h8Ah8HlzgYcJBAwZokK4hR2GQiIl+hzZcmxXJ
         Yi8FnGM+w9+XvdnViYIkGnc6isdmrB3ldnZwhrNLu98rW87JuB7H+0Wi2Fr93ZCqc2un
         yissl23g63GjeSGaqVA8zkhcpnLmm6E6wkfbeZrfEcTcfzpHLDWLhx9mhy+tC6Wj35ZA
         y5IPWy6cj1kEdDL2KRz5CWlimxRvKUwz1XPBNpmlauN8uJS6Avdlj81U3VbJRu2ry+SF
         gsAPm71Kv0Ig55en17c6qc6lAsSZo/nOesXWJEcC3AwP1FvcrsyEm7+YgeGzEGO9NwlV
         fc/g==
X-Gm-Message-State: ABy/qLaX0/4KDc+H92Kelj2Zr08eCyVuHznpXA8mc9JKfiEgxTO8h0l2
        nZOaTcy/e/NFHvNz1JJJE4k=
X-Google-Smtp-Source: APBJJlG7YrCpa9YjoiINUKiLwzmGgNdxKjiO2arboOheCtcorFw/xx+U7Yt2QAJBzyd0jHvcU1jdhw==
X-Received: by 2002:aa7:cb57:0:b0:51e:2a56:91d6 with SMTP id w23-20020aa7cb57000000b0051e2a5691d6mr2434166edt.19.1689762474993;
        Wed, 19 Jul 2023 03:27:54 -0700 (PDT)
Received: from localhost.localdomain ([2a01:c844:242b:b300:215:5dff:fe9c:4c81])
        by smtp.gmail.com with ESMTPSA id b17-20020a05640202d100b005217412e18dsm2520457edx.48.2023.07.19.03.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 03:27:54 -0700 (PDT)
From:   Matus Gajdos <matuszpd@gmail.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Matus Gajdos <matuszpd@gmail.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: ili9881c: Add TDO TL050HDV35 LCD panel
Date:   Wed, 19 Jul 2023 12:26:14 +0200
Message-Id: <20230719102616.2259-2-matuszpd@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230719102616.2259-1-matuszpd@gmail.com>
References: <20230719102616.2259-1-matuszpd@gmail.com>
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

Add support for TDO TL050HDV35-H1311A LCD panel.

Signed-off-by: Matus Gajdos <matuszpd@gmail.com>
---
 .../devicetree/bindings/display/panel/ilitek,ili9881c.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
index c5d1df680858..e7ab6224b52e 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
@@ -18,6 +18,7 @@ properties:
       - enum:
           - bananapi,lhr050h41
           - feixin,k101-im2byl02
+          - tdo,tl050hdv35
           - wanchanglong,w552946aba
       - const: ilitek,ili9881c
 
-- 
2.25.1

