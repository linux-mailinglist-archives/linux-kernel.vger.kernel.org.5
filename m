Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D26786FA1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240883AbjHXMvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241127AbjHXMvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:51:03 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789B6CD0;
        Thu, 24 Aug 2023 05:51:01 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bc83a96067so42213835ad.0;
        Thu, 24 Aug 2023 05:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692881460; x=1693486260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDfo1abF1Y082BBrZFHZQzYLHOisTvdpROer1sOJEwU=;
        b=jd0VZmQajINAqsLXp9n23+2+1KPtGpIthpO0CZAlRVylZIpMh4ujG6YwTiR3tZBuwk
         RLpZgr1je0bYfJGFMGeS3aUNK+A/+CjktG8ViaA/JEbd7xQDBlKJSbUbZ+ttsgBriprX
         nrHRe4lZdRnyJubEaCzDLsjxoDVNA+/gQobHjRYXZtdH+1YxRJTEm9m/jlrHruz0czn3
         RLF7YhqwVdTOoB9PnJdU8HA/YABsQgrxZH4z/wEil53cgrxD/DbNSRtQfgm0J0c3kLHf
         Ox4RfN2SmJNKgLNatsA1wL79fyyHLgZaVepVaVkbELcYg4CPfzp4xNAGoZ2Dx9qEk0MM
         GlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692881460; x=1693486260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDfo1abF1Y082BBrZFHZQzYLHOisTvdpROer1sOJEwU=;
        b=YoWHPFI6cvu9DXUr9SLhACJgxA7besC8W0KdGb7h4FgfR9xeDYighwzKsKfnR44jLE
         RzkFbzSmUJl0CUg6euqy8nnmoSUSRlefZU72/21pC6Vv3enAOFLqEWyy/rXBt6ZGjRGj
         IHslagduGF7MK1/c+o/T3KPOLq/QSRRM+7/2GHZWhK2uEPlAItheI7HRJT0om9W4T5ot
         beFA8DJZ/G9+YcYP1HoUIzMuxZMHdXA+9vSIYaHsfoi+VwE45t8Qil3r9+xp49aMcZWK
         JwjbvGUQ0zvYhYqC4u3VaV6yWN2oMKZQI/g7hQFYnEBC8eSm79SvOsqryNcyYuF8VMt2
         5ZfA==
X-Gm-Message-State: AOJu0YzgpfVcPXe28nanu7a0bbuJr4D/vZYHBwAupcB+shry9CyRyLkF
        VZu6wqeDXi9PLYu3BArL4rqEVGEGgsS9jRDl
X-Google-Smtp-Source: AGHT+IH1QQxInN2YyhJi1/gXe8Z0jHb1Wi+ficwRqovF5m3ZZocGRw+bUK+J91HtdzoFxOXNDj5+4g==
X-Received: by 2002:a17:902:8c85:b0:1bf:13a7:d3ef with SMTP id t5-20020a1709028c8500b001bf13a7d3efmr11086285plo.66.1692881460511;
        Thu, 24 Aug 2023 05:51:00 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c11300b001afd821c057sm12837295pli.58.2023.08.24.05.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 05:51:00 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v3 4/4] MAINTAINERS: Update MIPS/LOONGSON1 entry
Date:   Thu, 24 Aug 2023 20:50:12 +0800
Message-Id: <20230824125012.1040288-5-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824125012.1040288-1-keguang.zhang@gmail.com>
References: <20230824125012.1040288-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two new F: entries for Loongson1 Ethernet driver
and dt-binding document.
Add a new F: entry for the rest Loongson-1 dt-binding documents.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V2 -> V3: Update the entries and the commit message
V1 -> V2: Improve the commit message

 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 250c43c675cb..f462f3d19e4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14341,9 +14341,12 @@ MIPS/LOONGSON1 ARCHITECTURE
 M:	Keguang Zhang <keguang.zhang@gmail.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/*/loongson,ls1x-*.yaml
+F:	Documentation/devicetree/bindings/net/loongson,ls1[bc]-*.yaml
 F:	arch/mips/include/asm/mach-loongson32/
 F:	arch/mips/loongson32/
 F:	drivers/*/*loongson1*
+F:	drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
 
 MIPS/LOONGSON2EF ARCHITECTURE
 M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
-- 
2.39.2

