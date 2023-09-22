Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9757AAD49
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjIVI5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjIVI53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:57:29 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF234BB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:57:22 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-274972a4cb6so1382119a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1695373042; x=1695977842; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RDJs3U1rqa7YI0/roeh/1SBiVi3tTUp7AZYFFQzYY+8=;
        b=A22TP6mBKkhBhsokDD0dytb++Qhl90MPUcW6CZ8LOan6CSc1di7aeIYmcQk8e5S3q4
         gYpZlV8ZmqbKYi5gXzQYvjbwguGdM7J7xz+3DXgxpy8WVelte2dNvBXM2eaBilpwrC+6
         t7Z4NLbRLpPLLNdo+piJlkO2Q3bOhSdJ6V7L3v1GRuAgUATMORceR4WX28dLkDoDzPUL
         Bs8LBD67D3VCyfkwUjqufH+837oy/alGIHqq7EN8u13UQQZVa7zRsoZ5TgwWOQnVZqjb
         O86rqbCPOfekzsQVrr3xfWI8dUxGTmpCOxSiOsLXhZ5CS0Wdwgf0C5zb9S5IvBaZtm2V
         UX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695373042; x=1695977842;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDJs3U1rqa7YI0/roeh/1SBiVi3tTUp7AZYFFQzYY+8=;
        b=YAkfuhw8YZTKcTOaMzZygqJ6mCUUiUwFE4Nfhaf2GijQEW0/74mqltmyVKx6W7lehO
         8h56FISfuxb2aoDzIsz2uEclFHbJR+9FV20EEGQsXEh6g7QiAh+987Q/4ND8zsPayVwQ
         rnhXto6TjlVaM9ppo4NmrbbBdb/mk9ikGHFhYcr+f4nzrSkC/AlmFDmOw60IE5J0Rkdo
         1gQJZ3aA6k22/ESUcvn+eqibBhvAsEWc0XgSzBfYwmX69YqcpYR7dfBoOBg26YECtgi7
         hu9BKM4MdrP2MoK8wru8kUb14ofaYNGH36VV1Rh63bh+R/Wwlj2m6rY8NFqmhrpoJTvS
         ViZg==
X-Gm-Message-State: AOJu0Yzs8A2HEm+HoLbGEJb4LvYz2VNXJ7mzYLNIfP2XP+ERAUWA/X2K
        wOQAJxy3ucQE47h+XnNGSsftEQ==
X-Google-Smtp-Source: AGHT+IF2S3T6M/QFYXn0AbVDOA44Le3cU3dN6opZxZukQlTXZ9dw1OqvhHYbfoOzCbab4UanG6N9Jg==
X-Received: by 2002:a17:90a:f687:b0:274:74ee:eda5 with SMTP id cl7-20020a17090af68700b0027474eeeda5mr7847201pjb.4.1695373042268;
        Fri, 22 Sep 2023 01:57:22 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090a024f00b00256b67208b1sm4815024pje.56.2023.09.22.01.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 01:57:21 -0700 (PDT)
From:   Yong-Xuan Wang <yongxuan.wang@sifive.com>
To:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
Cc:     greentime.hu@sifive.com, vincent.chen@sifive.com, tjytimi@163.com,
        alex@ghiti.fr, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: riscv: Add Svadu Entry
Date:   Fri, 22 Sep 2023 08:56:48 +0000
Message-Id: <20230922085701.3164-3-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230922085701.3164-1-yongxuan.wang@sifive.com>
References: <20230922085701.3164-1-yongxuan.wang@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for the Svadu extension to the riscv,isa-extensions property.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index cc1f546fdbdc..b5a0aed0165b 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -147,6 +147,12 @@ properties:
             ratified at commit 3f9ed34 ("Add ability to manually trigger
             workflow. (#2)") of riscv-time-compare.
 
+        - const: svadu
+          description: |
+            The standard Svadu supervisor-level extension for hardware updating
+            of PTE A/D bits as frozen at commit b65e07c ("move to Frozen
+            state") of riscv-svadu.
+
         - const: svinval
           description:
             The standard Svinval supervisor-level extension for fine-grained
-- 
2.17.1

