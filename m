Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8AD7DF1F4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345996AbjKBMEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbjKBMEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:04:38 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9C4195
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:01:52 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6c3443083f2so148452b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 05:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698926512; x=1699531312; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jtFETPopYL9qQsqV12E64PSYpI6sEe2ykn1CxLszp0g=;
        b=DLXfjLgqWwQ8vYW7sWxECI1BRXzLe8nIJ0Y7zbwjiXysayV1Z7mfWI+QkHSH3Spwbg
         YCq92kvS7UQS8Vwue0Xp+Gl660UiyaOL6u2XrsZpIfNZHTGLpt0S33LSIa1+EjftN5fP
         /h3k2iDz6iJxv7MbQQ0r9k42+FXkpigoyDr8AWu7wRZMdPmWFP2dj5nIM5pC0f4cuZ0J
         O/J3s9dBVYr0m4uog+0wZw5VHB2Ap/j1b+QFh+IfLwZlFtND98iWq81wZ8hl3IQ3wXDb
         jOspcklFNGzLoqrZsS866eujfNBK94G1Um8SdBFSJyjulgDeQKYOCfw6mj0ytRLlJtN5
         mQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698926512; x=1699531312;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jtFETPopYL9qQsqV12E64PSYpI6sEe2ykn1CxLszp0g=;
        b=qAhgb4j+TeoTS+5L57lxci3tHWKu41bYp1WtVC9rtRvadd9sytymaFh0MyqMJyiX67
         rQIbhdnCdyFEaAna/Cp5/+2mAVvOYzS14CvX36lJm3ZAAEAJtocWSUiSIccSE9yggsag
         WRgps4JVCU8OuZGyHJLgTVdA21Htf64cZ4HKQUO9X/i07F1mZXYWrRqqhiQh6iq1agYe
         a9ITlxYBme/y24oV9NVd7JOe9cbv/cSM6NEQ0DbGjA1Syh2JpuadxgjF+LVQmyWloNG5
         sObXaEl0jfwOuBz7E6bNV3fmMGExe68n9cd/3ilhLU0JRla3Eq2iZFuB6wVtW12QYkzH
         30QA==
X-Gm-Message-State: AOJu0YzVTXiGC5iWfzXBapGk+/8Jsceot9pgvPUcz55M2f4DVe8p+nZ4
        dqhZKOQqbTegESK35O1K9gsV7w==
X-Google-Smtp-Source: AGHT+IGLAFMFBtszNocU+qASkTznimPTF67YR80XaS1rd2vj4mW97ZI7ftQbfZbaIOnyHp9z4hHfiQ==
X-Received: by 2002:a17:902:e5cf:b0:1cc:3c6c:ce23 with SMTP id u15-20020a170902e5cf00b001cc3c6cce23mr13093008plf.42.1698926512333;
        Thu, 02 Nov 2023 05:01:52 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902f68c00b001cc0f6028b8sm2969008plg.106.2023.11.02.05.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 05:01:51 -0700 (PDT)
From:   Yong-Xuan Wang <yongxuan.wang@sifive.com>
To:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
Cc:     greentime.hu@sifive.com, vincent.chen@sifive.com, tjytimi@163.com,
        alex@ghiti.fr, conor.dooley@microchip.com, ajones@ventanamicro.com,
        Yong-Xuan Wang <yongxuan.wang@sifive.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] dt-bindings: riscv: Add Svadu Entry
Date:   Thu,  2 Nov 2023 12:01:23 +0000
Message-Id: <20231102120129.11261-3-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231102120129.11261-1-yongxuan.wang@sifive.com>
References: <20231102120129.11261-1-yongxuan.wang@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for the Svadu extension to the riscv,isa-extensions property.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
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

