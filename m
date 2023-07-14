Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D9D753766
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbjGNKEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbjGNKEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:04:31 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B1126BC;
        Fri, 14 Jul 2023 03:04:30 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b7430a07b7so26757401fa.1;
        Fri, 14 Jul 2023 03:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689329068; x=1691921068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=an2k+eAcrKU11eva39vMNwnkzixwlsgN74pm/6rFidk=;
        b=Gglh3HT6qoHbAH9f/+ZPGePc8blbI+/PViC/c6F6GUQOM++ruDHAuhzr2Nb73aCgRl
         yesxRgEkj1Kmcug8XocCv//kGznIf4aNQTMTN0TQj5Vg9d1LSiFdfWSJ7aWTBMtshQZW
         OKla4D+7ACYbg8UJV2zUV3O2r0/P9xypKNkx6EKHlhVqCiwyStCjGAOlSQT0UCELQYYs
         klx1nWrChHKVKsbs5Bioj2UJkVheX4XPOlRAthSErrQuvWLUc7P5RzT5lP1IEQbqc/Lb
         FjtpzYfziqW9HF0QGoQt8ZhH/dNVgNYCqIVeGUdOag/Z+eC+tl+yvbPbSWsIBbXx524h
         iKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689329068; x=1691921068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=an2k+eAcrKU11eva39vMNwnkzixwlsgN74pm/6rFidk=;
        b=M+t2kCZlTOnkZBTV34O9YwbF7FNgBDqI88+AJNehj/kGDwWKuE3OakLW+xWk1ofO+y
         f+7fT8LpH+/LaBNXYG3ODN/v87qfpRLQhLkALVnYefU+PyUUfPAGm1gvsjXwMULBluxo
         yZnYvb625oNM1E7d133ejwetfmD08Oh9i3C/90u+vN+wWKsc11HXn6o4uyrHeoTvkEqW
         RNEQDwoJYaHWkYpIPGSwQLzDVz8WygJSZtUm6HyJJxuOMvs6T9FVFM+Z5Yct0BOqKA+U
         nzWda0BR4J0b0rTvCBtXvYoCA/xKLDsmIvcfpla4yoZtrPSsT4DuDmFQeuiEBKFSr7pU
         AsUg==
X-Gm-Message-State: ABy/qLYaqfnnp6DazBKQUkLiMQ+1+Gy89lIZTQPgyjgWVqoVaW1F0J4A
        o1fL2sluMAZ40+3bu+1UEbY=
X-Google-Smtp-Source: APBJJlG54Sg2G48n4QcLwkZNGq7Ib5MdVyjC8EqH0d56B6T/lRWcaMrnJGRMZuFTnx3N8WmpF3OGTw==
X-Received: by 2002:a2e:3509:0:b0:2b6:c818:a9bc with SMTP id z9-20020a2e3509000000b002b6c818a9bcmr3696089ljz.23.1689329068196;
        Fri, 14 Jul 2023 03:04:28 -0700 (PDT)
Received: from tablet.my.domain (ip-37-248-157-105.multi.internet.cyfrowypolsat.pl. [37.248.157.105])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709063c0700b0098e42bef736sm5215415ejg.176.2023.07.14.03.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 03:04:27 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [RESEND PATCH 0/2] mms114: add support for touch keys 
Date:   Fri, 14 Jul 2023 12:04:22 +0200
Message-ID: <20230714100424.29798-1-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.41.0
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
Enable support of them in the driver. The keycodes to emit can be
controlled by the linux,keycodes DT property.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

(Resend of https://lore.kernel.org/all/20230521145843.19489-1-aweber.kernel@gmail.com/)

Artur Weber (2):
  dt-bindings: mms114: Add linux,keycodes property for touch keys
  Input: mms114 - add support for touch keys

 .../input/touchscreen/melfas,mms114.yaml      |  5 ++
 drivers/input/touchscreen/mms114.c            | 88 +++++++++++++++++--
 2 files changed, 86 insertions(+), 7 deletions(-)


base-commit: 677232f879f2464007c511a73048ff5996b479fc
-- 
2.41.0

