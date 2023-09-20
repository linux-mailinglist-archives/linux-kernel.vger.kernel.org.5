Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC5D7A72EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjITGjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjITGjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:39:16 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6C0AD;
        Tue, 19 Sep 2023 23:39:10 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-573912a7b14so3846321eaf.1;
        Tue, 19 Sep 2023 23:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695191950; x=1695796750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KI/QX9GZKKfmFvg1oHlCB/TJtzRtp3iLf9zqKneYIf8=;
        b=YDbegpfMO9M/vzBG9ewnpIEdD1Z+VWAoflm29gxmVmB4c093sdor6Lj8+qStnz3/xp
         m47OZcPzzFmPJSoiOaa9xM57PBmhtUa9A2XPE9ok7nn+Dtbk5Cp1QTGUEplrW08Jz7RM
         DpI0glH3iy1pAyVkyWUhqXgakMfXiGHnLk0TXhJuHY2GUhxTn7G5HxzjjxgBpiDDN59k
         KRfdAfEFZVqtwff7oO0n4byDxECuoVkpJxMmfI/r/sgl/g70kZ9bYiVF/GBLHaYGsrIQ
         2WEu2Sbl5DdpiQ/b3wbLsgv1g2q5ckj7qIPvwzBrxxxZbAtQjfbMuyqWd2ndMRkoItEt
         LZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695191950; x=1695796750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KI/QX9GZKKfmFvg1oHlCB/TJtzRtp3iLf9zqKneYIf8=;
        b=BLjLcL0ORY0FFQKWm6zHGqCNeIDMC67t83pE/gWuHt4RqxWvCflsJOJTlazrbwtQdr
         gvwe+ddd+adgVoxUe2xFKtn1r/95sbGOZXvDrHoEVw+Fn4JCRAaZP5fPRRjIimuPDv2Z
         uv45jh8LVnxUEOPOP3soVSkupTC4JBFlMLU4Qr+k8OYJGcvMlXNbodVI3M8MzXq7QGFD
         I6qXgfduFWRjZ7Ov+WA3T/GYISYT4cdMxpb7hbAjO/yfbAR35bcJsYwukzEyxbUlL1j3
         pCavJELzF68xYX+V5h4XoqVPPUkB9kS07f03ndLXxGbLWWDYdmgM6hVrEzdfkEqoVzAp
         S5ew==
X-Gm-Message-State: AOJu0Yx8lHmHUj+iM1oL1i2iFFfXX4ysRWYEibezd+kHiKKzFZiy1qW6
        sTTJ9fCf63JihWWSCTnPN8A=
X-Google-Smtp-Source: AGHT+IHHcVB62V0O8O8EhZNxxnHZ/EOAMlu1mcrCjEcLLL1XAJibYFmuDfj3Hy9MMHpB7b/QOdNAdg==
X-Received: by 2002:a05:6870:5ba0:b0:1d5:91d6:65f3 with SMTP id em32-20020a0568705ba000b001d591d665f3mr1746274oab.7.1695191949915;
        Tue, 19 Sep 2023 23:39:09 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id ka5-20020a0568700ac500b001d65b641873sm5848095oab.32.2023.09.19.23.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 23:39:09 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
X-Google-Original-From: Chen Wang <wangchen20@iscas.ac.cn>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com
Cc:     Chen Wang <wangchen20@iscas.ac.cn>
Subject: [PATCH v2 05/11] dt-bindings: interrupt-controller: Add SOPHGO's SG2042 PLIC
Date:   Wed, 20 Sep 2023 14:39:03 +0800
Message-Id: <11eca9395bf730f41f142be2f8d26f527e36517b.1695189879.git.wangchen20@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695189879.git.wangchen20@iscas.ac.cn>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
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

Add compatible string for SOPHGO SG2042 plic.

Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index dc1f28e55266..16f9c4760c0f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -65,6 +65,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun20i-d1-plic
+              - sophgo,sg2042-plic
               - thead,th1520-plic
           - const: thead,c900-plic
       - items:
-- 
2.25.1

