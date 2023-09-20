Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC797A72E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjITGiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjITGiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:38:22 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD091C6;
        Tue, 19 Sep 2023 23:38:16 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3add255c88aso317146b6e.1;
        Tue, 19 Sep 2023 23:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695191895; x=1695796695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqOL131eM6+9EM2kWhV9SIhEDvrKv/6vCDQf5HCxj68=;
        b=erXMafqGbK0HdnktfuZgha6FPs5s7RFEeDdeqb2t0ZWFFLzAzE4Y9Sjs5ekgujKeTQ
         EqYvXc4mA0bEZz/psX6wzU3/t8+Rf1qaKHgT61saR2W4cNB0fwNNVZfp8u1RV3tiGeCD
         jUh39aKeJmTBWw8iF1S8JqZrAmM3gt6Fta6cUW8zBqdBPEdFpb2ZczHr8xMLYbVJfgVe
         BznQLCD4JptpHT2M1M5EnS9DGLylWzj93YMZY0HF6S5IPEOpKrM8UAeGdFbYWoWE1Wzc
         wlXTC38MSUd5GdDAmuQOZY3xcvMk8U+/b3kdy02Lw2I3gw1VS/OAJXDB3U38PYo2B2tK
         /maA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695191895; x=1695796695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqOL131eM6+9EM2kWhV9SIhEDvrKv/6vCDQf5HCxj68=;
        b=KUhkWwZY23YT+AYrX42YM+Dq7J5kRelmk3ukbHEUerM/azwpdgoe9KkW2ZiaQZl1Gk
         i1eDK1zJrHFP7eJKylo+ceIRapiM8ERlXJJVF6nwA/Nv2bdFphXZoLPe1yK6NL4hqWY0
         APliEud+4RbMkmxrU/9ehUa3H9pY95sDuOp6AWQr0ttIFprhYbxyZ5ILrUu7iDdB1lD1
         jlcOsODAld7b6T4PaQVrdoDQtwehH00RGOwyJMzbLjJxC4akyy0N+0m5yPsX9oMFmuPv
         L8sigkNloGCvtNUz8C1Vfo9q7wioWgIB99ciz29/kK8Qrozi//jFrpGrMRFWdPlvLdqH
         6KWA==
X-Gm-Message-State: AOJu0Yzggv2Dq4W8Yt+1kxrITb9YLCielWHYHjXM/FhSvEYKa5/cMabs
        3XJc08uo4VslTxnVmDmebAWs8pURJ8/9QWM9
X-Google-Smtp-Source: AGHT+IEcsKynrDvut/VM3OUOKYAEi4DE+22EYsG87JkRtkakAbHE0xLs89S1n6DB50p+QYwC2S5VLQ==
X-Received: by 2002:a05:6808:d47:b0:3a7:33bb:e5e2 with SMTP id w7-20020a0568080d4700b003a733bbe5e2mr1286693oik.16.1695191895536;
        Tue, 19 Sep 2023 23:38:15 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id a23-20020a05680802d700b003ab6461c8fbsm5604896oid.31.2023.09.19.23.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 23:38:15 -0700 (PDT)
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
Subject: [PATCH v2 04/11] dt-bindings: riscv: Add T-HEAD C920 compatibles
Date:   Wed, 20 Sep 2023 14:38:08 +0800
Message-Id: <c5061fbe8ef9c4971cd45de7b5d8408dc1b848b4.1695189879.git.wangchen20@iscas.ac.cn>
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

The C920 is RISC-V CPU cores from T-HEAD Semiconductor.
Notably, the C920 core is used in the SOPHGO SG2042 SoC.

Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 38c0b5213736..185a0191bad6 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -47,6 +47,7 @@ properties:
               - sifive,u74-mc
               - thead,c906
               - thead,c910
+              - thead,c920
           - const: riscv
       - items:
           - enum:
-- 
2.25.1

