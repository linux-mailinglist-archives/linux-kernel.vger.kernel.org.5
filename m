Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF0B7A1736
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjIOHXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjIOHXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:23:49 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A1CA1;
        Fri, 15 Sep 2023 00:23:44 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68fe39555a0so1641225b3a.3;
        Fri, 15 Sep 2023 00:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694762624; x=1695367424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i5DdN2I9qJnXX8fUomCodux5qyyadXgZyIqOEcUZz9g=;
        b=AnGHV8XHKtQMwHNm5+nWFoWc488eEmN3iAvPh/uK6nerq9TjGTJ95MVr2MItXURO8v
         F/34S+HmfwrH2rtckV6Nrn5FvGLvqm1FEpY8b/fYNeMhSJCb9oYxVRqnlLzT5X8sLnJp
         JM+nMRSs76h7fOyhUKGH6N6WZcVuvQe/lfmX3RN4AzVZxSYo65Bp5FLu4VMUifn7+FFL
         03QOjz5vGodpkwwM20SAuZ4RF11GRlt+sPOgLSqWdQzPIMkb7ynsM9mO/jpImN5aoKYz
         Szf52Yui/S10LVTb1u5lL5O3AgFmLcS8C8LT46gl92k+GKw+OoBRSoYc9PBgbrHcMQks
         jdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694762624; x=1695367424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i5DdN2I9qJnXX8fUomCodux5qyyadXgZyIqOEcUZz9g=;
        b=CpK7Chr5WqVcJgVCTX+kOS0l7bzNiBYIm38AZtUYLpE6q9lW0sQEiTHKcwVKYdr0+L
         tehZ1aaKlSv6h7GxuBTV0MZNsFo1lBKl2TupGMriAn+YTptxuo/DJUJAx7/K9lCCKZ5A
         gymBLEEyOQpo7pBNQa7XA6MY0kYRCySWIzOt9YgM0eMnQs5Cy+lm2XVzC3nbykYiNANk
         HcCWCT+EZdsuLqt/iuSgqmCozPL1e3yl93jTnUax7Ez4wUrMxOgDSWhcAvRFdZkUS9aH
         28pAFYUalEF6o4E8lOmc//Zinu1dondpueuSe7IpCQTjHtN6z2P/qstEzcXWrYHDcSLV
         XwPQ==
X-Gm-Message-State: AOJu0Yw47ggqnSb27m8DuGQ+jgMgnC4EEAtpOolwRPpKa0zIzqjQ7Vnx
        +pCmSNxcJ1l2fbJV0GtWhi8=
X-Google-Smtp-Source: AGHT+IHU/Iq9TuJy2Xn7NgZhqVwjAOkxxb1R/8UU167fw9+wSqRSNrFOKa8keUomAiOjbu+XfSshGA==
X-Received: by 2002:a05:6a00:2d21:b0:68c:3f2:6000 with SMTP id fa33-20020a056a002d2100b0068c03f26000mr1149644pfb.6.1694762623573;
        Fri, 15 Sep 2023 00:23:43 -0700 (PDT)
Received: from localhost.localdomain ([222.95.63.58])
        by smtp.gmail.com with ESMTPSA id e23-20020a62ee17000000b006889081281bsm2338738pfi.138.2023.09.15.00.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 00:23:43 -0700 (PDT)
From:   Wang Chen <unicornxw@gmail.com>
X-Google-Original-From: Wang Chen <wangchen20@iscas.ac.cn>
To:     linux-riscv@lists.infradead.org, conor@kernel.org,
        aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com, Wang Chen <wangchen20@iscas.ac.cn>
Subject: [PATCH 04/12] dt-bindings: riscv: Add T-HEAD C920 compatibles
Date:   Fri, 15 Sep 2023 15:23:33 +0800
Message-Id: <20230915072333.117991-1-wangchen20@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
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

Signed-off-by: Wang Chen <wangchen20@iscas.ac.cn>
Signed-off-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
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

