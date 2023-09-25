Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077B77AD94F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjIYNjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjIYNjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:39:42 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A390E11D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:39:34 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c434c33ec0so46230345ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695649174; x=1696253974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0nR1d1X0MlBXUc/LZD12tdCUY8BFx747N+beNbmoR4=;
        b=gwT99oCScaQ6PLarPlk9fI/jgD2fLi+GlERhCoR+X5vmRTP7r0brzzZa57gjc7JLXJ
         hSbCFFrTYfSKL/GVM1MSf/wTbvQ2gd5x3VMTqbieOmysc099WVynZpe0jvinnFbZjSQi
         mZG3KR2FtDPTHewkBHER6RuIV+gnVArYP6OLghMLUZRaUqG3ir7p5e931EV2kNI2FF8j
         LWg6ijX3ftlo+rLIkqd9pjuc4n0OtA7OOmHKwJHPDUG3Wkcldy3C/5JzLRyBrBmUhkZ8
         9Z0D6APi5NZhdRfNeFI64821ymn8WkJ295p94rSGn6OmM++xr5Wdglw1Uc+4HVACe9kD
         t99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695649174; x=1696253974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0nR1d1X0MlBXUc/LZD12tdCUY8BFx747N+beNbmoR4=;
        b=Akf26wVnRM7MVowgKE7f76CdUfj8due525/C171cdjQ9R3UKXz6tvSsa/yqtHjUUd2
         8oRpQE1eWSLokumSKyul4q4Y0/9gdASmM6JBcmT7tS74+jGf5zB5zqYAZzM5pJ5mpzkS
         jXfFoR+oY8DF8WDUKCrSiOz133S1C0pJNd4lM5QBS9E6u+nAllUOaWJ3Snv6dvT0QQmn
         ovop8Q9FJqEFb6bgikfNMdT8MP66B8B+ZKI0vvWP2XY17j2203596wwD+1HPDzoWPq8u
         2VOIeZ3TnT5O4TQDR7KSVJo0TDrUW1JfZ2J6LkpTgbL7ctbAdEg43semR7AV7RpshFQh
         V+Ug==
X-Gm-Message-State: AOJu0YyPtX+Cp0LJ51wFMQqkdqDpKANo6CJhDlVt4v42H34Naoz3/Gt+
        9hnR8M9NuDKQRyX7ILDH9a2Y/g==
X-Google-Smtp-Source: AGHT+IGe2ltYHOKifgoZuKPVFkm63dkXjtN4qjeWkEpgdWPkv+o21XyWmATLP8vrvzDJy8UtUBfYhw==
X-Received: by 2002:a17:902:d4c4:b0:1c6:f56:9315 with SMTP id o4-20020a170902d4c400b001c60f569315mr2815286plg.68.1695649173981;
        Mon, 25 Sep 2023 06:39:33 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902eacb00b001c625d6ffccsm969433pld.129.2023.09.25.06.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:39:33 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 3/9] dt-bindings: riscv: Add Zicond extension entry
Date:   Mon, 25 Sep 2023 19:08:53 +0530
Message-Id: <20230925133859.1735879-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925133859.1735879-1-apatel@ventanamicro.com>
References: <20230925133859.1735879-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for the Zicond extension to the riscv,isa-extensions property.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index cad8ef68eca7..3f0b47686080 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -225,6 +225,12 @@ properties:
             ratified in the 20191213 version of the unprivileged ISA
             specification.
 
+        - const: zicond
+          description:
+            The standard Zicond extension for conditional arithmetic and
+            conditional-select/move operations as ratified in commit 95cf1f9
+            ("Add changes requested by Ved during signoff") of riscv-zicond.
+
         - const: zicsr
           description: |
             The standard Zicsr extension for control and status register
-- 
2.34.1

